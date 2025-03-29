Return-Path: <netdev+bounces-178196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E865DA75780
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 19:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B96B7A2035
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 18:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D421DE3B1;
	Sat, 29 Mar 2025 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWJiILj9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB681BF58;
	Sat, 29 Mar 2025 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743274404; cv=none; b=QLS5XxYRWIymDMr75mVPX6XZV8hmkFY4FDfMf1KLTzyAODzEXEdELZrMzuYaAQfUDmuBSnCm5+acevYbt74bbpV75f9PjA0Pz77sPY2Ls+9GLsnJPUh5hvl2wlPUBy/DQ2RE2pVM4MwHTDO+VYspbRrTBMPk+kfjiou1t/Ru8k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743274404; c=relaxed/simple;
	bh=/unm9wPXKMPXsDJfs4AAPZDeDhmCaqHAxiaM6PnHmjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+f4Pr1G22m4knm2+5MGW7ugPCPPX1Kuceuk9OlpQE6Dd5SQiXecgFFnTNYHN59zuQPVl83Mt7iS/AvPWTueAY9415zFdZDNydjqT8w4gK7vf3aH5mNcG5P9z0ibqcRDwwIbxTnsK/IoN2UzhV3B1QzkkhkyT7GagFxWiJ3+OrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWJiILj9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743274403; x=1774810403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/unm9wPXKMPXsDJfs4AAPZDeDhmCaqHAxiaM6PnHmjU=;
  b=AWJiILj9n50XIRtsT334YSqwvsFxsO7au8BP2M/U1X6y1yyRL1Jeuoru
   AHBOjt/WzYFR/cDP5lPLmBnmlOmIpAbPDobR/1Az7zGFoUyIuGqdW1kYA
   i5dHak3mX4xHBj36WV300FQ3GaJ34v/R20UHmaaU7ylhnCcaCe+0iys1B
   5jzFl9CqZ6NqkKrq3cYwjXc/4zZogZkTc/QBa90kVNg54rx2nv97BcPA6
   dMdZ2k7YXJQyfV8S3T90QvTxbx2pTne29J5H56IlAt0j6TapE4JtOX5Zq
   ARK++0QwXU2Td9/Im8K31c+/rkBlL3EC51e0P0/rRk+rf8oP6VJXGEeXw
   A==;
X-CSE-ConnectionGUID: 9ZzXevnuTg6C9+JXQGN+Lw==
X-CSE-MsgGUID: 5i873txqTbulN0zxShTN5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11388"; a="44498996"
X-IronPort-AV: E=Sophos;i="6.14,286,1736841600"; 
   d="scan'208";a="44498996"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 11:53:22 -0700
X-CSE-ConnectionGUID: Cu+QujXWRCCqGMGpip+qMg==
X-CSE-MsgGUID: dpiqVix1Qq+ihM7rXO0Jmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,286,1736841600"; 
   d="scan'208";a="148902244"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 29 Mar 2025 11:53:18 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tybHo-0008Is-1J;
	Sat, 29 Mar 2025 18:52:32 +0000
Date: Sun, 30 Mar 2025 02:51:41 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] net: phy: Add support for new Aeonsemi PHYs
Message-ID: <202503300205.g0FCozVG-lkp@intel.com>
References: <20250323225439.32400-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323225439.32400-1-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-net-Document-support-for-Aeonsemi-PHYs/20250324-065920
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250323225439.32400-1-ansuelsmth%40gmail.com
patch subject: [net-next PATCH 1/2] net: phy: Add support for new Aeonsemi PHYs
config: riscv-randconfig-r072-20250329 (https://download.01.org/0day-ci/archive/20250330/202503300205.g0FCozVG-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503300205.g0FCozVG-lkp@intel.com/

smatch warnings:
drivers/net/phy/as21xxx.c:744 as21xxx_led_hw_control_get() warn: unsigned 'val' is never less than zero.
drivers/net/phy/as21xxx.c:775 as21xxx_led_hw_control_set() error: uninitialized symbol 'val'.
drivers/net/phy/as21xxx.c:802 as21xxx_led_polarity_set() error: uninitialized symbol 'led_active_low'.

vim +/val +744 drivers/net/phy/as21xxx.c

   733	
   734	static int as21xxx_led_hw_control_get(struct phy_device *phydev, u8 index,
   735					      unsigned long *rules)
   736	{
   737		u16 val;
   738		int i;
   739	
   740		if (index > AEON_MAX_LDES)
   741			return -EINVAL;
   742	
   743		val = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_LED_REG(index));
 > 744		if (val < 0)
   745			return val;
   746	
   747		val &= VEND1_LED_REG_A_EVENT;
   748		for (i = 0; i < ARRAY_SIZE(as21xxx_led_supported_pattern); i++)
   749			if (val == as21xxx_led_supported_pattern[i].val) {
   750				*rules = as21xxx_led_supported_pattern[i].pattern;
   751				return 0;
   752			}
   753	
   754		/* Should be impossible */
   755		return -EINVAL;
   756	}
   757	
   758	static int as21xxx_led_hw_control_set(struct phy_device *phydev, u8 index,
   759					      unsigned long rules)
   760	{
   761		u16 val;
   762		int i;
   763	
   764		if (index > AEON_MAX_LDES)
   765			return -EINVAL;
   766	
   767		for (i = 0; i < ARRAY_SIZE(as21xxx_led_supported_pattern); i++)
   768			if (rules == as21xxx_led_supported_pattern[i].pattern) {
   769				val = as21xxx_led_supported_pattern[i].val;
   770				break;
   771			}
   772	
   773		return phy_modify_mmd(phydev, MDIO_MMD_VEND1,
   774				      VEND1_LED_REG(index),
 > 775				      VEND1_LED_REG_A_EVENT, val);
   776	}
   777	
   778	static int as21xxx_led_polarity_set(struct phy_device *phydev, int index,
   779					    unsigned long modes)
   780	{
   781		bool led_active_low;
   782		u16 mask, val = 0;
   783		u32 mode;
   784	
   785		if (index > AEON_MAX_LDES)
   786			return -EINVAL;
   787	
   788		for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
   789			switch (mode) {
   790			case PHY_LED_ACTIVE_LOW:
   791				led_active_low = true;
   792				break;
   793			case PHY_LED_ACTIVE_HIGH: /* default mode */
   794				led_active_low = false;
   795				break;
   796			default:
   797				return -EINVAL;
   798			}
   799		}
   800	
   801		mask = VEND1_GLB_CPU_CTRL_LED_POLARITY(index);
 > 802		if (led_active_low)
   803			val = VEND1_GLB_CPU_CTRL_LED_POLARITY(index);
   804	
   805		return phy_modify_mmd(phydev, MDIO_MMD_VEND1,
   806				      VEND1_GLB_REG_CPU_CTRL,
   807				      mask, val);
   808	}
   809	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

