Return-Path: <netdev+bounces-148160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F059E0987
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49EE162670
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9B41DAC95;
	Mon,  2 Dec 2024 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="enAiIW2J"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1EE1DC054;
	Mon,  2 Dec 2024 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159566; cv=fail; b=AOAfoQC3hKilkRuVCUzC5tqYx2u8eJnCfVqFBPmImSSNfrDkQSvyEnW3LvxkhHUYhpW2XJ/ivkDv6S1uJZ+0CZuwr6G5J1biXD4nZ1mmuMwK6yiepeS+K6Fv/Z2NAhIoxDW0sK5x669N4YGnxlYoi+3ITExT6HWwM/kpfxvHo58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159566; c=relaxed/simple;
	bh=OBwQcWIIumZQFY7xQv7Zia+bpupoaEaSF04UbP4plog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+gedxopF/aiea8qQZgbul4YXVXObVEIyy4BLu5PhySdN2dpGk4OatWnWx23kWRo0EUOm0zzulC0AnAq49N1asV0yQTfsuaEtNCdW4Hkn8RzNdhi/edrfIB/w5YTOrJ3OvaBxvqYDEM8kErNMJxIAUrMf/UXSlepcif40GO1jrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=enAiIW2J; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIfyrSeX7Y6MIcpWsNS8f+P7bY0nnQrkBBBr6o9gpnCpS6gVdwnlNPZdX/dRi01K2kmTyRkehtkAu+WlO6fRqPuaLVuR+wdexqIKjcYsntidVCqfH1Oiqt1Z+mvZbyehcJ4BtW1u+WCKaBN+uGWDgjl7WH58IcFMGHCnmPrEhjlldHV0I0lqBU5MAjgn0/gOFdkV+HtpFWRnlHwQu8kds1qW+i9ArlR9dF+yiJL5kv+FsfHX2/IXREQwGzWL09nfzn3fTokKW0WtYqF0gOiAMFur3kftacus1Z2l2yTCZQCHUnJ+TuwYrQS7pYU6S34vJGDsrxT1RKE7jrqSErevVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxpvHghVGUZBirPrT+avRqazHLwNm3mPGiEO3bM5Gd4=;
 b=G2fWVxpzYI+WdViQSUN+201SSlux+uNctsY2QDFDz4l94mXPQyNZjCitGOs067KHlRp89BhVPTBSJ+nQQgugh0Eu3n3YF7Pom8+0QelvJUJbwo15O0nyw0q6yt1JsCxRIc6M6PwD46VAl83BSWusiW4TdcJPmtpnovUUA4xCuPODaYqoLng+0WeQdN3KM4OVTHmQexgwNMF8NaDFctbyjOOIYiHalSAKiwWtOamFEu67X1NsqN47b2oGsrRNWBaFTcLsU0bDSQZ/GEiS4fspHQ0P6soSDh/ElwebUr5Z8tiDkeT9KDc98LGdIbbnz9KG3+7mR9PnsfwtNUtMU93/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxpvHghVGUZBirPrT+avRqazHLwNm3mPGiEO3bM5Gd4=;
 b=enAiIW2JYPrdzDOlFksCp0GE9OW0kXwHnCdDuK8IZay2pqVSbiJ56r2xOpQcoQ6jRJ0nsYgmzY9NDU/QP4xpMT+UmVdkU5AZzN63eYiKxI0BKuo9FACmFqBKn7EcLRDdUwY8hj0O6Vjby7KAQD2qmY/bol2LUtQlPapRSc1Ns/g=
Received: from CH0PR04CA0057.namprd04.prod.outlook.com (2603:10b6:610:77::32)
 by MW4PR12MB6999.namprd12.prod.outlook.com (2603:10b6:303:20a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Mon, 2 Dec
 2024 17:12:36 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::cf) by CH0PR04CA0057.outlook.office365.com
 (2603:10b6:610:77::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 17:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:12:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:35 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:12:34 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 02/28] sfc: add cxl support using new CXL API
Date: Mon, 2 Dec 2024 17:11:56 +0000
Message-ID: <20241202171222.62595-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|MW4PR12MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: eadddf68-1c70-4391-b4de-08dd12f48479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G6z3s68K1tJk6KPjaT+/fC9JCkfC9mvcwPzLieh4ttRJuEygYBypHopgftMQ?=
 =?us-ascii?Q?QX5zuguSs0Q13WnVAmVVMBM8Ct1bRiOtpf+euY4qgw9LzNDeBncz9sY2IZTw?=
 =?us-ascii?Q?56IS4LFDlZyHAM823s46GZkfKpPdQGHI3+4cPEsk4lwHZKsCSuG5dUVJrmlE?=
 =?us-ascii?Q?OWTZuWG+UF9yfb3d/yU8wWQ9OG/eE2T5REVkGWT2415pQOaIa5GlJi9+8Z2B?=
 =?us-ascii?Q?XXY9qLKNyb2IKVPSrqEhR+uRvgrUuJIhKsINfBi1HUTM+JI+r6lhxqUPqbYc?=
 =?us-ascii?Q?VfxjmM+1MsHolLU+VRqT9Wapn68tXupFU/hPdYSzre6pLwGs+F7a8D0qB5EA?=
 =?us-ascii?Q?Ny5UBuQGlkha3Cmuw7kUt0DcrweXL129dnytLBF2g4voCfRQ0bTXmOEo2Fi6?=
 =?us-ascii?Q?YIxJgNDRxiswhBCgUr3Tkgd768I4vjgvCk/NAykEA+8PjWlqpoP/CYcTGgfV?=
 =?us-ascii?Q?vYNNFaYXHiVqKFYpS/ABZKzGmzG30gxk56LL/taXwC0H7wMkwj45bJi3spN7?=
 =?us-ascii?Q?hB/hUDMoKl1ftninxa3K7+fdzTMJ0bo8sD8IFeyJII7XgAAkx4AyPMZiq/oZ?=
 =?us-ascii?Q?6/tzqZ142s+2H7aKTJ6GvZPajQx12ooUxl/QsGgVYlbVHTgkQMVlCsO+NBMb?=
 =?us-ascii?Q?9dVuxiM7ECpuNaKfSWdjR7m0MfrHsyAGNytBhtHmJDvZLvUmKyQPiQkT/M7I?=
 =?us-ascii?Q?obBO44My9fkn7ld973a53PTamUGy3cgKvJY6UNRAHID6RBQbipyuCWNUKNVo?=
 =?us-ascii?Q?BnO52jWpyZ4pMpr2nQvBA8xY28rd/ojuzbKKQsB5KTXl7c9rmmoCZIJNKOCs?=
 =?us-ascii?Q?PTECbnngcFRO/EEWQ8/6JQ/V0IWq2DLO1k+T4rjgQtwlg07DCCcI/dHeIH3M?=
 =?us-ascii?Q?0m+jLUYyEgy/U1hST9OECrW2qS22OcLm1APCKXZiWj4b6vm11MbJnYX5lgHn?=
 =?us-ascii?Q?INOBRUZONgOV61f2kjU5c+kt21FPl/ICIA3BzJOuTSoo/enLDjB4fGElxie0?=
 =?us-ascii?Q?xIktZq76PYUmMjbWmgRp10bQj+a6O14wnr9w2qEST0d5TwEAWaHDZOuyg9ih?=
 =?us-ascii?Q?8NKdb8AAop/KnP7HugIbBpYDqZGfK+cVJZEB/3gN6ggFBV6QIx3wGgiIIKWL?=
 =?us-ascii?Q?IiCsR9L/9p34HeMXtLmWUthX3qB+0Kf3hoUc6uzAou/j+AL4IogznPX/Dwvo?=
 =?us-ascii?Q?sF3VgvEaA5H0zUyBovUK6of9ZGPtJgQNjsZeFp7jqAa+28ZIL+Ziv9TBLLVH?=
 =?us-ascii?Q?qHWH0FsuQYg3xRhNsmic0jbMp3yfsKyaoST7TG0QBXBfB2byrG9JRCOzNWJN?=
 =?us-ascii?Q?VVeT69ZJjbn2sHRwO0UmAgbf2kuzzjv5QYe6xgmx1ATpx9xM+PEPWDEAiqsh?=
 =?us-ascii?Q?DrUVY2xVnNm7/8u0sFB6B+XB8MgVjiVPew5EFRYeDnQ/WtIl8GcLqv7b8sQy?=
 =?us-ascii?Q?hI9sAM63s762IztvyktlTuUK861zBoPyA0UE9gK8dEx4jNgNyGH8Gw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:12:35.9429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eadddf68-1c70-4391-b4de-08dd12f48479
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6999

From: Alejandro Lucero <alucerop@amd.com>

Add CXL initialization based on new CXL API for accel drivers and make
it dependable on kernel CXL configuration.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/Kconfig      |  7 +++
 drivers/net/ethernet/sfc/Makefile     |  1 +
 drivers/net/ethernet/sfc/efx.c        | 24 +++++++-
 drivers/net/ethernet/sfc/efx_cxl.c    | 87 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    | 28 +++++++++
 drivers/net/ethernet/sfc/net_driver.h | 10 +++
 6 files changed, 156 insertions(+), 1 deletion(-)
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
index 650136dfc642..ef3f34f0519a 100644
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
 
@@ -1214,6 +1222,17 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
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
@@ -1485,3 +1504,6 @@ MODULE_AUTHOR("Solarflare Communications and "
 MODULE_DESCRIPTION("Solarflare network driver");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, efx_pci_table);
+#ifdef CONFIG_SFC_CXL
+MODULE_SOFTDEP("pre: cxl_core cxl_port cxl_acpi cxl-mem");
+#endif
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
new file mode 100644
index 000000000000..9cfb519e569f
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


