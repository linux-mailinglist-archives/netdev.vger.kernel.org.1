Return-Path: <netdev+bounces-225985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54472B9A2F7
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 16:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B141B265A3
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 14:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D737305962;
	Wed, 24 Sep 2025 14:13:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D5B305967
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723183; cv=none; b=QRxH8V9gpGgpPLBIJlPek2GUQgFMLIMacbc7OJafYiD9tFF9JRrVwNp3RiaERpWFf95X1PyUgKsQCjsDP9jnZ9GpvFrFdNpGyQckAY+uV1AnuqDG1cEk/lZ+oiXdlUYhVrUd+94Oog1opDxVc7FtsvWsNpZnIGf6dLTb/CBWY8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723183; c=relaxed/simple;
	bh=KWtSmrGnukt9WdYMSXI2gW0ksw650zNpIQCopoRyh1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcC2eeIdedqXVOMeVeuC+gVhAqJ7X9Z2vRDan+ljgAMpxAX81CjXpA9WetHtkiV3cd/+Lnx7TqJGgmu+jU52JbP/G9ZfOIOaK+4V5Kdpvu9fCTwYyt1DpXzCyREBuYa541O0qAinQ5nBMZ0mC67DTqHS0Z0EFDyXUooJhvU2GXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1QEn-0007px-1u; Wed, 24 Sep 2025 16:12:53 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1QEm-000GhQ-14;
	Wed, 24 Sep 2025 16:12:52 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 06CB9478DD5;
	Wed, 24 Sep 2025 14:12:52 +0000 (UTC)
Date: Wed, 24 Sep 2025 16:12:50 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: "kuba@kernel.org" <kuba@kernel.org>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net 09/10] can: esd_usb: Fix handling of TX context
 objects
Message-ID: <20250924-neon-private-cockatoo-b294a2-mkl@pengutronix.de>
References: <20250922100913.392916-1-mkl@pengutronix.de>
 <20250922100913.392916-10-mkl@pengutronix.de>
 <20250922171719.0f1bdb28@kernel.org>
 <3e810a325d0652a3b709807d2fbd7f8007a9f733.camel@esd.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2vmbmbx6zh2t3zve"
Content-Disposition: inline
In-Reply-To: <3e810a325d0652a3b709807d2fbd7f8007a9f733.camel@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--2vmbmbx6zh2t3zve
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 09/10] can: esd_usb: Fix handling of TX context
 objects
MIME-Version: 1.0

On 24.09.2025 13:26:39, Stefan M=C3=A4tje wrote:
> Am Montag, dem 22.09.2025 um 17:17 -0700 schrieb Jakub Kicinski:
> > On Mon, 22 Sep 2025 12:07:39 +0200 Marc Kleine-Budde wrote:
> > > -		netdev_warn(netdev, "couldn't find free context\n");
> > > +		netdev_warn(netdev, "No free context. Jobs: %d\n",
> > > +			    atomic_read(&priv->active_tx_jobs));
> >=20
> > This should really be rate limited or _once while we touch it.
> >=20
>=20
> Changing this to a rate limited version would be fine with me.=20
>=20
> @Marc:
> How to proceed further? Should I send a V3 of the original patch
> set or should I split the patch set in two patch sets like you did?

Please split the patches as I did, or even better use the patches from
the pull request, as I've moved the some of the error print changes.

> The code would look then like:
>=20
> 	if (!context) {
> 		if (net_ratelimit())
> 			netdev_warn(netdev, "No free context. Jobs: %d\n",
> 				    atomic_read(&priv->active_tx_jobs));
> 		netif_stop_queue(netdev);
> 		ret =3D NETDEV_TX_BUSY;
> 		goto releasebuf;
> 	}

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2vmbmbx6zh2t3zve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjT/F8ACgkQDHRl3/mQ
kZzyBQf/VaKwRGS7gvaESxRPEOD6lRi2bShZU2FCdwkdEcPGegChJg+kFZDt5vra
Oy3zgVxmoPUilrBUT8hFYEUH9aje36aIoalloRRjCpAz8qhjqx8VX5DWvlaf/UjK
wAzBxvKMRczpVyCTWfByjmTVInTAzc8uIUmuo8zWhH+p5fTofoetGZV9jqiKt2n+
VlGfw5S/heWj2PH3N8Z8tEFBuJD1r35i5aFduQp6r1tqHSx60tbaAuRnKA0vymv6
ICPMyi25ooo7fle4/+xOYNTtP7+iB7QrIYfgevEIs3Hp1IPZEWXdEhsIEHkBqelC
hlqQJPL956mTlGk4PUphEw4K2GM0Wg==
=xzl/
-----END PGP SIGNATURE-----

--2vmbmbx6zh2t3zve--

