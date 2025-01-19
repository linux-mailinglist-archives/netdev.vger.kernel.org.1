Return-Path: <netdev+bounces-159646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D666DA16359
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 18:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82426160673
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A5B1DF254;
	Sun, 19 Jan 2025 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Dpa5oybn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBAA15350B;
	Sun, 19 Jan 2025 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737307920; cv=none; b=TOOKsVYSqqXhP59Px/gq2w9TwNyixo+h3b5gtqKvYY9uKya/EjOrf3MloZLmZq6wVK0Y313z6iw/fbmY+Idcln4ynH+0Fz7k9rcB7YWXz6dxKQ3BlKvOC4ewAGE+Xh5vrgGV9lTj+TUY9F/AYS51+koeJPYzKZOZakONRjwuZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737307920; c=relaxed/simple;
	bh=RCbJS8qDkfjIat7A5HCBX9+z/JEJVKPnWrWjcfLZw4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/yotVah6Mqdc4wFBf9KgA4L6NeluIV+B9DMfXd1wigUf5FexZiAmiwXvh1h59MzTJddiRiu/o5CyifCeTdmthEEYe3BxkR5JDmC06dWr926Mb5nWrEY6/Pcu2zMyM1Pd0u4gSrDT47uK/HS7VOq2elHxCJ9xWdIjp9WE1nR3Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Dpa5oybn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AqXJtOIf4rCW4A5e2bQ1EyB3uRGWzyR+eKwMln2F0eU=; b=Dpa5oybnNfPHVmxV3G/PBBg4wO
	ePgzRXYgm9RJQ+5DVbWvV6RQeGb6G3Pji/0gWgyWvwVydMdgJmjCfe5oqfSAmkXCa6raJn2TsBodQ
	OkLck7d8V2VdHcoV4XPy0srE7ynBEfLEYZXnQTzAED9gj04OJ5ihlKCXZYBjCbXH9Es8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tZZ9E-0066tP-JT; Sun, 19 Jan 2025 18:31:44 +0100
Date: Sun, 19 Jan 2025 18:31:44 +0100
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
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next 3/3] net: phy: mediatek: add driver for built-in
 2.5G ethernet PHY on MT7988
Message-ID: <df67baa5-0f3d-4a42-a327-00452787908a@lunn.ch>
References: <20250116012159.3816135-1-SkyLake.Huang@mediatek.com>
 <20250116012159.3816135-4-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116012159.3816135-4-SkyLake.Huang@mediatek.com>

> +	np = of_find_compatible_node(NULL, NULL, "mediatek,2p5gphy-fw");
> +	if (!np)
> +		return -ENOENT;

The device tree binding need documenting.

> +	/* Write magic number to safely stall MCU */
> +	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x800e, 0x1100);
> +	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x800f, 0x00df);

0x1100 and 0x00df are magic numbers, bit 0x800e and 0x800f are
not. Please add #defines.


> +
> +	for (i = 0; i < MT7988_2P5GE_PMB_FW_SIZE - 1; i += 4)
> +		writel(*((uint32_t *)(fw->data + i)), pmb_addr + i);
> +	dev_info(dev, "Firmware date code: %x/%x/%x, version: %x.%x\n",
> +		 be16_to_cpu(*((__be16 *)(fw->data +
> +					  MT7988_2P5GE_PMB_FW_SIZE - 8))),
> +		 *(fw->data + MT7988_2P5GE_PMB_FW_SIZE - 6),
> +		 *(fw->data + MT7988_2P5GE_PMB_FW_SIZE - 5),
> +		 *(fw->data + MT7988_2P5GE_PMB_FW_SIZE - 2),
> +		 *(fw->data + MT7988_2P5GE_PMB_FW_SIZE - 1));
> +
> +	writew(reg & ~MD32_EN, mcu_csr_base + MD32_EN_CFG);
> +	writew(reg | MD32_EN, mcu_csr_base + MD32_EN_CFG);
> +	phy_set_bits(phydev, MII_BMCR, BMCR_RESET);
> +	/* We need a delay here to stabilize initialization of MCU */
> +	usleep_range(7000, 8000);
> +	dev_info(dev, "Firmware loading/trigger ok.\n");

We generally don't spam the log for "Happy Days" conditions. Please
only log if firmware download fails.

> +static int mt798x_2p5ge_phy_get_features(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = genphy_c45_pma_read_abilities(phydev);
> +	if (ret)
> +		return ret;
> +
> +	/* This phy can't handle collision, and neither can (XFI)MAC it's
> +	 * connected to. Although it can do HDX handshake, it doesn't support
> +	 * CSMA/CD that HDX requires.
> +	 */
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
> +			   phydev->supported);

So it can do 10BaseT_Half? What about 1000BaseT_Half?

As you said somewhere, 10/100/1G are not in the C45 space. So does
genphy_c45_pma_read_abilities() report these features?

	Andrew

