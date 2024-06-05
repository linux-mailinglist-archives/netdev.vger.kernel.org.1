Return-Path: <netdev+bounces-101171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9808FD9D4
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 00:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A7F1C24EAA
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 22:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601BD15FA60;
	Wed,  5 Jun 2024 22:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fhv8q/NC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A2715ECE5;
	Wed,  5 Jun 2024 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717626397; cv=none; b=GuExF4Q1qmvixu6ZSCny5R0Jv1yxlpB/eBpG61wJiihStxuffXuwB5bZIPQToptWZE8i1Aopk050q+mbsKPdwQiOXKMWRiUDPLgpAHWpjiFDBQh2P60UKwqJJzcHvXCmxa8RKIaRIQZ+KTMGcN2NENS/gq0QMlRyNiItDPS2OY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717626397; c=relaxed/simple;
	bh=GlWXfUtCWMB4lpnsqM0YWyUCmfcsIGMG/XHe0n2lWr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdAzcWMJfWkYIQK6m2P15GHVvGd0i2iQc9Oc4OFHLLGGj/0wygzy3MrM1++uSnvQ/RVNASv9CI+NcXT84cwWW0OWOfFDtOZiKtNHj2NNRhECYs9m95tV8y0TFJOoGRJP67zLFsdw3QWUwNRB/VeIip5S4q7wCZyyWk8X9ejHjo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fhv8q/NC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717626395; x=1749162395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GlWXfUtCWMB4lpnsqM0YWyUCmfcsIGMG/XHe0n2lWr4=;
  b=Fhv8q/NCiNntFUHsvRJ57XiY89n+GNzgq9a2AobKE81FVSLIjPkr21vB
   swtUj58WqgLnbiuoDpbpAH9gMXalBjJwP0VKrHBgBy1n2GDUR68igqqN2
   mrCYsO+vZN0PD3fw3Uo3F6hEJpzCHtYxReEytKUHKYya+LEbcOjvxoVqn
   SXexMPHHz7T/2nqb8wNvOhxpRYAFgvCrNPLmC80im5puYCjFrC2OQmcwc
   rvKIres9FdQRSDPnStaNiwqR4qXV1XeJSqwlU5ojwv7bwmwyXLWoKl2WB
   lkIbwHVGyf9FkphwjHL6Y3oI3yTmeihmGABsbWJtPLnBJR7ZBWmqiqkkE
   g==;
X-CSE-ConnectionGUID: qImpHhz1SFO14eNwXGjuAA==
X-CSE-MsgGUID: jFPFlVRdTZumTvGXqX1wtg==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14009638"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="14009638"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 15:26:26 -0700
X-CSE-ConnectionGUID: k70DZUB4SairZcjGEqDyMg==
X-CSE-MsgGUID: 0C3pdu/ORHu7QXKkBUJ+Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="42670402"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 05 Jun 2024 15:26:21 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEz5G-0002KS-1D;
	Wed, 05 Jun 2024 22:26:18 +0000
Date: Thu, 6 Jun 2024 06:25:32 +0800
From: kernel test robot <lkp@intel.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
	bryan.whitehead@microchip.com, andrew@lunn.ch,
	linux@armlinux.org.uk, sbauer@blackbox.su, hmehrtens@maxlinear.com,
	lxu@maxlinear.com, hkallweit1@gmail.com, edumazet@google.com,
	pabeni@redhat.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net V3 2/3] net: lan743x: Support WOL at both the PHY and
 MAC appropriately
Message-ID: <202406060612.UBlHLtM8-lkp@intel.com>
References: <20240605101611.18791-3-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605101611.18791-3-Raju.Lakkaraju@microchip.com>

Hi Raju,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Lakkaraju/net-lan743x-disable-WOL-upon-resume-to-restore-full-data-path-operation/20240605-182110
base:   net/main
patch link:    https://lore.kernel.org/r/20240605101611.18791-3-Raju.Lakkaraju%40microchip.com
patch subject: [PATCH net V3 2/3] net: lan743x: Support WOL at both the PHY and MAC appropriately
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240606/202406060612.UBlHLtM8-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240606/202406060612.UBlHLtM8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406060612.UBlHLtM8-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/microchip/lan743x_main.c:4:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/microchip/lan743x_main.c:5:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/net/ethernet/microchip/lan743x_main.c:5:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/net/ethernet/microchip/lan743x_main.c:5:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/net/ethernet/microchip/lan743x_main.c:3126:12: error: no member named 'phy_wol_supported' in 'struct lan743x_adapter'
    3126 |                 adapter->phy_wol_supported = wol.supported;
         |                 ~~~~~~~  ^
>> drivers/net/ethernet/microchip/lan743x_main.c:3127:12: error: no member named 'phy_wolopts' in 'struct lan743x_adapter'
    3127 |                 adapter->phy_wolopts = wol.wolopts;
         |                 ~~~~~~~  ^
   17 warnings and 2 errors generated.


vim +3126 drivers/net/ethernet/microchip/lan743x_main.c

  3085	
  3086	static int lan743x_netdev_open(struct net_device *netdev)
  3087	{
  3088		struct lan743x_adapter *adapter = netdev_priv(netdev);
  3089		int index;
  3090		int ret;
  3091	
  3092		ret = lan743x_intr_open(adapter);
  3093		if (ret)
  3094			goto return_error;
  3095	
  3096		ret = lan743x_mac_open(adapter);
  3097		if (ret)
  3098			goto close_intr;
  3099	
  3100		ret = lan743x_phy_open(adapter);
  3101		if (ret)
  3102			goto close_mac;
  3103	
  3104		ret = lan743x_ptp_open(adapter);
  3105		if (ret)
  3106			goto close_phy;
  3107	
  3108		lan743x_rfe_open(adapter);
  3109	
  3110		for (index = 0; index < LAN743X_USED_RX_CHANNELS; index++) {
  3111			ret = lan743x_rx_open(&adapter->rx[index]);
  3112			if (ret)
  3113				goto close_rx;
  3114		}
  3115	
  3116		for (index = 0; index < adapter->used_tx_channels; index++) {
  3117			ret = lan743x_tx_open(&adapter->tx[index]);
  3118			if (ret)
  3119				goto close_tx;
  3120		}
  3121	
  3122		if (adapter->netdev->phydev) {
  3123			struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
  3124	
  3125			phy_ethtool_get_wol(netdev->phydev, &wol);
> 3126			adapter->phy_wol_supported = wol.supported;
> 3127			adapter->phy_wolopts = wol.wolopts;
  3128		}
  3129	
  3130		return 0;
  3131	
  3132	close_tx:
  3133		for (index = 0; index < adapter->used_tx_channels; index++) {
  3134			if (adapter->tx[index].ring_cpu_ptr)
  3135				lan743x_tx_close(&adapter->tx[index]);
  3136		}
  3137	
  3138	close_rx:
  3139		for (index = 0; index < LAN743X_USED_RX_CHANNELS; index++) {
  3140			if (adapter->rx[index].ring_cpu_ptr)
  3141				lan743x_rx_close(&adapter->rx[index]);
  3142		}
  3143		lan743x_ptp_close(adapter);
  3144	
  3145	close_phy:
  3146		lan743x_phy_close(adapter);
  3147	
  3148	close_mac:
  3149		lan743x_mac_close(adapter);
  3150	
  3151	close_intr:
  3152		lan743x_intr_close(adapter);
  3153	
  3154	return_error:
  3155		netif_warn(adapter, ifup, adapter->netdev,
  3156			   "Error opening LAN743x\n");
  3157		return ret;
  3158	}
  3159	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

