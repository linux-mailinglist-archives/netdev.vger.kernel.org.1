Return-Path: <netdev+bounces-200954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46B1AE7851
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8FEB4A126C
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 07:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE5E1FC0F3;
	Wed, 25 Jun 2025 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oEFw5tJO"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B563A1DFD86
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750835718; cv=none; b=UhvYYh2Q6VVQc7aIqhr8c7zduFFqklkUffgUtbXkSPYzxcI2xUrs962FgVU6/0/ni+d4tXvBf9CKNugZKVVFx8HjOiUq2MfdNxlaFgUaEYO0g5mzNWQC9NwT1d33llmSxlOdfb9VDK23YTuE+kvG3170fqqSXP00wW6lZ0g7en8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750835718; c=relaxed/simple;
	bh=ItKmWAaJwab1Hl9wblEeNA0MrtVTZQ4x6JRAb/bem4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lflFt62HuEbssHbkHye4I70HqCA/JbY0zLj4y8lQphosUWn1QtzoCuVh8izTd3K5YbGcbzlPExjVGKiN+SxHB0blB+lm1ktgQKTiqgE+77MWQLT/2ipHomsapmwTBvaQlQVrXAFDypXHza9fpMP66r2MCaEA4IMrxj9xRonZwS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oEFw5tJO; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3CF4443E6;
	Wed, 25 Jun 2025 07:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750835708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItKmWAaJwab1Hl9wblEeNA0MrtVTZQ4x6JRAb/bem4k=;
	b=oEFw5tJOBUADcbTH2ta6ZGRqd6eq7iixUXAgCAW9MvEn1QzI2dDXskHcUuxKdMJAA0Xf7Y
	pIIvqGSfo1kAtXM8/1tfzhlxOTqh1L1pZC2eOVlizp1yRUa06yWaOKicEqL45OhKpCHAr7
	HIC7fMPbT7trt8Ibk9Zien/aeddNmihaJJIXoBoM68mn0aP1KAxSLsV4tldzzQE8Bojw+U
	VwEFNaz/NHjGIE6n8V15ZPvr19yh8EaVLllT5X8OcYqn/rZco9U41LKJcDejGQQvoabLsX
	cSS2oN5TqrvKlRhvd9BegbDWCnI9SZ9HiBcZnv4oPdALCgfr4VdC1oAXvh/1EA==
Date: Wed, 25 Jun 2025 09:15:06 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, "Russell King
 (Oracle)" <linux@armlinux.org.uk>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Robert Hancock <robert.hancock@calian.com>, Tao Ren <rentao.bupt@gmail.com>
Subject: Re: Supporting SGMII to 100BaseFX SFP modules, with broadcom PHYs
Message-ID: <20250625091506.051a8723@fedora.home>
In-Reply-To: <24146e10-5e9c-42f5-9bbe-fe69ddb01d95@broadcom.com>
References: <20250624233922.45089b95@fedora.home>
	<24146e10-5e9c-42f5-9bbe-fe69ddb01d95@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeuhfefgffgtdfhgffhvdfhhffhteeutdektefghfetveehheejjefgudeiudehudenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepfhhlohhrihgrnhdrfhgrihhnvghllhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhun
 hhnrdgthhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepvhhlrgguihhmihhrrdholhhtvggrnhesnhigphdrtghomhdprhgtphhtthhopehkrggsvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrhhgrnhgtohgtkhestggrlhhirghnrdgtohhmpdhrtghpthhtoheprhgvnhhtrghordgsuhhpthesghhmrghilhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi again Florian,

On Tue, 24 Jun 2025 15:29:25 -0700
Florian Fainelli <florian.fainelli@broadcom.com> wrote:

> For 100BaseFX, the signal detection is configured in bit 5 of the shadow=
=20
> 0b01100 in the 0x1C register. You can use bcm_{read,write}_shadow() for=20
> that:
>=20
> 0 to use EN_10B/SD as CMOS/TTL signal detect (default)
> 1 to use SD_100FX=C2=B1 as PECL signal detect
>=20
> You can use either copper or SGMII interface for 100BaseFX and that will=
=20
> be configured this way:
>=20
> - in register 0x1C, shadow 0b10 (1000Base-T/100Base-TX/10Base-T Spare=20
> Control 1), set bit 4 to 1 to enable 100BaseFX
>=20
> - disable auto-negotiation with register 0x00 =3D 0x2100
>=20
> - set register 0x18 to 0x430 (bit 10 -> normal mode, bits 5:4 control=20
> the edge rate. 0b00 -> 4ns, 0b01 -> 5ns, 0b10 -> 3ns, 0b11 -> 0ns. This=20
> is the auxiliary control register (MII_BCM54XX_AUXCTL_SHDWSEL_AUXCTL).

And I have my first ping going through :) Thank you so much, if I get a
chance to meet you in person one day, drinks are on me :)

Thanks again,

Maxime

