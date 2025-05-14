Return-Path: <netdev+bounces-190396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E2EAB6B25
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22664C2364
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 12:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20882749FD;
	Wed, 14 May 2025 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dRHBEV2c"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27409224AED;
	Wed, 14 May 2025 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747224829; cv=none; b=YrnF2NID5Y+gBWj/b999CNdnYiv/GmzMFq5oE2fDFKalQi5tLcFKAHQY6lehEDH8oANNTn4KSyFSjnkL82Zju326MQjhPQ/z00k7i3ncwnBbxtuwLYEzytJm+yKtNmXuhJcC7Pp6dtrqInrk1yDNDngQDzX0aMa7bcXF0IoPfZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747224829; c=relaxed/simple;
	bh=H2PRHzXAWxE9uMK6YCAjGgxQwKItUsBz6sbyztBIjFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrIVs2B0uvzZ1VassLsPMtjLRVlK8D8ULCvus5cPMC4l54scTrej1GWh/E91s+kKX/GDxqA2VG9iHPeGcrFnZYhivm3jPoH5b+e/N9Fv+sfY/36lzeEjEN+Md4eRnnqvPaV79m1mCI208jNxaJ6lk9X1fliP3Eqy4I72DAt/p6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dRHBEV2c; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+AfK7MCkRVYWu8R51rsh6Q0jzO0vpYJ7OnABWuVAlLw=; b=dRHBEV2cEqxhfNzllZyhYafO0h
	/hTgKWQXQn7JZ09jG5zYsbQMXqlUDve784VuWkNKz1emP/PBXlLZ30KvDz7bWFgoM3/oPy+uBpVjE
	SjbfghHTiSnRM3iZf+nXifEOpdp47y3xmOahwnOA12NLahY7d+IzuTzHqoV1EehTa7VfFC6xJOxpg
	9f5/xe7kkVs4jCEDy3ktJ26eYruBhzENT2hJPxPLAIG0nqxdnaDXgxzlqyZWynPyO5bcnFhP39k9r
	urtICyboVUk0OcoE3KqPl0KUsfKFhxaNuRdyERMQwWYy2ew+yYBTxFtAfJWz5wvLdJlvWkLbODNqK
	y2ia513A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36192)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uFAzN-0007GH-1J;
	Wed, 14 May 2025 13:13:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uFAzG-0004FD-2Z;
	Wed, 14 May 2025 13:13:26 +0100
Date: Wed, 14 May 2025 13:13:26 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	balika011 <balika011@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v3 2/2] net: phy: mediatek: add driver for
 built-in 2.5G ethernet PHY on MT7988
Message-ID: <aCSI5k7uUgAlpSsy@shell.armlinux.org.uk>
References: <20250514105738.1438421-1-SkyLake.Huang@mediatek.com>
 <20250514105738.1438421-3-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514105738.1438421-3-SkyLake.Huang@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

On Wed, May 14, 2025 at 06:57:38PM +0800, Sky Huang wrote:
> +#define MTK_2P5GPHY_ID_MT7988		(0x00339c11)
> +
> +#define MT7988_2P5GE_PMB_FW		"mediatek/mt7988/i2p5ge-phy-pmb.bin"
> +#define MT7988_2P5GE_PMB_FW_SIZE	(0x20000)
> +#define MT7988_2P5GE_PMB_FW_BASE	(0x0f100000)
> +#define MT7988_2P5GE_PMB_FW_LEN		(0x20000)
> +#define MTK_2P5GPHY_MCU_CSR_BASE	(0x0f0f0000)
> +#define MTK_2P5GPHY_MCU_CSR_LEN		(0x20)
> +#define MD32_EN_CFG			(0x18)

These parens are all unnecessary, as are ones below around a simple
number.

> +#define   MD32_EN			BIT(0)
> +
> +#define BASE100T_STATUS_EXTEND		(0x10)
> +#define BASE1000T_STATUS_EXTEND		(0x11)
> +#define EXTEND_CTRL_AND_STATUS		(0x16)
> +
> +#define PHY_AUX_CTRL_STATUS		(0x1d)
> +#define   PHY_AUX_DPX_MASK		GENMASK(5, 5)
> +#define   PHY_AUX_SPEED_MASK		GENMASK(4, 2)
> +
> +/* Registers on MDIO_MMD_VEND1 */
> +#define MTK_PHY_LPI_PCS_DSP_CTRL		(0x121)

...

> +static int mt798x_2p5ge_phy_load_fw(struct phy_device *phydev)
> +{
> +	void __iomem *mcu_csr_base, *pmb_addr;
> +	struct device *dev = &phydev->mdio.dev;

This will attract a comment about reverse christmas tree.

> +	const struct firmware *fw;
> +	int ret, i;
> +	u32 reg;

...

> +static int mt798x_2p5ge_phy_config_init(struct phy_device *phydev)
> +{
> +	struct pinctrl *pinctrl;
> +
> +	/* Check if PHY interface type is compatible */
> +	if (phydev->interface != PHY_INTERFACE_MODE_INTERNAL)
> +		return -ENODEV;
> +
> +	/* Setup LED */
> +	phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED0_ON_CTRL,
> +			 MTK_PHY_LED_ON_POLARITY | MTK_PHY_LED_ON_LINK10 |
> +			 MTK_PHY_LED_ON_LINK100 | MTK_PHY_LED_ON_LINK1000 |
> +			 MTK_PHY_LED_ON_LINK2500);
> +	phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED1_ON_CTRL,
> +			 MTK_PHY_LED_ON_FDX | MTK_PHY_LED_ON_HDX);
> +
> +	/* Switch pinctrl after setting polarity to avoid bogus blinking */
> +	pinctrl = devm_pinctrl_get_select(&phydev->mdio.dev, "i2p5gbe-led");
> +	if (IS_ERR(pinctrl))
> +		dev_err(&phydev->mdio.dev, "Fail to set LED pins!\n");

No, don't do this. config_init() can be called multiple times during
the lifetime of the driver bound to the device, and each time it is,
a new managed-dev structure will be allocated to release this action
each time, thus consuming more and more memory, or possibly failing
after the first depending on the pinctrl_get_select() behaviour.
Please find a different way.

...

> +static int mt798x_2p5ge_phy_config_aneg(struct phy_device *phydev)
> +{
> +	bool changed = false;
> +	u32 adv;
> +	int ret;
> +
> +	ret = genphy_c45_an_config_aneg(phydev);
> +	if (ret < 0)
> +		return ret;
> +	if (ret > 0)
> +		changed = true;
> +
> +	/* Clause 45 doesn't define 1000BaseT support. Use Clause 22 instead in
> +	 * our design.
> +	 */
> +	adv = linkmode_adv_to_mii_ctrl1000_t(phydev->advertising);
> +	ret = phy_modify_changed(phydev, MII_CTRL1000, ADVERTISE_1000FULL, adv);
> +	if (ret < 0)
> +		return ret;
> +	if (ret > 0)
> +		changed = true;
> +
> +	return __genphy_config_aneg(phydev, changed);

Do you want this (which will program EEE and the 10/100 advert) or do
you want genphy_check_and_restart_aneg() here? Note that
genphy_c45_an_config_aneg() will already have programmed both the EEE
and 10/100 adverts via the C45 registers.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

