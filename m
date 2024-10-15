Return-Path: <netdev+bounces-135431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA5A99DE33
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0751C21586
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 06:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A468318B486;
	Tue, 15 Oct 2024 06:23:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC946189F50
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 06:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728973416; cv=none; b=lCi809sxiOFAdPuWKd2pG/YcyLKnNtI7GUeVcQsE2z9gNDZAxBnBoaIKryvggMN/Y1khcsZCHev9CiyYBRvEHv6urN4NIsBVDEdc+onDS/wKtIEWdJWXmrkS+ATTb3RFr+QANRp+XbbAv6RLqUZy6c3B1EmnfOwSfh+My2khxro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728973416; c=relaxed/simple;
	bh=KHAi2VgNu03KG896sE8HnTfHWbjZzQZ+KrRFXALJR2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYumbOG5WIov4FssHstpxLIvBYgHBFTzVFxrvJ7aSJ/2ujQot4FUAlMSaSAaXks1kpEdu+lPIBs6HvLUH5bQD+PEq/gzOM6WKm51f24HXm0v5yGOpOp/m1dtwnMpezIIpYCXJgCIacF3Q4gSJWYbb7ADY4RxZs8Q4iNV2r14lKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t0axs-0008Ns-2F; Tue, 15 Oct 2024 08:23:28 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t0axr-001xwt-KT; Tue, 15 Oct 2024 08:23:27 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 48B37352EC9;
	Tue, 15 Oct 2024 06:23:27 +0000 (UTC)
Date: Tue, 15 Oct 2024 08:23:27 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2 net-next 10/11] can: gw: Use rtnl_register_many().
Message-ID: <20241015-ochre-gaur-of-whirlwind-d6e892-mkl@pengutronix.de>
References: <20241014201828.91221-1-kuniyu@amazon.com>
 <20241014201828.91221-11-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="obmbugxzhx27phby"
Content-Disposition: inline
In-Reply-To: <20241014201828.91221-11-kuniyu@amazon.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--obmbugxzhx27phby
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.10.2024 13:18:27, Kuniyuki Iwashima wrote:
> We will remove rtnl_register_module() in favour of rtnl_register_many().
>=20
> rtnl_register_many() will unwind the previous successful registrations
> on failure and simplify module error handling.
>=20
> Let's use rtnl_register_many() instead.
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

Who is going to take this patch?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--obmbugxzhx27phby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcOClwACgkQKDiiPnot
vG+nTAgAjnKUXYYbIxZLDIeYWnWd+OVPRbhE+gb7SzXu/V/z2yykWxBBmJNyV7Ga
+KFkWNJStmB8Nqf1VahhQzRwU1irKfxJfstINXWU0efv5SSK9/0SKMdDkrR/vCIo
73l+qwfzEeszScGmMeRwdreSNNyD5PwiAVwWwQUygFkX9KqlwbLIAsybLUgl/BWP
WLEKbJOiYH9N0HLl0JhZ9RUjTZF8ki58GsGdrHrb9HV818L1H3RMzkOn+KayNgQF
k3u0eRWoZNjeXhqAUuMn3xDsUWjA40ntJCe637VKKjE1ZfDwKzmBVh/147mhPao6
ltEPEfqxSGWTtg+xXQlloxv2u8/LQw==
=Op3n
-----END PGP SIGNATURE-----

--obmbugxzhx27phby--

