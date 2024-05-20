Return-Path: <netdev+bounces-97198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06398C9E3D
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 15:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D741F2170B
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3047136648;
	Mon, 20 May 2024 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IOp6znxw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404936D1A3;
	Mon, 20 May 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716212052; cv=none; b=upickSyXgqlG74USX3ISyyJNJeuNrIXAH4cntkHgNIbQ3epVjg54NJOyvjmBotXW5X23PjFW9boo4SR5yQvR4cV9PlCMAR5+GV46dWQAsV19Aiftz57994BluqBoo40EV6u8WSqKwikzxhJiqrAMj0hlsmsXVaRo+E6bDTSy92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716212052; c=relaxed/simple;
	bh=6l89WwTl0d561bLjFwzCLWKm7Dw0Thg6kC5YSizBDTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6jKV4JBztE4tQ9jH5TikxQ2St4IpgFTUfiekfmV1T382yEVtCWN7+ou6v/0bVaw69B2qhIEFK0GQHJxrZGUgEn6VhSTaqBjuCJ+2AqWpgVxHTnvKaTRWqulWa702tFoJyvEzwUfIrJwwZ6igbWooaZS5mdYeapDVlHbgZKlNCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IOp6znxw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7MTkFW5EKW6VtXAQK1YmzVyloY2FLZZSBaVZDYaOtOU=; b=IOp6znxwuh16I4+DNrVElh1uf3
	LQPxTYVNYVj4WuzeoZdhZj+T+Gk58XMxXkoBlL6vFSdxP0Ry9C+M7xeZI21ZO79kC7fSlSZO75pSe
	CUQ4ue2/ndyXxKlu/QhFa2rSXY4PeMxY5Hu06Ef5cqyou1EzKucmfXKbpIjphqf/0uwM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s939F-00FhPN-Bj; Mon, 20 May 2024 15:33:53 +0200
Date: Mon, 20 May 2024 15:33:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v3 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <62b19955-23b8-4cd1-b09c-68546f612b44@lunn.ch>
References: <20240520113456.21675-1-SkyLake.Huang@mediatek.com>
 <20240520113456.21675-6-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520113456.21675-6-SkyLake.Huang@mediatek.com>

> +static int mt798x_2p5ge_phy_config_init(struct phy_device *phydev)
> +{
> +	struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
> +	struct device *dev = &phydev->mdio.dev;
> +	const struct firmware *fw;
> +	struct pinctrl *pinctrl;
> +	int ret, i;
> +	u16 reg;
> +
> +	if (!priv->fw_loaded) {
> +		if (!priv->md32_en_cfg_base || !priv->pmb_addr) {
> +			dev_err(dev, "MD32_EN_CFG base & PMB addresses aren't valid\n");
> +			return -EINVAL;
> +		}
> +

https://www.kernel.org/doc/html/latest/process/coding-style.html

  6) Functions

  Functions should be short and sweet, and do just one thing. They
  should fit on one or two screenfuls of text (the ISO/ANSI screen
  size is 80x24, as we all know), and do one thing and do that well.

This is a big function, which does multiple things. Maybe pull the
downloading of firmware into a helper.

> +		ret = request_firmware(&fw, MT7988_2P5GE_PMB, dev);
> +		if (ret) {
> +			dev_err(dev, "failed to load firmware: %s, ret: %d\n",
> +				MT7988_2P5GE_PMB, ret);
> +			return ret;
> +		}
> +
> +		if (fw->size != MT7988_2P5GE_PMB_SIZE) {
> +			dev_err(dev, "Firmware size 0x%zx != 0x%x\n",
> +				fw->size, MT7988_2P5GE_PMB_SIZE);
> +			return -EINVAL;
> +		}
> +
> +		reg = readw(priv->md32_en_cfg_base);
> +		if (reg & MD32_EN) {
> +			phy_set_bits(phydev, MII_BMCR, BMCR_RESET);
> +			usleep_range(10000, 11000);
> +		}
> +		phy_set_bits(phydev, MII_BMCR, BMCR_PDOWN);
> +
> +		/* Write magic number to safely stall MCU */
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x800e, 0x1100);
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x800f, 0x00df);
> +
> +		for (i = 0; i < MT7988_2P5GE_PMB_SIZE - 1; i += 4)
> +			writel(*((uint32_t *)(fw->data + i)), priv->pmb_addr + i);
> +		release_firmware(fw);
> +
> +		writew(reg & ~MD32_EN, priv->md32_en_cfg_base);
> +		writew(reg | MD32_EN, priv->md32_en_cfg_base);
> +		phy_set_bits(phydev, MII_BMCR, BMCR_RESET);
> +		/* We need a delay here to stabilize initialization of MCU */
> +		usleep_range(7000, 8000);
> +		dev_info(dev, "Firmware loading/trigger ok.\n");
> +
> +		priv->fw_loaded = true;

So there is no way to know if this has already happened? Maybe the
bootloader downloaded the firmware so it could TFTP boot? Linux will
download the firmware again, which is a waste of time.

> +		iounmap(priv->md32_en_cfg_base);
> +		iounmap(priv->pmb_addr);
> +	}
> +
> +	/* Setup LED */
> +	phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED0_ON_CTRL,
> +			 MTK_PHY_LED_ON_POLARITY | MTK_PHY_LED_ON_LINK10 |
> +			 MTK_PHY_LED_ON_LINK100 | MTK_PHY_LED_ON_LINK1000 |
> +			 MTK_PHY_LED_ON_LINK2500);
> +	phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED1_ON_CTRL,
> +			 MTK_PHY_LED_ON_FDX | MTK_PHY_LED_ON_HDX);
> +
> +	pinctrl = devm_pinctrl_get_select(&phydev->mdio.dev, "i2p5gbe-led");

Calls to devm_pinctrl_get_select() is pretty unusual in drivers:

https://elixir.bootlin.com/linux/latest/C/ident/devm_pinctrl_get_select

Why is this needed? Generally, the DT file should describe the needed
pinmux setting, without needed anything additionally.

> +static int mt798x_2p5ge_phy_get_features(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = genphy_c45_pma_read_abilities(phydev);
> +	if (ret)
> +		return ret;
> +
> +	/* We don't support HDX at MAC layer on mt7988. So mask phy's HDX capabilities here. */

So you make it clear, the MAC does not support half duplex. The MAC
should then remove it, not the PHY.

> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, phydev->supported);
> +
> +	return 0;
> +}
> +
> +static int mt798x_2p5ge_phy_read_status(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	/* When MDIO_STAT1_LSTATUS is raised genphy_c45_read_link(), this phy actually
> +	 * hasn't finished AN. So use CL22's link update function instead.
> +	 */
> +	ret = genphy_update_link(phydev);
> +	if (ret)
> +		return ret;
> +
> +	phydev->speed = SPEED_UNKNOWN;
> +	phydev->duplex = DUPLEX_UNKNOWN;
> +	phydev->pause = 0;
> +	phydev->asym_pause = 0;
> +
> +	/* We'll read link speed through vendor specific registers down below. So remove
> +	 * phy_resolve_aneg_linkmode (AN on) & genphy_c45_read_pma (AN off).
> +	 */
> +	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
> +		ret = genphy_c45_read_lpa(phydev);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Clause 45 doesn't define 1000BaseT support. Read the link partner's 1G
> +		 * advertisement via Clause 22
> +		 */
> +		ret = phy_read(phydev, MII_STAT1000);
> +		if (ret < 0)
> +			return ret;
> +		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, ret);
> +	} else if (phydev->autoneg == AUTONEG_DISABLE) {
> +		return -EOPNOTSUPP;
> +	}

It is a bit late doing this now. The user requested this a long time
ago, and it will be hard to understand why it now returns EOPNOTSUPP.
You should check for AUTONEG_DISABLE in config_aneg() and return the
error there.

      Andrew

