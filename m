Return-Path: <netdev+bounces-99606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E6B8D5773
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 03:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70383B21912
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134594C89;
	Fri, 31 May 2024 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXJljSms"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42DCDDA1;
	Fri, 31 May 2024 01:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717117298; cv=none; b=VjykG3u3dzgGBULg9OL/0ONvc7dRAHB4uUyul8AeQPoBqHuaSovtBEgoV1JLd8ZnesPakYNZazFkVJEvse0OO1oteh9wpo8DlXDCz414GhzYHvBvw4Btx0UPB8jYmPc4FLEcgiUyyGxR5gVKBp7CvheTFeXkQ0ROgG8tHA1lrto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717117298; c=relaxed/simple;
	bh=HxG5osaBenuaXiNqjDMl+ACscharTtPstTDjg6QkFeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGpAI/61g+5CeQRap9Cjp+4GjW/bgjNTwShEUMsrkBH8naKwyTvBrEqQHXSWlsMSXFyb4ChlvBP/X/LDJEBwnavjsKiWpWBsLZkGuNtYBPKTw2mPyKAENfuXWKwECxYkLi3y/BsH7naVuLdqDPQT+VlCFySDwLjf3xc33bl0ZpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXJljSms; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717117295; x=1748653295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HxG5osaBenuaXiNqjDMl+ACscharTtPstTDjg6QkFeI=;
  b=HXJljSms5NbtjTfUpggaCEI9DKVmu391WneFibq7j5Swv0FPSrMX4SYp
   9okuCUH9LF0l5bN9mnopZ6Lp1LWbXDcClCxb7eupaQe2rg7X8J4iGancT
   IU5rtrZ2AK4hwaNurBzwlsxweHicy3iV8Ey+ji1T5HaCjZvbIKemGhwNz
   TNJDd153Qnfn+W1TIx9w5Mdc4YWXNYi0iV/rX69KVg/r1Pn0LMhiB4M9c
   eYdTBRXvQPw1woV/oxDMl1dBZ6eWk3shzBfhPLeQ5LVRweuHhz7eU3glU
   BfBMej6pzlxjsbrO66kkmRc4jJ5CNg+CafpI2S4GJs+mbHNJss6TOkmfF
   g==;
X-CSE-ConnectionGUID: vPYL4dGAQSGh/VupBoGryg==
X-CSE-MsgGUID: ljCTFV4ETgOAn9ggHStKCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="17446392"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="17446392"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 18:01:22 -0700
X-CSE-ConnectionGUID: KTu1FWO8RuCq02JLF+MT2g==
X-CSE-MsgGUID: v97yehVvQbyvM9/AyyHfgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36041608"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 30 May 2024 18:01:17 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCqdv-000GJ1-08;
	Fri, 31 May 2024 01:01:15 +0000
Date: Fri, 31 May 2024 09:00:50 +0800
From: kernel test robot <lkp@intel.com>
To: Sky Huang <SkyLake.Huang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Steven Liu <Steven.Liu@mediatek.com>,
	"SkyLake.Huang" <skylake.huang@mediatek.com>
Subject: Re: [PATCH net-next v5 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <202405310819.c3Dv1OM3-lkp@intel.com>
References: <20240530034844.11176-6-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530034844.11176-6-SkyLake.Huang@mediatek.com>

Hi Sky,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sky-Huang/net-phy-mediatek-Re-organize-MediaTek-ethernet-phy-drivers/20240530-115522
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240530034844.11176-6-SkyLake.Huang%40mediatek.com
patch subject: [PATCH net-next v5 5/5] net: phy: add driver for built-in 2.5G ethernet PHY on MT7988
config: openrisc-randconfig-r121-20240531 (https://download.01.org/0day-ci/archive/20240531/202405310819.c3Dv1OM3-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240531/202405310819.c3Dv1OM3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405310819.c3Dv1OM3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/phy/mediatek/mtk-2p5ge.c:106:9: sparse: sparse: cast to restricted __be16

vim +106 drivers/net/phy/mediatek/mtk-2p5ge.c

    56	
    57	static int mt798x_2p5ge_phy_load_fw(struct phy_device *phydev)
    58	{
    59		struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
    60		void __iomem *md32_en_cfg_base, *pmb_addr;
    61		struct device *dev = &phydev->mdio.dev;
    62		const struct firmware *fw;
    63		int ret, i;
    64		u16 reg;
    65	
    66		if (priv->fw_loaded)
    67			return 0;
    68	
    69		pmb_addr = ioremap(MT7988_2P5GE_PMB_BASE, MT7988_2P5GE_PMB_LEN);
    70		if (!pmb_addr)
    71			return -ENOMEM;
    72		md32_en_cfg_base = ioremap(MT7988_2P5GE_MD32_EN_CFG_BASE, MT7988_2P5GE_MD32_EN_CFG_LEN);
    73		if (!md32_en_cfg_base) {
    74			ret = -ENOMEM;
    75			goto free_pmb;
    76		}
    77	
    78		ret = request_firmware(&fw, MT7988_2P5GE_PMB, dev);
    79		if (ret) {
    80			dev_err(dev, "failed to load firmware: %s, ret: %d\n",
    81				MT7988_2P5GE_PMB, ret);
    82			goto free;
    83		}
    84	
    85		if (fw->size != MT7988_2P5GE_PMB_SIZE) {
    86			dev_err(dev, "Firmware size 0x%zx != 0x%x\n",
    87				fw->size, MT7988_2P5GE_PMB_SIZE);
    88			ret = -EINVAL;
    89			goto free;
    90		}
    91	
    92		reg = readw(md32_en_cfg_base);
    93		if (reg & MD32_EN) {
    94			phy_set_bits(phydev, MII_BMCR, BMCR_RESET);
    95			usleep_range(10000, 11000);
    96		}
    97		phy_set_bits(phydev, MII_BMCR, BMCR_PDOWN);
    98	
    99		/* Write magic number to safely stall MCU */
   100		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x800e, 0x1100);
   101		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x800f, 0x00df);
   102	
   103		for (i = 0; i < MT7988_2P5GE_PMB_SIZE - 1; i += 4)
   104			writel(*((uint32_t *)(fw->data + i)), pmb_addr + i);
   105		release_firmware(fw);
 > 106		dev_info(dev, "Firmware date code: %x/%x/%x, version: %x.%x\n",
   107			 be16_to_cpu(*((uint16_t *)(fw->data + MT7988_2P5GE_PMB_SIZE - 8))),
   108			 *(fw->data + MT7988_2P5GE_PMB_SIZE - 6),
   109			 *(fw->data + MT7988_2P5GE_PMB_SIZE - 5),
   110			 *(fw->data + MT7988_2P5GE_PMB_SIZE - 2),
   111			 *(fw->data + MT7988_2P5GE_PMB_SIZE - 1));
   112	
   113		writew(reg & ~MD32_EN, md32_en_cfg_base);
   114		writew(reg | MD32_EN, md32_en_cfg_base);
   115		phy_set_bits(phydev, MII_BMCR, BMCR_RESET);
   116		/* We need a delay here to stabilize initialization of MCU */
   117		usleep_range(7000, 8000);
   118		dev_info(dev, "Firmware loading/trigger ok.\n");
   119	
   120		priv->fw_loaded = true;
   121	
   122	free:
   123		iounmap(md32_en_cfg_base);
   124	free_pmb:
   125		iounmap(pmb_addr);
   126	
   127		return ret ? ret : 0;
   128	}
   129	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

