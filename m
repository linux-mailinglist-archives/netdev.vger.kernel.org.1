Return-Path: <netdev+bounces-124847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8222996B376
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378BF1F2664D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA35165F0E;
	Wed,  4 Sep 2024 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qfe+lb2b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AFC14F9FD
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436254; cv=fail; b=KifHP2CuGme3Wr5bYI1XJxqVTYkN4iiUl84yZMYX0671X+xchyGOQyqq3QnRhmKjiJUO04vc+Yg59hAOyDCc96473nsvSWk6LLYBtHxzryfUMoOl5zNOX4Hz4f1E0JV8huviXApQWJRIqgqkFSaRKV/JMJNOMTv+PVARsKa0S5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436254; c=relaxed/simple;
	bh=Di8qmlgkZs/cJAUscKdClbZHX4xQwrQTtN+RLe3xMCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NPeBsjUWLnDmsaOGMWfL322MwOWMPvY9dkkMeK1sh7AUX+/b6eW9fTTa5XIh+2zlSKEB9ljyQB3GhoC6c2oHa34Hw9NzCn4Ig/r8eY0pSXcuQFipCXFRKNU8meU9ErrgouIwxQBlNtx+00C8ia0CRDPOFgw7g1KvggEZBaN12/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qfe+lb2b; arc=fail smtp.client-ip=40.107.212.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P99GHjzBuMjKCXSt98Qqzwzaw1DvhpJYk+13GNpeYg/fhWjELddZcsuXj8/8ETF37XIqyi/vAXNWcwOmw5OUJgCCJNPkKuzHUWT3EaE1VbvU++ZAqifM1gZk7R7/RqIofyuTimD0FSC5XxBqTu6xCC/1wp2Wno6NwFHWYGeXGJEAIzHxpdeX6F72A0qHsjXyVqGdm0NqZknqLY4o2WoUDBBDzBykoXvB9rHuafjEODElEHMV0H9P3YH7qpSWRo26VwZFGXL0Gn4s0yB4Vq4V/k+IiFyvXtFPCssyi45PngxNjAYvXze32OkhgOUnQaz0l2HNR9YMXiunjRK2iYDAgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jj178cnzgngp/Qw0zjv2mm4xe4S6vFU5g20T4anuacY=;
 b=peceVzEUp0QdRtskB78d+bAgJHhf0D27il3QjcLV6PbOvsx74lUTVQZsERWrxlon7Mxvurw/I9I1hsM9kLn+hztim5hbzjT1bADqlhasGFdWL27wrDJgQjiI1QZDlUkgSw0LbZ3tqfi2qiiWOm+1FvQKve1hCPRX/1hUpB90oTAoolGZ2V+scnKq6L5FTL7yN1hnLbEFdsjuteIk7wzjKZ5i7QnKhapNCrES5yO7ufAiyNY8/lwmuoVCna9v6Q0TMEjhTi+wCQUjzvP9b8Ar5h0F9kdQ1OAG2Wh7/FK664TxA3JBkZssm/ySNJeuUdRoG8hBMZi8rtOIox/8dGUzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj178cnzgngp/Qw0zjv2mm4xe4S6vFU5g20T4anuacY=;
 b=Qfe+lb2bH8Pnh3tz+mdlPDahxOIgwrIWqAkn3LZlYPZ73McB8gqH+eFHnD3TsSH0B9HAvX4NPaj+J3StU5/X51q/z1g/G5FZJn9qAR8/iYXMkzX3Bod5K12g7Umj+3WAUHMv/GYUqrmpYpI7qqwqsu6R+cutmreEZZM71Qs5+7Z1sIpmM7dKkeS8OXtMTL2CM7RCCnQvnqMEcZkAiXaGltpRHRi2GsBJoe7Tq/mGtWzTyNdFqghwZWWMuRaUKX7kPQ9Eeqr/hYW6kWKucZ+Vn56RIHzDvYW/ActKgux26waYLL06vVebdi82dIh52Y5oD8GndAnrZucT9/qcvYPWew==
Received: from DM6PR07CA0120.namprd07.prod.outlook.com (2603:10b6:5:330::10)
 by LV8PR12MB9262.namprd12.prod.outlook.com (2603:10b6:408:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 07:50:48 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::af) by DM6PR07CA0120.outlook.office365.com
 (2603:10b6:5:330::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 07:50:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 07:50:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 00:50:31 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 00:50:30 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 00:50:18 -0700
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
Subject: [PATCH net-next 05/15] net: ethernet: ti: am65-cpsw-ethtool: Remove setting of RX software timestamp
Date: Wed, 4 Sep 2024 10:49:12 +0300
Message-ID: <20240904074922.256275-6-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240904074922.256275-1-gal@nvidia.com>
References: <20240904074922.256275-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|LV8PR12MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: 4467b337-6096-4f9a-05b0-08dcccb649bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uDSiFgL0zXdha+De/TLbPgkL5e++gFq3qB89kXF7EaSHQhhRKkbFsWsgN7Ts?=
 =?us-ascii?Q?f5mapv4Bt6Xg61gjqvPO1BSP0BMGOwOHAJO08yJyOVYD4SOfdO49nBun3oSx?=
 =?us-ascii?Q?UE6oIlKcYPnRSRMLnBfbdT33X8V9LiXT8fv0E4bjzMl0W5UhQocaILObHyyD?=
 =?us-ascii?Q?dLYtnDWF5NR0UO9pPDGQcLxesXmCymfLwoNkRfuaA++/PHCYxxsPwtug+7Fg?=
 =?us-ascii?Q?bsCGp3YdIzUJ0pMd6RI2y7bLSraDxT0RW14N8a1XzaPmqlt/RBUYPW3fwpuv?=
 =?us-ascii?Q?U4rLB0dJChD3Rk4ZAxSOeX/90b3LpABDwOPQN13+Z5/lHAXZP74/3kKUE0VI?=
 =?us-ascii?Q?j5TO3Z9iBpBCMDzBVJweR8fUf4CddbVJfEk50oHpu7ZmppUd3+I+GRSXsaXN?=
 =?us-ascii?Q?5fqzlAp1WV9y68RuAANe6z7J850xFLLLKqqUbRGg9kqtRqfwa8jtSGYpgA6i?=
 =?us-ascii?Q?9u05tdEnJnaf6W3wI011MKKkqqexBnqSwWHRy9fR/ClXNwg7uOl09YidihIH?=
 =?us-ascii?Q?QsHs52UWl/YJsPpPs2ptIgqCzooS1t5kpGK0yP1PhNs/yqfFCjzinvFTwpYj?=
 =?us-ascii?Q?hcN/4gXgd/+tfIaOjczZ1KnJIoZtcrMhEd7OTUi1xoe5UoruAkehisDRBemb?=
 =?us-ascii?Q?0GIX5I0mueGgu7uD/2nBNxEclDAY9nwSo52S4IKqhQJ10iltiZIJoj0amzn7?=
 =?us-ascii?Q?rwA56DzWublFC7VRm12AvwlEMEOjceP3wXj/oAI92pIJeRoVjlFnBwst4RK2?=
 =?us-ascii?Q?I1/dUnRiVfk7IrtRVi4VNh6DmOhC5cCMhxhLK1yIjTPoKc28oh2NjHC+uHNF?=
 =?us-ascii?Q?Wyffk0Mziku8scbYsdyJoZimmVLFKrt+EWXSK18lQ8LZlfS19yDLjd3rtlxx?=
 =?us-ascii?Q?HLfjuSQoQu6yhUnDmg9bSV7Z+BfYEObqXLzI4YGAiw8CgsKDih6tBYV/nlFU?=
 =?us-ascii?Q?kemGIYwQPVDmquQy3gRxopb9V53S4E2wlzcPc3RGgn4hUMnJB63ASaxSQtnx?=
 =?us-ascii?Q?oqipoBF0TwUwflS6QQYBZxU5V+CTAy4RCvIjEOnJdGhddFXJ4Ebcupf6VDj9?=
 =?us-ascii?Q?nK/vnt1khkQTUXIuxZouD0jRF/xmpgjGeqyVd19eKp2UH0m0sSDvVJFNQnEL?=
 =?us-ascii?Q?D2m2MBmPB9mqWQyo/qbjRWwnwjYENbCHXo45ErHM2s7nSQ4cwO4RffTj8Rpw?=
 =?us-ascii?Q?AnEe9vyG6M2XgIGZ8ZlR/aROlMp8c9gxBWEUuRs7f4KElLYhXXlfKffjUiFI?=
 =?us-ascii?Q?U6UoCXoLlipT9tEB5lapZb0GWXIG58A7r1CcATtMz9B/DhzUu3+7w/l+YJr4?=
 =?us-ascii?Q?W3/mO64U0Whjo7/GNVn/78ka3u8xLgpjBSPaAYfFjT0HU2i/U6bfhN25Xmfk?=
 =?us-ascii?Q?vAM/CzosXDQrZOnxzqlNgcxtS3J0iC5Rzzkg9OV3dVWnl+Dk3bAcWG5RA1d6?=
 =?us-ascii?Q?3qaCQzuFvrRSXh39AgV1BRgPgODX2e21?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:50:47.2356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4467b337-6096-4f9a-05b0-08dcccb649bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9262

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index b60976947da5..539d5ca82f52 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -714,8 +714,6 @@ static int am65_cpsw_get_ethtool_ts_info(struct net_device *ndev,
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_TX_SOFTWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
 	info->phc_index = am65_cpts_phc_index(common->cpts);
 	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
-- 
2.40.1


