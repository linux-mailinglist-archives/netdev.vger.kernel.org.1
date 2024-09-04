Return-Path: <netdev+bounces-124843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE2196B369
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA9A1C244D1
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0278714F9ED;
	Wed,  4 Sep 2024 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EggNC842"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29E149C52
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436196; cv=fail; b=NSvhoHuwHPNscSlbtfHFB1cPUpd4bFG9wWNZKMnhXdzeXSV2E4ppntmPtQj3DMyk7szeNqVu2SHwLEKfXZCMJQNzj1e0MXpoNLF8Hakp+Qv+Vk4TePL3KX+W6aZRNCTgDvVse9LDJffvyURMxI9nKU5whRWkrBOJL77E9tLx9Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436196; c=relaxed/simple;
	bh=P0t8/z572OxbUBCA3Oi3hcRQGhZPdme9Mf4RIXyZkHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AskWC85AtoRHnQNdHVj5l7EMuUKjWw62GJh1P+JphBF0HBYNQdb884dS+fanrg37Hh8cW6Qx1Vds8aEpuiLQ+emSTQ+dm5oyiQI8fAAU2twYElB8rMnDpPT1oBIyeogeSrke7U+1DEXoDZLG/sVbwROC/KsNCS+Rx66zT0zxBY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EggNC842; arc=fail smtp.client-ip=40.107.102.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETe9GvfmdYYnzNMyBO4KPoofoNp6hCsYZNFoD4T+pzCVxDBd9ycQhodQy1N+SlbwbPOHLkc6oXfeJfANOt/hIzV8Nj9A95St5HJHdYTMpqaFkrWJyTZCqmRiu/o5oW5m8Sud+QkTBThcloLGr4nTZUjCbZK2GydvO8caEANQURpjc6+NzJCG3iALbrqSyATYtaP3RLir3/8ztOpMXIv1RN4BOd1DPvI7dPsFp1xHuYVd1yOaBreF4utRKNDqKQXiTSSqk0Q1fJlyPHLzmdar6ZzMr+tCiQk7Ep7dGMmSwAhlojCdbF/DHNEYoOAnrr6ijjUUlSuyIzvzSv/YOPkKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vkx/U3tOVzczt3FRtZWBj5Ck/QM1D0z2IudTxxtMsC4=;
 b=gaRZN1g5ryqS8vAfdwnRP6O6RIasZkJrPjY/F1SUo8OGJ6C2QkIcceTOZmHeG99BkeftnxgfHJ+IToV96H+UrOjkI3GWVDIL9SB4lJLDLkcU/BnuzsrUvjktGPcKmeAflAcu7snXlhw75eNyy3DHBlagKJYZvlrA24hRyGl1uK+3joRy8epjkH9z/3xE/Nm+nHP4M2KilbB38ImPzU9fyYQ5q5iMycMV/RlWjE2d21TYnoH53WC+Mn/6etl5IfFf+u/ULwRzuaX+jpYsUXlAQNIupe4XMsx9nGp5xTRMfR9Gai1khwO87yagz3SmUpewebG52jpPP47XUJZErzkxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vkx/U3tOVzczt3FRtZWBj5Ck/QM1D0z2IudTxxtMsC4=;
 b=EggNC842YJZeqYc4/vHZUhonce6qGm0FMJw/VBiwFZtX+d4ZQ8b95vWh5rTaiVfeju6G0bnK+a1UapTfFTnpUlGVsSfipOiUvaz6VstUt3qCettqFCvQedkVdZMU79FfZo4YyIbL70xnEhKs2B3aZn/FgPHUJ3YeBnxBlPuZwXNHZ2lFX6NvxeKdu1Go4Jz56KTqTp0/clQmFH5w9bjgEj8QeRd+ZvqqKWnS0ZVJfatIRR1BK+mJCPUCsjzPPVT9UqHzPXeLUozVXkNXngz416VulVTgssTjnN+ECiGNQNMalY9UEI/uRXMw4smQ6vRyRhfZOWvHXZqAjfdDhOl6xw==
Received: from CH2PR17CA0005.namprd17.prod.outlook.com (2603:10b6:610:53::15)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 07:49:51 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::b2) by CH2PR17CA0005.outlook.office365.com
 (2603:10b6:610:53::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 07:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 07:49:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 00:49:38 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 00:49:37 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 00:49:25 -0700
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
	<rrameshbabu@nvidia.com>, Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Subject: [PATCH net-next 01/15] lan743x: Remove setting of RX software timestamp
Date: Wed, 4 Sep 2024 10:49:08 +0300
Message-ID: <20240904074922.256275-2-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa01b58-157e-4a2e-9db9-08dcccb627ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P2qv6vXIT8z0H4L5hvuxqeYsixHPPKpT66c5QvKbOzbe7t6XrJtI6PLhErrM?=
 =?us-ascii?Q?SkrgMHnTmPOuAJ7cU+1fXXYt6ahv/KpdxRrnXym90D62+45pdU7AHwNxLYpx?=
 =?us-ascii?Q?9JH9NIxf6TfuN2d3naLZZarTcXi9WtxVxKnG1Y9xxVJ6XNn3VQI4BrslNCYI?=
 =?us-ascii?Q?NuvFAGOm3S1kwaLPaHHIix28dIznXdRreg/0g0laVrlUJGG4JmSHxLzpWvw4?=
 =?us-ascii?Q?DfVwABDIHuw0WPdjow9B1SrqQVx8679XwVK9p5UwS8xMnKYOtqs1St0RRuiR?=
 =?us-ascii?Q?YhmpDlN/VCOI6dlkq/V1SKzEqvcUwP6c9BCi0GCAQWj71+4Ps71M/QVT8L7d?=
 =?us-ascii?Q?x/bUyzqpv2/HqwDMKpC+FeuQipgb8lRTSFQ0GcVUsMZXz7PKSmUjWMMGhc7U?=
 =?us-ascii?Q?x5pTDOJfHopJecUyVp8MNCsqEA4IJPCWWDI5GPog8LDB5NkbzU19s/bTTtv3?=
 =?us-ascii?Q?+jwPaJ4VL23uTYmA8IyYUYZwX5Q7f7EXm1gKtp6pW2jerlDP+ZseXLl0r6zO?=
 =?us-ascii?Q?+xeylVvQYTo6t9MwmRJkNCVFgYLFI9uCOEe+VPicd+bpJ+ecEe0QZTgXgQWn?=
 =?us-ascii?Q?AZW/pRLQsOkGZQAG0ZN2dcs0hK4eCFeZMXkvAWfYwHtQzqx4TygWMzb+EDsM?=
 =?us-ascii?Q?wzUOwLBww91BZxvH4NFz4drgEToJJhD2h+dzHgIh67WqCO47XmWZ83lfsXfJ?=
 =?us-ascii?Q?SLsKe12ovOVwUu5lJcckmdpmHix+WWfZ+i09mdgbWlWB4Ul6h/oWrjILLiZr?=
 =?us-ascii?Q?Q10MaJNBx7wgyBBvuH5zmDCt2/pdcSXwwKcSl1lNlV19ifjEFGN1adbi8N9y?=
 =?us-ascii?Q?OXVcwrpT5YoVb1VzzawyBf3u/7FbVJ4RVV27iD9chZ+RnPHO37unjJHxfKVn?=
 =?us-ascii?Q?ZcNS4iu/D8/5AMSTfSH8hYLXZbbEmDAhLZBehlVZfI2TWNXxVIR/a2/kppRw?=
 =?us-ascii?Q?5h58JBxEdK6H+mzs1VkuuvQUF2coij4jXFc63ypWnEb8CY1s5oKOQ6VOR4vW?=
 =?us-ascii?Q?ua7s2tdWmJwC06sYLDCbCEZQPgK2Wi+jH1QymPh4zWgrdbcZRpX4111SeC/c?=
 =?us-ascii?Q?EXzJunFjqjc8qI8MPIhmrz+3zA4mvP3FtiehxiB81tUx1cbfbLrNi6YF+ucY?=
 =?us-ascii?Q?4jJyomhi7+NErufWypJK0EMaYcbengvUbcR89OJ1t2oJlFpGNIszlLAm4xOY?=
 =?us-ascii?Q?03q4x7+66JCszV+xIR85LzBd0eQjtuPNWb+P4KTSGbuoA5SCp121Phg3lczo?=
 =?us-ascii?Q?lISqXJrZ0P0bPAich4yxvFR1tbUdPbK1xUeFc82JoJcWQHy2hP3NRrVdb+0+?=
 =?us-ascii?Q?Pee8wiw8DKL0or5Q27FlSrgnoBG2lcE+RH3/2nmsxXhs+qDdUpkL+rob4SWB?=
 =?us-ascii?Q?AclNugkP/9L3ybwkos+EWVDfOMZLq4CbIGP4ItcEkuTe5iVPtm4UCV5wzpka?=
 =?us-ascii?Q?55G0YsZdokzadF0yQcDpWczeIbss5ZZk?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:49:50.4359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa01b58-157e-4a2e-9db9-08dcccb627ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_ethtool.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 3a63ec091413..0f1c0edec460 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1034,16 +1034,12 @@ static int lan743x_ethtool_get_ts_info(struct net_device *netdev,
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
 
 	ts_info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				   SOF_TIMESTAMPING_RX_SOFTWARE |
-				   SOF_TIMESTAMPING_SOFTWARE |
 				   SOF_TIMESTAMPING_TX_HARDWARE |
 				   SOF_TIMESTAMPING_RX_HARDWARE |
 				   SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	if (adapter->ptp.ptp_clock)
 		ts_info->phc_index = ptp_clock_index(adapter->ptp.ptp_clock);
-	else
-		ts_info->phc_index = -1;
 
 	ts_info->tx_types = BIT(HWTSTAMP_TX_OFF) |
 			    BIT(HWTSTAMP_TX_ON) |
-- 
2.40.1


