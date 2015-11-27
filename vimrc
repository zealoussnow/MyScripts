" Vim File
"  Filename: vimrc
"   Created: 2015-09-17 17:30:02
"      Desc:
"          _
"   __   _(_)_ __ ___  _ __ ___
"   \ \ / / | '_ ` _ \| '__/ __|
"    \ V /| | | | | | | | | (__
"     \_/ |_|_| |_| |_|_|  \___|
"
"    Author: LeoZhang(zealoussnow), zealoussnow@qq.com
"   Company: FreeDom

""" Bundle {
set nocompatible

syntax enable

filetype on
filetype off "required!!!

runtime macros/matchit.vim

set rtp+=~/.vim/bundle/vundle
set rtp+=/usr/lib/python2.6/site-packages/powerline_status-2.2.dev9999-py2.6.egg/powerline/bindings/vim
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'tczengming/headerGatesAdd.vim'

" Molokai color scheme
Bundle 'tomasr/molokai'

" Scala语法高亮支持
Bundle 'derekwyatt/vim-scala'

" Golang支持
Bundle 'fatih/vim-go'
Bundle 'dgryski/vim-godef'
Bundle 'Blackrush/vim-gocode'

Bundle 'nvie/vim-flake8'

" Markdown语法支持
Bundle 'tpope/vim-markdown'

" C++ STL语法高亮
Bundle 'STL-improved'

Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'

" 头文件和源文件切换
Bundle 'a.vim'
Bundle 'todo-txt.vim'
Bundle 'vim-json-line-format'

Bundle 'CmdlineComplete'
Bundle 'OmniCppComplete'
Bundle 'AutoComplPop'
Bundle 'DoxygenToolkit.vim'

Bundle 'msanders/snipmate.vim'

Bundle 'tpope/vim-fugitive'
"Bundle 'bling/vim-airline'
Bundle 'powerline/powerline'

Bundle 'majutsushi/tagbar'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'

Bundle 'jiangmiao/auto-pairs'

filetype plugin indent on " required!!!
" }

" General {
set history=1000
set showmode
set showcmd
set number
set cmdheight=1
set ruler
set vb t_vb=
set novb
set noeb
syntax on
set magic
set ignorecase
set gdefault			" Use global replace defult
set incsearch			" Realtime search
set showmatch
set hlsearch
set wrapscan			" Re-search while reach the end of file
set backspace=indent,eol,start
"set listchars=tab:\│\ ,nbsp:%,trail:█  "把多余的tab用>-显示，多余的空格用-显示
"set list
set cc=79

" Tabs width and indent width
set shiftwidth=8
set tabstop=8
set softtabstop=8

set autoindent			" Inhert the indent style
set smartindent			" Auto indent for C/C++
set cindent			" C/C++ indent style

set cinoptions=:0,l1,t0,g0	" Linux kernel style

set cpoptions+=$		" cw displayed as $
set wrap 			" Auto wrap while a long line
set textwidth=99
set formatoptions+=mM

set modeline			" Mode line support
set autoread			" Auto loading newer
set hidden			" Switch buffers when has unsaved
set ttyfast

set path+=../include    " Search path of 'gf'
set completeopt=menu,menuone,longest
set cursorline
" }

" Backups {
set backup
se bdir=~/.file_backup
" }

" Auto group coding style {
autocmd Filetype css,html,xml,ruby,php,javascript setlocal ts=2 sts=2 sw=2
autocmd FileType python,markdown setlocal et sta sw=4 sts=4				" Tab expand 4 spaces for python
autocmd Filetype java,make setlocal ts=4 sts=4 sw=4
autocmd BufWritePre *.go :Fmt

"autocmd BufWritePost *.{py,h,hpp,c,pc,sqc,cpp,cc} call AutoUpdateTheLastUpdateInfo()
autocmd BufNewFile *.{h,hpp,c,pc,sqc,cpp,cc} exec 'call append(0, "\/\/ Last Update:" . strftime("%Y-%m-%d %H:%M:%S", localtime()))'
autocmd BufNewFile *.{sh,py} exec 'call append(0, "\# Last Update:" . strftime("%Y-%m-%d %H:%M:%S", localtime()))'
" }

" Encoding {
set encoding=utf-8 " Necessary to show Unicode glyphs
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set termencoding=utf-8
" }

" Record the exit position {
au BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\ execute 'normal! g`"zvzz' |
	\ endif
" }

" UI {
if has('statusline')
    set laststatus=2
    " Broken down into easily includeable segments
    set statusline=\ %f\                        	" Filename
    set statusline+=%(%{&fenc}\[%{&ff}]%)       	" Fencoding
    set statusline+=%y                          	" Filetype
    set statusline+=%#errormsg#
    set statusline+=%r 					" Read only flag
    set statusline+=%*
    set statusline+=%m 					" Modified flag

    set statusline+=%{fugitive#statusline()}		" Git Hotness
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    set statusline+=%=%-10.(%l,%c%V\ \:\ %p%%%)\ " Right aligned file nav info
endif

if has("gui_running")
    "解决菜单栏乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    " 解决consle输出乱码
    language messages zh_CN.utf-8

    set guioptions-=m   " 隐藏菜单栏
    set guioptions-=T   " 隐藏工具栏
    set guioptions-=L   " 隐藏左侧滚动条
    set guioptions-=r   " 隐藏右侧滚动条

    set background=light
    colorscheme solarized

    set linespace=0     " 行与行之间没有多余的空格

    " au WinLeave * set nocursorline nocursorcolumn
    " au WinEnter * set cursorline cursorcolumn
    set cursorline cursorcolumn
    hi cursorline guibg=#333333
    hi cursorcolumn guibg=#333333

    if(has("win32") || has("win64"))
        " 激活菜单栏
        noremap <M-Space> :simalt ~<CR>
        inoremap <M-Space> <C-O>:simalt ~<CR>
        cnoremap <M-Space> <C-C>:simalt ~<CR>
        set guifont=Microsoft\ YaHei,Courier\ New:h12
        au GuiEnter * set t_vb=
        " au GUIEnter * simalt ~x   " 窗口启动时自动最大化
    else
        set guifont=Microsoft\ YaHei
    endif
else
    if &term == 'xterm' || &term == 'screen'
        set t_Co=256    " 颜色数目为256
    endif
    set background=dark
    colorscheme molokai
endif
" }

" Doxygen {
let g:DoxygenToolkit_authorName="zealoussnow@163.com"
" }

" Key bindings {
cmap w!! %!sudo tee > /dev/null %

nmap <silent><Tab>	:bn<CR>
nmap <silent><S-Tab>	:bp<CR>

set pastetoggle=<Leader>pp
nmap <Leader>rb 	:%!xxd<CR>
nmap <Leader>nrb 	:%!xxd -r<CR>

" 末行模式仿emacs的快捷键输入命令
cnoremap <C-A>		<Home>
cnoremap <C-E>      	<End>

nnoremap <silent><F5> :NERDTreeToggle<CR>
nnoremap <silent><F6> :TagbarToggle<CR>
" }

" Folding {
set foldlevelstart=0
nnoremap ,z zMzvzz
nnoremap zO zCzO
" }

" Wildmenu completion {
set wildmenu
set wildmode=longest:list:full                  " 命令模式tab补全顺序

set wildignore+=*.luac                          " Lua byte code
set wildignore+=*.pyc                           " Python byte code
set wildignore+=*.spl                           " compiled spelling word lists
set wildignore+=*.sw?                           " Vim swap files
set wildignore+=*.aux,*.out,*.toc               " LaTeX intermediate files
set wildignore+=*.mp3,*.mp4,*.avi,*.mkv         " media format
set wildignore+=*.png,*.jpg,*.jpeg,*.bmp,*.gif  " binary images
set wildignore+=*.zip,*.tar,*.gz,*.7z           " Zip file
set wildignore+=*.o,*.obj,*.exe,*.dll,*.so,*.a  " compiled object files
set wildignore+=*.git*,*.hg*,*.svn*             " version control system
" }

" Vim-airline {
"if has('statusline')
"    let g:airline_theme='badwolf'
"    "let g:airline_theme='dark'
"    "let g:airline_theme='powerlineish'
"    let g:airline#extensions#ctrlp#color_template = 'insert'
"    if !exists('g:airline_symbols')
"        let g:airline_symbols = {}
"    endif
"    let g:airline_left_sep = '▶'
"    let g:airline_left_alt_sep = '❯'
"    let g:airline_right_sep = '◀'
"    let g:airline_right_alt_sep = '❮'
"    let g:airline_symbols.linenr = '¶'
"    let g:airline_symbols.branch = '⎇'
"
"     " 是否打开顶部标签页
"     let g:airline#extensions#tabline#enabled = 1
"endif
" }

" Vim-powerline {
let g:solarized_termcolors=256
let g:Powerline_theme = 'default'
let g:Powerline_colorscheme = 'solarized256'
let g:Powerline_mode_n = 'Normal'
" }

" ack.vim {
if executable('ack')
    let g:ackarg="ack -H --nogroup --column"
endif
" }

" syntastic {
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0 " 保存java源码时特别慢
let g:syntastic_error_symbol = "E"
let g:syntastic_warning_symbol = "W"
" }

" ctrlp {
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
" }

" Color Setting {
highlight PmenuSel term=bold ctermfg=160 ctermbg=148
highlight Pmenu ctermbg=5 ctermfg=7
highlight MatchParen term=bold ctermbg=7 ctermfg=1
highlight Comment ctermfg=4
highlight Folded cterm=reverse ctermbg=0 ctermfg=4
highlight LineNr ctermfg=8
highlight Search ctermfg=0 ctermbg=3
"highlight Normal ctermfg=248 ctermbg=232
highlight Todo ctermfg=3 ctermbg=9
highlight String ctermfg=99
hi SpecialKey ctermfg=77  guifg=#696969
" }

" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:
