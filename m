Return-Path: <netdev+bounces-169013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C36A42051
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A25F189245E
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E213F21931A;
	Mon, 24 Feb 2025 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fxmtDWxV"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D5195;
	Mon, 24 Feb 2025 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403043; cv=none; b=LETJ4Vu8ZGvAeENQC9qyzdUxUhbvjzKKYCOWccunNji74teKWJ8cKdFn/TdzJ0NeDoLb42OJfyaaCaAkdgXMHQ65t7YgP+GhoKYA4uk37YpnIvuk8RGrd6rTBmzmGZwy2rdqIZ9OOmjJUHWxVreA6akJPnLUh+PRiHcHe25mYKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403043; c=relaxed/simple;
	bh=iJujQgrFpeR89LdUfnOUutmKKbuFiKdlZWu5H+P8p/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiSaz5A7rqkLzoQBLlOwJdSTRHhv3rANzxryEhzQSFKy+P+V4Bsgf/rRBNSlkqJiKNKdl5z54SRa3tQTIL83q2fPWC8PQk2SFE4hhhiVzGR3Zpy2orVZ93Knu5WgtiRORNF62/6L45b1ilrytUAGzDJzKCNcoNx8p47KDvtrtzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fxmtDWxV; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4A6D941C15;
	Mon, 24 Feb 2025 13:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740403038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksTMumsP+uok8AykLK2ZoU0DRsvBnKMfzttvPsXkX04=;
	b=fxmtDWxVENVonUC0M6cX011xhIvC7sD7bgnqfraUtHc94+VeM1D9puG3DYiF9td+Qom/bj
	5svpFk+lUN6BTRzWiysDJn9zjQa4DCzQwMihqQXoaVj50V43KjoQ9W/Xw07BUctlWNg4Jc
	F3E7O1unVUsoGW7/XUmeFK7zhHMsZoDKMV31hO+Dcr/m34eD9TLyb1us+61Zq7d7750IQQ
	4wUi7kEht2uBnBeQkW7qSwBxgaR8OSz3owt1/b7uoXumL99XMKYsZtXee50rCacwx4EC5H
	J42tqD4W+z/j1hzQtw5JrktRBkYxAirE/q1T+Ny1rOi8/WOCoLEpCfExNlBcNA==
Date: Mon, 24 Feb 2025 14:17:16 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 09/12] net: pse-pd: pd692x0: Add support for
 controller and manager power supplies
Message-ID: <20250224141716.01751dc4@fedora>
In-Reply-To: <Z7xqz-Z5UhqBQXnc@shell.armlinux.org.uk>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
	<20250218-feature_poe_port_prio-v5-9-3da486e5fd64@bootlin.com>
	<20250224134222.358b28d8@fedora>
	<Z7xqz-Z5UhqBQXnc@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeekkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepfhgvughorhgrpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnv
 ghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Mon, 24 Feb 2025 12:49:19 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Feb 24, 2025 at 01:42:22PM +0100, Maxime Chevallier wrote:
> > On Tue, 18 Feb 2025 17:19:13 +0100
> > Kory Maincent <kory.maincent@bootlin.com> wrote:  
> > > diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
> > > index 44ded2aa6fca..c9fa60b314ce 100644
> > > --- a/drivers/net/pse-pd/pd692x0.c
> > > +++ b/drivers/net/pse-pd/pd692x0.c
> > > @@ -976,8 +976,10 @@ pd692x0_register_managers_regulator(struct pd692x0_priv *priv,
> > >  	reg_name_len = strlen(dev_name(dev)) + 23;
> > >  
> > >  	for (i = 0; i < nmanagers; i++) {
> > > +		static const char * const regulators[] = { "vaux5", "vaux3p3" };  
> > 
> > Looks like the 'static' is not needed here :)  
> 
> Have you checked the compiler output before saying that?

No I have not

> I've seen plenty of instances where "static" should be there but isn't,
> leading to the compiler generating inline code to create the
> array/struct on the stack.

Makes sense then, so it should be good here.

Thanks,

Maxime

