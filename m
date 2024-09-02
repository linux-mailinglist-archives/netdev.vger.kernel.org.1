Return-Path: <netdev+bounces-124298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2065E968D9B
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98CC1F24462
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE6C3B1AC;
	Mon,  2 Sep 2024 18:38:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9EA1A2640
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302325; cv=none; b=lEcynpu+ElBnyitekgaBZtDg/kDCnW8GGvsCB4HcpO8HUKEiQkYlOUs2tfPYd44S/+jYj4PzOUH/6eysSBonw6IMz/+kogoZqnEtebhQOeNjADZM83L3NPeU6mnyx6JxTdYn7lVx8GFY7uGMWAAk10M7AW+SeqivtrbBuclJu4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302325; c=relaxed/simple;
	bh=0Varc3tnvt61SgaGNc7xX/kWQaN+irCNpP8fQCjs2qA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AC0vkZPmzeexFhmQFGB8UmFi/8tBYwZKoD8DG2Fzfrj7f3usiYpGyGQDpK7oTtSl2KaNJhMRPyaSSB3IeLmQfEhD1vy9NT8FQoD0Coii8jo3yFhuVEVwzrSQeYOmW0e2ypJfYdV9ZgNzjB+ZY/8D5X6t2VFOSbXlFgSuBXyIRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.79.71) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 2 Sep
 2024 21:38:23 +0300
Subject: Re: [PATCH net-next v2 07/15] ravb: Remove setting of RX software
 timestamp
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek
	<andy@greyhouse.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
	<manishc@marvell.com>, Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Sunil Goutham
	<sgoutham@marvell.com>, Potnuri Bharat Teja <bharat@chelsio.com>, Christian
 Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Dimitris Michailidis <dmichail@fungible.com>, Yisen
 Zhuang <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, Jijie
 Shao <shaojijie@huawei.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marcin Wojtas
	<marcin.s.wojtas@gmail.com>, Russell King <linux@armlinux.org.uk>, Geetha
 sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>, Petr
 Machata <petrm@nvidia.com>, Bryan Whitehead <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>, Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>, =?UTF-8?Q?Niklas_S=c3=b6derlund?=
	<niklas.soderlund@ragnatech.se>, Edward Cree <ecree.xilinx@gmail.com>, Martin
 Habets <habetsm.xilinx@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Siddharth Vadapalli
	<s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, MD Danish Anwar
	<danishanwar@ti.com>, Linus Walleij <linusw@kernel.org>, Imre Kaloz
	<kaloz@openwrt.org>, Richard Cochran <richardcochran@gmail.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, Carolina Jubran
	<cjubran@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	=?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>
References: <20240901112803.212753-1-gal@nvidia.com>
 <20240901112803.212753-8-gal@nvidia.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <78154cd5-3551-9156-b4f9-9b6caf282233@omp.ru>
Date: Mon, 2 Sep 2024 21:38:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240901112803.212753-8-gal@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 09/02/2024 18:22:46
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 187481 [Sep 02 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 32 0.3.32
 766319f57b3d5e49f2c79a76e7d7087b621090df
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.79.71
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/02/2024 18:25:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/2/2024 4:15:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/1/24 2:27 PM, Gal Pressman wrote:

> The responsibility for reporting of RX software timestamp has moved to
> the core layer (see __ethtool_get_ts_info()), remove usage from the
> device drivers.
> 
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey

