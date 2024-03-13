Return-Path: <netdev+bounces-79738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 369DA87B1C6
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 20:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612F31C29B33
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 19:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E54D9FB;
	Wed, 13 Mar 2024 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdnQSew4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FA83FB1C
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357739; cv=none; b=YbuCSYGSA+hJLz3jTAe6q9bK0D3WUBpsla8g1Kq38Vp6hg8Ffb2sK02aE1et4kN/Oaszdy2zqgj7inD+fohgKpiKux8VLDO2nho6WwhHQ/JRD5DCbyHirVHMILM8JHfwYgSgxkK7G+/PGPFoYnn2Ig8XPP2wAF2uqao4A1eZRRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357739; c=relaxed/simple;
	bh=GMeaC8jNUNxm2ktaqQ9ficVlGCIxcpuk1L2dtdcseZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hw82BYPeYgKK8pJmbVkwd04Z5BDsnjW35IbMf/eCQFv6pcqE1uXTra5bDbmLObzmRUyYuzraNpOdLRIeOS2LtawJYvyjhbmcHIaYyKQi/19IP/8TnvK9Kie4gWxSO39g64tlCYKrXHRfeOX/a4N8vk/NaPWCBvAsvuXdiX0OE84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdnQSew4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710357738; x=1741893738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GMeaC8jNUNxm2ktaqQ9ficVlGCIxcpuk1L2dtdcseZs=;
  b=fdnQSew46gKmUUtXqrOx8gHIziaanpIy/dJnt345xU8nWQ+aPMDfWMP4
   idGH1KI1OGcdyjU4JulZwTvLiwE9GshzbuHSXzjZN1yEcYba76XOTWoHf
   UQHE2ceqCoDei1k1sLfi0YIDf35Jd6CbKjNPeiqFsjovtU+ucAUUnRbn3
   pGdmkHKYCc9/m3TYeX78idQNJA/nhQSC/9cOgUVsm+EFyIfdwxr+vKcZW
   fnBkgqfx/DMZ6udAFNz09EwunDG+wgw6Od86g8hU0DQ7+dzzBxVzUUblM
   6SPwpzS2kKYROtrgDw8m1eo4+Sa4hBRS9xo1msZ5Hi+Xrd3jmowk+M4o5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="15875801"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="15875801"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 12:22:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="914439669"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="914439669"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 12:22:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rkUB3-0000000CJ6M-1rKn;
	Wed, 13 Mar 2024 21:22:13 +0200
Date: Wed, 13 Mar 2024 21:22:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>, jcmvbkbc@gcc.gnu.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [net-next:main 4/19] WARNING: modpost: vmlinux: section mismatch
 in reference: bitmap_copy_clear_tail+0x58 (section: .text.unlikely) ->
 __setup_str_initcall_blacklist (section: .init.rodata)
Message-ID: <ZfH85ScHmojydKlw@smile.fi.intel.com>
References: <202403121032.WDY8ftKq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403121032.WDY8ftKq-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 12, 2024 at 10:29:16AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git main
> head:   f095fefacdd35b4ea97dc6d88d054f2749a73d07
> commit: de5f84338970815b9fdd3497a975fb572d11e0b5 [4/19] lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers
> config: xtensa-randconfig-001-20240311 (https://download.01.org/0day-ci/archive/20240312/202403121032.WDY8ftKq-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240312/202403121032.WDY8ftKq-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403121032.WDY8ftKq-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
> WARNING: modpost: vmlinux: section mismatch in reference: put_page+0x58 (section: .text.unlikely) -> initcall_level_names (section: .init.data)
> >> WARNING: modpost: vmlinux: section mismatch in reference: bitmap_copy_clear_tail+0x58 (section: .text.unlikely) -> __setup_str_initcall_blacklist (section: .init.rodata)

Reminds me of https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92938

-- 
With Best Regards,
Andy Shevchenko



