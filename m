Return-Path: <netdev+bounces-162701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A23A27A8E
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 19:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D0A1657CF
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74EC216E33;
	Tue,  4 Feb 2025 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIEE3XJ6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0DD218AA3
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738695115; cv=none; b=ipwlTZaq6iawmlbIIPkqzm1H/S6V6C6M29e9y4pIUiFsT1xKeGiaspQmVQMJIakmLeKXPzqQcr+jP3JhCP04ienn7lWEgrNxOaTSwsc0yZtGm1sJlSN4N/BbpE5nsAikfQn+PcvSm35Kz+rhhZRXbNLkEum0D6fTIzqvBeYa7DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738695115; c=relaxed/simple;
	bh=k7HIN2/4JNPmmW9EOwz5dmbwnDmMoY6rJ767bWiH8kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZCqxRhcNR0GyiG90wEOuX1rPDWKItGF0sq9/TMpp6GJ+wiFvoBAvbqxqpLA0YspKjccqffS4Kn8oC6foAtkLgGpLOVVGiwXEGrdM4lyMvZLuNtP3yPxy46uInh0xWIFr6G9l0UbRY4gHb55QsaQPtGExkxvjA/HqIIRTmHpwpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIEE3XJ6; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738695114; x=1770231114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k7HIN2/4JNPmmW9EOwz5dmbwnDmMoY6rJ767bWiH8kM=;
  b=JIEE3XJ6Ctbtk2yoXEHpvJhHXsLtWQZOwg8MeQFef+x5G/o2Phcyl5V8
   44fw3UhNOiWg3uMaXTiH0yPrGGwcKAOzovoLMAbyim3b8CcCXJpUetc3N
   f9DMfiudj/ZjjyMU3d8BrVFzVir5xx8pLpZo3g78xEOjq3+RtkO/W3r6F
   ICQcSi/OeZ282n0eY6a93JonsoqZi8dgsA8tyLWnW0ATEQyNsotAAM04n
   8Z5BJl5e6Zl670YpB4Rp9UYZ/vmZE4TXkYFk/dpkhoVEFfaQCbxzwEhg8
   jZv+1YL4/5N2hypN2o5vAcxzzYaGtoPJMbAxswnLLqo1q9hH4p99iMKsw
   Q==;
X-CSE-ConnectionGUID: hwEmJJ46Rx2hMrWCN/ZJGg==
X-CSE-MsgGUID: SNFNfrCBTdqQETACcaGvZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39268962"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="39268962"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 10:51:48 -0800
X-CSE-ConnectionGUID: mqLlYBAXRg647PCZwOhXag==
X-CSE-MsgGUID: qyQyePwGS0WtlynkG1GLBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="110559274"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 04 Feb 2025 10:51:42 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tfO1M-000ssZ-04;
	Tue, 04 Feb 2025 18:51:40 +0000
Date: Wed, 5 Feb 2025 02:50:42 +0800
From: kernel test robot <lkp@intel.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>, andrew@lunn.ch,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v4 6/7] net: selftests: Export
 net_test_phy_loopback_*
Message-ID: <202502050234.kRVRQjkS-lkp@intel.com>
References: <20250203191057.46351-7-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203191057.46351-7-gerhard@engleder-embedded.com>

Hi Gerhard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Gerhard-Engleder/net-phy-Allow-loopback-speed-selection-for-PHY-drivers/20250204-041619
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250203191057.46351-7-gerhard%40engleder-embedded.com
patch subject: [PATCH net-next v4 6/7] net: selftests: Export net_test_phy_loopback_*
config: s390-randconfig-001-20250204 (https://download.01.org/0day-ci/archive/20250205/202502050234.kRVRQjkS-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250205/202502050234.kRVRQjkS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502050234.kRVRQjkS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/freescale/fec_main.c:42:
>> include/net/selftests.h:30:12: warning: 'net_test_phy_loopback_tcp' defined but not used [-Wunused-function]
      30 | static int net_test_phy_loopback_tcp(struct net_device *ndev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/net/selftests.h:25:12: warning: 'net_test_phy_loopback_udp_mtu' defined but not used [-Wunused-function]
      25 | static int net_test_phy_loopback_udp_mtu(struct net_device *ndev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/net_test_phy_loopback_tcp +30 include/net/selftests.h

    24	
  > 25	static int net_test_phy_loopback_udp_mtu(struct net_device *ndev)
    26	{
    27		return 0;
    28	}
    29	
  > 30	static int net_test_phy_loopback_tcp(struct net_device *ndev)
    31	{
    32		return 0;
    33	}
    34	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

