Return-Path: <netdev+bounces-178329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A70BCA768D9
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2C0166DBE
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192EA221731;
	Mon, 31 Mar 2025 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TWByFbam"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6584A221573;
	Mon, 31 Mar 2025 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432405; cv=fail; b=Vapn58ysDg0ZzUaUyIQYrYvQvnEXpG4tZYwNfRRD8GXytwKhTe3SVfESycgdrzSwZnlNysQ3xLu0Hvh0KjP2BDIAZIZRmGp4I08C0hdpW8ehCeaHURQTnD3V91718+oQSH6vvXY5u0rWkBa2cIFub+JyavJj7XCFZJcwZqxP6Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432405; c=relaxed/simple;
	bh=3tlN5A8OeJZy2axZgM3nUMFQT88vp2VwEvIB26XuzAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9Cwo+f5y3OTlkJaeO1jkEcwT7k2lHSkqC7QCnWAJTzyondCtLv3sjgfpAoQqOEYLYdHQGqUHzzzQeaWDfStDH/tjdj//3AcrzRG8RmPDJpGGIPQ2aXLNJAOj8x/1g5LXu3xr/zyjcdJak/4KMG+bJ0/IGtUCnvi1EzLb0KVcLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TWByFbam; arc=fail smtp.client-ip=40.107.100.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxR+pUdBokBnuVNKArliq5jD3SBnWGitKx9CHlkoYHueSoTo4jCyuWQt9S26g0SimIIm+LaeclQ9EdqXTH1TNC0/3qGp8nFXBjJur0Vo7zk1ZXwoOBmb2v37xtVAZKsODd6JIrqFljpAJC5BmWy88Cek4Isxgnuk3Kd6Gaqzv/s4Z/nf0pgm8rHxlo29A4yqaZStgyX8dFBIHAB2teQl2eb8dTbDTxjI0VeKx0A9Z5rWiQHhdre8SzW0f2GKQ0ucwuASPIBtQLs0HsnexKztKDRCH2QlDpYK5ixN6wn8jEpEaBn8nbws0MpKPbTJVGBqrFzkQkpVRi8qbTI4zXlwmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/STeaUyEhr4PT0Uwi4qrqEMjBg8NJHmUYJdMKU4CU+s=;
 b=V6OQLLRjxlI8RpRcsIOcdp6Zkyrv04ZvN2ULoGzh/rYfRruzwnZl/9CvBquAl0vBH0k47NYbIWGZ+Gd118o0+79ljaU6RTt/FjN7qmqMxNUd17DpzyjvxhsR5uUZaX/qNn8daSO2yDdf3CRo3oSBT1GELFPpbpuWHZWLjxmnrrUkdxy8kKmTGpNBKEb9oGO12uBVFuWpZFCHh6YYg6KmyLUaS+I3LbifZo5VJ5qAdPZBa3TPiz4JlecW0+T68fsURAmLAWiDlU/ym0+oHBpBJj9CmlA8RR5Hfw5YMl+awAKRbgTsHJW6YlDt4sZn32G9o9/sMVaan46YM/CZaq8Cfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/STeaUyEhr4PT0Uwi4qrqEMjBg8NJHmUYJdMKU4CU+s=;
 b=TWByFbam5qRnCnVibBBIAcXkDJ1BZOtiTtSWOUp+0rC+gm5pm0WuspgBy9C4a2OdQqRnXIScxbpeFbip7sWW26HnX43/bVqI79jNfhnuCQiyjFO50AICiwrsjfHm9cF6VWFe094+tyV3PDPJ13X2Kl0L2Zd5+AdykKmn+9/Ul9M=
Received: from PH8P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::6)
 by CH3PR12MB8849.namprd12.prod.outlook.com (2603:10b6:610:178::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Mon, 31 Mar
 2025 14:46:39 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::aa) by PH8P221CA0027.outlook.office365.com
 (2603:10b6:510:2d8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.38 via Frontend Transport; Mon,
 31 Mar 2025 14:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:38 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:37 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v12 19/23] cxl: add region flag for precluding a device memory to be used for dax
Date: Mon, 31 Mar 2025 15:45:51 +0100
Message-ID: <20250331144555.1947819-20-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|CH3PR12MB8849:EE_
X-MS-Office365-Filtering-Correlation-Id: e565c96f-91a3-4040-5d4e-08dd7062d843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0EZAuaQDacoSx2uUWSBZm3xjoUn6PNs0RCwDsN1IV5b4LCq1XO1ShCBNEeAv?=
 =?us-ascii?Q?KJ6XkO06oCE49DU7GnHyBKMyW1gkOjt7cYgZ3slV4PqCG6/aHxHTK5VRbdQ2?=
 =?us-ascii?Q?0uiCMjumQ785WctkKfB8bo7qmnmkaTnwxJqChglSgYkapRETi26ufOosA8Px?=
 =?us-ascii?Q?lfMORCCVacG9pOJSmifDT+nLirkaoksay8XMKRrK0vSWQluUBOyqjzCXiyCW?=
 =?us-ascii?Q?oB8GWCkJ3Es1PKF80N5ZPzH41JRH33h3WwPfv8+HxLbCx8ZYBkD74R0Telzb?=
 =?us-ascii?Q?lGs367UxcwXYQYrc/1iKeJI58E7ZETt5ENGgprCIqSvAnDirfuMCjXhOwaSI?=
 =?us-ascii?Q?afItLk73urB+d5udoiCpnJdMrc4kkOHbIab8qmOeVFvxoEVlpqmfgvA5FNSf?=
 =?us-ascii?Q?3ZXJzFSyPtDFzo3Lh1ZpPqEFdW9KY5hJDALfwqERXQC4zVCvAiVKGJ2KMxgL?=
 =?us-ascii?Q?jW3p6aGwWtf6XBmZllOBGtt3MmgSBaV6IJtQR15clYlRDHgRWQLmuEY8beGm?=
 =?us-ascii?Q?Bt0swmeomx8qKWgmWlrr3gUSGpVtUrdwBm2yJZsBU0V74PYkSpyg4cIqO84F?=
 =?us-ascii?Q?fydfgf7BjP/g3p0cuXyEr+WHbHzko3CJqGbst5M12ENnRAEvC3swaCH2BVUK?=
 =?us-ascii?Q?vxz5Wm4miuYZ0c+cjmRFDcnlOT2dKJyZWt0kibF82UnQmqqcvMftyhqozCMx?=
 =?us-ascii?Q?lhu7l5rYMv8wSZ6m0qcvjXr08w4dOzUXZRQiHyQmIoSbxzE1K1GH8ny0IMZD?=
 =?us-ascii?Q?ixBTUhBuN8faKT2BrMJ4Yuvn//SXnRz02jSAgoa4XtwAHs45ml5c+WUIeO15?=
 =?us-ascii?Q?CdYt5UhBzJ+mflUKQouYW5S4Qn4gIZMDJjQmwsjm+PQhaxmWr3FFUueXQNWk?=
 =?us-ascii?Q?SU9n6W/9h9Kf9/2e1I32A/u/f60G6DJFv8g9Y5U0d/XRR0BIotbwWInzVX1O?=
 =?us-ascii?Q?wxzZxnPIMJBUXEKv4NKwRuk/Jd9MSmBHDuzayU2MbPNwV5wLS0scYnHPuTvb?=
 =?us-ascii?Q?wvgcCLU0DGaTqpCNCJC9ABW2mmz3DRR1OtVJ7KUqY8jDAnxizjP+SBvXTOoe?=
 =?us-ascii?Q?ZMqpalV44MaBupxzQLdrt2yZXE9XUrxp2tvWkMeK3q5v4jErwG8MchTS8nWz?=
 =?us-ascii?Q?Txkqex/C4jGPE0K7QNtr0K1tZUuSxE/TBx/l2st0LmdmyejnRRXVGlk+ze8Q?=
 =?us-ascii?Q?Rn/ys6aQg3isTgNDPBNi58TiYkCN/KKBoak7bJug2SwUWNi/HWEGBzaIGNse?=
 =?us-ascii?Q?quSvpWo4ZbfwUvxALeUq9QWkeoGxCvM+//3RUCx1EXnR81xyTy9osW8onUaX?=
 =?us-ascii?Q?UPvnzvE0Oc4xqVByKzsSrgU8r5sm6iTU4aToW+fz7Mj71Hty7Klu6mifC7u0?=
 =?us-ascii?Q?RF0NQPTtHGFi7/d+jhLqAeLjbv/7cZvccv3nGMwEXHI6IDHAhFVMzxViu/Ww?=
 =?us-ascii?Q?Ru50m9pyk36OIA3Re9imNLmnv/71XlYW33rldm5iZz2MCRs/4702T44RjiEe?=
 =?us-ascii?Q?+R/Jx7qCPJINaipi1UTaudYLmXqmjAbAJrR5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(34020700016)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:39.3096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e565c96f-91a3-4040-5d4e-08dd7062d843
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8849

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses. However, a dax interface could be just good enough in some cases.

Add a flag to a cxl region for specifically state to not create a dax
device. Allow a Type2 driver to set that flag at region creation time.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 10 +++++++++-
 drivers/cxl/cxl.h         |  3 +++
 include/cxl/cxl.h         |  3 ++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f2e1d5719a70..58b68baf2bf3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3646,12 +3646,14 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
  * @cxlrd: root decoder to allocate HPA
  * @cxled: endpoint decoder with reserved DPA capacity
  * @ways: interleave ways required
+ * @no_dax: if true no DAX device should be created
  *
  * Returns a fully formed region in the commit state and attached to the
  * cxl_region driver.
  */
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled, int ways)
+				     struct cxl_endpoint_decoder *cxled, int ways,
+				     bool no_dax)
 {
 	struct cxl_region *cxlr;
 
@@ -3668,6 +3670,9 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-ENODEV);
 	}
 
+	if (no_dax)
+		set_bit(CXL_REGION_F_NO_DAX, &cxlr->flags);
+
 	return cxlr;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
@@ -3831,6 +3836,9 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	if (test_bit(CXL_REGION_F_NO_DAX, &cxlr->flags))
+		return 0;
+
 	switch (cxlr->mode) {
 	case CXL_PARTMODE_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c35620c24c8f..2eb927c9229c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -405,6 +405,9 @@ struct cxl_region_params {
  */
 #define CXL_REGION_F_NEEDS_RESET 1
 
+/* Allow Type2 drivers to specify if a dax region should not be created. */
+#define CXL_REGION_F_NO_DAX 2
+
 /**
  * struct cxl_region - CXL region
  * @dev: This region's device
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 133d6db3a70a..2bb495f78239 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -262,7 +262,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     resource_size_t alloc);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled, int ways);
+				     struct cxl_endpoint_decoder *cxled, int ways,
+				     bool no_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif
-- 
2.34.1


