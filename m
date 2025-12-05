Return-Path: <netdev+bounces-243784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EC5CA777F
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 12:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63CB5312FD8F
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E5F32F74A;
	Fri,  5 Dec 2025 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JwF5ktJA"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D12E27F736;
	Fri,  5 Dec 2025 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935598; cv=fail; b=p3Ydq+O6p1X1OYoSFGxrCxislUvDRzByO5Az9rw9fAWAeKFOsNoKKbk+KgpJvs0zLHD6tpUlA6AldxJdqwkcSF/9xMHczK8CrPmTkaJvrq4oWjhR7HbJqlFCHILrJSHm+74bISIWvTVOtodMQE/VY0ETLD4qHeS83OWaWCM50Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935598; c=relaxed/simple;
	bh=+9N+IIX6sGduKg4CvnCqOG2cM4wqI+gWgHtLOnaQaSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AVv5CVRElKaJladrMFa/EsxVf30WxTfMA/oj0ciEWHVUbmnOvoD1d18rWXK4s17beYVfKWgJOOdkcxWx/dM1SK8UQjbmzpk1/6mM503mvD3IxMATkGHJxSbKMCQ4xLyaIHDabpHq0f1tsmKHRys+vr868FPiK/lK61ZRzFmT0cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JwF5ktJA; arc=fail smtp.client-ip=40.107.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxSJ9P/TDSJ1L7WeuJRuYm9Bjua1d7p8imSeSF+sg5FsZq7Vd2h2k2WE+COAC+M7RdlS+tJk0aSlTQeTJXRoBmhl8P4nEeuiMWxgspDouvNNh7KcuYoHErc4O5u7n9nr+04pEGdmstKAUyDJcWrU+qlv2pEfVm8kij8FM/LW4CEe45BS/cX0e07DxawzOg26M3GDlIybo+aMZSpAP9XYahwilk1q9qHyihV8wKO/oSIHoZvEI99KhycjN6WMql/Im+xiYrzq5VHp+hbll3kxNajjF5o+ufZplfnXdbNERsZc+tvGV20QOnRI8WU+IJ2bsHfKkSfQrecZlGsF6UNWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sN/U439SAwAW26mhOipC+j+4UWMPk+3FpV9uBR5Xgc=;
 b=mWqNRnUhdaOt6dNJQrkcGZ8xva+0zZLNSUXaFKXuiXpBOqyEsPyC7UpO63MgATh8Nn0AcGvRDtm+ibhc1JV4k18Wd5+u3qZBW9Jr+Cp631vOcGVNyBCZuoHiUObrqH+IhHpkgwQYfg7EueEsiyqYoB8ICeYt3wpyaNxipaehBL2jYqJZ3SkZi1X9luCc4xIrSv8Fb/dyyGm7NS25NVhE/vtdhX6uHAS1doUn1lHZUxIY0h/Ply3R2JoTbpWK8diZ6bPoLtvXh5rJfMXxviIRt+lZ5IzBF5UCXNqB9qhU9d0cOZ+BdCfge6bwau40ZN/TQT4UxYjkDwKHeRAzF8Rqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sN/U439SAwAW26mhOipC+j+4UWMPk+3FpV9uBR5Xgc=;
 b=JwF5ktJA/4UXv005HAY5xWEl6zuJR/VQBVOPwkpQzfRTiQ2389k53iGuqomO5mwyNC/2NWz0eYfuiB6lS9xXo5keEtYddasjM5mNl2QTVOfAuOMoXH44+kpUcV0+BMymGbz/ZmdB9x6nQAA07tADponGnML6v4rAtBztBRAlQqo=
Received: from BY3PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:39a::29)
 by IA0PR12MB9010.namprd12.prod.outlook.com (2603:10b6:208:48e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 11:53:10 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::3a) by BY3PR03CA0024.outlook.office365.com
 (2603:10b6:a03:39a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 11:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 11:53:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:07 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:06 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH v22 07/25] cxl/sfc: Map cxl component regs
Date: Fri, 5 Dec 2025 11:52:30 +0000
Message-ID: <20251205115248.772945-8-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|IA0PR12MB9010:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb3c6f2-c969-4e4e-c838-08de33f4dce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lRlaBu8Tl1gvDtdWdEB+Fxu4T6cqqWJ1j2GEcAF3RWrocYb0vkboiMsKEiP8?=
 =?us-ascii?Q?pFTNO2s4BsSi+WMVd9giVPWapn7PIXFct9OE+1kfQi+yarUoJ3XrD57CqfQ4?=
 =?us-ascii?Q?9kZo+IRDpTKvxrw8LLrGHtVCVVLvXE8Dv6ArlovG1EXPqqww0+7PQDfQVETs?=
 =?us-ascii?Q?mf4mdwW8XnsYbMbxXDLhyTjpaXvMqQsqnnzCvcbAw9fYop1qU0qtBkuRcfEr?=
 =?us-ascii?Q?fUhAdbARaIF5j6ANwma7cVLHQqpZBkoDQVMPewHbjiQRLgdPmukfUG23IZSp?=
 =?us-ascii?Q?AM4NEn3TFLg6es6MHNy51kZjtC9vmlUmRCFOmUeRT+jQlEyDr1q30YhyKK/H?=
 =?us-ascii?Q?g/QrF79nkNfuYtvw9h49dnIGNqPu854J+Wb0exbdDTUlb29MQv9aR+u/d/1Y?=
 =?us-ascii?Q?pbHKdB85Alt8a/H1Mtm9lJwmXsbVai1uD+SKFc+h5LNXSkQFxa+uG8ujM7Hx?=
 =?us-ascii?Q?U2EOelLE1Tz0n9IA6Tw7miMEstYSh1eecK6UQyvkn+5th7V48/wFHl2ZVJS9?=
 =?us-ascii?Q?Hknp2rY7OgD4g4gT0kS4xr015cLHqXJBBYCib+Kmlf921dDMmYcU11hXi4ZE?=
 =?us-ascii?Q?5zgCIYGANf/ru9tJyFxG9Ma36eHkmSuKX/UuOLTJqqoRo+y10lT0AuQtNzaE?=
 =?us-ascii?Q?tJElaUnT3++AjLPhLLKIieVnBu19+D1Is0/tTurgxlJF92apHfIs8jg+E06q?=
 =?us-ascii?Q?aw6wO8zh+NqrwcuBaHEImQKMEv0KW+dASH7n4rAHodPkzdtlLXjv/e4F6OU9?=
 =?us-ascii?Q?+1skmuHxOrnskf/Pzk4z6Q7/AZTGk8kIh7qEptBo2RyMQ3CzjvSROzewI4vV?=
 =?us-ascii?Q?YSWgCMsWZbxNK5ALiTd8oQ8aSQUosGrPnK0fEFemaSPTArwdeoFCiwqSF97b?=
 =?us-ascii?Q?BvvM04coSmKsE7STG63kxpON9bj5rgvX2xgmN2R91O/28yVkSFRq3Zchhxbz?=
 =?us-ascii?Q?we86KEYVgeQaGvMUl0gk60HsSzhBl+OhBzq76hWl0DtOLmqpDMC8ILdGlVCe?=
 =?us-ascii?Q?6BShzFUMWHtVys/IS+nayPiDaL2g4CZjx2SsznA/wwScn6CEhsrJrHy+U3FF?=
 =?us-ascii?Q?vJMJNrSO7cNPiQxnYyR5cEIrNvL9xYN69d206E9SVMsmftvrfViuf+gPbqzf?=
 =?us-ascii?Q?tDZ5UYSous/ZLAen0iKDGSHwfRAXmsDHjHXKcBPEHCOuy2NtxAaF/cZub/5D?=
 =?us-ascii?Q?JxFXoraKFEryKPC9NziIonCUr/oMqNAfLJghR6jMM6WJw/H7e9gFQ86ChHMq?=
 =?us-ascii?Q?I3fQK4FWavu2+QQCbAy/JUc9vowyY55im98htxUe/SaTstTmriRspvaXVpd1?=
 =?us-ascii?Q?kptNiIl079QSB3cs2m72w5Hlftz2+x5p3l4Lf4XRSyQPd4CH9t3QgCVSSmC5?=
 =?us-ascii?Q?XtPutHjZpwYpONJR1gopZc7l04G2g4rUHhk6R73HTbrQbrLPdcUm9jr82Ri3?=
 =?us-ascii?Q?9zDuhQhNidBfUxVEkNek/AtmFwJ1n3aSxnTp4628OaHCGKAlb4GjupBiu8bI?=
 =?us-ascii?Q?sQThFEupQoDdoJRY1FyQXc+uTJ2xIh1T3AIwgxa1FTWDalGax28Toug0eb03?=
 =?us-ascii?Q?0+wjrCETYN6F6IjwY70=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:10.2930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb3c6f2-c969-4e4e-c838-08de33f4dce5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9010

From: Alejandro Lucero <alucerop@amd.com>

Export cxl core functions for a Type2 driver being able to discover and
map the device component registers.

Use it in sfc driver cxl initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/pci.c             |  1 +
 drivers/cxl/core/pci_drv.c         |  1 +
 drivers/cxl/core/port.c            |  1 +
 drivers/cxl/core/regs.c            |  1 +
 drivers/cxl/cxl.h                  |  7 ------
 drivers/cxl/cxlpci.h               | 12 ----------
 drivers/net/ethernet/sfc/efx_cxl.c | 35 ++++++++++++++++++++++++++++++
 include/cxl/cxl.h                  | 19 ++++++++++++++++
 include/cxl/pci.h                  | 21 ++++++++++++++++++
 9 files changed, 79 insertions(+), 19 deletions(-)
 create mode 100644 include/cxl/pci.h

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 566d57ba0579..90a0763e72c4 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
+#include <cxl/pci.h>
 #include <linux/aer.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
diff --git a/drivers/cxl/core/pci_drv.c b/drivers/cxl/core/pci_drv.c
index 761779528eb5..4a812765217e 100644
--- a/drivers/cxl/core/pci_drv.c
+++ b/drivers/cxl/core/pci_drv.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/io.h>
+#include <cxl/pci.h>
 #include <cxl/mailbox.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d19ebf052d76..7c828c75e7b8 100644
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
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index fc7fbd4f39d2..dcf444f1fe48 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <cxl/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <pmu.h>
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 536c9d99e0e6..d7ddca6f7115 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -39,10 +39,6 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
 #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
 
-#define   CXL_CM_CAP_CAP_ID_RAS 0x2
-#define   CXL_CM_CAP_CAP_ID_HDM 0x5
-#define   CXL_CM_CAP_CAP_HDM_VERSION 1
-
 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
 #define CXL_HDM_DECODER_CAP_OFFSET 0x0
 #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
@@ -206,9 +202,6 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
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
index 24aba9ff6d2e..53760ce31af8 100644
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
@@ -100,6 +90,4 @@ static inline void cxl_uport_init_ras_reporting(struct cxl_port *port,
 						struct device *host) { }
 #endif
 
-int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-		       struct cxl_register_map *map);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 8e0481d8dced..34126bc4826c 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -7,6 +7,8 @@
 
 #include <linux/pci.h>
 
+#include <cxl/cxl.h>
+#include <cxl/pci.h>
 #include "net_driver.h"
 #include "efx_cxl.h"
 
@@ -18,6 +20,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct pci_dev *pci_dev = efx->pci_dev;
 	struct efx_cxl *cxl;
 	u16 dvsec;
+	int rc;
 
 	probe_data->cxl_pio_initialised = false;
 
@@ -44,6 +47,38 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	if (!cxl)
 		return -ENOMEM;
 
+	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
+				&cxl->cxlds.reg_map);
+	if (rc) {
+		pci_err(pci_dev, "No component registers\n");
+		return rc;
+	}
+
+	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
+		pci_err(pci_dev, "Expected HDM component register not found\n");
+		return -ENODEV;
+	}
+
+	if (!cxl->cxlds.reg_map.component_map.ras.valid) {
+		pci_err(pci_dev, "Expected RAS component register not found\n");
+		return -ENODEV;
+	}
+
+	rc = cxl_map_component_regs(&cxl->cxlds.reg_map,
+				    &cxl->cxlds.regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_RAS));
+	if (rc) {
+		pci_err(pci_dev, "Failed to map RAS capability.\n");
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
index 13d448686189..7f2e23bce1f7 100644
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
@@ -223,4 +227,19 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
 						      sizeof(drv_struct), mbox);	\
 	})
+
+/**
+ * cxl_map_component_regs - map cxl component registers
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
new file mode 100644
index 000000000000..a172439f08c6
--- /dev/null
+++ b/include/cxl/pci.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+
+#ifndef __CXL_CXL_PCI_H__
+#define __CXL_CXL_PCI_H__
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
+#endif
-- 
2.34.1


