Return-Path: <netdev+bounces-152297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF6C9F358C
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692871666B5
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0037F204F8B;
	Mon, 16 Dec 2024 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ipl822iB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5D71B87FB;
	Mon, 16 Dec 2024 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365489; cv=fail; b=Xez8H4SYJIE6jLXPouvCk6ob6aMCAwQ4K3Q+qypAnjDpxC5o+HqayrfG4yruf5js8W+HnQcap6TVnHo2/Hd867wUxNDFpKqfdYbrLsrUZu52r9krPyV9C0XszoZD1WWEbhxr7CAXSkLn7mmnAi3uIWpdoG9ie0pCQzUhUQ8UA0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365489; c=relaxed/simple;
	bh=yTJ3GlXO9NchaxYYlHh79Y8LjDMqKh4b1/15SRpt8Dg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZN8JUEnbVqxHiG6THKIAW/72bDOSHFWOknElOtlWle7wP3vpkCVYA2Bsokee9x79HXgIh32Hz6ffr4O2PgfP/q5rOtxu9A+33TEzjlWGxzg9hn+d6PDiLei4FUmcQQfF8Wro39NYvSuDLOvCe0i2kGmKdBnz0SiC6ieii+jlm/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ipl822iB; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5gjGu7kIadD+dWiMMRAMT35JWaUMTsY6SR99UV0VDytF/FtkeS+TBfV+lIX20oEAdvJyqGuo2y6G4U+6R45M3wvRynf//yYVlC+nq55N5y/tPPdA+9/9IlcqjBQrArFhpPe+Pzc8dB9I/eb12Hyfs+bUVoodSqw7u6dfLT5cOF3LzP9lshEmDpxjbaZ03yj3c5IeFM4M3QBnrvvoyix60pSLx4UN1TBdo8evYOthhK9QBZLjVQvGP0lpw36gp98XStNpU10QniCKI0RDIQryNDVT4H6ByDakdFww5tWJ2q8yXPe/DhveLXQ6ujUunAKmJHjJP//sny1yMLkdsNBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkeJ4TP/KQC/0vbJS36U5TxIeXAJCOV0+NwsnZh34bQ=;
 b=DhlFjLJQB423bK+PwQBEi8Kx3v+QIvqhQh1xOcXpxyNI9YxBVG2Tm1IKfPh+M5Q1wVoZpfHtqADbVSOiTi9KbT3RwCi1yel+jebI+mruOwum4ImyZTSLBCtlJ7ROlK5foxrzhvqN+H5aKKaPg/He2WcRH2my4wJI1uS5jiq2oLoYS1LDrUSYTOLPnB+1mpzqhQEcMI9aGCP/cOLEN80CvMDgbXjvf8HSJTuyNBXatKD33RYGt6jihcI7szKQsWBFaR5kgbb7H0dn7Q58qUN08u3d6fPAS9DtnsE/YFxd4qz2yCZ+kataoz+AXtkwxlLg/9kR4QHlV8ey+oBkcT3V8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkeJ4TP/KQC/0vbJS36U5TxIeXAJCOV0+NwsnZh34bQ=;
 b=Ipl822iBm2p1/AEys8v4AO7ftMcDLICYzb7mPpzI57DCGjbFurU6aGyj1C7/JRCwP1ne2N4GcDypTcBTnK8f5geKv3wOe7vYu8BGW0XrPuBOWJrFFfaS1fSp7eLVkU89MquXz0zu5HAgaw9W66P86OoEhR6vi2M4MexqLgK0cBE=
Received: from CH5PR05CA0019.namprd05.prod.outlook.com (2603:10b6:610:1f0::27)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:11:23 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::58) by CH5PR05CA0019.outlook.office365.com
 (2603:10b6:610:1f0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.9 via Frontend Transport; Mon,
 16 Dec 2024 16:11:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:22 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:21 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 21/27] cxl/region: factor out interleave granularity setup
Date: Mon, 16 Dec 2024 16:10:36 +0000
Message-ID: <20241216161042.42108-22-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: fee9a48b-1178-441c-27d5-08dd1dec491c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K0YohSal5hrrK8IWEI/nQAeR5YUQX88s8AbWQWkXPcnPC0Sz/yr8//ZM2UYd?=
 =?us-ascii?Q?9pNyH3ycr6+KlINtUQYFbn7n4j6cec8oprQSjuH5H8sQXR2dgBzSo1tv4Eyb?=
 =?us-ascii?Q?PEil9xUflfdek4uwtYXsX2v3Bo37mer6yUktay4JxpSIt+Kp4y27lOjvZkd5?=
 =?us-ascii?Q?SxCOWfioehifihHq7evuXJxdpu1kMs4pC6HugiotQ9uTukAVT/2x60FrkzXK?=
 =?us-ascii?Q?AM7f6NrohTrWbeo0fCAoI2uzM4o2DhXwpdPN+UvTUcGXIbkyl+KwpxxY5tzD?=
 =?us-ascii?Q?u9OJrbk0p6XJO0w5zvuGxkx01IZpvdx7LmKZ6yr7Lzg+CPdVAjI2PVI42qzu?=
 =?us-ascii?Q?ijUBXJVPTQAlCd8be/TbIm9jxn47lCXPZnEZZkQ0Mr/Q3Nm/Fj0/HmKw4K7O?=
 =?us-ascii?Q?StBpA8O4NfVlh4QiJpy7S2H6rxv1Bw7ZTC+nKdPv3VpNYVbbiBXAmQz+3Ujq?=
 =?us-ascii?Q?YKf3VZXpdbKSOvammLt/shfCZ6qsv6333WE0qdi2Fc85hqXy/0LX7R93WNCg?=
 =?us-ascii?Q?C8bXhYeguTFQMxsGxRJO0DGgftRW/gFFCU+w2q8Hun3sdfy+bi0BmRpGCDfZ?=
 =?us-ascii?Q?C6nWeDbeXYstbOYeyxyMFZchX1ArM7pV0XaKRHtQX1U7zhmhJ12MDI+qSuNo?=
 =?us-ascii?Q?w/zkaGlW7aW6C133Qb/X8OnE/dfSKqA46ZBDNYqLi1biDqfTh2U1zl4Wiaqw?=
 =?us-ascii?Q?zpNnWpjSsDbobJTuauN8fGYZYfFdqW+QFWgb9QlN2P4qR3YA+qYkKwpRH9F9?=
 =?us-ascii?Q?FdF3j3KfhkmeXDjWleJiA+Bmgw85ZSXeoiMBcqYW6WMsvrwknBagiqoMcGgc?=
 =?us-ascii?Q?nCS3DxpPqUV3otRHmR7MACYjeX3q+uCnegBwL2qfzI/k1Hpjb+NSkQNJnDS3?=
 =?us-ascii?Q?5PQDHnOPusR3yyv3jeYRSmnOgTe3yHXmmTggX89hLzOxujpYyuKQLJkkg1I9?=
 =?us-ascii?Q?Ys2XSqokOxE0TRBATS+KcZeE8aiXnxWzaLBT1P4IaKwPiXbZQRNrBF8Gkzmf?=
 =?us-ascii?Q?8H9Mmoz8np0rbgqRIv3JBNCTMe3nSOZ+kURGsnR50VpwauF2JN/0jnVUJ0lt?=
 =?us-ascii?Q?+UymruwL63yN124hEWMK6lYnaaS5dRgzqkXHvd8+YsNAXQKKtgu16yWBjMkd?=
 =?us-ascii?Q?xyjWkaroR3iuLzUTDCzpCvnwbLyB0T39F9N92BBK9qo2417OjRZP51Lq+gSB?=
 =?us-ascii?Q?VvkTn6SwQ8Wn4hc4NmiJqXJNiWhkLN+Z7DFjpa2nn/SfPLok44QZXuMkasgg?=
 =?us-ascii?Q?o47M1pQ0WV3aZ9Tlv0VUFveTds/D5Zd4OvqX2SAcRq9yjq2E596cUfhya4Zh?=
 =?us-ascii?Q?P9Rfl6yQebYwxuMTVqrZp9K6IRIjF2rGya52RCzRYf8cmCHc5qMwBnZZllQ+?=
 =?us-ascii?Q?8CUrheNQH0pgwCotuvxLmojrj1Pdl+aT6AGTJgUKaaSfs0R9kFkLOXAtyY74?=
 =?us-ascii?Q?Ha2YWkYYLKUziMNaps3l80oyupY5ZoCtFkU0TUCxsBQ6ELaJrvZUGoGpM2JG?=
 =?us-ascii?Q?PzzfIWC1Bifb8HF1JEf/+dPwSu5udAm4bw71?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:23.1766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fee9a48b-1178-441c-27d5-08dd1dec491c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211

From: Alejandro Lucero <alucerop@amd.com>

In preparation for kernel driven region creation, factor out a common
helper from the user-sysfs region setup for interleave granularity.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f02f0c0f28cf..3d9bc7d7c0c4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -540,21 +540,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
 	return rc;
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
@@ -570,16 +563,30 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
 		return -EINVAL;
 
+	lockdep_assert_held_write(&cxl_region_rwsem);
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
+		return -EBUSY;
+
+	p->interleave_granularity = val;
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
 	rc = down_write_killable(&cxl_region_rwsem);
 	if (rc)
 		return rc;
-	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
-		rc = -EBUSY;
-		goto out;
-	}
 
-	p->interleave_granularity = val;
-out:
+	rc = set_interleave_granularity(cxlr, val);
 	up_write(&cxl_region_rwsem);
 	if (rc)
 		return rc;
-- 
2.17.1


