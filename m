Return-Path: <netdev+bounces-199795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DCEAE1D00
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 16:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954026A1D6C
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E693328ECEA;
	Fri, 20 Jun 2025 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AO3JtqI6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C565A290D83;
	Fri, 20 Jun 2025 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750428219; cv=none; b=Nog7j+ySAAJoV2s76rkojiGi9mjE35Lo16VqCJn7aVrF90iik29yTBHUVNuwo/Pa3hFCzAc5IOAgLeV5AtHNg95/UA2fbk33I5Y4yZ44FBx9krslxiy910MwEvTRQdJlJ9J49Td6cyPdonRC6aZ+89ZvT+nbXBCcFPsAdyByN/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750428219; c=relaxed/simple;
	bh=p9nC1h8R9HgKVWcy4BLKg7nHMZViNKOTBn/WYNwJk18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jq90dpD2tWL82pF2Lm10asGEoZQ4092Y/wnbAfAAL+pbPQPQY82lagoh9TpqsJ1J6ouHSqHYtYp0a6ZV3HCbGl8vZL7fWpZL9BaCgbQ43KKBCgc97XZMSpNPj6LtmEV6VG5qiyBOy6ASRc2q1k39MhlIeXBoI0FOpmjEd08uSjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AO3JtqI6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750428218; x=1781964218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p9nC1h8R9HgKVWcy4BLKg7nHMZViNKOTBn/WYNwJk18=;
  b=AO3JtqI6U7B8VnLSN/xrF5WawEy8uI0hBx0mp3GbH+LnINY4D+05b2ic
   rxfCw0tX+9WZx8Mhu4Ud2oz5i1Vn7K0OdDUNW2cPxZL1idzeyfKRdFep8
   avGlvVvVLxyfRqulmIEet9Xsf4gFT3mSx/JSIbAKLSWQrgyNF5rSpEj48
   BoY7AKP1K8yEUp2Cl2OVZHl3c/7G6KSEd/XolCydB7V4YV6X1/VZZxDDJ
   EJWSUgzWya/uC8zrpVdmyo7hZuldT34/wViqKQ+XCWKmZT/isDvk9iGXW
   FT2I/Rz5jtHIGLm/wvuNvWw512Tr3InQSDSSIArDL4oMNzlyLyFqEGlgH
   w==;
X-CSE-ConnectionGUID: aOzow6koR3qTo3Jvcr41sg==
X-CSE-MsgGUID: B+Kbc7hpQVSEOGGdHeKmeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63744874"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="63744874"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 07:03:27 -0700
X-CSE-ConnectionGUID: RuhpVMTJTUCTIYqFQpaKbw==
X-CSE-MsgGUID: yd7fuzCsTgmcfEDgpRruHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="151471639"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 20 Jun 2025 07:03:23 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uScKu-000LpW-2I;
	Fri, 20 Jun 2025 14:03:20 +0000
Date: Fri, 20 Jun 2025 22:03:12 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Michal Simek <monstr@monstr.eu>,
	Saravana Kannan <saravanak@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: Re: [PATCH net 4/4] net: axienet: Split into MAC and MDIO drivers
Message-ID: <202506202126.EmqQsj0w-lkp@intel.com>
References: <20250619200537.260017-5-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619200537.260017-5-sean.anderson@linux.dev>

Hi Sean,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/auxiliary-Allow-empty-id/20250620-040839
base:   net/main
patch link:    https://lore.kernel.org/r/20250619200537.260017-5-sean.anderson%40linux.dev
patch subject: [PATCH net 4/4] net: axienet: Split into MAC and MDIO drivers
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250620/202506202126.EmqQsj0w-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250620/202506202126.EmqQsj0w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506202126.EmqQsj0w-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:3225:1: error: redefinition of '__inittest'
    3225 | module_platform_driver(axienet_driver);
         | ^
   include/linux/platform_device.h:292:2: note: expanded from macro 'module_platform_driver'
     292 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^
   include/linux/device/driver.h:261:3: note: expanded from macro 'module_driver'
     261 | } \
         |   ^
   include/linux/module.h:131:42: note: expanded from macro '\
   module_init'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c:2900:1: note: previous definition is here
    2900 | module_auxiliary_driver(xilinx_axienet_mac)
         | ^
   include/linux/auxiliary_bus.h:289:2: note: expanded from macro 'module_auxiliary_driver'
     289 |         module_driver(__auxiliary_driver, auxiliary_driver_register, auxiliary_driver_unregister)
         |         ^
   include/linux/device/driver.h:261:3: note: expanded from macro 'module_driver'
     261 | } \
         |   ^
   include/linux/module.h:131:42: note: expanded from macro '\
   module_init'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^
>> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:3225:1: error: redefinition of 'init_module'
    3225 | module_platform_driver(axienet_driver);
         | ^
   include/linux/platform_device.h:292:2: note: expanded from macro 'module_platform_driver'
     292 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^
   include/linux/device/driver.h:261:3: note: expanded from macro 'module_driver'
     261 | } \
         |   ^
   include/linux/module.h:133:6: note: expanded from macro '\
   module_init'
     133 |         int init_module(void) __copy(initfn)                    \
         |             ^
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c:2900:1: note: previous definition is here
    2900 | module_auxiliary_driver(xilinx_axienet_mac)
         | ^
   include/linux/auxiliary_bus.h:289:2: note: expanded from macro 'module_auxiliary_driver'
     289 |         module_driver(__auxiliary_driver, auxiliary_driver_register, auxiliary_driver_unregister)
         |         ^
   include/linux/device/driver.h:261:3: note: expanded from macro 'module_driver'
     261 | } \
         |   ^
   include/linux/module.h:133:6: note: expanded from macro '\
   module_init'
     133 |         int init_module(void) __copy(initfn)                    \
         |             ^
>> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:3225:1: error: redefinition of '__exittest'
    3225 | module_platform_driver(axienet_driver);
         | ^
   include/linux/platform_device.h:292:2: note: expanded from macro 'module_platform_driver'
     292 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^
   include/linux/device/driver.h:266:3: note: expanded from macro 'module_driver'
     266 | } \
         |   ^
   include/linux/module.h:139:42: note: expanded from macro '\
   module_exit'
     139 |         static inline exitcall_t __maybe_unused __exittest(void)                \
         |                                                 ^
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c:2900:1: note: previous definition is here
    2900 | module_auxiliary_driver(xilinx_axienet_mac)
         | ^
   include/linux/auxiliary_bus.h:289:2: note: expanded from macro 'module_auxiliary_driver'
     289 |         module_driver(__auxiliary_driver, auxiliary_driver_register, auxiliary_driver_unregister)
         |         ^
   include/linux/device/driver.h:266:3: note: expanded from macro 'module_driver'
     266 | } \
         |   ^
   include/linux/module.h:139:42: note: expanded from macro '\
   module_exit'
     139 |         static inline exitcall_t __maybe_unused __exittest(void)                \
         |                                                 ^
>> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:3225:1: error: redefinition of 'cleanup_module'
    3225 | module_platform_driver(axienet_driver);
         | ^
   include/linux/platform_device.h:292:2: note: expanded from macro 'module_platform_driver'
     292 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^
   include/linux/device/driver.h:266:3: note: expanded from macro 'module_driver'
     266 | } \
         |   ^
   include/linux/module.h:141:7: note: expanded from macro '\
   module_exit'
     141 |         void cleanup_module(void) __copy(exitfn)                \
         |              ^
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c:2900:1: note: previous definition is here
    2900 | module_auxiliary_driver(xilinx_axienet_mac)
         | ^
   include/linux/auxiliary_bus.h:289:2: note: expanded from macro 'module_auxiliary_driver'
     289 |         module_driver(__auxiliary_driver, auxiliary_driver_register, auxiliary_driver_unregister)
         |         ^
   include/linux/device/driver.h:266:3: note: expanded from macro 'module_driver'
     266 | } \
         |   ^
   include/linux/module.h:141:7: note: expanded from macro '\
   module_exit'
     141 |         void cleanup_module(void) __copy(exitfn)                \
         |              ^
   4 errors generated.


vim +/__inittest +3225 drivers/net/ethernet/xilinx/xilinx_axienet_main.c

8a3b7a252dca9f Daniel Borkmann  2012-01-19  3224  
2be586205ca2b8 Srikanth Thokala 2015-05-05 @3225  module_platform_driver(axienet_driver);
8a3b7a252dca9f Daniel Borkmann  2012-01-19  3226  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

