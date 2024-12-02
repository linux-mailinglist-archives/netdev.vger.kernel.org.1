Return-Path: <netdev+bounces-148185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AD89E09A1
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA63163981
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353A61DC054;
	Mon,  2 Dec 2024 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D3icYjxE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA41DEFE7;
	Mon,  2 Dec 2024 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159604; cv=fail; b=bX7Woxs4a75orjjcUIDYiD94c0+iILJ8a1UfOx7FTp4BZFjw+mDOReqITswp7Q1me1fW1mFUWZyIF1GX15YMn+VJ5ctpt4gIJBDg7jtrU8nuCgBCvuV6gV9Z8GYP5MNsJgs3TqOqI6B38hA0ZorvHJ74RHsUVBGiP+JwcrGnK2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159604; c=relaxed/simple;
	bh=5kk5WjVfG1jxypJiFD0YVYdaLyXz8GpiUXuazJ3J9cE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7F3msDbammQ/ql1fs5NrCddDhVPEPAUBgBAQ2nVwaYnLUM6L7wUU2sqjCA9KZMOhsDuyCi1x9sL/d2YtoLUJalWR8RHxRIcUS7TiCnO39x05RN3Y2KVxlRtsMAdDRc7rpcjEmPvVyD4SadO9QZWCtRHdYT4MUhUQodcH367mYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D3icYjxE; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmWMNY1axl+Nk4Td30NEdb2/OlrPYIpq7OKbNvdmNWywIxPXQxyn8qxueYkCpm5jSFqaJexrRBMZhkOYEre/leL8KwLjxba5PTvlIreIqEgnjcT+xoSaWxGyekfZPuQvBIppVGwKIjdBDCof+wUUBapxP7YWgH5tFAIY/U9ujAdnR1CPSnOv4gCkadRIaBcjUDCiSl/YaJkpWDsQOfhZfrlvws14q0POZS1HdxJcR/U/xOLVgOZP3ia4ZgmshNoue8uozz+IQalqg0o1zxCiIOdHox23/Y5u/FVIXdLcux0hmKMC9FjfKOkwOQYOCqseEpb0ViwdM3BpxTtWckFJHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfiakXJgweAY8VkjVm8vCzT5MXc9LK23kK2VsJVod90=;
 b=ZeVAxAKLmoxukU0ScDdbTHMHIA3Bvq/AZDH6BJOQOJOyepG3kmxHJZWYwZl3MQnuXMKG3xat8dR16VbKrLRtRetu3UOx/WZqQHLuobN6X54NErHWWda+4St3Cj+OGvivj4h7vEVs9olGaAWqo/qMa5uAYSDGe2QJM7Y5b4QIUx695VbOnMXXVz3Y7As93HkjXEAenRQ6CluVglf+/MCXM6ew25lqjW9y3ACSLkLYpRYOJ8XVJuwrRM+kKLuW467xOYqFjgBmH+zfpwXW9xB7KjUyRRlgzcVEnxPwa2n4d6Dm5mEKJEIju9+C2xTGn2nz3PuxC2p+vfrtp1DTGir5Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfiakXJgweAY8VkjVm8vCzT5MXc9LK23kK2VsJVod90=;
 b=D3icYjxEgfAeAaNWcjlhpuRMJ6WSMyv583a1P8/hRnQOUWeOW6s00dsPeeS9iZZP8/YBU/Ar9svlFAqueGGCfoJelrw2gpj1slhnmoJk0SvvyRkFc27EAdJu1YrmdpxCBE3kFizuoXUVyOxGu72VyRUmMtXREJXLO0ElmVWYmWI=
Received: from CH3P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::20)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 17:13:12 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::58) by CH3P220CA0010.outlook.office365.com
 (2603:10b6:610:1e8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 17:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:13:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:13:11 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:13:10 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:13:09 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 26/28] cxl: add function for obtaining region range
Date: Mon, 2 Dec 2024 17:12:20 +0000
Message-ID: <20241202171222.62595-27-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 0036b2e9-6cd2-462a-6e9d-08dd12f499b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vE4NYBc94wgGmm6UqSj/z1wOm+VM8/Rovr6vcYaghrkxEh970aJC6IWW3kgr?=
 =?us-ascii?Q?PkhwZ8uHwbsEqJ4t2KxEy+xOdDAIiMTvw+MDbtJTZHeF7MsiXomZdhvMcQEp?=
 =?us-ascii?Q?v10Ow+WzM8G64YXCXO3briu/RarKOyAiTDnuTMG1IyO2lnoFfXclbY7MK8BN?=
 =?us-ascii?Q?YZgRfBhVJLOd7UL6gakr2cvP6Kf6ZzHqMjIcQdFI4F/ptbWUSH80jCeUD1vX?=
 =?us-ascii?Q?D/F/bfO9DuLC7RZBnEx93PCL+o6V5rGMHSMFKTX4CDK/A4jIskQCWZl7nwG0?=
 =?us-ascii?Q?tIgQ5UzW2gF9Ohol09pjMiME8/xTI4Iwmxz848TtQ2ewkeCzhWtXnwcVFM4t?=
 =?us-ascii?Q?5dzGQ2udAvEzWm08rsLiCU+bbxjuzdC2BKUPP4uylsH/ZyPPaNjSlFFRf1pq?=
 =?us-ascii?Q?uXnXF1D3I1pmePAS0SmUahZCsbxOlQiV98lArSO3Gxon92BAN0fujvtmksBx?=
 =?us-ascii?Q?zOyW2WuFWQfXn8rqw1XI7rO/5cB/0mQsUi3TuxcfTKGWQtkkEFXd4uQ+nRo3?=
 =?us-ascii?Q?vQCqHkgE2l13JdMrFL7cPFgApk2zflZ6NaidYkkQW5BjdkSh1nt/PQBn6en3?=
 =?us-ascii?Q?a/YBjxUhhEB+wec+bNY65mXBOFwFAoK330T9V7vnI13Ij63/74RHxth+Oa4C?=
 =?us-ascii?Q?4Uun0kPyqXFOhb5GFtaqg9fta3fUBCSPwHjWEPNBSx75JynUJMd3BsRTIRVF?=
 =?us-ascii?Q?LhIQv/lgI4+nnhWxiCe7jNn2BgHU8lSKN2Oe7xUE3YHTJsVz9e0rhzUq+G+E?=
 =?us-ascii?Q?E6nwXBzRGCtoIPC3iCCLaGHJZjdr3t3/oXhhaoCStvRPEuhsKYgvrjq5QMOf?=
 =?us-ascii?Q?Unq9jzCbovuX0BlhsY36Dqrq5iIgmeHl6gTLhaZ09biJgpNJe8UKXMfV4uM3?=
 =?us-ascii?Q?9YwkEDtqDnXhke+2ON2E7sMDuqh+EtzbjkJJJGGT05578EuEG+g+XtPeS/n1?=
 =?us-ascii?Q?xxsZKi6Y3yJbF70m+7fS8Ub0IsPbAfj4quFor5pGhRnXxkpbu7RUJaOsOKkK?=
 =?us-ascii?Q?85aeQ7e+eqO/468zTxaznyzzDQuH4XmndcnDQzMOgB8YPWm0OA7r0zDw3VzX?=
 =?us-ascii?Q?8QEA/krNnx5XZhYNLNNn9NXMUxHsN0Eav/gLIzjzJu/eppDg4tCdOfBE+M9D?=
 =?us-ascii?Q?QggL7ZNoS0wpYIW8z31aGiKWdJM1YFhWTDdDPLHzfSAQ1SLH8oNartSKU+PN?=
 =?us-ascii?Q?TrOJhHqnyuz1aaB1MOES6cQr/F4WjuIoFaAn0dhPlQDBnkIR2nvxb5c4FeIg?=
 =?us-ascii?Q?cyYgobGqy7ANzvPEt7Tl1TyWjVIvl2IqstU3s6c80hTvHq3eGUR4xlB7K+RV?=
 =?us-ascii?Q?9CS9jWdLGAZXnZf7gFoykYC0mUYkj5WL542ylLv/igjWEBZDtCxdsELCWiR1?=
 =?us-ascii?Q?N9fJqBhXGfWD1t24qcyss+zbch/4M0dbbtEmrsJHVWJ1duJ6SGtjcc+lJUvJ?=
 =?us-ascii?Q?P5m+WXrJ3YUnHXjA1whOUFdtHGoJWmSh1p21m3SW3CiOynaOIsOCWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:13:11.5927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0036b2e9-6cd2-462a-6e9d-08dd12f499b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871

From: Alejandro Lucero <alucerop@amd.com>

A CXL region struct contains the physical address to work with.

Add a function for getting the cxl region range to be used for mapping
such memory range.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 15 +++++++++++++++
 drivers/cxl/cxl.h         |  1 +
 include/cxl/cxl.h         |  1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5cb7991268ce..021e9b373cdd 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2667,6 +2667,21 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
+int cxl_get_region_range(struct cxl_region *region, struct range *range)
+{
+	if (!region)
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
+EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, CXL);
+
 static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
 {
 	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cc9e3d859fa6..32d2bd0520d4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -920,6 +920,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 14be26358f9c..0ed9e32f25dd 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -65,4 +65,5 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     bool no_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif
-- 
2.17.1


