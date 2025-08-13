Return-Path: <netdev+bounces-213338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B0EB249F2
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A728581E7E
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D812C326A;
	Wed, 13 Aug 2025 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gVOlHXGj"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDAD2C3769;
	Wed, 13 Aug 2025 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089856; cv=none; b=Xw/rd6xM4V5yBlB2Kl5kQNJQ4kTbXxtycn4NQ7O6N3qHaNaO7Fg52M+ak5EpvUvONo2tV/Fv7IpnO9FgMpX9Ox+zU/Qg6qP6UigU3DIhB6oDZcuCvC2dUeTC9MMI5c1EYI9usWYdFrmO2OyZRULh915FsN3L1wTkzZW4qnlK62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089856; c=relaxed/simple;
	bh=MuySi8sGF43XpA/joBh7X59LLJ7d8bjSnCs2l8x7hac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYbVUvvp3illijmZuQbBHTUqdd7obGq7K3ZLCuhOFHiuYj/ya5W3qAoZuWrEUo6ReqArI/joWxjO5h3FQp9V/A5Q5fjC3jHzZe1/eup2PVgFVr/lZ8MSukviA2eM8EPF9ZOPXJUkCXc3ytngkAMzQb/vPqoBex2vNCPaAOq4Dn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gVOlHXGj; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B2175443D7;
	Wed, 13 Aug 2025 12:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755089852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LqS3Q6phEP/DPZ1mfnaxML62/DqcKCkwjx/UApUTUU=;
	b=gVOlHXGjsNr7KKDk0ZThJ8H4IXjAesO9gnPORc9Hn7ogm83F7yP6JmgoWOfLIrE493k00U
	n17vG/wzSpbdBwpSljfKhC7TRbalHJK9PbUcAq6o2FiWScgNN8PgzE45UcBv5oECk5Qpw8
	YLernhmInIHUyggWMz+FGQ7pTO3lgfGXlvvD8ORWOf1kgchoHwN9RZvG3T8WZk7m6KKInf
	znJaz1lZYjaE2gtDfjTXwcRV1AXRPaq1h+dmLau6+rvwnWngjyKF9W3Va2/Za4MmApGylB
	5BkUIrzCeVNYkr4dNQAde8XlcOIIw+AwQ7yx/6KnKSxdsJaFd21BOP6Ma1Hbqg==
Date: Wed, 13 Aug 2025 14:57:30 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Michal Kubecek
 <mkubecek@suse.cz>, Dent Project <dentproject@linuxfoundation.org>, Kyle
 Swenson <kyle.swenson@est.tech>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH ethtool v2 2/3] ethtool: pse-pd: Add PSE priority
 support
Message-ID: <20250813145730.0b47e26e@kmaincent-XPS-13-7390>
In-Reply-To: <aJyEMob8kFAvD-HU@pengutronix.de>
References: <20250813-b4-feature_poe_pw_budget-v2-0-0bef6bfcc708@bootlin.com>
	<20250813-b4-feature_poe_pw_budget-v2-2-0bef6bfcc708@bootlin.com>
	<aJyEMob8kFAvD-HU@pengutronix.de>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepp
 hgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehmkhhusggvtggvkhesshhushgvrdgtiidprhgtphhtthhopeguvghnthhprhhojhgvtghtsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

Le Wed, 13 Aug 2025 14:25:22 +0200,
Oleksij Rempel <o.rempel@pengutronix.de> a =C3=A9crit :

> Hi Kory,
>=20
> Thank you for your work! Here are some review comments...

Hello Oleksij,

>=20
> On Wed, Aug 13, 2025 at 10:57:51AM +0200, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > Add support for PSE (Power Sourcing Equipment) priority management:
> > - Add priority configuration parameter (prio) for port priority managem=
ent
> > - Display power domain index, maximum priority, and current priority
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >  ethtool.8.in     | 13 +++++++++++++
> >  ethtool.c        |  1 +
> >  netlink/pse-pd.c | 29 +++++++++++++++++++++++++++++
> >  3 files changed, 43 insertions(+)
> >=20
> > diff --git a/ethtool.8.in b/ethtool.8.in
> > index 29b8a8c..163b2b0 100644
> > --- a/ethtool.8.in
> > +++ b/ethtool.8.in
> > @@ -561,6 +561,7 @@ ethtool \- query or control network driver and hard=
ware
> > settings .RB [ c33\-pse\-admin\-control
> >  .BR enable | disable ]
> >  .BN c33\-pse\-avail\-pw\-limit N
> > +.BN prio N
> >  .HP
> >  .B ethtool \-\-flash\-module\-firmware
> >  .I devname
> > @@ -1911,6 +1912,15 @@ This attribute specifies the allowed power limit
> > ranges in mW for configuring the c33-pse-avail-pw-limit parameter. It
> > defines the valid power levels that can be assigned to the c33 PSE in
> > compliance with the c33 standard.
> > +.TP
> > +.B power-domain-index
> > +This attribute defines the index of the PSE Power Domain. =20
>=20
> May be:
>=20
> Reports the index of the PSE power domain the port belongs to. Every
> port belongs to exactly one power domain. Port priorities are defined
> within that power domain.
>=20
> Each power domain may have its own maximum budget (e.g., 100 W per
> domain) in addition to a system-wide budget (e.g., 200 W overall).
> Domain limits are enforced first: if a single domain reaches its budget,
> only ports in that domain are affected. The system-wide budget is
> enforced across all domains; only when it is exceeded do cross-domain
> priorities apply.

Thanks for the doc review!
Maybe we should not talking about cross-domain priority yet, we don't know =
how
PSE are supposed to behave on that specific case.=20

...

> > +	if (tb[ETHTOOL_A_PSE_PRIO]) {
> > +		u32 val;
> > +
> > +		val =3D mnl_attr_get_u32(tb[ETHTOOL_A_PSE_PRIO]);
> > +		print_uint(PRINT_ANY, "priority", "Priority %u\n", val); =20
>=20
> missing colon
> 		print_uint(PRINT_ANY, "priority", "Priority: %u\n", val);

Well spotted, thanks!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

