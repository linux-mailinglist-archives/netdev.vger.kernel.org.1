Return-Path: <netdev+bounces-227924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3A0BBD942
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D6D9349B83
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AA321D585;
	Mon,  6 Oct 2025 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B/KKkNeA"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010032.outbound.protection.outlook.com [52.101.193.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC4C1CF96;
	Mon,  6 Oct 2025 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745035; cv=fail; b=S4/04lQPdVa6GTl8HORcIzasgegK/7XVg5jtp5kRTPNiO6f6F1tHyt5yUZpi/hbaRihZqSoknQpOd29oAWmvzHA5rzIgCdnuyxE0E/jx/pjrVFh+XyZ2zuOAyAmnPWX2PD96EgjebLaASLo/ER5JtLEwcqDpSRrcGVLW9stAEZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745035; c=relaxed/simple;
	bh=f2kg+Kj/e3F5eDCWD+MZmCtGuKcS3qOqHc4OeGxI6qE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2lLmoSPlybwp+T95MrJEpWCDcV71K0+SQI52rW62NSmQ1lyEyK5nuaC/dUfDuluiyjWTQCX4HwbcbAcOnzNqLeXNSr0OhzPjdMGLFZNJk1fY4D40msN5ECuu/5JLYRk/9QZXJcwOM4O18WmQHXub4hYzUh2oic8BkVtfF3SYtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B/KKkNeA; arc=fail smtp.client-ip=52.101.193.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gc3Nx6ddUqAQxwEnpObHjX2uwGNeZt7gHiWhZEC7WAjyJiBnKxT3AJe50Ima4Dtq9QNdOynvbwawR0bdBqNvkisdvkKGZIsjmSJqqJLHipXHlp2uchtjRWoyLZ5ouIs0vdbUWrguBsrDvfMae7GD9eANwgLsR9g0LvLGynu7cZmkpnEENLpPYkFKQHEHK9ZVqvXi/0QzVQ5KRgrQgEMHCHzYTCrfTpQJ0Rv8tM1ymRCfGvWn1WhmxxiSuRdPwxD57/c8vy3ktROE6GBVI7+H/6B7gi9+lXs+B+y+rlFXdABqeezjTJGvpU0buj7IRdSDKqRme+sk3GfnUItgEGZ5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mlND7a3efaF9Z4YVHcKJbAPLIyJZkm05F4uAmPmNZw=;
 b=AR66JhyuJRJOLBObq8yGMWwm730LtbunKyVXndcgoFWH7fZ+OmbAkNLzYgpojlOAvKfuIzc7mp9UxkpywuCAG+aB49+qOIKaovEB44B/VK89hSCvGrQf8A9dYdljjF67Z7e6iWdC0J+AH8Zfh3A/qX2viwSY9HfqWT5Ttu5kUiS22qMEEJLHWV4MxiNx/zFnQyurHANxGZaY7XL+B9MfBLv2eiYRgo/gvLSqwdjKbxa1XMMvNKVA8W1I0nKTGal5yrmk+H1lvCRFO0pfI0+nTOTVItlF0bz6EDtMeNG8Enbk4KSZ9gdc5GSetPrqgA0CP4/VHILB/ioXW6iQJfAkag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mlND7a3efaF9Z4YVHcKJbAPLIyJZkm05F4uAmPmNZw=;
 b=B/KKkNeAkbRrkKgQTGovdvMcLGQfRmWsgpa0ZYbgA/s1Vqide1yj1T/SIf23TQOY1LLgdxxcbtujfFWrSsLSV6zo1OI8o06ScqWXP+2Udde5jcH0NskEEkwNt108rTd+9TA5NgxHQNWqWO9MbGQZgdymUMKBt+ssPJ4f0jg42gQ=
Received: from SJ0PR13CA0225.namprd13.prod.outlook.com (2603:10b6:a03:2c1::20)
 by SJ5PPF183341E5B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Mon, 6 Oct
 2025 10:03:46 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::21) by SJ0PR13CA0225.outlook.office365.com
 (2603:10b6:a03:2c1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Mon, 6
 Oct 2025 10:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:03:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 6 Oct
 2025 03:02:18 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Oct
 2025 05:02:17 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:02:16 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH v19 07/22] cxl: allow Type2 drivers to map cxl component regs
Date: Mon, 6 Oct 2025 11:01:15 +0100
Message-ID: <20251006100130.2623388-8-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|SJ5PPF183341E5B:EE_
X-MS-Office365-Filtering-Correlation-Id: 2250db84-b530-4c69-e20c-08de04bfa3ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xC/Js4CV8MRp93wrbC6HVWP0Y3vqDaMRoj4Sdcozcx0eCi0gKl4IeZonfRAe?=
 =?us-ascii?Q?6Gz4mD+Eneeai85kR3JTzgXlfD7NsXjtToaN2eCZBdSnnaeCeJoq+pAfI44g?=
 =?us-ascii?Q?Wmh4EDXZU98cbRtfFFzTEF8e1p2zpVxRcUprvrcJkVu1TmiIlZn0/3wbmAeF?=
 =?us-ascii?Q?G95e+PuxwSyLdn6nlCoV5hAi6dNQFOxY9Eo4n4NhHk/3uo1XBR2z2zDfSe5k?=
 =?us-ascii?Q?fLYZZ+EBANUfeM237iJqbO/T1/2BWEdHVp0DSeXlbX5Q7DijCKas0krwc2uw?=
 =?us-ascii?Q?vmxUDq4pTKRhk71z6EbzasRgAJpCF6LXF/anUAfa3aOdsKtyYPc/P6p4o8W+?=
 =?us-ascii?Q?YgctYWXy1H82+xw7wB0XuiTxW82C+dF3Oa1m7+0AXTHucxYbbFW8sdm7BIfn?=
 =?us-ascii?Q?R9SQMNschr9LkwNZXCBR869iggOLf03gpYXlx3XAQmSQkjLjMy0m1fcO/BqX?=
 =?us-ascii?Q?JUiFX/ek9AkvxFmJn1pog0KuNJDOzlIMsXqjc/a/Y1AzAx335zM/8ldMHt+B?=
 =?us-ascii?Q?TkddVKjpCx7y2At07cTY0ZzQ8dB5xwyk9x7Yl2FcCURNHfC/+AndMjy48UvS?=
 =?us-ascii?Q?p8reowfGf+cMlf7+tI+TxdNQEts7YhUT/M8PesfeHByOGWmoguVS1HVSdFSa?=
 =?us-ascii?Q?Tg7bg2Jklo5ucH2xRdCSQ4+Sq6iFU2FXkRBJVDGuQekMFuf+4/TjLiWfXsGm?=
 =?us-ascii?Q?kpbSKyjRFsM0onTCvIzTk02nAlrRAmdbraCDGMbvou5CTXN8IqdKXaqigRLT?=
 =?us-ascii?Q?sQ+VlOkj0IU18XD7OnPPr6J0EOm0xZxqsiEpO8D52DBds7OZ2hzkqHIg9BCz?=
 =?us-ascii?Q?s0ULfe5hBkvFRJbkQxBQKEzzPfGKWOGxvj27iuAa8pOlVu+JLQ2nrVljOZIa?=
 =?us-ascii?Q?UFngEmIGSrvbpe5nNkmk22gclJW9L7pJVucWQplmIHln8LwPhH7PNXIvoJT6?=
 =?us-ascii?Q?2WffAzMPCoocrEkEkZgYTNuQUxRFi5MX/YlcpxofcFSrHHgnhLxsDHO4HTZF?=
 =?us-ascii?Q?SnyCwQvBLNSaM+QssC/Jbx6+M6wDja2by+XTxpadvmvkQPCVHJAbuqpqcuYj?=
 =?us-ascii?Q?1O4PQZGHh9c2l/t0R4W8JG8ALPQaEOlZtrMY8XpO6Xmj9GXaAgXlxzh9r5c4?=
 =?us-ascii?Q?AAYUtkiXyD0Rk8HVDxTU49v208JYFS+sevzu08WAWip+NnYwwHFkZqZ+UG4t?=
 =?us-ascii?Q?vQmLvclEXt+10lfjwVCdCmGaP11iyPd5fipBgu5r2KWwXdIK4sKYK51Y0fKl?=
 =?us-ascii?Q?BySxRVANaqzHlTzZ4fJVsvsWfq1QwgBPIqsdgOMDM7VimtQ+eQDL3xkPIWzl?=
 =?us-ascii?Q?ZUDjlYpm7I9A2V9qvJtTtdNqlQYo3JvwqQ8Dni2X1fGKqjwRwNR2xYJj8N5A?=
 =?us-ascii?Q?lmzr+sGuMdnWPfhgyTHlreSulc2WqXy0W6Atd8toaVHYqL/XC92myTFVgimy?=
 =?us-ascii?Q?F2KqojpfpchrYmBONVYfbNSViCUQ18bfs0hw4zUuI6coaXYi0UdOPfT/qIJt?=
 =?us-ascii?Q?POgMdpJ9v+mQaSXTmP2eE4vKcA8cpFQxnEAKgymv+BkALTj8gZLz+QEapURh?=
 =?us-ascii?Q?eAKlNxa1erT1sH+JQc4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:03:46.3177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2250db84-b530-4c69-e20c-08de04bfa3ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183341E5B

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
 drivers/cxl/core/port.c            |  1 +
 drivers/cxl/core/regs.c            |  1 +
 drivers/cxl/cxl.h                  |  7 ------
 drivers/cxl/cxlpci.h               | 12 ----------
 drivers/cxl/pci.c                  |  1 +
 drivers/net/ethernet/sfc/efx_cxl.c | 35 ++++++++++++++++++++++++++++++
 include/cxl/cxl.h                  | 19 ++++++++++++++++
 include/cxl/pci.h                  | 21 ++++++++++++++++++
 9 files changed, 79 insertions(+), 19 deletions(-)
 create mode 100644 include/cxl/pci.h

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 2059017ba8b7..33dbec3d18c5 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -5,6 +5,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
+#include <cxl/pci.h>
 #include <linux/pci-doe.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
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
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6544a3ca41b0..2e9f71d3a214 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -12,6 +12,7 @@
 #include <linux/aer.h>
 #include <linux/io.h>
 #include <cxl/cxl.h>
+#include <cxl/pci.h>
 #include <cxl/mailbox.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
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


