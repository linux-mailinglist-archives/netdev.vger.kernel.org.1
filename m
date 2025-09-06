Return-Path: <netdev+bounces-220626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 440D1B4775E
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 23:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 443E27B2542
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 21:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149052957CD;
	Sat,  6 Sep 2025 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5TTURoZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FFC20296A;
	Sat,  6 Sep 2025 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757193395; cv=none; b=Wd/cTKL+f6ANb0Icp1fz9XCxakad0W4lvKyJsukXqd6gKtf/g9kXTiXO61n9zlzQ2o+dXJkuepm0i9fHm2BP/A3+xbSjyiZGkSCftsCLaKQlpDx2QtSgZGQOjOpbf04yCjN+FiEaF2yOIgMhKrHcFcwBAlUl7KjJLG/uEWyjJ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757193395; c=relaxed/simple;
	bh=rBLI7ukQHDWS6AwQcN6I5VytRlnwi7WAZKTS9iyO0tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjm33u0E88Fj241AfyoGE4/OHJ1IL9QNlzzTvzdWeWOdNNdfIKHH9RHcwMjuIJU4zH4U2ITuCZTRevZ4/z5nr9OEUqMcJa10+XBY3k0Nw6z4s4qtQXAIL7krJ2IfXgxDwxsfvdsUnSMmegOXfBfM2lKLF6YMlPnpiMT8iXvypfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5TTURoZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757193393; x=1788729393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rBLI7ukQHDWS6AwQcN6I5VytRlnwi7WAZKTS9iyO0tI=;
  b=I5TTURoZvLRKKRS2lsIxbGqi0qVvUGVa0Dbi2cuywtDE7okj0lq2stJ3
   ZRg8kHId1s0YJ6vDMZ8zcA1vL9kgH90vZg3pWLF2YMVfBrutWR9d9pex5
   H3SF0n1Xwgf8nEYpihJ/tT+Qeysi6TvaE3xm1tn9CBK6iTd/j9rSBej+0
   xCEAbAIO9C7rFBfIjk3BgwKQM8xSdnFQq8/5LvCPvsP4zXUZV55czu7u0
   cwsOpynD2tDPWlFnf3YiaqKUV/9mGkNpDMR5HGAFBTcsvqcQoTaeGryca
   vrYR6L5HI60EMV1Q1yPSlS2+Gg17n2KTy1WKeN2wAQWe1CHM0FB+2gyoO
   A==;
X-CSE-ConnectionGUID: opL1HxJ2SrSjf9Dp6Mb97w==
X-CSE-MsgGUID: jZJZoyUMQfSeD58uBOMCMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="62131850"
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="62131850"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 14:16:31 -0700
X-CSE-ConnectionGUID: m/SS9zIhS4m6vaHeaN13bg==
X-CSE-MsgGUID: iPkamp7WRvKSUK+pal2eOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="172366458"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 06 Sep 2025 14:16:27 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uv0Gm-0001nX-2E;
	Sat, 06 Sep 2025 21:16:24 +0000
Date: Sun, 7 Sep 2025 05:15:57 +0800
From: kernel test robot <lkp@intel.com>
To: Chen-Yu Tsai <wens@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH net-next v3 02/10] net: stmmac: Add support for Allwinner
 A523 GMAC200
Message-ID: <202509070456.CKA8CXUt-lkp@intel.com>
References: <20250906041333.642483-3-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906041333.642483-3-wens@kernel.org>

Hi Chen-Yu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Yu-Tsai/dt-bindings-net-sun8i-emac-Add-A523-GMAC200-compatible/20250906-121610
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250906041333.642483-3-wens%40kernel.org
patch subject: [PATCH net-next v3 02/10] net: stmmac: Add support for Allwinner A523 GMAC200
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20250907/202509070456.CKA8CXUt-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250907/202509070456.CKA8CXUt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509070456.CKA8CXUt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c: In function 'sun55i_gmac200_set_syscon':
>> drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c:60:89: warning: format '%d' expects argument of type 'int', but argument 5 has type 'long unsigned int' [-Wformat=]
      60 |                                              "TX clock delay exceeds maximum (%d00ps > %d00ps)\n",
         |                                                                                        ~^
         |                                                                                         |
         |                                                                                         int
         |                                                                                        %ld
   drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c:74:89: warning: format '%d' expects argument of type 'int', but argument 5 has type 'long unsigned int' [-Wformat=]
      74 |                                              "RX clock delay exceeds maximum (%d00ps > %d00ps)\n",
         |                                                                                        ~^
         |                                                                                         |
         |                                                                                         int
         |                                                                                        %ld


vim +60 drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c

    39	
    40	static int sun55i_gmac200_set_syscon(struct device *dev,
    41					     struct plat_stmmacenet_data *plat)
    42	{
    43		struct device_node *node = dev->of_node;
    44		struct regmap *regmap;
    45		u32 val, reg = 0;
    46		int ret;
    47	
    48		regmap = syscon_regmap_lookup_by_phandle(node, "syscon");
    49		if (IS_ERR(regmap))
    50			return dev_err_probe(dev, PTR_ERR(regmap), "Unable to map syscon\n");
    51	
    52		if (!of_property_read_u32(node, "tx-internal-delay-ps", &val)) {
    53			if (val % 100)
    54				return dev_err_probe(dev, -EINVAL,
    55						     "tx-delay must be a multiple of 100ps\n");
    56			val /= 100;
    57			dev_dbg(dev, "set tx-delay to %x\n", val);
    58			if (!FIELD_FIT(SYSCON_ETXDC_MASK, val))
    59				return dev_err_probe(dev, -EINVAL,
  > 60						     "TX clock delay exceeds maximum (%d00ps > %d00ps)\n",
    61						     val, FIELD_MAX(SYSCON_ETXDC_MASK));
    62	
    63			reg |= FIELD_PREP(SYSCON_ETXDC_MASK, val);
    64		}
    65	
    66		if (!of_property_read_u32(node, "rx-internal-delay-ps", &val)) {
    67			if (val % 100)
    68				return dev_err_probe(dev, -EINVAL,
    69						     "rx-delay must be a multiple of 100ps\n");
    70			val /= 100;
    71			dev_dbg(dev, "set rx-delay to %x\n", val);
    72			if (!FIELD_FIT(SYSCON_ERXDC_MASK, val))
    73				return dev_err_probe(dev, -EINVAL,
    74						     "RX clock delay exceeds maximum (%d00ps > %d00ps)\n",
    75						     val, FIELD_MAX(SYSCON_ERXDC_MASK));
    76	
    77			reg |= FIELD_PREP(SYSCON_ERXDC_MASK, val);
    78		}
    79	
    80		switch (plat->mac_interface) {
    81		case PHY_INTERFACE_MODE_MII:
    82			/* default */
    83			break;
    84		case PHY_INTERFACE_MODE_RGMII:
    85		case PHY_INTERFACE_MODE_RGMII_ID:
    86		case PHY_INTERFACE_MODE_RGMII_RXID:
    87		case PHY_INTERFACE_MODE_RGMII_TXID:
    88			reg |= SYSCON_EPIT | SYSCON_ETCS_INT_GMII;
    89			break;
    90		case PHY_INTERFACE_MODE_RMII:
    91			reg |= SYSCON_RMII_EN;
    92			break;
    93		default:
    94			return dev_err_probe(dev, -EINVAL, "Unsupported interface mode: %s",
    95					     phy_modes(plat->mac_interface));
    96		}
    97	
    98		ret = regmap_write(regmap, SYSCON_REG, reg);
    99		if (ret < 0)
   100			return dev_err_probe(dev, ret, "Failed to write to syscon\n");
   101	
   102		return 0;
   103	}
   104	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

