Return-Path: <netdev+bounces-240131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B7FC70C86
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 095FC4E036F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346CA302CA4;
	Wed, 19 Nov 2025 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NuGdwwBb"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010066.outbound.protection.outlook.com [40.93.198.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B81828751F;
	Wed, 19 Nov 2025 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580180; cv=fail; b=jtXBgSU62xySty9K3VSeKBMYt7WzJT6YLLbWKCGZ+aYfuXQB34inBXKDsBm+/z5thC4skrouyaytoU2zOnWFXILpqRGs5hOIXBKoOTA+F4Ufyo/dP+PIg5um0oRf9+0RJQaSAGJLyc4ti4wuCoC7H/tOUttnkLPPWvda0bfYwdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580180; c=relaxed/simple;
	bh=5qP2EwE8QzA+NQFq7ADWSJAKIO6iKHjnh4L6/QaigkY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSKi8H+XbuzXQYTLK+Kty72CUpXIAEGdSykZL29UbOLF13b3Drxvh9XxHlPtCkYAjxa+rC+a8rqfOw/Z5VtvstsP4LKD/0Mg/mIGmKCYWoq2x0pC5XNsVC4qeYmVAmDqt1zehHyvcD8Y2wLQviHLuyEW5wc8s+Q6bpflNvYJip0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NuGdwwBb; arc=fail smtp.client-ip=40.93.198.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coOSnBQKgI/NoDd4G1WvOaFyhbjcrBvaZY0RvCyCYTttWHW65o0yVUg9hHqIIHwi+MxJOs4/FAkLnmfyN4ek5XREzOEOIBMiAv5dv9/No7Meuw8CBTOyAR6qFXJU6KHdH+WuU8u4vYGLSZgJ3gjqYnMi5aY/1LL8Dw6NEzMHQrIqwK1jiY8zykXD9wQmsi1JO+FLy1YKiSbrJt3fOGSUFAMyg0S8ZWTxnnzn/iuAH396DFpp+3vDdVM4D+qn08RgqnLBDAnSzdDYncYjaQG5AcmMhWfa5kTpyVt31R05DMdegKDEcobDDG0kpfA/X6KoRu0+PzoY790Is+hK3jlKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYvzWCF+fLKbAYDKmPUOIP15CG7xVzoyo/nCKeLujfg=;
 b=d9frXMcVt0GJPIC9VopBzT9/y4J9MLNpwkoBxptYpuAHMSgL9PIHGvzlBUR/kYFmFHouLGmOpuqCEg35b8Kfkk82MAm5wkDRowWkei8NJNl7N0mXMf4V4M0HjYuVnETIwcRZgHLFnRiYqgb2dBs64AtSVD3q0Q9vZMpf2dPAQ6QzRW/hyY0Ml+DKrmWtgupzjVeNoIPOu265Ci1qjIi9UsJPL1zCdaZLdg7qhKDjM96UHM8MTemAm6F/GvfE3N1KSJ6QYOKAehPaF19gbpVqYvfZdrVxReRBB0xifZzRhq04VrzeoiVcB3+omwX75Ch8LyfjcAybE7xzQ3pF001PZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYvzWCF+fLKbAYDKmPUOIP15CG7xVzoyo/nCKeLujfg=;
 b=NuGdwwBbs3XLvq5kX2TDBQ8aQdcpmBlv75P8AbsvWH+7q6M+pQj2ejYObMmoETK3w2swkv0MRJ4Zrs+y82yixlDEHuPflV55QgyCXbVAvehDDODbTGrNtFEsp9VU44jdbpVddmVyXTIxYQ+P6Ydjk5FTKWPj+9twheJIHuRRjxo=
Received: from BN8PR04CA0052.namprd04.prod.outlook.com (2603:10b6:408:d4::26)
 by SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:22:48 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:d4:cafe::fa) by BN8PR04CA0052.outlook.office365.com
 (2603:10b6:408:d4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:22:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:22:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 19 Nov
 2025 11:22:48 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Nov
 2025 13:22:47 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:22:46 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v21 02/23] cxl/mem: Arrange for always-synchronous memdev attach
Date: Wed, 19 Nov 2025 19:22:15 +0000
Message-ID: <20251119192236.2527305-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SA0PR12MB4367:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d49821-a3d3-48cb-a175-08de27a10672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mAhiX3fn5qhzBqajdu9nHfsUO1KWKwmunGEH1fgmIv6ldLohdXFymNzVl9tV?=
 =?us-ascii?Q?FwpAB933ShioFcSptdch1JSvoPwqIU3clen5wfnygGl5H4AIJKdk9mV04kGa?=
 =?us-ascii?Q?tpKvGElUdK7SHg6fs57xYvqdpYPAV+rmCUDuze1CTvPMJMU3HnPy0qie7Ztc?=
 =?us-ascii?Q?1/mF3flJBdixHejm17Pc6tpQUjSMC9TW8u7gyzN7QNRPHYQLhmf9EmGmd3vr?=
 =?us-ascii?Q?Jnh3A1j2okLW3cvBL78/7u+sZR4GA9nv4kziap/xQxsZcgu8x0TC94vUfny5?=
 =?us-ascii?Q?X+TTvC0GEIhxSBCZonbi/rbRiEKOIkPKEw05SVo9H77cdhCmSTENYrnMejGY?=
 =?us-ascii?Q?OtcEJ6wGP8fff1CNGfPt3ycXU86mqq6XWsb9jogN7i/mT37EyCoJfzbaZJ1M?=
 =?us-ascii?Q?yJFj/KMvthzSXYCOfKC0gWSSx2b6HWAdvRLYyBEgonRoMNs34tU7nsZ06Ovh?=
 =?us-ascii?Q?W6tSAH87/u8VMEsgbiTA9WO1UomcOBXhkxmk7qFRtowl7WaZSDi3839oncR9?=
 =?us-ascii?Q?9NHuN8xVERKyRttTlb3otewRkqBkxJZwB4bRrlgltT5/Po012OQuxp8KpFiI?=
 =?us-ascii?Q?jKE8feFrMtQzjRj+NxDm1ZqIXy99Td0QGWVMY4qPU+qs20FXBGTuiCaKj6sK?=
 =?us-ascii?Q?0a6tF0H1la4POromdToZ7jag+wPDXnfLx9/9Y8OIqLNi3kal3LVX4D61d7Ky?=
 =?us-ascii?Q?YJ9g9iZtZ3XAlXzKca2Rxl9tUWRXa1h4F+58rtH7TVRsFWVNYmAv+fDAgFMl?=
 =?us-ascii?Q?AZDJXFrueqES1ftG2k56Mcz/qQDrVLgIbNdPd5sa6e2Lo08bd0hYfOATC6a2?=
 =?us-ascii?Q?AIbcDa4a0yx6g52wgxTQyxwgcYxLFwzOaXr6+RJj3x6ktkFgqVBWx9oQHbjk?=
 =?us-ascii?Q?h6GACTsBSU1HzT+vNNM7D46ra1foXoe7gaQfg9jhMGJDQzDPGy4hpzg5c4e1?=
 =?us-ascii?Q?mGC8d5w47b5SVCcKkYYb4Kw81iFbGECmzDRTi0U+frvRMeBUFnNAaD0bFKpL?=
 =?us-ascii?Q?qUAVLw6CMP919clcmuRyAlOj5VYEowyaHirfdWetaHyH4zjer6P6z9SE1MLj?=
 =?us-ascii?Q?8jwOeYlbiPux6ApHOJlMpSjgUexO7TrorFOzSYbjTJHhohpgvr+5zE9OE/Mv?=
 =?us-ascii?Q?nfQXHawLZcSh70bpMsEABkmGXwtTNynrEVufzrjUWK4hXx0EP6D0rwkJWPtc?=
 =?us-ascii?Q?FGAyj15mMSh6r/IvQyQYq/oj8sMWajoX2X2kaekHkvnfiruhEwASLh8j5aWI?=
 =?us-ascii?Q?gbfmmspaAa7AMuc5yfECKCRSdJLFmZwvMVIxU3AFdv6hmlTTmn/gMrjO7WR4?=
 =?us-ascii?Q?mSLin7Gg/76ng6qMEbionmaaqeDWf88tZh8zvQub05GZvUshZJdNLg26fQ4T?=
 =?us-ascii?Q?mBpIHhiRUL911hife5livBgKPXLODMsPvLJxT9uCLBEvVtfcHbxbqqTwt0PQ?=
 =?us-ascii?Q?+wczQCYLoALTopCByFSaW9Ej78+c45OFcI0LUJfrDZNI7zLd/Copb9/m+7H+?=
 =?us-ascii?Q?C512b2Zlmsn03DvZHPH2GKyBwG+Q1emVO5bEOayXOdfBNduMYmahHyR9a9ff?=
 =?us-ascii?Q?4CZDOJkSIoKzlaXnEk8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:22:48.4084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d49821-a3d3-48cb-a175-08de27a10672
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367

From: Alejandro Lucero <alucerop@amd.com>

In preparation for CXL accelerator drivers that have a hard dependency on
CXL capability initialization, arrange for the endpoint probe result to be
conveyed to the caller of devm_cxl_add_memdev().

As it stands cxl_pci does not care about the attach state of the cxl_memdev
because all generic memory expansion functionality can be handled by the
cxl_core. For accelerators, that driver needs to know perform driver
specific initialization if CXL is available, or exectute a fallback to PCIe
only operation.

By moving devm_cxl_add_memdev() to cxl_mem.ko it removes async module
loading as one reason that a memdev may not be attached upon return from
devm_cxl_add_memdev().

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/Kconfig       |  2 +-
 drivers/cxl/core/memdev.c | 44 -------------------------------------
 drivers/cxl/mem.c         | 46 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 360c78fa7e97..6b871cbbce13 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -22,6 +22,7 @@ if CXL_BUS
 config CXL_PCI
 	bool "PCI manageability"
 	default CXL_BUS
+	select CXL_MEM
 	help
 	  The CXL specification defines a "CXL memory device" sub-class in the
 	  PCI "memory controller" base class of devices. Device's identified by
@@ -89,7 +90,6 @@ config CXL_PMEM
 
 config CXL_MEM
 	tristate "CXL: Memory Expansion"
-	depends on CXL_PCI
 	default CXL_BUS
 	help
 	  The CXL.mem protocol allows a device to act as a provider of "System
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 8de19807ac7b..639bd0376d32 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1070,50 +1070,6 @@ struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_memdev_alloc, "CXL");
 
-static void __cxlmd_free(struct cxl_memdev *cxlmd)
-{
-	if (IS_ERR(cxlmd))
-		return;
-
-	if (cxlmd->cxlds)
-		cxlmd->cxlds->cxlmd = NULL;
-
-	put_device(&cxlmd->dev);
-	kfree(cxlmd);
-}
-
-DEFINE_FREE(cxlmd_free, struct cxl_memdev *, __cxlmd_free(_T))
-
-/**
- * devm_cxl_add_memdev - Add a CXL memory device
- * @host: devres alloc/release context and parent for the memdev
- * @cxlds: CXL device state to associate with the memdev
- *
- * Upon return the device will have had a chance to attach to the
- * cxl_mem driver, but may fail if the CXL topology is not ready
- * (hardware CXL link down, or software platform CXL root not attached)
- */
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds)
-{
-	struct cxl_memdev *cxlmd __free(cxlmd_free) = cxl_memdev_alloc(cxlds);
-	int rc;
-
-	if (IS_ERR(cxlmd))
-		return cxlmd;
-
-	rc = dev_set_name(&cxlmd->dev, "mem%d", cxlmd->id);
-	if (rc)
-		return ERR_PTR(rc);
-
-	rc = devm_cxl_memdev_add_or_reset(host, cxlmd);
-	if (rc)
-		return ERR_PTR(rc);
-
-	return no_free_ptr(cxlmd);
-}
-EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
-
 static void sanitize_teardown_notifier(void *data)
 {
 	struct cxl_memdev_state *mds = data;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index d2155f45240d..3f581c37f3ba 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -7,6 +7,7 @@
 
 #include "cxlmem.h"
 #include "cxlpci.h"
+#include "private.h"
 
 /**
  * DOC: cxl mem
@@ -202,6 +203,50 @@ static int cxl_mem_probe(struct device *dev)
 	return devm_add_action_or_reset(dev, enable_suspend, NULL);
 }
 
+static void __cxlmd_free(struct cxl_memdev *cxlmd)
+{
+	if (IS_ERR(cxlmd))
+		return;
+
+	if (cxlmd->cxlds)
+		cxlmd->cxlds->cxlmd = NULL;
+
+	put_device(&cxlmd->dev);
+	kfree(cxlmd);
+}
+
+DEFINE_FREE(cxlmd_free, struct cxl_memdev *, __cxlmd_free(_T))
+
+/**
+ * devm_cxl_add_memdev - Add a CXL memory device
+ * @host: devres alloc/release context and parent for the memdev
+ * @cxlds: CXL device state to associate with the memdev
+ *
+ * Upon return the device will have had a chance to attach to the
+ * cxl_mem driver, but may fail if the CXL topology is not ready
+ * (hardware CXL link down, or software platform CXL root not attached)
+ */
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlds)
+{
+	struct cxl_memdev *cxlmd __free(cxlmd_free) = cxl_memdev_alloc(cxlds);
+	int rc;
+
+	if (IS_ERR(cxlmd))
+		return cxlmd;
+
+	rc = dev_set_name(&cxlmd->dev, "mem%d", cxlmd->id);
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = devm_cxl_memdev_add_or_reset(host, cxlmd);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return no_free_ptr(cxlmd);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
+
 static ssize_t trigger_poison_list_store(struct device *dev,
 					 struct device_attribute *attr,
 					 const char *buf, size_t len)
@@ -249,6 +294,7 @@ static struct cxl_driver cxl_mem_driver = {
 	.probe = cxl_mem_probe,
 	.id = CXL_DEVICE_MEMORY_EXPANDER,
 	.drv = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 		.dev_groups = cxl_mem_groups,
 	},
 };
-- 
2.34.1


