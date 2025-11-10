Return-Path: <netdev+bounces-237234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5384FC47A0D
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F853BF3D4
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4152B27991E;
	Mon, 10 Nov 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oMJCGVw4"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F76B2741A0;
	Mon, 10 Nov 2025 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789055; cv=fail; b=U1NEGge15bfzv+JEKKe88DXTpUIJBNcJ9Pfh7mJe8qA071S4+HdMzXZLvnRv+PgSQFqHoBjpvMpUSvck5NQsdQBPTJ51oSKM2l6Ov68UuzaDK7IR1iz/qF0AT9wHYm5wqnrxphvxwuWyDvn/lYAelySZZ2rwUWW2W8AZgjAmdmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789055; c=relaxed/simple;
	bh=f16ezKmN/5k63RjgduZQ1yTNWQ0O2q2Nbki/5fZ+WRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZVmxj4tkhCqufOk6BFvADIJvn+s//zE5H86CnLis3LxrlZA4aTpEbrdeT+zVB2Cpav0KmRU4eayw67m8dqvc3dERl/5mT3g+NnLVEC9Tnx/hwq7p47Sjyp/5EEu+VCf/EKXQ31v2h/7QJmyY/wj1ouoKjUg3STpSNKl9GPo6wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oMJCGVw4; arc=fail smtp.client-ip=40.93.194.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ena1yBqVVuOxqBH1YV02wOTGkXW1DQakChe7IulmjaHP3veCVKSLwJQZeAdbJwyWfY/pSIV22VLzm84mbqqnzWI4Vu568mK3dDGbQA2ASghvsGckVydi6vhktmsmDc5Z/wYe0nAiXEBhg24fJUcDaWFVKvMSN3LZq/6tyX59jQ/PpZzyHc9jyLAaCU1o5oXdG58IWDMCxLuiqO7KQN5kSh6ipJyYUItwPUAQ4vHTSBo4qn+AUbv7q6AKjZYdiWJSGJ89WGpMrKBtpwcvdVPOxXX/8jk2iF1w/SHhGb5/Q1a1MUc7JtwKgEMY2/+WEC8IJJ/wEbGdlC2BmvOUKee3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xll8yKNcCnxzZs3ub6B5uXOUT6JYwtJzXxKt957pqo=;
 b=auoteSz55zJhZC93x2A9326KtrizX/CRxBIUoA5KudIWUbfXE+bkgpokjd9Fm0y5nIfenLfjM3mMeXcpznu4qNlh9dq1yXag5FKMUQBr0ncbR2jxoy8zGk/n6VQXTILQmSV8pOFrElQF+5/eJu/YSU6uMHounth4rCffdiBGBR0d5QKCU5k2n8mF+Lq2lMpVxyGQRQ9WPIxOvBuhDuwN4Uo6HgrHgi0Qf2svaV3WjLjVTaoK0djqpcTArXtcb5mn978jOYffba42ELvxauKTbihuCvm9UBCwysJsQl50apTqvYjMVbj1WbIm0ibBXPTugHsEJlBbDR3Doov79mumhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xll8yKNcCnxzZs3ub6B5uXOUT6JYwtJzXxKt957pqo=;
 b=oMJCGVw4tWajsYgA8D65HSK94jAv9WM0iJLU2CqBUjrfMFU+puDzB+4d3KjS74lD20D9YnXZNGV+OsETL7I8T4x4VGx5VO59VcaZ8tgsudw+ci3FZEIt7+l5ZLjpenE4QujxQtkSR8co7Cnl1OZYHK7m0MpwLNk+0VMmDfCSBC8=
Received: from PH8P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::7)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:37:28 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::3a) by PH8P220CA0006.outlook.office365.com
 (2603:10b6:510:345::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:28 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:13 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:13 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:11 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>, "Alison
 Schofield" <alison.schofield@intel.com>
Subject: [PATCH v20 05/22] sfc: add cxl support
Date: Mon, 10 Nov 2025 15:36:40 +0000
Message-ID: <20251110153657.2706192-6-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|MW5PR12MB5597:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a29b4c-baca-4c24-de3c-08de206f0dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?liUcnYes97xdtfUYvDS83wmkjjZrap6YP8R00mdcFzIHdIb8AaMft1BYPclk?=
 =?us-ascii?Q?bYewD5bNjyajbtyusiCFeBuwiy1a0X7tYGjDapgCPiAfa74a35d9iBPF2tTi?=
 =?us-ascii?Q?+vMCa6HRifycEnU2lZTeJCV+RYIH8OMAXwcYO5+jIMqOsTuEvG7MD1ohLPtE?=
 =?us-ascii?Q?lpkdY+KAo0l6EkC6zE5nmfnl9azbVFk3cVfK6pfO6r2oWGIPtqFrHhPZHwha?=
 =?us-ascii?Q?E6nNuSFbm0+7PPItEJHRWbNAikBhQbQmeljx+Bll5fDrK4/nLighzzmzB5Xl?=
 =?us-ascii?Q?ZKmL/rLNLS6CCe+EUHJELs3OqoTdEHZcr7uJ+STLI+ekPiRGewp2KGhoZy87?=
 =?us-ascii?Q?sQmdP4bJ/19OAto27B3VX8o9ZIC4FwJgCat1/uwu4eUWOnKIjjmTxnh/5LU+?=
 =?us-ascii?Q?gpJRG3KH8wVcxzBN4m5Rge8oTbR3jEcVNdjGjCXUtYebhM+rgpjURtOUAXkd?=
 =?us-ascii?Q?NyVS352nJZAAgdWW1bjsZkceTWUSlfxISwcttsp1OjTxgym1aIat5/NlG6J+?=
 =?us-ascii?Q?REMQ4I/dE5CzPMEqAnjJQZXZ4eaMrUBROIw6T0jzDcclB8UYMIdf4ggQvDUh?=
 =?us-ascii?Q?uhPcA11ZtvAKYhtn1QIZE8EGxZ3EKGlp4r90bhl067BH1DvfU0BK3IFErIp8?=
 =?us-ascii?Q?AZNSNTC7yz97HHNNpBUxNhYx1ah5XSwtEdBsCDAhDnaxcwq0A/5SCvXvROVC?=
 =?us-ascii?Q?sGmAuZjNDSkhpN0kMt2VlqQrzM1xo5+xb7ZCe9RxFcgkgYffPK7ERL7IrR8s?=
 =?us-ascii?Q?P1V/sYL2b3VBV7qUn8eaaSEgrbebtLr6ypfDWFROTD/9UIZ01IZi3CdzS6Ay?=
 =?us-ascii?Q?RaXwrq7TrV2ipnPJ8Zu3oaUuoEW4svra+HreywDHPwUneIwPzGb61yhtBCSh?=
 =?us-ascii?Q?v5475qaC8j5C9NbuZLPa3N+x3z/CbbsJjjWNfxrgJBZ6lwKOxXwV2DuNy++Y?=
 =?us-ascii?Q?Fww0Mm3jHp5iX7cs2tS/tjiFE4meBtNoiOvSPQV4FKlyfnGxsqT53csJVH2e?=
 =?us-ascii?Q?w15/RN9maOdslaWcPO4KDZBc1v6zZwCYf6NrQDWqCg+QR656wxg55D5i8gHU?=
 =?us-ascii?Q?U/1VYE7slPDWj0aZav+Y7LCwRFJSgu3jyMEqJvyuo+XnEG0a8dkXK2EPUHjF?=
 =?us-ascii?Q?tlBaLcQkOHwEGbbEQMcUleHyvd4JCkdUhSqWgESiNpKk8MvIqhE6lGLIJ/iO?=
 =?us-ascii?Q?flr4rvumGYIGaJjaeF2RZ6ufMHiLQphTQB8Npj5+xoohrM32mBobht9Ao3mj?=
 =?us-ascii?Q?3ySZvD8E58dnjV5u3hxEoSTJctVUMaEJtFhUSk46EPfH/+ZR7ktXO/eegu42?=
 =?us-ascii?Q?OxH6gLxSkX3HuANF4VYojHuIBng+K8Ffe/CAVsb5sMKM4HYcHAaI22rgrmKM?=
 =?us-ascii?Q?noiDFLEVzRU6IlScjr8s4JSsAnOyjH/0t+z4Cnqixjm7qPFoS4ToGUhQTC91?=
 =?us-ascii?Q?Vt5E3DWpIiMKybtDo5LOwtqvxYpzSBR2pElOF1lKfrIMqXzpH8KvM7reyKPz?=
 =?us-ascii?Q?R/lW57tD7FlIRQhiTwkDVH/MirseCggQwaGsDA/YDGINS10B4JpDUOPYUbpc?=
 =?us-ascii?Q?VAzgI8RbvcMZKx/tKEQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:28.0610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a29b4c-baca-4c24-de3c-08de206f0dfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597

From: Alejandro Lucero <alucerop@amd.com>

Add CXL initialization based on new CXL API for accel drivers and make
it dependent on kernel CXL configuration.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/Kconfig      |  9 +++++
 drivers/net/ethernet/sfc/Makefile     |  1 +
 drivers/net/ethernet/sfc/efx.c        | 15 ++++++-
 drivers/net/ethernet/sfc/efx_cxl.c    | 56 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    | 40 +++++++++++++++++++
 drivers/net/ethernet/sfc/net_driver.h | 10 +++++
 6 files changed, 130 insertions(+), 1 deletion(-)
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
index 000000000000..8e0481d8dced
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/****************************************************************************
+ *
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2025, Advanced Micro Devices, Inc.
+ */
+
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
+	/* Is the device configured with and using CXL? */
+	if (!pcie_is_cxl(pci_dev))
+		return 0;
+
+	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec) {
+		pci_err(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability not found\n");
+		return 0;
+	}
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
index b98c259f672d..3964b2c56609 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1197,14 +1197,24 @@ struct efx_nic {
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


