Return-Path: <netdev+bounces-227928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B92BBD955
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD6F9349E1F
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50426223710;
	Mon,  6 Oct 2025 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iiCCamVE"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010057.outbound.protection.outlook.com [40.93.198.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FBA221FBD;
	Mon,  6 Oct 2025 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745046; cv=fail; b=CaDDdOIX5oUXpqlgM9vb9N3rELeZHw13gAsIURBv6FQNQTBRIBix31q+LC+TpghjlqTZjAm5p9ok7vXkVDbKAY1xLoqEOT+CSApnjUdOSyoJN4b+uHnz5ZRoV2xwmTjDGSYKrcaIwVAiLiXLZ3dNkBtY6kb3jJBm3Bauk5kCz8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745046; c=relaxed/simple;
	bh=jXDhStXjx5gRFU+1Cb0Ytx/8c5o3XNaGUCvq8IMRmpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6af+CWTemDTHRdcau8CUTgB2ypE/jGgsscwPgF//X9HJm9u1syNreqbj8FdOB1XQkpHcp8TeLaq54q2lh7tTNNxoP8wIBHUyPnYOcO7vL/LYPJHypQEyzq9jEyXVxRzLLlP3l2XZyFeKCd/nZx4qkJ32Q0Z1WYm9HSIiZabhAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iiCCamVE; arc=fail smtp.client-ip=40.93.198.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baEhLYchDORL+Hijbm8sami0J61xRmN52bBt3pctcRw4JRCT/CTqEymtiIRu5H6QW7CSVq5cN6+IkEh2dIHz4lptjw8qDQMN2Dxa69zUamQFN77yIDHEpwutz86x+qZR4kVmRTkBI/ojyo5m5Up+8mpIgkLpJSvV1+xMruwW8tx1WnLpEYaSdTi2YnwnrqHL2orSjUXAefPmk48MhPzxbAqNSXWzvZV79YDjCpjIy0qJFODX71GuqQ50C1ACTtO7M4DM/bnUwXNiYtN1dbgu42PMhb/khGFPwiEp3+8OP4wG+cb0885YjE/DQ9T9mbUrnj9N+I4bYRCpH35Lcv1FxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTj1DkiwvPRn9QiBrfxAFzLeSWi/kLJxaLxCKnmPCm4=;
 b=edzni20k1WRhmAORK4z2DxVSibpDd19Pli7hMRy2jw81CSt3q0ze9wf8MtaFOrkdtYPSChHtOETGvVbzZBjRgJcvm7QGQr1r/ddIeBw7NEHxpsOm7COYSv6ECmxHLxMQURHzhlkm7NGkI1F4YKkZW69qxU2FVqB2aT/ogzXJfZWeJga46riQNyQfs3QfCpkpf8+e+8iYYLVw9Z0MIWeuORrFdyg5Mug4CQhtXvIc0ngT47cufjmTNSq6A8NLlp1AXdI0Noaul41230PxrQVS1Ims/68LRjxmLun7eU9jjONZZgoq3tt9pUFbzYmuZVWavX/LujjcKKKyhoI0F/MpeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTj1DkiwvPRn9QiBrfxAFzLeSWi/kLJxaLxCKnmPCm4=;
 b=iiCCamVEnI/0P7PWwc+n5/g8VOzL3U7hs35ly/GaXeQ3dLC3A+Xu8BLjizUx6cq+tevBdyhHCQfJpWH4aiZKtbvk+H6m3hWtQFGtJofnosDtTaySO4g3rvjBN1DSXAhe9UvnXjJKCUohNjGNDWFTpFvpkVFyFbXbqhBvz51eD7s=
Received: from CH2PR10CA0002.namprd10.prod.outlook.com (2603:10b6:610:4c::12)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:03:57 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::83) by CH2PR10CA0002.outlook.office365.com
 (2603:10b6:610:4c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 10:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:03:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 6 Oct
 2025 03:02:41 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Oct
 2025 05:02:41 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:02:40 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v19 21/22] cxl: Add function for obtaining region range
Date: Mon, 6 Oct 2025 11:01:29 +0100
Message-ID: <20251006100130.2623388-22-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9d3d43-ff09-43bf-f211-08de04bfaa51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0XqIRCLETaSbrSVTL6vWzeqtoosm2GC4U2gJkF/P+MXONnYszpglzZobDiSy?=
 =?us-ascii?Q?SNZeTzJRFq3I3Td1WfhYxj06A+n8EOLGX3rfDlYDAEY2wkDGFV4ptHXplYQQ?=
 =?us-ascii?Q?PFejkUM7PZ4MlJb2yWNCM8q6XPZ2w6oPP5gfm9usoBTQ9z+jIq/+kri2JsHQ?=
 =?us-ascii?Q?ZIC+ChHqF/7elze2vER+QbCqrWXJt2JyFZS4g84AoYb3jVgNLmlqshvG6KIj?=
 =?us-ascii?Q?+K6GHcfvFc1kD5Z2Y97ol7Ikv3OQlSkZOmN7w23FEFDiI8cv6rh1qFnvV8kh?=
 =?us-ascii?Q?XmTf81qCCA4eM7SOw6YXdl25Q2Db1QJZmRC2mucDMHK4Ry4lFZD+FhVwSM89?=
 =?us-ascii?Q?ye/Uv5vDL8j61AQqssjDYtiE3ltv7tUGjRC4xyA5cWuWS9GV4Ptpx9CYxJX1?=
 =?us-ascii?Q?cKytF8PrByJd8jQH0lrMDOqEdacHmdAqNAl7P3sDMpk4+ycWKBM9DuBt1Gdc?=
 =?us-ascii?Q?XARwcrmHoPH8/Tu6RBcmTbpcTI1pFcrTEnGmnKFcov78osFtBhR1kuEbblXk?=
 =?us-ascii?Q?OaI0mZ3leyXfxvrP9xVO/Di4X4KeUx64yWjtj4KPoIwYA0oUhCD/Ce3cbqVf?=
 =?us-ascii?Q?KvJ/WlL3cXFVvqpOaXXrsnYlmyD22MQLwzxlMmDfgrfelIdXHrWnMeI3NDIo?=
 =?us-ascii?Q?d2bENqfUf0S26kA8rKAoThY62mZtafYojuPDsBba042rSe3O5HPPF6IGmwwo?=
 =?us-ascii?Q?NyUEnHwqjthtU6ojDE995eaxk8UeQ6IrRtO2jRel/hhM5+CtXV6jRFU9QkvL?=
 =?us-ascii?Q?vuPTywpKupK23SEKpL25yyj4WtH8FWwBywxaDr6jzZ8f3U6eSgV3PGc/+S/M?=
 =?us-ascii?Q?TQvg/EmxMbmdjjs+SlP7W4fzxRhnYINV8UPG/dQtdATOvv+4bGpgw1X3GkPd?=
 =?us-ascii?Q?EXnVcXMHnrNdNtIsJlo3I4FvNMrLby8aY/cQQf9h2lZBDThsvX4+7m1bYdF5?=
 =?us-ascii?Q?tHAnGB+ov2sxnnlFpDGbZRhlK5fFrZ7uduHFaJb+A+U1cwhohcRY72VWnnuD?=
 =?us-ascii?Q?+ZK6v96MHMax1TYmLQ9Ma74xig+EBOQaDn3jyD21FNkRcw9QAIsLhd6ybftH?=
 =?us-ascii?Q?q/aHwlir7YmdYOzkSm66eijeDybsP097z3XuPn4isQc51td0rdHeokUHrCWB?=
 =?us-ascii?Q?mu4MVGAuONFg2/KCE8ftNUspTRKp3pKQkGU9YeeNdSF3Amsinrnt3W3vN394?=
 =?us-ascii?Q?V1wgXJUDhjzV7S9G8APT3+sBlAVJQivEEFaYv+afISAZI1Myn5Exh5cwecwj?=
 =?us-ascii?Q?ktxY/XWKZ3W81fAZzH93xWQUPyw65EoJ/AR9YxZtYnk50J6a0MaqiFRDjLqb?=
 =?us-ascii?Q?mAW3nKtiNDkqkntDzA4Zjx+FLYYSidC0dq5/64939pQvzrA82Q87jm20QmAX?=
 =?us-ascii?Q?LC/aPJkzOQB0rvcn++Tx7dMeb3Bshgt/vCQWw+pMpPig1tjkOv5XvlNqnBG2?=
 =?us-ascii?Q?t6hzD3aPjx4LHOH74W9CLNn8qQ2hAo3+WAan/3ASWJP6xubbDspcgwfy6oW/?=
 =?us-ascii?Q?8Q4ZRwIX42BG9SnkuK54MdXRIPYFEB7vutTQhRU2ZVgVYFTZGJ2flKS+F+By?=
 =?us-ascii?Q?U4vo89jvJ41X8+j7M7w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:03:57.5409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9d3d43-ff09-43bf-f211-08de04bfaa51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318

From: Alejandro Lucero <alucerop@amd.com>

A CXL region struct contains the physical address to work with.

Type2 drivers can create a CXL region but have not access to the
related struct as it is defined as private by the kernel CXL core.
Add a function for getting the cxl region range to be used for mapping
such memory range by a Type2 driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 23 +++++++++++++++++++++++
 include/cxl/cxl.h         |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 05f0b77aa229..88c07ecd9e68 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2754,6 +2754,29 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
+/**
+ * cxl_get_region_range - obtain range linked to a CXL region
+ *
+ * @region: a pointer to struct cxl_region
+ * @range: a pointer to a struct range to be set
+ *
+ * Returns 0 or error.
+ */
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
index c6fd8fbd36c4..e5d1e5a20e06 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -286,4 +286,6 @@ enum cxl_detach_mode {
 int cxl_decoder_detach(struct cxl_region *cxlr,
 		       struct cxl_endpoint_decoder *cxled, int pos,
 		       enum cxl_detach_mode mode);
+struct range;
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


