Return-Path: <netdev+bounces-173673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A002A5A591
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833CD1892AA2
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C8A1EB5F9;
	Mon, 10 Mar 2025 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OjDyuV/W"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18831EF37B;
	Mon, 10 Mar 2025 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640666; cv=fail; b=aBH7CnSVeunZJ+pd68f4tBusGvMv9ElBdIuW5Wz7jE93Vu9SDW6FRHwMMbxua2eclNvmDj1DgsmDphTp93Ryo5HTnh31GGM7PplAIU1M2nA5zLTr0QC7uBjIGaUDPK+BemXHRbNkGYsZC5os/OW1TIb7dAdmsh+yQ5uV3ssntyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640666; c=relaxed/simple;
	bh=gcPP27FovahU3/3ERI6OXGtxsmauR2oa6hgUm2Z1mEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPkV6NL3JrOEKmmmhc/Fyv7SwMwxKiMXu+krra9+w78/WwZ5XqT8hrozRTcDUb26uOJNR9Ysvxt1odlww2t/q3ccZQF/5RfAzgP7a3m9HxcuZ+hMkp2ChMZvVe+0yAHvzPu51nbg9k4I1L+RBWC/N8vXZd5ZmS7Imk1UN03LxoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OjDyuV/W; arc=fail smtp.client-ip=40.107.212.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4A5xXAGJgcmcFSAP7BFqpF51gdxvPTU2cmjtOqMwCzPWNiyu8ac53czqecwj7krhhek/DVXqullPx6SZ8mmEvR5P1KJpXBblu0ebKKE3pYfcgnEfAuaRYOSTx5Fn+5RRMo2bRIW+u9JPL6cnxZBKbUEBQIYmE9IgZgDMH1ybC1DAnA5N4HsT6XvmzaJDKlC38LXHQEKIWYbDZtaXUEIl8LiOfy5mhkbRbYlzKlSAw0EEqPwzuS0Rs11MujZ3WIVjSUtwugqWP9q5NTXvpx/vwtw2VZ3pwQivpw/O2uZ4EuXgMh19DmTd1GCoPWAtdYfA4vpKXoBhFIh3FtcqwIuow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQDK6LBtBLaWpKS+JpqlMcFHS49iDyfoS3qqXzfd/Z8=;
 b=Rho7tqONsfAM792Qbv6Okrscf+kuE5ZU7el3CdDpkXKNP+DZS1J6gZSai2QU8X8yhdUJnV13KmTMuUrNEIozzX7suSx0/pzmRRvfLKCdSYfPCXgHiQxqBsEVJhP6Qw2Nr/RidLH/Sog851jhM94iLJwaTXcejDfF6xKjmQsFeEBIWES80wPCnfGNOYVYufk9axa7mjIAuO9jMegsDdhlXJSSQvtLRoYvnpiFD7ItCOGi80GzTfuL7FaQi33m8aRmuW75xGz2QqCGFZDr2iVFRCGcSFZvZO2dS8fINhlvo3d73eZ2YfP9GnEsW64DCcZsBJcWkq1hOCaNcV5dte75Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQDK6LBtBLaWpKS+JpqlMcFHS49iDyfoS3qqXzfd/Z8=;
 b=OjDyuV/WN2+ySTuZ07obpZ4jOY3x5ohlYnl0xgFLPDTFetc3jK1vopClPBNbPt6FZkXcQvm8mx8aDGZyfaXBdGP+bC8TedGJYtAdc0wzCYx9z5W8yyZXNZBS/iDBa9bgrRQkvybIvdjdWg7zhWC90z7KqPSxmq5xT5nx6XvWsUg=
Received: from BYAPR07CA0048.namprd07.prod.outlook.com (2603:10b6:a03:60::25)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:04:21 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::e7) by BYAPR07CA0048.outlook.office365.com
 (2603:10b6:a03:60::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 21:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:04:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:18 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:04:16 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v11 19/23] cxl: add region flag for precluding a device memory to be used for dax
Date: Mon, 10 Mar 2025 21:03:36 +0000
Message-ID: <20250310210340.3234884-20-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|CY3PR12MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bdb7480-d401-429c-2a48-08dd60172078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uzR2QbLy+hsSlb0dlxhZKqAEP6UmrkgIlf84ihObNQcIrSsEiSrrVkVuxdwh?=
 =?us-ascii?Q?4QhfqJKpUytmm+1cHnMb8eXwewU0s/qTIZ2UyTCoHdEg8DoNOG5KnVM0SpL4?=
 =?us-ascii?Q?wWQTuxM7B6k0sBhrq+J+gw9GDE5rorkJlWQzX8OW7s1O2kvcyNUrySLHGvTZ?=
 =?us-ascii?Q?0bUMvCEn88U8jJ25dLo46mAFx/Kqf8sdBC7T9KzM0f6p0OTaoemMRIqwmCh7?=
 =?us-ascii?Q?SfGvkpEuKpdFn8KzVEqtnSprrHA1/VOUUbce2DjWcvmCoB7/sKzxq9YeiXO4?=
 =?us-ascii?Q?oO9RByktNKaqW9XRu19ROpyTocU5dKyqTmhe5Ffv/ET0fqYOhUhEcRTT7GVR?=
 =?us-ascii?Q?p2NFJLVL/rQ7XO+T/WC58h6GV/Ua2jylsBrel7EVa7uFJw00vvim5v3xQgbP?=
 =?us-ascii?Q?9t2MIJImSXrgqhG8PxmA/1zIh2EWFbf69WpgC3zNNOXqJGrIjdqjd4yBqaYi?=
 =?us-ascii?Q?AxleSNnMjO5HjvCpOLND4Rb/69kmDV2eCm+pzmme9W1Y9HlybFJiPZrx3VVY?=
 =?us-ascii?Q?Zn87J250uKvyWA6Jd4fBcWgsmL3ghl7fjEcMZOtNn5DE+SpgPrO402dWVs+1?=
 =?us-ascii?Q?hv2l4zet7XB60fNg+UE9wO+Gp6EGuIjv87e7vt6MhoYnS6Mhezqcf1Zr4Apm?=
 =?us-ascii?Q?F7f1aKcy/Zy3FT5P2/mYnb+n+9ubcICwiqJaitQs1yCCwb9x2GB75CPJlEzE?=
 =?us-ascii?Q?peIuY7ek/ixhK+quZQ9ibDLG1D8I0E5vY+orv2bfzyfU9zMDy/kAAR3Pu2VC?=
 =?us-ascii?Q?M3skTQ569zAHH3Xnx8gFQwZbDP4HqFkDoFpCPRXy/yW7ogSi9Hwdw2k+T03h?=
 =?us-ascii?Q?cug9UZ17Ufkfem0wKuvX4SngPkq8K40sEBDyysi5L0fSboj95pWT7OOZogyk?=
 =?us-ascii?Q?0Iu3qk6OqOSm/a5eXnxJBGQNiTZykcinVt9fz7DMJO+JTYp4D6/DtVRyuZkA?=
 =?us-ascii?Q?+N9mKtG74X61el1JSmvXJKywiaCh0X/UQKOhtzVOa8nJQsmZs0bZyEZU+Pwy?=
 =?us-ascii?Q?JRqSLRiA3ElrjJ8F8pmVw0aIY9hClewDpdtgDMjv4hnegA52kOCMj4UTq+Ch?=
 =?us-ascii?Q?tzDiV/lFhGyqNjBRk4Y9CV9kreaK5MniqNOcMJ8Q3adluqO+Zn4dTYgIfewK?=
 =?us-ascii?Q?g9Y2Oz7pUCje1sPpfb57O/osCqrtFrgJ0BNbk0bUe5aRTu95Gy80WKapVLoa?=
 =?us-ascii?Q?+u8b9QP35z4Y8+/yJcW9AFeTtxG3KAV+1G2ZwFQV47YOtYEZ3sUhzhDTxR+B?=
 =?us-ascii?Q?+FYO22Quu8+2wMyDr3wjzelBECSoaSWmbXnqMcehRJH1IR+2qufGZKeORt5R?=
 =?us-ascii?Q?lsIqkOz04BdhbnfbFZ3fRzyq1DHZEUydZD1VXLUkqqITCyYJSmbvbCvBaT4s?=
 =?us-ascii?Q?NNK0jJ873I2YwfHQ9sVFLz6g/LtlgwxzgQBFNuHXGYt+K0IV8ubvqymrLm3Y?=
 =?us-ascii?Q?3kLLqaOQZgwgInwwvaWGJRI8rqH66VBfCYbPr0CqnivhvCCmmKB98TSzw+9c?=
 =?us-ascii?Q?gpGHt+wEr02sCGY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:04:20.0019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdb7480-d401-429c-2a48-08dd60172078
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses. However, a dax interface could be just good enough in some cases.

Add a flag to a cxl region for specifically state to not create a dax
device. Allow a Type2 driver to set that flag at region creation time.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 10 +++++++++-
 drivers/cxl/cxl.h         |  3 +++
 include/cxl/cxl.h         |  3 ++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e6fbe00d0623..7f832cb1db51 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3651,12 +3651,14 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
  * cxl_create_region - Establish a region given an endpoint decoder
  * @cxlrd: root decoder to allocate HPA
  * @cxled: endpoint decoder with reserved DPA capacity
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
 
@@ -3673,6 +3675,9 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-ENODEV);
 	}
 
+	if (no_dax)
+		set_bit(CXL_REGION_F_NO_DAX, &cxlr->flags);
+
 	return cxlr;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
@@ -3835,6 +3840,9 @@ static int cxl_region_probe(struct device *dev)
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
index 9212d3780a5a..f54d8c72bc79 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -260,7 +260,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
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


