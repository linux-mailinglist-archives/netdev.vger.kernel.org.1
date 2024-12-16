Return-Path: <netdev+bounces-152290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5699F3581
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B5D7A3650
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A25206F2D;
	Mon, 16 Dec 2024 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zn4eciM2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D27206F24;
	Mon, 16 Dec 2024 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365477; cv=fail; b=X7e0j1KKCwpykde7Q8QMblxPaTvZWQ0lQSXDp3j3TewVwBFdGNB9Mcha/CSrI5wzxcs4qJSrH9oVTk1OVll0lLj9QwLl5KeNlC2vwxkdhLG1K94W2sVtgnqMUl3b8PQIfXfMUpvHWdI2V9+/qXJqshce3cmIDUhzuGmAQdAjlMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365477; c=relaxed/simple;
	bh=PsYyacYUyyC69INDAsvdW42LNThKhA+bVo7WcXsBrg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MddHfiI68D3PgPpq2HyRJ6m4cgw12mkAhJx7bX/z8cdP0U2cMSp9pdBB1SJpDP1K+J5ehadO3rPqVOa4nShq0R0oAqRL90wMyTEdEqksmFMd/pUYSKVocrzFyGVpPuScyw3UKUoWFslkd5eZVGIGP3s9kwSQ16SVXpBjV2LwmJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zn4eciM2; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCnl5psC2PTYWvT9cgDdQ7FOsjti0u1tdTN066aCxgg9lua2uKgsFgMJgimwovofJjImEpQZiHKum/dr+nVF+ZKe9r+Qx4ieQC3ONtxsN5/Asxo6zb9xsUyo3b2y+V/Jb9kftlVXWO4+EkmDHLXbMyW0utJ/XR8iKCtZKYzMU50+FW5nL4ol7RZmjzpFo1LSvEhm7m9oPnGisn0R5k00IYlM7NmW7iiWAJuXWsZJ3/Dnp15mvBwU4nZLEQsgTJGCGZWwkiJ09BTIDGsEEnhwOgy1AnSHcdVu6SeB1Co2pPBVSXBQxz4BG+Ui44k2RYuOboOvfX0pYMmxKieIJyq3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrB8rYr23JWx7oRMSVbccH5m/1/irYScGjlcB84x65w=;
 b=EH7G9WCLj+1FE6y/YxM86V38Iq06Lqkqb3kAoS5dT43cB5KzlyASMhrOdXHRPFa+kNa7F8o0HFG5X8uWtFLHqtCjidhHRYRMxpVX7MoOCV1BP7ivAWyEqIVmri91UBvgXp6XRNvqWrkkKDptwD2LveTqPqdWUk0uSOk4AxtSQfBGbscQ7tXr4Cv4syyjsG9Wxf8U/HhzNhG59fGk0cME58M4i7wERwIIWxNBiTa/SV8Gfsb5rQaUL4l7IkoglMK2M/7vMS+A6YrHn7VdRrEh5ucuF8pIS28snpVLJptwa3NUAfeEiDmCy6XG18FlMNG6rmZ4aZ/OILf9Z0FLs8OhLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrB8rYr23JWx7oRMSVbccH5m/1/irYScGjlcB84x65w=;
 b=Zn4eciM2exNfRswtjcelKWWsWwCb2quDWL9LBVcC2IkY/fCBGCXSD58lqxgmEJiQ00B74UW1Qx/93UIFXxrTlZTPNYwTV7E7adnXSXvLS9za6CUI/ESZV4U0Qz9TgdfQIFGR+XQcIQdRMqyKuaNOIm6cwovP3t/mUkX7J9hmLQQ=
Received: from CH0PR13CA0003.namprd13.prod.outlook.com (2603:10b6:610:b1::8)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:11:12 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::6e) by CH0PR13CA0003.outlook.office365.com
 (2603:10b6:610:b1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 16:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:11 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:10 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:09 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 13/27] cxl: prepare memdev creation for type2
Date: Mon, 16 Dec 2024 16:10:28 +0000
Message-ID: <20241216161042.42108-14-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|MW4PR12MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c923408-8b9e-4086-173c-08dd1dec4240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qrct5YIhYitcUwjQF0EGboQN2214CGvmER/r9Mdi6iFBCHLAs7j7aioclYK0?=
 =?us-ascii?Q?OO71f50hIICuDYFu+APuYj6OJ684h6e/IFfHQZbvVp4vki7AHg2ZbLnj4Vvo?=
 =?us-ascii?Q?P7ReuIHpFRdsyiku86WDYqi5uFefYbR1Clbk729lGejlgNZYDl1gxvWSmSb/?=
 =?us-ascii?Q?IkVh4dBty7dtYuU7hd7rE7NJvKSgxv0VayowYh+Cc6Fii+1RutOlzKhd7uFH?=
 =?us-ascii?Q?Cp+bCPwLsD58ozNk0Sh0FRrAr35hKM1uQtQwKHIwKuT35Vihlp/ZQNhFn7vO?=
 =?us-ascii?Q?92GtbP+pQwRrqDAker/YFbuegFq27f+t6QXIGG31F8L7CnLc+cED/3+NedE/?=
 =?us-ascii?Q?7xd0u8qLGl1I6ukfrBRcA3zmr5aruAvkS0JIVr5UOLmHJpih2AuNnnL3Z3Jm?=
 =?us-ascii?Q?kPLpNKRanVFgoyMmRu+yQFzLKJ+UsoTlXurd1ySdn9Vy7CCMAz831zBvs+/A?=
 =?us-ascii?Q?IFrRYxJLOQR50lySXTFm/+GrKME/c5wJB04cU7y+F8aqsNsv/l12VDxQJKpS?=
 =?us-ascii?Q?lkETix/yz06wYXsnYHavdN4i+pFLh7bH2+PUQT6zLv7CLtVomj2pwNJhQedp?=
 =?us-ascii?Q?cygyjmEztqcDCzpu/raZDsxGwyi9CgkHJJHnBPU3p3SXsMFvPd1N8ig4PS7V?=
 =?us-ascii?Q?NdWCBrc3KeQPBAj92wDJarc6VaY2FD14Wkj8/isstt5bC4pdVq9Kj0viOuA8?=
 =?us-ascii?Q?6fzQzePKHHlW5r6/mgNSg309UUsXPsLhjs1RK4rZHGSND4X0XHgAOmHnVLJB?=
 =?us-ascii?Q?Jsdj+zq+L0HnHY6Z7WHP/FF9LLvvXlh4qHOg+7d0iiYGrOIN/jbYTa/P7TGN?=
 =?us-ascii?Q?BFW1inVKGsGM8tWEF8b804eXzyUtaAIsLPpU2GCanNbhMMDCgIXeWReI0Xve?=
 =?us-ascii?Q?0pIAFjr+ZVLjBh5IGZCHZIjR/MzMUK1iN5fHGqO0zFjfEK0rdK+imZwFE1vl?=
 =?us-ascii?Q?tX/1ut400MDDnIycI1zc/26IhZBDGbw/k6pTVlC2WauHacw/NwzR8jalVa6U?=
 =?us-ascii?Q?swMZy1bHsr24cxdfaDciH720blWsySsVu72UXGOV94nMhpagJCSEdmsg8VPk?=
 =?us-ascii?Q?sVVKDqqhklR31H4Daf++W3nhhW7sm0Yej3Kbk93FL6UztMbrXwdFQjGoMmKz?=
 =?us-ascii?Q?stW/nGWkzsBxjr/qs25rD9TXLcObbZiNFv7/pjHxLP6f8uSuajo4CjNACRQS?=
 =?us-ascii?Q?1NCHFnk6W+ycHRJBv68QqturhtZz7I7s3T2HP+wVVq9Y1sYMX9pqmw67dnP7?=
 =?us-ascii?Q?yrXkdkN6oxbQXwNCw4+MCpEIhf5pPcFaehWuPEY+DIE8cN9BYlPMWQgSkBcs?=
 =?us-ascii?Q?rB3JqWBRAKotAn0HHDed7DwIc6VhUf69vAdBQFDfmSFWyEetdgmHYoHKnD8S?=
 =?us-ascii?Q?sDaqAKEe0FkkrNwMPzChoIJI+Dn6pjQw2BGj3f7QhhthyiKSbrnT+sTD2DVS?=
 =?us-ascii?Q?aISNk/aTGUc5SG/7JmT/JP/sUJ1OM7qDGaFk3E9j3fEvdlpgOGI9/1F4Sj5/?=
 =?us-ascii?Q?7MOavc1Vw8U2FMwf0vLu0S7DZ/l/n1fvzd2O?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:11.6681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c923408-8b9e-4086-173c-08dd1dec4240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359

From: Alejandro Lucero <alucerop@amd.com>

Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
creating a memdev leading to problems when obtaining cxl_memdev_state
references from a CXL_DEVTYPE_DEVMEM type. This last device type is
managed by a specific vendor driver and does not need same sysfs files
since not userspace intervention is expected.

Create a new cxl_mem device type with no attributes for Type2.

Avoid debugfs files relying on existence of cxl_memdev_state.

Make devm_cxl_add_memdev accesible from a accel driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/cdat.c   |  3 +++
 drivers/cxl/core/memdev.c | 14 ++++++++++++--
 drivers/cxl/core/region.c |  3 ++-
 drivers/cxl/mem.c         | 25 +++++++++++++++++++------
 include/cxl/cxl.h         |  2 ++
 5 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 8153f8d83a16..c57bc83e79ee 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -577,6 +577,9 @@ static struct cxl_dpa_perf *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxle
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 	struct cxl_dpa_perf *perf;
 
+	if (!mds)
+		return ERR_PTR(-EINVAL);
+
 	switch (mode) {
 	case CXL_DECODER_RAM:
 		perf = &mds->ram_perf;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 82c354b1375e..4d24305624e0 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -547,9 +547,16 @@ static const struct device_type cxl_memdev_type = {
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
 
@@ -660,7 +667,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
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
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d77899650798..967132b49832 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1948,7 +1948,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -EINVAL;
 	}
 
-	cxl_region_perf_data_calculate(cxlr, cxled);
+	if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
+		cxl_region_perf_data_calculate(cxlr, cxled);
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		int i;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 2f03a4d5606e..93106a43990b 100644
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
index 473128fdfb22..26d7735b5f31 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -45,4 +45,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 void cxl_set_media_ready(struct cxl_dev_state *cxlds);
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


