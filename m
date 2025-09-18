Return-Path: <netdev+bounces-224317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A90EAB83BCE
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514641C21EE7
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B962FF643;
	Thu, 18 Sep 2025 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D1JFIdX6"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C50D2FF141;
	Thu, 18 Sep 2025 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187093; cv=fail; b=j1DvvSgiZTNptJDrewOas0bPIt0vuEmm1MQ7P+qTS0FDFKngtDPMzA26CHG9LeEBbjlC06pKyeXr1hCAG+89+U8N/m3tF7AzQJBe8F1oP3ZdkCXjtUSX22JCsOjRbsgdoBJ9H4fEFbErRvzUB1LLZPeFXvcR/7TP1LGJAaG4TNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187093; c=relaxed/simple;
	bh=BmVRcvOCudYfNzrtdhllBLzqbykudcaUd1ZHHdKVjMY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnSkq+RHu+hO8WkGm+oK1VjS7GCx+Qcj4PcfqlG6r9v1Jy0EiFL18k2dHUR5PI3uTyzGsDE8nn9I+qSjC6TLxQQzbHJU4S4CjbzhYwhI1Qlafu3vOCyyFpgFoDDVY7QWg6IV0exaNa+quibtOmK57HPWpq4UUL5maRe20RuUjd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D1JFIdX6; arc=fail smtp.client-ip=52.101.46.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6VE5XG04gbOn750TtqUiHJ6UOP+93WFSCqR3fjtsADVq1UwHc0Vzfc763v5bQwuFUmycMTJXwIJSOJ8Pc8xwcGqFXphJ/Y0uEboW53ZhE7BDf78UXdPWaLhm05Lnush/kNIHbz9cW4gkY3SfCv1byVSgLz6Y48j4HQ+HuvxPiu+3Zz7i5JwqNlOpUjhk96s2G6LalF8wn2/C+qiGtll7zCL7t7eVmsC1KY3TDmg1OXFqvsZhZR2rL8w17pE1a8p1MW8xqG4Xb8q9Gu8YiTHcSbpAXv8UbjSd5aV6v1p5Zq+tG1Oj/ZPiSwT/eW9dCTcYpfj0FYM9xTJEWMPkGkrFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3ikvnK/AZ2YMylyVKxDrrpoUSwfRTOtWOrUEutSkro=;
 b=vbjHKHb88vozOmk2Ew32rH7yGSqO4HCU+4aMeOt7NRHxxYWt8cYmw6IQ8lViKBKjuCX5XwpZCX0OZNiq/TRXp7V0Z/hqXQ2p12pu0xEd+voWzjnw2YZ99e1kVz1r+0I2pfrlb1pt2GGo8cHTPaIpj5vdRa//du3RfVL8jw8KsArifxDTu2MXwekMfJl1KgDfpypa1mOjwzMb1al1vqXc1+deusF9lkqdlWNWbeYfX/kQO2TtR8kRE4NH6bETU/dk0PDSx8HTUN+dzpeizEuRTbUOJMDrK8fBvEJ9LtuAK7RWwOSEYr9fhSWL54d5ZPhbbbBq5vtQZgs7ZrFbyW6t1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3ikvnK/AZ2YMylyVKxDrrpoUSwfRTOtWOrUEutSkro=;
 b=D1JFIdX6P1jEdKAzZuT9ndJ0h6GcxA7GOyJ9VdZS7OPM0qovXh8G6S2MS8OiczheZsEhV4nLxmzPTMNsKIUpF7pe4pwjMw4syh9LCtJbaR59+WDib7xp8x1ME6M8vYldPEG8fJneoUGwGC3gw5bl8G5nQrraUk+8j/xBPAl4aLM=
Received: from BL6PEPF00016418.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:7) by DS7PR12MB5816.namprd12.prod.outlook.com
 (2603:10b6:8:78::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 09:18:05 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2a01:111:f403:f903::4) by BL6PEPF00016418.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 09:18:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 09:18:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:04 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Sep
 2025 04:18:04 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:18:02 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>, "Alison
 Schofield" <alison.schofield@intel.com>
Subject: [PATCH v18 02/20] sfc: add cxl support
Date: Thu, 18 Sep 2025 10:17:28 +0100
Message-ID: <20250918091746.2034285-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 998e41c2-eeff-4d64-b862-08ddf694469d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?58ts6qTrYnESqSPZ3r1q51dSqMNs7SGemdHlHB3TdfS7VpwF37A6DAzpy+jb?=
 =?us-ascii?Q?d7Bu+nYQi6V88OdPLEXuMnXrb1HR1G9j2wko3xmUgCOp2B3Pv8f/RzeWSLJC?=
 =?us-ascii?Q?1nBxtqSnd6TKPwus2/8U4z42UtBqzYBBMY4ri+ClAEIbrAvBcMp2Qq0miI+5?=
 =?us-ascii?Q?Vvy5lqqpyBi6FwVq0GG42ubUEYrOuMtVvcd+8gU2dR5FpnOe++dxtt/YNz9X?=
 =?us-ascii?Q?ZM9k2fFe1qvRwIG1Is3gKol05dOn19NinyPu9GyuTkOb4uARdEN31heJwY8h?=
 =?us-ascii?Q?LbJ4RW3trIERjwm2yaS1FsIXB+8sfk+9uDsJN//aIvR3VrtKZ65PnHwyuBFy?=
 =?us-ascii?Q?/rPOzQR8VnWAyxylBLxZpYgUy/SHPsKnd0HtLZsjO5By9bYRIta5V/EuLPKY?=
 =?us-ascii?Q?eTLPhw3/5Lfx7X1HRF7oFCB8pmUzG7gM/bnScSuxfgs318ieLDvHrStAkUKe?=
 =?us-ascii?Q?e13ICjSBwPAgoxgF7X0M2U7FMcypIWe5AxILyeeBPxhXbXevipmtNWN5LtAM?=
 =?us-ascii?Q?/08s0LzqJsmSlBXCcg51UqX/JCiRKAplTH74daXfnwcjhb8hP14NR1JZpkhS?=
 =?us-ascii?Q?6VvF0sd7XNigQZFBRPoVGqSD+rXDmiXNk3B06KOef/6NIZ+Ecy6PUGB8CTrL?=
 =?us-ascii?Q?2OWehDK8uezv4alwkcmcKnNBbO6TxUlFuvtsSJNhoTF83o8qaaHqhTGliUYf?=
 =?us-ascii?Q?L0CwnDOjfv+HoOoPEng7O+z/arhjRAhFhGdX1Wq82UubWKlW19kFrTTVdbho?=
 =?us-ascii?Q?n9fgC1sMTKfTj6gkIYC6N7RoRzt9shV/U7PfcYrz2oTBXf2D94JZ7BiuhmjI?=
 =?us-ascii?Q?z8O/b/3YeeiNHzu4VtwW9jQsO9U3jl2e7+jC4AkvYEpF5vHKT4shdfza4AO3?=
 =?us-ascii?Q?MwYI+4KzCgi4fym7KhrogdHS+r3liFfVDmW0v8RUKZWRFFCm4zF2MRCfr/pR?=
 =?us-ascii?Q?NQBTWN70f2LQtfKdycmFnHcxrNYHgO+vftPVBUR1VRrp3NEUySig6GnTKjAd?=
 =?us-ascii?Q?GU7Bk3JnfPdoHVJ0rCuwUdV74rHcUOF/Pvg4bRvlsF82wEbRPjXTkvFe2G9d?=
 =?us-ascii?Q?O0tOoQf9UpituFIOWJ99WagU52UzvhzpRbgixnzb6szzHtDqp9nkj2Ee6hf3?=
 =?us-ascii?Q?9FHX0j1hJ5C7h+QamsY7GYrBUOQDG55tnCV7fpFmpX2lcBD65hFbYheWSJfU?=
 =?us-ascii?Q?MpWsw/5h5KuP8alxKOg0tIU3Lws8Q5XSVi411XPeohSQzfQTnWdT19e2NrKf?=
 =?us-ascii?Q?q5c/9dP6BqUnLV7dIL9VmNh5AfQffK9TLKAzwhA+clgaDjyxeoMYCiHBfnPV?=
 =?us-ascii?Q?1zltOva3xsNQm0pHWrxRHo849cgzs2mzfBQOY22gUyOuip3De+pWQJkHfKpr?=
 =?us-ascii?Q?E31jh8O2ljSH5jua6Rp8PvQ/mhMe0cWHOG72GWy7gx1uDsnM18R9Difuzth1?=
 =?us-ascii?Q?LWUFEB3DGb8w6FEoNX7I28gtbPjU+lLlsk8ySwQY/UOIKL31aMCwHZfy/Kth?=
 =?us-ascii?Q?9NhcVg81drgUOnrn4Y3bmLsTxj9VVNMfjhkV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:05.6393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 998e41c2-eeff-4d64-b862-08ddf694469d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816

From: Alejandro Lucero <alucerop@amd.com>

Add CXL initialization based on new CXL API for accel drivers and make
it dependent on kernel CXL configuration.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/net/ethernet/sfc/Kconfig      |  9 +++++
 drivers/net/ethernet/sfc/Makefile     |  1 +
 drivers/net/ethernet/sfc/efx.c        | 15 ++++++-
 drivers/net/ethernet/sfc/efx_cxl.c    | 57 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    | 40 +++++++++++++++++++
 drivers/net/ethernet/sfc/net_driver.h | 10 +++++
 6 files changed, 131 insertions(+), 1 deletion(-)
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
index 000000000000..56d148318636
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/****************************************************************************
+ *
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2025, Advanced Micro Devices, Inc.
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
+	/* Is the device configured with and using CXL? */
+	if (!pcie_is_cxl(pci_dev))
+		return 0;
+
+	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
+					  CXL_DVSEC_PCIE_DEVICE);
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


