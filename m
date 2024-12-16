Return-Path: <netdev+bounces-152299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 298739F3597
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838FF1884C8F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156ED207DE2;
	Mon, 16 Dec 2024 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vY5yjeg9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606FC207DFB;
	Mon, 16 Dec 2024 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365493; cv=fail; b=eLitMCyKRg/jvJpPmg5VxYwz73Xbvl39PIiL8HU+yo0fGvJYF1/PlenRFIhrjv1yw/zLGEgKMzGrf28DcsurgZUl3dGWrjDE2r3NogmaSq8CfYJJBn/yD+VffLUXRA00ynIpRzA14uB3e8j7n8gxsHTzH6wr64FDlkfsIpBqMxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365493; c=relaxed/simple;
	bh=k20ZtuzwKec/c1TMP5fd5BlgYCtoh8Rj2LEiIPuuUc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Foyu0IIOETEW9bEqtWpo/u0Q08an3KmOHxdatV/Ovq+71/TIxCUttq0psfy+W/bysNR0ZUtFpdl9wSFdktYRkMj9eWxq1wOo7SY0r3rwf9Pd4swaZrMB386oHWRG3CTIaIJ7ndxw+0FMQ/GwfrhvuQADUMpTYr+FhJNe3+ehxvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vY5yjeg9; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SitTnuGQ6tCWPZEDUjqJIqd3weUyMQFZzJuSPuGjaqvVO5AJK1T5KP5Gua436CohH0sH5ZGjsH5Ze3pvta7u60u1MXxYfxnZTeFcVwQu0NLJx4IvX7MUr3wMsWHWUx9tLUqT0BrNOO4ZsSRAr06sGEW1o0LG11yl+fgMt8wYhcsyYfOrdvxTna6xAab9l848O9H3+VX0KcBkBEP6+jFIFTjkzSwgQGNwrq+mHvLIQ+bH5yP0cwIF/XrdOMe6JNXG3R0lMJiKpEqbSKOyABtnOidcjTPOqMGYcVpNoSraQhvtK1cQCC6Ktr20py4Li3tG6+F1WnHcYjESvAkVOPUYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aIDB7A0M+sAuCAgTSOA6eDBiml4rQNeH5U/3VCcWcI=;
 b=gfVFZQ7vyqnWrUFik6pUE2CSefEzX1T2KKrVh/34EC673LVDG8dy2J6qQ3fE/APUnSDQr+ClNkJ5G5AS12/0A7f1ievxaGAWyOwVo1U1Vx6ZRLY+n73doS1zoFVkqXCQFbkuPmhhqZ7yFYKAZ5KX1yypa3bmsf3S6vdiGem/jFNzy34svxvKS+gMhtm8tSLVYfBnhvmeHYE2ISGKdhilhH4ge/mA/SfacqDog/hFMwW9Uas676ssRfOstKxhtRpui4reu4M8E38RVk6uTZ1i5V1UIUEB9KPg+bP5zS9ybRhjE7u8GCTXNtrZxNaFs7E46h3WY83Y/YbZHelv5tYKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aIDB7A0M+sAuCAgTSOA6eDBiml4rQNeH5U/3VCcWcI=;
 b=vY5yjeg9mdGTejy34SbKZ4n/6iC8RJavMlLzwvvUcpVICXq52YAnvcKKMf10LNYunfozFO6ofJAEomeM2G29Ag5PQfn1dOUVZMSxw7LRqS14Ac79deL9WHrde/z7e5ftw24pmtvOUpbz1qI+7gF4sD9mtumliaBPacgRY4Suh/4=
Received: from BY1P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::16)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:11:27 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::55) by BY1P220CA0021.outlook.office365.com
 (2603:10b6:a03:5c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Mon,
 16 Dec 2024 16:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:25 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:25 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:24 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 23/27] cxl: add region flag for precluding a device memory to be used for dax
Date: Mon, 16 Dec 2024 16:10:38 +0000
Message-ID: <20241216161042.42108-24-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 9afd979e-5cbb-467a-1d21-08dd1dec4b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sc6tlAGmpSt22DrvswydmORhGCxxQO6ud/T1Mqv1bmruDCC4QgsUeEaNB0tP?=
 =?us-ascii?Q?qBvJ2//+by3F7BcLMtDsou8fC5NlQXgvux7IaietU0lYDC1R+iCIMTzHqLSr?=
 =?us-ascii?Q?ttRMfhye+ebrxy3UCsRKumt9+Z+Ox9LsAGaCyHXngmMAU+zZDHcvHd7LN4IT?=
 =?us-ascii?Q?na1iTNr9gf1OqvkTq2VKUVLpOmoGd3FiCbA6F6XWFWf2pc7Nj/LZDdSMJ+kx?=
 =?us-ascii?Q?ukzag/brenpvRnry1GJo4g6QQ478nXaAk95nJZ0wijvOCmixjj+IC3KR5mKW?=
 =?us-ascii?Q?DqEjIAC5JQOsoKYzcCbH34vZ4IUG7PzeMDRJNAb/8L0K4YLoWsyrsHEJDuzZ?=
 =?us-ascii?Q?5nPuxKacaO9Zt4fWIILlGpMHNQ7rK2mrj64PJAsAaQW9YfMgqS6wxa+LqjfO?=
 =?us-ascii?Q?chMKGEmBAvfGfDoBQEVxmKrO9qhswJwtlXt5LgYw8tnBzPuG48UQjjxcWcuy?=
 =?us-ascii?Q?zDIV5bNJC0mfZZ2djUWuTCdDexqSiCpIJ48XOmeK25d3vojOuI5MRDNG+S5Q?=
 =?us-ascii?Q?d2J7AqdfuuSC59fnI6PzMaK+Y1oTk1cdSGQY6KFI4DNNHmoEfYCsvOJRpuYV?=
 =?us-ascii?Q?REZVad7EljHUC8GuLPBdUqnTJBgWCV+533vQLocSabp9xwUPhlzNjeO+b3f7?=
 =?us-ascii?Q?nDqs5y5lEypdeimMCfYPpWnmxIb7K+HGQPwzHGh9DGNDnA44T1+jRreuMrlK?=
 =?us-ascii?Q?hN4IxgRtKn2rByZ0xAwwBIZ1RMsdwzLyJRa8MQSh1w4KE+i1laI+ZpuZhenV?=
 =?us-ascii?Q?uiaaRqLgmsGU287eIX+2tS26FV8K5j5pKMVtaN3fP7z0DNoybhR9J+4reSqN?=
 =?us-ascii?Q?Tycq0SqS/6Yg0NMeSOk0DI5GKnl2d7JDE/et/wegU6LfDCd6EvKTVZwIDVP3?=
 =?us-ascii?Q?EzIQm0J7xN6TFNA+2pjPggYYJpQiDOQcX6Unmt1Zx369X3NKkHtLkLKASTDM?=
 =?us-ascii?Q?EWyZMaTmNUvigeSjEUcomuWBE/NvXcqPP0Lzl112scIRU551ZMLhcF6UQjnh?=
 =?us-ascii?Q?nf//c4DyL+xkRPQEVp+hCdUcS4dVwijViMoskhm8wM8CwqsvDXX8qvff/rrb?=
 =?us-ascii?Q?W8t1X6DqFShXrEeXtbD6+1I6TO4shSs6HySIX/pCA65GhOwdPpW0/KBN2LcH?=
 =?us-ascii?Q?6w2w7QB0QsqhCkojLE4bzJXCTJCbSeRjdhIUFY1jJ7ZfjpUYwGT9fwKlT85b?=
 =?us-ascii?Q?CP4s/m8Fgdm092QDKqp+7/eiQJxdkS7covXZ4W7CyxSnw1QvSS7RuQ1dkeCA?=
 =?us-ascii?Q?zMrNEm0QKlHXu2IbIhbWEM7ej0dPri3v2Gs4iVqffobMwgaQZk89H70mhbmp?=
 =?us-ascii?Q?k1Rp8olqFprYJZT22MeLL+UkrJ9RPK7/5nYNmlWxgQGBGDsmDvWmaFkwlURM?=
 =?us-ascii?Q?9S0OJEcnyautMqUv+aOUendwHtPrGj7LRl1mlXPVVHvKV8dH/NooD4rzydxn?=
 =?us-ascii?Q?mhDLpAMa8Df0QR72gyI/1GgImQp9hDZyyWPEDRQoX39Zc1Gj7guQUjHvs8mA?=
 =?us-ascii?Q?wVIzV836X49ih3s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:26.5782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afd979e-5cbb-467a-1d21-08dd1dec4b2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189

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
index a24d8678e8dc..aeaa6868e556 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3557,12 +3557,14 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
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
 
@@ -3578,6 +3580,10 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
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
@@ -3713,6 +3719,9 @@ static int cxl_region_probe(struct device *dev)
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


