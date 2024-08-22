Return-Path: <netdev+bounces-120840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EABD95AFDB
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 10:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895592820F5
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 08:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78F616DC15;
	Thu, 22 Aug 2024 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5dSuazd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43EA165F11;
	Thu, 22 Aug 2024 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313904; cv=none; b=JHu99tR+uncovyt3uA7v6/syzADm+1/HbqRfArI+f/1GBTJhQ5PZ4F7B8iyfiY/6kdK/duto/EWqOz3X4eNTzj9JQuLpRcADb194Oz2GdySK8Ql1oXbPSpKj0OP/9g3s98BSbrTQZRmfR3xe3mDBMgEfZwTrFBU7J95bqBooXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313904; c=relaxed/simple;
	bh=fm6pQUwUxuBv+6oy62hhbqM1OC8Ag4JBgdutDL6RhYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiJQOVWoGzWu9Ek/R+T0D2f2eV/ohmlDZ7uydQJsJ6zA0Dj/MzyxN/7TWNQbJEZCleAR/AHeYoYWzOedNixaagj1uEKzb52AC8iwPnFsi4RyVCIT09n2ECVEMEyqm/8s/LwgBzzvbrefvpmoVAmSkU7d4GPZn+oSKhPFPqWKea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5dSuazd; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724313903; x=1755849903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fm6pQUwUxuBv+6oy62hhbqM1OC8Ag4JBgdutDL6RhYA=;
  b=F5dSuazd8BiB4VOoty4IWF2WxBSo/rCWJfsLi9BPxYDp9yMCXsbNkAu0
   5yYjdYoFKicPnaxayGA0LlaCj5LZeNBdUYNrOwNu54FKhFjE2gYw15GtU
   TTsrDYCfCFWJU/QORpeEqHJIdRmTGk7I6/hd0NeCdT/TbDPqBSVDx1qnn
   FDbhKKojbezuoh6tZ83pMjvAedDUl11QrqtulkwpfKwVXrwLm4PELZJ0j
   Je2ScG4NIQQ0/f4IzRA3vzNEf9QOlcn5FJVfK81Fbuc4AnRFjHiaVfseD
   LB/DDNDzuRujqEfNLPCvpodDKjap5PSYDC/LyRKD2Aj/NYYDbo+WzyJsA
   g==;
X-CSE-ConnectionGUID: 4e/4KmYKRBOBoITxOsPEVg==
X-CSE-MsgGUID: qgvgG9X1ToafsSPaZ25neg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="40224141"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="40224141"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 01:05:02 -0700
X-CSE-ConnectionGUID: 4t9MExnhS2qk7cgpNILH6A==
X-CSE-MsgGUID: LCYVEev5R5i8tBQYMiAqSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="61071853"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 22 Aug 2024 01:04:57 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sh2oQ-000CYo-2z;
	Thu, 22 Aug 2024 08:04:54 +0000
Date: Thu, 22 Aug 2024 16:04:32 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	Chad Monroe <chad.monroe@adtran.com>,
	John Crispin <john@phrozen.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: aquantia: allow forcing order of
 MDI pairs
Message-ID: <202408221523.6Cc0ADf9-lkp@intel.com>
References: <ed46220cc4c52d630fc481c8148fc749242c368d.1724244281.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed46220cc4c52d630fc481c8148fc749242c368d.1724244281.git.daniel@makrotopia.org>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/net-phy-aquantia-allow-forcing-order-of-MDI-pairs/20240821-210717
base:   net-next/main
patch link:    https://lore.kernel.org/r/ed46220cc4c52d630fc481c8148fc749242c368d.1724244281.git.daniel%40makrotopia.org
patch subject: [PATCH net-next 2/2] net: phy: aquantia: allow forcing order of MDI pairs
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240822/202408221523.6Cc0ADf9-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 26670e7fa4f032a019d23d56c6a02926e854e8af)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240822/202408221523.6Cc0ADf9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408221523.6Cc0ADf9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/phy/aquantia/aquantia_main.c:15:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/net/phy/aquantia/aquantia_main.c:15:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/phy/aquantia/aquantia_main.c:15:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/phy/aquantia/aquantia_main.c:15:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/net/phy/aquantia/aquantia_main.c:483:5: warning: no previous prototype for function 'aqr107_config_mdi' [-Wmissing-prototypes]
     483 | int aqr107_config_mdi(struct phy_device *phydev)
         |     ^
   drivers/net/phy/aquantia/aquantia_main.c:483:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     483 | int aqr107_config_mdi(struct phy_device *phydev)
         | ^
         | static 
   8 warnings generated.


vim +/aqr107_config_mdi +483 drivers/net/phy/aquantia/aquantia_main.c

   482	
 > 483	int aqr107_config_mdi(struct phy_device *phydev)
   484	{
   485		struct device_node *np = phydev->mdio.dev.of_node;
   486		bool force_normal, force_reverse;
   487	
   488		force_normal = of_property_read_bool(np, "marvell,force-mdi-order-normal");
   489		force_reverse = of_property_read_bool(np, "marvell,force-mdi-order-reverse");
   490	
   491		if (force_normal && force_reverse)
   492			return -EINVAL;
   493	
   494		if (force_normal)
   495			return phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, PMAPMD_RSVD_VEND_PROV,
   496					      PMAPMD_RSVD_VEND_PROV_MDI_CONF,
   497					      PMAPMD_RSVD_VEND_PROV_MDI_FORCE);
   498	
   499		if (force_reverse)
   500			return phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, PMAPMD_RSVD_VEND_PROV,
   501					      PMAPMD_RSVD_VEND_PROV_MDI_CONF,
   502					      PMAPMD_RSVD_VEND_PROV_MDI_REVERSE |
   503					      PMAPMD_RSVD_VEND_PROV_MDI_FORCE);
   504	
   505		return 0;
   506	}
   507	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

