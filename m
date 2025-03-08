Return-Path: <netdev+bounces-173172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B270AA57AC5
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 14:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1AFE3A43A2
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010FF1A9B53;
	Sat,  8 Mar 2025 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NRjZGi8m"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B66A1527B1;
	Sat,  8 Mar 2025 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441928; cv=none; b=m7ljE/FIu1cZzsfZIX7e4ZfqBhcIdqxz47oooVPBr7eCdVn3dGJO1pWRCx/yy0f+NGi5OZhMUU9YQuD2q5d8pG0mrHq95OAksQMhckit7jXR7MqJe9lvHvRTx3yKOQmrzpMJwZX+bVN+BvlaSXbxVs0JXChTp4QVOJRDfrr1/8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441928; c=relaxed/simple;
	bh=WKVokk4EZBnnTxzZA3HR4l0jDWxT54H1Fc7mvdjy3cE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piPmcwGOEXNWu7b7soLxzGAb70RIxMHZpF1QXcidw7qx09+ZlQEy2+T2anM6ok7BFF6WUCmGKNIyEoLNr07/QtWPfV0VmHduFLygPUY0YpT1gSZXrMzaFj9dKo4v57b1lWqQMioh4nppkaQXN0ZBfB42L+asuJ8WehuUgO6lQKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NRjZGi8m; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 53FE5443D5;
	Sat,  8 Mar 2025 13:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741441917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/wbGZUe+OxH97D/WyxmtJYVI7v+UGzPeNHB5oGEb8s=;
	b=NRjZGi8m/PVXSRTiJGtCN3cMbxxfTw1LfZcEiaEqZOKyHYfLWptawgzkwNzwjxauyAohnm
	GK/N/BiIyAs4FWTgHzo1mBJbzPiFNQiKyffksl807Gs6vurDGFVeVdVRHnLp80e2DKiMmd
	b2wAy6VeKCzhtN0kaH/Vsv0Q58iM9x5Hnr6xfVGw9IQJ6/KTk7jJq2gtqNQ41FYcnnYyS6
	gFnFZVxBCxkll6mQbkC5F42tFK7evv3A2bhB1NptMLve6OLtZ877tKTx9BaLAewXOu22Bv
	gO1OO2PQtAHYc+b/6vYO09wUrcUxadltRSfjH2Rabqk4TK9PgW93sCTMOLcY8g==
Date: Sat, 8 Mar 2025 14:51:55 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Russell King <rmk+kernel@armlinux.org.uk>,
 Thangaraj Samynathan <Thangaraj.S@microchip.com>, Rengarajan Sundararajan
 <Rengarajan.S@microchip.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v2 1/7] net: usb: lan78xx: Convert to PHYlink
 for improved PHY and MAC management
Message-ID: <20250308145155.12c437c5@fedora.home>
In-Reply-To: <20250307182432.1976273-2-o.rempel@pengutronix.de>
References: <20250307182432.1976273-1-o.rempel@pengutronix.de>
	<20250307182432.1976273-2-o.rempel@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudefjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrt
 ghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeifohhojhhunhhgrdhhuhhhsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehrmhhkodhkvghrnhgvlhesrghrmhhlihhnuhigrdhorhhgrdhukh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Oleksij,

On Fri,  7 Mar 2025 19:24:26 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Convert the LAN78xx driver to use the PHYlink framework for managing
> PHY and MAC interactions.
> 
> Key changes include:
> - Replace direct PHY operations with phylink equivalents (e.g.,
>   phylink_start, phylink_stop).
> - Introduce lan78xx_phylink_setup for phylink initialization and
>   configuration.
> - Add phylink MAC operations (lan78xx_mac_config,
>   lan78xx_mac_link_down, lan78xx_mac_link_up) for managing link
>   settings and flow control.
> - Remove redundant and now phylink-managed functions like
>   `lan78xx_link_status_change`.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

I only have a small comment, the rest looks OK (at least to me) :

> +static int lan78xx_phylink_setup(struct lan78xx_net *dev)
> +{
> +	phy_interface_t link_interface;
> +	struct phylink *phylink;
> +
> +	dev->phylink_config.dev = &dev->net->dev;
> +	dev->phylink_config.type = PHYLINK_NETDEV;
> +	dev->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
> +		MAC_10 | MAC_100 | MAC_1000FD;
> +	dev->phylink_config.mac_managed_pm = true;
> +
> +	if (dev->chipid == ID_REV_CHIP_ID_7801_) {
> +		__set_bit(PHY_INTERFACE_MODE_RGMII,
> +			  dev->phylink_config.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_RGMII_ID,
> +			  dev->phylink_config.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_RGMII_RXID,
> +			  dev->phylink_config.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_RGMII_TXID,
> +			  dev->phylink_config.supported_interfaces);

You can use :

	phy_interface_set_rgmii(dev->phylink_config.supported_interfaces);

instead of setting all indivdual RGMII modes :)

> +		link_interface = PHY_INTERFACE_MODE_RGMII_ID;
> +	} else {
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  dev->phylink_config.supported_interfaces);
> +		link_interface = PHY_INTERFACE_MODE_INTERNAL;
> +	}
> +
> +	phylink = phylink_create(&dev->phylink_config, dev->net->dev.fwnode,
> +				 link_interface, &lan78xx_phylink_mac_ops);
> +	if (IS_ERR(phylink))
> +		return PTR_ERR(phylink);
> +
> +	dev->phylink = phylink;
> +
> +	return 0;
> +}
> +

Maxime

