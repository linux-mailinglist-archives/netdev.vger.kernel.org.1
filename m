Return-Path: <netdev+bounces-230341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B10BE6C41
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04AC95E45DD
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB1A30FC2C;
	Fri, 17 Oct 2025 06:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bSHUylJO"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D91E1D6DDD
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683662; cv=fail; b=TOHU1v4/S5IsxeG8mR9KthF92sPD13Edu5YeyEGPSppmolzT7ZuWeRxDSPUqij1R3cXd0N4DPFUAz9eXrvjPdhFdA3QBJ8iU6jXVCAJiTeOl/nz9qaXbh1zL2tkTtSe/+my9dnzXpve1NtwZAGvyluC0tKXZ84FXuejzeqngTnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683662; c=relaxed/simple;
	bh=kg4wqGkzBcKIjjpIfH+5Be65Czk0mwjO0kk6FpfPbmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1H4JBpHWMeg0qR5mxhpeLRjGvNPqmjy1OHp9Rvm5NBbjgqCykC9M1bNQ00uCvBicQt/y6Tmqc4JDqFEkqlFanEHRICNN6VkM4ERm2ayY7WFY5eUPINARY7ox2PkwQWbbVMYtBVJRDMTceCBd+YyPU1tFG8QoTKIke0h9f21xZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bSHUylJO; arc=fail smtp.client-ip=52.101.48.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5uDm9hc1F/gqhVka0zp2XSfCSsaTZx1+EdKG0MI71CYKjWVoXRJna3kp0HYga4sisd1cmrkdWLLNKrXAp5pHfKKgpoFGmmnq6xrVJpCcV4BgEl/HtKCMiZ6nMf9QXhWNK07hCZbb1kfhzMimZS8SgwGR4ClTe7dOYuKFMy2LNt+vKak2UZudWK3svjyWWxdKMmm2u5EW9hKTIy97K9fpBnowH4QGPkSl03nBmxVMtBrH6c8qh5tVwbLvuCumKPeJNo0Ed6yDwyxSiTJ6O1+hjZJzL219ZQaFj/Cjxgf7tiy3wiudgLqePbN4FJ/nzkzU5PE2Cfbntzy3CEXSyPhFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qV8zzXXTQhbYpPHCXQZPQJlBIK8atGtMrMZwsKIEQf4=;
 b=k5EIdy9x+SLxr4Yzaww6QhOa2SoJtKifKOmim4BuF9MyaTahG9jwq9LZXoFweuYM0zcG5VL3AG7u9Mi7Gl5eSJBqAGxCh0aAyd8zn6SPtVA7Yjmdf+vYaCZhMixxTiOwrpNMkHT1RVyjxLsjYaJYJIS2vIYLDQ879JZ5IT+An029LRmCbuTnHaNw/YrwTauXfxFmQ9d8/8JNuonu+WsNxrd1kKLe+SuGfDGdQ1opn0PduEK/kI+YvThsucX7lLFz7dEZaFVWp76QnZ/cjTcJykbv/mmLJA/waLr9kZWNjM5LNXsVZ1ULJLFkyFfBFf9v1qSWwQJVnU3YyWJZimBdIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV8zzXXTQhbYpPHCXQZPQJlBIK8atGtMrMZwsKIEQf4=;
 b=bSHUylJOC+orav5SFSLz6MSmWXBp9UjCahfHDh2a5fdSqtFeWcTQji0Fhw+dsngIrimConaEgaQAxo/8mZ1mEnFtje+hUjUjSWBC1JKPRY04DbeS03fIfvQriyf+QShRjJm1iT8lEYFhR+jCmSlqSNW+kJ9Bm0qzoQWohzJ89UQ=
Received: from DM6PR17CA0015.namprd17.prod.outlook.com (2603:10b6:5:1b3::28)
 by MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 06:47:36 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::29) by DM6PR17CA0015.outlook.office365.com
 (2603:10b6:5:1b3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 06:47:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 06:47:35 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 23:47:25 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 1/4] amd-xgbe: introduce support ethtool selftest
Date: Fri, 17 Oct 2025 12:17:01 +0530
Message-ID: <20251017064704.3911798-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017064704.3911798-1-Raju.Rangoju@amd.com>
References: <20251017064704.3911798-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|MN0PR12MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b85f08-ddce-483f-e7f2-08de0d490e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IScgRdHY6ZwKF+7tW7tdilOu5MUZ72FTJBwIi9gZwBWZaju9+HwDaLfJYcLY?=
 =?us-ascii?Q?XeBbDfeyavOx9ME0kTNvloQIM/oNVCZOMq4FN0U09qV27MjbrCsQDouYS+lU?=
 =?us-ascii?Q?fy/DRa/zTU/smFtMJ6G/+Bjjddd5hdFANlYFSLn5kdYulQH3R/emTnIYQlR9?=
 =?us-ascii?Q?EXz3GtgIShKhEJOP3EHEQTRjG1saB8TaV4s9ryzV3kzinvBW/Vjg/2IaQD5i?=
 =?us-ascii?Q?D4LQf+cp4CYlZR8xSR3QieWNAITASqM2Ce8EMmkhEzVdpZRRjWnUwjalW7Ix?=
 =?us-ascii?Q?Y68drtmauF+KIU6ZhkwcZejE2zJIvvPZCDhLKA5lJDjbXX/cws9lT68Rr6zy?=
 =?us-ascii?Q?lvcu1LD6PrzwF0logunwSS45wW14reOFlcw0YuE0VtZZqP87Q9fI19hRFAPP?=
 =?us-ascii?Q?WD9fpbrQE/+gyRqQT0dfs7MzVcCGHey+pmOQXP1q6EvNQJ+cjjTkfi/RzfM2?=
 =?us-ascii?Q?U5aqnlGogRYwyFY5KMZ/0AfWlo4FafL1qS/AER4FLvjIyKx8GUeIz+UOrXHp?=
 =?us-ascii?Q?+s+Pjqy7io9XeuS4i2H4ZPmQLKuORaniN2uV66kk+sLS0a+1PEBToU9FcwWp?=
 =?us-ascii?Q?hV7NmUs2t6J48emqkbInPSX3Sq6CPTv5fVHWGZk2E9ENPzwBPyl6OmrPctBe?=
 =?us-ascii?Q?FXQzzCHOiaU8wjjGz3H1gKLyNxVKQWG56oTwn7lGEKcbm7l2un5wNwEnd+oa?=
 =?us-ascii?Q?aqp7jc3dsKNyeHEeGinGqAx01TiITlZfmGdZ7qwieDgzmiyG3uf7DHGBqFwW?=
 =?us-ascii?Q?zjm27/p5D8pH2k4YI3hehAMPZPE2XjVCy2MZ2E2xesCGWnK0nM9z60Y5yZvf?=
 =?us-ascii?Q?KscOqcRPoAYCCM+N9uJvpLMRMNoGq8Z+udXvStNaKmu+JUFEJgzQF4vXMrQY?=
 =?us-ascii?Q?v4eXlWtPD3QE7XzgM8nQfuzUIQG4WsW12FJ62yteX3cQHZz7x7YC4923sYF8?=
 =?us-ascii?Q?zch9kaSEsOcc5GANB8c4P7eHit0us5BZiBTvHJAAx7pWsH8pady9mOtAM301?=
 =?us-ascii?Q?W07shyzXC7Lo+UVwgS1HKmy9B4nq6hZCOaO7GOWSKTW+ho672dLcvzL2n7ru?=
 =?us-ascii?Q?6HnYiGpfMLZbamjEWe474XZdGNZ7ZnbYr+kbU2P8jmeO1nHcJNxTEMFi3WAS?=
 =?us-ascii?Q?8Qh+pkonz8YZtKmdHZ2TzgZQcexcaBys+kFoJhG6Vy7belpmGwmJ08rideXz?=
 =?us-ascii?Q?2LBnCv69cSBWcuBNpQrrJh/gW1U/6TE7oiZz4NDnAyKSycpoC8/kjqKx5O2S?=
 =?us-ascii?Q?JmI0Rlc2rzgPhEeQOTP4az+9W35tjKOLpgFzfDU1Uomzb08ED4f1NmPhdQq7?=
 =?us-ascii?Q?rG1xI+4qolu8ProOF3wcHTaCYQXmVwlY55SkkRVTVO/weBSgrHLoInjl8T6b?=
 =?us-ascii?Q?aSDGDD9ewbFd5qJ/b1sEfoU2Cx5D6Q1F11gsN3qiiN+juARwdDAfaFrs1cAO?=
 =?us-ascii?Q?eu4981wHC59nBWOY/jEdJP2e3jzHy50yGEGpO8nZyDt5a2EV4HIqIGHHNfE3?=
 =?us-ascii?Q?7uUdTyZroV8SPtr/HMWE8xofz9eOzHtfton+GYRXi+xx5xcOaSmkgCZnhMka?=
 =?us-ascii?Q?4TE5Jndo8Nt5WWxY7gw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 06:47:35.2210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b85f08-ddce-483f-e7f2-08de0d490e11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980

Add support for ethtool selftest for MAC loopback. This includes the
sanity check and helps in finding the misconfiguration of HW.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v1:
 - fix build warnings for s390 arch reported by kernel test robot

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
index 000000000000..5209222fb4de
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
+		snprintf(p, ETH_GSTRING_LEN, "%2d. %s", i + 1,
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


