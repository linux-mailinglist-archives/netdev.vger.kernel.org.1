Return-Path: <netdev+bounces-229349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B3BBDAE9F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 20:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D700042617A
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 18:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F65308F2E;
	Tue, 14 Oct 2025 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lh0Y0Ubn"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16B2307AEB
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465524; cv=fail; b=Id60/4q9fk0bOdOBSrFPKT50Pklpd3DIXSX4ey8gToMtiqVqw1fcFhzG7Bj9zR7aE8kBh95H8tHIs2vRhJF0GV0X8DfLgQq3CYhICe7oYn0a/WKbpGe6YwiUEs4CsqtK1NOlElfbuza/2E7315GJKIiNO6XiyNmGGW05DuNVC80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465524; c=relaxed/simple;
	bh=i4uiXMxgGNk5JVLahkPkxcLgfYv71AtqAP7aMsJf7w0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OnpdKeZUuYJv1UtKqDWtS5dE6T5+lr097D8pVxoxcuEGPssSNCNbqzNIgjMPeropq4UEOsE5l8hyUGG+8PdYpLU0pTVymX19PjstLvv/snTGKeq9ISIQxx1McKAY9aMWcOzo4MTtEku0enzkrBpuGTeRnhxaPUICgN2U0fsl39M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lh0Y0Ubn; arc=fail smtp.client-ip=52.101.46.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcDXSIgeLEuZHsf1iUivWIbeZE3mOLSvk5JZRIXB8WSVsi2IYadQFy/r7YQOyqFvs6cK2Q2NdeqKhZiOS24hgajEUMTUH5f2vO/GHrg9ffK0SdPY7j24sEXZrWilcGuT6D8J5FoIX7un6H+wWC0fCHVpOLZnoRpogUaEU/2MncGFqjDc0Rt0H/71EHAt48pOTpvsW7TOny6mxpNo296kqV7EsKKQ+REkmrgqP24jo+J15mFrGoVCtqrAB0fp/RpxGfuLxEGE0KXa5rYN4+/oQW9LUF5Ug/h6R5vW1DbjS9McRMuGwtibXAwoIgUlQCm2OD9vhKn9A83NkDe171oI3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eSgZm13HMKRcBO8EXMIDVqCWff1h6WjroBcmn0Ktr0=;
 b=ciA6/CgQO18FweLaugeAHQU+gmP4DvJ8Jvf+PxbEsjRWcFdX1X18SUxS0ytlOQJOrHh6ZOUwbMyOsigy2lOcd3quiVzVYca/XNP4L7vJ+ZTP36CQdesNmFKJprI6sJRPf6ixQs/U1SNPTcQH85cZWNxMcoJKrMOrWjWcLg60B0bls0jarIPfO/fwHcAvb/qvx4fPrWTslQIP5Hc6j+K3xTWiYAvX2t2wU2FBeacqZVGKX6JaGuPX9QsR37wCNhlPOvgHfi3OGEFm3sN8harX+PckXyYsMSxIErGNUu5sPTp+ERkQlgEXkUD8reKYVqZpGJke4JELvMr1aP7IVxlxMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eSgZm13HMKRcBO8EXMIDVqCWff1h6WjroBcmn0Ktr0=;
 b=Lh0Y0UbnrzzdAOOaXJN99l2+BtzQ/bn9MNuoPnjS2dV6+EeoU9UNDJ/t1Uor3Fhe9pReyehjtmGFD6wfSzaB4DRjTtyBmYRl67ZbYInuxUqrBYm9a0pZ6jVdx+j1CHu57+9SKmGhP+P5so0FUPogOwvLrVr7Ao1vu46LXfaJUo8=
Received: from SA0PR11CA0140.namprd11.prod.outlook.com (2603:10b6:806:131::25)
 by BL4PR12MB9507.namprd12.prod.outlook.com (2603:10b6:208:58d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 18:11:56 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::14) by SA0PR11CA0140.outlook.office365.com
 (2603:10b6:806:131::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Tue,
 14 Oct 2025 18:11:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 18:11:56 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 11:11:53 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next 1/4] amd-xgbe: introduce support ethtool selftest
Date: Tue, 14 Oct 2025 23:40:37 +0530
Message-ID: <20251014181040.2551144-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014181040.2551144-1-Raju.Rangoju@amd.com>
References: <20251014181040.2551144-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|BL4PR12MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: 371c1821-b738-4ebd-498f-08de0b4d291f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Us6bmLsT/bTp5//P7+LZtOrkRzzlsU2NN9c93ul+VZNlSnGKSvTYCVNk5qdR?=
 =?us-ascii?Q?0w3DfoApja3JgbANmclQtYwNKM9xo2TYEPM+5MqXKZeUKY/Cg6LHF9dEAACR?=
 =?us-ascii?Q?eSQuHvDccpdDCkczy7R7zGI/iVCw9BcoHKIodKNn5KvDHK3tgreUMV77Z/nG?=
 =?us-ascii?Q?4WyQk3SVLDOCc1dAk+37o//vblG7p64fCq9mMRoMzk1YVaBY50ihRt0H66qu?=
 =?us-ascii?Q?QmMf1okJWAkFNiYj92h0MP3G4KtdQyxC5J/DWfV57OlIbxQg3i+JqUXld/i4?=
 =?us-ascii?Q?7pe+BBrQsW8y0lGVYQrftHq+LzmB26/OkZ52TJFgFlnR/f8XJdC15wQRJ9Qx?=
 =?us-ascii?Q?1zU2teqDzG5CGwCSg2zOcnzs+9C0lx+jQMDxid+uPxh3CoMoZWpf45SR7huY?=
 =?us-ascii?Q?PLwHBgHx0kj+huLq52DkK4iZLs9iF5iIaQd374Fb6KZ96V9mhiWPdJbOTVkF?=
 =?us-ascii?Q?Zyuv8QKVLRxTlz64SFcTxX4O3M7mDfW7kMNB41yrelIBDbRjVvu5s9oWHZUv?=
 =?us-ascii?Q?sknyruBslTAvqCEfWH+vgNLHdrWOLE76RmJIhJwz6kyd06smOc5abTOIJw8p?=
 =?us-ascii?Q?mn10Lopw0ADGgRb1YON1IM2hDI4PycM7ANJkar/kiZNLpkQIrm+cs6U40OcG?=
 =?us-ascii?Q?y2tnR5mO6sbhX94E85omrAX+NnKzeMy3hPJKSBmLwY1c0HaGdZsaTY3yNSKp?=
 =?us-ascii?Q?KWMF6IPcOL6r6l9ZJswEKvW2oN34uHRfi/YvhqtyJf9xoL8KMPp0/mqLMlMg?=
 =?us-ascii?Q?/Nxr6pkH2K4wYhVIQ+9ARMOMs5rDyiUeSSoMWAuYUVc6+VPvBT5Hp24sdr+p?=
 =?us-ascii?Q?JXdg22Xdrgd6lIpLgT6SQfcOuJylL2KQ/nn9v79rCWpR0QggXmuowzqhVS1i?=
 =?us-ascii?Q?19cm48c7BImfJjlKpDSUnaS92cvLyxVqKfVSTEy7CDyCBPGEjhYhAccKrR2r?=
 =?us-ascii?Q?UcAJp1p4miWUvRiqdlBwX3fDm9CB3NujD8IyeHymNyWAbNAbCQxvoK1WtX2b?=
 =?us-ascii?Q?YxbgvfAjF0sXo0YgwsMu1ebxrxLgtSe0OmHkMQuTpGy1npj1LennF4n4PVpy?=
 =?us-ascii?Q?LMnsustzuZiyUGSumcQXOlODTBzZBCGyDypLY2AUqK6FtoD1lx0/XpCdZoHB?=
 =?us-ascii?Q?VMFq6RLVf19dKs2qkudR+k5PMf5U7fIEqrSooQNDBCTVyOY+p2PENPx6Y75G?=
 =?us-ascii?Q?oaQit7oAqQDWgKOa0o4UavCIdn1++fUMUU/k+bxx/Eii8hTUhvndWicw28+b?=
 =?us-ascii?Q?trhWPUl7JXZ0TOFdqImY2vBKdIDfBSqmEVJtn/GCuPLh5xU7Gp4M/zWCDpuA?=
 =?us-ascii?Q?FcWgD0ZjkDqXPsCszntpYxI2lhpy0Al3Quom8ZREX3IkCfChYK01R5s/Dj7P?=
 =?us-ascii?Q?DO77VICoFXsId+hYWFY7ck46YC1anBsrcVyCaucnlMqsgdDD5PAZuOjub6CS?=
 =?us-ascii?Q?bAZJ35UJsBY4jHCPPjwM/lDTIfmJcQrZutfR3mlJ9gd5I6DwDYLIhdLNm5O6?=
 =?us-ascii?Q?6sZKsSkPPvwiYJfO6Js/ZqtowE6/uO2U9wQ4zFpjq/wlMCQI5qZzNFRADAs1?=
 =?us-ascii?Q?pPXlVl5AAE1ZodKFs9w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 18:11:56.2834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 371c1821-b738-4ebd-498f-08de0b4d291f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9507

Add support for ethtool selftest for MAC loopback. This includes the
sanity check and helps in finding the misconfiguration of HW.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/Makefile        |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |   7 +
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 397 ++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h          |   5 +
 4 files changed, 410 insertions(+), 1 deletion(-)
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
index 000000000000..b8d1de07d570
--- /dev/null
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -0,0 +1,397 @@
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
+	ip_send_check(ih);
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
+		udp4_hwcsum(skb, ih->saddr, ih->daddr);
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
+		.name = "MAC Loopback               ",
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
+	for (i = 0; i < xgbe_selftest_get_count(pdata); i++) {
+		snprintf(p, ETH_GSTRING_LEN, "%2d. %.27s", i + 1,
+			 xgbe_selftests[i].name);
+		p += ETH_GSTRING_LEN;
+	}
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


