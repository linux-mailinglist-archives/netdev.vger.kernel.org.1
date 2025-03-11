Return-Path: <netdev+bounces-173976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A77DA5CBC3
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 18:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D1416DED2
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 17:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAF7260A32;
	Tue, 11 Mar 2025 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kzS1HYkv"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0968925C6FF;
	Tue, 11 Mar 2025 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713087; cv=none; b=Tw/l+VbDHwW+5GluQRpQFsLCore9zhx0EwAuIoufVgZVn4QtPmNfVx/48WiY9JLTtw9n1nbuoO3Z9bAf/goTjVU78UfyW7aI4unh1tu5hygbhRJIsCiPQ9ar+UzHhL25QKz3TYQuajdGKdrr+UQ4h+BJGci6l1dVZtELEptB6Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713087; c=relaxed/simple;
	bh=iWOfywb2ZgN/DV2L//kHF5EmUlAssN1Lf9nq9WyUOfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8l7AY7kRQjj+qcCK5wC7I06lYZdmNJIohg3xxaQ+OiOHDV6cvX0aSSOvpghUbBiVV6eBjzDl1YT++uVgEXU+ZElsrxlvEF/PYxCRm1POlckzkCoBuE59MTIthFXkGW94WKYmmuIc8L5XmUhc5NiZz1IuAS/bGlZ6KI+C+K8728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kzS1HYkv; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E3C21442AD;
	Tue, 11 Mar 2025 17:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741713082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWrlzjIwoAbjcMpraGEw8NTMjMyT86D1v//3+JUsrVc=;
	b=kzS1HYkvnbeKZVIbFIGXOh/rU88MERKp63D8IY6mH/mtzYKRUAfJgCQqZjBxW9FeVEGzJJ
	N5730t4BTu6i+4oBvIZiA1CPb2cIPLmlI//WSjmjsXoBMjuaohQZO8168RyTYTJ+gKTXb2
	46A8m5Lc3sRu2MB5lfNK5Ou4Wu3I7e3VarPm0z9vmfRBVXEJsVeGw+NDNiWJupoD8nrq+5
	3B6X3E6qpVBaLolYfqK95659NH0fHOJb5Dq9mV6AuHrmHFDCZteOffGI2B43ZIHzllWRhl
	jDDY4Kp6ssChVwqfjIYAs/O9+s4XBg92FPvY+/42jQS8Y6mspZgo/XoVtCDLwA==
Date: Tue, 11 Mar 2025 18:11:20 +0100
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
Subject: Re: [PATCH net-next v3 5/7] net: usb: lan78xx: port link settings
 to phylink API
Message-ID: <20250311181120.604c0a49@fedora.home>
In-Reply-To: <20250310115737.784047-6-o.rempel@pengutronix.de>
References: <20250310115737.784047-1-o.rempel@pengutronix.de>
	<20250310115737.784047-6-o.rempel@pengutronix.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrt
 ghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeifohhojhhunhhgrdhhuhhhsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehrmhhkodhkvghrnhgvlhesrghrmhhlihhnuhigrdhorhhgrdhukh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Oleksij,

On Mon, 10 Mar 2025 12:57:35 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Refactor lan78xx_get_link_ksettings and lan78xx_set_link_ksettings to
> use the phylink API (phylink_ethtool_ksettings_get and
> phylink_ethtool_ksettings_set) instead of directly interfacing with the
> PHY. This change simplifies the code and ensures better integration with
> the phylink framework for link management.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/usb/lan78xx.c | 34 ++--------------------------------
>  1 file changed, 2 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 73f62c3e5c58..7107eaa440e5 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -1862,46 +1862,16 @@ static int lan78xx_get_link_ksettings(struct net_device *net,
>  				      struct ethtool_link_ksettings *cmd)
>  {
>  	struct lan78xx_net *dev = netdev_priv(net);
> -	struct phy_device *phydev = net->phydev;
> -	int ret;
> -
> -	ret = usb_autopm_get_interface(dev->intf);
> -	if (ret < 0)
> -		return ret;
>  
> -	phy_ethtool_ksettings_get(phydev, cmd);
> -
> -	usb_autopm_put_interface(dev->intf);
> -
> -	return ret;
> +	return phylink_ethtool_ksettings_get(dev->phylink, cmd);
>  }
>  
>  static int lan78xx_set_link_ksettings(struct net_device *net,
>  				      const struct ethtool_link_ksettings *cmd)
>  {
>  	struct lan78xx_net *dev = netdev_priv(net);
> -	struct phy_device *phydev = net->phydev;
> -	int ret = 0;
> -	int temp;
> -
> -	ret = usb_autopm_get_interface(dev->intf);
> -	if (ret < 0)
> -		return ret;

It is unclear to me why these usb_autopm_* calls are here in the first
place. I think we only need to make sure that the mdio accesses are done
under usb_autopm_get_interface(), which is already the case.

> -	/* change speed & duplex */
> -	ret = phy_ethtool_ksettings_set(phydev, cmd);
>  
> -	if (!cmd->base.autoneg) {
> -		/* force link down */
> -		temp = phy_read(phydev, MII_BMCR);
> -		phy_write(phydev, MII_BMCR, temp | BMCR_LOOPBACK);
> -		mdelay(1);
> -		phy_write(phydev, MII_BMCR, temp);
> -	}
> -
> -	usb_autopm_put_interface(dev->intf);
> -
> -	return ret;
> +	return phylink_ethtool_ksettings_set(dev->phylink, cmd);
>  }
>  
>  static void lan78xx_get_pause(struct net_device *net,

If you need to respin maybe add something about it in the commit,
but besides that,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

