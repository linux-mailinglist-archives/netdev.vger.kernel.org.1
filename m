Return-Path: <netdev+bounces-124114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841039681AA
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 10:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FE61F21181
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 08:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9D1183092;
	Mon,  2 Sep 2024 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsdyNM5J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5F4152E12
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265521; cv=none; b=gn+l7KBIBzF0vlp9f6kRQ2OMfTuEg1xRYTdlwP6FVsdfMZpl4L4N7QTVTTV77JoNwJyHviwGI8UfUMoKa9dweMyCEDW7md8GCoEKHYp4+Qgq+I63GcA/aNtbDSmg1TCUIouuEyRujn86z01oSadNc4DuziQ8ZCHNXfpIUbHnE1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265521; c=relaxed/simple;
	bh=GMjaSWl+FIetIgj8v1Nl3YDPMkanUQYCHhkaVZhnNUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJm+RxjBFRIrtBVQBTLYDAzNJoxHS5UnuoHDHVTon+cQyWgHaP+IaUAm8yPpDHRVmPjxEd2HlNc904V1ZBDk9dCho55i1rGkZDsx3xrRVMV+RijnFUtaS83YkbonkORMaVi/0jzXsugpg253T+QVa68tEdOFXktReqhRZEZPZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsdyNM5J; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bf009cf4c0so3896452a12.1
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 01:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725265518; x=1725870318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vW4iwA6cRFj2TnExDkg48J3ARYUiqIBaclOEBkxzw24=;
        b=dsdyNM5Jf4d+3YIOZWlQg7HZXIvnzLuRh1+Np7T1AskoYn5FKYKUhVHoqcW0ZYI90N
         o1gkK3KbfE8I6Nh69RyWOMK+3+f0HjjQASSoObuWwN2zGgc1bfjq9tglpcTMWwzVAbew
         aG3Eu5rS5P6xYTuWmeiIn7KlFlx8fojk9uYrZc9rH+kRSuiGwTGX/Dtb0AnJrd9q/Xa7
         SVeSNe8LlxFgsa2RKQ2q8H4OgmS2Gmoh9AvMkEu+YpP8XGnIts2R2YDev4P7LUwgdpm/
         BbpsGqPlByRRlR3aXBD1BGEBgz6GI94vQ+tBLzTv+iAb5Mqay+U0fuyAjZEdTqv7HduL
         b6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265518; x=1725870318;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vW4iwA6cRFj2TnExDkg48J3ARYUiqIBaclOEBkxzw24=;
        b=ND1o8uVoOWSye6u2MXxnABRQ/EnY5wXhvWKOjA5LZTLInGLDVWFiWJN0wYvSebejg2
         La3aakoQAspQB4E560oqXK6qtfV3VTTtOjWNhK6Hv3xT+5i1Q2uhWsqnoD+5t/+emv+A
         b7KIESUoYKZHaNvdjw7VR/nNzt9JKzzW+R86eIiETal10qGFJdjw4KVagIh5Fzl9mbr0
         zj+8LknPZ/9NsxcXxFdE5LzzxqWu9a/iZuV4VXyqdlmdFhnvKAedOLfHSpQJdkCOT2MH
         kVksdrJilOZZSGfcINefhwSBTFQg6SYUzLVrPG7IS4ebqrr/WHbfv4e00hf5wkNIazGg
         CjyA==
X-Forwarded-Encrypted: i=1; AJvYcCXsCdfuNg3HDvTmzC+Qhh5tZCe/uQNZG5Gp7hU87JmOqJoY4K7XUYdc81LmUOqv7neUyLktYsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0bJ+HROKJFyCt08Apv0fgC786lmt5MJmb+bYmidirmTB5ul+w
	cHGNSn2TpQo5rMLmB78Zt2b9Rda8ACJtgjOIIVrAUZuUPUJlppLM
X-Google-Smtp-Source: AGHT+IGYPPs+kIykQIoURPvbKCK3anGYPT7WJpMpWIIdbu/Q6oS97hqd2SBeNSUcg7AJ+dOiWmgtew==
X-Received: by 2002:a17:907:86a7:b0:a86:843e:b3dc with SMTP id a640c23a62f3a-a897fad6fcdmr773510366b.62.1725265517658;
        Mon, 02 Sep 2024 01:25:17 -0700 (PDT)
Received: from localhost ([149.199.80.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feae4dsm529490066b.31.2024.09.02.01.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 01:25:17 -0700 (PDT)
Date: Mon, 2 Sep 2024 09:25:20 +0100
From: Martin Habets <habetsm.xilinx@gmail.com>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sunil Goutham <sgoutham@marvell.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Dimitris Michailidis <dmichail@fungible.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net: Remove setting of RX software
 timestamp from drivers
Message-ID: <20240902082520.GA72183@gmail.com>
Mail-Followup-To: Gal Pressman <gal@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sunil Goutham <sgoutham@marvell.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Dimitris Michailidis <dmichail@fungible.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20240829144253.122215-1-gal@nvidia.com>
 <20240829144253.122215-3-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829144253.122215-3-gal@nvidia.com>

On Thu, Aug 29, 2024 at 05:42:53PM +0300, Gal Pressman wrote:
> The responsibility for reporting of RX software timestamp has moved to
> the core layer (see __ethtool_get_ts_info()), remove usage from the
> device drivers.
> 
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

For drivers/net/ethernet/sfc and drivers/net/ethernet/sfc/siena:

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

