Return-Path: <netdev+bounces-152279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D10549F3576
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BFE57A33B2
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D35320626F;
	Mon, 16 Dec 2024 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sMqnir8N"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2147A205E07;
	Mon, 16 Dec 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365463; cv=fail; b=NzFo4iHphFt3khoXZ8FgPuCIbWm043kvJaf+IFJPL0PUEBLkLWt88xchPLwEQxmBud+knrbnGPKeDeIhPN1ZO1AnCvZZKszLq/GVABs28kTMCoIODmsFps5U0UGZt/LRx5lHpl4m9k4uhRJsxvAAPRW+/9xX66gP3et5Hb3v8rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365463; c=relaxed/simple;
	bh=jhMvVYG8O5qbCVSV20tVFB3CU1BPV19Adb+e9cVFLao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AH81zTkkRFhWTlzrK61zwN6Th/71EIt2eYK5ltku0wP0b/qXWw+y2JOJnnIBcyC0SW36EEjLU05HD1owXPp0VsLj9FNYkqctgwRGauxCs7mWNZRYecX/d4X29+JY7d25egiRxM3DLxoKSO1mZzoQne4YW1u3rUIaMh22Flz4ges=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sMqnir8N; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1Iz7ZVPeNMSxRA9D5vGoMQx0l+kn+gVXWeL61Ola4uOA8lOnsKBitaYJiu7SSSLRG6nzcsVxtTR08VHG0lrYirqko8UKkiLpstEmVhFCvNNWyZPPfhdYibrkHvmTUbI+9Wy+yi74pK2+Pdsm3G2C1+kUzAyU94GDE2q0BpScepeomzm4jPkYfS3DG36UncL7HX3WhLAecC4ciPhJ3ctbPWahlglRPg7C+CxKtvQMTOkctlKh0NN//cQ3qy0jcRGvP4xrgIKrWPeyH3YuZUPFhSCAuJo4Xa/qrvDPVg9N7ahrquwUMmmU4njKaC2sW5u02Fn+CEafbKFb+duk4jxvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/RVHFXqUorJUxJrilamvx+ARLhobHL1mS9kS66H4fc=;
 b=EZ5AkAMGZN1TGabfHdwM9tdjeNijiRaMtWJ+9MtZtScftNNWaM8ia199PFoeOWyAoAfzoSYrcwIYaHQham4EHzcyiq0Dh6P//cwDlW0LCou35jUAtfY6ZwnFYwUg6wBURVMhS1x2mMb9kbaVNvpEsRIdOp2irdmNtG/xwdSiZSKB7KblcGdoLoIkSOlQDNRbYMjhDpP1QtE4kmzjar9DNYpiv32D63IvliTnHu9WNGKCbMNHFuzRNIXmTQTwglmBraqijIV2828qpGRVOP/7ooBf4reOEmchoXuXhrOnYg64VXfodbDkMgn2wg9S5XsQhTk4aHKSPqttf+CLl88yWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/RVHFXqUorJUxJrilamvx+ARLhobHL1mS9kS66H4fc=;
 b=sMqnir8N5KZkJntms0J/Ccn7LM6WXton7/+TU4O+HY7xS/w5rEgF4nCtJSlumY9CnuKQfeVyfBSYXEkAJ3HUMVmklKyO+Hwxwa4KxFzCt77a1NYlTkwBy6E6kjqmd+aP5+TzhNkRonvyYz8N85RizjjjVcRGiXhQUar2d36FHjE=
Received: from BY3PR04CA0027.namprd04.prod.outlook.com (2603:10b6:a03:217::32)
 by PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:10:56 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::4) by BY3PR04CA0027.outlook.office365.com
 (2603:10b6:a03:217::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 16:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:10:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:10:54 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:10:54 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:10:53 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 02/27] sfc: add cxl support using new CXL API
Date: Mon, 16 Dec 2024 16:10:17 +0000
Message-ID: <20241216161042.42108-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9b7f52-840a-472b-9dc6-08dd1dec38e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?md3rcI5krPqJbp1pQ4pLqItjAtbGyO+5qsWp9YtJCAlOgNf/IjfPRsV1CiBE?=
 =?us-ascii?Q?CABscBcDZjezI9GP3DIQjF2fkcK3fM18lFjmvo3RK6zh8WKUUr9ac7lCExia?=
 =?us-ascii?Q?NOqWvefV3hdGTaaZFjqXKWrI6oYYJNu7JTdhncc8X7Qlqy3s+m0Vh1SFOe4s?=
 =?us-ascii?Q?KTEuoh9RloxFXeCYP5kw6Tcrlpb7BBHyTp4sTgLROFU36Q1WEwr/1CQXtzYl?=
 =?us-ascii?Q?j0p8nqA7JA79Mam7YdUePQOPuuJ38iUNeDG1CzdlY+92lw8UYbQB6/mhEHlL?=
 =?us-ascii?Q?shE8AKVmVJGnhgCSba9G72CMvUnY/jVzQSVu3bTCkd8xcRtY2V39SjJr1Twf?=
 =?us-ascii?Q?KjzH+QMcTaxvNcKizWMaxk/UCzbiKKUkt4XG0MI4LjvACvoiMCrwWXLzJ+Lm?=
 =?us-ascii?Q?9yZJb8yMr8FWJ6pDUR5idjmOJFn/T1G7OP2he0F/KKwm8tTjYam2t8Ci+riZ?=
 =?us-ascii?Q?A/l3YxWdbnmOJuw69ML0jjSjUbsF1DgHgSsPURDfKPyVUSJrsoIJgityg/T/?=
 =?us-ascii?Q?NrirAI87XjeKLlRXUlz/UIvWeou8CCyQFp2RD2HDHPxGoPtWwbZGR8ltLgSG?=
 =?us-ascii?Q?P6tUv47KjlGk60KtTCSCO3oVqwsxpvX7xdXWYOn/o9ZPozWicdNk7AtoYbHC?=
 =?us-ascii?Q?FiNz2Ad1d6UrhIwvFN/jIq4r6okmkh/LOYh+6zyUxSoizKoHtHr9Y57FzoX5?=
 =?us-ascii?Q?PyD/orBrgmyYHld/0S4SJ0XSk7mGdLXnrBOrOniM2RbW0Z0OwRI496wtfsQf?=
 =?us-ascii?Q?K9d5Vn0nsySJk+vfXEiULi2qxMpeaBEK8hCIYVAwC2bjnr2nlvx3gGBRw8JH?=
 =?us-ascii?Q?XhAFQ9Wnjyutr+3VLsjlVPPA5IOPkjOeexlsRMyyomy+ZSKiPLrBmE/BIwlO?=
 =?us-ascii?Q?rz/E+zp6FKM9xywKd21UsNTvGpJMYzRHyEEBY1TxKACcLxyU4oNE8foo+Zmp?=
 =?us-ascii?Q?ogs9fCWI+fhB4nWuQz98v/JHUSI67LPuU1eGFd8mSObWC/7NrcYNZK8BlCXB?=
 =?us-ascii?Q?pwJJosahqQbGw0bHEHROcim7xEaZheuE3X3wEYHuoLwALNOgYtoz3zSfb3oS?=
 =?us-ascii?Q?+N0H0QBzz8Om0RO/cMC8BSEXj7vjCtOf15DEtbEjVlgngUYkAGFQ6AP0qb+1?=
 =?us-ascii?Q?4QTK3F7bBEbIrvmd6A8rrurBUQZ6FoQI9LbMWXR3l6SgMvNwgy0zGN4F+wb4?=
 =?us-ascii?Q?ucyfFcl6p5LvWdFioceBPn4hqglVRT4fvReAGT7VJ8Qt6dR6Xg+s4eqgiDD/?=
 =?us-ascii?Q?ZYJKGMFpP6LZJociVVBEItzDGsXGZJRHp/cjuXg7sloIu36q5lY8QIKfPtWO?=
 =?us-ascii?Q?y29xpqtrjlrx++tObzMpsLTxpnXLMMoQfQlbqoCEkfdMprSC7yDlCjawW73W?=
 =?us-ascii?Q?elIx99+IcyEEIyU3csHgDWxZb3ol6tZx3jJl6lIUXP3YFWDBnhdxzIbYOW0P?=
 =?us-ascii?Q?uw2aEMVAsMTy9Gn6UerOb3xwim4XpgvnDzX6GMK9hg5Ts+odrNcpEPaArXBU?=
 =?us-ascii?Q?JlJJe6TDeJfLPlgFXvwYHJCnW4juI2xJ8e/O?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:10:55.8647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9b7f52-840a-472b-9dc6-08dd1dec38e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617

From: Alejandro Lucero <alucerop@amd.com>

Add CXL initialization based on new CXL API for accel drivers and make
it dependent on kernel CXL configuration.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/Kconfig      |  7 +++
 drivers/net/ethernet/sfc/Makefile     |  1 +
 drivers/net/ethernet/sfc/efx.c        | 23 ++++++-
 drivers/net/ethernet/sfc/efx_cxl.c    | 87 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    | 28 +++++++++
 drivers/net/ethernet/sfc/net_driver.h | 10 +++
 6 files changed, 155 insertions(+), 1 deletion(-)
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
index 650136dfc642..ef9bae88df6a 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -34,6 +34,9 @@
 #include "selftest.h"
 #include "sriov.h"
 #include "efx_devlink.h"
+#ifdef CONFIG_SFC_CXL
+#include "efx_cxl.h"
+#endif
 
 #include "mcdi_port_common.h"
 #include "mcdi_pcol.h"
@@ -1004,12 +1007,17 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
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
 
@@ -1214,6 +1222,16 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
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
+#endif
 	rc = efx_pci_probe_post_io(efx);
 	if (rc) {
 		/* On failure, retry once immediately.
@@ -1485,3 +1503,6 @@ MODULE_AUTHOR("Solarflare Communications and "
 MODULE_DESCRIPTION("Solarflare network driver");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, efx_pci_table);
+#ifdef CONFIG_SFC_CXL
+MODULE_SOFTDEP("pre: cxl_core cxl_port cxl_acpi cxl-mem");
+#endif
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
new file mode 100644
index 000000000000..356d7a977e1c
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -0,0 +1,87 @@
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
+		goto err_state;
+	}
+
+	cxl_set_dvsec(cxl->cxlds, dvsec);
+	cxl_set_serial(cxl->cxlds, pci_dev->dev.id);
+
+	res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
+	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_DPA)) {
+		pci_err(pci_dev, "cxl_set_resource DPA failed\n");
+		rc = -EINVAL;
+		goto err_resource_set;
+	}
+
+	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
+	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_RAM)) {
+		pci_err(pci_dev, "cxl_set_resource RAM failed\n");
+		rc = -EINVAL;
+		goto err_resource_set;
+	}
+
+	probe_data->cxl = cxl;
+
+	return 0;
+
+err_resource_set:
+	kfree(cxl->cxlds);
+err_state:
+	kfree(cxl);
+	return rc;
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
+MODULE_IMPORT_NS("CXL");
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
index 620ba6ef3514..7f11ff200c25 100644
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
2.17.1


