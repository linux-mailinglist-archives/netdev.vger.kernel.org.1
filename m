Return-Path: <netdev+bounces-126218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0722C9700D2
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89CA41F22BBB
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFF3158219;
	Sat,  7 Sep 2024 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rFOAvihb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6782F14D444;
	Sat,  7 Sep 2024 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697185; cv=fail; b=capxwp5Uft+G2ogrv6ODjDOJJ5zwItIn79laPBRqPK8zhJGpHaC07wyXaDHqGepmaG9KN+1j830ijVf/c4BzmsDcvxwZFp3+APvIJ6Gb0Vmse6DmaT9CL3/48XWDq3pb4DQsW7/5vaJIAlvfdufqUuoqQH0RyJHaRuOGuCKjl/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697185; c=relaxed/simple;
	bh=XfAZFewFqEJ0wLZFwhsCxWEEaaT3i1R/PrFq5boor8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5MUKTuW8ruOrwb8Om8BP+Kh2LtvYr8oHjxYdLpojUEOvStMFIYNM1AdD/cnu+lNVekOWS3t2dEljhXqzsEXgNGe4B+h6yTZGp2WzDLgK+TjE2vu4mLNJzy18EMJJx4McCKFQ0WtwxhdIxx5dOEsdvs9tGTqcaDF2o08wJyZGf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rFOAvihb; arc=fail smtp.client-ip=40.107.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfCkPXHwDpG86PfvjW0cP4qCgvQ5yi4xLuG7UCIHElVlurQIADZQ6l5kWVKfTBy2oJUOn+9DnULtOwv1yHIPIxESzUQzKQV6Bb5FJb0k6h686P2ZSHVo6wrcAgqPvAUjiw0qvCOHW8N6orgbMzBMbtAy7BSxFc3SvInL1miZAoIdUDpoQ8itoNwY1etX8GEXy1ZcSnsl0kwtYRPqZNtqp5fp8WE15OPipSqBPRKQNHsvSuJtVrzZV7gjygRZRzCtxT5u7QBLkvJqQ3p7GjWvb87lWIfB5n/+HXlHyGDOracCSCU29WWqzV7ZYCs6e5JZ1rNYcpN2+o8WSVkv7JR84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4JHaADDa0IZNCi1R9QwUXLEo/yDw0n9egHV+GCXIG0=;
 b=WxzxecnhnnOqnRsUUJS/cDNeg3YIPhgWbnB8FpGWdq+weOoTVlAEV/xR0VBM9/2ST7xtmxjhbPc+p+n+db3bG2ZoLrsNn9+TG+xG02diK0uDSt73Snx8Bcbzt8LxwW/IE23Vx85BlK4TMKwkra2SEXrBSqmjD4aTPI5Ydm9areRReZ+YUpN2AulS/ILDbO7Kaw6lfNbH5j1GhzYTEYD/IGi10n7XNNtid3IKjYaDqvJ+R4oGrzF24XT8sLdQ8bEhUkuthW4WQaZrRK1uDdPJqJzYm7Qu4OA7VeyYqMPkxE3qrETKF4FrA0/GtEbzrsw/CIruZ9i6K/3OsJwILzbOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4JHaADDa0IZNCi1R9QwUXLEo/yDw0n9egHV+GCXIG0=;
 b=rFOAvihbg86+sW8qF1wDuy7xvKsBmgXl+LQB0LZ5gFMcpTaxaXyqAvhEouIeXmxXlazqb9LKOmQzrsA3hXvYOF2un6XHDnDO43nQVkAu0mreu5HP4+HEes5htwudXocRux6rup5Wws5n+RK/9+L9OTYF8q2m0W+HJdIX14H+cKQ=
Received: from BYAPR08CA0014.namprd08.prod.outlook.com (2603:10b6:a03:100::27)
 by PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Sat, 7 Sep
 2024 08:19:37 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:100:cafe::ef) by BYAPR08CA0014.outlook.office365.com
 (2603:10b6:a03:100::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:35 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:34 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 09/20] cxl: support type2 memdev creation
Date: Sat, 7 Sep 2024 09:18:25 +0100
Message-ID: <20240907081836.5801-10-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|PH7PR12MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e83f8f-65e1-4c95-c85a-08dccf15cfc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?laaDbPifZZGW+FMlVNRh/H/QComNz8QfvqUx7ZdN+svlM8Dmw8rNfi+sDMrK?=
 =?us-ascii?Q?9vwAO6I4dKvwI94wWNUcXpVObwODGAWbCk3vwSt/Abfi1JucbVElgbpdRpIz?=
 =?us-ascii?Q?BfVuCSfLnJqYFclGh5YixhDKbNIkXVlutJcXQXe/S8D3P4HBYvmsCDJV7uNj?=
 =?us-ascii?Q?yS1J49IEfykwUKuPnqgSGdt9NRBujKBfyZdhA6SNq8oYgs2Cy+ZjmmD2S2MF?=
 =?us-ascii?Q?IGozWSXrfM5yxbHkagvpOfnPfJtJVoq2ESfDJH9cwBnn9y9XzEz0yxLUdu2G?=
 =?us-ascii?Q?9uScrNb2us0zlyVwpjITa1sJDP/ERspxN1rdyh6gZqeRYnADE2+8S2cYvrOS?=
 =?us-ascii?Q?QiBjD/CTnqdmkjn6gzyfZ799aAk4p40+L/9gOAWAsVhSMHsYg6ORlEDqktSm?=
 =?us-ascii?Q?1O2oJwOjvri8FHu012kFqGJ6Uz4mVVKy6/jaV+ias1uokgoPM4DgMeHIVkaf?=
 =?us-ascii?Q?sPmiVidf9NDNbvq7NcNoqpL/vu5L9NoLLWMa893QDyzc+V1yybHugEirJjAg?=
 =?us-ascii?Q?szKQuyelpU6LKLc6fX4FUBSaQd0imamP/dgcvgCBS1kuHAHu58ADVLC/So8s?=
 =?us-ascii?Q?6QT5Us+WbWIA6GOnGRzYU1s3tz2z9HS7eaqVVkIwhvHYqnm5pt6bi8lmcRsz?=
 =?us-ascii?Q?iugu3lG5LKglqMLbVMKp45XOtf3M/SipJi8biz2aH/Jqjdm5xlpmmP9llpBH?=
 =?us-ascii?Q?qTf2pIWW4nzpF0SJc7soJ754nCKiy45K9IL8bsItFEGwaZv+NG9+Qri6EyCl?=
 =?us-ascii?Q?UtoHi2iGvSmaYU6i56vFHt1S2NQnYEl8CX40Z6eqLNetBEUJkt0ccLlfnzHD?=
 =?us-ascii?Q?7O04J6wSkfQdzJNwIz1ENdoL7O6FdCIqQmURAvx7JmJlN5qOwP60T/LMq9qN?=
 =?us-ascii?Q?rsqFrJgyO++LBLKZpXpIc0a947WDmZdVKRHj3IPA5uPms2rcQt5vya7i5DFg?=
 =?us-ascii?Q?xsd7JeQp202fV0nOYhhFvuPCypMfDFmcmWuk1euy44VURfpwRpLClG4AAhOL?=
 =?us-ascii?Q?VnAznGn8CKeecaRcZqUEq0kcRFXcRWoJhtZ0+5EKiMo/23FdjaQRCFdxsB64?=
 =?us-ascii?Q?+C8JC9+qiLMYqwqKuS7LCaGYh89WoHM1953NRVd5XgOjt6YyraRrXJqipr00?=
 =?us-ascii?Q?Q32kauWZZq/NcJhOnBgCt7uZmsK+bZm8i2au/107pJAntBQAIZK2SAdh/tfi?=
 =?us-ascii?Q?hYoZdXwcuulsLXCLItm28LC5BCmaYCjO8iEwFbFvPiUcIzRhvAI8zJMHw/Hj?=
 =?us-ascii?Q?3pfX3wbd+QiiLIQL5Wr3yLinSJlTUQBrWfp1V6l6G5Pmm+55Z+a51SaEMBQ2?=
 =?us-ascii?Q?MTXBqjkKUcAcpTmW+Ir7J4chZOolvzUXDtEBVLLijWMov1S4JpTbP6bK+V4O?=
 =?us-ascii?Q?kArN7d29SMxFTiEQmjOXM8ZipagCE5Z7S+hsL2sZbIe84AjfoJPzLbG3qozU?=
 =?us-ascii?Q?RA8fTjOTsScTcc19uGUjH9n2T3yEY7eK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:36.5354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e83f8f-65e1-4c95-c85a-08dccf15cfc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901

From: Alejandro Lucero <alucerop@amd.com>

Add memdev creation from sfc driver.

Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
creating a memdev leading to problems when obtaining cxl_memdev_state
references from a CXL_DEVTYPE_DEVMEM type. This last device type is
managed by a specific vendor driver and does not need same sysfs files
since not userspace intervention is expected. This patch checks for the
right device type in those functions using cxl_memdev_state.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/cdat.c            |  3 +++
 drivers/cxl/core/memdev.c          |  9 +++++++++
 drivers/cxl/mem.c                  | 17 +++++++++++------
 drivers/net/ethernet/sfc/efx_cxl.c |  7 +++++++
 include/linux/cxl/cxl.h            |  2 ++
 5 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index bb83867d9fec..0d4679c137d4 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -558,6 +558,9 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 	};
 	struct cxl_dpa_perf *perf;
 
+	if (!mds)
+		return;
+
 	switch (cxlr->mode) {
 	case CXL_DECODER_RAM:
 		perf = &mds->ram_perf;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 836faf09b328..5f8418620b70 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -468,6 +468,9 @@ static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	if (!mds)
+		return 0;
+
 	if (a == &dev_attr_ram_qos_class.attr)
 		if (mds->ram_perf.qos_class == CXL_QOS_CLASS_INVALID)
 			return 0;
@@ -487,6 +490,9 @@ static umode_t cxl_pmem_visible(struct kobject *kobj, struct attribute *a, int n
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	if (!mds)
+		return 0;
+
 	if (a == &dev_attr_pmem_qos_class.attr)
 		if (mds->pmem_perf.qos_class == CXL_QOS_CLASS_INVALID)
 			return 0;
@@ -507,6 +513,9 @@ static umode_t cxl_memdev_security_visible(struct kobject *kobj,
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	if (!mds)
+		return 0;
+
 	if (a == &dev_attr_security_sanitize.attr &&
 	    !test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
 		return 0;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 7de232eaeb17..5c7ad230bccb 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -131,12 +131,14 @@ static int cxl_mem_probe(struct device *dev)
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
 
-	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
-		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_inject_fops);
-	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
-		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_clear_fops);
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
@@ -222,6 +224,9 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	if (!mds)
+		return 0;
+
 	if (a == &dev_attr_trigger_poison_list.attr)
 		if (!test_bit(CXL_POISON_ENABLED_LIST,
 			      mds->poison.enabled_cmds))
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 14fab41fe10a..899bc823a212 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -83,6 +83,13 @@ int efx_cxl_init(struct efx_nic *efx)
 	 */
 	cxl_set_media_ready(cxl->cxlds);
 
+	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		rc = PTR_ERR(cxl->cxlmd);
+		goto err;
+	}
+
 	return 0;
 err:
 	kfree(cxl->cxlds);
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index 08723b2d75bc..fc0859f841dc 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
@@ -55,4 +55,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 void cxl_set_media_ready(struct cxl_dev_state *cxlds);
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


