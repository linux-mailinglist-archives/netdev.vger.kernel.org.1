Return-Path: <netdev+bounces-126374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A458B970EB8
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63259282A7A
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEDF171658;
	Mon,  9 Sep 2024 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PsNOA7fw"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABCC2AD00
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 07:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865259; cv=none; b=DQ9MWe3YypZ7AAKGJZlQuEJSf+At9VnNVRs60YI8vf3aJe4gPhd3Q3jRnxR069s0OIzXBTrQRHTcGWPo4hpQRPMX22YNRotP5cULia79itXdEM6xKxytQloDvVAzzStlekF7yvY6pbAsJrVVvkU/NbNsqUCZVZN8LeLVtWXmBBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865259; c=relaxed/simple;
	bh=+cy4o+n8mY5SDlzIrkgP2bQeW/huoG8GAbmo8l6HPkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dB+a4N0Pl5KoPDjCHstbQaHKTFQeyURaqFswAte8EZChUWoFWS0mt0P4ibKXSx/zisJbdPQn6YTR/W3bKFo5r2zud+ZbkETwkouqMD/PElFTZez86HM2grTv4xu5+MOoVK5dzYgRG3AqLu7dL9Cz3cXuegZJvn4Y5exI+qYmo5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PsNOA7fw; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725865257; x=1757401257;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+cy4o+n8mY5SDlzIrkgP2bQeW/huoG8GAbmo8l6HPkg=;
  b=PsNOA7fwZa9nb/86QXV42MsUYWtv05bDiNtAgF8Ss6BB57shwozqrPJV
   ZTOHF/TgIQGp7pT+36Ga2rVSb9yk4NKpSmNPEPLzPrOTOrhEHNZaFzth4
   1DvbpTQtZk7wGo4eBy26fw6AipRHwtwAVDl8L4+gsGYVGjAhszBWPDmWg
   0pxH1DRBQgMJAIXTVawGSlUFvXg2wbMUqux//YRFVL1yaA1ZarAYPMEHC
   4T5X7pDTUKUMqj+8mP6T95Tcv8eu2M7/jx2DZli4VPWboy4spS34i5Ojq
   xmgzAOhU3Wn446wDgAbAGE50QRF6AG/MQXatfdo9csVDPY0SVRrYwX+Gl
   Q==;
X-CSE-ConnectionGUID: wOzT8WlIQpikLS4OGOWp9Q==
X-CSE-MsgGUID: 2dQzHHbiQ8CAPdCGNKXhww==
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="262466743"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 00:00:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 00:00:14 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 9 Sep 2024 00:00:05 -0700
Message-ID: <43c561ff-f7a0-4313-aaac-62a2c3992eb6@microchip.com>
Date: Mon, 9 Sep 2024 09:00:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/16] net: macb: Remove setting of RX software
 timestamp
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek
	<andy@greyhouse.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
	<manishc@marvell.com>, Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"Sunil Goutham" <sgoutham@marvell.com>, Potnuri Bharat Teja
	<bharat@chelsio.com>, Christian Benvenuti <benve@cisco.com>, Satish Kharat
	<satishkh@cisco.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "Dimitris
 Michailidis" <dmichail@fungible.com>, Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
	"Tony Nguyen" <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
	"Ido Schimmel" <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Bryan
 Whitehead" <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, "Edward
 Cree" <ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>, Linus Walleij <linusw@kernel.org>,
	"Imre Kaloz" <kaloz@openwrt.org>, Richard Cochran <richardcochran@gmail.com>,
	"Willem de Bruijn" <willemdebruijn.kernel@gmail.com>, Carolina Jubran
	<cjubran@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20240906144632.404651-1-gal@nvidia.com>
 <20240906144632.404651-6-gal@nvidia.com>
Content-Language: en-US, fr-FR
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240906144632.404651-6-gal@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 06/09/2024 at 16:46, Gal Pressman wrote:
> The responsibility for reporting of RX software timestamp has moved to
> the core layer (see __ethtool_get_ts_info()), remove usage from the
> device drivers.
> 
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Looks good to me:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards,
   Nicolas

> ---
>   drivers/net/ethernet/cadence/macb_main.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 95e8742dce1d..e41929c61a04 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3410,8 +3410,6 @@ static int gem_get_ts_info(struct net_device *dev,
> 
>          info->so_timestamping =
>                  SOF_TIMESTAMPING_TX_SOFTWARE |
> -               SOF_TIMESTAMPING_RX_SOFTWARE |
> -               SOF_TIMESTAMPING_SOFTWARE |
>                  SOF_TIMESTAMPING_TX_HARDWARE |
>                  SOF_TIMESTAMPING_RX_HARDWARE |
>                  SOF_TIMESTAMPING_RAW_HARDWARE;
> @@ -3423,7 +3421,8 @@ static int gem_get_ts_info(struct net_device *dev,
>                  (1 << HWTSTAMP_FILTER_NONE) |
>                  (1 << HWTSTAMP_FILTER_ALL);
> 
> -       info->phc_index = bp->ptp_clock ? ptp_clock_index(bp->ptp_clock) : -1;
> +       if (bp->ptp_clock)
> +               info->phc_index = ptp_clock_index(bp->ptp_clock);
> 
>          return 0;
>   }
> --
> 2.40.1
> 


