Return-Path: <netdev+bounces-234129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCACAC1CDFA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A9624E15F2
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8242B32D440;
	Wed, 29 Oct 2025 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HJOfBpFO"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD0F2F692B
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764545; cv=fail; b=ZwAvnW/m9ElkTdEVhUOAyUWlw5u2f4K3hs2JRU/QkqzxVMdIeoxeOQrmMghc2xiB7A/SMNmYF9o4DoBtTycpkh6l/AtQjV/zTyPK/MOxLJA65RicxMS6+nAG9aeMG+LsIW8NTfXGKY2PfswESiscWXUc5zwT2itFSokpCwxK4hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764545; c=relaxed/simple;
	bh=N3od4Wa5FLKL9cVbQ3zsJgGPQMki8+dVfj/mOMVlaQE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eYz3SJneEEPd1k47jtUGGrIq5PxjRu7Yyony0O5I4MFoHAw/JF/C0TuqB4q1v7cx00lnCyJbUww6eUgu7IB0XYd7UQc6cV+PmpBqEbB0C8ZX2quyEcyCsfKs+GFROIqAcO3j0yD5ctAp6hSqr6AQx8RvKYTU7zIQeiYXApDBXA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HJOfBpFO; arc=fail smtp.client-ip=52.101.85.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCsfVzawahoZFtCXyAWxd30OVPmxyKpyGqiPe0kUdP2xwFGpAtCETlA19tF4mTdE4b1NPWP18/bc6vUL6yO1WgphnIEelRGKkGEomU71NRs7ieTJu2a2osIdX9lmkMPODGLyuMyL9QF5cCPx1jDlupr7zQcT95mMuquJV6TkzkGAHNkqM6RyMAQSV6nUam4ZgGj0ONU920RjeHZodI+EPG/KPpuzOaKtQVCl8JoblkarYTcYB6LwPI5f8nXaroKnxNp3htNelemvblKRfUTx1H1nZoeJH9pDa95KrNN/R1rHG5QMVruYL3RpmudLEhKy+dYI7M9cIUY0wrV8L4S94g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APO+OsF6yzE2KClNIqeO7ZT2WaSEbW4mJTZYsioQ6X0=;
 b=WxIeflSkh7ZsNQvuJTCKleqLtw7PpBLvXv0zrvHwkySsomTGanKA1yqWvX4RZaIGnj/7c7e3MqXmFj5uvQdu5QNWHm6Tt44kJKtp4llNGL6luX9qppqFUFDYv2FJAfyFkMpvAyRaQE0Eu1ScUkn/0jOUJ8GHYkPsaApOSva/F2FgGhIk+flumNsa5kazI4EvLk/FAuWb8Gzdx6avYGL43QRCj4pPlQlW2mXU2cSoYykedsauy9wEDrAY/BTBvgqGCejGHWupaNqFexzftRDancQdp5/vHSws6q+vgRiIMJlzYSrQjjBsrQpXqUywz83Y+/Zu6CjM9hSN80MGmzTLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APO+OsF6yzE2KClNIqeO7ZT2WaSEbW4mJTZYsioQ6X0=;
 b=HJOfBpFOBBiBcA1YsKbzXgXFiGkxP5yO7U1UuoECqueXlXQ7J1BKQuRI7ZQMfkLqeouvdvSCsXywJou4jGswywIRxdwKzQgeomG13a9EQFOdWoKCDHPR/gXcpMwFoeSUYA9zCZ5p9iCITtPH7LlmV3AYd6su04MFFSDyCfTOAng=
Received: from CH5PR02CA0011.namprd02.prod.outlook.com (2603:10b6:610:1ed::28)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 19:02:19 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::be) by CH5PR02CA0011.outlook.office365.com
 (2603:10b6:610:1ed::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 19:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 19:02:19 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 12:01:40 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v5 2/5] amd-xgbe: introduce support ethtool selftest
Date: Thu, 30 Oct 2025 00:31:13 +0530
Message-ID: <20251029190116.3220985-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ad1ccb-6339-41c4-0de5-08de171daf49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O+Nrz0vt84BFsd/YGgdTaf4FBbCe9DWWC4hc3ouf7mOdYTh/TYgF54f3FMig?=
 =?us-ascii?Q?PQoxpRnozzQW7BXFWYyeYy4GjmVbLdFRJMMO7RWp0CPLlRxHvix63pZO6AAL?=
 =?us-ascii?Q?Rt+Ygd2dGdWjuueMRoARz+Hzv8JQqyzHJUEnzUd5aOGP8x0ARXiEVr/F+9dX?=
 =?us-ascii?Q?NsN3qAV2cksmFUM8bWBUBt7xjyYpere3NKfTp/6pZglfismL9yFM+EAYHNnT?=
 =?us-ascii?Q?lUEbd9Ft6tunCcME8xVO0ifzx57YN/Po6YS6h39ACFd8kBYazqwl8vLugtIs?=
 =?us-ascii?Q?DO487hm1rPZKg1OWi/QmBLNocIhThH3cGGnS/9vuGlSKNx4yhnW5qcOgGvar?=
 =?us-ascii?Q?nzplhyxlHvWcxvksBUqgwyZIjr+tubdOP8jzjXOiffDaHDLu1S2pSI7qb8Ek?=
 =?us-ascii?Q?c8Dbe12sDI086QqbbyTVHDylhtqOcDUwoIkIIaqam8p/dp8YrTgRl2w1HLbZ?=
 =?us-ascii?Q?bJr7fw6HrE/r7sdJ8Q1/HTmCFwAHsmvNAvPiJDHnhhBfpfkYlDaRGBsn4xJQ?=
 =?us-ascii?Q?28X6hqqf/i2qmpYFJQ9993D+PTCn9gir1783V2xq7QBONCZEhLMg8O/O4l/7?=
 =?us-ascii?Q?jbmql5C6uMVd+p5+I6quO4e4Go4g5vbSpYjgbgPcZzlqVl02U9u1ouwxQfUD?=
 =?us-ascii?Q?Og7Q6LJIo9CfVH7vl7uEGaRJboBN7IU0KnsZZswJN5Um/9Zfm7oFilk1PRDA?=
 =?us-ascii?Q?+zroc2dTsZeuyfD5c4hMO7gDLHxHpFbZcFFLEG5ORlJq9Swm/bWKZcyev8sB?=
 =?us-ascii?Q?VtcX14KWjxtfTFoXAeu+pk7xdUO8LUXAevE7mbjPiDXyec7JLUerBq4EtgFf?=
 =?us-ascii?Q?37SUoQYi0dFbJ5xH2gFvtcmmyvxGUCi0G8nZAK/1xlYCendT+bXqhALAYdZz?=
 =?us-ascii?Q?KI8fd7wwjrZmw2SVQJxZKFde9guucNmONHbQE+LsrwsTKh/KO+aHVdZFfe6q?=
 =?us-ascii?Q?O5+gglAp9Qzmg3BHuiK5UcttFinpem10z6fLIAHnTLqKVhN5KohKjCYt0X6p?=
 =?us-ascii?Q?puxzaMCnvs0MqNwh2bWZJhWuCzPsrHr/AYC1E0a2m9iFMe4ebj/3vWe504Rd?=
 =?us-ascii?Q?UK54NZhxQfHRHE6sjGJvHzB+ISRod6LtYHM+Be7rbDX9hoE7diKZ/jvWuxbq?=
 =?us-ascii?Q?huC4HsTsAXStoe9KyNPHqDqrZpoY8/iHMLJhBKavY0S0WpvwA9p75twFISea?=
 =?us-ascii?Q?7Jb0vnhnjkFgCGj5ja3nN53MTYXpdqtY9coAVPwSvxbUNjDz/BSMw7WOoOUL?=
 =?us-ascii?Q?6HuNij1yvHZ8P3p/pgZW3fe6AxmQvUkvlDtERP1jjOoxkewiDDhZySzpmde3?=
 =?us-ascii?Q?33O5VSP4JKMURuOqjMkh3GvwxOTkZ+5o7yuFqjcUQt9Z1RcLjd+MGCf1IWPZ?=
 =?us-ascii?Q?nGgAjPi8tykIrNW6PT8r222MmmnleC7e9uZEa7rBK9po/KOq7nSqdV/TKqq0?=
 =?us-ascii?Q?F/7vC0w4cNVUEZwUSnnLqmAvo46Y25WAnCQ3P9iFH9eHXb9XYkcZ/aUsxh1v?=
 =?us-ascii?Q?1wchd+fwWUVsNC/nw7n01i7B8OtyzWRx13gCf9DsadArc2ZTooOuJ9rdtR0s?=
 =?us-ascii?Q?Bl8uWXQj7FEBoHNZUM0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:02:19.4763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ad1ccb-6339-41c4-0de5-08de171daf49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915

Add support for ethtool selftest for MAC loopback. This includes the
sanity check and helps in finding the misconfiguration of HW. Use the
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


