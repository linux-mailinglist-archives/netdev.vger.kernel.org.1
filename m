Return-Path: <netdev+bounces-163040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C551A294CA
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC3E3B2D41
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E094B1494DF;
	Wed,  5 Feb 2025 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YkfE4xBa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314AB1714D0;
	Wed,  5 Feb 2025 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768810; cv=fail; b=Y6eRNRR7u5FpMZ9gq22j7cvIAWpHBoltEjKz1tYZ8a072kRRqhUBX90Af64d42xmeH9Gzm4cEC3ecPmVTJRFkAHnxfXBYlTTGGPOrGhD3fbAKdEP1GxV+weh5DZS3Fr5CNy6LwVBsTA4e1iK9PtEMb3a5KzyPT6C+MAoqjU3wUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768810; c=relaxed/simple;
	bh=Tq3BuGjd4Gb3Hpb5Y/aIG4P21zSZ9Nj89HnmyQ+Q20E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8Lfm1ymSuup6NcB+X05ZO7ga9DjHXyZbmqNO2AturAcBYXTY9HGcZr4s7ErWvVYVHN59alLbuWM/B8qf4Yoz1QJwIpYE6UJ4kAsp7WcK+3bWd2FP2rf9e2GbuqGrMw3W+9Oyz0dRiSrfZqgzhIplkVvpcDoC7hzDGYNwRem4qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YkfE4xBa; arc=fail smtp.client-ip=40.107.100.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZmWPZshKKS1jBhtaGWmWtdt9pd6I8PozKALF5AsuljdzbX+6g9T1BMarpjXE85LFP63VrEWtIpEYbpeCNCtTQk6JrUMjKXE+tZgO0xNg488+DcIziliDpxnzesG06nZzPFkFJoEU2XUS2Cq5rPl/XAhNlt7OTA7Wjs3SoqC+lABfIGr3FlmXVvb1UEYZFGXXPskgeukwAM1SxSgt+mAZ6h0cj3FVJTSFoNMy1CQTm/ftbKxTEbkxEVB64unCc6hv/qhllDTkvrPqbSnHa3yj/CmD9KZgVooKZ0fcrCAB9GCvIJjVrQ9F8OoFEK/5XtJxcUkNxyA6XdXL842KhFJtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFhVPUcV0rRISeJ/sFnePBwhiE5AKwp3t5FbOSVlV3o=;
 b=sSeO2NLuZHJN3alltOrG/XCCGssuAuyl2qk7bpQF9CcO2InVT4jQnIRI0DPMzwQoO8u3CsQGXQPHgmXQIKd+WfNsFCQro8noq15+v2s5CiW4OCi3gQ5SSYkg8ipVSSx9pXOCkZXlEvMe20BsDIIN/pHzxCktZSSYF0r1waBXeXtj6HQ4uxA+kz1X6sHoPq+7vZYxdjEKO2rE6cUDN+66FSznLHDfek+yV+WCSmYVCIJDeRAjUxpJiTGy2fzRVvAo0PApXsK1U87l8RC4lUBNLi32dyz0Qec7+5yArBIkexT/gbxQlf+kA5o0nE8OReLZqDYOpRrFAeDSdBNaV8ZKIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFhVPUcV0rRISeJ/sFnePBwhiE5AKwp3t5FbOSVlV3o=;
 b=YkfE4xBazUiT4Q+F6OLoJ5AlcSqU7BPt/tGYvE8aGZVgMq0rEJAO0PlbUDpmkBdPZxztY6SwaPGpFsOvtXUd8YCPNwxwHe4Fm5BXCxQlhlReRpf2HHaf4t1mqKt28m0+G6UQSja/ejiNaksSWW6zmihQTaya1aASi/a9qlQPLf4=
Received: from DS2PEPF0000455B.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::518) by MW4PR12MB7000.namprd12.prod.outlook.com
 (2603:10b6:303:208::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 15:20:01 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:2c:400:0:1007:0:8) by DS2PEPF0000455B.outlook.office365.com
 (2603:10b6:f:fc00::518) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.5 via Frontend Transport; Wed, 5
 Feb 2025 15:20:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:19:59 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:19:58 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 01/26] cxl: make memdev creation type agnostic
Date: Wed, 5 Feb 2025 15:19:25 +0000
Message-ID: <20250205151950.25268-2-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|MW4PR12MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2df776-9531-4289-6719-08dd45f88ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GaqVkVZwhYFyRCfJV7IcHTO4LPBFzhN+7YZM4DBf5z9F+FSY3mpA787hVFLB?=
 =?us-ascii?Q?DJjhvjLI9VqYkL7rxcbIGKInu/4VAXunq2YSYPvukepM41ppvBNvZkGfpSi9?=
 =?us-ascii?Q?DCnU7Z3EGCc77AJ0Gdm0zaNJUt6vrXIbZ67YQx5+qDFs6Pz1zP99eufwXlpX?=
 =?us-ascii?Q?NTiAsZEWIWP9LJbYSJ5V+iUfqfzXIDbMIvA2jEzOhGDFYgr9CoyizvxWv+XJ?=
 =?us-ascii?Q?jeN/nalbtXyZqZFZKHEbQtaehmX2NL4OdaT85em3y5uqBCEd2M7XuZ1ZPBnr?=
 =?us-ascii?Q?ZDEDbGLEx1fNBN29AQp/koQRWGT0csDAcC4ZXOoi+kDMmxs/Dh7N6VIJqpJ3?=
 =?us-ascii?Q?xZfJvqbpNrpeTC6YZvkGOSTrJ5vp7IHutoKRUA4Hv5JVMLiL8iqc3pXAAQGN?=
 =?us-ascii?Q?Pe0mVHdcI2A3nawcbUwEYoizt8In6VHzqJSOVsFxSeXUkyqHEoXdWSX6CXpK?=
 =?us-ascii?Q?6reCWRY2AM3dnF/47BND3BUaTsvsYFxL8/0bAm4pjm7uPjRCiDsGFqIbIfFC?=
 =?us-ascii?Q?RObJQSunJV2SPpKA0kT5L4Y4Ii+btncTzR10KPTvjRFRxvAjPoe1IlQvZCUC?=
 =?us-ascii?Q?dy2CU6eHGZA2jyrHgJPq/cXWaToYCKLoubImfPXTYqLcJL8ZC22AsyocWK1e?=
 =?us-ascii?Q?OrxJdIKCIJPgQZsn7PYye0W1Q2UeBI66/e0pFFplIYBPqI5SasM670YUB0NP?=
 =?us-ascii?Q?ZWgDvWqMgkC5slTZOSa0QedXqlZCmtnADa0SUyRhJBsoukz8Ppk29vgSdYYq?=
 =?us-ascii?Q?dT2+mqGt1vwy91FyhoxRA/k4IoQ9KZTEWa/k4edC/K4UT2KXqEEVYpftzlOi?=
 =?us-ascii?Q?6J6DxoY2QN5FQG6Rb4cfXlobTruaIFIkDj0/FIaMwMLdmHHxQSdzHAu8rfce?=
 =?us-ascii?Q?B/8//7PrTnclHOPpaG6CjwM83oJbOYfI68L+LWzb+blRXkF7+mTf8jWK2sMo?=
 =?us-ascii?Q?mf/gFuMMs2qpcAtEiA40crWFaoIGo/gzjmxvGW8uSyBKIuDrDsEm1b5Lk3FV?=
 =?us-ascii?Q?vCgWYYO0uqIWEGT/e87VOf9G6ev950D3UibHZw8OEj6smwflu7stRBeK/WGV?=
 =?us-ascii?Q?nKCqEj25Fr/SRY5b8F+bX4kRupdJW61w0GBwPGOfTfRO6/5NUCpxhhXr5nAr?=
 =?us-ascii?Q?9ndZKBn9eGO2n9s35hvUKnHFvGNzw01FZPFEccyiSWcNAJjseq0xd39GIbQ8?=
 =?us-ascii?Q?Y00vJ1HT0ZSb5V64zcis1PLJpf/NaTqqYWxWINM9yVaqzDWwnd28B2Y806hT?=
 =?us-ascii?Q?ggkqFWgWpE0oVyosBQTH8iDo563QkuTKkxBMaM2DvNr1DECB00p+r/7QCUcl?=
 =?us-ascii?Q?S/NXdj9I6kkmQssul16UnlG/W3s65zNzAc4SOQa5LNqaxtuw6RX56sRtavHN?=
 =?us-ascii?Q?r4Mt5Z7TTJRM+XPwPavlXVkrDcgM6ziiw1FjWmNRFy/EkkQ3PNHc1luUEa5Z?=
 =?us-ascii?Q?WwwMFliIUXV+yO5F+om9Yi9cy8jLKmJ9H1ehetsStMheD0xjZHuRccOi95ii?=
 =?us-ascii?Q?X2DfST8jE8RxtQY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:00.5245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2df776-9531-4289-6719-08dd45f88ec8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000

From: Alejandro Lucero <alucerop@amd.com>

In preparation for Type2 support, change memdev creation making
type based on argument.

Integrate initialization of dvsec and serial fields in the related
cxl_dev_state within same function creating the memdev.

Move the code from mbox file to memdev file.

Add new header files with type2 required definitions for memdev
state creation.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/mbox.c   | 20 --------------------
 drivers/cxl/core/memdev.c | 23 +++++++++++++++++++++++
 drivers/cxl/cxlmem.h      | 18 +++---------------
 drivers/cxl/cxlpci.h      | 17 +----------------
 drivers/cxl/pci.c         | 16 +++++++++-------
 include/cxl/cxl.h         | 26 ++++++++++++++++++++++++++
 include/cxl/pci.h         | 23 +++++++++++++++++++++++
 7 files changed, 85 insertions(+), 58 deletions(-)
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 4d22bb731177..96155b8af535 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1435,26 +1435,6 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
 
-struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
-{
-	struct cxl_memdev_state *mds;
-
-	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
-	if (!mds) {
-		dev_err(dev, "No memory available\n");
-		return ERR_PTR(-ENOMEM);
-	}
-
-	mutex_init(&mds->event.log_lock);
-	mds->cxlds.dev = dev;
-	mds->cxlds.reg_map.host = dev;
-	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
-	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
-
-	return mds;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
-
 void __init cxl_mbox_init(void)
 {
 	struct dentry *mbox_debugfs;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 63c6c681125d..456d505f1bc8 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -632,6 +632,29 @@ static void detach_memdev(struct work_struct *work)
 
 static struct lock_class_key cxl_memdev_key;
 
+struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
+						 u16 dvsec, enum cxl_devtype type)
+{
+	struct cxl_memdev_state *mds;
+
+	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
+	if (!mds) {
+		dev_err(dev, "No memory available\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	mutex_init(&mds->event.log_lock);
+	mds->cxlds.dev = dev;
+	mds->cxlds.reg_map.host = dev;
+	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
+	mds->cxlds.cxl_dvsec = dvsec;
+	mds->cxlds.serial = serial;
+	mds->cxlds.type = type;
+
+	return mds;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
+
 static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 					   const struct file_operations *fops)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 536cbe521d16..62a459078ec3 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -7,6 +7,7 @@
 #include <linux/cdev.h>
 #include <linux/uuid.h>
 #include <linux/node.h>
+#include <cxl/cxl.h>
 #include <cxl/event.h>
 #include <cxl/mailbox.h>
 #include "cxl.h"
@@ -393,20 +394,6 @@ struct cxl_security_state {
 	struct kernfs_node *sanitize_node;
 };
 
-/*
- * enum cxl_devtype - delineate type-2 from a generic type-3 device
- * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
- *			 HDM-DB, no requirement that this device implements a
- *			 mailbox, or other memory-device-standard manageability
- *			 flows.
- * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
- *			   HDM-H and class-mandatory memory device registers
- */
-enum cxl_devtype {
-	CXL_DEVTYPE_DEVMEM,
-	CXL_DEVTYPE_CLASSMEM,
-};
-
 /**
  * struct cxl_dpa_perf - DPA performance property entry
  * @dpa_range: range for DPA address
@@ -856,7 +843,8 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
 int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
-struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
+struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
+						 u16 dvsec, enum cxl_devtype type);
 void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 54e219b0049e..9fcf5387e388 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -3,6 +3,7 @@
 #ifndef __CXL_PCI_H__
 #define __CXL_PCI_H__
 #include <linux/pci.h>
+#include <cxl/pci.h>
 #include "cxl.h"
 
 #define CXL_MEMORY_PROGIF	0x10
@@ -14,22 +15,6 @@
  */
 #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
 
-/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
-#define CXL_DVSEC_PCIE_DEVICE					0
-#define   CXL_DVSEC_CAP_OFFSET		0xA
-#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
-#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
-#define   CXL_DVSEC_CTRL_OFFSET		0xC
-#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
-#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
-#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
-#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
-#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
-#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
-#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
-#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
-#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
-
 #define CXL_DVSEC_RANGE_MAX		2
 
 /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b2c943a4de0a..bd69dc07f387 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -911,6 +911,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	int rc, pmu_count;
 	unsigned int i;
 	bool irq_avail;
+	u16 dvsec;
 
 	/*
 	 * Double check the anonymous union trickery in struct cxl_regs
@@ -924,19 +925,20 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return rc;
 	pci_set_master(pdev);
 
-	mds = cxl_memdev_state_create(&pdev->dev);
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  CXL_DVSEC_PCIE_DEVICE);
+	if (!dvsec)
+		dev_warn(&pdev->dev,
+			 "Device DVSEC not present, skip CXL.mem init\n");
+
+	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec,
+				      CXL_DEVTYPE_CLASSMEM);
 	if (IS_ERR(mds))
 		return PTR_ERR(mds);
 	cxlds = &mds->cxlds;
 	pci_set_drvdata(pdev, cxlds);
 
 	cxlds->rcd = is_cxl_restricted(pdev);
-	cxlds->serial = pci_get_dsn(pdev);
-	cxlds->cxl_dvsec = pci_find_dvsec_capability(
-		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
-	if (!cxlds->cxl_dvsec)
-		dev_warn(&pdev->dev,
-			 "Device DVSEC not present, skip CXL.mem init\n");
 
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
 	if (rc)
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
new file mode 100644
index 000000000000..722782b868ac
--- /dev/null
+++ b/include/cxl/cxl.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2025 Advanced Micro Devices, Inc. */
+
+#ifndef __CXL_H
+#define __CXL_H
+
+#include <linux/types.h>
+/*
+ * enum cxl_devtype - delineate type-2 from a generic type-3 device
+ * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
+ *			 HDM-DB, no requirement that this device implements a
+ *			 mailbox, or other memory-device-standard manageability
+ *			 flows.
+ * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
+ *			   HDM-H and class-mandatory memory device registers
+ */
+enum cxl_devtype {
+	CXL_DEVTYPE_DEVMEM,
+	CXL_DEVTYPE_CLASSMEM,
+};
+
+struct device;
+struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
+					   u16 dvsec, enum cxl_devtype type);
+
+#endif
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
new file mode 100644
index 000000000000..ad63560caa2c
--- /dev/null
+++ b/include/cxl/pci.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+
+#ifndef __CXL_ACCEL_PCI_H
+#define __CXL_ACCEL_PCI_H
+
+/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
+#define CXL_DVSEC_PCIE_DEVICE					0
+#define   CXL_DVSEC_CAP_OFFSET		0xA
+#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
+#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
+#define   CXL_DVSEC_CTRL_OFFSET		0xC
+#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
+#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
+#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
+#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
+#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
+#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
+#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
+#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))
+#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
+
+#endif
-- 
2.17.1


