Return-Path: <netdev+bounces-236206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A90AC39BEF
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 10:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFF134E3522
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 09:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE60530AD19;
	Thu,  6 Nov 2025 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPP5WUE+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1030ACF6
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420009; cv=none; b=PG/M1F2j7CwxgUX8adY9T5ItfHNIG18SGQL2TYwP2/xCAF8YE6Sg+NT8IVh7sKPTS80Mtt3lHGE7gpptA0TBiR44xn8QlCshxiwWNxe7e+AnPSH2l5OXYOdSsM3Uz9NvIECp+KIdzzBmMSeoy9lcRvZx5kkCYETrtpXray4bpto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420009; c=relaxed/simple;
	bh=i3D2gBal5+YbLDjTq5ytrhJTTHuFXbJwZnfo0rk6QCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApU/pbHYEXNI39F/x8IaWOGerjXGa8ej9ywksGTYr1PR1bgRyFf/V72pmAH1ZUPCAgVdSpiheiQj3b9BcrVXgjDEf3T4j9avwpNZt+RlsNT5na/bYOlSKJNe3C1fTzq6M06SMIqC/QDLfX8ONHYX+84E25cuyWXjHbGZvv9r1Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPP5WUE+; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762420008; x=1793956008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i3D2gBal5+YbLDjTq5ytrhJTTHuFXbJwZnfo0rk6QCQ=;
  b=SPP5WUE+vfBjEiPoy++ElM3TpbgziThabb5mq56MOpiDVGnCBlyIph9n
   1wZA+eeRhOGVeVsp93dbWmGi10Hv1zYbDanzG/64XImytfENEO9ugpZ4N
   5bU/tNmfiSouOPOl7FRTGoueCta1MRq7TS0J5qpQ3LhNvLu27t9rluRup
   6RlMqfDGfQ4x15FdbVBDgHuUuGkqeRFuRPpZe4qp/xajptrTVI3QL0KhH
   imaFz6jRAnyaN7w8t/5u7YNJ+t9SBmLlE558+MgGTtUxNQFOnDpUIKX13
   irTyWAkPQUjl22JlbBk758H/YTGw0g5Cu77zqLRZ8sulGkXQRiie9JFBO
   A==;
X-CSE-ConnectionGUID: xTNw6S2UQYq8cZpxZTj0+A==
X-CSE-MsgGUID: jeWns44WRSWBC8d2z5TuMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="63756658"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="63756658"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 01:06:47 -0800
X-CSE-ConnectionGUID: 2/NgE5SQQ6eOREXwCKlqMw==
X-CSE-MsgGUID: zC1S65aLSVeEoNWP8khe0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="218366584"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 06 Nov 2025 01:06:44 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGvx3-000Tha-2Z;
	Thu, 06 Nov 2025 09:06:41 +0000
Date: Thu, 6 Nov 2025 17:06:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 09/11] net: stmmac: ingenic: simplify x2000
 mac_set_mode()
Message-ID: <202511061640.PHWz6zWt-lkp@intel.com>
References: <E1vGdXJ-0000000CloA-3yVc@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vGdXJ-0000000CloA-3yVc@rmk-PC.armlinux.org.uk>

Hi Russell,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Russell-King-Oracle/net-stmmac-ingenic-move-ingenic_mac_init/20251106-015834
base:   net-next/main
patch link:    https://lore.kernel.org/r/E1vGdXJ-0000000CloA-3yVc%40rmk-PC.armlinux.org.uk
patch subject: [PATCH net-next 09/11] net: stmmac: ingenic: simplify x2000 mac_set_mode()
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20251106/202511061640.PHWz6zWt-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251106/202511061640.PHWz6zWt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511061640.PHWz6zWt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c:128:13: warning: variable 'val' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     128 |         } else if (phy_intf_sel == PHY_INTF_SEL_RGMII) {
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c:142:2: note: uninitialized use occurs here
     142 |         val |= FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
         |         ^~~
   drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c:128:9: note: remove the 'if' if its condition is always true
     128 |         } else if (phy_intf_sel == PHY_INTF_SEL_RGMII) {
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c:123:18: note: initialize the variable 'val' to silence this warning
     123 |         unsigned int val;
         |                         ^
         |                          = 0
   1 warning generated.


vim +128 drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c

   118	
   119	static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
   120				      u8 phy_intf_sel)
   121	{
   122		struct ingenic_mac *mac = plat_dat->bsp_priv;
   123		unsigned int val;
   124	
   125		if (phy_intf_sel == PHY_INTF_SEL_RMII) {
   126			val = FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN) |
   127			      FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_ORIGIN);
 > 128		} else if (phy_intf_sel == PHY_INTF_SEL_RGMII) {
   129			if (mac->tx_delay == 0)
   130				val = FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN);
   131			else
   132				val = FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_DELAY) |
   133				      FIELD_PREP(MACPHYC_TX_DELAY_MASK, (mac->tx_delay + 9750) / 19500 - 1);
   134	
   135			if (mac->rx_delay == 0)
   136				val |= FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_ORIGIN);
   137			else
   138				val |= FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_DELAY) |
   139					   FIELD_PREP(MACPHYC_RX_DELAY_MASK, (mac->rx_delay + 9750) / 19500 - 1);
   140		}
   141	
   142		val |= FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
   143	
   144		/* Update MAC PHY control register */
   145		return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
   146	}
   147	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

