Return-Path: <netdev+bounces-243803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A850CA7F29
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FD8533B9768
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20D133122B;
	Fri,  5 Dec 2025 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qUabXJ08"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B2C2E6CC0;
	Fri,  5 Dec 2025 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935626; cv=fail; b=SkF6Y4Ct4ExqTIs5YRDl7sze8F5gNhh/eLEePaPpLM3dk0iQKHt9LgOxknMoygvSTAgWShUBF79rQtIVS3+lnBD1qPzsizF0EtAKWlVIinKntFRrhWkN4zuK3VuX0gy/stlfKY1Sjzbro4aUequUEJpPxs2pEgma5dJN3wSiND0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935626; c=relaxed/simple;
	bh=VnsSat09Z3ZAiWo+yxW8vYKxxW1KkkZ2gpzms7f+R74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K53aUbPefs8RvgQZ4LLqh88BdR2b3IWi28Oom9Kt7ncQPQtxUfsfLZSWnyo0zlk46WferSLmdtEpcQ6HcUSZlRctLKIwhVA9Qs+4FxRPbXG2Dgn7NSq99dcZZO3z1qQHCy4WmSC7w0C4ks8TZ94jbeSYXHXFPoDfM7rjTu7BGVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qUabXJ08; arc=fail smtp.client-ip=40.107.209.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fkyfi3AfOGrD+CmmNBNat/wevJa0NwTVEZAY2Cef2ofoxXpq41tNpudyHUiz32Nb1OxRDEer0wL4cp9XHRBqb20eLcmqYMMw3Ka4HG3tiOwaA+sGQ+TILug7Kxd3j8C1kvlH/kLIiYZDGWQi6QxoEBSQphoK62pkp5bU5XqK7oaFPMcUO6cghfxbqpKRkqucSECOSuePAn8eunD2xRibaO3Iz8O2tfN4oudD2571vM9hrchLRBsGwf7fkM4APqL28jYH37wuDVHuBMGkG2TgKII0NNc+7iA6dlDEwRy56b/wPNtiLb/1VDKQlILlXlOY5KPa3d1Vn9mdAtUzTKg9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLbpUcpvo5FRna+zT8JPNniv9gzwskImOEMk4xwiqLc=;
 b=BWms+bohi8UUInhtEjVP7dFsate8nSGkW7meahatEL1ddEx/MlOIRgiIFlqOAxvZHYr5DZVjKgLzvH21KaCvi1vurYNBFa7glsyKsQpfIoUmwZqKZi8tejlTpEAdloKR4xMQOWA/5u7+zCRpd7CMBwt19sbytAjALxfiNe+FFD4FG3YTuWjJad4MeAOQMvoztuYNKg4dL8kWIjU91jNfxUc/B3TkAgPZqeMIT3RLkxdQienfa7OJoIOS4zZJ654BhL7ixKyuqF8ri2fxfATDgHwELVlesJ2sOGIRJym1byytUJed7oeWTd5yLGwU4tFHeCcrGHjYPs5KhpgmVPM39A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLbpUcpvo5FRna+zT8JPNniv9gzwskImOEMk4xwiqLc=;
 b=qUabXJ083wOPEOHpUZSY38IKVSsdDHNUk3yS3FrjVoQWkemFII1FskrBIETuO3/HbFXvSarcglQyAvgDzlF1cbxoph2mhgbvthKVLu+1rhEnaQtg13LfT4jBoPkNsmGNdUbOxgdkAFcAnQGjNJ0Qqb/vxTlDJYp39DMBEVkFD3Q=
Received: from BY5PR13CA0021.namprd13.prod.outlook.com (2603:10b6:a03:180::34)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 11:53:32 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::9) by BY5PR13CA0021.outlook.office365.com
 (2603:10b6:a03:180::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.0 via Frontend Transport; Fri, 5
 Dec 2025 11:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 11:53:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:31 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Dec
 2025 05:53:31 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:30 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v22 22/25] cxl: Allow region creation by type2 drivers
Date: Fri, 5 Dec 2025 11:52:45 +0000
Message-ID: <20251205115248.772945-23-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffc5829-1b7b-4e43-5728-08de33f4e9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TOKwwJL0K81dDea7ksBPEwST4tbc7Ip6ud07o3ZBqgVqEnpRjxWAfzj853CT?=
 =?us-ascii?Q?VYvxOJ2E0KswDrPBjFi6xh2H9TIpZZfZsKBrw6Z1snTtiDIvOpEWP33uNlXk?=
 =?us-ascii?Q?+InbpwmcHrdfuwQN45VqJ4LtGEzgzZJvQHrmlPp5q8XT7A2mV+wqVBzI03KW?=
 =?us-ascii?Q?haFEEJQSVpvGB6UYIHChJvQ7bDnYpsCEo+5/ZnGv38wLwAktiJn87dCBnTS6?=
 =?us-ascii?Q?ZKaM1gSVSI2DvhAXC9jSQiTDRzG6th4gu5eWTLK7RK1NJ0c6rB59wTSyjkxO?=
 =?us-ascii?Q?4son/mNffbGekniC9GGXAJd5TXViRrgxBH9zhf4aaEmrTqwn61posFoc3/Ft?=
 =?us-ascii?Q?emoOBCrJXFhAJ3x5ueSIclQAA+CVc+UHGAtC+jc0JbTTrkbV0wP7Z4IERJ40?=
 =?us-ascii?Q?rkRZqE8Egi5qH8WEhQmZeGSMwwQ6H68FYJXdBYssPeiE7HdTQ8UFvjZsDJOF?=
 =?us-ascii?Q?nCenvwwv0oGluYEeQZ21MGw4mzfnqV2aFcId2v/PtEcQVMuXHDocEpfWRu/C?=
 =?us-ascii?Q?mtxY8MZ3Dth7XCJLA2zdIRvfP6dYvDArQsU6FGO1dD31HM8Jyx+wL70bi13J?=
 =?us-ascii?Q?0qWviZeIwR1XVgdhW53FuDHKYRmD+pc/4tkPA88kXlOojp5LPbbXI/Lmyn8u?=
 =?us-ascii?Q?hhfdO8MWTNbxmzvmvCnFBVI+9A5sE1zMUi/Bo8Q8p0RK4NPTXwjHIGqiciki?=
 =?us-ascii?Q?myXXsKXZwuPld8iS5cVr66+4+z5aXCAM5gwc2HWTh+jxeQw1ilfKqxRHcdAn?=
 =?us-ascii?Q?9BLI3u4LJ7ecrwxMw6e4/ftdoXdGZ0LE4AuTDf5SusdVh13hDbeT/jiMZaIU?=
 =?us-ascii?Q?o/ggMChQlwK0GL9N2V45toh2FlJvY4Z66EksoxkDqmJXP90vGZHVueGSeNGs?=
 =?us-ascii?Q?+s3wcTLJke6Tt6xmsLSrRuT8HR9+TT317wqT+iYbzQX8YCW7aMi+0p6ilsU+?=
 =?us-ascii?Q?t+o9EP22K6Qa2a6fFH6P/PAQV3uC58p6cLj6+FuXEL/sMMT2FMXspZrth9L6?=
 =?us-ascii?Q?sPeQeaJUh1uhgCEFcEksGoGsDuKSi5DXTV2bAF03q3We3UfIG4Ep9+APvHUX?=
 =?us-ascii?Q?7TNzp050tZyPRZ160C6Dva7Yod2izP898UGhW8CqYgw78SLieZgzPmg05/m4?=
 =?us-ascii?Q?04+8JjfG1/h3EvqbthZ7VzvCqszJ+UssuxpK96yU/9a0ZdPG9fD56QMGkx9C?=
 =?us-ascii?Q?no3n3k1AH7ws3HuCr6xuWqPR0v6eDxR5d45OiXcANjJhrnvOM2+iiEgwGaL7?=
 =?us-ascii?Q?AmLnnM4ED4/TjOQv3+bKN+/MKJ+/Wg7GzcGjlH6ZIYQ7Lf9+4W72ifgWBP0i?=
 =?us-ascii?Q?2Qk9tZcLE8PcZaKljUwoj6aPDgSx/GIiNSCm0XfLNHjL15Z9gOwwq1bmUbZT?=
 =?us-ascii?Q?ktHX8b4BsReVrsqORyFhn9Yxzix7k3WrPJxCTq2x/YtrLV83O71ZKpa3R5GT?=
 =?us-ascii?Q?VoVIP3w8fn/sIxfHTWM7pzm1F2etIiZ5JyTuX6VeHC6fQwapVBWtWyRFdNaG?=
 =?us-ascii?Q?l32KUQEDAiBAU6kKCbv3fvapEXgAQ67Glsn2x6i5kOCQfEPy3SNU9RzSadyB?=
 =?us-ascii?Q?g6KVV57FB+wyl2Aa5K5Rh+hNr2NQDsm7p0QW2/si?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:32.1265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffc5829-1b7b-4e43-5728-08de33f4e9e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders.

Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 131 ++++++++++++++++++++++++++++++++++++--
 include/cxl/cxl.h         |   3 +
 2 files changed, 127 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21063f7a9468..694bb1e543cc 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2894,6 +2894,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
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
@@ -3724,14 +3732,12 @@ static int __construct_region(struct cxl_region *cxlr,
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
@@ -3740,13 +3746,26 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
-	if (IS_ERR(cxlr)) {
+	if (IS_ERR(cxlr))
 		dev_err(cxlmd->dev.parent,
 			"%s:%s: %s failed assign region: %ld\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__, PTR_ERR(cxlr));
+
+	return cxlr;
+}
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
+	if (IS_ERR(cxlr))
 		return cxlr;
-	}
 
 	rc = __construct_region(cxlr, cxlrd, cxled);
 	if (rc) {
@@ -3757,6 +3776,104 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return cxlr;
 }
 
+DEFINE_FREE(cxl_region_drop, struct cxl_region *, if (_T) drop_region(_T))
+
+static struct cxl_region *
+__construct_new_region(struct cxl_root_decoder *cxlrd,
+		       struct cxl_endpoint_decoder **cxled, int ways)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p;
+	resource_size_t size = 0;
+	int rc, i;
+
+	struct cxl_region *cxlr __free(cxl_region_drop) =
+		construct_region_begin(cxlrd, cxled[0]);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	guard(rwsem_write)(&cxl_rwsem.region);
+
+	/*
+	 * Sanity check. This should not happen with an accel driver handling
+	 * the region creation.
+	 */
+	p = &cxlr->params;
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s: %s  unexpected region state\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
+			__func__);
+		return ERR_PTR(-EBUSY);
+	}
+
+	rc = set_interleave_ways(cxlr, ways);
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
+	if (rc)
+		return ERR_PTR(rc);
+
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
+		for (i = 0; i < ways; i++) {
+			if (!cxled[i]->dpa_res)
+				return ERR_PTR(-EINVAL);
+			size += resource_size(cxled[i]->dpa_res);
+		}
+
+		rc = alloc_hpa(cxlr, size);
+		if (rc)
+			return ERR_PTR(rc);
+
+		for (i = 0; i < ways; i++) {
+			rc = cxl_region_attach(cxlr, cxled[i], 0);
+			if (rc)
+				return ERR_PTR(rc);
+		}
+	}
+
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc)
+		return ERR_PTR(rc);
+
+	p->state = CXL_CONFIG_COMMIT;
+
+	return no_free_ptr(cxlr);
+}
+
+/**
+ * cxl_create_region - Establish a region given an endpoint decoder
+ * @cxlrd: root decoder to allocate HPA
+ * @cxled: endpoint decoders with reserved DPA capacity
+ * @ways: interleave ways required
+ *
+ * Returns a fully formed region in the commit state and attached to the
+ * cxl_region driver.
+ */
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder **cxled,
+				     int ways)
+{
+	struct cxl_region *cxlr;
+
+	mutex_lock(&cxlrd->range_lock);
+	cxlr = __construct_new_region(cxlrd, cxled, ways);
+	mutex_unlock(&cxlrd->range_lock);
+	if (IS_ERR(cxlr))
+		return cxlr;
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
 static struct cxl_region *
 cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 {
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 7bd88e6b8598..e6176677ea94 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -290,4 +290,7 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     enum cxl_partition_mode mode,
 					     resource_size_t alloc);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder **cxled,
+				     int ways);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


