Return-Path: <netdev+bounces-169012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8E9A4201E
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591FF169B01
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF6F23BD17;
	Mon, 24 Feb 2025 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W9a0H6Z7"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834D323BD0C;
	Mon, 24 Feb 2025 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402844; cv=none; b=PUJj9UV10iwWHxzvml9+0wTaamT9afPuLHqwDc//7Qke4h48Yo9BkksHnmX1xg34CgQB2dcuClthJQeICr6Z3N02z14L2oaicc1rA6q/2c0f7y08COhU4d8DIFGU0fnc92NID8j43rrN21luXdxBte1n1CDfgpmbIj1s3Z3k70M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402844; c=relaxed/simple;
	bh=nJR/oct9FaXI0t9DTfvKDLkojusQDlTdMGlmiUFoIbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOj7v23hi2qs+hEYXfGZgBCbuYReNeqpl5o7u2WiTKg7kQkcdjBKC2yreddkhiw8swZT3YPpJqSnwz+Ed6MZogIVoSwqYe58Xqj88hhlujg9D0VolhIA+4KGX1/jrNXvxmQfM9yZf6MuA6E+IlMwczswPVNs4MHHBTgGaEPbYoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W9a0H6Z7; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B23844278;
	Mon, 24 Feb 2025 13:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740402833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCAIkXQWMLlT5Qmo1Sco1hYx05ZJXQkx1DWR+S7sN28=;
	b=W9a0H6Z7g2kiDsfvojehTYR1fvg8IVBOLZ0E7g2ru3DPQL2cRDUBgJ0b84ZO2dsXNancyK
	xTNafqw99yaqGZ1J/Ywmzdv5DkennF5U1VKv/JUKI+n8BGWC5O1k2Szo+30/63aqVf7l2S
	jm44u2kAT7Sf83YvE6CtEHfBfjTtgnifWh0x9rR3q9t+5Tr0lZpz5StnqGdbYjtT6ODER1
	XsEjHdAua7AgxlaszUOAJbuzeRfAJxFyndyYxY5DmIjMqn18IW/SCTqF5JAlYf6pdQXz1C
	q5GXTScg2jYKWjQsM9o/IXDOQHgYnAZIGvuQwbRFAPq9x5I/xSRq1hPUy9YENw==
Date: Mon, 24 Feb 2025 14:13:51 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 07/12] net: ethtool: Add PSE new budget
 evaluation strategy support feature
Message-ID: <20250224141351.3a942099@kmaincent-XPS-13-7390>
In-Reply-To: <Z7iEYQzsdpUFmfZE@pengutronix.de>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
	<20250218-feature_poe_port_prio-v5-7-3da486e5fd64@bootlin.com>
	<Z7iEYQzsdpUFmfZE@pengutronix.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhus
 ggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Fri, 21 Feb 2025 14:49:21 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi Kory,
>=20
> On Tue, Feb 18, 2025 at 05:19:11PM +0100, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > This patch expands the status information provided by ethtool for PSE c=
33
> > with current port priority and max port priority. It also adds a call to
> > pse_ethtool_set_prio() to configure the PSE port priority. =20
>=20
> Thank you! Here are some comments...
>=20
> > --- a/Documentation/networking/ethtool-netlink.rst
> > +++ b/Documentation/networking/ethtool-netlink.rst
> > @@ -1790,6 +1790,12 @@ Kernel response contents:
> >    ``ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES``       nested  Supported power =
limit
> >                                                        configuration ra=
nges.
> >    ``ETHTOOL_A_PSE_PW_D_ID``                      u32  Index of the PSE
> > power domain
> > +  ``ETHTOOL_A_C33_PSE_BUDGET_EVAL_STRAT``        u32  Budget evaluation
> > strategy
> > +                                                      of the PSE
> > +  ``ETHTOOL_A_C33_PSE_PRIO_MAX``                 u32  Priority maximum
> > configurable
> > +                                                      on the PoE PSE
> > +  ``ETHTOOL_A_C33_PSE_PRIO``                     u32  Priority of the =
PoE
> > PSE
> > +                                                      currently config=
ured
> > =20
>=20
> Please remove _C33_ from these fields, as they are not specific to Clause=
 33.

Oops, forgot to update the documentation accordingly. Thanks for spotting i=
t.

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

