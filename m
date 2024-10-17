Return-Path: <netdev+bounces-136681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710819A29D3
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300B3286D7B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DF51F80A9;
	Thu, 17 Oct 2024 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KQ0RAC6a"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FBA1F6660;
	Thu, 17 Oct 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184031; cv=fail; b=Uw7pmY8ppmAPCd9VzqsZUY9KbW9c4SvBzzCAEKIpN7ELV43FtnZichxb5vSPliX9tVHjnmslEKHyoJxrc2lg+tY/yONh4Q7XjndN7zdzAuYgR9Vx8qZAsi/7Gg9irvB/GbIpYmU5A005Y2PKNV24Td9tiMZUwWj1PYPRB7zs0CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184031; c=relaxed/simple;
	bh=kC3zwSkMiMJfJIJ80LLz+0mnFiC6EarwLCNGbjFo0f4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjC7+J9bVOnX63V0DGI/KMTgT5HoP6ETr05b5ygzh/TF/nJ8SPBgLa5CHfcWWaKH1BwKRyu/tqCmRYu17m2v/rSus1iD2ORr/3LISP9axiBuJfKSrmya3w8Ppg4Q00FDDjGePnZZ1hZhqAvg/hYU1vzXLwVu3NMBgt1iTn2ESYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KQ0RAC6a; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbm6tiIeuOm0clrGZWr4zuB3IkKsNzMtktKtvLWUrVmsQG+qUkgjbrXtE8f45Wq1lLPxf5rXfgVFXQkYzUsN51czP0DnnIuAc5yCfUMsqIvOUWqip1O8ygFqj/qoYY4l5akqSO/chH0h2O2/zWTOa7Fek9Fk+NCaZvwJmQ6LySntqImkwOe/24/L6d1M7vVCS9aUFVSRTdO3wdEgb97F1DlVRAzlrgTsxmd/TwwUrVsqlPnhujhYi1P85OTdoe6ct7hNyOQuEP9rIcpdghS0DSITzlIKmLFkGlBm7WLqzMFgd9+tukkoIWoacIACYO5soiyToLw7pXZkNh2/1gCAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVVa3CcH2ioehlzDdkrdCMVmsuz9Zsn3xryGAoKlF/I=;
 b=R8EICJTvo1l6WsyxuYAA+v57+Kjl6gaZrkUk6MeZBDclGb3T/YLT5iaivNnOwh48wxkFUpBa0TVVO67hMKcEtTuGdGHlZrqq7Q5+J85O5icUaOd128nYP+HCCuUoShIq9gmZtZgs24DBYeIUCA0Gcj1O4wQDGpJNF5JTxnI0g1hrC5c2+BQnwf0loraPETpn41xibjRjWxwKJ/DcjU/uMfCvtfgup1UxIrFdCHeSHpj+EtDaQLqfANJgJZLC1WOwY9X5ChVbhtWZhKwvSAs2b1WrEbbe8JlJyc1RkAehcqTjXVLJ8SJtnF2taru94oArfMe3xK6JW0jAFkGYR5daXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVVa3CcH2ioehlzDdkrdCMVmsuz9Zsn3xryGAoKlF/I=;
 b=KQ0RAC6aBjugdx8zWy766owTIJ7MirvDx/PBr8wMHnl4vX5q6xW6kDNyOqgnBIJ8NOZoOWLBv8x/A+s7tiz9ONFR9RhwvHAWtq6HkK1I/dB2S58Oc4sp71m3Hq4dvF2gjog9YE5RwbuKsLjlxXTIdQh2htwtMK9ty3rjPIXCjow=
Received: from SN7PR04CA0109.namprd04.prod.outlook.com (2603:10b6:806:122::24)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:53:40 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::e1) by SN7PR04CA0109.outlook.office365.com
 (2603:10b6:806:122::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:39 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:38 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 19/26] cxl: make region type based on endpoint type
Date: Thu, 17 Oct 2024 17:52:18 +0100
Message-ID: <20241017165225.21206-20-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|LV2PR12MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c95d9f-6fc4-4a3a-6b80-08dceecc408b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YZfZZaQZK6VrzzOICea0lVG1WLZum8Xzm2kGtW7ZiIYbkuRWkVmARtUpyR87?=
 =?us-ascii?Q?Q05YH0bdTJ1kwnkAlWAwG2NqaKDvcrcHpZ4ld4WWor8lKgUgiLWVIVjguuui?=
 =?us-ascii?Q?b2nliavlBufDTNIRwBDstURt2uneTeIqHUVdFufeN+A64cx0PkzD410ZkCne?=
 =?us-ascii?Q?2E/VS07BV5jmMarKD1yEIDagSxqRW7sht9JrdAQSpbLDvN+daDCuYwnas+iC?=
 =?us-ascii?Q?G+0agkfLVMeJQg+rbCIhavj6KqmS+X79qgNLFwMIgxF90qvf9oZZGGKnpXAZ?=
 =?us-ascii?Q?QmxNeiMBqa5p5jCULkjMV1rXHf8ogtkhvm7NQRSFfpW12rsob2Y9qoQLu7YM?=
 =?us-ascii?Q?/vHCoB+vDaASUgIrnARHHLBGiQzsq1J4mSBVuUraYOO6yZ2MIESNc5+hTmqj?=
 =?us-ascii?Q?1xoBUwDV6jM1Z3NHjwrvVvcQl/UScBfcPhgL/UO45y0Xz2yHtyBCpkESCpgM?=
 =?us-ascii?Q?LAjBwwhRCkwpWmjfVR6P3dLYAhnik5RiQlJPd2u03lFX6rUmJ/Kbg83S9dnj?=
 =?us-ascii?Q?VvVotsWdRtRm/GxIdUSYH6KThB60aW9ZLIGmBnIISI9V2xhseK+vPtRTYdzl?=
 =?us-ascii?Q?zTxYvYi+JFzQSQw6AXWOugmUSgdmbvFXhUviEm9mrjnPV0s3vV/Vn1GDNb2B?=
 =?us-ascii?Q?NJViRrgcg5DDUID05GzOu1EWBvyFtaje4Z/fJKhGpp7kGax7WXIViUe9huAU?=
 =?us-ascii?Q?DjKtG+2UJFEcekCq0MUg1FVImm328p+GjB/6jRfDp9QqRuOILGx2KzcsagcC?=
 =?us-ascii?Q?91v+covkzi1MagQBvcl+2DPQx7mYpfPdu9eiFJc0Y9ObRXRCOqUe1HBwfgKI?=
 =?us-ascii?Q?WYYc52SVYe94ZM//DXW82UF3u4OR0H2uIR7+48y39SUUsuPf4d1yR75QWe3d?=
 =?us-ascii?Q?+UD9+fFZOnxqAumpJMLiPWGNNXiY20o2PyXya3OaGjsTwOpCqfWte73rfpGM?=
 =?us-ascii?Q?cC+4Jqd598OayRdBX5fZVDiza9Ri1TR9Uf2jR0blwOFI2KJ7zuPkX46FnSnA?=
 =?us-ascii?Q?keD6Fd8uQyM9PZu0BKQ5FRGiYnzhT380+WJ6EScKGbqB+BpTROZkoAPXT637?=
 =?us-ascii?Q?fYaVVDkwJp3M41YwlPC/Wchtk+ATteH81UeOm0hc91CAKIYh8mCG3tS6VJDv?=
 =?us-ascii?Q?9oCBcJdixC43xajD7zd9z9B7wnYwqeebqnOmWTCIDgcurm2gz4eReY4RA4r1?=
 =?us-ascii?Q?1DTmJdJ5KQnGID8ipgaaQGeCwUz7zOtvHcjjxuGzUVoc9Fw+hueISCOrsba1?=
 =?us-ascii?Q?d2xtXRT7dXfertl/YMQypRvNV0nZffWOA6kfpTNs4Q3g4PHWOl58twXKeozG?=
 =?us-ascii?Q?Y1yf8bRz1DVjyfuaP1II6GFpuuqvItR/Syf8sYCcg5KDWfE2NVwjV4jbAU8v?=
 =?us-ascii?Q?mH8+lwkd2ULaUOjyFlJ2aSmPRbJKBE5caDAhwfKnoLDGF++fAQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:40.2448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c95d9f-6fc4-4a3a-6b80-08dceecc408b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3d5f40507df9..5c0a40fa1b10 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2665,7 +2665,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_decoder_mode mode, int id)
+					  enum cxl_decoder_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2687,7 +2688,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_pmem_region_store(struct device *dev,
@@ -2702,7 +2703,8 @@ static ssize_t create_pmem_region_store(struct device *dev,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id);
+	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id,
+			       CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -2722,7 +2724,8 @@ static ssize_t create_ram_region_store(struct device *dev,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id);
+	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id,
+			       CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3382,7 +3385,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxled->mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.17.1


