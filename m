Return-Path: <netdev+bounces-139147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CE49B0698
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 17:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F261C24C1A
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC8717DFE4;
	Fri, 25 Oct 2024 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RN1r29h5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E402217C234;
	Fri, 25 Oct 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868257; cv=none; b=uNTWYnpHDcfJYR21M2j95GxY/4P94qNMqRyn1hTo4t33S5RbuPNE3xpmTGBibIurPYkVw0FZm7FBWxgycryas0GBqXv86T38CH45SvfYB/Ioqzb0TRlwnEKErO0P+dxK8Xio0YpARIczKOeh49YDqdwQzcbLBaTTliCEzn6WL0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868257; c=relaxed/simple;
	bh=ix2tXusYTmrFGAelw8kNSLKU2BJAsin2+gBsbel4FJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5kqzBEXnrxWuQNT+GqWNWjgRXLYD5+g+uC0oMYHLOregpAsmwZAJ1gvHknmn2NV5byCjHmsIqNgLA4vAxAzQX76JZd8873PZhOEH4U8xzdb9eJAg64xWmy26+ZqNOhK6TX9TUqTPxbJILbtzayUUJ5tIt/brjMSw4tNTrGPlw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RN1r29h5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729868256; x=1761404256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ix2tXusYTmrFGAelw8kNSLKU2BJAsin2+gBsbel4FJs=;
  b=RN1r29h5E9PtfOdjwQFrhDCLHxmtrVj3g92N40WDDCuGe6RcSsT4A7B4
   TrZywnURwNTBtnoXEcixFtex7/tUksHZC2tDHSnbW4efr7N3YyNfodAUS
   l4L7t+zTZWHe+eF3Li2Vs1+9QymOZucfgH+5Sp3DFazzA7yHaPd557/d8
   2Y/TzyOEQwtMP9DNY5MGArhze1uUKQCD4NkmfH+rC7RZxJmiWjgQ3JAfW
   yefpGFR3WlgnPOVW2m/EWfA7VTsiPday/r8uvc/XjFwZeLZ/8+LT4IH2F
   MkEB4vzqPerzdBbq7TNZhCS/vWo1c4pqS+wRW/DG0gwCai38BhKIQse5X
   A==;
X-CSE-ConnectionGUID: U18jMg5CSmiT2vUnHHIN6Q==
X-CSE-MsgGUID: EW0v4K65Rr6nPHBxfQWAUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40913193"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="40913193"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:57:14 -0700
X-CSE-ConnectionGUID: 7BbwNPViT5KjA/RGTdYz1Q==
X-CSE-MsgGUID: 9Kiu9YxlTRG39KkA2dLSrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="84894408"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 25 Oct 2024 07:57:08 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4LkQ-000YNg-1r;
	Fri, 25 Oct 2024 14:57:06 +0000
Date: Fri, 25 Oct 2024 22:56:46 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Rosen Penev <rosenp@gmail.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next] net: freescale: use ethtool string helpers
Message-ID: <202410252249.mmE2EZPz-lkp@intel.com>
References: <20241024205257.574836-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024205257.574836-1-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-freescale-use-ethtool-string-helpers/20241025-045447
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241024205257.574836-1-rosenp%40gmail.com
patch subject: [PATCH net-next] net: freescale: use ethtool string helpers
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241025/202410252249.mmE2EZPz-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5886454669c3c9026f7f27eab13509dd0241f2d6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410252249.mmE2EZPz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410252249.mmE2EZPz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c:11:
   In file included from include/linux/platform_device.h:13:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c:13:
   In file included from include/linux/fsl/ptp_qoriq.h:9:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:95:
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
   In file included from drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c:13:
   In file included from include/linux/fsl/ptp_qoriq.h:9:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:95:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c:13:
   In file included from include/linux/fsl/ptp_qoriq.h:9:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:95:
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
>> drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c:257:14: warning: variables 'j' and 'num_cpus' used in loop condition not modified in loop body [-Wfor-loop-analysis]
     257 |         for (i = 0; j < num_cpus; i++)
         |                     ^   ~~~~~~~~
   17 warnings generated.


vim +257 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c

   242	
   243	static void dpaa_get_strings(struct net_device *net_dev, u32 stringset,
   244				     u8 *data)
   245	{
   246		unsigned int i, j, num_cpus;
   247	
   248		num_cpus = num_online_cpus();
   249	
   250		for (i = 0; i < DPAA_STATS_PERCPU_LEN; i++) {
   251			for (j = 0; j < num_cpus; j++)
   252				ethtool_sprintf(&data, "%s [CPU %d]",
   253						dpaa_stats_percpu[i], j);
   254	
   255			ethtool_sprintf(&data, "%s [TOTAL]", dpaa_stats_percpu[i]);
   256		}
 > 257		for (i = 0; j < num_cpus; i++)
   258			ethtool_sprintf(&data, "bpool [CPU %d]", i);
   259	
   260		ethtool_puts(&data, "bpool [TOTAL]");
   261	
   262		for (i = 0; i < DPAA_STATS_GLOBAL_LEN; i++)
   263			ethtool_puts(&data, dpaa_stats_global[i]);
   264	}
   265	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

