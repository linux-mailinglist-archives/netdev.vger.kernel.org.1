Return-Path: <netdev+bounces-157703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A1CA0B43D
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4FC188874F
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDCC2045AA;
	Mon, 13 Jan 2025 10:13:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768DA2045A6
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 10:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736763183; cv=none; b=Xv9CfCSLSvWd6IThfYFIJsJlq+uydNAz8/13Jl66wQsi7kBjlT256Uh5COCD9Vi1D9POfi+cc5rvNW5K2jDZWkvstcY0rH4oQ5MOFM9i5pNesuOQPNmEPwY7euprAPFv9/9KTDJETJHGfm2BVHBWw1I5iR/BSi+O2Em7oWYrd0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736763183; c=relaxed/simple;
	bh=aSlU/XU7Gw9vwATkxMVfaJHI9YBD7QlnksgCXz3qbtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCv2zkxWi5ILLyogVyx+lqz9g2aJptKYy0+xNCq5FdwuHdU3k1YV0FsLbYsqbGTgYSIq4E+8KhjPX92fLqXcN4qhyUv+uKN0OyeMTUcd+WoWmQDny7dnUjPCA1oq5f1QR7SYahcQSxonUc6ZzyeCPhh9MMPdqf2ZQ2kCRcKCbro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tXHRA-0003rW-Dw; Mon, 13 Jan 2025 11:12:48 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tXHR8-000Ere-1K;
	Mon, 13 Jan 2025 11:12:46 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 369573A60B6;
	Mon, 13 Jan 2025 09:52:33 +0000 (UTC)
Date: Mon, 13 Jan 2025 10:52:32 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	mailhol.vincent@wanadoo.fr, linux-can@vger.kernel.org
Subject: Re: [PATCH net-next] can: grcan: move napi_enable() from under spin
 lock
Message-ID: <20250113-outstanding-bronze-kestrel-d0927f-mkl@pengutronix.de>
References: <20250111024742.3680902-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w3ictz64yuvhjsen"
Content-Disposition: inline
In-Reply-To: <20250111024742.3680902-1-kuba@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--w3ictz64yuvhjsen
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] can: grcan: move napi_enable() from under spin
 lock
MIME-Version: 1.0

On 10.01.2025 18:47:42, Jakub Kicinski wrote:
> I don't see any reason why napi_enable() needs to be under the lock,
> only reason I could think of is if the IRQ also took this lock
> but it doesn't. napi_enable() will soon need to sleep.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Marc, if this is correct is it okay for me to take via net-next
> directly? I have a bunch of patches which depend on it.

Yes, please take it via net-next directly.

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--w3ictz64yuvhjsen
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmeE4l4ACgkQKDiiPnot
vG9HeAf+KWsa4lVfcia7SK0/l4aQ9itqxlDjwiV3UfE+FgzC+gb+dg1v8ZWEICMx
+2By71lhY3hYIS+H6vltiAIRNPHX2x0nZNe1HTdECwrA1rJxa9P7SkYpkF5DRnjP
XX6bgn4Rln0/jXF+eo3q//3wXNFWh/qs5ir1vzAvlkI2bPTWrlCkKVTiF0nlZRXM
Kl6Jjq6UNoAVLCZHH0UIgzcTZ4ER/PnVZS+pEw/kfCu4F6T3VXxBKemG1TfYy9DH
ZeB6524+h9uI61RY+oI7cQ6eDS7IkpT/B7yGSdxsssSlEnY/54I7lUubq9uzpO/K
eMYIcm3empQmdvvOiS+1MjnX9lBYAA==
=BQhA
-----END PGP SIGNATURE-----

--w3ictz64yuvhjsen--

