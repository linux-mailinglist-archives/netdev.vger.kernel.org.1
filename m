Return-Path: <netdev+bounces-136419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E409A1B3D
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BB91F28BC2
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F7A1C2420;
	Thu, 17 Oct 2024 07:03:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858181BA285
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 07:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148591; cv=none; b=hvC7j4d6t9GRsyVrgCmL3i0fEJbBrBPik3KN07ORgOs6GFuka8X/f7kKknu5BkK9Ww4X+o+xSin1PrEq1M6fAXcB3HSCLqwWXfFJimvjXDvznCCal9fMnYFSHLCWMDvQtekdSCeSOSWdAYiBiLsjGsYd7DsBJ64ffzAdQHAe7/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148591; c=relaxed/simple;
	bh=6Jtr16ZJzQOFs0XnMxh5Jwvehj6+gdDdsyxTKoQlxXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eL2Pc1P1XPXvbGI9ZK/4vm3Zm6SxjOZGavj+X9n9BpRLMXynX1+0SPB0rM4MRi31/S2gTxrNoBkhRIJ+TKRKp7GmTW9D134jo/NP5BzjVQ2xGtBri+Ox9NDFSaIkHFYMfnkjQaArsdFrO08T5gwk3kxM1U/vl0YhXROWcfNUD5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KX7-0000a5-7P; Thu, 17 Oct 2024 09:02:53 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KX6-002UCz-LD; Thu, 17 Oct 2024 09:02:52 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 464F8354D93;
	Thu, 17 Oct 2024 07:02:52 +0000 (UTC)
Date: Thu, 17 Oct 2024 09:02:51 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, imx@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 09/13] net: fec: fec_enet_rx_queue(): use same
 signature as fec_enet_tx_queue()
Message-ID: <20241017-bird-of-striking-relaxation-b30671-mkl@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-9-de783bd15e6a@pengutronix.de>
 <ZxB3NB7qbSuPluZc@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="arfarvx37qyy5g3n"
Content-Disposition: inline
In-Reply-To: <ZxB3NB7qbSuPluZc@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--arfarvx37qyy5g3n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.10.2024 22:32:20, Frank Li wrote:
> On Wed, Oct 16, 2024 at 11:51:57PM +0200, Marc Kleine-Budde wrote:
> > There are the functions fec_enet_rx_queue() and fec_enet_tx_queue(),
> > one for handling the RX queue the other one handles the TX queue.
> >
> > However they don't have the same signature. To make the code more
> > readable make the signature of fec_enet_rx_queue() identical to the
> > signature of fec_enet_tx_queue().
>=20
> 'signature' is strange here.

Signature, or the full name 'type signature', defines the types and
order of a function's arguments, see:

| https://en.wikipedia.org/wiki/Type_signature

> Align fec_enet_rx_queue() argument order with fec_enet_tx_queue() to make
> code more readable.

I've updated the last sentence.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--arfarvx37qyy5g3n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcQtpkACgkQKDiiPnot
vG9luAf7Bqn8DYmvRyOF0fsOReuyxJbzYNQP3NWE9fvzmOT/2VojUbLb40TKNMxZ
N6J586Lzdpki2hvuGFmmEf+uCMoKmslgflB4T3GM2i0kDkXLbC4qh1IyEo+CPbMu
jE8TlqLykNk5auPGilIAHeILTspWCIUnOD5vqPmQiobZacafWJ77IlqwVIU5ncYq
UOjLXXZ4ED5Ts+YhjUTqnA47byugEyqT17gHNDaLgA/sEyTsNPUl4w2W+APNKM0w
w45YKk5GQk7Ijva0NuIWt4ZCVgPxaAKMULp+UABKbIoEi0MTW/RwrissPjD5R9p5
A87JzdInBAMXvkCpuogFclx8qaqVYg==
=AZGX
-----END PGP SIGNATURE-----

--arfarvx37qyy5g3n--

