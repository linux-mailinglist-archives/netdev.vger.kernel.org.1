Return-Path: <netdev+bounces-50194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569977F4E0D
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 18:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8777A1C20A8C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC5857888;
	Wed, 22 Nov 2023 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KUA08b5U"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA73191;
	Wed, 22 Nov 2023 09:16:50 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D9EEC60005;
	Wed, 22 Nov 2023 17:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700673409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=96QYHoZIDIT+pxG6t2aqCRbFyqHy2hKopbA6OtGC0ug=;
	b=KUA08b5UpgDVT1Kju2OmlHYuYPXgqPrvOrFBHuw1abLqkrs5cPxtdYXHtnbwYAM8lelA88
	jm1PutjS30gkjtNygopDI5oZa0aJYFHh7SRzlVxIaoMc7obiW98oKo9db1aOdIPGCW+A+C
	Ash1xYvo6E/RUmxVsIOS+G3F2KZajj+gPzSNz2utAQUa+X+rnPhvWsIVFLRCs4mq64rsBG
	8B7O9KyJl52TiZ+/MIssxF4mxVn1/f9NlVuCbIJ2wlGym9utHkXm9tApy4zUQC6HIOOp86
	x8o7ABaAu2TcLEwT2lNVvP6XDl3FtfSjSIZQbG8r9V97Vf2j85MUjhDjUTDdDQ==
Date: Wed, 22 Nov 2023 18:16:47 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 9/9] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <20231122181647.06d9c3c9@kmaincent-XPS-13-7390>
In-Reply-To: <04f59e77-134b-45b2-8759-84b8e22c30d5@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
	<20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
	<2ff8bea5-5972-4d1a-a692-34ad27b05446@lunn.ch>
	<20231122171112.59370d21@kmaincent-XPS-13-7390>
	<04f59e77-134b-45b2-8759-84b8e22c30d5@lunn.ch>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 22 Nov 2023 17:54:53 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > > > +static int pd692x0_sendrecv_msg(struct pd692x0_priv *priv,
> > > > +				struct pd692x0_msg *msg,
> > > > +				struct pd692x0_msg_content *buf)
> > > > +{
> > > > +	struct device *dev =3D &priv->client->dev;
> > > > +	int ret;
> > > > +
> > > > +	ret =3D pd692x0_send_msg(priv, msg);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret =3D pd692x0_recv_msg(priv, msg, buf);   =20
> > >=20
> > > So this function takes at least 10 seconds? =20
> >=20
> > No, on normal communication it takes a bit more than 30ms. =20
>=20
> So i think the first step is to refactor this code to make it clear
> what the normal path is, and what the exception path is, and the
> timing of each.

Ok I will try to refactor it to makes it more readable.

> > > > +	msg.content.sub[2] =3D id;
> > > > +	ret =3D pd692x0_sendrecv_msg(priv, &msg, &buf);   =20
> > >=20
> > > So this is also 10 seconds?=20
> > >=20
> > > Given its name, it looks like this is called via ethtool? Is the
> > > ethtool core holding RTNL? It is generally considered bad to hold RTN=
L for
> > > that long. =20
> >=20
> > Yes it is holding RTNL lock. Should I consider another behavior in case=
 of
> > communication loss to not holding RTNL lock so long? =20
>=20
> How often does it happen? On the scale of its a theoretical
> possibility, through to it happens every N calls? Also, does it happen
> on cold boot and reboot?
>=20
> If its never supposed to happen, i would keep holding RTNL, and add a
> pr_warn() that the PSE has crashed and burned, waiting for it to
> reboot. If this is likely to happen on the first communication with
> the device, we might want to do a dummy transfer during probe to get
> is synchronized before we start using it with the RTNL held.

I would say it never supposed to happen.
I never faced the issue playing with the controller. The first communicatio=
n is
a simple i2c_master_recv of the controller status without entering the
pd692x0_sendrecv_msg function, therefore it won't be an issue.

Another solution could be to raise a flag if I enter in communication loss =
and
release the rtnlock. We would lock again the rtnl when the flags got disabl=
ed.
The controler won't be accessible until the flag is disabled.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

