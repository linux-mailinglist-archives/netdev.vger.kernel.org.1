Return-Path: <netdev+bounces-237249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D8BC47B63
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC708422109
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF6431CA7E;
	Mon, 10 Nov 2025 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hK1ig/ak"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012003.outbound.protection.outlook.com [40.107.200.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D843176E6;
	Mon, 10 Nov 2025 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789073; cv=fail; b=EwLqXACXgZaQ95sXppslchyj3uR8RVs8zDiqMvwQJ7scNOTKFzcg8B2rCDsap+/P1m58ehG150gxPKjMgGXVPyrW2qqUcKqfGseDJFTWUlRpgWMAzUtx7n5FOdk3wnWGXumkAFTqJ1gOrFMtQv2kKuJR6aXqgtAr/61v+LGintw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789073; c=relaxed/simple;
	bh=BSjAQNxanX6A0EOId5sL1DiDITwNYvTK7+YGLhvjKgQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9ZltBMo4H0z84KapOa0PsBhRN8vgGOwe/9zdXbKlHMdtxcgEwrzNKWN9uTjQYuUMf6Tk/PQM2wosTMLB4Vxa9Ce/9jA4G1h72ef/M4YMjXUCOVEm/3izOdV+5HCXSpCNM5u0RjhS69QdCJV512D3AX0h7a5+uax8J4ik8997pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hK1ig/ak; arc=fail smtp.client-ip=40.107.200.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqo7JJaQ4oIeWv7YDWIepDxPLjwlzh/qVXkt2phtT5hVfm0joytZPexjN/jsZBmU76FKxuod5ZFTp0eK7/r+tFqmYEyCRcH51VNGjTn3rHlUghu7Dlndm7F8un0ySygHpxv0bGYK/G82o0ZzgBRdFT9PeCFPu4qLALIJsVndzDaIEftmEYmBslEJyyt/6xDQzWvSOb2UHq5rb5LfWs3xeq4G7IcWWEuVJr54Z8Eukc3wTdFoOgEzEvpt12sXlndbpT1iX8IObzqdUyhnT9U22OppX848aXvVDgWtNcIep/dTxu2qxgd2fZsLnfdEreHUDV2BRGaSikjAyNdDkJXkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pdIM2rqFiHAOWnvUPgIkem8gM0DDYwOrNkICZ7YmZ8=;
 b=F65gbzDi/4StyLYfsFcIhd0Biv6pQgarbZSZNYqGyXNLMEmMmbIv/BsiVDEUZRx5SgZek4oG8u2/+GSE1q05f91Aeerx7PQNKj5oBqfaV/UJxGH6W/Oonryw0XUwnl0mg3QFIGfXmQ8gvddhKZ9kjTl+jds1D5UuQzmhBa2CsZZ6G2Ur53B3m7N5rp32MNA6Bw+FIQ5NbomCgH86iOOl4xbzy7TkdYVWVLarkK96pg8KksH7z8Cu5PtOJdKi5y5ncNVl+APOx1Gq1Bf5RKDEgJrlllLxwq00MvHSoHHMLmiY5brcGsxH3aczKiZUCvNizVzlobAgdP4XDG36/wavvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pdIM2rqFiHAOWnvUPgIkem8gM0DDYwOrNkICZ7YmZ8=;
 b=hK1ig/akON0FBLrAX3U5VqxH4zuzDBQ8dBS+0IllCPAdj6dxGkxvSmBBEAMgjYPzgYGf1mb6bmEK+GnXYRPeX6biheP5wkuP6FZs/8YWHIsM4ulik953n20cIaB4Vm/y0yC5W5xrlbUq3GKAlhT+XigZ0PyljHkMHYigsfwPUk0=
Received: from PH8P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::29)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:37:42 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::ee) by PH8P220CA0023.outlook.office365.com
 (2603:10b6:510:345::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:31 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Nov
 2025 09:37:31 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:29 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v20 16/22] cxl/region: Factor out interleave ways setup
Date: Mon, 10 Nov 2025 15:36:51 +0000
Message-ID: <20251110153657.2706192-17-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 289b654b-bc2d-4781-90e0-08de206f1640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7jE6HbSE6ZO8RYEXc6kvgGi3ud8ZMUTsrvN8HkDrrWl9+4H2KQS9H1+K4ipp?=
 =?us-ascii?Q?S2F/RMejdduypOh6kVIcn9u53BbHFVUCiec7v4yvcqGhgpE4p+rhd2vwKC4x?=
 =?us-ascii?Q?+OyS1Ecglz17aNU2qaz/9SFHM0bvvgUNcUH0we9s7/YHabQFoKkWSrawPzpO?=
 =?us-ascii?Q?WVsYKhunMjcSL9ZiSa76eZAzH+NibBhKBpOpfWrrMSW6CoGcg8u2Y7aTBPA+?=
 =?us-ascii?Q?7qfDU8L+NoRFLqqabHizwBPNHWetTKONDtSpD0cF1dU0YChBy3PJZUhpVuEc?=
 =?us-ascii?Q?J/XuvkCjgxamHpGuAIiYUkrQ7Nd0PwCcB5+3K6IICBIrPrwsISq7LEEYqTOm?=
 =?us-ascii?Q?hvqYSoWzlQSv/iOypM3AVHOf5BD1XgBdUlwD3lrFH8EHxIs0KJOPJcAhkJj4?=
 =?us-ascii?Q?J4ncO8DFYRRaPYqX67trlfaISC0qkZzXFVMXuRhzonQUflAHpAQrbpM1BVVh?=
 =?us-ascii?Q?cmhyS1uIcLpO0jM1kV+W+l4KKJsdjn9OPf733KjGCRTmL9fSoIAi8tnc51Qu?=
 =?us-ascii?Q?HWdHI9mdR+IIG6FJFYWQv/QK6pJs25SBa7cO0wkuSOmW5TPONY45GkA1RAEX?=
 =?us-ascii?Q?O/31VSwCwqEime4gG4mF2ui65pcfE9Sa5CS1iYh23hXOBuqrHr7qGdKh2tsZ?=
 =?us-ascii?Q?L4MSk0HdG/PQY8lwbMqpdCgjrULsDfiNnyFbOE2CmIuHbRH6gxwyefp9i3n8?=
 =?us-ascii?Q?MxuVGC18w0XugkApopVUB3Vi8fwRcpf62OOAMw7zd0fgocb/oq+iKmLhtsgq?=
 =?us-ascii?Q?97ojcq2ehCvfhSg0Ki3WX6QOCVOJXNEKJ/SQ/Db2mgItYiaZem1MG0HaPkdF?=
 =?us-ascii?Q?eY3yuY27qYboHzQC7dnbZ/LVZc0jiVJaWK4sIP6VzVC+0EFmw89Aqair/ZNQ?=
 =?us-ascii?Q?3ZUt1EPmn4RFRg3HYhBk2BE4KvevHAJ0KANtbAwkppPl9RV8xhna4YnVmiUh?=
 =?us-ascii?Q?wUZFhGGp/th+Klp+6bLZz2zoOFCqrHqxTLqH64TiX/2n7M+pUcBbVotv7ulE?=
 =?us-ascii?Q?qDf75QyZVfz5ejdO3sxpawwZsyWrFTlw9HC+BkmcRH5bZs9xGyy+o11uocSX?=
 =?us-ascii?Q?Pmaxv9nQQiJcos6fdS7cdYqqP914U7lCTdXjRQgRg0vtHF0IfkzTXYwz+tZl?=
 =?us-ascii?Q?dVi5QlXUh5QrlCwcjZm1GUD7FUruwgnOh+Hcjfh2SsJf7tiK/0G3QDOeMZuw?=
 =?us-ascii?Q?MX9wJyfqNPeuzcwF9ThQfwWGwQhTimf1hygYZQv/pKU57UJhkvg6+wsTHtoK?=
 =?us-ascii?Q?KVFmPTTafbioUNSFr8axRAn+pDW5xa1uK1B23e5UIUHNwXt/1JxuQCQtHetN?=
 =?us-ascii?Q?S4jggv3R2iv9Q4Ql8+50Wa41i388Hjt6zgfYDa6iUMuF6t2zz23blz0iR2ev?=
 =?us-ascii?Q?l6Tp/eT2mrIatwjpW+V9Cku/KLDPdtgDNRqonucDA199oPDLj1rejbi2wlo9?=
 =?us-ascii?Q?DyXtD53zdBLAaNZ/QlcLuBOGrUJfzjtJDob9eu2gt2auvkWKUVxgmhUyq3yP?=
 =?us-ascii?Q?Mv4ZdSih+TNk+M8ACq6rmq/Jt/odVCYSXIFVMMFit4vUQnR9/Ho5Ay4CKfDq?=
 =?us-ascii?Q?WlLHNskDJyo1kgbFCzY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:41.9326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 289b654b-bc2d-4781-90e0-08de206f1640
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185

From: Alejandro Lucero <alucerop@amd.com>

Region creation based on Type3 devices is triggered from user space
allowing memory combination through interleaving.

In preparation for kernel driven region creation, that is Type2 drivers
triggering region creation backed with its advertised CXL memory, factor
out a common helper from the user-sysfs region setup for interleave ways.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 43 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5dc309cf54ce..1d26a842c99d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -491,22 +491,14 @@ static ssize_t interleave_ways_show(struct device *dev,
 
 static const struct attribute_group *get_cxl_region_target_group(void);
 
-static ssize_t interleave_ways_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t len)
+static int set_interleave_ways(struct cxl_region *cxlr, int val)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	unsigned int val, save;
-	int rc;
+	int save, rc;
 	u8 iw;
 
-	rc = kstrtouint(buf, 0, &val);
-	if (rc)
-		return rc;
-
 	rc = ways_to_eiw(val, &iw);
 	if (rc)
 		return rc;
@@ -521,9 +513,7 @@ static ssize_t interleave_ways_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
-	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
-		return rc;
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
 		return -EBUSY;
@@ -531,10 +521,31 @@ static ssize_t interleave_ways_store(struct device *dev,
 	save = p->interleave_ways;
 	p->interleave_ways = val;
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
-	if (rc) {
+	if (rc)
 		p->interleave_ways = save;
+
+	return rc;
+}
+
+static ssize_t interleave_ways_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
+		return rc;
+
+	rc = set_interleave_ways(cxlr, val);
+	if (rc)
 		return rc;
-	}
 
 	return len;
 }
-- 
2.34.1


