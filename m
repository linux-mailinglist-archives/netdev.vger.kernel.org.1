Return-Path: <netdev+bounces-240132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7E7C70C8C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E54DB4E10FD
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338C42C235E;
	Wed, 19 Nov 2025 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="laAOGAwR"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012067.outbound.protection.outlook.com [40.93.195.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F3C31984C;
	Wed, 19 Nov 2025 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580182; cv=fail; b=ZNC4RPybp6FAvUe+PrTLk4MlemnjIOfg8IXibVy2TTZmsejm9nei3W339roksS+EuaDKbYAAB98qvZcnEB9uFTiKNc20L1W6RPKMU34xPXi1tTN2GeXwyyB0peTceO3fuREBN3hj7S7BkWREN1uoTZEhO49rwCwh06HI2AkykcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580182; c=relaxed/simple;
	bh=lzbI8gOamqH9vX8D01E5BQAJYhIPSPUNWv8pp0+8Vsc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAD1RkbYzqF9eQpiMsTONyebdd5brIXeytGPxgbzMeTxzkXu5QvTFU2gsi6KYBhOgKnogqBLrkRc74fLzv6ejtg/MFJhRfcx+OIx1friSbotYR+HEAqMTRnAh9WbE6M7+L8xKBuvSKMMvEG88y6ZbRvbbrMDgdHxIar8pXM04dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=laAOGAwR; arc=fail smtp.client-ip=40.93.195.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9Vxl2qB3rUoiHltugHbVGkAE9yZw6zzgb0++t1ms2XBD7hXOjs3hzqZMVXP0lQuevvQPPp/X22zucyhDc7Xm6lxPUycjZH0hOk13yRXREcY5SV/yJSpZ1Rc8lJaPv+8p4ULrtKP3Fep1d3Eve67WbvDjXwNKqZtzS4gNkHRvGLJNHKws7DDOn8PCr51saAlkKeWvAvcjcpk3BrK1leCMzyt4vEFDCbpQk99747Sozdu73bBqah9WFsvgAFtH5JBs4MDpCIYkpWtzeE3SdqvtNWk7mQw/kNlbzslrQqb1u2tXbF4XUFd+anjUmzIswC38LnYSS2W31KwStrCl7OCNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Kz4fzSGgQU3xdA/bBk4DtCz7VqytFjuBi2Q6SNiWEU=;
 b=JOKSwe4yVk3Pn18t4ax6vXVIDmSYEiYNs3V8jQPnd3XZailbyGs6EL58qxV+oaK7ImqVM5Kw7xJGQSoecaMmmmKNqgwqN1fDp7qhS5r0CCwGkBrysNpX8Gl4y58DusOMMmA17oYOb++hZpOLjRFvz8GU2CReojgr709HbjxzZkB+Qai8RLDjWfnUMgGgmSV/Y+7q5DmlxNPMgvfmX92C8U3MKcapJKgDJ93QfpnasmmT5dXevcxjKy3hbKgy1e/26QNY1YxODh+dJywZTLoFaUrA+T+mKTby8agTbCUsNQjRlhjqT8IxjtlQseBkqm1BRjvpvWBzYDV2koZqEN77+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Kz4fzSGgQU3xdA/bBk4DtCz7VqytFjuBi2Q6SNiWEU=;
 b=laAOGAwRQcB008sWDYRXrKtcdOF4ZBB9XeXE1f2RIew+fSBcrUuANT9+6bI+efodkPksw2VvQEVPzNQXJWXkoofVoehI9odSyl0jHUoXkJb1Hr0021g1DsRwKq6dXderNlB2MAd9ENJQ+MUIKvy9xo6mtJjEKOaUuk/SMwlcP6Y=
Received: from SJ0PR13CA0117.namprd13.prod.outlook.com (2603:10b6:a03:2c5::32)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 19 Nov
 2025 19:22:47 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::21) by SJ0PR13CA0117.outlook.office365.com
 (2603:10b6:a03:2c5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.4 via Frontend Transport; Wed,
 19 Nov 2025 19:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:22:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 19 Nov
 2025 11:22:46 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Nov
 2025 13:22:46 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:22:45 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v21 01/23] cxl/mem: refactor memdev allocation
Date: Wed, 19 Nov 2025 19:22:14 +0000
Message-ID: <20251119192236.2527305-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0ec196-fc3e-4b0a-d8e0-08de27a105bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mcozUP/KH6mTccDXuOdWgTkWLyt1eUCZsAI2kjZ6OHPg9AAaYZXaiCXdNcvz?=
 =?us-ascii?Q?MgndRND3wxe2mCoiX1wA2BUvhJX/+sSfBksfSw75Jr/NwDlH4w+bqEEmZFwQ?=
 =?us-ascii?Q?DuyAy1NogQ0FQ3AIRWzKQH2SovOEZsfPOyiTcltEH8eVFk7xIQiv7YEqMOLu?=
 =?us-ascii?Q?2lKPbY1EWBA9yS30d4SXzfjQKS+WPs18Tap0HiEkiMe7eVrA5p8eHXseMLvV?=
 =?us-ascii?Q?wN7ZNR5en4t/IbR77/e9pFzCckmVFeSq8Sj7kOEHe3enYQGME1PDjYkfbo2E?=
 =?us-ascii?Q?FLScUSQ0ktWoPKogS6xaLAJqLtMLUDOKqGTaDlpGz13KCZa8blOz4lj+iCNM?=
 =?us-ascii?Q?wL5QPdiL6PLvCndW3Zs+8oR0g8+YfhCzGT3wYvy4fp9DZ0pIJ48nPvTlWEl3?=
 =?us-ascii?Q?7FogybQgaPDO72tD2tzi6i6NEwydGnSExAirdPkftKHGzVpM0+KJaSS+HR5I?=
 =?us-ascii?Q?9Yddwk4vf6IbwycybWFzhdUHZiIu717y+5wDgJRyBxd5dNQnFCuasUJKo58p?=
 =?us-ascii?Q?UmjjB2IAXJ04geNlBxemx5sp+HchMfE2bmAK2zs8aIk0y6PDG4BIlFqnMDMt?=
 =?us-ascii?Q?2oXze4/kPYuGz8a1kwrt1lDeVJohqJVhD4GPnCtKgwJt4ULFEv6lrHm+vFin?=
 =?us-ascii?Q?llxsqb2DY34Nb49d0VfJdYaBvgJ5psPQ80X+iFGQL3G5T9X9W1dRiUCqPtPe?=
 =?us-ascii?Q?HQjtqFBM8ShWxQROAKmL7YD5nGDK/RmLD5ntrVndxELZc7y6LrEvtIoZSUcP?=
 =?us-ascii?Q?3YMVEHprDjwuNjwlejdvTpXwekx+SDdTCGI8Nnh8bL1DBO450NqVyh/yNJVH?=
 =?us-ascii?Q?rtxU/vFmYVZd+MvM0FpaRSrRUamQHY9FPg3+F0Tnnfz1BzwcKaP/xrArz8wy?=
 =?us-ascii?Q?Lf43UroEcYTplUS6YZfEtclmW3f/xdwD/FLOB9FPuWNVuVb/g9/ivGxJQTMS?=
 =?us-ascii?Q?Uk5PnB4GAsAa+vgmsMIHrwrRg0qwQoxUtpANvtPbHxkK5XCKsgn+CJyMfSoa?=
 =?us-ascii?Q?o8T7K5Dl5qVW0MUbxauFQHFpSLkrjK5FFktGbFtfmqUD3n0EGbg9tpp4P1NK?=
 =?us-ascii?Q?k+6P2dBVlD/2M46TrDmGIbVps0+HnLK3BM5bJPEKRWY3Mn8id6m1HSskV32m?=
 =?us-ascii?Q?mFftPFfAXe4O2lUlhAwqWHRaL5b+aUpl5NDifrFuZlgWxO6yrcn+kvxBUncD?=
 =?us-ascii?Q?def0+mpMrvu3AEF8QIUI5LLWLnsXp8t418CRIfpzz6x7IuP6V6RD+U4GJUNt?=
 =?us-ascii?Q?gpTiimqLhEPligExLzAfZGMI4aA4nwqvI6EHhTbSxaMtaDSlt8lUe2YhltJ3?=
 =?us-ascii?Q?SPK3euujZ29+v6ZrG8qmZH0pcNNKu2QzANGqE9kj7cWak2rjuKBGnuFPrDVf?=
 =?us-ascii?Q?U96pqyCzuKtDGrPnYTkYlaNho+AU8zd590xJ8jq2p938utpoCYTj7xFCAhK5?=
 =?us-ascii?Q?6nv+vbeeVFJBoFvNTaNE3hZvRJZ7PkECMy4MlV03OpOdTMFo+ZUWfRaoqu6k?=
 =?us-ascii?Q?MN5rq/Ac0MPZknkam0bRt4ioLWY9OxgYyTheIxNDHCy+/JTmReMG1ZDIu9mt?=
 =?us-ascii?Q?gjSmCYl/GcO/KzyHXIU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:22:47.1519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0ec196-fc3e-4b0a-d8e0-08de27a105bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412

From: Alejandro Lucero <alucerop@amd.com>

In preparation for always-synchronous memdev attach, refactor memdev
allocation and fix release bug in devm_cxl_add_memdev() when error after
a successful allocation.

The diff is busy as this moves cxl_memdev_alloc() down below the definition
of cxl_memdev_fops and introduces devm_cxl_memdev_add_or_reset() to
preclude needing to export more symbols from the cxl_core.

Fixes: 1c3333a28d45 ("cxl/mem: Do not rely on device_add() side effects for dev_set_name() failures")

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c | 134 +++++++++++++++++++++-----------------
 drivers/cxl/private.h     |  10 +++
 2 files changed, 86 insertions(+), 58 deletions(-)
 create mode 100644 drivers/cxl/private.h

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index e370d733e440..8de19807ac7b 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -8,6 +8,7 @@
 #include <linux/idr.h>
 #include <linux/pci.h>
 #include <cxlmem.h>
+#include "private.h"
 #include "trace.h"
 #include "core.h"
 
@@ -648,42 +649,25 @@ static void detach_memdev(struct work_struct *work)
 
 static struct lock_class_key cxl_memdev_key;
 
-static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
-					   const struct file_operations *fops)
+int devm_cxl_memdev_add_or_reset(struct device *host, struct cxl_memdev *cxlmd)
 {
-	struct cxl_memdev *cxlmd;
-	struct device *dev;
-	struct cdev *cdev;
+	struct device *dev = &cxlmd->dev;
+	struct cdev *cdev = &cxlmd->cdev;
 	int rc;
 
-	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
-	if (!cxlmd)
-		return ERR_PTR(-ENOMEM);
-
-	rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
-	if (rc < 0)
-		goto err;
-	cxlmd->id = rc;
-	cxlmd->depth = -1;
-
-	dev = &cxlmd->dev;
-	device_initialize(dev);
-	lockdep_set_class(&dev->mutex, &cxl_memdev_key);
-	dev->parent = cxlds->dev;
-	dev->bus = &cxl_bus_type;
-	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
-	dev->type = &cxl_memdev_type;
-	device_set_pm_not_required(dev);
-	INIT_WORK(&cxlmd->detach_work, detach_memdev);
-
-	cdev = &cxlmd->cdev;
-	cdev_init(cdev, fops);
-	return cxlmd;
+	rc = cdev_device_add(cdev, dev);
+	if (rc) {
+		/*
+		 * The cdev was briefly live, shutdown any ioctl operations that
+		 * saw that state.
+		 */
+		cxl_memdev_shutdown(dev);
+		return rc;
+	}
 
-err:
-	kfree(cxlmd);
-	return ERR_PTR(rc);
+	return devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_add_or_reset, "CXL");
 
 static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
 			       unsigned long arg)
@@ -1051,48 +1035,82 @@ static const struct file_operations cxl_memdev_fops = {
 	.llseek = noop_llseek,
 };
 
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds)
+struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
 {
-	struct cxl_memdev *cxlmd;
+	struct cxl_memdev *cxlmd __free(kfree) =
+		kzalloc(sizeof(*cxlmd), GFP_KERNEL);
 	struct device *dev;
 	struct cdev *cdev;
 	int rc;
 
-	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
-	if (IS_ERR(cxlmd))
-		return cxlmd;
-
-	dev = &cxlmd->dev;
-	rc = dev_set_name(dev, "mem%d", cxlmd->id);
-	if (rc)
-		goto err;
+	if (!cxlmd)
+		return ERR_PTR(-ENOMEM);
 
-	/*
-	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
-	 * needed as this is ordered with cdev_add() publishing the device.
-	 */
+	rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
+	if (rc < 0)
+		return ERR_PTR(rc);
+	cxlmd->id = rc;
+	cxlmd->depth = -1;
 	cxlmd->cxlds = cxlds;
 	cxlds->cxlmd = cxlmd;
 
+	dev = &cxlmd->dev;
+	device_initialize(dev);
+	lockdep_set_class(&dev->mutex, &cxl_memdev_key);
+	dev->parent = cxlds->dev;
+	dev->bus = &cxl_bus_type;
+	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
+	dev->type = &cxl_memdev_type;
+	device_set_pm_not_required(dev);
+	INIT_WORK(&cxlmd->detach_work, detach_memdev);
+
 	cdev = &cxlmd->cdev;
-	rc = cdev_device_add(cdev, dev);
+	cdev_init(cdev, &cxl_memdev_fops);
+	return_ptr(cxlmd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_memdev_alloc, "CXL");
+
+static void __cxlmd_free(struct cxl_memdev *cxlmd)
+{
+	if (IS_ERR(cxlmd))
+		return;
+
+	if (cxlmd->cxlds)
+		cxlmd->cxlds->cxlmd = NULL;
+
+	put_device(&cxlmd->dev);
+	kfree(cxlmd);
+}
+
+DEFINE_FREE(cxlmd_free, struct cxl_memdev *, __cxlmd_free(_T))
+
+/**
+ * devm_cxl_add_memdev - Add a CXL memory device
+ * @host: devres alloc/release context and parent for the memdev
+ * @cxlds: CXL device state to associate with the memdev
+ *
+ * Upon return the device will have had a chance to attach to the
+ * cxl_mem driver, but may fail if the CXL topology is not ready
+ * (hardware CXL link down, or software platform CXL root not attached)
+ */
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlds)
+{
+	struct cxl_memdev *cxlmd __free(cxlmd_free) = cxl_memdev_alloc(cxlds);
+	int rc;
+
+	if (IS_ERR(cxlmd))
+		return cxlmd;
+
+	rc = dev_set_name(&cxlmd->dev, "mem%d", cxlmd->id);
 	if (rc)
-		goto err;
+		return ERR_PTR(rc);
 
-	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
+	rc = devm_cxl_memdev_add_or_reset(host, cxlmd);
 	if (rc)
 		return ERR_PTR(rc);
-	return cxlmd;
 
-err:
-	/*
-	 * The cdev was briefly live, shutdown any ioctl operations that
-	 * saw that state.
-	 */
-	cxl_memdev_shutdown(dev);
-	put_device(dev);
-	return ERR_PTR(rc);
+	return no_free_ptr(cxlmd);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
 
diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
new file mode 100644
index 000000000000..50c2ac57afb5
--- /dev/null
+++ b/drivers/cxl/private.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2025 Intel Corporation. */
+
+/* Private interfaces betwen common drivers ("cxl_mem") and the cxl_core */
+
+#ifndef __CXL_PRIVATE_H__
+#define __CXL_PRIVATE_H__
+struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds);
+int devm_cxl_memdev_add_or_reset(struct device *host, struct cxl_memdev *cxlmd);
+#endif /* __CXL_PRIVATE_H__ */
-- 
2.34.1


