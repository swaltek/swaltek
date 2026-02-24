(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(with-eval-after-load 'ox-latex
   (add-to-list 'org-latex-classes
                '("apa7"
                  "\\documentclass{apa7}"
                  ("\\section{%s}" . "\\section*{%s}")
                  ("\\subsection{%s}" . "\\subsection*{%s}")
                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))
(with-eval-after-load 'ox-latex
   (add-to-list 'org-latex-classes
                '("apa7stu"
                  "\\documentclass[stu, 12pt]{apa7}"
                  ("\\section{%s}" . "\\section*{%s}")
                  ("\\subsection{%s}" . "\\subsection*{%s}")
                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(corfu flycheck flycheck-eglot lsp-mode lsp-ui modus-themes pdf-tools)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq org-html-head-include-default-style nil
      org-html-preamble nil
      org-html-postamble nil
      org-html-use-infojs nil)

(require 'org)
(require 'ox-html)
(org-export-define-derived-backend 'school-html 'html
			   :translate-alist '((src-block . za/org-school-html-src-block))
			   :menu-entry
			   '(?S "Export to HTML for school discussion"
				((?S "As HTML Buffer" za/org-html-export-as-school-html))))
(defun za/org-html-export-as-school-html
    (&optional async subtreep visible-only body-only ext-plist)
  (interactive)
  (org-export-to-buffer 'school-html "*org School HTML Export*"
    async subtreep visible-only body-only ext-plist (lambda () (text-mode))))
(defun za/org-school-html-src-block (src-block _contents info)
  (let* ((lang (org-element-property :language src-block))
	 (code (org-html-format-code src-block info)))
    (format "<div class=\"org-src-container\"><pre class=\"line-numbers d2l-code\"><code class=\"language-%s\">%s</code></pre></div>" lang code)))
