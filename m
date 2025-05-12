Return-Path: <netdev+bounces-189812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3816AB3D28
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E653B9084
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285E2248F4C;
	Mon, 12 May 2025 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Al6Kunkg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC4253957;
	Mon, 12 May 2025 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066273; cv=fail; b=DzqexfiQlnnXbzbFQfsGQlvkNR20fYI/ytapjHzjPptFXVlTKG/NZi1rQhzYhYMTEjupapGwGheCjRa2aiT9UOePCZgWzulBiT5LedYwCI03DsWjnlgdrhyNYOZk5yGOo1G83PHzf880yfy7ryhRYannuTyY8ciW5xuKUkXGp1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066273; c=relaxed/simple;
	bh=Lu1m0TeS+aoXHHihpbN+e7b4gK95RpUHJ8U5EtoSfrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qxr06srJbND0uv651Hp+Pie7HjUda0WPFlpCBLvZ39QtpJRuxGPcI995j+Hno2JXqwQKMLy0fo4jzi6khizVwYMOC5fvkbjqq/G2SGYMuHPg/FIF9tA464uNrJnGANSiXnbwONVzZxeSzAn6JP30MKSIgnadZSmxQb1ugptvCOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Al6Kunkg; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X32/sgkyMkY/0U5NL+m340qZDAM+c2uEYI/D0fNMzK0rrXPbe/XjDfG4HYsNQenAciJQ5bduf7KOZQLm0j7+vjmvHdFUqqUQBtGDsJpVLL5IODcjerMnQQNTczIaXKYDU+tE+38z3hv7ZgdFwSmbn3FMsa8OH/jEujRWHaCTz5LBUN+yKD98NxT+0Z24UKUU4/l5Bv/nZBnvhaXvPcL9VRNPlWosgMcTUNy6NknhhDBWcwHXWgd3/yNWP1ZU0A9MDcddGnT6NnyqiwKhbl/8v29AgmOTDaCkfo4dFu3LxXaqXWgODFDwlH3/Z2L+tWA4sTrynBWMO5+yxhsDECQwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOwHry2zDbOdOQnl8BvJFW8UzWMoanvxp8MQtxu0uwI=;
 b=AiBS739egoRillkn8fGgI1OuV1/PVIu8qPXaool+J9CjLJriIX9Gq61d8sg/VcsdNGiZpy9hLURFJrHp55yY9nFVnsB+GrvqKRWQha/Fmem1BXu6DbNq9243OsQtzJuzVFprHPURyqloRHSaoJRRqbdYuef/IUjK0uU13Tc6aJdARuP1SIla2alr1etZfHMeqsgH4o4ODi2KdPgGtltEW9IUXf3d5dChZ7E8gWMM5n/uPsFziZB6S1h0LAv6WvxFip/8C++kuwdhuaos4cX1InwCzqQW8Cei7iyTbC2732GHmyhEtExMiMtqA7CgIx5K0Jhj8g3sObUVLBEg2ei5RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOwHry2zDbOdOQnl8BvJFW8UzWMoanvxp8MQtxu0uwI=;
 b=Al6KunkgGtxD9gE6y6K5u4ZGbIPdBR+3y9H0XoyWxqUBGN3OYuwivvpDTC3DeI3OsJl1ZbEF74CbviHFtdkYv/46UAJvtGGg94+F7R3HfQ7iCnEu3ZSEiZuq0VH/GlOBApE/TL9YogYGXa2Ehx5KG1hYRkiGLpT4i+JEl96T5tU=
Received: from SA1P222CA0053.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::27)
 by LV8PR12MB9666.namprd12.prod.outlook.com (2603:10b6:408:296::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Mon, 12 May
 2025 16:11:07 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:2d0:cafe::60) by SA1P222CA0053.outlook.office365.com
 (2603:10b6:806:2d0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.28 via Frontend Transport; Mon,
 12 May 2025 16:11:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:07 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:05 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH v15 02/22] sfc: add cxl support
Date: Mon, 12 May 2025 17:10:35 +0100
Message-ID: <20250512161055.4100442-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|LV8PR12MB9666:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed62bd5-e857-45c8-d3e9-08dd916f9a93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?723/Mo28DByX1RjQOReDCKJ0WUFsMFixujClvPDz/B9iyXywfFOP/qRbZJ93?=
 =?us-ascii?Q?HuFdItyRaMKLZcTaSwAfFE3y0X65FtaIcIPyHEtwbcVGcubvu3tr5UIPDM75?=
 =?us-ascii?Q?2q9CnpIsGJ8InOzvc9Dq7CBw6OfWb83I02rfvtv31FVBYV1y+esZzTHjZqAJ?=
 =?us-ascii?Q?v7PsxLhWXrvHAtpaoTwLKIun/54NE8yu0G8Clxzhqrfyrln+DnWMEU0cnMYq?=
 =?us-ascii?Q?QwpLnZGRql+z4u8GT8cEXuNzAql6WVLqSd2rUerE9Ui6dwieBD/NPwdEh7bR?=
 =?us-ascii?Q?XIqrVgJDeLxxFYE8hZQr0qtl7j3Jo57cuY3G4Ka7EpX5UAi15sECtFPSHF3D?=
 =?us-ascii?Q?aqPW0gxcwaMMtGNM1KH75eM3skPxDJ0cK4CcB+Rpdd8jTT7rxFcl/TDyK6OL?=
 =?us-ascii?Q?a3gkPXWRgUfj7lp4i6RqNVbN1saoxLI2xvo9n2amSYwfPrQlcbbRt8cLjp51?=
 =?us-ascii?Q?+s4AiLatE/tKpg4wuH8RwzvIpAwpnYowyQM6gprJ1dmrxTiNKvongUuPbO4R?=
 =?us-ascii?Q?uwTqDuO4nmCA4K2qT5Mylt3wQvUdug5ITQFrlYIwr0zv2WprpGI+f3yyuGqU?=
 =?us-ascii?Q?a5EQo0nqZxSMuWHyMdI5mf1S+A9mPkaQcvIZpzKYATJAaJx9tlWCFksAqW12?=
 =?us-ascii?Q?gCHeYqLGU57VtDlf5CJGt/KaMKk49m9n/7PRSMY110XsYaY91jcOr+ZB6Ooj?=
 =?us-ascii?Q?SmtVPKrgQYGSYoQ8LI+mydiSnguU58i48GP+08jaTMq00DfbkqhTyP0G/mOW?=
 =?us-ascii?Q?h2E+MeqIk4sWac57T/y2AZHlYLesC7HJxk8UW3tbOZB84js+VrreKGZwmFoh?=
 =?us-ascii?Q?dVP5LvNiwppkCLAOVbACY7qgloP4cYsREzj5oAKMk/y8e9r6xGO3rRRq4wVZ?=
 =?us-ascii?Q?SudZrieA9rVM31gru/a2aPq0rLk3kYLuvzb+BtiZkyNJN1zpuhJGLzJUgLco?=
 =?us-ascii?Q?atfCW/Y7Z+O5CllORuHDadI8OrRRRZcoY5/T0x7be/B6Ytm9T0dkwOCnEDY9?=
 =?us-ascii?Q?MUpT2JlioktZ4RCDZjgs+mNGHaE8z8vCOqJWxukT1jDK2KBSRaUwjHnZBl/2?=
 =?us-ascii?Q?Xi/cLMr6K/JpKe5Fhi+QPL4hMh2H4+Lf0ENVaRewzsvg3cn5sofWJZpYLtYg?=
 =?us-ascii?Q?O0fibF3/z3zzkxLEseQMfZotg7yXu79YwgE2NcG+DBrskbpOKxqem/FPYq2J?=
 =?us-ascii?Q?5C1pLdehdd2XM2hvh59TIFmqpXKISxV3BHMcjrVJ8iu3WdFQvqoRkVFduetD?=
 =?us-ascii?Q?t8QPMLxOGtCab3WxjAxGnSz3LOeP/Qd2XcTHcSYp8e/nvDXlbJ31OS6+/2R/?=
 =?us-ascii?Q?wUBXwQW4+0JtLs47N/xqHzS4qktx/arlc4q4GOOcal76D/gAgRc1uYEDjD8X?=
 =?us-ascii?Q?u0Z6DMwWf+uBFYyfH7ZPzmBrogxzfsnFRy6VwRJopT04vCfMIETF6L+oBnLj?=
 =?us-ascii?Q?UT0y6Y0BRhHWXGGcs8GGZy9pDG2WqVOMh/5ndnVnnTzYAMCqq6o0l3QzUSJB?=
 =?us-ascii?Q?rfH9IOGY6RrhPMlDuu/VhvQoMAYL8CjxGGQD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:07.6645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed62bd5-e857-45c8-d3e9-08dd916f9a93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9666

From: Alejandro Lucero <alucerop@amd.com>

Add CXL initialization based on new CXL API for accel drivers and make
it dependent on kernel CXL configuration.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
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


