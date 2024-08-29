Return-Path: <netdev+bounces-123413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B449964BF5
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947FC1C22794
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FE51B3F14;
	Thu, 29 Aug 2024 16:50:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60251B4C3B
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950210; cv=none; b=no9AUqx6RLpNwViKy9ge+g4xkA2q3M2wjGPG8pZEaSMMxrmBuDE4DQUkEdFZNFkWFOFMZuzxVrpJ2kp1tnJLVDLmCcXpwGx3peus5TOVO+vkFgHQJcU6ISASFMz7+Daxz7XPo/R0xQU7n73nEJGLkEqShDQQkLpvU6Chkft9UT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950210; c=relaxed/simple;
	bh=AKr9IIeIbjZSGKlLmtkxYRMx8DPLmyjhaCOpkSuLMpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvBIoX8KLTcZsbp7t/0hh8d0dAgRVDPrWFzRReZSBcN4X+oIZ1ZlEFuV3I63YfQY7ZaolZAGNCKaKSKQoPWFqWJW6k18qMg+YC95fBUITo2Vkt0OPVxkaV6GeT1jKwIHrlXub1WQM26qWTUOg/YHa952dwT0HIKwCnfLdz/5yN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjiLM-0004bS-QG; Thu, 29 Aug 2024 18:49:56 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjiLL-003xEk-Rw; Thu, 29 Aug 2024 18:49:55 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 538B232D36E;
	Thu, 29 Aug 2024 16:49:55 +0000 (UTC)
Date: Thu, 29 Aug 2024 18:49:55 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, 
	Andy Gospodarek <andy@greyhouse.net>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Sudarsana Kalluru <skalluru@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Sunil Goutham <sgoutham@marvell.com>, 
	Potnuri Bharat Teja <bharat@chelsio.com>, Christian Benvenuti <benve@cisco.com>, 
	Satish Kharat <satishkh@cisco.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, Dimitris Michailidis <dmichail@fungible.com>, 
	Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jijie Shao <shaojijie@huawei.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Geetha sowjanya <gakula@marvell.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, 
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Bryan Whitehead <bryan.whitehead@microchip.com>, UNGLinuxDriver@microchip.com, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Shannon Nelson <shannon.nelson@amd.com>, 
	Brett Creeley <brett.creeley@amd.com>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Edward Cree <ecree.xilinx@gmail.com>, 
	Martin Habets <habetsm.xilinx@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	MD Danish Anwar <danishanwar@ti.com>, Linus Walleij <linusw@kernel.org>, 
	Imre Kaloz <kaloz@openwrt.org>, Richard Cochran <richardcochran@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next 1/2] ethtool: RX software timestamp for all
Message-ID: <20240829-quick-inchworm-of-poetry-3ebc4d-mkl@pengutronix.de>
References: <20240829144253.122215-1-gal@nvidia.com>
 <20240829144253.122215-2-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t5eyogjq3jsiix2j"
Content-Disposition: inline
In-Reply-To: <20240829144253.122215-2-gal@nvidia.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--t5eyogjq3jsiix2j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.08.2024 17:42:52, Gal Pressman wrote:
> All devices support SOF_TIMESTAMPING_RX_SOFTWARE by virtue of
> net_timestamp_check() being called in the device independent code.
>=20
> Move the responsibility of reporting SOF_TIMESTAMPING_RX_SOFTWARE and
> SOF_TIMESTAMPING_SOFTWARE, and setting PHC index to -1 to the core.
> Device drivers no longer need to use them.
>=20
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Link: https://lore.kernel.org/netdev/661550e348224_23a2b2294f7@willemb.c.=
googlers.com.notmuch/
> Co-developed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--t5eyogjq3jsiix2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbQprAACgkQKDiiPnot
vG/EQgf8D7XEdwjr+ypafyyl6OqZCBsIH2oCiioGIoX9OSTePxJwBROLdKkGtYj8
OPCDj1vvSVZ+KduSEzICWZZh0fALahoQnXpNZxFL8ccLWrp9nPnAkuGV2G+pQRu7
pS46VOy9TgNeB1220kdICRCSmcA/g9GJwj5CkHgZxAs4rKgehmFYkakNCkZeavOd
fQecGNT9MhRLdMX+YDVjr2tyDJuflaYlUz4tkJH7ehLkrjJU+r8+msj1DZXQJZxr
hoyDI4knPF5eoqq4tePVgp27UfxVoU0ntR1qSuFBp89XkPwlUrayiJ60e1pPG6sM
IDC5UudpM+ax+kuCiK7DOxdjVMinQw==
=9rFK
-----END PGP SIGNATURE-----

--t5eyogjq3jsiix2j--

