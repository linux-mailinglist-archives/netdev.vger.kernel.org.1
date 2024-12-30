Return-Path: <netdev+bounces-154572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 423E59FEB15
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3413A26D4
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00F819DF8C;
	Mon, 30 Dec 2024 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4YeNgR94"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD0519D8AC;
	Mon, 30 Dec 2024 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595110; cv=fail; b=hTJMX4EqNkarw6AAUFeBQMH0dTXaFqLin5aEjmwDPwQIj5PyybWYCeOW0KZ7nHcRoImP2z6V1sadG/Jc87/8gO3btbb/g53FjnzlRs878ZqFfCs6JrGCfPKvCh9CY2fj6/A3Zz+ZTZeewhUiJJuUmyZ11GLimOrbph2ctq763f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595110; c=relaxed/simple;
	bh=VDLFWZX09gGuQeUSXCE1Hp5E1B0NAKaG+95TPpmvDeI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uaiaiqSw1IMtd3T2U6ICQ5+ue1O7lG3lFWiKdZk9OX5amTy+j6QDl9EeOy/xhJ1ENVQh+FrhhwFaRHqU4AxPFqTmmsLkpDsyd/bmRhVnC30BzjHwh0HekIHmWRRWULF7NTBV+vRhVUrj6N/tEgU5iMKO8XKYyz+TZYRByrq9Mus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4YeNgR94; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCjYkWMUicS2aKQggdlxBG2Y5n8KGpHVVYOA6q7kg4+HKy4WeO4U0UkV4SudvIoubpLtgV2+Vjg69K1Q74ytBDn7EHl2tnoGwoJAKBxuL8YzKtV5D4SIsGnOLThhIdkcldqrnEKewH7DKum3B1PUPa+uM8saB7qJo99GuPKkDlNF5jYu9YQokFVh4z1WTLRRPuYuAwClffdBm69dGRp1KwwlUQ6cdazF7zQ3Jg7WIEydcyhPTgDYKC/yOYuOJNJtf8MkxUWs1A9smrCPRldLaKKvzu23sK/SqG0JCFBlYLS4x9SpzDofuB34i9CWFTg7iSQYsFUXHwxrqgAAig6Z/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQYR4p4iGJueL7/pEub8Hm2mBq7mFavdXDfGBU0q74M=;
 b=pr2qxAa/HhTnuZcKHZQ+oq4Aq59BDoWBnjc6G5M8SYkdOjNZOIi0STjzyUQv51VcqMoXkptMuRuHA32+8Kd+vI/7SE+C4EpH5MUdbYvYPIy8hBTr93yI/u8HwnwzOduvlgX3w9MxJk52eO2E2ZKrOlrDpWv0aq+Fhcrr1xo+xiN6JeDNqxo5Npi5Cptd3Rt8jFNeS9lNDmOkspYMAdA7Ro0JIda7VMKR1oQmyCCGFGqmr2VVSn2S3SZ16QVXrKv7hMJ6g2XwIzBC8G/dD4nKF1CdoKX1m06KzSipoZYtnP6yK41T6PAIFjazRM6P2oBgkisjv9G+KXFGqp46oPfX/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQYR4p4iGJueL7/pEub8Hm2mBq7mFavdXDfGBU0q74M=;
 b=4YeNgR94lFLRm15rQJnsbRym6P+e5Iavf4uEFidqUjHKUPVX9B41yjOHgpNt9ZbIccruhIXKLUYqs3zihhf/uX7RperRb+b0dK+kYi+fR9QsURzTUrIBSLvj/o7pqdpkXid2peIeeA2+Fc1mKGG4Ikk7VY9rfNsFoEwRHkF9cX0=
Received: from BYAPR08CA0003.namprd08.prod.outlook.com (2603:10b6:a03:100::16)
 by DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.15; Mon, 30 Dec 2024 21:44:58 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::41) by BYAPR08CA0003.outlook.office365.com
 (2603:10b6:a03:100::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.17 via Frontend Transport; Mon,
 30 Dec 2024 21:44:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:44:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:44:57 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:44:56 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 02/27] sfc: add cxl support using new CXL API
Date: Mon, 30 Dec 2024 21:44:20 +0000
Message-ID: <20241230214445.27602-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|DM4PR12MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e86ad6-0fa0-456e-c9e9-08dd291b34ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ty68meImh1k7OvmZJQ6V1QxcG+uyn/RPHjeI2Pi4b/a/1Adj/Eon1zFDDwVB?=
 =?us-ascii?Q?RUpr4sWAfcyJsQ34ZHiZGs5j8Ucow5CTywTJ+FxcT27sAKQCcLU08jMYpmQE?=
 =?us-ascii?Q?FnGTzpWPD+Vw9UQf5JdCJIEgFTu9IdNMbwhNE+DBcw3rJjrTYsrueAxHhq01?=
 =?us-ascii?Q?KW4l1hokyxNa5YUhpKPv8J0NXORxpoheolMye26XnqEUFj/lscjIyXnPFT50?=
 =?us-ascii?Q?BEAm50do/SQBCBxt5Lk9o6eymJybymn75liVZullHLNTKrrDw2ELB+vF74XG?=
 =?us-ascii?Q?OJO2bjtDOKuDIIyDCc3/zCs9QwKyGiVN8CNS/2FmVLQeD6oDA067+vcGpB2k?=
 =?us-ascii?Q?u6WtobPSFnSLfXM6grYfyR7tumQMJF1FrlprEW+BAv93Wyvs8x+hNyc/qb9Z?=
 =?us-ascii?Q?cbrlHikcYufpNL2pWeXeoceUFwXgKfhKaYwCWkNRpE6r30elNaPy11uUAhuG?=
 =?us-ascii?Q?MQyBGnuWVFyQwYRC5OdizGO1FoJnZ+pySFqax0LCGK+4ZkMFD9SxpX66F7VU?=
 =?us-ascii?Q?67t3BcUMWx2FvrwwrhazDFdtHdDUz2Rx55PTOvC0/7kaI7cKF7vsQmONWzOE?=
 =?us-ascii?Q?BbW2o4Xfe0r/m9GT2bhbTEkcFvqsgi4LysnrX9cFUj2GwikVlZrgO2nPXPwt?=
 =?us-ascii?Q?PPyH3kyeqaJEVYaMl6jPB6PS1xVGgXPy8I/F++nyXiXkr3gAwXFuotFYAk5s?=
 =?us-ascii?Q?xilcl5o8YXZJxJ09t+xaqRHxMahF2hBb1hE6A//tbiXF2zHGEj9mOdHgk4ZR?=
 =?us-ascii?Q?IpIpwWe7HpeO12YwLo34PRaC7umsAoL2bAeGUjvHDDJ3ZirAt38ssEYFochI?=
 =?us-ascii?Q?HaLuTFKYCsbTYDqZNuc5k8lTEc97A8Qq/Q/OtEKApFBxulNk3CuDdiH1wBO4?=
 =?us-ascii?Q?ZncCVhXQqZP7uvrqiQihidcc4FPeFXaezTtEnGqtuWk+V+Hc/1J/PKGw5V7C?=
 =?us-ascii?Q?c9SP3lWE6ak822cqndtELt0Y3bWzGXITAFtkz69hqzUxtJVXij7ZSQbBCMxJ?=
 =?us-ascii?Q?vPOc154DYExgPPlRNw4jZWMMtv82ZWc/oej65wJm/z905otQUoHXeEiN5GuY?=
 =?us-ascii?Q?9RqsuixskCd7ro8dTbHkCWm70nD6iLncD3nWqG+krdz35fDyz9zn7vr0c7lg?=
 =?us-ascii?Q?X75BXh1Z+ndAabrP7T4PFpD6urY8vUvGpib5L9BDUUt3q/TmRj4BOpml3nH2?=
 =?us-ascii?Q?NdaR+KHWmtGPUa2ga2Ke8oHc/yRp2hA0U/yUyap7OOFbu1xPP2XXfsZQkL6M?=
 =?us-ascii?Q?/hDGun+dV3lnGaoKHd9l+MhM6QHynBwXRURRDrWFaKxSbLaof+4EfoQzk4zA?=
 =?us-ascii?Q?D3nvelE/zrDPhrvYRiZZMwpMC4NXthuDNMmEojJ+6Gu0bU8T8F1yc8hbFmxY?=
 =?us-ascii?Q?ChND1aH/3o2XMhDPAyLqq0r8dtsBtltSY2mr6wPHZLZ3uj13aCstDtIvr5hr?=
 =?us-ascii?Q?GRY5duhkSNYQ62pk9MReVcbeOJniadqoMl8bGD7JvOU2rrFd73zi6YViGCXd?=
 =?us-ascii?Q?rBSu4Q/dVxrROAw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:44:58.0201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e86ad6-0fa0-456e-c9e9-08dd291b34ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112

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
 drivers/net/ethernet/sfc/efx_cxl.c    | 86 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    | 34 +++++++++++
 drivers/net/ethernet/sfc/net_driver.h | 10 ++++
 6 files changed, 160 insertions(+), 1 deletion(-)
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
index 000000000000..12c9d50cbb26
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -0,0 +1,86 @@
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
+	struct pci_dev *pci_dev = efx->pci_dev;
+	struct efx_cxl *cxl;
+	struct resource res;
+	u16 dvsec;
+	int rc;
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
index 000000000000..88077d306eeb
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -0,0 +1,34 @@
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
+struct cxl_dev_state;
+struct cxl_memdev;
+struct cxl_root_decoder;
+struct cxl_port;
+struct cxl_endpoint_decoder;
+struct cxl_region;
+struct efx_probe_data;
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


