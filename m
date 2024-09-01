Return-Path: <netdev+bounces-124026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41092967633
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 13:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6871F21187
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ADC1586D3;
	Sun,  1 Sep 2024 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fLPFeGQP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08F2153800
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725190142; cv=fail; b=Xh07CHkJeAI80krV2aKhcWICrBXZg85qkkNVwvrAv9IC+2A3I9EcDDDP6SFwRQR0hh8pVtN92gKGZGYTYhed3FnV3sqMYcN3ewRs4SXazhtZ1ke/mCu36H5wguUf5ocIzT9yBcw0R0S/LRI97dGOsO0nw8ljkTWeqEGvSTST1R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725190142; c=relaxed/simple;
	bh=9VYc0rgPv/B7kKkKdTACOXXiU++xD9/qmg5xGjV47v8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXly3F7diEx92HrMMC8coid+fzjOwki5cE34F/YcVm/1NrBRQ4RGeV6K+p+T98L6UYuqn7ujUH3AOTLJOD987vOVXMMf/1TvmaVxgfczJrdOATqLpYEVrf+elCt4UEmj/DAmOR9OaSojFTwTBs4xfx2F2lyRjRx1hg5trsmJDBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fLPFeGQP; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WL1NJgJnHAQiAY60rq/hv02bJWkEzFXdADqvhcNZ6RzwR5EDEiC7d4oFGRUmD04eImmpzRm3vWB0JJcwX8QdDgSROR03TUIsFE+SwsrH10N+sINDDs7zHSaK5YdTcktlN3G9TCQUhCbVVUIq0MPEPBih4ffD18rM4aQOHpe+udclsgcRPri8+jXFhCmxvuk9GD+uk7b6dbacRRwfQsIPDRZBw0B7SgrHtb93x8LB9W8uGLPLaHKaCDEzFDOvPLs4G7zZqD2qZEtfXT50zmjOVnYMUj8tqIXZZkgEgDJ5pM4b2LhMVOFNXMas++5kkYQnTwCldhRr8EZuv81E7zaYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grhUbnkW/WAnofaNMCDFFjHhRkq4iVKuMdR0Ra2x7to=;
 b=GNCSOjZv6rRTDDA+WOpmD9kXNWwd7K9WqOwnDeixAFrxFPozJvBHZflDVNNXotv897bE9Z1DH1olR+IjAKSw4zEHjdtSiMiu78gjLVSr3KzCgbxDtzX/fUBBGohnJPURmRMJlmgZ2uhj77xVysif8GaxwJgsWW7XU4D8u8BctwSazvI/2tfhkaXJf1UA6whIjhDTiApLSz6GoQ7iQJeWV4NtrmKHSLxtWjqK3jBLY70r7vT1Ulp/0WBa3YJyDsn7JTteb4mwOrh4eYBiF6sxXFwM9p0eIT/VrLNGmM/w8k+9nn81Rvyt5E/6bpETElMEU/dGT7yxozAq7k481ROoEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grhUbnkW/WAnofaNMCDFFjHhRkq4iVKuMdR0Ra2x7to=;
 b=fLPFeGQPuPtlOtFCj0vl6ttdiF+MP9lJMCWe3vcROg+eizriC0r6ke3ffn8diWrbN5s22slLJblQDGylLxZ0unrJ/ZHpVteA7fjUvVaj2wxaZJwarFopk5tDFleG1UYzpra0mN/QjTaFGweRr/Z1OG8P1C905m2cl1qYIXIqtqIcXWoMPUzfL2lqLqkyU/3GZmdBDbvK68Cg8fGpR8oWSGqXP+pUDe5oa+GbNTTEVSmhfGheISKZ4LbeYPLI9M+8cyvo5wzt+QO+u+ZUNFWXFfx+EOmm101v6scDteN5oNXLQJiSJtgka/3Wxy9t4fTptAI7D0t4UZvZKPZOuj0CeQ==
Received: from BN9PR03CA0085.namprd03.prod.outlook.com (2603:10b6:408:fc::30)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Sun, 1 Sep
 2024 11:28:55 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::a9) by BN9PR03CA0085.outlook.office365.com
 (2603:10b6:408:fc::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Sun, 1 Sep 2024 11:28:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 11:28:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:28:53 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:28:52 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 1 Sep
 2024 04:28:38 -0700
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
Subject: [PATCH net-next v2 04/15] can: peak_usb: Remove setting of RX software timestamp
Date: Sun, 1 Sep 2024 14:27:52 +0300
Message-ID: <20240901112803.212753-5-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|SJ2PR12MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 456398a6-9d75-4e4e-a608-08dcca79436d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p5hkDH8o72Z1+HbEmVqUTX18HYYGxniSql41tHctOSVwAzVxsJR4zveHxF2i?=
 =?us-ascii?Q?Fx+i7MPy3xFpCs4R1Ao4R2zXNBlZplQrOvM+6W/Mn0dqFaJIKbkud7JDDbiV?=
 =?us-ascii?Q?BmcJPSd0n+1NFRxoOrvPxRAzyqNQ0zqHZwjYUuejlG9tZNQelr+5yPHp5yHK?=
 =?us-ascii?Q?mF9Eme3WKjgZqWYksQ4WktjUTlVhSlHlCBgSiDyHEP3n6uVSilFZgjHBgP/f?=
 =?us-ascii?Q?Pt10QzLiIr7uS0nXxGxEeiHmaWPvyk+2lMrEy02CCpni60QrHhbFjfW69inn?=
 =?us-ascii?Q?GiDaaiRwc7FFo6PaA/EOr9wodeGjEhbmzLQ72mSjghHSab++TRHtATEDoA9R?=
 =?us-ascii?Q?rmojdz9i2q7/9DwZCWugCysMPrZmyexpPwB1Fi7sqZ+h6SvDCo9ZxHvSHZmU?=
 =?us-ascii?Q?Iw+ATa9AroiL/NMZ8PgqNHNN5CyDLlek7sh/oeV4YqbJFIwHhu4XUKM7Oh/W?=
 =?us-ascii?Q?Vpqi27S2uaVgnD4E6uHyCTIVFBvg0d2Y4EDVlxNquyzyffjgfpzXU6GFfFVk?=
 =?us-ascii?Q?uejcHq/9Jfs0syfR06uA6qqKeVf+6oCRxWzohxdWzod6WPocAD1utqBhz1OK?=
 =?us-ascii?Q?adSrhTLbTuznoWgrF3fjjWgbpzNOq37fOTjtQ68yC3Mg2Zr3jDnk88wfAWcr?=
 =?us-ascii?Q?G2J6zNjhO8MvacScoDerD+soBfsOqewAO3n73U7okkNAGfmaLF+PRf63T8iC?=
 =?us-ascii?Q?tUmrDUDObkBcyAfWvoyp0h04XkYAPWxaCWkM4PgE81P72fuNmHsoFIOSVMYu?=
 =?us-ascii?Q?Nu8i5QS4GeZWE8b60js+SUPiCDQg9cW+I5ww3HcbMeVFSNqsSoRZrlpO0BL3?=
 =?us-ascii?Q?+AyqaVLOwHqM3HkWJGL9AwxGNTUBcvEXciXL+72iNBogWaH+PF5+kocrVOcG?=
 =?us-ascii?Q?6BFuD3InweKAvTmi97xCzmCOJ3JKYxDxQEoq8vcJx6SVX5G19fpegN5tdBTd?=
 =?us-ascii?Q?ZWtWws88mkU+RkRR3EK1i3Zy49pw3GDARTb/qTqOVsHHKDY+DzXo3ufSSQf4?=
 =?us-ascii?Q?SSnK11SJPnxL1/vvH1hjtPjdGuvdiaOFNUj1z3PO8hbyPp0ihl5jccskDaVN?=
 =?us-ascii?Q?DChBqwQIQspgI/kICva8J81GmLyK0TkxiqQcSNYYhMvnaXKYeopvmR6D2ett?=
 =?us-ascii?Q?9uk6u8K+3VsarRtPKrNWsDGBYIz0JvrzdwCJVM4IwakMOXdv35l1UkrAM8W8?=
 =?us-ascii?Q?veQuqHITR+fU8GH7y0LYmScAveVJt69d1QnXWNVzkWr17N6B7HeclElFiGLM?=
 =?us-ascii?Q?42P9/hBzd97+sk4Vlb7tJc1cL9y9drsF/pcmfrBBFmiPs0sNSCUx652C7i+s?=
 =?us-ascii?Q?1BYUzoHU3xz+UrLq1xyNUwMCVW8B/ZEMImYtnv7XH5H9ZXLP5LeS0tjvmkLw?=
 =?us-ascii?Q?2d7xC6VorqfClF59GJF3ONWJVfELE9eVtJ5NpYhcM1XbOrlTGUIgwk5aW6yY?=
 =?us-ascii?Q?voOp3bVw8USwU8ZeE1x8ISRwbCqBTCwp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 11:28:54.9005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 456398a6-9d75-4e4e-a608-08dcca79436d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 3d68fef46ded..59f7cd8ceb39 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -901,11 +901,8 @@ int pcan_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info
 {
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
-	info->phc_index = -1;
 	info->tx_types = BIT(HWTSTAMP_TX_OFF);
 	info->rx_filters = BIT(HWTSTAMP_FILTER_ALL);
 
-- 
2.40.1


