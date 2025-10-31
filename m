Return-Path: <netdev+bounces-234622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8231AC24BFB
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A7CE4F40C9
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8367D3451B3;
	Fri, 31 Oct 2025 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OQ3GI1TP"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E653431F4
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909404; cv=fail; b=RQ1PGN2RcFDCZVdFbUNLJKvR3aBvklaGYYwVu8HCFhV5cVvuWNVJg/jk2wFkDBHMBnBm7e3zM0eTSz2w3jYLMgdH8r/n/3fOjgCqdtozO5JvXFJ+bs1MEtXpLc4hRIl1EMLn/WKJqKsVy64ZKsK4clTQdKrRmsHRHblLK622ZlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909404; c=relaxed/simple;
	bh=Oq3OgnPiInV8sCrAqlCJZEEu6lb/ww25x6hY7lr3I+w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GglqY4GcopiCj0xL1BJXRZzMRvXJZ2CM7zPpulttKBZZS5+LQ738JancP/Nazqg8rVbO9CCr0sDYDZkiJak0uq82qXqCV3zsFoHI/gskUIiW/uqnBkaknOmE2+wlf/HxKd007y3w1wNxjiU/DvVpZU1OEU029mDBnW0fgb7aMlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OQ3GI1TP; arc=fail smtp.client-ip=40.93.196.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8v1t3iOZtCCha2QyHWzzNrtdilSEXvbYT0JGv/GNlVTr9OETP7f7HWfpPATeuex3Xo9urqQPzpVMf+YIC4V+DQWIH73FgxBeX8ZGB54Phtarbx4kutM5Na1nYD1zB0QlnoUFr9/1uyX6sujBOMP7rFnlJmzdVvSHNEMQ1ky1B9mBKmKR5L+jj6z9zKAq7HEmGAFILrUMPqeTczIyQyms68955OYY2EiXdfk81YJRiXzYDcXN2sRXDVrKWzy5zbNnHQRSd1w6LKCdb9cAFvCpqcZrhR8Vpnb3aBWWdymyeHbGq7vdxALwtuXR4/ciQdwgqhhRCWg9k0+FTSmVjvVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMlK5u3H5BVnyNR3FBA84eUZj1uXSzhZZH8Qcx4kZ/0=;
 b=u2YQw/eTEGcoc45idZOE1MW9Ztxe/+PwV+fu/mwTb8bLVxYrr2/pPt/jC55k8xtKh70L1BIsn68YqIdJURjR+G5gIExuGIGyaLP5Dj2SOre4LDAJrve2bo01O1qRoKIqnonP2YqvKcGHgA9jluk4W6HMN1tF4anUlJ4hXsjlRGJjlPi4FwFlhUkEHc/zyK3rhvGXwCB/Wr6RjBcKdjbr3PyqlL1k3iJpGpg2Woyb6RD6raznjbdj3xYV0QEfBP2LnlZyaHi3ErLZi4CSumc9IwRWFgEnAdpEb96jNttcgtBcTCXeFpgo8/ytAMGqFEWvETVLSEevoN7SUVAqv34OVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMlK5u3H5BVnyNR3FBA84eUZj1uXSzhZZH8Qcx4kZ/0=;
 b=OQ3GI1TPA8IrR/qIn3AUy8t1EJgYzOqMqzwVeUvAqC5EaajXXyss5nMsj9wG4DYV3CPsFLt7EYF/sVl7S8l0th3QjU3hNcc4Whd9gpSr6nhoiZmxwxpxnTneS19aN5z2kXurdEn3A+GegyEUMqvga4S8ZtZ6p8k1is+HlTCWamQ=
Received: from BN0PR10CA0018.namprd10.prod.outlook.com (2603:10b6:408:143::29)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 11:16:37 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::12) by BN0PR10CA0018.outlook.office365.com
 (2603:10b6:408:143::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 11:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 11:16:37 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 31 Oct
 2025 04:16:33 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v6 2/5] amd-xgbe: introduce support ethtool selftest
Date: Fri, 31 Oct 2025 16:45:53 +0530
Message-ID: <20251031111555.774425-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251031111555.774425-1-Raju.Rangoju@amd.com>
References: <20251031111555.774425-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: b203880a-f4cc-4f4b-7085-08de186ef534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SDR7mqnOgvnzGvNBPuB5pSejvWTUy2Su3/08ylNiTJ7WZK3fwIfr20V8HEYr?=
 =?us-ascii?Q?Wzey4uPbqC4Y4+fciPPiHzqTzuVPz7K6WD8UKYCv8Xuf2bS1m4H7v4VdcK07?=
 =?us-ascii?Q?jXHwoNSjE/7A/P9gaLbD6mqrCJvB8J7aimJz1AIQkyFBYohQNy/GetrgmLhY?=
 =?us-ascii?Q?lTAt6OZvJvT4Q6p2hmyY/gNWtKfAWOvGNcbYv0phwaoyEGmFueUjmm1/rhRJ?=
 =?us-ascii?Q?X7YgH/DGh8bguUP6bDf4paIq/8IC0/DxXOB0fyIqZYqWXwfsm2f8Yjxr/Q/z?=
 =?us-ascii?Q?cHNQrbC0G3aI+CTzkAyfnN6GecIIvKsYvxuHkWYt9v69WwcfjhptxrBQVW59?=
 =?us-ascii?Q?FwxX2XDCR/AT6Sv6knLVLClrakyvzSNLiasr8gCwyfGQDUe13+C5jFrNUEak?=
 =?us-ascii?Q?rHZ2rRWgsR8PWAUHdz3VZ1ldvI/a2YvWz2JbMyeGvcqZ2GR62RZ79ORdO+Kb?=
 =?us-ascii?Q?M3Qb7QuwgYLyQklYtLY3OiFuukj0mqwtByhV/Jfqi/mCwTqkE/2UqVG9XVsD?=
 =?us-ascii?Q?Tb8gtowLx/e2VqHCIxUcLE7XFYDzKeZDo1A/zqTRmUwh9xj4piP3UBf4yIHf?=
 =?us-ascii?Q?VG0MsXSJ/YD+mKa5TNXgb5eZYSD/bOogpLFugcYIuwUw7LnUi9YVVgyTz9SM?=
 =?us-ascii?Q?mxx0aXq8BA8nOqqLSTxtKhmgBFvIRwCBkQn7oq03e+X9Iml5TzA8o+20TD7P?=
 =?us-ascii?Q?o7X9cqDbwAotD9PlmngkQHm1dxrMaxn1h+Wv9qkGOey074nA4+3MzuFLqiMR?=
 =?us-ascii?Q?pHGZp/veWpefhUYHXw6+LohjqVgNHk9UbbOcg/RLPAhkwSFroQt7eZLtiM1z?=
 =?us-ascii?Q?vkKcsIp005zhxWKkEw7xGmpJQ1GIFr8yMtIKLM1QsLIU+vaLeFtEeZ8JFuZC?=
 =?us-ascii?Q?JTnRg68hxnyWiJRRvzVLqMLGtnv0wwq9oitQAafDk3mfNf8W1A6FA3iHWUUJ?=
 =?us-ascii?Q?CuKiCdpjpZls1G2vD5XJpK1liHLU1zG5LPogeqPw8r9dfLrFuI8KLwaMGH2p?=
 =?us-ascii?Q?UzThH/fWlM6x+NQPDILJBJVTXVWdaomRTND98cXj1Cl0BiHlcZ5zOrsbG9w5?=
 =?us-ascii?Q?20tbeLRzx9fq6FEkGcLuBev+NVQ6AwgcACCWyuXUoMoEfpMcixUtZsBwDGA/?=
 =?us-ascii?Q?hvM/yOvnqy+K7v+30X+u9EbnVyTghqKJZrBevn8bmvM/dLuViGI7oxJNIF29?=
 =?us-ascii?Q?IWVlC7Ccp7Q+pHvpx7M6mt3mJRUFR5r4P8gIM5mIfGH/X7aDzYBwTwK6xRKN?=
 =?us-ascii?Q?dfb4bgzJUraWICunaNMMsfHdSAhsfjWZhYsWYc1PrBdYA9y0e3TTx5YIia+Z?=
 =?us-ascii?Q?0wbGF4wZseIt8zcXvPknJZGimtyM4tA5GK7DQIyDZKVh3aBZDd4v8p565/gC?=
 =?us-ascii?Q?2GQbzB/6nS6qjyK+ip94GXx+x0xYCeZS9hUpFK4vwa7CGB+RIgOKgH/1qMXs?=
 =?us-ascii?Q?+1nxYD222dobNIsHOv6rGds/GsgFYLQjiefWKAvxt68Kmc/In36mx5OgUrp9?=
 =?us-ascii?Q?LYMwUKVFLa6h4T3+PXQfSFvcswwInSzXpmR+7Qee2PicJhYFrQU9qTkIDdai?=
 =?us-ascii?Q?j80rfxHbpsiWGP6HoKU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 11:16:37.2087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b203880a-f4cc-4f4b-7085-08de186ef534
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404

Add support for ethtool selftest for MAC loopback. This includes the
sanity check and helps in finding the misconfiguration of HW. Uses the
existing selftest infrastructure to create test packets.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
Changes since v5:
 - follow reverse x-mas tree format
Changes since v4:
 - move the helper functions to appropriate file
Changes since v3:
 - reuse the existing selftest framework for packet creation
Changes since v2:
 - fix build warnings for xtensa arch
Changes since v1:
 - fix build warnings for s390 arch reported by kernel test robot

 drivers/net/ethernet/amd/Kconfig              |   1 +
 drivers/net/ethernet/amd/xgbe/Makefile        |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c      |  17 ++
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |   7 +
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 237 ++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  10 +
 6 files changed, 273 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c

diff --git a/drivers/net/ethernet/amd/Kconfig b/drivers/net/ethernet/amd/Kconfig
index b39c6f3e1eda..d54dca3074eb 100644
--- a/drivers/net/ethernet/amd/Kconfig
+++ b/drivers/net/ethernet/amd/Kconfig
@@ -165,6 +165,7 @@ config AMD_XGBE
 	select CRC32
 	select PHYLIB
 	select AMD_XGBE_HAVE_ECC if X86
+	select NET_SELFTESTS
 	help
 	  This driver supports the AMD 10GbE Ethernet device found on an
 	  AMD SoC.
diff --git a/drivers/net/ethernet/amd/xgbe/Makefile b/drivers/net/ethernet/amd/xgbe/Makefile
index 980e27652237..5992f7fd4d9b 100644
--- a/drivers/net/ethernet/amd/xgbe/Makefile
+++ b/drivers/net/ethernet/amd/xgbe/Makefile
@@ -5,7 +5,7 @@ amd-xgbe-objs := xgbe-main.o xgbe-drv.o xgbe-dev.o \
 		 xgbe-desc.o xgbe-ethtool.o xgbe-mdio.o \
 		 xgbe-hwtstamp.o xgbe-ptp.o xgbe-pps.o \
 		 xgbe-i2c.o xgbe-phy-v1.o xgbe-phy-v2.o \
-		 xgbe-platform.o
+		 xgbe-platform.o xgbe-selftest.o
 
 amd-xgbe-$(CONFIG_PCI) += xgbe-pci.o
 amd-xgbe-$(CONFIG_AMD_XGBE_DCB) += xgbe-dcb.o
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index e5391a2eca51..ffc7d83522c7 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -3578,3 +3578,20 @@ void xgbe_init_function_ptrs_dev(struct xgbe_hw_if *hw_if)
 
 	DBGPR("<--xgbe_init_function_ptrs\n");
 }
+
+int xgbe_enable_mac_loopback(struct xgbe_prv_data *pdata)
+{
+	/* Enable MAC loopback mode */
+	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, LM, 1);
+
+	/* Wait for loopback to stabilize */
+	usleep_range(10, 15);
+
+	return 0;
+}
+
+void xgbe_disable_mac_loopback(struct xgbe_prv_data *pdata)
+{
+	/* Disable MAC loopback mode */
+	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, LM, 0);
+}
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index b6e1b67a2d0e..0d19b09497a0 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -85,6 +85,9 @@ static void xgbe_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 	int i;
 
 	switch (stringset) {
+	case ETH_SS_TEST:
+		xgbe_selftest_get_strings(pdata, data);
+		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < XGBE_STATS_COUNT; i++)
 			ethtool_puts(&data, xgbe_gstring_stats[i].stat_string);
@@ -131,6 +134,9 @@ static int xgbe_get_sset_count(struct net_device *netdev, int stringset)
 	int ret;
 
 	switch (stringset) {
+	case ETH_SS_TEST:
+		ret = xgbe_selftest_get_count(pdata);
+		break;
 	case ETH_SS_STATS:
 		ret = XGBE_STATS_COUNT +
 		      (pdata->tx_ring_count * 2) +
@@ -760,6 +766,7 @@ static const struct ethtool_ops xgbe_ethtool_ops = {
 	.set_ringparam = xgbe_set_ringparam,
 	.get_channels = xgbe_get_channels,
 	.set_channels = xgbe_set_channels,
+	.self_test = xgbe_selftest_run,
 };
 
 const struct ethtool_ops *xgbe_get_ethtool_ops(void)
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
new file mode 100644
index 000000000000..8a3a6279584d
--- /dev/null
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
+/*
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
+ *
+ * Author: Raju Rangoju <Raju.Rangoju@amd.com>
+ */
+#include <linux/crc32.h>
+#include <linux/ip.h>
+#include <linux/udp.h>
+#include <net/tcp.h>
+#include <net/udp.h>
+#include <net/checksum.h>
+#include <net/selftests.h>
+
+#include "xgbe.h"
+#include "xgbe-common.h"
+
+#define XGBE_LOOPBACK_NONE	0
+#define XGBE_LOOPBACK_MAC	1
+
+struct xgbe_test {
+	char name[ETH_GSTRING_LEN];
+	int lb;
+	int (*fn)(struct xgbe_prv_data *pdata);
+};
+
+static u8 xgbe_test_id;
+
+static int xgbe_test_loopback_validate(struct sk_buff *skb,
+				       struct net_device *ndev,
+				       struct packet_type *pt,
+				       struct net_device *orig_ndev)
+{
+	struct net_test_priv *tdata = pt->af_packet_priv;
+	const unsigned char *dst = tdata->packet->dst;
+	const unsigned char *src = tdata->packet->src;
+	struct netsfhdr *hdr;
+	struct ethhdr *eh;
+	struct tcphdr *th;
+	struct udphdr *uh;
+	struct iphdr *ih;
+
+	skb = skb_unshare(skb, GFP_ATOMIC);
+	if (!skb)
+		goto out;
+
+	if (skb_linearize(skb))
+		goto out;
+
+	if (skb_headlen(skb) < (NET_TEST_PKT_SIZE - ETH_HLEN))
+		goto out;
+
+	eh = (struct ethhdr *)skb_mac_header(skb);
+	if (dst) {
+		if (!ether_addr_equal_unaligned(eh->h_dest, dst))
+			goto out;
+	}
+	if (src) {
+		if (!ether_addr_equal_unaligned(eh->h_source, src))
+			goto out;
+	}
+
+	ih = ip_hdr(skb);
+
+	if (tdata->packet->tcp) {
+		if (ih->protocol != IPPROTO_TCP)
+			goto out;
+
+		th = (struct tcphdr *)((u8 *)ih + 4 * ih->ihl);
+		if (th->dest != htons(tdata->packet->dport))
+			goto out;
+
+		hdr = (struct netsfhdr *)((u8 *)th + sizeof(*th));
+	} else {
+		if (ih->protocol != IPPROTO_UDP)
+			goto out;
+
+		uh = (struct udphdr *)((u8 *)ih + 4 * ih->ihl);
+		if (uh->dest != htons(tdata->packet->dport))
+			goto out;
+
+		hdr = (struct netsfhdr *)((u8 *)uh + sizeof(*uh));
+	}
+
+	if (hdr->magic != cpu_to_be64(NET_TEST_PKT_MAGIC))
+		goto out;
+	if (tdata->packet->id != hdr->id)
+		goto out;
+
+	tdata->ok = true;
+	complete(&tdata->comp);
+out:
+	kfree_skb(skb);
+	return 0;
+}
+
+static int __xgbe_test_loopback(struct xgbe_prv_data *pdata,
+				struct net_packet_attrs *attr)
+{
+	struct net_test_priv *tdata;
+	struct sk_buff *skb = NULL;
+	int ret = 0;
+
+	tdata = kzalloc(sizeof(*tdata), GFP_KERNEL);
+	if (!tdata)
+		return -ENOMEM;
+
+	tdata->ok = false;
+	init_completion(&tdata->comp);
+
+	tdata->pt.type = htons(ETH_P_IP);
+	tdata->pt.func = xgbe_test_loopback_validate;
+	tdata->pt.dev = pdata->netdev;
+	tdata->pt.af_packet_priv = tdata;
+	tdata->packet = attr;
+
+	dev_add_pack(&tdata->pt);
+
+	skb = net_test_get_skb(pdata->netdev, xgbe_test_id, attr);
+	if (!skb) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	xgbe_test_id++;
+	ret = dev_direct_xmit(skb, attr->queue_mapping);
+	if (ret)
+		goto cleanup;
+
+	if (!attr->timeout)
+		attr->timeout = NET_LB_TIMEOUT;
+
+	wait_for_completion_timeout(&tdata->comp, attr->timeout);
+	ret = tdata->ok ? 0 : -ETIMEDOUT;
+
+	if (ret)
+		netdev_err(pdata->netdev, "Response timedout: ret %d\n", ret);
+cleanup:
+	dev_remove_pack(&tdata->pt);
+	kfree(tdata);
+	return ret;
+}
+
+static int xgbe_test_mac_loopback(struct xgbe_prv_data *pdata)
+{
+	struct net_packet_attrs attr = {};
+
+	attr.dst = pdata->netdev->dev_addr;
+	return __xgbe_test_loopback(pdata, &attr);
+}
+
+static const struct xgbe_test xgbe_selftests[] = {
+	{
+		.name = "MAC Loopback   ",
+		.lb = XGBE_LOOPBACK_MAC,
+		.fn = xgbe_test_mac_loopback,
+	},
+};
+
+void xgbe_selftest_run(struct net_device *dev,
+		       struct ethtool_test *etest, u64 *buf)
+{
+	struct xgbe_prv_data *pdata = netdev_priv(dev);
+	int count = xgbe_selftest_get_count(pdata);
+	int i, ret;
+
+	memset(buf, 0, sizeof(*buf) * count);
+	xgbe_test_id = 0;
+
+	if (etest->flags != ETH_TEST_FL_OFFLINE) {
+		netdev_err(pdata->netdev, "Only offline tests are supported\n");
+		etest->flags |= ETH_TEST_FL_FAILED;
+		return;
+	} else if (!netif_carrier_ok(dev)) {
+		netdev_err(pdata->netdev,
+			   "Invalid link, cannot execute tests\n");
+		etest->flags |= ETH_TEST_FL_FAILED;
+		return;
+	}
+
+	/* Wait for queues drain */
+	msleep(200);
+
+	for (i = 0; i < count; i++) {
+		ret = 0;
+
+		switch (xgbe_selftests[i].lb) {
+		case XGBE_LOOPBACK_MAC:
+			ret = xgbe_enable_mac_loopback(pdata);
+			break;
+		case XGBE_LOOPBACK_NONE:
+			break;
+		default:
+			ret = -EOPNOTSUPP;
+			break;
+		}
+
+		/*
+		 * First tests will always be MAC / PHY loopback.
+		 * If any of them is not supported we abort earlier.
+		 */
+		if (ret) {
+			netdev_err(pdata->netdev, "Loopback not supported\n");
+			etest->flags |= ETH_TEST_FL_FAILED;
+			break;
+		}
+
+		ret = xgbe_selftests[i].fn(pdata);
+		if (ret && (ret != -EOPNOTSUPP))
+			etest->flags |= ETH_TEST_FL_FAILED;
+		buf[i] = ret;
+
+		switch (xgbe_selftests[i].lb) {
+		case XGBE_LOOPBACK_MAC:
+			xgbe_disable_mac_loopback(pdata);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+void xgbe_selftest_get_strings(struct xgbe_prv_data *pdata, u8 *data)
+{
+	u8 *p = data;
+	int i;
+
+	for (i = 0; i < xgbe_selftest_get_count(pdata); i++)
+		ethtool_puts(&p, xgbe_selftests[i].name);
+}
+
+int xgbe_selftest_get_count(struct xgbe_prv_data *pdata)
+{
+	return ARRAY_SIZE(xgbe_selftests);
+}
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 381f72a33d1a..dc03082c59aa 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1322,6 +1322,16 @@ void xgbe_update_tstamp_time(struct xgbe_prv_data *pdata, unsigned int sec,
 int xgbe_pps_config(struct xgbe_prv_data *pdata, struct xgbe_pps_config *cfg,
 		    int index, bool on);
 
+/* Selftest functions */
+void xgbe_selftest_run(struct net_device *dev,
+		       struct ethtool_test *etest, u64 *buf);
+void xgbe_selftest_get_strings(struct xgbe_prv_data *pdata, u8 *data);
+int xgbe_selftest_get_count(struct xgbe_prv_data *pdata);
+
+/* Loopback control */
+int xgbe_enable_mac_loopback(struct xgbe_prv_data *pdata);
+void xgbe_disable_mac_loopback(struct xgbe_prv_data *pdata);
+
 #ifdef CONFIG_DEBUG_FS
 void xgbe_debugfs_init(struct xgbe_prv_data *);
 void xgbe_debugfs_exit(struct xgbe_prv_data *);
-- 
2.34.1


