Return-Path: <netdev+bounces-163037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA030A29456
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4903416756A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D1115FA7B;
	Wed,  5 Feb 2025 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3v7++fH7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29B8158536;
	Wed,  5 Feb 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768806; cv=fail; b=S0EBt8ccxH+22kMIIm/UJadNBrz2KLl7LjtlvxmHios202pUMcQvOSvcR0Lbg1muL7S88xjsE11wIthPXwlvuZgqQ8vHWtJ3usTZVN9lFtEo7IU638/PRK8E6yOO2MuTN8NIG20zTo74CokfggURGCrfFf6m16CrrhFqcvJ82J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768806; c=relaxed/simple;
	bh=22W4mF6qlO4nQy4md+dxWDyx/aHT8FI++4lTdPsgh8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pIOJUNztP7sUtQ4B9qf6DVGNeBKE4uEKqeSHBHmS7uwzeWP3dKMEXrcRKgUcLsNY53gG2GGE8mv6kNSnAxgv+E1E121M9wo9Ii7wlKCZCqei0NB4P2oegwLo9dCqHhgLLiJqj0xWd9TYuHOrzi1KimtzlEOo1IGXSIQiTfuzFiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3v7++fH7; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjkTKUk6zq5SLB0pMbCf3kTcVo7jRniTx2VZOWOfGRUNx+SfxH3EBGVyG0Uzhco7w2uTSBFWQBNgsk/HnWZH1WZfzvrSasQkrnfN6UCDrqqEcJttT66bGtntczAlNsM4X0D83Q9WCu/n5Zpi4cDGeJDrZewezMq9nyx8dnfFxKQHXnFHiCwb+jEL0EXRO+L5XyQxSlc4De4nVtSIFH9EZ0kqUMcIc9rgxzlGUki1N09wk7SV19k5evUlcAcp/l8IWvNj92cLBD7OYEWO3R9NNOODAst7/6ApoEYG+rFOSbVVHVOhdt2RUq4ITQYZdjTfR3DITB2IfgKDfuEUCbVxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljp9HolJ/Aj5quLk27h3uInIVcU4H9/ZpIaqa/MY+0s=;
 b=tzQ/9FUDxi6Ka+PFUAD6/6AL4WyU7Mn0l2uPdv3JMf7D87OHW36iNX1ngdOWxL4sZqxeBo0h8wFRFd/k3u6bg0Ln4dwRAuUKt+UxFaLYidexDiAE1YCnhaiMIH77glTSniafbC9Rv6j8MEtgYZ2MHkLrau446CWCT5vYImYiCyG6gsE99xgkBDn9vcdkNSkb9jLDNtS5JqIL3m40JI7BC06t0RXFMQhdu9wwmT0UWWmd9jf7SlnrgZSayrLXrobf1ung+bX5JS2k0luWReR+TS9rJ7aQpcP6fIDiBoVK4BycwWdchpF0MEydNUfW87GlOYFUKtL4OBK6snKgPZXzqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljp9HolJ/Aj5quLk27h3uInIVcU4H9/ZpIaqa/MY+0s=;
 b=3v7++fH7Udsb7rNfrkTE0HlF1yUUcZWQPBV8bekey8iO0tRPZZA9YhA3vgvsTUB+FWWXMjAU3QbTdFld9Ju65DcV4KOI2OfI5GNNQ3eJyCapVEIYUvUDX55xZ/C1PuoWd5mjIK6NFqM3H3sj404Ldp2+hCF/0EH/6ZkCAUjyB1Y=
Received: from SN7PR04CA0011.namprd04.prod.outlook.com (2603:10b6:806:f2::16)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Wed, 5 Feb
 2025 15:20:02 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:f2:cafe::10) by SN7PR04CA0011.outlook.office365.com
 (2603:10b6:806:f2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 15:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:01 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:01 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:00 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 02/26] sfc: add basic cxl initialization
Date: Wed, 5 Feb 2025 15:19:26 +0000
Message-ID: <20250205151950.25268-3-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|BY5PR12MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1e99d6-b038-4c0c-9fbd-08dd45f88faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wvn3YtDiOD9O++LU0rF6OCHRXCyNRO7268L/0UgevFnz1B3HBJZQUPV7ff3K?=
 =?us-ascii?Q?zL/u+G2fs34CTxwE3PfbNAyrXCFUOVFpVyp/hfzADbpZZorm/yjPV/NEKGn9?=
 =?us-ascii?Q?fmlVmgKqXb8EB8HP3PHXwg1jPgsI69XAXyYyWhAK5wrkuvsXt7yQV/36qQul?=
 =?us-ascii?Q?llZsbtqNa4m3J2Vt4zmoS1T26IVpzmOnlZ0HYs4M8Wxjy73T/8yjSTzhbZ1o?=
 =?us-ascii?Q?i5aaCK5alXoJsuZFgRW2zrSnjBhkGp8iC8tfAOG1gRCj3AiTJLvHMaG5Pdze?=
 =?us-ascii?Q?/6OHr2eK0RIh3B4wZXvETNOJ5gzDMO7YLb12T6GbafEOaRT+xUG4tcSn3//Z?=
 =?us-ascii?Q?dGO5lcmxJZ+DS9cohhmMZE62SBPcMfTdZCiDekGkgIUC1ZKW1ju6C8Kjrb7C?=
 =?us-ascii?Q?90rpCh/WF4I4w+2ZCV6VKLjYX3WdTaZ4XAK48/jfAinjl13Qxis5L5JQa+7G?=
 =?us-ascii?Q?qRiEconW/wfkWTxt2Sd59zdk7UAXy8DGLuOICX9AmuPhHA5rlTPkEM3KvdYB?=
 =?us-ascii?Q?kQ1VCM0/nWkkDN20B4sNa5mIF0Itd5Jz/ctpWmkBqAJawGZEegXSsTbXT8BN?=
 =?us-ascii?Q?G0h3Fa9k1rWsyMqS6b17xS6XULMS+kU5ha3V4dDO9rsu3wm7dswVdb2tR+Bf?=
 =?us-ascii?Q?q8si0a4iYowFM4c8RHtbf3oeR6pTQwo+GGkiYl5cYsrR59Sh1Xl9/OiL7tWI?=
 =?us-ascii?Q?9dG0V+9dk/Br/vDKQwW98NZfrIwn/cg/pXUa61vTkOMEmRHl4SYJa/jD+dtV?=
 =?us-ascii?Q?HEU3xWbHX0UGAIlD8WbCCVRe37qW2InPFBhEsKJTvkiZmNXNavQe77hzc6FE?=
 =?us-ascii?Q?MMR4l+ITC63Lg26PehgL8fozzHQk0aYOkDMeMFZIwwkUdigUFGtdLI2vo8cP?=
 =?us-ascii?Q?fyxCr59pZd+71kuxIoxkjTDpa0mJorxSZuvhuf4aeRdphmC5xy5t6k7bGixQ?=
 =?us-ascii?Q?gtkLuuHSWHrWomkLH/E7M502OeXpVtt3yP3nnbp58wvChD70pXrjiVX58XLW?=
 =?us-ascii?Q?zjhYlX8MSNGHLx8lHBWR4oaRG+EUSH2Lpz/Hxo9KE08gvkzVjdIBXumEAaUI?=
 =?us-ascii?Q?pUVydj2bJ94MQQ/MbH1nZpMCEMb/EufXZacJ2wYkXFqaFfAsvNU8DcMDDUX0?=
 =?us-ascii?Q?IuAIuFzseDw5P4yXdrtLRO5SfA5AWVyiuJMyaZmzePoE/FywbIwepAs43HCP?=
 =?us-ascii?Q?Fp6g5y2TEoZeSuGpK1Xk3QVYAkzOg12nQxdHnnuBSaE3wMpA6dsKEBvwNWMC?=
 =?us-ascii?Q?95Ia0U48vor2uhFkHtjvNsJ9NXkkiYt89fARRMcr7PS5KfeczI2bejE4Mnkv?=
 =?us-ascii?Q?jiMam3o9xEXC3sklXoeBj0uHvD6yFThxL6eRQed5glu2aTLNVb+FBhJWMl1b?=
 =?us-ascii?Q?iTBf1JGjZxnAYiM2reFug05KacD05IZWRF5Dui0fvpcIuEVqdXDlWL3fkz24?=
 =?us-ascii?Q?ltSyGt0WlOECMtonY9N1NdzSJ7Q53sV6eOoWLrw1AFCBeMEJihqKD9AhfMPx?=
 =?us-ascii?Q?q3UIn4KjZzSu2ZA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:02.0070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1e99d6-b038-4c0c-9fbd-08dd45f88faa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209

From: Alejandro Lucero <alucerop@amd.com>

Create a cxl_memdev_state with CXL_DEVTYPE_DEVMEM, aka CXL Type2 memory
device.

Make sfc CXL initialization dependent on kernel CXL configuration.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/Kconfig      |  5 +++
 drivers/net/ethernet/sfc/Makefile     |  1 +
 drivers/net/ethernet/sfc/efx.c        | 16 ++++++-
 drivers/net/ethernet/sfc/efx_cxl.c    | 60 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    | 40 ++++++++++++++++++
 drivers/net/ethernet/sfc/net_driver.h | 10 +++++
 6 files changed, 131 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h

diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index 3eb55dcfa8a6..0ce4a9cd5590 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -65,6 +65,11 @@ config SFC_MCDI_LOGGING
 	  Driver-Interface) commands and responses, allowing debugging of
 	  driver/firmware interaction.  The tracing is actually enabled by
 	  a sysfs file 'mcdi_logging' under the PCI device.
+config SFC_CXL
+	bool "Solarflare SFC9100-family CXL support"
+	depends on SFC && CXL_BUS && !(SFC=y && CXL_BUS=m)
+	depends on CXL_BUS >= CXL_BUS
+	default SFC
 
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
index 650136dfc642..d34d136c3650 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -34,6 +34,7 @@
 #include "selftest.h"
 #include "sriov.h"
 #include "efx_devlink.h"
+#include "efx_cxl.h"
 
 #include "mcdi_port_common.h"
 #include "mcdi_pcol.h"
@@ -1004,12 +1005,16 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
 	efx_pci_remove_main(efx);
 
 	efx_fini_io(efx);
+
+	probe_data = container_of(efx, struct efx_probe_data, efx);
+
+	efx_cxl_exit(probe_data);
+
 	pci_dbg(efx->pci_dev, "shutdown successful\n");
 
 	efx_fini_devlink_and_unlock(efx);
 	efx_fini_struct(efx);
 	free_netdev(efx->net_dev);
-	probe_data = container_of(efx, struct efx_probe_data, efx);
 	kfree(probe_data);
 };
 
@@ -1214,6 +1219,15 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 	if (rc)
 		goto fail2;
 
+	/* A successful cxl initialization implies a CXL region created to be
+	 * used for PIO buffers. If there is no CXL support, or initialization
+	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
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
index 000000000000..69feffd4aec3
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -0,0 +1,60 @@
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
+#include <cxl/pci.h>
+#include <cxl/cxl.h>
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
+	cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);
+	if (!cxl)
+		return -ENOMEM;
+
+	cxl->cxlmds = cxl_memdev_state_create(&pci_dev->dev, pci_dev->dev.id,
+					      dvsec, CXL_DEVTYPE_DEVMEM);
+
+	if (IS_ERR(cxl->cxlmds)) {
+		kfree(cxl);
+		return PTR_ERR(cxl->cxlmds);
+	}
+
+	probe_data->cxl = cxl;
+
+	return 0;
+}
+
+void efx_cxl_exit(struct efx_probe_data *probe_data)
+{
+	if (probe_data->cxl)
+		kfree(probe_data->cxl);
+}
+
+MODULE_IMPORT_NS("CXL");
diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
new file mode 100644
index 000000000000..b9e4ef4559c4
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -0,0 +1,40 @@
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
+#ifdef CONFIG_SFC_CXL
+
+struct cxl_memdev_state;
+struct cxl_memdev;
+struct cxl_root_decoder;
+struct cxl_port;
+struct cxl_endpoint_decoder;
+struct cxl_region;
+struct efx_probe_data;
+
+struct efx_cxl {
+	struct cxl_memdev_state *cxlmds;
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
+inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
+inline void efx_cxl_exit(struct efx_probe_data *probe_data) {}
+#endif
+#endif
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index f70a7b7d6345..a2626bcd6a41 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1201,14 +1201,24 @@ struct efx_nic {
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


