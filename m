Return-Path: <netdev+bounces-146433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043C09D35E0
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 09:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF722834CC
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 08:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B1D19924F;
	Wed, 20 Nov 2024 08:49:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3841518871F
	for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092595; cv=none; b=VbhFdDSk5LTvvgWCTZMwyF+dhmitqw4LjMJ9zADrCQ8js0sFeZcOZVLwQGd4aiIwUOnqzI5ULPdTbWYRpY+URfFsz2Xja3e7NJwvXWi84EA9Ku7n8VYTkrsLKXt6sYGtPlEsbPZuvDFBqJ5kfoK54sm3KsCWhc4vo6IDLxjWxOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092595; c=relaxed/simple;
	bh=z6uGNiyKdhbu4W52lK1ROjc1cwQmth/lR3lpQuGvlFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFLEiqOIw3x3D7uo1XZtyJXkT0J6C/JYpp9IaRi/X5rXvZDIz/6LlsSYnF8ItG45SZQ5cuDZ3DU1P2cGeofqN+DUVFfHinFxuOcVIDSjTG8vgxtNSHXxVLs69mTF0ssYSXlFFZzaKvOHqxgkxQ7cBvRLJRby1L8kU/RZeW1Cebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDgOy-0002L4-Bq; Wed, 20 Nov 2024 09:49:32 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDgOx-001iBn-1u;
	Wed, 20 Nov 2024 09:49:31 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2BA88377A6C;
	Wed, 20 Nov 2024 08:49:31 +0000 (UTC)
Date: Wed, 20 Nov 2024 09:49:30 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, NXP Linux Team <s32@nxp.com>, 
	Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, 
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC
 support
Message-ID: <20241120-loose-amorphous-manul-49ded8-mkl@pengutronix.de>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
 <20241119081053.4175940-2-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p6fwbv6zisgrhr6x"
Content-Disposition: inline
In-Reply-To: <20241119081053.4175940-2-ciprianmarian.costea@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--p6fwbv6zisgrhr6x
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC
 support
MIME-Version: 1.0

On 19.11.2024 10:10:51, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>=20
> Add S32G2/S32G3 SoCs compatible strings.
>=20
> A particularity for these SoCs is the presence of separate interrupts for
> state change, bus errors, MBs 0-7 and MBs 8-127 respectively.
>=20
> Increase maxItems of 'interrupts' to 4 for S32G based SoCs and keep the
> same restriction for other SoCs.

Can you add an "interrupt-names" property?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--p6fwbv6zisgrhr6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc9opgACgkQKDiiPnot
vG+wiwgAh11QjYP8xYpcPbJZwG3wRM/IlhLrAxES4a5SgyhHqDVWYNViijSN1BJj
D2+S8YYBuNAw6jMpUOEXOBkHSRkSA3KHqIFIkghkOvG+rMzwRNToBPlUIztDG78V
p5EgsERpeQ0l5VqGk+7BmKtxNSWTs2dnOEw6sGfhdPDujSDcooMiSRJc5bKeJHkl
gjb40viNVrJYDB/4Od+GYTQDUezcHB1HIWLAAn1/MIDtaKLyCfIXtRxNR9EYxOKc
hQ4JXJw101hutB/L/D1AqXKuIyu294ILEevn1bXtPklg2W/JaixYcsvAkF+G4RWg
n3dccj7YW6JwlwS+d7sUvUdvTCe6Yg==
=zshn
-----END PGP SIGNATURE-----

--p6fwbv6zisgrhr6x--

