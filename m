Return-Path: <netdev+bounces-233457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C224C13A16
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 09:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C411887ADF
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 08:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A5B2D9498;
	Tue, 28 Oct 2025 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fYqfRDN+"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7202D9789
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641390; cv=fail; b=BT9mUlfGvL9Y6NA0VBsg9yiWqk1MX+EyLU8l3q4772OWK3FVWSbUICWORuDvKISgpr1FMcQSigLHdLoAfVp+vT3cB47sZhFee5ZJk7YOmBqxXrjP+pfjdUe0qG4lXCt/azVQCr7+F5y4URiX/pk9ZMPzjBlUK6+O+u3+xBlM2ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641390; c=relaxed/simple;
	bh=b0/8ibJs6uTEUBsSxrm31y6y3mxs7D5PM6TocUPYp7Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jL4ErUEWctxEMtHdlYma0KFghUCJvir1vRC1IYeMMag6LKGBoB6tlIjl8sHl+2IkapP4tEPLRjzdJFUJ1TK6AIyaJEZFXxJaBwKzUEcJJ79iT+k1yNR/Bjqz2oY6Y/BZBuvLoPXmK/oF10yMXqL1+OZWPkjo/soUXKBLjKFd0/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fYqfRDN+; arc=fail smtp.client-ip=52.101.46.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbVriMQBaJy6DlPrW65lKcKihUnfyR0WCYQLU7ou1u8NqRnGi4iRABi2CJ76yPDvxbK5j+nzz9y419qFGj92joHwia5J17OlKTiSNWPYCxgsmxOgBsm2VWm1PS4zv/ZNdbfJGQlzUY0gTpU3DCB5QOn9uc0v+mTYOtR8nisDD/hROwTEww2oZhuYC3X9Zs6xo0Aze0D0cIDwuu3l/y8KeWrP/exRd3NROQCyepIjXPWPuoZ+AA0bkzYeVzi2Qi2iC+aNVzLMkPXiS8Y08fkO/yF7IVbapM53oHEyyhCNMLo6LqZn2r+1CEP0zbU6hdUdjcUjHgGxVOI17cvG66wztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoIZFI0zVgWfVT6H1v3C8BFfpfx1P7nFEmIwSwwdr7c=;
 b=HkwRx9TJKrr8B9uYrEvjU5EQpUZNbRrAVQZHowodeIwz1EUgbuOMZ04DJDxVJjAIEjtNhtl88fT4KabqTo8QBHWjSAyNHxg2K5JtYVJzvLdEXZqUos+LRUaB6KQi48sanWAaKMtjVG7aUYNDimj5tfE23+wAmHHy8Qrx6c85Ivjwgg1kbH8EFw9oMYmeMDC91WGnmTxz4LMPUPDc05dfbUP1c8mQZg4CKjPpA3tERvHnJZ5GyN3xkKlcvqKWHjEgFCK0pBBFUwNL4CFLUSt6LprlBZkGslC61vJO50SFPSTITov1M9tzlKTgtMcPWoy5FpCkhY1Ac0RFxZPzDv583Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoIZFI0zVgWfVT6H1v3C8BFfpfx1P7nFEmIwSwwdr7c=;
 b=fYqfRDN+orcjgxIB3WPj++VhOSjyYxkQ5FXYGuSxM3mWfkPGx+Vx3gfQ/S/8lzIYQxYp/pXHTP80GknNvR3QOqdbDcSrhX/aEkcGXepa1lqSbd5L/9vr+13Jnzt6yeWKllC7U3+hUueSC92iULj12S4oM28yJfYLwgEd3K5Cgwk=
Received: from SJ0PR05CA0135.namprd05.prod.outlook.com (2603:10b6:a03:33d::20)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 08:49:43 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:a03:33d:cafe::5b) by SJ0PR05CA0135.outlook.office365.com
 (2603:10b6:a03:33d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 08:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Tue, 28 Oct 2025 08:49:42 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 01:49:39 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v4 2/5] amd-xgbe: introduce support ethtool selftest
Date: Tue, 28 Oct 2025 14:19:20 +0530
Message-ID: <20251028084923.1047010-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|IA1PR12MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b77107f-22d4-4814-fa14-08de15fef021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Oz4GIsXny4mvf5hyP76n+Pat01+yOD5Cl6MYdylTpYDVOeZytemwesLGEb2?=
 =?us-ascii?Q?RZSjbJeTpREr6wP855oToi5ZQ+LMdejaGd/liK1uI/OVWPoZs1eEgoRab5qS?=
 =?us-ascii?Q?uBtlkki1m7KDq+AkhWGyTBx49UakPkhGQOEvFhTluw2slhPjLdlOdaFUmd84?=
 =?us-ascii?Q?jv987FIf18e8M53eQHNzcu/uxqtia4HOpmQKsbGLoiD7KcnaamYaDUO9FXZM?=
 =?us-ascii?Q?1SHABrONes2Tw7Lg2M74nOGO749ByBCFRZJbmoTypPeZEbRfKNZXWm4pKLBE?=
 =?us-ascii?Q?l7Yw6zH6NNVq2HNN3hzeIsdgRhQnh/GCvBYXHOK9B+896ZAzd6RoYNRz/DUI?=
 =?us-ascii?Q?XeY/bxa67EpT+pmfD+qI2xV0WvWtYVZ5BGgxzG8EZ1bPv3g4K41qP4Bfcsl+?=
 =?us-ascii?Q?7k0kD/kM2z3UNuawlgard33ife7/uygBVG4Jh/EFiAXaMr5RLm5Ouegs4sE8?=
 =?us-ascii?Q?2pwkejr9nRswzMO4A0Q0g+3xbj3m8oaCaeuokavL6JFoLNXgAVV4ZVxVk2S/?=
 =?us-ascii?Q?tfdFvANhmNAEtBb1W3tQprRnZYRGXum3KPrF3qDRKhut4Y2UBzBAJKDwurSg?=
 =?us-ascii?Q?ptcX3QuEGXf0MBParQfy1poZ4l8ePm7fevdooBt1o9/LOyLm1RII7QGinwg1?=
 =?us-ascii?Q?xY1eKjthZ1qHLl6IHdCMJWpwdnEEOUICsJlGsT/3wOm8FGdVYaArC8u5B+6x?=
 =?us-ascii?Q?PPO1au0GAfQ+rKUHAT+XyHXqn32mkNsq7lzYFXxSYXDrnC9uYb2FHOSAos52?=
 =?us-ascii?Q?EdeTyD8CfrgOcLqT3mHFErI+469fz64+a+77h/W5xwCd9fG79ujiJC5S6NE3?=
 =?us-ascii?Q?7K6exhtzPi39YXqwhvMgYUwAezVKvyOGpkVUqsccws0J/kvJP+34TUYhHm4P?=
 =?us-ascii?Q?4pMfgMGroF/cdrYAjxu5JHoIXm7lYBySS+9sXsCRcb7ITcT9IiFiqSzBUChL?=
 =?us-ascii?Q?ovWHAU+EHzqrPsSuNVaQeDsN12iuPoU+ADmIixrddeT08t5MzBbcafLjHgXF?=
 =?us-ascii?Q?cEnoRm9okty9tUA6ZA18AtFIQYMDnoYW6YFqaUhxxw2Y+ZlYyT3emQGcv21V?=
 =?us-ascii?Q?eRXRuz0ETTAkM40fB7oA8WmAJny6PYdoGuKXVvR/UwblQ9cx2Bxh9/NSDI0x?=
 =?us-ascii?Q?cD2ontYrisb3g5+J1oso3y+YmUBK4a8GgVF1kFoRupfPl2TQWaHFsQcPu+xo?=
 =?us-ascii?Q?Ll2wJ4C+1BGIr+hwldmimxUHd3NyYg1D2SmfzcDoc4YDTsT0gENEMhXhoSk7?=
 =?us-ascii?Q?TqlXzzeIons1DvIB0Y9kSGO9eO1RGVvDLYiIM+86uYDrIhFAz+IRECrsQd9k?=
 =?us-ascii?Q?Tku5g8tfxzd+W7t7WNjBAcVE339HTPKr9xHCLEj0Dq5b8IIVMXzLPGrGQ55b?=
 =?us-ascii?Q?EnfdmPbzEm1ua9W6838YuYF9efbyvYqRW9we+UPLY3O6R+lfLGTdQuQ1Zijt?=
 =?us-ascii?Q?JYO27MbVspV1moJBth/yPIuIWbWV4IQGQBz0vbaPk6U1KP+1GvbHhoErZfsB?=
 =?us-ascii?Q?VO/51XOX1XZe1MdyoMJ9ikMMIeb+4UZP6u2S6mCzfsYkBNFBhw1TP8o0ANDg?=
 =?us-ascii?Q?WCYlbCG8jyg0xaNVp6s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 08:49:42.6486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b77107f-22d4-4814-fa14-08de15fef021
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063

Add support for ethtool selftest for MAC loopback. This includes the
sanity check and helps in finding the misconfiguration of HW. Use the
existing selftest infrastructure to create test packets.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v3:
 - reuse the existing selftest framework for packet creation
Changes since v2:
 - fix build warnings for xtensa arch
Changes since v1:
 - fix build warnings for s390 arch reported by kernel test robot

 drivers/net/ethernet/amd/Kconfig              |   1 +
 drivers/net/ethernet/amd/xgbe/Makefile        |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |   7 +
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 244 ++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h          |   5 +
 5 files changed, 258 insertions(+), 1 deletion(-)
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
index 000000000000..55b19d906c8f
--- /dev/null
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -0,0 +1,244 @@
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
+static int xgbe_config_mac_loopback(struct xgbe_prv_data *pdata, bool enable)
+{
+	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, LM, enable ? 1 : 0);
+	return 0;
+}
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
+			ret = xgbe_config_mac_loopback(pdata, true);
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
+			xgbe_config_mac_loopback(pdata, false);
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
+
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 381f72a33d1a..4b6001ccd6e4 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1322,6 +1322,11 @@ void xgbe_update_tstamp_time(struct xgbe_prv_data *pdata, unsigned int sec,
 int xgbe_pps_config(struct xgbe_prv_data *pdata, struct xgbe_pps_config *cfg,
 		    int index, bool on);
 
+void xgbe_selftest_run(struct net_device *dev,
+		       struct ethtool_test *etest, u64 *buf);
+void xgbe_selftest_get_strings(struct xgbe_prv_data *pdata, u8 *data);
+int xgbe_selftest_get_count(struct xgbe_prv_data *pdata);
+
 #ifdef CONFIG_DEBUG_FS
 void xgbe_debugfs_init(struct xgbe_prv_data *);
 void xgbe_debugfs_exit(struct xgbe_prv_data *);
-- 
2.34.1


