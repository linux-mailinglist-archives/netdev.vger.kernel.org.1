Return-Path: <netdev+bounces-164510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BF1A2E049
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 20:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B453A5B10
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 19:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349CB1922D4;
	Sun,  9 Feb 2025 19:46:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150BC70807
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739130360; cv=none; b=rINL8fuSFs+UZOyA5wWAbI247DlA6Pd9WllwBBLXxvJ2Ddx8qDvCE4VhTP77Jsq0dMr+c8pFYG+fP36W6AyTCAmy0cdMqCqzYiY3+zhneOPxZjWvwxqHuEx1NuJeluZHAj2NFHE3Qqlw+nt59/JYmco1/9rzxtBUaS4a7ysIEU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739130360; c=relaxed/simple;
	bh=YpOONgEkF20tcqZ3NmMFtl2heUImZSs8vEBzd9SNccs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+f++3wWf8Hq0/ij+/Q+L1HkTBmYqBeJgltM8vLL1OpCZiPZlmOPtWNXDnVRoxX4AY9xMEHvyLNiA3fTBz/GTZo9EkV02pDdj/ZPAaWhGmPH0Eylq72cOimBK1G4IOdOR8tUEKDITZs1jA0BlbUrUvkSsln5u7lhHrBufRBMtkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1thDFP-0003BH-LK; Sun, 09 Feb 2025 20:45:43 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1thDFP-0007tm-11;
	Sun, 09 Feb 2025 20:45:43 +0100
Received: from pengutronix.de (unknown [IPv6:2a02:1210:32cc:3000:b91d:2c31:8aee:36c3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EC32E3BD5AB;
	Sun, 09 Feb 2025 19:45:30 +0000 (UTC)
Date: Sun, 9 Feb 2025 20:45:25 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <Stefan.Maetje@esd.eu>
Cc: "horms@kernel.org" <horms@kernel.org>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Frank Jungclaus <frank.jungclaus@esd.eu>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH 1/1] can: esd_usb: Fix not detecting version reply in
 probe routine
Message-ID: <20250209-platinum-numbat-of-calibration-a8514d-mkl@pengutronix.de>
References: <20250203145810.1286331-1-stefan.maetje@esd.eu>
 <20250203145810.1286331-2-stefan.maetje@esd.eu>
 <20250206-wild-masked-hoatzin-b194e1-mkl@pengutronix.de>
 <d7fd564775351ea8a60a6ada83a0368a99ea6b19.camel@esd.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="elfnnhkrcv3ndzlv"
Content-Disposition: inline
In-Reply-To: <d7fd564775351ea8a60a6ada83a0368a99ea6b19.camel@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--elfnnhkrcv3ndzlv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] can: esd_usb: Fix not detecting version reply in
 probe routine
MIME-Version: 1.0

On 09.02.2025 18:53:43, Stefan M=C3=A4tje wrote:
> > > > > -	return usb_bulk_msg(dev->udev,
> > > > > -			=C2=A0=C2=A0=C2=A0=C2=A0usb_rcvbulkpipe(dev->udev, 1),
> > > > > -			=C2=A0=C2=A0=C2=A0=C2=A0msg,
> > > > > -			=C2=A0=C2=A0=C2=A0=C2=A0sizeof(*msg),
> > > > > -			=C2=A0=C2=A0=C2=A0=C2=A0&actual_length,
> > > > > -			=C2=A0=C2=A0=C2=A0=C2=A01000);
> > > > > +	for (attempt =3D 0; attempt < 8 && cnt_vs =3D=3D 0; ++attempt) {
> > >=20
> > > Can you create a #define for the "8" to avoid a magic number here?
>=20
> This value was found empirically. But I think I have to reconsider
> the style of handling here and may need to adapt the solution.

You're the expert, change it as needed. I can only comment on the coding
style and its best to avoid numbers in the code. Create a define and if
you think it's worth, document that it's an empirically found value.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--elfnnhkrcv3ndzlv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmepBdAACgkQDHRl3/mQ
kZw4SAf+LCQMYmQFCBf/DDbBUAkjiRiHJgH7VKwgfcxd2iVd0JdLK5Qt15sr8Ag+
PbFpHy/yvMvfHMmLZ6hoRW34OINxJj/pTNcAruqSso1jjhzQ17NcUPpZhhMSLpwY
Jw4cHBFjGoJ7xh8egXSnbKdBH9PBiKEV0Cb07mw87c/SAwbjiPRQJFvahKv6Es35
izyvnU6ogBcCxhAsgWjxKNaI0tbQszpTJN1tamvVc+g+E3Wg524Rnd5ZBSuaBYcv
taM+xzI2kF2PZI3FExrqDWMMdqMNZXiifddev5nWhVsZotoGZ8G8mPv2826im4W9
I+4wjmIoQdJSfpchxxqmCQ/XvQNPuA==
=okuT
-----END PGP SIGNATURE-----

--elfnnhkrcv3ndzlv--

