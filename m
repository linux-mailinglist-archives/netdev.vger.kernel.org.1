Return-Path: <netdev+bounces-150356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A489E9EA1
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 20:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35D51888F0D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DDB1A256F;
	Mon,  9 Dec 2024 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zfrqFK4k"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DE619D060;
	Mon,  9 Dec 2024 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770521; cv=fail; b=f0AbIzQ+gqXmBC/VXthYzT3nI8vouw9vlJw8b5+tou2a8B9Vfd1oI3CVyo66dL9YeUEQ5fQDg4BsITqQmvY+edcC50P7Qb5mcg8/DglYli6tt5fPoRWXibb1djbioEKYkL3+rUOBWSMRDr3FoppqCl2QeWi0uB2wf/fH/nvTWeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770521; c=relaxed/simple;
	bh=4ABAWQmRCwApiB5wOwZB/kMuFu6p4+qMTbjXWily8zg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ol0+p4EyosdwkuAaBuKcZcN82g6zig2YXWwdQDr79UQXiBZzsAxo4d7bJLUABflWfQ2XEr+Ckte8JxEc3dAiqmY9+ndUgDudt6n6MUGGXdAAxmft4km89DNDgvBR463dENaivYnFV9gWtbca2ykWjXDRcAK6LBVhskoSkDSvTpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zfrqFK4k; arc=fail smtp.client-ip=40.107.96.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddtQCFODkadzQlP7Of296kud6G4vm2AY6zF+k9UDx/0Xez65u+M/QQI87PJ4OvfOkIg9ayMNQbxTR2w3qmyKFyueNhORA7tQ9/U2BJs11juqolEHB8lOGhO77SAqzmetGbQRfBN+be04OyqAsM5Ih3x+4PwcCBmvurlZoUNVDB/R8DaxepvvVoKQ67w18S8fMpvIgRojaDsH2dKSQgVx50I+wVHWvGqTFz5vPoaHdp22bKa6r3VIH0KNF9IhzkNpXcrNb5bdb9bsgz8q90uSa1Os39xusktCKtc1jrC/AaYso9knGHxt64lkaqJgQ4frDwnXwUN8yv+ig707aexBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxSlX/HNDcfSqziYmC5FhumBNqqNrff3UBpkn4jHNt4=;
 b=S03W//23Dy7D34xyS13Q1ox547Hx0HoK2LunMtywQVnyt+ZqIxxxC7I3AsYAUEdOlU/+6UG4DeT5mtdF+ZZ2o1t91tnBwbxjdaBBk3IN4w60FRFr257MS2jzErxF3mGC7VdhdfRYXs5R6Kl55x6TKhWcU079WtTrHmuPC4l+w6/Wcmxzyd6itwM87iWZljMe3D5Qq9JFpJLIZpYZHHvHDBaOpP9APeb+/TvYCPgouYyW/z6G1jYmPPwhQVJRLcbjPZI27+GyIFzeucHfCDjIrYAT9fXGLBet+gyXgF/DGH4Y6Axbac2Ol2b81LmJlilOtm9PhuYLM0wve4aJw03qBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxSlX/HNDcfSqziYmC5FhumBNqqNrff3UBpkn4jHNt4=;
 b=zfrqFK4kkTPX9yAqJQqk20IRSvO4vH11wgWCR9gNGlTDmnilEatHxjyG9QeNEU3xNfnYalOENp2OSg+WtOJbtABAB6w6qkFhgzYPk15eCHFc9hrzNfxPF2wRSiZwlVKYPzz1Bv4dRT20hoq2YDXt2liA/UPlPIQsVZVr/IfnkfU=
Received: from BN9PR03CA0781.namprd03.prod.outlook.com (2603:10b6:408:13f::6)
 by DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.24; Mon, 9 Dec
 2024 18:55:16 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:13f:cafe::11) by BN9PR03CA0781.outlook.office365.com
 (2603:10b6:408:13f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.13 via Frontend Transport; Mon,
 9 Dec 2024 18:55:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Mon, 9 Dec 2024 18:55:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:13 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:55:12 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 24/28] cxl: add region flag for precluding a device memory to be used for dax
Date: Mon, 9 Dec 2024 18:54:25 +0000
Message-ID: <20241209185429.54054-25-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cce8519-f7e5-4fd3-3cbf-08dd188304fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CSgV7c15k0rsoCcwMYTX7ldTF/h6dBoD27ujGFIeYbvbXn2iq2n3iwWgZvp2?=
 =?us-ascii?Q?PyTQ04AxLibRThvO2pWu4uXROc4VCQzP4NUCDx2ZQvmyMHO0yvgMt2JHFj/W?=
 =?us-ascii?Q?L0FDzK/icUBq134YMkGkJlwR6Wlku57w3+YXY7YVdqcHDpzYRVBYoOWBhVAC?=
 =?us-ascii?Q?b5NWlcy0cwn3nz+/kurYU05+BSgRmGIolP/Vc/U8VYA3oGTefdsQlYCQc5ip?=
 =?us-ascii?Q?o48T+C53Jkq3W6pX8XtDOvUdOXLPGCj3pSf4dmK2meq8PXjsHwYwQ3RqwZ/n?=
 =?us-ascii?Q?1utW7RawZQmbAdyhw4vESOHo3yH8fPXjRZUbGacu3h4zVNm3jH3QyrYnSWnd?=
 =?us-ascii?Q?33GRhfqfTnjFCkcNqtP0Pjc2jZCTUNHcyxLOhMZnYa7WGETZDgHIfWmDryKZ?=
 =?us-ascii?Q?rglsy5pzqcuuCSi/FaFXdjN0YPhIohZ7xhFcKULDrnqinnqYZi6l2XRsQ5xF?=
 =?us-ascii?Q?IfftMu6j20ffmT8gNcU2U1X6QvDZy27aN61V2VMc2jBa5mpAu4UC2OqsqygK?=
 =?us-ascii?Q?o7yLEkDwoYXEv8XGACsYQOTJXa27OKe6Y6oXQDl3cqGuUi8mlKkAF+d1tHis?=
 =?us-ascii?Q?x4dpCRuJfNq7mXRaRsCP7AyUgwM4yUA1pUxcuTQVPB3iT8v9ROhbNGmKN2CO?=
 =?us-ascii?Q?o1SszL4bLuui/IAcLgf7Jgn7Zc4jjs6CF/ZAT3eL06rMRuLNGkIwBohdSjVP?=
 =?us-ascii?Q?Nr6aDqgF7N5fqzXJAHUnP2LjznmKRGgXoTHhfMnoOpjzQ0W5RxhVE7VqvQUd?=
 =?us-ascii?Q?Pxg+Ywf3vxBnJZG8DURHSZo4g7HOCm4gdn4fQ+DIkdu/4J0JjTVqZdo+qN5v?=
 =?us-ascii?Q?g23EiTMDI2DlrDn6JkjiRJb6DwFud+h0tEqzoODG46NEQLr1JoVRIx0Qo1Kh?=
 =?us-ascii?Q?KUuIDD7TVEcatVC68x9EG4KREpCrpstksNLWsFfFYNe0tWBVtTBGZuJPJ0P/?=
 =?us-ascii?Q?BnvOeIWdjiT5mwzYtdXqXz7ttFUPpNe9TbtXcXf8FjFWKP25DnVHFh8fonQU?=
 =?us-ascii?Q?ipdCSJ4SVotq5JUTpHADyGRBpUHrag/mulCSslTYZljv4ZmCV12drJIdLI1c?=
 =?us-ascii?Q?X3HJGwnNMiTnXSbi8izUaCcWrOT1molfExn9oC9fnjmxaRdDg9NYaaOitDRp?=
 =?us-ascii?Q?rAJ7FyZ1skfOga+1N8+3b9fU9Zes/TNhNhAsqMROwfvuHixCLl9r98vamGsX?=
 =?us-ascii?Q?xFiamRZ7pw1FdCzJOm4h2pggzg44FHuqs/qThHHHJosCfADUtzeDm002VJ64?=
 =?us-ascii?Q?0vdrvboaoINLy/QQtymU2XgJtlT0xglk6qgVY7qdN2GrmhxfhDW3UL8ln9zX?=
 =?us-ascii?Q?xgivJ43uYHRdGMrWxUwojmPfArtJbgYdgEuQC7B9bo6PWzDHDNURHQ6nVUkm?=
 =?us-ascii?Q?LEcZiMeUFfjNvB8DBI5SCm51yLCG7ZiMXOOXcoT6o1dXUyeX86Eeknr1Dhpc?=
 =?us-ascii?Q?mk5s8S/wIKFwlF2+xeoeOm6MUyjMJCxIRaClG4doyW8VkLAeHkC+ow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:55:15.9119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cce8519-f7e5-4fd3-3cbf-08dd188304fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses. However, a dax interface could be just good enough in some cases.

Add a flag to a cxl region for specifically state to not create a dax
device. Allow a Type2 driver to set that flag at region creation time.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/cxl/core/region.c | 10 +++++++++-
 drivers/cxl/cxl.h         |  3 +++
 drivers/cxl/cxlmem.h      |  3 ++-
 include/cxl/cxl.h         |  3 ++-
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b014f2fab789..b39086356d74 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3562,7 +3562,8 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
  * cxl_region driver.
  */
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled)
+				     struct cxl_endpoint_decoder *cxled,
+				     bool no_dax)
 {
 	struct cxl_region *cxlr;
 
@@ -3578,6 +3579,10 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
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
@@ -3713,6 +3718,9 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	if (test_bit(CXL_REGION_F_NO_DAX, &cxlr->flags))
+		return 0;
+
 	switch (cxlr->mode) {
 	case CXL_DECODER_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 57d6dda3fb4a..cc9e3d859fa6 100644
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
index 9d874f1cb3bf..712f25f494e0 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -875,5 +875,6 @@ struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled);
+				     struct cxl_endpoint_decoder *cxled,
+				     bool no_dax);
 #endif /* __CXL_MEM_H__ */
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index e0ea5b801a2e..14be26358f9c 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -61,7 +61,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
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


