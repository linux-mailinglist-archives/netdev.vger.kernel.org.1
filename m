Return-Path: <netdev+bounces-189826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B05B3AB3D3A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E55516D766
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC922512C5;
	Mon, 12 May 2025 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a836RITJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07900259CA7;
	Mon, 12 May 2025 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066293; cv=fail; b=kVzdbIIgZbZIXHE4yxuVlsaHHSjLF+AVNVhj8hURHCW2vqj/4CyqXENPydxKSf8EDlIb14J0JQ0APu0BX+/4bStjy2Hb6JpFc2OYc2i0iVL+BhGGOoXHYv7XoU2deAm4KhBpUvQQVHYFZHMUJNcy4HS5iQKpMAo1KhkJI8T3pq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066293; c=relaxed/simple;
	bh=wZVJS4NpY88J0B/yES+ZOculINGH+6TXhKfE8/v3LZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TksXwToxXHKMpDDzZwTxAG1YRuNUDWH78qZjROmcS9DlIwyh30Kt0+giGDcGA9g3GSKXoA8vIZlfnkvif+78midX7PhM7rNWEhoiup0HLLWvEDDaL3BTqWV8n28frpY0es7ckBK5QUpBwwWS4NeGbgr9qyoCB8cskiPfG/00dpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a836RITJ; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQ3d9zEdqHwIemKA1KfXYT+nq9QfL+aljcJHqC2Dz4cLFYHF6lqaz/2KTxz23XMtfAKgnJQN0Zho4pV1l0v7j39Y+Fkaiy9J/5chV9l+49qMJ4+2bzIbpi/QXqWwgD4U2ltxKVtNaJp80N5W1jnVW6yVCHsBjAsNzSYiKnlidkelmULiH9Yp5RhkMW5vY1r+T1Ko4itP25hQ5sqsvoRj2m2CebEkb0JOzPiC3Bz7zyZHbzI4AnL/B2FjhYr4BfdLkmqQChI8ATFUyBDk3fXIDRkcJ0FU57lO0f4B1PuF13bD2ZodNllCDIQdkx9H1qNhixCYUoJ8jcQwzM99gUH3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE1/ZTz5XgW6xF62LVxf4X4XyVOV8pw2fQjkRv4kMwI=;
 b=yeSjGrkVaFgN+HvufJi+6sukd2rLnc4wj7lmcQKBP1Xt7wXc+2wGimkldZC1t9MhinSIgGL+OHN0ZayQ1l2qEfYhV6snZEtXbHMXMjmOjuS8xNM3L9MTUgrMEZUAlQ1v1PVgmK3eUhe1wp3c2Ox/b2oWJS2t9SnVNWocaF/8U5rKTdBK4JVO7RsGe30p6Wb40WuBh8xJjAfIdgjfbj0OLFU1yu8Wg0aCpp5+GFDX/mow0LlIuepJemlUDIq1jE58sBvIppsJ4dYRfJE28OvSDfXmUv425XAfakCc5D7prTqOfKTZgEIWVjuqYI0GRWtRueDrNYYXzS0lAEQoFRLhdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE1/ZTz5XgW6xF62LVxf4X4XyVOV8pw2fQjkRv4kMwI=;
 b=a836RITJ+yymrCpmCpMxKVTQJWSseTMqhnCIUXMhyb/Xn5Vhl4Qle78Bk2oO4RZxRnQo4W2SFamf03nHe9FZpWFO2ZHqH2vSvi8VXiFZw1tHznXfykfuZT0+EuzG6aDf2kGUijsuACQZNuUOcCZiIh5/S9unrFm1obj0XHjkYw8=
Received: from DS7PR05CA0023.namprd05.prod.outlook.com (2603:10b6:5:3b9::28)
 by SA1PR12MB8985.namprd12.prod.outlook.com (2603:10b6:806:377::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 16:11:29 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:3b9:cafe::e6) by DS7PR05CA0023.outlook.office365.com
 (2603:10b6:5:3b9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.13 via Frontend Transport; Mon,
 12 May 2025 16:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:28 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:26 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v15 15/22] cxl: Make region type based on endpoint type
Date: Mon, 12 May 2025 17:10:48 +0100
Message-ID: <20250512161055.4100442-16-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|SA1PR12MB8985:EE_
X-MS-Office365-Filtering-Correlation-Id: f2cdf17f-c4c4-492a-1697-08dd916fa755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z0CbD6qvZZr8FPOTBqe8Wdz/Z3GYGvWfZ+MJTm4B9dCVBv9skouJS4zOBsze?=
 =?us-ascii?Q?E7z9RHx/TMd6gqTza1BpOyZJ/18eXytaUdb+eEA9iY3NbGlHtGrSSRzuVpIQ?=
 =?us-ascii?Q?b3euvyGU0vdaInEZbIGO83cIpDeufY38/uSn4jbP2XOXrvesa8RfesJr+8xx?=
 =?us-ascii?Q?OnwcgV8hvnsiz8uDZzlxZ+9Jh/WzIOiy3RhTlH7PkxwOkZhxxvlZEfFZH9Ga?=
 =?us-ascii?Q?PwvNiBLfl8mC6GI1ioefOGYgP207vmhowVa6PS3OBx4fAj1tO2u/AtTFCebj?=
 =?us-ascii?Q?ZE+s6U5iyrQf4iJyWJv99Y9Kz2M3RIy4xv0MNY+eji+MgpkqqrW1n9hiJsWY?=
 =?us-ascii?Q?1Us7dbsFkPmQPNbsugvK7/cP1gM3ZTAIJvqSYS1RxBggYEjminzrUSchnf0y?=
 =?us-ascii?Q?ox8Kcp33ZBAF4a+TN0wgk4twoXLEstSX9raWnd2mdHu2BfhsmFLiYZVYCWwI?=
 =?us-ascii?Q?tL/bTURVOimeRV9yq8oLpWebYXbSg0JWeg2TfUCUbQ/wweIC7ZVcqm+U/Ds7?=
 =?us-ascii?Q?eXsOoaY+kk6kY0UPMyc245UI94YGW6oQvN7Hmg6lU2D4Gx1ci1GXmDLsXEk3?=
 =?us-ascii?Q?CqSJOX33ecX9qqk0Jq8Cn8k3nfLIJhTUH/MQymbjwydgCmFj0jGgXvGasJo6?=
 =?us-ascii?Q?5Kf73RTih3pM5nLDA1yLSwxWoQAnwD+EmtyAn6F88i94wS4ow3Uh+kbGiSxe?=
 =?us-ascii?Q?rQZhSG3yzpgvOUJ05S+kcmAgTXkg7vCZ3PiBBH2riWC7INKKpEgM726cpZ+L?=
 =?us-ascii?Q?fw/LJgxr2+Rp/ABoBhgYGjdGDSsOF0ay8NQPKOaGgulI5pJj2NeazjVNLA/B?=
 =?us-ascii?Q?dZhYF//q2XHgCWF3Vd89ku9wlT93I5p8WLb9J6gFJ4ak6QOZM6cx4bZpaBmQ?=
 =?us-ascii?Q?nr0yV1p2DOwCA4/o2yAJDOdcyO95dg3Z+s6KfyqzSnSyL+XqW/A2ZlBgOpYg?=
 =?us-ascii?Q?bHTArbyVRLOP1rvaxlL6ItAsZ5fGQM1v6KabxSH+QCeDgpYnndtUVJCumcW7?=
 =?us-ascii?Q?/rI6QFnb9YiJ0LMlxeJ2bV8y9Q14CnkTdkLgjtzoE77Zc/oWnbqxQBIqzJLT?=
 =?us-ascii?Q?hTs5JHNSjq850w0v1IgmnBvkxkdFuE+y79NzhPOdB3Gsh8s7Hzp9cHf1Mukg?=
 =?us-ascii?Q?1b+kr1QCnHyyiT4JY+c9qzCPqE6bbqmnawnbFDfXsrn3dpxoOlmVAEooPLAs?=
 =?us-ascii?Q?jaTZ45zGBjZC2ZNNJ14tnGg2WmodSpz9QyZB0ufmfGH3mzqKkVtwe5M7s/aF?=
 =?us-ascii?Q?/Y5S86bEKrCZjgB2YnoPsjGUnM6aQfck8ERBJyrZ7MT6M4Gr8IoiSW+XARSP?=
 =?us-ascii?Q?bZXKZWvATx5Yxzf28DRGinc6aNNddehTjYgPdcA3d7O8tphUvfWio5HrIGaE?=
 =?us-ascii?Q?L3V5LKnmt1uff8yyafVCPXAbRTBSbbN3ahOdxQDV4w7epCdK39pT2VLwAuqx?=
 =?us-ascii?Q?KFiX9lCL+gOQujWF6qSeXJVbTAnxTUd/4iTRqmoiB3X/P7SISDuWmZUsiFPs?=
 =?us-ascii?Q?nOf9ZQaH2T47cZgOn56BPQLUZzyhU69bzjoS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:29.0479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cdf17f-c4c4-492a-1697-08dd916fa755
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8985

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
index 4ebabae67f1f..466ac8e6e2e0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2733,7 +2733,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_partition_mode mode, int id)
+					  enum cxl_partition_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2755,7 +2756,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2769,7 +2770,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3570,7 +3571,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.34.1


