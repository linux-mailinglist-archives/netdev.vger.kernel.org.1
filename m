Return-Path: <netdev+bounces-124642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FAE96A4EB
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE7E1F24A62
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D574C18C32A;
	Tue,  3 Sep 2024 16:57:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D78818BC19
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725382673; cv=none; b=rExfTqDLi7ylSbMii5/5rJjpA79FyzNzFpiDYdJginEwtE6MI5Oz3iB0umuCPyUcIpGbuN5XL1Mj869jqB1dmWKsUeN9XxBawaviKEvD3v4e9wy1phkkJhutjPE9+pWrnuK3hZ/LVjO4h51whResMj/zO5Jzwza4T3ZgYkgpE3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725382673; c=relaxed/simple;
	bh=Kp4Ltf2L/vJqCknBSuRSkxLSWkJH/qnHIhhNntGIG68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfmVDCFuYuF0LgZjkLLXCtFELyAjkLK/jufRArcbmUUDlQDeC0j3L7y9GE9Kv+rs7u5grwNkCRYKh7WhEllXo2n/ZOyMEQGawvOggOaYf65mtzxzKuJLJbVaPWmXAQpR//uC0AsVrDgAYv9PjcCKVpP1h7vs9cACc1GfPlANzBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slWqG-0002YO-GD; Tue, 03 Sep 2024 18:57:20 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slWqE-005F6V-CF; Tue, 03 Sep 2024 18:57:18 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EA7E03317CB;
	Tue, 03 Sep 2024 16:57:17 +0000 (UTC)
Date: Tue, 3 Sep 2024 18:57:17 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: =?utf-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>, 
	imx@lists.linux.dev, Eric Dumazet <edumazet@google.com>, 
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	Linux Team <linux-imx@nxp.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Wei Fang <wei.fang@nxp.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v3 0/3] net: fec: add PPS channel configuration
Message-ID: <20240903-keen-feathered-nyala-1f91cd-mkl@pengutronix.de>
References: <20240809094804.391441-1-francesco@dolcini.it>
 <311a8d91-8fa8-4f46-8950-74d5fcfa7d15@prolan.hu>
 <20240903160700.GB20205@francesco-nb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d3n7e7dyaggm5ums"
Content-Disposition: inline
In-Reply-To: <20240903160700.GB20205@francesco-nb>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--d3n7e7dyaggm5ums
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.09.2024 18:07:00, Francesco Dolcini wrote:
> On Tue, Sep 03, 2024 at 04:10:28PM +0200, Cs=C3=B3k=C3=A1s Bence wrote:
> > What's the status of this? Also, please Cc: me in further
> > conversations/revisions as well.
>=20
> I am going to send a v4 in the next few days to address the comments
> on the dt-bindings change and apart of that I hope is good to go.

Have you read Richard's feedback on this?

| https://lore.kernel.org/all/YvLJJkV2GRJWl7tA@hoboy.vegasvil.org

There seems to be a standard interface for what you're trying to do,
right?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--d3n7e7dyaggm5ums
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbXP+oACgkQKDiiPnot
vG/vKQf/a72N78iIWxzkOUlx3s8T+bzkiDPclPHM1guLq8EsSRbMyCMujcaqdMxL
hGNyiqnyNI5zFNhK7lVWJ+tShy/cLQgdCkAaEBIhBmQIT7M2N9zfG/4rHX8vX4MF
D3XZSZzQC+pHiZgnUbm5SESmjz5GmumZUmBDJkVfaqjLMROR2HiAQy5f/bbE5OLp
kU5cBBXQnhJf8+lWMEWikAhjfyt1p6Cgb7ZFsK41rGrjK+/cble0O1q7gBKsEicT
eR5HabwoUHnKWJ7z9EB0YoLVEq/yBN+56uPZFYPxr5k+0pfX0jopOMkPlNjdlN7g
KlNrBoCEeQ+CI35ecgDOQK9aqgK/Hg==
=3c+f
-----END PGP SIGNATURE-----

--d3n7e7dyaggm5ums--

