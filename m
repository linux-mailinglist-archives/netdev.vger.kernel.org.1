Return-Path: <netdev+bounces-182627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E29EA89659
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAC23AE530
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 08:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4056127A135;
	Tue, 15 Apr 2025 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T9bqMamA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3656F2798FA;
	Tue, 15 Apr 2025 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705179; cv=none; b=NFPnQSu5u67Nrco2hhjNC8wmkMEppwbw+tLQFItsxpGC3EiOuJvnHaRfnkXPMUu5eW7evUMrVEtBPnuEtn32U6iGE6fb21T3R0VSN6bdVS4tKydiDKh+WFWDZr4I0xcpihsaxwK+b/cwBXDvV9KGzsAggqF+dRNeR2AdrA2Y8xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705179; c=relaxed/simple;
	bh=SFyxnbEum3KNdMhZz50Ktv5YNZLdU4f0MgLrK/uWyBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkbzNyLVYPfWrAAuM48x1F9V0e/Bq6JrJhXX3XNZTjxuF61lkZRIrMryfXEymJLjwXzKSvM0vUGCIDyBW2si+hou7sT8AZCh0b1tm/CPoZ0oX/bzI/PlCGK0SYOjjL+DwFeze1y1Gd4Jiq3hU7LctRhyFAj1xrf8ukS4G/YAvkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T9bqMamA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705177; x=1776241177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SFyxnbEum3KNdMhZz50Ktv5YNZLdU4f0MgLrK/uWyBw=;
  b=T9bqMamAqHhBfUntkfdG+rj58Jo8ViTGlBnOi385LAAdYCnKZflAdwVO
   v7CxtKxgHTUhath+glA/nZogw5BXyoyZnPlontcly1XFwYzd+nrAh6TKc
   ViU9m504EGgVAQI4RGjXal0af0+KhSkXfXgupO0FuNO/ALw0Ert827Xl/
   VHGfRogi8trMNeIwDf8diWrH7sqcX18lRYG5v/T5XjOtapQunCtou/bcg
   Gv42mixuKBO+KyP2UOEhf/aqew3ENRcOaMxO/1CuKMS4fa3tgmeropM6Y
   u7zfWTrVO45ZcfEa1/agEzQ5IBS5CZ+E1T9qphGo69bC8bRbp3ey1kvRN
   w==;
X-CSE-ConnectionGUID: Tsc26RdqSD6jOv2dp7IKzQ==
X-CSE-MsgGUID: 3u6iCh0cSXCojTXmKQT0gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="50003363"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="50003363"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:19:36 -0700
X-CSE-ConnectionGUID: SJYYEgwSTnqx6OsbFXsQZQ==
X-CSE-MsgGUID: 0QBjkgWKT8uw5gkhbeZ7rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="134152716"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:19:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u4bVu-0000000CUCg-3v7o;
	Tue, 15 Apr 2025 11:19:26 +0300
Date: Tue, 15 Apr 2025 11:19:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>, Russell King <linux@armlinux.org.uk>,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/33] Implement kernel-doc in Python
Message-ID: <Z_4Wjv0hmORIwC_Z@smile.fi.intel.com>
References: <cover.1744106241.git.mchehab+huawei@kernel.org>
 <871pu1193r.fsf@trenco.lwn.net>
 <Z_zYXAJcTD-c3xTe@black.fi.intel.com>
 <87mscibwm8.fsf@trenco.lwn.net>
 <Z_4EL2bLm5Jva8Mq@smile.fi.intel.com>
 <Z_4E0y07kUdgrGQZ@smile.fi.intel.com>
 <87v7r5sw3a.fsf@intel.com>
 <Z_4WCDkAhfwF6WND@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_4WCDkAhfwF6WND@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 15, 2025 at 11:17:12AM +0300, Andy Shevchenko wrote:
> On Tue, Apr 15, 2025 at 10:49:29AM +0300, Jani Nikula wrote:
> > On Tue, 15 Apr 2025, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > On Tue, Apr 15, 2025 at 10:01:04AM +0300, Andy Shevchenko wrote:
> > >> On Mon, Apr 14, 2025 at 09:17:51AM -0600, Jonathan Corbet wrote:
> > >> > Andy Shevchenko <andriy.shevchenko@intel.com> writes:
> > >> > > On Wed, Apr 09, 2025 at 12:30:00PM -0600, Jonathan Corbet wrote:
> > >> > >> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> > >> > >> 
> > >> > >> > This changeset contains the kernel-doc.py script to replace the verable
> > >> > >> > kernel-doc originally written in Perl. It replaces the first version and the
> > >> > >> > second series I sent on the top of it.
> > >> > >> 
> > >> > >> OK, I've applied it, looked at the (minimal) changes in output, and
> > >> > >> concluded that it's good - all this stuff is now in docs-next.  Many
> > >> > >> thanks for doing this!
> > >> > >> 
> > >> > >> I'm going to hold off on other documentation patches for a day or two
> > >> > >> just in case anything turns up.  But it looks awfully good.
> > >> > >
> > >> > > This started well, until it becomes a scripts/lib/kdoc.
> > >> > > So, it makes the `make O=...` builds dirty *). Please make sure this doesn't leave
> > >> > > "disgusting turd" )as said by Linus) in the clean tree.
> > >> > >
> > >> > > *) it creates that __pycache__ disaster. And no, .gitignore IS NOT a solution.
> > >> > 
> > >> > If nothing else, "make cleandocs" should clean it up, certainly.
> > >> > 
> > >> > We can also tell CPython to not create that directory at all.  I'll run
> > >> > some tests to see what the effect is on the documentation build times;
> > >> > I'm guessing it will not be huge...
> > >> 
> > >> I do not build documentation at all, it's just a regular code build that leaves
> > >> tree dirty.
> > >> 
> > >> $ python3 --version
> > >> Python 3.13.2
> > >> 
> > >> It's standard Debian testing distribution, no customisation in the code.
> > >> 
> > >> To reproduce.
> > >> 1) I have just done a new build to reduce the churn, so, running make again does nothing;
> > >> 2) The following snippet in shell shows the issue
> > >> 
> > >> $ git clean -xdf
> > >> $ git status --ignored
> > >> On branch ...
> > >> nothing to commit, working tree clean
> > >> 
> > >> $ make LLVM=-19 O=.../out W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64
> > >> make[1]: Entering directory '...'
> > >>   GEN     Makefile
> > >>   DESCEND objtool
> > >>   CALL    .../scripts/checksyscalls.sh
> > >>   INSTALL libsubcmd_headers
> > >> .pylintrc: warning: ignored by one of the .gitignore files
> > >> Kernel: arch/x86/boot/bzImage is ready  (#23)
> > >> make[1]: Leaving directory '...'
> > >> 
> > >> $ touch drivers/gpio/gpiolib-acpi.c
> > >> 
> > >> $ make LLVM=-19 O=.../out W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64
> > >> make[1]: Entering directory '...'
> > >>   GEN     Makefile
> > >>   DESCEND objtool
> > >>   CALL    .../scripts/checksyscalls.sh
> > >>   INSTALL libsubcmd_headers
> > >> ...
> > >>   OBJCOPY arch/x86/boot/setup.bin
> > >>   BUILD   arch/x86/boot/bzImage
> > >> Kernel: arch/x86/boot/bzImage is ready  (#24)
> > >> make[1]: Leaving directory '...'
> > >> 
> > >> $ git status --ignored
> > >> On branch ...
> > >> Untracked files:
> > >>   (use "git add <file>..." to include in what will be committed)
> > >> 	scripts/lib/kdoc/__pycache__/
> > >> 
> > >> nothing added to commit but untracked files present (use "git add" to track)
> > >
> > > FWIW, I repeated this with removing the O=.../out folder completely, so it's
> > > fully clean build. Still the same issue.
> > >
> > > And it appears at the very beginning of the build. You don't need to wait to
> > > have the kernel to be built actually.
> > 
> > kernel-doc gets run on source files for W=1 builds. See Makefile.build.
> 
> Thanks for the clarification, so we know that it runs and we know that it has
> an issue.

Ideal solution what would I expect is that the cache folder should respect
the given O=... argument, or disabled at all (but I don't think the latter
is what we want as it may slow down the build).


> > >> It's 100% reproducible on my side. I am happy to test any patches to fix this.
> > >> It's really annoying "feature" for `make O=...` builds. Also note that
> > >> theoretically the Git worktree may be located on read-only storage / media
> > >> and this can induce subtle issues.

-- 
With Best Regards,
Andy Shevchenko



