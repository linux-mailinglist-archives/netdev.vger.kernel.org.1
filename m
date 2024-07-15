Return-Path: <netdev+bounces-111575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD9693194F
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD101C21C26
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0047A13A;
	Mon, 15 Jul 2024 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="463E++Es"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE3E4D8AE;
	Mon, 15 Jul 2024 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064552; cv=fail; b=YFTFakeBsLfcXJ8BPoaLa5VJsj42FjLwmVTxLJ3toC/VzYTDvbyoNlRtYbWlCIqgaujdlNllOdSU+I51L/fnKbyKmqRXCGoQL0njS1wDBCBfv4WHlrMycLw39O+cfFsBtA2l9+sviW2I8oQXFAYoZX0FX5YORzB9M93PUFO/rZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064552; c=relaxed/simple;
	bh=Pcx01+JoQy6MNS1OD9L/ItqN/D6WPwR+kVqAFX56bI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewBU6gUwCEjhO5mzIl2XByN2VxCLuC8YnmNy40lVHuaub9TFbX6oQ0qRMH3Epn9PRjhedNYUmLJb+J7et7b/6xjrMdqcn9f3dOKMJQFbsCqZfzpboBQ8ypQljL+XoUsOujl82y1mwc6FqC8sGzuICtSxJ8oDhbJsnXe8w1Lgd0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=463E++Es; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtnkmjIUY5nM4yjrt+JqYVNesP6la7hDx/Pv0DvCcQ0hQKKwCzN5VDnWzIdJqrn+PjGJEUbUEqW7blwfIlJN8OIdKWvcY361HsvCmHC+rc5KrJdaGVN4Uy1bWcpFtR4YdvyYl/bb7f5xYOIXvs9e8aEJHQ4NMPR9EmWY+7bBDFmEgg5j05WUjQIdtVdGGmPWY6IBp+Obbtm/eBk+KDqJ+Bw3slCTmYdbQgk/PH+X0SmE0mWh5KwPzAvGQoXh7CYAssC30qm2BUbaYIF3sAIFYFL0NrGcoNpV3JcadNPfdowekMqvqkcMj+2ktHzxl5N0Gsvht23CJNziqhn2mQ9qNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgbzVYdE6aZLPnVX/enqasFlmXjMj4PxplaAW0wb364=;
 b=HJEXDJThtBYdTU2Mbwp/xGv/1s8DzC1dOze78UjPsQZC7VlH7zwLq7NG1BqIsFwz81vtKIxHb9yD0RdG+RvEPJ2Iam7+rY0xezKcA0xk/Jvgk/foV02LbrH26mDTPGr0tm6vltUprPfsE3o5OuxW+DagrYLrDCEhX7QcxeAb2mZAu0VBi6edRmoCHYc4n+Vc7EoCQz/m/v6k142BsHCdMx/oFxwVokGcqMoO6jhyqWsWkIM1wgXVCWptCTlo94jCDQXSvzEwYxwC3zPxIGbxXvIF0xxdV9YC72xVgEHZim5IxQv5+9dZc5FguPu2lsmUlcw3vsOTtlZNkpgOms+6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgbzVYdE6aZLPnVX/enqasFlmXjMj4PxplaAW0wb364=;
 b=463E++EsLX8O5d+JbBLSwhAhDu+L1GGHJtBmw+50uKDSk344uNuOeO6Sg8xyYcBRFri51w/bn0OqslwXo335fwTbJc72jSachQZ3lMAQ0dQCcrpyA1yWJMI/mtnq53B6O+jrY5yv3XeI+3XoX1zwL5Nm46cEdklW6/Y7yo4+3kI=
Received: from CY8PR12CA0042.namprd12.prod.outlook.com (2603:10b6:930:49::21)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 15 Jul
 2024 17:29:05 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::b) by CY8PR12CA0042.outlook.office365.com
 (2603:10b6:930:49::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 15 Jul 2024 17:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 17:29:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:29:00 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 12:28:59 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 12/15] cxl: allow region creation by type2 drivers
Date: Mon, 15 Jul 2024 18:28:32 +0100
Message-ID: <20240715172835.24757-13-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 61351246-6a4a-4e1e-d30d-08dca4f39e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6GBtQwBt2irAOf8Jey778/OFrw7qQRA7wAuvlzYckqD1Cu6XnG6l8uOkkvI1?=
 =?us-ascii?Q?ns8kz00ro9f31kuonr1KhkAKd2RIg1swpKm5x5ZTRrhKDXRBQSo6phBKBee8?=
 =?us-ascii?Q?Inm61OiFAwwqo8jQR0yewGYc46asMtAcobA8nBTHy2ajaWrhknAIJegUBdF2?=
 =?us-ascii?Q?ZVbH1T3JkfyUKiT5ZUlZ8liSEkXYTp0Jx8tyrqP6ivXPyYMwvhF1w9019cOc?=
 =?us-ascii?Q?39IR+cugrrL50KfT0MFXpuinqH1M4q3N5FAv9Yc2FQneVU2jih+7/u+1yrp0?=
 =?us-ascii?Q?M6Ep+aBggm801TqoNi0R/D73FPmjIUl/2tStSnfV5iDTHR+ym1EBLukl1qfg?=
 =?us-ascii?Q?yes+88CE6ZQB5fmCLchUDsDPxu5fLRSxorU7ZSherVo3JNtioEn8662wDXz+?=
 =?us-ascii?Q?IsLP4d8W6FROmxciiFM3BRg7EMt/ZTwIb3gWKUHaciBChT43c0943TlqUb6D?=
 =?us-ascii?Q?ahZ0h8Kvw2tJhq+hG6j01hSNjp6zdOMhrKWWyV4godmE7tyCfDhuIpI52kTU?=
 =?us-ascii?Q?vJDBXd80LBjpsmTeVyp43xrXccvhSlqP20MKCl5mptp8p4PNqXDDJME6uuDX?=
 =?us-ascii?Q?TeN4qestG1sUJln/kqYQw2onhdR2DhHOZWkErcoyQ+YVtSLEL4Tq4CVyxcw0?=
 =?us-ascii?Q?2B2QefOQiJM/lCkTNGOntB2aG1YWReNA3n4qMIPy9ftiib0fYwd+hbEefGhi?=
 =?us-ascii?Q?+J+bbg//cKSSkR4XlMSGyu4cBu2uTI06gYKTLkLNETPHrdXuBHdkEca9ou75?=
 =?us-ascii?Q?Q8X7RVJU6ZJal138mixsutXBU6dtLMeNwlYw3vJeFgLIVeRgV1C+SuKLY1K7?=
 =?us-ascii?Q?tL+FiW6Ge24eL7Eq96xZes6cLkauDAVsgJMTK6Gpt17ZT9T4JEan1VkgCUUc?=
 =?us-ascii?Q?bIfh597sz/v3XetafanpVamsgJbfj5TvF0Cn9mBdfEU6ImQJzvADYEYegq8H?=
 =?us-ascii?Q?cMoWGuG6MNQbBVkUe69Ucvp3LfScZH5+IcAFgt1LJf+04PpKwJ63GYZZfil8?=
 =?us-ascii?Q?EmTsrs876p76AtDpc7kFKRyydtpETcz+TUqQneUpSyuyIgGSh+KZ5GsGlYh7?=
 =?us-ascii?Q?V3pUp3HNM8r1EtyxTWzw73Ep0iFBrcEa3wFpQo5TIPlzn+oP++dcB1gax4Jk?=
 =?us-ascii?Q?+5WadVC6ikdHxXpE8IrXlknWw4B+RBRHjnl9e3861UX1KMSPM9LBhAQTec2W?=
 =?us-ascii?Q?8tnpfqYLUophNX2fKUcuhBty8g5sbe0rzDr1FzQXG9mJx6ZrzRGe1oaVwKa7?=
 =?us-ascii?Q?4bRSFK1qiBK/YY5lUS0hZDTuPn/oZi8m5oHTB+vLgdKGXUAv1xJMdftp9Foc?=
 =?us-ascii?Q?VqjM8fIviPmOy6GsSEcY6Xr2053qOiWVTUBE+CTvz7vFfk2DoKEe9P9Z5XCq?=
 =?us-ascii?Q?lnKjVjsvWDAiuoZorYzE89YnUrEPF9sE4jrgUaTyHIqKJiV27Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:29:02.0589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61351246-6a4a-4e1e-d30d-08dca4f39e6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders.

Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m84598b534cc5664f5bb31521ba6e41c7bc213758
Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c          | 265 ++++++++++++++++++++++-------
 drivers/cxl/cxl.h                  |   1 +
 drivers/cxl/cxlmem.h               |   4 +-
 drivers/net/ethernet/sfc/efx_cxl.c |  15 +-
 include/linux/cxl_accel_mem.h      |   5 +
 5 files changed, 231 insertions(+), 59 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5cc71b8868bc..697c8df83a4b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -479,22 +479,14 @@ static ssize_t interleave_ways_show(struct device *dev,
 
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
@@ -509,25 +501,42 @@ static ssize_t interleave_ways_store(struct device *dev,
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
 	return len;
 }
+
 static DEVICE_ATTR_RW(interleave_ways);
 
 static ssize_t interleave_granularity_show(struct device *dev,
@@ -547,21 +556,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
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
@@ -577,21 +579,36 @@ static ssize_t interleave_granularity_store(struct device *dev,
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
 	return len;
 }
+
 static DEVICE_ATTR_RW(interleave_granularity);
 
 static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
@@ -2193,7 +2210,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	return 0;
 }
 
-static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
+int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *iter, *ep_port = cxled_to_port(cxled);
 	struct cxl_region *cxlr = cxled->cxld.region;
@@ -2252,6 +2269,7 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 	put_device(&cxlr->dev);
 	return rc;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_region_detach, CXL);
 
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 {
@@ -2746,6 +2764,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
 	return to_cxl_region(region_dev);
 }
 
+static void drop_region(struct cxl_region *cxlr)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+
+	devm_release_action(port->uport_dev, unregister_region, cxlr);
+}
+
 static ssize_t delete_region_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t len)
@@ -3353,17 +3379,18 @@ static int match_region_by_range(struct device *dev, void *data)
 	return rc;
 }
 
-/* Establish an empty region covering the given HPA range */
-static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+static void construct_region_end(void)
+{
+	up_write(&cxl_region_rwsem);
+}
+
+static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
+						 struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxlrd_to_port(cxlrd);
-	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
-	struct resource *res;
-	int rc;
+	int err = 0;
 
 	do {
 		cxlr = __create_region(cxlrd, cxled->mode,
@@ -3372,8 +3399,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s failed assign region: %ld\n",
+		dev_err(cxlmd->dev.parent,"%s:%s: %s failed assign region: %ld\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__, PTR_ERR(cxlr));
 		return cxlr;
@@ -3383,23 +3409,47 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	p = &cxlr->params;
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s autodiscovery interrupted\n",
+			"%s:%s: %s region setup interrupted\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__);
-		rc = -EBUSY;
-		goto err;
+		err = -EBUSY;
+	}
+
+	if (err) {
+		construct_region_end();
+		drop_region(cxlr);
+		return ERR_PTR(err);
 	}
+	return cxlr;
+}
+
+
+/* Establish an empty region covering the given HPA range */
+static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
+					   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct range *hpa = &cxled->cxld.hpa_range;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	struct resource *res;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
+	if (IS_ERR(cxlr))
+		return cxlr;
 
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
 
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
 	if (!res) {
 		rc = -ENOMEM;
-		goto err;
+		goto out;
 	}
 
 	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
 				    dev_name(&cxlr->dev));
+
 	rc = insert_resource(cxlrd->res, res);
 	if (rc) {
 		/*
@@ -3412,6 +3462,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 			 __func__, dev_name(&cxlr->dev));
 	}
 
+	p = &cxlr->params;
 	p->res = res;
 	p->interleave_ways = cxled->cxld.interleave_ways;
 	p->interleave_granularity = cxled->cxld.interleave_granularity;
@@ -3419,24 +3470,124 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
 	if (rc)
-		goto err;
+		goto out;
 
 	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
-		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
-		dev_name(&cxlr->dev), p->res, p->interleave_ways,
-		p->interleave_granularity);
+				   dev_name(&cxlmd->dev),
+				   dev_name(&cxled->cxld.dev), __func__,
+				   dev_name(&cxlr->dev), p->res,
+				   p->interleave_ways,
+				   p->interleave_granularity);
 
 	/* ...to match put_device() in cxl_add_to_region() */
 	get_device(&cxlr->dev);
 	up_write(&cxl_region_rwsem);
+out:
+	construct_region_end();
+	if (rc) {
+		drop_region(cxlr);
+		return ERR_PTR(rc);
+	}
+	return cxlr;
+}
+
+static struct cxl_region *
+__construct_new_region(struct cxl_root_decoder *cxlrd,
+		       struct cxl_endpoint_decoder **cxled, int ways)
+{
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p;
+	resource_size_t size = 0;
+	struct cxl_region *cxlr;
+	int rc, i;
+
+	/* If interleaving is not supported, why does ways need to be at least 1? */
+	if (ways < 1)
+		return ERR_PTR(-EINVAL);
+
+	cxlr = construct_region_begin(cxlrd, cxled[0]);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	rc = set_interleave_ways(cxlr, ways);
+	if (rc)
+		goto out;
+
+	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
+	if (rc)
+		goto out;
+
+	down_read(&cxl_dpa_rwsem);
+	for (i = 0; i < ways; i++) {
+		if (!cxled[i]->dpa_res)
+			break;
+		size += resource_size(cxled[i]->dpa_res);
+	}
+	up_read(&cxl_dpa_rwsem);
+
+	if (i < ways)
+		goto out;
+
+	rc = alloc_hpa(cxlr, size);
+	if (rc)
+		goto out;
+
+	down_read(&cxl_dpa_rwsem);
+	for (i = 0; i < ways; i++) {
+		rc = cxl_region_attach(cxlr, cxled[i], i);
+		if (rc)
+			break;
+	}
+	up_read(&cxl_dpa_rwsem);
+
+	if (rc)
+		goto out;
+
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc)
+		goto out;
 
+	p = &cxlr->params;
+	p->state = CXL_CONFIG_COMMIT;
+out:
+	construct_region_end();
+	if (rc) {
+		drop_region(cxlr);
+		return ERR_PTR(rc);
+	}
 	return cxlr;
+}
 
-err:
-	up_write(&cxl_region_rwsem);
-	devm_release_action(port->uport_dev, unregister_region, cxlr);
-	return ERR_PTR(rc);
+/**
+ * cxl_create_region - Establish a region given an array of endpoint decoders
+ * @cxlrd: root decoder to allocate HPA
+ * @cxled: array of endpoint decoders with reserved DPA capacity
+ * @ways: size of @cxled array
+ *
+ * Returns a fully formed region in the commit state and attached to the
+ * cxl_region driver.
+ */
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder **cxled,
+				     int ways)
+{
+	struct cxl_region *cxlr;
+
+	mutex_lock(&cxlrd->range_lock);
+	cxlr = __construct_new_region(cxlrd, cxled, ways);
+	mutex_unlock(&cxlrd->range_lock);
+
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	if (device_attach(&cxlr->dev) <= 0) {
+		dev_err(&cxlr->dev, "failed to create region\n");
+		drop_region(cxlr);
+		return ERR_PTR(-ENODEV);
+	}
+	return cxlr;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
 
 int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index d3fdd2c1e066..1bf3b74ff959 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -905,6 +905,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+int cxl_region_detach(struct cxl_endpoint_decoder *cxled);
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a0e0795ec064..377bb3cd2d47 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -881,5 +881,7 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
 					       int interleave_ways,
 					       unsigned long flags,
 					       resource_size_t *max);
-
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder **cxled,
+				     int ways);
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index b5626d724b52..4012e3faa298 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -92,8 +92,18 @@ void efx_cxl_init(struct efx_nic *efx)
 
 	cxl->cxled = cxl_request_dpa(cxl->endpoint, true, EFX_CTPIO_BUFFER_SIZE,
 				     EFX_CTPIO_BUFFER_SIZE);
-	if (IS_ERR(cxl->cxled))
+	if (IS_ERR(cxl->cxled)) {
 		pci_info(pci_dev, "CXL accel request DPA failed");
+		return;
+	}
+
+	cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1);
+	if (!cxl->efx_region) {
+		pci_info(pci_dev, "CXL accel create region failed");
+		cxl_dpa_free(cxl->cxled);
+		return;
+	}
+
 out:
 	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
 }
@@ -102,6 +112,9 @@ void efx_cxl_exit(struct efx_nic *efx)
 {
 	struct efx_cxl *cxl = efx->cxl;
 
+	if (cxl->efx_region)
+		cxl_region_detach(cxl->cxled);
+
 	if (cxl->cxled)
 		cxl_dpa_free(cxl->cxled);
  
diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
index d4ecb5bb4fc8..a5f9ffc24509 100644
--- a/include/linux/cxl_accel_mem.h
+++ b/include/linux/cxl_accel_mem.h
@@ -48,4 +48,9 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
 					     resource_size_t min,
 					     resource_size_t max);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder **cxled,
+				     int ways);
+
+int cxl_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif
-- 
2.17.1


