Return-Path: <netdev+bounces-143534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB869C2E4F
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 16:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A511C20E44
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41A019CCEA;
	Sat,  9 Nov 2024 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HOz4E6lS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F1D19CC21;
	Sat,  9 Nov 2024 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731167029; cv=none; b=ldlWoOUgI/txQ6TqibMoTLNWmTMR/7t+d/C98IO/Q7d4oqL1Vra6KieV+OCYrW87GYAlsYFVH5wthkXQf2Va43d8wFBytKKRCSjFw1kMFHbmk9UYq/c029OUssJLvsOobblIyWSd10+/pY4oThNOeuYB/gRKWHFcv+oQ/8N9RNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731167029; c=relaxed/simple;
	bh=jDNZB1A/J/zq5gt2PGFW4eLWP2EuMycAA3yVEocaOhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKI0wcKg5dg+Ez079HUOV5vFXHfkndzI1epZne09TBC64ZKjx5bsFA9o/7cmk0wA/CfmAGyV3V323DKkHLgpClXDMw2iLl4/WVSdowdxyEtYZP9IWf0yK7WcoQSy3m4o2Hm3xEo+U8C7gumaWp2HMVnw0hPUz9KV+XZsTdzszvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HOz4E6lS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J57s815SwhMV8jjaOfiNANO5vn4nCJpafqqppdC8Pmg=; b=HOz4E6lSW7KvhQYxEEDlHapBil
	06iVa4Ql5eIpJK3KaG6xlCHM4FATGEtGbGz6MLI3M8DHdg/vbp2HunYyTqVrcAwGRjmNwVpARqneL
	3eGN9WqggzBm0puxFjjBL/SnzDGfVSiSoXfTNFUO0JrAl2ycMlaqlDtyoISD4tihzCC4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t9nch-00CiYi-EH; Sat, 09 Nov 2024 16:43:39 +0100
Date: Sat, 9 Nov 2024 16:43:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Message-ID: <d912d397-38b4-4bdb-ac38-ac45206b4af8@lunn.ch>
References: <20241109015633.82638-1-Tristram.Ha@microchip.com>
 <20241109015633.82638-3-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109015633.82638-3-Tristram.Ha@microchip.com>

> +static void port_sgmii_r(struct ksz_device *dev, uint port, u16 devid, u16 reg,
> +			 u16 *buf, u16 len)
> +{
> +	u32 data;
> +
> +	port_sgmii_s(dev, port, devid, reg, len);
> +	while (len) {
> +		ksz_pread32(dev, port, REG_PORT_SGMII_DATA__4, &data);
> +		*buf++ = (u16)data;
> +		len--;
> +	}
> +}
> +
> +static void port_sgmii_w(struct ksz_device *dev, uint port, u16 devid, u16 reg,
> +			 u16 *buf, u16 len)
> +{
> +	u32 data;
> +
> +	port_sgmii_s(dev, port, devid, reg, len);
> +	while (len) {
> +		data = *buf++;
> +		ksz_pwrite32(dev, port, REG_PORT_SGMII_DATA__4, data);
> +		len--;
> +	}
> +}

This kind of looks like a C45 only MDIO bus.

#define MMD_DEVICE_ID_VENDOR_MII	0x1F

#define SR_MII				MMD_DEVICE_ID_VENDOR_MII

This is identical to MDIO_MMD_VEND2.

#define SR_MII_RESET			BIT(15)
#define SR_MII_LOOPBACK			BIT(14)
#define SR_MII_SPEED_100MBIT		BIT(13)
#define SR_MII_AUTO_NEG_ENABLE		BIT(12)
#define SR_MII_POWER_DOWN		BIT(11)
#define SR_MII_AUTO_NEG_RESTART		BIT(9)
#define SR_MII_FULL_DUPLEX		BIT(8)
#define SR_MII_SPEED_1000MBIT		BIT(6)

A standard BMCR.

#define MMD_SR_MII_STATUS		0x0001
#define MMD_SR_MII_ID_1			0x0002
#define MMD_SR_MII_ID_2			0x0003
#define MMD_SR_MII_AUTO_NEGOTIATION	0x0004

Same as:

#define MII_BMSR                0x01    /* Basic mode status register  */
#define MII_PHYSID1             0x02    /* PHYS ID 1                   */
#define MII_PHYSID2             0x03    /* PHYS ID 2                   */
#define MII_ADVERTISE           0x04    /* Advertisement control reg   */

So i think your first patch should be to replace all these with the
standard macros.

That will then help make it clearer how much is generic, could the
existing helpers be used, probably with a wrapper to make your C22
device mapped to C45 MDIO_MMD_VEND2 look like a C22 device?

	Andrew

