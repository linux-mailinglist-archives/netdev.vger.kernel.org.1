Return-Path: <netdev+bounces-48647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0818F7EF181
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 12:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9296AB20A4F
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 11:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4AD19BDF;
	Fri, 17 Nov 2023 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bv2DM1K8"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5CEC2;
	Fri, 17 Nov 2023 03:15:48 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 71B84FF80A;
	Fri, 17 Nov 2023 11:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700219747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MEnAPhotGrymqx9LWYvphkRnK4e8fFIFQk+XIJhM+Ew=;
	b=bv2DM1K8sfN7my6DGyXah1OW8f8ligLTQQbv2oeWPGfbH3pLz1fHL6HIMNb++VwFLFUVVA
	FE1nA3josktfusczdxPl+/rQoN0T4Ts/w9mObdtiQ3g+qXqd/2nOanonmA9tPh1TFCGkZy
	vgD1OEXfv9yMX3wPMJBwJ1L7Fioj7+jPPTa2tP2+0VOLLGbavTY4V6X7mdLdLX74HTOCqa
	Uym+ZBpydJjuw0j3sGy+LIobi0T+MVrTtbNfVQjq1lvXM7AcZSlCvVEPZTOEYdFSrGkwC5
	I35VqoXtIL/pbJ6TDyFwSYqTOdtcYWRmlpXFo3EoXpFl4VHg/WpGxLAOmMmI4Q==
Date: Fri, 17 Nov 2023 12:15:45 +0100
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
Message-ID: <20231117121545.2f950d43@kmaincent-XPS-13-7390>
In-Reply-To: <47d42d52-943c-467d-bcc0-fcb274f69841@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
	<20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
	<47d42d52-943c-467d-bcc0-fcb274f69841@lunn.ch>
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

On Thu, 16 Nov 2023 23:38:08 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > +static int pd692x0_send_msg(struct pd692x0_priv *priv, struct pd692x0_=
msg
> > *msg) +{
> > +	const struct i2c_client *client =3D priv->client;
> > +	int ret;
> > +
> > +	if (msg->content.key =3D=3D PD692X0_KEY_CMD && priv->last_cmd_key) {
> > +		while (time_is_after_jiffies(msecs_to_jiffies(30) +
> > priv->last_cmd_key_time))
> > +			usleep_range(1000, 2000); =20
>=20
> That is a bit odd. Could you not just calculate how long a sleep is
> needed, rather than loop?

Oh, right indeed! Don't know why my brain wanted a loop here.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

