Return-Path: <netdev+bounces-212914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B18CDB227ED
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99FD51AA7B2F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6EB281378;
	Tue, 12 Aug 2025 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nLVc3lJJ"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4969281509;
	Tue, 12 Aug 2025 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003804; cv=none; b=Gn5O0F1VwR7+JIxi89W5JngqjtFXVlgNlx5izaqVDC9Nt6RAUkAMteHbGd2wBpLBgT2AhYz1BMJZDqbgYQaicHt0edsSBiQaU6/DrW3uxgfC/TfuJ5LwAoK6SYegSjPKWlLInysSNDhKpeQ92jaIRtxin6PM5OORp3OO+XwOeR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003804; c=relaxed/simple;
	bh=O5l9GcLTZ4fkpotFf55vTIX/Omf/gELrNUq5bLR+Dm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRprysMHjZJw02WmfeClrOE6Ov6gyDbS/xEdoGhV14Q5rxBp/dsONdp2OB0yusFnKwYLJp76S8hrR/9i8R7jnc5fuc+3exLTjAlmS9egyO1/dinoy/UlEE1tKRJY7Q/IFbo2hWFKtKO8ioQehPZGurZl/CiO9Mg5I2JDhmdWgYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nLVc3lJJ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BB0B8443BD;
	Tue, 12 Aug 2025 13:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755003799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ha+zfhta6/gd/PsP7pwOyziLi6lhZ0AiBlnU+OeDoJo=;
	b=nLVc3lJJx3bqaPx7a1FbQW0iW77xdWTObr9knoyD0zE58dAeaoKqLO0bzKoCAUaP6WzgqJ
	CoLa/ubKASAyKdb1P9oS4ZbqQ1T6lxljxWGb9ict7mvAArRnPF4tEpt6LxZVMy+42cKHQI
	rZGY32xYc3f1y3SGQcJ6ux5ABqZ9e1aYDoaaYh2AE9UeGYgUKe5zBtsA+CmgDCtSyTO9sC
	CnZ6InPx0lBhr092mUPnp4LsRueG3uLgwy8O785/PKjXlpevmh5mUO5mIkExq1EX6tBhVd
	9gW2lf7JIqDVndQ/QekPtmS0M/Ey9O9NaIgkj6Mfqpjxkqt9DXOg/SGb5jGkUw==
Date: Tue, 12 Aug 2025 15:03:17 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Piotr Kubik <piotr.kubik@adtran.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 2/2] net: pse-pd: Add Si3474 PSE controller
 driver
Message-ID: <20250812150317.76b51f01@kmaincent-XPS-13-7390>
In-Reply-To: <bafdf870-dbc4-4641-b8c0-515375943acc@adtran.com>
References: <2378ee79-db60-45fb-9077-f21e8f7571eb@adtran.com>
	<bafdf870-dbc4-4641-b8c0-515375943acc@adtran.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepphhiohhtrhdrkhhusghikhesrgguthhrrghnrdgtohhmpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvt
 hdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

Le Tue, 12 Aug 2025 11:12:22 +0000,
Piotr Kubik <piotr.kubik@adtran.com> a =C3=A9crit :

> From: Piotr Kubik <piotr.kubik@adtran.com>
>=20
> Add a driver for the Skyworks Si3474 I2C Power Sourcing Equipment
> controller.
>=20
> Driver supports basic features of Si3474 IC:
> - get port status,
> - get port power,
> - get port voltage,
> - enable/disable port power.
>=20
> Only 4p configurations are supported at this moment.
>
> Signed-off-by: Piotr Kubik <piotr.kubik@adtran.com>

...

> +static int si3474_get_of_channels(struct si3474_priv *priv)
> +{
> +	struct pse_pi *pi;
> +	u32 chan_id;
> +	u8 pi_no;
> +	s32 ret;
> +
> +	for (pi_no =3D 0; pi_no < SI3474_MAX_CHANS; pi_no++) {
> +		pi =3D &priv->pcdev.pi[pi_no];
> +		u8 pairset_no;
> +
> +		for (pairset_no =3D 0; pairset_no < 2; pairset_no++) {
> +			if (!pi->pairset[pairset_no].np)
> +				continue;
> +
> +			ret =3D
> of_property_read_u32(pi->pairset[pairset_no].np,
> +						   "reg", &chan_id);
> +			if (ret) {
> +				dev_err(&priv->client[0]->dev,
> +					"Failed to read channel reg
> property\n");
> +				return ret;
> +			}
> +			if (chan_id > SI3474_MAX_CHANS) {
> +				dev_err(&priv->client[0]->dev,
> +					"Incorrect channel number: %d\n",
> chan_id);
> +				return -EINVAL;
> +			}
> +
> +			priv->pi[pi_no].chan[pairset_no] =3D chan_id;
> +			/* Mark as 4-pair if second pairset is present */
> +			priv->pi[pi_no].is_4p =3D (pairset_no =3D=3D 1);

I think we should return and report an error if a PI is configured as a 2 p=
airs
PoE as long as it is not supported by the driver. This could avoid any futu=
re
mistakes from users.

Except from that it seems ok for me.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

