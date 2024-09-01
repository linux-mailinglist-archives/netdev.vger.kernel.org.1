Return-Path: <netdev+bounces-124024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5861D967631
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 13:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4801C20A67
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A481166307;
	Sun,  1 Sep 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qi+ooFm5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D9E165F11
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725190125; cv=fail; b=reZRVOzphGFVKHa4hURn+pz/geFqbvskZzc83Rk5tANsOrPgHFeDDtsxTGw0qXniOKrnFEgAWHxq5rv6J1hIL/x0u4fN/5syHloVccgwcXd7hkuNp3G3i+Dz7/ZawU+zUEsHjXt0uPO5JL3ynjUw89It5NTIbuvfmRt5tSIUSsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725190125; c=relaxed/simple;
	bh=em3ZcM5izUUzZkznaXxiOehIspcwJoNK5bUC8voJFh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnmxpGqNtx1s+4j/qDZMGtkNaNnYcbp1WtD0ZtN9wH3/1z+5jaUFJBuH0mrlK5lpmBrqcNGPrRvTuPHdFQkk6U4X1d1QdoOFxn6DvSeM/5OsrPksUmBv/IWelFvTRe4XJ0/tsUnHP1xf+p3R5RS7LL1/NMhtzSTgsc55bAV80N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qi+ooFm5; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZikU6b2FEfFx8Dx1zehJKmHOktbhohwGmcEjnDmQ9wZm1Pti3+KvjCjguiaEpVopt7KSAu6VxAUU/nfSMhIOS9xfpalAL/WIY2tg2xKTN+UAAbb5XT/hzOfLbZha16v40LWha+9MUqZvXa02huoTnHYNWqs8gWG6En76/iMCfpDj/Tszn2EwKBAGS2P0y/aUTmSRwcY3mksv0JDH2UtKT9wCBoKFRIwIKm1mD1MfPN3VfA4ieViEvNtxW4V++yrgMOoJnrAKyf3gdt5mT12S/daDRej+7X+3n96vy8af9SSbY9C/6EDrdUwowOxuZFP4e4IJTHXhsdCoweGJ8ouuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtmLDPuX03p3zAxUy3ylpXhMQfdsddCnPI3XOWx80oI=;
 b=Pc5i5pRBWuQ61IUdTdq4o1L4I+sYe8NpMPPoVmR+iMp9C8fYBSwMCaiWFoubPgn0lVagV4Dh89mKq6tCkkOfPV5B1ExbY5QdGkAb6pPSaQqdFhghJpKEm4rsSMzFMPbgHnqgr8D9uRSR/lk6bt0NSeFXpf/fCK+SpIpvOW1wkBMn1Uvgw9STdkwBSHDjmNPHlCIYUwBnPGndPhsWesNSyyxcIJssqaLiBKgqXqToKgqRg9BtulcBT2wukLey3/JNu1OVtipaIUeXdB00YI7SXTVLtl6Oss3FEWXx3iW7B9SX+9e/jyUYNxDaFZRHH76fHBfGI7xBPQxIK44dVgjnbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtmLDPuX03p3zAxUy3ylpXhMQfdsddCnPI3XOWx80oI=;
 b=qi+ooFm50yAK6dDZqIuEvpQ6heuZTiZUBv574+Fsiu482We7T+ftAWMJRjwifplHU6qchEf7RySQbcliWWg3Ng6c/k/ly7i0WFRZv7RJvye+ocZ5ETHb4qXKi6TGsHVKWBjun8mkmPYjMyYE6o0WNIH8ri6G3fsByS+wMtGvB6zEiDUcSdvVDtepcvi7zX8ep7fV3cLC7YzKrQ29YT6eMY+n4qmTMqlXeWthdAnvbXCNjlAAmXhbYqbUpdzyZB7heYOLBCmIanwz4S4F0wXECDOQPdPbiIK28+dwhfMWCGJZ4AKMHMqd8al3q6Z5KjjCrGxDip3nmLpQGnNod8DuCw==
Received: from BN9PR03CA0703.namprd03.prod.outlook.com (2603:10b6:408:ef::18)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 11:28:39 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:ef:cafe::60) by BN9PR03CA0703.outlook.office365.com
 (2603:10b6:408:ef::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Sun, 1 Sep 2024 11:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 11:28:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:28:24 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:28:24 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 1 Sep
 2024 04:28:10 -0700
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
Subject: [PATCH net-next v2 02/15] can: dev: Remove setting of RX software timestamp
Date: Sun, 1 Sep 2024 14:27:50 +0300
Message-ID: <20240901112803.212753-3-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: e555ef80-c348-4fe0-3761-08dcca7939ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KNJtTAuIO4BW5X6ETeDF4yag405uLBgufnrV+ksWlAW9qZvxgWPGAUyv1vVd?=
 =?us-ascii?Q?aRksh1KhCgxFzzMT9o3a9bbusnuyGULM56CEh+tkgloHgP8wb2JEprk+qBPP?=
 =?us-ascii?Q?KRwAHqS7DmMKVEqlQm1ZntgEdaxeHuhQCBhFdnwRjTtfAyxeE/HrX0hWWxJn?=
 =?us-ascii?Q?d4+Z7fNngpedmmDo+v07cZiee5/1ZhXN+wEfSDv+foUHaX1D4XrIVmectLvm?=
 =?us-ascii?Q?lKk0CmuHZB9YozRrvfwVHFAKICubrygHuYJvBfSw0V00OIbwVRp82Qpwz+F1?=
 =?us-ascii?Q?mgIUjttYo29fdJREZVS5jTND2TYsfl1plahAb5uAA4qAvyhXad2yqBSWSeNN?=
 =?us-ascii?Q?QZNYf0caDQOhE3PQo3/5kp9h1J7cMIBELtEE/aeIfEGfV61RTaH6eQ99GM2i?=
 =?us-ascii?Q?+ceFjAuMvHH3Pj2e3A71b1e3LESDUwWW3+kSDYWnNidgxRfiXhGoX+Nx0Pvz?=
 =?us-ascii?Q?aYXpVxRc6f6bPl2UAn4G68GhlFS3bUyaBO+SxjECthS79HwwcNzZ5EJuT84Q?=
 =?us-ascii?Q?MZfdHk+CjqlnyxE+lM07zZmJyVik6LaH9e5kHlA/LnkurtYjTpG518fDbIV+?=
 =?us-ascii?Q?W6ix6aqCGiCO1xtJb3n4f93BZXuG3AqUQkMvH5mqnJ5fnmNKRSMCGpb7OZA5?=
 =?us-ascii?Q?9ybPy0lFsxLQ1d33PmHivuUpHPJwRgjx5oen2cMDSDc7DPdMM1+zfhd724Xz?=
 =?us-ascii?Q?dq5F0Z44AOZs+zH7v6wMJIwKSEdtLWqPOUtPq2iMxm6/tjcQUCG9pPUQ53ar?=
 =?us-ascii?Q?f+yYq9k3HqPQVqBYq0Bc6w5pMgKGp4TH2aTT+Zt/e8e+USjreJ2601QDPq1k?=
 =?us-ascii?Q?bmPZ/Sshf+1rEXvNApFWsMV+Xdt+RbSY99AXvyNE1NnDw8wUhoSsMHbA18pP?=
 =?us-ascii?Q?Td/m3Xx+teHT0+2mZZ+C8lESxQHjCIjdYi3C/0AaxYSsWQ6tZF+4cHrwAkNG?=
 =?us-ascii?Q?HGo+qfOqmpso8hQb4PZAEMiuuKANWELqlBJI7AFtoJESP0t1LMdYnZdwj9vA?=
 =?us-ascii?Q?2gFiIHrfC+OS+OafCaQBXlzv5h5o8jZakqh5rcReyxLTqVUXyp8EBzsXF1UA?=
 =?us-ascii?Q?eccFwiBd42yoI8pm/JXJAA75ktp0l5qyrEezSW3jkQ4qw+AIwnNv5U0b4sXT?=
 =?us-ascii?Q?2TotBic+HG0qbhH2W41s8+MfiKmPE30fgGkTiyEe+rc5JeuAalMTNYVGC0+4?=
 =?us-ascii?Q?bOFjgPCoReXkpAN116Ru7AhQWEkMrxifW0OjGe9BvCukMN8zIUOhtDQYPMW7?=
 =?us-ascii?Q?8aNIyw8XZ+Sa6D9/VQqO3Wl5fv69u6rKE85+MgF3o/VsZ2kTqENXg47yjNs5?=
 =?us-ascii?Q?ZSxQ0zyRi0eonGFT6jMDSG90G4BfCX177vwbEbU4gkd5D9Jr8QjbR8hrVZY+?=
 =?us-ascii?Q?RZ8ouyUaX7/yl5UaQK2aFmi8IiNiz4mid+4VG/XgfYOf80h0hjm0QDw2Sx5w?=
 =?us-ascii?Q?rmslet5Q5ykhDEdlq2SBFI0yIsHELh9/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 11:28:38.7562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e555ef80-c348-4fe0-3761-08dcca7939ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 87828f953073..6792c14fd7eb 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -380,12 +380,9 @@ int can_ethtool_op_get_ts_info_hwts(struct net_device *dev,
 {
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
-	info->phc_index = -1;
 	info->tx_types = BIT(HWTSTAMP_TX_ON);
 	info->rx_filters = BIT(HWTSTAMP_FILTER_ALL);
 
-- 
2.40.1


