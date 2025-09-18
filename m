Return-Path: <netdev+bounces-224327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61E9B83BF5
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE2A524D50
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05014303A0A;
	Thu, 18 Sep 2025 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="inG9D+BO"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011042.outbound.protection.outlook.com [52.101.57.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D529D2FFFB8;
	Thu, 18 Sep 2025 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187115; cv=fail; b=sR/QuIvzu9kRbjgMfovX9RnjjcTyEup0g94OA5fVcvy2PReEmm7tyx93+jsrEsgdYFI4gKBnsS8yaHULacIygFMaHu+GZBvtM5bANr6T7UeHbnjBdLjrU/7+GKkG/jzb1FGWy0W0oJquoiy5+9bYSa6RJGfMTp6ep4BosXmMia8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187115; c=relaxed/simple;
	bh=REJbeodHF/uwXf/+lo+sYzXl6Jgw1aZK2JBgkFD387E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEencGuIM7TsennodaN8Gl0FfpwmDZOnzST4cZ7qUQ/uKLHGNN8obyahB7ksiSA0TDvw7cg/1sIQiaSRoSddMB5g9hNSmDE1PVwSgl5TjUzO2ClDV2GrDlPkDJ1O6DB5ZEl8Z+uTVzknF+nJ1Ke7WwjCtbswl1qPSvnRGUqrGxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=inG9D+BO; arc=fail smtp.client-ip=52.101.57.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gasb7jW1stybx2R71GB1BuDooT3pYGUZUXfJNzpPuW+uDW57eWSiCO8BPByMT9Yipkcp9MlnDLg6P8y7iTs1orvApqinPODWfLHjj5euanMvxZje+tW7U950isGfVVata7CBKx3EbPjUGCxrni7dkfDZ4rMh7VJjYSLvpTOO4lJEtkRT/8IDuwRZ+EUi4LkmWH1DF99+6X7ch1H4k8xgup2F0TBQjq0w2K3ejF5G+JgJ8w0u4Qb8GUyuI3K/mX5iiaKnNh0rm+3/muvvEJyHRKJAmaNrWnT+xAG5qJxMgRXL/kpD1z6ua3hood9/DW03m0H6BShiV/Hrp7ZVFM0C+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgBn5FcpiaXAWfVgFGlZBAQHbbhZ1q19pqdoQfwhS6o=;
 b=vgCgmlD0J2YnyVmapmlFY5/0d56o7YftYrYFYytWPgQDBieB4+m/nvuPlsha/pM2tq4Gfc/QQlL5ABZRqxWklUhF7YWJLtPAuajpQdtOGXJQuWLTET4v5rwAtpvJeZNq7dq49tl0+gbMX/Qu7B+FD2M8lEYMr8ZkI5adcSZCSxhmCqzFTmgbaz65X3KmDWUU6qPPws/VHzx3e1Fj0cVaemCJWAMTQJ3tXUKlOx+6U7WfefwbudRY6JJxdMeloSQQwV6llJTqPyZf9SHXWOb1BTd5fdRexjo7W9LS06SHq5wNgx3QBSa7LcneTYlUzjPSOTtFvZz+Ja0mAFNBtgzVDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgBn5FcpiaXAWfVgFGlZBAQHbbhZ1q19pqdoQfwhS6o=;
 b=inG9D+BOPBx+PmOPg9OI9KU5iGk7DP3GJjGFiUOnPXA68JzHY92nKRGlTUrBIyJBS7QvXPzYd+2ELkXfC2DBaFxpXulCAQqvpdbMOwjFtIIN8z/WRlyXVv6jS6UxSh9UUdf8NaiV+k3YNY0qGtIK2Xh5cPR6ZyawuuYW/XsXw4U=
Received: from SN7P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::30)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 09:18:27 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::47) by SN7P222CA0027.outlook.office365.com
 (2603:10b6:806:124::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 09:18:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 09:18:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:07 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Sep
 2025 04:18:07 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:18:06 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v18 04/20] cxl: allow Type2 drivers to map cxl component regs
Date: Thu, 18 Sep 2025 10:17:30 +0100
Message-ID: <20250918091746.2034285-5-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6336cd-c22c-4e6d-f3de-08ddf6945378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8wHBrxxjGQDX8Q7aWaTfERpAjD1HsqIAscG5SQBf+UG3FIp58dWeSUtKHFTm?=
 =?us-ascii?Q?TIIy0vlOQtRUNEAxHReZPNVOVMKmsZchEl7cc661bdnl1zA9O6vXTZJGx1OU?=
 =?us-ascii?Q?3TfndnAlseQbmA1aK6gmcIJsMSsV2maiw/rBawaGXPinR13rYAy34ZBtuRGf?=
 =?us-ascii?Q?QKwp60Mm3CKedg7gevcq5e7U/bHMr62Rd8K7HyIMRVZU2Y953WdejgS+L2eu?=
 =?us-ascii?Q?aFWur7r4uoFvFysjx04QXCBw56+5RrZYVPp2jD4K12ZfUJQLnx5fvxPOwXmx?=
 =?us-ascii?Q?f8WiP/aU/HwtMVVPcoJRf5Uwvx6vdz9ptoV/uVlzAZLfQ1+itLLTcEBSfFd+?=
 =?us-ascii?Q?Oof+hFTN9m/TjsdHu/o9pfOsMPiRU8jlE5ym7Q5gMdo3Zcxxs5nwFbHDAS6g?=
 =?us-ascii?Q?kEJ/CuFABYzhAr4bTZus3LdbVFYSMOcdT9UGmL80fGAD4G7ah4tzStY+xgm8?=
 =?us-ascii?Q?o/t1wry2qaMwkXs2PuOfDgsuomWx6oalMGBxYoHSdDGbVv1YdGStpPyUtHWJ?=
 =?us-ascii?Q?2B1lBkoUqbZ44Gl9xcx0sLhHWMG7N2e+TDt9RiWT9n5mCnNLCRziFGfgsrqj?=
 =?us-ascii?Q?Im+HdaGBbJAGKksyfE9ylxhgGkfUkN9b4aGKra8JnO+gWvhtu8tAlgz1ZS8z?=
 =?us-ascii?Q?BeSM0Nd9TZUACl5LkHd1/CSwcqun7yl/rlYp0dexaLp5KWusJMi+aM8aNNIH?=
 =?us-ascii?Q?m3f7yCpXGiFcdxvxO8oVFHedQpnqWyna8IviGMFyI+KZ81AAQujf/dH1xNSp?=
 =?us-ascii?Q?66BQAEuzB+iN22wOvRFXrh8J1mcqC25gWt7WM6R0RCkTv46XlIKSE1PB/nRk?=
 =?us-ascii?Q?NxNt9+Oksr0DWuF/KgIOSYmiHlYDAIrkFuXLRam2IRSeYwKNFbEjHkfhvT9f?=
 =?us-ascii?Q?bLZSQkz4IyagTGjRVG1VgYnc1x3XOChiwntAbETloh6ltN7Q9o0Fd63bAXdH?=
 =?us-ascii?Q?UjM9kXZZu4+NgEBkDf7Omchbc5xp8o3UPkcMyuCrdGafzo2d3mWvjONtVlWM?=
 =?us-ascii?Q?N3N92WP4+v4bxcIDuLQ2DFeawCii2OWMduJcmZgH9ym8pnuWzyjTqXlK15uB?=
 =?us-ascii?Q?4Suza1KVXOvDqw0Goiy6P2BbRc3yvuINBFtp7ZgTji2YXyPqkpEhwFAKrygM?=
 =?us-ascii?Q?RLYOl71Z33fflnZgJQigcqgVJqyjrKP0Ni+hhG0WVYNuAzzYSLSw2V2QvXg4?=
 =?us-ascii?Q?rE2WxVeondJkiqx80IyHSP29fDvEP6V7PuVf2+90GbTK98BqW8MYnJ2V1dls?=
 =?us-ascii?Q?wTg5WLpVw378yA1tLJu5nJmN1yItAILlvEySWkfAZytuLOmWaA0r1aU+/BOl?=
 =?us-ascii?Q?odwlOQ8oWm+hDo7utrOY7NAcFTsTV65jBU8qjCHLlMTh3d0FhKjXqDCwQMYc?=
 =?us-ascii?Q?PafQ8kB/NTEFZMfPLlqdjH2nJmvjR8IAv0CBMg7orrdyOADoVsPVjg8KikTs?=
 =?us-ascii?Q?xbPcgaFcNs6Yvqsno0PiuawjCdnuI50YlTP56AI0Td3zNyFmLbexrMjcKDfr?=
 =?us-ascii?Q?4VAnc2m7piys4x6WUoVu+gQGJ2utpvUcq+cY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:27.1894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6336cd-c22c-4e6d-f3de-08ddf6945378
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924

From: Alejandro Lucero <alucerop@amd.com>

Export cxl core functions for a Type2 driver being able to discover and
map the device component registers.

Use it in sfc driver cxl initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/port.c            |  1 +
 drivers/cxl/cxl.h                  |  7 -------
 drivers/cxl/cxlpci.h               | 12 -----------
 drivers/net/ethernet/sfc/efx_cxl.c | 33 ++++++++++++++++++++++++++++++
 include/cxl/cxl.h                  | 20 ++++++++++++++++++
 include/cxl/pci.h                  | 15 ++++++++++++++
 6 files changed, 69 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index bb326dc95d5f..240c3c5bcdc8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -11,6 +11,7 @@
 #include <linux/idr.h>
 #include <linux/node.h>
 #include <cxl/einj.h>
+#include <cxl/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <cxl.h>
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index e197c36c7525..793d4dfe51a2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -38,10 +38,6 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
 #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
 
-#define   CXL_CM_CAP_CAP_ID_RAS 0x2
-#define   CXL_CM_CAP_CAP_ID_HDM 0x5
-#define   CXL_CM_CAP_CAP_HDM_VERSION 1
-
 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
 #define CXL_HDM_DECODER_CAP_OFFSET 0x0
 #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
@@ -205,9 +201,6 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_reg_map *map);
-int cxl_map_component_regs(const struct cxl_register_map *map,
-			   struct cxl_component_regs *regs,
-			   unsigned long map_mask);
 int cxl_map_device_regs(const struct cxl_register_map *map,
 			struct cxl_device_regs *regs);
 int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 4b11757a46ab..2247823acf6f 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -13,16 +13,6 @@
  */
 #define CXL_PCI_DEFAULT_MAX_VECTORS 16
 
-/* Register Block Identifier (RBI) */
-enum cxl_regloc_type {
-	CXL_REGLOC_RBI_EMPTY = 0,
-	CXL_REGLOC_RBI_COMPONENT,
-	CXL_REGLOC_RBI_VIRT,
-	CXL_REGLOC_RBI_MEMDEV,
-	CXL_REGLOC_RBI_PMU,
-	CXL_REGLOC_RBI_TYPES
-};
-
 /*
  * Table Access DOE, CDAT Read Entry Response
  *
@@ -90,6 +80,4 @@ struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
 void read_cdat_data(struct cxl_port *port);
-int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-		       struct cxl_register_map *map);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 56d148318636..cdfbe546d8d8 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2025, Advanced Micro Devices, Inc.
  */
 
+#include <cxl/cxl.h>
 #include <cxl/pci.h>
 #include <linux/pci.h>
 
@@ -19,6 +20,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct pci_dev *pci_dev = efx->pci_dev;
 	struct efx_cxl *cxl;
 	u16 dvsec;
+	int rc;
 
 	probe_data->cxl_pio_initialised = false;
 
@@ -45,6 +47,37 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	if (!cxl)
 		return -ENOMEM;
 
+	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
+				&cxl->cxlds.reg_map);
+	if (rc) {
+		dev_err(&pci_dev->dev, "No component registers (err=%d)\n", rc);
+		return rc;
+	}
+
+	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
+		dev_err(&pci_dev->dev, "Expected HDM component register not found\n");
+		return -ENODEV;
+	}
+
+	if (!cxl->cxlds.reg_map.component_map.ras.valid)
+		return dev_err_probe(&pci_dev->dev, -ENODEV,
+				     "Expected RAS component register not found\n");
+
+	rc = cxl_map_component_regs(&cxl->cxlds.reg_map,
+				    &cxl->cxlds.regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_RAS));
+	if (rc) {
+		dev_err(&pci_dev->dev, "Failed to map RAS capability.\n");
+		return rc;
+	}
+
+	/*
+	 * Set media ready explicitly as there are neither mailbox for checking
+	 * this state nor the CXL register involved, both not mandatory for
+	 * type2.
+	 */
+	cxl->cxlds.media_ready = true;
+
 	probe_data->cxl = cxl;
 
 	return 0;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 13d448686189..3b9c8cb187a3 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -70,6 +70,10 @@ struct cxl_regs {
 	);
 };
 
+#define   CXL_CM_CAP_CAP_ID_RAS 0x2
+#define   CXL_CM_CAP_CAP_ID_HDM 0x5
+#define   CXL_CM_CAP_CAP_HDM_VERSION 1
+
 struct cxl_reg_map {
 	bool valid;
 	int id;
@@ -223,4 +227,20 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
 						      sizeof(drv_struct), mbox);	\
 	})
+
+/**
+ * cxl_map_component_regs - map cxl component registers
+ *
+ *
+ * @map: cxl register map to update with the mappings
+ * @regs: cxl component registers to work with
+ * @map_mask: cxl component regs to map
+ *
+ * Returns integer: success (0) or error (-ENOMEM)
+ *
+ * Made public for Type2 driver support.
+ */
+int cxl_map_component_regs(const struct cxl_register_map *map,
+			   struct cxl_component_regs *regs,
+			   unsigned long map_mask);
 #endif /* __CXL_CXL_H__ */
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index d31e1363e1fd..bd12e29bcdc9 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -23,3 +23,18 @@
 #define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
 
 #endif
+
+/* Register Block Identifier (RBI) */
+enum cxl_regloc_type {
+	CXL_REGLOC_RBI_EMPTY = 0,
+	CXL_REGLOC_RBI_COMPONENT,
+	CXL_REGLOC_RBI_VIRT,
+	CXL_REGLOC_RBI_MEMDEV,
+	CXL_REGLOC_RBI_PMU,
+	CXL_REGLOC_RBI_TYPES
+};
+
+struct cxl_register_map;
+
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map);
-- 
2.34.1


