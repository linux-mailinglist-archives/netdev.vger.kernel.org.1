Return-Path: <netdev+bounces-169478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B35A44271
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 15:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC6117A900
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C0D26A0CB;
	Tue, 25 Feb 2025 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hGy97bFZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24C3256C62;
	Tue, 25 Feb 2025 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493045; cv=none; b=hfpVhLTum841mlS1t5BFqv1JgayTWr5xG/9sniUqzdrKp60bbObpHENjNr+ghf/y0ajPuMWwV7XLJlU7K3tWmo0JKJLkcajDaI4B0Tz9A4gC+sf+qdjEv651Wh7E3ivzP+JlCp2vpEbP1GjA6Ndj4dsdbNwcRT/Wlz4a1SUrdj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493045; c=relaxed/simple;
	bh=b/ETh82ccROWlFBnVJoGXaUDJ3XwJUdAkS0sAfZEHpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/HIz0ydc/DJDWZpOlwribjzGU3nLOQ8xq2Eo2Zw55V3curdTDNYIQjiWNHxgPT1SV+eaF7/XZ3+2PuBT3zyD+2PMVWLUK59t1DuvluUzs4d5PdTvzk2DgmtLccLV4sYf58BplE7nhaJSCud5e7wxVQuTladYx1EOvQM87N0s/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hGy97bFZ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B6E4043425;
	Tue, 25 Feb 2025 14:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740493042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mY5FfQ+FK/SGrOr5TQi4sZrUW2dqPRYoNVeQLnDmxMg=;
	b=hGy97bFZf5CYDUbjbclD2/EryWItej2SmmkPIpvJcm5/vQRnqwCPoMwpaE3Sc4N0n4ncS9
	264lUdNYZvNOG1I4IIS55EMlKC5aR7vuW6jpEIIlX2+rS+vN4tszJTsidhgFuDUpbSZAZZ
	FlPZc8RU1Fwz7Mdw4YyqsaCgTa25u0Pp8zqV2pC/nkpfeUoYxsv6/eFApt2jekCY8FIj0D
	/zlP+xkMS5jrI0JIr6F4b2QZh8SFabLUItIcMb0JPiNH8qmGETMMbF314nj6cBzM69ZLm0
	Kn+IQM5qQwr73LZVAm6HZsqwaXSIuNSo7kcqx4c5ZRQQKN94uFLd8/vWLXAfDg==
Date: Tue, 25 Feb 2025 15:17:20 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Simon
 Horman <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next 12/13] net: phy: phylink: Use phy_caps_lookup
 for fixed-link configuration
Message-ID: <20250225151720.29911b4b@fedora.home>
In-Reply-To: <20250224150440.7fe5458d@kmaincent-XPS-13-7390>
References: <20250222142727.894124-1-maxime.chevallier@bootlin.com>
	<20250222142727.894124-13-maxime.chevallier@bootlin.com>
	<20250224144431.2dca9d19@kmaincent-XPS-13-7390>
	<Z7x52C5dE3eXWomq@shell.armlinux.org.uk>
	<20250224150440.7fe5458d@kmaincent-XPS-13-7390>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemtggtfegtmeeglehfgeemfeeiheehmegsheejgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegttgeftgemgeelfhegmeefieehheemsgehjeegpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhof
 hhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Mon, 24 Feb 2025 15:04:40 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> On Mon, 24 Feb 2025 13:53:28 +0000
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Mon, Feb 24, 2025 at 02:44:31PM +0100, Kory Maincent wrote:  
> > > On Sat, 22 Feb 2025 15:27:24 +0100
> > > Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> > >     
> > > > When phylink creates a fixed-link configuration, it finds a matching
> > > > linkmode to set as the advertised, lp_advertising and supported modes
> > > > based on the speed and duplex of the fixed link.
> > > > 
> > > > Use the newly introduced phy_caps_lookup to get these modes instead of
> > > > phy_lookup_settings(). This has the side effect that the matched
> > > > settings and configured linkmodes may now contain several linkmodes (the
> > > > intersection of supported linkmodes from the phylink settings and the
> > > > linkmodes that match speed/duplex) instead of the one from
> > > > phy_lookup_settings().    
> > > 
> > > ...
> > >     
> > > >  
> > > >  	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, mask);
> > > >  	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, mask);
> > > > @@ -588,9 +591,9 @@ static int phylink_parse_fixedlink(struct phylink *pl,
> > > >  
> > > >  	phylink_set(pl->supported, MII);
> > > >  
> > > > -	if (s) {
> > > > -		__set_bit(s->bit, pl->supported);
> > > > -		__set_bit(s->bit, pl->link_config.lp_advertising);
> > > > +	if (c) {
> > > > +		linkmode_or(pl->supported, pl->supported, match);
> > > > +		linkmode_or(pl->link_config.lp_advertising,
> > > > pl->supported, match);    
> > > 
> > > You are doing the OR twice. You should use linkmode_copy() instead.    
> > 
> > No, we don't want to copy pl->supported to
> > pl->link_config.lp_advertising. We just want to set the linkmode bit
> > that corresponds to the speed/duplex in each mask.
> > 
> > That will result in e.g. the pause mode bits will be overwritten despite
> > being appropriately set in the advertising mask in the code above this.  
> 
> Ok, so the right thing should be this:
> linkmode_or(pl->link_config.lp_advertising, pl->link_config.lp_advertising,
> 	    match)

That looks right indeed, I'll address that for the next iteration.

Thanks for reviewing,

Maxime

