Return-Path: <netdev+bounces-129271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE66197E992
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 12:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0D31C217CD
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 10:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BB819922D;
	Mon, 23 Sep 2024 10:08:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57D3194A54
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086133; cv=none; b=jyhxMq3lzgcqEibqWx6+Vump9HiIa+aVm7gN1x7v+qaTW+HeI8paR3upeGoa3kQM3eVTMmxFY/SfOuLUbWycc7ZGguj7bL0/2QUPD90xCG4AsUHebXGKpcWlsIi4V6MthwGclC9W2u8sa+dd42D6VpJFB/nz3pOoBsQC6G8tH8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086133; c=relaxed/simple;
	bh=wAxj4X47rwpfE8DME5JjC/KFI3GHmOUUJeEabElbU5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ba7jhBm3pkaijpVl9+G1zB5CfwmxpiXdlHqnnc1kkdaDi0sl9z9i2F2BmAj3N0g1C070yghvbvBz378fQVNBfupVOFy2kGCfyOPeC8MIKckZkt6+iqgBmaNVhJMyvWzTRVUUmbbEO2GRSmhXuhffAPVDBcrKELIdQT7r3J2le3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ssfzS-00006g-IR; Mon, 23 Sep 2024 12:08:22 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1ssfzN-000vje-Rt; Mon, 23 Sep 2024 12:08:17 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6D6CE340BDC;
	Sun, 22 Sep 2024 21:13:45 +0000 (UTC)
Date: Sun, 22 Sep 2024 23:13:44 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	William Qiu <william.qiu@starfivetech.com>, devicetree@vger.kernel.org, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] can: Add driver for CAST CAN Bus Controller
Message-ID: <20240922-inquisitive-stingray-of-philosophy-b725d3-mkl@pengutronix.de>
References: <20240922145151.130999-1-hal.feng@starfivetech.com>
 <20240922145151.130999-4-hal.feng@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ynvekyrzzuwpg3ly"
Content-Disposition: inline
In-Reply-To: <20240922145151.130999-4-hal.feng@starfivetech.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--ynvekyrzzuwpg3ly
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.09.2024 22:51:49, Hal Feng wrote:
> From: William Qiu <william.qiu@starfivetech.com>
>=20
> Add driver for CAST CAN Bus Controller used on
> StarFive JH7110 SoC.

Have you read me review of the v1 of this series?

https://lore.kernel.org/all/20240129-zone-defame-c5580e596f72-mkl@pengutron=
ix.de/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ynvekyrzzuwpg3ly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbwiIUACgkQKDiiPnot
vG+1cAf+JRa6qiL+McRGaVYbwDK+5KafGW3568LC7Fz2J4e36IgRjTNWrK3zGdwR
lUQekR2f2bapcH5T72+S0KDjjyI0v28jzRcWZR/A1/FsKY+xFTeNzOG+6ODx2VRV
YMxZ58ZM2telOVS0SUtaGiLpXBrayzpz5nCOUxyymt1SdjjkdaVifDayKJI5vwvh
IT4lXhvNRgPy3Guw9C9YcSk0OyIZ/TFOosTB3Db3j4M9SxdL8HgIc2H5NkV1+4Tz
UmEmWzNKgZS0XDRPtpMe6DqR+zkm4IVm+9NNk6+0XRQ8aEZr77W7LQq946qSd/1O
EgLfQi6D50XAsIef/NFxmgOk9EUKAQ==
=udGo
-----END PGP SIGNATURE-----

--ynvekyrzzuwpg3ly--

