Return-Path: <netdev+bounces-183935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BB6A92CB3
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD30447365
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCC02144D4;
	Thu, 17 Apr 2025 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ci9x/KTh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B363822172C;
	Thu, 17 Apr 2025 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925415; cv=fail; b=X65YtjvFODYr/bqO+4zN4HGLcg+Fy2PkVmuRpF58T7mkx5zv+79NF2MealHMK1rIpsyTJBF5ClBP8bxhKlJCGghC+G5X40eqSOp2q7B96BQlyA74F0R6GQp8130/UV3s9uRq5TiOjsLgSXLaibWyXuuwdTBNZC0pqbjFod0mf6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925415; c=relaxed/simple;
	bh=WqJrPRs5dUxY39SqFD9mlDT1v69RKhyO8OSTb4XFEZ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdRVaqjOiD2uvbhCg8cOCzT/vXq+AONQyF54xD1t7mhz94B+bdzUcg/iebMF4KigVdr+UzP+NXCfSOmbS2l7h+fgLAym1y602XOq7gzQYg6mINTbE+JpUdcWKFbTCINejVgAScmSHWDtcEJhFE2pmlnxr20L408IQT3oihL2jIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ci9x/KTh; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i92REYklthauu5Q+hvv+AlWhXIp5LimP1SzNIMDlZyHyxf+AlJRfbZI9PJGAMISJZbHkSnJ4TLkt+s7fXV8ifydHxuN9cXI1ua1V4TnuyN/NT51bUaLJ3la+tsku8+6lvpW9XOQRT6ziEMpbo3V12r0Z5OGBTFhcl6OIoKCgQWNO+nuOnYLU6fmUsNagExjBhUlBmwMznZppM/C2DVSL+1opLnP6Rr85QU5aLOl52bLVaSh/uVwtyn9ck9m7kcxv6/gnnapQRArTKnQCk8cC9eyOXu8IIzlRV2YhNvnA1SAoo0MjZ9MWtlrWExyp/9TuX2rcBkx6kzJeRpniIcF/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sr2dTxOW6sFVsnECY8dHJ7tAvLFFKHeEQyBWFsHpah0=;
 b=GcMJFP5FXOmQCT/nrlyonIXB+EYwlpMU7JZu/7niLt9ye6vJOyK0oUwgNpvAxyyLJNh258hJyUHxfCQno9HwXALkrmAettm9/A/g+8Ghd0zuTlwRRNRDCCje1tNsMEpQPpp7tikmtf9VbI5OQIz+hQWuDA3BPq9oib90UR/dZBB9RVlUvNSz2DBsKxu553EOZTqJiFxpzmlii6uj8tPqmWzMzOI4sPhBA+jgZn/bCtwb7uMz9D5DPuYVYSJmv0uXeahhFO5dClrn0sFQ1mjjb//qneyjSMIu9SX0jkI9B7uKMsDoPk/ZD71l1DHCj1SJ3xyrE6QP8OJj73WrsXJjRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr2dTxOW6sFVsnECY8dHJ7tAvLFFKHeEQyBWFsHpah0=;
 b=ci9x/KThxU3+l+6Wqw87Sp/orL6lDYkeK5v07JTKwvrfmnsnoxGYxktfchzuzZl1YTPYpVn7T6MCuwMB8OyIwJ0i0/1Mp6RwBTRPAuc2nGqumskkAWWj8xHOfyv21hvx4TlH7E1eta0oSEFieM/S/uIrJ0+/VwGtQOZrxLxlzEE=
Received: from DM6PR03CA0101.namprd03.prod.outlook.com (2603:10b6:5:333::34)
 by DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 21:30:10 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::16) by DM6PR03CA0101.outlook.office365.com
 (2603:10b6:5:333::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Thu,
 17 Apr 2025 21:30:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:30:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:30:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:30:08 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:30:06 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v14 21/22] cxl: add function for obtaining region range
Date: Thu, 17 Apr 2025 22:29:24 +0100
Message-ID: <20250417212926.1343268-22-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DM4PR12MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a8e602-c0a9-4dc8-cf9a-08dd7df7084e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jMbGND+O6CKdCLoyJKeifRWMUav6lQ9uF4QSiHvJjpcG0cME4c98SObCi3jU?=
 =?us-ascii?Q?X4O4lIAJX/U3bTlByTTpEZSLlf63dXFQWQHe3nnwH605OJSy2+N1ou4skSs8?=
 =?us-ascii?Q?yZnK1iq2Td3XHAQrQehFfZQsCIvCp6a3GOES0AbtZs946HsT6GM3PRmQ9eCC?=
 =?us-ascii?Q?JsiX5hdSnogQ+qfIX0H+SkICRC+Bifg98mP17PO1HvZjJVLM7TZOf3wNCtei?=
 =?us-ascii?Q?vBu/gX5mzI/Hm0z+YHA2R1VaV2AJkIAnnkGu40k0WlDh/osVma91xp3zQh/3?=
 =?us-ascii?Q?78f3ROnD/w510Jfq2xFkq0iCfox+6FKKP6RaddJ2n337+vQkc6eC3wQSdest?=
 =?us-ascii?Q?3cWNHCeow3gJ5D9mjhnwXbLLEmIMKqr0B+eIyTF4VeHxDnjg6T1UwbX6/jtD?=
 =?us-ascii?Q?uFL1NmO54pj0PK2QLbBeXR/qSWVcPgSX58bWST5RM38ZcF9KZzeoxNcdCOD7?=
 =?us-ascii?Q?/uRiHZ96cr98aKZX4NAVkzHfUoa/rJ9bZEvs0tLY76aVzaVpDZmbVEAGEopk?=
 =?us-ascii?Q?eTuxp5KvSEElnwhY2h5RK92LMfxm5/7QytUk5jzwMgzFl7pYyJYgXB7sWMux?=
 =?us-ascii?Q?HqY0OYg7pBMdMe4phMDsJcyBSWD/E8QVkHf/WnIhaRC/wDjvkw4Y7NvuhaJs?=
 =?us-ascii?Q?IfL0RVjjclUOcXQiP0zqcYe96cRzu1T7/Y6DAR/aWPRMExr3MExwp1bu8I1B?=
 =?us-ascii?Q?dmqcYMBXhlf4hi1Q07LD+zQtVaRXLn6I3nJQSgMvtNNeDVfyv31TAdWST9sW?=
 =?us-ascii?Q?oPQt6Fpfpw/1Ge5HguQBwwlAdj3PzYGBQnJrDOVqPrz27h6CnhPWhLUb1v/q?=
 =?us-ascii?Q?5t+sWBgRupsZCM7yjmKGraMBdvrArx32wUzvj8J5V+QMxUdZH08D9sTJvXZm?=
 =?us-ascii?Q?nv3mNEvH83Uc3xyOTyl18dsUKSQoj1ht0XxxrqY2D7/E/Zn123FV/yGw954n?=
 =?us-ascii?Q?eMaG02uHATlWeuo6trCKpLTnEWB1Sz3zFTiIqYiOS80YVtj6nR1pHr1t7WeH?=
 =?us-ascii?Q?QZfzugYJ27iGeXLz5H8SEeISNh4JsjamDON8K2dMS1/PqPSjq7/dEy0NMZsv?=
 =?us-ascii?Q?9iVyp0j2qGgrLLJRg3mGpETmJ98c9zu+vYm76qa1no7O8+dAXu73RyeRPyn2?=
 =?us-ascii?Q?L8BV1wumhxwUfZdB08CqtTDq7BXZLKU3Z0/m/Kunu8upgYECAmU0vIM09VYS?=
 =?us-ascii?Q?ytKWdd8/3wNdf711d5uKhmYyGDl0mzbLAA5UxijiwU/9BpbdF97wzM87m4PL?=
 =?us-ascii?Q?PNY4jxS+RBdZBLEDJCyJ7FJjJ/reVhLjI/4hpD8aw5lV6DppUq+10I8jjU/h?=
 =?us-ascii?Q?CWAoCvD2oVCGI37WezKiH5sDfzbHGJi1pXApIEQuO8fg7znp0WcFVwVS4LRe?=
 =?us-ascii?Q?KsxN8++wQNJG62pOJHWF+GJXuHho9QNtai+sHLvsXiVEBqma8vrRE8CmrS1t?=
 =?us-ascii?Q?uBQpm2EvGs7OgKCVA+nOsCC0E3dweik5hOCjcvev57PS04DzUV3x5yRCNVU3?=
 =?us-ascii?Q?xC4nhlZjq2Jda6zXh3DtQnetkNmT1CfUOCcF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:30:10.5006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a8e602-c0a9-4dc8-cf9a-08dd7df7084e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568

From: Alejandro Lucero <alucerop@amd.com>

A CXL region struct contains the physical address to work with.

Add a function for getting the cxl region range to be used for mapping
such memory range.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 15 +++++++++++++++
 include/cxl/cxl.h         |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cec168a26efb..253ec4e384a6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2717,6 +2717,21 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
+int cxl_get_region_range(struct cxl_region *region, struct range *range)
+{
+	if (WARN_ON_ONCE(!region))
+		return -ENODEV;
+
+	if (!region->params.res)
+		return -ENOSPC;
+
+	range->start = region->params.res->start;
+	range->end = region->params.res->end;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, "CXL");
+
 static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
 {
 	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 5d30d775966b..2adc21e8ad44 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -271,4 +271,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     bool no_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
+struct range;
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


