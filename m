Return-Path: <netdev+bounces-144910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D44819C8C23
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D4FB2D16D
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793B11799B;
	Thu, 14 Nov 2024 13:34:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E496417583
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591281; cv=none; b=QmrvqMerkc7tRQE0apcvK8dRLa71pzvnclAcIf+t4Mt00f0mrMQUsEmlzSx+448iqAEyGmyyi+QS8OQup4ci48LlmiRiXZbw2vEF/UOrAzCrG7KRvMQ0RFWh74OF4+fj7mxEiaFO7xT7w1CLoozZeGjKsxH/CJgzde90zPTAe8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591281; c=relaxed/simple;
	bh=LOmxPIMg6jrFPKZiUguNgedM9X7esh/UZV6ZPaYukPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOy/pql3OMnsj1WAkwmXO/9afCXn1PwRY4pir2EJ9VisgVP3cMmaA/D634iCXPaC72n33AS7DwgGAG9AQSsPfsxs+cojIdbeuyWVcJVeYNSaWn4us+60iqv+g0VEVLCzZ8KDfdWp/bbQasQ9LeL3t4LOBrN4VxJUTaCN7lYE+oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBZzP-00079t-8i; Thu, 14 Nov 2024 14:34:27 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBZzN-000kVD-09;
	Thu, 14 Nov 2024 14:34:25 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A9469373215;
	Thu, 14 Nov 2024 13:34:24 +0000 (UTC)
Date: Thu, 14 Nov 2024 14:34:24 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Max Staudt <max@enpas.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] can: can327: fix snprintf() limit in
 can327_handle_prompt()
Message-ID: <20241114-olive-petrel-of-culture-5ae519-mkl@pengutronix.de>
References: <c896ba5d-7147-4978-9e25-86cfd88ff9dc@stanley.mountain>
 <6db4d783-6db2-4b86-887c-3c95d6763774@wanadoo.fr>
 <4ff913b9-93b3-4636-b0f6-6e874f813d2f@stanley.mountain>
 <9d6837c1-6fd1-4cc6-8315-c1ede8f20add@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xu6aanxxn243barg"
Content-Disposition: inline
In-Reply-To: <9d6837c1-6fd1-4cc6-8315-c1ede8f20add@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--xu6aanxxn243barg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: can327: fix snprintf() limit in
 can327_handle_prompt()
MIME-Version: 1.0

On 14.11.2024 21:35:07, Vincent Mailhol wrote:
> On 14/11/2024 at 18:57, Dan Carpenter wrote:
> > On Thu, Nov 14, 2024 at 06:34:49PM +0900, Vincent Mailhol wrote:
> > > Hi Dan,
> > >=20
> > > On 14/11/2024 at 18:03, Dan Carpenter wrote:
> > > > This code is printing hex values to the &local_txbuf buffer and it's
> > > > using the snprintf() function to try prevent buffer overflows.  The
> > > > problem is that it's not passing the correct limit to the snprintf()
> > > > function so the limit doesn't do anything.  On each iteration we pr=
int
> > > > two digits so the remaining size should also decrease by two, but
> > > > instead it passes the sizeof() the entire buffer each time.
> > > >=20
> > > > If the frame->len were too long it would result in a buffer overflo=
w.
> > >=20
> > > But, can frame->len be too long? Classical CAN frame maximum length i=
s 8
> > > bytes. And I do not see a path for a malformed frame to reach this pa=
rt of
> > > the driver.
> > >=20
> > > If such a path exists, I think this should be explained. Else, I am j=
ust not
> > > sure if this needs a Fixes: tag.
>=20
> I confirmed the CAN frame length is correctly checked.
>=20
> The only way to trigger that snprintf() with the wrong size is if
> CAN327_TX_DO_CAN_DATA is set, which only occurs in can327_send_frame(). A=
nd
> the only caller of can327_send_frame() is can327_netdev_start_xmit().
>=20
> can327_netdev_start_xmit() calls can_dev_dropped_skb() which in turn calls
> can_dropped_invalid_skb() which goes to can_is_can_skb() which finally
> checks that cf->len is not bigger than CAN_MAX_DLEN (i.e. 8 bytes).
>=20
> So indeed, no buffer overflow can occur here.
>=20
> > Even when bugs don't affect runtime we still assign a Fixes tag, but we=
 don't
> > CC stable.  There is no way that passing the wrong size was intentional.
>=20
> Got it. Thanks for the explanation, now it makes sense to keep the Fixes:
> tag.

Should we take the patch as it is?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xu6aanxxn243barg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc1/F0ACgkQKDiiPnot
vG/HGgf9EeX24y7P9tYOPhJJz1/H/hn654sGuGCLl/nN3MJgAydMHuylzmzTiz/E
GvsLM85ZVXv7HbQ/chW/9EWFW7got3Ba6ANhtFnTCmkiLvPCApOPVPWYUUyTjE8Y
8FlwAu9CbfzvlcCjnRX1bsK/3WPm2PK5Ry6z5Gh2/jTpmpHdPMZZZTNpW3KRBIdQ
Tkn+0mg2uibVFzSjGNf0u74gwaoJyU09SoaleHjDm3UojDwNUwb36j+h3j0bpfek
9GQPG+mFqZvEJJtpkN3LegRggtVMO6cib4360/0FhFLCvD6hp3+yfqXsLTtRcDFT
+GOsBwRir+/j15W6xPnW9hyQlg+fSg==
=ckyc
-----END PGP SIGNATURE-----

--xu6aanxxn243barg--

