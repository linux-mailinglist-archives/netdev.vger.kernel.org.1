Return-Path: <netdev+bounces-221730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1B1B51B18
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B98B174086
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97A62BE7AD;
	Wed, 10 Sep 2025 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qjg1XiVy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25DF1E8320;
	Wed, 10 Sep 2025 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516956; cv=none; b=N/Vx0PlWppFLjwW7AHqVSxO6fKyg4EOuynA72UU47bWf+BfUtfMXbtry0KEBEt04n/7EAtHnS/EmnOnpHn7c4pybekYRz+mi0AaGE7GePjc9bxRegx7b6JW67xWY7FjaNRm5mbnKchFFaKPvfQVFBHl+Y6RiS33HpWe5+vtR6O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516956; c=relaxed/simple;
	bh=ydn2xtFjAjaReC6GWq0B2HXB/HbN5g3KL/JJeEAI6Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceXk+qiI241Ii3O3ZXcf01m7LgVyjno62DpIlXTHpHa/f9XAuR842iuTvtR3u4mYU0Po3/cf8uaQ117mI++HWlFc3ITDg5kC2qXms08rJ8AQL1jILym4Kqyt8u1PIJ6FAcQtDUkQsDbHNahTHrSe2SbRTFE6/Xhp1vRJ/OQfZQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qjg1XiVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96D0C4CEEB;
	Wed, 10 Sep 2025 15:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757516954;
	bh=ydn2xtFjAjaReC6GWq0B2HXB/HbN5g3KL/JJeEAI6Tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qjg1XiVygkBuHfd07CGmzSo/BBZXDsGklMV0teiRj9Z8OCLNdQBIS6DOn6KlS5iAF
	 YrMK97cedrPJ+ls5/8RGkg+kMzekHGsJoZNal3m+g9MMIkxKeJCvlEuwD0AajJyVyT
	 nVVgaq8HdtMZ+kaQYTmwo3o7W9/lsWczG/Jd/89uasTo+qK3R3qYNi0zjmm9+qfnp7
	 HcznSK765Tg/LeGyQZKu/6bqp01nzTsg/hgsCaQGwpqGFES+HIlh/jP+1pUnvj7WM5
	 m04NWxyYbHAfuG2S1vrxIHSpSmqrlq0m6PDAL10LSWZJdGlwSDWmjA5B2zlSh5ye+y
	 90Ey/7zxBol8w==
Date: Wed, 10 Sep 2025 16:09:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>,
	Jonas Rebmann <jre@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/4] dt-bindings: net: dsa: nxp,sja1105: Add reset-gpios
 property
Message-ID: <693c3d1e-a65b-47ea-9b21-ce1d4a772066@sirena.org.uk>
References: <20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de>
 <20250910-imx8mp-prt8ml-v1-1-fd04aed15670@pengutronix.de>
 <20250910125611.wmyw2b4jjtxlhsqw@skbuf>
 <20250910143044.jfq5fsv2rlsrr5ku@pengutronix.de>
 <20250910144328.do6t5ilfeclm2xa4@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7Lh4wxWc22jPqJvF"
Content-Disposition: inline
In-Reply-To: <20250910144328.do6t5ilfeclm2xa4@skbuf>
X-Cookie: I think my career is ruined!


--7Lh4wxWc22jPqJvF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 10, 2025 at 05:43:28PM +0300, Vladimir Oltean wrote:
> On Wed, Sep 10, 2025 at 04:30:44PM +0200, Marco Felsch wrote:

> > Can you please elaborate a bit more? I was curious and checked the
> > AH1704, it says:

> > "The RST_N signal must be kept low for at least 5 us after all power
> > supplies and reference clock signals become stable."

> > This is very common, so the driver only needs to ensure that the pin was
> > pulled low for at least 5us but not exact 5us.

> The statement says that during power-up, when the supply voltages and
> clocks rise in order to become within spec, the reset signal must be
> held low. This requirement lasts for up to 5 us more after the other
> signals are in spec.

...

> I said that _while the supplies and clocks aren't in spec and 5 us after
> they become in spec_, RST_N has to be kept low.

> And if you plan to do that from the GPIO function of your SoC, the SoC
> might be busy doing other stuff, like booting, and no one might be
> driving the RST_N voltage to a defined state.

I suspect you're reading too much into the datasheet there.  I suspect
that what it's trying to say is that the reset signal only works with
stable power and clocks, that it must be held low for the 5us while
those conditions hold and that you have to do at least one cold reset
after power on.  The above wording is pretty common in datasheets and I
know in a bunch of cases it was carried forward kind of blindly rather
than looking at the actual device requirements.

> It really depends on a lot of factors including the reset timing and
> supply voltage distribution of the PCB, but RST_N has essentially 2
> purposes. One is ensuring proper POR sequencing, the other is cold
> resetting at runtime. You can do the latter over SPI with identical
> outcome, which leaves proper POR sequencing, which is not best served by
> a GPIO in my experience.

I'm not sure not including the signal in the DT bindings is going to
influence board designers much either way TBH.

--7Lh4wxWc22jPqJvF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjBlJEACgkQJNaLcl1U
h9DAVQf/bV9pJbE/mcsitFrWvPTWQA9z8+bhcyfQvq0Gkx7sHsDEmqtDTZwoRHt0
l9vaWvTC9naNGIpZ12Qi03nJGcQlGzXAnoWmccXlXwBn6MvMPFBlMsgKNyz+gTNz
catYyQNIJN6FIQm9deSbtUx8L7B7pe+4SAPw86OtEJZnnehm2O41+jzb4tEyUCKP
WkmYb5kn9Lvn6zHZb/7b1B7s8wSq+6Ztn1Bveyiu+qdA82H6K+Arwau1Dx3eVffA
JFfvrMeyRcB5Uw075C0YvBBtvaJycYewBMYMp4rIPrN6L8LzDXyvIxDo2bKOsy7m
YY6fHqSe2ib/4su6ne2AZDPFBN2Qew==
=Xxyx
-----END PGP SIGNATURE-----

--7Lh4wxWc22jPqJvF--

