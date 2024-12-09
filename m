Return-Path: <netdev+bounces-150334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B359E9E87
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071C9281C63
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B8E19995E;
	Mon,  9 Dec 2024 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HvVbYywQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D95199244;
	Mon,  9 Dec 2024 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770489; cv=fail; b=oqKpTwKtwcPH67RA8JKs/R+fAHy99fqSV2OYJUnN/XtN9c+WVAA/4kWIjAK6SGbnjzSHnlcZxy81I0gaEylCm6R2B9oIeuVdg3pP/zusBx6jxxdImHvnvDUrU7CCFAb09s4bvdxnOkzZpTOHTk5KPfysNLNfdKl3aWyjwl1TNkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770489; c=relaxed/simple;
	bh=FB2UNiITpnjeXaSIbj0XOtM0iUwxni+HCYOxQyUU1Ug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piEpHu41n8RVeVpD3868d7ZHcKF3RGOW9ogDpy5H6FBYMTr23as1bMb+EwEcJ8olDe6IUV+TdBZTen5x4kP3xnpUkPbyi+JM0qXmuG+4qtrj6CSq66EqdFHEvF1M26ZEH2JfQbF22tRMSZVmlJjPZyw3s099ZKIfTFif2oK40rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HvVbYywQ; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iymSR1pctXXSkOI54wXH5DELn9YzTNp27qZLpQRbajHl9W7CAAbVjGLHOxT487sBMlHkBdmFavIScOyWRkUK+MxkzZbkP233ediJSPx4jeImOG+vN9W5Ccag7cEJweWtSDuP1R4g45jfpLRnKfYJAScF+CB32Vwer9I1dDnu5mvA7+NhTnEJLE60xXvoAxNOtOhEeSLdCP95gilOadYTKZVI7ma0dODUm2ZgaZeHEbgcOmrLmvNspGCaX3zN4/x007xXMm/jWk9tlgMyWAzvm0g0b+9GeA9dpQj+D4+gUM3htsqTgrclbB+XtNwK8kReu1ajeu5gPzfVd5WKbC3ttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJ1jKFpm2rWPNSc3IgQBHcO8C5H2B0RAb+s5s7QnOrs=;
 b=SNp55huxIG7By+xxkA69W2h0hNwFfCfP8m7iw/682SSGy7b56rCAFfxkUTJbIkp94gQOh3PdiHS06t1ZfA1SSePWj5MfcceCOFaxuzeGyvasg5BOTwQP6Zcw5nOEPtzAt82ymSr/IZi2xcSFgAgclm2sfBW+dLLE2G3paBKMD0tPc/1qrzA0tsegAHUqpo50X/ii2ybC0Ll06Ot8IX/y1TD+YSSx9wfjSro5Gn+88aURC3U3MkXzqwPyd5hV17GY1+jhDD0XRL9aDwUiz0CHA/5Pon3t3aRKgUma6IHAUSq+3aVgKDVh21/NIS5iVGMNK9io4yqc6vGTIGA6iDjhNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJ1jKFpm2rWPNSc3IgQBHcO8C5H2B0RAb+s5s7QnOrs=;
 b=HvVbYywQshck/J7DoOXnutUsHZkpSitwCyTOuXtVFEi0X7xpmbAkHF9rV30UzXYM2NIGeSe+/uGA8GKxj8+P3lh9oCr/IvtgDQSoYwaOFXEp2Obmfc1grINKxWYl4ZSTqQY3cHWQiqFjIBhjB0O3cr4PS9ezUUKS4ophFR/Eoys=
Received: from BLAP220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::11)
 by IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 18:54:41 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::47) by BLAP220CA0006.outlook.office365.com
 (2603:10b6:208:32c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 9 Dec 2024 18:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:54:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:41 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:41 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:54:39 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 02/28] sfc: add cxl support using new CXL API
Date: Mon, 9 Dec 2024 18:54:03 +0000
Message-ID: <20241209185429.54054-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: b438308f-695d-42a7-d517-08dd1882f0ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KF2EKyxgO2R2MhwR8A0ukBo9f6E49tsKu+VObW+GCkKujBFrdTptrqHWZSLW?=
 =?us-ascii?Q?qDGaXafcD92rzS2NBlwFWkjAGQk8mELGvUKGiwqV/ejoe3BKQ7gM/ZV0io+8?=
 =?us-ascii?Q?1As4wBhj8FoPU6NqGUsAuj+RnqR/qfZ8J+RsN2ln8JVserhb50kxRehAv2Lz?=
 =?us-ascii?Q?CNMzlHhBRNufpoM6Q8PG6cf4E9einwknGcB/Ww2y1gmV/bvQJdg6+J/BxEpg?=
 =?us-ascii?Q?yuyePXY05Rp02a6sHV3rL2w88NBU8ffGWj5d1gS/d6iCXz+Mw5U+kBi98IJY?=
 =?us-ascii?Q?NiT7MkBwDj3sfWXTGoJmV+Y3u7kdv/xkow4DuvCovP40HCD+KrNmdVG8+PlX?=
 =?us-ascii?Q?lYt26pXSBQYuZDYvu9dHX5F7t4bQY3tY0KhexBHtRnef02JGqfXoWPGlRa/I?=
 =?us-ascii?Q?OTjqRJ9EDPenvQc3P6QX32GC3YviIzaLItvg9Jmm74xVIRFDPFKnA0Gqwq9I?=
 =?us-ascii?Q?z43d9o2VbxK14BACD9PGxwFScM69ewQlZiLW/hvnY8ini7HWS5Rx7Poefiej?=
 =?us-ascii?Q?amormsbTJJ0IceKbdAo4qazviuQCi8EN9w+6Z656GStDUE4+4h1jzZJ9v/1F?=
 =?us-ascii?Q?Mbe0CQD1TaY/ohUto//sx5AYl4aWF9yS/RJHfCZUy4QWKCsPRphSz/iavwud?=
 =?us-ascii?Q?t6deFdb3o8ZaCvqGsVCdBJK5bYojKihTbqwtigtWsul3aFBNjQXDbqUFqlHw?=
 =?us-ascii?Q?UKHL460qcu4MXQugwmCSkhdp4MInJY4SovvJDkHIAcSfrVrw2ZwLKlyndDpP?=
 =?us-ascii?Q?VUuB8QFUz1M4YbppCBFYWfFGgmk3Pna9Y68OV8VzbTvXdCDLaf14fqtJQ1L7?=
 =?us-ascii?Q?cE0U9/ECuOQ/IOiqPihEpxwD/VptRiCeU/XrhXHPXeykXHza3s9QyAeLviqE?=
 =?us-ascii?Q?g6/2EuE48Vl9J5Ka0Xze7nH2QF8dxrBWOdBeo6kPaMJ9vFEo4V5QVAsin+fw?=
 =?us-ascii?Q?yDy0hA3FgradentH59JbCEvri6DtK2WCa0gaTqzmBafNlrX5yV2SJF45sLBm?=
 =?us-ascii?Q?ZqNgvm2Ngyog3tm8lJbeDCZ9sZLPU88XKvibU63aENw48d9oIqj9BiswGz0s?=
 =?us-ascii?Q?8jlnaJGHDp1MAzRuUWG7jgtSPoWf4U/vzO/iItyqii45v2FxLJx5D7px7sxU?=
 =?us-ascii?Q?IxgfLjCDQ6Hx1V+xjjmR4dNBL5Hcw11IfwbGBjH2/yYeI7CegQe2o3TYEhiy?=
 =?us-ascii?Q?H3fhOmVPNme6/SXkXwFP0r/ZwzUpUMfl3xH29eRv9PqlqUmrbrTWZzaeUbfT?=
 =?us-ascii?Q?ztbiSJRILVag5dcJg2z7+N9II7pdYrG4mkcv3gTAgr1O31LdxQ4GdbLMOxaC?=
 =?us-ascii?Q?5jELrBjWuh5ZnKKXvijG5gyX6TItxrYkd6ZIbifjFOdl/PqYKUmNx1tPPKoa?=
 =?us-ascii?Q?2tZ3R/+Imv1b4NAJajkqU1e7rfoyj6xXm+ybbFQnTKiyu2Gq6Nmbdhx98Woy?=
 =?us-ascii?Q?3MT6GfwIPRvZd+QaO5iEvaDRc+Cqsw10x0RZi2qzYBu8fl4f6ymRtQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:54:41.8436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b438308f-695d-42a7-d517-08dd1882f0ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627

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
index 000000000000..58a6f14565ff
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


