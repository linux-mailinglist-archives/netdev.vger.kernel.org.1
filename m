Return-Path: <netdev+bounces-148171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F589E098F
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AD42819EB
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C14A1DE3B9;
	Mon,  2 Dec 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HG84CtdY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6491DE2CF;
	Mon,  2 Dec 2024 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159579; cv=fail; b=na/WxpSYR7SEQDTdczRtRFnBn9QnTT5zU0SUS7pn95atKaxK60kRMkmGGKdzG9qnvKrGgoXxceRBGmAwGhW6A0jAKafnTWtmhOcGJ/FZt0uNOFHI1N0gDIJ9D6v+7mt13prl9jd2CqFbMJy/jNpyS+8pG+uWx6nAQ/EAqw+uTTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159579; c=relaxed/simple;
	bh=yCWZ1xqLi6xvLFoQby+WHXX0JY38nFKY6lYuZFraBEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlDLWYlfSazH0L7TaZDtc/gyB2Uf1m2fsm3/TDM63F1DepFAz1uUqwSpgwdsoaCmiYZiuuiMptnVjCJ4ryBRGlROqq8JWf6GFZGa8La7HaKYnykZayNwNflLiTseAaVHFcDMkaFu69eIp5vFTldteBAQhCbNzIQG4YWTk3JNGqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HG84CtdY; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiTr6wHz57CQwpVLruzDHs1ohvM/OhK3qdCaX6kn8mOpYFPXvL8hsWU2XPiPsAuPeS740BBd0DW94skfucSBeK9lhA9Si7HVaOkR/s5lzMOp8iOO1amT2xXtkjQO2Oemd26O/Hme51mFmDW4x6SCAT9NYb+SudlAf3iFnqLFLc9V9+b9ZQOJAyqgUq/CwkbQjuqJjQLY09t97GOpabHM080FKdiZp5RCiaNdORDMPno5VzHeILZBdm+TBjUiU5HsFFfCtHbebeqrqZErSVQqc6L5m/GYuGmO37PpEOUU+k4sSPRaAOPoO6zEFx9seJnJ059vzbMgMW3HLHVPd8CHfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iC7Myjuu36TNTkyCRq1/Uj6oPUPGlBMRc/6d79aQ1PY=;
 b=Y0zwihBstCO0xBMiZHdgpuXNavcstjCoU9HkKi/lXRLQI707WV9PJNcbcMauySP3ENnunpH8xlqRIbK4cDp3dw8zGIvDqOs6Gfw04qORwhEylaAFc8sbSPn3B3f53FlJ418yOHXcyRaJBS+qadO5cc5Rt1wuk4ifW0BnM7PCyQhgFnNIEJXSt0k12T3qjavxVA/PFGOS9jeshOAwmntxCABS+0nNHBlpcthXX0p/jLZEPqRrzH5OHFn4dayYhKVR/kJrmNoZRf3zuLaqrDI1nHBWaa62dQsmM0UdkllY4NqnfaDv45j4fTFK0c/Qp/r6wsyePELp4BjIU4PyzOVM7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iC7Myjuu36TNTkyCRq1/Uj6oPUPGlBMRc/6d79aQ1PY=;
 b=HG84CtdYZu2Z/EIQc5azXO/oLWW4TWbmFcD/UhTvf8ZYgceJZx+ULsGZ3Fv7+2+78K87vMDUUVZHdyct+glDnxGluKG5O2tKihwOTRR5WbW7pBn+xwNKG+9gAvVflhHvhDnItVfZHGKYabo3lew9kfXZ/QA8QFzkiVn/Lumcp3o=
Received: from BN8PR04CA0064.namprd04.prod.outlook.com (2603:10b6:408:d4::38)
 by DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 17:12:52 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::d) by BN8PR04CA0064.outlook.office365.com
 (2603:10b6:408:d4::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 17:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:12:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:52 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:12:50 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 13/28] cxl: prepare memdev creation for type2
Date: Mon, 2 Dec 2024 17:12:07 +0000
Message-ID: <20241202171222.62595-14-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|DS0PR12MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: cd765529-04c7-4e78-90f2-08dd12f48e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IEPB9dfEiSYPG9nLHyg5+S0Brh+4AkUUqOXvb4nnWbO0G2A1eOrydhb8Wwjr?=
 =?us-ascii?Q?EDg6TIGP1gWf11Ukz+Vu04rUAzzLdIR5ovLlff2yHnRD1tks3opbmQoXZnbr?=
 =?us-ascii?Q?RJBd1lujEL78NbuA3EDeh3LLl7pZxIe1en7IChBHXkfZGv46ljbjEg2eCa+u?=
 =?us-ascii?Q?ai0qgos3MMCCRNi5RqR9KnL4Ab+qItEeqXJQJqy3yPQpVLKwW6vARM+35Dtd?=
 =?us-ascii?Q?98UxG0S6g+EAtdTTH1uw1zPa1cH7xmZ91yqUTAUVNT+iYfu7rh/q0rDN5jcX?=
 =?us-ascii?Q?fMf+AZ+EiuZ8pp1Vi/s9IpyYuAKQx/o67C+XWImlcThWm1za26pZk348UOpX?=
 =?us-ascii?Q?nSfp3mBMTsyLbF5r4rwn7ALn570E/RaVuxaS2Bh3ZfwsU2jmQq1Q+LYeQEp6?=
 =?us-ascii?Q?Pq/7jknfzHkN2WXDLFmZNY6g2IWVVLorve0Xkwf8ihYZypCGuAwBlhT/G3ZH?=
 =?us-ascii?Q?5CMcjOXhWORVN/miROraE95SogjjNzcZC8qwjGwedPcxswN5qUECaeN9QcA+?=
 =?us-ascii?Q?zGB81x6Q5sXgz6Kl7sZLRmZ2hk2y1XYRV868y1ZXmREQdukgM3OyKa7v3oTh?=
 =?us-ascii?Q?nHUvjYPF0PvFbcvQQuWwmccGEkLJEP2jN5goHO2/XdPvsG07kQ7CwbAg8dkJ?=
 =?us-ascii?Q?DykAsus+7OMzHjFdJXjkdeUbtucxXmAh1lk8YSmd4xFnO0+msuN6sCYPJ/f0?=
 =?us-ascii?Q?AIXGw7JczS/XC9FNqD8reZvNHe/idbOIEsBWtw+ldzhrxDeG/VH0erI9rn5d?=
 =?us-ascii?Q?uYJJefxs7wO0zO252kEiKS1gMkMpy3+hg8m5cSt4dz3y0RYPPPDzNgkh0J82?=
 =?us-ascii?Q?5JHz6smgSJ97eS1lrNG8Pa4oLaSV4XyH2NdGMpRPEQk0iBDwH+ZDqrXG1SuX?=
 =?us-ascii?Q?ur5Uq0hVSGhiryp+qgQuhAwYgoXbgvkQlz1XWeX4Sqh1TOUlnYy8RfPIC0Th?=
 =?us-ascii?Q?xJ0JJI2177qevx1fbcMQV1MyD6oDhTu9nxT+SfuXXAttZQVFCTZ1UBjhFZpW?=
 =?us-ascii?Q?vynZme3LUTQQL+7hiPkypbxgBHvJ8vlTWT7lOhG/6LFC5jd5NfI3sB/zqQcj?=
 =?us-ascii?Q?XWCJcTkZKU7IyksvPK/pKmOzK+Udz1kxy+ka2eFuzb4zJaEnFkgU7AbMRwfJ?=
 =?us-ascii?Q?TBtSbiBqPH0q4YQFcEjQfW5y8xpUmjnBiUoJLJb7tdL7mGnPWjZYUvQAjNsJ?=
 =?us-ascii?Q?VS7rKXdXnTUsRj9xgwPD5ZSxvPpovdF2xPyzaIh3YN2nm/POC4uIQSj+GDxM?=
 =?us-ascii?Q?4GQw6EXjUOzLU+9K7AhNLmPXLy+AGvfo9+YVXwLM/+jZbFBgsBfslY/Qf36W?=
 =?us-ascii?Q?bHLEM0lw1XqNRDAzqaYN/EDwl6Te62WPvn5cZYgR5NvHYtl1s32uyzI/IaZ5?=
 =?us-ascii?Q?6jg5CzctBSKv8Yv/XpDLFR8uE1dMEdovPPQbUobFRu7y9pIeO3HqGy6pvCWA?=
 =?us-ascii?Q?Nfa+8tl0AlIjUG+LPbl3ELmkn6T+sKr+uEPZFyDC5DlX1YJN9cI6+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:12:52.4662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd765529-04c7-4e78-90f2-08dd12f48e50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6560

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
 drivers/cxl/core/memdev.c | 15 +++++++++++++--
 drivers/cxl/core/region.c |  3 ++-
 drivers/cxl/mem.c         | 25 +++++++++++++++++++------
 include/cxl/cxl.h         |  2 ++
 5 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 2a1f164db98e..f1c5b77cb6a0 100644
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
index b14193eae5fb..4bc946388384 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -547,9 +547,17 @@ static const struct device_type cxl_memdev_type = {
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
+
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);
 
@@ -660,7 +668,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
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
index 70d0a017e99c..2a34393e216d 100644
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
index a9fd5cd5a0d2..cb771bf196cd 100644
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


