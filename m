Return-Path: <netdev+bounces-111685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0A09320CE
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9141C219CD
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 06:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454B61CD32;
	Tue, 16 Jul 2024 06:57:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F34225761
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721113058; cv=none; b=MdzRNV2d4DQ9zOzZKIACnwznJnQTODz9Qm0G/0iyiCa+f35ICJu/HOiqXYvY5rZirYv+igAJmLB93q8M0h8R9XR3pVQSPLOT2ApKnJkTcMBiJzkywyO++ddqRXzenuIhIlUOJMO1IkefX3MFE2LfcaHS3n+pdlZlBcKw8ZRhhQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721113058; c=relaxed/simple;
	bh=8qlscJasTrwwPLY1nNciHNwhUNUtFNdBxH9NWwcXmjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyrrYqkAS9len2iu4WCGhowUNhEC3LrsKBgW2r2x1WebtkS6DSrg+MxmnZG+nF+7g0D7r/ldfBtu5vIdKN8sHdFnSsbGm0vmps+DU/B6arRBppbgz7QA7PUu/zInQm75soCkqcFOx4YIKtluhdRIsekrw4rk9ApMv6JDOoD4FjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sTc74-0004f5-9S; Tue, 16 Jul 2024 08:56:38 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sTc71-0004NX-ML; Tue, 16 Jul 2024 08:56:35 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4C5A2304DE4;
	Tue, 16 Jul 2024 06:56:35 +0000 (UTC)
Date: Tue, 16 Jul 2024 08:56:34 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	haibo.chen@nxp.com, imx@lists.linux.dev, han.xu@nxp.com, 
	Chircu-Mare Bogdan-Petru <Bogdan.Chircu@freescale.com>, Dan Nica <dan.nica@nxp.com>, 
	Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>, Li Yang <leoyang.li@nxp.com>, 
	Joakim Zhang <qiangqing.zhang@nxp.com>, Leonard Crestez <cdleonard@gmail.com>
Subject: Re: [PATCH v2 2/4] can: flexcan: Add S32V234 support to FlexCAN
 driver
Message-ID: <20240716-magnificent-imported-ammonite-06274a-mkl@pengutronix.de>
References: <20240715-flexcan-v2-0-2873014c595a@nxp.com>
 <20240715-flexcan-v2-2-2873014c595a@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7czg2i2w4wkjgew7"
Content-Disposition: inline
In-Reply-To: <20240715-flexcan-v2-2-2873014c595a@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--7czg2i2w4wkjgew7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.07.2024 17:27:21, Frank Li wrote:
> From: Chircu-Mare Bogdan-Petru <Bogdan.Chircu@freescale.com>
>=20
> Add flexcan support for S32V234.
>=20
> Signed-off-by: Chircu-Mare Bogdan-Petru <Bogdan.Chircu@freescale.com>
> Signed-off-by: Dan Nica <dan.nica@nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> Reviewed-by: Li Yang <leoyang.li@nxp.com>
> Reviewed-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index 8ea7f2795551b..f6e609c388d55 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -378,6 +378,10 @@ static const struct flexcan_devtype_data fsl_lx2160a=
_r1_devtype_data =3D {
>  		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
>  };
> =20
> +static struct flexcan_devtype_data fsl_s32v234_devtype_data =3D {
> +	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_DISABLE_MECR,
> +};

- Does the core support CAN-FD?
- Does the core generate an error interrupt when going from error warning
  to error passive?
- Are you sure, you don't need to enable FLEXCAN_QUIRK_ENABLE_EACEN_RRS?
- You probably want to use the mailboxes instead of the FIFO for the
  RX-path.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7czg2i2w4wkjgew7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmaWGaAACgkQKDiiPnot
vG/7sQgAgoy9kUcei84qu1gP/cmLa39WpufEkj5qo0h9LC6ryRNtHYJJVHdpthTt
SxG5murRrAfL7yeoaG09mOH8ROFWIdoXrVULxUGYF7sumeLW1AQXnatEdzgUgAEn
4SkwIr8lsFKMAWoV1JB/UPEBhAMaJ1eHrvVEtzXZMacVKlw/uEj6V7K8vfN2nhdh
uL8P8ERJln6grTXv5ydB+kpSuGw8/xLMYko5qrk29Kek+Fd9FeybZdu9nYf3Ea68
96EBM6f6E+/T7c16p7NeYZiwkc0id21xbQDLbOYRsOkehUklskz0WrY9fMPFONRP
+urFyd+I6wA0roHQBfuSy4ibb+JkdA==
=sBBU
-----END PGP SIGNATURE-----

--7czg2i2w4wkjgew7--

