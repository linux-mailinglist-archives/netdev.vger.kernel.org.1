Return-Path: <netdev+bounces-140506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D82489B6A89
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3CD1F25D5E
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4B822A4A8;
	Wed, 30 Oct 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHPN8+8n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76682215C62;
	Wed, 30 Oct 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307794; cv=none; b=ZB12nVq6G46eh6VJjQ+UeooI+ggC08w4n5VmXzr6k0+Crhmu4C39h/37AZMYuwY6esboyVjt7sw5vMRGWDK/rR3awHjjKB0Txqt8dUq2HTsgcV1B1hgvfvuurm0rgOFcDGOD0FT1fe2tjU1dGN9ui187y5EmTnK4wfSYug4Zbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307794; c=relaxed/simple;
	bh=xaLOjVrI4UuOoIHBUz4HZ9I1PFZXA40k3S1zbQTvOro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyr+PJP+bqDocf5gnXX7TnRIA8B95TOwK9jCUklpQSSgIGhHRaVZRbgvMOX/JAedfNFnzo/p3/TuaQgevL9zZqppA8J4pX6CnM0SIJWHp72OpLlbGGDonb8szcizdqZvWgAFCy0vW+WdxG2BC1ltDLtS4QRUrixNc273MeQrCBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHPN8+8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FDCC4CECE;
	Wed, 30 Oct 2024 17:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730307794;
	bh=xaLOjVrI4UuOoIHBUz4HZ9I1PFZXA40k3S1zbQTvOro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LHPN8+8nKtpCllz/g2EPsz88AegVBlVNxYu7A/iZd+VBjYe50uYaDnla3TLGW4S72
	 ambRMrlE5Z6lEoqxQX7OMTYTUT2txic9VV/qA6n+JlDyyEdRZZf7kTtHqqoLTcpJiY
	 bicHMeYZWffaVBIQv0mZ9M1/zMEwBZr+tQYaJIDIC9i6mJVAOgn8KzpsthPiGBaU4q
	 Ptiu5i9BbNXt7C9AEGeye3gmxjyy3IOwrnMsw9UW6NdHDZjQjl5ERvhWT1XaO/Dg0s
	 Pit/vq4sHbWQczf6oJbmPvtEfIhB0KO0cc3vCc4gLK1SkL01XwpgfAhzaI4hffOc5c
	 R4VO6N50128zQ==
Date: Wed, 30 Oct 2024 17:03:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 11/18] regulator: Add support for power
 budget description
Message-ID: <578d2348-9a17-410e-b7c8-772c0d82c10f@sirena.org.uk>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
 <20241030-feature_poe_port_prio-v2-11-9559622ee47a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="prXmSPGW9RUQhXiM"
Content-Disposition: inline
In-Reply-To: <20241030-feature_poe_port_prio-v2-11-9559622ee47a@bootlin.com>
X-Cookie: I feel partially hydrogenated!


--prXmSPGW9RUQhXiM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2024 at 05:53:13PM +0100, Kory Maincent wrote:

> +/**
> + * regulator_get_power_budget - get regulator total power budget
> + * @regulator: regulator source
> + *
> + * Return: Power budget of the regulator in mW.
> + */
> +int regulator_get_power_budget(struct regulator *regulator)
> +{
> +	return regulator->rdev->constraints->pw_budget;
> +}

This is going to go badly with multiple consumers...

> +static inline int regulator_get_power_budget(struct regulator *regulator)
> +{
> +	return 0;
> +}

We should probably default to INT_MAX here and in the case where we do
have support, that way consumers will fail gracefully when no budget is
specified.

--prXmSPGW9RUQhXiM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmciZskACgkQJNaLcl1U
h9AnVQf/dquldrMtKE+BySk6azhTqAAT6WH3XqoGfpYdYax1H6llEMjkX0stqKkb
yLZPvq+oPk9vtvrfTRoN7QI9o/4o4c1PVNkF/iUSaosJfVCXniOH6rsVYZpbQp4P
v/YEyQ9lw9DWEATwkMf3xXFGvwcPCiLI44ZxaeFu9eIUK9QoyRFVzY3ajfaSCmLs
028OklZvbhhL1NThsGZw+b9C4JvE4bjYp16V/sih8BRfeY6eTw60Km5jYTnR+CMI
Qbmgw25vYYnKMEeKuac8GDYOevJ8yBoUnd/DkBPcCyj0khS3HftFozMjp4/I0rlU
Hdf0yLQTNlvF2ux77cavWyi8YSLkdQ==
=seAF
-----END PGP SIGNATURE-----

--prXmSPGW9RUQhXiM--

