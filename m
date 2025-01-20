Return-Path: <netdev+bounces-159745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD64A16B51
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 12:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7043A951E
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 11:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B551B4F02;
	Mon, 20 Jan 2025 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXl1Bzvh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE23019DFAB
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737371725; cv=none; b=lIr4npNb8R0vrRMCOD/J0HGKd4vSIlv5y6ZZJHfgRgIAaTzzdoWraWMBWorDviS7vodBoil8+bz1eMvKTrOolvSQNvqHX6Shozcj/lfCye3+RBZpQX++rvOt8zn2s8rSIlMfnPzoUoYjyCqC6wrI1oYM5g7CVFAHvn0/qwSObro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737371725; c=relaxed/simple;
	bh=se8iuTeVfpUizEwLzuSXzkzwvCHJFsZ6DnPXyjataaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PODQ8SjaewiN9ckibcl3VXBSy8sgF03UIZ8IqXJ6p5Br2oNIH2az4KvI3nBmAwW+7VBn1z0Oirl9zCvelEO3KkqypGsGJWJiI4Y9jwxFLtDRINmoCJcIY2/KtUYbZ0gc/HDscPwGcg7PaYcUmITD03agNZ6e8JoiB6OgWpHupzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXl1Bzvh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737371724; x=1768907724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=se8iuTeVfpUizEwLzuSXzkzwvCHJFsZ6DnPXyjataaY=;
  b=gXl1BzvhIBYOXyoMcSoIUCcgQdzQwiMym6QhRyaAvBFdAzFwt0HBro97
   PTpLoeCEz+oOX8zCq0LfJxK91v9liWbuqnt4Utk7nl0lZgtFL+jwCrxsR
   1FL+GxfvlEAIUsop5P/G2GMQwui9AKp7aeZ8lQHMQW1if3fksEICPzBNe
   2NTW2nS1kfBv09UFLo5Dwe5I9i/MICQUEpLcXpEDFro9UPS64W4ZQppar
   KunTas1/HYmUKVJE26YQ/IKmfKQ3F0NfuUmMQvk7kaEHXSTnCXamgc/rt
   3C8TGwTP41rBiblgTwbGFGrtpKP/AptEWtmAXVs1mqzVviFJBL2kweBr0
   g==;
X-CSE-ConnectionGUID: c9MlxOqeTQu/p6JY+vVrSg==
X-CSE-MsgGUID: W182OyfcS8KSDVfZDnvdnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="60222866"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="60222866"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 03:15:23 -0800
X-CSE-ConnectionGUID: XZijA5KOTfWgT9j2hVzDPw==
X-CSE-MsgGUID: joDIB92rTjWlprtOHd3htA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="106301303"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Jan 2025 03:15:19 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZpkS-000WTj-2W;
	Mon, 20 Jan 2025 11:15:16 +0000
Date: Mon, 20 Jan 2025 19:14:44 +0800
From: kernel test robot <lkp@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
	horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mengyuanlou@net-swift.com, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH net-next v5 1/4] net: wangxun: Add support for PTP clock
Message-ID: <202501201812.CX71IRuQ-lkp@intel.com>
References: <20250117062051.2257073-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117062051.2257073-2-jiawenwu@trustnetic.com>

Hi Jiawen,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiawen-Wu/net-wangxun-Add-support-for-PTP-clock/20250117-142347
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250117062051.2257073-2-jiawenwu%40trustnetic.com
patch subject: [PATCH net-next v5 1/4] net: wangxun: Add support for PTP clock
config: i386-randconfig-004-20250120 (https://download.01.org/0day-ci/archive/20250120/202501201812.CX71IRuQ-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250120/202501201812.CX71IRuQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501201812.CX71IRuQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: ptp_clock_register
   >>> referenced by wx_ptp.c:306 (drivers/net/ethernet/wangxun/libwx/wx_ptp.c:306)
   >>>               drivers/net/ethernet/wangxun/libwx/wx_ptp.o:(wx_ptp_init) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: ptp_clock_unregister
   >>> referenced by wx_ptp.c:650 (drivers/net/ethernet/wangxun/libwx/wx_ptp.c:650)
   >>>               drivers/net/ethernet/wangxun/libwx/wx_ptp.o:(wx_ptp_stop) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

