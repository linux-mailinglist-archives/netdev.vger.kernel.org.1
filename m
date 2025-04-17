Return-Path: <netdev+bounces-183932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C53A92CAF
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD922188DCDB
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587C4221726;
	Thu, 17 Apr 2025 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wwsd42wa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEA61C6B4;
	Thu, 17 Apr 2025 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925410; cv=fail; b=IbV4M5Dcjl2ZkWJzz4d4JizlS6jQO/B7nr3il8spgQ0e79gATRpRzxzW/PpJ9XxbALSInw1eOAFMXaslrMTWqWUw6r3Ro6DLxQWONOXn2eJxNNKrvFWoUF90W7+DK3ASf5m3XSCaVtdrTRceDNq5cd583fpGENrpcjjzsPVSOjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925410; c=relaxed/simple;
	bh=OkPz97BU1pbWCzvB1TcLv/s8nsNF38rmbNNtHbsQN80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukFoeTDcF6Uq3bVqZJWjTnA7nzl/1dkgljN/24JIlZV9bCdClcnUrGZqUXQbhVeC+STEo44PEZVJw1F7PfQtgGudqctkPYyhQBRZIEcQJ29hd6BFIC4QhVXyIiJfjxc6fPQX2AfxZTIh8Jsp8mqeRWSfeEOBEdSmjzgIHCGi9Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wwsd42wa; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVU1+gfvdgJKyNTDLct+ZENLzlFhawAPS3seGpUBV09aCLf+vxYWEzphV32CW/qjNFKnkWy5vsTxpGpuf6sUdQAFD1M7KWxa1rT0oOmHP1x+t3GdSARXQTYcqAmE3ka43iomMQtxPIVhcjh6WNI7IauO63alvscveYb7CnZa6pyQucL1a4MykYLCTzzyCSXksUsfrk88j+GEQPpxFXlmUDGSBeRHAD/eKFfmlNOvv6WuM5CUAr77nu2/8z7fW1400gbS6YTZLp7oSnZY9iYeNfDvmW0tyzRVQ9qNSpcywbUAnohZsG5lWkfVhad/HMiCda4cZiUIRVpXu8TqlpGWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2t7yHcav8jpeoXJTgtqbF1rm7AfMwLPF5am9kbPZ3s=;
 b=BLcMI/LJhMHy+OX5Em+QmSGP6njR3iBmR/NAA1scDTV8/DYT6wEOIiGNXGrO8JzRGz3A5Ru3+Utim9kDCijlz2Bc7UBwmeOkPxSSxKB6orhySZpcas3wDB/YXCkmrO3n959LhmV1vNuk0zZhMgE4j6N5RacSPUfheSm96Ha0eJwxa4/CSrJNq2juxdth4wrfVWZgt2sO67KYEZjMELewMMdij/NyALieH62+lLw53lVx89gCJV7TwIksefscT99DWVHRPPA/oQGknyZWfHyP9yZlyR57lKANaghYwDN1Wlq13e9BS7mO/86h0iyo5M/6Bs06+Qew3XBXulZn2wAcTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2t7yHcav8jpeoXJTgtqbF1rm7AfMwLPF5am9kbPZ3s=;
 b=wwsd42wawVxNt93vjYjTmjCarIb2hrmKZdxLwZGkXwwUPppjassElt/htn4t58D0WjqYY7Xcy2WT4povvs3wxQfksQRcT91xrAZ4VNPosOtV52AbxOL11hL7PP3iXU4RsKjnynkwRmMy9BrLDjs6F//Z9uak/KfH//SrvMlU8x0=
Received: from MN2PR11CA0022.namprd11.prod.outlook.com (2603:10b6:208:23b::27)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 21:30:01 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::89) by MN2PR11CA0022.outlook.office365.com
 (2603:10b6:208:23b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Thu,
 17 Apr 2025 21:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:30:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:30:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:30:00 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:29:58 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v14 16/22] cxl/region: factor out interleave ways setup
Date: Thu, 17 Apr 2025 22:29:19 +0100
Message-ID: <20250417212926.1343268-17-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 775f3f15-7b3b-4884-c9de-08dd7df7028c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vm1XzMDOh6tzMU9/YdTQQHQjca02/RkUXusJMLEBbr4poqjgPhLehhheT+EC?=
 =?us-ascii?Q?0RBMjLajxzoXFMGb2ci+Z4w5Nj+981JxZUXg0cQzkflFty3AQYJv0GjdxPIn?=
 =?us-ascii?Q?LqUU9kfS4YxcQKDhLWzfdj2W7uhVIyf0hbpDMFXQIHxk9LTb0VerLZX7L4re?=
 =?us-ascii?Q?ojBSYv4+gayzcFbyETUXCXU5aexsu3XN41666wO3qJAZp/uR19jfgo5hogXl?=
 =?us-ascii?Q?i8sr8aUkkKe4tNSFSHO+2VRI4HuJO8rofLUr41uIEcZdokncce97GpuqpUqF?=
 =?us-ascii?Q?8UF0HufLYeDQL5LLGfENpQANbue2eq6z0V1UeIeD8CV8aLtcUCGw4djDidN+?=
 =?us-ascii?Q?lYkJ+lrsN/c+5y7pqzmfRqkes2FZ82HQZSI2Ta3cSXW6DaZTlYqx3XP+QUsb?=
 =?us-ascii?Q?h1YsrgLpnndk7sIHQCk/To5SGIt+4xbZbri8Gv5wflM0Zfn9hg3YFP8j7sQN?=
 =?us-ascii?Q?s3qb7ZM8dzxFPzXVkXb3lz+rDQHTkoAJb9DOYIIaOFWxpTDvZeCZ8RL2VxVt?=
 =?us-ascii?Q?i10uZiHNpGwZxwDFqbSUTvQuLrCKeBjx1BVj6iMUaA4zganvz0YTY5lVl8RV?=
 =?us-ascii?Q?7ak30TEYFpVo98oq2cDtOJNwe2nX/YvY950LiyxIiJRfuRnHl06ra+KkmJLZ?=
 =?us-ascii?Q?PDmpct9TznjVPIAt1RdE4O6wUK9t2DTM7FzPkWi5UhCAetxSivI1mVsCmrUd?=
 =?us-ascii?Q?Nozb4zD8JxtlylQOKjKowU6dQxnWdN05QTMfd7pyqe4obgdMtv/pPf0S6Amh?=
 =?us-ascii?Q?+dfAExYAuTcvvSGpffzuzJIfBsbEPb2UmmlpXzOus9qzucuQOE2pxtugtxBP?=
 =?us-ascii?Q?Od2EQ0UtT/SeU8hMVSx4GoJo/g+bnP8nu7zdKMaGfERBhBXHyMjSo5SGBqfX?=
 =?us-ascii?Q?kDfRuSWRGoYpYQ86d8gp8R8qAbasaGb9lytKYUdJS8MJP6YjUT+OU/s4+NeK?=
 =?us-ascii?Q?/pWk3A+zK/G4nCc7KLqnKYZkI/DjxpvTDuamNbc8fISlbQlxBdQfB/XyX5d1?=
 =?us-ascii?Q?uMCZtAClBVChFjH/LhzdMLh90D/kZhjUBDGx93hSyetXOh6Yu+qB5tBpq4LW?=
 =?us-ascii?Q?Za5wVwNz8RkuWwh2JE4eFOHX8PU0y5lcusc9UxUzyzhyB65Ym/YLoE7kMMqk?=
 =?us-ascii?Q?uOqnW5U3IUt9g7WNUcmPNk21t+kvzrVYtFVQPMN3650TPjNT+8WcWfcSGGDr?=
 =?us-ascii?Q?8alhKGTpVev0P9WT1VMdAaj8tIRG/Zdj2URfLt5PX1EdxnU6rcFb344HxCHZ?=
 =?us-ascii?Q?tvUjEnh6wyZtykC0D9fABbtM/sr+5bSvLQXF8x+Xx1egnD5+AVLJ09+zsSco?=
 =?us-ascii?Q?1ttcNysaJzstVVaoYooXy+XdcEE5hdBJetcYhp4ZkrtfU7urmc5iQQrE6FTU?=
 =?us-ascii?Q?cvq8e7yf8HbbazhqmOmN3BfeSt5FD6Pnz5OqxmCCP5kSPfK5bug24bar67wZ?=
 =?us-ascii?Q?wfX/TABMMn8xVDrqPCxpiBYDdZhwYmcEWLwkUrbmLyvYGXkRUToiTG8OpIP7?=
 =?us-ascii?Q?e3Z6lwD+kP1s0uh0FCdm+I0pkVWGbofJx28s?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:30:00.9212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 775f3f15-7b3b-4884-c9de-08dd7df7028c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672

From: Alejandro Lucero <alucerop@amd.com>

In preparation for kernel driven region creation, factor out a common
helper from the user-sysfs region setup for interleave ways.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 46 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6371284283b0..095e52237516 100644
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
2.34.1


