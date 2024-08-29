Return-Path: <netdev+bounces-123412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85559964BF4
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDB50B21D3B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F315D1B3F14;
	Thu, 29 Aug 2024 16:49:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C0A1B580C
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950192; cv=none; b=T5+r8Q8mN3wtH61DSAhmVfhKxOWGE3mO0q3OaQp4v0tuRLKMfsw41IzTo4mf4585GA06o1HWfwsYIUJyvYfzNNwsosaGv6ccXSjbpygEdJfrUuy8c77uLv6kPrFJfQLxxyk3WK5SgfGjS2O7kI0YSw9r9W46jIae4NM5wZMurjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950192; c=relaxed/simple;
	bh=V48Mny08t2IN2YedpR1R45G1Qx9CWl7XVsLdWQ2BoxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qh1mKD9VldcpLU1BZ1jAl+kBMfCq5IyUmwwg4NgsLpbl/XB4zcYYw+0MXMkXcxqzWq48gSeWH9CLgQ9g7fftHJOFiwiWwdpJqzsYfS2BWCUWDRaS4ixh0H+lH0ahql9gybbY5J+by04PGmDF1RCC5aNkURfwDa+apZ/YZZvVGTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjiL1-0004Cw-56; Thu, 29 Aug 2024 18:49:35 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjiKw-003xEc-8y; Thu, 29 Aug 2024 18:49:30 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 955DA32D36D;
	Thu, 29 Aug 2024 16:49:29 +0000 (UTC)
Date: Thu, 29 Aug 2024 18:49:29 +0200
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
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Carolina Jubran <cjubran@nvidia.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net: Remove setting of RX software
 timestamp from drivers
Message-ID: <20240829-outrageous-lovely-galago-da033a-mkl@pengutronix.de>
References: <20240829144253.122215-1-gal@nvidia.com>
 <20240829144253.122215-3-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ocbei7p7ppynkha6"
Content-Disposition: inline
In-Reply-To: <20240829144253.122215-3-gal@nvidia.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--ocbei7p7ppynkha6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.08.2024 17:42:53, Gal Pressman wrote:
> The responsibility for reporting of RX software timestamp has moved to
> the core layer (see __ethtool_get_ts_info()), remove usage from the
> device drivers.
>=20
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>  drivers/net/bonding/bond_main.c               |  3 ---
>  drivers/net/can/dev/dev.c                     |  3 ---
>  drivers/net/can/peak_canfd/peak_canfd.c       |  3 ---
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c  |  3 ---
>  drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |  4 ----
>  .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   |  4 ----
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  5 +----
>  drivers/net/ethernet/broadcom/tg3.c           |  6 +-----
>  drivers/net/ethernet/cadence/macb_main.c      |  5 ++---
>  .../ethernet/cavium/liquidio/lio_ethtool.c    | 16 +++++++--------
>  .../ethernet/cavium/thunder/nicvf_ethtool.c   |  2 --
>  .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    | 11 +++-------
>  .../net/ethernet/cisco/enic/enic_ethtool.c    |  4 +---
>  drivers/net/ethernet/engleder/tsnep_ethtool.c |  4 ----
>  .../ethernet/freescale/enetc/enetc_ethtool.c  | 10 ++--------
>  drivers/net/ethernet/freescale/fec_main.c     |  4 ----
>  .../net/ethernet/freescale/gianfar_ethtool.c  | 10 ++--------
>  .../ethernet/fungible/funeth/funeth_ethtool.c |  5 +----
>  .../hisilicon/hns3/hns3pf/hclge_ptp.c         |  4 ----
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |  4 ----
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  2 --
>  drivers/net/ethernet/intel/igb/igb_ethtool.c  |  8 +-------
>  drivers/net/ethernet/intel/igc/igc_ethtool.c  |  4 ----
>  .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  4 ----
>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  2 --
>  .../marvell/octeontx2/nic/otx2_ethtool.c      |  2 --
>  .../net/ethernet/mellanox/mlxsw/spectrum.c    |  6 ++++++
>  .../ethernet/mellanox/mlxsw/spectrum_ptp.h    | 20 -------------------
>  .../net/ethernet/microchip/lan743x_ethtool.c  |  4 ----
>  .../microchip/lan966x/lan966x_ethtool.c       | 11 ++++------
>  .../microchip/sparx5/sparx5_ethtool.c         | 11 ++++------
>  drivers/net/ethernet/mscc/ocelot_ptp.c        | 12 ++++-------
>  .../ethernet/pensando/ionic/ionic_ethtool.c   |  2 --
>  drivers/net/ethernet/qlogic/qede/qede_ptp.c   |  9 +--------
>  drivers/net/ethernet/renesas/ravb_main.c      |  4 ++--
>  drivers/net/ethernet/renesas/rswitch.c        |  2 --
>  drivers/net/ethernet/renesas/rtsn.c           |  2 --
>  drivers/net/ethernet/sfc/ethtool.c            |  5 -----
>  drivers/net/ethernet/sfc/siena/ethtool.c      |  5 -----
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  4 ++--
>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c   |  2 --
>  drivers/net/ethernet/ti/cpsw_ethtool.c        |  7 +------
>  drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  2 --
>  drivers/net/ethernet/ti/netcp_ethss.c         |  7 +------
>  drivers/net/ethernet/xscale/ixp4xx_eth.c      |  4 +---
>  drivers/ptp/ptp_ines.c                        |  4 ----
>  46 files changed, 47 insertions(+), 208 deletions(-)

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de> # for drivers/net/can

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ocbei7p7ppynkha6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbQppYACgkQKDiiPnot
vG9DqQf+I6S8Ta7ifEQE6FKkHd6W5KQ/WY0UwK6GU051CoDUF4Ji0joG8a/IzMPe
hYsFwCDpslBDkhqpNfTuELJ4pyQsyWp6tH2pmNiZXIgf8tdX1r+6tSQi1NzC9JSB
c0DvsJjXhNtU0g/zYOD5BgCq6rQWfrA9RggDEvpbgMkl042+U2HfvQD7upAzKDMT
XdYa0pixZBmMZ5i/pUJf6xdHXnIWuDSawVqiKGgbmSH3BIhUouGUq92lYu+hzDln
6YHWoFEDLhbuExXf2DYiLSmzB+14CtS+YQjbcz3nYmoGFD3yxvNt5G+c3eFj9RoN
Agdj1Q9tyk5kjy58bwcjJJmNpxbh+g==
=eqay
-----END PGP SIGNATURE-----

--ocbei7p7ppynkha6--

