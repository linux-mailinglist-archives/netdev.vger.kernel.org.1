Return-Path: <netdev+bounces-200667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1BCAE6831
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7220E18974DE
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08C92D4B5C;
	Tue, 24 Jun 2025 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oO4xW8m0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA42D1F68;
	Tue, 24 Jun 2025 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774464; cv=fail; b=T54ftLAskVMAa/v2iQ3QEyWEqYFRWuj5WC29zxVkMMnKW5Jcu/eHebY/goETILeU5mifZlw6yOZTTaJV3D7FlqYoTeL0efwi1ltp6iFEoVNSLleqI+H7Q5ILTTUefeSWpSKOGHZFUQOWPDgir4cZs9VDLTfSX+YYqVYCeSfgyDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774464; c=relaxed/simple;
	bh=ajU6xbsXIFncPHd3cEQPvakQnI6D0FrkNcUwaNtcvvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBkhR793oHQmh+ZRMRi4b4z5tHCCLcQ4UrLM69wFysVBwozkHH8NqrdAbZDeEgmpT84sxwIdxGiuA6e5eGRPgILvQ0AZVLAFKl09TRccxmxLhVj9SL8IGS0J03HLvYk5+/fWV04bNC7e/KqziIhlKve4wsQ2u+usR+tBYFUHQ2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oO4xW8m0; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LudmNKhJKjN9ZTYmga7eaII9cynPf5HEPeXBlrnnVcAVpKCwsF7cp/F3eDnGDkLCTI9lQbllHn5jpOhIJtmEcCBBMPteN635FKyWNum7yyOuxO02tlRXY54OvwBt5ZI0psoQGDXvFw/+NUADsrRfAlY4jGxVIjgxdCQYpba4D8JlGyo3MGaxc40dFPYVSO+l45xlLTkxeIebUMZg+SujserdWAGVbKXV1+xsydNc2b3Di0tu7IS0V3wBMb4elAnpBLeYPK5+UxNdy/3vBzgyr6Lko/y9WqJYCW5luJaSWfQ19f2AllhHHHGB1O/gesyfqwAOaumRffwKvI7PWPrrbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uq9dNgm2GUzbxLUnKDx7R/eHSHG/41uuQPrMC+80MdI=;
 b=kGZB4746VjGLOGSz6AunNNx5f9nQfutEu2eqbq7zuqxPXAaccUl3HxhTdHMuw/OOvYIktPNMG0/HyVVK/jNnUdf5sLFTrIfS2MYzRilYuVUMEpIit2zjhMNnp+qfTWcqq4ByEB3JuTo6ZmL4mqnzK5340TzKVvnSAzXWydhHf6PsIRi08B533bdWUfqEFlAHZSV1ZHKSQzjdpEiIP0NsDHgcZsJn6E9mi14Ra9S5Yk8eDArXel2kNksxVtDfJhdaTwWP3JBojOnD+vxmQglC5n+2JQ8Cu+NANrwcx/4qS+blcHztZUVRQveSv706hZOVPyfkCKJqvd8EwA5INSR80Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uq9dNgm2GUzbxLUnKDx7R/eHSHG/41uuQPrMC+80MdI=;
 b=oO4xW8m0YmC3YTKN2ZsicT9KXVP/t6BXv2+nTLnU2r19ocZqtCF1LL6mbERO7MiTskkkOR4w3xuKzR1ojT4Q5X/kaiHMfP6VJTWGxRFYHK07ssXKskiVJBgnX+GnwwgJH4Ey+vEioh9p4ZcPnWVXWgqxllMcbB/V0743okhSEps=
Received: from SJ0PR13CA0154.namprd13.prod.outlook.com (2603:10b6:a03:2c7::9)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 24 Jun
 2025 14:14:18 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::8f) by SJ0PR13CA0154.outlook.office365.com
 (2603:10b6:a03:2c7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 14:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:15 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:14 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>, "Alison
 Schofield" <alison.schofield@intel.com>
Subject: [PATCH v17 02/22] sfc: add cxl support
Date: Tue, 24 Jun 2025 15:13:35 +0100
Message-ID: <20250624141355.269056-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|MN2PR12MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: 905e1097-b85c-4137-bdae-08ddb3296839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xUp9vYPMnDWhMsEuzGc2z5KoyAkpdUauQQdQYXmRimZFe73V9XN4vWN7mmZv?=
 =?us-ascii?Q?5TSSZqey8OttpTm4gOwRn7oUbtwKXKKXJsWVYZS5dEBc4hnGjtoNLf/nXuog?=
 =?us-ascii?Q?WSle4ZvDmoNIDe0bIvTfVNvpDkpBkUb2F2hrzNa01zKSWtcOCyoTz4uv7k6B?=
 =?us-ascii?Q?sUDAxqMcfQukad2MtDVw561bp875+e1I8NJyLj1PSEz3868tgCSmD6p9ldQj?=
 =?us-ascii?Q?PMWe7gHsgh3Srti48xQHyIuxJ9d21eh7CnfQoQcFg/q6ACcJV97e91NDv6/k?=
 =?us-ascii?Q?Ras3Ud61+7ST/eLb6YE7lvvgSOQGqh0uotSx696wzIeokt1Y7N2I0Dt1luiI?=
 =?us-ascii?Q?czPxcVcpOSPv5i5Emc04EtFhEbqJVOZAJz4FWWufgV0gNI5zl+Ji6Dsf3YM3?=
 =?us-ascii?Q?SKIqL9a0+KyajzMmEYsQPFjCvQMGBK6GBGyenrUCaKEBqOY6kGLrfsc9asQt?=
 =?us-ascii?Q?0nvWQ6fRogbwMCjdXP6EFqF2pIo4wbTPlbMRD3qIxkuFfNRx0G706nvyocjN?=
 =?us-ascii?Q?osUpi/OnFzP57RMRvvc/ibnXE7BJymbgw3Zz9B1cDKicgSVoUGKAJTrZgNhX?=
 =?us-ascii?Q?MzxfZWnL0OXzCowMFsWKxhW0JDY6mSG1Z9+7oGGbWdD/TOIkDzotgw28d27/?=
 =?us-ascii?Q?G1TVYsS2rsfH+OLT77q+eqcWxhTF8f7uaoZaHLndYIMzqTwbhPDnF6VnAg2z?=
 =?us-ascii?Q?K4l6xOgaXNXtUXQv53a60uvQeGykXdI+KlYCHLVIKftD6nXI68ncRVXK7uqL?=
 =?us-ascii?Q?+wV5Lgl1NFK62zfS/iLeBpSB6Utoo9mG1MpgdXT5DANnqIqcJKyJAxLSDv0k?=
 =?us-ascii?Q?RdmdyU1WOGDiEd4BS27VllFWKiEWBxHx8TlI/fsanomu5E/4DS53I2pfUK9M?=
 =?us-ascii?Q?k6A06rRYA2zg4/Y/hfyLAOThCKa7zCivGtoTQEMoyDlt5hZrLmNg7y8/dkcq?=
 =?us-ascii?Q?t/JC7blymhab6mtVXPb27X2r2+gIbh3z9xx3MTVaAFOG2/fJmIO03yJMdjSt?=
 =?us-ascii?Q?NaEzFPE/avgRQN3J2LAbtT2Ajgv+xJJrsH7nf99r+Gc38oT8jbR3dnHG4bio?=
 =?us-ascii?Q?EvqTPPRsKCNVUAqgmT+UvdKLhXBqsnc6jJzUwnmQ1jmREywz7lwBHqYmMqJ8?=
 =?us-ascii?Q?Xr8bLWZxUknEIr9+lUmf1Ybd9KEPkjk+yU+piiv3e8sQ2RDEB4GrtIDldPDQ?=
 =?us-ascii?Q?kAd2K+Ym+jlnhI77cWkGaGtlV9jq2KzzDTfDpxYcg0psD0t1EJDPLRmv2M9x?=
 =?us-ascii?Q?BlSMKCQ08zFmw6u4zd6Zn8FF6TyjqvaeDSPl+ImQYem/ynwjdyJ+5odHiwN/?=
 =?us-ascii?Q?8EF/ysv+ABHXc9St5toXHrDJ9RpPh6gfRVAYmnLF62k1xZXkSlBw+5HvdY12?=
 =?us-ascii?Q?iY2+RQVWcwLj4e11oe+BFGSerX4WKKclwVGw/yFcBzC6PJBDde6PWXXrHPAN?=
 =?us-ascii?Q?n6ViZBnehy1cZBtNCzZLRPd9M0xqvLrQGm8KN2dYaGxGz54o7IC1dMvbddx1?=
 =?us-ascii?Q?VGsQe/hQ+qiCbabnPOcO58Eil+ND2/+Qq7Wr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:17.8863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 905e1097-b85c-4137-bdae-08ddb3296839
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253

From: Alejandro Lucero <alucerop@amd.com>

Add CXL initialization based on new CXL API for accel drivers and make
it dependent on kernel CXL configuration.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
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
index 000000000000..f1db7284dee8
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


