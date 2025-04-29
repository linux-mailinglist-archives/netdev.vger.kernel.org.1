Return-Path: <netdev+bounces-186711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC86AA075F
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D24D8441C7
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537C7288C8F;
	Tue, 29 Apr 2025 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jCzzZ0df"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0AB1CF7AF;
	Tue, 29 Apr 2025 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745919170; cv=none; b=t1IGVQa3OZ/98Yf4LYqMV4K2nr7fQI5u2CXeyz72FhILfRez4fh3DoCnF4PcI0QNqMtSeQN74GPU78kw2pRbP53H8sy2XAMHH7EI04U31DOtEb/3AtEyzgk0/cGyGJGxlwFqcmoGaJ+BJOhlVf0+buWPf8HTNLg3BYI6ao9MXis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745919170; c=relaxed/simple;
	bh=iyrD5fmqLJLdHUw4ZJ+D4a+Bfs8zSL40H6J52M4ie7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdpQa/MGQ1QFt0bwdxGAkYggtyVhbJWgeSqFIzXyQEyMjclH4ITzP3isgUZ2b62FxaRvJojEul0drHHD0Tn/rSvx9VAd68eWpSA57bvv55p2ft2/RMX0gDIZEzzyiuz4F39k6G7BnW269SJ7izwl5dEf0t6BzMDI2/I59fr3lC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jCzzZ0df; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF72B43AF4;
	Tue, 29 Apr 2025 09:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745919165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Ka0Bn71hD5KRGfp1m5vqguPisa5gsBriU33g+DLET0=;
	b=jCzzZ0dfRgp0juitg7OuU93zMJKRcX4KFXXucM1BpINsJ6vfPLqlSI/UXtaDjEZ278uKww
	ZbTbl7XOsfwaZyMlQeahVPokVo7wXVJA/KcjHeou+INDVfRzwcV18Xc+MBS4gRA3Zy7kYo
	KZrgtvXwaE+cZOzij08fOcAXVDlXwrrbAAuILXZ7uLPCbAeNBrkEWKAPU6DjF1OgTplXqV
	AARxMPxalK0d6IJOtAX08doNuknRsA9rB1Lwwb1G/fccrudjTqn+cj4KjMts/RYAL8egA4
	NmmhfalVsnbctzeBA7EmdQW/HMvVx5dCE/8qTrCir7w8XGtu4G9ndMaYJWd2Mw==
Date: Tue, 29 Apr 2025 11:32:41 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet
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
Subject: Re: [PATCH net-next v9 02/13] net: pse-pd: Add support for
 reporting events
Message-ID: <20250429113241.572e3759@kmaincent-XPS-13-7390>
In-Reply-To: <be2ae666-a891-4dee-8791-3773331ce7d7@redhat.com>
References: <20250422-feature_poe_port_prio-v9-0-417fc007572d@bootlin.com>
	<20250422-feature_poe_port_prio-v9-2-417fc007572d@bootlin.com>
	<be2ae666-a891-4dee-8791-3773331ce7d7@redhat.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieefgeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughum
 hgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 29 Apr 2025 11:00:19 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 4/22/25 4:56 PM, Kory Maincent wrote:
> > +/**
> > + * pse_control_find_phy_by_id - Find PHY attached to the pse control id
> > + * @pcdev: a pointer to the PSE
> > + * @id: index of the PSE control
> > + *
> > + * Return: PHY device pointer or NULL
> > + */
> > +static struct phy_device *
> > +pse_control_find_phy_by_id(struct pse_controller_dev *pcdev, int id)
> > +{
> > +	struct pse_control *psec;
> > +
> > +	mutex_lock(&pse_list_mutex);
> > +	list_for_each_entry(psec, &pcdev->pse_control_head, list) {
> > +		if (psec->id =3D=3D id) {
> > +			mutex_unlock(&pse_list_mutex); =20
>=20
> AFAICS at this point 'psec' could be freed and the next statement could
> cause UaF.
>=20
> It looks like you should acquire a reference to the pse control?

Oh indeed, thanks for spotting this issue!

I first though this would be sufficient:=20
phydev =3D psec->attached_phydev;
mutex_unlock(&pse_list_mutex);
return phydev;

But in fact the ethnl_pse_send_ntf(phydev, notifs, &extack) is called witho=
ut
RTNL lock, therefore the phydev could be freed and we could also have an Ua=
F on
the phydev pointer. I will add a rtnl_lock here. Maybe a
get_device(&phydev->mdio.dev) is sufficient but not sure.

Also we really need to throw the ASSERT_RTNL() in the phy_detach function,
because there are still paths where the phy is freed without rtnl. I have a
patch for it, I will try to send it in RFC soon.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

