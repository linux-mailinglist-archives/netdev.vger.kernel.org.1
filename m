Return-Path: <netdev+bounces-154583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809F19FEB1F
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580001621BB
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF85A1B0408;
	Mon, 30 Dec 2024 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ImbY8UTY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A11ACEB5;
	Mon, 30 Dec 2024 21:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595123; cv=fail; b=l4N8stbtaFp2SZbgjJv3LeElUeNgJZ9jdA+yDboV894XziEKROn2JE4VcgTwORytQIRwjsHUpm9ljqVWl6y7F3ywZFlev4FH90sBKs3isEXvW9KdotP7h/JtcSd+79wPaLp9VVoFQgbY6WKfCmlx8Q57nV4hzFgYtGKAJFO0qM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595123; c=relaxed/simple;
	bh=l+8jsd/+XSSneDb4+l9JjeOqWP6c08oxpb1le/kLg0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckL2IpMtQB26oHXsfVwxA5/FdxXcGTgd54hA2v7qiekRSB3IdFosps75qy2sEvHQO8gDIyiabJvwkX/k4I4lhvgwoGB/ifteOYz4XXpGFjbUYKcTQYUigC2ndnUrQ2anfcmPYzqSw1AMsWLkTLMHi39rxX2ypg63WZr1mI44VCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ImbY8UTY; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arcQSxB1lxZ/aPFEaWpejLj7x7LHdDx9gos69XkSaN54u2kelFYTkEB7DMsCJ0h3PBTrRQqxxJNRk0V3NmurOtuegYNAP+CfXoshvCs+bZMvqvlqRwyrQAywT5owpZJrAAYfAnKLlzJXe4PwD8OnKxhm/8/D7p6kLcgsiHc006r+ZWxy9HSon3WbhWENnquikcllnjIvWtyBNbXSpr2kfyF56GJkvEJs7WqCc/3z6q0OPEcKLPXhf95FkyPf2WgpzoyCv/4IlPPPS8amPQvp4jyyd0yuQKsuHe+0BvvCAho/JqQQZclKTFnXRVkcIncabxSUG2oF+/zpyw8zwUxYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZt9lucKqiQNwjcEZMsNkOXtCM4qhfJIm7KVaHs0Kac=;
 b=hjILPV3QnVqGx19Po2Kqbv1ze3G3R323tzv0fOYn9EftZ2Eieh1x579bgo7QDqN0xPCr/rhZMtkgD2K5txfcyzmtrTjOcH6UoipGNYmDW3hrDF2cN/YRHsTfhZhOq5W9MqGliD9SygQJhat8cz7cODeBeuzl8HoJrwWrGO6GRKBNUbvsLgTomG+ogGdQ7fLTzoaXguIuuaDeD9wUFQBtPcxyeXmkeZR3S0vVP1EwapJN1MuY68tW++wljKoxt7t++aaqzIM8A8Rs5yoYYHNsltz5i9pnDmG+/pGHcktQYLWKhZpBlM1WYxX+TtH6SqBs/dJ00/7CvQKgr6w6/Nqd1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZt9lucKqiQNwjcEZMsNkOXtCM4qhfJIm7KVaHs0Kac=;
 b=ImbY8UTYuQAWO0V5nAjSvDlketffHdX2mlJBFqQl68wNs+Aa0uYeNThhGmzc5ZzY0v+sprYq7fYeG0cW5tK02MIaSjJHtnUKylTM4f9RaZErwG7BpEa6x44q5pqPNnOZSRQZ49W8aEMXwuCq7NyRojGOgYyYrWm4cWl05cbPxOQ=
Received: from BN0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:408:e4::30)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 21:45:13 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::3) by BN0PR02CA0025.outlook.office365.com
 (2603:10b6:408:e4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.19 via Frontend Transport; Mon,
 30 Dec 2024 21:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:12 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:12 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:11 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 13/27] cxl: prepare memdev creation for type2
Date: Mon, 30 Dec 2024 21:44:31 +0000
Message-ID: <20241230214445.27602-14-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|CY8PR12MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: da8bdd13-c5da-4ce9-23b5-08dd291b3db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GJsyjEsofYT1vrpCYqSQfPRAS/yqIvvS142i9p8GrwNe2eU7c2wOrB96uadT?=
 =?us-ascii?Q?GvG6P5ijJeLZ1okcX7zIow+gUaqfwoUwEs/5W4Oby6hXNpoPKEt7/UrCoak/?=
 =?us-ascii?Q?oo25YSk87wklmA1lRuoxX4kgAvxBc4pLH74pTLoLlYH5GtZupSSGjZv0YeEU?=
 =?us-ascii?Q?+KzdE82E4jRynfx9fY7o3WD/3t/+sXr44mhMWVCL0XLEiHYSfM73Txrxehgh?=
 =?us-ascii?Q?4/yjfIgVbVJQ/nEHSwcyQ0jz330ELxEp/l9IF1TM6uxo2V+u4ZvxBhaY7rUI?=
 =?us-ascii?Q?8B9Gq7H5+DNGZV2bpLCFx0mP5C/8nPW7aMdH71kK9wTdBiGHUX2iOkF1KttU?=
 =?us-ascii?Q?eJwth/HGHiALprGyhv5w6nstfYzGlxJFEnskDAQQeRZsD3tQQz8iq5V22OnN?=
 =?us-ascii?Q?ZhRieUlg60cNjEEhUXbL/qpFj/M7RslMYZ3KJrii2r+GcdoqhXkzVlnrGveI?=
 =?us-ascii?Q?e5JMsloKSejkqd4uofKGk6IIqnl5y8/T1aKw2icwxE9MmR/rYfVHi2fnDAhB?=
 =?us-ascii?Q?Q7vQYBxet+33gNoa0NlK0s4IjhUT8y7qFzW4BRw9cKk6DeGfsE6Dz+YJJBaH?=
 =?us-ascii?Q?0Nwb95wjaH6zeMloaJx8QA3U+jTkA3OsybL6TLvG2gvMOjX9JoozaoeSlAOf?=
 =?us-ascii?Q?mzp3CqolOD3tpHT0T2Izv5oiEFTi7pP5YL/1T6bgHPONkCwy141kNvtalaHD?=
 =?us-ascii?Q?ZLL0sVWnPoz3HqdNoOs/i+DSEdrg+FLd6+9/fU6Yl6G2bhRyUWA/+neZyLkr?=
 =?us-ascii?Q?R05JLhgtFX14g0frVMm13xZpIU++cABuFnzh4+iMrbQKgtcfB0/BoMHHQzhJ?=
 =?us-ascii?Q?sxMPM2DLw8LOQVYmFgECouYBtNgOIsLzggKtLByzQik3s0C6wHsK/dAyJpjW?=
 =?us-ascii?Q?kJRIFGw+tOrxGf4RVCJaObY0zS/O3lvilGheTCq9lQoNg+zl/96RMlFSVNoS?=
 =?us-ascii?Q?LWBdjdYFBCeDMTxHS6tfBrf/2nNShWyCy1QH2kyNbHtgpdN3ABjz2epO38Va?=
 =?us-ascii?Q?4MeMkghyzFXpgDHhl2dpm3NlDYdKcTjs5Y89N9hXSNr/NVNoU5K4DubM40u6?=
 =?us-ascii?Q?q3inTeVS+P3Gd18DdIihbWhziPhd9gO7xA5t5dv8MaRujy5ruipVmFkLIE2x?=
 =?us-ascii?Q?ul45fa2BcmPLepbtmnmD99rmJKYh32Bm23C7ySfWV/52X5OXdfAIhnHxfFes?=
 =?us-ascii?Q?oRAHGI1LtwAQHYOgBGjZ6bpBFfeqcKeCUBEbAk2MriJXpjTbkXOi96tQw6+8?=
 =?us-ascii?Q?JRQhFkd8OC+vw+g7Vxq+ddM0X/CBQ2FD33amMkxVJ6VqyLO3S0IAW1WqP+Ci?=
 =?us-ascii?Q?U4HyiBIcnRIl4xJCcdjIbLVK55UvHdE8y2n9wEYEntqzaPVGl+QiLfXndtiZ?=
 =?us-ascii?Q?5egsVKcQEk3aWYO0Untf5IsQghonepQwINqG8zl7zmj1oIQPExdWlskNyZjD?=
 =?us-ascii?Q?qQBmlfESHTf6KQY0DslWXhUJ/W2R7CnaDWHLgIC6bf9p/r8ledF3Zy1N0MOA?=
 =?us-ascii?Q?ufYejyHvskuZ14s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:13.1637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da8bdd13-c5da-4ce9-23b5-08dd291b3db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412

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
 drivers/cxl/cxlmem.h      |  2 --
 drivers/cxl/mem.c         | 25 +++++++++++++++++++------
 include/cxl/cxl.h         |  2 ++
 6 files changed, 38 insertions(+), 11 deletions(-)

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
index 836db4a462b3..f91feca586dd 100644
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
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 4c1c53c29544..360d3728f492 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -87,8 +87,6 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
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
index f67ee745d942..f7ce683465f0 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -48,4 +48,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 void cxl_set_media_ready(struct cxl_dev_state *cxlds);
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


