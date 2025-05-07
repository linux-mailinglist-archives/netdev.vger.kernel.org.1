Return-Path: <netdev+bounces-188582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1A4AAD910
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 09:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7F23B7C75
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 07:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6E8222575;
	Wed,  7 May 2025 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eIK7M34k"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AD9221286;
	Wed,  7 May 2025 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746603903; cv=none; b=CIHOhBnrCXFTM6KqbtWDCgdlRS8TU9noUENFSLgbtwdBYCfOEe7qc1pofKCJryTsj3XxlJfubleSBBZWrklcRaNLFnySljQ1im+y+rOHtiVo99Oc4+RbZ00yNqKJyqF9fmAWqmUxEpcD9XTxfIFB9mzXOqQ6L/s8xNVvi0NJsVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746603903; c=relaxed/simple;
	bh=SQsRYLRdU71LaJ3wdeA+W6LRxPDPNV2wGe+Mwnyowgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nbe/d09VuzATvEXbT6h1pMmVwYrmQizchoQI9xxW0odOGFYyebDwHKLC0dX3rfbVZ6FeysqroLB4YpZx30uxrYhif87Fqhstl+VDEIhTn8cxfp6K3TzIhWs6cQNXYnCpJPUP0gH7WT+XE3VnhdFjossNYLyu7SeDys0EykvovS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eIK7M34k; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3876A4419B;
	Wed,  7 May 2025 07:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746603893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0HW6CbY74NioaSQ8ld8M44cztZr/A/kw8B41kCDVZo=;
	b=eIK7M34kbOGrSDj67RJbY66sYJfkjUMO8K0CZTog3FdE2x5vlRgAcon+h/SWdCKOxhnmZa
	lloNynWr58xtnndahT5HViyWiwzyZW44D4zpCJiGrtGS8ar/oNCcSV89NdU3q4XLiBriNW
	An+emOeh1BrqFpwpyDxSBN3JdccXNUk3FqrrmuCbhE9146GEHcxJXMFgCZtlFMhgTr0OUd
	NRln1YjsbIUpeXo43BszMw83V6hIAmBFHSJ1g57p5tqyMB0z3XDVFMdkUYkIn6xfL6n72W
	IkYBxjpo4GXf7+lAoxNrMpk8c/oRhZmxNpHLwuMIqkDaGaUYh6qD4FI56yOU+A==
Date: Wed, 7 May 2025 09:44:49 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: <Tristram.Ha@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Woojung Huh <woojung.huh@microchip.com>,
 Russell King <linux@armlinux.org.uk>, Vladimir Oltean <olteanv@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Message-ID: <20250507094449.60885752@fedora.home>
In-Reply-To: <20250507000911.14825-1-Tristram.Ha@microchip.com>
References: <20250507000911.14825-1-Tristram.Ha@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeifedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeeftdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleehgeevfeejgfduledtlefhlefgveelkeefffeuiedtteejheduueegiedvveehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopefvrhhishhtrhgrmhdrjfgrsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepf
 ihoohhjuhhnghdrhhhuhhesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepohhlthgvrghnvhesghhmrghilhdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Tristram,

On Tue, 6 May 2025 17:09:11 -0700
<Tristram.Ha@microchip.com> wrote:

> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The KSZ9477 switch driver uses the XPCS driver to operate its SGMII
> port.  However there are some hardware bugs in the KSZ9477 SGMII
> module so workarounds are needed.  There was a proposal to update the
> XPCS driver to accommodate KSZ9477, but the new code is not generic
> enough to be used by other vendors.  It is better to do all these
> workarounds inside the KSZ9477 driver instead of modifying the XPCS
> driver.
> 
> There are 3 hardware issues.  The first is the MII_ADVERTISE register
> needs to be write once after reset for the correct code word to be
> sent.  The XPCS driver disables auto-negotiation first before
> configuring the SGMII/1000BASE-X mode and then enables it back.  The
> KSZ9477 driver then writes the MII_ADVERTISE register before enabling
> auto-negotiation.  In 1000BASE-X mode the MII_ADVERTISE register will
> be set, so KSZ9477 driver does not need to write it.
> 
> The second issue is the MII_BMCR register needs to set the exact speed
> and duplex mode when running in SGMII mode.  During link polling the
> KSZ9477 will check the speed and duplex mode are different from
> previous ones and update the MII_BMCR register accordingly.
> 
> The last issue is 1000BASE-X mode does not work with auto-negotiation
> on.  The cause is the local port hardware does not know the link is up
> and so network traffic is not forwarded.  The workaround is to write 2
> additional bits when 1000BASE-X mode is configured.
> 
> Note the SGMII interrupt in the port cannot be masked.  As that
> interrupt is not handled in the KSZ9477 driver the SGMII interrupt bit
> will not be set even when the XPCS driver sets it.
>
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

[...]

> +
> +static int ksz9477_pcs_read(struct mii_bus *bus, int phy, int mmd, int reg)
> +{
> +	struct ksz_device *dev = bus->priv;
> +	int port = ksz_get_sgmii_port(dev);
> +	u16 val;
> +
> +	port_sgmii_r(dev, port, mmd, reg, &val);
> +
> +	/* Simulate a value to activate special code in the XPCS driver if
> +	 * supported.
> +	 */
> +	if (mmd == MDIO_MMD_PMAPMD) {
> +		if (reg == MDIO_DEVID1)
> +			val = 0x9477;
> +		else if (reg == MDIO_DEVID2)
> +			val = 0x22 << 10;
> +	} else if (mmd == MDIO_MMD_VEND2) {
> +		struct ksz_port *p = &dev->ports[port];
> +
> +		/* Need to update MII_BMCR register with the exact speed and
> +		 * duplex mode when running in SGMII mode and this register is
> +		 * used to detect connected speed in that mode.
> +		 */
> +		if (reg == MMD_SR_MII_AUTO_NEG_STATUS) {
> +			int duplex, speed;
> +
> +			if (val & SR_MII_STAT_LINK_UP) {
> +				speed = (val >> SR_MII_STAT_S) & SR_MII_STAT_M;
> +				if (speed == SR_MII_STAT_1000_MBPS)
> +					speed = SPEED_1000;
> +				else if (speed == SR_MII_STAT_100_MBPS)
> +					speed = SPEED_100;
> +				else
> +					speed = SPEED_10;
> +
> +				if (val & SR_MII_STAT_FULL_DUPLEX)
> +					duplex = DUPLEX_FULL;
> +				else
> +					duplex = DUPLEX_HALF;
> +
> +				if (!p->phydev.link ||
> +				    p->phydev.speed != speed ||
> +				    p->phydev.duplex != duplex) {
> +					u16 ctrl;
> +
> +					p->phydev.link = 1;
> +					p->phydev.speed = speed;
> +					p->phydev.duplex = duplex;
> +					port_sgmii_r(dev, port, mmd, MII_BMCR,
> +						     &ctrl);
> +					ctrl &= BMCR_ANENABLE;
> +					ctrl |= mii_bmcr_encode_fixed(speed,
> +								      duplex);
> +					port_sgmii_w(dev, port, mmd, MII_BMCR,
> +						     ctrl);
> +				}
> +			} else {
> +				p->phydev.link = 0;
> +			}
> +		} else if (reg == MII_BMSR) {
> +			p->phydev.link = (val & BMSR_LSTATUS);
> +		}
> +	}
> +	return val;
> +}
> +
> +static int ksz9477_pcs_write(struct mii_bus *bus, int phy, int mmd, int reg,
> +			     u16 val)
> +{
> +	struct ksz_device *dev = bus->priv;
> +	int port = ksz_get_sgmii_port(dev);
> +
> +	if (mmd == MDIO_MMD_VEND2) {
> +		struct ksz_port *p = &dev->ports[port];
> +
> +		if (reg == MMD_SR_MII_AUTO_NEG_CTRL) {
> +			u16 sgmii_mode = SR_MII_PCS_SGMII << SR_MII_PCS_MODE_S;
> +
> +			/* Need these bits for 1000BASE-X mode to work with
> +			 * AN on.
> +			 */
> +			if (!(val & sgmii_mode))
> +				val |= SR_MII_SGMII_LINK_UP |
> +				       SR_MII_TX_CFG_PHY_MASTER;
> +
> +			/* SGMII interrupt in the port cannot be masked, so
> +			 * make sure interrupt is not enabled as it is not
> +			 * handled.
> +			 */
> +			val &= ~SR_MII_AUTO_NEG_COMPLETE_INTR;
> +		} else if (reg == MII_BMCR) {
> +			/* The MII_ADVERTISE register needs to write once
> +			 * before doing auto-negotiation for the correct
> +			 * config_word to be sent out after reset.
> +			 */
> +			if ((val & BMCR_ANENABLE) && !p->sgmii_adv_write) {
> +				u16 adv;
> +
> +				/* The SGMII port cannot disable flow contrl
> +				 * so it is better to just advertise symmetric
> +				 * pause.
> +				 */
> +				port_sgmii_r(dev, port, mmd, MII_ADVERTISE,
> +					     &adv);
> +				adv |= ADVERTISE_1000XPAUSE;
> +				adv &= ~ADVERTISE_1000XPSE_ASYM;
> +				port_sgmii_w(dev, port, mmd, MII_ADVERTISE,
> +					     adv);
> +				p->sgmii_adv_write = 1;
> +			} else if (val & BMCR_RESET) {
> +				p->sgmii_adv_write = 0;
> +			}
> +		} else if (reg == MII_ADVERTISE) {
> +			/* XPCS driver writes to this register so there is no
> +			 * need to update it for the errata.
> +			 */
> +			p->sgmii_adv_write = 1;
> +		}
> +	}
> +	port_sgmii_w(dev, port, mmd, reg, val);
> +	return 0;
> +}

I'm a bit confused here, are you intercepting r/w ops that are supposed
to be handled by xpcs ?

Russell has sent a series [1] (not merged yet, I think we were waiting
on some feedback from Synopsys folks ?) to properly support the XPCS
version that's in KSZ9477, and you also had a patchset that didn't
require all this sgmii_r/w snooping [2].

I've been running your previous patchset on top of Russell's for a few
months, if works fine with SGMII as well as 1000BaseX :)

Can we maybe focus on getting pcs-xpcs to properly support this version
of the IP instead of these 2 R/W functions ? Or did I miss something in
the previous discussions ?

Maxime

[1] : https://lore.kernel.org/netdev/Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk/ 
[2] : https://lore.kernel.org/netdev/20250208002417.58634-1-Tristram.Ha@microchip.com/

