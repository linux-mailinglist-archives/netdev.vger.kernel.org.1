Return-Path: <netdev+bounces-227922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DD5BBD954
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C776F4EA9F7
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D356C21CA00;
	Mon,  6 Oct 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wJzgYD4h"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045981CF96;
	Mon,  6 Oct 2025 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745005; cv=fail; b=Q+GVrPsHKq1u6hqDxlkHF3sr/3zOeeNx4CaPretE1PSekH/I0yzynqh/DjQO+KQVhdei2LvSxOtX7GusU/bObiWAhFLCYhGta8uiEm07YwBJA1UTGHpOcG4EU6r2SAWgvZd3RwxxygXDLIPlpiji8hCLUPKAU6udLJn4UvmAaYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745005; c=relaxed/simple;
	bh=mc+GDKSHWcAAkAs16ZzJxRj0qTEEu+BKzeIrCniIDiM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdd2WyaYNJeJiVe/92SHvUQPGNb+4N2S5Qap+B21JcF59v/bMcUiRY4FiY4jU90EUSfHuyca94ePzR4buwMHa2Cv8hJkOx8N51ykC25wWTJFnj6iy2t1V+Mg+RXVoTF+EO9X9Ui/Ua2E3QM2xKAbnl6eK/wNkWdxYxPxawRophA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wJzgYD4h; arc=fail smtp.client-ip=52.101.52.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hhgs12QRD7Q/phhyZBux3dAWYjb9XqzGW7hMjhdL1erwV1xn/acINO+ksIFOsc86Gn+hMErygBA+fZs0MJz3K1wfMsCsLYkthKzOg0+M8CLMIcPaZNioYroC1yxfmcr2Hv5QXxAp5jSeAu2IKcSlxujc39ycf+u9uqf5cxyJQ0k1znaFIKHZ96xZIZydjtvetE/DQsM1w4u5yHNNFdnrWhan4w+ZOGeEgwL9920xZWZ1XHr/UKsA8Hbh8prSpV/2MarbswTb2YzobDsCRcps8nFOH4UJD+WLpXpBwO0cBUPx23XhYQ1u/sQnt1RXf/7FgXON1Tndim7tQFM4yb0gMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utofsBRk7+QVtN7uwBu22LSUhj2TFi4V++bV9CtYh1M=;
 b=YhvUGeF7pW169ojG+9x8E/K8LLELmR73y7rqKfV4v+b7v9ugsp9U1nJcdPLgNU6XkzslT80zHy6H6IICNlQs1wWkujUfI4ViuwupgRJYLFc5zAzqpcCXK592dhyhv+YPdbHs1iwVIkMku6u5OFSJ3hTLj8vEbhkYWKUFrHnwxeFH0E9zdI99f2xbN88qJjStMU8vtBREckHJcbagLco/0wvcMbaEgar0GhNbwRgFMtfVRUPW+ZvHe5sai1yst3ZRVGq5vJ8x49MWuOigC+dF2AApukwhJRu4eXULnxf4Mc8dY7kevuPTeDMtLtUu+MDSutv/7HCJ156g10TnxRoaTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utofsBRk7+QVtN7uwBu22LSUhj2TFi4V++bV9CtYh1M=;
 b=wJzgYD4hJ1rBem+pqfK3yNgUkPAHvL+m7UUp6UO32Pd80mt9Ch7EmmybsmbWZj/cvmPWBctTneuSzdgU7dHwmwCcBiXfacKTmBebE5XqjNMATD057n5uVRzpsNaP61EuXCM7ypjNjZq4y1tcoeQ9d6SYD37bs0QJhhDRcY6ClLQ=
Received: from CH2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:610:20::17)
 by LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:03:16 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:20:cafe::16) by CH2PR07CA0004.outlook.office365.com
 (2603:10b6:610:20::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 10:03:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:03:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 6 Oct
 2025 03:02:15 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Oct
 2025 05:02:14 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:02:13 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>, "Alison
 Schofield" <alison.schofield@intel.com>
Subject: [PATCH v19 05/22] sfc: add cxl support
Date: Mon, 6 Oct 2025 11:01:13 +0100
Message-ID: <20251006100130.2623388-6-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|LV8PR12MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a70211-17cb-4306-fda1-08de04bf91cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b0luaweSIiqvXrgfnTydxLMVIELB+2WpZ5AAIOTj8XTmdQnMVaM+pnL+vQ8p?=
 =?us-ascii?Q?dqe5/BUAcIYCqNXAU5VBWzKpTTIngtVevmulQ3V4HTpmlj2uHVMwFEftA1lc?=
 =?us-ascii?Q?NRJYI6b9muJpv/VqILGamkdWddwRvcfCj9Sq54fdgqpVtqWK8mR1PStYOO1m?=
 =?us-ascii?Q?mzHsDAQYRQSVP8cK9f4as2ye0h0ua0Sr2YTaLJqPpKbgeSRIPTauAx4qEzon?=
 =?us-ascii?Q?SCRvIOyvWgZUKJeJmbIdf/d3DaAqp9YPdNZCFJuIk8KDloS+pV/OXPxG759L?=
 =?us-ascii?Q?/t6EBXguhswPcBaD/RBGkhONenBuywsSNNNJW2ZTIrb5SFyBl0YX8V+ftsqy?=
 =?us-ascii?Q?yC+rAAezU05XCXD9m0N08bxSzdSe+XqO3dSquGyrBlVR4jAWav6dPEFwh2wd?=
 =?us-ascii?Q?u7xL3WNr+q1Te4LAbmfNyr/vKqAk6rl7vjLq4ZuxS+uPniUz4W1ITR1MfHli?=
 =?us-ascii?Q?QeADOCbXEsJDRqR9eZXMm7jG0Ymv14/Do/ib526H7YvO0CFjIew8DV+SeRqY?=
 =?us-ascii?Q?uNidHnQA4l4ftjQ2OEiN2IsDTDMjMXTGMhNgiYo0YbSDE5zIYICBU0vsje/O?=
 =?us-ascii?Q?YYw29KnD3/dcpC1O6qrQZ+GTe3imUDcnUyGeqMAQ6XNww0ErpECE5Rp1I2Sx?=
 =?us-ascii?Q?9+Ce4fGCtQ3+CRj/wz35s6YQmLrGvmZ/eJ4S3ZEDeK8/u0qNTqTOtMGhg6q4?=
 =?us-ascii?Q?+7vnFfCwsendt7XSsSBtA/NAyVJaEoq1bpqz1++jXFBL41RJWSN0M9GHvWBU?=
 =?us-ascii?Q?/Gnipk8S8UdOPIbMUHSSABR2uksR1ET37d3wCkQvEFL8dcADnyD39UP9FdFV?=
 =?us-ascii?Q?70IrlymXSBcmbkaJxDgCg1cZlfkEiDSvSmWLSMEX/j9PH82IO2HxPAyX0LTw?=
 =?us-ascii?Q?7Zp3v4w74+VcPsll5kAfEtoZG5abPkAew2yOCBLvrfYptB27NZkXxFxVOgbf?=
 =?us-ascii?Q?ActaXSwHctaeBDoyUKuCOtSym1x8zncMupYsFp76fIKCd+Da76sKB/T3nZuv?=
 =?us-ascii?Q?CoWXtJS1gbstHMzX2qWAeO3RDGdCsO9qwnXu5Y1POaFvUKcYkbpqURFkl5Ey?=
 =?us-ascii?Q?n5BXosq1cRrvor6ZyrdwnE7av9ZjPiyoXsC8/wf7bUqmeFEwOHamXAX93lYa?=
 =?us-ascii?Q?Z6hIdHs7V3wsRfdrDy5RWPU7fgqLAyHtHaB6hZdma102FY8ybFrWclgMXr78?=
 =?us-ascii?Q?X1fIJNYp+yGAPfxCow2BuJiD6t0fWO+PfXLaHU3NZD3eX9SagLBUdkmsHnJa?=
 =?us-ascii?Q?Vufm5ZfIATmtmUvRXNY5HyjoAYf6/4M/p4IbI3jZD42Xy4KfTBKLb+xyFuNO?=
 =?us-ascii?Q?9KzdcHj5NBmbag/xTvrnFX24ZeTYNwIY3gDYEEzR2atvYVziQ7uz/jZuOkoZ?=
 =?us-ascii?Q?oQ4r1b99WvQZdOVKyRHuq8nKM6lbD/hFW8IJA4ak2EfZM2OEf1ueK4/4BjCn?=
 =?us-ascii?Q?Ki976TfUcv9x9tYtOQEP99efXw+/7kqZNHnxKQMfn4lIJCVQajoDEFOCQU7Y?=
 =?us-ascii?Q?grnS907eWSkJSaGDsCnQTTpbaVMq/6BAJSSW03XjEOF6rQlNyyN4DXHRV92N?=
 =?us-ascii?Q?U4NAXk+v+va1DOE79cs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:03:16.3960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a70211-17cb-4306-fda1-08de04bf91cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9134

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


