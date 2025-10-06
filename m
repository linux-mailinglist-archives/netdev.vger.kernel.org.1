Return-Path: <netdev+bounces-227937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D05BBD9A3
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23E234E9865
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C232123370F;
	Mon,  6 Oct 2025 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4stubwit"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC8C221572;
	Mon,  6 Oct 2025 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745073; cv=fail; b=Udesyf1W2lMENeA4gDeKQoVp8yCsTpR9IgaCey4tqQKlOG/aEdkBprR9xjsh0n+7Qsx32MekjE6yhxJbyVwm3uelOfPONmwe8MO8ZUTdm0OHLD9YKU8fCHEeFLkzXB+5Yc3e1R1PqNQpi2KCzX51YGiQ5rzEdTXfh9K8bo9Uwj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745073; c=relaxed/simple;
	bh=oQsQsnmKd1AksP9yx63Jl4nDniKarpSrY11HCVHjxa8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmD6p8nxbJrrOieBqHTiT3V7Z4KrfyZY7dMHPDtZ8d/Y2qxHG9XpeyoKrKp5S+e42BAJNlGPpXW894U46FEntuHxjHfWZsD7UIj16mxBdGJT/BXefBwOlXD0UGzdY9JmocgN7Lp3SGTtWCGJFICzleMD/eC8TeaX6U/45RVbYxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4stubwit; arc=fail smtp.client-ip=52.101.85.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqlREo4GA00WmGvP6hdrroyI3uKG6P+xzy8EoopH4i8WuObvrUODTzQQtPfZFOsD/APDGT8qT3p3ETlfqQBuI/NwICvF/+sSzUQTjI4/foYknhegfo5SUJbe3jvBBE+iGrc0dw5CxaWOLgBgJLqUaMQ9A6ieTcf6LeJEYOqZPmxKTpoF+XoWXCPZscOQpaQNBOipArdlXhl1wY0cKkQSuDR4YPVrxCdE9zJGeLzKYe7cX7hjO8fHEtRBYcjywXKtXHbF8EyTPrRCp8JdDr80wZRhbrlcer6BAssrXcdYz944VewzS6STXcpmE/7t2a4rDpYxJPQRCf1c9SQ9SpIJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFaLOslLJhlSbL4mUQcgb6PhiZJpDu+wFmptxb+cMtQ=;
 b=oWd28uFC7JMtOaDKvCZ96E4iGTEr+NXbx3pre8nmIouKwBSqVR7Tr/Mgq0drURhe9KAaMB18DzwgcCRB5L655aGHbDFVWpZ8tTcDoQSTINoE02kH6lMAhS/iWFCcVUmJ0H44K7YTW9lXoOS1vBPWz99twoUsy5rMLoMDObgRHCkm4ur1+zV4T/DUVp7aFnP80Qu2Pa1Gj4HNov9Z1IWyHnrbPPwePH8A0Xfe4dC17xWHf1aowL66xHu3gM+9uJ5oTiQvE0Zbm38rr2nWw247o9BsE2TTusOoaDQQFOQJY683RaCJHV7xWr0FfCy8LjK6vgMBqgtwq2RfOezO4/gQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFaLOslLJhlSbL4mUQcgb6PhiZJpDu+wFmptxb+cMtQ=;
 b=4stubwitY8TOCcsjRdN2iwfdt+EjB8YXoe/ATiqUIhobi3EB4FpZBP2Gam0NDCV5Iqu606DEuN5Qi3PerLDwsjc5AJ0xYpslvwVa9iSRuaGTGh1hM3r6UuhBKoStew7p8iDcZYyaYsbR0eo//8ArYwurHIRjw6paCnkKI4FYZyA=
Received: from SJ0PR03CA0152.namprd03.prod.outlook.com (2603:10b6:a03:338::7)
 by SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:04:26 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::94) by SJ0PR03CA0152.outlook.office365.com
 (2603:10b6:a03:338::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Mon,
 6 Oct 2025 10:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:04:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 03:02:36 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:02:35 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v19 18/22] cxl: Allow region creation by type2 drivers
Date: Mon, 6 Oct 2025 11:01:26 +0100
Message-ID: <20251006100130.2623388-19-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|SN7PR12MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: c328052f-a3d4-4252-8305-08de04bfbaf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kr49OMW3tvl7vaK0dZhcVfCkECCr2RlR9YHiLK8FZl7QgZUipNFr4z0lv9tV?=
 =?us-ascii?Q?Q+Fb5iuMgBt68pnR7Bn9be1e8iGTsQl1Z3TJ5IDF1b5CIW80II1SGHnoHmjq?=
 =?us-ascii?Q?fD5ZiQje4GSj4eqhwe+kWNu/W94uuWLeFgJBbgGlcGgUSg3M90S0FllUbbPV?=
 =?us-ascii?Q?B0ZZ4/1ewKjakeOaDEa8BHnPrM0Upf4oP52e758x8kZno+NkjDoE//LczgpL?=
 =?us-ascii?Q?yagXvvFlZxkirek1fGGRFn0VTENxvqI6cfbjYF7KkLy52vK8nvmSzTNtgn8f?=
 =?us-ascii?Q?jtT1q7kNH4ugOov/WuQoo1CI4suHEjxiE8acvYXrKsmcfS9RV2yD7GAoEiC8?=
 =?us-ascii?Q?iOGcpzwoTCAkqoCvFBBftbL3sVJJf4oMNFZ40uqG6Ry9zVBVyXEL4nK6nVDs?=
 =?us-ascii?Q?rgMZ+5n/ACpD6RnrSX3JH0/b89VrKnkVabQraNuXXK7zrvJEkaNIak9JBINL?=
 =?us-ascii?Q?cHP7l0ZkNxZQopnAdfEiwz6vhvrQTfmhvoMLtP2MdHosiac+W5V8ln7UUkTR?=
 =?us-ascii?Q?+aQ8UiFyWqWAla1M1PfRF0f5kz0MxeyAyPDUDTagCNi/WDbUDkJ5IB3DUAgc?=
 =?us-ascii?Q?GOhu3PN0WHflpuof+epib/YkD8if3hUBHsXcPslKhMckmwQCShgx+WqBpiv6?=
 =?us-ascii?Q?mVfg7o/BkYko//SQvKn1+lX1woO50l1kjMF+awUx+xhOMDDWngGz/9M3Ioew?=
 =?us-ascii?Q?1+HgBx0Ji9YB02X+7e84io9SkmWdz1IeYBJY54AFchp3svzYhHYbSDxaW+eN?=
 =?us-ascii?Q?ZjIqCQiKnfxsvXDpvEpDLEvKOpRQ9T0FrTtkah9GXf1FWhjohKxCeMhBOAuq?=
 =?us-ascii?Q?zqRRyo/mKRosh5velb6SvKGP44Am7woJdtseSSJ19d4v9JY/BB/sNmjPQeCm?=
 =?us-ascii?Q?+D4i6d7V3y0omeIzrGujRl5/qEPLZ8ZizcaAENQq+z36EFFHaoZYQv21nrK0?=
 =?us-ascii?Q?QY0YSzePd3KJ+6hBrocJ8MfpN1qyqTXdx4g6Yo7GAAUyNhFZ1IUYaf8SPEec?=
 =?us-ascii?Q?1oIIOpuHf3RQGWVg9a8WXYyThTRTj5ytJTPDiTFhT18me8lnw4zgnqvm5fSq?=
 =?us-ascii?Q?Yle6/aHcdvsdbV//rT+lB3e2he2bno7+E33r8rjBtXyXWASgjJfLGOFuQ8DZ?=
 =?us-ascii?Q?2Ae0KnjEsHuYwJ4fCOB8WTXLCoTTCEsWsPhGln8gacnuOrHGlM8MY+50pRoE?=
 =?us-ascii?Q?FKrT/UF/KPTcygqRlWhzz4FbhSy+5jj5oRrb9IFWMiZ0w3QOIq9CkDsUX5+f?=
 =?us-ascii?Q?pzUsY4mmscluaKrSKLPqIMv5n9NqHQ8yT27myp2QdWn/0aNMLxh6dTa6i+lm?=
 =?us-ascii?Q?0EQZRphQcuYumc4JKoapbGOFb2vxfnHkcvq+DCQoUAG1VdEY7Mvx1VRec16q?=
 =?us-ascii?Q?xRue0gEyfaK/GK+A/rpvgb+a1yYb0ke7PgzpVlQ18v94jMZE02fAmd4T1P2J?=
 =?us-ascii?Q?YGdBk5hoOf7FH+YRSejDAySkfD39MuRSnqYpJmA5ikasSgxUTTOAxXq2lnI4?=
 =?us-ascii?Q?FhBsBf2BW5yLuf73QVMMHiSLuVrPdqAdjwbXfkChCPwcUBR1xCJPdkEVBANR?=
 =?us-ascii?Q?zzmyLj3EY7y9W1ELLs8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:04:25.3958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c328052f-a3d4-4252-8305-08de04bfbaf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders.

Support an action by the type2 driver to be linked to the created region
for unwinding the resources allocated properly.

Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/core.h   |   5 --
 drivers/cxl/core/region.c | 134 +++++++++++++++++++++++++++++++++++---
 drivers/cxl/port.c        |   5 +-
 include/cxl/cxl.h         |  11 ++++
 4 files changed, 141 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index c4dddbec5d6e..83abaca9f418 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -14,11 +14,6 @@ extern const struct device_type cxl_pmu_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
-enum cxl_detach_mode {
-	DETACH_ONLY,
-	DETACH_INVALIDATE,
-};
-
 #ifdef CONFIG_CXL_REGION
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_create_ram_region;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 26dfc15e57cd..e3b6d85cd43e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2375,6 +2375,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
 	}
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_decoder_detach, "CXL");
 
 static int __attach_target(struct cxl_region *cxlr,
 			   struct cxl_endpoint_decoder *cxled, int pos,
@@ -2860,6 +2861,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
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
@@ -3588,14 +3597,12 @@ static int __construct_region(struct cxl_region *cxlr,
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
@@ -3604,13 +3611,24 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
 
 	rc = __construct_region(cxlr, cxlrd, cxled);
 	if (rc) {
@@ -3621,6 +3639,106 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
+				break;
+			size += resource_size(cxled[i]->dpa_res);
+		}
+		if (i < ways)
+			return ERR_PTR(-EINVAL);
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
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 83f5a09839ab..e6c0bd0fc9f9 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -35,6 +35,7 @@ static void schedule_detach(void *cxlmd)
 static int discover_region(struct device *dev, void *unused)
 {
 	struct cxl_endpoint_decoder *cxled;
+	struct cxl_memdev *cxlmd;
 	int rc;
 
 	if (!is_endpoint_decoder(dev))
@@ -44,7 +45,9 @@ static int discover_region(struct device *dev, void *unused)
 	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
 		return 0;
 
-	if (cxled->state != CXL_DECODER_STATE_AUTO)
+	cxlmd = cxled_to_memdev(cxled);
+	if (cxled->state != CXL_DECODER_STATE_AUTO ||
+	    cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
 		return 0;
 
 	/*
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 1cbe53ad0416..c6fd8fbd36c4 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -275,4 +275,15 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     enum cxl_partition_mode mode,
 					     resource_size_t alloc);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder **cxled,
+				     int ways);
+enum cxl_detach_mode {
+	DETACH_ONLY,
+	DETACH_INVALIDATE,
+};
+
+int cxl_decoder_detach(struct cxl_region *cxlr,
+		       struct cxl_endpoint_decoder *cxled, int pos,
+		       enum cxl_detach_mode mode);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


