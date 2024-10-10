Return-Path: <netdev+bounces-134318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EA8998D7B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 18:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A988CB3365C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57AB1CCEDF;
	Thu, 10 Oct 2024 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2mmwB5X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907621CCB2E;
	Thu, 10 Oct 2024 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574763; cv=none; b=at8SGK+Ge4l2CdaeGzC/ZRzrxC0uDWOcgdDb3TSZe93+fYCUd1x2guKnwUD6dke0NK0TNFfxrTXJJeMaxMLqPfq26pngR8XJVmbhdqJIu1BTQDfwc5avgX/VUX26fsaoFiJANRcrqxMzIbn77q89w+2U4fqR5ZmfjRl/C7d0GsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574763; c=relaxed/simple;
	bh=OKZM64W2/1goUfn9zpZk+nrafJl+gGzMnyjh3GoRC7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5Bb2COs79OiV80n1L2Vy51i/TTrR7DFRIfPdjEc9PXEYtbb/yFTfDR8BZxoSDl3J8BXsHNP7AzzaJIS2CKBjKWLXXcev/IsBbhqjVitJgbSiM/TOEFQ+RIp2O/oAAk5D0Q7LJ4JdkrMle5C3SJXA0D1pb3yOFflvlNNuzWABco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L2mmwB5X; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728574762; x=1760110762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OKZM64W2/1goUfn9zpZk+nrafJl+gGzMnyjh3GoRC7Q=;
  b=L2mmwB5XAHT8FXs/oVTyK79unVybIdMQE2V4hqOTYONvbSbTwNYrTBPC
   851Hfc8pt7EPQCokopwqL2TYzDjQXqEylvGHlrCxuX9uwdrOTH3tAYNpu
   wV20rDJYTjhe9G0fVJ6jfsZQp0ZXjmDH9qL2S5bFmzwlMVsiTY590YCQd
   UCXQGidLQFfLcU030pjtW+yo98hGYW6TJX8TV/ABRRJEkxr65N63iybaq
   6qwQYTj4fhob9vckSGsq96ngbNEFAzzkeBM03QcPv2DLja1llZ7xmF7Hs
   euj3MV0B6Vkgu/VpIyHbCBNxZWqN8a507dnwOXdCYGq4mG/2EnENsfyJ4
   Q==;
X-CSE-ConnectionGUID: zLiurKvyTcqn1Ty1sfnnTQ==
X-CSE-MsgGUID: vs764LOiQHW5gIqIYIYn+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31736772"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31736772"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:39:21 -0700
X-CSE-ConnectionGUID: pfr2fdPsTgiJOjd3/2PF8Q==
X-CSE-MsgGUID: x3yuQj0aSsa6TZ/FIAjH5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81637488"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 10 Oct 2024 08:39:18 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syvFz-000AwT-2N;
	Thu, 10 Oct 2024 15:39:15 +0000
Date: Thu, 10 Oct 2024 23:38:55 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: intel-xway: add support for PHY LEDs
Message-ID: <202410102342.H7m4WFQ5-lkp@intel.com>
References: <c1358e27e3fea346600369bb5d9195e6ccfbcf50.1728440758.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1358e27e3fea346600369bb5d9195e6ccfbcf50.1728440758.git.daniel@makrotopia.org>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/net-phy-intel-xway-add-support-for-PHY-LEDs/20241009-103036
base:   net-next/main
patch link:    https://lore.kernel.org/r/c1358e27e3fea346600369bb5d9195e6ccfbcf50.1728440758.git.daniel%40makrotopia.org
patch subject: [PATCH net-next] net: phy: intel-xway: add support for PHY LEDs
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20241010/202410102342.H7m4WFQ5-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 70e0a7e7e6a8541bcc46908c592eed561850e416)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241010/202410102342.H7m4WFQ5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410102342.H7m4WFQ5-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/phy/intel-xway.c:7:
   In file included from include/linux/mdio.h:9:
   In file included from include/uapi/linux/mdio.h:15:
   In file included from include/linux/mii.h:13:
   In file included from include/linux/linkmode.h:5:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/net/phy/intel-xway.c:7:
   In file included from include/linux/mdio.h:9:
   In file included from include/uapi/linux/mdio.h:15:
   In file included from include/linux/mii.h:13:
   In file included from include/linux/linkmode.h:5:
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
   In file included from drivers/net/phy/intel-xway.c:7:
   In file included from include/linux/mdio.h:9:
   In file included from include/uapi/linux/mdio.h:15:
   In file included from include/linux/mii.h:13:
   In file included from include/linux/linkmode.h:5:
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
   In file included from drivers/net/phy/intel-xway.c:7:
   In file included from include/linux/mdio.h:9:
   In file included from include/uapi/linux/mdio.h:15:
   In file included from include/linux/mii.h:13:
   In file included from include/linux/linkmode.h:5:
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
>> drivers/net/phy/intel-xway.c:518:8: error: use of undeclared identifier 'PHY_LED_ACTIVE_HIGH'; did you mean 'PHY_LED_ACTIVE_LOW'?
     518 |                 case PHY_LED_ACTIVE_HIGH:
         |                      ^~~~~~~~~~~~~~~~~~~
         |                      PHY_LED_ACTIVE_LOW
   include/linux/phy.h:880:2: note: 'PHY_LED_ACTIVE_LOW' declared here
     880 |         PHY_LED_ACTIVE_LOW = 0,
         |         ^
>> drivers/net/phy/intel-xway.c:518:8: error: duplicate case value 'PHY_LED_ACTIVE_LOW'
     518 |                 case PHY_LED_ACTIVE_HIGH:
         |                      ^
   drivers/net/phy/intel-xway.c:515:8: note: previous case defined here
     515 |                 case PHY_LED_ACTIVE_LOW:
         |                      ^
   7 warnings and 2 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +518 drivers/net/phy/intel-xway.c

   503	
   504	static int xway_gphy_led_polarity_set(struct phy_device *phydev, int index,
   505					      unsigned long modes)
   506	{
   507		bool active_low = false;
   508		u32 mode;
   509	
   510		if (index >= XWAY_GPHY_MAX_LEDS)
   511			return -EINVAL;
   512	
   513		for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
   514			switch (mode) {
   515			case PHY_LED_ACTIVE_LOW:
   516				active_low = true;
   517				break;
 > 518			case PHY_LED_ACTIVE_HIGH:
   519				break;
   520			default:
   521				return -EINVAL;
   522			}
   523		}
   524	
   525		return phy_modify(phydev, XWAY_MDIO_LED, XWAY_GPHY_LED_INV(index),
   526				  active_low ? XWAY_GPHY_LED_INV(index) : 0);
   527	}
   528	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

