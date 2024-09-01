Return-Path: <netdev+bounces-124034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FD596763D
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 13:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A10E1F219FD
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C484815C13A;
	Sun,  1 Sep 2024 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cVH16YV3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AB5170855
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725190271; cv=fail; b=LGxlz93hEIefJwz6wa5cYJxK3hZCaRRXarx28pOqbcid8rAVCrZpqMy7sjXvCMLiHeyTWT2QPGtEG2W5Os/oi5vzapr/KC9Y89JFGM+qngfM5a5MlAPp/Jc+JV8z3Qxy1SFa0H3DMZuODkKBdElCT+oNkix8vrdDnIJcICsKDB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725190271; c=relaxed/simple;
	bh=J4Hm5UeOI6yOP8tn3vxqX8hrLJOPRRQmPRZV+pAFLmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcZ2mKlKaQMAsQ7V8f1vW4qH/rjDW4+lXB1MQWBYtovHp4qg/div9nNc7go8ozs9gmYM38Iwy3Lcecm7fuB2hoSsFOQ520lH47cbmIR6uGwkZB1/wcIbeJGy+or7Knvs/NnJBEcyRZRZeFlYJNlHkr7YlepC7IPfW36jQmiBLAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cVH16YV3; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVkWdCFAPsoEOznsrrD9U5vbTFAUP9nTxaFcEp6FxXnJsa7v9lNYvXDBHyP2UdVNQC2fokqawcf9lTa9/RtnqrLEzLz2QUR5EACzk0Nbw2OA63oxooO5TUqVjWyE5E59Bqk39eQ/GpH02zFilNRjV67updwBwpdS6CXIxiVBW7zayCHEt1xstjjqheDUr1hdr9ikXU2rSeA+da0iB7cFETh1YI4V9N3Y6kan1jh4mdUyMxxIo09XHc5ZVH2RqVSrCREPtHxm8PwRmiWhh+TFYWoC6xkL51ERQZ59+d6mXJtE5KlBt/EuaE1F/kxoZQC0Eua5Da8Jq6h+MRg/HBDlMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ruGocmAv5GU8D3y9pdF3Th7HXPyq3Z7U2nYtfL3REU=;
 b=i2Hl7kWYRcQpf9WjAjoTiwB/DImf+ys3POjugZsU5sr+C9lxBQknrzsm/r7RtGXtjW/s/X5ifmkqpzoh4FeftTdRYQb2sQyf9vbcJno/VlrMcWC2U45wBzFeMHVG+PlxufNfYqitITuAsdBpoW1rk4nGoQxMdwxYbt8RATePOdTD0/NgInji7MbPHK2l+d5WsKPN0L+HvSP4IySW17a/DkIvlv779N3TQ7LCVtauhooJOWohd2W0W8O1gwje4FnJ8/QWSb9z6NeORC8TlzAzOSxTCI/OoGWvn7woOMwfkzzkRY/jb/PWIAA8wR+wy3py+laBCbEAp9BztoALDVRcZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ruGocmAv5GU8D3y9pdF3Th7HXPyq3Z7U2nYtfL3REU=;
 b=cVH16YV36HMAj91UBTlrWcu5wp1Ys8p1cWwZixb2mlXzTjUiesIua+oTOM9H3dV6p6/qURPkAxSh6OKOmMLNk10w4Cm2eEmfPvgpe+EH3TSwRfunz0YAND/KKIgQjBzjEpHcUqe6LxphPtlv1uxZhhEEQ3dhVSh2PfYZoEsqbD198Xf0SW1odcn3mLk762dimOVIhF9lEUEMGT2w3jDhEDB2hDZ/5t4BWkTD7bnQCPozJVyOjQeW8iskJ/TYfqBqRDj5y3B7i29940p/SN/qIA7j2ZVsdCvsE5vWm0FUDRxDE1EZjXimK+XFTU63gSaBqkrput/Lu2kEjLOTLZRm5w==
Received: from PH7PR13CA0020.namprd13.prod.outlook.com (2603:10b6:510:174::27)
 by SA3PR12MB7857.namprd12.prod.outlook.com (2603:10b6:806:31e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 11:31:06 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::3b) by PH7PR13CA0020.outlook.office365.com
 (2603:10b6:510:174::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Sun, 1 Sep 2024 11:31:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 11:31:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:30:51 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:30:51 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 1 Sep
 2024 04:30:36 -0700
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
Subject: [PATCH net-next v2 12/15] net: enetc: Remove setting of RX software timestamp
Date: Sun, 1 Sep 2024 14:28:00 +0300
Message-ID: <20240901112803.212753-13-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SA3PR12MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: b5025ff3-d8d2-4042-2564-08dcca799103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EgLswSQNqBzWcJNAfzQhgmzp779P+JUnwAcxDgTseZSUQtA1NEldVNOzP8Ac?=
 =?us-ascii?Q?CGzModpTU8G6tOmZOuK2jF6Dxux7sLkq0zs42t4ijtGZEwOHSHXYKQtLZn+U?=
 =?us-ascii?Q?B+ecmsFeWJaDG+cxfB5r1c8nGMuYzDrqAsWRXn2FWAeAuYr6C3AIIhk1I1SK?=
 =?us-ascii?Q?c3w2v4jObVZeL1A+FKbwtKcjJg/rqrLOy2luvpl8zdeK0oCvGWX2dYwOFyTc?=
 =?us-ascii?Q?lt/w8GiICWH1KJW7KjzVq1yOBUshfp71aCPjSgYzElU7KCobonNQKeiqZvjm?=
 =?us-ascii?Q?oFR04SDeFMBLOnDZoR+YSgWjGjWt8F/GSn7MKncL4Q1TulUEQmINwHnwRyfB?=
 =?us-ascii?Q?ceuEwumWy00z4fdkloLbuPIsft0cWUr18x7uGEF8uHZYZe7iGdVet6TIN85L?=
 =?us-ascii?Q?v6lG7PDZPGkP0DB6RjKQiaEkflz6HOY7JGT2oSdtZJQ+DND1IfPjoXKK+Rnj?=
 =?us-ascii?Q?ZmhDsh/6p37WYKrfevln8lsJMUxlGV7YJbxeJGO5s5K0Zvsa1tEKT406lRWZ?=
 =?us-ascii?Q?GafK1kzukGklTaFjVSvnuNX79OScdA3DyX8lDNr3KPCWzwzHE501iWZpzMj8?=
 =?us-ascii?Q?4lu6qJPUvdxZ0VDj8NnE8rONbBpIMvTNmkKUn70L54prRFVXx4BjVI7JtEZC?=
 =?us-ascii?Q?7GV55caJGmNnm9/HW+J/jXaxKyaRAmtxY6Ym6+/SDP/oUm4NZsI25k6SfJxv?=
 =?us-ascii?Q?+Hj7/Kwp0QXbhF1RY6Rre5LLkUSGntSInOCm7kI4qWUOIzgrnKGcdjE5j8ue?=
 =?us-ascii?Q?e6vpzsV+G1vihHE/RF3FY35kFfrK26a7lZoTm/8xx7wp8j6i03Kl75fqycHp?=
 =?us-ascii?Q?f0VLXcnLp3WzTmSFytzLwFykUmuNykfdVTIsnAR1d7rCoK7I/tUZdldneaGu?=
 =?us-ascii?Q?M/XS4cHLR9CXZY0HhAVb1tVC3Ld/hvRruYjYwL6N6pbFwkCdAYQcjfe4FEJV?=
 =?us-ascii?Q?fVqY5QJ1DEbooZEoYju2gKvWTvYJi5S1XzM171BcKCH+OblFN63Azz9lQTaK?=
 =?us-ascii?Q?66nlrYl4E8ukwdtf248UVNsxsnbfcpkfg/lPif40r/mYqmtduhuzQVJL7vMl?=
 =?us-ascii?Q?hC6Ks7RJ1COpiLDZSyll/RiZtflaQKeAtMSZ9b3Oh4NVT5VUn5HiRCtteiOj?=
 =?us-ascii?Q?tnyC4MnG8TgqnYAbde+StleK9gSX8WbFcVcTUDwu5PXXXqb/UN0LUuwtRdu/?=
 =?us-ascii?Q?w97I1/bjTU5jisnQ0oqbogMivWKda6jL6PGMdhi2DeGyE+w+XKR7VlCs+gSP?=
 =?us-ascii?Q?5WhRHWcUVBIqUdadInSpqnS+DoSt7SG+280yr1o4PmvP9ujeILKbj/DzIwXh?=
 =?us-ascii?Q?FsbAtY3MUw/qJmTkSpnBNGJlxb8pNuqyV7FzGpc6QhHIRUYp0B6U1rzutjJI?=
 =?us-ascii?Q?11+BrP4ueB79r/knKYEzktqFbfkDv5jg+LKV9Ezd5Gl2A5ke23g2yXGiCNpV?=
 =?us-ascii?Q?LICcpx/SJW9qr40EUHA3uzBJ8XSjL2eN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 11:31:05.1586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5025ff3-d8d2-4042-2564-08dcca799103
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7857

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 5e684b23c5f5..47c478e08d44 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -849,17 +849,13 @@ static int enetc_get_ts_info(struct net_device *ndev,
 	if (phc_idx) {
 		info->phc_index = *phc_idx;
 		symbol_put(enetc_phc_index);
-	} else {
-		info->phc_index = -1;
 	}
 
 #ifdef CONFIG_FSL_ENETC_PTP_CLOCK
 	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE |
-				SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE;
+				SOF_TIMESTAMPING_TX_SOFTWARE;
 
 	info->tx_types = (1 << HWTSTAMP_TX_OFF) |
 			 (1 << HWTSTAMP_TX_ON) |
@@ -867,9 +863,7 @@ static int enetc_get_ts_info(struct net_device *ndev,
 	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
 			   (1 << HWTSTAMP_FILTER_ALL);
 #else
-	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE;
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
 #endif
 	return 0;
 }
-- 
2.40.1


