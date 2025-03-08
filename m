Return-Path: <netdev+bounces-173173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15053A57AC7
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 14:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B617188DB7B
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 13:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75741B0420;
	Sat,  8 Mar 2025 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N7qj1/Dr"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F7B17A2F5;
	Sat,  8 Mar 2025 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741442066; cv=none; b=KWX5lsKKEfkQT08IVoXq2puQ+PXX9zWaf0Ed1QvD42kq3tS3wd68YKN5Yh8Ie/bhudoF0AFP6NSqJGBdZBtl1j4jbZ1fT2bWmjUi7g/LdIjXCrIWI/6So+80e2kUL6A5PBxfScdpvfYQqqQpmaozz0WVlBs0qNyli4wzP+sAUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741442066; c=relaxed/simple;
	bh=7Tw2HNt1HVYnuuPGHl3TsAng25V0j2+0BlRcBB9eRyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoxmS++kkcCkTZtTOPWWKQYnVPCopz6pOw3HmKsHUVuGgHoqduTdDeSF9yijneZLY2Vby9a7skRWMtu0lCve7KtfDO+NH2WPu6eYVgYySSjGaRDOhBtssj8IWC6GFpX4YHFZKwLFyWqh9SVuiojwMWvKdq/vhl5b8fM3lzHj/Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N7qj1/Dr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D5C342E80;
	Sat,  8 Mar 2025 13:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741442055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mby0pUW4UzyD8b5PxL0LFse+sgWHkla2gTE4ym797V0=;
	b=N7qj1/DrHrZYEYp8euvYLYqXa7PgQlXaDKSBg1HQxwPK/ERo4pgBFpJx181IwAmNAdD8mX
	9mIZ1HUxE27Vf/kd9Jsh4Mw8vv7sQiSWPBB885YO0k1qf3ivSiNlwe9Jvq7Erluo9jTw4m
	yJ8KN120Mz1d0yIVwcdyQAeDlGsClPuuvHJKsXvNoccwTACCy8XC4lVbfmMQNEIKxLSkSI
	T9vZCnyLx7xPNfpXrblQFQpmTayKN6Xmb5iypXYECZyR8cdJpnrzpxeKRv02YON5AfQ1IE
	FaUpnKUqRffabE6iaH8nrp7mn0z7aiFyCH/ufscm3c2Ue2BMeSqr2PH2jVhUZQ==
Date: Sat, 8 Mar 2025 14:54:12 +0100
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
Subject: Re: [PATCH net-next v2 2/7] net: usb: lan78xx: Move fixed PHY
 cleanup to lan78xx_unbind()
Message-ID: <20250308145412.1f7944d4@fedora.home>
In-Reply-To: <20250307182432.1976273-3-o.rempel@pengutronix.de>
References: <20250307182432.1976273-1-o.rempel@pengutronix.de>
	<20250307182432.1976273-3-o.rempel@pengutronix.de>
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

On Fri,  7 Mar 2025 19:24:27 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Move the cleanup of the fixed PHY to the lan78xx_unbind() function,
> which is invoked during both the probe and disconnect paths.  This
> change eliminates duplicate cleanup code in the disconnect routine and
> ensures that the fixed PHY is properly freed during other probe steps.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

The commit message looks totally unrelated to the content of the patch
:(

Maxime

>  drivers/net/usb/lan78xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 01967138bc8c..4efe7a956667 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -2688,8 +2688,8 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
>  
>  	ret = phylink_connect_phy(dev->phylink, phydev);
>  	if (ret) {
> -		netdev_err(dev->net, "can't attach PHY to %s\n",
> -			   dev->mdiobus->id);
> +		netdev_err(dev->net, "can't attach PHY to %s, error %pe\n",
> +			   dev->mdiobus->id, ERR_PTR(ret));
>  		return -EIO;
>  	}
>  


