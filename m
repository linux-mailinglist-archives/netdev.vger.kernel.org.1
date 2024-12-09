Return-Path: <netdev+bounces-150354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B12C39E9E9F
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 20:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2945218888F6
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F791A239B;
	Mon,  9 Dec 2024 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YEFu+jBZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E250719CD0E;
	Mon,  9 Dec 2024 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770520; cv=fail; b=D/SJ5pvWiKTmrUcDpRxV+kN7EeY2FHnLx3Mji98JCEogp++R+774rhUTKoY5YjncLuTUpq02B68Q4Su9l+TwvqVg/DSYJp1sFTsKU3bNF5UWtpMCcOxduTOmCSBgQWE+IT3YD/eWlAfeJX1LkCo+PGGa8CZRFytlYQFfWXm4HXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770520; c=relaxed/simple;
	bh=FvDzdmH7ZEdLKyIMlJknbwOam060ZhArSPTa8D5MaAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udVkWyWIjEYHK4vz7ZysZcbCLl/VDTDUqA/Plv2nGiPlZ/Dx6w6+7+SDPLi1dQjGzNMfvIWcGtD/JhlX7qbIrnrC0QrdEtnfam3SUdupUSDEtJLaR/Ajhranw3adK3KXNvCwD0WPmvD95NXnGWdho9BwgggXNy9qJT7u0tWsIUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YEFu+jBZ; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQinsQw88Cc72FURoVRwCm3vZRRqJLEwE2zyv9nxjwAVTo7qkQ7/OCIrLchZzNHsd87fmL8ms7nQ93KbGQuTgx6P9QJnCpr+knTz57XRkX53wx+1NW5F8NDkAeAWQ/jXJ3XqAURSPO+IKW6JNcESw4TQ61v2GzHLn/Fvn8Q08J9f4Tvi94ntdoVXdxxnkjv2ylhzYuHD/DXr2aBDFMUo10Ug7OgzVdiExy9fzlqZtsKS84t+Q5DoTteccch5PCUFglAUtmgvHSocMoNL8In9q2lwiDwrF9+SzASGCrc8TzmQD0m0qimRQ7dxLZDEidvvbbyJFJ/ojtDoE1eAcF1UXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rk149y49Gmgmq/dGHY7tanqL4kaUOxsQqqJHGBGT/pk=;
 b=ifQFPvZ3/TuLW9XgwugI5lAW9ehzpyBSfC8ogDYWLrOlhWqXewPL5fNP/MYLxCC8alwgrTTFWob+jQ8PfHcefPKPE+9TxNVZihGuevuonEQGt4GIXv/WzZVtbF/csbP3rgzbIXIkS8zJuaGRsbB2oL/9orjyvRgdq6oK4tNkEuzVGjcUBZpCC9eAXtz6Wv8ZlwyNOqr1T2LX6H7XWvsZqNWtDKYnfVo3PWOjQv7+nOGLuRkH4tcUnNAiXduAAKc4c504fLD+tfjYMoAaenWkXahQNUxTfL2iUv7k0tQu966GUaqFFbz5ZrKq8FZepKERX85tPDB6Sth0slaMUE/QJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rk149y49Gmgmq/dGHY7tanqL4kaUOxsQqqJHGBGT/pk=;
 b=YEFu+jBZwY4UiF3fO9gb2ojKispRbwZJc7EJ85hZwGnRuJugugxCrWCB4+5azTI6Q3bbq3OuiIJ2dhAd5XXAFopwhY9u1QV23tZvZ6ufL7H1UADihKlx00QPm16408I1PKh4farlUy28lQ5XrKYzkiRtCnassfqvHvMl+0JHSdQ=
Received: from CH0PR13CA0026.namprd13.prod.outlook.com (2603:10b6:610:b1::31)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 9 Dec
 2024 18:55:11 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::86) by CH0PR13CA0026.outlook.office365.com
 (2603:10b6:610:b1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.12 via Frontend Transport; Mon,
 9 Dec 2024 18:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:55:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:10 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:55:09 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 22/28] cxl: allow region creation by type2 drivers
Date: Mon, 9 Dec 2024 18:54:23 +0000
Message-ID: <20241209185429.54054-23-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: d94519c6-60f8-4b1f-173f-08dd1883024c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m9D+Oi6MwbAC4G5yo1csgR3dxiSXyav726+jEg7gr5eQXGvXfNeDDtARKbA6?=
 =?us-ascii?Q?iASAd2VEmrJqXHUwonYS3+cptNE5Kh6cOpswJujQ4tVMIVjOP/rcGFWMNZNk?=
 =?us-ascii?Q?l2fjtvmqXjESTwWzNONrEUziXpbj35J6RNoTzJXGEynlf4hvsvayje2aWCYr?=
 =?us-ascii?Q?zyfYSj/w77kGWlu9Ok379JxuVzbpaGiqUsrW7BAZ2g2ILHFPKXl/q1uqAl3k?=
 =?us-ascii?Q?vaz/5AvSrQ337KHeHSeXNBJLDhTaYoYmj35cTfbgMRQACOEA0+x58xeGcnEF?=
 =?us-ascii?Q?k2Ox3bh78ujxfEL/3fhdEPB1fXX8uBJfGmlSVrj0JZpC3i4wrVs3MvKEHBPZ?=
 =?us-ascii?Q?ZUwP2/rN1OnMAfN1Heryfe79ALeY0g/Z8vYL7xUd3YyJbYsMSetvwjAT/41P?=
 =?us-ascii?Q?+cc2EuakFVu5uoc5HfrpPRx2l3qRee6s5zSNKX2yF5o0hqbIiqMU+reWchje?=
 =?us-ascii?Q?o8VhTJr0giJ804Pa2yUTdEi2+bdUSLsHNhWd+PtD5rVEGEXYY3M3kxCXrkVV?=
 =?us-ascii?Q?INEwUOT9SIMm2hDowmRgHViKnfYvJRVIvNxwM5v+ktz/2QMnVl2y93o4A5q8?=
 =?us-ascii?Q?FwQ83pjG+Xs6E+Fgm88yE6G1Lz/WX9Bk/rI8FHhjZQbOQ+1LoNlaieckdtpA?=
 =?us-ascii?Q?knjCrWTiEA0TPneZlI5dLOKW/EtEOdE9s9/vV7jJyy5Kzeu9MJSCciam3fht?=
 =?us-ascii?Q?7uleiXMxOG9bgE/YdrT107gmbcunXOt4LchzyehjyuatU0q6mlXf9zKjNest?=
 =?us-ascii?Q?AiF4FHTFGAgbsRFQE/RHZlAaUZKUGLpnLxawb4YvxEw3JCP5M6w0iAe3+OuB?=
 =?us-ascii?Q?NNofKELOZ9jAS/zTX76rBW4dNN7vdCsCjPfD9rrKgegrRh4cSyJK0QExb2Q/?=
 =?us-ascii?Q?Bywc6nm0UsiV5OyGur7pGmTNcvjOv3iXI7mbJbnVqO6DKM6Eo5FN+2IIL3IL?=
 =?us-ascii?Q?RVdjtY89t5+jCKSiPBWcj1sJhc2wAOeDylv0/9jnSBsOaSKYT5bKDxhCsz9B?=
 =?us-ascii?Q?okchm6oLafCHy2/45oQeIBjNQujnQlbVJm9i8erCyMDkMbK1lq137a1fJhd7?=
 =?us-ascii?Q?XKsfONdT0FWlZxkZoxRH7GBoYLIYsoUDILa8XkFtZ7MMpSvD/2MzuojbPY64?=
 =?us-ascii?Q?7b1U06Cpzg8+hcoCfpHaTHBh/mPL6+wcpnVZiATwoO2GyecIKAKH2KQFpd5b?=
 =?us-ascii?Q?h/q7qCYf6MXtJA+FsgnjiWtd8xRTvRmRRj3g49uZzzj9UwCmlA7x822WGbxc?=
 =?us-ascii?Q?5tvIiW/agBaPFi8vsO6avAvYh+m5O00YqPq0XEeZ+oqF46x5LUm7GjGVyQBD?=
 =?us-ascii?Q?s0Tb2hYd60CCwNRL2o3ey45KQ/naPN6ikAwTjVdAn/3qA/HmxvuZ1waHmCMW?=
 =?us-ascii?Q?LLBp3o1HZwZI3heHZBWeFovDVAdN+jflk5x+B9ufPwcVU6FM+MwbdtJBRqsG?=
 =?us-ascii?Q?lV+s9GDTgedAuP+WNiF8V5c/aLUQCDF8O918hvFk6SNn/DShXX5v9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:55:11.4020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d94519c6-60f8-4b1f-173f-08dd1883024c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders.

Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c | 148 +++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxlmem.h      |   2 +
 drivers/cxl/port.c        |   5 +-
 include/cxl/cxl.h         |   4 ++
 4 files changed, 142 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5379f0f08700..b014f2fab789 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2269,6 +2269,18 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 	return rc;
 }
 
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
+{
+	int rc;
+
+	down_write(&cxl_region_rwsem);
+	cxled->mode = CXL_DECODER_DEAD;
+	rc = cxl_region_detach(cxled);
+	up_write(&cxl_region_rwsem);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, "CXL");
+
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 {
 	down_write(&cxl_region_rwsem);
@@ -2775,6 +2787,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
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
@@ -3381,17 +3401,18 @@ static int match_region_by_range(struct device *dev, void *data)
 	return rc;
 }
 
-/* Establish an empty region covering the given HPA range */
-static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+static void construct_region_end(void)
+{
+	up_write(&cxl_region_rwsem);
+}
+
+static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
+						 struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxlrd_to_port(cxlrd);
-	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
-	struct resource *res;
-	int rc;
+	int err;
 
 	do {
 		cxlr = __create_region(cxlrd, cxled->mode,
@@ -3400,8 +3421,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s failed assign region: %ld\n",
+		dev_err(cxlmd->dev.parent, "%s:%s: %s failed assign region: %ld\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__, PTR_ERR(cxlr));
 		return cxlr;
@@ -3411,13 +3431,33 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	p = &cxlr->params;
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s autodiscovery interrupted\n",
+			"%s:%s: %s region setup interrupted\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__);
-		rc = -EBUSY;
-		goto err;
+		err = -EBUSY;
+		construct_region_end();
+		drop_region(cxlr);
+		return ERR_PTR(err);
 	}
 
+	return cxlr;
+}
+
+/* Establish an empty region covering the given HPA range */
+static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
+					   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct range *hpa = &cxled->cxld.hpa_range;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	struct resource *res;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
 
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
@@ -3440,6 +3480,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 			 __func__, dev_name(&cxlr->dev));
 	}
 
+	p = &cxlr->params;
 	p->res = res;
 	p->interleave_ways = cxled->cxld.interleave_ways;
 	p->interleave_granularity = cxled->cxld.interleave_granularity;
@@ -3456,16 +3497,91 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	/* ...to match put_device() in cxl_add_to_region() */
 	get_device(&cxlr->dev);
-	up_write(&cxl_region_rwsem);
-
+	construct_region_end();
 	return cxlr;
 
 err:
-	up_write(&cxl_region_rwsem);
-	devm_release_action(port->uport_dev, unregister_region, cxlr);
+	construct_region_end();
+	drop_region(cxlr);
 	return ERR_PTR(rc);
 }
 
+static struct cxl_region *
+__construct_new_region(struct cxl_root_decoder *cxlrd,
+		       struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	rc = set_interleave_ways(cxlr, 1);
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
+	down_read(&cxl_dpa_rwsem);
+	rc = cxl_region_attach(cxlr, cxled, 0);
+	up_read(&cxl_dpa_rwsem);
+
+	if (rc)
+		goto err;
+
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc)
+		goto err;
+
+	p = &cxlr->params;
+	p->state = CXL_CONFIG_COMMIT;
+
+	construct_region_end();
+	return cxlr;
+err:
+	construct_region_end();
+	drop_region(cxlr);
+	return ERR_PTR(rc);
+}
+
+/**
+ * cxl_create_region - Establish a region given an endpoint decoder
+ * @cxlrd: root decoder to allocate HPA
+ * @cxled: endpoint decoder with reserved DPA capacity
+ *
+ * Returns a fully formed region in the commit state and attached to the
+ * cxl_region driver.
+ */
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_region *cxlr;
+
+	mutex_lock(&cxlrd->range_lock);
+	cxlr = __construct_new_region(cxlrd, cxled);
+	mutex_unlock(&cxlrd->range_lock);
+
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	if (device_attach(&cxlr->dev) <= 0) {
+		dev_err(&cxlr->dev, "failed to create region\n");
+		drop_region(cxlr);
+		return ERR_PTR(-ENODEV);
+	}
+	return cxlr;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
+
 int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 4c1c53c29544..9d874f1cb3bf 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -874,4 +874,6 @@ struct cxl_hdm {
 struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled);
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 4c83f6a22e58..4bb89b81223c 100644
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
index c450dc09a2c6..e0ea5b801a2e 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -60,4 +60,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     resource_size_t min,
 					     resource_size_t max);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled);
+
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif
-- 
2.17.1


