Return-Path: <netdev+bounces-127026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269CA973AD0
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AE30B21AA7
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 15:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85278156C69;
	Tue, 10 Sep 2024 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mB61+Kfa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D726F305;
	Tue, 10 Sep 2024 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725980456; cv=none; b=TC0vLC/3Kx3m0WSuFHGTTcBU+YEFopGT0oj8pWxIYrJrk2G1xi4L+9yb5GOxwudF7kaxYyyt/WLBjp/uQUG3kTxrmT0ihjekSQn0ZZZEcNgeMgK6Cf1enaM75/U1ZDR/3Gyo3+Lw8iw+oPv1ZDjxMU7sXBp40ocr0antr7rukCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725980456; c=relaxed/simple;
	bh=j7tjGVSW8H3+q0t9e0IaeNfipepQz25epPeXce/Z4AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZYMheiSUtGj8QyqehUgyrHZQENNXQGfSW8BqnuMHJqVXal8Rsgj315zFOJi8sKZLXWXor0IqZtXRcKtZc/l5XrTdRYoanA/vWhM6DeXsqKCvONgvzrkKEBBjMPucXNeb+hAr3DFKrkpxH6hW1XnVQJaXHvrYesaFHIQBDtqCKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mB61+Kfa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725980455; x=1757516455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j7tjGVSW8H3+q0t9e0IaeNfipepQz25epPeXce/Z4AA=;
  b=mB61+Kfa4H0OZ0RRHKYPlo36wPVKKTmlKbYXhymQen5IAUFel1s9uDWy
   uCshamx4KI79sNVR3MJGeHAkLRko4oujdYWGPdDlMbBAmxzn2ELuVuS3c
   dPtvIBaxPpO5mmTPMvwvj9/nVhtICYmWfu0BH0G4V0i5roK+dvmwODHkq
   T5lOTtFwmS0DIPJseduQMoDU5ZGXq2tTY5HCFf1vBKGNdASTeO0ssEGFH
   1v4B7PDRM8ZV+bGfLl5y8zKt6GWyTSMPVVs1bbozrf/kDNlkCT3o3gW9V
   /LNBADa5AHUXMbWeyygu4wcBgWqmZhp00KSaPAr5WMJpT49AE5oyZqBIz
   A==;
X-CSE-ConnectionGUID: +vf6wpRuQwSTbuA1dYsZ5Q==
X-CSE-MsgGUID: 8/k93VU8TaS36IiNEBCwzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24880241"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="24880241"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 08:00:49 -0700
X-CSE-ConnectionGUID: T8gd7uDyQnSWOWsUCSSmKQ==
X-CSE-MsgGUID: PGauhd31SA+bb4UACjoxSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="67824809"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 Sep 2024 08:00:46 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1so2MF-0002Ea-0t;
	Tue, 10 Sep 2024 15:00:43 +0000
Date: Tue, 10 Sep 2024 23:00:34 +0800
From: kernel test robot <lkp@intel.com>
To: Jeongjun Park <aha310510@gmail.com>, davem@davemloft.net,
	dsahern@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kafai@fb.com, weiwan@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: Re: [PATCH net] net: prevent NULL pointer dereference in
 rt_fibinfo_free() and rt_fibinfo_free_cpus()
Message-ID: <202409102210.krjQJVRr-lkp@intel.com>
References: <20240909184827.123071-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909184827.123071-1-aha310510@gmail.com>

Hi Jeongjun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeongjun-Park/net-prevent-NULL-pointer-dereference-in-rt_fibinfo_free-and-rt_fibinfo_free_cpus/20240910-025008
base:   net/main
patch link:    https://lore.kernel.org/r/20240909184827.123071-1-aha310510%40gmail.com
patch subject: [PATCH net] net: prevent NULL pointer dereference in rt_fibinfo_free() and rt_fibinfo_free_cpus()
config: arc-randconfig-002-20240910 (https://download.01.org/0day-ci/archive/20240910/202409102210.krjQJVRr-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409102210.krjQJVRr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409102210.krjQJVRr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv4/fib_semantics.c: In function 'rt_fibinfo_free':
>> net/ipv4/fib_semantics.c:156:13: warning: the comparison will always evaluate as 'true' for the address of 'dst' will never be NULL [-Waddress]
     156 |         if (!&rt->dst)
         |             ^
   In file included from include/net/ip.h:30,
                    from net/ipv4/fib_semantics.c:37:
   include/net/route.h:56:33: note: 'dst' declared here
      56 |         struct dst_entry        dst;
         |                                 ^~~
   net/ipv4/fib_semantics.c: In function 'rt_fibinfo_free_cpus':
   net/ipv4/fib_semantics.c:209:21: warning: the comparison will always evaluate as 'true' for the address of 'dst' will never be NULL [-Waddress]
     209 |                 if (!&rt->dst)
         |                     ^
   include/net/route.h:56:33: note: 'dst' declared here
      56 |         struct dst_entry        dst;
         |                                 ^~~


vim +156 net/ipv4/fib_semantics.c

   149	
   150	static void rt_fibinfo_free(struct rtable __rcu **rtp)
   151	{
   152		struct rtable *rt = rcu_dereference_protected(*rtp, 1);
   153	
   154		if (!rt)
   155			return;
 > 156		if (!&rt->dst)
   157			return;
   158	
   159		/* Not even needed : RCU_INIT_POINTER(*rtp, NULL);
   160		 * because we waited an RCU grace period before calling
   161		 * free_fib_info_rcu()
   162		 */
   163	
   164		dst_dev_put(&rt->dst);
   165		dst_release_immediate(&rt->dst);
   166	}
   167	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

