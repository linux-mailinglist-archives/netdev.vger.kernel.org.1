Return-Path: <netdev+bounces-148179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E2E9E099C
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FC428277C
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE761DED59;
	Mon,  2 Dec 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SYLTx8WG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673BA1DAC97;
	Mon,  2 Dec 2024 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159594; cv=fail; b=Iv7ifpGoPvuDMzNS2MhdaJzvEGGqkwWYkoqEZGtafv0DeQab2Yl2E/c2LB/8Cxgs3HpboKB5UgqxSh5dmyS6ymDKULOBaC3pWmkD10xCAwOC9LeHMs2XTiraTsLt+HOXCrId1I/pOTb+2//UVXasfhrgihXyzINF0k7Kbe1BIUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159594; c=relaxed/simple;
	bh=lnO+sJpgeoGMcE9cNTRc+jLGWg7pyZPqeXdcDKpvEdE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W4vkcS20KntAifyDya0Ecjsf/0bbOE/CxRXxyHE4kRktXr3EBvZVSM9HdhsRTlKRK0/B7RcvrA69xnDRrBjWJ7cchSiT5eFy6Dv0l0MIIuqNQ0+SinS/Jb/61INUNyqrCdG5EZ4YvyPgM36wZxs2Wore8cCcd1+Yx+zo3umFEnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SYLTx8WG; arc=fail smtp.client-ip=40.107.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBWjzHvZt+8L7cGTJZQ8p5nKdtO4tLc2ofK+Bngg9uBcRCy/EvLlt9wxIGaKEhd8yuZV3GOjBfapyYCKEECjZt32TbSes72mVgs/YvjouOCasxHZvNDbwxKgc6HnGI4/E2bEKeuOFiZvtZlmbHB+68MnGlCsz4KfFqQEn3ORNiabyaNS3YvFp3sjRMdepikx3GemUA8yI4EE/iSkN9+WVH2hY2NI6S6DFbaGwsCLS2Hk3VyatKxyFQwNuQuXY4aoOyFPwvTqPZfMSqSEYLS9MmoPo4UCjNSoOmUxLMjUOW8pAb7KYs5TR9/P6qC/gOTA/pw7NyEQHZAiPjAFQz/iUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5wNjAtJHQs/eIfV86ss1HV2F0Wlws16zK9CmnUWXAU=;
 b=varPWY8tfCy1TBzcUbwsAxomvx4KT0GyNhRODwuhNGVYaGLm5gG7DJaU+xdw/N5rxzZtfMpkYbaLVw6y6L0j1Yghj78Bhw0cwC9xYBENCxsQ55x8u493Pv574ZgJflhWr0M4Q7RNfvv3f+q4owtLUTg+0kn4V+Fa0M9wZPAaqTRJkBwYUW7GXB3Z/byCquGRO8YOlHyuG3lkgHFsEVzbVSXfz0xGwq2u6Ec4LYvFmpgnABA8Z8HKRcqm9EEd8CWTvfrT6VwbNbEluVzlQ6yt34IZ9zCm2qKYtc/KhK+wq4Cm4KPnBIFmpx7sV015TskFdqYayO7t78vNjOtQl4KmvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5wNjAtJHQs/eIfV86ss1HV2F0Wlws16zK9CmnUWXAU=;
 b=SYLTx8WGzIl3otRJarXFV6BS8x3d9V0H5dO6EiOEzkVvAjEe0+G1j1pStSck0dQCCa8o+1xCV4c9KG4UZVU+58EujUTp5QAvRkX5UnB++bK1B9rezt1XXSZa5kIo67SRIbcG8dKl1fAzCPFh0JsWzCNiTa81OjpjlzGPBvz7b7c=
Received: from BN8PR04CA0049.namprd04.prod.outlook.com (2603:10b6:408:d4::23)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 17:13:07 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::aa) by BN8PR04CA0049.outlook.office365.com
 (2603:10b6:408:d4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 17:13:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:13:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:13:02 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:13:01 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 20/28] cxl/region: factor out interleave ways setup
Date: Mon, 2 Dec 2024 17:12:14 +0000
Message-ID: <20241202171222.62595-21-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e52d9c-f282-4599-3ca3-08dd12f496dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ybyx0XJ/TGdxaR1GG6Xzjj6VGeYpWIW2KMwi7VbStVr/jBQBqOO3EvkEYoef?=
 =?us-ascii?Q?F9nfzDLxNg4dQ2Q9uNzubjgtShBmkxwpqIBalMwLd4RpDWHJJLgaZ7oLk/7k?=
 =?us-ascii?Q?lNTfmN6AEo2oV6orwoFphDYkAV+4BbS6uYuH9mtffBqdIL0P5c2WPtn5xWZH?=
 =?us-ascii?Q?/LsNHv9gjTwcceSEihxwP7dxlLoNbj1iSV7atuDGuhrhhnpxMBqpAn9roe71?=
 =?us-ascii?Q?WpsgTZixG7nVK2YLvIYJEjEUVcUrrcB0QJZfTf/Q5QD0lie5e12PpVAHBz+b?=
 =?us-ascii?Q?MDiNL5d83gwFOxqbGOPTJl2lEQax3FCO5En2CVOd8ut/4ur/8pG/mz3kj4ix?=
 =?us-ascii?Q?RKVNeaZXezQ936+rAophk2rYxhp82nbgu/5wR++J0//BS6ymQ/D/xZUHOP87?=
 =?us-ascii?Q?4zgoY0xrWTzQbfJveIq3y0DEp1wo6Mwkex7IQNZeynRc1jtTjOLrsfMkpiDh?=
 =?us-ascii?Q?kgSbBUBeM9MyRCn23Otx1G/0TDjvsi9Ys8jsXmtP5fQNqbGTkhgoDdb1kY26?=
 =?us-ascii?Q?ADQAiaJbs6PEUN1q8VVZFTEGLK6c62sq+ikCYZTYt11UjUpGTAOjTrewpf+2?=
 =?us-ascii?Q?IDUiEHLRzlzwtAUyyGYI53anJpwVxNQcq2jpXxnXLB7TwxvxbOsP0fEs/uGe?=
 =?us-ascii?Q?IkCAZhSQ09yqA0OtVKZ1Xl+FiCl30P5UU6uWBJXophkiyKtt7yZzfN+tgsL/?=
 =?us-ascii?Q?pQ4zMoUxzPrmM0W/6tDid+k6iPsW9vtvyDmjqEm9XEauvnSFw31kkueuoSBu?=
 =?us-ascii?Q?dbIBtWY4SE+r/FF/2VPWuyH+LR5VbEJILl/SoodvwMq+DOVluvzYTHpAk3bl?=
 =?us-ascii?Q?F+RXitaZ678TLusMdJcBJPPoJl/vu72hDUGYYz8gHGw1qfovFc2tnNKMJueN?=
 =?us-ascii?Q?GqWNmWPdhvcoUvDBomYhshFNuLhIfiRlfeeE0D4JVXcySR1k+2Q0F/e3ZxRK?=
 =?us-ascii?Q?T/L4ro9bibskfmzS+FOfQnsINz5Azp32CpqvwziNYjTfjwpZVWNyzJgCOMyC?=
 =?us-ascii?Q?OwBegLFscRtilxE7P/LSQvmui2jwVcJNZ37h3ca27SMVbMd72kVCa70ge0kz?=
 =?us-ascii?Q?vq2ofkpM48+QmJmNDxjNmyzLg1nsQxK7urSPUKdeSIkkqq06ktfmgTtBIbQY?=
 =?us-ascii?Q?Av64QlO8HwNXeRnNE0gxxjS9L7upIrmgI7dNZCNNOcnVhOnvHDv6MrNVTlxG?=
 =?us-ascii?Q?ZXs70ER/s/RROLxH6DwKLmVyAc6x1CyRPGsInnbr97EL/scLdY2v6ZlhOdKU?=
 =?us-ascii?Q?kwW5clgrVdNVShb1ZgdKAxQ94U2lpNZVRnsT/cNCKzqyUbvlICaCp1pc9nzj?=
 =?us-ascii?Q?1+6yEduMO2x01zvPM3/10+90FPmkWHx4d4/gTdi86ewRRH8VPC/+TAaFNHNP?=
 =?us-ascii?Q?FVdZRid6WJTnO29Wl69PDK1hclwyeGFqAwJPSIoIrbxhNBlcHzc1xekVsjPj?=
 =?us-ascii?Q?gXESQuzZnSloWl6fYwQgEuRgBPsm3N7LZkictSjR0OIsaPZdnqymVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:13:06.8255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e52d9c-f282-4599-3ca3-08dd12f496dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095

From: Alejandro Lucero <alucerop@amd.com>

In preparation for kernel driven region creation, factor out a common
helper from the user-sysfs region setup for interleave ways.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 46 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5f4d285da745..28f65478b135 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -464,22 +464,14 @@ static ssize_t interleave_ways_show(struct device *dev,
 
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
@@ -494,20 +486,36 @@ static ssize_t interleave_ways_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
-		return rc;
-	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
-		rc = -EBUSY;
-		goto out;
-	}
+	lockdep_assert_held_write(&cxl_region_rwsem);
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
+		return -EBUSY;
 
 	save = p->interleave_ways;
 	p->interleave_ways = val;
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
 	if (rc)
 		p->interleave_ways = save;
-out:
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
+	rc = down_write_killable(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+
+	rc = set_interleave_ways(cxlr, val);
 	up_write(&cxl_region_rwsem);
 	if (rc)
 		return rc;
-- 
2.17.1


