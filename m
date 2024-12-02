Return-Path: <netdev+bounces-148174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8240D9E0996
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430BC282510
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29AB1DE4F0;
	Mon,  2 Dec 2024 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o/Uh3rWD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCA91D9350;
	Mon,  2 Dec 2024 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159589; cv=fail; b=g838qnEv9lklcxZ/woozJSpEr51KLVBTht21VwPUoKI5OYsyZgBhO2f1FTfUgdgzveW0agFoD7YvgHQTnmT/MrJXu2155jeFi4Cxec9pgxZCWhhgIy/KCV+0DaNIFY0l2Qoja9Qe1wgiTchNerH8aDFtKO/y8+mWakfYcTmHoN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159589; c=relaxed/simple;
	bh=7Zkbrhl5PrxvCrWhiSS8ZptJLjUwt1Is3SGYWKPDpno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/dUJvav2z+MXIKEAdi0FuyONVmv/KpHjM6qiQ3MPfCC8H+Jw6ZW9Gn2CmHHUeKTW/HJbywrniehscZ5ftqWEMR52Rz5YmLmPy2BONoVv8IsZae/xaTSC5u/x5vwGr+EqYxh2I7Mqob0B1QkpD9SRyV51DeHLEuTiDPO5sI7BPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o/Uh3rWD; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWGOpeBpZniXo2c1ywd9FY3ODvh+tvfor73uphCYX1+iltT9iwiTyt6blekSUUNyBLWV8Ye8bGhKuaquRoo+CZoldOwFx94ooD4wfNpb4BDfiOqq0r9XikWNgB6gjL7z6ZE0CVlRJ7dWML+AF1oSxQV6UUsoH35A1Ns7bTDI/hJi3mv2eY3CV8UqsjN8K3+DkmXjBX9oDg5YgzXSZaNohtau4Qli9u8OHeI4laIqT17TxJUpRuoxNXJAGN9zv3FyejfqcsSqVgH3Ioc2Xc5MqEDHV2S/av6NO9GMYu7/SrmYIeHqKi+htP1HX1tQOZyk2kdpDIkSnOKqmf7uSNK1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MnCsA3OL3jfs16qZZiPYNZqznQTjHnZk0LzLkSad/0=;
 b=MCQdRS4puebenGQNozWXKBpNzLmkXH8xI+ocWEBeIHl7oWD2AhI8OKYuSu67LY40T2rjMxiQITRkvrd8MZC911dF0wMXlSCy9vgIvqighRz4fGU6HZzMw1pvsarHJGBMKUrKvRxbc7RM18f8ESZygc31i4dA1a3/Sw/ZV3wAoti+WpqJeyX8ZEfAxa+Qex0/2HX0YP72+Gtj/YptAEwv1T5e/rwYkqWJ+eOwLI+dQLSsyXjvHHHCrOFvNC+88JE0g/OM1LXjDNC41yY8tn6OD4rU6bxikXWGesMHuy+uHtXrLDD53rviwOO1+UesjVV3tEcJZ/XJ5eqt0RkmbUAa5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MnCsA3OL3jfs16qZZiPYNZqznQTjHnZk0LzLkSad/0=;
 b=o/Uh3rWDGeFhEugSTAuIPF7YEOUcsb+wqlg9miuOcm0bqrbRFstLEr0dr9tDQlE4omfDFaq3q2fOYh28L2YwvGsAQ2A8t2A0GP42AMWSLp9JVSlkQw3S+WYWdIhOPK9b+o0kWGWsa8e1rdySa/R6DWMXEr5qLz6YS5pTa4XaCqc=
Received: from CH0PR03CA0239.namprd03.prod.outlook.com (2603:10b6:610:e7::34)
 by SJ1PR12MB6195.namprd12.prod.outlook.com (2603:10b6:a03:457::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 17:13:05 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::da) by CH0PR03CA0239.outlook.office365.com
 (2603:10b6:610:e7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 17:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:13:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:13:04 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:13:03 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:13:02 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 21/28] cxl/region: factor out interleave granularity setup
Date: Mon, 2 Dec 2024 17:12:15 +0000
Message-ID: <20241202171222.62595-22-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|SJ1PR12MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 37dd4455-ef73-4a23-8f88-08dd12f4956f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?474s26W5v+8d0RulakOAX9OMpgh1xChLNSnH/AhTibVP5a0wBid7EerTxXxf?=
 =?us-ascii?Q?/7Aji2zSfXrvp4l7zJU/4GEWYHIfvIrAnk9l0DSsuSGi++j8xdOAE5hkFsp5?=
 =?us-ascii?Q?waMXMXTaoyqc6hqxB4pUqhd6uA0S4PH20GoeHRQ0en+G5X3gag1+AJdnVteg?=
 =?us-ascii?Q?1fkMjDE9ai4YGkVGoJjEbL0+sjHYOC4Shjkjz0tnZrke5LBgjhwMBDIxYpzM?=
 =?us-ascii?Q?2Aa4FqiTplIFvB/DOGcphLuTN1TS3A1A5v+76IxGhzPh46YFtew5Zu79yJob?=
 =?us-ascii?Q?VhNBi/kifzyVPYtPNvrk4+d5G74y3ntcTV8rqZ69jSpatFcDKDQ8K3NazKF1?=
 =?us-ascii?Q?nJFs7FbLu1Ur/ZahxZmzc3njm4XHlxbS3eTqpGEHwq8e1btAKaFiLuSD67nr?=
 =?us-ascii?Q?E7HeHfYNbTatvkfDVgbxf692IeKhmXFwf/6R8mZAEJ45boQSWIVAUq/weZUm?=
 =?us-ascii?Q?I1m4dXvKuzYTIxmuXPfTa4FOxtRM19zvLp9Yn/7u+iwb8YUjgVbWlOfgj6el?=
 =?us-ascii?Q?upfHfEbeT2lonFR/SEnoCLJHXXf6eav7pIjX8jDPU2hCZUubBr2o0QHljZms?=
 =?us-ascii?Q?+iaojV34cC8yXVdGXoHPRl1QZGsF2+0AUUUWpovJF07aaFsUhjU/ESSEglKt?=
 =?us-ascii?Q?U3lvq8sYymyVQ7m1btdUqLudKHnjwTuy71ovVVOLNKPcQeeqZY0TyAc9CcPI?=
 =?us-ascii?Q?igv0cXcevbm023wfNPWiQWxNT5LNDpclkXpsdjoIkaSUzC1pU3rox0isK1Wu?=
 =?us-ascii?Q?64Q0UeexWlElwWpIv4qBs+s8lFuDeVPcTrzguLEhdyio50Bg+kY8MafSggzB?=
 =?us-ascii?Q?DNj/Lr4WcQqz2lwBAPjssttSfl6pS5DiLkjIM9x/a2RvY/PdlRsIZqdb7u1r?=
 =?us-ascii?Q?vm4ctDpoeHW8F4ILj1LH+ucmVATBtZKLGLhyk8XjsoYob0PcAw+IRLDluuj6?=
 =?us-ascii?Q?+/JCfcsDx+pUuKwCh8yVBgo7++iVnJoZ5ZXkg9v0d0Vk+gZspYZIUoPBFCyT?=
 =?us-ascii?Q?dNqjpZPkEVGplV6WpdXxI++cjk8S9sTsGuRv3fYzTkKpqymct1riU6jG9tSw?=
 =?us-ascii?Q?9iRUHqPjx0HzVJeSJ+46v2kAaX+nTxuZeVZ1qEw2ws3JHa3yEDYUwdZS9Z8m?=
 =?us-ascii?Q?U/olEBmCoix/OdYCksQRvvqZSDJz0fOhFQ7zzi+anKxgXR6IDZ/cN0HA6Nv0?=
 =?us-ascii?Q?x8lXE6BwxY9EXqvEPrIq99+DoLCWho3k78wgvuIFf4/tqYNTbl1ZPkTZe+l6?=
 =?us-ascii?Q?+qBMGq6TeYWlY26Aa18roMGGEF71d9EQGKJmhI0U/dtkmJpCwUZw2PCYPcLm?=
 =?us-ascii?Q?lw08TT4UAaSGZJi4MrPuCrSMiHikj5W8SXkxxAY0ENgeM9zgfp5DP/s2D++N?=
 =?us-ascii?Q?xaTTdcKZ8m0K/dt/B2eZ/To1X4U2tev3rSxPqI1lBA9secce/gIKAcW8NB+w?=
 =?us-ascii?Q?LUGUWNgJXA6yWlYqvxwmZdrVGNVsymfhBkXoBwXAbKkZcYxGtqhCNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:13:04.4133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37dd4455-ef73-4a23-8f88-08dd12f4956f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195

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
index 28f65478b135..203312007165 100644
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


