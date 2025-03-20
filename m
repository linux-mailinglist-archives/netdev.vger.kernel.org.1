Return-Path: <netdev+bounces-176367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4C2A69DCA
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 02:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2D31899619
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 01:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E6A1D435F;
	Thu, 20 Mar 2025 01:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SGpI18+q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501F1B81DC;
	Thu, 20 Mar 2025 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742435719; cv=none; b=DwKyL3tEzi+2J220jdWExncKdi/+zSkOiLJhdewNQCpcXRwI6KoNeVoncYWiLUZhbzPUS+uq0a0aCQMnYdT8tlyOHGNeBblhB3Tj6U1q7AkCS1pkbvl8j1tb5Vq8PasH9YltDet3aXrz/iptIjYFuZtPaA+JLZRc8mGA2pvS8CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742435719; c=relaxed/simple;
	bh=bhkj2LY+NFVBJwqfQ11YjE5f4cXbFEAgE+iqrONhw3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEIfPei02rDpE0uFfkDEo9kCmvJI5CO73JuLYW4mXYLluyuMeGUHy/7ay9RsZw85KPnWZ80+ykwInt2JBZrn1SvCpDzbKVV37aoZQHsgFP1cK9EI2p7JM5ZBeye/Sh8rjrgvSSUY9toZ9ieM1rnSeRaNuXyQ0lHmXyi3fe53GXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SGpI18+q; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742435716; x=1773971716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bhkj2LY+NFVBJwqfQ11YjE5f4cXbFEAgE+iqrONhw3w=;
  b=SGpI18+qhj4Jgor13fvqstf3AWztJS/HT2Ivl99pmBYJ8ldlHbDfi8y/
   xTraiHTjjTp9F0RgLSnGzXTTA2AFkRLd80jpja/IcvwgNKzde5WOxwWgd
   pstfkEzYyRQT47NYv6XJu8vp1L/Ainbat3Bt3WIDugK6u4ZtTjgvgL3Dc
   0qSRO317zoCO6lPEYKON+/C82CXUKAtz99GyqmNlSi8Mra1p7j3wltK1k
   H+pJbS8b/oRw7oBV33sy99WONQwJ580qrPpPAstMxthD4Mjz6WOjZKnzt
   NEX8z6f100Z08IuMNLl5/aqhzI8UAbxd+28A+Y86l3ECU5kohJXWX68WH
   Q==;
X-CSE-ConnectionGUID: DNGhSbz9RxqsQ23LtKJVQA==
X-CSE-MsgGUID: pEIhymEGR+uPLZ95jVGiRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43665301"
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="43665301"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 18:55:15 -0700
X-CSE-ConnectionGUID: tZO+WAlaRcScjbsPOBPWaA==
X-CSE-MsgGUID: JGReu0G3Q+SI0MZqGMcJfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="127967853"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 19 Mar 2025 18:55:10 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tv57k-00005b-2W;
	Thu, 20 Mar 2025 01:55:08 +0000
Date: Thu, 20 Mar 2025 09:54:10 +0800
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
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@airoha.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [net-next PATCH 5/6] net: pcs: airoha: add PCS driver for Airoha
 SoC
Message-ID: <202503200928.j6AEMrdf-lkp@intel.com>
References: <20250318235850.6411-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318235850.6411-6-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-phylink-reset-PCS-Phylink-double-reference-on-phylink_stop/20250319-080303
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250318235850.6411-6-ansuelsmth%40gmail.com
patch subject: [net-next PATCH 5/6] net: pcs: airoha: add PCS driver for Airoha SoC
config: arm64-randconfig-r132-20250320 (https://download.01.org/0day-ci/archive/20250320/202503200928.j6AEMrdf-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 87916f8c32ebd8e284091db9b70339df57fd1e90)
reproduce: (https://download.01.org/0day-ci/archive/20250320/202503200928.j6AEMrdf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503200928.j6AEMrdf-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/pcs/pcs-airoha.c:2723:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *base @@     got void [noderef] __iomem * @@
   drivers/net/pcs/pcs-airoha.c:2723:14: sparse:     expected void *base
   drivers/net/pcs/pcs-airoha.c:2723:14: sparse:     got void [noderef] __iomem *
>> drivers/net/pcs/pcs-airoha.c:2728:25: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *regs @@     got void *base @@
   drivers/net/pcs/pcs-airoha.c:2728:25: sparse:     expected void [noderef] __iomem *regs
   drivers/net/pcs/pcs-airoha.c:2728:25: sparse:     got void *base
   drivers/net/pcs/pcs-airoha.c:2732:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *base @@     got void [noderef] __iomem * @@
   drivers/net/pcs/pcs-airoha.c:2732:14: sparse:     expected void *base
   drivers/net/pcs/pcs-airoha.c:2732:14: sparse:     got void [noderef] __iomem *
   drivers/net/pcs/pcs-airoha.c:2737:27: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *regs @@     got void *base @@
   drivers/net/pcs/pcs-airoha.c:2737:27: sparse:     expected void [noderef] __iomem *regs
   drivers/net/pcs/pcs-airoha.c:2737:27: sparse:     got void *base
   drivers/net/pcs/pcs-airoha.c:2741:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *base @@     got void [noderef] __iomem * @@
   drivers/net/pcs/pcs-airoha.c:2741:14: sparse:     expected void *base
   drivers/net/pcs/pcs-airoha.c:2741:14: sparse:     got void [noderef] __iomem *
   drivers/net/pcs/pcs-airoha.c:2746:28: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *regs @@     got void *base @@
   drivers/net/pcs/pcs-airoha.c:2746:28: sparse:     expected void [noderef] __iomem *regs
   drivers/net/pcs/pcs-airoha.c:2746:28: sparse:     got void *base
   drivers/net/pcs/pcs-airoha.c:2750:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *base @@     got void [noderef] __iomem * @@
   drivers/net/pcs/pcs-airoha.c:2750:14: sparse:     expected void *base
   drivers/net/pcs/pcs-airoha.c:2750:14: sparse:     got void [noderef] __iomem *
   drivers/net/pcs/pcs-airoha.c:2755:33: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *regs @@     got void *base @@
   drivers/net/pcs/pcs-airoha.c:2755:33: sparse:     expected void [noderef] __iomem *regs
   drivers/net/pcs/pcs-airoha.c:2755:33: sparse:     got void *base
   drivers/net/pcs/pcs-airoha.c:2759:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *base @@     got void [noderef] __iomem * @@
   drivers/net/pcs/pcs-airoha.c:2759:14: sparse:     expected void *base
   drivers/net/pcs/pcs-airoha.c:2759:14: sparse:     got void [noderef] __iomem *
   drivers/net/pcs/pcs-airoha.c:2764:29: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *regs @@     got void *base @@
   drivers/net/pcs/pcs-airoha.c:2764:29: sparse:     expected void [noderef] __iomem *regs
   drivers/net/pcs/pcs-airoha.c:2764:29: sparse:     got void *base
   drivers/net/pcs/pcs-airoha.c:2768:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *base @@     got void [noderef] __iomem * @@
   drivers/net/pcs/pcs-airoha.c:2768:14: sparse:     expected void *base
   drivers/net/pcs/pcs-airoha.c:2768:14: sparse:     got void [noderef] __iomem *
   drivers/net/pcs/pcs-airoha.c:2773:29: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *regs @@     got void *base @@
   drivers/net/pcs/pcs-airoha.c:2773:29: sparse:     expected void [noderef] __iomem *regs
   drivers/net/pcs/pcs-airoha.c:2773:29: sparse:     got void *base
   drivers/net/pcs/pcs-airoha.c:2777:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *base @@     got void [noderef] __iomem * @@
   drivers/net/pcs/pcs-airoha.c:2777:14: sparse:     expected void *base
   drivers/net/pcs/pcs-airoha.c:2777:14: sparse:     got void [noderef] __iomem *
   drivers/net/pcs/pcs-airoha.c:2782:25: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *regs @@     got void *base @@
   drivers/net/pcs/pcs-airoha.c:2782:25: sparse:     expected void [noderef] __iomem *regs
   drivers/net/pcs/pcs-airoha.c:2782:25: sparse:     got void *base
   drivers/net/pcs/pcs-airoha.c:2786:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *base @@     got void [noderef] __iomem * @@
   drivers/net/pcs/pcs-airoha.c:2786:14: sparse:     expected void *base
   drivers/net/pcs/pcs-airoha.c:2786:14: sparse:     got void [noderef] __iomem *
   drivers/net/pcs/pcs-airoha.c:2791:25: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *regs @@     got void *base @@
   drivers/net/pcs/pcs-airoha.c:2791:25: sparse:     expected void [noderef] __iomem *regs
   drivers/net/pcs/pcs-airoha.c:2791:25: sparse:     got void *base

vim +2723 drivers/net/pcs/pcs-airoha.c

  2707	
  2708	static int airoha_pcs_probe(struct platform_device *pdev)
  2709	{
  2710		struct regmap_config syscon_config = airoha_pcs_regmap_config;
  2711		struct device *dev = &pdev->dev;
  2712		struct airoha_pcs_priv *priv;
  2713		void *base;
  2714		int ret;
  2715	
  2716		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
  2717		if (!priv)
  2718			return -ENOMEM;
  2719	
  2720		priv->dev = dev;
  2721		priv->data = of_device_get_match_data(dev);
  2722	
> 2723		base = devm_platform_ioremap_resource_byname(pdev, "xfi_mac");
  2724		if (IS_ERR(base))
  2725			return PTR_ERR(base);
  2726	
  2727		syscon_config.name = "xfi_mac";
> 2728		priv->xfi_mac = devm_regmap_init_mmio(dev, base, &syscon_config);
  2729		if (IS_ERR(priv->xfi_mac))
  2730			return PTR_ERR(priv->xfi_mac);
  2731	
  2732		base = devm_platform_ioremap_resource_byname(pdev, "hsgmii_an");
  2733		if (IS_ERR(base))
  2734			return PTR_ERR(base);
  2735	
  2736		syscon_config.name = "hsgmii_an";
  2737		priv->hsgmii_an = devm_regmap_init_mmio(dev, base, &syscon_config);
  2738		if (IS_ERR(priv->hsgmii_an))
  2739			return PTR_ERR(priv->hsgmii_an);
  2740	
  2741		base = devm_platform_ioremap_resource_byname(pdev, "hsgmii_pcs");
  2742		if (IS_ERR(base))
  2743			return PTR_ERR(base);
  2744	
  2745		syscon_config.name = "hsgmii_pcs";
  2746		priv->hsgmii_pcs = devm_regmap_init_mmio(dev, base, &syscon_config);
  2747		if (IS_ERR(priv->hsgmii_pcs))
  2748			return PTR_ERR(priv->hsgmii_pcs);
  2749	
  2750		base = devm_platform_ioremap_resource_byname(pdev, "hsgmii_rate_adp");
  2751		if (IS_ERR(base))
  2752			return PTR_ERR(base);
  2753	
  2754		syscon_config.name = "hsgmii_rate_adp";
  2755		priv->hsgmii_rate_adp = devm_regmap_init_mmio(dev, base, &syscon_config);
  2756		if (IS_ERR(priv->hsgmii_rate_adp))
  2757			return PTR_ERR(priv->hsgmii_rate_adp);
  2758	
  2759		base = devm_platform_ioremap_resource_byname(pdev, "multi_sgmii");
  2760		if (IS_ERR(base))
  2761			return PTR_ERR(base);
  2762	
  2763		syscon_config.name = "multi_sgmii";
  2764		priv->multi_sgmii = devm_regmap_init_mmio(dev, base, &syscon_config);
  2765		if (IS_ERR(priv->multi_sgmii))
  2766			return PTR_ERR(priv->multi_sgmii);
  2767	
  2768		base = devm_platform_ioremap_resource_byname(pdev, "usxgmii");
  2769		if (IS_ERR(base) && PTR_ERR(base) != -ENOENT)
  2770			return PTR_ERR(base);
  2771	
  2772		syscon_config.name = "usxgmii";
  2773		priv->usxgmii_pcs = devm_regmap_init_mmio(dev, base, &syscon_config);
  2774		if (IS_ERR(priv->usxgmii_pcs))
  2775			return PTR_ERR(priv->usxgmii_pcs);
  2776	
  2777		base = devm_platform_ioremap_resource_byname(pdev, "xfi_pma");
  2778		if (IS_ERR(base) && PTR_ERR(base) != -ENOENT)
  2779			return PTR_ERR(base);
  2780	
  2781		syscon_config.name = "xfi_pma";
  2782		priv->xfi_pma = devm_regmap_init_mmio(dev, base, &syscon_config);
  2783		if (IS_ERR(priv->xfi_pma))
  2784			return PTR_ERR(priv->xfi_pma);
  2785	
  2786		base = devm_platform_ioremap_resource_byname(pdev, "xfi_ana");
  2787		if (IS_ERR(base) && PTR_ERR(base) != -ENOENT)
  2788			return PTR_ERR(base);
  2789	
  2790		syscon_config.name = "xfi_ana";
  2791		priv->xfi_ana = devm_regmap_init_mmio(dev, base, &syscon_config);
  2792		if (IS_ERR(priv->xfi_ana))
  2793			return PTR_ERR(priv->xfi_ana);
  2794	
  2795		/* SCU is used to toggle XFI or HSGMII in global SoC registers */
  2796		priv->scu = syscon_regmap_lookup_by_compatible("airoha,en7581-scu");
  2797		if (IS_ERR(priv->scu))
  2798			return PTR_ERR(priv->scu);
  2799	
  2800		priv->rsts[0].id = "mac";
  2801		priv->rsts[1].id = "phy";
  2802		ret = devm_reset_control_bulk_get_exclusive(dev, ARRAY_SIZE(priv->rsts),
  2803							    priv->rsts);
  2804		if (ret)
  2805			return dev_err_probe(dev, ret, "failed to get bulk reset lines\n");
  2806	
  2807		platform_set_drvdata(pdev, priv);
  2808	
  2809		priv->pcs.ops = &airoha_pcs_ops;
  2810		priv->pcs.poll = true;
  2811	
  2812		__set_bit(PHY_INTERFACE_MODE_SGMII, priv->pcs.supported_interfaces);
  2813		__set_bit(PHY_INTERFACE_MODE_1000BASEX, priv->pcs.supported_interfaces);
  2814		__set_bit(PHY_INTERFACE_MODE_2500BASEX, priv->pcs.supported_interfaces);
  2815		__set_bit(PHY_INTERFACE_MODE_10GBASER, priv->pcs.supported_interfaces);
  2816		__set_bit(PHY_INTERFACE_MODE_USXGMII, priv->pcs.supported_interfaces);
  2817	
  2818		return of_pcs_add_provider(dev->of_node, of_pcs_simple_get,
  2819					   &priv->pcs);
  2820	}
  2821	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

