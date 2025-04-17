Return-Path: <netdev+bounces-183916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F8AA92CA0
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E89592443C
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D966C210184;
	Thu, 17 Apr 2025 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r0/XEoIu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F210E18D63E;
	Thu, 17 Apr 2025 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925385; cv=fail; b=SIyO62CdJJUvuQuJ7KHDnxlZQ5aDz0QLUL0bZXMHHSpSe0w7FlxoSz8HZ+kzlmi51ab6Qwf4c4gEwSHKlchQkBfy1J+KrlN9wJqj//FM2v3FHcCTZ+opb2vyr4qGbRpRjNKJTh7ogMXMDkY6y0+yliF0nPSFyZoP0haxvwCKHxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925385; c=relaxed/simple;
	bh=eHDpZaROqf7kajhc2J7wK7/qjGGyjVreYzVqKgPpMqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diexDZ/YB6YJ73mKQ1hZ6QfuKVmrA6tjAI4Ta8Wv50+spFeq6lN5+VGzSahVSLON7OGAIKaLJ2rNhJ9fg3TzYEfKAOK9DNpsDoXdFLvdzU8ewOS+t8bpHjI/IKS1tokICP3MJbdZIJKnuQtdS9BmiCseiB/z9mFuj9u1UMKEirI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r0/XEoIu; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KS9OzMykk/L4s1wEsHCfFObHGl8+cvayakMbTyWAdiT6yaQ2Nh5Ne84CIjXOXB7Pg8B9fKKy1zmwnvcRccFepZ27tnfumHTuXvaT58N4SIJzkeqyWrRdwViLxcBgebJoowWQK32u8IaoT4eWb5kpKlXuWi2cy+WY0G1fIP7No20ygfVMnxwzfVXwB7GXd9dg3AQornonR+w79FspEiqAGrbtOuKBIr830vz5y/NsoylevHZg2bLN2hWImODhDUUpWEsp5xXYM/e4REs5zOEDsZMGOh/ZAE09kord6OXAWY3fUkxDTbBh+CIllt0W9Wulkkh28UnevvDHXxN6Y8pKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/zrX6vZfbgI7TcrXUHKFZtmRarE63hW0B6o5PuZkzg=;
 b=B1mqFVu6PNsl/O7CLBDhFq8SU1gPo5nUCUlTK92UZuRFteDeNtP2hZcGXQ2Fr2QCb7W3DjjDu8/OOTfEffLXYoWA5gG1rqYRRj6SvTJoD5VcXdTjAS4C85Ovg3nUz2R1mcgVCwi3h0ZlSxv21MwOgn2OkBJF6eJ1HB1V+xBsyweCTf3OHUVlDP00pId9f4Yg51bMqwwBylNpK2F8n5ezjC9gErnYik3ft2GHYZi1DIFEX4bfDc3ekSc3DIdCt9axSOZUrJm3AmQ++B+CvkJi9+wUQ3XkQU2soY3eum6UW3vzs/uzU9TcPbD9/yU0J8NifU4+Y+h/Hyz4ENd5Dvnq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/zrX6vZfbgI7TcrXUHKFZtmRarE63hW0B6o5PuZkzg=;
 b=r0/XEoIuIsP+1t4014BBWWbzFOhxXYTiFqzBwu74Z2HM4Zp0hJ4+QtjfJYSt+NDIoVADADZsIBDQtdQGWe2tnaHEy/QaNb8R8iAJq7HDMhEYd7UUOCTd/BK9XBGmRL6qOqRb1XRFalrS8xOVERvFSOn3Mfg9GS56/KUl3++dxBg=
Received: from PH0PR07CA0050.namprd07.prod.outlook.com (2603:10b6:510:e::25)
 by SA1PR12MB8987.namprd12.prod.outlook.com (2603:10b6:806:386::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.26; Thu, 17 Apr
 2025 21:29:39 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::46) by PH0PR07CA0050.outlook.office365.com
 (2603:10b6:510:e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Thu,
 17 Apr 2025 21:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:29:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:37 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:29:36 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v14 02/22] sfc: add cxl support
Date: Thu, 17 Apr 2025 22:29:05 +0100
Message-ID: <20250417212926.1343268-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|SA1PR12MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ead8750-4976-4a43-3a39-08dd7df6f55b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dWNMTh7fC/CYt2YwcHLQZ9Zhzwn7JEAmS0zOOUgZaFbttvijsWhNUJePLkWR?=
 =?us-ascii?Q?zki1lcUqg3haw+wt77CxWgPNI4WYG34IropopT4zt8ghD+J2EzBecXs3TNKl?=
 =?us-ascii?Q?gh4rSEGmO72O8LAdgL5LGMFBN6Cj9OF3X225+3DzbyIe+RlVP2Pbo8rSTJxD?=
 =?us-ascii?Q?6Jm29BPzfcAwCtOr1Yf8EhPUwcpKkxZrIQuMmQ4uFd+L7+9KpgMq7wU6f4Fb?=
 =?us-ascii?Q?duQFB+uWuec+WdUUB8Yed9gXDorSFX2rgb7FIyZD8U54F/IlwqPGQum11XYg?=
 =?us-ascii?Q?Ze0nRl2LlqVEjBzQkKrEskDHsTKjkEn/OoEdVJCBXMnC9axYNKoKF/Uxl2ug?=
 =?us-ascii?Q?MxkDrPfQCdzqWkwVQm3bCRFtpkXZll9+MsfK9os4I1JW8SgTABRBVLURJxJp?=
 =?us-ascii?Q?2wHlJDaeDuw5Cy3uuz0italmGVqDKrA6OBlMK+phJQb7BH+BCDBSn6h1P/0t?=
 =?us-ascii?Q?0E7VkuStHx/GdiVsriamsk9xascGpBdMq85+cKUfo7iv/s4dimCXcphZYjFh?=
 =?us-ascii?Q?4uLmC2kGchqlu4AenxxE1l3DCHNlXXAt5b+GfqdIC4NwaPTPFILiGoUCMSss?=
 =?us-ascii?Q?k8j3xtJ9Vv6S1IWndZbLqQGE9g+yw45lKn8/yP/BSROCULapJuYh3vD860JO?=
 =?us-ascii?Q?p4dQKkd4T4E4Xt3Buxd9exY8JSGZsbvthoaqp3/jgJ3hxHmnbUV/yopK15hu?=
 =?us-ascii?Q?YehKKYkppMMuEMyiIuELVuKOkCts5kWpbF4febwQwhgrgKzYfX2gfM/XWNy0?=
 =?us-ascii?Q?eBHOWWoJpuLFwcEf3sYR1XuZrFxQhcoNS+FBLlBrU03+CnF6CQlSTDiC68Sf?=
 =?us-ascii?Q?I1no1483PGNf9sHeg3M57hB1EpxIPyzHxQISkXkw0h7gG2IDTcF3CC6w4OhX?=
 =?us-ascii?Q?Ce9GNBR16SM5Y5f0Xo8HmndJn9hIHKccrKUWf8vyrmSfCEEuD4w5tmSJK8/5?=
 =?us-ascii?Q?Kq3M6HWZewvB1WvHXVqdHasbt42MYeYNvG6dDlA5zb2xCDJXgx2/9t1TwARB?=
 =?us-ascii?Q?vTkaqkm7FV3vFIbQZxbEiZVlxxGZt62kUTPyJ9rVhVrGO/NVSHMK+7PWbvP2?=
 =?us-ascii?Q?7NqlZT4R2eYj+hl1xQzFuw9ozEhGrpJMPkOaEPYK6/Mk/2EfaQ99T8y9NauP?=
 =?us-ascii?Q?hMimbrgnWbilQoBkUyjxIyh2pO/OP5QIkAjO8/lCgtZ9DLdw2E/R6RYPp6nk?=
 =?us-ascii?Q?jzFrD5wDFw6Sobj0ftUCEjdWyLljpTTfYruQIbtCSrPlc3HF18ztJXIJqkTX?=
 =?us-ascii?Q?grCb1TRoZI+oMElpBwxvqyarmbtes5Y1hhKbgARiUju+onqEubVSkWkodzjV?=
 =?us-ascii?Q?8xyunSkft+To1sjSyl8RxlZtmSaKF6Q4escxyf8vQ6ootv7Zu4znBryZr5tK?=
 =?us-ascii?Q?EaFSOMcgb0Bt14hy6grd97ZxF9HzEnlZT2yT8t98JgYBe0qyIbOM/lUKtgcJ?=
 =?us-ascii?Q?hu1jDUrV2dGj25SLtCEOxvGtA2ym8ErbQFwXP2sinX+6okqztPIl02tRUFCp?=
 =?us-ascii?Q?6tiSb2FaXQTxF/lezxiY0G6ugoC+vKINDAI5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:29:38.6739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ead8750-4976-4a43-3a39-08dd7df6f55b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8987

From: Alejandro Lucero <alucerop@amd.com>

Add CXL initialization based on new CXL API for accel drivers and make
it dependent on kernel CXL configuration.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/Kconfig      |  9 +++++
 drivers/net/ethernet/sfc/Makefile     |  1 +
 drivers/net/ethernet/sfc/efx.c        | 15 +++++++-
 drivers/net/ethernet/sfc/efx_cxl.c    | 55 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    | 40 +++++++++++++++++++
 drivers/net/ethernet/sfc/net_driver.h | 10 +++++
 6 files changed, 129 insertions(+), 1 deletion(-)
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
index 000000000000..753d5b7d49b6
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/****************************************************************************
+ *
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2025, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
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
+	struct pci_dev *pci_dev = efx->pci_dev;
+	struct efx_cxl *cxl;
+	u16 dvsec;
+
+	probe_data->cxl_pio_initialised = false;
+
+	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
+					  CXL_DVSEC_PCIE_DEVICE);
+	if (!dvsec)
+		return 0;
+
+	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
+
+	/* Create a cxl_dev_state embedded in the cxl struct using cxl core api
+	 * specifying no mbox available.
+	 */
+	cxl = cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
+				   pci_dev->dev.id, dvsec, struct efx_cxl,
+				   cxlds, false);
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
index 5c0f306fb019..0e685b8a9980 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1199,14 +1199,24 @@ struct efx_nic {
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


