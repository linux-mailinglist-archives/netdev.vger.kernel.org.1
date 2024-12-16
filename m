Return-Path: <netdev+bounces-152298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B12C9F358D
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3BE1685F2
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383D6207DF3;
	Mon, 16 Dec 2024 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="slHV/BAX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3E204C3E;
	Mon, 16 Dec 2024 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365491; cv=fail; b=cFsKHQRi/e0eTc8w2zs67fUtfypayKJZL47uuOSxmykQbGOr2oYsvToabZjJ2KZDB0FCmGzDa0vUO0jRvvryWosAxpu/lL7AyXGEaA74B1nkGjb85NfmNEr6rz1t0xeoF7df1qBQxZgwuJs839f3DKq3Eeeut7rBGgyXEdiatVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365491; c=relaxed/simple;
	bh=pY2zDWRn25Gw/91h9F7qDAHYl25vwXCD2CI9CEXIxEA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUl2VWLAIR8E7hBxyt7j5uvtBQt3JiN6XJA16w91FpeIeiNSKTxWCNyb6UoW3twyL/v0FvtqdzBc9m0vO4BE1V98idz6rVWKFzVH9bONVW2A46yGTHGUpA+PwHchzY4wlYzGF5YnovX5skOUVPHK4kfXMlpaE6ehUQlO/6HVnig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=slHV/BAX; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMFMoyqEtJHuS3rvEq7yjs/mmE36yOXEFhA6GlmeGbtOLlEqdNbgPFdy6dwm4FQjfBC1r+7ASO/ZEmCbbCUXNegMQvCWOX/Brsviek/3bTHFkMEcwzs9F3uiNc2jgY1/X2sZFRxojZzJ8pt8TpWiVHbzWziAjCg6z+YeokzBk3aS3I4GyLtVywRe1KTYhm8bvdTZ9A7VWqxRctpiUaqXN8bybWsaYfRIa0jzMDiB4HX258IwEmkZlnrW/qu2YbqENNJhiOOMFh42WxFMFwtk5UUhtwVVCikED4SE6q1VEjL8HKioJYXIFQQOQ/UIPDivZXYwKlk9e20+TbuZB+cuyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=notGdNkDlWqkS717bUcGtI96gvDWjIP0PoWdXJI1ez0=;
 b=bZlvsD+pVnAPsJCY1XUSQh4AMW8sLE7SMLprQ6sN1vmop3fWzWc5FiJIuva5KyXOPHujOblIJh7o09/BAl2QjZ7Oh3TbjJeMU3uPBBlYr+RF/NIPlQIUFFy7ZgbFqBrkv6zbEsWeIfc+69PF2ngr9sRFf/BLDvVvVncfCyPcmj7zHDSZ4gigByjlj8J64ZZx1f/33O1TnSmpoowqwPFLCDU6vv4OAnNpn4WU8h0jp5YneuwzZ8uBvIOjb0l6BEh2X7uVd+AQTm+5hvFyh8xSrAgg3HlMyW8GqrG0qw/lFO+mZySufifFVkoZCJBzJ0mRO6cnML18wpV+2iNHkSkOnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=notGdNkDlWqkS717bUcGtI96gvDWjIP0PoWdXJI1ez0=;
 b=slHV/BAXSwZJsrSaa+Q9imWE7w1mGeFDneQLN6RQJjRgUl/McmU1xFr0KMooYZe0HHlO1ZZvM74RKtLKjXHvvWmBUxvFIOc+EiOR9tc6MMmQbjNIk4gNe9s3pVXgaSXo36BgG5N616y4vG27GsSQnsMSx5Ih+xfT78seZLhU/ug=
Received: from MW4PR02CA0021.namprd02.prod.outlook.com (2603:10b6:303:16d::31)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:11:22 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::56) by MW4PR02CA0021.outlook.office365.com
 (2603:10b6:303:16d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 16:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:21 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:19 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 20/27] cxl/region: factor out interleave ways setup
Date: Mon, 16 Dec 2024 16:10:35 +0000
Message-ID: <20241216161042.42108-21-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: c7dde9db-3927-4733-cf2c-08dd1dec4865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vaWO9WqF2lJI3alB4mC6Rrin8va9hIIFuZu2ltxEi7tMvlLd0EOzvZTWrHEV?=
 =?us-ascii?Q?sRuPE2mnykJTQ6TyIrw3AWZ/V8bmW/jF/KJbhrRr6aTKCwtVclQmHd7fTsYD?=
 =?us-ascii?Q?hhfaurVelx59YojnMlp8UTGgkD4xGYuHgyhZVsLE5mvNMtJhC78v2qnA7rIE?=
 =?us-ascii?Q?OyrUReI7YjTZe1riEnwwoYOPt+GsJrzriMYWpJ5r8/0yl6pOs2yeFQhuavZR?=
 =?us-ascii?Q?tEWnRsVIRC8sTmxu8iMIHIYnrqNMjkVYQj3yZE3HhGSanwy5mOBtM3g08Gff?=
 =?us-ascii?Q?jEB1IVLHhAPgy8LVb4kW3PS5fvEr4sORJJrdAWZj65r7TndSNEWfFmj/6JpK?=
 =?us-ascii?Q?8kHv6Lfr9HsUdfYnCr6PjNUftyh171kJXQnvrCf6WnXcL4qFzreDHz/9Pr3K?=
 =?us-ascii?Q?LL200Z6y2nweBS/oKb6gxXeSDtjc9HfLUdIhaKuZkYIAH6tmqgSJzYeOThDk?=
 =?us-ascii?Q?4okGfef1LOfsBqFW1gCuJ7NSRNlNq9FGhjJVNwg5jwoJdITHfhnPAdYtkX9y?=
 =?us-ascii?Q?pniMrQi6cilzpsonFLZTptqoHdnxn4TRIQgf8gYGKFrh3HrEh0bIzDTwc13J?=
 =?us-ascii?Q?m3x1Ob5WH/O/YCG7IeJTppQZwA0QQ42zD2yihfg8WqeBO8B25MrCWfELK2o8?=
 =?us-ascii?Q?Sj3S0xyS+2gX8Vq0YV4PaC+a+TshnmhovBjFv3FqSPOK909ARGBXI7Zk4oup?=
 =?us-ascii?Q?pBlbi4niIl3A2jPDjCSZavB3cpPZq1YEKl1sV09I0ASUPpPzFdPMgUubn4ou?=
 =?us-ascii?Q?fPVk+a4OwBWXYkPTxSdQyLOlS8ErBp0hV3khmV1weyBxoHwzdCFKjtDCTu2L?=
 =?us-ascii?Q?NzibblzPhnen6oJmwNJE45rf5GcwTeoKBMb/hAWdqVPLgwodu6bjGr9ozbsQ?=
 =?us-ascii?Q?dxNK1vRC4Ym0OG53CG3US60l67e2I+RizjAnFpNfayY+kb0Ao053S7fagjwN?=
 =?us-ascii?Q?gYXhOjSOzCmBU4VkPkg+WR1CTHvOwt7naCOQiE++v0jElsUt5mXjzJeZ6a18?=
 =?us-ascii?Q?o2BjcbiOVF4LibT4PXCfUlc1PeoXAh+WgbAs8Y4wWd2HAhlYOD5pycoN+7y3?=
 =?us-ascii?Q?moIGtY9JXJdVu3uTtiljHRuzM3feyj6Om5ezISxL6bwU8NKV/sCnS79lGf6b?=
 =?us-ascii?Q?3e4cdg3Np85/DSfVv8hlKLvD8aOf9FglQIH7cstQRJpsa6UqtGK+T2wRwrHj?=
 =?us-ascii?Q?YEwMX7PA5H0/5GKLypDWYeGvcC5womvx8rjmrYEJLGn4nmMQZJnhTnlEw2bo?=
 =?us-ascii?Q?nu7Uxgt9UPpi7NX/NPuIQ2pGQaaPiYxsK3D+wXYv7R6lRUGH6z9KKJyuw5Vb?=
 =?us-ascii?Q?uN0ArtIGw3TzFPul+AMErMyMxhatKLwwA2bqFEl4Kzm3gkwNfYcA3EIKzSW+?=
 =?us-ascii?Q?CG2BjzpjL5P7oqXqepW4XDduxJSPDCc5k+cvEwGD5TyZS+nmnP72ujW7xekC?=
 =?us-ascii?Q?ZxKVKpOdtWBA4kRG1eli1KWlvXLSDBGDh72klSCBtrL9h9txavZh4Gw5oANC?=
 =?us-ascii?Q?JkLSZNMvc3J44pP99HLac6dxP/5x5hf1WE/b?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:21.9035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7dde9db-3927-4733-cf2c-08dd1dec4865
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667

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
index 583727df1666..f02f0c0f28cf 100644
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


