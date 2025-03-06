Return-Path: <netdev+bounces-172457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4ABA54BE1
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 14:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F418D1898204
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 13:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0394120E024;
	Thu,  6 Mar 2025 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEZ0gw2X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3A51E52D;
	Thu,  6 Mar 2025 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267057; cv=none; b=CiO6A9SotWvgafSE4UnceZ2AOIou91DeVpJ26n1POB4WXuJTJnHPWs481ZRxuBnVkHMjGNiA1uNsxki6tDP3TxQBNecKrNQavcnWB8hvD8pTlYZicOAx6aGRRN0pbx9BtLtAvpbdeVUrl6ucm+jkLLUk9KOw80T0qyqo7Ek1Bm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267057; c=relaxed/simple;
	bh=LVi65KmYjY+KIOVOXMGlsTdV8Rw68dC+th4ebE/3EqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fo/pfB2hRBZuxJKU47UY8HBKRKN3CuaJ8Q/m3VIRnIrtG04kNvXbbWhrCuy8NurzGImNiFUVpATls4XqL3PJuzlHXZw4DoFL4+G/3DWsLwIXVf+DzSaGHsI5bsUYxdV6f9Hf+0A7I6qKziJ2IKlmv+0AwRG2uXjhcWGzSAv2wOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEZ0gw2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A51C4CEE0;
	Thu,  6 Mar 2025 13:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741267057;
	bh=LVi65KmYjY+KIOVOXMGlsTdV8Rw68dC+th4ebE/3EqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qEZ0gw2X8G+ggMuMLeTpC1kVEVhVZyFvToYyGpDttorzj03eROdjFK/xLS2lY4MNv
	 yOp9XdrUNMqap92pXDJaBg3nLYiZGAe5s+9SzFpxVDYxw6eapLDkIIm7wEwQSqSnch
	 2YBdZZ85uPY90nINlEi6Z7+GheVECpKDAZOHoB+hz7RrAEYjwodOY1k+w79amGW3XO
	 91r/Bid8+FhB5SuK5JFejXAkZ6m1WBIuOaf+AM/SBn5juZUcv06JJViEtqibrMLEoF
	 ajYEUwEE13i09qS4ZdzpUb6uWh/mvE76HTxK1/rJVdi2klbkQl31cczdoJYzFOqC6v
	 uQg9PoK0D37+Q==
Date: Thu, 6 Mar 2025 13:17:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Lunn <andrew@lunn.ch>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v2 06/10] net: usb: lan78xx: Improve error
 handling in EEPROM and OTP operations
Message-ID: <97719544-5cc5-4d81-8e0c-dad5c88bf81c@sirena.org.uk>
References: <20241204084142.1152696-1-o.rempel@pengutronix.de>
 <20241204084142.1152696-7-o.rempel@pengutronix.de>
 <ac965de8-f320-430f-80f6-b16f4e1ba06d@sirena.org.uk>
 <Z8lhRCkxvtkB_U3x@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3Z5WkyayUYv10S9R"
Content-Disposition: inline
In-Reply-To: <Z8lhRCkxvtkB_U3x@pengutronix.de>
X-Cookie: What!?  Me worry?


--3Z5WkyayUYv10S9R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 06, 2025 at 09:48:04AM +0100, Oleksij Rempel wrote:
> On Mon, Mar 03, 2025 at 06:02:23PM +0000, Mark Brown wrote:

> > IP-Config: enxb827ebea22ac hardware address b8:27:eb:ea:22:ac mt[   20.663606] lan78xx 1-1.1.1:1.0 enxb827ebea22ac: Link is Down
> > u 1500 DHCP
> > [   22.708103] lan78xx 1-1.1.1:1.0 enxb827ebea22ac: Link is Up - 1Gbps/Full - flow control off
> > IP-Config: no response after 2 secs - giving up

> I can't reproduce it without U-boot. Since netboot is used, this adapter
> stays in some kind of preconfugured state. Where can I get the SD image
> which is used on this system?

I'm using u-boot - this is a full netboot for CI so I'm using u-boot to
fetch the kernel image.

--3Z5WkyayUYv10S9R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfJoGsACgkQJNaLcl1U
h9BQKAf7BABv6XCTLBA5+K9fuVKeUsncDrJaW6NtRKkNGqtB87xGmPkdbF10RVyw
Ku8YeSm6hxHEMqZZ7Qig04n5YTnvIeciHNBu9QIXmVHR+tWfdhnwIUpYyXZXq3E1
aoFBw+hwfptoDBkjBvXNA5lRpumM17n9BZOSM4MeTCLSbHxoEW7S98CiQ+ffOauC
qLYhhc+KBjtHqNUpUGtifu/8yEC7zlR4y2IEjB/6rMN+nbbpZfaKSwCCMGv4hfje
NVqOuYKxGea5SAiUv0XbFhxDOMwlaEg2mrMrH0GMqunnEtaheAvJIAD8hm5Bk9+r
MDwfAwjIoxFU1/za8bMW4/lt5ANoUw==
=QcYb
-----END PGP SIGNATURE-----

--3Z5WkyayUYv10S9R--

