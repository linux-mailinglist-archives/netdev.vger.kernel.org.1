Return-Path: <netdev+bounces-145194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06209CDA7F
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F130B24816
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 08:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E9F18A6BC;
	Fri, 15 Nov 2024 08:31:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1367018BC2F
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659499; cv=none; b=KMme3rg3vZOviGuZdsxaRN+t9Anab6qijNSlifiVyIXxTe9GpwdvmIlPFRWGfj6yID7giP0vhJkSQ+A9PBu9pOVydexbqxru6oDoHbMmjLvudBN1J80i6miywqqNgVnylL8393k3t5CA/C0F8txTmFZXUT2HN7WdFl7nfrSgYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659499; c=relaxed/simple;
	bh=xcdtrxcwpTnLEPaXSmZR3NuiRhTzoRvMbIOYl8cGGsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeCnhM1hWkpbiLJu2Dh+iDyomP9q5EnfxXbTDq9DQWBBCDCuc369oLDpyYHhbnqgNH8R6naO5IG5UccoLitg02fZzW5Hy1QQovbTa2DFPrjTbw+t/q4RPgOvEXRP0MpQGCwhW4UMsxd/eBBjQ0b001ND46eHX2wZV1Zpax7pDrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBrjF-0000SB-St; Fri, 15 Nov 2024 09:30:57 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBrjD-000sSC-07;
	Fri, 15 Nov 2024 09:30:55 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AA09D373AB0;
	Fri, 15 Nov 2024 08:30:54 +0000 (UTC)
Date: Fri, 15 Nov 2024 09:30:54 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, 
	Jian Zhang <zhangjian.3032@bytedance.com>, netdev@vger.kernel.org, openbmc@lists.ozlabs.org, 
	Matt Johnston <matt@codeconstruct.com.au>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] mctp i2c: notify user space on TX failure
Message-ID: <20241115-scrupulous-mantis-of-purring-1c41fe-mkl@pengutronix.de>
References: <20241108094206.2808293-1-zhangjian.3032@bytedance.com>
 <20241113190920.0ceaddf2@kernel.org>
 <da9b94909dcda3f0f7e48865e63d118c3be09a8d.camel@codeconstruct.com.au>
 <20241113191909.10cf495e@kernel.org>
 <42761fa6276dcfc64f961d25ff7a46b764d35851.camel@codeconstruct.com.au>
 <20241114070235.79f9a429@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vt3m2lwmvec4zdoq"
Content-Disposition: inline
In-Reply-To: <20241114070235.79f9a429@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--vt3m2lwmvec4zdoq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] mctp i2c: notify user space on TX failure
MIME-Version: 1.0

On 14.11.2024 07:02:35, Jakub Kicinski wrote:
> On Thu, 14 Nov 2024 14:48:57 +0800 Jeremy Kerr wrote:
> > > routing isn't really my forte, TBH, what eats the error so that it
> > > doesn't come out of mctp_local_output() ? Do you use qdiscs on top
> > > of the MCTP devices? =20
> >=20
> > There are no qdiscs involved at this stage, as we need to preserve
> > packet ordering in most cases. The route output functions will end up
> > in a dev_queue_xmit, so any tx error would have been decoupled from the
> > route output at that stage.
>=20
> Ah, it's the driver eating the errors, it puts the packet on a local
> queue and returns OK no matter what. The I2C transfer happens from=20
> a thread.
>=20
> I wonder if there is precedent, let's ask CAN experts.
>=20
> Mark, MCTP would like to report errors from the drivers all the way=20
> to the socket. Do CAN drivers do something along these lines?

On CAN_RAW we send fixed size messages (struct can_frame) and there is a
bit left to mark a can_frame as an error frame. This basically means we
send the error notification inline.

What about using sock_queue_err_skb()? We do this in CAN_J1939.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vt3m2lwmvec4zdoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc3BrsACgkQKDiiPnot
vG+fYgf/Va/T2YBUFonO4TuAsteq+Vjzg37H/7ok0NZCvgSfZ8QqVGaI54B/ByJH
fdknhCQ6xHUH0ov7SkK7I8TS2LZHQ3N092ApMCtENsfCTg5ZybIiibPS2Teb+lPP
lKbktQqtS/5UX/ZJdstAl43zm/MYrNMHnfV2D+BUXDMpr3JvMFX6B6/jeUwZ/lAS
6r5QAne4+DWNfWf+1S+YWsYHqI1r5cuzN1ZcVPM2WhTM0LdksgkojKAvV5t7zDes
zwlUtToIF6nfehDyeue5wjMy0WrPOZQs8cTVi0GK3Z2petxKnGFWAvn5mkVg6T0k
Wc7MKFi1s015Oh1cjnxV6VwvambeUg==
=XgKe
-----END PGP SIGNATURE-----

--vt3m2lwmvec4zdoq--

