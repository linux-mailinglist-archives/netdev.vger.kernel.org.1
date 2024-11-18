Return-Path: <netdev+bounces-145939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4192F9D1592
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FEA1F2117E
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7B01C07DA;
	Mon, 18 Nov 2024 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1EXggiWX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867971B21A0;
	Mon, 18 Nov 2024 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948293; cv=fail; b=MLhYakMNu+LUG7i+l+l9GhMT5KlzflBSVqVVttM/RdKxmS832GYErqXtRbcDU1BoLvFlj7IATUJMKwTVm7BSDE/GDTozEaLoyJt2rC4bl0QD1pqUaReqRvquTFh+zoNEWaipXXkEMi1aFraQcVONjqsMFoJggL2s6Y/WK9jJ88E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948293; c=relaxed/simple;
	bh=0sYwz+JHrLWQ5FurmU8K7G/8MFpuLgz6QX9rmhIpZOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kB6FEplg53ln20xuyBHb8kqEjeUkmYpKrT81iaq272cGeD3pcsgD14goYTCBdMlnCHos3b2iEswQY3QMXjP3QwiTAVMZwuWjPprh+ibm7jCX0kNdk97Ds1EUl7sxB8rxRa1OyPCIPo96CxFzu4HqR9VRuto0tzLO91k9e5k2tsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1EXggiWX; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7J7U5cSmGF0qLWARi5yxbUm5+oS+BWkK/ptzJMkiZb+obCNfy4BTY3Ph/k90PHpof7AV88f4tpkJVUhfC/Fu+mT/Iv4CEbHpOCj9A8/K/ipJr5J04S3EW/uOS1BsbzuJEtcS4VlDScFK9EChAMlDJddYp/E/E3yr9+1b4YlexAFnQRNja2Jrhm9ey7qBK2lrDgVsPO57nOgn9yvbnxq9aURVtkbi006ioHxOed4TwbecR8cnYRmhnrd7roHctWeUUSxqRJmv2BhyyzHiCirE2Io6MtzjCk5s1Sz03Z4dljCf8Hcd094fjThXj7MEK8JuPEdggo2VtG0PrZeKX6bSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fxq/lDZXwSN9KhVcvG0CjNC7q2n51wlWjAfCmiYHtQY=;
 b=ogoluNQm348Dzg5dJwtkAOtGn3PxdIcX5bEK7BGjMKKxzqXKs7nYwN+oYEPibrparZdACHUQge92pey6sxJhuSAT6XH2yy+pARjmc86H7Ab+A3BR5J4nJTn+Sx57KD9dp01GI5o5RH7yuuUJP6g79Dseu5xFgPBIQrMm+LZ3DKZGapH7i9CZvJJLHDOrUnCrdyByz+/44f7m1oFCWxjqaKW4Kx3kMyqp9/aX6X0Yjl2wk4QFmlA9W0ae6A9NAASC4wSG/CN4CaaPhczIuXxyQSSBHnZEvxvVFQFsgYMThqVV8ZKHvcnz3ayteEUU/0AyyOvSCb9qXiITSgF4bwMyRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fxq/lDZXwSN9KhVcvG0CjNC7q2n51wlWjAfCmiYHtQY=;
 b=1EXggiWXxxo/d5smuq3BeeNxTzig1r4JQFKXPJlCH7rKJp4CujCIEUdRyZJXF1hcbDu2O5ZBOuEVI7B4upFZ6NXmngL0DWhubVqKfCZTtZf3a2hNWmAcYfMwsUHgz2AO/Es2p3E89/GHcyZKfF94O837C3rKX+KI3ZqbXptFndM=
Received: from DM5PR08CA0040.namprd08.prod.outlook.com (2603:10b6:4:60::29) by
 SJ2PR12MB7866.namprd12.prod.outlook.com (2603:10b6:a03:4cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Mon, 18 Nov
 2024 16:44:48 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com (2603:10b6:4:60::4)
 by DM5PR08CA0040.outlook.office365.com (2603:10b6:4:60::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.22 via Frontend Transport; Mon, 18 Nov 2024 16:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:44:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:47 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:46 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:44:45 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 02/27] sfc: add cxl support using new CXL API
Date: Mon, 18 Nov 2024 16:44:09 +0000
Message-ID: <20241118164434.7551-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SJ2PR12MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: bbcddcf4-920a-4573-b647-08dd07f05077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z+BmOdhdfwfJt6DHqj2s0EyPqRJeEotPaE7WRXDAt9YVdh2zB5fsUgYCPNsz?=
 =?us-ascii?Q?LinrJrudxdXEX5Jnq2y4rl4Q2GVhD/HZfWGuTHUj3q5eVRD40zyAU4qHTSCR?=
 =?us-ascii?Q?6oj3xHZO4gTXy0TnEmSXTUVoj3/SmoXcQUJlBirvr6M325cH1uv0W/mdq7hu?=
 =?us-ascii?Q?miDIGMsGUSWmwHl8AYxNxkxtelwKeatZpWnRr7BrEw0zwdnuXfSkMr4dqQf7?=
 =?us-ascii?Q?6H8AE7KoYGwLL520YAL+blF4Q5EJyVITHPwDPrX10cKrZOVtMGKqx3RshV0v?=
 =?us-ascii?Q?ksClN6GJQG72jc7OcR67WAMfvpnTVVmpnvCt6fEi6GEW0WcgHXkXXBsZOlPE?=
 =?us-ascii?Q?UvDWMeWDJ6Rub4pyOPEIPJsXYdGdqZyb4vj0NuaL1wuwVe4BitERuzKO3WsQ?=
 =?us-ascii?Q?KIVvM0OaWvNx95X8qEZ3Qs2iMu7iU8LRhJIPyan1wNdz1PomWsoGFsgOv7N4?=
 =?us-ascii?Q?YQ8dtne1WB8VDKSOi162e29t6+d8UVmXWGsijjgKt3gksF3YHIhcYUSaNLPa?=
 =?us-ascii?Q?sdtU+DXMaHjXrJ1zI+N6/Bc9rOL8ltQoraUzxM6sGMR/91LoqmjEDAl7FlQg?=
 =?us-ascii?Q?aVxDogeNRGYTPWkH0jIrfU1DpxsGcnTyx6gqyz/RgExekrfF0XXFDxCxwHU3?=
 =?us-ascii?Q?pgnPYPPKg/E1NodP3SI24H5tdQDPZWCuseJPmVv0ubcY4dwKJB/mTV5SqzGn?=
 =?us-ascii?Q?OGndL7zxn8YgQRc77APuiji7JLsZsKOH6tExKAgnbiNvNQJPg509MNSU4bRe?=
 =?us-ascii?Q?lzKZ7hN24kquvJegj4WBok56x0pUcwki4EKwNcBA7OFXu/e1MTBwgo6b9PhP?=
 =?us-ascii?Q?LZzbJvogoun63M3nJkBQicr+rlffWxN80I2mHsSVAp95KXpnaue61HctFpyg?=
 =?us-ascii?Q?3ZnIBv6TikNS5C4/Jf78mLMdDJxjJUStq5r8JnbcuX+v6nEHotBdi06AoX1n?=
 =?us-ascii?Q?8kY5dFQFrpbk+HQreRRAF7P0T6MCl8eHrxfGy9Xigx6+vjv6gaFJCGXhAppj?=
 =?us-ascii?Q?X7ozYktdmnTIlWSSBn9FwtyZWG2hFWITQrGahItvZ6ICzi+IzAudV3sRk95h?=
 =?us-ascii?Q?sRITvtTmq7E6qm8hHw61ICNe9KgIsW568gH9DTvS+AUcC8UsqbmbTxJss/jD?=
 =?us-ascii?Q?kJ5z+kqGwlM1eOxsLI7/vCSTMUvjGTCJh0ReEMGB/F7eWi6EaxKN4ippvj5d?=
 =?us-ascii?Q?ahucsQoPSONqUHG+aBf3IoSujz81nphHsJf91o4LGX3TNSPUIAqoYNpN06eA?=
 =?us-ascii?Q?+PX8HLYXSqTVVGbijCC/qQja/C0ji1W6p1w018fS+TumxAPCwu/Ab4R6/hyy?=
 =?us-ascii?Q?LZHl+4HHU0Kve46KvhklKtSiC+Pmry7/0IjLt7m7tSa11eJJYcqWyeEbcTns?=
 =?us-ascii?Q?8wRzMZAJDg8jKTI2TGacqLcvQwFxDAzW1IxtTpj57mMyKVn6hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:44:47.8952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcddcf4-920a-4573-b647-08dd07f05077
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866

From: Alejandro Lucero <alucerop@amd.com>

Add CXL initialization based on new CXL API for accel drivers and make
it dependable on kernel CXL configuration.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/Kconfig      |  7 +++
 drivers/net/ethernet/sfc/Makefile     |  1 +
 drivers/net/ethernet/sfc/efx.c        | 24 +++++++-
 drivers/net/ethernet/sfc/efx_cxl.c    | 88 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    | 28 +++++++++
 drivers/net/ethernet/sfc/net_driver.h | 10 +++
 6 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h

diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index 3eb55dcfa8a6..a8bc777baa95 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -65,6 +65,13 @@ config SFC_MCDI_LOGGING
 	  Driver-Interface) commands and responses, allowing debugging of
 	  driver/firmware interaction.  The tracing is actually enabled by
 	  a sysfs file 'mcdi_logging' under the PCI device.
+config SFC_CXL
+	bool "Solarflare SFC9100-family CXL support"
+	depends on SFC && CXL_BUS && !(SFC=y && CXL_BUS=m)
+	default y
+	help
+	  This enables CXL support by the driver relying on kernel support
+	  and hardware support.
 
 source "drivers/net/ethernet/sfc/falcon/Kconfig"
 source "drivers/net/ethernet/sfc/siena/Kconfig"
diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
index 8f446b9bd5ee..e909cafd5908 100644
--- a/drivers/net/ethernet/sfc/Makefile
+++ b/drivers/net/ethernet/sfc/Makefile
@@ -13,6 +13,7 @@ sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
                            mae.o tc.o tc_bindings.o tc_counters.o \
                            tc_encap_actions.o tc_conntrack.o
 
+sfc-$(CONFIG_SFC_CXL)	+= efx_cxl.o
 obj-$(CONFIG_SFC)	+= sfc.o
 
 obj-$(CONFIG_SFC_FALCON) += falcon/
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 36b3b57e2055..5f7c910a14a5 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -33,6 +33,9 @@
 #include "selftest.h"
 #include "sriov.h"
 #include "efx_devlink.h"
+#ifdef CONFIG_SFC_CXL
+#include "efx_cxl.h"
+#endif
 
 #include "mcdi_port_common.h"
 #include "mcdi_pcol.h"
@@ -903,12 +906,17 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
 	efx_pci_remove_main(efx);
 
 	efx_fini_io(efx);
+
+	probe_data = container_of(efx, struct efx_probe_data, efx);
+#ifdef CONFIG_SFC_CXL
+	efx_cxl_exit(probe_data);
+#endif
+
 	pci_dbg(efx->pci_dev, "shutdown successful\n");
 
 	efx_fini_devlink_and_unlock(efx);
 	efx_fini_struct(efx);
 	free_netdev(efx->net_dev);
-	probe_data = container_of(efx, struct efx_probe_data, efx);
 	kfree(probe_data);
 };
 
@@ -1113,6 +1121,17 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 	if (rc)
 		goto fail2;
 
+#ifdef CONFIG_SFC_CXL
+	/* A successful cxl initialization implies a CXL region created to be
+	 * used for PIO buffers. If there is no CXL support, or initialization
+	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
+	 * defined at specific PCI BAR regions will be used.
+	 */
+	rc = efx_cxl_init(probe_data);
+	if (rc)
+		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
+
+#endif
 	rc = efx_pci_probe_post_io(efx);
 	if (rc) {
 		/* On failure, retry once immediately.
@@ -1384,3 +1403,6 @@ MODULE_AUTHOR("Solarflare Communications and "
 MODULE_DESCRIPTION("Solarflare network driver");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, efx_pci_table);
+#ifdef CONFIG_SFC_CXL
+MODULE_SOFTDEP("pre: cxl_core cxl_port cxl_acpi cxl-mem");
+#endif
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
new file mode 100644
index 000000000000..99f396028639
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/****************************************************************************
+ *
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#include <cxl/cxl.h>
+#include <cxl/pci.h>
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
+	struct pci_dev *pci_dev;
+	struct efx_cxl *cxl;
+	struct resource res;
+	u16 dvsec;
+	int rc;
+
+	pci_dev = efx->pci_dev;
+	probe_data->cxl_pio_initialised = false;
+
+	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
+					  CXL_DVSEC_PCIE_DEVICE);
+	if (!dvsec)
+		return 0;
+
+	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
+
+	cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);
+	if (!cxl)
+		return -ENOMEM;
+
+	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
+	if (IS_ERR(cxl->cxlds)) {
+		pci_err(pci_dev, "CXL accel device state failed");
+		rc = -ENOMEM;
+		goto err1;
+	}
+
+	cxl_set_dvsec(cxl->cxlds, dvsec);
+	cxl_set_serial(cxl->cxlds, pci_dev->dev.id);
+
+	res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
+	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_DPA)) {
+		pci_err(pci_dev, "cxl_set_resource DPA failed\n");
+		rc = -EINVAL;
+		goto err2;
+	}
+
+	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
+	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_RAM)) {
+		pci_err(pci_dev, "cxl_set_resource RAM failed\n");
+		rc = -EINVAL;
+		goto err2;
+	}
+
+	probe_data->cxl = cxl;
+
+	return 0;
+
+err2:
+	kfree(cxl->cxlds);
+err1:
+	kfree(cxl);
+	return rc;
+
+}
+
+void efx_cxl_exit(struct efx_probe_data *probe_data)
+{
+	if (probe_data->cxl) {
+		kfree(probe_data->cxl->cxlds);
+		kfree(probe_data->cxl);
+	}
+}
+
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
new file mode 100644
index 000000000000..90fa46bc94db
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/****************************************************************************
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#ifndef EFX_CXL_H
+#define EFX_CXL_H
+
+struct efx_nic;
+
+struct efx_cxl {
+	struct cxl_dev_state *cxlds;
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
+#endif
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index b85c51cbe7f9..efc6d90380b9 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1160,14 +1160,24 @@ struct efx_nic {
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
2.17.1


