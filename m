Return-Path: <netdev+bounces-139197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF279B0F27
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 21:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E64B1C2234C
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894CF20D51A;
	Fri, 25 Oct 2024 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hXq4sh8a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7016418F2C3;
	Fri, 25 Oct 2024 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884938; cv=none; b=ihUutpJZLTy80DZPVHuHMIiiqFUqXmvDCaZ/1xZwan6yqXBLT35Oj0qcgoPEpNkjflavVIzoI3RaIZLwhOqCH3fklt78ef/AduZGEfwZsPQZXc1QflY+kXizp5KvJ5OlJDBT2B7WwDxZ1ZTz4bs1P6VqsGinL7LmwBS2AaEs3nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884938; c=relaxed/simple;
	bh=EgyR/UbyJ4Voj9eU/40Jz25ghogHjnVJeexcYHhMjPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKE3VYW4u/wbOACRzbrvDm/ItgqbkcMZ65+Jhg5bMdJJBM9n5miIDRAsz4vd9MJRmxJ1qmiGEAoyCm7vQAQSR+v/HnocUwcje1wLnfLMlA2Zm98uqhhPmCgPqdLN1sCUu78Lf6RRqZNiyWM7F6puL55OBa9whRTJwXDYFXIBfJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hXq4sh8a; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729884935; x=1761420935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EgyR/UbyJ4Voj9eU/40Jz25ghogHjnVJeexcYHhMjPo=;
  b=hXq4sh8a+CNHRFtsfsXG27z2fbwkfM8+zYN3GE4Lmq8ES2DXvPkLZku9
   d/K9e7DOYorgGsC3S3nCYb3b1I/IkNWFbytBsL5dHNcvl8pcthDaE6+w8
   LigkCwRqz+8xf1ENJBkICa5KjNLzf+BtqDZaOLvImJnGQrdfhBP3zQg8Y
   qfXjaH6HVIofM6vtDCG4nJWpqCUZQN4dqT2w6JkcUFFvaSoDLt25SFQJO
   Uo6APOgY+tylZl5CN1px3YhYY6CCEhqkWKvO7LIZP2pk6BQMg4Ij/QqTU
   07ZHVur4y80CWP60VwbQolbj68ZdXPj1YmL19wd/AC+WpHckDdF1SnZsi
   A==;
X-CSE-ConnectionGUID: huvUCd4cTK66tBlI9TafLg==
X-CSE-MsgGUID: DAZlq5gZRfaVPKyq6L+C6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29007672"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="29007672"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 12:35:34 -0700
X-CSE-ConnectionGUID: fJ4qj/scTtu8exG4VL8VPQ==
X-CSE-MsgGUID: NN4ixM9NSji1YGfQYgpSdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="118468872"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 25 Oct 2024 12:35:27 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4Q5l-000YoY-0Z;
	Fri, 25 Oct 2024 19:35:25 +0000
Date: Sat, 26 Oct 2024 03:34:37 +0800
From: kernel test robot <lkp@intel.com>
To: Inochi Amaoto <inochiama@gmail.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
Message-ID: <202410260337.pPIMKkX6-lkp@intel.com>
References: <20241025011000.244350-5-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025011000.244350-5-inochiama@gmail.com>

Hi Inochi,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on sophgo/for-next sophgo/fixes net-next/main net/main linus/master v6.12-rc4 next-20241025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Inochi-Amaoto/dt-bindings-net-snps-dwmac-Add-dwmac-5-30a-version/20241025-091315
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20241025011000.244350-5-inochiama%40gmail.com
patch subject: [PATCH v2 4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241026/202410260337.pPIMKkX6-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5886454669c3c9026f7f27eab13509dd0241f2d6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241026/202410260337.pPIMKkX6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410260337.pPIMKkX6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c:11:
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
   In file included from drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c:14:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
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
   In file included from drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c:14:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
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
   In file included from drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c:14:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
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
>> drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c:30:9: error: call to undeclared function 'rgmii_clock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      30 |         rate = rgmii_clock(speed);
         |                ^
   drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c:46:6: warning: unused variable 'ret' [-Wunused-variable]
      46 |         int ret;
         |             ^~~
   17 warnings and 1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]


vim +/rgmii_clock +30 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c

    23	
    24	static void sophgo_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
    25	{
    26		struct sophgo_dwmac *dwmac = priv;
    27		long rate;
    28		int ret;
    29	
  > 30		rate = rgmii_clock(speed);
    31		if (ret < 0) {
    32			dev_err(dwmac->dev, "invalid speed %u\n", speed);
    33			return;
    34		}
    35	
    36		ret = clk_set_rate(dwmac->clk_tx, rate);
    37		if (ret)
    38			dev_err(dwmac->dev, "failed to set tx rate %lu\n", rate);
    39	}
    40	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

