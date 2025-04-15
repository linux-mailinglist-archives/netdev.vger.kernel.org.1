Return-Path: <netdev+bounces-182660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4744DA898D2
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C10440B3D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1040F28E614;
	Tue, 15 Apr 2025 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XcwIkZAM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0140A1DF994;
	Tue, 15 Apr 2025 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744710874; cv=none; b=EnmKdTH2cNctl9FSt16ZYnP+c8md/SvcwY/LIBnCDFH6Y4VljbXvco8nVvl0WDoE18X3DrwsviGes/OGy59+tJMMJDlI3erRIeWPbvNGoAKKmAegHj2fSa++RyHpWrqwmEp8WPV40LQaYhYV3cfFCQNW/b2xVxlcUgtnAbwRkuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744710874; c=relaxed/simple;
	bh=L6ZBp9B5ub+vR6BAf7feLXCkVJt33r176fqAi+yE76o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5VAYa+TgbwGBqHjjT8mEuzff2dfSQFkSDcrtMuWOma28QQ/z18Eob+G8xX8o0vY1/LVEXuRn7NRLJ1i+UAtOzornhCdOu6H/csEs9Zd0nTfl7Ivi0luS6Z0vM4uZ4oS6+0IzgKOoUtHRwhY02Jr6jNfRseuYjOQeJ+7nqfVJnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XcwIkZAM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744710873; x=1776246873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L6ZBp9B5ub+vR6BAf7feLXCkVJt33r176fqAi+yE76o=;
  b=XcwIkZAMkiI603RHjAyxII9TBV15NQeM7uTJYnfScAPeIZnbhWgb9zI8
   2kC7pFspRgUMw+xaAKFyTpqRpHTXfM8NHuK829W/0eD3meG9Vzs8tYe08
   2PktSr2xp+Ot8N8tGODfU3h30xxhn0txukkSmoePdmRoGkgiTvztQ//77
   CO19bG7FFW9lWhUsJAlix+lq14Cv9vFEF19OYI5bUIyILmszR4WbRk1J9
   5KiWvx9wIn0Rt8JGHY86W3yvzF/Wj/2Jh17TmcjEneAnN2fgm+CEpGo1n
   WoC/qpn0xZOiFl5et/LkhiHXpdb/oPYggGzzOFglhIogDTQsWS40n1pd/
   w==;
X-CSE-ConnectionGUID: m0gbZTTUR1O6c6/5sXKJcQ==
X-CSE-MsgGUID: E8f1mHLdQV+uum7k6eRfQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="63613698"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="63613698"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 02:53:26 -0700
X-CSE-ConnectionGUID: t9YJsE8KQGCAlc11/WLcEQ==
X-CSE-MsgGUID: aSNYI1kSTlSjvvGelplNCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="131053763"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 02:53:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u4cym-0000000CVcP-2KCZ;
	Tue, 15 Apr 2025 12:53:20 +0300
Date: Tue, 15 Apr 2025 12:53:20 +0300
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
Message-ID: <Z_4skKaqR6NuwOx-@smile.fi.intel.com>
References: <871pu1193r.fsf@trenco.lwn.net>
 <Z_zYXAJcTD-c3xTe@black.fi.intel.com>
 <87mscibwm8.fsf@trenco.lwn.net>
 <Z_4EL2bLm5Jva8Mq@smile.fi.intel.com>
 <Z_4E0y07kUdgrGQZ@smile.fi.intel.com>
 <87v7r5sw3a.fsf@intel.com>
 <Z_4WCDkAhfwF6WND@smile.fi.intel.com>
 <Z_4Wjv0hmORIwC_Z@smile.fi.intel.com>
 <20250415164014.575c0892@sal.lan>
 <20250415165102.44551ada@sal.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415165102.44551ada@sal.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 15, 2025 at 04:51:02PM +0800, Mauro Carvalho Chehab wrote:
> Em Tue, 15 Apr 2025 16:40:34 +0800
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
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
> That's interesting... Sphinx is already called with PYTHONDONTWRITEBYTECODE.
> From Documentation/Makefile:
> 
> 	quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
> 	      cmd_sphinx = $(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/userspace-api/media $2 && \
> 	        PYTHONDONTWRITEBYTECODE=1 \
> 	...
> 
> It seems that the issue happens only when W=1 is used and kernel-doc
> is called outside Sphinx.
> 
> Anyway, IMHO, the best would be to change the above to:
> 
> 	PYTHONPYCACHEPREFIX=$(abspath $(BUILDDIR))
> 
> And do the same for the other places where kernel-doc is called:
> 
> 	include/drm/Makefile:           $(srctree)/scripts/kernel-doc -none $(if $(CONFIG_WERROR)$(CONFIG_DRM_WERROR),-Werror) $<; \
> 	scripts/Makefile.build:  cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $(KDOCFLAGS) \
> 	scripts/find-unused-docs.sh:    str=$(scripts/kernel-doc -export "$file" 2>/dev/null)
> 
> Comments?

I would like that, but it should be properly formed, because somewhere we drop
the path in the source tree and if $O is used as is, it becomes _the_ pycache
folder!

-- 
With Best Regards,
Andy Shevchenko



