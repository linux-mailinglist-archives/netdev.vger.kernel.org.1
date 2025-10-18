Return-Path: <netdev+bounces-230659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55903BEC687
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 05:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062E06E3375
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 03:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7FC2459E1;
	Sat, 18 Oct 2025 03:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YC1shBOk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC9D15ECD7
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 03:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760758449; cv=none; b=l9Gqx7MmEpLCNyUqNtJoppm+vDMSEROW7NIMNBnNO3hBwdxdnemHIeOOnO9glQjcMQ0Taw9t97CkJ6366HnmaJJvDYWiu2kM/pP6+jyoUMRS+SxTk4ZRub1Kz01D66I9qh98PQl6rGwgOwJMWSLWPSfZ7VkXDqNJSkeT8uJDOQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760758449; c=relaxed/simple;
	bh=gYmdi6JiwWVpQ6TBq+3bLWOKPe4TLx5SGGvSpAVDKtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+1RWKuOymQwbEOhBwsDiX84vwRQYvSNu1rlw3Q09bY5W8YNzX2IeW7UUzTvT0RGk8fS3b/Baurw2Wf4QZeeKJOpPZfHPALCvwj8HF1LHinmXJCoYXgVO2KWXyu9UhtAL/bGZEpPG696JoEplUX/kZmKdMSw0k69Zzvdm/2R3Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YC1shBOk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760758448; x=1792294448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gYmdi6JiwWVpQ6TBq+3bLWOKPe4TLx5SGGvSpAVDKtw=;
  b=YC1shBOkWnoAzlyKWvD350QrYr2it6c3lLLRRp41vX30N+s79UfU/hf+
   yNJdKvp1RdDJFvpBaH0kydGdN97To3Zm1izKPWpUuGs3tMAzEVOUeNB7H
   6+Pp9fvk0PtDKKlPCcphw3JwrQAbhmK0wLZqfqHpowXuGjn09uzloT02k
   iY4mz6ZxCItlEZuIcLuUUYwHINg842saIsxGKK9O/kTbyrQWJNblj1ob3
   g6YRRfTOcspxdl70OtKNvCxrAytUzJgQmx9v4QIzljzms8bGEYas3L69/
   347dhUjRw8FrT6FgzG3+Lc4wMvKA7qrPar8QK5wtlyPV64AwSTCHLBpTD
   A==;
X-CSE-ConnectionGUID: QYk9najGT7GTdqDafC4Y+Q==
X-CSE-MsgGUID: J3ux5zBDTHmUNeYmdGr6Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="80603289"
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="80603289"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 20:34:06 -0700
X-CSE-ConnectionGUID: dd69f0azSbSAVVL/9C0exA==
X-CSE-MsgGUID: gZZK3RFBT0yEZJ7ZRqWNzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="183647805"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 17 Oct 2025 20:34:04 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9xha-00081j-12;
	Sat, 18 Oct 2025 03:33:57 +0000
Date: Sat, 18 Oct 2025 11:33:20 +0800
From: kernel test robot <lkp@intel.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	Shyam-sundar.S-k@amd.com, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: Re: [PATCH net-next v2 2/4] amd-xgbe: add ethtool phy selftest
Message-ID: <202510181124.5LDfdemg-lkp@intel.com>
References: <20251017064704.3911798-3-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017064704.3911798-3-Raju.Rangoju@amd.com>

Hi Raju,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Rangoju/amd-xgbe-introduce-support-ethtool-selftest/20251017-151230
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251017064704.3911798-3-Raju.Rangoju%40amd.com
patch subject: [PATCH net-next v2 2/4] amd-xgbe: add ethtool phy selftest
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20251018/202510181124.5LDfdemg-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251018/202510181124.5LDfdemg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510181124.5LDfdemg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/amd/xgbe/xgbe-selftest.c: In function 'xgbe_selftest_get_strings':
>> drivers/net/ethernet/amd/xgbe/xgbe-selftest.c:427:52: warning: '%s' directive output may be truncated writing up to 95 bytes into a region of size 28 [-Wformat-truncation=]
     427 |                 snprintf(p, ETH_GSTRING_LEN, "%2d. %s", i + 1,
         |                                                    ^~
   drivers/net/ethernet/amd/xgbe/xgbe-selftest.c:427:17: note: 'snprintf' output between 5 and 100 bytes into a destination of size 32
     427 |                 snprintf(p, ETH_GSTRING_LEN, "%2d. %s", i + 1,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     428 |                          xgbe_selftests[i].name);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~


vim +427 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c

066e40696db52b Raju Rangoju 2025-10-17  420  
066e40696db52b Raju Rangoju 2025-10-17  421  void xgbe_selftest_get_strings(struct xgbe_prv_data *pdata, u8 *data)
066e40696db52b Raju Rangoju 2025-10-17  422  {
066e40696db52b Raju Rangoju 2025-10-17  423  	u8 *p = data;
066e40696db52b Raju Rangoju 2025-10-17  424  	int i;
066e40696db52b Raju Rangoju 2025-10-17  425  
066e40696db52b Raju Rangoju 2025-10-17  426  	for (i = 0; i < xgbe_selftest_get_count(pdata); i++) {
066e40696db52b Raju Rangoju 2025-10-17 @427  		snprintf(p, ETH_GSTRING_LEN, "%2d. %s", i + 1,
066e40696db52b Raju Rangoju 2025-10-17  428  			 xgbe_selftests[i].name);
066e40696db52b Raju Rangoju 2025-10-17  429  		p += ETH_GSTRING_LEN;
066e40696db52b Raju Rangoju 2025-10-17  430  	}
066e40696db52b Raju Rangoju 2025-10-17  431  }
066e40696db52b Raju Rangoju 2025-10-17  432  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

