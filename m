Return-Path: <netdev+bounces-123541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F06AE9654B1
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 03:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC7D283948
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 01:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C204436E;
	Fri, 30 Aug 2024 01:28:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FD5290F
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 01:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724981328; cv=none; b=AmHuJgUXrvEU9O3sN8G93rMFs6BT2gCDUL3u+Ci7jxHD9e8e5I5K9HPLoeAX7vHNvz0/EP0OU9L5rdYviw9CplMdH0rWLzoPkC+yoywxP5I2KAYFrxkjBUu/kScNxD2Sojzl9FNTyeOljHsVxhLHIglADhJYKD+dBo7gUrunAN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724981328; c=relaxed/simple;
	bh=JF9gsP5xm6mwQJ02yR64mDkZKpSnPJBuz4wWLoS3aKE=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VXIkyFfd16kckysrpcsXzRK3oPh+M1QQ2mpnZURZHSMvcEWAJin+kM/d6vzQTd/SHaY1nZxVL1VcGMHwAb9/fIG6ak+6VdGMcuPth/Mo92HwvQbzfbyuKhq3x+pgqltKVv1RfK8AkoffNQCCHPvpzBbFLko+cEVLiu2JVI4KSSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Ww0qS4SFTz1xw1c;
	Fri, 30 Aug 2024 09:26:44 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id EE88B1A0188;
	Fri, 30 Aug 2024 09:28:42 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 09:28:40 +0800
Message-ID: <49c3772e-9ebf-411d-b5f5-e2626cb1a80e@huawei.com>
Date: Fri, 30 Aug 2024 09:28:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>, Jay Vosburgh
	<jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Shyam
 Sundar S K <Shyam-sundar.S-k@amd.com>, Sudarsana Kalluru
	<skalluru@marvell.com>, Manish Chopra <manishc@marvell.com>, Michael Chan
	<michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Sunil Goutham <sgoutham@marvell.com>, Potnuri
 Bharat Teja <bharat@chelsio.com>, Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Dimitris Michailidis <dmichail@fungible.com>, Yisen Zhuang
	<yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Geetha sowjanya <gakula@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Bryan Whitehead
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>, Horatiu
 Vultur <horatiu.vultur@microchip.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Edward
 Cree <ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>, Linus Walleij <linusw@kernel.org>, Imre
 Kaloz <kaloz@openwrt.org>, Richard Cochran <richardcochran@gmail.com>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, Carolina Jubran
	<cjubran@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net: Remove setting of RX software timestamp
 from drivers
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
References: <20240829144253.122215-1-gal@nvidia.com>
 <20240829144253.122215-3-gal@nvidia.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240829144253.122215-3-gal@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/29 22:42, Gal Pressman wrote:
> The responsibility for reporting of RX software timestamp has moved to
> the core layer (see __ethtool_get_ts_info()), remove usage from the
> device drivers.
>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>   drivers/net/bonding/bond_main.c               |  3 ---
>   drivers/net/can/dev/dev.c                     |  3 ---
>   drivers/net/can/peak_canfd/peak_canfd.c       |  3 ---
>   drivers/net/can/usb/peak_usb/pcan_usb_core.c  |  3 ---
>   drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |  4 ----
>   .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   |  4 ----
>   .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  5 +----
>   drivers/net/ethernet/broadcom/tg3.c           |  6 +-----
>   drivers/net/ethernet/cadence/macb_main.c      |  5 ++---
>   .../ethernet/cavium/liquidio/lio_ethtool.c    | 16 +++++++--------
>   .../ethernet/cavium/thunder/nicvf_ethtool.c   |  2 --
>   .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    | 11 +++-------
>   .../net/ethernet/cisco/enic/enic_ethtool.c    |  4 +---
>   drivers/net/ethernet/engleder/tsnep_ethtool.c |  4 ----
>   .../ethernet/freescale/enetc/enetc_ethtool.c  | 10 ++--------
>   drivers/net/ethernet/freescale/fec_main.c     |  4 ----
>   .../net/ethernet/freescale/gianfar_ethtool.c  | 10 ++--------
>   .../ethernet/fungible/funeth/funeth_ethtool.c |  5 +----
>   .../hisilicon/hns3/hns3pf/hclge_ptp.c         |  4 ----

for drivers/net/ethernet/hisilicon/hns3/

Reviewed-by: Jijie Shao<shaojijie@huawei.com>



