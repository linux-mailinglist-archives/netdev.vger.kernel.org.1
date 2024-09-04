Return-Path: <netdev+bounces-124859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6891496B38E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8022D1C249DC
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D868415530F;
	Wed,  4 Sep 2024 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sPwHyq5q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B541547EB
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436375; cv=fail; b=KRBpd6FSZKXT8uZ7oXypqMbmgzhX2wJhMd7giT1nf61asB7uqFUt4eVWx+HhPK+ERd+z77hI23ZJHDg3CsqEL7ECFa061NMnjIviFdZ+uJnN4z61DAjgjXkAqhp0Own2CtHeJzHxwFgjjeSKJ7uOZcUj2Z3N5NQoGSaOSRGKSfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436375; c=relaxed/simple;
	bh=EAza/WZhoGybWsuZVIsGEyf5zmAi0bFTPSUFcba0Q44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HyIxNiZwgRm12XTh080aMGYJ0342D1qHjGQBEzw2MT7AvjziF/ZeVLay0Tq6ILMJknEsA5iVQ2FrmS6bUbIhLARQ6pqr2acMyty1EDlZMTs9YuYRc4IX8rcG9S/X+DUEzPqcAYKvso+1WIeqt0zaqpc4aiynxjrnjqUJPHRgdG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sPwHyq5q; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgqpZC9WW66ApPfxw0s245xNMEZMXr2PiD2PVpToknw30eLIveHsKHCLwamQFUUxBMRZDaxOvxTC+gQ4ot6aZpCVqbqi7s/iLQFQuKYGUO5mbFmk+9CjxDeKPTOwyWXHxWj3Tcnf4KLDN/t5oXpQvCT4c5qXs6xeBKchyMXIlVIsRKKsYtSe8VVf9aRpLncvHCNedgcRh/w+9q596VePVoru0rgXaFE4Ix8Ubzm/93ayVmFCRQ2F0JwNSPTv/Jxd8xARHz09JEKtN0Fzn55uGAoc4ai5tEZ+Qw3B7hUKvaQYAtTQKQjN+KtS6xW/EFnWc1RnA3pgGdvxi5hNqxJcNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncQB3c5p0B/ai9eV85oZQ/06Zolkek4LD0YVnOi7rqk=;
 b=Cw7xygfCexPGWnX4V6QJNbi1FMzNJsr5uGokYEHWDdIy+dCu403c1zbACatSTpSteq1nNWrhNnwVtpPbKwSq8ieTdU3Dq1J8roqvQPAkzEwtSX9W3rTFxy1sa3mBwFCl6lDL98JBBR0NhJbd33lnQGIieGLNLZLT3jZoT8DeT/pafACbxf4Oc+bcKFSc5IR6PlE5Z3Pf151w26OaoUWFA24H6fDteAaCbpAOVpF2B56HI08aLLuOOsOWNtK1LWBybr3s7cgkZh0QF6EfYbCXOkkWe6ywimiy2LP+D+nT13o2BG+cdOGghrKZVxbDW9l+enwtTem5FFFQP4JC6f0lrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncQB3c5p0B/ai9eV85oZQ/06Zolkek4LD0YVnOi7rqk=;
 b=sPwHyq5qaamqv36ShPo7xTDQoDS5o7+seTchYGMoBiZBOxtneyRmG7yK5Yq7vF8KKqUITBBQSP7ffv0z39iFRlKNaa5qMVZ8TOKtLBYmGyGztSBa3GMQEgqFhNTb2H12IiVEuOqA3YHZvERgpJ0sVJtMjIpEusphojjxEB746RHiJ9l97JkVeiwFDOzWD/C6HffxOEdSnDR2e8pDZfsd2tCTh5lZrWlmNxEryokHlcSaO9h15CmZYw0AQTCD9JpLVT1TsEmy1mbiNCF3ATkrT5L5x30awNjyLlFT9A8y7LvDs0Y50RRdovxyyEVqbr8bh7vT7hVpKH0ygxmgxcpuUQ==
Received: from CH0PR04CA0016.namprd04.prod.outlook.com (2603:10b6:610:76::21)
 by DS0PR12MB7828.namprd12.prod.outlook.com (2603:10b6:8:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 07:52:50 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:76:cafe::8f) by CH0PR04CA0016.outlook.office365.com
 (2603:10b6:610:76::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 07:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.2 via Frontend Transport; Wed, 4 Sep 2024 07:52:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 00:52:43 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 00:52:43 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 00:52:30 -0700
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
Subject: [PATCH net-next 15/15] bnx2x: Remove setting of RX software timestamp
Date: Wed, 4 Sep 2024 10:49:22 +0300
Message-ID: <20240904074922.256275-16-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DS0PR12MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: cbefbeea-4261-4bdf-a760-08dcccb69298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hCTWrYRxgWtHuBFyoVOj+V4Hd4S5Y8qYOz3qYRq+WMgGJgDp22QkfuVvqtAX?=
 =?us-ascii?Q?YqvgBb0HvnKAQbFfI7pFYHoVZ6wycAKDb+y2qzHmfHsuOmUZli7FfZcMbJRM?=
 =?us-ascii?Q?AcgDVTuy+SKyKumZYnrCddPx9eboa/1FpjEO7xy8rN83l6Mg1BZhEUS7FdIC?=
 =?us-ascii?Q?MUA36dxxKuaJdePaH6tRzDB7rD/NhYaT5Rn8JHl4EQ7OPPFn0LFfnjtlkwTM?=
 =?us-ascii?Q?fSA898fyAPVKwIh/38sdR8NFp+4qMRMORzy7v+wHnModB/J9PoMQroY3HpN8?=
 =?us-ascii?Q?86zCebb5PXb3ykraD5Asw7i+Eb9VcXw8PcAPjKtDnuUOJaADDTbC5olQD4RX?=
 =?us-ascii?Q?kbc/1TCsI514tB+Urd4osUM4ngeTAyIfEcVnX4i0HwaDq2CZd3MI+8TFAPzG?=
 =?us-ascii?Q?pbwWlK6UU3NMOOVVSYNaePa6jx1Nlr8pz37JXMZRGklPh8g/RdsyZg5jOuh+?=
 =?us-ascii?Q?zAKIxRRI8qm72nWsriqKhWFDElxXHMINt+9wepuP4AuOyiGQ/z0FQtEjRx0/?=
 =?us-ascii?Q?FEHbO1nRId/Q3N0QmXNeQs0bkUzL3k5uNigs8xulzK6zZ8a9OOovA/zzjX3Y?=
 =?us-ascii?Q?sevYq9x//ZL0MJ1wlTiFzcKaljfOwwS3aLYH+E0XJkbu2oj+NO6yMy8G8qfH?=
 =?us-ascii?Q?s9YVlHdImync+L4lz7OzOGEHFU9FxhKu2bekDcuGakBYCJtRIiuUW2po4kVv?=
 =?us-ascii?Q?qbcS3qJZ3Sy2EeH7zhp0F83gdRyEmBfUqVoBb7slPzH7Mm9ECpMwayqu5Lgm?=
 =?us-ascii?Q?s90KtkHI/S6vC0TfmH9J0ajYK0l6C36S7YrvqVr897DeI73ogeD75HE3LVyy?=
 =?us-ascii?Q?mWaqVS7JXAYl5r9MrVLlFuCQGAD/ngz2dhvZqLVHC62wKLs/NMXr28HH6eeC?=
 =?us-ascii?Q?n8Tx18m45YAuuIpnImcQGEHxR+ODFC5cZ4cKNybBunSobPGNbzHY9A3FDoqR?=
 =?us-ascii?Q?FV3avYhV0OE6LLrGMZQZDSFITo42nH5R5bThQQgku/Wr1ag4g76HDvhYmurt?=
 =?us-ascii?Q?NbtG0JMEKqjKjA3eM7nT3JRdbFnIWn+hX4FxrugzG4DocPps/iybSNpI0ISn?=
 =?us-ascii?Q?rtexTD2QYALQVNEtC4BpADesCgj4NbJMii1zBDlvO/aP3lzOp1u4DUI+npOI?=
 =?us-ascii?Q?w59YA7CXF7l4yrqrXokEVbFfxstLJEsbNmwO8nbb5s3OpNHAPmY4YYVdIEns?=
 =?us-ascii?Q?df6jUuhCU0XPnwzk9w/6HzUTQhnxjGbg5zpn27ZjMjNbaSRVoCw1BG59h889?=
 =?us-ascii?Q?z5zX7kABaAXYUt9OZu19V7BZkFRwQAUaYTJGMq5iXZPOHExyj0OLZr1jTYnn?=
 =?us-ascii?Q?hvMhSpLjCpd/0R7OjHCH8Y1IG/TW8EBpoQxZ8EHqMYYH8ubXZmLybuH30Ad5?=
 =?us-ascii?Q?NoHcokmAObTDqQV8rJkEUXcZEBDSIjby5XVbRRJrPjugaFM5VLevJk5uRaQf?=
 =?us-ascii?Q?FKxMO52B4uxcWla1AG2pkTGAGaDb1qPA?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:52:49.4109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbefbeea-4261-4bdf-a760-08dcccb69298
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7828

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index c7b56a5e5425..adf7b6b94941 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -3640,16 +3640,12 @@ static int bnx2x_get_ts_info(struct net_device *dev,
 
 	if (bp->flags & PTP_SUPPORTED) {
 		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-					SOF_TIMESTAMPING_RX_SOFTWARE |
-					SOF_TIMESTAMPING_SOFTWARE |
 					SOF_TIMESTAMPING_TX_HARDWARE |
 					SOF_TIMESTAMPING_RX_HARDWARE |
 					SOF_TIMESTAMPING_RAW_HARDWARE;
 
 		if (bp->ptp_clock)
 			info->phc_index = ptp_clock_index(bp->ptp_clock);
-		else
-			info->phc_index = -1;
 
 		info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
 				   (1 << HWTSTAMP_FILTER_PTP_V1_L4_EVENT) |
-- 
2.40.1


