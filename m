Return-Path: <netdev+bounces-123330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F6B9648D5
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643391F2189C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053E11AD5E6;
	Thu, 29 Aug 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fTotIStx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693281922F1
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942621; cv=fail; b=pfFFyIQGykCqghsqrZYtRfO/dWRugHK0/r/DsX5oweSjNVR8STugiOx8TEX7GFHBVT9uOyb9lzwy0I+cJhTEOIyIFNCWXk6Br+3gLP3fcT+lLQYK3q6Z6tzivvdaNPh104uhZ2n2FsQr01OU8+5wyEJQFwva8YR+HssO48IGaqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942621; c=relaxed/simple;
	bh=Ys8m9gZ6sA2Ku2UEyravFLz8ADsA3BBd5mQq5Uy90Yo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z038ieYUe5m4bPWsg11P2EVootCLmJSxfJ0E70a0bLkVWjtwDQqQy9lue7MJDC9JMoopRAdxWFmU6SGFgwf7AH7mSzKJeUfssixd35kq+Avx1UHtkO6CGKhsAbHPNtaVChwZRHTDU2VEDrGYNRDosmYVziDUYNN8mlg9lSARCDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fTotIStx; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kH/atzbZcwyTLgEYIo5AExdblixQcF27SNnOWNn7kz+Nq7EKLgP280V6LdhiRThF/8QzurrQIrbaloPB4uzDqyL+JqbCDFBaQyEw+3qW++1FzKLpDKYDsVXVPLTlQWAfZLLG2cFWyx2wv7GPPBGFmQFju660RSNAjtaenZeepnWu5/dYS9JrRr82yF1SC33WOaqtmDI51NY0Fn9o9NGwiyTRPtrihizE1hS2ju04UyxdyyipdGpxGsu5CRxhaGJt+LN+YAsoPSiiFbVBAcvaqXYlsIUAi7pgf4NXYxfIKU+s1ufQRvAlnYEgmhfhEnE6x2YSxt8/q1dYp4nAiefSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3Og62sQfKyraH9d8fODuEg8puYx4Xf2cJlfvEWg2I4=;
 b=UYoXZHWqID4PfI/idyN4nqBicMaOYwDqZQied5Z3yyW+Tk/nNXWh1mLekRYaDwLqMgppSm4xWnwUBlSIhATdbQJqhm+q3WLWHLSsRWVUOmEOpe4xzhRlgIhrop0BQIQkFxoiAU2gYux2zOvkfWYB9Wjns4Pd7UNThNv2hf6brrjvAQcEjvJqLKad5uMKCEJnOJVw9aAh7QAYu5caZCa/tnR68QAAl625xoMJBxBD0mh4MbAoncSTxumnHEcGg0RTRIWAb+hkIZEysbByOJwR7v4zvQgBViaNRzDWxQdElrER7C3/Qw32z6ntIpZuZZWGq8sG/sYvTBIDWtmVMCTQDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3Og62sQfKyraH9d8fODuEg8puYx4Xf2cJlfvEWg2I4=;
 b=fTotIStxjlPt5crwWRFmxkmxQ80kOYUr5wsKajA++bhPaEZSwuokjRzm6zECEan3YwHiexXkzLUltUQ//hjFmXvEyPwTN9j2QyrKEiuuJMUNsWzqEwpJU+e1ACmMxN8qIgz66j/0x8xZ5jUDstycBDt5X7rj2wXCRhqVg0pQyBigSCNK57rFVQ/VhS8aUUPtZ3uzZI1aSMGpnl7ulR5buJiGQzFOKzWUE6DMWGRjF2f4m+/XXyV+ZFLs5bzBSzcqJWzHpRb1wBoih8s5IjMaBnmcs60k6fGN8bZoQ6XpdfC4wFXUsiV/Mr9U8fE/DdYpcaNU98gDOLUFv8QsS+/j9g==
Received: from BN9PR03CA0868.namprd03.prod.outlook.com (2603:10b6:408:13d::33)
 by DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 14:43:35 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:13d:cafe::96) by BN9PR03CA0868.outlook.office365.com
 (2603:10b6:408:13d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23 via Frontend
 Transport; Thu, 29 Aug 2024 14:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.2 via Frontend Transport; Thu, 29 Aug 2024 14:43:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 07:43:20 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 29 Aug 2024 07:43:19 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 07:43:07 -0700
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
	<gal@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH net-next 1/2] ethtool: RX software timestamp for all
Date: Thu, 29 Aug 2024 17:42:52 +0300
Message-ID: <20240829144253.122215-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240829144253.122215-1-gal@nvidia.com>
References: <20240829144253.122215-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e2a516-c0fe-46e7-fb11-08dcc838f470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yWhZCe5F4DoAQR6xObrUGf0u5oRWpNRAT2CFSMR1P0UjHbptQ6t9x9hcX38N?=
 =?us-ascii?Q?f875LqOv+f3KhlFPmuC1GcbuAKNFfvh0ghZHJUqiCqw9CBtjShxfTAKSIioc?=
 =?us-ascii?Q?yY55KiUKGXmGuJaNGkJb0e4O/l56kk8klLkFv8EKj48/lKD+A7uY4j+0fLN9?=
 =?us-ascii?Q?b94brm6Bq3qE6MT0j2pq4Z5evs5Lfd/mCEBO6oBkR3va/KgObKobxgrdUoh2?=
 =?us-ascii?Q?4yrAYNWnghXdHzkVT+icPuRBQ/LpG9MGChyDrKoBbjRyZbEjm4mkF6s87iVF?=
 =?us-ascii?Q?8VMwM9NtBKWin2JPk3Pqf7WaajC+23qjPtGBmKD2mze1t6G3JF+Vs4bZzenV?=
 =?us-ascii?Q?+jp1V2l+/lr8o4ze0a5HGED2UjLTEDKqg0CQRehfDfrx0/Oy1PFEl3FHQl3o?=
 =?us-ascii?Q?6BYkm8INmPPEA6Cp4Z426gIyIjgMQJsfOFbCxmWgG2orzYN77nQjYKXs+HuK?=
 =?us-ascii?Q?/K2zEhhDgSUxGzcQ62wfFvy47rfessRPkBh30YjLL3O0ucCfDJim/3wN/O6b?=
 =?us-ascii?Q?Mz0TYb8qgf+3X/m94pM2Ve3xzMmaFdpPC8+OW8AdngvK7xmo8IVJlJoItlXP?=
 =?us-ascii?Q?UbA74cZ4P9QmunqtiZaFzIRMplimhXTflOQBd0munfriPyIeCDkket0xMoiI?=
 =?us-ascii?Q?J1jkH6fRV/rD9JFtcjjZzF1fc4eGIEk0LaAsurWggiB7VhBZG8yegVe81Umn?=
 =?us-ascii?Q?0i3eMbFZkNBogCx9x9XS6+Yq3rrdmiNpR4f5vPjVCUJXlQvL8+XpRBS2i6iv?=
 =?us-ascii?Q?r/I5rQ/RYbjQ3Vzju9VNSBcTkL8Xmrxp9cK0+RiW6JZZsYG3QrthFOsxMeaA?=
 =?us-ascii?Q?NSVV/foUyxEFmk1a+PH5n0pR6KlKtvYxNB4OLfOt3Cyhn5rUI4cv7YhcYJnD?=
 =?us-ascii?Q?ggkqgdQDI0pgudxntTLjMvY+1KtuSjbd25G3n4jE1cYYpX1bzYkDk2kv9Vi/?=
 =?us-ascii?Q?bWDNN8eUHjN0uAVAfwLd7kGhvNuNrtMUVvZhwYOUtgUd7HWDhnsfc4IzYHLY?=
 =?us-ascii?Q?bUgTxE0867pMFGd0+ID5xXEQcW2Qb334EvUvAVQUQ6kV/WZlEIGrsQsq/Uj6?=
 =?us-ascii?Q?5bJTh0wirjAgYx91b8kjXlwq9n6ihwPLBmbbPmppIayHBaCaKMDpA/A8Svzf?=
 =?us-ascii?Q?CCj52oRKEfquu/l981V+SJwz49a2EPWDeA+z9VFy+ffMS8WfBYg/L74aLeN2?=
 =?us-ascii?Q?rVoemCTBqTzlEsapuMLpszuWctIESXQbhzRZzq/Lgd0CgeQZq9IdD42C44tF?=
 =?us-ascii?Q?oRNN7pZfFZ3NlAO/qzY9yevmHWXz+HkABhx3qBnj34V2YkMVsf9ty2yfxQNB?=
 =?us-ascii?Q?Ohl7BovtwjQPw+fCsQuWXnr88uWZhfn8QzZHP4sGz9TH7RI/ChKwKGPz9JgO?=
 =?us-ascii?Q?sg5F6dPGpVso3DZRDNUx5jFwtD0xptqAXymDGMk/Qn20ROGU8tmMqrAHjVGb?=
 =?us-ascii?Q?5lMJ3zRcNgtSCuZ4vFM7/Ci+FvqBHKy4?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 14:43:32.2817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e2a516-c0fe-46e7-fb11-08dcc838f470
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183

All devices support SOF_TIMESTAMPING_RX_SOFTWARE by virtue of
net_timestamp_check() being called in the device independent code.

Move the responsibility of reporting SOF_TIMESTAMPING_RX_SOFTWARE and
SOF_TIMESTAMPING_SOFTWARE, and setting PHC index to -1 to the core.
Device drivers no longer need to use them.

Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Link: https://lore.kernel.org/netdev/661550e348224_23a2b2294f7@willemb.c.googlers.com.notmuch/
Co-developed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 net/ethtool/common.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 7257ae272296..aa7010f97152 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -695,20 +695,21 @@ int __ethtool_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct phy_device *phydev = dev->phydev;
+	int err = 0;
 
 	memset(info, 0, sizeof(*info));
 	info->cmd = ETHTOOL_GET_TS_INFO;
-
-	if (phy_is_default_hwtstamp(phydev) && phy_has_tsinfo(phydev))
-		return phy_ts_info(phydev, info);
-	if (ops->get_ts_info)
-		return ops->get_ts_info(dev, info);
-
-	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE;
 	info->phc_index = -1;
 
-	return 0;
+	if (phy_is_default_hwtstamp(phydev) && phy_has_tsinfo(phydev))
+		err = phy_ts_info(phydev, info);
+	else if (ops->get_ts_info)
+		err = ops->get_ts_info(dev, info);
+
+	info->so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE |
+				 SOF_TIMESTAMPING_SOFTWARE;
+
+	return err;
 }
 
 int ethtool_get_phc_vclocks(struct net_device *dev, int **vclock_index)
-- 
2.40.1


