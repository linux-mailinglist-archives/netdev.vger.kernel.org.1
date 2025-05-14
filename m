Return-Path: <netdev+bounces-190434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 093D8AB6CB1
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC803AA23E
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F4427FB37;
	Wed, 14 May 2025 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mgr+zjy6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E025B27A92C;
	Wed, 14 May 2025 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229311; cv=fail; b=BIH+ZeFI4hLvHpw06JQ6GePztublhdJpgfHmy41nuUeh/tC25OzRum2SZ+DR7eOavaEuijEWMaPjgk+5glzMFx87y21pa77ESmflqAtNd0C7j2MrQP8uXRm5kiiY548wVHAGyn7Rd2XoQbGmo0CsA1ImdwkQX/Ph56LsK+imUJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229311; c=relaxed/simple;
	bh=fc90rmoHzjHle0bxfQ2zZdRxkth/vpyZ3VA/4+cQao0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRB6uiXS9nBBrDwm2m4CxW2KCkIN6uOHLcbzMgwacuIzGo5s09UbTytW+u2CqtQo3JEOiItowKVo2xu/lMiH9HCFG4p5QbjJ0e2tQK2BwN2s9RTzXDX6vNrUSLKK8tNnCdGHS1y0PDzo/M4SUPYoLELRJ+jedPSzwUdAzVmlANI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mgr+zjy6; arc=fail smtp.client-ip=40.107.212.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idp0BENc3nk+Kcj1EPV7MD6314IMkKusa2icsTV2Flwn/KILLsheKcWlQnFXXzSndZWocCtJvcs84+hu1h35iz4sB6hkjzrm/rIL1Hu2Du1RTaIDqRWY/L/mcoz0Nyuk1tjjQZsdoDPWIttm22AV7Ad86W62bVDbpK4iDPnePgOs7jEVTEmYgSoQX+clHafxLrCXWXd+iuGt48LKYWsFSh5VvlOIxFFOU++UMDgUb/MwImvK5RhIEJ4YUt8jyhkkwLRRVkw5PDHJo8tsDOEb9UBAfzyQQP3UQ6an4Cb9kTsE4mFHblyHKUwNnfQpLtRA42Mz2OulpSk34blEh4ZqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nktpvIBgo5niHIJoyhQ7ydlhvfQQwb4GRza+5VReGXI=;
 b=ti/UNk1oW/GPr99BSeaz/JxA5cvFZQmPn8072ZZLROx0SqEaoRGlzpzfku8xIZHgRLSiHUf1gHwgUZnfMXpGF4YXKhHZPlsRG03+WO+Emr11Lnqyw960OGnwhbBBw2gX5gHC3AX75p7P47bQhv6WsscPSzlGt8CZhzjzKGcoQ/DvCL2FlxYlpNEqoBeZzqGaoLodOixZOsKCm2e7AmZND68PS0AeI7zIl6mm7R/S3dYOijCgoOJt9qZd+lKq9noeHwrCAzNNHKgW9eppTbVukWyWpS/Jgg8AujjswMsqTyk9aPCNBhWpFWGwrymSPMpGK2JiuqWZJFCv7hIA1K2nUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nktpvIBgo5niHIJoyhQ7ydlhvfQQwb4GRza+5VReGXI=;
 b=mgr+zjy6RsGpnwC+yY9ynfv1cxiJtboXhlqLiC4gE6q7RCq1RyZSE7yifeWmuPjpq86GRuhVO5RHHBxw90YFZ4iv6KkRtLUXJ69LmCqWRjixWJiBQ2sH3E+wvfl5LPG2fSJrSjERgZgI8/ru8rjrqN6YzK8sxe/xpD+C+vvpMEI=
Received: from BN9PR03CA0151.namprd03.prod.outlook.com (2603:10b6:408:f4::6)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 14 May
 2025 13:28:25 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::bd) by BN9PR03CA0151.outlook.office365.com
 (2603:10b6:408:f4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Wed,
 14 May 2025 13:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:28:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:24 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:28:23 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v16 19/22] cxl: Add region flag for precluding a device memory to be used for dax
Date: Wed, 14 May 2025 14:27:40 +0100
Message-ID: <20250514132743.523469-20-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: a0476f4c-8ae7-4bbe-7a10-08dd92eb345e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y5vfsFAICO58ZwyZN/SZ/ZSyuId8KXGQeeNXmYYg7Ua82jqpAydxp3P0hEIh?=
 =?us-ascii?Q?iWPzZaqObMQ3xpctpJC5CcGvfz3h1EUyU7/YLr9ex6SbEHaCwJEtASFAjXx2?=
 =?us-ascii?Q?8Jcbu9CivnwLZf033EGDh7z+rlL6wv3xfSQpeOYCdY4mTB7YuojCTKh9q3F2?=
 =?us-ascii?Q?Tm9uYuAM4pUNP1Ww6rPPCSLLrqw80vXHAHTf2CJpJcQJ31oYjR/sAK2nY5nL?=
 =?us-ascii?Q?8kZeYs9x+Sj0IwU5EBx3MgnPsw0O57df60MDnA7AsBoyR6dmC8YaVe9Q8WUK?=
 =?us-ascii?Q?zIwxbn01RRxYDgMyz7VIyzZua0O+RD41kcCOaDfOFjsNSiC8YmSZR5j9plVq?=
 =?us-ascii?Q?tbVg4539zaeB80gmD4NhV254So1dA1zibpe8pwKNZ1tSzSif3RgZt8cIGNbG?=
 =?us-ascii?Q?AmR+4b7CXeN4tNU+PMuuKl072jBwJ/nUHBunWsKn1yNaN/qI9tYpKtxkiij7?=
 =?us-ascii?Q?Fjmg7K3YOX9/Hh8/HWj6TfreVu8XUeVPHjGygRgq1CYLJGN++2NPxLI+Yak5?=
 =?us-ascii?Q?hcy8kuQzYo5hzlcRQMBQayaWTvit3RGwBGBM/m6VP/rO9kaoBBPj4xmd9VIy?=
 =?us-ascii?Q?d4+g3ddpFZcYHH7AVwvQioifaW93j/JFG9tVuZPLV5yoGYfxCljvV8yPq441?=
 =?us-ascii?Q?EwDILaTVdsS8moHAkluBUYONDpGJua5Ax5OQci83T6uh69O+1vwa8w3I5odv?=
 =?us-ascii?Q?ElY672NNRm2mILKldFescuL2ARZ73HYMecaZgPT0I04HH63hy2qAobuN8PjS?=
 =?us-ascii?Q?sYK6l2yRhk18e1mb2UVoC1qTal/ppSDaufXybbUsZCpbrOsMuVfP8fyzmMMH?=
 =?us-ascii?Q?zZSdBUsDr48DyjQZEKhkPDzJrJV6fAUQJ3Ltdgy5zvIQigaQ3RJ32wId/Hul?=
 =?us-ascii?Q?dMOFzc/z6GH1hqWhwKEu089GvI36xZvkOcz3UHuYtMT4vXb4s8orML+LFAF0?=
 =?us-ascii?Q?od/srL2BRVpm/hsom4sdVDq7PVH+6OV5qXVrvkzboVj46NITS0+rMLUdP/g1?=
 =?us-ascii?Q?wg5wWcXCJoZAxmLzbzDyKRaazlw4oLm4kp97vHxOssOgLc4XEf4+Yy8ehVjy?=
 =?us-ascii?Q?3UNYA/md3Dp1f74shc9E4shS0DKwa+UXF0O36tkOYaADes1Tn0E6XIH1GH5g?=
 =?us-ascii?Q?H2S3ezfHbrtMBU5bKIIVi4xlDet0z5zXcYsv8Uio1Z6uwtRwk9rzBJA91b2I?=
 =?us-ascii?Q?BISVWxV3v/ZFDLxxjyobhJCn0HvEHvqRYHY1FmUULBKwR12kjbIHTkV0HlDs?=
 =?us-ascii?Q?9AY3JSdKaAW6A2vqEtT6+97yxTpdF9OFHTQoLmQ76jAZtu0jlRRqf3nSVHrA?=
 =?us-ascii?Q?SlM/9TvExvYRFGLkA2dbnA5B9MESH7vZ1IyzWsnoCl6SlqHopMfXZGis+WiX?=
 =?us-ascii?Q?Hrci39r+BSFZGiNI2Hd6+Zyg3UZKZm2CbVt9XT0M3kGL9I2r2mz7ezewuN6e?=
 =?us-ascii?Q?pRfemDY5cv8cQ/4GhdmeKb/STUR1+ITcK7Wat/2jyLXX7QkaG50Q1VTeJWVK?=
 =?us-ascii?Q?ub+O4+KyqmGOuSblqmFkS7jKp8heksFQVrup?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:28:24.9623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0476f4c-8ae7-4bbe-7a10-08dd92eb345e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses. However, a dax interface could be just good enough in some cases.

Add a flag to a cxl region for specifically state to not create a dax
device. Allow a Type2 driver to set that flag at region creation time.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 10 +++++++++-
 drivers/cxl/cxl.h         |  3 +++
 include/cxl/cxl.h         |  3 ++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f82da914d125..06647bae210f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3658,12 +3658,14 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
  * @cxlrd: root decoder to allocate HPA
  * @cxled: endpoint decoder with reserved DPA capacity
  * @ways: interleave ways required
+ * @no_dax: if true no DAX device should be created
  *
  * Returns a fully formed region in the commit state and attached to the
  * cxl_region driver.
  */
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled, int ways)
+				     struct cxl_endpoint_decoder *cxled, int ways,
+				     bool no_dax)
 {
 	struct cxl_region *cxlr;
 
@@ -3679,6 +3681,9 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-ENODEV);
 	}
 
+	if (no_dax)
+		set_bit(CXL_REGION_F_NO_DAX, &cxlr->flags);
+
 	return cxlr;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
@@ -3842,6 +3847,9 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	if (test_bit(CXL_REGION_F_NO_DAX, &cxlr->flags))
+		return 0;
+
 	switch (cxlr->mode) {
 	case CXL_PARTMODE_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6fc6fd7b571d..8c418d62b0e4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -405,6 +405,9 @@ struct cxl_region_params {
  */
 #define CXL_REGION_F_NEEDS_RESET 1
 
+/* Allow Type2 drivers to specify if a dax region should not be created. */
+#define CXL_REGION_F_NO_DAX 2
+
 /**
  * struct cxl_region - CXL region
  * @dev: This region's device
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index d9cd10537fb1..867dd33adaff 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -283,7 +283,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     resource_size_t alloc);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled, int ways);
+				     struct cxl_endpoint_decoder *cxled, int ways,
+				     bool no_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


