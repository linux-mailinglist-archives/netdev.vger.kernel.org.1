Return-Path: <netdev+bounces-176481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6161DA6A822
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1DC1886BAD
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5960321CC6A;
	Thu, 20 Mar 2025 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RnjYKOkT"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959B6EEBA;
	Thu, 20 Mar 2025 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479792; cv=none; b=uNrBhCDEcwVdRg3FKrjE5P576O5OxTDcazAMNjyzqC0w2y1tU5ABkmRTaIAxQgPjWbR7+s7EXT9OGBSPt0MbBrHWFB196mYRrvOtS4ngN54ZHchL1FIyNgT60SD0bQCPsevgCmb3HKTF+W2xupZamPapptjPKjJSAdAxVwb04Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479792; c=relaxed/simple;
	bh=3gUsqaE7mUufKOG+8Ij0UulGdSKP7dyRB6jukOjry5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4dK9tmiBtTp6InsfuPnLSryiHUlotFM1WFhkHhRSC1+XK2pRWOntJpWyaWUiS7X1mSxOchuZvfnFjhJbSPHukt4SMLZ3LxWPc0yqnZrGrwcx0S8+z5HHJ+K6smazNI1EfoI0xxdixi5c2v/KZ9jKEQm83Y9WtQnDxiMmAH7ybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RnjYKOkT; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A3AB444F5;
	Thu, 20 Mar 2025 14:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742479787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+k1WKBS8wmBGYzs9sr3LXVqLTZJWa/ILl+XBNscDrbY=;
	b=RnjYKOkToOruA8gtWMfVJQ2lVzosiERg2s/F0lfOMsW+ruPaTOwSBxJrVEsbEBOUHf/zsi
	Taf0zisRRm7yXvuh9Y9N/mcLcRLWcp9ghxNIIYxEdy4JgNKmvIzry06R7k4pdux4r+kp3/
	Jc8HCqJe+bRnGbNoYJ7/HbDSLXy8gId8hxT7K3adtc9V9+q7l8sWWqbpXywAuhYgDoFbLW
	XxgGGb4+afw6A+479MukdQiPptRg7ekdm1cE33XeQWAMLG2GpfHYuROX5G5njn2M6xixjx
	uCjG68LJ3GXjQQhXjXUpVGe1Yppmn19/s3b/4tpGVIw1gaJFCZLHvOOs+TeVfw==
Date: Thu, 20 Mar 2025 15:09:44 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 03/12] net: pse-pd: tps23881: Add support
 for PSE events and interrupts
Message-ID: <20250320150944.6ee054c3@kmaincent-XPS-13-7390>
In-Reply-To: <Z9fu3u34K3-OeDis@pengutronix.de>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
	<20250304-feature_poe_port_prio-v6-3-3dc0c5ebaf32@bootlin.com>
	<Z9fu3u34K3-OeDis@pengutronix.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekgedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehku
 hgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 17 Mar 2025 10:43:58 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Tue, Mar 04, 2025 at 11:18:52AM +0100, Kory Maincent wrote:
> > +static int tps23881_irq_handler(int irq, struct pse_controller_dev *pc=
dev,
> > +				unsigned long *notifs,
> > +				unsigned long *notifs_mask)
> > +{
> > +	struct tps23881_priv *priv =3D to_tps23881_priv(pcdev);
> > +	struct i2c_client *client =3D priv->client;
> > +	int ret, it_mask;
> > +
> > +	/* Get interruption mask */
> > +	ret =3D i2c_smbus_read_word_data(client, TPS23881_REG_IT_MASK);
> > +	if (ret < 0)
> > +		return ret;
> > +	it_mask =3D ret;
> > +
> > +	/* Read interrupt register until it frees the interruption pin. */
> > +	while (true) { =20
>=20
> If the hardware has a stuck interrupt, this could result in an infinite
> loop. max_retries with some sane value would be good.

Ack I will. Do you have a value in mind as a sane value?

> > +
> > +static int tps23881_setup_irq(struct tps23881_priv *priv, int irq)
> > +{
> > +	struct i2c_client *client =3D priv->client;
> > +	struct pse_irq_desc irq_desc =3D {
> > +		.name =3D "tps23881-irq", =20
>=20
> here or in devm_pse_irq_helper() it would be good to add intex suffix to
> the irq handler name.

You mean index? Like the PSE index?
So I will need to add back the support of the PSE index in the series.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

