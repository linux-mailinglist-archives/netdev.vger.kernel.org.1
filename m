Return-Path: <netdev+bounces-197994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE5CADAC91
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 11:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A383B0D67
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 09:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB95274658;
	Mon, 16 Jun 2025 09:58:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD320274659
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067892; cv=none; b=qv7jMQcm3NYG/ieES3Hde6M+4gR7CWBTFurgigQebSUavyGMbSDvgT3h3vc9MIVxebL9HpFOeUrdO+HV+KY7OsPaJIhrzpmOYc7+h+yIQItuChrZPWKIJpsL+amV4MzZvSu3fR/v3K5s3SZtu4Z88nD3SKNzObpE/DY9Ry8Vyeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067892; c=relaxed/simple;
	bh=9HK13tBfv+jEnFNg79GNo9j4TrEZUStIBqXdIdGFZk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayzmXF0/xCB15Qeh8KuOq6znyjq7V2YcmIbc0mL5nt5H3y12Aq8GiCKv7AmHOmvY4QiIrnO/wWhvtOaeVOSl0W1jsmd59tTX16dQUIcgpIt/5MX6CMDNyTnRK/ayS7KYb7bDwsL39AR/37iHvxlTpifC1fgxOiYZmrQTocGD+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uR6b4-0002wJ-5K; Mon, 16 Jun 2025 11:57:46 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uR6b3-003mk9-2d;
	Mon, 16 Jun 2025 11:57:45 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7498F428696;
	Mon, 16 Jun 2025 09:57:45 +0000 (UTC)
Date: Mon, 16 Jun 2025 11:57:45 +0200
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
Subject: Re: [PATCH v2 4/5] net: can: mcp251x: use new GPIO line value setter
 callbacks
Message-ID: <20250616-quick-blazing-dogfish-1d73c3-mkl@pengutronix.de>
References: <20250616-gpiochip-set-rv-net-v2-0-cae0b182a552@linaro.org>
 <20250616-gpiochip-set-rv-net-v2-4-cae0b182a552@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cgo7ltpow6ehzxso"
Content-Disposition: inline
In-Reply-To: <20250616-gpiochip-set-rv-net-v2-4-cae0b182a552@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--cgo7ltpow6ehzxso
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/5] net: can: mcp251x: use new GPIO line value setter
 callbacks
MIME-Version: 1.0

On 16.06.2025 09:24:07, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cgo7ltpow6ehzxso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhP6pYACgkQDHRl3/mQ
kZwhTgf/Rdvldz+sfHV1GPN68aLAO5qzKJUWpvJ05B1WZ62FpeQ32yATbOX4Gdza
PXxXP4fcb4CI/tchuSLijWxILlaHeH3XmLKr6dbISHa+3fITiyTfrT8aIVrbXad7
B7Lk/k3xCSpFeIy59IYjx3x/JuVeAlOnId9AnKiv2eXJAJbxta5HNL9XcwpJ59kl
68PO//pu7LDxwyyuxtoMT2xkhBV72NEQPBnK/vzYuw0sVvTxpRi4LuJtW0Twth3G
qSspMeG2q8te19InHtEwF/hvgGE5wPwMf+pH9DBwVdFH0R5yuu4O4mzKTt2Cg6Qv
mNLmJthXx+uFjegch384egz7Aw7oyg==
=8T2d
-----END PGP SIGNATURE-----

--cgo7ltpow6ehzxso--

