Return-Path: <netdev+bounces-173654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574F6A5A57D
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBCB41892986
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18211DF991;
	Mon, 10 Mar 2025 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w+yUbSnf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA8B1D6DBF;
	Mon, 10 Mar 2025 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640637; cv=fail; b=YqI2ercVGuOUye13unmQHHwTIBuxDCLWQpVat+8RUEgu2c3z+6MAdGvoH1lFCb+fP9+eN73tRm5vt8YPXefWUv3jhpkF0PKREdYwfQJZuZ+zfCyqQ1Ld9pSQX/pfLFiUAcxf8n+hlrXen1CXhBQcYzYLmHhy3WI8czssNGa0khs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640637; c=relaxed/simple;
	bh=yAZcRjDucgOc7+o4/ZbM10grjHRJZdyDE3uIh54FxT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzMq/kVTxo96pmP4SPFObZI6NRg+N+tW1zaHbcXbc3330PdNwAYMYuyPawS42U6QWtAzpm50oRB4N8zsP2S6CBZumUd8BxtIZoOieXahG2o3kYHv9teynEL+npjG+/LCgFhmSbixIH0zHxYby3vuDHSBg+XUyJzQYm1pDzupPxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w+yUbSnf; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4Q7BfrN7RkJniwfdgfqEjwM1LQ9vf+ipeuQncGYmjsuGY2yP3ydjWTANO+pQ3AD2ENPYi9qWQrwlz81XlG/jD5gAqNYRuZ7NjuIUXSmIb7vT0gGwWoy6omb6KO5sRI8LIKMhtPSTgp4q8Mu3Qk5fN8hE6lYD+21Avh5LYJxLcf6iu3qLtpyi1v3BsZ9oQd+AnTWhOhRBTky7Y59+5tBT9s9Vu2kWUJRUeoqryFme/rllGr+UjSjCkWGMv2UOtBr5VKy/hlxHrCkvSGCIP78Gi2QAOBbzu6ptOfBD528Zh86oFq+M/rHTujXQ3/Di7nZIMgcqBS1rRUsZLc+qb4CgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=na12sOs20qehhrJZ4bUOn10+SJlQsbDZC9sJmsgtvMM=;
 b=paV+yY+4npiWwzQu4+Z1cfVPkU8WxxVzA1sIVRUrw19XVVeUmHeaixLIQuP7FxOvMrNMPeEn8qaNX0vKrWvgWr83Xs9jONhBgllK5y7GjLV2lKu5nJFl7/mCGtu8OTwl/zc/ev5w3SlSlfBuDzOJfOKRTutps9Gw0tpAXXf0K0Sz9sfRb6jItSCSJG69YJxWfdASWwHcdrjpPMuV4X3dm6PEpQb8+Zoh7WLFj+zyW1PCU15HXZ0rOi+7oAtE8EDQ644xzimTaqecYmI9m5o6SkTtGbnQsfbN3ip5KtTvjwXCLec4W0YnNk1Hpz0qT9AHxahownuIDR/RAQvkNXnm+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=na12sOs20qehhrJZ4bUOn10+SJlQsbDZC9sJmsgtvMM=;
 b=w+yUbSnfXTJixbRi9K0J5iijdBauxrdm+1qT2ua4wt9VhqaL1BnZjtEjyZwdJ78wyMWHLIec/XzWgi6XdyOFul9ITmQDs+Thf0wH+R1ci1746O2f/3WRysmS+ss6JLhYu5qYV8AQ8U8vCr2NZ3cmKu4K7UITDEomwGg73cb1rxc=
Received: from BYAPR07CA0037.namprd07.prod.outlook.com (2603:10b6:a03:60::14)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:03:53 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::51) by BYAPR07CA0037.outlook.office365.com
 (2603:10b6:a03:60::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 21:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:03:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:03:52 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:03:51 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v11 02/23] sfc: add cxl support
Date: Mon, 10 Mar 2025 21:03:19 +0000
Message-ID: <20250310210340.3234884-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: b20962b1-5dbb-41f0-db31-08dd60171066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DDcOYda1Jh+mtwHr7c/jhi7+yZpbDkK3hxzW2va2TsCxROOspBlHj1HVrO90?=
 =?us-ascii?Q?XfNPA8nIYQ26QsL6EWXBqht5SooRODSQGv/H1USfLpzXfckIRFNQHfh+l614?=
 =?us-ascii?Q?Ljtes7ekRwLEY+TfaQh6disJuhbF90kHkVYPaEF1aNdAX61bs4hXJVP3fsmL?=
 =?us-ascii?Q?Ymx6+Crt1v9A+QxhGLk016N+x1FIWnkjxjNHKZWd8Bml5qelfRn/5UxoqZm0?=
 =?us-ascii?Q?pnmC/SJf3esfWP/MNx4cSc8cBjjf7+PxsGM05VMnm+vH7Dr3W9pnaHv+8t1D?=
 =?us-ascii?Q?+aoz37gJBrW1OsI7defK33Z+FDiFlei0M8SGNORDgmIJoqBJoZ01vsPAcNuL?=
 =?us-ascii?Q?UD8+vg9FWX/pyXUu7bfQ5N+HDe/cg4mSuFe4vym+hGQKbg5z8bfAO2SP45xf?=
 =?us-ascii?Q?sItNB7wKkc1PnJPTcOOI120lxci1DYg+cBRvk3EQAZ2/emCklCedZC2qNc0w?=
 =?us-ascii?Q?S1U6O/SxpEstEC3Q7/F2XzMpUjnd/DmgH8AJjdofjfcj39mHnkoZ9xZMEh74?=
 =?us-ascii?Q?bVB2vhJXzmM4pTncn7GATxy2nvhnc+JdlpSxRb2SsKqfjvu4AEa3AIOsly+u?=
 =?us-ascii?Q?4nv7P64d2Jcv8tCU7rjsYziyTRfMtdWjZu2zCDyh3ESXLpp/e1gBbeIGuZjp?=
 =?us-ascii?Q?4gY6Nbsoqdz5k5r2wz8kUKJcAHUsAWrWNJthUaxWdkbLFmVdE7XtKN7wgAuW?=
 =?us-ascii?Q?CIChD3GGtiNc8O6OTUmszMMKRhBhjso+LiidjKEIn2HvAJBcYlkxT9r9WsJZ?=
 =?us-ascii?Q?5eGfHF2ocCooPrx0H/Dj+YskdPzLLeTDH2nz9yEW3ART66KyfVl1lodrJK7K?=
 =?us-ascii?Q?JpFXrOXLj0ksQBPWIoqoep+TqLMx8eukYwDRLg2AOGN+rNkW5/DbGNO3RVFq?=
 =?us-ascii?Q?AeeI7sccpIeKovfODbDHLHgzuyKxlfAi111V83QgkmobE+QJmO0R4ILypg/v?=
 =?us-ascii?Q?6Xq0daHXea7bTpJtlR+k61GjlYn3Wg+37r6B7l8QIkGgzt0Xu31aYZYr+yGM?=
 =?us-ascii?Q?NobGqigqF+Yh99C8LVvCPxdEysbJ8Jd7sgrRQI7Q8UI1hsJzkcf15YUqo7xc?=
 =?us-ascii?Q?wxr51TfBy2IcxRMNcB2LbLzir+Y2Q+GF082LVFPFkswi6ohFWMJKsjrYYRh1?=
 =?us-ascii?Q?iumTkJZlEUgO+jEjgOaK5U2y53uS2AG7CagAKJyX7mUrg9SND2+O5pQiEPki?=
 =?us-ascii?Q?KdAZJ1Rn7/N0tzs/1omQJ7SJBAY4tjAIBows0yYM5Zas7HwsmgczOI+klje+?=
 =?us-ascii?Q?yCEZn6hFlvP7AIp4ksg1lX8WQWHSnzb17aVfmTlK2NSafgCtOeAc0902QhTy?=
 =?us-ascii?Q?7i4J2mmhgflX26cWld6I7DyjjnXrL7Vf0IHmRgkyl/BloYSLkt5tIzXKGQ0I?=
 =?us-ascii?Q?pClIngRROeIjM/ciTzxPcFeQ5ujmRG8E5kIL1DwCCOMIrXtPVGpUrpcntAa2?=
 =?us-ascii?Q?1/SsomOnp4lJLFGlslcalpg67+GNwxhD6qVU5bPJ0pTY6GrDmQbwwIct50t6?=
 =?us-ascii?Q?95+rHv2NL9bqGFE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:03:53.0450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b20962b1-5dbb-41f0-db31-08dd60171066
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674

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
index 000000000000..e0391293a2bf
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
2.34.1


