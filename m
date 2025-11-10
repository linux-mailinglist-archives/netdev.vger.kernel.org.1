Return-Path: <netdev+bounces-237231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E075EC479A1
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD42E4F3A0C
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70B5153BD9;
	Mon, 10 Nov 2025 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sCTgZ2iP"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1103B26461F;
	Mon, 10 Nov 2025 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789049; cv=fail; b=q3MLX93Jxqn9nKkQFex545wQZ+7QEHIPFJGdVFccLEAZX9rVo1sGuWBTvXGVMbVmcqP4JWBRbqBMouYlg1Cfvm93rhHe4POss8OPEzleLDvlJmPVJXyn3Dc0XgqhffMU8qmZZdxO/GrXBghA3VIG+xcF+to62pMdZyYb688ZilY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789049; c=relaxed/simple;
	bh=HR07iNdtWPe0VOJ7fFtVGEoc+cRHyFYkn0U0sJ4Zopc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHqvrC109bSGIAToYKZbcLzrIVznArEZU96S+Nm9wfMYluFt8hQ4udDB+KJGsQ2OgpBG4u54E911cwaIbzUlhY3QSluaDU3jdvm2sXZYKS7kV+B8SXhk6O7LYvU4RUDM+gfxOYmq3p0OP3CRBVWiMtkl2I66u4hsBnNa+a5KYWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sCTgZ2iP; arc=fail smtp.client-ip=52.101.48.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJC63bZ8/rRNeoV8/uI693eBKqaUW74b4D4a8xvx3BFbm4e9So/xqPCegR6BxA66wOGAgodF7D4pBVcIYoYhjq9cWmjEleEXkUancigLvU2AIGjmGzSRuv/Zs1T8tqTOv2njnP4ydZ89HDVEn0gtdxh+FHt2vGHwbnm1DP34FJonzZUopq6Une+IvWS5xlTGBdEzEV9ODQYTyzsdCALJcTtlKrT7NmrxW+l1FLBt6hTZQ2Adq8zp50EOU1wnOvD09p7ouabndYw9PKriZq7QLjyqCbjC8P1YbW7HjhIXl/rayvcsIPei3HH4L3E70sfbWwz4aA0OI31WsIP11mnKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NI0H+YEyEaa25z4QPN08uObAm99ZGiRvOQXaEsVJsQ=;
 b=RLin/GYlVX1oQLE/IOECvS2cWbLBcJJv7RRobuEvD0JuyBpxGdyjgF/lJSLrdV96giTiHX3BAOiVDr25cn5+CkZS/AhwKKN2uiZGUzGG4n8B1bnLPu8Ez153INH5LaPoVnqU/GFJSpEVlQZa7hOG+PzJi7k1jDVwe4h61n1vfqfF1WtoqLil2zwY2EXGI9SQukhet3SRGu9hC1J7Y0w+2vc/wpU2uFGzImfUs56kQv7bXuTcz8VOHblQpBNBBhGJt6UNZjk6+4C7hRv36P48PVOmVkCY9vbJg6HOCgDu9RkxT66U3bgRlUkEwhIR+LQPGrp5y9WOHVKR+pPZBILbiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NI0H+YEyEaa25z4QPN08uObAm99ZGiRvOQXaEsVJsQ=;
 b=sCTgZ2iPNW8HUFSvvruSUG2TPtW7+AsZ1n3/5ojOG0E7BlUUcjBUU/AdwW+sVdoN5tGlRt5LVaoKDfoCBx7BNpnTfltF7/vcQNFpjs42T2MkmvvgkVlDhk5H43HSLaX0xgPH4o8oge+aoVNznDMpdE8lqawPX1kkKqmP9/okR18=
Received: from MN0P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::29)
 by SA1PR12MB6823.namprd12.prod.outlook.com (2603:10b6:806:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Mon, 10 Nov
 2025 15:37:24 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::d2) by MN0P222CA0022.outlook.office365.com
 (2603:10b6:208:531::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:16 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Nov
 2025 09:37:16 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:15 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH v20 07/22] cxl/sfc: Map cxl component regs
Date: Mon, 10 Nov 2025 15:36:42 +0000
Message-ID: <20251110153657.2706192-8-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SA1PR12MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: eba8309a-d39b-4f14-72a0-08de206f0ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yhf0DeK+9oSHFVpmXx4H4d576/644dnMnGd2C194jfv+c+MihYeMvYevQEGV?=
 =?us-ascii?Q?viAFy15g1m77zn/9n1pirsfk/CcAp4NgxrL8DAjjhgGBt7RNa2AoTslBB9l5?=
 =?us-ascii?Q?0R24FLY8KXbZD4gMCWS5nkXh8reWX0szghpVkUXs3a01j7AzvmeVacLtk48M?=
 =?us-ascii?Q?vn1hWQJOLslLU71BHy8n8cL9oeEmaRpLAAL7cc3Jwyi2IrMm2xc5Y8Ti/kgi?=
 =?us-ascii?Q?WwTVlIvxBZVqo5IA+W6DutAbYvOJwNFpJb4zQWmbL1c6JGC7+fZIu5+2GFVk?=
 =?us-ascii?Q?zbwmiWd/ijD8mVqGMlR7WGrH1nZ+q8WLrG3A9WNTUuVq12leLLmv+Vdcopvu?=
 =?us-ascii?Q?grdlFzX94x6NVn6m/LHqS4oJijdh+b8k/FML7IJbAu2917fFrKAi5dxk8qNK?=
 =?us-ascii?Q?/tDnnTYgcS2BwwhjTMxCMxPOGIUJQWV1pXwxUfE5tSS7ZT3MQtnuEs6jOYNo?=
 =?us-ascii?Q?DoRRr5WZA5L7n0Cq9zYDRiyd5V4TIsfAkFrMeTuuP+vNgq1+tlrNoHzql9cy?=
 =?us-ascii?Q?78vpylpnpLgJXvOKZL0GDl2s0xjQW3jOPPiScPge1SlBltzSoAF0fWdes8WV?=
 =?us-ascii?Q?HE7B2NTsnmcNpphermuZqssyiU0gtHSgCiRsSZTlESR4w5hDLGNIYSyi9EWv?=
 =?us-ascii?Q?d2AiRv+9Zi0IU9ifoVIWDui1gn8CK+oQOrrmfJHQq293CaOsI7mh6ghXBKP8?=
 =?us-ascii?Q?b3jAHq2u0sMBezMrK2/fSUnWiyJNkIuwTHvgcq6VU6dBRqpL6xq8GresqplI?=
 =?us-ascii?Q?onSOYSn6erHtbi9GSAjaMg3PndZginLrsvryRL+oNLoE1lLp2yw/wMQIg/PJ?=
 =?us-ascii?Q?qmTtpZh41TUUXsfjSHkX9WVqqZgF25uYY5Pyo++DFb6fazmjiZExCEd9y/dl?=
 =?us-ascii?Q?bZkodRXbLVxS1VCRUEFauw9+QqLDnYUQBUrGIkosjmriO9z84Wr2XiJqBnU/?=
 =?us-ascii?Q?AFaLIt1kyeO7N5QucgP2uoh9pLcpWPBFdKVd7OhQ0jCccOLxocOWHrEYM6xK?=
 =?us-ascii?Q?RK53V2R5+qSc8VNR9L6d/w12cFTrjn4VSpZyX8zdHvDhuwkv9gyNgrgP5IqT?=
 =?us-ascii?Q?Cf/IqDWq3/Gv2+cOQMJSedTpScUcHJFq48p+ttZfGZIQKEEl52evd0jEDlpf?=
 =?us-ascii?Q?ScXMx0AS6fCdYkbNS/3lysouDLLkqZnBMS1nX8hUkmSqZGiyUmaAkzTN+xUm?=
 =?us-ascii?Q?a1yp4GM1Y7fVHtONO4fEO5TCCJ8kynFdZQ9Y/QR2d3MeERS3QT6TaUVI0QVx?=
 =?us-ascii?Q?nxLkjrMdslFgERq1W05Cj022SJ5rH3HlA+ktvUp5Mt3DB49tO4yvSCGxIMD3?=
 =?us-ascii?Q?00jhs8N1T1ly934+Y+qnC1PAW8exTiwxd5CoTIy+NK8Y2jFaTj592jVe81Zf?=
 =?us-ascii?Q?7799nxhD+WvhfjLqnbpnHAOS1CrMaJL4AGj3XDZLaF/z7+GMGHXLTuJUlAuq?=
 =?us-ascii?Q?rkOLxdcZqMHqzNn/qS3V+L+voFn0rwLwFjAqkzYw2NDaGb9GGIJj2qAXvgXu?=
 =?us-ascii?Q?/nghDOxOH9XsSh3pAyhs2wtZ7m7I4wcEv8mUWF3iAS+8oLOWi58WuUnmnE/u?=
 =?us-ascii?Q?i0lYSVvEtUqb/dAbvq4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:22.6784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eba8309a-d39b-4f14-72a0-08de206f0ac3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6823

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


