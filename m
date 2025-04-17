Return-Path: <netdev+bounces-183928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5F3A92CA9
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8035F19E8340
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6852206B7;
	Thu, 17 Apr 2025 21:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hm0QZTGl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A6421D3E9;
	Thu, 17 Apr 2025 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925406; cv=fail; b=pid/6v35WKEPZEqvkRzMD1lsQvhvN7n9ZGH2jlA375xnSwtU5EfURlWz8LhlPp100Ltj63wM2yDU4igNbfElAsI6v7/B0rsrNPZJWYTYmmAvKghafjk7TDq/D99tOZL3+f06VszhSMhEJQoHXWAu3kWvpG8vhT87WjFhdhcvmeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925406; c=relaxed/simple;
	bh=88UyN/sBkJKuI9Jrp478XbCCwJeVKD2v764U8YIu/5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fjl5F8OtVs48haZoazRcra6YeczRwZrsyN4jldVlp8wBVT8l3fpz0wLbMxKLxC7p5CMsX1pcH1oMLKmaD2pjk4Y0HNoFe8V4yhG+ONfNDTw4IFzZnRuwq/ngV1LUVhcDxGTWA06J0lbjDhvoEP67qAd51Im6Ls4+P8hi9Wif5cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hm0QZTGl; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjWUkaKBv1R/QrEUN9Gf9DjLMbvPgKUgKMwS7wXmgJxoE/8EFsEWaPeRBfK0xsWeGdWjG533cTBFXRf4Q70NXezvIavMmQA+XutqOJvIJ71S3/yOeT5YzarZltPpjwyhItIgMLP+rnh5aLOwC5zq1RXbDgzjX5340T4lem6Mp9x19oCfiOWliaCqkJNnzOn7IpRMBp/IL4kbCPSKHLHz84Ta7QcaEGTUKtiRAphVTnknlLE097HXMdZx9sLuvCYoeT9owFzcFeeDzz62ULOjEt42URWKilmrtp79cQucc70n5h+knm9AA6zcmZC1y1BQV424wxFRgb5wIybd+l0MBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YB+JE99mNj3wdCDWUItQJHEzrwwP2ZC4+tIhu8cr0B0=;
 b=UAnPmETrzGi05Xy+RmZpkvfThoanJeY6fZ5bQ8ZVnYSq1pdCcWXUw+Tuj49Q8ii4frfIYl2uHGppNUO8G1dThuaeEFX+GrncDvwqd5lhjVqvfmNcOO9ez+R7JHlipBUmbuNxJoMgOWGJAP2iEjYRLRDi+9LVsg1Fcc+VhfU+etZZcmQJqVj2M4Ga0KJeT9Y9YwcvacQUai3ivRbmaNJvD9wG1uYqoq8mzrlfCcj3VDMb13dVfg4r4FjAIyCSj/83J4FPfOYHHeucZtDsLJZuKfdl955TX7QwHDWkNG6VlYdT+t8Kyne+iGH656K2yrDQnZ7w8WLNCK99w5X9CmzSiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YB+JE99mNj3wdCDWUItQJHEzrwwP2ZC4+tIhu8cr0B0=;
 b=hm0QZTGlj/YD4hATqt+yfjYePaXW7wq3DJG63jSf7N40r+3bxo8kHUro9LIB+u6moSBZf53/b8pSGR0uYQgoecoHGkYuM/KCCDHvYMQQwhs1ZPy4tUI8giTcFPIKWAa/NYVaFuYTZhGhS+8ivtSTqFHPVR1rMYC03rWuFrPDLRw=
Received: from BL1PR13CA0063.namprd13.prod.outlook.com (2603:10b6:208:2b8::8)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 21:29:59 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::35) by BL1PR13CA0063.outlook.office365.com
 (2603:10b6:208:2b8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Thu,
 17 Apr 2025 21:29:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:29:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:58 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:29:57 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v14 15/22] cxl: make region type based on endpoint type
Date: Thu, 17 Apr 2025 22:29:18 +0100
Message-ID: <20250417212926.1343268-16-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0306fd-531c-455b-72fe-08dd7df7015a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xkfuAe8lGFHlt4NfG6rN5UM2YAJ+Mwd1zI8kQo5F7Ci7DJNzXKn8fKHPCxyB?=
 =?us-ascii?Q?ovzM9KqnmlcZRPBLkwCOTGhEtCcrwY3uIyXnq5oNeepw/onH3+l3Zo2UfL9n?=
 =?us-ascii?Q?Gp27dwZScTobVDDRFviQK8j4us33wBmTab2HQtms/d6pTZiCElGdC+hxpk4i?=
 =?us-ascii?Q?cH927LRwb+4YDQa2flDAxg60YaZCAZWE2jl8Tw9V/TI8UMC+qhR/rX8vGI8O?=
 =?us-ascii?Q?gezKn3xpo+lm4X3ykLBe0PLMNFXPYupe8PBI3KvFrZo64nubLhiVI4fDq/QB?=
 =?us-ascii?Q?WUNFginHMEik24IoCqe23waagoMUrn1RcFwJ2xchZ5d5tZ81Vp/GxXzIIpOD?=
 =?us-ascii?Q?sXRrUkkG/BQqY6Rrl7k6yA0O7fezycqMIAtB8uvRKCePgB0Q41HXS9Ow2VaM?=
 =?us-ascii?Q?ecCUJ4ggUbFR+mNjAnWEPSVz7v7Ll4+QCueOAjFHhJEDu9QYsKd+yWoAeI6s?=
 =?us-ascii?Q?oml1LK9fJ80x4mBCQ/KyXaAZQmvIzy/R4OgRMYTHQaOguapxX9ToHiiiTW5j?=
 =?us-ascii?Q?G7DI0T+TqikXw0Y4q5ji2215ToaltqcQ/Rg5O6SeFUFox1UiK4pYRtnKsMZ1?=
 =?us-ascii?Q?McRP2RgkAL0PL+EddnYi7Skxuu0vmate4kmuP8IF0winNR+vGzhWq2apZPOr?=
 =?us-ascii?Q?fU+dXUc3X+QCteP3paTIYO34lrcuvOJeGvHOU8BF6zvr7OIdUZrX/VsGAkiH?=
 =?us-ascii?Q?fNdLxBlFDmhiWCa7EJ8lzSProuTltC7dUrTZ+FCqL8RQbaWJKs2K7mQyA1WM?=
 =?us-ascii?Q?V1U6nnHHURBhIXErhsAobbidEP6lj+0BUilOtwpkJavTBh+Y6SLf1DwqCtTw?=
 =?us-ascii?Q?r91DUA2Exq0wBn7DSXsPWEWEiLEbhC6rMl9vXocEODeGki3h/1KkJufv01KC?=
 =?us-ascii?Q?A+encKwahAmcN7i9CY+m1Sw8pKoQfzOuK61JvcI/stgmv+Oym8qUYWuF0F0X?=
 =?us-ascii?Q?DBQrxDNX6aK/rqlCZVJB/ahGrsyfYfRShGadLUy3jNsh0cTKHQFKIkCPtPY8?=
 =?us-ascii?Q?J5C60oWF7pjnszZz91+tjteRAui4IOHkNd2fOoPlOs9CvDUfPF/ICy7roN/G?=
 =?us-ascii?Q?JcCFbflYeHoxJBwpe/tcdOaM/7woVNmrb+wxxl3uDdfoVHU+r0zWQBlDV7QD?=
 =?us-ascii?Q?GFlPz+i0DGaQKMigb2htZFuL5C5wEJASmJhn9iiWkwPX8S1aJnL38mw0iSk7?=
 =?us-ascii?Q?NqBqD5gAQxWklajop9ap4oHY3jOp0tTKll7x5zE9kGIhhGwyMr685gWktWhb?=
 =?us-ascii?Q?IRjLzyK/A3+hZQZf4r6SuVXnB17f2lxjP0RdR1adEy71eNdeQktaMTWqRhA9?=
 =?us-ascii?Q?4NjiPj/sPmFp15ashBZH9C3dxbYCGjRnzsvrlHNpiq/1CJXiijQX2MKD/bmU?=
 =?us-ascii?Q?Io9sE/6klhNNyu9Dru65rFHMyXhWhpYWfmqPtXx2zhx9Ua3ukQR74wPG9ycc?=
 =?us-ascii?Q?BNFiQkqO1qSlxXMDOpj8/ELJgydb0bgUU4Jp+CIKEw0/Q7RZeJcChJrVrCgu?=
 =?us-ascii?Q?q9ovT/z6/oxWLQpzyECVXgX71/GZcZ1OEFgM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:29:58.9124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0306fd-531c-455b-72fe-08dd7df7015a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0a9eab4f8e2e..6371284283b0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2712,7 +2712,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_partition_mode mode, int id)
+					  enum cxl_partition_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2734,7 +2735,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2748,7 +2749,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3520,7 +3521,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.34.1


