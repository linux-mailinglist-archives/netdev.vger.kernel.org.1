Return-Path: <netdev+bounces-183923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8482A92CA7
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231644473A3
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922C8216605;
	Thu, 17 Apr 2025 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2q77I6lV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58D3219A7C;
	Thu, 17 Apr 2025 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925395; cv=fail; b=lxYqr8SYTD5XMNa70ws1nsKQT1cNfnrAL8nX9M50i5mTd8p9QNmcIUF8CzB4D9MfmCWFmCYc0PYg4Q0Dgci7WHuktXSxKAuGaNn1+CAGZBRAx3/PRi5dkAOaJpo82SAzk8s3lJRZT6cmTUaKmmL+aG/LobSU/pC6rqIu2F2iAx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925395; c=relaxed/simple;
	bh=iUdaPnOnkVzU1K19AnCKW2euOAsaxt5LOiA15B2DoTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2yMBbPFttW1yztTqu2ldFa82bfZX7CN26BJYh+5cZCRWmXPDZ2YqcaPWphq0k+MSp/+K6ADcZVcWKbN3lFpI32reLyFklswN/2tdhFjOZRaNS6hSUkZEWkJX9QuEYGdLLKW4aDgYLg/8xXOX+eOE038PlVwTAlWGpfCGyBRFXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2q77I6lV; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uk0wNvLtwvSQv8S1v1xMATWQJtsG2JDCz9ZIJnjZUsOaQh37ovvpPzeMsg+6tqyIDOvu5ckoLaJnGHcxjRLW1NuuhWj20q55icXFOnUR+foS1NSIQmt7paLnBvUngqJNovsXNWw5IKtESFgkeKi1SQ23pY5SbxIn8hFiP0CVTyE8MS+dd+S1v3L9HBvfIDtA4SfR8XMvHGia2amc39CNX/YBhhY8P6JWuY8DEP/+jK94Q6hix8wJzdTCbQWKbjseqF/y2P4Lg4oyuEodRaazM/o7cs6XGef/3lzKE96jP28iOBmTgXY2rNSz9EKVq+ca2YHAV4KjbDdfRuROyr3dpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU+Uo5wk8R92SYn0ltYQfhXAdlX6VGuZL3o+JOc4Q7s=;
 b=XJImUAR2z5ve5Ka1aKQYNvS49M005CKVLgbv9mgo+W3XajmPCKllXYaMsq7U8qdqBqE54kt3m7TBidUTWLLDXIlH1lkbRnr0w0rWwKyv8UVNL4NGAN9GajFcjMz8t93wxMyXiRUgLUSf+Z3j13Uy1taTl3iQD5wqKjOdqaxV2T0hFxGV+qFGxKmLL4UPRR0lNDc2O0y2K0kKcP7vQ1ikfsYoYAIhszg2xaiM8MlwPy3UAfCKg8Dz/ciuGOfawI4x6ToiASlS3cXCxQL2brqTz3ptXnRwt7WZzALadZmVZc9pBrpb2DKvgGDUIYQBY04kWg5H1ClcNOneNBDrD4+ZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU+Uo5wk8R92SYn0ltYQfhXAdlX6VGuZL3o+JOc4Q7s=;
 b=2q77I6lVDYpzU85TpKL3Vu6B60hNRUUVCJJ3z++dCAsOp79zyVKBMwXI5n/ksjH6gYaCzlWJ/Y3DDScZQQ52rIfHW9yaUrFXnCZdK9qAXrTrVCXus1LW+RLUoRC2jxX88rc0gEDmDqmfj1tPqcUDx6FSPY10HRT8+FHAuDzeOaE=
Received: from BL6PEPF0001641A.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:6) by DS2PR12MB9663.namprd12.prod.outlook.com
 (2603:10b6:8:27a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 21:29:49 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2a01:111:f403:f901::8) by BL6PEPF0001641A.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.31 via Frontend Transport; Thu,
 17 Apr 2025 21:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:29:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:48 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:29:47 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v14 09/22] cxl: prepare memdev creation for type2
Date: Thu, 17 Apr 2025 22:29:12 +0100
Message-ID: <20250417212926.1343268-10-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9bf293-16b7-4401-5555-08dd7df6fb7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bAX3PEWNn+TlafKRNlnYH5zWQo7CZnMSjv0m7+RYuDJzyfLh1XAeAfL906Oy?=
 =?us-ascii?Q?D++pXkeHipz/Vw9F9UIKw7vIl6wyQOGiHrJLZmMUQAHH5rtPWgdzhQCLzlUl?=
 =?us-ascii?Q?4OyN6MxpnstN66tP3v1AJggZZp4eRkxRzjsBoUE/3S1WCtDQltISNrTpPjGc?=
 =?us-ascii?Q?11UJoLBc2eHNQixzmZx4R4otMNqGsOspikxbBngqZ1l0ODZKKMY2mX0NoUEL?=
 =?us-ascii?Q?wibnJEt7XAEBRgGTynsfLZfQL8r0qiIU0ivfD83+8jBsk7XllohBlxiPinfR?=
 =?us-ascii?Q?k8sFcA0ZOQIgpqsjvLNrEF5r8MaKU3usXimqpMOhjYa1zC/2Tomyc62uHmqz?=
 =?us-ascii?Q?mQmOG4Q6eGhdXvxmbitG/yZnbur636kigXzqG5KRyVv/2SvS/LwyeKrD71ti?=
 =?us-ascii?Q?F8OxP8Wso7OwANkzft7iBkofOxiB33KeWZd+dTU0NgyvgOmHbgweCPGsz/Eb?=
 =?us-ascii?Q?63d4lhCoZKw+z0fUqxQktrHwmJ5slUscwepqTDxVYOnDsvGWBnsJINsm1Z2u?=
 =?us-ascii?Q?m0FR1DPc50e8UGl4Ex8r947TgSt9ixE9rqmJLKBOD7rNLydoiHsJCiHXTXRg?=
 =?us-ascii?Q?N0dxd8oX0cVUYXGBS0SySisafbKCLw1Eo636ENTYPgJ9T/1MWgu3e8g14EkU?=
 =?us-ascii?Q?WhD4bqbXGPGf3iTdlqjoLG1UKH40BD+6VCPaFQLc0IqKxHK1QQR/nyR4nIut?=
 =?us-ascii?Q?Qa9am9KbptPIoAYJHXvgbk69XSrppd3FqSXYmrBJiWTXJbgPwQisCtFEzpf2?=
 =?us-ascii?Q?cuKSEjqItb4go12A4+XtXzb2slsHf9H1XI/l/gFkL5zRCxv6hzc9XeO3qDPy?=
 =?us-ascii?Q?TbwYZ8taw87FVd/y25zwkCZ5zkAuxWUre2Bw7OrJuSzkDslqy4Z0gWYeRsSr?=
 =?us-ascii?Q?jAtkSSSz5+oNW7SZ+w6MnjyW47Zr9ZA+TnfUwjcy0LNIYIvVdads3z69JQRi?=
 =?us-ascii?Q?QX7SiiFWlsckqEcTcmAwvHrFEFuw/ZcvH42sGVUm3tKq+ZyJaCJ4FJqUYHoj?=
 =?us-ascii?Q?EAgIECz2rUibId+qB4AeQVv5p5F8kuXZv2KxYsLec6JfWpGC8M+8u/w/wYeX?=
 =?us-ascii?Q?XguCvessHLtgV1ZxBrm9BdWXieCY6Ji5WrNRPzvzQ4SBJC9j4bwjQai/RjLi?=
 =?us-ascii?Q?R9eXaa1zLpKV6gpkqg3lByuMZgPqa8vNjzktOBDvSUMotbHSi1sqOJxDt1sz?=
 =?us-ascii?Q?DGqGM88Igt2XAplb04r7Wx3mPUH63rMQVhVPQXlT5x73h6xFQQQ5Cxsgq/BT?=
 =?us-ascii?Q?mmtGBcK3yp/0saoMgNmoKW6CZ/AF+VQNxajOe4mGWhEpgRrBnCRiLCjqDsqV?=
 =?us-ascii?Q?OldKmtiL4lqd/Kz+DNVhahWf+CGDev6ollDcFMhX8nbkLyO0k7mce/6rAFpP?=
 =?us-ascii?Q?sStYib/YtJhhSi5RyLkVoHoVnL1WnQPj6pjL1DiM+Ca7cr7BRPZzEK+d558O?=
 =?us-ascii?Q?o192ohvF0ze3goG7IpnYPIK0seOWaSrQyr/9T2eDQPUqovD7eileWA79LP6x?=
 =?us-ascii?Q?jF6fZjtQhH8nw9S9L9kvY+aFGvnvM0Otrvpt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:29:49.0888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9bf293-16b7-4401-5555-08dd7df6fb7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9663

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
index 66e5ca1dafe1..9c0f097ca6be 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -248,4 +248,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
 void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
 		      u64 persistent_bytes);
 int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlmds);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


