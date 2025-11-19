Return-Path: <netdev+bounces-240141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE7FC70CA4
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CF374E290D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B6A36CE11;
	Wed, 19 Nov 2025 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IF+m7cOm"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB49369979;
	Wed, 19 Nov 2025 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580197; cv=fail; b=rUw/Qih3Ol6FXMKTyyh6dZF30Ca3NBxw1dNI8b+y0oSFvrWO0w4cKNxfnuk0KD0YAFK+DUcPD+nveeilbuhzWgEPqLRzZWuzn8bDvDvfKoVYXp2OSKGlYmmUeX/jzm8s467iApxaExpeFXpklToI2tGU3Cn7iFRF1iaGlq6US1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580197; c=relaxed/simple;
	bh=28JCvXHCD6vLADrfGmt39EAkll2F0CJKA1yMU7BNapU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxEOAXwa5W0wTSp1jTEoER+PC1edXrQSvK1IxfBUyOZ3OASM0J97Y24nnWGCr/2nHgpL4YxAPHuj1w0dMOw9wtLON/b36VAmHx/9iWRUJcJlUeh4yMbhTXZCDAhVUg46M0ZwKe38LKIJFlyThQUbTyu3cuGEKURy7j7oCKLNTW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IF+m7cOm; arc=fail smtp.client-ip=52.101.56.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8HzATN/I5+Zt6MEKX9d/7Fw/Z5fsXKvu2yG69W1h9APj9Kijw1GpzBYm/su0bsKW5BtSXHEiTn4cMaWyNjhtw5GQI+r7cInghT2szYHEPw78SaOQYljb2U2R29tR6nYbqFUqUEwsVssg39BNpT/ch36jaSQzUof0OwIb5vMzBzY1X92ur9zyjD36pHU/JRcWNaH+I0sfqnQM9FZdz77jGRXZMIiP9G7HWfGwzajQNk7FzXhh64lTGnaXuMVzshZWLYCMhptyJ09t8If/fvK7vcVqac1GPOdL+j6lEGQcztM9uyDtp0fPQJXnM0NquGvinOTZg05UbIXH9oeCQwYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfnKsSwC1Xy+8PfJZMhV9eu53tpAjj95G+4Gse5Ykpk=;
 b=r8i46BZosu8/3Qu+jMEE+OhTWcKsfRNJUmsgfSaUnYi2rhBU7jldKhcWLNIeZ+ML90iUiWf93rKpau7lLhxewLXdI4liJdRPGb5E3HsWEkv2nyTThKvQaC+j+0Q1PvzlCDRu9YWvQzNEdQYGVFk4MSbIUz06Rt5pc9PkHT+unMAQYxBxmwbDdXBymxV8g2VYhUve5b4VWegoRtBYSjkZKSDxqyDld3DWssUDG9NIBK9qrPRyTyXCx1kIxsBUYD74BQg+B84lTMEMh/xRz+q8w6bWQym8mwInoTDrUc92sK1eE1qqJwc9G9PIF6pIH+bb6WwBwHkSCQ3DTp97mILPBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfnKsSwC1Xy+8PfJZMhV9eu53tpAjj95G+4Gse5Ykpk=;
 b=IF+m7cOmHbzzz+gu3JoN1djo8hNMWCzAI7Cpi/2KdO1cWV9mYVYmO438AmDvzKOgCo47mn8kWBAZZ+3aZR1VvQxotWCt8Ip3DZPEDJOwBAsEdUyw4VohyiFnJsUsFOtcOXW7djOJvenmIvgxumDKGtzuUdHWoj3LBWPQtsRz3lI=
Received: from SJ0PR03CA0346.namprd03.prod.outlook.com (2603:10b6:a03:39c::21)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:22:59 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::11) by SJ0PR03CA0346.outlook.office365.com
 (2603:10b6:a03:39c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:22:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:22:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 11:22:57 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 11:22:57 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:22:56 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v21 08/23] cxl/sfc: Map cxl component regs
Date: Wed, 19 Nov 2025 19:22:21 +0000
Message-ID: <20251119192236.2527305-9-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: b653aae0-373c-4471-1051-08de27a10c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QC9HWn8Z9oBGyBpnnTpyOLCAVwqz5hR//S8+8iOtrwu6QLN285Xt9OTOkbyS?=
 =?us-ascii?Q?wkK3EvDQ3rYOfiUVuGbUir5HMyEsFBWY3lBrQm9YkUgWvftoc+SCchOQm01c?=
 =?us-ascii?Q?liSqsQdKD2q5d6L/BxlCsrbBd8mNB9JBn8SrjF4EPRQp74iVQJIPvk5+LSXk?=
 =?us-ascii?Q?BD4IRUiSlLIQ7+pDtGwqVVyrfyTLVmVQRYH7tZ3Akq8onyBKkrqc99lZpSQZ?=
 =?us-ascii?Q?18YC2ewjv6zNJ46RWdwsQVFkPErWtd4RYDEpCgpQqlSUaMUZksMskZKMCPSF?=
 =?us-ascii?Q?VtZK+co6u8cK8TgDSdnHtHbdJgCL7s9O0kLUdc93nLiokW6AMVWgmJ5N5bM9?=
 =?us-ascii?Q?R1rtYrpd1wXeMmE5xJfWKhxaGevrUsvLB52iq/wOCDhVmxMVmt/E+vA80Icz?=
 =?us-ascii?Q?UuyOUBDxVxn201jMhscRWWpQwjPNN4Pt2wb0/wgaIkwqxLhyxoZamg7urdrr?=
 =?us-ascii?Q?mqMmMoKEqHMy5G367cT0yTu+3f37dZ1yICmsqSK1y/RM0mey0yy45car36r4?=
 =?us-ascii?Q?fxXBHS/iGNAM1+I5Eb/vXB2er0M/npGisQMQLK8+SUbQfB0joRDPYPcNwv5y?=
 =?us-ascii?Q?pszHG49uGRb6dgEdqFKh4dIzTkUqN6IUwyRG1znLvuNWruE0OjTgmxTKCD/6?=
 =?us-ascii?Q?SVMblFmhQIN26TI7ljBtAW9yMVQ5oOhWTbDxH0macN+r+P1UPjmEiuqFetdJ?=
 =?us-ascii?Q?q2gEJ3H2X7RNIlCCCNhgGth43sx7pC7fu8pwzbVt8ukGGdZeg3Ocv4pyE6EW?=
 =?us-ascii?Q?BtPiTMxd+IMI4v2mriUGANQB50a7hiq4HnQKCM/z3LjWQkVSyPRdrfqvtn+D?=
 =?us-ascii?Q?I0SHH/lnL0pRngIpbUVrEq1YtOh2TYxJIlMpFbO//6zlddkn2oeEjBTZkJI8?=
 =?us-ascii?Q?8iLC1hGKQcUreN4KP5ZMMSojAoq/+QJ1l9GPYnIl8nv1cMwpkqtJ6rbCcEAs?=
 =?us-ascii?Q?SVLtN4uzFvFzWjUePykYqa9medKD6i768QTiiHsVOV7RTYCtH3DX3xrJ1eQ3?=
 =?us-ascii?Q?gXmP5+PXU2Ef7SQ/76JPy0RgUWnGup9b6yiPBCtOtCAZz3osGunq+8+jQjcq?=
 =?us-ascii?Q?e3r6WZObXPqsx70W8IsvoUMKzAnclWUekT+WzIQxYmZxUYLlUp3+AzPqM+Dc?=
 =?us-ascii?Q?MZFEvKFT2TBLoVghhQHuALY/y9cxGi4zM46FFN0l0ETf+fQKEvaD/k9XmNU6?=
 =?us-ascii?Q?V0X+UAlgVCqotu3/zG7zWFVjG3s7JRgA36MCVNeLh7BPD6hrkRURvran8ril?=
 =?us-ascii?Q?6HMOGKcFZr2y1S/yarzBFsqcTx3q3TZxxlQkFO6g9e3aceDLiZUyiyhlXRn2?=
 =?us-ascii?Q?iDIU2M0C1UFPslN8pdZzz9BGtVeFeqEooZVLa73QAfTWv2K3EmSJg2Jy7lYa?=
 =?us-ascii?Q?J6XAqVnNz4Pf9CQnq7/0qUQWXepcmif8iu5B2BBURY3VK72KuFtQ6rTvlzkX?=
 =?us-ascii?Q?TMYnnrEbw0jwiEcuVchnVgcOkBg/Q75O3uxhC7nrgEyvq7150f8yxfoLirce?=
 =?us-ascii?Q?pOPxFSJi+MPKLLgk36MJ/39gzi19tPHWADm7hfUQ/8rGAzI25cktkX3zE8Fb?=
 =?us-ascii?Q?8XhhRr0+YBVAdoZCIx8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:22:58.4956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b653aae0-373c-4471-1051-08de27a10c83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018

From: Alejandro Lucero <alucerop@amd.com>

Export cxl core functions for a Type2 driver being able to discover and
map the device component registers.

Use it in sfc driver cxl initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
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
index a35e746e6303..4c767e2471b8 100644
--- a/drivers/cxl/core/pci_drv.c
+++ b/drivers/cxl/core/pci_drv.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/io.h>
+#include <cxl/pci.h>
 #include <cxl/mailbox.h>
 #include <cxl/cxl.h>
 #include "cxlmem.h"
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


