Return-Path: <netdev+bounces-190425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1789AB6CA7
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1610119E88CA
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9445127A459;
	Wed, 14 May 2025 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ol/GuuL9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FBF27CB1A;
	Wed, 14 May 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229295; cv=fail; b=I+htmrU5x1VPzBXB9T4IM/0dcuDVYYiwyoBsh7d51mVJnqPnkDp8BlriAJ0yZ03tuf7n0zQdK4vIwBKuKa2Y5HkYHtD6AqfvoPL0o1kuKWnXuqx9gDTEORXnw6NV0dVO+fPgOoVmpviVwqQV/4FVyAgV275yrcKZjs4gotAeAeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229295; c=relaxed/simple;
	bh=Z3Xrlovbp63S5Vx64U+qxN3+Br/KqxRQGG/9vO2V5Jg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emBR1jqsylemUmyVMh+NhH4sFmecP7g6+GFlBI9u/IEwLOGdC2ScPDAA6QwKU7QVgjmry9HZ5S8s4Hr1+4LKCdZcc/Si63aABEnKeiH3AIzIbOM5t+vBLcGbVtohx11YequMHb5zKesP/a2aplEWeaoNd5ruEHL2xueq3mqTemY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ol/GuuL9; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qf3I2V6trTvUQezxjGOaQ5Rl4ydMX7na82TNXcXDmBHEGZGhV6a50LlcDe5zm6OdfKAIPd5T6oebjujsLmhWQBrttspz+EkaAtUwfcAPNindx/R8XVhGDhhYJpNL0hrZ6lhulFaF020FAKWIc+LzECAM8jA7EujCY4FrbaSxMsY2UKPa7dOI4JDAjT2prVINJL/oqbcc9pV8EMwSUaZwisYurAmX7a7C1zsTGLrJPM5Sv90bFMAfK62RWRyhU82WLaMZUwLYkvrTpxHJQbQarIu/oue+dqiZ+lXj1oQAUsAD9TrYF2KJTLKmR6LZeea83d+j/tU3SCNWor4raFpusw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLm8nLlxNVKmqOqeccdv2v87/M7FThz8NPZk2K2x1ds=;
 b=Bz3iXNINztrqlx+qtVdQ1XCTQhZqEiaf0y9uiLyLZGHYtMUCSp6oBmXp3I6PjAlZch6r6CzkAiBx3E25pRROb/OaGwd5qTqmP8wumYBEJhLzSprCXaST4TNC6cM+Zp3g5fX/fYtD6atnpn3wGx/sOwiMbs2wTokk4bVYm/R2c6llrUSpsNVuYSLmXUMcH8mWV6FIqmD3zjNNpwJnoPexZSeaVzIaaVTK0ZZDDJY1eR1Tdn0d7Iq+rKcp0Tu1NPwqtJgGGq87BlBvXr1HkQqOJwfAk2k8sOluFACP6pBWjtl4aYXyq7aPvJoL29MRDu3su3LjduT/WqF/UajooG4fiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLm8nLlxNVKmqOqeccdv2v87/M7FThz8NPZk2K2x1ds=;
 b=Ol/GuuL9/rzN6wTT5CqHWt9NFOZULLTKQ3/43HJM0ueSPzZdfDI0CbF0cbVHrEqhNGRnhvyTC3xV/X8VxAMvGRZutEvuOn7UweefISl8xrsnHqRu2QR/bnQoJLVfOrrhcbEO+QDKwz0thpTbmYIuQCjDbtWkxcXbul0NvPSm+LI=
Received: from SN7PR04CA0234.namprd04.prod.outlook.com (2603:10b6:806:127::29)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 13:28:09 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:127:cafe::ce) by SN7PR04CA0234.outlook.office365.com
 (2603:10b6:806:127::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Wed,
 14 May 2025 13:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:28:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:06 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:28:05 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v16 09/22] cxl: Prepare memdev creation for type2
Date: Wed, 14 May 2025 14:27:30 +0100
Message-ID: <20250514132743.523469-10-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a85b8f3-97ca-4963-9653-08dd92eb2af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dn2JDzVm8ciRVh0wNAobdHXFoy8Ng9qMdzg5vBPistT/G2m5Lz6NRDEFiF9b?=
 =?us-ascii?Q?MFS13nRkPlSwVZRCOiBWa0NA+SNGvvd7D/7V8dMdohmJ5tI/u48FYuC1IRCb?=
 =?us-ascii?Q?kB8IXBLELS5/jdz3ur2qjzJrG5tfbGKMk0/DFbTQToZhA+7S5qyL6ZggU78x?=
 =?us-ascii?Q?S+1LrvXuSLdivnCdhni9NgLLPt+qMxx5veEl72+bAQA5G5YOwZXp1I1yc1Ti?=
 =?us-ascii?Q?3jRC4hNOm14qgXXHKfR7dg2GJW7V2FA6b13UOQLDnUQVW0PDcHHrTlMMo1Xe?=
 =?us-ascii?Q?g1ytYX3ic6LpKb0qkBx47z/eagaTVD2qNiY+dpbVVJEwXLKGfkm+Py99MSKK?=
 =?us-ascii?Q?DqDLjU6k5yfq+PtyPdHZcnF8EPpqI/inNnJeo9gmHHSULIRIxYmyxTtUaZfD?=
 =?us-ascii?Q?NtOcn+AwJnSfElR3q+zGls/1o81Igus/ezjIaMQFDdAYdVIh9OwFkE9OQSJV?=
 =?us-ascii?Q?jNe32AUu113S8ApcflN4+9OAa7LRX+3ZPjCeOur16/aYeZiQLWS0FHkWw4Vp?=
 =?us-ascii?Q?NjSoF7qy9sHSn6NsHJK8jKCWTwUu/wQm3zEhL7SAQi/3Pv5cpZ+scNRtB2BM?=
 =?us-ascii?Q?zuRmcyOBnfCB83mCYHFhyvN09GV3z95zSanF8pqmE/NK1olgUp2WAboeVXG7?=
 =?us-ascii?Q?6CL56mQAX1TzKMbgxZkoZob378dxBGzC2hN/3QhSPpuuw1cRY6oQeQB1lVLs?=
 =?us-ascii?Q?KGdWT5Vd+AtZRQaPUBkinaAFK4WVdDOuTK8FbmCOZUBi1EK1N+mWMubrZ5fe?=
 =?us-ascii?Q?qCitfFYEkxAxYn0WONTFl/4MS/90Kks6vO9rT9eBWq2Yv1zZsVS9ptkIyfEh?=
 =?us-ascii?Q?g5a9CIYH96LzynZ/2z6qRZ+qKvvC9/hlim1MFBBJfzgLjKJgKajLOHJ7AHMw?=
 =?us-ascii?Q?r119cHgYPhD3yntJs/rg4QoVUf05dWSczOMXrgJQNHhsEvOOKZBkTvPBTTbZ?=
 =?us-ascii?Q?1fDpE9glJRw+ayYuEEagq40A2I9E+M+q8stNgpDha0YaZ8TugdRkjylPKvSJ?=
 =?us-ascii?Q?MRbu4U2bOuYhZ2Fe7j+qYuHB3qmAiflT/X/0HYx8I9B+qrhZOfOM5wx5CKOM?=
 =?us-ascii?Q?EnZnkPOBADd/YkiStlDfvEs6JIMmrjgEmrW/6AIraSMZS6DVKQJBJdh2PSNM?=
 =?us-ascii?Q?u8qh7BB2LJUZbzgaL6jA6f0F97rQZLYTItAbILI7kGf12i2buDYC2noxo6+y?=
 =?us-ascii?Q?XU7DvoFOoyMVCyk1YZcn1fIfU3GmOmL8QcW6mYOnQa/U3RvqCqR9tYXTjdHU?=
 =?us-ascii?Q?xvEVQf4ViDf779fhLNKCNlUShxZZ5p/zRkyngMgM2qZhvoTPp40fbCQUkKSf?=
 =?us-ascii?Q?wb3U6kA2CJsbzFvtwjCaNGhNsUKuvYNUgk88jn4/hrnIsxXoOnfwCCVPScF7?=
 =?us-ascii?Q?L/n1rw4seeuKmhhu2fq3RnYhA1fMXmYwVbKlzrCu1ptw2ghWdBngI5KCtkmc?=
 =?us-ascii?Q?3Lf9JYzgUv2R8IS+IM1b5CA3yv5Okgjuf9Zo4SYZ9oFsqaImLbnbGoXSSz+J?=
 =?us-ascii?Q?3FE07ukhwrh7JXvopXDV2jqyB4aaxLVkj3Ie?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:28:09.0680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a85b8f3-97ca-4963-9653-08dd92eb2af3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091

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
---
 drivers/cxl/core/memdev.c | 15 +++++++++++++--
 drivers/cxl/cxlmem.h      |  2 --
 drivers/cxl/mem.c         | 25 +++++++++++++++++++------
 include/cxl/cxl.h         |  2 ++
 4 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 6cc732aeb9de..31af5c1ebe11 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/pci.h>
+#include <cxl/cxl.h>
 #include <cxlmem.h>
 #include "trace.h"
 #include "core.h"
@@ -562,9 +563,16 @@ static const struct device_type cxl_memdev_type = {
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
 
@@ -689,7 +697,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
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
index e47f51025efd..9fdaf5cf1dd9 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -88,8 +88,6 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 9675243bd05b..7f39790d9d98 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
 
-	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
-		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_inject_fops);
-	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
-		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_clear_fops);
+	/*
+	 * Avoid poison debugfs files for Type2 devices as they rely on
+	 * cxl_memdev_state.
+	 */
+	if (mds) {
+		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
+			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
+					    &cxl_poison_inject_fops);
+		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
+			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
+					    &cxl_poison_clear_fops);
+	}
 
 	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
 	if (rc)
@@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	/*
+	 * Avoid poison sysfs files for Type2 devices as they rely on
+	 * cxl_memdev_state.
+	 */
+	if (!mds)
+		return 0;
+
 	if (a == &dev_attr_trigger_poison_list.attr)
 		if (!test_bit(CXL_POISON_ENABLED_LIST,
 			      mds->poison.enabled_cmds))
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 6d2cebae2ca2..19d194d98665 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -264,4 +264,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
 void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
 		      u64 persistent_bytes);
 int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlmds);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


