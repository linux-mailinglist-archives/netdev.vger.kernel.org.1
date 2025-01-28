Return-Path: <netdev+bounces-161278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F9FA20781
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 10:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21B3167181
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 09:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5444B19A288;
	Tue, 28 Jan 2025 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mNLgD8ma"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537111990AF;
	Tue, 28 Jan 2025 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738057148; cv=none; b=DusiHPgEDK1AWVKhPO1k5piKvZN3u574G7b8BQP1yxnBRlhfHGQSlYyBpvCKcAgHfYUwd5w6zq7C3euIVrNtIyeuOYInMogKiXLLVJluhq2Gswfbfm7iBftOWCg4ZkJuLUB5aa8BoM5pcS90J1KYKB6SdufnZp88USw8PG8SxRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738057148; c=relaxed/simple;
	bh=GYCo/Kndq3nfJ6judEOYDhx9u7QO15r8HwrtlgIeWWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZEoqZHOR7qmMQ1gpEXZ035n6xOPux9AEkRMsvspglqLuaWmzGLYN/DNiBJmBQh82iDmT0h+Z5+1uYMCJyHNBoZ+JNQuCrYMvlXhgdkS6KwssWaVpFh9/53PHawED4HMnXOgNlC05RHYfXdBxvcU7EKYzmQE8iNv/D13AWDG4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mNLgD8ma; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ObV7BoAqZImnctXDVt7lyjV5cNiG7Dopxwg+5yeYBlQ=; b=mNLgD8maBCZSq2NlXzcOpgkc5E
	oxhTSKtLZOPU5qgdnBHOXe/uzwpNsOv0YyfKu0eiWOdC9xM4Px4wI2K3NNoR7iY085NV3bi5uLm6u
	KFZSqfyzTi//WPDJ4cJdrrqu+MinP2+srMzaSgBjcsa3xnqf0sXT9m2zLwB5JtNTgu+2uG1P/nKvi
	z3TtLqh4niPWq4JHYryDlqx3fPOiUXQ5ZhNsao2L3VF0+LBN2GMXamG+1Q3z2d9xlMyfl9lr4prFQ
	TQ4pkew12wNFjs+7AHPfn0axjAsJHVlU5p7IhOgqJuliC5l5Mkd67ikH18PpUTFXAA039FDPj8NHF
	9cYkokBQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53066)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tci3c-0006nm-0v;
	Tue, 28 Jan 2025 09:38:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tci3a-0002Wq-2R;
	Tue, 28 Jan 2025 09:38:54 +0000
Date: Tue, 28 Jan 2025 09:38:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 2/2] net: dsa: microchip: Add SGMII port
 support to KSZ9477 switch
Message-ID: <Z5ilrp1c6lbMGqbl@shell.armlinux.org.uk>
References: <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-3-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128033226.70866-3-Tristram.Ha@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 27, 2025 at 07:32:26PM -0800, Tristram.Ha@microchip.com wrote:
> @@ -161,6 +161,113 @@ static int ksz9477_wait_alu_sta_ready(struct ksz_device *dev)
>  					10, 1000);
>  }
>  
> +static void port_sgmii_s(struct ksz_device *dev, uint port, u16 devid, u16 reg,
> +			 u16 len)
> +{
> +	u32 data;
> +
> +	data = (devid & MII_MMD_CTRL_DEVAD_MASK) << 16;
> +	data |= reg;
> +	if (len > 1)
> +		data |= PORT_SGMII_AUTO_INCR;
> +	ksz_pwrite32(dev, port, REG_PORT_SGMII_ADDR__4, data);
> +}
> +
> +static void port_sgmii_r(struct ksz_device *dev, uint port, u16 devid, u16 reg,
> +			 u16 *buf, u16 len)
> +{
> +	u32 data;
> +
> +	mutex_lock(&dev->sgmii_mutex);

You won't need sgmii_mutex if all accesses go through the MDIO bus
accessors (please do so and get rid of this mutex.)

> +	port_sgmii_s(dev, port, devid, reg, len);
> +	while (len) {
> +		ksz_pread32(dev, port, REG_PORT_SGMII_DATA__4, &data);
> +		*buf++ = (u16)data;
> +		len--;
> +	}
> +	mutex_unlock(&dev->sgmii_mutex);
> +}
> +
> +static void port_sgmii_w(struct ksz_device *dev, uint port, u16 devid, u16 reg,
> +			 u16 *buf, u16 len)
> +{
> +	u32 data;
> +
> +	mutex_lock(&dev->sgmii_mutex);
> +	port_sgmii_s(dev, port, devid, reg, len);
> +	while (len) {
> +		data = *buf++;
> +		ksz_pwrite32(dev, port, REG_PORT_SGMII_DATA__4, data);
> +		len--;
> +	}
> +	mutex_unlock(&dev->sgmii_mutex);
> +}

I don't see any need for any of the above complexity for writing
multiple registers. All your calls to the above two functions only
pass a value of 1 for len.

> +
> +static void port_sgmii_reset(struct ksz_device *dev, uint p)
> +{
> +	u16 ctrl = BMCR_RESET;
> +
> +	port_sgmii_w(dev, p, MDIO_MMD_VEND2, MII_BMCR, &ctrl, 1);
> +}

doesn't xpcs_create() result in xpcs->need_reset being set true, and
thus when the XPCS is used, cause xpcs_pre_config() to do a soft reset
of the XPCS? More importantly, the XPCS driver waits for the reset
to complete...

> @@ -978,6 +1085,13 @@ void ksz9477_get_caps(struct ksz_device *dev, int port,
>  
>  	if (dev->info->gbit_capable[port])
>  		config->mac_capabilities |= MAC_1000FD;
> +
> +	if (ksz_is_sgmii_port(dev, port)) {
> +		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  config->supported_interfaces);
> +	}

	f (ksz_is_sgmii_port(dev, port))
		phy_interface_or(config->supported_interfaces,
				 config->supported_interfaces,
				 xpcs_to_phylink_pcs(port->xpcs)->supported_interfaces);

If xpcs_to_phylink_pcs(port->xpcs)->supported_interfaces does not
accurately indicate the interfaces that are supported on your XPCS
model, then you need further xpcs driver changes.

> +static inline int ksz_get_sgmii_port(struct ksz_device *dev)
> +{
> +	return (dev->info->sgmii_port - 1);
> +}
> +
> +static inline bool ksz_has_sgmii_port(struct ksz_device *dev)
> +{
> +	return (dev->info->sgmii_port > 0);
> +}
> +
> +static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
> +{
> +	return (dev->info->sgmii_port == port + 1);
> +}

No need for the parens in any of the above three.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

