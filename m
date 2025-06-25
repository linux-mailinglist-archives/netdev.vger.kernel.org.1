Return-Path: <netdev+bounces-201220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B36A7AE883B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 17:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095094A373F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DA725F99A;
	Wed, 25 Jun 2025 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BN0KbcnT"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E14725E445;
	Wed, 25 Jun 2025 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865615; cv=none; b=E99NvjL43gL9lZPUjtlId6ZGQbL5JNxBbpNUNITaccEyoBpv9jWbKtNqiV/SiU0Z9V0CwXF9+tCZPCPKeRnTdXHlc/zAldbJsjv/kTknlULphtGXCFcfX+J5TnNDlFfWtPewCIw152penjYHeM554CccTR2Bj1hPu4DGd+WBN50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865615; c=relaxed/simple;
	bh=8/YmsIFFyVC8EIUMRZzjBuyoWLpSCHvtknRAomVerJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/uiobn7gdUkny8Woueexe1GTzzUso1h5qiGh8BRJFoh1qq14BnQ4h39Sf2YiRwihhCiOweyYw0A7gaGvm9+PIiZlKlkShmduS6odK79DWy7HZlJhANUQ6JGb+xKHLL2m3rnph/+2nbyxLeXr0ip/IMye4rpL0rijEeeEU2hsCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BN0KbcnT; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5CBE7442A9;
	Wed, 25 Jun 2025 15:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750865605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2q9SQ4qqS5hVARAO+lvP8xdA01Da1YU1AfQAuXlTTg=;
	b=BN0KbcnTMdnqcei9gX4mJK02e9Y7tI2Be/thjwv+mt97cgMZAJFEeP8hQHZtY9A5WvGQyv
	8RBFt4XM7zg/spRBJT9tc7zYdteiTsDvkOqv/Q6mjpuaigFN6VCJnhk9c5XuykyWjeiO8P
	9ImKds3J3h4EN877Zr29KbqzL6984zeh6A0xIPwWvxPL1krCeVz3L6heUE8aRn2UHThn6p
	FSL9KShXZUgUr6QeqVScinglvVSo1smNSesL3txqz4NxKRZOrpMAyK/yGL6rjg8HKEQxrk
	ZwgrRXjKRqBz6/Imq4Osoou9O0qN3nZOrsLFZLSU1o9aBhVup8aeWCe2z6eqXQ==
Date: Wed, 25 Jun 2025 17:33:23 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] phy: micrel: add Signal Quality
 Indicator (SQI) support for KSZ9477 switch PHYs
Message-ID: <20250625173323.37347eb7@fedora.home>
In-Reply-To: <20250625124127.4176960-1-o.rempel@pengutronix.de>
References: <20250625124127.4176960-1-o.rempel@pengutronix.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfeduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeuhfefgffgtdfhgffhvdfhhffhteeutdektefghfetveehheejjefgudeiudehudenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrt
 ghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Oleksij,

On Wed, 25 Jun 2025 14:41:26 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Add support for the Signal Quality Index (SQI) feature on KSZ9477 family
> switches. This feature provides a relative measure of receive signal
> quality.
>=20
> The KSZ9477 PHY provides four separate SQI values for a 1000BASE-T link,
> one for each differential pair (Channel A-D). Since the current get_sqi
> UAPI only supports returning a single value per port, this
> implementation reads the SQI from Channel A as a representative metric.
> This can be extended to provide per-channel readings once the UAPI is
> enhanced for multi-channel support.
>=20
> The hardware provides a raw 7-bit SQI value (0-127), where lower is
> better. This raw value is converted to the standard 0-7 scale to provide
> a usable, interoperable metric for userspace tools, abstracting away
> hardware-specifics. The mapping to the standard 0-7 SQI scale was
> determined empirically by injecting a 30MHz sine wave into the receive
> pair with a signal generator. It was observed that the link becomes
> unstable and drops when the raw SQI value reaches 8. This
> implementation is based on these test results.

[...]

> +/**
> + * kszphy_get_sqi - Read, average, and map Signal Quality Index (SQI)
> + * @phydev: the PHY device
> + *
> + * This function reads and processes the raw Signal Quality Index from t=
he
> + * PHY. Based on empirical testing, a raw value of 8 or higher indicates=
 a
> + * pre-failure state and is mapped to SQI 0. Raw values from 0-7 are
> + * mapped to the standard 0-7 SQI scale via a lookup table.
> + *
> + * Return: SQI value (0=E2=80=937), or a negative errno on failure.
> + */
> +static int kszphy_get_sqi(struct phy_device *phydev)
> +{
> +	int sum =3D 0;
> +	int i, val, raw_sqi, avg_raw_sqi;
> +	u8 channels;
> +
> +	/* Determine applicable channels based on link speed */
> +	if (phydev->speed =3D=3D SPEED_1000)
> +		/* TODO: current SQI API only supports 1 channel. */
> +		channels =3D 1;
> +	else if (phydev->speed =3D=3D SPEED_100)
> +		channels =3D 1;

I understand the placeholder logic waiting for some improved uAPI, but
this triggers an unused variable warning :( I think the commit log and
the comment below are enough to explain that this can be improved later
on.
=09
> +	else
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Sample and accumulate SQI readings for each pair (currently only one=
).

Maxime

