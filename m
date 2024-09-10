Return-Path: <netdev+bounces-126761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F54972650
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 02:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA37B1C232BC
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B37E1D540;
	Tue, 10 Sep 2024 00:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/DFz2C+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1478F23AB
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 00:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725929288; cv=none; b=dxmQEevs6vpOv7iH13e50+qTVHsrAmEzEU8pkCWQVtdoEBKM/WeBU3oBtHNLQJkBXqjJqX2XUNiMXE/cz2enL5+VqiYMDiOITZVVG+QrHL/hqf0ApsyZUa7INrMXOUsY++zaFtCSu57sClCNL8L5yAQue0ASAFjVsA52R7W346k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725929288; c=relaxed/simple;
	bh=6PMciq1ZJQO/MeDLVjFPPrZCSz7dJ2iza8b9TCt0xJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gF8fMFcQez7CgI7Rw7SiCoi/lszSRV3Vb8gmJrruXRqm34D9bnbMUdJ4FD+v0/dw8XRrPfPgibfmzZUeu5sMoWnCOPbnLh6j8YXRgehg8817INze3mjrsntr9HS1JsR0o5liqcKFAre6vUTTaPsBLY3zDMfvNu4dTgK3DX9t7Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/DFz2C+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D04C4CEC5;
	Tue, 10 Sep 2024 00:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725929287;
	bh=6PMciq1ZJQO/MeDLVjFPPrZCSz7dJ2iza8b9TCt0xJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r/DFz2C+wfdHz0WAuf1ocM3CEEonXIFw4FxIb7/seT1tKgkhy59/qLCrKigdPveN1
	 q4iNxS0vS/1X/GY8WnPFnNYE7yR1ElnTpTd567NUrIyM0FXZxJYB+EhZNgeSjtqNQY
	 cQ6n/CG5x1q9ja0VAlnzhoMuiG3hucD5ea+O7c4lRPlTYh0Z/o5BzNu0eRaFJoyqCg
	 9gdL8sSkx3/deL9y0Kik82zxMWFsfVZQpwtKeMEg/bW/2bRBD4YSRCTkVVWBCcz/2K
	 F2iaLpH6aK8BgczqMdta9Pb15rBVY5OjBEF298keq5yaAv2PsBqWr7BRigdGbIDjYz
	 R14/JGkooiWHg==
Date: Mon, 9 Sep 2024 17:48:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>, Jay
 Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Michael Chan <michael.chan@broadcom.com>, Pavan
 Chebbi <pavan.chebbi@broadcom.com>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Sunil Goutham <sgoutham@marvell.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, "Christian Benvenuti" <benve@cisco.com>, Satish
 Kharat <satishkh@cisco.com>, "Claudiu Manoil" <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Dimitris Michailidis <dmichail@fungible.com>, "Yisen Zhuang"
 <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, "Jijie
 Shao" <shaojijie@huawei.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marcin Wojtas
 <marcin.s.wojtas@gmail.com>, Russell King <linux@armlinux.org.uk>, "Geetha
 sowjanya" <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 hariprasad <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Bryan Whitehead
 <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>, Horatiu
 Vultur <horatiu.vultur@microchip.com>, Lars Povlsen
 <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Shannon Nelson <shannon.nelson@amd.com>,
 Brett Creeley <brett.creeley@amd.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Niklas
 =?UTF-8?B?U8O2ZGVybHVuZA==?= <niklas.soderlund@ragnatech.se>, "Edward Cree"
 <ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros
 <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>, Linus Walleij
 <linusw@kernel.org>, "Imre Kaloz" <kaloz@openwrt.org>, Richard Cochran
 <richardcochran@gmail.com>, "Willem de Bruijn"
 <willemdebruijn.kernel@gmail.com>, Carolina Jubran <cjubran@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next 14/16] net: stmmac: Remove setting of RX
 software timestamp
Message-ID: <20240909174804.6be54abd@kernel.org>
In-Reply-To: <20240906144632.404651-15-gal@nvidia.com>
References: <20240906144632.404651-1-gal@nvidia.com>
	<20240906144632.404651-15-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Sep 2024 17:46:30 +0300 Gal Pressman wrote:
> The responsibility for reporting of RX software timestamp has moved to
> the core layer (see __ethtool_get_ts_info()), remove usage from the
> device drivers.
> 
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 7008219fd88d..a7b8407e898c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -1207,13 +1207,13 @@ static int stmmac_get_ts_info(struct net_device *dev,
>  
>  		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
>  					SOF_TIMESTAMPING_TX_HARDWARE |
> -					SOF_TIMESTAMPING_RX_SOFTWARE |
>  					SOF_TIMESTAMPING_RX_HARDWARE |
> -					SOF_TIMESTAMPING_SOFTWARE |
>  					SOF_TIMESTAMPING_RAW_HARDWARE;
>  
>  		if (priv->ptp_clock)
>  			info->phc_index = ptp_clock_index(priv->ptp_clock);
> +		else
> +			info->phc_index = 0;

Would have been good to explain the unusual change to phc_index
in the commit message.

