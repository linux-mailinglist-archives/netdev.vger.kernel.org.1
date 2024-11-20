Return-Path: <netdev+bounces-146435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9A99D3645
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FDC283AB2
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 09:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE6019CC1C;
	Wed, 20 Nov 2024 09:01:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C974C19B586
	for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093312; cv=none; b=Yq5CMLGyIJCYPpyb/pdnLUI1VXI/kxPLvtMJb7kf8D3475uGqcmbfIUJ27glAk+ClQ7fzRi6qnJwRZt6hH08tSaGsBSdzcXD059m19axkvik3sa1Ec8OFgWo/dDDJohIePewbzvVCJfU7XxW2eerOkX9J5b31sZRWZZ5vH/+V+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093312; c=relaxed/simple;
	bh=wcSMKiJ69HrlIc3nrCpMzCAQPxRMhBmAA0kEtaMXYi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWFUYYkNmoiJAyEMTfhg/Lp5X4S3OLEG07JMAYX/wxj98rf13W31Dett4BXOc5u9e0kBfkuWisXRgtQEiehpOyiVj72dGnKQrVXoe7hGKAOoUiPMEV1f6HUDb9knxdCE+gBVDMbmHCNk0lnWEQt0Cvz4Z6GiTYRMGd/WoN4yPyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDgaZ-0005Ak-DG; Wed, 20 Nov 2024 10:01:31 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDgaY-001iDr-3C;
	Wed, 20 Nov 2024 10:01:31 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 99084377A99;
	Wed, 20 Nov 2024 09:01:30 +0000 (UTC)
Date: Wed, 20 Nov 2024 10:01:30 +0100
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
Subject: Re: [PATCH 2/3] can: flexcan: add NXP S32G2/S32G3 SoC support
Message-ID: <20241120-cheerful-aloof-marmoset-362573-mkl@pengutronix.de>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
 <20241119081053.4175940-3-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wpzspvzzp6w362mq"
Content-Disposition: inline
In-Reply-To: <20241119081053.4175940-3-ciprianmarian.costea@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--wpzspvzzp6w362mq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] can: flexcan: add NXP S32G2/S32G3 SoC support
MIME-Version: 1.0

On 19.11.2024 10:10:52, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>=20
> Add device type data for S32G2/S32G3 SoC.
>=20
> FlexCAN module from S32G2/S32G3 is similar with i.MX SoCs, but interrupt
> management is different. This initial S32G2/S32G3 SoC FlexCAN support
> paves the road to address such differences.
>=20
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

If this flexcan integration has separate IRQ lines for Bus-Off and Error
IRQs, please add the FLEXCAN_QUIRK_NR_IRQ_3 in this initial patch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wpzspvzzp6w362mq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc9pWcACgkQKDiiPnot
vG+Mggf8DpZSw8wjaxZ6jHdpcyVL2PJMHg7z4vphPOmfUFCzMOV2ixIoprlMqXmg
i4CiHnHBKrIRK6tDDuM2Vr6O/6JOYwNwilPfpmWyXmJeHiuJKpTbzh/FEbv/uEnI
avaqtkK8/fft+pZ7Qb+3syoWPEMh+qI6Z3II1QGCAA5BzFSALrffJTtwm0RKl5Km
J017hnIPopYqewwD/fmBfpGYdJZbJe+IVzrniyqVDuduPWP999DsSv+QB62G3Qvj
S1jUNn7BK/A+EljRMSR2mIjXnP7is/Jc+3FmfrlJb8vSEoNafhABnf4RaNl0aGSU
1kCG4plZUgcuZUh036aMnDfr/dgdog==
=6DFs
-----END PGP SIGNATURE-----

--wpzspvzzp6w362mq--

