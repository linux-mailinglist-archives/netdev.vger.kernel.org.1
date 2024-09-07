Return-Path: <netdev+bounces-126223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004539700D7
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765A21F22BA9
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8716815990E;
	Sat,  7 Sep 2024 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tpyZzFvm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CF1537AA;
	Sat,  7 Sep 2024 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697195; cv=fail; b=RjT/W3zOw1ojAPjkVU4+BjY9eeKV2nbg0RUBkE3WeosOHqkYTNKC75fO5+TTqZJ3MF8j7w0Fq3MFUF6uhtUug7RunBnQbhjrIKAyHmAfIsZhYXnuUqjoJ0N93OjV7M6jPcygeTHyvA2W2ImOeNkkXLArc7F1NmBzxUNMcmpXR/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697195; c=relaxed/simple;
	bh=tVu6urx6U8yTEvHqe5CqXZ6LeiopZgxbSqR0PJXdzo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbLgZ3AxNQ2W22GjZZEsOeog8h+k5ciN8z9BKY7Q3YXKDgz/IQ8Lhmdxg4t1eW7W0+HiFROLvBDIAVdeO6MjJbxeUsjiKUSpXCNxEF8W8guDGxxDe/LUvA6MtydOFlcxh5Fr7j4VKAgxF5OG0arxrWbPYHKKO7uhYtT4lu/BS4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tpyZzFvm; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZ+FBJGNeA2YoZ905vqmW/FYvDV1S0aAkEFC61DX25VrnKrz43wadTa0t9McNL7uXfrIBTpKfvuV5YCVRrV8xvoeRktMCwYcXGR+S8g7jzxPkFVLoib7hH14oblyBJzcAJUkIKC3bx/YKdjfBK2SWudsibVSNGw7Xu9iKSPxXjScuTcHBI9o7CvouNlaXPDtA+CUKFfaGtsM8Pql2Ldlg5JZuGpQ2S//Gmz4YxEFTo5Q7hugOEYkGH1qre+mf9ea1Hma5lQWQTx7pr6JN9Eq/PB+H55+3RY0qu9PBBavISW08S5KhgA/Uy4ZbTvoIwjbg2zL9h+RDmq+sALECH0+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhu5N4ZTzfCYq0bQowULOeQSrnVJJz6IjoM7IJ5B/nE=;
 b=cHjlPfxji50BxyFvbH9bEJhBIVLDxOnfLjFlD/L8wVnXlIncmLI61nVPbK5NZMUDC5/gJQU/YOmJI2YeDMg8fr4qRYGjNkFINWWCi7165PPzt8wXBie8R6n9btCrVi+gd8EVOHDtKg41+UJw2xfI6DUr53rr9u9RA+9SnaNt1IBj6Ot6gJglo/0ddRNMGZcq80ZoeH8CTbOwc5q70DkPtRP4uxenJxE7+/d5SnV+NzRbvxTpGxrcgnbBGcrMe5CfdN96f7yrW91nhDOfpDJcByi5KEHnpJrrChJVxR3XhGnttTaUi8VgTuKOdClHAxRrg4U8ZDFtZo54+T5fNKZyRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhu5N4ZTzfCYq0bQowULOeQSrnVJJz6IjoM7IJ5B/nE=;
 b=tpyZzFvmh2YhVZuSS8FJj3wKCvtazV3zlWL7NBJJmIofHFV/MvMxRoxCvPwXXWV5WKNs1XdZjry4CV8IunAhiM/nVmuXRFg2/UVHCqzmE3rHd1U63W3bWF+zmodWaspa4fWRGB42u1QxgVwgYEf9OXvDSjhzcu//aJv0FweexVk=
Received: from DM6PR04CA0017.namprd04.prod.outlook.com (2603:10b6:5:334::22)
 by IA1PR12MB8222.namprd12.prod.outlook.com (2603:10b6:208:3f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Sat, 7 Sep
 2024 08:19:48 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::9e) by DM6PR04CA0017.outlook.office365.com
 (2603:10b6:5:334::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:47 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:46 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 15/20] cxl/region: factor out interleave ways setup
Date: Sat, 7 Sep 2024 09:18:31 +0100
Message-ID: <20240907081836.5801-16-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA1PR12MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b8985e-e197-4417-e786-08dccf15d6f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ELeYTiVshgHUSjyTUR4urBncFY+kdKauBiYHGabcXgkJdOUjsk/I8icaCu5l?=
 =?us-ascii?Q?r+MwV0+19zf1bNmXkIjF9e3B+aShm8e48j0VE5J8q8+lHmjAgtHAPaQ3w47y?=
 =?us-ascii?Q?x9F7tJ6Y7/qzVsuLEjdLB/PpFyr8UTEAlX7zAu+VMXmE9ZUHb0zFOVMW+bSs?=
 =?us-ascii?Q?8x072SgcATkatGU0t593Xkb7GFodpCKrxZR9WKPsvfaOUNsAo1sR1qySFAa9?=
 =?us-ascii?Q?wyIiJsF4bmn+3UHHqK62ywqKkn8gaGhNVJnTIBkdzOrUnKu2xI2glcobMqCP?=
 =?us-ascii?Q?5tWmSJKovbozXjoJdXkcCOg/Z/uW8brXsX+ed7AJSJE/D+PNq15W280QBe+n?=
 =?us-ascii?Q?2okgw0o1xyVa+KYIkg1xnru1AcvKexz2W69Kk9/ThV9uRGrwHLrrWtDXr41U?=
 =?us-ascii?Q?QLog2izf7L0YxFtXl4miHhkLtxc+SGbUxiI3b9d41lmOOW8uBJ6KIUgu66dh?=
 =?us-ascii?Q?JeBOnNz2UkIv7B8p9WT4CZOV5Hl0pCM5dsv93l1jZQr5QAUQU+qnhUmhSlbe?=
 =?us-ascii?Q?2OuTzT4kehfCGCz3h0JIWAZIY0+Cf7aVEXeuBasf1gsRnEXMQb7h7Uj5sHmg?=
 =?us-ascii?Q?um9t73dskNoOkZRQW/QHypZTCP8TRIQtlhLN3JH3EeEX/LG+bO+Ni9X7NXEm?=
 =?us-ascii?Q?loD5OrkgvMakVFinWQa+IxhrKHlw942Cnp1b1IuFOmbf3pDmebYkEPLd5FWy?=
 =?us-ascii?Q?q2+KuqZ+gGuaOiGVsSo7ldXnQDhDy2kDsrPNl6VPb1zHen+wUEMN6HUbVQVL?=
 =?us-ascii?Q?ZaXBmWRAVQHC203+Q7oDj9V1uJxpuogl7mv/HEiAaOdtJivAHhRVFzbklTw1?=
 =?us-ascii?Q?Y4dvQfK4k/Dgzld+xYQpSrQz2QWi/Au2xLEpS1iZnW4tmNz1OtL0rETuNFjI?=
 =?us-ascii?Q?2jPwcPgleP/o91/3o21SB1PnRJkvTjGjnpBKv4et4yme1hdbahIKU8u2BMnA?=
 =?us-ascii?Q?FtEQTr0p3fvaZ27HHferrGW9B3Q9PCa7KGmeQz5LT9RWMcAewJGtSogBmHJW?=
 =?us-ascii?Q?KmQUdnSeNqlFrE+ctJYW0ZVY3q+j5nS/fvmrc+I7wPeURA65I5s1tqSsBNzG?=
 =?us-ascii?Q?rr4c2uJE1EFNJDTzqMvMnbT+r40hMgkch5/hnR4oleIW8MQGVWOz05A1XX0v?=
 =?us-ascii?Q?L+QEtuSvzEHuax4LHd7s8vBQeLBdgeF01AA25qN99Q2DkoPctFVOep0POCvZ?=
 =?us-ascii?Q?m9wZOHkaP1AiuCTgSi3U16hTEkZu5DMQ02FXP30EeaYYYl/fbXF5bk6LvAdC?=
 =?us-ascii?Q?V6Cbvqdk52gzjBvAap4RiqSgUTygnSNc9uKDLdjrTbUCXbVH/bD9MxQUMtnA?=
 =?us-ascii?Q?IBglVTt/LtNTj9LkbWXcFTkf8sPE4hB3GcQffk0U4zrUB57AD3uizMPiXYr8?=
 =?us-ascii?Q?0H8w+lnkYCOAAq/VqmoHqWZ3X5KvAdgEG4YqkGYzigDd3/YoAsqlyAABH6y3?=
 =?us-ascii?Q?JDx0o7MYY1t/MpM8yyv2g46vmN86o9dg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:48.6336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b8985e-e197-4417-e786-08dccf15d6f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8222

From: Alejandro Lucero <alucerop@amd.com>

In preparation for kernel driven region creation, factor out a common
helper from the user-sysfs region setup for interleave ways.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c | 46 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b27303b9764c..edd710105302 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -480,22 +480,14 @@ static ssize_t interleave_ways_show(struct device *dev,
 
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
@@ -510,20 +502,36 @@ static ssize_t interleave_ways_store(struct device *dev,
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


