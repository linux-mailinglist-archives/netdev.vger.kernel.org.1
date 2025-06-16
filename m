Return-Path: <netdev+bounces-197993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D77ADAC8D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 11:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6BA87A2D33
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 09:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC6626E718;
	Mon, 16 Jun 2025 09:58:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D866274678
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067888; cv=none; b=BJBBjqyr0p2Z6HnGy+Ti49M2xAJStQQv4JINecUWHvH7RMFvD6mhVu/L5IbzZS29EDvaEtvsUcV0KbMMC1UEULQSv2/lHCzGPAIn2yVjwUAtu8H4Ka21HdWyjjYZFmDwHb8jsil2GgMiZasOvYVfBnicJbSGp/eBwmzGKttIiLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067888; c=relaxed/simple;
	bh=r3ZafE+v5VeSNX6Xt/GDq+TE85TaHGnoq3LgKAUW3Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC+bexwld0A8OyVJ/eHQsthOR8fmMJ4W5t+1VLoY905VGHuRrNd9hsCsG2ZRg3N/Rn/zZDiRDi61kGqUgCqR1WtW4IV1RnEZShq1YXJgaZhCHcbEnOwTR+P147cKmwMBRdC5K/lXVJx1Dc1K/58eYJ/zOkUgc+Is9lD492w8h+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uR6ag-0002GD-6S; Mon, 16 Jun 2025 11:57:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uR6ac-003mk1-1V;
	Mon, 16 Jun 2025 11:57:18 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D3E53428695;
	Mon, 16 Jun 2025 09:57:17 +0000 (UTC)
Date: Mon, 16 Jun 2025 11:57:16 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linus Walleij <linus.walleij@linaro.org>, "Chester A. Unal" <chester.a.unal@arinc9.com>, 
	Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-can@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 3/5] net: can: mcp251x: propagate the return value of
 mcp251x_spi_write()
Message-ID: <20250616-authentic-competent-bustard-e31498-mkl@pengutronix.de>
References: <20250616-gpiochip-set-rv-net-v2-0-cae0b182a552@linaro.org>
 <20250616-gpiochip-set-rv-net-v2-3-cae0b182a552@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e4kyy2hl3xavjzza"
Content-Disposition: inline
In-Reply-To: <20250616-gpiochip-set-rv-net-v2-3-cae0b182a552@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--e4kyy2hl3xavjzza
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/5] net: can: mcp251x: propagate the return value of
 mcp251x_spi_write()
MIME-Version: 1.0

On 16.06.2025 09:24:06, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> Add an integer return value to mcp251x_write_bits() and use it to
> propagate the one returned by mcp251x_spi_write(). Return that value on
> error in the request() GPIO callback.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

Feel free to mainline the 2 CAN patches via the net-next tree directly.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--e4kyy2hl3xavjzza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhP6nkACgkQDHRl3/mQ
kZxs6wgAhFu5HOzU+o2sA/iQUZtoFgGRCGlnrRtplsyqOkJuBOv+EbNYewvtRN3L
auIWb+i9/gNN7LtktKhKgqQ/w3ZP+dXNqktHOODiNT6EbzdIF4XpUzGEq1cG7Gaa
SCYw1XiSs1A4p88Vr0sa15bYmRam7OK16HTquSz0yPXeTGdc/mjdYnOD6Zu8bVM7
p8E0Z6zcjxDsagIp99SIUpJvyUat2LkMxi+3aKx4vCcDgm5WsEniGjFITJm0SmvJ
yUlCyfN5HEjiQVI1Pc4Ns8ngROMfciVzVoTPfghS957w1aNM8SGQB+5qeX+UctWf
iofixBKdnPKxxjesIAlu3SjuYLm/jg==
=UtNp
-----END PGP SIGNATURE-----

--e4kyy2hl3xavjzza--

