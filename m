Return-Path: <netdev+bounces-182285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BED87A88747
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A293BD75F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7033A2749E2;
	Mon, 14 Apr 2025 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="urcHRzOC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F262741AC;
	Mon, 14 Apr 2025 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643638; cv=fail; b=j7GF16RrztBVu8HQM8Tieqf9EanaK9Vbil8P2dj2gCg/C5fzfO99V9rd0tZggHzOXGm0Cy8cTLo1k+4Fp0oXqSUHWnHRZf9TTA1QKCg7z718wsy0OviDAdMdnzKe1jl+Rqip6A294Ic6aafWfr28ESYTjco2zXA9g1N9f4wcIzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643638; c=relaxed/simple;
	bh=eHDpZaROqf7kajhc2J7wK7/qjGGyjVreYzVqKgPpMqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOeHyFVSVRZDi04A7UizEY2W3cWxJUVHJw/cwb3hKtEcDrbDhD7EfDGsduYVj7tltSDm5y0+14gwKLpSwY6C7YWig10n920945r+l9wtX2o63TAKAiHmpY2h19p6I2sPwU+sNhPlZ7uMwdHNs09Mfd2jq9Wb6AOIPWbVxd5btKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=urcHRzOC; arc=fail smtp.client-ip=40.107.95.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaevqyEzGCq3jdAV5AESV5FFhzfq3EP1z2G7Nv+RAAWEsFqMcn/qCLr1Z/Rz/J4E+Rh0Idq5u0Yb0v0Sf01FeUdgayESkovnPCVGMOrWcOWSLsLaEtvf80/3//Y/ibS3stvuGONzkFqUfMSfJEJNyltgRB/JJpu3zJSDGiH7ElLrjfqMkyf2AaqBlF2g0JyVhrl6rGFgtu/PdwH8e4p1fWsJ/x8XXjkqlTIa7RMTblAkP59pYD8dyMkP0T1WzLVUoFrvbh3mgSeMQkgMNA1ty4RGWOCkKNnuJV+fGA3fYznFkzzOQQUgU+VBBcUYY0/Rbp5bh7+c3/ZJExG6mZLrgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/zrX6vZfbgI7TcrXUHKFZtmRarE63hW0B6o5PuZkzg=;
 b=aw+WIui5cBSaRiF/SBJvhEdHg0NbpTXkoqEMnJhO85oo67waMQDLv7xAm+hTTwnvHMcG/O5tENuZ+I8CDWfrbpTi4k7Ji+jOZOUHwWljRJiiqusE+3QoBS2KJ6AVjRQO/NC+JX9HebmVDiJzWomWhZuwMOG2KNPDBZV7Cb787gqyb/EuW4PXadCWM0894dqSk7u6HgMFqT7pYJAOFWmqfawrM5NPJEOw/i73B7RIjZgUvAQvj688XbA1arDnXEc482omg/pk1boySUwzhxWw50JVhbZzh0ZYVmTX6KHE8vU2nLh9l3tnPR2/Zn+U/E0O5gQXPRqt6v3hfo/qkhhmMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/zrX6vZfbgI7TcrXUHKFZtmRarE63hW0B6o5PuZkzg=;
 b=urcHRzOCKLPAHLCg8E9HA4i/VSdOLEF6438PjxFzvVwHwV2jCbZh3MLRDjSnz27jY0hT8KgdvDI22FMww2Jl5vN7Zc98rdcCC8+vFNVJBjIWK6Rq4kVXfegm6/TmFsa6FN8hYSXd/bvAgptfEzmYToceFWACyjKE2Z+lw2y9MyU=
Received: from PH7P220CA0092.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::28)
 by CH1PR12MB9599.namprd12.prod.outlook.com (2603:10b6:610:2ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 15:13:50 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::64) by PH7P220CA0092.outlook.office365.com
 (2603:10b6:510:32d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 15:13:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:13:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:13:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:13:48 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:13:47 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v13 02/22] sfc: add cxl support
Date: Mon, 14 Apr 2025 16:13:16 +0100
Message-ID: <20250414151336.3852990-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|CH1PR12MB9599:EE_
X-MS-Office365-Filtering-Correlation-Id: d1acab4b-0f80-4415-9b63-08dd7b66f5af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vA7IDdAMrHSKl9EJhSgTYXHoHQe3lV5txtk3Ssp7SU+ZwhJM+R4sqwhsUyIb?=
 =?us-ascii?Q?dkLCn2B2Ky7SK9abC4kRkbiq6qS+mZhp/8lJ+wg4XDDCUsXhoJLESRhBt/lT?=
 =?us-ascii?Q?YaXjYJdUrVC0tyfY57wZ3PMJHr1/X39gGaHbVrNgRcD6p3sYVLdrKsfAOpqK?=
 =?us-ascii?Q?eqloRLRoHKJgwRY5ILwTJJ1wctabPyFW+6reOxX/H19r642VEpT5g3YnVyen?=
 =?us-ascii?Q?ElCr8h/Tt4JFhBwL04yBaQGnyOvBEEKiL4/YDeLATWgEGr1NjcYU4eLtvVJO?=
 =?us-ascii?Q?BKjK2qXqn9EgzzFN+uVKnKQXmrVZNFW/ttF77yCphJCxrvOOG+frCRr2c2uN?=
 =?us-ascii?Q?nHfX2E16Gpi+jnwimHJ0f1Z6EDnHZsJoyaw4e39s+yfYLpbac3r3hAg9Zepo?=
 =?us-ascii?Q?Tk7RIk2siW6yaM1i1iYRrt19kwrkLE0U7kuW6nASdzpHTOTacqw1JP0d3q1M?=
 =?us-ascii?Q?PymnE3I9cLVmsUjS/GCnlp0xpHHKx60SvPkqK4GhsV6zj0KBZJQDpbS1q8jp?=
 =?us-ascii?Q?1hi9bCMMLQiWoTUI3x+mDZXyI4VoTCzzy2kV/4CXgA1wVTH7rk72MLq5ZvpA?=
 =?us-ascii?Q?VI2gLCJl4wB2WFHkZ170oy8IJj6BnRXdogB9/2kXe8sdsXK9jzTfR0RMhZzj?=
 =?us-ascii?Q?J1fS6HtNCmlH2o+FCQAfyQ3L+zb4FTTuhGYXjbq19UVKsJlMz4TKQm13uAyK?=
 =?us-ascii?Q?3IKXx7VIwyPpRxS9zVu1DradyDqyuzMzdhOvjr2ePK4tA1sDlULPk0n69uCt?=
 =?us-ascii?Q?gCskNVYGpfl5GdwBKZQexHAGientIicjJWy57kGKifqbNxQpp5dSk26bcGde?=
 =?us-ascii?Q?rShw4ufASeriFi3/PHrZORVrdE/f4R77uMaSpuMGpxS1WF5VJVkjK7MjBllm?=
 =?us-ascii?Q?dRkCBo+OtgwhFFwmvGnX0+gBd+GDISOSQWSQGjcJuOcgSOHHtmqdG1alaHZ6?=
 =?us-ascii?Q?riVapRpexb5nJwUmueCULhAClLClEAtoayxd3mQqOBTrZD5eUYsceqYrGXzU?=
 =?us-ascii?Q?qvZZWA/9P7PDsxXNBdLgLJDSJGftR5csnUTDIZQOm/E+to4+GzFuz5fbuLjt?=
 =?us-ascii?Q?DgEcMPxtPf+z8qvESKnw0PPloGVZ35Dytcjk6MmPGJfwAcc3chq4YVZtBJ0u?=
 =?us-ascii?Q?IEWsixIJddJzcVbJEFIKiTi3+nVOir/WNoSKb5SqP67wZa8stcwrhf+PzF08?=
 =?us-ascii?Q?TwqT8Jniyt+o4ERF1LryxN5XIxRr+mF0C3w6vGfeyJnz0YXM85OmKcOENHN/?=
 =?us-ascii?Q?EquhAoBZ5lw4blB+Nn9wFJA63ulVoRJBHTiWPbkZKcOk0Aiqlwq9DrGJv5Qz?=
 =?us-ascii?Q?KCQUSKLZkhMbMAOGwKHtSFBnYCCEtv1Jo/78jFR2jYhFGlVBw99djhKhtNd/?=
 =?us-ascii?Q?DDAY2gK+AMSLUioPHsOTQcVME5Aqd3tVpxD3omE1h/PnAHzdTtmk0GO2/y81?=
 =?us-ascii?Q?JY1sumgnp36b2yx4TRpb7DOvhsGx5fDj0IuR7wtmye+ka+AQo1YTCI+uP7ep?=
 =?us-ascii?Q?maD5Dd0RYtPwfFdXGCsU4Ej/bg0Y0vJ1cHwc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:13:49.3723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1acab4b-0f80-4415-9b63-08dd7b66f5af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9599

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


