Return-Path: <netdev+bounces-124037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C6C967640
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 13:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B221C20430
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA4016A943;
	Sun,  1 Sep 2024 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mQMhxyn7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2086214A61B
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725190310; cv=fail; b=Gu5eMyiX0/SsPZnQ2F7jrbQQxxZ+23oTIFw8Ege2OeOrsn6RvfcfZdzkACgP6e5cEvihQ4O+hELk/jGBm/T2fOorV2NP572VOBVVMDsThyXoQbphZDfTsY/DETrgTIVQKrTkZeAxUX5g9vS4H/yF11RkVU3GoKzE7XghU8H7ZJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725190310; c=relaxed/simple;
	bh=hNQimT3FGwS/R8Bqif+FnJvmThUZOmsN/Enk7kgnk2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnwO0c4yA7RSRMtl+62Nl8yuvvq4z4xQ877KCC806JBNAy5/FYmoszF23Dc/y+DHcLm6SiIEXv/ZEpbQ/7IMlELa/vtbJghDNvEi692c0XgZaQoSozxt1wFAcx7QzINPqxyr7L/osrwAwP/Od6H9LvvRMfnBnztpcr+bYqjgjiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mQMhxyn7; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+q2nxMKw2jos5RYfaYQOa/U0QoyVkuVOJHuQoW25rFeHx/tDIH+SMEk6OqldRRrqbz9+Jf0IYyGPjXEZu2m42WofeSmUfOZswHtipdimQPAUNMv2/2q/1AvcAv0jedF8Unge9JrixRJs+Yqa3axtDS923p5xw5lDNiK9TClYIf1yJoWphtzHUPODtl+drrnvz4HYTnOzrhjzRps/9ybBcZQW5nhom/r+Ro3zRqorx86ayXvRUUUrYzGzsOWe1VRqTlXmNOES8mvp3prQXn3g0A7qtgjTMvCVi23ZGZo57/mj0M+NNq1rOI0BtRiL6lnkKgkDgxBKh8NjxP22mk4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpqDiT6elLMhpy3jofH89JaINp/FW4339jF2XNN9evQ=;
 b=PBdochJtJmLfZaMuyYhZe8FxSsnYrwr7etsVCAG1kG/AGpfxd4jjNfksLOgHqoTmWTeyA3QKgjAr5NzSGwUn/M3LM8BD54o141FwqPKcNs/MglbjDcbK2vMSdAovtdxaqPOiSi7yylaWiwf/rNkIJLCbm8YMQpfDw3X5a0WmjnVJg6fhmMU7rk9xVsl9ik0ToVbkMNHoxooJYoKwyOAH5o5AlhQEP6oItHIduc/OV6ELlU4AVbpnglad1cm3swx69Di1jVI2FPmtvSW4YxtFSyk62BS6lGLvC0ioK7YG/4uyR1T8N5j+5U9SrPe/D+vqtotSPJF+yfXGFQOgT6rrhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpqDiT6elLMhpy3jofH89JaINp/FW4339jF2XNN9evQ=;
 b=mQMhxyn7LHgh1jLRTE4DHgZQOZPWqzIbd4T6/4YP+P6srg6POCV2+6CK0kF0S0zUvsbtKl2eYMO2YPB1PGQWvd7muWhxeDktcPsuI6NmatrYBABTtzi4Pk+17e266LiMpLPZNVF0E0fNSatBRDfs2M4oLfbTG0jsJ5raTM6OnbNo2xCeoI8brTREVnnKYlMazWsVBzmpBxDmi0ZJJGJ4YyVwOIqiG/ViGmxcGp25RlTa2KCwqT5B3pq7/bU0ddG3Sb2b27I2E9lUKoUvxX1OxQO1Eiq82Td0eAHgOYz5CFY61yMHm7VdV9mv41BPX14LnHFHMkGiZxEnnNSOrwIMkA==
Received: from BYAPR07CA0038.namprd07.prod.outlook.com (2603:10b6:a03:60::15)
 by CY8PR12MB8265.namprd12.prod.outlook.com (2603:10b6:930:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 11:31:45 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::b0) by BYAPR07CA0038.outlook.office365.com
 (2603:10b6:a03:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Sun, 1 Sep 2024 11:31:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 11:31:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:31:35 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:31:34 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 1 Sep
 2024 04:31:21 -0700
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
Subject: [PATCH net-next v2 15/15] net: mvpp2: Remove setting of RX software timestamp
Date: Sun, 1 Sep 2024 14:28:03 +0300
Message-ID: <20240901112803.212753-16-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|CY8PR12MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: cfcd942a-e701-492f-6723-08dcca79a8ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IDRyYkdluEfAtwjGT4a43nNsCxUxtIdtR9VcQPFIZOl+Sth1TY27qk9Hb/JM?=
 =?us-ascii?Q?QXM5EJ8Gxd02EACv5v8vEePMD/mukz2tATqCDpejTOdFSVx/f4y3QH5PkOab?=
 =?us-ascii?Q?EO87qIMJSxLOCzqP7ay/eN/Tt4G6qgIO6MnjTdkp7SVZBtTOGNQzUCvBI4cB?=
 =?us-ascii?Q?FS9qR9pNw/jpoQpqzwJA7ET8HcdwSnqzGA3wL9GS30a5469YKjX8PreNjo/E?=
 =?us-ascii?Q?BuMf3UebeGT23DalrbZ+NlNj6W5vF0KVGRO9GxVZ516fjXbv2ZbX2tulQcoL?=
 =?us-ascii?Q?fpVc76HTV6X+SdhX5wjeLJlOGMnAlT2cBsl/dR8jXJEqVajaENnUxAAaaK35?=
 =?us-ascii?Q?/L+yavJgJuvD6ae0zekSpn2Ab3U5n2vxrTcFlHwpQCzPKifVwZChiFHWuTSe?=
 =?us-ascii?Q?slnrKYmrfBHS26Ib0mvLLBKScHY+FZDSDtU54T33QHp5tVwc6RNTZ1myMwao?=
 =?us-ascii?Q?VbO1gFIQD6+lNJNv9apMgkQ0e8jco9Rr5D3LWpOxtTxU9qvTUQXOr/R07GOM?=
 =?us-ascii?Q?HcoQWv2uQLcNkTMJ8vMuqncrn6HjkwZ4SLzZ9mmHUn40j4ezumm76E0DCX1g?=
 =?us-ascii?Q?Oe0XMV4rV+jRgy1acjvrx53Pt1TQUcPCDvuO7AgTb4EKwqXF0wtPQP0xQKUo?=
 =?us-ascii?Q?0tDFOY+4sPyB5F8rkf3naJ0gbKwokBm6lh1woG5sMuuyC7QTTLl4/qIa0dbO?=
 =?us-ascii?Q?lq+eCcn5V0aLbJe3FRg1OU4AnhOCP7d/oICVe3JCTy7g1OAiqAZopyupY6ru?=
 =?us-ascii?Q?lqGmSUjQi3g2/Y53dibJ/lWKm6Zm9NfwbGjAycHB2rwMziTm6fOtnVvjM8KS?=
 =?us-ascii?Q?/BPSPmSGbJlKiY0+uUSb2054hz/Wgi7mq+qR8a8KqxNl1B7qvPK+EGEAUBiK?=
 =?us-ascii?Q?v9FVRHgKxtcwPf8zP7+k09rqL2s+LEWky0whyrUGK1ZUy+Izisc6RRiJpL1K?=
 =?us-ascii?Q?lmed52TX93/LJgVnozNO0aOBTFvrBp0bD7kdPv5L2N2QRsDvuxMq2imUhQgK?=
 =?us-ascii?Q?x81lB2u6LzX+/HXeIga0J8nTHOPh+6M2NXZxiZhkI+irpAgT7SoV73OkVcJT?=
 =?us-ascii?Q?0cOaMPEQGjnD7eRhfhRI1qpfwF5BazbSEDYtJOqc3Com6dNeeVA8A1n0s8n1?=
 =?us-ascii?Q?9De3n9xExVw2G3S+dYx7uPxFg64YZ3ZS7jFChbvgpUKUzx3/RLdY6RTsxdaV?=
 =?us-ascii?Q?pvJ/KygKt4hITydUmwU4VKk/UVlYvjhArh9AtW+mvUrrWHv3w7s+8GzHclUZ?=
 =?us-ascii?Q?InEV9z0loDuvL8aR9HgJowMcibILlZFQ13sChgOxigDDGHopRZsEFWupTJZf?=
 =?us-ascii?Q?i6fa/qF2O6z03xzj6Cks2BDyARRU5HllJuLvO7BlStLSgbVMAtE/RG0SFlhF?=
 =?us-ascii?Q?g84G9bZMK0Q6Ksntypzvs36f7f7GRJJeHeRYN5TaNcRjn+lyb9ustH7qjHl9?=
 =?us-ascii?Q?GIuPRDiirvr7918hG6XSRI9xkQLM66zm?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 11:31:45.3101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcd942a-e701-492f-6723-08dcca79a8ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8265

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 0d62a33afa80..1f01c6febc6b 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5268,8 +5268,6 @@ static int mvpp2_ethtool_get_ts_info(struct net_device *dev,
 
 	info->phc_index = mvpp22_tai_ptp_clock_index(port->priv->tai);
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
-- 
2.40.1


