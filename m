Return-Path: <netdev+bounces-79884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9C087BD69
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 14:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51841F21775
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 13:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276EB5B1FB;
	Thu, 14 Mar 2024 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mC9eCHFs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3729C5A4C0
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422130; cv=none; b=ReTuduCvp+ab8tHNunFC22F7hhv1lbnL1kpy+vJIR/zKB5Ow27wJDiAmV7UHO8OiXQhECw0ZxjXbnLdnEv8C9Xe65FoTTpbM0F/rxc30EVP/5+HzUBq2yC29pAuPccEq1OuSP5MTo6yRcGaHFP966LGlDtauMbKIw4dc5l74Vr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422130; c=relaxed/simple;
	bh=t15J5v+a0NBM3J5pyicTzFmZpQkk74Q6WHA6oHvys0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWs5nWG0VQvQv1nTRplWxowINllLtO9DeA+VvhumgtJ/gTCP+w0f/TIptw0KQHUKjC1hV0CLYFgqMx4Z+dat1eERUcWoDWM5N1tkU/YeJi/ftYooYoo9LgVgXkl5gMx/LIzqUPRkADich724AFMx4vaWLIVMoAy/v+OOfENKXPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mC9eCHFs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710422128; x=1741958128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t15J5v+a0NBM3J5pyicTzFmZpQkk74Q6WHA6oHvys0M=;
  b=mC9eCHFsVyqgv2Y+1HRzAW2lCb3ZJu/hQ39gkV1b3YjTYJB3mvcNr6uN
   Lsh2yCe09aopNtwKUb3txvVSkG8uaUNyEBYMcE4fLrAOCvoOnwPmhsYTF
   /VhqmloPka5Jm4u/KAr7/N4QXruVHTnjPVZC4u0R4RX9N5SwGppKb1YcO
   kWgqF2O7fFucUHcWD1hdy+gummMyyV5xYqINsJc6cEqGTbngfX2ir608R
   hFZ8pUs/X7S+/1dHgMIlxkOwOeV0+aAQDdC8+PGs2gigtj83jFwtRpXPl
   GtINQwzhRwAONY9tuu8rfEskA85D6tEbWG8OHZCyemXnKMmJ4Zz7XfTuF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5091499"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="5091499"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 06:15:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="914460089"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="914460089"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 06:15:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rkkvb-0000000CWKf-0DfA;
	Thu, 14 Mar 2024 15:15:23 +0200
Date: Thu, 14 Mar 2024 15:15:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yujie Liu <yujie.liu@intel.com>
Cc: kernel test robot <lkp@intel.com>, jcmvbkbc@gcc.gnu.org,
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [net-next:main 4/19] WARNING: modpost: vmlinux: section mismatch
 in reference: bitmap_copy_clear_tail+0x58 (section: .text.unlikely) ->
 __setup_str_initcall_blacklist (section: .init.rodata)
Message-ID: <ZfL4amLH5W9Zc_MS@smile.fi.intel.com>
References: <202403121032.WDY8ftKq-lkp@intel.com>
 <ZfH85ScHmojydKlw@smile.fi.intel.com>
 <ZfLGLmb3QAsIGlbB@yujie-X299>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfLGLmb3QAsIGlbB@yujie-X299>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 14, 2024 at 05:41:02PM +0800, Yujie Liu wrote:
> Hi Andy,
> 
> On Wed, Mar 13, 2024 at 09:22:13PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 12, 2024 at 10:29:16AM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git main
> > > head:   f095fefacdd35b4ea97dc6d88d054f2749a73d07
> > > commit: de5f84338970815b9fdd3497a975fb572d11e0b5 [4/19] lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers
> > > config: xtensa-randconfig-001-20240311 (https://download.01.org/0day-ci/archive/20240312/202403121032.WDY8ftKq-lkp@intel.com/config)
> > > compiler: xtensa-linux-gcc (GCC) 13.2.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240312/202403121032.WDY8ftKq-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202403121032.WDY8ftKq-lkp@intel.com/
> > > 
> > > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > > 
> > > WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
> > > WARNING: modpost: vmlinux: section mismatch in reference: put_page+0x58 (section: .text.unlikely) -> initcall_level_names (section: .init.data)
> > > >> WARNING: modpost: vmlinux: section mismatch in reference: bitmap_copy_clear_tail+0x58 (section: .text.unlikely) -> __setup_str_initcall_blacklist (section: .init.rodata)
> > 
> > Reminds me of https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92938
> 
> Thanks for the information. We will configure the bot to ignore this
> pattern thus to avoid false reports.

I haven't told they are false.
I Cc'ed Max who can shed a light on this.

-- 
With Best Regards,
Andy Shevchenko



