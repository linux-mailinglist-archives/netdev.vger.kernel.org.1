Return-Path: <netdev+bounces-146681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C73F9D4F4D
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63F3287023
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485931DA636;
	Thu, 21 Nov 2024 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHghZpDo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0551D8E1A;
	Thu, 21 Nov 2024 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201094; cv=none; b=Vm2PpmkQv0ju85CH1jUYrknZSlBjnTrUfExwAIFvn3ogmtn73f/tFkEo2BL9sxH30VbprsIm56xberDHyLQsQibB4DT4I7bxalyvRyH4PS62UO9LTQ5Y7zpHlJu+Dl250Bh0upqS1HPNyp94rtZwv4ll/ajhFZ1yrQBRWc1Tvb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201094; c=relaxed/simple;
	bh=9SGWniObCUlE/SX/NM2WS2ry5gVPFkNr0PSymn4y86k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0OWvkwZw3Xg7QijxYhDgMjUxoWu2zZG6YCkI+rKZSe2aN/Bex+8Jc785+wG9SwOqNkLN4PYpDNlxYH9K5RdgQ7DfveXi8MboG9bKnJnHXbw/6AdR4d6J2yVim/xsi83cO3i7gI8msRikcb9tpHqhm9SUpUJUg20Nq5o3SON23o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHghZpDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34227C4CECC;
	Thu, 21 Nov 2024 14:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732201093;
	bh=9SGWniObCUlE/SX/NM2WS2ry5gVPFkNr0PSymn4y86k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LHghZpDoDFrLXwulIZn+3PA78KV7sAvn2LBiKlhMw87P3/MSL/34U1m7AtPrm21Bk
	 3EFEBd3gY5a6+vP60crkuE37EvLTb18sekMWa+p8j3twq7YUcUVNY5ny1CN2y9CJCQ
	 grtTIiZTYkYfarfQvMn0M8DwagKI7e05z6SCuSsm7hVr8UIGatyuw6MkJT1HRHWzvA
	 8OvJWaXoEt3sxmn5L4kql2q33TQN+dBsRcTBjFb9sBH/A+ubzueG0b28wiyK48bSew
	 zC06LIJuVmg0/duF9QGd0TlDArn2M5qfs1/R48JA41o03BBE73O/teNZqiNFr9pAyy
	 OMG4Tpr4yOY5w==
Date: Thu, 21 Nov 2024 14:58:06 +0000
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
Subject: Re: [PATCH RFC net-next v3 17/27] regulator: dt-bindings: Add
 regulator-power-budget property
Message-ID: <9b5c62aa-fc01-4391-9fab-219889fa0cf6@sirena.org.uk>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
 <20241121-feature_poe_port_prio-v3-17-83299fa6967c@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q4c3jl8/3ZnQlZHQ"
Content-Disposition: inline
In-Reply-To: <20241121-feature_poe_port_prio-v3-17-83299fa6967c@bootlin.com>
X-Cookie: Fortune favors the lucky.


--q4c3jl8/3ZnQlZHQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 03:42:43PM +0100, Kory Maincent wrote:
>    regulator-input-current-limit-microamp:
>      description: maximum input current regulator allows
> =20
> +  regulator-power-budget:
> +    description: power budget of the regulator in mW
> +

Properties are supposed to include the unit in the name.

--q4c3jl8/3ZnQlZHQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc/Sn0ACgkQJNaLcl1U
h9A2FAf+I2Rxy1xHk5tzxU9itbf2D45SYnEgbc6MMXznKAOC7Fz+t7xN2erABHUk
XE1EFYQkhCvKVcP5J47rdoyIwAfF2s+i1TE0hfrVurjLSQLHuEo5WsiBV8nRSp0C
PmI95x7tPTDoVGOqpBvSQuW4c+7ykmTViT9Y/diWfVlTxccvu1ppxaO75+LS1S6T
Bm/lLHM0Weyl4eb9yw1uTE5HM9OOrt6O7/58UlB3RbQfNPKB9SwM4A5DcXzbxORZ
vjpkf7Gs3wC5AnmIZSBPgE3aRcTymhrs5phpQwKwAxUJ2Oq7y4O5+h8lOIDGfO03
KiWqLeQ2mONLW/QcR8Nj+TNMBHW8Fg==
=A/Pb
-----END PGP SIGNATURE-----

--q4c3jl8/3ZnQlZHQ--

