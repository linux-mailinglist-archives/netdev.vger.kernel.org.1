Return-Path: <netdev+bounces-82696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C110D88F445
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 02:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2AA1F2E321
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 01:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C31BF58;
	Thu, 28 Mar 2024 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ej/Y+nR9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A121804A
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 00:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711587594; cv=none; b=BHgnlT9MXNtOFonryQ9RUlpF5NBdxCdwkfQnyx0kbQARcqvIuudRHSyHFGTsdqdQkoPfOBBP0yBXacKSfoYYJMO5xlUB6NfxKlZs0lmEhreEogrDxqXEyfhMX20lIOgzna4ZM8xk/0DbvqmZJaEMxReNm/QU6TZxN1piNu90LBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711587594; c=relaxed/simple;
	bh=Fzr+1mX9IZgrETnHkt3eB1xu4QMrdEGU+0foG4diZYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1CHWSCrL8gdlU6BAaVIZUNOz0+k1YgrsvA7tBFCaO4qOKsEyoDPnt2gSwHhMmXWA5/0JOnRldaYf8Nu0lOWUrcDySXJpCcP4HzaJVpA6B6z1ZiAwWnlUYCW0ClKTi5a9uHpUlj5zsFd2gmh3+WKmQsvuw/aXOUcYB2Z9nHikBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ej/Y+nR9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711587592; x=1743123592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fzr+1mX9IZgrETnHkt3eB1xu4QMrdEGU+0foG4diZYs=;
  b=Ej/Y+nR95BLMzS8560W5PxbP79C8qEnMEwtbYfTmbXsMjZOHnUwWtut7
   lNVDBFpxzgoAaO4VVRZzpmFtt6SxYC/LydLEUO+GmUbLTQ0C2nJA2yCFZ
   i3j+V8AYrS3bIyGjwDJvgd1uXf++wy490GUZt20Xb3nFCkrKEKvUj8pAV
   i8thfZvH5Z4z8AY+FqQ1RdTPgc1C4f1boGSoc1n5h0tYidWgMAv9CViMn
   FOmSvu4b84e5SjBA0lSWLLVBRwuLDi5JP4zryRy23CHbXzvvtU4o80XKG
   YCII8qRDvoGnOYGEv2AX65K9Ui/Z4Yl/N22zr/pze+0f8hRMRQLtrTse1
   A==;
X-CSE-ConnectionGUID: uLeFHlfjQimkiXVBElhavg==
X-CSE-MsgGUID: 9w+axXEEQvi0EEckFn7uhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6551558"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6551558"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 17:59:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="16552169"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 17:59:46 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpe7M-0001ek-17;
	Thu, 28 Mar 2024 00:59:44 +0000
Date: Thu, 28 Mar 2024 08:58:53 +0800
From: kernel test robot <lkp@intel.com>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	netdev@vger.kernel.org, Carolyn Wyborny <carolyn.wyborny@intel.com>,
	Jan Glaza <jan.glaza@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 5/5] ixgbe: Enable link
 management in E610 device
Message-ID: <202403280824.PzGzDP4N-lkp@intel.com>
References: <20240327155422.25424-6-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327155422.25424-6-piotr.kwapulinski@intel.com>

Hi Piotr,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.8]
[cannot apply to tnguy-next-queue/dev-queue tnguy-net-queue/dev-queue horms-ipvs/master v6.9-rc1 linus/master next-20240327]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Piotr-Kwapulinski/ixgbe-Add-support-for-E610-FW-Admin-Command-Interface/20240327-234237
base:   v6.8
patch link:    https://lore.kernel.org/r/20240327155422.25424-6-piotr.kwapulinski%40intel.com
patch subject: [Intel-wired-lan] [PATCH iwl-next v1 5/5] ixgbe: Enable link management in E610 device
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240328/202403280824.PzGzDP4N-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 23de3862dce582ce91c1aa914467d982cb1a73b4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240328/202403280824.PzGzDP4N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403280824.PzGzDP4N-lkp@intel.com/

All warnings (new ones prefixed by >>):

         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:4:
   In file included from drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h:7:
   In file included from drivers/net/ethernet/intel/ixgbe/ixgbe_type.h:8:
   In file included from include/linux/mdio.h:9:
   In file included from include/uapi/linux/mdio.h:15:
   In file included from include/linux/mii.h:13:
   In file included from include/linux/linkmode.h:5:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:4:
   In file included from drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h:7:
   In file included from drivers/net/ethernet/intel/ixgbe/ixgbe_type.h:8:
   In file included from include/linux/mdio.h:9:
   In file included from include/uapi/linux/mdio.h:15:
   In file included from include/linux/mii.h:13:
   In file included from include/linux/linkmode.h:5:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:4:
   In file included from drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h:7:
   In file included from drivers/net/ethernet/intel/ixgbe/ixgbe_type.h:8:
   In file included from include/linux/mdio.h:9:
   In file included from include/uapi/linux/mdio.h:15:
   In file included from include/linux/mii.h:13:
   In file included from include/linux/linkmode.h:5:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2822:5: warning: no previous prototype for function 'ixgbe_set_fw_drv_ver_x550' [-Wmissing-prototypes]
    2822 | s32 ixgbe_set_fw_drv_ver_x550(struct ixgbe_hw *hw, u8 maj, u8 min,
         |     ^
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2822:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    2822 | s32 ixgbe_set_fw_drv_ver_x550(struct ixgbe_hw *hw, u8 maj, u8 min,
         | ^
         | static 
>> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:3563:6: warning: no previous prototype for function 'ixgbe_set_ethertype_anti_spoofing_x550' [-Wmissing-prototypes]
    3563 | void ixgbe_set_ethertype_anti_spoofing_x550(struct ixgbe_hw *hw,
         |      ^
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:3563:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    3563 | void ixgbe_set_ethertype_anti_spoofing_x550(struct ixgbe_hw *hw,
         | ^
         | static 
>> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:3584:6: warning: no previous prototype for function 'ixgbe_set_source_address_pruning_x550' [-Wmissing-prototypes]
    3584 | void ixgbe_set_source_address_pruning_x550(struct ixgbe_hw *hw,
         |      ^
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:3584:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    3584 | void ixgbe_set_source_address_pruning_x550(struct ixgbe_hw *hw,
         | ^
         | static 
   20 warnings generated.


vim +/ixgbe_set_ethertype_anti_spoofing_x550 +3563 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c

  3556	
  3557	/** ixgbe_set_ethertype_anti_spoofing_x550 - Enable/Disable Ethertype
  3558	 *	anti-spoofing
  3559	 *  @hw:  pointer to hardware structure
  3560	 *  @enable: enable or disable switch for Ethertype anti-spoofing
  3561	 *  @vf: Virtual Function pool - VF Pool to set for Ethertype anti-spoofing
  3562	 **/
> 3563	void ixgbe_set_ethertype_anti_spoofing_x550(struct ixgbe_hw *hw,
  3564						    bool enable, int vf)
  3565	{
  3566		int vf_target_reg = vf >> 3;
  3567		int vf_target_shift = vf % 8 + IXGBE_SPOOF_ETHERTYPEAS_SHIFT;
  3568		u32 pfvfspoof;
  3569	
  3570		pfvfspoof = IXGBE_READ_REG(hw, IXGBE_PFVFSPOOF(vf_target_reg));
  3571		if (enable)
  3572			pfvfspoof |= BIT(vf_target_shift);
  3573		else
  3574			pfvfspoof &= ~BIT(vf_target_shift);
  3575	
  3576		IXGBE_WRITE_REG(hw, IXGBE_PFVFSPOOF(vf_target_reg), pfvfspoof);
  3577	}
  3578	
  3579	/** ixgbe_set_source_address_pruning_x550 - Enable/Disbale src address pruning
  3580	 *  @hw: pointer to hardware structure
  3581	 *  @enable: enable or disable source address pruning
  3582	 *  @pool: Rx pool to set source address pruning for
  3583	 **/
> 3584	void ixgbe_set_source_address_pruning_x550(struct ixgbe_hw *hw,
  3585						   bool enable,
  3586						   unsigned int pool)
  3587	{
  3588		u64 pfflp;
  3589	
  3590		/* max rx pool is 63 */
  3591		if (pool > 63)
  3592			return;
  3593	
  3594		pfflp = (u64)IXGBE_READ_REG(hw, IXGBE_PFFLPL);
  3595		pfflp |= (u64)IXGBE_READ_REG(hw, IXGBE_PFFLPH) << 32;
  3596	
  3597		if (enable)
  3598			pfflp |= (1ULL << pool);
  3599		else
  3600			pfflp &= ~(1ULL << pool);
  3601	
  3602		IXGBE_WRITE_REG(hw, IXGBE_PFFLPL, (u32)pfflp);
  3603		IXGBE_WRITE_REG(hw, IXGBE_PFFLPH, (u32)(pfflp >> 32));
  3604	}
  3605	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

