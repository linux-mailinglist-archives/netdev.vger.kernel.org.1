Return-Path: <netdev+bounces-124033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E49B196763B
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 13:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7255A1F2121C
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF15815CD78;
	Sun,  1 Sep 2024 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TTLNDKXI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623181684A4
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725190260; cv=fail; b=FTGhgET5+YLe28YmE6P7NsEWcIn2qtkfyktZz43qmH5nTqPMdmHv0HV9NMuERl5BlNDq+6lw+oDq8n1IxELKKkhmZ5T2AxZs7Pdlrnv+vEIkPXAIIPn50UawDVrula8y85h3Vmvog207csx2pB/0lO6cK/lURxdC5+MhEyCRvFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725190260; c=relaxed/simple;
	bh=k8UFacMuLGain9eTs7TqVUtyo/AJDj7O3QoeG5G9bIg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrQUAV8ZXJ+Vlc0VIPWRlp4MXHt1zpyKjLTFkTbnika2eIk3ihOLUWrz7gDX4/Zh5G1hRTo0asBXGunVizb18fOXPwCbLmgzvIGHwiwmMLq+47Ig6mJqnmtRiRzmhvQ94xvIltiLx5nIScmHjNG2eby0DfZCzW9/0RByHPQmx+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TTLNDKXI; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEr4OUE3+TPedO69hC/eISRCr64rP+G1V4K5ygt9CDRNeOtHrCes2ZCmVtRJcjK4tqn6t8nvcQqSZNUpbtdrxbnwpL+1uqHiA0W+Fvlypj5OKft6VP/sp2WWxKNz9JN+ZeZOZNeUdirYELGSIJqdoDpte5QIYA/IqPbxg6DrJGgIdHc2U4vRDubaMY30rwLqjfn6XqvjUkk5oj7ohsd/a4+2cKO36axTfzCFZGfQCxiKN8ypzikHbzo9JoWv5oq/UxO4vIp27nl1+JCXXesNaYoHSmVW4BA5mq3QdB4Gwl/Gof0adKUplLcHeBKzoKaTLDXWaNUHB4caycHqLGFoJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/ir06wWyjEjxAQcap9lzpnYfSNiK3tLiHimyI+gJLA=;
 b=JHO+tAcZI15rnqOnAiYeM9K/DIwJCk2ahKkJfpgERZ0VDzup96PxVALPFfTONCWjIYWTCGVokFCpxW++3ItEYrRvx4o5E5fvgcAi6XSo5EUDeAFeb34aenRERG0Qk/PJYOjp2pmhN56tq1WEHDoVFHsUG/0ZHR3x0aIb8sdMJvok4nz5GiSGa8WsdhHxihTbegFFm4hv1qStwxZchGLbuoG8nk7OZmZI1jWuEkAQaX9Q/kCY1apswLhLqjtogWoFwsOilkOotd0XWPePukMuZnPVME2V2he7+SPoWQXQxtixI8D6R7Iu4DwfooHNnKSbbKbBOUCRSzZ/gfFW46SqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/ir06wWyjEjxAQcap9lzpnYfSNiK3tLiHimyI+gJLA=;
 b=TTLNDKXImIKy35PxCfSmfcV2jccxTQyRuZymiA8/8xxXCxJpF2tK24gQsqAmqUrqQ6l8tcLmmWPpsGkL9q3LA2vFFUNzMTUqS2P28qW/xpnQzQedPwKsfQbS9D93v1u+3hyYYLPo1JgUovZl8cU3/NrC1YZTSArX817F9T/QoVLlWoxIP6aHV873ETFgwjN0cFaKO8Gm5jELOHA2NaHQD+54KzOJUJgShKXhPTtuSjP1ec2LUMSulpeV5DE5QrHQW8al7jbxsL7aClmHoxAIyP8HLt8zDIyUKgYrYzFHzmt+TrdQ7sS3ESSpxLret4X4hZxkQS9OyZqzZVMZD9GuSg==
Received: from BN0PR02CA0053.namprd02.prod.outlook.com (2603:10b6:408:e5::28)
 by PH7PR12MB6635.namprd12.prod.outlook.com (2603:10b6:510:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Sun, 1 Sep
 2024 11:30:53 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::73) by BN0PR02CA0053.outlook.office365.com
 (2603:10b6:408:e5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Sun, 1 Sep 2024 11:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 11:30:51 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:30:36 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:30:35 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 1 Sep
 2024 04:30:20 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek
	<andy@greyhouse.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
	<manishc@marvell.com>, Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Sunil Goutham
	<sgoutham@marvell.com>, Potnuri Bharat Teja <bharat@chelsio.com>, "Christian
 Benvenuti" <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, "Claudiu
 Manoil" <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Dimitris Michailidis <dmichail@fungible.com>, "Yisen
 Zhuang" <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
	"Jijie Shao" <shaojijie@huawei.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "Geetha sowjanya" <gakula@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Ido Schimmel
	<idosch@nvidia.com>, "Petr Machata" <petrm@nvidia.com>, Bryan Whitehead
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>, Horatiu
 Vultur <horatiu.vultur@microchip.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, "Edward
 Cree" <ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>, Linus Walleij <linusw@kernel.org>,
	"Imre Kaloz" <kaloz@openwrt.org>, Richard Cochran <richardcochran@gmail.com>,
	"Willem de Bruijn" <willemdebruijn.kernel@gmail.com>, Gal Pressman
	<gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>
Subject: [PATCH net-next v2 11/15] net: fec: Remove setting of RX software timestamp
Date: Sun, 1 Sep 2024 14:27:59 +0300
Message-ID: <20240901112803.212753-12-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240901112803.212753-1-gal@nvidia.com>
References: <20240901112803.212753-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|PH7PR12MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a1ee71-311c-4db2-9cea-08dcca79892e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CKQzMqKOHznKXF0WGvMXegx5q2XTxL/KOJhg9OqZU2E5A/i4LQ6KA20b6Dlx?=
 =?us-ascii?Q?07Ppzf+FMke/Tlr05yBIvg+44g5LCVXlDKwxvgyy/dNCVp2CIFQ56b4JNjhP?=
 =?us-ascii?Q?tdRjwnI0fvN3t+OdUWvNLweUATb2qUsrOrOziiAfEl4BA3HdzzZ1OI3YtFdh?=
 =?us-ascii?Q?SpoE/G9IXEXGjZqJtoo9GtpOoHjSd7fopWkKuX2rBWS1eBwsYHK7SVHhFMVu?=
 =?us-ascii?Q?mld+K5MhmUCUGSetA6RBYYO+sBiVXNIv2la7GQBNSI4RZeAhErli4edfkuBL?=
 =?us-ascii?Q?G+l5JosMmBwlEyQ8IcXRaKMtgoIX4r1j+VF29RM5AjF2TIiRSNet0foytWqR?=
 =?us-ascii?Q?dNNIP5PNp6t/QRYlCqKaLPkQC3stV+sSCap1N0CnwNL2e7z7z25DYH7aKsiI?=
 =?us-ascii?Q?efIENAvwNRuobCsKTavdy6s2NYjCASSRyZJBx2LpPYLECvsJBey2uEKha0O1?=
 =?us-ascii?Q?y0yqOeMxpko84cEAiXzL0AJw5jlr4DQZk3UAsKvlRNmgXvsQIvxXC66vHmcE?=
 =?us-ascii?Q?zzVJIcrK7YG+mb7gxXzVkOgDGKe+uNrNpNZtzyoTq/TP4aKx2VHMRQbLTE1d?=
 =?us-ascii?Q?QMGtvIBonieeXGEjI02xkxXAX/ZRdtZYHuPKGhXQatUXftfK5TXfyIzu+rsS?=
 =?us-ascii?Q?ySFaxMtQZ9UbwsBEamVGWeRBagYbJayfNgHM1plOSDHPj6W+mrBpgjhR1RTZ?=
 =?us-ascii?Q?BdEpWD7ts8/v5I3VZS1eoi8fbaIEKvbzLlg3P3h8Fzk0aT42wLdOUsynH0Wi?=
 =?us-ascii?Q?8/WWHGHy7qJYkOB7l542zXc3+HNQJnrFAufZdVkcA1Vl9V4iAChJPe8RWjJv?=
 =?us-ascii?Q?yawZPIIvSDd68kz0dDilMJ5VVeuMyuxXlxYoXtua5PZwmgipqQXMi7gvdmvs?=
 =?us-ascii?Q?OjN1qc4K9KWZABhXtE2+243EZTEeDzwgMuodo17POgCNKiuZwioNp0vZOMyU?=
 =?us-ascii?Q?CXjsJBsMawMpakb4zQBNRD3Z2rHk9Et6ukeTSAqP8lJ8Xqmon2haCRXPluKB?=
 =?us-ascii?Q?LGiaRn3l8VsoC8YD1ctxioRY6hlr2bFjDYN2Cvyoh/jm2jM3YTjJ925iURDE?=
 =?us-ascii?Q?MZc8onJu96U66Sxvn8MW3DevjVZG+56xDe86ADtmcT7j2Y8e4nF0s8TA/h4a?=
 =?us-ascii?Q?JRO6tPHfIOTlILiXwSU4EgqReEaRULxHVlTA7Eu2urhdD5miqExr5VabZFMD?=
 =?us-ascii?Q?p5Xqc7WM6gs8iZvIUmXKAhggmXFXBgGpCSKNU5go9njb7EylAwbG0rGVPxEK?=
 =?us-ascii?Q?E0QfA6qFs7hKYOas+w+p8Cwi46wRGcqyrofAJgAXjZOEsllB/PmVNgFTs/+A?=
 =?us-ascii?Q?oAlTtaB9J6GQR+nC9B0oUyluWYgPse80xn26a2mr7EckkO3E7rJu4jGgnfws?=
 =?us-ascii?Q?5EeFyeEy1nfTBjC57fxQDQTuNux+yHuj3Ph5ycMPJqnQhgTfjyfh+79wAzO7?=
 =?us-ascii?Q?OwYpvFRFFkwpxI33GLUX+2BEvZhUMzvk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 11:30:51.9279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a1ee71-311c-4db2-9cea-08dcca79892e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6635

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 8c3bf0faba63..acbb627d51bf 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2775,15 +2775,11 @@ static int fec_enet_get_ts_info(struct net_device *ndev,
 	if (fep->bufdesc_ex) {
 
 		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-					SOF_TIMESTAMPING_RX_SOFTWARE |
-					SOF_TIMESTAMPING_SOFTWARE |
 					SOF_TIMESTAMPING_TX_HARDWARE |
 					SOF_TIMESTAMPING_RX_HARDWARE |
 					SOF_TIMESTAMPING_RAW_HARDWARE;
 		if (fep->ptp_clock)
 			info->phc_index = ptp_clock_index(fep->ptp_clock);
-		else
-			info->phc_index = -1;
 
 		info->tx_types = (1 << HWTSTAMP_TX_OFF) |
 				 (1 << HWTSTAMP_TX_ON);
-- 
2.40.1


