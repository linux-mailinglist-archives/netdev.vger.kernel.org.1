Return-Path: <netdev+bounces-152300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEE59F3591
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FBA165C41
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D79207E07;
	Mon, 16 Dec 2024 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z2XtOZoy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1701C4A3D;
	Mon, 16 Dec 2024 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365493; cv=fail; b=oiAo8WiOo9rRjEfwOGbvvNOhGmEmK4arxsan+jtz+yvEUt3zhqBaLRUiL/pmI/KS9ao/CgtEQat2WFb8KTq94gJkf+LZTrO1zeoksC9WA4vFlMI2bQ9iHf3djeqREsByCxey/WUFDKPUP+gNoSyWGwFL8iD2S+8nJbVI4IfvAng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365493; c=relaxed/simple;
	bh=WlJxHq0go/pqi6J0XbLxot7aYu0coHzYZrgo4ITXcU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EhNSGOVFprAvgKK9vPjZL7gBuPHosFBoey5npT3lTeXaDgco96ityEN4MOvDraTNPrLmW8CrIA/mgrzuK0fTeqFX+Fg0Tyo7TjZxfdEtG4Qxhl5H2a8uPrUE7WqbW9T3X/37Y4a9f+0dXVr6HyzqyCjdymC5G0CcGP6nwLy+9NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z2XtOZoy; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpBz84JyHpWxwU3RYxSlDiXeUp636be2U27nlRCl/Hd3Pl1oXr664FnkuFUJ3Zsg8vBI18FaFZxYoNmyFL01XrLfPxeQ1ctsu67Wp1czgiv0m7bVV/egYWC0pAcbu5I4fozAGTuAyYyMSM0hG1j0EnJjaXs5IdaXOHFWVf568DS/nJgmGGXvJEc/JhF983EEzgYRmfUb0wX5QBaRGCBkIFAUjscSSECCNkwW+VBL375wuKciBp/ehLYwrbvPdFCINhie6Xw+wgRfik1kAjV/7uVAL7pG1GgpS7PztTyB6262S1/7KpqR6RBzWxqmdB0D4SLE2PEZXIMfuu8FU5fYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNpDW+CeRhKcKL4geKPCVo9LYDVSoOGO/DDAmoOELJM=;
 b=KUfJG5K032JJEclcCa9ktOJaqlbWwqyBs2eAnvmArxyFozTiiqQVTR3dsKTfV8PbmbkjCGzxokUxqVIvHdM/pAh5pi04uSBSFWlP7xvw5TjrpL+/4TDjmLg+lC5TXFS+CjQbK9KqdgnHTl6zqYaOc8XFiY9ozTZx/NJNXfhhygxZ1J9MvSt2r0E7X1ZoZOYVWtQz0H2bXqr0gW+JyGHFsMueIqYgYoqUBmOFC6hHSvjMJw2pdx4rRYRPtbLHB38K9Yq0G9csYWrKbqK1lsN21SmbopLqrjwb/Z9+WVgRaSqE9h16UNRvaKe7ARbn4x5TivO5/m2DlxfpNy2G4NW3gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNpDW+CeRhKcKL4geKPCVo9LYDVSoOGO/DDAmoOELJM=;
 b=Z2XtOZoyRjBIDwVmJZ28kRa+vdtDsgJLRazbP8mJxvEyQM8IPI9zQHEz76Y/l55aOP8z1GvH7wZPII5xNrlqYZYJnqttMF2lTqMgtmh31DYWjHu2hZxJQEOyGgnBXcTBMMsBxJriJxtmvCQo7fBZHu1gNvB42W3uyXYZ8W6QXtc=
Received: from CH0PR04CA0046.namprd04.prod.outlook.com (2603:10b6:610:77::21)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:11:24 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::43) by CH0PR04CA0046.outlook.office365.com
 (2603:10b6:610:77::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 16:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:23 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:22 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 22/27] cxl: allow region creation by type2 drivers
Date: Mon, 16 Dec 2024 16:10:37 +0000
Message-ID: <20241216161042.42108-23-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 7344236c-b3cc-449c-6dd3-08dd1dec49f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?odmjmaw6C77y4yOqKUDlsrqaGBEGek4T975ijHp2n7qO/fvQecSvNVjNwXss?=
 =?us-ascii?Q?FJ3pXNk/xbkwP67gKtu87/hbDcyecknTXQDxPHWSyKdFBzaOokdzEsJx9s7s?=
 =?us-ascii?Q?sLmGJ9DDrQTOiUADrsZNHmgXlZ6M4TDvX4eE+IByOJhbM43ebWObaC+kTJkL?=
 =?us-ascii?Q?JFMumAoLilIjfnam1uAN9RwHZJmlJ17BiuDK5iANFwYmLaf9jiWeICzC9qdR?=
 =?us-ascii?Q?/OlYt78tchxFrJcTYmwmXd7CkgGfI75z8Lk5skbjNPkAp0OpDI8bQGHK+wWY?=
 =?us-ascii?Q?tNLGlXVksQxx4IZT3jqk25SAzriP3fSGmqYS0TDDt9OJFdf2lt+fMzO2iuQU?=
 =?us-ascii?Q?GU1S1e9NvrAR3MIt58GGPS3mH1QSrqvMg65iBS/lbXNBgzuzp5DrCForZltB?=
 =?us-ascii?Q?q/tctDn/uSxG3nHT5zpSa7bHsQIfN7qm6afooc7VioXVAc4tb0aAMRi6aVwj?=
 =?us-ascii?Q?fM4u46gwyKAR2KBMxViHFMnvsImNcWNrEKvrNUToubYvTemjgfJmCHdjb5PY?=
 =?us-ascii?Q?KWBbaOMeP4LlRJvdpE1DrhsmVcJocP8Q4CRptlqpVLhoD40ptlsiP3elFE20?=
 =?us-ascii?Q?/sWKbxurCqK8FoQ2mFJlgPWF/DJqGdOu+e4YwMhpSwgZqhemPZ89ash15brx?=
 =?us-ascii?Q?ubE3Iw1/WVgsV7k64t+OGS+18h9+qmqhtU4aZj6/LtjWqVJ8phvocOInw3G6?=
 =?us-ascii?Q?ib4M4z0YSKXSXbHWePp74qIUppKD/8M2xYRW1NZAc0eQk2kSsjT9iFOTCK9O?=
 =?us-ascii?Q?pAT6CYdjyJV+1TbU/ev60OF3OBe1MBzQyPWO5oL6EY56OvvqAknjNFvdha0/?=
 =?us-ascii?Q?hqo0sFasS+hmHcA2tt9iWgCX6f1tAKoQiivCnJ2Eik5WhTdt8U+Y8GNE0ARH?=
 =?us-ascii?Q?8WwTyFIs9AsQQNUfLsDU3DaaIN7l1xgkLt0s55zL2mkmEbiD7JmoEMZgB9IK?=
 =?us-ascii?Q?eIiMdCes1XYKpil58F8HbnSh+4Zb6ZzGCB8oivDbkrmIjfpItD57BHyHVA+0?=
 =?us-ascii?Q?VCdwznojgGAfhv6+uomIAjfpaALAnHkrjkCS2xeQs8mFXupEEoYCK14RcSbn?=
 =?us-ascii?Q?vPYDMqu6NCsUZwSGC6iSIZI1n8xGmU+jUxOYhrN3ufEdXPn3pTFmhQZnL8uF?=
 =?us-ascii?Q?oXYtvvI0UTtuGFpvrI96D4UG4ABNGLdRsluhmQVGVOGKDLBOlxk4fpbwRn4d?=
 =?us-ascii?Q?papNx2OEz+OLsodwY03kDLtUmCOGS/7gh/UyPrbT1BxOiSyuUw93XubSh//I?=
 =?us-ascii?Q?DxEH8VTArJ9NenyRQtFHoHl3xcLCJlSaRNJS48/yXUz7OvEKqgANOkRcQuC+?=
 =?us-ascii?Q?6fNvkXj4kfaJLzn6EEotWg5MEA941bsyZHFHx7OD2APct1Ii7i/domd4+CbJ?=
 =?us-ascii?Q?YzzDTxiK+zyOwe7LdtRQSY8Osw36G7ktlAXwvzZUkJ/CLoEEL1LUU1Pjn3pd?=
 =?us-ascii?Q?nqkdDgxbTDro48u9rYV4vNRMalgCyCZ6B9xoDc+cAeL6bnj9ewqaWQdYi/7i?=
 =?us-ascii?Q?9owvOTQBH2dqVFJlyVfySo14aWdD8Z7LmS8V?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:24.5587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7344236c-b3cc-449c-6dd3-08dd1dec49f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders.

Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/cxl/core/region.c | 148 +++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxlmem.h      |   2 +
 drivers/cxl/port.c        |   5 +-
 include/cxl/cxl.h         |   4 ++
 4 files changed, 142 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3d9bc7d7c0c4..a24d8678e8dc 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2269,6 +2269,18 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 	return rc;
 }
 
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
+{
+	int rc;
+
+	down_write(&cxl_region_rwsem);
+	cxled->mode = CXL_DECODER_DEAD;
+	rc = cxl_region_detach(cxled);
+	up_write(&cxl_region_rwsem);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, "CXL");
+
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 {
 	down_write(&cxl_region_rwsem);
@@ -2775,6 +2787,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
 	return to_cxl_region(region_dev);
 }
 
+static void drop_region(struct cxl_region *cxlr)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+
+	devm_release_action(port->uport_dev, unregister_region, cxlr);
+}
+
 static ssize_t delete_region_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t len)
@@ -3381,17 +3401,18 @@ static int match_region_by_range(struct device *dev, void *data)
 	return rc;
 }
 
-/* Establish an empty region covering the given HPA range */
-static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+static void construct_region_end(void)
+{
+	up_write(&cxl_region_rwsem);
+}
+
+static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
+						 struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxlrd_to_port(cxlrd);
-	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
-	struct resource *res;
-	int rc;
+	int err;
 
 	do {
 		cxlr = __create_region(cxlrd, cxled->mode,
@@ -3400,8 +3421,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s failed assign region: %ld\n",
+		dev_err(cxlmd->dev.parent, "%s:%s: %s failed assign region: %ld\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__, PTR_ERR(cxlr));
 		return cxlr;
@@ -3411,13 +3431,33 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	p = &cxlr->params;
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s autodiscovery interrupted\n",
+			"%s:%s: %s region setup interrupted\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__);
-		rc = -EBUSY;
-		goto err;
+		err = -EBUSY;
+		construct_region_end();
+		drop_region(cxlr);
+		return ERR_PTR(err);
 	}
 
+	return cxlr;
+}
+
+/* Establish an empty region covering the given HPA range */
+static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
+					   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct range *hpa = &cxled->cxld.hpa_range;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	struct resource *res;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
 
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
@@ -3440,6 +3480,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 			 __func__, dev_name(&cxlr->dev));
 	}
 
+	p = &cxlr->params;
 	p->res = res;
 	p->interleave_ways = cxled->cxld.interleave_ways;
 	p->interleave_granularity = cxled->cxld.interleave_granularity;
@@ -3456,16 +3497,91 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	/* ...to match put_device() in cxl_add_to_region() */
 	get_device(&cxlr->dev);
-	up_write(&cxl_region_rwsem);
-
+	construct_region_end();
 	return cxlr;
 
 err:
-	up_write(&cxl_region_rwsem);
-	devm_release_action(port->uport_dev, unregister_region, cxlr);
+	construct_region_end();
+	drop_region(cxlr);
 	return ERR_PTR(rc);
 }
 
+static struct cxl_region *
+__construct_new_region(struct cxl_root_decoder *cxlrd,
+		       struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	rc = set_interleave_ways(cxlr, 1);
+	if (rc)
+		goto err;
+
+	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
+	if (rc)
+		goto err;
+
+	rc = alloc_hpa(cxlr, resource_size(cxled->dpa_res));
+	if (rc)
+		goto err;
+
+	down_read(&cxl_dpa_rwsem);
+	rc = cxl_region_attach(cxlr, cxled, 0);
+	up_read(&cxl_dpa_rwsem);
+
+	if (rc)
+		goto err;
+
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc)
+		goto err;
+
+	p = &cxlr->params;
+	p->state = CXL_CONFIG_COMMIT;
+
+	construct_region_end();
+	return cxlr;
+err:
+	construct_region_end();
+	drop_region(cxlr);
+	return ERR_PTR(rc);
+}
+
+/**
+ * cxl_create_region - Establish a region given an endpoint decoder
+ * @cxlrd: root decoder to allocate HPA
+ * @cxled: endpoint decoder with reserved DPA capacity
+ *
+ * Returns a fully formed region in the commit state and attached to the
+ * cxl_region driver.
+ */
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_region *cxlr;
+
+	mutex_lock(&cxlrd->range_lock);
+	cxlr = __construct_new_region(cxlrd, cxled);
+	mutex_unlock(&cxlrd->range_lock);
+
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	if (device_attach(&cxlr->dev) <= 0) {
+		dev_err(&cxlr->dev, "failed to create region\n");
+		drop_region(cxlr);
+		return ERR_PTR(-ENODEV);
+	}
+	return cxlr;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
+
 int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 4c1c53c29544..9d874f1cb3bf 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -874,4 +874,6 @@ struct cxl_hdm {
 struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled);
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 4c83f6a22e58..4bb89b81223c 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -33,6 +33,7 @@ static void schedule_detach(void *cxlmd)
 static int discover_region(struct device *dev, void *root)
 {
 	struct cxl_endpoint_decoder *cxled;
+	struct cxl_memdev *cxlmd;
 	int rc;
 
 	if (!is_endpoint_decoder(dev))
@@ -42,7 +43,9 @@ static int discover_region(struct device *dev, void *root)
 	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
 		return 0;
 
-	if (cxled->state != CXL_DECODER_STATE_AUTO)
+	cxlmd = cxled_to_memdev(cxled);
+	if (cxled->state != CXL_DECODER_STATE_AUTO ||
+	    cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
 		return 0;
 
 	/*
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index c450dc09a2c6..e0ea5b801a2e 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -60,4 +60,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     resource_size_t min,
 					     resource_size_t max);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled);
+
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif
-- 
2.17.1


