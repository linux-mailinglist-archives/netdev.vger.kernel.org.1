Return-Path: <netdev+bounces-255640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBfiBJt4f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 17:00:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13539C6624
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 17:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6090A3050A35
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FE3242D9B;
	Sun,  1 Feb 2026 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KsiZfoU5"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013011.outbound.protection.outlook.com [40.93.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CCD246BC5;
	Sun,  1 Feb 2026 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961329; cv=fail; b=UOx+MQZm620CU1mHxJWSRHPyQcc3u2PCiWj5YNld+T/A+PRpGn8MrOE5Au/orQezE1eH8oY70zrbUd1+Gbp6R/r4beyuLl0T1MsqppzatyuU8oZNRFNLROOLjYbgCX6qF5xQgD45jDWPk2LtugWQd4HUJZuNOi6RjMmc0oGPKGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961329; c=relaxed/simple;
	bh=g1xgSiiO4nFJ/uXgEcKF/euVlbcdgwkz6flY/HCUGUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=No1xmsA/UwzI8W4SEkHlipk2rMZRTnifzJtIj7363G1mO2VMXhnCYGH2N5H+uRkf24QTmAmtkfNafaWaI478XpKxsTeanugioiwgU1hS7DxeSXYA4HGn7v593O1DZt/JWjvRb1ca21IFeyWnU0HOGXHS4HmZ8aK9Bq7FqzwUCmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KsiZfoU5; arc=fail smtp.client-ip=40.93.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQ6xnlKsxByRJraJ0QbK/Bugh5byxCUdZW+U7weiMD5/w9nn8Zma/dmii0tKsKlQVdmAgw1jqdT6bQh5UbpXLUX1W0+gEllNXasxZtWo9o8cG4pUwEnN1ZqiXnwk18DR2rC2BlkTdQCKawNJlwEbgbM9u+7hAyopnLCue0aSoME23RiZhmsQ9Fv0NeIeHj90P0zOMQSXM4MLNs5tK/4epxpXIVL13og24lTpaeOzDr+8tJC193ssa2JHjxTqCijZ0UUY7BTztjSLWwUiK7WbsW+INOmKgklUVKeLOT+at2lKq8jfD3g3uqmbLBNqkoUQgjKk9BsjD1axGpJ36f2bNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2QaTUqBEDGug7/Z4UKIxUtKt6VSlt8y/kO+poEuxBw=;
 b=BTByD1uG37EWdEhLlzYvJYX5hVFhaLXS4rCAAvfR88mgT94TEcbvcHEngUzvdljCQDsZLp9b1Yn1AE24mFuWnPv827x5YBskskHjVs7gMzPs5Lwi179RgsgbFaoEeF0bCLfbDbQFaZPkQbLLJRdCYAlco18fw9xAx+aRqF8AZbZ+meDdgYVDkCGXiamtp3GSvSL08xPp/K/Cb+I8nhsZnnphq/W56UPioQTgUF1aHoEM0xCy4OF/mtGeEA7FIxEQ2LkqOYQ1uh2n7gCuEPs4LPH+icTMS31S8fnHkKl1TTqylJ/VnALulioAMFL8Q7nrZFhIdzYKL6pHefHw8UQK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2QaTUqBEDGug7/Z4UKIxUtKt6VSlt8y/kO+poEuxBw=;
 b=KsiZfoU5d0mioQVetQp3bvAaxv2YJUjPk4CsiY3SwNM9Wppp1OAen12aneq8qLtDDkAJTczNAi1v7ggYvYLQHpmcBMWr8yeiw3wyeD65TdRLW9tRg5VoNJae6q2apXXm1QUnP4pCwMwCw3spUlVJg69C7W2ZsldVYYIeUmsyR6Y=
Received: from BYAPR06CA0058.namprd06.prod.outlook.com (2603:10b6:a03:14b::35)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 15:55:24 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::d2) by BYAPR06CA0058.outlook.office365.com
 (2603:10b6:a03:14b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Sun,
 1 Feb 2026 15:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:55:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:55:15 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 07:55:15 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:55:14 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v23 18/22] cxl/region: Factor out interleave granularity setup
Date: Sun, 1 Feb 2026 15:54:34 +0000
Message-ID: <20260201155438.2664640-19-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a28df1-b010-4782-05fa-08de61aa4f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?as2jlMPtg6uGZnd6VlriKZag9XDIF2AbDTIgq3VO/QCXWP23Wy9aPkjTSxEQ?=
 =?us-ascii?Q?qsWZOkml1+ByYHn2+atq/IXFXD4fzbKKcri3BYoDlhyQMM6DxFRGWTUAkZYy?=
 =?us-ascii?Q?fKHRfyrqPOWYCiByYCntJXSOX77sh1s+x9FuQ14afdpjplsqPWp2bJL8ofdT?=
 =?us-ascii?Q?RiBivqGv1+VcPO1nTCob3Pbqapv3paJE25uPF6TsS4oU80S7I21LiK9DKRdt?=
 =?us-ascii?Q?6TN7iyin8bDKcnLWd3IWw7B41JLsp5YQS6e4IzXedjZ4Pig88HWXhMBPqHW4?=
 =?us-ascii?Q?7KnkLm30xnSVB6xYyKs04UvQSnKVw6wxEviQGLEFUbarAJromJucBA3f9fk1?=
 =?us-ascii?Q?AEF57nVKqM/M1HrbAzj+ycTrKo+d2n8tXFGO8BoDakVeGeqlqKDXIvdFaDoM?=
 =?us-ascii?Q?nA2DznC0lVLpNJnwLoNBkwfPTlcDUP6iknb5Mh+0YWy++layoK8r0QgFWRCZ?=
 =?us-ascii?Q?SXdUingTSJTeNLxm11xWsb4PWq+xr/NH4a60TpvdGR/BCDzESnXXOwkqM8Wc?=
 =?us-ascii?Q?5a/2pSonJoypbG+ZZCTv/c5bYMu6bxA3+9Dm6QAipToPRZ3mGEsHEZQ78Tve?=
 =?us-ascii?Q?ckv35wZ/g4OMiYvPz+XHCmKslePu5XJRx1vZ8eSfbrbuIJZwIEWxMB40vqOH?=
 =?us-ascii?Q?Cqooh4302TpVufjvg5yNKyaOGTdVumDjCJMOplZBG7BWCXZV5G+YCroy3WX9?=
 =?us-ascii?Q?2rYGW8PfdBbAoHETcQbDyBV9VoRqZXYbB3KT671MSZaPk4dBwR48n5hcvDl8?=
 =?us-ascii?Q?SIS/XdApM/p6uMnMaawInzaRzFjMMaZFbj/zWamsNiSeeEF6IqVubJSWq2hD?=
 =?us-ascii?Q?QzJIkMAl50QzfCFVhMAF0tV7BBxyOEz3nH1Vo75AqqKzOohIOrKalqdMwFLJ?=
 =?us-ascii?Q?YLX3io+OOGk449/ktMs3xzMH8o4x6T090U8e0eRvgJpg5GCSa3AOUsBiCwkb?=
 =?us-ascii?Q?mfT5TLVjU6tSLe8jjHYWLHOJWIV9T+HsT6uEXyc5R0nWEQbN+E00jsL8VYC8?=
 =?us-ascii?Q?39b4sepxFY/TlhioyKZWARx5mB5eZKZDbrUSqrtLwx541J4mnZbeWLaXGR4J?=
 =?us-ascii?Q?afsp1IBTsOp3brhxrHk1Lxl/fIvd/hrpLW7uslOIPUCSnXcfH7ssayWlsOhE?=
 =?us-ascii?Q?8xSjEo1bSGiV3M4x7cz2WbjPdVj/pm8zzn7SGdI6ZELtcDgqoytFKUCJIxYS?=
 =?us-ascii?Q?9ql2TYusmhdAtxX2hp7IJ9cgR+9ZQA+DCZypNz0wp6Y+JFXi0+5sufoN+Jd4?=
 =?us-ascii?Q?5d6TTnwhFaF+JqQWfLMNZpi0X/N4LWmXm4OR6U/pTpzfcti3hQeN6GfGYl7p?=
 =?us-ascii?Q?fc094PbrJOx+K1JB1u5TakAFYbNisu0G5WZnlmwrPeIjQW2JXT2n3h2AfBVV?=
 =?us-ascii?Q?OxmQafYUcMS0WlMYdIyFV9qlBgrvDZnBYzGVe9DCvy3vGvzlU380DkIvFMR5?=
 =?us-ascii?Q?kGKu7mkDASeAb70wtz5XHFy0hIL+dTi2WQwK3SkE2rxCHdDXAJQSRX57WRXw?=
 =?us-ascii?Q?ZNQJvbzCY8imqVNOfBVnx03LcQ+JKFh1uEIm/mrCcKDJF3aehaCNwK8oJhzh?=
 =?us-ascii?Q?W/h2c/cso2bYnfFqznezpr+3fa9tpAN924WVzjH5rSTuiv/vIyuponfJwnPo?=
 =?us-ascii?Q?RbISyL5HpJCS+tjyV5cQ1N7+fXe7wpLD7C7+zAVe4c2CoF16oUm8aaXQfCN5?=
 =?us-ascii?Q?c15BKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k18NP8ddrKxSOpymE6wOyGOswp9mUIavc/TDB1W0zdq8bQpIR5F/t2Gi7PhdpEpaY0l+G8NEQVk13ZJzyT7lRoi0Jbw9qtNY2ohuiJxy0kxUNQc8OArSXvacEg0YPSl1IbTdcwdqJaGHnYYXRuztAjN3wbLW8FnHTECpJwerESAP82+FjLkJ6hAbcLxyaHpCsXVhLAnCpN9XmNg+fzmNRqsT3Hu9wl8jJTDgN6lbj77hDzX1gA3XjBQ31XJSp19rhI/5X0BsURXVdV9SRNy4TkKzVwhPWNFsW7Li1kpcZcfPiDQMdoEXwXjqp2vOw7R5/k5Mx3EedrSjaGuUsfgMNoACr/1OwdQa9/FNEMLnmtXuBfpzRi4stIA/Qvs8Vl3pmFlogbbi0Dp1K4xq3s0hE3IU3gKtB6E62d8P/oiZKDY0wYsmOUjgWVoFKi09cOqe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:55:23.6985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a28df1-b010-4782-05fa-08de61aa4f71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-255640-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,nvidia.com:email,amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 13539C6624
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

Region creation based on Type3 devices is triggered from user space
allowing memory combination through interleaving.

In preparation for kernel driven region creation, that is Type2 drivers
triggering region creation backed with its advertised CXL memory, factor
out a common helper from the user-sysfs region setup forinterleave
granularity.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ece1d3df7cf1..63c2aeb2ee1f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -559,21 +559,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", p->interleave_granularity);
 }
 
-static ssize_t interleave_granularity_store(struct device *dev,
-					    struct device_attribute *attr,
-					    const char *buf, size_t len)
+static int set_interleave_granularity(struct cxl_region *cxlr, int val)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	int rc, val;
+	int rc;
 	u16 ig;
 
-	rc = kstrtoint(buf, 0, &val);
-	if (rc)
-		return rc;
-
 	rc = granularity_to_eig(val, &ig);
 	if (rc)
 		return rc;
@@ -589,14 +582,32 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
 		return -EINVAL;
 
-	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
-	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
-		return rc;
-
+	lockdep_assert_held_write(&cxl_rwsem.region);
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
 		return -EBUSY;
 
 	p->interleave_granularity = val;
+	return 0;
+}
+
+static ssize_t interleave_granularity_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	int rc, val;
+
+	rc = kstrtoint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
+		return rc;
+
+	rc = set_interleave_granularity(cxlr, val);
+	if (rc)
+		return rc;
 
 	return len;
 }
-- 
2.34.1


