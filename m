Return-Path: <netdev+bounces-180687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF02A821DD
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576B31B870F6
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F12254AFD;
	Wed,  9 Apr 2025 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHe/jY0V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFA533EA;
	Wed,  9 Apr 2025 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744193775; cv=none; b=PfPBMjLK67CFbL3Tv+joWWIrLTmefl6kDSPhv1XI9c6UciSleIeb+TA2HflOwmpnc7LIwsAOotyOdp9lWcrsTtch8jmGMyS0vuvlfxvaEnyot2dtf6sn2H5dSXTxzIDm6ZUx8LKWWOjW0X/97xMHu4UVZJ5hwPaTUJmdu6Wr7bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744193775; c=relaxed/simple;
	bh=s9rylRVqZUHe66iRjdlxTUlwHoKlAY6moqZHmMo9LGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iva57CGW4Eh0jkNqwPdQ1Ypezo/evkqHtAjjh69ZCI/tEjqE71MK8lT387JVxLt7LrQxBYL2vwCEhrvxZg4x7mgoAzvi04v81hUNAk2UJSrznKi5xHi3OxYwMD97+FEfnC/lyvk98qK0v15afGlGw8nqoi1VaoRuP/Acm3KChNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHe/jY0V; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744193773; x=1775729773;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=s9rylRVqZUHe66iRjdlxTUlwHoKlAY6moqZHmMo9LGI=;
  b=LHe/jY0VsGj/fNqTcTCUyllFPkZBm1A2pzsWdXYyfzJ+q5oGaTb6VR2X
   Nnq1mb+zHGfPb4/BD7/OPsNS30TpufLLM8Xnyt0dmJqcDSUt/Z9SFHXxI
   2IrmVPnqek+oKIu1uyV7FRgT7o4OvdbIII4VqJHc5vG407MtkAdIcNa9G
   +kce59zpQMNvDj+JoWPg6+kBofCTLLG9hjsRBZTY3CrHYn0hbb/+fCOi7
   CsrUmGjL7xV3G3xxfuSuZCagIjZorPCFso2fV9TFvB2uX+ZXb7NIqvrHs
   vuqrRZF+C3Vra/S9mVmC1yvAqrTrQdpuxngXG/i2zK0Cz5ivCffuPwUmx
   g==;
X-CSE-ConnectionGUID: 9dyZgYclQi+2//2fDW+tyQ==
X-CSE-MsgGUID: m3tKoWfUS7uZKgN3Es2YqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44905862"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="44905862"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 03:16:12 -0700
X-CSE-ConnectionGUID: sYMYYL7ASHW9N0CDTaRE8w==
X-CSE-MsgGUID: o0i/4KmbTJSZiuaDYpMjWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="133406942"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.201])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 03:16:10 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, Russell King
 <linux@armlinux.org.uk>, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/33] Implement kernel-doc in Python
In-Reply-To: <cover.1744106241.git.mchehab+huawei@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1744106241.git.mchehab+huawei@kernel.org>
Date: Wed, 09 Apr 2025 13:16:06 +0300
Message-ID: <87r021wsgp.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 08 Apr 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> Hi Jon,
>
> This changeset contains the kernel-doc.py script to replace the verable
> kernel-doc originally written in Perl. It replaces the first version and the
> second series I sent on the top of it.

Yay! Thanks for doing this. I believe this will make contributing to
kernel-doc more accessible in the long run.

> I tried to stay as close as possible of the original Perl implementation
> on the first patch introducing kernel-doc.py, as it helps to double check
> if each function was  properly translated to Python.  This have been 
> helpful debugging troubles that happened during the conversion.
>
> I worked hard to make it bug-compatible with the original one. Still, its
> output has a couple of differences from the original one:
>
> - The tab expansion works better with the Python script. With that, some
>   outputs that contain tabs at kernel-doc markups are now different;
>
> - The new script  works better stripping blank lines. So, there are a couple
>   of empty new lines that are now stripped with this version;
>
> - There is a buggy logic at kernel-doc to strip empty description and
>   return sections. I was not able to replicate the exact behavior. So, I ended
>   adding an extra logic to strip empty sections with a different algorithm.
>
> Yet, on my tests, the results are compatible with the venerable script
> output for all .. kernel-doc tags found in Documentation/. I double-checked
> this by adding support to output the kernel-doc commands when V=1, and
> then I ran a diff between kernel-doc.pl and kernel-doc.py for the same
> command lines.
>
> The only patch that doesn't belong to this series is a patch dropping
> kernel-doc.pl. I opted to keep it for now, as it can help to better
> test the new tools.
>
> With such changes, if one wants to build docs with the old script,
> all it is needed is to use KERNELDOC parameter, e.g.:
>
> 	$ make KERNELDOC=scripts/kernel-doc.pl htmldocs

I guess that's good for double checking that the python version
reproduces the output of the old version, warts and all. And it could be
used standalone for comparing the output for .[ch] files directly
instead of going through Sphinx.

But once we're reasonably sure the new one works fine, I think the
natural follow-up will be to import the kernel-doc python module from
the kernel-doc Sphinx extension instead of running it with
subprocess.Popen(). It'll bypass an absolutely insane amount of forks,
python interpreter launches and module imports.

It'll also open the door for passing the results in python native
structures instead of text, also making it possible to cache parse
results instead of parsing the source files for every kernel-doc
directive in rst.

Another idea regarding code organization, again for future. Maybe we
should have a scripts/python/ directory structure, so we can point
python path there, and be able to import stuff from there? And
reasonably share code between modules. And have linters handle it
recursively, etc, etc.

Anyway, I applaud the work, and I regret that I don't have time to
review it in detail. Regardless, I think the matching output is the most
important part.


BR,
Jani.

> ---
>
> v3:
> - rebased on the top of v6.15-rc1;
> - Removed patches that weren't touching kernel-doc and its Sphinx extension;
> - The "Re" class was renamed to "KernRe"
> - It contains one patch from Sean with an additional hunk for the
>   python version.
>
> Mauro Carvalho Chehab (32):
>   scripts/kernel-doc: rename it to scripts/kernel-doc.pl
>   scripts/kernel-doc: add a symlink to the Perl version of kernel-doc
>   scripts/kernel-doc.py: add a Python parser
>   scripts/kernel-doc.py: output warnings the same way as kerneldoc
>   scripts/kernel-doc.py: better handle empty sections
>   scripts/kernel-doc.py: properly handle struct_group macros
>   scripts/kernel-doc.py: move regex methods to a separate file
>   scripts/kernel-doc.py: move KernelDoc class to a separate file
>   scripts/kernel-doc.py: move KernelFiles class to a separate file
>   scripts/kernel-doc.py: move output classes to a separate file
>   scripts/kernel-doc.py: convert message output to an interactor
>   scripts/kernel-doc.py: move file lists to the parser function
>   scripts/kernel-doc.py: implement support for -no-doc-sections
>   scripts/kernel-doc.py: fix line number output
>   scripts/kernel-doc.py: fix handling of doc output check
>   scripts/kernel-doc.py: properly handle out_section for ReST
>   scripts/kernel-doc.py: postpone warnings to the output plugin
>   docs: add a .pylintrc file with sys path for docs scripts
>   docs: sphinx: kerneldoc: verbose kernel-doc command if V=1
>   docs: sphinx: kerneldoc: ignore "\" characters from options
>   docs: sphinx: kerneldoc: use kernel-doc.py script
>   scripts/kernel-doc.py: Set an output format for --none
>   scripts/kernel-doc.py: adjust some coding style issues
>   scripts/lib/kdoc/kdoc_parser.py: fix Python compat with < v3.13
>   scripts/kernel-doc.py: move modulename to man class
>   scripts/kernel-doc.py: properly handle KBUILD_BUILD_TIMESTAMP
>   scripts/lib/kdoc/kdoc_parser.py: remove a python 3.9 dependency
>   scripts/kernel-doc.py: Properly handle Werror and exit codes
>   scripts/kernel-doc: switch to use kernel-doc.py
>   scripts/lib/kdoc/kdoc_files.py: allow filtering output per fname
>   scripts/kernel_doc.py: better handle exported symbols
>   scripts/kernel-doc.py: Rename the kernel doc Re class to KernRe
>
> Sean Anderson (1):
>   scripts: kernel-doc: fix parsing function-like typedefs (again)
>
>  .pylintrc                         |    2 +
>  Documentation/Makefile            |    2 +-
>  Documentation/conf.py             |    2 +-
>  Documentation/sphinx/kerneldoc.py |   46 +
>  scripts/kernel-doc                | 2440 +----------------------------
>  scripts/kernel-doc.pl             | 2439 ++++++++++++++++++++++++++++
>  scripts/kernel-doc.py             |  315 ++++
>  scripts/lib/kdoc/kdoc_files.py    |  282 ++++
>  scripts/lib/kdoc/kdoc_output.py   |  793 ++++++++++
>  scripts/lib/kdoc/kdoc_parser.py   | 1715 ++++++++++++++++++++
>  scripts/lib/kdoc/kdoc_re.py       |  273 ++++
>  11 files changed, 5868 insertions(+), 2441 deletions(-)
>  create mode 100644 .pylintrc
>  mode change 100755 => 120000 scripts/kernel-doc
>  create mode 100755 scripts/kernel-doc.pl
>  create mode 100755 scripts/kernel-doc.py
>  create mode 100644 scripts/lib/kdoc/kdoc_files.py
>  create mode 100755 scripts/lib/kdoc/kdoc_output.py
>  create mode 100755 scripts/lib/kdoc/kdoc_parser.py
>  create mode 100755 scripts/lib/kdoc/kdoc_re.py

-- 
Jani Nikula, Intel

