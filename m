Return-Path: <netdev+bounces-124851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4F996B381
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216FB1F26597
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3A715573D;
	Wed,  4 Sep 2024 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GPD8wDzI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF7A1494AB
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436305; cv=fail; b=F+g96T5gWwoaBVQV2JifNksx6zKNdYHtLJgGBoSGE5IkLv7f709Q6oZ4YDS20k2y/pxqNiqJpEAROwcwTmGeiUrCI2NpqZqj9CmMoIojKuWoWLE1Q0d2nMZ6pbNDERSRMV6Ycqqe97//OX0mfDWbsqqZRND/G7fzCec1cbxlARA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436305; c=relaxed/simple;
	bh=pVCzAYlHvw+POnnKlqeN0LaB8PGg6FbQCF/N6Bv9K5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsTPbeCLtuHAHE3BzclH8/1Apdc8ZfOcI499w0Mr5PVCG8eBB5OUJ/oOO4FMVmBLHErbd7YZYEd+p5IfABgSzeGlV0ZazPnDsUtgjfPKYFL6OxXowqrcn0FnzGsjIzLYgH9aS7nF+7YK04KDXcF1uecswmwj2e0imj9NjkEhcX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GPD8wDzI; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyZwoBDdxhUU+0Gx4Ev/I8jThA766usoeTQP2s6hWrbF3/fsbUSObj9seR/9fu8TNf5EpIuJUgnUqu075OZJABKkhhTNVO8Bvl1Xhnh7jQEQhOSJ2ur8jCMCMN6cfsd+HhhiTy8ZYf8DyoivNb56RdFAb3ChC9LPKf38Z3tAL9v+QN0/UbqIbas57hl60sTpugl/+V+4zZPWy1GrvPoXTXLoDV+f1uaxr1A4EhRINH5S/1tqTTtuugx8r83LPK6oFitSwPaPnbq4Qg9qCPqrlvGYqDuFfz9qrZR8CoSPdVujYwsDAo8QH0+993G8UacTy/JLgAnQZ6XO9vxiJxUD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+MHLMrSk9HpmsF7/iiAoADt6Qp4Xs+tnCbKzG1tkQM=;
 b=NXryOZgMRuGsGbv+KIe8/9MhcK+PRdLsSVam/BInIGrDvWnjukzNu5C8vRM9koJXA2TOpyq1N6We36id28jirCCEuoGgdIj6j4DyrclZJoIwTi4jr5Asp8pnFAm4wNiD7yDyl6HUQxLp5CTOnrCIOc6IFltZWJShLyxzATnk50YVtMXkMUOPH3y7XQiaDjntlCAd+AZ3sKe53dPO/lv9vJhIf8x3ZAj9VQfiTvEC8TVGyY+J4HXz7PzqjJ4Iyb/LxyKohf/JW+3HPnxcCRLmx39MFPxJGUWNxtaApiAHISZtFabO7w+/ZLlhlVzeOcYirGJR7XdQB7jnD8zXkTyhvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+MHLMrSk9HpmsF7/iiAoADt6Qp4Xs+tnCbKzG1tkQM=;
 b=GPD8wDzI0GJ5BorbdJ9gFi6E1IQ8ihGMQ3bIjZJjGRX8+TqRHlWaYg3DPlLRmnDcIE9lfvxDOdpldX0DcckdLIcYSTanKajGzOTFli+d9RwkUhYmsOOLZQAb3Jloc8lYnhAYF04AisDuQbWukNPwe8rpe+eb2UueijbegGJbxSXeffCHmASyoVyIIfPbMsJkFN85AqXdkGD1h9a2uLh6Nq8CzSEbFbCnf1FLh7ynHGW9eJafh/MQEUrhvldzdsWnXdMiEORfvYcmgzQYUkzLDv/96Obzh+LA1Tpiq6br/7s41c/8ueyNXQRm0Df1cgzH6CQb7nWTo+DKb6JjWaMakQ==
Received: from DS7PR03CA0140.namprd03.prod.outlook.com (2603:10b6:5:3b4::25)
 by SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 07:51:38 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:5:3b4:cafe::c2) by DS7PR03CA0140.outlook.office365.com
 (2603:10b6:5:3b4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Wed, 4 Sep 2024 07:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.2 via Frontend Transport; Wed, 4 Sep 2024 07:51:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 00:51:24 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 00:51:23 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 00:51:10 -0700
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
Subject: [PATCH net-next 09/15] i40e: Remove setting of RX software timestamp
Date: Wed, 4 Sep 2024 10:49:16 +0300
Message-ID: <20240904074922.256275-10-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|SN7PR12MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 21776187-42dc-4360-acd4-08dcccb66820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ReoEjYf+0Ph/yNs/LrAWdBS5XKlIMLD4i9apkh9GbKvl/8k8oze2C1RhSAsi?=
 =?us-ascii?Q?juutDjG3fsaeWzXmJZkNj0Lt+Yvy/ibgn8XyfV4uaSi7rCPqXq+5V/1FHXbY?=
 =?us-ascii?Q?iEUEWURQZ2U2bNxJcy+3HXgD3lIoToDWPGLfslC1VSlUTUQ6O4p+LjF1gXFo?=
 =?us-ascii?Q?FhXEgOsjpb6ZuStPUb6erT6FPe4nVsiRzeQW2BIF5PKbgqI9zmu49+TRMlsn?=
 =?us-ascii?Q?gYcUdGQM4vGgJb9xETNFqIHk+GP92WXmAUsj3t0qjkSVHXDCZs40Xp05qpJp?=
 =?us-ascii?Q?P+J5Rbzc10QHMsAo84HS4KAm0/epPjgh08gzEi0ltUSo4tR+Bls7DBP/DCKu?=
 =?us-ascii?Q?oGTB91ybDQBsRm9P4/VWya5IAb/Nr7vl04CrRtAJX9g0mRv6MZUMrpNCJ19l?=
 =?us-ascii?Q?v7GjP0YZRWkI9NLEE45vsej/X4FRVRzPl7d178+P+/NJZofJLbCIjOs+xzWJ?=
 =?us-ascii?Q?3xN0iMPk3BJx47tGer0zT3HoWt0aNVcuqG/iG/DypKzEGZ7gdpEyz9UsCm0Z?=
 =?us-ascii?Q?YW2iYvYo+pIXR5LMKSfYuLiiIULe6N+gmKVp1p9HBL9lJS3BVfBDesKgwuwz?=
 =?us-ascii?Q?s6BNAIrI+WDXPtWlFVUWmCkjLPwUKn3tWdh0uZVILCGjx2QY/joAGMX+zjaJ?=
 =?us-ascii?Q?g1/E4tVC8gBj0ieHRUSyuVNOXZeq4E2By0XMhw8DLzIvn1qrhgci0e0ERPJb?=
 =?us-ascii?Q?4A1ZuHi9F+9EC2ULL2Y1a1dCNdHXmIvhSp6EZCyUlf+14lrNikZVEEx8+jfn?=
 =?us-ascii?Q?8VKwQuc07cvltPFkB3ZF9lQwkytbqus8r5sul4CEwavAzipqnxr/RddRwcfh?=
 =?us-ascii?Q?palILiiC/W3CGCw1iGsgWG/l1rpwIU7NCjVW8d+d1Uh5O8JydarMAgyZrOrS?=
 =?us-ascii?Q?m2LVe2kC3uG95GMJzlS3jgY3P1q/NarX6EkIR3STZn9IURXOx6EdygfE3nWd?=
 =?us-ascii?Q?b4PW3BqMfNsimWplR1vD/r6hcQbCWyghGvBMqhQBR52MuWHx5cb6YE/arD9y?=
 =?us-ascii?Q?37r893VIYQTPVNtAS0mDwz8ebM0xFmgTGJSR4/DNFubex0XUeDfzimczvqZc?=
 =?us-ascii?Q?s6GFCiJw7E8M1n0lisJv6Mr0OriFQNjpuvBtkgK2k0wOMjCR6ecpXqu36eC4?=
 =?us-ascii?Q?q8AX794Nyw980aoh5w8HEhtLVGPjcCzLZBtdpdvWE9owZi5M8sIaxahAWyFp?=
 =?us-ascii?Q?Xu1afH9duj+6k4D/dQ22JIx5InDNY28krBTtKxGOX61KgduL2d8cbKbCUHmJ?=
 =?us-ascii?Q?dR4eafAP8Ah5mAwlhktS9Ft3OWn1OpumnnNkPtHQVWRgvdI3t2ApFhUzwq0v?=
 =?us-ascii?Q?gY4TrMBIbYMB2H1gZWbQOuLHuhLDoIAzNDqkFyyHQ3gbpL4Rt68lHLvuQHvV?=
 =?us-ascii?Q?SGKD7epYxBiOeANNLb4Z5e11/On8ax9+aWWk5ViZSXIQ3hgwJwLjTg1eOAR3?=
 =?us-ascii?Q?irMS7Uv2KmLxkRiY2JK9hiHB1iOpB/ww?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:51:38.1447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21776187-42dc-4360-acd4-08dcccb66820
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 1d0d2e526adb..2e57de16368b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2555,16 +2555,12 @@ static int i40e_get_ts_info(struct net_device *dev,
 		return ethtool_op_get_ts_info(dev, info);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	if (pf->ptp_clock)
 		info->phc_index = ptp_clock_index(pf->ptp_clock);
-	else
-		info->phc_index = -1;
 
 	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
 
-- 
2.40.1


