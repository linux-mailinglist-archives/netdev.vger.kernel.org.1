Return-Path: <netdev+bounces-178313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EDEA7692D
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074CA3AD41D
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD9321D3E6;
	Mon, 31 Mar 2025 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OVlHUPAq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4072153F7;
	Mon, 31 Mar 2025 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432383; cv=fail; b=MXTcK3CCbEUQQnn0+mj9hi3jGUaO3p4UhZtVuLhrcVA4Vtj0s990l0PmIOb1pTqvc98i1KcHkIzOHPh7L1WdPM1rTfxH45z2ZypfVRoWLm8J0IFLdldue8eN3q+mAeLEm1Tb2OUD5BRPjWwORPfclKNu03W2ReyYu3+lk9cKfjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432383; c=relaxed/simple;
	bh=z8oSuyqXr+KDx5lVm3kIUE69ABNl1NZdp1cnnJ0lZfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBQksnwbXHcgp710un7IPGMuDw6BfgtQ6QLcvpjQdL/0/u5s6ICyh55wwbY6tw34z17Bu9Cqt0d1k4D9WjypYvfH42AcKoEFYBO1vcr0goGCXximhzPRnirXEIM/wC7pFQBbTKTAYRV+cXoD3qwTfdu+URwJmpL3QGJ6Zbtq4g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OVlHUPAq; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xD+Qk+Pm/0kEHzySD5lf5y1kqDwEpmHYkkcQS09+dN2suFADhDRnQdRBjUtbdnAsVy5BNflf8jhRbTeKjyBstqDjUj9ok/l4/dQUgd1xck+olXPbNfXEUr1K3OqWMIjm0rNK4Uum6+d4IAgB89EMw47DJCMtCcWkJQZqpRJoxPInQxhK/Xo7EwTPhl4QvU8ueSmsjMUwocozdA5tlDHcEaM6IbZYnCzFKeNNxi+CdmWfZOQVT0c11s7aBfRlkHUf+18fcQSBjH5JhIlBQhBT5ROLezYwb+NhsK9FzXphW30BWrrdLT++fV1wG+kWlAyrrJpwvjY2u3kRkW9dh3I95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsxveOdemsrzyWA7/HThpEi0+sSo7PMGcdpGSwPEkEg=;
 b=piDV53tvPUP4q2ce5Y17VT3eXBo+AmiH+ueF2BnoSaI3t+ccodXco4bhXXeiELgDquamVEhKCXIBaxbcYaohKZupAm3NAJTngbzarYfW+5D3DMDGXVtXKENHqW55QvkGb5zfyNftpRIe8P0ILb+cUlSdemXoeyPbU1gTvPQhLgtUsl3aQa1100ZEqAaZhZb0AJmeAM2EXKhrzv/k1KaDPGxhAYUqMRNBT1FO+kkC2ru0MbRoeqV8fIIwbz4QA128V1J3RXZfJOZZVmTPOWO6Q38yR24Cf2zmXXWhRGu5Ropk1jo5KluLxfzZOoorxGAjBVUJJA3aRal/cZj1agDa/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsxveOdemsrzyWA7/HThpEi0+sSo7PMGcdpGSwPEkEg=;
 b=OVlHUPAqjXqEWvbZU/RVlywf0rQxWorqtV1iqUoV08IHfyglF1Y8/7v5gS7vgTp05CflJ2f2HxCaBG4QEh/6qvT0CoFbD+BsUg1f2dVVN3XrTJBeJjjIW/aeRI03tqsVn2CZGlg2uLcTMZNHzfs8P4YioqT+rFl53hhQmq0A0pE=
Received: from CH2PR12CA0014.namprd12.prod.outlook.com (2603:10b6:610:57::24)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 14:46:13 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::4) by CH2PR12CA0014.outlook.office365.com
 (2603:10b6:610:57::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Mon,
 31 Mar 2025 14:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:12 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:11 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v12 02/23] sfc: add cxl support
Date: Mon, 31 Mar 2025 15:45:34 +0100
Message-ID: <20250331144555.1947819-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|PH7PR12MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1fe59c-a9a0-4f19-5724-08dd7062c8d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TAMiRtItoOsFwIjgK7R6wycNbE3F3hEMG5Miw9S3RzjTn/cA4msEVTF4crBN?=
 =?us-ascii?Q?UtQUjDP6SceloNsAL+roS3ZlgXgaW83HKGMBNONM6NMG0ObzGaAnGOF1NsgC?=
 =?us-ascii?Q?c0weC11v2ENHARv5p0inJ18eF8kFObR5WNIGVjexh+Xhq2Pa3GWTY1ZE2xrv?=
 =?us-ascii?Q?pOyWaEuF1Y7B6uVyAukahiG9008IhsiM+hg/9jw+izEC4ZwfeFkhUIu61qXE?=
 =?us-ascii?Q?rpsJBFzDjMcVT6e9VXVHGiL5c19gs4J0e0hiCxWRip0ZI18QwY3n5M+PAPnB?=
 =?us-ascii?Q?f7rVLetXCliL7ZZO4nCzT34XTx4s5EOzYul4aB1RnKxtHnngSAGg46/LEo1d?=
 =?us-ascii?Q?8BOfkTgmHKjarQb9q1bHXQos0zy8e95ZxZcgEeIp557mp+N0RJ1Xcm2i/Bg5?=
 =?us-ascii?Q?BRs0L/bL+CPLBs74IUETaaSTmqiy6RZp4KWeikHYhe0owq4HAwX1s4F05Kqr?=
 =?us-ascii?Q?xFbtcaCqIMpZ9xV3ggOtEYepEgFFtlQWEO1CkKa1gDOVWSwpBX7k7cnlJrBq?=
 =?us-ascii?Q?gCSYnNZ5KbGww6hRZMaW2spabXg2VcOZhBYHQznEnFNPO2BhBn7XE9FqY43u?=
 =?us-ascii?Q?bmMWAltG9e7T2We9whsKw8zr8PVCE26l/hG1Nr0AqSTPGTr2ECMN1bl/lxCF?=
 =?us-ascii?Q?zPcTYLbQZxh31hATo/aLsKrnUDE1H3QuiCTDz1H275BOW1wuLye/fHFKCovW?=
 =?us-ascii?Q?NiyLGa/nI+BwLdCGYL8ic31paO27a1JWUwKn0c2q7GMAn4GuCoq7fzLYHaZR?=
 =?us-ascii?Q?diMsooT0ttkd5kSIOT8WZDXog2xWLoK9vnr2wS4kGUah96jGfg+6CY1UopS5?=
 =?us-ascii?Q?i1rNl6ghM/SUBCtfMvy+DXJqiIIrwKti8tEJBHgH3/S4UosAUGidwmM1EfzB?=
 =?us-ascii?Q?vm3uLaVghOKmkgFBCU7b+WVGPyTWM0Z8D5IDlUZgr04OvLKwmr596K9w1LC0?=
 =?us-ascii?Q?CRYi1EywneJgQjJHt2xlmOcu6lFNBLGI/MCLlVO0y94oSF3GKCzGTlW7zG0M?=
 =?us-ascii?Q?kMwXWGGmqA9pTcd8t/jLWviqLByHhijCck3ASD1i0l4ziVreAa9OyeOSkEVu?=
 =?us-ascii?Q?FaUHCAe3A+pGkdXimzJnpZgNR9MJudUjyV29XsXti8QnLWr1KPLom4C4GzeA?=
 =?us-ascii?Q?RuE00aq+NtbpjkrDTii70/EjvxBMPIcJNYGRH+WovZqacRI1fnNBkzQRrToX?=
 =?us-ascii?Q?I0MxzocHi7zg0BoD3tYjVmWkmLIM9zRdBpHRF3Y/1JabBcYEGw+hqwKcLcvw?=
 =?us-ascii?Q?4SB8x7IhmrG5bIJ7wgQPPZA/uZnxHp4WGGaDo6XV3s48ueMAmMN9ddl/A5Nc?=
 =?us-ascii?Q?QNYWbdbM21OQi49iUgxacbErbsDVoQNCwA55hKYe8JKIT/X3KwQovi8+817d?=
 =?us-ascii?Q?2vm1PVacMRip2nMkDbpcrIIU2dJaNAkhkRS6T3der5/N70scgbNZCCfHgpZI?=
 =?us-ascii?Q?Vf30R8+XcwC9qxpF+yrutGZAet9GVI1z8DHBz2omiBxK/ynKF0/WnlWNatFR?=
 =?us-ascii?Q?lt2QNdgY0DKqaGE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(34020700016)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:13.4006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1fe59c-a9a0-4f19-5724-08dd7062c8d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818

From: Alejandro Lucero <alucerop@amd.com>

Add CXL initialization based on new CXL API for accel drivers and make
it dependent on kernel CXL configuration.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/Kconfig      |  8 ++++
 drivers/net/ethernet/sfc/Makefile     |  1 +
 drivers/net/ethernet/sfc/efx.c        | 15 +++++++-
 drivers/net/ethernet/sfc/efx_cxl.c    | 55 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    | 40 +++++++++++++++++++
 drivers/net/ethernet/sfc/net_driver.h | 10 +++++
 6 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h

diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index 3eb55dcfa8a6..c5fb71e601e7 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -65,6 +65,14 @@ config SFC_MCDI_LOGGING
 	  Driver-Interface) commands and responses, allowing debugging of
 	  driver/firmware interaction.  The tracing is actually enabled by
 	  a sysfs file 'mcdi_logging' under the PCI device.
+config SFC_CXL
+	bool "Solarflare SFC9100-family CXL support"
+	depends on SFC && CXL_BUS >= SFC
+	default SFC
+	help
+	  This enables SFC CXL support if the kernel is configuring CXL for
+	  using CTPIO with CXL.mem
+
 
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
index 650136dfc642..f60f9153f018 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -34,6 +34,7 @@
 #include "selftest.h"
 #include "sriov.h"
 #include "efx_devlink.h"
+#include "efx_cxl.h"
 
 #include "mcdi_port_common.h"
 #include "mcdi_pcol.h"
@@ -1004,12 +1005,15 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
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
 
@@ -1214,6 +1218,15 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
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
2.34.1


