Return-Path: <netdev+bounces-69785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E029184C99C
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 12:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4801C24E65
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 11:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB07018EA1;
	Wed,  7 Feb 2024 11:30:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984DA1AADA
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707305455; cv=none; b=MybXXc+QXbScnzrtPm4G9L2uk9MQ08vL7TdfOkhY0gODNuuzdMrR0tFJYNHon27o7I/LZBdYMrwCgooyQ6VgnYPe6IHZxTOikX+Hym1NGAWW8V1khChDCsul501Oi5yPBB1qidXZm+dKDrdrn7aAugKlLIvDWjgCDX4Pg7ziCac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707305455; c=relaxed/simple;
	bh=mJPb3Csc9S+IPjh9zm7ZZ5fDJg1ab6QD0TMbnPaw/SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PS79VVkFkh565aYsk8N8tXsQYhncyQYaWaYEvRrgm8wMluXF8EnHEygFogIGir3DfsU5vQU+Yto6YWL5K0thJozkdBbIE2+Ts2KU6d2XsC64WTndgW5m9FrFeELkx1P8X/JEif4Tig+RT5W3/u/IshSLRt/Y9SbkkGgoU8oQjIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rXg8U-0007Ap-8G; Wed, 07 Feb 2024 12:30:38 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rXg8S-0050gf-KI; Wed, 07 Feb 2024 12:30:36 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3A7D4288803;
	Wed,  7 Feb 2024 11:30:36 +0000 (UTC)
Date: Wed, 7 Feb 2024 12:30:35 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] net: fec: Add ECR bit macros, fix FEC_ECR_EN1588 being
 cleared on link-down
Message-ID: <20240207-abreast-appraiser-7165418af08e-mkl@pengutronix.de>
References: <20240207111859.15463-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cu4vj53txk47ei46"
Content-Disposition: inline
In-Reply-To: <20240207111859.15463-1-csokas.bence@prolan.hu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--cu4vj53txk47ei46
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.02.2024 12:18:59, Cs=C3=B3k=C3=A1s Bence wrote:
> Signed-off-by: Cs=C3=B3k=C3=A1s Bence <csokas.bence@prolan.hu>

Please provide a patch description.

> ---
>  drivers/net/ethernet/freescale/fec_main.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethe=
rnet/freescale/fec_main.c
> index 63707e065141..652251e48ad4 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -273,8 +273,11 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address"=
);
>  #define FEC_MMFR_TA		(2 << 16)
>  #define FEC_MMFR_DATA(v)	(v & 0xffff)
>  /* FEC ECR bits definition */
> -#define FEC_ECR_MAGICEN		(1 << 2)
> -#define FEC_ECR_SLEEP		(1 << 3)
> +#define FEC_ECR_RESET   BIT(0)
> +#define FEC_ECR_ETHEREN BIT(1)
> +#define FEC_ECR_MAGICEN BIT(2)
> +#define FEC_ECR_SLEEP   BIT(3)
> +#define FEC_ECR_EN1588  BIT(4)

nitpick: can you keep the original indention?

> =20
>  #define FEC_MII_TIMEOUT		30000 /* us */
> =20
> @@ -1213,7 +1216,7 @@ fec_restart(struct net_device *ndev)
>  	}
> =20
>  	if (fep->bufdesc_ex)
> -		ecntl |=3D (1 << 4);
> +		ecntl |=3D FEC_ECR_EN1588;
> =20
>  	if (fep->quirks & FEC_QUIRK_DELAYED_CLKS_SUPPORT &&
>  	    fep->rgmii_txc_dly)
> @@ -1314,6 +1317,7 @@ fec_stop(struct net_device *ndev)
>  	struct fec_enet_private *fep =3D netdev_priv(ndev);
>  	u32 rmii_mode =3D readl(fep->hwp + FEC_R_CNTRL) & (1 << 8);
>  	u32 val;
> +	u32 ecntl =3D 0;

nitpick: please move it before the "u32 val;" so that it looks more
reverse-xmas-treeish.

> =20
>  	/* We cannot expect a graceful transmit stop without link !!! */
>  	if (fep->link) {
> @@ -1342,12 +1346,17 @@ fec_stop(struct net_device *ndev)
>  	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
>  	writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
> =20
> +	if (fep->bufdesc_ex)
> +		ecntl |=3D FEC_ECR_EN1588;
> +
>  	/* We have to keep ENET enabled to have MII interrupt stay working */
>  	if (fep->quirks & FEC_QUIRK_ENET_MAC &&
>  		!(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
> -		writel(2, fep->hwp + FEC_ECNTRL);
> +		ecntl |=3D FEC_ECR_ETHEREN;
>  		writel(rmii_mode, fep->hwp + FEC_R_CNTRL);
>  	}
> +
> +	writel(ecntl, fep->hwp + FEC_ECNTRL);
>  }

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cu4vj53txk47ei46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXDadYACgkQKDiiPnot
vG/E3QgAncnNsVMkgTePvIOhdjGWiKWBEVgOsiYbBHyP66pFGcI+O9W5H9L/uMGd
RcaPxP2xRIml6Y5IwyPu0/UnZmLfODKYn6YNuYbqPe+IKQaTclRE85kemylMdpDW
49uDbKWVebcFUqoodguzW4OUAvfpg3FHg+imsQaQYkWfSz6ULHEcJL2Oer2VYRsl
7lZYbMxa7e2m/DuSNtsvagGonJe0IJzDoLDMsyMYN+9Ml/7esWgTt630I56fO6Q0
cJVKyhOASc0SoSY8oBqK0g07mSOIl2cNe/ifvf2vJvDU3Puw3dKEaFN4SDMtIyAm
5QQG04q7M5HdVsYPKtrJovMbG0lS0w==
=tzM9
-----END PGP SIGNATURE-----

--cu4vj53txk47ei46--

