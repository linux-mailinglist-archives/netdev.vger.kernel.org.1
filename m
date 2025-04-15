Return-Path: <netdev+bounces-182662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5387A898F0
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9907D189F1C5
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8D728DF17;
	Tue, 15 Apr 2025 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmhtAbm0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D655289353;
	Tue, 15 Apr 2025 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744710928; cv=none; b=M7AY643wG1ziO0Hi18hRo4pjLCD+hepIN5M2lUKl4/tgdKEEPQEDIQHAy4IgZugDH4Uxgxffil67+bhtuIXDa56MzOvhtUGjlfIb+EvslmkbkcFVOBN6c14uR6Kk9Hr4Q33fvApFf3eZ+XtfsZqnlzJF0EggDrYEBqX06gEO2MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744710928; c=relaxed/simple;
	bh=ZnF3b2liXOIjwbQ2uq2Ja54W0JiZUa4Fk4ppFleWBL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0UWdQyqnpG+rR9YvEJ2bqH5EXZmOX1aQPVicB6LEELWuqxX4BJwu7dQaR2bJaknOCQDEbJ6EPmSqGXCFEczXWGAGsH2ONhFumLRVlxpzkFtwpCgQnDPow314QbBvF4+90ZP570D2ik2h2AF16BRQ1/V/ioiP8xWGSEhXHUac94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QmhtAbm0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744710927; x=1776246927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZnF3b2liXOIjwbQ2uq2Ja54W0JiZUa4Fk4ppFleWBL8=;
  b=QmhtAbm0ktG4ZoxwxCE4pObE625khkBLeM/YNFzYVgesMgyQodaW7XaC
   ULg8pCHE9CVJMvz5t3oi1RjxxrxwkCq1IuiAyClwv04Sw4CDHBhLadzgq
   DK2h8ALnXADMGN2JhAe2GBpx4ufCpGYQC6Ja6XXK0DK0z4nE8fBR9XzmG
   XF1WLt4zqeHNOQ4dPnwt5rrtfezbTVwNADPWmCy2OPu/Nsd7BoxWfwrTN
   VMOh9Ctj4qXCMc72jpB8pEdXdSSmiekuw6c/q1sG3lxZZFPPp+dtBxEQf
   ZDtQTxxJIA2RPavqUfokw40+KVXT10AqcRaFQ2pXRSXW3bR6T7jhQaF6O
   w==;
X-CSE-ConnectionGUID: TE8cwfB2Sh2vxYXioa5MtA==
X-CSE-MsgGUID: 48qIGxheS/G89zI4RWPlFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46093697"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46093697"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 02:54:18 -0700
X-CSE-ConnectionGUID: jR62VZZXS/60WKSyHWz82g==
X-CSE-MsgGUID: 25cUjWMuTIGR1UAtBNOBCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="161054267"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 02:54:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u4czc-0000000CVd3-3Lhs;
	Tue, 15 Apr 2025 12:54:12 +0300
Date: Tue, 15 Apr 2025 12:54:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>, Russell King <linux@armlinux.org.uk>,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/33] Implement kernel-doc in Python
Message-ID: <Z_4sxCFvpqs7qmcN@smile.fi.intel.com>
References: <871pu1193r.fsf@trenco.lwn.net>
 <Z_zYXAJcTD-c3xTe@black.fi.intel.com>
 <87mscibwm8.fsf@trenco.lwn.net>
 <Z_4EL2bLm5Jva8Mq@smile.fi.intel.com>
 <Z_4E0y07kUdgrGQZ@smile.fi.intel.com>
 <87v7r5sw3a.fsf@intel.com>
 <Z_4WCDkAhfwF6WND@smile.fi.intel.com>
 <Z_4Wjv0hmORIwC_Z@smile.fi.intel.com>
 <20250415164014.575c0892@sal.lan>
 <Z_4sKaag1wZhME7B@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_4sKaag1wZhME7B@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 15, 2025 at 12:51:38PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 15, 2025 at 04:40:34PM +0800, Mauro Carvalho Chehab wrote:
> > Em Tue, 15 Apr 2025 11:19:26 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> escreveu:
> > > On Tue, Apr 15, 2025 at 11:17:12AM +0300, Andy Shevchenko wrote:
> > > > On Tue, Apr 15, 2025 at 10:49:29AM +0300, Jani Nikula wrote:  
> > > > > On Tue, 15 Apr 2025, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > > > > On Tue, Apr 15, 2025 at 10:01:04AM +0300, Andy Shevchenko wrote:  
> > > > > >> On Mon, Apr 14, 2025 at 09:17:51AM -0600, Jonathan Corbet wrote:  
> > > > > >> > Andy Shevchenko <andriy.shevchenko@intel.com> writes:  
> > > > > >> > > On Wed, Apr 09, 2025 at 12:30:00PM -0600, Jonathan Corbet wrote:  
> > > > > >> > >> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> > > > > >> > >>   
> > > > > >> > >> > This changeset contains the kernel-doc.py script to replace the verable
> > > > > >> > >> > kernel-doc originally written in Perl. It replaces the first version and the
> > > > > >> > >> > second series I sent on the top of it.  
> > > > > >> > >> 
> > > > > >> > >> OK, I've applied it, looked at the (minimal) changes in output, and
> > > > > >> > >> concluded that it's good - all this stuff is now in docs-next.  Many
> > > > > >> > >> thanks for doing this!
> > > > > >> > >> 
> > > > > >> > >> I'm going to hold off on other documentation patches for a day or two
> > > > > >> > >> just in case anything turns up.  But it looks awfully good.  
> > > > > >> > >
> > > > > >> > > This started well, until it becomes a scripts/lib/kdoc.
> > > > > >> > > So, it makes the `make O=...` builds dirty *). Please make sure this doesn't leave
> > > > > >> > > "disgusting turd" )as said by Linus) in the clean tree.
> > > > > >> > >
> > > > > >> > > *) it creates that __pycache__ disaster. And no, .gitignore IS NOT a solution.  
> > > > > >> > 
> > > > > >> > If nothing else, "make cleandocs" should clean it up, certainly.
> > > > > >> > 
> > > > > >> > We can also tell CPython to not create that directory at all.  I'll run
> > > > > >> > some tests to see what the effect is on the documentation build times;
> > > > > >> > I'm guessing it will not be huge...  
> > > > > >> 
> > > > > >> I do not build documentation at all, it's just a regular code build that leaves
> > > > > >> tree dirty.
> > > > > >> 
> > > > > >> $ python3 --version
> > > > > >> Python 3.13.2
> > > > > >> 
> > > > > >> It's standard Debian testing distribution, no customisation in the code.
> > > > > >> 
> > > > > >> To reproduce.
> > > > > >> 1) I have just done a new build to reduce the churn, so, running make again does nothing;
> > > > > >> 2) The following snippet in shell shows the issue
> > > > > >> 
> > > > > >> $ git clean -xdf
> > > > > >> $ git status --ignored
> > > > > >> On branch ...
> > > > > >> nothing to commit, working tree clean
> > > > > >> 
> > > > > >> $ make LLVM=-19 O=.../out W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64
> > > > > >> make[1]: Entering directory '...'
> > > > > >>   GEN     Makefile
> > > > > >>   DESCEND objtool
> > > > > >>   CALL    .../scripts/checksyscalls.sh
> > > > > >>   INSTALL libsubcmd_headers
> > > > > >> .pylintrc: warning: ignored by one of the .gitignore files
> > > > > >> Kernel: arch/x86/boot/bzImage is ready  (#23)
> > > > > >> make[1]: Leaving directory '...'
> > > > > >> 
> > > > > >> $ touch drivers/gpio/gpiolib-acpi.c
> > > > > >> 
> > > > > >> $ make LLVM=-19 O=.../out W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64
> > > > > >> make[1]: Entering directory '...'
> > > > > >>   GEN     Makefile
> > > > > >>   DESCEND objtool
> > > > > >>   CALL    .../scripts/checksyscalls.sh
> > > > > >>   INSTALL libsubcmd_headers
> > > > > >> ...
> > > > > >>   OBJCOPY arch/x86/boot/setup.bin
> > > > > >>   BUILD   arch/x86/boot/bzImage
> > > > > >> Kernel: arch/x86/boot/bzImage is ready  (#24)
> > > > > >> make[1]: Leaving directory '...'
> > > > > >> 
> > > > > >> $ git status --ignored
> > > > > >> On branch ...
> > > > > >> Untracked files:
> > > > > >>   (use "git add <file>..." to include in what will be committed)
> > > > > >> 	scripts/lib/kdoc/__pycache__/
> > > > > >> 
> > > > > >> nothing added to commit but untracked files present (use "git add" to track)  
> > > > > >
> > > > > > FWIW, I repeated this with removing the O=.../out folder completely, so it's
> > > > > > fully clean build. Still the same issue.
> > > > > >
> > > > > > And it appears at the very beginning of the build. You don't need to wait to
> > > > > > have the kernel to be built actually.  
> > > > > 
> > > > > kernel-doc gets run on source files for W=1 builds. See Makefile.build.  
> > > > 
> > > > Thanks for the clarification, so we know that it runs and we know that it has
> > > > an issue.  
> > > 
> > > Ideal solution what would I expect is that the cache folder should respect
> > > the given O=... argument, or disabled at all (but I don't think the latter
> > > is what we want as it may slow down the build).
> > 
> > From:
> > 	https://github.com/python/cpython/commit/b193fa996a746111252156f11fb14c12fd6267e6
> > and:
> > 	https://peps.python.org/pep-3147/
> > 
> > It sounds that Python 3.8 and above have a way to specify the cache
> > location, via PYTHONPYCACHEPREFIX env var, and via "-X pycache_prefix=path".
> > 
> > As the current minimal Python version is 3.9, we can safely use it.
> > 
> > So, maybe this would work:
> > 
> > 	make O="../out" PYTHONPYCACHEPREFIX="../out"
> > 
> > or a variant of it:
> > 
> > 	PYTHONPYCACHEPREFIX="../out" make O="../out" 
> > 
> > If this works, we can adjust the building system to fill PYTHONPYCACHEPREFIX
> > env var when O= is used.
> 
> It works, the problem is that it should be automatically assigned to the
> respective folder, so when compiling kdoc, it should be actually
> 
> $O/scripts/lib/kdoc/__pycache__
> 
> and so on for _each_ of the python code.

So, the bottom line, can we just disable it for a quick fix and when a proper
solution comes, it will redo that?

-- 
With Best Regards,
Andy Shevchenko



