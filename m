Return-Path: <netdev+bounces-234310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0760C1F397
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606AF188CEE4
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C64D254848;
	Thu, 30 Oct 2025 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qbx1V0r/"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A85334C2B
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815642; cv=fail; b=qoGKwe00rC420ym31xvs+l8JTG3W01nTguqzGrNsKfYSYVz5Hf0tXz8opxIE3AZgM1gRNVuGhMIr0S7h2svmNOVgovaT/7bfdr3h/kvar93ybhldu5BKXOoASsO3W6/QJw/+pI8qP4spgj9sct3eFawy6h+/AOExhsUA/XRYZhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815642; c=relaxed/simple;
	bh=Q7cW3zWnBTLycD3fx8w+bB0rGTTEykIroVELDXX523g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hhbxXUt2N2HJSw9WM+fG3RvR5wmD6hjbGQhSQsOHOXhtyVHEaqqEAvv9+Tr88E2BskEGt+P3CjxOBbaoyf4cB1JbmoUyZDw9hZmkYy8bVWiTvCIK9irEN0+Y7WLunaxyAeOFSjJLjk7Lqz9sMm5C5jc2NtaK/55gEp3Z5WXV6ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qbx1V0r/; arc=fail smtp.client-ip=52.101.46.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xl2iE1luZ0zqBYWdAbXrSoNizR1WW3uVL7xU6AlnTRO6iw/mQg/dM/gsMyRYPYypi92i/W7+WplAXgzzqS9QrD9Uvs5olFXCRsNfxs0bbA7jLohkwNbTNKgIvh/P8NWHnp0rOWc28rT7cmUXHeXJce4yVIHSPu1XzGuYD+Y0u7oRUBM6f0tA3m8gpfet5amHqE7Hx0jtIgLeYfiEuL4ESzQACppdN4JEydxHda7gBeGDUOhlbnlLZFp5RXe2WZKK3TmLZry8PoFd7RAenBIBswdBeRFwT4RX/Kg1GDOLigd9wDWzBO0FEjr/gPwtr2MRWeHHNjGADjPI1uggIuMBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJkeaUpOOlIhtZt868zEikXig+Uhx1SVNMgJ5OJoyvg=;
 b=YPH6oHe/OuS0SBcb14QS+KwgOCJDCVtqr/D2rqnwHkNXaJTheJBdGFkE0XueJS4jCZWB9vlbfgzQlFhoF1kVqwb9Z14TFod/A3isNXs7o5y0L682mO629Ods6AGDJYpcdjxxVwvikG2loMx8xEJkm0b2/Wj4jDI8//heDr6zWgolkMFsnwTNKQJLhKeA4ZkESQeQpa3h9bAlAvni+at67iLMw3qxE2FLR+G2O5A9ClJU/UI36oKlQGgnsraFtfCOAn8y+7Nw29j7BYOeNhnktizfk0omfX6gj0HJ7AIGBQTVhPSGW+cl1NSpb4JM35dLytthAOBCoNJTYBTB/0X9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJkeaUpOOlIhtZt868zEikXig+Uhx1SVNMgJ5OJoyvg=;
 b=Qbx1V0r/sQRjqtHbAga5ZhqcljkweeMUAxsIJMADvPUaKDUrnlCVDMAyEMB71bAa204xxL1eGn2egiRXQ9kTuyFhVHnjCc8pVpTNwad4IguUYRu7x1RrdMRh8Kca7mFoIILdUkZpaa6CJo13ddaH2yj/5ZxHe0DEkyQqnMuNd5M=
Received: from MN2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:208:1a0::21)
 by DS2PR12MB9822.namprd12.prod.outlook.com (2603:10b6:8:2ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 09:13:56 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::74) by MN2PR07CA0011.outlook.office365.com
 (2603:10b6:208:1a0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Thu,
 30 Oct 2025 09:13:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 09:13:56 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 02:13:53 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH RESEND net-next v5 2/5] amd-xgbe: introduce support ethtool selftest
Date: Thu, 30 Oct 2025 14:43:33 +0530
Message-ID: <20251030091336.3496880-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DS2PR12MB9822:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e15722c-2f7a-49a8-29c9-08de1794a78e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D6ZcIrW0gXvANa5wqmKjIBJSNJkOX4V7ZZMJhpa0JHgK6QJ6o6NeXcX7fkYT?=
 =?us-ascii?Q?Yhn/85cvQR/JKTovHPATKsVGhecET78W39boMSjL2qZUsW9x33KclM+GbBS7?=
 =?us-ascii?Q?DJlfijrXegZ70BGPijY/S9SCmvxYlEr1/jlTojihlIh3/zK/bwwrrf8XXo39?=
 =?us-ascii?Q?Dg13d9QaSD4lnhJrfBgtAy9wdDhOUbyXSU2/mzDQLVNICR7bq6OdYTxJL2GC?=
 =?us-ascii?Q?WOelTH88/HWAmwUYf2rDMITSX/gx5E7RTalZiWGzisSGde3Q372hV3yeEEgc?=
 =?us-ascii?Q?s3tQYpmK2To3/K29D6uh48oKq//nDZeJmRQIqNn49krEAf/4CCRTlhr4a0Gr?=
 =?us-ascii?Q?lbAl78MBJI7sKziWl7fUydFFcJM5ZIQhLFQ9nmni4lZdbVtX4uqC8s95iMAK?=
 =?us-ascii?Q?O4IM1mOiAuY/whX8tA0JhD/GHjglTOYcReKtj0k8Ftx+4RgKRsqliQpUfEig?=
 =?us-ascii?Q?7HUUafsYtZIgNYXJTC2FU7fPrijTdOD02hDH7UrgYKu4wmSfhKT4ubx3jaQS?=
 =?us-ascii?Q?AM/eg6Nx+kYMzymK5Xd5BLmCIAbFQPv0qXt4hbHDsnkzWvVK9VEnP4cFAd/v?=
 =?us-ascii?Q?E5Ig1qIoUrNIKLEVm3y8DHo8A3waSnFaOP9oTpIXOP9zwWDCeWkKUXIJLJEv?=
 =?us-ascii?Q?UyJts07gONEjKOQ7byXFpKx78YHGaILouYcGdSWnKgTk37Wu8ga1AEZDY2XB?=
 =?us-ascii?Q?psrI5JSzC5Vf2pwmNfrzFVl26NZsVdQNJbdmrxjL5eWYIHub+SGfL1fMm0VC?=
 =?us-ascii?Q?OZNDvhi1uo16f/f9fUHY87yPYL8isUfbb+z6GuEbgSbKeHoy4NCWxEUCYxAn?=
 =?us-ascii?Q?SvLmJu1BYMyGkSav/WCEdiRi7UtDiyn6HKQqblJceTeLFQI3tEyphwtFA/XK?=
 =?us-ascii?Q?82XoxVVSbmW3PgkDdedmDIU745jHJnF2VWgWgShAqqNjHmyAMWtLFdpYqSB3?=
 =?us-ascii?Q?iTe2KkFcHKHpGto7c0kn8sJrzUYGHLR78S+mTS7YLRNFCZdf+ce4vsuJ4tDw?=
 =?us-ascii?Q?gUGVVQUdaycH0zK0X7oCL+r1CAEAy5Fu3E9LNRx3N4co2NonbvhBhwgGKU1V?=
 =?us-ascii?Q?h2zul3QtvKI7Qx4bmnfYiChecyhCwc8mVDoFxWpKYQSB8b0ByZvVm3G95+st?=
 =?us-ascii?Q?y6XCstMDMI3pXOyKSZFIn/XKrN/n9gCRQXLjJkMDCl+UegUzLNiO8L4INVYf?=
 =?us-ascii?Q?vHxcZwf13MHDJZVlBPvRQnIE1HaPJaCb0rCseYeSFYh5ALBGsm9GhumbCUYy?=
 =?us-ascii?Q?tdcPkTx5DHIYu4uTEae5YGjyMtIX16quC/Z79l7Rt1s7QiNjVweE6fl06IXP?=
 =?us-ascii?Q?8D9CC8TobZDp7LDZc+XXHuoDuTesZECpkPJE2E6dJX3saOiUq4qpkGNRTvQa?=
 =?us-ascii?Q?3MOmI2XvSpVSwodidmnH53lTDT36VIuoIYLg5eH2CkC331Fjh+hG2tTkUn0E?=
 =?us-ascii?Q?IWgwUEMTukjly4+5rcpNSvZlGbTYBUvsNjw8eJlYISNFN8SJVOjUo17JyLMw?=
 =?us-ascii?Q?9sgk5TPyCWJ57l8afOg+5fHlkZpn5l2FNTJJhWaExp0o1EUUQpAtPkrRDa4+?=
 =?us-ascii?Q?yNWsZuWsXQxCO1wG210=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:13:56.6457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e15722c-2f7a-49a8-29c9-08de1794a78e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9822

Add support for ethtool selftest for MAC loopback. This includes the
sanity check and helps in finding the misconfiguration of HW. Uses the
existing selftest infrastructure to create test packets.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
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
index 000000000000..2e9c8f5a68ca
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
+	struct iphdr *ih;
+	struct tcphdr *th;
+	struct udphdr *uh;
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


