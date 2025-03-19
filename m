Return-Path: <netdev+bounces-176076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F66EA689FB
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C113BE6ED
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 10:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251692505B2;
	Wed, 19 Mar 2025 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qkco05SA"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5BB157E99;
	Wed, 19 Mar 2025 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381296; cv=none; b=s6cxo59wvgNoKGfEiFgEARay9YQER/G/27T1E7TJQFse2ifLX4zSqjOHY9sEli0+zwShsKsYMGEZDIKTEtCrHQlCHwV8jmr8fJokKB13RaQvdm+64bL0cpRdBn5heXbI1+TfUgiZgC+evH8sQayY860MSsQFc3GQ0SCnMnZbNJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381296; c=relaxed/simple;
	bh=jllMXrVcXsNGnx2TJKhvq7lN7ipa5KTwy5lutJvlubA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKtde2uK/Vb0/9dwApIT7yyICqf9/UVOPCV++W78+xYkRgxVcx9tIuLiwtmJOKk7KV4g4tv1m6lV/5KghCFL/sVvN0MIFbUTjUskLHtHCgcbbGoL6YXP+9+S/92j/5+xyBerETWFZMszpSem71fcmeOyz4GFLkALA/+5ObnP5+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qkco05SA; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2055244292;
	Wed, 19 Mar 2025 10:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742381286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0VN1Fjl61TNtzzgu0qljQ1cxV5vW70ntadpK7WZDMQ=;
	b=Qkco05SAh2DcOjV4dh6ffFgXUq28V9GBSdXffJgl17CrjWDOsVcY7dmaUIqeiqRmzhJ5/F
	BKT5v+KdNxUBYNJUPrGmCmXmV6QGx4ZSykUKU4X+MyBs+LYN1EZL+duObIVt7YjyDRCxZZ
	Ahzte25ayArKuoyvb6/b7BLmSoZiUEmExVOWSL1xMeA7EcV7aHqzaVHjbEttxbJkWJaVFU
	EC2zID+Jt3etaq9HzwblCoyv5Jf+cOWJ0K4nRC56u4qpxHwZSg1wUmtKfxomg8AOQ/9smR
	w0rlHc8MhInDfaAXWlnHsuHNxvg/96NxCGMqrIrnp5yGCAIpJC0czcf8cWZ0HA==
Date: Wed, 19 Mar 2025 11:48:02 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Russell King <rmk+kernel@armlinux.org.uk>,
 Thangaraj Samynathan <Thangaraj.S@microchip.com>, Rengarajan Sundararajan
 <Rengarajan.S@microchip.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>, Simon
 Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v5 2/6] net: usb: lan78xx: Convert to PHYlink
 for improved PHY and MAC management
Message-ID: <20250319114802.4d470655@fedora.home>
In-Reply-To: <20250319084952.419051-3-o.rempel@pengutronix.de>
References: <20250319084952.419051-1-o.rempel@pengutronix.de>
	<20250319084952.419051-3-o.rempel@pengutronix.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrt
 ghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeifohhojhhunhhgrdhhuhhhsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehrmhhkodhkvghrnhgvlhesrghrmhhlihhnuhigrdhorhhgrdhukh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Oleksij,

On Wed, 19 Mar 2025 09:49:48 +0100
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
> - update lan78xx_get/set_pause to use phylink helpers
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>


[...]

> @@ -5158,7 +5137,7 @@ static int lan78xx_reset_resume(struct usb_interface *intf)
>  	if (ret < 0)
>  		return ret;
>  
> -	phy_start(dev->net->phydev);
> +	phylink_start(dev->phylink);

You need RTNL to be held when calling this function.

I'm not familiar with USB but from what I get, this function is part of
the resume path (resume by resetting). I think you also need to
address the suspend path, it still has calls to
netif_carrier_off(dev->net), and you may need to use
phylink_suspend() / phylink_resume() ? (not sure)

Maxime

