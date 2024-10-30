Return-Path: <netdev+bounces-140517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 242139B6B06
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49BD1F21C7B
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BC51BD9FE;
	Wed, 30 Oct 2024 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CN4x54XE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D531BD9E2;
	Wed, 30 Oct 2024 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309501; cv=none; b=qLKMjV4zowEjNl7yJkR1GvBJAZKdyhcHqYbIyBHZVX9SDCj61txIFLYz93x22CWWA3gYERq+gtp1kVCRsybJAiijnwJejOFuZEEpc5KNs2YD9m7+bWPCdRFbKYo3D8e8ch7DxWS7JpEdZBhhvNB5/BHF5XA8+IoT9p19EAZovx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309501; c=relaxed/simple;
	bh=XW7RJZx1sP9q6TXqI9l2Urrnb4a67wAySZqs1jvelWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeCDjbzL7ir3KQ0GM3ylMwCxR+uvHP5Bmotqsk695PaVGHcuX9KBfLru9jt8nOiIo5kgx9npMxvq75+NijgIeqoAZi0JeSJS442haMn2VXjFR4KMX+tZcfpg2FWk2eLzdrfXz2OOlHXMgywvTqFUGzHQkC+EWkILWEbztyFfWK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CN4x54XE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30EBC4CECE;
	Wed, 30 Oct 2024 17:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730309501;
	bh=XW7RJZx1sP9q6TXqI9l2Urrnb4a67wAySZqs1jvelWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CN4x54XEb9tbYCE19JNWOq0DiqvRyu6hQIAYVkeC1tzgVAJiq6JeFYnKJwXCc6SSG
	 asTz+gd8+lhB9iFZ0KUUk6umD+UPDl8gFeAjS9E3bSBntnL1M0NFnRr9zrVl5q0W2j
	 9+2vuFGyLA1vliTh9GPNB2sYiHUhbiN/x9xCCsV1ceARqIrCJ54k1Xa+3Rf2pqwsY8
	 xh1PFT7qqOhGTHMiVEEH8UX2Ae7uGpj5ICMaTvMn8f07j4LzSJdq7gP75K3c3BO9Uw
	 EMYSy6WPf/C+Oxn/AydzaqrkuXFWZN+LattnDI9NWmFAQRn6Ntox7NIErn93kgaUB5
	 hc6hclgSHdNQw==
Date: Wed, 30 Oct 2024 17:31:34 +0000
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
Message-ID: <8c5df9b8-2ee9-4baa-a7f3-1d7f633cc908@sirena.org.uk>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
 <20241030-feature_poe_port_prio-v2-11-9559622ee47a@bootlin.com>
 <578d2348-9a17-410e-b7c8-772c0d82c10f@sirena.org.uk>
 <20241030182211.748c216e@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="el+qXin1X1ZKUea9"
Content-Disposition: inline
In-Reply-To: <20241030182211.748c216e@kmaincent-XPS-13-7390>
X-Cookie: I feel partially hydrogenated!


--el+qXin1X1ZKUea9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 06:22:11PM +0100, Kory Maincent wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Oct 30, 2024 at 05:53:13PM +0100, Kory Maincent wrote:

> > > +int regulator_get_power_budget(struct regulator *regulator)
> > > +{
> > > +	return regulator->rdev->constraints->pw_budget;
> > > +} =20

> > This is going to go badly with multiple consumers...

> On my series the available power budget of the PIs (which are consumers) =
is
> managed in the PSE core in the PSE power domain (patch 13). We could move=
 it
> directly to regulator API.

It feels like it's going to need joining up at some point.

--el+qXin1X1ZKUea9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcibXUACgkQJNaLcl1U
h9ADDgf+K4s+GOUMO5jmJWqeNUJYp+6ocvIZ7QnpOTh37qAM6qG+h8XVM9Oe8f04
9MtmNBGEle1dyji0jjOyDoBvKALX3Yo6bjt2vAKqNJ5i/9wO1GA8M1DCbazjs9sb
Mx0nD4PNNMUIAfgLtEJyfK7HrxW91Hp22EucF7t5mBSNlF8gYI61p2RCVSFm5BZE
YJvSoHOG4A63f3bWwiLTRQHoX0ZO7onl1Ctucog10znV/kp9K9r7EEGPzZWeSoPg
/Ttdjn8u36c7R/ZvGnEJg3XYYFeQ9njVbAg2YqSU6XYfduaJxfCtYv4263uGbzhi
RjL+TbbqhPxieaiC/dLE9aVoUd/jZw==
=rb83
-----END PGP SIGNATURE-----

--el+qXin1X1ZKUea9--

