Return-Path: <netdev+bounces-230931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5175BF2129
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 17:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B9704F7F56
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E644258CFF;
	Mon, 20 Oct 2025 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qvkz/V/l"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010025.outbound.protection.outlook.com [52.101.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04D2258CF9
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973801; cv=fail; b=cad59FjuIRToKblXdhVkzv7jtsdqobf3v3gRjmxgA9ofTIe9omghCF2v9E2k0EfJ7ZCiN0TxljacUKbJPmAcLVqmIZyw+EUaFyIzJxsWd+AMzfoQtzVmu+KffwI2kJigRiOvwdvFJ+pKvAg0gXh9D/MHb3mfBjRIS7cj4eJA+fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973801; c=relaxed/simple;
	bh=LAaVTLJtrPja81updsm5EbbnW/oLvVx4mm5XmbzAFHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPiQEGLrbbq6zaKhj9zQE5baJpcYVS8teCFEHj7BRsJQGOnR5/BoisOSOCgGwfv7i6sv2W3WEwQ7Z2BXK913ojdnt6Vy9swo907we1K1khTFRfx0w1TydtwX0haKmqzrEIZ5YGxFld2pLrTHZrXkVEPycYVZsKaVQrzuVsUJm2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qvkz/V/l; arc=fail smtp.client-ip=52.101.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Of8mhwrbtfMhMLDVcZW6aJzZ/Z0MwkknlNBpCo62FyXGqOhjmsW5VrvvMD8dKgeKUou1u4FDrAIuiikpDla/TrAVT/S1q16dHsTNLbVCTvgZx5Y/3dkmom+HTSceapoYc8EECTBtFPFWB3RawjA9yCMbiWdgJ25nBF1pWkv4LQjYuxOM40/q6A4AXCxF8od0NZF/Ywqj/wsm/u4uFBs4urBqliYWcBY6kQZgHUHx5bIsATmIbYjzj+y6bMb/jV8PSYi5GF4fti3tYYPbvYzKr1rqfDcopaAj4L+qcIKoXZu+H4R+2KLa2vqiS2R/4FHx+ZO7LskrSfBitIdvh7Q/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rh4mGLPf/pLje/I72I29nxqxll9DFmd/vLLJx+U3oos=;
 b=m+bKzYDfcoQQUSvB5bDBxzDZLsDrF6zn5GpxRqGonEi5tDNEOpt3mLT0wFOrHrn6BZ44nw+fskbCxZPav1zGTSr4rMSUeCdCEv5RECVCAMjQfVnYsayua+yNO/P9da6dmOpUgAJdKLYSUX5cmQmT/k5VF1tVTOoN2rfKOxNTmxm5m5Fn4VPp+hffkArbhaFpq7fHltb5Mx8tQkgJ89oFjsw7BGHlgNB6qh0W9XYccwsjuxN3mcZ3s1EroewkWeQkT7FasQM2B1geEfelWRqDpdP0q+PFiimy0t1j+WEhv+9+1JIGTQHZBpp5MxGmENMPSUGE4t9B55lSZ4OVyXA1Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rh4mGLPf/pLje/I72I29nxqxll9DFmd/vLLJx+U3oos=;
 b=qvkz/V/laOxsXhvKaLVrwk1ZKv2xrVSbKnyOVUG75hfy0ZAEWUk3Egskd759NR0nf6sqKv5EOJUTanJEut84avziN0vbuqLmpAMLM7nacnsYcTQIV8No0VgtCTfz3cIQsbd/qHTEyzHQtSr5z5VsQ6Fg2V9VNKwLfrOl87CpPUE=
Received: from PH7PR02CA0014.namprd02.prod.outlook.com (2603:10b6:510:33d::34)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 15:23:16 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:510:33d:cafe::f3) by PH7PR02CA0014.outlook.office365.com
 (2603:10b6:510:33d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 15:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Mon, 20 Oct 2025 15:23:15 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 08:23:11 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v3 1/4] amd-xgbe: introduce support ethtool selftest
Date: Mon, 20 Oct 2025 20:52:25 +0530
Message-ID: <20251020152228.1670070-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020152228.1670070-1-Raju.Rangoju@amd.com>
References: <20251020152228.1670070-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0d8ab3-48f3-4f79-e5fd-08de0fec9750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K2z7NTUxPU9gWvMAUpFmRvZe5SoKyrZJxrc+2grGTs809iybeuBEEm3PB9oC?=
 =?us-ascii?Q?AvPNEYAEjsUgnotk5WbZ4MAGBdUAtO39Gnb+HcuR8YAU5W97VgjbGNdAzlkU?=
 =?us-ascii?Q?UXQmPWLdiRauuRqAP9vWCI9P6Vx7Hwb7kegvlba7L0swtklyXngDz2yZTNDC?=
 =?us-ascii?Q?vw9BfvcavDf9PlrXKFKebUOfr19xYxm7qPRDKEoVxfGk+Hlj3MRKPsJBnoo7?=
 =?us-ascii?Q?7GOYZ1EHlQ3aNo7BVy3l03mVtXgEyMYj1H+W9/jr+muE9yx9mS/8mX33QB0A?=
 =?us-ascii?Q?NCjsmG3I58XAwB3Q6yhG1+PtIMM7buikeY6+63Gru6sEk7qpipkxwUELACe4?=
 =?us-ascii?Q?Ei2zY7M44qV1FFrWZCVO1TxGmo9BBpJUq18bDreJqt0xFSygaAj9hvmiFIXN?=
 =?us-ascii?Q?waHK/S7oMrYy7SXKmQq7iGy902WU1mI5HMWCjSP3iY6g911Wy3HOrdZ5q7rc?=
 =?us-ascii?Q?kd09ezkS8/BvYq71s6AzEgAixczQXwTrExBBBlCpf7KNXk6c+gFuUy113f++?=
 =?us-ascii?Q?7fTYqvVD+H7V8ndxE4yJH3aiy6GSwcwZl8AT/bJq5N9UcNPsgW0oGOl+D04Z?=
 =?us-ascii?Q?3Kl8ZQX+sm7zHfUvaanpsTeOb59nzEDIfOqUfEcG+vlbQmQP5PJGm1kNaMxg?=
 =?us-ascii?Q?5A0vUUdF8n4s34hEcG4ivgF61lmsn1JaghQNJ1bF16FoI+uc2X3CZCDAkLZO?=
 =?us-ascii?Q?0IjO5lY0oRb0kVXOaORrLMMnCbcil3S2DHC74+3ze/FLYZlxj1KcxS1lol+R?=
 =?us-ascii?Q?1dXcwf7RpVHwfSiri8r7gWjedBnVh8I5TSxDa3kDbaZt7qF4CIDwWtxL96NP?=
 =?us-ascii?Q?Mrleix5iIyc5FOQVYyEAY/ytg9hS52wx2qQK0DJB+ABk2rYmX4UUVWPfyYJ/?=
 =?us-ascii?Q?PetFYnyIe+rXOXT/XP0vXJslQNxPgWeTcLfqYr5bHT+IMon+tYeWJ+b9lnl9?=
 =?us-ascii?Q?JufDipinezvWTE5U5FXZROJbrDYqxCcD9wREMLF+xE0gKk0Sv2gyJT3ctdna?=
 =?us-ascii?Q?QHqNz1L564FWxjo5D5HmZU2qpBzza4R2OE8sADpxInoiul8FgkMsuOtbTv8n?=
 =?us-ascii?Q?1CXXhvs6I3WSUA3cy8BCCYj/qyxtxRadeAs8r0MmLwN1Ez/tq9D3g+SDQml6?=
 =?us-ascii?Q?pNMuLnSdERCxmcfnJrPtsbb2TeUTWcNOeAOsbd7AY2r2kfjz3kSPGLgJDgwR?=
 =?us-ascii?Q?HV7wIJ2NuXb03cgKcj/13zpKSI7ws+73J7MaITnvWJENxzPx5Tgt6pZR4MtQ?=
 =?us-ascii?Q?yqZocNn6b+kHCnaLCz0Nuztoyl7eVOd3X0aEvUbyvca8K+mfbBdyayuHIbxB?=
 =?us-ascii?Q?0/9LodOGGO4Q6VzSz2ckQn0R7Zbodaa0YOgNvzvXEooummzRZt64w/a8lLOF?=
 =?us-ascii?Q?iyz8+FqcPiPN/MR3WRaPbFOgN1a1c8JrumhtFoF6Sg4+F5YuLUEB3Vu5DYln?=
 =?us-ascii?Q?G+zIYXo9XV9VOvAU5cpK1Lbhd4lomakZH98w2cOv4ZGevStqB0OGUAP4t2So?=
 =?us-ascii?Q?VHQ6dB1aRqLs82o/zMkfe3BjoHRx4+cHW/LTORfooIFt/OhY7toSn4C3flxC?=
 =?us-ascii?Q?M1ax0CEbVHmsF7snm+E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:23:15.7216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0d8ab3-48f3-4f79-e5fd-08de0fec9750
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228

Add support for ethtool selftest for MAC loopback. This includes the
sanity check and helps in finding the misconfiguration of HW.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v2:
 - fix build warnings for xtensa arch
Changes since v1:
 - fix build warnings for s390 arch reported by kernel test robot

 drivers/net/ethernet/amd/xgbe/Makefile        |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |   7 +
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 402 ++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h          |   5 +
 4 files changed, 415 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c

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
index 000000000000..54a08f5c4ed8
--- /dev/null
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -0,0 +1,402 @@
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
+
+#include "xgbe.h"
+#include "xgbe-common.h"
+
+#define XGBE_TEST_PKT_SIZE (sizeof(struct ethhdr) + \
+			    sizeof(struct iphdr) +  \
+			    sizeof(struct xgbe_hdr))
+
+#define XGBE_TEST_PKT_MAGIC	0xdeadbeefdeadfeedULL
+#define XGBE_LB_TIMEOUT	msecs_to_jiffies(200)
+
+#define XGBE_LOOPBACK_NONE	0
+#define XGBE_LOOPBACK_MAC	1
+
+struct xgbe_hdr {
+	__be32 version;
+	__be64 magic;
+	u8 id;
+} __packed;
+
+struct xgbe_pkt_attrs {
+	unsigned char *src;
+	const unsigned char *dst;
+	u32 ip_src;
+	u32 ip_dst;
+	int tcp;
+	int sport;
+	int dport;
+	int timeout;
+	int size;
+	int max_size;
+	u8 id;
+	u16 queue_mapping;
+	u64 timestamp;
+};
+
+struct xgbe_test_data {
+	struct xgbe_pkt_attrs *packet;
+	struct packet_type pt;
+	struct completion comp;
+	int ok;
+};
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
+static struct sk_buff *xgbe_test_get_skb(struct xgbe_prv_data *pdata,
+					 struct xgbe_pkt_attrs *attr)
+{
+	struct sk_buff *skb = NULL;
+	struct udphdr *uh = NULL;
+	struct tcphdr *th = NULL;
+	struct xgbe_hdr *hdr;
+	struct ethhdr *eh;
+	struct iphdr *ih;
+	int iplen, size;
+
+	size = attr->size + XGBE_TEST_PKT_SIZE;
+
+	if (attr->tcp)
+		size += sizeof(struct tcphdr);
+	else
+		size += sizeof(struct udphdr);
+
+	if (attr->max_size && attr->max_size > size)
+		size = attr->max_size;
+
+	skb = netdev_alloc_skb(pdata->netdev, size);
+	if (!skb)
+		return NULL;
+
+	prefetchw(skb->data);
+
+	eh = skb_push(skb, ETH_HLEN);
+	skb_reset_mac_header(skb);
+
+	skb_set_network_header(skb, skb->len);
+	ih = skb_put(skb, sizeof(*ih));
+
+	skb_set_transport_header(skb, skb->len);
+	if (attr->tcp)
+		th = skb_put(skb, sizeof(*th));
+	else
+		uh = skb_put(skb, sizeof(*uh));
+
+	eth_zero_addr(eh->h_source);
+	eth_zero_addr(eh->h_dest);
+	if (attr->src)
+		ether_addr_copy(eh->h_source, attr->src);
+	if (attr->dst)
+		ether_addr_copy(eh->h_dest, attr->dst);
+
+	eh->h_proto = htons(ETH_P_IP);
+
+	if (attr->tcp) {
+		th->source = htons(attr->sport);
+		th->dest = htons(attr->dport);
+		th->doff = sizeof(struct tcphdr) / 4;
+		th->check = 0;
+	} else {
+		uh->source = htons(attr->sport);
+		uh->dest = htons(attr->dport);
+		uh->len = htons(sizeof(*hdr) + sizeof(*uh) + attr->size);
+		if (attr->max_size)
+			uh->len = htons(attr->max_size -
+					  (sizeof(*ih) + sizeof(*eh)));
+		uh->check = 0;
+	}
+
+	ih->ihl = 5;
+	ih->ttl = 32;
+	ih->version = IPVERSION;
+	if (attr->tcp)
+		ih->protocol = IPPROTO_TCP;
+	else
+		ih->protocol = IPPROTO_UDP;
+	iplen = sizeof(*ih) + sizeof(*hdr) + attr->size;
+	if (attr->tcp)
+		iplen += sizeof(*th);
+	else
+		iplen += sizeof(*uh);
+
+	if (attr->max_size)
+		iplen = attr->max_size - sizeof(*eh);
+
+	ih->tot_len = htons(iplen);
+	ih->frag_off = 0;
+	ih->saddr = htonl(attr->ip_src);
+	ih->daddr = htonl(attr->ip_dst);
+	ih->tos = 0;
+	ih->id = 0;
+	ih->check = 0;
+	ih->check = ip_fast_csum((unsigned char *)ih, ih->ihl);
+
+	hdr = skb_put(skb, sizeof(*hdr));
+	hdr->version = 0;
+	hdr->magic = cpu_to_be64(XGBE_TEST_PKT_MAGIC);
+	attr->id = xgbe_test_id;
+	hdr->id = xgbe_test_id++;
+
+	if (attr->size)
+		skb_put(skb, attr->size);
+	if (attr->max_size && attr->max_size > skb->len)
+		skb_put(skb, attr->max_size - skb->len);
+
+	skb->csum = 0;
+	skb->ip_summed = CHECKSUM_PARTIAL;
+	if (attr->tcp) {
+		th->check = ~tcp_v4_check(skb->len, ih->saddr, ih->daddr, 0);
+		skb->csum_start = skb_transport_header(skb) - skb->head;
+		skb->csum_offset = offsetof(struct tcphdr, check);
+	} else {
+		uh->check = 0;
+		uh->check = csum_tcpudp_magic(ih->saddr, ih->daddr,
+					      skb->len, IPPROTO_UDP,
+					      csum_partial(uh, skb->len, 0));
+		if (uh->check == 0)
+			uh->check = CSUM_MANGLED_0;
+	}
+
+	skb->protocol = htons(ETH_P_IP);
+	skb->pkt_type = PACKET_HOST;
+	skb->dev = pdata->netdev;
+
+	if (attr->timestamp)
+		skb->tstamp = ns_to_ktime(attr->timestamp);
+
+	return skb;
+}
+
+static int xgbe_test_loopback_validate(struct sk_buff *skb,
+				       struct net_device *ndev,
+				       struct packet_type *pt,
+				       struct net_device *orig_ndev)
+{
+	struct xgbe_test_data *tdata = pt->af_packet_priv;
+	const unsigned char *dst = tdata->packet->dst;
+	unsigned char *src = tdata->packet->src;
+	struct xgbe_hdr *hdr;
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
+	if (skb_headlen(skb) < (XGBE_TEST_PKT_SIZE - ETH_HLEN))
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
+		hdr = (struct xgbe_hdr *)((u8 *)th + sizeof(*th));
+	} else {
+		if (ih->protocol != IPPROTO_UDP)
+			goto out;
+
+		uh = (struct udphdr *)((u8 *)ih + 4 * ih->ihl);
+		if (uh->dest != htons(tdata->packet->dport))
+			goto out;
+
+		hdr = (struct xgbe_hdr *)((u8 *)uh + sizeof(*uh));
+	}
+
+	if (hdr->magic != cpu_to_be64(XGBE_TEST_PKT_MAGIC))
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
+				struct xgbe_pkt_attrs *attr)
+{
+	struct xgbe_test_data *tdata;
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
+	skb = xgbe_test_get_skb(pdata, attr);
+	if (!skb) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	ret = dev_direct_xmit(skb, attr->queue_mapping);
+	if (ret)
+		goto cleanup;
+
+	if (!attr->timeout)
+		attr->timeout = XGBE_LB_TIMEOUT;
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
+	struct xgbe_pkt_attrs attr = {};
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
index e8bbb6805901..f4da4d834e0d 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1321,6 +1321,11 @@ void xgbe_update_tstamp_time(struct xgbe_prv_data *pdata, unsigned int sec,
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


