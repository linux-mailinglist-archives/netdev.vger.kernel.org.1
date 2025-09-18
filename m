Return-Path: <netdev+bounces-224329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAF7B83BFB
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A5D525D75
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63A9303C83;
	Thu, 18 Sep 2025 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mfvDJcN2"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72046302172;
	Thu, 18 Sep 2025 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187116; cv=fail; b=JLNPWy/NKoYO5ZVw+nTxoWaUMA1tBVcl0wQ/ONyuz7aiq0tsRDspquclGHmG6IqSCUROmk7ll6iV/MRyUtAFlY3dEHdb2/w8FosRiNBDSMNQX4yLnJMfrMXt7KpWwc+2fzX+KVv9/6D4j0u5fUFhb+HYDSq1rm2C1n1eFmIBFb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187116; c=relaxed/simple;
	bh=IlyM1V8rGMClisYskPZw2FA9WK2aO/JcqY4wpS4Frqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YyRGLUv/42pwSkdiaMuAbLf25vRSbR5uArIMlCjomYHrOPrRDbUUzKt9UN0EKS7dUaV2NWKzAHFddb4clWZtwYheCWbwBHdJdmGZQ/a5QtkQrc3BxTFyZUQ6q0gm7vCQpIwcv42cjKLJI2Owq/BrO18YDnMRRojO1rdHiiUd4xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mfvDJcN2; arc=fail smtp.client-ip=40.93.198.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJT+VrwdhuTS0X6NOzlrBj8qEo43VnUFFbo4SINbxZMzQykWEByvX+xWP8fqKnuwl3UfNtYIIdl5GhnTDEn2l2/d5O7o/PvMWz6M8qsMyklniIrNAbVhFIrgNMY+H1+PhFURx6qOLkjDOkkB6JT2t9Bc5Y+RoH8u3NmJUDgfsmmmkqAqmeOiuzIYWtxgBGq1+4HnvdxPZkwRrP6zVLZ33swWLKkhB5AUyT0XY1GfmhiyTHpCDvB7pqDOUTkfZllP4EL23z7BZJy9BW/V6boXIo9jEx6jrNb7xZOPqIKlTQzXYpH9bSdSppz7mLj1ShlrCpiVWD0SU1GthgFdsoK8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SXyg/uuKnerWBxPjGN04dWhjRwaTOMmvJmIphWd19s=;
 b=SiFmZBNjqBdgwaQ0i3s7g1q2vJQ+BFFJpjxXpkHfIw2t4gRivf1omVi3+9iLVrwk/NZClq5dWgfnUob34akMlAopgKC8hzbPm6FJCZS6CrpF47QzKx982H73kCOQ00yph051HiTJ98ulYc7CfBukXWAo1FmeTJNwjPO/i8fAMcFP2R6VNUPNDoFw7TVon9vZkQqv6mOZ5V+v5XDlVbfRSYTAIkLE1sg1qBXHbTAQH94Qs7NT5qJz5i5MKecTeEUlexe2WuCoIqc+talBUmYPhNj1JZ3lgAvszBwGOc68iUs76P8BJUuVBI2CTmrUloCjez1M8y0rZhZHeDx0NExpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SXyg/uuKnerWBxPjGN04dWhjRwaTOMmvJmIphWd19s=;
 b=mfvDJcN2T58aVr6SY4UEDX4fhByRSY9aj6M5xQ+p2FCeY2YLsGRrNCedoKX7n0rcmx4LmFWbK5hDn+3Pr6V0JSju+vzYU97eqU5JItdWxds5ebqh0Sn6adg3RnnGPjIC4ETr/OA2u+AVWifCUmm8xfRHbaNLtQz/RFGGs3bjMKI=
Received: from SN7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::26)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 09:18:27 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::e7) by SN7P222CA0012.outlook.office365.com
 (2603:10b6:806:124::26) with Microsoft SMTP Server (version=TLS1_3,
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
 2025 02:18:10 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Sep
 2025 04:18:10 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:18:09 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v18 06/20] cxl: Prepare memdev creation for type2
Date: Thu, 18 Sep 2025 10:17:32 +0100
Message-ID: <20250918091746.2034285-7-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: d55f25b5-e811-480c-a406-08ddf69453a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?76zZv6xL4X/TiowMKHOeFTWS0yzG9Km9d48LuLFQMazexBHC6nUyk7lcfJBy?=
 =?us-ascii?Q?P59NZpYdj8lI2zRntX9MymONXlkxKtmHojjDh77zOoQO5Q0HeGRuaf/SXh/K?=
 =?us-ascii?Q?+gqFaCKNtPs/bzYGuM4qBFZgpJNVjPj2hvEiiAaOAT956oLYb7XNhLo6ydkT?=
 =?us-ascii?Q?aS2EbqzS+CfGhYiubFiqW3bdMdFtEqv+BbJX/YSzk1ema+Dx4SucJmj1chWD?=
 =?us-ascii?Q?Yh1GP1elsgnisFgYCM4+EYoyrw3PdSl5luYVYYGmuuzsnBV2BHxrYwB+PRBL?=
 =?us-ascii?Q?GhbRZiADaOu5iI/Xts6bcIVJW9Gc9j0iwwyCw2o8tD3pyREGvp7ZdTYRo7II?=
 =?us-ascii?Q?5f0+LdN90y/jHt7LEU83GHQeWPLP8fo91JkGqsoksbsFLcNgXF9eXm5NYMi8?=
 =?us-ascii?Q?vsOdInjyFqRE5EhpukdvJJVtK1iBoMUVrOUPtYHwrun8nFjQZ/yJLVRviDPA?=
 =?us-ascii?Q?JFaMdCIOOH/bMolLctetnP4MubE0EYX51TE2mCU94gmtoHw8C5UhYwrseiZX?=
 =?us-ascii?Q?QWzx2Pppo6H6P3EVwdxmk1E6zGMASgiPxVmjPKsqI5AeSFbuH4diuZmNBXCJ?=
 =?us-ascii?Q?iWQnMorW8IfQKgvjPQujvT+WVYuUMuAzH/EeAvpnbd9qpPNYSSGHiiCj3whU?=
 =?us-ascii?Q?yaFB3LisaU3EdcgQHk/6UehBa3g6u7u8u60GmT54X3II96UFfEqCdKIpL1Bl?=
 =?us-ascii?Q?tR8Rd5sF5vWjpI9YfEsXgm3Do36/oMamOqIN37x4eq1q1lxxQZ4qdJ2Pamz0?=
 =?us-ascii?Q?oMudcZvkHADius2zJkj51FWgOVc4XbvUEZzDY+LspWj3r9h4YcVuETAMylqN?=
 =?us-ascii?Q?hmzptOkTF0J8TmTcoks50PAnLuH6d4XT4E+2MHVPubgJbWPYzR1Ier+w6fCZ?=
 =?us-ascii?Q?9mhimjGbC4PnGlfg/h4JNvqKx+qATctgo5zpqZM/6AFOU71XvC0eMzGh1D2h?=
 =?us-ascii?Q?86FOxiGTr7ytR0oA3h5h4oKMkmHMXFj6zgeCD/m4PKsFbeRjoeKoYrwa+odM?=
 =?us-ascii?Q?8RES2umgNIZeBzNmnbLGjvBPyVZI8wrdX4N0tHD+alR+vBZGTbdJpxEdOfps?=
 =?us-ascii?Q?aBnxAa2T8S8rFIifywsyjfkUvgIEZBjJkAa+ZKwh1a1A95yO1Fb0+nr5PG7E?=
 =?us-ascii?Q?0SOQOFs5mI/duYJhYMW4CI0ppJCl59qviac+cJxhB8y45JYT6NvunwI+Ivf/?=
 =?us-ascii?Q?//kUo8lMt5i0tMRdD2ncVNLgwLboVnGcvUvSyJ1n2eILqg+o4gDPQRxcF9UF?=
 =?us-ascii?Q?yCNM+e5OojlutewlZXVuDQDmYUMMI/u+gz1V6LLCW67gWm2DGoOUuo1RwRn/?=
 =?us-ascii?Q?xQ1ch3CsWvkyL7J1o4dEvFGD68XYGEnI97r10vjiltus98G4q+sFnadgo79I?=
 =?us-ascii?Q?TZ5QCdQSeEEirUdl1UtKjSvRtt6q2XrqOpIvhBfNp6wrrkLzz67bIKoREdyM?=
 =?us-ascii?Q?Egds89Ik2pDNxq6doyblBcMKSJQatPZXZZ4tUY/xKwaHBThD6+D3LZGELua7?=
 =?us-ascii?Q?lk40d8ZicKr9Wr+o05h5GLtH5t7TQHxF65pn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:27.5016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d55f25b5-e811-480c-a406-08ddf69453a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303

From: Alejandro Lucero <alucerop@amd.com>

Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
creating a memdev leading to problems when obtaining cxl_memdev_state
references from a CXL_DEVTYPE_DEVMEM type.

Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
support.

Make devm_cxl_add_memdev accessible from a accel driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c | 15 +++++++++++--
 drivers/cxl/cxlmem.h      |  8 -------
 drivers/cxl/mem.c         | 46 +++++++++++++++++++++++++++++----------
 include/cxl/cxl.h         |  7 ++++++
 4 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index d148a0c942aa..3228287bf3f0 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/pci.h>
+#include <cxl/cxl.h>
 #include <cxlmem.h>
 #include "private.h"
 #include "trace.h"
@@ -550,9 +551,16 @@ static const struct device_type cxl_memdev_type = {
 	.groups = cxl_memdev_attribute_groups,
 };
 
+static const struct device_type cxl_accel_memdev_type = {
+	.name = "cxl_accel_memdev",
+	.release = cxl_memdev_release,
+	.devnode = cxl_memdev_devnode,
+};
+
 bool is_cxl_memdev(const struct device *dev)
 {
-	return dev->type == &cxl_memdev_type;
+	return (dev->type == &cxl_memdev_type ||
+		dev->type == &cxl_accel_memdev_type);
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
 
@@ -1139,7 +1147,10 @@ struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 	dev->parent = cxlds->dev;
 	dev->bus = &cxl_bus_type;
 	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
-	dev->type = &cxl_memdev_type;
+	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
+		dev->type = &cxl_accel_memdev_type;
+	else
+		dev->type = &cxl_memdev_type;
 	device_set_pm_not_required(dev);
 	INIT_WORK(&cxlmd->detach_work, detach_memdev);
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 86aa4899d511..0e02cd9f0bad 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -34,10 +34,6 @@
 	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
 	 CXLMDEV_RESET_NEEDED_NOT)
 
-struct cxl_memdev_ops {
-	int (*probe)(struct cxl_memdev *cxlmd);
-};
-
 /**
  * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
  * @dev: driver core device object
@@ -101,10 +97,6 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds,
-				       const struct cxl_memdev_ops *ops);
-
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 7480dfdbb57d..9ffee09fcb50 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -67,6 +67,26 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
 			 cxl_debugfs_poison_clear, "%llx\n");
 
+static void cxl_memdev_poison_enable(struct cxl_memdev_state *mds,
+				     struct cxl_memdev *cxlmd,
+				     struct dentry *dentry)
+{
+	/*
+	 * Avoid poison debugfs for DEVMEM aka accelerators as they rely on
+	 * cxl_memdev_state.
+	 */
+	if (!mds)
+		return;
+
+	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
+		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
+				    &cxl_poison_inject_fops);
+
+	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
+		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
+				    &cxl_poison_clear_fops);
+}
+
 static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
@@ -94,12 +114,8 @@ static int cxl_mem_probe(struct device *dev)
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
 
-	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
-		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_inject_fops);
-	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
-		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_clear_fops);
+	/* for CLASSMEM memory expanders enable poison injection */
+	cxl_memdev_poison_enable(mds, cxlmd, dentry);
 
 	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
 	if (rc)
@@ -236,16 +252,24 @@ static ssize_t trigger_poison_list_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(trigger_poison_list);
 
-static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
+static bool cxl_poison_attr_visible(struct kobject *kobj, struct attribute *a)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
-	if (a == &dev_attr_trigger_poison_list.attr)
-		if (!test_bit(CXL_POISON_ENABLED_LIST,
-			      mds->poison.enabled_cmds))
-			return 0;
+	if (!mds ||
+	    !test_bit(CXL_POISON_ENABLED_LIST, mds->poison.enabled_cmds))
+		return false;
+
+	return true;
+}
+
+static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	if (a == &dev_attr_trigger_poison_list.attr &&
+	    !cxl_poison_attr_visible(kobj, a))
+		return 0;
 
 	return a->mode;
 }
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 88dea6ac3769..401a59185608 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -153,6 +153,10 @@ struct cxl_dpa_partition {
 
 #define CXL_NR_PARTITIONS_MAX 2
 
+struct cxl_memdev_ops {
+	int (*probe)(struct cxl_memdev *cxlmd);
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -244,4 +248,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
 int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlds,
+				       const struct cxl_memdev_ops *ops);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


