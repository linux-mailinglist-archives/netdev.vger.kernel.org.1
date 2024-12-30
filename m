Return-Path: <netdev+bounces-154587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0DE9FEB24
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D334D1623F8
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D611B0F10;
	Mon, 30 Dec 2024 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i1JNt8cy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A951B043C;
	Mon, 30 Dec 2024 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595130; cv=fail; b=PbZa38PDBrz9dEf/WBzn3uaumT0ipqyN93zmgHbNiw+wN8uZnFHJwpqsrGtwuGMPedobw6rq3ewlr2yDdKfkRpbg+f/i8yVn3i4z8xV1k9DbPObwehN0pgJ5DHBDmkGDUSR/ehRmTAoKx/U3uVpdQlSgryxuHbjdbFFbE1CIfp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595130; c=relaxed/simple;
	bh=2qInuz6lG1dS7s6tMJecYNwrzeyAiFi01/MeXDNefAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZComT7P0yZmr6/RNBY134TujaE1WvMHJJHqSQTNriH/GGUr+zQpc3HeNOhNGVBko56CsRTkhiEmb64BveuQ+7EzRf7Pg6ZNkCkzJW9nV6/gcvitxUwA16GG1V2UYw/gqa/wFSpMv2e7qNFPlLXwsk6opcjwTz29kUr99AumaaJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i1JNt8cy; arc=fail smtp.client-ip=40.107.101.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7Lhu70MEdIsvf/jJzPaDeaXOw0H0Cr+MRw6R9iNmDoshJUkAN5AJ24lz/qJ1E4A0OZKjz7O6o9ZvbwZuUvAhI/YpI8dAfpuepMZlzKB0OF2MDA6tHIC8mSPDQixLAcMPRQsdXGPcTiI/PRYhVUum7yyh+vR52WxawLkdu2rHJMRL67t7QRokm+ihmM9J9iZZsZUZNxsAdOv0K8DLlU1YyqIIrxEPJMW/GD/k7dcqTt3k5QpHs9HPmjJS1qMmFtf+eszSm8sD2Ej1NjUEdOErB90mAq3/EzrZCcVCBLqqoV9avVhmwWJm/op1aqTv4OLH57fLuUT0PVhWGi06uKePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXH+owV+ew8EFz2UxF83SKya5TK6WHoqDi+OEasoehk=;
 b=JWhEB3Up/yELdrmGbC9eK8CuanozaTgVChe94LHrN3vW45W56NUvPlgdB2S88kbvjB0BRj1sA4illdVONh9HL2UWg5Zi4nYOLSwxgjyHGT7BHkL2InI6GwfPPvvJXEoNb/5R96HMrAvcGQbgZ8YxlAWFXF/tkF2xlJHSNEZH3EHrPsT5pA0E9A+TCjpJUDL6NVrd5qNI2QnCCSibepTmoa74zmbawLdwjiG6h/jb78Yv7nEVq3IVbIsYSV5JxVvoN9F1qXUzBh8V+vT0woH4nFYZIlkloMIKH9elLdPWlGeQNLrHUdh6vqdMKDzt6Q5sO4DXPy+QUpzl//lvbldljQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXH+owV+ew8EFz2UxF83SKya5TK6WHoqDi+OEasoehk=;
 b=i1JNt8cyvIj1UdDXaHVf39EePUKyYTfA8/Hvv5QZpHXvrioafrLJHeeN6NOoXcIM4LzgZLhw0vBGHaXurrJHah4hTqitCXMRHMPtcaWM9glRdzSjwpCMi9S+GDPh4jkmryxdAx/h+nxGb8i8Uonun0fh13UZpG9jlDQJlk/lTO4=
Received: from MN0PR03CA0013.namprd03.prod.outlook.com (2603:10b6:208:52f::24)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Mon, 30 Dec
 2024 21:45:22 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::1e) by MN0PR03CA0013.outlook.office365.com
 (2603:10b6:208:52f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.20 via Frontend Transport; Mon,
 30 Dec 2024 21:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:22 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:21 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 20/27] cxl/region: factor out interleave ways setup
Date: Mon, 30 Dec 2024 21:44:38 +0000
Message-ID: <20241230214445.27602-21-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d8132c-b256-4408-2b3e-08dd291b4351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ayGuZG6aQVllHVNNMuu66IDOCgUO8rJR3O0taucNAeRWS4oYTsjeyxZpnD+Y?=
 =?us-ascii?Q?jOi426wsEopA4mAHhPDVMbrVKogoPXfZfZfpZCm5OmWA0AC6zV0ETtrJMiTF?=
 =?us-ascii?Q?rnC/6D7rbtmcdJ/Wx/tZj4/VieEIVmGQlp5wxibxZvPu0LV2cxnU0SJ9bwxu?=
 =?us-ascii?Q?fVQSQhONeSc+94ue7s0AdndX0DH8efY6SZRMe3VceM84ozdqASlHKTGdgL/X?=
 =?us-ascii?Q?nRFF4MLANweMaxxLwVWh2CpDW78zprUN8NZEbjIGqZn4i9LGzcPgESaKbXRp?=
 =?us-ascii?Q?yjO+54CSlGMNQClgBLm1/tXmk27pmu1Q6nbNt36xpRFGrQOvebSbAmvZhbEJ?=
 =?us-ascii?Q?wX2Vf2Om7WHq59j/FJ9AC+x5w3nBxrY1p2HGA9D8sJjsotkfUgkW0692g4Oo?=
 =?us-ascii?Q?HGovQ+uAfcAzB2Ydc3LQyTnk3E2cg/hTY0wf77R/CrmmUrJjyyZ1jYl+kuXP?=
 =?us-ascii?Q?pGF3ADa638xqpXm1yBCy7bsltbjAAc0Hb2QCgjoIHxMvrPnmQRLgbRYoPtiK?=
 =?us-ascii?Q?r/CatVyp4Mn7G/UZpdejvMAqUzopYmxuCSnD2KW6LnZiIORH0oeD09x2sv1Z?=
 =?us-ascii?Q?mRKfNqsrYVusXYWYm1f53SuVSxE2Rk87i+Xd4UaAWCEwqtuNY9zddzhBKynQ?=
 =?us-ascii?Q?kGHacLMhX82YhIJyDCShhVHvxv8z1+VsVQx1S4TnyEVUP48VMhGT6kkIvFSy?=
 =?us-ascii?Q?VQMHKBZ+/esokYe8j0J+IEna81w3ANoUMtWq9bcgTbxPbSIBT+wEdEzVjx1x?=
 =?us-ascii?Q?JqtnXgyUgTKTZleOwCqq8gBNJW0Sh5yh+chNAyT8JTNKoKMz2YZEYs2/MQI2?=
 =?us-ascii?Q?3U5bnQbeg3FgBrq2+lT77gc9SuVBa8ghQcyj4zhgfhIBehBlNNhxgGXyNjHv?=
 =?us-ascii?Q?oq6XFe33gO9n98foU1Q6gL39SqsiyHVUNte5kqlfusjbOqO6/ggPbbV8Km+W?=
 =?us-ascii?Q?YpZ9P5zVXUg7qtyT5LyfmYX01S1lg4ckZnbVNKHgQJ1mg7oowm8gAMeKfz+m?=
 =?us-ascii?Q?v7HDE9EA+Jgu2ohM4Hv6r+mFrSUeoAd14107K0cZ5PYJCfYGe7ndiHdAbLFo?=
 =?us-ascii?Q?Y75hALxVF/GoWVy6h8vYR7Lwre7Ax3kcl8tuH1PuGkPlWZjcOVG4je8qIimz?=
 =?us-ascii?Q?/grPKETxeQFByJfT4VwSC6fcbO1WpBuI5QFiud0pPQ/hhCNPDMHcHcYV5RyK?=
 =?us-ascii?Q?cHzX8A9tDjL72pFLPCqsnVID+6FUE9f3UM/82phldc53m/ixrw1YdilyzJfH?=
 =?us-ascii?Q?WEckQgY7EF3zy5BdRG5Dd5hSGcftqhC2dyk7skNu5EMMVfw5AI6wyi2xWPkc?=
 =?us-ascii?Q?iZxKYTZxp9CI6YrfZ7gO58FIkSnAMVIdDV7z4Gk+IXN7SHQ20Nua9X862Cl1?=
 =?us-ascii?Q?u77Z7fd39ptRW96J3uNKPUg2/VKikjE92SE31zFVblwxgPG25ql3xK7GUQJD?=
 =?us-ascii?Q?HIoY9gHNXhX0IzGKNSc38f6MJXJj3hZo8FtSj03zl3P2RvwtwoCafvqvMTTB?=
 =?us-ascii?Q?fiyMhx8Igw2D9z8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:22.6102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d8132c-b256-4408-2b3e-08dd291b4351
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217

From: Alejandro Lucero <alucerop@amd.com>

In preparation for kernel driven region creation, factor out a common
helper from the user-sysfs region setup for interleave ways.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 46 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8cc959859ede..cd4913320fe9 100644
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


