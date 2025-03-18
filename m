Return-Path: <netdev+bounces-175653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1757DA67001
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B2E57AC0DE
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAFC207A0F;
	Tue, 18 Mar 2025 09:40:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4132040B7
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290814; cv=none; b=VhukJ2zZfWp1erBJZUPu/cftRNfDb2FMb9Fp9HStOsJzx63AYnW+BQcd1b7yKrFijktjyLkDy6ttpuc2ZQD8B9T2PwNiHvar9CxD70I7SofYT2qqs1MdnpSd7yjNQVgWd/tBUD1lyIhbeP5abQAa1RQ1MkgcwnR325ehpxs4A/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290814; c=relaxed/simple;
	bh=WChQF7TtuUtzCTdzukaysCL3gi4APAjdIMuYzKD+0nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNnWkQrJdEXdvBk8diYOPqYHnaNQhSynfXcgNvJ6RhOd6077kkOSq6xvnLUCs3VCqjS7rac7QSIWRkbSjAJc74qpUPQbFmodObf1ssNJsSz9Y5fFFDI/4WNF2spKSnz69s4rtqMbzpmeqBwXsdmRKGNVyAsnePuW4rizeW47OoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tuTQS-0007RA-VB; Tue, 18 Mar 2025 10:39:56 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tuTQS-000P4Y-02;
	Tue, 18 Mar 2025 10:39:56 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0018E3DF4D5;
	Tue, 18 Mar 2025 09:39:55 +0000 (UTC)
Date: Tue, 18 Mar 2025 10:39:55 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Russell King <rmk+kernel@armlinux.org.uk>, 
	Thangaraj Samynathan <Thangaraj.S@microchip.com>, Rengarajan Sundararajan <Rengarajan.S@microchip.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Phil Elwell <phil@raspberrypi.org>, 
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, kernel@pengutronix.de, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 01/10] net: usb: lan78xx: handle errors in
 lan7801 PHY initialization
Message-ID: <20250318-friendly-victorious-bustard-fcfbfe-mkl@pengutronix.de>
References: <20250318093410.3047828-1-o.rempel@pengutronix.de>
 <20250318093410.3047828-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gxukq2mcwm43hawu"
Content-Disposition: inline
In-Reply-To: <20250318093410.3047828-2-o.rempel@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--gxukq2mcwm43hawu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v4 01/10] net: usb: lan78xx: handle errors in
 lan7801 PHY initialization
MIME-Version: 1.0

On 18.03.2025 10:34:01, Oleksij Rempel wrote:
> Add error handling for `lan78xx_write_reg()` and `lan78xx_read_reg()`
> in `lan7801_phy_init()`. If any register operation fails, return
> an appropriate error using `ERR_PTR(ret)` to prevent further execution
> with invalid configurations.

You have to convert the caller of lan7801_phy_init(), too. AFICS it
checks for NULL only.

Marc

> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/usb/lan78xx.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 137adf6d5b08..d03668c2c1c9 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -2531,11 +2531,22 @@ static struct phy_device *lan7801_phy_init(struct=
 lan78xx_net *dev)
>  		dev->interface =3D PHY_INTERFACE_MODE_RGMII;
>  		ret =3D lan78xx_write_reg(dev, MAC_RGMII_ID,
>  					MAC_RGMII_ID_TXC_DELAY_EN_);
> +		if (ret < 0)
> +			return ERR_PTR(ret);
> +
>  		ret =3D lan78xx_write_reg(dev, RGMII_TX_BYP_DLL, 0x3D00);
> +		if (ret < 0)
> +			return ERR_PTR(ret);
> +
>  		ret =3D lan78xx_read_reg(dev, HW_CFG, &buf);
> +		if (ret < 0)
> +			return ERR_PTR(ret);
> +
>  		buf |=3D HW_CFG_CLK125_EN_;
>  		buf |=3D HW_CFG_REFCLK25_EN_;
>  		ret =3D lan78xx_write_reg(dev, HW_CFG, buf);
> +		if (ret < 0)
> +			return ERR_PTR(ret);
>  	} else {
>  		if (!phydev->drv) {
>  			netdev_err(dev->net, "no PHY driver found\n");
> --=20
> 2.39.5
>=20
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gxukq2mcwm43hawu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfZP2gACgkQDHRl3/mQ
kZwvKwf+MEPLjAHblaP3leTqe2XdoA6+NbuGVEDc6sJ3G1sHtzQxNS5flMKBZWya
GHCk09YMmS5zX/6HSurJ61peWXiazuT6gfZYSo54VkO8PU2s3WRAzY+BYuQB/6yr
SslI4ODRORclVQWfgwLR/mX4rVIIDu+tXJvzKc7vCScGHUrQe+rlaAoW/t+xVrGE
fnr4MXUmvFi+eGQ0edWZAHE3fffDJxh1P+DyDcCe66g7QMnoOQDOdkPhb+S2fSLP
cfZuNrwoSHAfQ0ELXFqpug2qDgYh5kWhOSxUloiZvZfHwLHfuMwf86ikgrNc8WuU
4dlH2gA6JqmWHJ7MKHx5JKv2kueCRw==
=iR3z
-----END PGP SIGNATURE-----

--gxukq2mcwm43hawu--

