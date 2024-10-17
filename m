Return-Path: <netdev+bounces-136415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1A39A1B1B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3114C1C20823
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 06:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E106199229;
	Thu, 17 Oct 2024 06:56:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B919409C
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 06:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148184; cv=none; b=TDqXm6T1A/2wCjOb+OAISR/PvIrhGWXIVCGvxPgwPIopkWHRibVFaesHXebTAur27emvpy1JA2mKsYBYXj8GgXfcpCqdEyazR/t2lAcuEK+bjxP4Jk7sVahxmk19lt+AbOwg5WPFYQCMKWayHsDRS53tcfzRo+oXntVsde5KDrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148184; c=relaxed/simple;
	bh=2LXFTfPKVtP+wXDiw37jeu5qX7y5o0JZRZk1/lZryKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLcXRfQ6C3hYL6L3mt58dKhPVwZqxMHRdJr7RFaT1zNe+0DX5YUUyA2r0ZQuANGRND+QrLjnWGVZ6GeWmEGjjfOIgcAumBTpzA7x2qStJoiuT0LY1aF62ScKjsi08vUQZ5PhUhQC6HZHJYTqd1uD2cfSjb5R07GzRmwEnfC1LWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KQZ-0008Qx-Q2; Thu, 17 Oct 2024 08:56:07 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KQZ-002U7v-A0; Thu, 17 Oct 2024 08:56:07 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 04DA6354D79;
	Thu, 17 Oct 2024 06:56:07 +0000 (UTC)
Date: Thu, 17 Oct 2024 08:56:06 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, imx@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 05/13] net: fec: fec_restart(): introduce a
 define for FEC_ECR_SPEED
Message-ID: <20241017-elegant-smilodon-of-fascination-0ccf4c-mkl@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-5-de783bd15e6a@pengutronix.de>
 <ZxBw8Jph6mPW8ExQ@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fzhhiooh6gpdajeh"
Content-Disposition: inline
In-Reply-To: <ZxBw8Jph6mPW8ExQ@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--fzhhiooh6gpdajeh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.10.2024 22:05:36, Frank Li wrote:
> On Wed, Oct 16, 2024 at 11:51:53PM +0200, Marc Kleine-Budde wrote:
> > Instead of open coding the bit mask to configure for 1000 MBit/s add a
> > define for it.
>=20
> Replace "1 << 5" for configuring 1000 MBit/s with a defined constant to
> improve code readability and maintainability.

Fixed,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fzhhiooh6gpdajeh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcQtQQACgkQKDiiPnot
vG/HNQf+Ibh78Ah8wakBm9pOmoQ66lmfz/spL7rOeMDtANUon1MNOBbVlRku0aFs
nS35Nbc2rOXw5gkqUO/3xS06xPWMD0I+JSn0kS3K5kAVI1rWJxNYZ1aeFh6ErdYR
fL7WdYCEgwHSFx7wmTpUCRNr071qf58rYemuflT5sk6pj5JTQ5grjEXj/nKaPZSq
R1p+NbYKuN2v7rUxaxSBj5XOztiHPaPOqFlpn3Gi96291q2OqssZS0rrI0EWz8ST
tL7Y9Ao2qLCARsA1NDwFBGCBc8YUwE6amp8mpZu1yynn2bkAZm0AJz5vlmreQZFv
Jhgo7W5sSbLW/dR7iwg8t/nobYNcBA==
=ury5
-----END PGP SIGNATURE-----

--fzhhiooh6gpdajeh--

