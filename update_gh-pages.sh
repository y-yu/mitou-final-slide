#!/usr/bin/env bash

set -eo pipefail

TARGET="mitou-final"

make

if [ $? != 0 ]; then
  make clean
  make
fi
  
if [ $? = 0 ] && [ -f "${TARGET}.pdf" ] && \
   [ -f "${TARGET}_without_animation.pdf" ]; then
  git stash -a
  git checkout gh-pages
  rm "${TARGET}.pdf" "${TARGET}_without_animation.pdf"
  git stash pop
  git add "${TARGET}.pdf" "${TARGET}_without_animation.pdf"
  git commit -m 'Update PDFs'
  git push origin gh-pages
  git checkout master
fi
