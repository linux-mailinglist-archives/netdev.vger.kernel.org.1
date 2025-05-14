Return-Path: <netdev+bounces-190433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC650AB6CB0
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F5A19E8CD7
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596C027FB2A;
	Wed, 14 May 2025 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E13L/swn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A66127A930;
	Wed, 14 May 2025 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229311; cv=fail; b=U5EY5lXjfBoZw5N5hkUy9ZuwOPFBbrvjNyMlshAOIoS65XmOtJnW76U6fE95NTXn8i5cfVAZjMi0pcvkSvX72LmBz6UvCe8HRjtmp8X1GdjLn8xDpRl0ZFUvOdG/Dfpx3mjSyvAsyBKvdrL/fyxunxpRijhWl/VP11pwtKX07F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229311; c=relaxed/simple;
	bh=R3EfssR1sIuavCwlK4YpK1gKdV2DmzM1ozpNjSWYfEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYhtWGXtsPDBH2P/L7fLQsNziK4DWmoikpuJAPpfa9jEmGgZNxkrK+LFltlsbGr7Ohzrvg1j/5CmyWkcPuZlOihbvoXywCmD9N087h764mLWXjD5LxMjWdx5ziMa0w95Zlh1/DlbtiK9XbPw3+GwhUAoyJL7rHerTxc2yxNEe0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E13L/swn; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkUl4gSP7GIYuUefWso6tlEg4kZkCovGvBFQ2wHpR43N9ywPhXkIcNmvFFst3Omjux82dMCDQpNv3sTiTKJ8Zo4xIdI+xk3vkNgvHd39znsGDGmxpFTXM1IpOtwnHaSxkHZsLx9v3IUmXPTB4FRoo4NyvOvfLPgYYjYRnnMYviA0RZMaDu2MrnW4/inqwM8APuQzq0feAhLIM+71NK2lk43RwCFkh5QEyn5OehmuX7C01NnDnI1D4moHVcOs0EhgVgarBOhNFRHJ1F+3L1KkIhR4F3RT2j4D/FVFlqtEGn8Xz9APNg00udowCjzMwfcXsIGlnMIajcaGfCiuepKocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHqP+F9g4nifHdc5IJLw0MfVErw6QkqbknU4DE2UF24=;
 b=pJRS09sbyuO5BGyW+r6qCZQLa40l54iWglGWwLh0mRMRMEwJkz5fQah4xBMCbS5hQ+ZgbQsZOLvUE8142XiXxhsNXSo/dnNAoyGr67pVL/9MRCqWF4V/LO4czRf+tatSzgM1P8yVP+6vgfMl7JkBvvy1jJz3cZdCY3Di9HlebOKimTi8KN1Xb2+Je/sJ+tMmqH/dumVuxIkS9qzxpsuL3ONsal38rBW4WxmiI/nJWEIkQa8QZbArdL9xANrtdb/vrmwFI23nA1z0u6YXojUo3VSmw3FYvtC7lldbFyiFOflCXIQF7LGnL38q4EDgLMIsBAjaUkKOaM24ksBQ20CUMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHqP+F9g4nifHdc5IJLw0MfVErw6QkqbknU4DE2UF24=;
 b=E13L/swn521lDjew7QtZ1GxMjlM7YBctaVcmRJmR1eb0k8yP/ekFEtV4oZWq1y3Sm9ysOvS5FEXCN+u9u3gwisT2bysHVvh2SuZgH65GBaJKw3o3PpwzRVmhBkncqnWeHNZ3OD7EtSuRn1JYHi8Q4CrC2RrA1U2v/I4/6Zm20Gk=
Received: from BN0PR04CA0091.namprd04.prod.outlook.com (2603:10b6:408:ec::6)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 13:28:24 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::26) by BN0PR04CA0091.outlook.office365.com
 (2603:10b6:408:ec::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.30 via Frontend Transport; Wed,
 14 May 2025 13:28:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:28:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:22 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:28:21 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v16 18/22] cxl: Allow region creation by type2 drivers
Date: Wed, 14 May 2025 14:27:39 +0100
Message-ID: <20250514132743.523469-19-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: c6007172-fa52-4070-b935-08dd92eb33b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2/J+DGlC/JPR+mQ6xWFxPCfEaTBD01zfUIH/jR0aEIMmA32LgrlOFfBRD6Ee?=
 =?us-ascii?Q?AAz3pRGqSy6/8JSpfxGbo73TD8eGdpfV8W+HlOkQJvkKM+N6tkHWNSTd9psu?=
 =?us-ascii?Q?nU4Eea/gh6sLzRQSpk6mVYm4QRA5HsHJV5cTBVEHVneO7GeQDhh9YNvTlab1?=
 =?us-ascii?Q?jlZLdbM6lSmjv1dVPcagcYqNprHnDj4103Qh7saNoqGdP02DAQkHHehv+hx/?=
 =?us-ascii?Q?iwuKPUmME34VOIwMfBddhwvc80hJnrPiHIaf4iRIlRKV+2739r7XmI/0t6cW?=
 =?us-ascii?Q?ecnINAfUA/FuPMZyS8CTiMYfpUZzvl39NcJpZQUoBUh7oTvJE9w2+KaJ/uDs?=
 =?us-ascii?Q?Oa+ysFehfLUxVsOJZYekkKxgumYR9Zrm657loi49MznoTTn51FUx9c88e91E?=
 =?us-ascii?Q?dJKISWRvLsP7+y7G6/NmeS17SY4kildlGYhOpKcknsA+4V+hpWUURv7Xmfc8?=
 =?us-ascii?Q?FrTNxV2W3bT62s0SI9lr1k0EFsads7NUsGtTHrd3H7JBKp1s8/6yJUh2wslR?=
 =?us-ascii?Q?CZWZnqVXBQoaQPPtHuiUTWp2A2XtGIHU9QAXoNyNavWMWD7npm+BHB6bRTus?=
 =?us-ascii?Q?whdz17b0KDhmIWlwEtOEkfZjcZYczhUAlYVNFiyhs97dnoR1wkEz6fgYpKzO?=
 =?us-ascii?Q?+QdkN0dgeTEWPlS6OkH8CRtBC3hLWQ8spVrS4uVQInucMjASBZYqFUNeryDV?=
 =?us-ascii?Q?tlXXV60tl4StSVE1+TCQ0fJ+jSzInmd4bA5jm+h1sXTB81RpFh3y7YCzBmKC?=
 =?us-ascii?Q?ajeJTtKw4WNwNvFZfQJrrpH2IDxNmetuHsoFE/Gj7Rr7ToO6l/x42otKZg3/?=
 =?us-ascii?Q?aKeZV/70e0W4WqVbVETq40zEiE3MQM3zKSJhrZtsGyVMVDESi9fgHf5CrNlE?=
 =?us-ascii?Q?mhbN9PBhTb2aJJJPjLn0RgLkbS3I0GNZ3cm4g9+7l0BU/ccS2nml8Hi4Jtc7?=
 =?us-ascii?Q?l+LvHPuVu6/qgMSO/9SHHS7mJIJ4rO1VQ1OBxzTLHxwGNVrx4w+XbgZieRDf?=
 =?us-ascii?Q?z8fm25J8uF6cPIZf2uubLqf7uSrFlu+1ALl1H8Zgijx3RardRg5rOQ0n6VcB?=
 =?us-ascii?Q?kMCHLQamTZ6Ff/KBO0wzlT7FjE/p61GhzYQ4nHa3uSgFo9NlETXqEmj+dgf6?=
 =?us-ascii?Q?EoNcVGYuUmZoAQHAoms4JrIoUBcxQqQ+NNnC4sbex+k6GXazlqa7hVYVNl97?=
 =?us-ascii?Q?nbf6A/VHDPeYa8sZLZ3+Y73wgS4fnEfM3I0o+03508p0cazsQwO9k5jqoAaF?=
 =?us-ascii?Q?L9omyeZTrESPWvAMqYDz6okhzv1vsI3wtnphP5Zi0rl/67ZClbD9fuR5v7RI?=
 =?us-ascii?Q?7Pm6ADeSsmh1o6NfM4AQfAMwidPuy2GdmhYCyHT8NrMnhM+8Ve8F+L3Exc2M?=
 =?us-ascii?Q?K2TogX6vNjLeE5iQqGHhjxH6GMbQoftAY55DTOX95O9y6jwFvo6Bo+X9T1U5?=
 =?us-ascii?Q?jh4L1F0a2IWPbw58p9mZf3aX6vHe9ZjNI8N7XyafKkDfdm/UjafrAvxivfKR?=
 =?us-ascii?Q?JG56VVjxA1nGpd1aobDsC1RtBKjKT7Nb7nCnvw0gH1GRzu0Igu9kU6Zqsg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:28:23.8237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6007172-fa52-4070-b935-08dd92eb33b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders.

Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 140 +++++++++++++++++++++++++++++++++++---
 drivers/cxl/port.c        |   5 +-
 include/cxl/cxl.h         |   4 ++
 3 files changed, 140 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 4113ee6daec9..f82da914d125 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2316,6 +2316,21 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 	return rc;
 }
 
+/**
+ * cxl_accel_region_detach -  detach a region from a Type2 device
+ *
+ * @cxled: Type2 endpoint decoder to detach the region from.
+ *
+ * Returns 0 or error.
+ */
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
+{
+	guard(rwsem_write)(&cxl_region_rwsem);
+	cxled->part = -1;
+	return cxl_region_detach(cxled);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, "CXL");
+
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 {
 	down_write(&cxl_region_rwsem);
@@ -2822,6 +2837,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
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
@@ -3526,14 +3549,12 @@ static int __construct_region(struct cxl_region *cxlr,
 	return 0;
 }
 
-/* Establish an empty region covering the given HPA range */
-static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
+						 struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	int rc, part = READ_ONCE(cxled->part);
+	int part = READ_ONCE(cxled->part);
 	struct cxl_region *cxlr;
 
 	do {
@@ -3542,13 +3563,23 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
-	if (IS_ERR(cxlr)) {
+	if (IS_ERR(cxlr))
 		dev_err(cxlmd->dev.parent,
 			"%s:%s: %s failed assign region: %ld\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__, PTR_ERR(cxlr));
-		return cxlr;
-	}
+	return cxlr;
+};
+
+/* Establish an empty region covering the given HPA range */
+static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
+					   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+	struct cxl_region *cxlr;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
 
 	rc = __construct_region(cxlr, cxlrd, cxled);
 	if (rc) {
@@ -3559,6 +3590,99 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return cxlr;
 }
 
+static struct cxl_region *
+__construct_new_region(struct cxl_root_decoder *cxlrd,
+		       struct cxl_endpoint_decoder *cxled, int ways)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	guard(rwsem_write)(&cxl_region_rwsem);
+
+	/*
+	 * Sanity check. This should not happen with an accel driver handling
+	 * the region creation.
+	 */
+	p = &cxlr->params;
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s: %s  unexpected region state\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			__func__);
+		rc = -EBUSY;
+		goto err;
+	}
+
+	rc = set_interleave_ways(cxlr, ways);
+	if (rc)
+		goto err;
+
+	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
+	if (rc)
+		goto err;
+
+	rc = alloc_hpa(cxlr, resource_size(cxled->dpa_res));
+	if (rc)
+		goto err;
+
+	scoped_guard(rwsem_read, &cxl_dpa_rwsem) {
+		rc = cxl_region_attach(cxlr, cxled, 0);
+		if (rc)
+			goto err;
+	}
+
+	if (rc)
+		goto err;
+
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc)
+		goto err;
+
+	p->state = CXL_CONFIG_COMMIT;
+
+	return cxlr;
+err:
+	drop_region(cxlr);
+	return ERR_PTR(rc);
+}
+
+/**
+ * cxl_create_region - Establish a region given an endpoint decoder
+ * @cxlrd: root decoder to allocate HPA
+ * @cxled: endpoint decoder with reserved DPA capacity
+ * @ways: interleave ways required
+ *
+ * Returns a fully formed region in the commit state and attached to the
+ * cxl_region driver.
+ */
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled, int ways)
+{
+	struct cxl_region *cxlr;
+
+	scoped_guard(mutex, &cxlrd->range_lock) {
+		cxlr = __construct_new_region(cxlrd, cxled, ways);
+		if (IS_ERR(cxlr))
+			return cxlr;
+	}
+
+	if (device_attach(&cxlr->dev) <= 0) {
+		dev_err(&cxlr->dev, "failed to create region\n");
+		drop_region(cxlr);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return cxlr;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
+
 int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index a35fc5552845..69b8d8344029 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -33,6 +33,7 @@ static void schedule_detach(void *cxlmd)
 static int discover_region(struct device *dev, void *root)
 {
 	struct cxl_endpoint_decoder *cxled;
+	struct cxl_memdev *cxlmd;
 	int rc;
 
 	if (!is_endpoint_decoder(dev))
@@ -42,7 +43,9 @@ static int discover_region(struct device *dev, void *root)
 	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
 		return 0;
 
-	if (cxled->state != CXL_DECODER_STATE_AUTO)
+	cxlmd = cxled_to_memdev(cxled);
+	if (cxled->state != CXL_DECODER_STATE_AUTO ||
+	    cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
 		return 0;
 
 	/*
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index b3ca0e988ae7..d9cd10537fb1 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -282,4 +282,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     enum cxl_partition_mode mode,
 					     resource_size_t alloc);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled, int ways);
+
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


