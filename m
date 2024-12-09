Return-Path: <netdev+bounces-150345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E43C9E9E95
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3EC167A5C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0E019CC2A;
	Mon,  9 Dec 2024 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RZuW2qsI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD8B19CC0C;
	Mon,  9 Dec 2024 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770504; cv=fail; b=iu2971IfhqfhpCodnqYkd0UDZ0I6QynbeIQWBGRoFo/au+Okd4QYaZxmMen/WzOvY0/lN9TIppjXbGt8tRbtjsPCRiFOQUErwVzDFDGTWjqepQqs7fmzQjSAuRhzwtgQZJ+B8HJWilhluxJE8ujRloXVsGXkPrRCWjls//ofE6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770504; c=relaxed/simple;
	bh=2/0HomN6sjpnLSy1+KxwRWuitMn6iQowsaCM/56L3WA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bx41BoVsJpqGzhpQWjWDI2VVIHTf0+UBrEK5nqS8xEU77v3r79+ECutT/qZkq2M0shqQxV7In8ZQgKKdl08D6kMI4PGxeDqmHC5AOAKul8sJGdp6Z/6QfDteZwUMZwUG+qGpBqyXti+sc+wliFRiyXhJzw8ECsR+xueqI8wCT0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RZuW2qsI; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qe9faFqW91w6ax5Mzpm1G5gkaCVXucfP9YunNqUHitUMl1AQhkhIK4x4kpx/xXJOC8ANqu8EOvOUQNsG8pyo3YQ4QmT7nZ9d1gZ3zE6AkgxCSgGOfU4YRp9QpW2o6adaurm6kI+XLlo20UYNyin+pYaK1QyDpx7wrZmXMYdxmonb5o4HrIot3MPO50rObUuvwkBzVAUVcMPYNf9rpMGAOEGNgLD+7PllDEXTIWttjxXjr8gEvKIFCSAkBsUNLql5Csa0HTPVatnYkl7IV7yIRWvNg2fv7xNWToQ5qLqacWpF3pEBBclHuXQZx+m/Ud1rMc4zibrqOLgiLvrcJr+4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXcVPg+XI4tAf7lv1AJezIdfqoT8xE/gfWSD1QnQ36g=;
 b=MgbWnyv3zciVOv6S5ip0K6HvaSpabMdtymjBbIyslMF+FzNeeEjNTwg0HFwNyuHjXJVFYmbCNmDq0sD5L+KW06HBsBZtOZAD+TJru1JC1OcffalgXYq0SITZl4+77L+vE6PaRmMgL5RTX8ti+roIotRwHh6Tb16sUu5M5QTV8O9o9MQkbyJMQ593bjfuhhK6d1eDp6UvMfMQiuc/S1VMTrU5SFzis9AvUffieSLVhlGhsm+OuGy2C97DwU8ezT5AFRgLfOXQjRf+Vl2LW339w6+i5kA11pzSboxedoga4uhD2K3SYWqazBeJ3d3oYMciGKfg/Dxy0Lbl4qf0ohAmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXcVPg+XI4tAf7lv1AJezIdfqoT8xE/gfWSD1QnQ36g=;
 b=RZuW2qsIlHFUR5GgYq8l17F9KrXAIta1+FXeQEgkMH4EIm6A8HQxbeBdYOw8JUtwFo3U1Ww12DYoQuRDAXddsZ2McELEY/xmuOqoh5oTch1qWIsKjOfU/v258s6gbOv6O9ZeNI44mAm4TobbP6nY7mhxRRTI4ub9hnVOHZb5k/Q=
Received: from BN9PR03CA0496.namprd03.prod.outlook.com (2603:10b6:408:130::21)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 18:54:58 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::9c) by BN9PR03CA0496.outlook.office365.com
 (2603:10b6:408:130::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Mon,
 9 Dec 2024 18:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:54:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:57 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:57 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:54:56 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 13/28] cxl: prepare memdev creation for type2
Date: Mon, 9 Dec 2024 18:54:14 +0000
Message-ID: <20241209185429.54054-14-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|CYYPR12MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e8b213c-e612-4a16-2b9d-08dd1882fa5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+4AEWu1X+/GBjzqITKfP/HmQ9jzTFQZGOUjQqTwcWQCpNhdQ5G/RXjSGDvnk?=
 =?us-ascii?Q?bbRmHr54yyienDd5d/rrfadFZUI6A2X17YNnKLucc3gd/cO1Xr939UqWPEiv?=
 =?us-ascii?Q?6rAn5LlJXolXtgIa4O5cIvPzMeqpT00SD0n30xAmfnGU84XifUUMdDwQlvsU?=
 =?us-ascii?Q?WfM0vYumZ7UcsIh1wS5N+zFq4P6uT37jlZ77piXjv2wZrnrenJxHmZkXNSM8?=
 =?us-ascii?Q?aUfvGcHDFHTlrpY6NLY9DHPQEJzHTAGnMU1NKKtOon2Y72o71apNlLSET4Hu?=
 =?us-ascii?Q?lnbQpBrCVQi6S961LhzPo6MzMSWuWR5TsJ/6vCey7Y4MhYPGRG2F/D8/5r7W?=
 =?us-ascii?Q?Z7ALxhua5gUI21YdKWOInP4BrqEllzzMsP6Bugvy/j+gla89U1QQ72YLJMXQ?=
 =?us-ascii?Q?etFhDDN5IxPQUX+uP6+d7uw1LZYJlLlf5gwFxJIIT285s+16LrhmxVyPYks2?=
 =?us-ascii?Q?fvvw96WlXghy8o4hIBxt8yH0ryCn2lpjPThOydm6M249CQY49Wk/cw6CKIZt?=
 =?us-ascii?Q?MBnlZmkUVjXswb+pc1jrqGjGRJxq8L4TA2D2ySSBgphJdvQm0RJozSGHasbz?=
 =?us-ascii?Q?Danp+wFoCC+w0+1LGhoW//yjqleyNdGgK45YsmAFXLM9OKsI8D8VcIT4P7+c?=
 =?us-ascii?Q?aY3IgJytTnpPQGFpH33NrF0Ez7O3A6gPo1YvsVsWX2ombsuhMgPmoipG1A+C?=
 =?us-ascii?Q?NQ+64NA6gsbAscSMJcWDET3FNrmt0PThGenutOzwn71uCrtJhkDJRVny2K1Q?=
 =?us-ascii?Q?W9nz0F2L2tQ6MbBLJtYtX8OKQaY5xUHXd8WxlnSPgGz3apB5URDlezQwDkAz?=
 =?us-ascii?Q?eWRLmxQ+GvydUZYV6zrskRquzeBNhyb43beHbEZOcSG7/mdpVVEtlphXa5iF?=
 =?us-ascii?Q?caw/3g4I4JnxJQiVJ1QeLG9WqSjes3SBHcBTvg1gSv9KFEXW9C27EGpoGKV1?=
 =?us-ascii?Q?lVYesSelfn6OMde6bD7nl9R7syjVSFlQwrIys8j7nS6T2nwmdyA7tfkijC1r?=
 =?us-ascii?Q?fGJqL8GSPtUBm2JcEDdlujY0pEpAH4QSqhqeOl9iVhM+4mQf/8zpapUHVyii?=
 =?us-ascii?Q?Aml5IfKmxELqJEs3YrmRyzpQdbmVnOmXhZrgSUFTygYJ/Sl7mcC9RkxWUq01?=
 =?us-ascii?Q?8rHmPJIjmoCrwMwOQG6EXTJa7o6jW/SlC06666R7HgUw2fQTyPhiO3kQFqR5?=
 =?us-ascii?Q?tDJp3nPB4ycclMRVfo4gW1AAxoCNCrg+GBomR+K95J875Cs847OAiULOlklU?=
 =?us-ascii?Q?ikVrn9PPXfB4XnDBjZ6vdNaHHhVCmZfbrPj6BLK4dl+jth4ENHXDvwtodala?=
 =?us-ascii?Q?rq1yQZLFus87MbQTDFL98C8h1wCiTDt01rWQCfLydZc3D9rwoyoOGg1vf7kD?=
 =?us-ascii?Q?292RE9pWSYuSapEYK22q/0XbE7MgX2UCdmml2XUqbrWmnDi9Vnpr0KiObaKN?=
 =?us-ascii?Q?hzckAkysnrpefFm6eKI8Wwfm30iLn8weU7nRgFOnVedo4OBUyhncTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:54:58.0947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8b213c-e612-4a16-2b9d-08dd1882fa5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732

From: Alejandro Lucero <alucerop@amd.com>

Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
creating a memdev leading to problems when obtaining cxl_memdev_state
references from a CXL_DEVTYPE_DEVMEM type. This last device type is
managed by a specific vendor driver and does not need same sysfs files
since not userspace intervention is expected.

Create a new cxl_mem device type with no attributes for Type2.

Avoid debugfs files relying on existence of clx_memdev_state.

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


