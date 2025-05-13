Return-Path: <netdev+bounces-190023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C52AB5025
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB89C7A31D1
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE04239085;
	Tue, 13 May 2025 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gb+AFHD/"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2601E9B12;
	Tue, 13 May 2025 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129463; cv=none; b=KAZJmjMpXeacp6noNX9ggRESHWo12rp6mt7Osl+Oh+R9vXqr8ttr6Ytp/PO21lapSs0IqH8vjiVb5IEyqRoodTrvDxM6/9YEc9I+jZ7AN9otpfE4zu8ybnSoZ0FLNfMdhcVHAOMYg2ZD9y/Nl360ItgASM/ilUfm8BgBa+0YrNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129463; c=relaxed/simple;
	bh=FCLE3Sish6sJWT92hus12ytHM+hbiyV8B6C7X2tTk8o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0SKZZqIIYsGfV4leKaQt9G8G1Cge3ZXC85u9u6t+DMPcaQhxvg57VB/iGcKyF9AD9JAiqLqDmSwcY3wqw3rZArdt9Eufkz9HQ+Yre7P82v8/rQ6OB1AnkLiOf6cpdaWkjHn2l1si0gm7hK+WxyPJFmRYIeq+d2elDPFXX2i8Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gb+AFHD/; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D51D43AD2;
	Tue, 13 May 2025 09:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747129452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mE82WGnbCCvrXYireTZju6owhNfokw4sOSCiM1zr2e0=;
	b=Gb+AFHD/SQUWevkmVYSDlRjy1sAPR1xJFtl8IuFOYsKPvFDaGlLyRS/+edzz/eKYcNhqVa
	XTZ/LnTmMSRlCk/JbadJLvCi4/8DvhJRO5zpIK3oCyK+9nJ/RSF7IuTKZ4u1tNpvPGBYjx
	7zDV7gypVkZ0QKgfejatW4Reyf3/Ii2OeK7pWPd7Wy9cB6qwdpAcHXolibNz8QSOPkQNZs
	BsPg8bY3eLUJM68KPbiPmM0nRdnKC38Yw2ZpRHj1IJgtxkbuos/Shn+AE+D48I1Vs1p1xn
	/n6jcagI+T9Q7umwrQVduMCSm8cU5avN3pDHwS8Qd4DnjGiJ9DmEspk1FzBY3A==
Date: Tue, 13 May 2025 11:44:09 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 02/13] net: pse-pd: Add support for
 reporting events
Message-ID: <20250513114409.6aae3eb9@kmaincent-XPS-13-7390>
In-Reply-To: <20250508201041.40566d3f@kernel.org>
References: <20250506-feature_poe_port_prio-v10-0-55679a4895f9@bootlin.com>
	<20250506-feature_poe_port_prio-v10-2-55679a4895f9@bootlin.com>
	<20250508201041.40566d3f@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdefkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 8 May 2025 20:10:41 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 06 May 2025 11:38:34 +0200 Kory Maincent wrote:
> > diff --git a/Documentation/netlink/specs/ethtool.yaml
> > b/Documentation/netlink/specs/ethtool.yaml index c650cd3dcb80..fbfd2939=
87c1
> > 100644 --- a/Documentation/netlink/specs/ethtool.yaml
> > +++ b/Documentation/netlink/specs/ethtool.yaml
> > @@ -98,6 +98,12 @@ definitions:
> >      name: tcp-data-split
> >      type: enum
> >      entries: [ unknown, disabled, enabled ]
> > +  -
> > +    name: pse-events
> > +    type: flags
> > +    name-prefix: ethtool-pse-event-
> > +    header: linux/ethtool.h
> > +    entries: [ over-current, over-temp ] =20
>=20
> please change this enum similarly to what I suggested on the hwts
> source patch

Ok.
=20
> >  attribute-sets:
> >    -
> > @@ -1528,6 +1534,18 @@ attribute-sets:
> >          name: hwtstamp-flags
> >          type: nest
> >          nested-attributes: bitset
> > +  -
> > +    name: pse-ntf
> > +    attr-cnt-name: __ethtool-a-pse-ntf-cnt =20
>=20
> please use -- instead of underscores

All the other attributes are using underscore in this property.
Are you sure about this?

> > +			phydev =3D psec->attached_phydev;
> > +			if (phydev->attached_dev) {
> > +				netdev =3D phydev->attached_dev;
> > +				netdev_hold(netdev, tracker, GFP_ATOMIC); =20
>=20
> GFP_KERNEL ?

Oops indeed, small copy paste mistake.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

