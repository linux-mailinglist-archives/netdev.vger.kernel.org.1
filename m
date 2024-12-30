Return-Path: <netdev+bounces-154592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB699FEB29
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BECCB1883119
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68BB1B424D;
	Mon, 30 Dec 2024 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fcsVPqaV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4212F19CD19;
	Mon, 30 Dec 2024 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595136; cv=fail; b=LMRSKBKh9DIk+9WbV2glGEHzMjfz2gqIY/oUMV/xWVSwClbEoBEpGkYNw5893BCQIbDssf5ONF3Q9KnlF/mH2T+beH6yU5j5kKVfDcEZ74LCWVlCgMpsOoUHNCG+YPNQo2FY0RwuRrAmuIWZA/JsQWjiXPBTckDJPgXdG3PDQMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595136; c=relaxed/simple;
	bh=70MQ9+r7zYsz4MIQO9AfJJfmaA4IzFvCQ6nyRGYtcXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVeQe3y92ZY8yzB36q48l17mt62A2RPdtiRvFnDCevbSJKEL7z1abimqhhGqLwC7YEqQU0e4BhApDst4KzmwhKI9UM8EIJAbmsiOeyLEmz3n4Rcm3AgEfuqi/BsNo79Y2QvvjGs/tRarXGh4fJnUpIN8GaivoBS1qMEOg7A6uUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fcsVPqaV; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrQ1oOzIlxHDTNSEDnZ+H18x8TIx2isF0EqRkxtJGUhpclygujJA8UtP3HNWRBH4uu78ssZogUsKUGkMQhvXXGIaL34mkG+H5dcSybYLuI3Ui4G70rgvk5gIDBCamZL/JqXBLoPgVhVkmdn/Uc4bz8C4X7EuETn+lJX4M6oqD4voo62DPZ01DqlXJIu0aMWIqJfpb/rtfghnAEFcfmCRx4CTAK1jflFp3FOLbsppq3G6lyfM0gfzSduHUd/4qOSAcxyVEr5O2ZIMXl3T9ANOr9zHi+m/HYklfG4A2OxO5BWrIZkGWPLZLXykA9kJtYC0dbnTr6lbYRfGAkE64Ie7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2U2uhUU12H3Al24bRXGlBx1GJW7nj4D00jldHYmpHtQ=;
 b=XqN2DmnDsiuFXNKPFZVSLB6OWGSmwHy55ro5KcrL6MW69FCQxf1hcyTiCPqvTBOLqR7C/oo4b+Slyp62p5HqdBcrs6bwpUCxfwLbONWNrW8VUd8l+0BTKEhIvnioHSsgUB79fGv0jxUyDs2CJgxztL2iAzmCuol4IUHZJ7HnnLeuTrNyGdh02DUb/TvtCTD3NX6yVfnPfHw5K+CcPZfCPtCARClE+D1pIFnpx54kVwnI+NJj2IxPDTTznBK84fq5s65XbzvttC9SgR+4VXkDLhCE+cp99ky5rDiZCO5RkDXq2aDErbJTpL8V2uvH8H1ZzeDBkyvp9OhsAgUDqzMaXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2U2uhUU12H3Al24bRXGlBx1GJW7nj4D00jldHYmpHtQ=;
 b=fcsVPqaVhHNQl0t4bZ3UpvaXgNv/VU9yxpde7DMdqJQ04Ol5XFeHPig9v4to4FA2RRAvwiTM8pXNbfIBbwFmwULmS6zjlvDETsKVmM2PF6ggAkNICp2Emrzj9BmG2Nz3u6FSEDfQx0EEzv5ovci7XXkIEbvRJe8vf3nT9mfO+kM=
Received: from SJ0PR13CA0028.namprd13.prod.outlook.com (2603:10b6:a03:2c0::33)
 by DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.20; Mon, 30 Dec
 2024 21:45:27 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::3b) by SJ0PR13CA0028.outlook.office365.com
 (2603:10b6:a03:2c0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.10 via Frontend Transport; Mon,
 30 Dec 2024 21:45:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:26 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:26 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:25 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 23/27] cxl: add region flag for precluding a device memory to be used for dax
Date: Mon, 30 Dec 2024 21:44:41 +0000
Message-ID: <20241230214445.27602-24-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DS7PR12MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f34ae4-9dab-404d-5cfd-08dd291b4652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5yT0QmUwe71DOWlCpNbQ1eHqLYju3YANOYzRDyVodW0Ujo9RPRVrrSNumjTX?=
 =?us-ascii?Q?DoygiNnhcSBk9sXWRvV/tNpsPjnTGh2C5niER5IHFQiP/T5MqJde3NiRhXDJ?=
 =?us-ascii?Q?+XxIFHtFsYHZfUfhUzFX18vNDciDt/YdT9NI7V/vfMqjcgcm7Xlt+EdetCxk?=
 =?us-ascii?Q?I11b7Ud0tIDAy1mMQgRqIR+p+BzcY/fX+LS9rcqr8QaxqJcBJr9R/a6g1tF7?=
 =?us-ascii?Q?GWg4gwjA63C0rkpntLjNyspGK9XQW9EycnWcpcxNcd96YlHwXndslFScbz4S?=
 =?us-ascii?Q?sxv2cPGneuqWBgTTSkV+lUt7hRU028sQ3BvqcskSAIv5CGpo9dG6dAKvkIQZ?=
 =?us-ascii?Q?uIOedYyJIjhGUmqaP9OuJ+59shlk0R9oI+Oz5brdcFoHNATmiYH3iHzHkzZS?=
 =?us-ascii?Q?wvAdTjYPlPQNJwj5yC8iq6P03wFKZ4LHIYEWIKb9AyboZskDOcn5nAqTByoa?=
 =?us-ascii?Q?uYfSDcFLB0+9Wha1XgATb61zorHmuQe7nL/FbmAS21QwzNkhXKVaFjjq1f7/?=
 =?us-ascii?Q?qmVcB7cB/MHFoHluY/NpvQY+N9jslarrjq2eC1aSE1P2UVkkoPe+xzQQEv9S?=
 =?us-ascii?Q?B6O4vdc8frkUbhMSD4r0KpzIT7HwAcaU78vuwjJXXw+/hwFdcuI9yU0VNOKx?=
 =?us-ascii?Q?FlfyyuaHGMKpYtqMfN0g1dE0yyqb/0HF0N9tIRgpcIGMDtUJL5k/mS0jm3sY?=
 =?us-ascii?Q?RmbNthNJYLmDrqoSfoOZE/4FSPQ8ZkVw6woeSwDmm42C4qaObLnYk1h0UcAo?=
 =?us-ascii?Q?yDa35sEt++lFEzOp+WeS1UROOm4EXpob9D5SO9qSvjsilIv4s8UTe+sMjUaf?=
 =?us-ascii?Q?X1VAoYIda8obupaUMmQUxWF6NX6/kOB0IKBUifLtD/BYTfR7W29Y8cttMSWY?=
 =?us-ascii?Q?WaiLz5vBzFlQWHscB6m2bajpYhjKrnCu/B13E8rckRTHhWph9zMVll5EzaRu?=
 =?us-ascii?Q?HvwFbb5zIw2TvIST48aymLYeE+Qebigg+l1hkugpegyQFlj30mCx4mmFkFWb?=
 =?us-ascii?Q?tYYiLGQD1c2mKY812JLLa5ebYv5HnRC6B+CMxUZ9OiiOy4jJug9y63EmIwc/?=
 =?us-ascii?Q?lBLyXuCeCjZGElkgNC0BNO37cwBPbwETsVtSDc2L2MZ2bgJrKm9bt/8WjBGM?=
 =?us-ascii?Q?iMouagIvzzBX5hKzZgPeupt7a2lAF9G++0j7cq4WotRkeU+lGuYcs8NJz61n?=
 =?us-ascii?Q?zWTG1VcfutKDw92Z6XZNm2I0LAL8vmKqXQM9kVKpylTE0UKXRIMHFaZwPrfC?=
 =?us-ascii?Q?CfImy3MQPV0BNV4bPVq91s6BajK/KzoJROk3BDq9PxNNdpqL+SU9DNA+gTBK?=
 =?us-ascii?Q?L+3utOynhq0h8wa2dj/Gwol1UgX61be/PunCxEMM8nS+zQmFJmgieR3XtQbh?=
 =?us-ascii?Q?mPm2Qq1v8ipE6N4XBNhUZJBlVvbN44sj+6DEryeAcL+egOGMGCGlVT4vtbS5?=
 =?us-ascii?Q?/C5BZdcPl1zBxE+GP8nEJnWjOQS7yt5eeYq6eREjl8QgK6GUv/zYRmxtMz/R?=
 =?us-ascii?Q?rjyPv+P6Y01U8uw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:27.5574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f34ae4-9dab-404d-5cfd-08dd291b4652
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses. However, a dax interface could be just good enough in some cases.

Add a flag to a cxl region for specifically state to not create a dax
device. Allow a Type2 driver to set that flag at region creation time.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/cxl/core/region.c | 11 ++++++++++-
 drivers/cxl/cxl.h         |  3 +++
 drivers/cxl/cxlmem.h      |  3 ++-
 include/cxl/cxl.h         |  3 ++-
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a2b92162edbd..b3a68c1d0652 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3559,12 +3559,14 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
  * cxl_create_region - Establish a region given an endpoint decoder
  * @cxlrd: root decoder to allocate HPA
  * @cxled: endpoint decoder with reserved DPA capacity
+ * @no_dax: if true no DAX device should be created
  *
  * Returns a fully formed region in the commit state and attached to the
  * cxl_region driver.
  */
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled)
+				     struct cxl_endpoint_decoder *cxled,
+				     bool no_dax)
 {
 	struct cxl_region *cxlr;
 
@@ -3580,6 +3582,10 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 		drop_region(cxlr);
 		return ERR_PTR(-ENODEV);
 	}
+
+	if (no_dax)
+		set_bit(CXL_REGION_F_NO_DAX, &cxlr->flags);
+
 	return cxlr;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
@@ -3715,6 +3721,9 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	if (test_bit(CXL_REGION_F_NO_DAX, &cxlr->flags))
+		return 0;
+
 	switch (cxlr->mode) {
 	case CXL_DECODER_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index efdd4627b774..f28873a17443 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -521,6 +521,9 @@ struct cxl_region_params {
  */
 #define CXL_REGION_F_NEEDS_RESET 1
 
+/* Allow Type2 drivers to specify if a dax region should not be created. */
+#define CXL_REGION_F_NO_DAX 2
+
 /**
  * struct cxl_region - CXL region
  * @dev: This region's device
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ae024ae8fed8..b681f1382a39 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -873,5 +873,6 @@ struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled);
+				     struct cxl_endpoint_decoder *cxled,
+				     bool no_dax);
 #endif /* __CXL_MEM_H__ */
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index d1264c58f6c0..19f3eef44535 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -64,7 +64,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     resource_size_t max);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled);
+				     struct cxl_endpoint_decoder *cxled,
+				     bool no_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif
-- 
2.17.1


