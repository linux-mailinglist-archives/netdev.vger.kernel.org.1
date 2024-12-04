Return-Path: <netdev+bounces-148842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF49E9E342E
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B44BEB215B6
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B736F18C03B;
	Wed,  4 Dec 2024 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5tcKpbX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF68818A6C5;
	Wed,  4 Dec 2024 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733297869; cv=none; b=tmsfinfOKJqPotUCdoDCrNKPsXrPMgGKgVZtHCnmR1BSTqz70Khak3UZWS4A1YuP1A6EGJHK4gmWro7yR/dfbHpsdqacO+ixTE846V4tIZNWsqaZX9kJ0sz+398847qVisw+J4PRztisvFaWWzcWw6sM18Egn5b0BmhIb1xdRsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733297869; c=relaxed/simple;
	bh=ebhNcEjRwrrGcGYQzGz+ZLdeK/Qos26guvcvrZ6FEPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZ7B5k6fLbT0mmrSiOxA/tlnp7v/7LdfpHDbrbCxC9tEcaGZFbYEGABdMtw6owU/yntHOiDTY98oX72MZrqKLg4tpf779B5YAf8SzgQGtxcOr0SNQkdMgux6P3WytGBNmJY4yHvV9VgQf7X0PYEZKrvvsVI73ufmdV7TwA62Qdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5tcKpbX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733297869; x=1764833869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ebhNcEjRwrrGcGYQzGz+ZLdeK/Qos26guvcvrZ6FEPs=;
  b=d5tcKpbXZn4yjMLqPNoHSyT+3cKCnsipnD2+QZm1NXHnEsjdEy8LGpm2
   8Zi7IALO9jmaoPZciColSQvX/VUno4DqJZrVUfGuiB+D+/MuunB/f3G+j
   thUrzx39T87KUvlAiI60UNAzPIbaQLQgutnFcqfuTvWwNCQCdT+Ep53T3
   nTkrhyHiPDjdeW+oA8qyHDYoao/6cKPgQGil+J6lhbTnT3BURlh4RU2rI
   NeMOucwPTAsFL/ee6STjIgfD5RgmuJViptjh5DlDPR3HtRBgzH+yLkeqP
   bRsCL6/T5+p0mRKqucNuhAgVb9DQnYg7eH0FTqKje43qvrkHAgw3cRAI8
   Q==;
X-CSE-ConnectionGUID: CjHo4Gr0QuOUyzUMpBnrgw==
X-CSE-MsgGUID: PXwWfHYFQRKTquxDw2Sc4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44027743"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44027743"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 23:37:48 -0800
X-CSE-ConnectionGUID: CFCefRZoQlWIUldCS2TWHw==
X-CSE-MsgGUID: Rul8T89gR/ma3HOuIlGcBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="98488777"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 03 Dec 2024 23:37:44 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIjx8-0002i9-0X;
	Wed, 04 Dec 2024 07:37:42 +0000
Date: Wed, 4 Dec 2024 15:36:44 +0800
From: kernel test robot <lkp@intel.com>
To: Zhiyuan Wan <kmlinuxm@gmail.com>, andrew@lunn.ch
Cc: oe-kbuild-all@lists.linux.dev, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, willy.liu@realtek.com,
	Zhiyuan Wan <kmlinuxm@gmail.com>
Subject: Re: [PATCH net-next] net: phy: realtek: disable broadcast address
 feature of rtl8211f
Message-ID: <202412041520.hGCSOuph-lkp@intel.com>
References: <20241203125430.2078090-1-kmlinuxm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203125430.2078090-1-kmlinuxm@gmail.com>

Hi Zhiyuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhiyuan-Wan/net-phy-realtek-disable-broadcast-address-feature-of-rtl8211f/20241203-205751
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241203125430.2078090-1-kmlinuxm%40gmail.com
patch subject: [PATCH net-next] net: phy: realtek: disable broadcast address feature of rtl8211f
config: mips-ip22_defconfig (https://download.01.org/0day-ci/archive/20241204/202412041520.hGCSOuph-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041520.hGCSOuph-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412041520.hGCSOuph-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/phy/realtek.c: In function 'rtl821x_probe':
>> drivers/net/phy/realtek.c:147:51: error: passing argument 1 of 'PTR_ERR' makes pointer from integer without a cast [-Wint-conversion]
     147 |                 return dev_err_probe(dev, PTR_ERR(ret),
         |                                                   ^~~
         |                                                   |
         |                                                   int
   In file included from include/linux/kernfs.h:9,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:18,
                    from drivers/net/phy/realtek.c:11:
   include/linux/err.h:52:61: note: expected 'const void *' but argument is of type 'int'
      52 | static inline long __must_check PTR_ERR(__force const void *ptr)
         |                                                 ~~~~~~~~~~~~^~~


vim +/PTR_ERR +147 drivers/net/phy/realtek.c

   126	
   127	static int rtl821x_probe(struct phy_device *phydev)
   128	{
   129		struct device *dev = &phydev->mdio.dev;
   130		struct rtl821x_priv *priv;
   131		u32 phy_id = phydev->drv->phy_id;
   132		int ret;
   133	
   134		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
   135		if (!priv)
   136			return -ENOMEM;
   137	
   138		priv->clk = devm_clk_get_optional_enabled(dev, NULL);
   139		if (IS_ERR(priv->clk))
   140			return dev_err_probe(dev, PTR_ERR(priv->clk),
   141					     "failed to get phy clock\n");
   142	
   143		dev_dbg(dev, "disabling MDIO address 0 for this phy");
   144		ret = phy_modify_paged(phydev, 0xa43, RTL8211F_PHYCR1,
   145					       RTL8211F_PHYAD0_EN, 0);
   146		if (ret < 0) {
 > 147			return dev_err_probe(dev, PTR_ERR(ret),
   148					     "disabling MDIO address 0 failed\n");
   149		}
   150		/* Deny broadcast address as PHY address */
   151		if (phydev->mdio.addr == 0)
   152			return -ENODEV;
   153	
   154		ret = phy_read_paged(phydev, 0xa43, RTL8211F_PHYCR1);
   155		if (ret < 0)
   156			return ret;
   157	
   158		priv->phycr1 = ret & (RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF);
   159		if (of_property_read_bool(dev->of_node, "realtek,aldps-enable"))
   160			priv->phycr1 |= RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF;
   161	
   162		priv->has_phycr2 = !(phy_id == RTL_8211FVD_PHYID);
   163		if (priv->has_phycr2) {
   164			ret = phy_read_paged(phydev, 0xa43, RTL8211F_PHYCR2);
   165			if (ret < 0)
   166				return ret;
   167	
   168			priv->phycr2 = ret & RTL8211F_CLKOUT_EN;
   169			if (of_property_read_bool(dev->of_node, "realtek,clkout-disable"))
   170				priv->phycr2 &= ~RTL8211F_CLKOUT_EN;
   171		}
   172	
   173		phydev->priv = priv;
   174	
   175		return 0;
   176	}
   177	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

