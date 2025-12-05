Return-Path: <netdev+bounces-243782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C8DCA776D
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 12:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E3F43028C15
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC8632C92E;
	Fri,  5 Dec 2025 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b3eNToie"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013021.outbound.protection.outlook.com [40.93.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BFE2FD1B9;
	Fri,  5 Dec 2025 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935593; cv=fail; b=TGl4hsYE3zUV1W1DqQgM3RnrvP2MwUxMX+TTa7n5hPMe0ldHDVozhgzXApEmxE0t2jhpyzIJutAMKrxHoRbubN67LDo7X9ggnIJE91rPZcccYmg/X6WFaUtI0gLxVYzMa7DrgRaN7APB6oUE0AEAY9+47MDOCLsiGH8JmLb0ZK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935593; c=relaxed/simple;
	bh=f16ezKmN/5k63RjgduZQ1yTNWQ0O2q2Nbki/5fZ+WRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIOzf0VHfZc4s1RyHhKb22VlZkZNwBBr3vjzKeu62pf5s0ElsE87KcFD4HxzzL+zaYJM3a8U2x/ZWEle5HCrtgn7e+naemaSXyDtpSz6dzyXCE813h1A+GTrNoZbj/xcYIdq4DTzNmoZH/F10aknziItstqw3DxeyqSri5t9zNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b3eNToie; arc=fail smtp.client-ip=40.93.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dD8HRu4kPtb/+r2BYTetPc343bPQcTNKflIMsNwHAxPHMX3wVOOXp2s0NZ5RLPvDtyxn9TZmItOKyQo/Hk8FVx07JngmXzuY+Gk7BcYASGL6Kj5VHf5FXL5nwCE9Qbhy48jAMzFVC1QbpvHfrWaNu0PqW7YW6rtjA/OGP449u2SrfwXxiLicfm9IYgieSoukF23teSCClFmCgAMIOzERDxvQkt9DzYuvrTcCv2d0l1uCWFSkuxa7bohWR97FcfZIOhgoHg5btgo+C+HCUxqeyg+gf8pDE0FVEw/TA0jqVoEQjbY/FL88EsKo3NrPJBU9uUML7SdM7daDSEu0VGPQMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xll8yKNcCnxzZs3ub6B5uXOUT6JYwtJzXxKt957pqo=;
 b=mf0EMWEDkxIYtL98wNaQKHOr5Aa0A0PG2joV+fUaM6dhdqdYWMCXSxBKMFlbDEeb5OfT3IN+4I0jL1AMH1vbWy/7u0ns357aABKLuByV5mZUlJKWQ6T99P9qszq7+NQndWOKxqb0Ht0GtnnBK3OqodWwUN1w2aoVT0Zrw8/muaqf1camHTFCwRbwJrJkpoin66uwtso0Q1N94Q95s+u2RQEKDtEmEcjMr99LeabcWoTM9E3VHAGAq5yuJov2hNJedUnauG/tBN4eKwlJ+swYZNxFSe/z4FimuKh3uqs0qE2z64s9ueU2RQuvCJQbRNtaHqXHVVvQq3H5mvmAgL8iqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xll8yKNcCnxzZs3ub6B5uXOUT6JYwtJzXxKt957pqo=;
 b=b3eNToiecqtQHCKO/Is6flIoJ0hQVMMdqW3EJIz9pqv3l1mwE8kzpzmKYmhQs9RU4CCQI0T7ppp2A95/nxbCkjZ2O01zg7E/+wA6zcdGKux8VfHeR8XTbxfXVuaqB2oqmv44PGnBj3crCFZHk0Z1JLuWWLfXxgBXRZjzCy0Xfaw=
Received: from SN1PR12CA0047.namprd12.prod.outlook.com (2603:10b6:802:20::18)
 by DM4PR12MB6206.namprd12.prod.outlook.com (2603:10b6:8:a7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.12; Fri, 5 Dec 2025 11:53:06 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:802:20:cafe::eb) by SN1PR12CA0047.outlook.office365.com
 (2603:10b6:802:20::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 11:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 11:53:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:05 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Dec
 2025 05:53:04 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:03 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>, "Alison
 Schofield" <alison.schofield@intel.com>
Subject: [PATCH v22 05/25] sfc: add cxl support
Date: Fri, 5 Dec 2025 11:52:28 +0000
Message-ID: <20251205115248.772945-6-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DM4PR12MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c759a09-e5b2-4214-bff7-08de33f4da1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ManUDiUR+VzXqWY+42ooJ1FA33XQWNGvfbECSCeN0jRBSuxwlpjreE0hUS2?=
 =?us-ascii?Q?BpmjA4YGypTN22RYPLjPqiNHsg+xG1bsKJ8DbQTo6T/TafYAH8nSbkrgTe6V?=
 =?us-ascii?Q?EY74PyglhXI/Aq9SMTCXYrbxYj5DxN3xbz1qHzrj10Yk4577Xfhe3dVDJI6G?=
 =?us-ascii?Q?+yAO5mjxOLp2AJd9f0aBKxHUIxjPWGqjBppzcZRHbMAAEZaBemmstbxssvJ0?=
 =?us-ascii?Q?ahohV6Xj4fqPMa5/mic+w8bqDovnd3sFtpW2gZTDaAHdyY7zSbxXGSG6HiJH?=
 =?us-ascii?Q?AvUZlh2NEM4KAipFYd8HkY6AjIy00eQXVcyu2/1InbXcoq5EjR1WmPrGeei2?=
 =?us-ascii?Q?CdtbTS98XtDoTczk4so/aaQVIHh/MMqeOK81jmB7LPL2hkY5c4FEkGvgzNAO?=
 =?us-ascii?Q?KheBwmtalWeOtOlM5QGN+DwpeiwjFUd8ui+iYZ5bIElaVL8XJvemnebGB5/A?=
 =?us-ascii?Q?83bo9Wx4r0EpVZXhgrWwS9DnTpS38FG3JW/eL34utRy8XriKgTnzxWDCEp3f?=
 =?us-ascii?Q?VMtdRJps5vhNIOSX7U89YRGvfwiJOTLt0DNx7Rcsbv+gQXx4aDIdz2vPUSe4?=
 =?us-ascii?Q?xsfd4WKb5hlqwJRPb3GGVdS536JCUhvx6FnJmxsjzbzjP2xHzL0CqMosIy0+?=
 =?us-ascii?Q?a1WJ+16lzlrXWGpQOzObLE9NfgcpyI9sVkySFrmN49MOT26QQ+GniLcqMhzU?=
 =?us-ascii?Q?yKvnK3A0Qh9HvFmUGi/xI9e3/wG8YXsCTu2FOoUwvdI3NhVyFqHMYO8VyVL2?=
 =?us-ascii?Q?enJi4n262EPB0kINice16FjHoCx8pRUUCMrDUv42Arm8rzqc07lvd+pPVKVL?=
 =?us-ascii?Q?P/cCBLdseA3UY83CFKjuIjIWbbrVo5QpnuFZw/Wx+cy6YH74utq5FHf8UZr9?=
 =?us-ascii?Q?QqPqUzQWe6qniqdvRcnQ8FujOODa2KZDx0U6DeZ0mFus3vx6cO8BCISY7lmz?=
 =?us-ascii?Q?Ri3pn2WfP9YIubQfB4Eq/sVY+21qLNiATpIuvDfaYLi9ePcNub4ooUdXhNXv?=
 =?us-ascii?Q?sRv6W+OYO0NxUvymhxuC2xdAejtf0ZAbjdbROY8W58UVLN4FLy5BZKZdnt/s?=
 =?us-ascii?Q?ImytqahymxpEvh5FyUfP/U+3TK+oLJfBTW75JHPZcrpLwBv6+d/0WKokDoke?=
 =?us-ascii?Q?1QLhLEF/7L4PdQBZLvB0bO82JjZyigpN9Z1czwW9kM4H4B7B2LE3iFY6j2J3?=
 =?us-ascii?Q?vCx0UAgmqkzAy5gy2JXv99XXyi89TS/AE1DGZ9tiTqbjF1cEW9POR5SnB9yC?=
 =?us-ascii?Q?s/ctyvUzcTtHWaEnqkydlqVF8ZpbDboPh4pMMaXSbOvWVN1j0i4nXn/NP3R7?=
 =?us-ascii?Q?Qyfiy+8sD3bjHgU/M6q+oyOCxqHnffCZe6UUp31tq6zGBY+FKgWEiCoFALAD?=
 =?us-ascii?Q?BlS5oRL4IKId+y70pXRyJhG1hij7bnmAOwohe41ygUvExzAYMvoResvzpmfg?=
 =?us-ascii?Q?z/DxVCQuSMm1H2gdoYLs6xjgnF1lnKrYYeI4yJZNQ9mdZZ25Nh8zOztPaPfQ?=
 =?us-ascii?Q?WIL5EG04jep80Ml0GlIqggev0Mrkn6irR91FRCPnoG8z/ZTwTdFV5c5oRKON?=
 =?us-ascii?Q?D5z4NKY8fof0xQFwzjM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:05.7092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c759a09-e5b2-4214-bff7-08de33f4da1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6206

From: Alejandro Lucero <alucerop@amd.com>

Add CXL initialization based on new CXL API for accel drivers and make
it dependent on kernel CXL configuration.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/Kconfig      |  9 +++++
 drivers/net/ethernet/sfc/Makefile     |  1 +
 drivers/net/ethernet/sfc/efx.c        | 15 ++++++-
 drivers/net/ethernet/sfc/efx_cxl.c    | 56 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    | 40 +++++++++++++++++++
 drivers/net/ethernet/sfc/net_driver.h | 10 +++++
 6 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h

diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index c4c43434f314..979f2801e2a8 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -66,6 +66,15 @@ config SFC_MCDI_LOGGING
 	  Driver-Interface) commands and responses, allowing debugging of
 	  driver/firmware interaction.  The tracing is actually enabled by
 	  a sysfs file 'mcdi_logging' under the PCI device.
+config SFC_CXL
+	bool "Solarflare SFC9100-family CXL support"
+	depends on SFC && CXL_BUS >= SFC
+	default SFC
+	help
+	  This enables SFC CXL support if the kernel is configuring CXL for
+	  using CTPIO with CXL.mem. The SFC device with CXL support and
+	  with a CXL-aware firmware can be used for minimizing latencies
+	  when sending through CTPIO.
 
 source "drivers/net/ethernet/sfc/falcon/Kconfig"
 source "drivers/net/ethernet/sfc/siena/Kconfig"
diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
index d99039ec468d..bb0f1891cde6 100644
--- a/drivers/net/ethernet/sfc/Makefile
+++ b/drivers/net/ethernet/sfc/Makefile
@@ -13,6 +13,7 @@ sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
                            mae.o tc.o tc_bindings.o tc_counters.o \
                            tc_encap_actions.o tc_conntrack.o
 
+sfc-$(CONFIG_SFC_CXL)	+= efx_cxl.o
 obj-$(CONFIG_SFC)	+= sfc.o
 
 obj-$(CONFIG_SFC_FALCON) += falcon/
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 112e55b98ed3..537668278375 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -34,6 +34,7 @@
 #include "selftest.h"
 #include "sriov.h"
 #include "efx_devlink.h"
+#include "efx_cxl.h"
 
 #include "mcdi_port_common.h"
 #include "mcdi_pcol.h"
@@ -981,12 +982,15 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
 	efx_pci_remove_main(efx);
 
 	efx_fini_io(efx);
+
+	probe_data = container_of(efx, struct efx_probe_data, efx);
+	efx_cxl_exit(probe_data);
+
 	pci_dbg(efx->pci_dev, "shutdown successful\n");
 
 	efx_fini_devlink_and_unlock(efx);
 	efx_fini_struct(efx);
 	free_netdev(efx->net_dev);
-	probe_data = container_of(efx, struct efx_probe_data, efx);
 	kfree(probe_data);
 };
 
@@ -1190,6 +1194,15 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 	if (rc)
 		goto fail2;
 
+	/* A successful cxl initialization implies a CXL region created to be
+	 * used for PIO buffers. If there is no CXL support, or initialization
+	 * fails, efx_cxl_pio_initialised will be false and legacy PIO buffers
+	 * defined at specific PCI BAR regions will be used.
+	 */
+	rc = efx_cxl_init(probe_data);
+	if (rc)
+		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
+
 	rc = efx_pci_probe_post_io(efx);
 	if (rc) {
 		/* On failure, retry once immediately.
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
new file mode 100644
index 000000000000..8e0481d8dced
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/****************************************************************************
+ *
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2025, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/pci.h>
+
+#include "net_driver.h"
+#include "efx_cxl.h"
+
+#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
+
+int efx_cxl_init(struct efx_probe_data *probe_data)
+{
+	struct efx_nic *efx = &probe_data->efx;
+	struct pci_dev *pci_dev = efx->pci_dev;
+	struct efx_cxl *cxl;
+	u16 dvsec;
+
+	probe_data->cxl_pio_initialised = false;
+
+	/* Is the device configured with and using CXL? */
+	if (!pcie_is_cxl(pci_dev))
+		return 0;
+
+	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec) {
+		pci_err(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability not found\n");
+		return 0;
+	}
+
+	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
+
+	/* Create a cxl_dev_state embedded in the cxl struct using cxl core api
+	 * specifying no mbox available.
+	 */
+	cxl = devm_cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
+					pci_dev->dev.id, dvsec, struct efx_cxl,
+					cxlds, false);
+
+	if (!cxl)
+		return -ENOMEM;
+
+	probe_data->cxl = cxl;
+
+	return 0;
+}
+
+void efx_cxl_exit(struct efx_probe_data *probe_data)
+{
+}
+
+MODULE_IMPORT_NS("CXL");
diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
new file mode 100644
index 000000000000..961639cef692
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/****************************************************************************
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2025, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#ifndef EFX_CXL_H
+#define EFX_CXL_H
+
+#ifdef CONFIG_SFC_CXL
+
+#include <cxl/cxl.h>
+
+struct cxl_root_decoder;
+struct cxl_port;
+struct cxl_endpoint_decoder;
+struct cxl_region;
+struct efx_probe_data;
+
+struct efx_cxl {
+	struct cxl_dev_state cxlds;
+	struct cxl_memdev *cxlmd;
+	struct cxl_root_decoder *cxlrd;
+	struct cxl_port *endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_region *efx_region;
+	void __iomem *ctpio_cxl;
+};
+
+int efx_cxl_init(struct efx_probe_data *probe_data);
+void efx_cxl_exit(struct efx_probe_data *probe_data);
+#else
+static inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
+static inline void efx_cxl_exit(struct efx_probe_data *probe_data) {}
+#endif
+#endif
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index b98c259f672d..3964b2c56609 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1197,14 +1197,24 @@ struct efx_nic {
 	atomic_t n_rx_noskb_drops;
 };
 
+#ifdef CONFIG_SFC_CXL
+struct efx_cxl;
+#endif
+
 /**
  * struct efx_probe_data - State after hardware probe
  * @pci_dev: The PCI device
  * @efx: Efx NIC details
+ * @cxl: details of related cxl objects
+ * @cxl_pio_initialised: cxl initialization outcome.
  */
 struct efx_probe_data {
 	struct pci_dev *pci_dev;
 	struct efx_nic efx;
+#ifdef CONFIG_SFC_CXL
+	struct efx_cxl *cxl;
+	bool cxl_pio_initialised;
+#endif
 };
 
 static inline struct efx_nic *efx_netdev_priv(struct net_device *dev)
-- 
2.34.1


