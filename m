Return-Path: <netdev+bounces-123592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA04896573F
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 08:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C7B2869AD
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 06:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139B9136E3F;
	Fri, 30 Aug 2024 06:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LFK3FZFY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F52014F9C7
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 06:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724997697; cv=none; b=G4U5XVvnP1x44knfpsD+j8P+6L3dQC5WviVxN1YxbacdTxeaCEYIbrBgfej4LUFnBNn4+KfwHf2yqOQZaCfd435NeOGKCZSu9glOV2Qn6CyuUh7SWzk0pB6yQSk+6nUC0hs3QkhhlqTpPp4PI262YGHpgRq6GyG7M5JAcMk/fr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724997697; c=relaxed/simple;
	bh=BpQ2H6xunbxWBzaZitOZ/jyxktxvtM3fzotgLnGFOy0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZ6yJKrJawGD8jCuQ8OM658S78FQqnNVRsrFRZhq2n0ZK6yBoHpdUWXk5RlEiwj3iIm2wmwY8q+vMSg9JQNnSUaqEqZqPYFd5e4XN2McLFulSWkdL0SdoNzX1K407Tr5t8b4B5QopRX2HZguAXDGr/fiXtvaIp+NdJagUqkfIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LFK3FZFY; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U5FaZX030410;
	Thu, 29 Aug 2024 23:01:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=b68NH+AyL/ppVi+dSLAub4/Ns
	4kz7gjNc/Se3wFmmYo=; b=LFK3FZFYUZPCXNm+QvnpgeTchtPXy0XK8zaaYijYz
	geXRgyMgU8o27qxLQGMIytQFsFefo5qiMFOPgrAxe9Aw0YgnxtRMlPngwaPqoYr1
	xn8v1NNtXQ7sQc9UguhdixStTU5bW8l3GtcRqr7xqQGtG4fN2nJEwwWgZsgAxot3
	tWULm8zlmD4AjDJMGwUreRP/L82TrMZeZT2+wY3zEZ9HsRZxUtNcYeQ3RQ4eV1/u
	+Iy18f3oo6MU7D+dY7x7H7mZJMmgGuGzUYNsjGpUiKMrgIbTuEZcoSohmZewNSm3
	Jt8IR2IMqB7Qw3GFKhz7XtRiKCKGlbQr4lXsmwQ3K+BuQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41b1b3sewa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 23:01:05 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 29 Aug 2024 23:01:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 23:01:04 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 3CD213F7085;
	Thu, 29 Aug 2024 23:00:46 -0700 (PDT)
Date: Fri, 30 Aug 2024 11:30:46 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Gal Pressman <gal@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        <netdev@vger.kernel.org>, Jay Vosburgh <jv@jvosburgh.net>,
        Andy Gospodarek
	<andy@greyhouse.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra
	<manishc@marvell.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Pavan Chebbi
	<pavan.chebbi@broadcom.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Christian
 Benvenuti <benve@cisco.com>,
        Satish Kharat <satishkh@cisco.com>,
        Claudiu
 Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang
	<xiaoning.wang@nxp.com>,
        Dimitris Michailidis <dmichail@fungible.com>,
        Yisen
 Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jijie
 Shao <shaojijie@huawei.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Marcin Wojtas
	<marcin.s.wojtas@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Geetha
 sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>,
        Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
        Bryan Whitehead
	<bryan.whitehead@microchip.com>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu
 Vultur <horatiu.vultur@microchip.com>,
        Lars Povlsen
	<lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Brett Creeley <brett.creeley@amd.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Niklas
 =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
        Edward Cree
	<ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar
	<danishanwar@ti.com>,
        Linus Walleij <linusw@kernel.org>, Imre Kaloz
	<kaloz@openwrt.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>,
        Carolina Jubran
	<cjubran@nvidia.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net: Remove setting of RX software
 timestamp from drivers
Message-ID: <ZtFgDohEl82O9u3K@test-OptiPlex-Tower-Plus-7010>
References: <20240829144253.122215-1-gal@nvidia.com>
 <20240829144253.122215-3-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240829144253.122215-3-gal@nvidia.com>
X-Proofpoint-GUID: FVHN10tJUMOQb4M4Fgt7EAeZNsr_VJPD
X-Proofpoint-ORIG-GUID: FVHN10tJUMOQb4M4Fgt7EAeZNsr_VJPD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01

On 2024-08-29 at 20:12:53, Gal Pressman (gal@nvidia.com) wrote:
> The responsibility for reporting of RX software timestamp has moved to
> the core layer (see __ethtool_get_ts_info()), remove usage from the
> device drivers.
> 
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---

for drivers/net/ethernet/marvell/octeontx2/

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

