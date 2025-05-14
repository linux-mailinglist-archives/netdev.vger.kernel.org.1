Return-Path: <netdev+bounces-190416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3281AB6C9A
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82353BC001
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF9527A44C;
	Wed, 14 May 2025 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="al+LAnS5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363F51C8614;
	Wed, 14 May 2025 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229282; cv=fail; b=oXsXkVtnUvhrKqzubJOns+Zc8Xs6/PtWNUePo8iDsZyEz3n0OMHVFEP77/5baEpnyNLmMgR9qpc1h4gFkJfeZ3iPTuk+1WQyuQupfbugjVivB9eXZWjn5tMyu38UDkMxbDm0EQTKPilp2b0Yw9wFIzeM8krN63CWgST1QSHCBEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229282; c=relaxed/simple;
	bh=Lu1m0TeS+aoXHHihpbN+e7b4gK95RpUHJ8U5EtoSfrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwWGWZC8IGtUjTB7KLxD3Lr8wHRO2GrvEA4V5IGcT5Vx/zbTEfG/tGY3rxPONb/rEk3RWGDJNwoIFtCY2cHCgZmLV5WpxMJaUjODB7RAgmCW8m7YIROMqr+YKyDb9W4ZOtlAjluQSMwzUvRm85TsJ7BEBYxLyHHQNxynXkbOI8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=al+LAnS5; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzUm6bBTSC1x8+BVSt1PmOX5JJ0EJljLaG8rZ7UJ5VrN8SvMj5kjJ9EqCb2Z71BzLr8fLm4402VE/xf9V/VvC5/I4t0kSCqWWw9rNYZ6EZFJibyCMK6TE95jtRf3rJBqHCUiw5fz8EHlwCBrYsBTvhG3mNvjhXr2htWTgzY3k7DAawSsrxNhFwZYjiJnE8AjUSjJr+aa38C0LzyCnOTw8pkletlwPub8zi1u/QPhxTNQuAb2aAJcVpA+PPHGk5GgNlvQkoxFy1FfSpxrbpJjnA2pWOzrNPwDRdr1HY+uX89GaTOHyrqROvetue4ySdR8916bqHuPB2VH/NvgxONVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOwHry2zDbOdOQnl8BvJFW8UzWMoanvxp8MQtxu0uwI=;
 b=x3olXjDx6eEZw8T9MOSHlUttuwpddlOYrIwRtvuZaE6c0YjaYCQnp7KhqH/xqE6gE7kzCyzTMEY+sIHjaB4tyxVLXYoNx5KznUh3JmtfwOo/fejEN0rgVKbseXup05N0o63tYAPDNE6Vu785ca7/sCOnk5MnmY38tmaxua/lGGtr0A+jyZJ4ujMHurNdS1Bzn9cgYejy149GqJF4hurOSjhQXLW5UcFHrL3xRebu0SGmGs21uR/4zMiISGFjCmoxFXn1MNrgyyAdj5fpEF89al7UhC3SMIA9z0xevlZ1f21JVkmpzFB9B7SP0pz55mnNmC1RbImN0aLWEw/lQe0mrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOwHry2zDbOdOQnl8BvJFW8UzWMoanvxp8MQtxu0uwI=;
 b=al+LAnS5JKgAEZNjXmm91UOcgdTDc7dzsjAB6fWVlzHnkEemljiqyRWkRkMdELcIsqBet7FVOE2j1QjCgwErqxFR4mvtjwYZNhc0KTqJtKfn02H5+4wwf19JX+7x/133EjpvjfWhecUDXk9bw7kQHtEdGHFNT2wWzcz5BdaUNxg=
Received: from BL1PR13CA0126.namprd13.prod.outlook.com (2603:10b6:208:2bb::11)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 13:27:57 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::6f) by BL1PR13CA0126.outlook.office365.com
 (2603:10b6:208:2bb::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.14 via Frontend Transport; Wed,
 14 May 2025 13:27:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:27:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:27:55 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:27:54 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH v16 02/22] sfc: add cxl support
Date: Wed, 14 May 2025 14:27:23 +0100
Message-ID: <20250514132743.523469-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2700ca-2ee7-441c-2aa4-08dd92eb2391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZlGRNrJYDVpXs4YK9Pkn7Ft9HklPXFM27jsTN1qPxpPCFAdH+0Kd2aD0apfv?=
 =?us-ascii?Q?bo8jrLEV8vBkqI7g6+A5scqzUuTNJ4xeWHDinBsoVNGtvoFGQWXjhpaKOs90?=
 =?us-ascii?Q?mb4b9RGCt8jDSfsM47by/WqGNy6AOk751yPa5Vw0+yA95GFWNpaRJz8qb7Za?=
 =?us-ascii?Q?xF7zHr/LOxl7sSwfO4r6t2SoGitk3YPqYyRhB9Tee/PV6ugDD3zRMHNhc53E?=
 =?us-ascii?Q?Yn/ZDnj8w2wslZMFLhiGd645VM991NmExmTatnHBHOrxwG8tOKlZrduSFrgd?=
 =?us-ascii?Q?N6I+AtgRm75JPwj6nyY9pduX6qmixftSx9O4CQa9Rjt3MUtF2p9J5iFTl1m0?=
 =?us-ascii?Q?LUUryeTvwaCdmQlazLeXGOUAvbEVHTaT0roa5xNLWZXSo8RuAzgIa7XcnHfJ?=
 =?us-ascii?Q?YkF962OSVKL0IXEUgc6ou0ML1sQTmEgh8ua1KJGS6VAXy3VLD96RicxjwUXJ?=
 =?us-ascii?Q?ZBi3E3tGhe/IZlpRWbTPiU2XAslIKi+7Xilw3/CTIuJtyVU+kxdpL+Z0O1EH?=
 =?us-ascii?Q?2nfYvJkrX2rRym++7J89s9K3MUmW6F+/sQ0sGI8VoUlftL8wuTLZGkRZhi33?=
 =?us-ascii?Q?5lqNXyLgJN81IbJLMxzabONDAbK34zU0WMe6x69uwzEYnuNpVSCqjxmOF9o5?=
 =?us-ascii?Q?Shdk7E0S5vEevrvvtXz8kc196ksjzB8xDJ0rFKE4vCA2+NdNsWhGiO9aAU1T?=
 =?us-ascii?Q?wqfWAVHyjIU8zzYhY3gbKlelpyQLnLc8ti+8mfDZjd4sQpXH+8WjAvrr6ImT?=
 =?us-ascii?Q?Bgv2yC2OAXGDQ8JOZu5VwJnhnNVuJ3+ZwvcszcXIHyI4iZpEGsEPKSdcK6b6?=
 =?us-ascii?Q?P7z70EycQlFJSQU2x8VyRXEDKxtRwjhX3dzkYbg17JlVDY2sWZa1iTQDxS6K?=
 =?us-ascii?Q?QsT6ZEkpKxrsJSAgf3EX5b0RYo+WzHDYh3SoKgAy4C9jYZUH/ymZK4E6MGqM?=
 =?us-ascii?Q?brmr+YrLa9xiwOHRwYijK6t/IbvLkfelYM3qO7bQ1xeGwOZw8fgEMUo4SQEn?=
 =?us-ascii?Q?/VKDlWWJ5yCVUZlNxqspawMsRls5cPZGjB+UNFclKoSroFTf9g8C3cycYNaC?=
 =?us-ascii?Q?fyWvg5FWGWeqvCxCQFpZ6MsLCt7sXEPt5MCACex5brlarD06thWWuWAG9IyX?=
 =?us-ascii?Q?YSLO49kurjeosUxsftklAlKS081E4ZxwDFh2BoqhcNdT4hrRZejbCCmt9WLb?=
 =?us-ascii?Q?Ad1Ndur7EKPVmK+FUVKKH9JrgwN5k4GBAgJKUpvI5YffLicUFtsuBFmTq/2X?=
 =?us-ascii?Q?cX+Ql5n2OpOnFaWDoInayLzNDJoYiUqF20R9sO+JgMEVcIIXHlwtr0fcE2Do?=
 =?us-ascii?Q?ObGlSvRJs6RC97AWqfbSBkm+AkSan/cdrBMWQdNX8I4jovk+pGNqDJK/I2kk?=
 =?us-ascii?Q?5MbRRRVqRWcQYKYX6oSw2QtCfwrg0P0SMZOkUasn8ghKBglPrJ0v+PciA209?=
 =?us-ascii?Q?Wj1+PkIIVfD2JDoAq20lsMx0Fb2Js9tOc4eazrewl69fJ+ayKTyZNqTyivRf?=
 =?us-ascii?Q?FnLZzVibghBTB3kNX/S2kL5UbscMiFf+vXqq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:27:56.7713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2700ca-2ee7-441c-2aa4-08dd92eb2391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269

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


