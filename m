Return-Path: <netdev+bounces-173983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7BAA5CC33
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 18:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4713B502A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 17:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7051F25A648;
	Tue, 11 Mar 2025 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OM93F3xA"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C461876;
	Tue, 11 Mar 2025 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714275; cv=none; b=NKD0FhCB0BMUoH4YUDYZsLlfGz5+wruea0tt0oFnIrJX7p91UePxYxJXVeUzha0YcCK2Fhb4+yF+Q6Pp7C6igIRK+0H/sfQHI1BR6JhbYjySFWNarIMVwBRMpiDce5dPO/yP8XvxombV6h1uyo51IPC5k4hqeFiyT/u8jdlkkDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714275; c=relaxed/simple;
	bh=YnU39UTdrkK967CS5QBoK9SJMChpCj6ucq5fmt6tDlI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2JdmLZkdGTH5mkumBrjXs2neLqP6AMwFasAcOxwNKoLGM+prpsXXG7hAzuSNWKI9lTjCBJbVKPwnkqYSN1NUQcMvNlbQf7Qx3Qn1UEKKPfqFOVoayY/vzMKwvd4SyTFYj/ootTRkbNnMoPaiTWxUs5fHzth+02W/YOFPkhBM8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OM93F3xA; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F194A441B3;
	Tue, 11 Mar 2025 17:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741714264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4ce7XpyqCF9Ov39zRPIKLWSbFCk4LaFJEpsxtfdhHI=;
	b=OM93F3xA1g51io8YkQQiFUSlwLnXaX/o9Sao+TxG8GIwmnE/IkiiXGf/hzopkxgEo3X5gd
	6a2oA/4x0nw9LOqZq3EBk0+ZyXcP0ps4ae7oRhF4+6ypnxFk1cflI9WZSmVW276cBmlzM1
	admySuOuqaG81EDCsPfneFXG/0Pj1bI7lTUhMDuVK+fUzxagAWTPYKMoAfhhU+7+tsCKul
	hPfG9FW8ysuzHO6EXJt3uSo1gI4ZytzA71Ju0KKi99qebyIJz2dnATeeRJ9T3L2vicI4/3
	ilT2NHvUuKBe2oEyeIgJqn4jn4AAmeQcQz/hP4H3N+zXjCjK4J40ECGYRiC0mw==
Date: Tue, 11 Mar 2025 18:31:01 +0100
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
Subject: Re: [PATCH net-next v3 6/7] net: usb: lan78xx: Transition
 get/set_pause to phylink
Message-ID: <20250311183101.5192c3df@fedora.home>
In-Reply-To: <20250310115737.784047-7-o.rempel@pengutronix.de>
References: <20250310115737.784047-1-o.rempel@pengutronix.de>
	<20250310115737.784047-7-o.rempel@pengutronix.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvkeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrt
 ghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeifohhojhhunhhgrdhhuhhhsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehrmhhkodhkvghrnhgvlhesrghrmhhlihhnuhigrdhorhhgrdhukh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Oleksij,

On Mon, 10 Mar 2025 12:57:36 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Replace lan78xx_get_pause and lan78xx_set_pause implementations with
> phylink-based functions. This transition aligns pause parameter handling
> with the phylink API, simplifying the code and improving
> maintainability.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

Some very minor things below :

>  drivers/net/usb/lan78xx.c | 51 ++-------------------------------------
>  1 file changed, 2 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 7107eaa440e5..3aa916a9ee0b 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -1878,63 +1878,16 @@ static void lan78xx_get_pause(struct net_device *net,
>  			      struct ethtool_pauseparam *pause)
>  {
>  	struct lan78xx_net *dev = netdev_priv(net);
> -	struct phy_device *phydev = net->phydev;
> -	struct ethtool_link_ksettings ecmd;
> -
> -	phy_ethtool_ksettings_get(phydev, &ecmd);
> -
> -	pause->autoneg = dev->fc_autoneg;
>  
> -	if (dev->fc_request_control & FLOW_CTRL_TX)
> -		pause->tx_pause = 1;
> -
> -	if (dev->fc_request_control & FLOW_CTRL_RX)
> -		pause->rx_pause = 1;
> +	phylink_ethtool_get_pauseparam(dev->phylink, pause);
>  }
>  
>  static int lan78xx_set_pause(struct net_device *net,
>  			     struct ethtool_pauseparam *pause)
>  {
>  	struct lan78xx_net *dev = netdev_priv(net);
> -	struct phy_device *phydev = net->phydev;
> -	struct ethtool_link_ksettings ecmd;
> -	int ret;
> -
> -	phy_ethtool_ksettings_get(phydev, &ecmd);
> -
> -	if (pause->autoneg && !ecmd.base.autoneg) {
> -		ret = -EINVAL;
> -		goto exit;
> -	}
>  
> -	dev->fc_request_control = 0;
> -	if (pause->rx_pause)
> -		dev->fc_request_control |= FLOW_CTRL_RX;
> -
> -	if (pause->tx_pause)
> -		dev->fc_request_control |= FLOW_CTRL_TX;

Sorry not to have spotted that before, but after that patch you no
longer need dev->fc_request_control, you can get rid of that in
struct lan78xx_net.

Related to other patches (probably patch 1), it also appears you can get
rid of :
 - dev->fc_autoneg
 - dev->interface
 - dev->link_on

Thanks,

Maxime

