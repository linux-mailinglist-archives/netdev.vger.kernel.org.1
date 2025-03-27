Return-Path: <netdev+bounces-177924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A7CA72EF2
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 12:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41825188BA6C
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 11:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D232A211499;
	Thu, 27 Mar 2025 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Tg46yswV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3993619D88F;
	Thu, 27 Mar 2025 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074680; cv=none; b=j2P24dEDRao67kzOKZpFpfAGAMS3BNm7PcgBEPJcg94bdurEQ7BbVZn4Bm8ZnWENCKvkj9B5DYQ/DxbUYlCzz36+CMowb6sX/aIj+DBiSWfbzLmOio1zPF+rHa1RmqQvcqPxeEJ9yN7WD6/nqUDmLuBBt2M40ToOyzW0jvoSna4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074680; c=relaxed/simple;
	bh=o90eJ9r17sHcsxjv667qqNImLfONvscKSdVPajh8Zb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rltjshOdiDxJ1XuLLkozlupTGXwXvgsPO7i2Df6qgZSbgaj4tnSR2Sj9pwmsrK4pavGwwTqsWSaHX58tC3GfmW9gbW7FrP1Xlr6/xKjUewNZkQk6l/MmD2QEJCG5nZAXa+/bMacqsXBOJsBLs8fJGsXlNwuOdr6Z61AvSERnrtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Tg46yswV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8Kd2m4/qDTBu4FgncmANR8l0RgY9la+y1Mod4stXgAI=; b=Tg46yswVdHA0FtJG6X00K5GDXS
	ITlusgE6UxNSakQz1awgavBIMDV5nWn68+Lb4EUlvEJV8HVtQDEFl6ObnRH38FR40IZml8CTUZcvP
	gGxMnv82tJexW/PWtMKzZNsSm+SYo6dDExr0VdE6RksAsChnEUZltKeFJiNikFCwCvvubT1JM/zdk
	ZtC7cZI69vYfd3fp8nre+uHXpOC796CP6/Nudr4yLtsxmkKLLAztF233fQc53eWGp5CBLIv2UwtN3
	WWdEY5Ss7s04C2eYPOasuwePnvPHYnn9jRO5GXR/G0lKvEwm9Pijzf2XkOQCDoqkw3eJpejirUwR4
	nz+yJ+FA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38688)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1txlLY-0007AV-2e;
	Thu, 27 Mar 2025 11:24:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1txlLW-0005ar-2U;
	Thu, 27 Mar 2025 11:24:26 +0000
Date: Thu, 27 Mar 2025 11:24:26 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v3 3/4] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
Message-ID: <Z-U1anj6IbSdPGoD@shell.armlinux.org.uk>
References: <20250326233512.17153-1-ansuelsmth@gmail.com>
 <20250326233512.17153-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326233512.17153-4-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 27, 2025 at 12:35:03AM +0100, Christian Marangi wrote:
> +static int as21xxx_match_phy_device(struct phy_device *phydev,
> +				    const struct phy_driver *phydrv)
> +{
> +	struct as21xxx_priv *priv;
> +	u32 phy_id;
> +	int ret;
> +
> +	/* Skip PHY that are not AS21xxx or already have firmware loaded */
> +	if (phydev->c45_ids.device_ids[MDIO_MMD_PCS] != PHY_ID_AS21XXX)
> +		return phydev->phy_id == phydrv->phy_id;

Isn't phydev->phy_id zero here for a clause 45 PHY? If the firmware
has been loaded, I believ eyou said that PHY_ID_AS21XXX won't be
used, so the if() will be true, and because we've read clause 45
IDs, phydev->phy_id will be zero meaning this will never match. So
a PHY with firmware loaded won't ever match any of these drivers.
This is probably not what you want.

I'd suggest converting the tail of phy_bus_match() so that you can
call that to do the standard matching using either C22 or C45 IDs
as appropriate without duplicating that code.

> +
> +	/* Read PHY ID to handle firmware just loaded */
> +	ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_PHYSID1);
> +	if (ret < 0)
> +		return ret;
> +	phy_id = ret << 16;
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_PHYSID2);
> +	if (ret < 0)
> +		return ret;
> +	phy_id |= ret;
> +
> +	/* With PHY ID not the generic AS21xxx one assume
> +	 * the firmware just loaded
> +	 */
> +	if (phy_id != PHY_ID_AS21XXX)
> +		return phy_id == phydrv->phy_id;
> +
> +	/* Allocate temp priv and load the firmware */
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	mutex_init(&priv->ipc_lock);
> +
> +	ret = aeon_firmware_load(phydev);
> +	if (ret)
> +		return ret;
> +
> +	ret = aeon_ipc_sync_parity(phydev, priv);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable PTP clk if not already Enabled */
> +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CLK,
> +			       VEND1_PTP_CLK_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret = aeon_dpc_ra_enable(phydev, priv);
> +	if (ret)
> +		return ret;
> +
> +	mutex_destroy(&priv->ipc_lock);
> +	kfree(priv);
> +
> +	/* Return not maching anyway as PHY ID will change after
> +	 * firmware is loaded.

Also "This relies on the driver probe order."

> +	 */
> +	return 0;
> +}
> +
> +static struct phy_driver as21xxx_drivers[] = {
> +	{
> +		/* PHY expose in C45 as 0x7500 0x9410
> +		 * before firmware is loaded.

Also "This driver entry must be attempted first to load the firmware and
thus update the ID registers."

> +		 */
> +		PHY_ID_MATCH_EXACT(PHY_ID_AS21XXX),
> +		.name		= "Aeonsemi AS21xxx",
> +		.match_phy_device = as21xxx_match_phy_device,
> +	},
> +	{
> +		PHY_ID_MATCH_EXACT(PHY_ID_AS21011JB1),
> +		.name		= "Aeonsemi AS21011JB1",
> +		.probe		= as21xxx_probe,
> +		.match_phy_device = as21xxx_match_phy_device,
> +		.read_status	= as21xxx_read_status,
> +		.led_brightness_set = as21xxx_led_brightness_set,
> +		.led_hw_is_supported = as21xxx_led_hw_is_supported,
> +		.led_hw_control_set = as21xxx_led_hw_control_set,
> +		.led_hw_control_get = as21xxx_led_hw_control_get,
> +		.led_polarity_set = as21xxx_led_polarity_set,

If I'm reading these driver entries correctly, the only reason for
having separate entries is to be able to have a unique name printed
for each - the methods themselves are all identical.

My feeling is that is not a sufficient reason to duplicate the driver
entries, which adds bloat (not only in terms of static data, but also
the data structures necessary to support each entry in sysfs.) However,
lets see what Andrew says.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

