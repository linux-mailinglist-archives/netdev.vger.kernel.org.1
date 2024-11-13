Return-Path: <netdev+bounces-144333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 813BF9C69BE
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 08:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113E81F23550
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 07:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF15187350;
	Wed, 13 Nov 2024 07:15:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A28175D38
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731482159; cv=none; b=C5bwK3WzPflzxNEEEAewlDpqiWeSvULLie848rzl7/FtQJcX/ekWgErsUO8cmKnnBwrbcDx23btzfJLvV71uycQuzwCdujydwFl/HuMj8YC7Ax/W1qdU9ELWRqSyxVF2MVvBJUUw0xVea0YRgm9EKKXU7YuTDc0HXCbcimnZ4tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731482159; c=relaxed/simple;
	bh=SBaq0tNsdJyjxFyTdktXxwIt5E9hSiPSZMXHIrQlJVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jusiEmMJeWcPkO9gyEEft3LrRJRHPHGXcvJ35bFM06oy0f68qjCE3eDEiAhLFbnXsQD0190GQctR+nNs4LaeB3myqhkDFcYTij2Zm+SH3NY89T6YtuKjOrK6CSQ5ubzpt4TiCh1B3xPRxH36odOkiKOMFJUCOgIh46glt/AqFI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tB7aT-0007QT-1e; Wed, 13 Nov 2024 08:14:49 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tB7aN-000XUv-0p;
	Wed, 13 Nov 2024 08:14:43 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C3AE03721A3;
	Wed, 13 Nov 2024 07:14:42 +0000 (UTC)
Date: Wed, 13 Nov 2024 08:14:41 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Pantelis Antoniou <pantelis.antoniou@gmail.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
	Byungho An <bh74.an@samsung.com>, Kevin Brace <kevinbrace@bracecomputerlab.com>, 
	Francois Romieu <romieu@fr.zoreil.com>, Michal Simek <michal.simek@amd.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Zhao Qiang <qiang.zhao@nxp.com>, "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, 
	"open list:FREESCALE SOC FS_ENET DRIVER" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCHv3 net-next] net: modernize IRQ resource acquisition
Message-ID: <20241113-nonchalant-spaniel-of-contentment-83978a-mkl@pengutronix.de>
References: <20241112211442.7205-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yqpx5eyx2zhvpvlt"
Content-Disposition: inline
In-Reply-To: <20241112211442.7205-1-rosenp@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--yqpx5eyx2zhvpvlt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCHv3 net-next] net: modernize IRQ resource acquisition
MIME-Version: 1.0

On 12.11.2024 13:14:42, Rosen Penev wrote:
> In probe, np =3D=3D pdev->dev.of_node. It's easier to pass pdev directly.
>=20
> Replace irq_of_parse_and_map() by platform_get_irq() to do so. Requires
> removing the error message as well as fixing the return type.
>=20
> Replace of_address_to_resource() with platform_get_resource() for the
> same reason.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> (for CAN)
> Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

Please write this as:

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de> # for CAN

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--yqpx5eyx2zhvpvlt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc0Ud0ACgkQKDiiPnot
vG9ixwf+MRErFbP8EBNYW4KiknVHSCJqliQuxtMgRc5LE54Iz/W8AKqAbKIjgzTv
XVCnuSSPn5hWw85VK1YrC2romqZQMmkjFDeaDAf27emw1tYQC5DkAg7DfdasiaFw
ZUNWdDjmY3lm3YwXCupckUARjWB9VEXNsLca8eti0+gmBWR16gwNbd7lBeXHm+Qf
mDzxiz9SQG5P/1V6GYCnHUgqw4yC6yxgNim60jfDfbD7t52x/C1EQylcG0Wzx3Uz
H1irShtJQNqXv0j63qMX0K3NQOkUKy0/yfNUS5gqHefjAT5YnEqUHKReldiPq0JB
IvRUsw91n6EDC2kPZwOR1gOkgMzKZA==
=7118
-----END PGP SIGNATURE-----

--yqpx5eyx2zhvpvlt--

