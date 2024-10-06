Return-Path: <netdev+bounces-132532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB51399208D
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 21:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443AB1F2175E
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 19:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3212918A94F;
	Sun,  6 Oct 2024 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZoxJg3zq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5605218A931;
	Sun,  6 Oct 2024 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728242021; cv=none; b=B1H3ppKuyoJC1DM4xLNRSICO9dE4bmw18d8h/pooM1dWRQhSnXSoz5iPvFXuRVizoHRkT1gPq/qwGGser8T6eHiviHtZBYIpIMza4nQByJ70+64XJWrKyQaTWdvB7Zx5o1H+/DUFfvv4FWX4CcHHe+Y7stUappLmH8gl2LmD1s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728242021; c=relaxed/simple;
	bh=yX6nZc33Ski4RXltFwt5GMNR7dVy1uwiTXpGZr4B2FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQ1cEn6p+eXfuehBG8nXDB3X3xAdjKOdiWivDkABeYPD0kP4qrbkDL5RIYJn/Em6KuLDP0s0gF8lRvB122MbweoTi0jPMs8Z8s0EmXFs4WJs9ULY0bjMBklw+KgXldG7pShFc0YdwNH13XIiHsgBUGYaqSFuSPUvkSi0+hQCAgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZoxJg3zq; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728242019; x=1759778019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yX6nZc33Ski4RXltFwt5GMNR7dVy1uwiTXpGZr4B2FU=;
  b=ZoxJg3zqTmXJvyql2Se3cz63BWgn6aDpVSVgOjMjGuZgy+fajEdxYcnN
   PkGnsZudkdL7Dtj2Nx+8L6Y7kckEhcfolhNFHL+/Xao/ifC7QdHe1WR9j
   cIiq6jJFbF4B6tjUrkZEfbejYUVkoL7P56IhYIHlOx8cgEqBiG/P+6Od8
   x9f0AzFzIAqPZ69CuxBZ0WfIdsISIrXOA+WV/2l2WpDjmz6R4v2jqDjEz
   q8BcSCbF7M/gsDIbL4wm1gnuSOJ6ODHYAnvQ3eig85YqZb2opsGpSO9wq
   HDp6fSI1w3/g2BzNLs9M5VsAEtA24hkfmdrP9ZUqGM2J2JlzMWBYNo3jr
   w==;
X-CSE-ConnectionGUID: HAbFx5/OQ0up7dDPVqo++A==
X-CSE-MsgGUID: D+7fMU3bT0mWiUns1w4rAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="27478704"
X-IronPort-AV: E=Sophos;i="6.11,182,1725346800"; 
   d="scan'208";a="27478704"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2024 12:13:39 -0700
X-CSE-ConnectionGUID: XzZfBZQOSZeLTB+yeUeCrw==
X-CSE-MsgGUID: O9kIaUY9Rguux3MLmNqt6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,182,1725346800"; 
   d="scan'208";a="80041253"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 06 Oct 2024 12:13:36 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxWhB-0004G6-1l;
	Sun, 06 Oct 2024 19:13:33 +0000
Date: Mon, 7 Oct 2024 03:13:07 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, jacob.e.keller@intel.com,
	horms@kernel.org, sd@queasysnail.net, chunkeey@gmail.com
Subject: Re: [PATCH net-next v3 03/17] net: ibm: emac: use
 module_platform_driver for modules
Message-ID: <202410070205.fxayDTTJ-lkp@intel.com>
References: <20241003021135.1952928-4-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003021135.1952928-4-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-ibm-emac-use-netif_receive_skb_list/20241003-101754
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241003021135.1952928-4-rosenp%40gmail.com
patch subject: [PATCH net-next v3 03/17] net: ibm: emac: use module_platform_driver for modules
config: powerpc-fsp2_defconfig (https://download.01.org/0day-ci/archive/20241007/202410070205.fxayDTTJ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241007/202410070205.fxayDTTJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410070205.fxayDTTJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: drivers/net/ethernet/ibm/emac/core.o: in function `emac_init':
>> drivers/net/ethernet/ibm/emac/core.c:3285: multiple definition of `init_module'; drivers/net/ethernet/ibm/emac/mal.o:drivers/net/ethernet/ibm/emac/mal.c:782: first defined here
   powerpc-linux-ld: drivers/net/ethernet/ibm/emac/core.o: in function `emac_exit':
>> drivers/net/ethernet/ibm/emac/core.c:3293: multiple definition of `cleanup_module'; drivers/net/ethernet/ibm/emac/mal.o:drivers/net/ethernet/ibm/emac/mal.c:782: first defined here
   powerpc-linux-ld: drivers/net/ethernet/ibm/emac/rgmii.o: in function `rgmii_driver_init':
   drivers/net/ethernet/ibm/emac/rgmii.c:306: multiple definition of `init_module'; drivers/net/ethernet/ibm/emac/mal.o:drivers/net/ethernet/ibm/emac/mal.c:782: first defined here
   powerpc-linux-ld: drivers/net/ethernet/ibm/emac/rgmii.o: in function `rgmii_driver_exit':
   drivers/net/ethernet/ibm/emac/rgmii.c:306: multiple definition of `cleanup_module'; drivers/net/ethernet/ibm/emac/mal.o:drivers/net/ethernet/ibm/emac/mal.c:782: first defined here


vim +3285 drivers/net/ethernet/ibm/emac/core.c

1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson 2007-08-23  3283  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson 2007-08-23  3284  static int __init emac_init(void)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson 2007-08-23 @3285  {
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson 2007-08-23  3286  	/* Build EMAC boot list */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson 2007-08-23  3287  	emac_make_bootlist();
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson 2007-08-23  3288  
c142fce2e67e1b drivers/net/ethernet/ibm/emac/core.c Rosen Penev  2024-10-02  3289  	return platform_driver_register(&emac_driver);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson 2007-08-23  3290  }
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson 2007-08-23  3291  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson 2007-08-23  3292  static void __exit emac_exit(void)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson 2007-08-23 @3293  {
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson 2007-08-23  3294  	int i;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson 2007-08-23  3295  
74888760d40b3a drivers/net/ibm_newemac/core.c       Grant Likely 2011-02-22  3296  	platform_driver_unregister(&emac_driver);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson 2007-08-23  3297  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson 2007-08-23  3298  	/* Destroy EMAC boot list */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson 2007-08-23  3299  	for (i = 0; i < EMAC_BOOT_LIST_SIZE; i++)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson 2007-08-23  3300  		of_node_put(emac_boot_list[i]);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson 2007-08-23  3301  }
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson 2007-08-23  3302  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

