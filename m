Return-Path: <netdev+bounces-200682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AD3AE6845
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CF2189DF5F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28EC2DA774;
	Tue, 24 Jun 2025 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vnokCIiu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D62D9EE6;
	Tue, 24 Jun 2025 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774489; cv=fail; b=qU9AHXlZ9TJQxQU+keTT4ME07NbQj82Z7rOt/n5GE4KYPe+EdEfYEWnwlSMukV/g9fCR4bGkh9WFgyOcx8yNPPnf+pIxcs009wDaBTIVx6L51LB7kuA1Xs/SuxQ7WURxVrLBW0Liwe6K71k8XTf37/y5ZemvxUDfDc1cqNfWLOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774489; c=relaxed/simple;
	bh=GZhaI4L4M8QI1jA8MJr7NVSEU37k9uSMOaIs8HOe+Fs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fx4Q8RmGVZsfk9KHYYJOp0c8dxJXpP4QIhRFEgtvEGbQbzoOZD/RgbXk/7DFvlsa75+sCraqYdYAGVtc0tdw4rclEno5yE3k7CkLNAJXhFOS4rIeur1Hd6K044Nb0MIWUEGQi5JME2JeLmwlGqjlOG7xhb1iep8gdxPfW+eMyaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vnokCIiu; arc=fail smtp.client-ip=40.107.95.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+/Nt7nR1gYO/+4sAsWxg26LqThMHe39D5pkSSFm+IjN8zBbegteEhTFFY4zotX7cD0PsjwhlxonfLMhVVNm9U+St0q25JbIFgSWTHI5sy6DPe3qvIy0O84wDJP7Kt+HbjtXuTQe6bCZIa4Ut/H3f/9a3s6OTKaXWoGaXQIt/sO0behkhm9t/taRi6PbzZ8evhpFL8fKlEH4IdUQ6iuvq4SEUz/Binv6+tk6GRD9JGjuSKr4A3Q/PCqQCdrnLRX2s2qeL/6JsDmATaCBUbVWhMaYSAFYxeRQvmWEFiDWPCBy3eVXQ6KNALGd269sZFnQ72gr28yoeL2z6ogieMGorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PH3NF7TDv54uwgiBw8q0uJy1qBLpjoWYVPFaLU7gAyA=;
 b=GlU4br0Z1n6bqKC1mZj6rhgamLFJht/R3XovCgJE7qynSo/Rgfla3CCe3UAzi3CO/TsyhgDHcSRQizemH+cOOzkjddYnk2h8iJWL1gBfs9BmqJV5gx8JQuKa1HmItxDix3Gzu35f6sAye/zGaaiWm0VRYv4NdCrfOlWXqEbZmTIMAhL8KF1TiS0Hdv4gK0Chuxs9gyPtdV70YpffDRIVc9Dmyob4llYG39N107Wada/a6G+AX50DVliq3FRJLpie6f3wNV2ov4aLU9pNkgbEAkL8wEXPoorpEMGW6iCtX/r7H55qEqvqbO3ahsj3/8jRkJVUHKew/V6y4I8CpyR1cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PH3NF7TDv54uwgiBw8q0uJy1qBLpjoWYVPFaLU7gAyA=;
 b=vnokCIiuypbs1cAKykGkZPwnbl6uCo5dEE8nAMexEmzkFPqic5H4A/aEuRCBo/XQ6HpISanzH7byp07dMwJBUnEeaUUPctBlDYMPi0/F3wblJr3B7EafWDkLihE3+VzaBoeNGu73k6NP/u12xrvQYUvskWziHKGRzUMocWLWVMk=
Received: from SN7PR04CA0229.namprd04.prod.outlook.com (2603:10b6:806:127::24)
 by CH3PR12MB9145.namprd12.prod.outlook.com (2603:10b6:610:19b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Tue, 24 Jun
 2025 14:14:45 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::c5) by SN7PR04CA0229.outlook.office365.com
 (2603:10b6:806:127::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 14:14:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:41 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:40 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v17 18/22] cxl: Allow region creation by type2 drivers
Date: Tue, 24 Jun 2025 15:13:51 +0100
Message-ID: <20250624141355.269056-19-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|CH3PR12MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c3e9634-d046-4134-aa1e-08ddb329785c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bl4VEhwaErKZVJeEc/2rCiG/W7JH7IQ3tgM097YxfvoqbsXeE1tylXa4w9Zf?=
 =?us-ascii?Q?Q1Ci5YZQRgQ5NApNB7oSN7dymgJFUk0kbtq1DAfoJLVKDi22gteWXwdSlc/E?=
 =?us-ascii?Q?Q0Qa3s+KcIwPX6bxYE2TR1/olrLyY+7dIsNfJcSJy2ioWoOJR/KnMGCFCxMg?=
 =?us-ascii?Q?BsDy+VatLjg+MvGkr89xBisSOnMJDdqZiJ4oOxhIdFEpCR//keyV+1RDEgmS?=
 =?us-ascii?Q?G2oli8NPAGDznBjsIJ8tyNs6yXiaZBw/TTkovM0Cxnc+2u+RuqIzKZjqWI8E?=
 =?us-ascii?Q?Vw+gKvmb1x5QzTDFO8VN801ZSx9vm+41hhivhvt8eOBfjHuYwWxtz752eQeS?=
 =?us-ascii?Q?0DCLOCrz3QZClPRZf39HahcNVcSQq7HGwvL/uio4l6iSWaMwOQ26OjUoRBeq?=
 =?us-ascii?Q?gIf39bJb7rcf7r5WMXhR5ChK3DXKOej9hwtmAStnNd0mMGYu71rspb5bzP8z?=
 =?us-ascii?Q?9eeVbtuy0nV3v1WQUZ6//Wlf8zLCCVKxmYquhSA+RpnUL/W3K8nxviPg4n9T?=
 =?us-ascii?Q?G4DlUf+21figL1UPrvQzsnV2VGXocFPQy+P1Oa+lLtkdOr30D5pxCptKbOYU?=
 =?us-ascii?Q?lf6mKAZ/nbFVbJ98zy+wdXBAaTDvk/lhcBz7bDX4lSLc8ilOLzEVVHYkLhkT?=
 =?us-ascii?Q?dCitaQb2v9YxCYk38vOqgPLJb8nMPCyk2Y+kAHdY+af5GzvBscO/BA2x9fjB?=
 =?us-ascii?Q?elwlDc3lhMLjUWLgc9kOZu2Tq0oWVECnA5g6PjLurGf3F9QsUIPIfa4H9KQz?=
 =?us-ascii?Q?iFWqHOWahcuDKCI7vjU5Ve4Z4XF2cLnVI9pvkt3OaKWNl9fbUE9+xHnjMigX?=
 =?us-ascii?Q?xBbZIX/GV7Zq9mZb3qAlcX7lToTzwj6D8Q07zyKmKDBGjioohg/zArC5Cvpd?=
 =?us-ascii?Q?GaXLI7OwLaOLj0DlUx9tJ4irp9cQVGbPjrDop9W11wDcey00IjjUoqEgFltf?=
 =?us-ascii?Q?OEcmV0SSH0wPt2cIFEt/+NJpFLqvSvuPclzLvtSAT1wXpwR4j0C/6bjU8hC4?=
 =?us-ascii?Q?Cx4kBLoEBn2EHfgxZmnt8xHabVy5DXT25fRAQ2rT5XSI5CSDoMasmZsJrYKN?=
 =?us-ascii?Q?JQQissNO/GAQSnWCOqq87Nant2K993bldbmbfwX2AxdwkOMCijh9tau+EP3S?=
 =?us-ascii?Q?cH9jD6EF33GG785N45S+MBDceASw9DKGOInbqcrGRiA4P53c9eW/qKIVIbQE?=
 =?us-ascii?Q?Mx746VczpPF2IIS/Mf+AHc9K3Km4MUrBYDNv2F1X0b2ATGcYP+pwFrRKPKcm?=
 =?us-ascii?Q?1WhkQRS5SB7LrH9Ox5H2MsaTGM/r8qpKqFWWZcTbmBZuo/5B88sc5GmMSArC?=
 =?us-ascii?Q?OPoq3xzD2+7MQvL5LztLhpdP4udXQBerAP9sgMJn5BimTrHiTWg0cm104n7s?=
 =?us-ascii?Q?qRj4o92lBKRT3/VLrAhVSyzQVQaV8TkFwLjhNxnGno105ZTK2Dk4DQPcRwb0?=
 =?us-ascii?Q?/ONoJG6npBvXzO5J5qYZpuFqWgLDYkIcpTX7CbE5Yt+kQ/NMV7TK44El+HI4?=
 =?us-ascii?Q?/snPQl6Xy2Ce3t13gC4Kzjqd5llUSKOaQXajNPokmetoB9SL53q8ltfAAg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:45.0173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3e9634-d046-4134-aa1e-08ddb329785c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9145

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
 drivers/cxl/core/region.c | 152 ++++++++++++++++++++++++++++++++++++--
 drivers/cxl/port.c        |   5 +-
 include/cxl/cxl.h         |   5 ++
 3 files changed, 153 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21cf8c11efe3..4ca5ade54ad9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2319,6 +2319,12 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 	return rc;
 }
 
+/**
+ * cxl_decoder_kill_region - detach a region from device
+ *
+ * @cxled: endpoint decoder to detach the region from.
+ *
+ */
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 {
 	down_write(&cxl_region_rwsem);
@@ -2326,6 +2332,7 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 	cxl_region_detach(cxled);
 	up_write(&cxl_region_rwsem);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_decoder_kill_region, "CXL");
 
 static int attach_target(struct cxl_region *cxlr,
 			 struct cxl_endpoint_decoder *cxled, int pos,
@@ -2825,6 +2832,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
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
@@ -3529,14 +3544,12 @@ static int __construct_region(struct cxl_region *cxlr,
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
@@ -3545,13 +3558,24 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
@@ -3562,6 +3586,118 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return cxlr;
 }
 
+static struct cxl_region *
+__construct_new_region(struct cxl_root_decoder *cxlrd,
+		       struct cxl_endpoint_decoder **cxled, int ways)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p;
+	resource_size_t size = 0;
+	struct cxl_region *cxlr;
+	int rc, i;
+
+	cxlr = construct_region_begin(cxlrd, cxled[0]);
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
+			dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
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
+	scoped_guard(rwsem_read, &cxl_dpa_rwsem) {
+		for (i = 0; i < ways; i++) {
+			if (!cxled[i]->dpa_res)
+				break;
+			size += resource_size(cxled[i]->dpa_res);
+		}
+	}
+
+	if (i < ways)
+		goto err;
+
+	rc = alloc_hpa(cxlr, size);
+	if (rc)
+		goto err;
+
+	scoped_guard(rwsem_read, &cxl_dpa_rwsem) {
+		for (i = 0; i < ways; i++) {
+			rc = cxl_region_attach(cxlr, cxled[i], 0);
+			if (rc)
+				goto err;
+		}
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
+				     struct cxl_endpoint_decoder **cxled,
+				     int ways, void (*action)(void *),
+				     void *data)
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
+	if (action)
+		devm_add_action_or_reset(&cxlr->dev, action, data);
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
index a2f3e683724a..5067f71143ef 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -252,4 +252,9 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     enum cxl_partition_mode mode,
 					     resource_size_t alloc);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder **cxled,
+				     int ways, void (*action)(void *),
+				     void *data);
+void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


