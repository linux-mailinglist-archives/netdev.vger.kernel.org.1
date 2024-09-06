Return-Path: <netdev+bounces-125975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0588C96F74F
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B3E9B21C00
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656AE1CC8B7;
	Fri,  6 Sep 2024 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aB4n2yru"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8982E40E
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634095; cv=fail; b=hHkAKQo48jshHMFzVjlaMsHjQesnmfr6AD9PL2/ev8Byvvn+i5K+Ah9YQS8ZezRc8brnRiBLtxqDFuY1GdPXVMcEl/fVZyjIEBLgmHY4tHb+NtjHO58NcVOhQuVllWcV6HUzozSzqMBjaZTfyBf5GjN3p5rPbm7EDWOIP2+P3N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634095; c=relaxed/simple;
	bh=5Fbotf6LuiBSkKTdGltqfERaCkqAL+xZJIjGCDUG+5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dria8AsKcUAjgR/kIk9QXoQ6h+TnqlP9aey/7cedrqA+uflP6UzieHA4I9cIJ4mzXCRgFnAo7Dq81ClMs7YQcFB2Dumfleu9cOg38IdzHuqB0yLNdlh3OnOKv1SNE7bFa7lHN5SDbZWjgK3zUAT5eWL9VJm8F9NZ9HF7DW503Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aB4n2yru; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAgLYHfJF4RcFxbQsOUQQyKrpruLC5+IC37Pmvd4hjUs3Alur2kzs0of33SnkMJFE9xwf8UKBKXCchjBIfApB83VK2QUfZ25E4+55naWYoPO71j6p1xEuZUGIeDuBHp5hZL0tY7ZnU5fg5K8OKx6pMLkhOpQO1g45AdK+EXTjxd4bgPb4bjHKbVc5HT1Al6INoecv24HZYncIae3ajDUOI67ArNTpmqNw7dwvSBmfanP9lgAroIgi3uPZanZmNCrbGw00dJqwiMUipTaq9j21UPiUeFS/V+OGBym91DUsnNTGgzPHcZW/jXTNqp/+c5IsOi/yr6buDYdDtU7ts+UfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8zCldna8CPFCJfkITzphY3Nn7HzHCPlhhdl6VMvZsA=;
 b=g/DD4LEGf0Bzyr85nm2Nlw/yUHvBBbg50rd0DJRR1HT+a1ODmnAg4Z5RKwiOpyoatJd5jlXFi3SV4kcz+QSFtcuoqtBjTXc6djiB7wt9+ossjThXp6feUbjtZzRyx4KrYESs0BkHI4mQ08SuNRbFOdgwjMnS1j4AIZUlZxB03IuUV+Y8+xElkStF1KhHATPsdRutmK6my+M/z9ingOpw1lE6O8Lo1cBSzer/g2TXA5nB9jtHbjZ6JXN2Zf/ts6J11lYjGRKFPXdYsF8YPO6KHaRBHHbtGYf/N7E/AwnF0WExN1TSqjOTBtrQA4bRTtHzMH9exLyQn6fSbB8AY7B1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8zCldna8CPFCJfkITzphY3Nn7HzHCPlhhdl6VMvZsA=;
 b=aB4n2yru0O2MxJKsG6+Sawpls0WqdQPcGUTsVu6qWaTFhmBZIACfU8ZvnCpdqjIBIto8NxeEyO+SoY/QQa6osDyTFzPeZ1RgCCv19FF3DthEFJdypcD4mmjFxq+uoMtjO2MeyaRdg2vmOdwYHfv896KnUI3qP78+Aancg8Ho7Co6GaqITK/O6Hx8k+Q4Mj7zOeP7RDcU9DJuv4Nzgjff+QLRGa3VNPCDP07gehfa/iZKqORvl/AmohNM0BzIjJnR7rODWU+OFPjIf0G5z8QSL00ADSDwzSrp8AToeLD/sJqAzVmYJFxk7xaAo11e7Xpd+i4m5HDv6kdZ8UrQHp1QSg==
Received: from MW2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:907::31) by
 IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 14:48:02 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:907:0:cafe::48) by MW2PR16CA0018.outlook.office365.com
 (2603:10b6:907::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.18 via Frontend
 Transport; Fri, 6 Sep 2024 14:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 14:48:02 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:47:51 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:47:51 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 6 Sep
 2024 07:47:37 -0700
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
Subject: [PATCH net-next 06/16] liquidio: Remove setting of RX software timestamp
Date: Fri, 6 Sep 2024 17:46:22 +0300
Message-ID: <20240906144632.404651-7-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240906144632.404651-1-gal@nvidia.com>
References: <20240906144632.404651-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c1644c6-0734-4fdf-e40b-08dcce82e87c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sqNia8HXpNQzz8nNcBKGdJcfBFBuE9nZ0941vqkctW0CqNSvg8SHXXziQWJC?=
 =?us-ascii?Q?7vbPT4GG7kEEF8RSC24qhuCchL0L/dvP/kVSVGG4iaJiCCKgBuFn0ZsNodJW?=
 =?us-ascii?Q?gcxfhBymdhlesoPB8Bz1CqpOaFyDuq4qnZ8baWd5DWuLhIPzpC3et4aBGEDe?=
 =?us-ascii?Q?0bZe8EAKcaiI+rIfxBCB9mJTx4R8VMqMOUs8zrHulVCPQO3egYfAIyVO5pvD?=
 =?us-ascii?Q?g4gFcyl9uARe9/9pnieE+cQWF/N3pQlyQVNFZECug9dzmFCigz9C3dZmec/V?=
 =?us-ascii?Q?zTaKAArT49XSag/CQ48FLx56XBNXbQXV1wiTv84eqzk70zn/LiQr/HFNbA8B?=
 =?us-ascii?Q?GYG1lHZmh5K68Em7Cmm+436WqXLkZdd8FNt8qffM8RDdQxzQ8f72y7sS7iGw?=
 =?us-ascii?Q?7Aw51ZxfaZ4AIOJjKqDlQBA2Zi1oe7IJZI2ZYBUUfpYqJM3kVbP32Kn/GUgJ?=
 =?us-ascii?Q?DKb2wSBidJH+vUSDYRGAWInLChw/EmDlAK7ZIksdsEfn12SSh30xXv9yrVF7?=
 =?us-ascii?Q?nWhMviEKzjlHK9tAcaGVcTdHbKiv1kxpZGoa4d/WpToZDSBrA41AW2jdAJNx?=
 =?us-ascii?Q?AlGtBPRS4NGvR6ZfRqb0QJ3JN4fvHvdYZmN1l1YsFEPVF+Ogz5y2rX8S2mBK?=
 =?us-ascii?Q?BbNat1pssdp1bsnOKIyf+p6sm1A78IyrIosVWzH0GP65MI2kK/t7+KqKdw2r?=
 =?us-ascii?Q?BEG8bJFlwIAG4acP1BCTIYh/DrhqCr/38AQVl/5YRavJHwi+XLZOqZHk/Jd7?=
 =?us-ascii?Q?PDyj+lwQmQWxZIGA/TNpzEi9S702uVXjo5ck3GCJVdNS49XTV5AjakFPbuei?=
 =?us-ascii?Q?cqJNnUtGKEV7gnDKZya/1Fje6zqAed4QVCVBz7K1/RJR538gRBkY2d9cX7lR?=
 =?us-ascii?Q?S0t6YwkkKH/oBQfbdHpnDEV1EnXzNfPVWwKd+8CyBZIY7pjijaKEUeZabDrw?=
 =?us-ascii?Q?lpgCedgWusz2ETvFNVqJTIy96340qs15bxJXKkQgtOoL0XZ6WVnJPoRaZD/T?=
 =?us-ascii?Q?rvyIQWZfiFVnrZyTcT4gmdl7f8ZjsQGaOAsi5rZwUgyMfNX8u11ya9mu0v1T?=
 =?us-ascii?Q?v4sAWfKzEFel9+pzp1l0giB0ygBA1RatUxe3lb1fXBp8XPPyF45IP/L7K1vR?=
 =?us-ascii?Q?rkTxu+huFmEHvES6RRGB+HlD8vTytREm8KmCMNNVusVj1UQ3epSPWj5DCL7M?=
 =?us-ascii?Q?GCgHoTWDsgDDCwEBPVZ0hN6RpDrf7VDxsE4yHvy1rNemyjaC0iZq26jPoSwn?=
 =?us-ascii?Q?KGa8nnhSq/pByRZF9Kf3hBjITKb+4o209SaYNKzVLOC9lk/+PdIeji5ebCIH?=
 =?us-ascii?Q?8Q/XX9ENGndgRhPB37DwFX8oigKjavZ/KfS60c7/pxREKaXaaFRnPA7ZhwCF?=
 =?us-ascii?Q?H9nBJZUtB9zz7ujk6+h5hyyBXsMCPWpdkuqyQnjb2CInuu6TWU/3QFeW4J/o?=
 =?us-ascii?Q?54AsXrUT7p2ZD38OLhz1lLt30kd3ONUz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:48:02.0399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1644c6-0734-4fdf-e40b-08dcce82e87c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 .../net/ethernet/cavium/liquidio/lio_ethtool.c   | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
index 5835965dbc32..c849e2c871a9 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
@@ -2496,37 +2496,31 @@ static int lio_set_intr_coalesce(struct net_device *netdev,
 	return ret;
 }
 
+#ifdef PTP_HARDWARE_TIMESTAMPING
 static int lio_get_ts_info(struct net_device *netdev,
 			   struct kernel_ethtool_ts_info *info)
 {
 	struct lio *lio = GET_LIO(netdev);
 
 	info->so_timestamping =
-#ifdef PTP_HARDWARE_TIMESTAMPING
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE |
-		SOF_TIMESTAMPING_TX_SOFTWARE |
-#endif
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE;
+		SOF_TIMESTAMPING_TX_SOFTWARE;
 
 	if (lio->ptp_clock)
 		info->phc_index = ptp_clock_index(lio->ptp_clock);
-	else
-		info->phc_index = -1;
 
-#ifdef PTP_HARDWARE_TIMESTAMPING
 	info->tx_types = (1 << HWTSTAMP_TX_OFF) | (1 << HWTSTAMP_TX_ON);
 
 	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
 			   (1 << HWTSTAMP_FILTER_PTP_V1_L4_EVENT) |
 			   (1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
 			   (1 << HWTSTAMP_FILTER_PTP_V2_L4_EVENT);
-#endif
 
 	return 0;
 }
+#endif
 
 /* Return register dump len. */
 static int lio_get_regs_len(struct net_device *dev)
@@ -3146,7 +3140,9 @@ static const struct ethtool_ops lio_ethtool_ops = {
 	.set_coalesce		= lio_set_intr_coalesce,
 	.get_priv_flags		= lio_get_priv_flags,
 	.set_priv_flags		= lio_set_priv_flags,
+#ifdef PTP_HARDWARE_TIMESTAMPING
 	.get_ts_info		= lio_get_ts_info,
+#endif
 };
 
 static const struct ethtool_ops lio_vf_ethtool_ops = {
@@ -3169,7 +3165,9 @@ static const struct ethtool_ops lio_vf_ethtool_ops = {
 	.set_coalesce		= lio_set_intr_coalesce,
 	.get_priv_flags		= lio_get_priv_flags,
 	.set_priv_flags		= lio_set_priv_flags,
+#ifdef PTP_HARDWARE_TIMESTAMPING
 	.get_ts_info		= lio_get_ts_info,
+#endif
 };
 
 void liquidio_set_ethtool_ops(struct net_device *netdev)
-- 
2.40.1


