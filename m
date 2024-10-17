Return-Path: <netdev+bounces-136664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961119A29BD
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DCA12838FA
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA8B1E0DF3;
	Thu, 17 Oct 2024 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hk5995lU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8473B1E1C05;
	Thu, 17 Oct 2024 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184003; cv=fail; b=FdRqgSA5BkMHqzaGXa2yPrX72H+iPt0R7+NcpCKW8SrWVBUSVIEGxMUoc1wQweU0tWU4OK8zCwRUOuiL4wwP2H927LYeUAL/EDHJ/OpVn4P3FsWz8Q/E8eYim2GJHeAGamKA4rDLb05ZswDhghj79z4TDFq6Xbp39ZRwBcOg3/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184003; c=relaxed/simple;
	bh=LsAZ3ReHLQo02uRYNZzVZ0SkWQys4lQuIaEOkoi16HM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cglw4xdrtO2+D44sy0jlUS8Ij/utJo5s5aRqh6KjQXpdiKxt23gwmoLtQxH1VfAXc0dMPxNLzi/zigTHM3GgoRsT/E87OlEyoHIuFAmb00E6qsyQiMcEFq5KclvHCO8kEue9kXdyR40jhL8UdFh+PpRxX+F+sHBEp1VuHxa+6rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hk5995lU; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHedz/HCez8noD4oWx1KdC34unHJw+CfCf8jvSC/DpjRbmdsapli/WVMZn9zZUMzgr6AyYhmoZNRz8x0l0mWvz5nC+7/mpU1SkE2P8m4qY2X/+OHUM4LLLOtXbxvRJ2/nPQunW3U0iKpYP1DR3KdaOyeLxgg4fq77mTXl5KzWIME53OI9V0vYmcKRtmezbQejEbw1HFXEYOr2rJiDgDTUR63GrIFr+pHXdg+50HC6vF5Gwcdj4tKmuqhR2WpAv9P/Z1GlNlRP3hnOkog/t6+xy3ufC+WohfCtlsNWg+Bx3HP3NxW0ctOnvQ42diikw8Si6Tz8QLnm7zWEkAUDH3uAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF7bNIO8pk8MbwyJVRMhC8ITbfwjc1nvzSpCtco35gE=;
 b=NytM/5lSFrmXbr70i+KHBODieY5pL7vpR9S/UDQd2lMnusSE91pU0tiPlH5LeljIy4+2E1GZ9HTj8tfl+KXkyt9w6AZNa4F8LgYPmWHLwFxtM3CeRP+1SoDMd9D5+OXJHnLWCefYNwZDlyz3/dFpSwHzMAsoiJTKozaU3skQna6WMBW2FGglnxyfmbFqHxs+6EHe5RMrSvwvJVJw8qncCxVKRjLUVo1ImAfE3O849cdHI5boEXdf9Egq/M4NoEfsd5Iem+MSPn7+aqXJeeKba9RKU/iDxUuxikYbScUkGQuLaSaGlvTpS7N1wL3iHVNqAKztgtHX350H9YYeCKmP0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF7bNIO8pk8MbwyJVRMhC8ITbfwjc1nvzSpCtco35gE=;
 b=Hk5995lUS0CaZsbFQ/TtsNiZtmL2WjastqLgnsD4UyQX2bpjqG3yYsWnkGwGZq0stri5EF/57xtNSaN5fU900SzTT2j5Ilk2vwfv4DSWAeuVRESHLhLOr/6tvokqrXzHsCk5PwHTt5ql/1FezdnzKqZDonUcVtRvloq/3Hc9Fpw=
Received: from BN9PR03CA0909.namprd03.prod.outlook.com (2603:10b6:408:107::14)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 16:53:15 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:107:cafe::20) by BN9PR03CA0909.outlook.office365.com
 (2603:10b6:408:107::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:14 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:13 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 02/26] sfc: add cxl support using new CXL API
Date: Thu, 17 Oct 2024 17:52:01 +0100
Message-ID: <20241017165225.21206-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 41609d36-921d-4755-9a2d-08dceecc31aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yIU3ExmY6YJZfQqquRscMWfGULYJp577AiLyPZDGsKmRvTAg/HRiRDGJnwQY?=
 =?us-ascii?Q?BZRNTR+rqP7lSmRACOqCVVQENR147FugeBUBV7CX4SBe+5cFO9QP72sRj7zH?=
 =?us-ascii?Q?FvdPb/ngYwNj6Gs6nqNQgaRT3pU3/3N+wZdUawj8SXAKXUY+BciRv1u3bnMc?=
 =?us-ascii?Q?f9wH1njrstnAmLNuYJ0F59BfT2D7gm82K8idTOz8ik+5wKMWm5J/t8lwCY9E?=
 =?us-ascii?Q?y2xOdWNK/Lp+4e+GZEpxWAPSYZddTyW1MDliXi48plzEnK63kWAhH3SKdAOM?=
 =?us-ascii?Q?MdA8PXPpWNjmTa1JPWpY8ZuXfroL0JQ/PbqQ85y2oSa8pub5C/Un1SGUrJnq?=
 =?us-ascii?Q?L/Pk+FRvlR9u7kVhk6MCMo4FO9qm4k7Zb5NG0AD7OmtAuSY5r1356nRzwGpT?=
 =?us-ascii?Q?DsYsRdwHvpXAFrd2c5nza7LieM9rxwjQv+QtRsWr4R8D+mywx/CON2UHikOo?=
 =?us-ascii?Q?wAj+QcduFawW52Rvrib40fqxr6PavHMcPGzYW2M4ksOviD65iU3nAzc/Mfj0?=
 =?us-ascii?Q?AUwwXolDXyxpR6fELgieqmzBPxI44BxhqW4fkQz/1ddW+/5wlOMdUiTaNzS1?=
 =?us-ascii?Q?5VXtD5FUxYEiuqHuJZ5jX8vfRfBlEcg5xrb7Mt56q3gBL8zlvepTzcDsR043?=
 =?us-ascii?Q?/PSv4csnxlIrI1IOrProwd0PjF8acLvaEs8REz9bT2O0E0UhrUsfVv085doO?=
 =?us-ascii?Q?GgF9Lw8uuvKQivg++XQ1lo4nBT8H5QknCPXWalxht5b4Y4SAPqef2Klk0FWx?=
 =?us-ascii?Q?M7eGTk40xRiKNqu5eUOOy2uBNKHXxSmgrByc98ykfd+dDyXAS6Jm+niajMNE?=
 =?us-ascii?Q?CpmjjpcdFrfUXBFv++npJtuLtppAPdUwvML84cvWp1as7892R7s0+FKlfd0C?=
 =?us-ascii?Q?7a6LqTcd413rqp31WjG6QJpWGDuTbRVy5+cqSYPxW3/iqnGACr/KCwkvexJk?=
 =?us-ascii?Q?1ZyqHO8x+0gizsH95vx6eWqytkNIw5LihRES+KvDVxAFLgmUdpwi0cjOuxZv?=
 =?us-ascii?Q?JjNEA5SkQ3A7nySTYK1qtQiMgIAJvtI3uDmPKNs0oRgq80fWOK4n/WsHfXUY?=
 =?us-ascii?Q?FQddwbn+HNUynFUdjR9+Yq9TLCDvOo0WXKi5h2/B+7vKP9cJImShbQmQJq0n?=
 =?us-ascii?Q?bb5WWNU8flE0TpuDdpQkuyVekfR6lnHd9chtJQrZZmPL8BXJM+ZmFCvaVrNo?=
 =?us-ascii?Q?s3081GGZIuCUIdFLcIbE4K0588InGOyKRv8djOeL5XaaR5fQUaSMIfuzVwsO?=
 =?us-ascii?Q?RusjEKXOEa3Fr2FC/oxE43LE/fIAUbwshhTAhiGKhYKfTag/IxE98vZMKY/0?=
 =?us-ascii?Q?vQpX03itOFjnTjsHyH+p8PBYssG56HpvPr9Lxnhoi4upXX2MzmSADMPgIPwJ?=
 =?us-ascii?Q?B1ZeY3JVsibEpxL1MKe7XmEVMsWmF+k/Dv02GrquH4qVPp7ZUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:15.3146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41609d36-921d-4755-9a2d-08dceecc31aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343

From: Alejandro Lucero <alucerop@amd.com>

Add CXL initialization based on new CXL API for accel drivers and make
it dependable on kernel CXL configuration.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/Kconfig      |  1 +
 drivers/net/ethernet/sfc/Makefile     |  2 +-
 drivers/net/ethernet/sfc/efx.c        | 16 +++++
 drivers/net/ethernet/sfc/efx_cxl.c    | 92 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    | 29 +++++++++
 drivers/net/ethernet/sfc/net_driver.h |  6 ++
 6 files changed, 145 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h

diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index 3eb55dcfa8a6..b308a6f674b2 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -20,6 +20,7 @@ config SFC
 	tristate "Solarflare SFC9100/EF100-family support"
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
+	depends on CXL_BUS && CXL_BUS=m && m
 	select MDIO
 	select CRC32
 	select NET_DEVLINK
diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
index 8f446b9bd5ee..e80c713c3b0c 100644
--- a/drivers/net/ethernet/sfc/Makefile
+++ b/drivers/net/ethernet/sfc/Makefile
@@ -7,7 +7,7 @@ sfc-y			+= efx.o efx_common.o efx_channels.o nic.o \
 			   mcdi_functions.o mcdi_filters.o mcdi_mon.o \
 			   ef100.o ef100_nic.o ef100_netdev.o \
 			   ef100_ethtool.o ef100_rx.o ef100_tx.o \
-			   efx_devlink.o
+			   efx_devlink.o efx_cxl.o
 sfc-$(CONFIG_SFC_MTD)	+= mtd.o
 sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
                            mae.o tc.o tc_bindings.o tc_counters.o \
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 6f1a01ded7d4..cc7cdaccc5ed 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -33,6 +33,7 @@
 #include "selftest.h"
 #include "sriov.h"
 #include "efx_devlink.h"
+#include "efx_cxl.h"
 
 #include "mcdi_port_common.h"
 #include "mcdi_pcol.h"
@@ -899,6 +900,9 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
 	efx_pci_remove_main(efx);
 
 	efx_fini_io(efx);
+
+	efx_cxl_exit(efx);
+
 	pci_dbg(efx->pci_dev, "shutdown successful\n");
 
 	efx_fini_devlink_and_unlock(efx);
@@ -1109,6 +1113,15 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 	if (rc)
 		goto fail2;
 
+	/* A successful cxl initialization implies a CXL region created to be
+	 * used for PIO buffers. If there is no CXL support, or initialization
+	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
+	 * defined at specific PCI BAR regions will be used.
+	 */
+	rc = efx_cxl_init(efx);
+	if (rc)
+		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
+
 	rc = efx_pci_probe_post_io(efx);
 	if (rc) {
 		/* On failure, retry once immediately.
@@ -1380,3 +1393,6 @@ MODULE_AUTHOR("Solarflare Communications and "
 MODULE_DESCRIPTION("Solarflare network driver");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, efx_pci_table);
+#if IS_ENABLED(CONFIG_CXL_BUS)
+MODULE_SOFTDEP("pre: cxl_core cxl_port cxl_acpi cxl-mem");
+#endif
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
new file mode 100644
index 000000000000..fb3eef339b34
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -0,0 +1,92 @@
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
+#include <linux/cxl/cxl.h>
+#include <linux/cxl/pci.h>
+#include <linux/pci.h>
+
+#include "net_driver.h"
+#include "efx_cxl.h"
+
+#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
+
+int efx_cxl_init(struct efx_nic *efx)
+{
+#if IS_ENABLED(CONFIG_CXL_BUS)
+	struct pci_dev *pci_dev = efx->pci_dev;
+	struct efx_cxl *cxl;
+	struct resource res;
+	u16 dvsec;
+	int rc;
+
+	efx->efx_cxl_pio_initialised = false;
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
+	efx->cxl = cxl;
+#endif
+
+	return 0;
+
+#if IS_ENABLED(CONFIG_CXL_BUS)
+err2:
+	kfree(cxl->cxlds);
+err1:
+	kfree(cxl);
+	return rc;
+
+#endif
+}
+
+void efx_cxl_exit(struct efx_nic *efx)
+{
+#if IS_ENABLED(CONFIG_CXL_BUS)
+	if (efx->cxl) {
+		kfree(efx->cxl->cxlds);
+		kfree(efx->cxl);
+	}
+#endif
+}
+
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
new file mode 100644
index 000000000000..f57fb2afd124
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -0,0 +1,29 @@
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
+struct cxl_dev_state;
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
+int efx_cxl_init(struct efx_nic *efx);
+void efx_cxl_exit(struct efx_nic *efx);
+#endif
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index b85c51cbe7f9..77261de65e63 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -817,6 +817,8 @@ enum efx_xdp_tx_queues_mode {
 
 struct efx_mae;
 
+struct efx_cxl;
+
 /**
  * struct efx_nic - an Efx NIC
  * @name: Device name (net device name or bus id before net device registered)
@@ -963,6 +965,8 @@ struct efx_mae;
  * @tc: state for TC offload (EF100).
  * @devlink: reference to devlink structure owned by this device
  * @dl_port: devlink port associated with the PF
+ * @cxl: details of related cxl objects
+ * @efx_cxl_pio_initialised: clx initialization outcome.
  * @mem_bar: The BAR that is mapped into membase.
  * @reg_base: Offset from the start of the bar to the function control window.
  * @monitor_work: Hardware monitor workitem
@@ -1148,6 +1152,8 @@ struct efx_nic {
 
 	struct devlink *devlink;
 	struct devlink_port *dl_port;
+	struct efx_cxl *cxl;
+	bool efx_cxl_pio_initialised;
 	unsigned int mem_bar;
 	u32 reg_base;
 
-- 
2.17.1


