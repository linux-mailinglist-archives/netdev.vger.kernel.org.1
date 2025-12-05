Return-Path: <netdev+bounces-243790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 833A6CA7EC6
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EEE4322C3BA
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95A332FA17;
	Fri,  5 Dec 2025 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yqMU94Kj"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011062.outbound.protection.outlook.com [40.93.194.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7F032ED51;
	Fri,  5 Dec 2025 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935603; cv=fail; b=oVhlfiZBjzTohc7H+hM+iwe43sE5/qmf5cg9N+L5xvIdyhAD2UJ0t8wXzBdi+hT2QWaelNRHL58QLoaNyFuR73dr8czvF7XqR9fu8WlEr3986WCewFmhGEest1dRiJCHYJeGpo2q5XlKWJzWqYqXTrYvCOIbICOgKt43wQtOSyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935603; c=relaxed/simple;
	bh=OItcUMbDh9zsVpfF7aTeS2C6Ega16aO7JtVwE0c98C8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXnGzGUFtxyrH4ApHQDgEDvecIHBYJeIxFIR89kVsyO+rnh2Iy4rY7RSYKhJZW71/BR544lwZQfwSCFC8VofBncBItUZUFkpocrq8iy817Vq4DsV/uzZetIi5Qvj7XELVU3V2bxkISXBQ//T4QAfQNwbxX7E1/0X4wAiXnZbkZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yqMU94Kj; arc=fail smtp.client-ip=40.93.194.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=me4DmB70NgwPf/J3R+ehI9EfJDwyj6hPnHV79ethyou396QTkVh8q+7M5oqTZ+F3eXkLSXm5MmjuQmmnJL4rIXG3t0rthUirw6ksIgsfusq0XsR4brWIvdxYOomAHUF1e+zNLh/FvDqP7HNQRp7rgQFF1MCS1/hdyLcXqF2rCckApqciH/kERyfk5E122lGSc4B2lj3bwBzwPti6xisaSyN3/pMoQ3snIbwapu+qvLh9eLs5dOeYdhIZ5YZ3fDfic24MeRWn37ftgIiMqbxUopLabIClD2Jg7sSyWsY1tQzjulteGAnIpwJyeTSe1z+NbomdG8WLFS0WyIrIcpKkcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7kKjRMWi0y6vC69arlFf5m9okcexubZKWvJs/BOHBE=;
 b=vUKiT/sldnGrsLkjD4Wp2LiXTRGkPV2CPCcO8gGNEbV1wyOSvTC/vYygOgBftSyjphNc6VoKGccNj6vqTsxSIud/lQrUj1yOJ4jBh6idWuVpmNyFWpE37xdGtxI4AXlWxDgvdn+vICg5fbHUoUcFGMz0xwYHidqT1xCs0+/h/DpZ7C/nablHFwqOGMJAEI2PQX4odPgc+t7vRWiV+Z6CSFXZg//vc6hrUlcnHgutxKEM6tkWn0H7QTr/WyCb/ua6RcBmXTgcNN2pOXbiWBtRo3o+OnEY4WeJsoi9KWyx/0DqlB+COUwYZL5q4QJAheDcSVC9ru5C6aO/rA1kcqwsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7kKjRMWi0y6vC69arlFf5m9okcexubZKWvJs/BOHBE=;
 b=yqMU94KjEwr/aejgfhTrqTDv+VsuLjIubLpyR5szMz6TEbxPYlRMLVFiuXbWnxm69iKRtMksmp9QVNQLlWt1FqV9dp0MlppIFFlvv55wZb877YB20S8yKV00V5Sh5WWiLUXhlCAv2gtau+/fjR7wlu2VaJy18GOgKWSQoeGwAuI=
Received: from SN7PR04CA0180.namprd04.prod.outlook.com (2603:10b6:806:125::35)
 by SA1PR12MB7294.namprd12.prod.outlook.com (2603:10b6:806:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 11:53:16 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:125:cafe::88) by SN7PR04CA0180.outlook.office365.com
 (2603:10b6:806:125::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 11:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 11:53:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:15 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:15 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:14 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v22 12/25] cxl: Add function for obtaining region range
Date: Fri, 5 Dec 2025 11:52:35 +0000
Message-ID: <20251205115248.772945-13-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|SA1PR12MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: da5460ce-3c1f-4994-d250-08de33f4e053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CCzkwSAFe+/bgR9ENONl9WmgWNBQPCaXNwxJ464/TARsfohAbiPLZNezrpaY?=
 =?us-ascii?Q?ZhdMpvibxSBl6CeaFTMwadmbWgS4Cpfh6wt4+3yWQ8thkrutnvX+O0zdxzka?=
 =?us-ascii?Q?9I0vanY+024H+fU6DVc9c93bEzbR8hZTrni/J8LJJU00G2rcxAODzPEPw8v1?=
 =?us-ascii?Q?7InfqJL96o5O8N/7DsAML2Q7j/l0vx2HOSdQO6L4ku0MLJQDM0proZDlco1u?=
 =?us-ascii?Q?JG5jzXzPa1EkPmgkQKLMUgSQI1v3+VKIZuhvOIHdUe8PpAzgpnJLe2Q8/B0R?=
 =?us-ascii?Q?J03tZpE+cXySJyRYCH1w1bPFiL3AiItQSG9q2MPm/tr1G2DUPZMfRMYMI7uR?=
 =?us-ascii?Q?0W41Lj424Apy1jfpxiS/7aK2RQNT82fFlBvR3gkN47xeVCFA6ceiAWOCi+Zf?=
 =?us-ascii?Q?DgEQadQ6bZp5nHtHk+n/9jTvFWsAvZ9t/gvYWvpPd3Qr+NLFH7yAuXbVyud6?=
 =?us-ascii?Q?BngXeuQHA7O0JYdoe6xJQBCoP0Zxdbks6E7Bm5+4lTcOmaleBzzq27pcanTY?=
 =?us-ascii?Q?bVn323ywXmgC/GdCRPY1SAZ5IBBPkhEO4jzcoiLClsBG+PBs2NFcxvP+bu/v?=
 =?us-ascii?Q?wuLtFqTiJTJyXNgQcm1oMEfuhq0zSQ7smT6crJH5CbGPEIxQrz402tVKqBPd?=
 =?us-ascii?Q?fqRQ4Zd/g8dD2wH8Pr10DNupDdFRDLRML9S751DM1FcIGX2RAU8cDwbNqRa9?=
 =?us-ascii?Q?p+DJaXz8uLcYJAUl/LWFK4kjBSgAa+CJ73jJQ/jKbupzp23iLOdgZxqumpqH?=
 =?us-ascii?Q?lp67YKc9W/VGmioWA7esC9QH0IKZMst3hEfbD+UVDbNNWySezhUw+Wi2r78v?=
 =?us-ascii?Q?K2XmtCCJTpagibf1b9h9Onp99SttuPT2GlPEkmLxYGyElhllf/fFgNyTOp9w?=
 =?us-ascii?Q?m51mTMPY+4E8hv4uIxfy4qq8h55GfsVUeecMAnxOk0fnmG3gJWJm1G6X/h2N?=
 =?us-ascii?Q?kFLXtLkaYS3WP15kxGZDZDX9Esl8xGld94FDkZaNx06ArjMpXKdsDzwtNCWb?=
 =?us-ascii?Q?TsxMeny6oMsushbNg4oJolM7MXepwGkBvZCniSU6IS0GCQsOYS3Pe+5qG3Pz?=
 =?us-ascii?Q?OgGrJcMN7H59CY6hc0aMDtKxkpHu0pe7jvALJxrewZg3dqP6dVYlQrIglfNA?=
 =?us-ascii?Q?qNKsF2Y9z9LazuYgOGUl/3ZepYgSODBg1R1P0XgzcWNWbYQx9ZCsFhkdjRi3?=
 =?us-ascii?Q?vDxZy6QeBJWWNSc0JlYIInTO0EOINyOPLVPLkS00SXZ5GqDjSoGtuFYnT+F3?=
 =?us-ascii?Q?w8QHCjhlfAZQDTFw4Fj6n0cZpsg2iql446SuS+yUyp7+khEUTjoROYxSnlgq?=
 =?us-ascii?Q?V+dJWaMOsVFJhm1i22Ry/Om3lAtjEEqvAjuvUDEMHFQ2N2IxEDVDFdQeQFAB?=
 =?us-ascii?Q?jvlJkedpnR0ik5l/5K9in965pyV3KObCM/MB7sjsPCtWP/x96jGswXGfdaF4?=
 =?us-ascii?Q?FLpzPMFuLL0tv6X/HImgkbILc4nHPGNWqZFh/2xp4su1bpP1biLcMw3+bz7Q?=
 =?us-ascii?Q?0+VtWbqt4EICsE7kIXsO/AJQeyTKKuUTiz1ip8g5JIjMJaXiF4F4g9jeAXMq?=
 =?us-ascii?Q?45oVFtTOiJW6sUWu/6w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:16.1158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da5460ce-3c1f-4994-d250-08de33f4e053
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7294

From: Alejandro Lucero <alucerop@amd.com>

A CXL region struct contains the physical address to work with.

Type2 drivers can create a CXL region but have not access to the
related struct as it is defined as private by the kernel CXL core.
Add a function for getting the cxl region range to be used for mapping
such memory range by a Type2 driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 23 +++++++++++++++++++++++
 include/cxl/cxl.h         |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b06fee1978ba..8166a402373e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2575,6 +2575,29 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
+/**
+ * cxl_get_region_range - obtain range linked to a CXL region
+ *
+ * @region: a pointer to struct cxl_region
+ * @range: a pointer to a struct range to be set
+ *
+ * Returns 0 or error.
+ */
+int cxl_get_region_range(struct cxl_region *region, struct range *range)
+{
+	if (WARN_ON_ONCE(!region))
+		return -ENODEV;
+
+	if (!region->params.res)
+		return -ENOSPC;
+
+	range->start = region->params.res->start;
+	range->end = region->params.res->end;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, "CXL");
+
 static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
 {
 	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 2ff3c19c684c..f02dd817b40f 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -253,4 +253,6 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 struct cxl_region;
 struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
 						       struct cxl_region **cxlr);
+struct range;
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


