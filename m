Return-Path: <netdev+bounces-190410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B808EAB6BE6
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A9357B4D86
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 12:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE4227A442;
	Wed, 14 May 2025 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PBG6VKrN"
X-Original-To: netdev@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C542327934B;
	Wed, 14 May 2025 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227407; cv=none; b=her2OU65OIuQ4Ofp9yynEfKRztunrRH1YWvoqT6TizPjHkYf3TD8JPsF2Prktsb5R3pvbcLrznHL5UX3UIlOyRjVnpTNIN+CxG/fGFaIgaZUJhKXQEQmRYx0WtO0c7F9u7qLyzdezjEc1S7/d9Zd0ODzwwgFuDmRiM+WpgCmSf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227407; c=relaxed/simple;
	bh=NX/VvfyT3yx4Tep6l3birVN50K6v721rMzQfg9guXs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fus3hUWeloUmXqlVdypnPJkwpm7W8E83IJnqPdWWqySS0qo2TBuwqk/XBRHyK7P2NrRkHkP1WOTKxD6KXPlRlcCpRWHEEbTflPAJbGCRP+sFdg/+eIVUjjBVu53ZcPUL13XL/c6sf4hOjc5AfZuKU3QpaIAoLAz9XDjeobsVJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PBG6VKrN; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 3DB4258309E;
	Wed, 14 May 2025 12:32:08 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1252E42D43;
	Wed, 14 May 2025 12:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747225927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pjPEOeClLl5IrMnfRqcS70xURLRIMkwA33VVWgiUGOA=;
	b=PBG6VKrNjxcPNI7qF1o9rk8f9Jb7Pgchx2d3X8+YOdJ8NGPD9LDHlb4gUWb1JXsjJ4al1q
	CiB8fba/7GQQMUJZeemX9GiPgIY6sidHf9duyfp8k5lDb84Q4WwiX0jR8BURvESxpWubcm
	PCVKKe8eDpgt38irBLTe9aD45TUcuA1mqIJ3ISEggndXjCiGwdBOFQNKNZP8ZiVKxo5IRr
	5Ni5EACRi3BpR8pVZrZzxNbs1vVxHqbrWvLzrQD38Mmf6KS0NY6CX2/pRIz1cbEhGGBn2H
	xSAQ7IuzxMEZnQaDYBJhQGZ6twbAbtt0dZe0Zb3cpteTxLr1ZM0/r6SVRgHEdg==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net-next 3/3] net: phy: dp83869: Support 1000Base-X SFP modules
Date: Wed, 14 May 2025 14:32:00 +0200
Message-ID: <10709391.nUPlyArG6x@fw-rgant>
In-Reply-To: <99c9d8f8-1557-4f90-8762-b04a09cb497c@lunn.ch>
References:
 <20250514-dp83869-1000basex-v1-0-1bdb3c9c3d63@bootlin.com>
 <20250514-dp83869-1000basex-v1-3-1bdb3c9c3d63@bootlin.com>
 <99c9d8f8-1557-4f90-8762-b04a09cb497c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2360622.iZASKD2KPV";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejtddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhggtgesghdtreertddtjeenucfhrhhomheptfhomhgrihhnucfirghnthhoihhsuceorhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeetveeileegkeetvefgtdegffdviefgvdevkefhgfetieffvddvkedujeefvdfgtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehffidqrhhgrghnthdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtp
 hhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: romain.gantois@bootlin.com

--nextPart2360622.iZASKD2KPV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 14 May 2025 14:32:00 +0200
Message-ID: <10709391.nUPlyArG6x@fw-rgant>
In-Reply-To: <99c9d8f8-1557-4f90-8762-b04a09cb497c@lunn.ch>
MIME-Version: 1.0

On Wednesday, 14 May 2025 14:22:48 CEST Andrew Lunn wrote:
> > +static int dp83869_port_configure_serdes(struct phy_port *port, bool
> > enable, +					 phy_interface_t interface)
> > +{
> > +	struct phy_device *phydev = port_phydev(port);
> > +	struct dp83869_private *dp83869;
> > +	int ret;
> > +
> > +	if (!enable)
> > +		return 0;
> > +
> > +	dp83869 = phydev->priv;
> > +
> > +	switch (interface) {
> > +	case PHY_INTERFACE_MODE_1000BASEX:
> > +		dp83869->mode = DP83869_RGMII_1000_BASE;
> > +		break;
> > +	default:
> > +		phydev_err(phydev, "Incompatible SFP module inserted\n");
> > +		return -EINVAL;
> > +	}
> 
> There is also DP83869_RGMII_SGMII_BRIDGE. Can this be used with the
> SERDES? Copper SFPs often want SGMII.

It can definitely be used to support non-DAC copper modules. In fact, I've 
implemented support for these modules locally, but I'm planning to upstream 
this part of the SFP support later, as there is some additional trickiness to 
solve beforehand.

To quickly summarize the issue, non-DAC copper module support requires reading 
autonegotiation results from the downstream PHY and relaying them back to the 
MAC. This requires some kind of stacked PHY support in the kernel, which has 
been in discussion for a while now:

https://lore.kernel.org/all/20241119115136.74297db7@fedora.home/

So as things currently stand, SGMII SFP support in this driver is blocked 
until some kind of generic stacked PHY support is implemented in the kernel.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart2360622.iZASKD2KPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEYFZBShRwOvLlRRy+3R9U/FLj284FAmgkjUAACgkQ3R9U/FLj
284zdhAAk0GTv70YpkAUSlaZox0jB91q0KP0Xtb2qb5CEH0UC3M4Uxehx2No5VUT
+e/SjXEa2FDhcjkewAdJJLVKwhcwKlAIHSGwgVgSXAQqNa+NwMmLytuGbr0qb67k
p7+GG8+wwtKwJdQZP1wrytiS4oDaNO8fsI3xxemGN2GyvOVhJCYmzoh64mWsRy5k
NtoWFvyUa2pGSgstJmrteHhe7RHwWx88FvEJoVyBEU8ju9IgXviAGC7KmFzIAKwO
o6Vyq5GLZ04/KeDMnGpCF/DfNIRNFjCwe0RvXXyEyLDg3YVvf4xJmYnv6NcLeyQ2
YZp822nkowXBIjS+X9XWI5Zv+n7ZGDLdH4vmZZ5T1NzdvKCtJr6QW1DM6KNeaQfi
MRtBvqb+P0V4BUJxv6Cbsh53ZRWk75da7Vhd4uRaxR7B1YSiH45z792mbpZH/Cu0
xSPHMT7kPlwYVCo1yM6B+4pBHBKx8x4KnvHckPiq1CNoV7tj9ZC8H/xOq0C9fNtY
W8l3a9tw3Ad0yvuMregIXJT+xLPg4TkZ8XMbyrdPXt0S/o1be9zpMc+CLZtHc+rr
KyLfoKV+SBz3nlgqBQ0anKmfQ10DCZtm1PuZsiMmzXdbjEiXuX/Y5e4RYq72w6NE
OjH5wvb+dieD2SGjo0gCA2j7L+SluDcYll16smY9HtWDmQW8IA4=
=QjE0
-----END PGP SIGNATURE-----

--nextPart2360622.iZASKD2KPV--




