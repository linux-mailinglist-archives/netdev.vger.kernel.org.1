Return-Path: <netdev+bounces-200683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDF0AE684B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E6B5A08EB
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034AF2DCBE2;
	Tue, 24 Jun 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ece1LaDu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2072D9EE7;
	Tue, 24 Jun 2025 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774489; cv=fail; b=tVDgLfeBc3KAg201spVvEpuo1diU5l4h2y14QBVuYwvihWCF96cKRYSBo4QM+ClFcsv76OtxidxbggGlSr6c2YV6X6NzrcHW9KuCAxvM0wJrYEUI8z/PdvCGDJhkV1oBX1NMQlYtHxcO51hOi1RzSFi8IeC0lb/UmOC4VCguhZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774489; c=relaxed/simple;
	bh=4ak4lDbSIrLYklE5BOzeRSs39HFj41aYXKCOtAsceYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMivZQlprhxarx76CP45fwRE214nACoqLVqLn9WP5hT+Ntk5MhG98od0oSiijFEYUoXV3ocYJlKMPtbFfOrvNsGZJ/Jo5iH+O1aod4CDeLdN+Y7VXVd4DgTMWVK6PlVpu/7WaSTOOHSizDPeQ73qF21GltO3eDX7yQZg9KODHzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ece1LaDu; arc=fail smtp.client-ip=40.107.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntX6Iv9tlzOgv03oxzkBXoFHHH/eiIqM30HstFSafMChX58FW3HbnDmKNe7JbJOH2zhj3t7aA0RzJ+kektIZOobn5PsRHnmKG4EdzL/huE5RG6fk7J5ltmeaDYHUGzp5EdBscDAQfY395y96eeRmU11m7fve1CEO4X+2xPoFZYaaYAK+LpB/UrgPZm1Ss0uUqsNw10GCrIXmYAeSp15sYrr2G5FCKCZmsUyQJceTW7bIrfqUEU2gkN09+eyNu1zRy5OT8Q0l7pBbzGGyR2n7NR1ATpFYWUYsRU1kUPRyzCKSil159kyg33l3BOxEmscbEQoAyzAXBr5CiMSp3v6d5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NNNhR0MEBdz0Cgl132SmHfa7MzYBq1OPpNcxRAKYqU=;
 b=J1YQKMSh1AU9JZXFA1ToG2mnhqY/z7P2++AIWnd7JvxsivWIEcNNjxmzqVR8LljPEXjWefiLsgtsWLLxF5M3I0fBA7tzpHc/anYF2vmT2YJb5YMAyuKDjxoM7nI98lC67RWq74UGN7j5mNcMzlW9ziLrdzMy8kf+CapU7qB0K1rXLNL0KBCzcv9eyTHBwo5p22H8W9jv6iORKZS6oKMMCG5x2qsVamapzy3WOLg2RpO56VY6A33NcaewdZWd3O31RTtFyAkzWg5iL+ilCLWV4YUrNQV9tvHSIGJt6NlwIfpDWF2oEqUtOasF3dfCag/qONBP10wOwisIQs9hE8QZWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NNNhR0MEBdz0Cgl132SmHfa7MzYBq1OPpNcxRAKYqU=;
 b=ece1LaDunDMChoskhYqfNp8wBNS+NuutV5XUlBNsq/vlnvTN/H9q4c3I/H+ZAf/rQtX5JfelcrHjqllq8CkVt+egx9tpToZmtikAAF4Bm+6AyOnb0gfui4dKrUmknXouJM2txyz3PFb8PicR4OkkBnXs1WoQ7WYWo9+UoNV6BHE=
Received: from SN7PR04CA0225.namprd04.prod.outlook.com (2603:10b6:806:127::20)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 24 Jun
 2025 14:14:44 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::31) by SN7PR04CA0225.outlook.office365.com
 (2603:10b6:806:127::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 14:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:39 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:38 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v17 17/22] cxl/region: Factor out interleave granularity setup
Date: Tue, 24 Jun 2025 15:13:50 +0100
Message-ID: <20250624141355.269056-18-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 537c282d-7520-414f-6659-08ddb32977c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t4CVfJt5dsyWT+vJ7+4zic5J6ENwzFylEwWJ5FN+6mwbY2NyeL5oJli24pOa?=
 =?us-ascii?Q?aYeTLqH3CM2B+ZFdbl9VeTzH31G6x9TjJWp4hUl30joUshzoWCMoC9Es+a+3?=
 =?us-ascii?Q?H1cTj/Jvt8gzTwJLUBz8wduls1aszuZ0YSx2dqEWNRe9d5MfsHheobkxxPkK?=
 =?us-ascii?Q?iI2XMfG0KO8mlgoASR56fRjLqVCD/EYX31tAbJx2B7blX0SjpHlrEYhkFzCp?=
 =?us-ascii?Q?iPvZsAeVj8iOPV4THvk3dqZy2sqn7CBOKK2N7GSqSLYkhKcUDFiGgke9v9kg?=
 =?us-ascii?Q?GEEJa/5qwVeWRH6rkv7DamynyJJTviiPx7LKpZMGFouOr6DeencuBHlsP+eZ?=
 =?us-ascii?Q?qHn6xIAMHBTdaGNtZoF/NVDKTSB70RCGeKaVStFES3uixHsfoUX4hGG2e9XP?=
 =?us-ascii?Q?knMFJFIZFX+lPPnQVWMwUAueJoyI06SqvuPnUfCMVcSBs/9DrpL2wutRgu/I?=
 =?us-ascii?Q?EOIyHCeMN+dYDvc36TDL0AakOIyxVw6lnf/AnDS0tXxmKvuMwbCMpuzN42Xr?=
 =?us-ascii?Q?eYvg0QIS9/MyltlPzVss+Ir0PXtlmbByEKM0V+a580SRlhhjKf+FDY6IVX+B?=
 =?us-ascii?Q?VH19tDE/0TzUFA6n1f+SKHzaIUByjy23Fl6rY5A1zj9x3yJt6qj7pqGIVw/N?=
 =?us-ascii?Q?hBio3k4bwpF1FrIFSapYfvMIjiwUSPpEQiCwN3KJ5NZcdgcxk9H/uEaFLKuG?=
 =?us-ascii?Q?cLe9XNva9t8FKVkVZZOsaz06IcE8P4W34kuHWgK410KT98pk2IRt814y3/zR?=
 =?us-ascii?Q?55q0BPMwkUgmv9tWL7AOqdg0VkGGGOTPOJGpQ2jt/OmtXeMM/ocJN2jn4NQI?=
 =?us-ascii?Q?dzvxmJ9YS0A3gHYWkyfrF7LOkJsJZ2xahb5GQSna7Ki8dSV9JHdWQ3ZXsXjE?=
 =?us-ascii?Q?Q3wLBVCfHP/of4cvacxxGloOrxfQ/RsZhJDHt/WUf9ce1yDSDFuDSXiy0Svi?=
 =?us-ascii?Q?L/hN63ZdQXJlbbAq8eEFBJe/sXy05AfV69/uT3iYKTHYCpmC12yeS0hti9zC?=
 =?us-ascii?Q?YMHtWQY9TZPFHaKPP+Y7RdQgl8EjtMpZvoe28pErpHd3ARQxMHXpUne0VIsz?=
 =?us-ascii?Q?8ONedyM53OiX/AluNCUPngoKqGKt32aqSA+FhI5sjLJjmhL+OyW/Cvp1vD4d?=
 =?us-ascii?Q?wXyauWMTyxJqBO5/IxMdTsA+Gmpu/ZRuvIRtLc8jznUyHI+sUR2oxrvOcoif?=
 =?us-ascii?Q?28Lm20zPqbuTOSwyEFTvYolvweDc8NIMb0gKQ+qImthggPfnTdRnHMA1Vjoo?=
 =?us-ascii?Q?UqnzCfNvGx5yn14/x6rNhsjVfOVPsGNUtN31pZyLgaVkUn7ydSnx8lbIrXqY?=
 =?us-ascii?Q?/eoYhNXR7VUn2UYIytDeiHbqP+xrkmkl1ZaO0wTyg272cm0PnIv+bFtgi5bt?=
 =?us-ascii?Q?VgfjM+wsXm3V7Iq8bflJzN4xk7n+UFdLwY00qMsMisTeXGpzxWTWEXBrFOn/?=
 =?us-ascii?Q?j3RvKXpCu07dARoeI341IL3O7hIVoie2TYuWAUNbWFBQ1VPn8R7CCvBpq+I2?=
 =?us-ascii?Q?M3PNxnZnwphfr7EasSxG0Exl82RkSFR4A/kz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:44.0454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 537c282d-7520-414f-6659-08ddb32977c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118

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
---
 drivers/cxl/core/region.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c0ad6ff67977..21cf8c11efe3 100644
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
2.34.1


