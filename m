Return-Path: <netdev+bounces-106836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7682C917D8E
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A879C1C2291E
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD2A176FB6;
	Wed, 26 Jun 2024 10:15:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B82F17B50F
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396948; cv=none; b=AKPtkx2kOZ413hTMRQgvWXeNf7ruHudCAQz00kluBFuXOn79qFEjnM8ocmFnaWnnD7CiI32vFYnv+SF9/hVY3YFCUv6Xiu1cR30Ba+o1Zhx0Bglxrpq4i2Jh5CaYnDF0jCpGbZql06n6rJUvAM4gtDn0Dgi21iDmNuTZBQlCFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396948; c=relaxed/simple;
	bh=7Vv/38yXXS6Mw/kIpaWszQSVXYeuVTY8r2rsU6ywIuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiJYj3SwBeLxnz+0Od+ZON/pz3mHyv05AcmeTofKkTFKTLuxqzWHezj2896VAx8NPPokQjfpFAAG1ySjYe9JmmCmuUAdHG0fYknb4CYn0S13cZN3TfFsQ5DrvKlNSUyqBihv0QYYaiQqomntk1vDt3qcJjjzueZ+XjL2Uf2IawM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sMPgQ-0006E2-4e; Wed, 26 Jun 2024 12:15:22 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sMPgO-0056aZ-Rj; Wed, 26 Jun 2024 12:15:20 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 62EB32F3FC2;
	Wed, 26 Jun 2024 10:15:20 +0000 (UTC)
Date: Wed, 26 Jun 2024 12:15:20 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Herve Codina <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, =?utf-8?Q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>, 
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, 
	Antoine Tenart <atenart@kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH net-next v13 00/13] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240626-expert-gharial-of-amplitude-79e83f-mkl@pengutronix.de>
References: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
 <20240626-worm-of-remarkable-leadership-24f339-mkl@pengutronix.de>
 <20240626120137.10c2ad61@fedora-5.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="45kzkz4ehdxunhp2"
Content-Disposition: inline
In-Reply-To: <20240626120137.10c2ad61@fedora-5.home>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--45kzkz4ehdxunhp2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.06.2024 12:01:37, Maxime Chevallier wrote:
> Thanks for giving this a test.

I was looking at this to figure out if it's possible to use/reuse/abuse
this for CAN transceiver switching. Although Oleksij coded a CAN
transceiver struct phy_device POC integration, we're using the "other"
PHY framework from drivers/phy, i.e. struct phy now.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--45kzkz4ehdxunhp2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ76jUACgkQKDiiPnot
vG+gRAf/WTo2sBmipgFQU528oVB0wkUX7yBWwy/ft0FsxHVVEdtQqq9q/EKwGOLY
E0M+Kq7EyF+TKTDZRdghlMftZ3HUvwz30RaHbm/fUr6miC1G9k1UsncoySO3eafn
7gdEqpG1xrdtgtNqizfmD4MIqs2FUnfQoVQ5Q6KSrs7aT50zMf24UG7zprZ7VMth
9QBnnsQVq9a8zqAU0pFnCnUPYbf2f2uYLKupYVmp9E2YA7zlvr8OuMy+7xaWalIR
RI0e9mjH7qpWPzDKrtCQ4h57Lo7J8NFRg6TeeHUiTxnpv7ygA8DUN1DvgJs88zpg
k3QESogcJa73i5OswBY3vdD9k+3cXA==
=lKXj
-----END PGP SIGNATURE-----

--45kzkz4ehdxunhp2--

