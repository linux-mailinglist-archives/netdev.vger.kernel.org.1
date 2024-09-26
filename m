Return-Path: <netdev+bounces-129923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C52898708B
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 11:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC061F294BD
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 09:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB7E1AC8BF;
	Thu, 26 Sep 2024 09:43:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCE61AC8A0
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343828; cv=none; b=DKjgcm+HEWzfTZzqktjVbqHvbb27B4aDCZrAqO0Eikh2UMXygzTRyVDiCwHJMZ4G/ah6eXmO7kUTTM4OtfTC36u0xRgUpufOsfI59t2F9Nnjc/AFGPEMLXxRUNm1zIaeQ/6XV8rfFII+kjEBHry1vCt35Wlb9DwQpg4cFS9M/qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343828; c=relaxed/simple;
	bh=J39S9SFF4nvbADpWj4XpcDkFu67NPPxdSgq9yoSez+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYAlIbCTSeZQwJZr5ABAiz6ZFlp0kmvjwpJ/A5jm6/D1SFF8QAvPSRDAoZtZzSM/laaDRtle9e6RHYqfkJldFHWHg8ZeuQAj6Yb3lwdCsrhgVr+jxl0R152X4l6ahnsza1JowfV7dxNiXWjNa055EPsiXrRkKY/fer2K8LlJXuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1stl1q-0002On-HQ; Thu, 26 Sep 2024 11:43:18 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1stl1n-001ejo-F0; Thu, 26 Sep 2024 11:43:15 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B47E8342FF1;
	Thu, 26 Sep 2024 09:43:14 +0000 (UTC)
Date: Thu, 26 Sep 2024 11:43:13 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, "Felipe Balbi (Intel)" <balbi@kernel.org>, 
	Raymond Tan <raymond.tan@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@ew.tq-group.com
Subject: Re: [PATCH v3 2/2] can: m_can: fix missed interrupts with m_can_pci
Message-ID: <20240926-resilient-arrogant-limpet-98af37-mkl@pengutronix.de>
References: <ed86ab0d7d2b295dc894fc3e929beb69bdc921f6.1727092909.git.matthias.schiffer@ew.tq-group.com>
 <4715d1cfed61d74d08dcc6a27085f43092da9412.1727092909.git.matthias.schiffer@ew.tq-group.com>
 <6qk7fmbbvi5m3evyriyq4txswuzckbg4lmdbdkyidiedxhzye5@av3gw7vweimu>
 <1a4ed0696cbe222e50b5abdff08a5ce7f8223aae.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p64oeuz4yz67h6sr"
Content-Disposition: inline
In-Reply-To: <1a4ed0696cbe222e50b5abdff08a5ce7f8223aae.camel@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--p64oeuz4yz67h6sr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.09.2024 11:19:53, Matthias Schiffer wrote:
> On Tue, 2024-09-24 at 08:08 +0200, Markus Schneider-Pargmann wrote:
> >=20
> > On Mon, Sep 23, 2024 at 05:32:16PM GMT, Matthias Schiffer wrote:
> > > The interrupt line of PCI devices is interpreted as edge-triggered,
> > > however the interrupt signal of the m_can controller integrated in In=
tel
> > > Elkhart Lake CPUs appears to be generated level-triggered.
> > >=20
> > > Consider the following sequence of events:
> > >=20
> > > - IR register is read, interrupt X is set
> > > - A new interrupt Y is triggered in the m_can controller
> > > - IR register is written to acknowledge interrupt X. Y remains set in=
 IR
> > >=20
> > > As at no point in this sequence no interrupt flag is set in IR, the
> > > m_can interrupt line will never become deasserted, and no edge will e=
ver
> > > be observed to trigger another run of the ISR. This was observed to
> > > result in the TX queue of the EHL m_can to get stuck under high load,
> > > because frames were queued to the hardware in m_can_start_xmit(), but
> > > m_can_finish_tx() was never run to account for their successful
> > > transmission.
> > >=20
> > > To fix the issue, repeatedly read and acknowledge interrupts at the
> > > start of the ISR until no interrupt flags are set, so the next incomi=
ng
> > > interrupt will also result in an edge on the interrupt line.
> > >=20
> > > Fixes: cab7ffc0324f ("can: m_can: add PCI glue driver for Intel Elkha=
rt Lake")
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> >=20
> > Just a few comment nitpicks below. Otherwise:
> >=20
> > Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
>=20
>=20
> We have received a report that while this patch fixes a stuck queue issue=
 reproducible with cangen,
> the problem has not disappeared with our customer's application. I will h=
old off sending a new
> version of the patch while we're investigating whether there is a separat=
e issue with the same
> symptoms or the patch is insufficient.
>=20
> Patch 1/2 should be good to go and could be applied independently.

Can you post the reproducer here, too. So that we can add it to the
patch or at least reference to it.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--p64oeuz4yz67h6sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmb1LK4ACgkQKDiiPnot
vG8ygAf9F3z7iuju1FF4PZ5yNHEgp28yZl7t8Ot4b8R7yf5GjLjd4co76AEB+g/d
Aa1stE3EBANxAalAwDUm+2/Bl6HBmGnU+Z/r6fstpKNjiqh53Cv0GcyEM0ZBDfhU
YwbGSQab11HGFEcftHMw5gMQUEahdlZUeWuTR7kFERLOjRE1bZHEiigoUsCWqTX1
29hHXxJuHfis8yA79Le/+77NWvNqm6+uciy1PvVLz9V89u570YVD9WHoBruwobju
zIMLrqWSZgHoynMyNtYqB7h+ijRnfRHMknaVSTcUhlSFVD236ySX4ACAtU+t38jo
NY/PAQ1sjmQvTo/RKgp8ywyHs8ETgQ==
=nMju
-----END PGP SIGNATURE-----

--p64oeuz4yz67h6sr--

