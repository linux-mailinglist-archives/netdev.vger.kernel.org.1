Return-Path: <netdev+bounces-133447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB37995F0A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 07:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3BF285507
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 05:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00071174EE4;
	Wed,  9 Oct 2024 05:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ijA5P0qo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A9165EEB;
	Wed,  9 Oct 2024 05:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728452410; cv=fail; b=jd9Shp42gNj0PFfZSy/MPlrcNWjoCRMrZgwtudjSto9Zt9Gc6Jsn5dj8IkTRIVV0qErtnpLUskaCzWlLdyhpY5dIG3SF1zDIaiIf/4PkuBf6BcCYIZnjPsh+foGGGtKxIwbSUYNsKQPPinchk5LNY5q2JSt2HtCiniFHt27xoI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728452410; c=relaxed/simple;
	bh=WqfctBRBJilP0uPg5lYNnPHdmKKv7igchR+qiZ11xSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbspzYXjm/q4tSJ4W1AIJcvXV91Lzm5uAqO2DYhTpb+RqA1wYQ/J3CC7mAbfpDI0UVxryZ7+w7cXe+jhma408Zsf07YQjvgHCj3FtaJTG4wFkMy6bf4cv8FPpDTPKNBcwjBunMnGZOouH5rzeWtb+h+vNKwwcYv//hvC4ngXG2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ijA5P0qo; arc=fail smtp.client-ip=40.107.212.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCntHa5Uxr8MsOryitObLr8sej90VuE3yAT+17stsTsn6BjXSNYHgyhaEQPGPVpvgWdxoUFvBPqYDhk4QXoYqV85F3pcUv1PRcNiQIx/ylrdxZfOxfxxM+yBcLgZIWY3oUIq7IkYbACi5H6DH0PBf+ELQY8NJdMW1oHtIN9VVB/qfaumeDQs5C6gueue8ZPug2iC96cy6s48DN9w8a3UnCCvOlNpP4VAdZmxlSfew2+1MacFMngdAo+yQ5IDlZQQ3abL0QlsJkojK+uR8le52jiaHj/7Ccu01AAjVfx9Ouh+IOhj+Ef4j2UuEe8SI40XFRbRRVljy9TTRpg2KcLZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnpehRx/yk3mgrlICWQnVmzr1NhxIJgFgUTKo1tYWtI=;
 b=GS8USWsXqgWtG5esh6yz1zsMptebbB4nI0Wqsc24IkdCg9M8AzwwOLt6ndCKBsQZDeSQwrm1dnJYdYh4h8v6kmRj03pzA5a3+mTWxVT1KTGJy63M3/xSuRbY8Q7+egPwaobLLGO/l/zy0i+a30A7O0UghQ6Zf3qvZxgJfyqvlbhqZ381b4XOIMGrpy1cBrPoxf6kIOGiPNKPOMLEulU0ESOGPXeaGPc94jqAY+EgRCQqUyZXFe8eQ2BmG611AYBcFwM497bmuxzaM8XUXoWYIeLNK+Jl2VGfq+2DAvODtPgJl3JzU5+MlkWSoJu3MA6BIokuwS3k25DDfxKKqGR27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnpehRx/yk3mgrlICWQnVmzr1NhxIJgFgUTKo1tYWtI=;
 b=ijA5P0qoFpBB6c8faPgqZaLed9kf5oTXsLRxqA37bm4fOGCytzK7l74Ntav6ERHcgoasiylFXZyyafhbZmq0unXP6dVE5KM535e2MZJ3TYMkbnUylcCgy/lqI+AKP19oI86G+DUlgmBNm9Ml6/qsnzIwG/ATU7i1PN/aV9bXSa8=
Received: from BY3PR10CA0004.namprd10.prod.outlook.com (2603:10b6:a03:255::9)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 05:40:04 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::6c) by BY3PR10CA0004.outlook.office365.com
 (2603:10b6:a03:255::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Wed, 9 Oct 2024 05:40:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 05:40:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 00:40:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 00:40:01 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 00:39:57 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [RFC PATCH net-next 2/5] net: macb: Add versal2 10GBE device support
Date: Wed, 9 Oct 2024 11:09:43 +0530
Message-ID: <20241009053946.3198805-3-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009053946.3198805-1-vineeth.karumanchi@amd.com>
References: <20241009053946.3198805-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: c1dfe126-4e2f-4218-c52c-08dce824d3ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VbuY1FBDfanYBPfiSoDGPPGLvGGfgsDMqCzw5I2jdpSRBtkHpaewZ9ccc6/Z?=
 =?us-ascii?Q?M/RBg20GHYdNWr8ZgZCdOiJ9T8RlgfWBLqWoT6QnRarsgorPvq1NUppDvj42?=
 =?us-ascii?Q?mJdU6N6mnFhchsh7DUygTxL0IJ0jdafklLke6ZJn9eTfaH60HB7AjkSLLKh9?=
 =?us-ascii?Q?9KLQyKURGPADcDEgd07H52QUorjHeOvLGSR3AjlVajKanLIWMf/+VXbBmGmt?=
 =?us-ascii?Q?kLpyyuVS+sfF2Wnh5mRfF753tEB67xYANSV7q1EhEM4cYL8SjjVfmGGBviO8?=
 =?us-ascii?Q?+eRvmJQ0EhVy3FQfqJAGhiNaoat6qV8Yb4XqJHPBRPFe9wRALBJCfnjVCwGb?=
 =?us-ascii?Q?QMTn/oS2Pg6CklkTe1OWnteZhbL4ZipfqhHhAG0jIsCRNFblbEzUYglzTDuW?=
 =?us-ascii?Q?TQtJeo7JoItKvvUUaMYXerkFHFp3TNbl4hrxrEx0byRxE4juZvJydjdHDUcD?=
 =?us-ascii?Q?KheyVGAtdBs5RzkdSiIMiMll433loIT9OyrL76Efq4rxCjZgy+qcYe/oVFs8?=
 =?us-ascii?Q?lxl3vIL911J8WRo4gHLsnk+Jfmw6EKd058nEREVGkMJjlz/CgoWhU0I79LzP?=
 =?us-ascii?Q?cVPQQoBEou5VxgqKdxOLC4bQHac4eAK61Kn1Z3B7b/pQNBa8Cvw20VCAWUzZ?=
 =?us-ascii?Q?aueDMWiBItHgvNyI+Uhf0dqTo9PLTj0CVPVva4l6f+Ma+GPv8xrNzK26dB9A?=
 =?us-ascii?Q?d6qyUL8Uq7pSnZTZGDJ31eg8nvoJ8lEFlg9z2/juqsF5SZgZtdoww4Odsgp2?=
 =?us-ascii?Q?MyC0Ju47HP5pMp5hnwm82d6u5D6FEpQMd40dh/ZwmXlRmL60Xp7aC8mZmQdy?=
 =?us-ascii?Q?Z9bcd/0H6i0g6nFfJ2k1bJ+qqsjns2dQ/9fTx09zjb2lZcY1+eyolXQ6gjCq?=
 =?us-ascii?Q?/x479xSpF8xjyHn7riphEI5TvG/vfZ9dO8D932M6/1AYNzDaMZqkcIrHd+Ia?=
 =?us-ascii?Q?t9Q/GClCp8zMgnXa/CtWA4iBxKMoXVZ5MDYY2PlrYsdxNUlzftEgQnVpi1Ek?=
 =?us-ascii?Q?Il8CwygygukocmQb/P9EKMs6motGBjfxZdrYlkVHdvsi/v0tr4+hOIL99UZy?=
 =?us-ascii?Q?QM7orekG1I5cITixGSYR7YIqGRZeei5f/KOYUEOKiLy50hLZnD7TnFzMzGt2?=
 =?us-ascii?Q?X3OGSyzayKcZ9l/hsiB2bRElCKlHsZM9C12qVHz+MhESydg6E9lbvhf/IOd/?=
 =?us-ascii?Q?5MvDRfIMLZEYDVvw6VU3I8rWU9eE+tRLeY6G/hCsdAQd3xHr7defEf4ci54s?=
 =?us-ascii?Q?gjiOMi0ges3vV7tNFDYfil2kbu03YxexaJurn6/WYfYMqRwSPe9y5e8B+nMO?=
 =?us-ascii?Q?qaJt4HK7MagkSJEiZIyY2s7hZdq5bDejWEFFk8YA40RUbn7o5rH6C81DIdsc?=
 =?us-ascii?Q?5DRWtp/2VIxYUpfz8A1bLFb0lKFW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 05:40:04.6274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dfe126-4e2f-4218-c52c-08dce824d3ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591

Add 10GBE high-speed Mac support, it supports 10G, 5G, 2.5G and 1G speeds.
10GBE high speed Mac is an extension of the current 1G Mac in versal,
inheriting all its current features.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 79db6cd01844..8f893f035289 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4951,6 +4951,16 @@ static const struct macb_config versal_config = {
 	.usrio = &macb_default_usrio,
 };
 
+static const struct macb_config versal2_10gbe_config = {
+	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
+		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH | MACB_CAPS_QUEUE_DISABLE,
+	.dma_burst_length = 16,
+	.clk_init = macb_clk_init,
+	.init = init_reset_optional,
+	.jumbo_max_len = 10240,
+	.usrio = &macb_default_usrio,
+};
+
 static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "cdns,at91sam9260-macb", .data = &at91sam9260_config },
 	{ .compatible = "cdns,macb" },
@@ -4974,6 +4984,7 @@ static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "xlnx,zynqmp-gem", .data = &zynqmp_config},
 	{ .compatible = "xlnx,zynq-gem", .data = &zynq_config },
 	{ .compatible = "xlnx,versal-gem", .data = &versal_config},
+	{ .compatible = "amd,versal2-10gbe", .data = &versal2_10gbe_config},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, macb_dt_ids);
-- 
2.34.1


