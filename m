Return-Path: <netdev+bounces-243793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 451D6CA7EBA
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C71832633A4
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07C532ED42;
	Fri,  5 Dec 2025 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SIHYHk8f"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4CE308F05;
	Fri,  5 Dec 2025 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935607; cv=fail; b=DfYG7CCTD4DIh/EsV4Ze5qas75Fb+XrWtjxTlLXhEM80x7tlGMj/lbMIyJEY4+jc7BhLY+E962dZJRc4UxW1MtDOhjDRiesLqVVgYqkhb+e38EEdwW3YKZgb50s/kakw11jzr1ASPXM1HLSkTUo90+q1mQHkZz0JRAGHI897FaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935607; c=relaxed/simple;
	bh=6HBvtBPxQ+fbflRtClGcWJ4mo8scz6MC9rwRxvhkYFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rqxnKPUos2bIQhjenrKy7RW6i2AmPF+6LsuSazzwlv6Q1yXPL5Qi8uRE9Zc5z8WalarqIGNqZ5ZFmuW2znSQi0u/DbhXtCc1ELacK4tqQwKnMOmj2lG388ZriqFBKK6vAs2im3XqaG3qn/ETo6iPpCgmm1amKbhZ61q+AOSTGFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SIHYHk8f; arc=fail smtp.client-ip=40.93.196.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mffkSbEWAmtu4PQsbX8IZ60/g9BHao9QH9x6Ui6GVmhpuIioJsjkSjc8gUIZ4USLthUUAOqJHsLxryshYNEefcP4DV+imq0BvhIuIh8w8AACNneMsyRMG0mBcb1580vV7hpFGbAy+prpLM+j/av66aWmbnFCg7BLLAb1+0X8ZzkaBIr+IFJDrJ0yrVYAJmJmc3upQgLwYImk1CjwHPLTyJHu7Lli1poQGPzWcZlAJsSLg4o1EArwZRfFQ6H2OjoeSPS6MeUY//qoMWE2+uIqoR/oJKwu4GTg/5uvGYrkjpPQTXiCfcZrpTH1WY29LtKO40zRApeQYE39XRe5WJt5pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgTSP+yofphL/8cyvctjxi47O+NUhILzf4RKV25ahQE=;
 b=X2aKHItT5IUOaPZQm4TepuCQURBxb1dXnuCDsR18tNFE/QUapBNLXFZfjDR39hvFtTl8UCDzz+mK9/Fpuxgoxox8TLUQEiebvPtw6cxDi/+lWAz4pz1Wnk6znLTVY8wZekTiWvcnu8xRuc2v7cHWOC5xIktmSa0xcwttSuJr9WHaHrDYjtf7Ul4YB++s9VqNanPpIAjsIFoWFqO/M8exxaJWP5YXl76BW+YPsINTUS8AGoiQ0MOctZUENQpp7jddzpxf7kKaHrF+o6sTHIuwWipDJdUKR4vdXuh+qQ+Zg9cFG3cL7OUhLpI1daX3ILyuSoeTJM0JxLYiWMg62nIDrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgTSP+yofphL/8cyvctjxi47O+NUhILzf4RKV25ahQE=;
 b=SIHYHk8fRtWxrzW+3gZ5HQNmAa1fyzuN5QRyo8smqZ+VXH8VkR+GxzQAv36qLwTJHKhhqFANCj0xewNvh/uGlhCpcxjRMKu/esjPmaYR4mMvOGs2XtTpwAA4Rxu3XHM8VcjP3t9ZLOHvKJLLS+dOefxaZBlxJghbR41xcKXuj8M=
Received: from MW4PR03CA0303.namprd03.prod.outlook.com (2603:10b6:303:dd::8)
 by SA5PPF50009C446.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 11:53:19 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::34) by MW4PR03CA0303.outlook.office365.com
 (2603:10b6:303:dd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Fri,
 5 Dec 2025 11:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 11:53:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:17 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 03:53:17 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:15 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v22 13/25] cxl: Export functions for unwinding cxl by accelerators
Date: Fri, 5 Dec 2025 11:52:36 +0000
Message-ID: <20251205115248.772945-14-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|SA5PPF50009C446:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b97710-88a5-4d1e-f4b3-08de33f4e1ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cA9aSb5fa6J2Qd8qYE9H91yFMSoShYNjJR7YWcKJdbUwBlbRLFEcoQu480vk?=
 =?us-ascii?Q?AMW5/SI4PG/N9Nsg1M5jnM1Kn/37lHfD4WysxPzs+ZiRWtpRdUXh8eZeIT25?=
 =?us-ascii?Q?Gdz2j6bfbRsW11iyptsNn7LBcxCmnUeU4N8VLp9ugckyttrf96D5b7IJycar?=
 =?us-ascii?Q?yhDbJ9AXiOURyrkI4woDhp9lSoWajVb/zMCJIWdTMU5+fAyjd93/Z7VoPfE4?=
 =?us-ascii?Q?rbBlgfUdwAYW9GfSWAivtlmUfDdIYMMDqZpl8p0JlOZbmKpHbyu1rNI0Pst8?=
 =?us-ascii?Q?yILCqHw78/HqSipgQg8Fm1G7U1KGK0qVWHkZCjLBvbSOYPrg7VMvQdk02Ywg?=
 =?us-ascii?Q?4DFPcS2DKdZLBhOi5185Mt0/U0vBvEMN+fuNDA0elAmtFdHxQUZ4SKKhq27V?=
 =?us-ascii?Q?R3nsFGNCUaD6mRLuLb2ltYJeP6oOPGehHAk4Uh86JPHj98cH/jnsAUCw+w5F?=
 =?us-ascii?Q?m0gQaGauw3tBsqRNcFmPzNx1V63xo2PiqvFD+CTBPf3RAtbWrbeno2RNyhxa?=
 =?us-ascii?Q?kLUtp6jxtP3rOuXAKREpgwt0E45b+96vkCBunTzVLW4i9iR3NXpHo2gyPYH9?=
 =?us-ascii?Q?TrFpAuVZgncsgyEdLDr3uERNQUULzzSf+9OWqGQlIeMuSd2Ch0R4agwUInKx?=
 =?us-ascii?Q?udDbU/BJ4mLLG0LtfZJ/AUw18Z+eF8lI6qh8BT8cq/Ne9pr7rwZ7EdSmVmTq?=
 =?us-ascii?Q?5u6nZCz0uBSQSOo1otST45mUf21Ut0a7A8kEV6odiIEYPoV19A8w2mWdu/B+?=
 =?us-ascii?Q?2KJRX+EVBra0QoZtxO4mFSC3Z3oOvUKUjqbJ8FWVMhhsBCUgOvZOCGT3tuXd?=
 =?us-ascii?Q?Ay9ZH2um20JtjpR9l/UWAsLJHzgZlR2UcCaOw385VYjnWk3nkSVSF2dRPW9y?=
 =?us-ascii?Q?gRb7e/r1ADKDqGvwCQkYLwe1LWrinD24iTvgWG8G3cdaDjJCGaonhQPoiL/7?=
 =?us-ascii?Q?CUh6y/B3KPY2h+JPBITi1+S4tzBAHVwl9ytRhFLq4TSv4mCcMW7qgrraVHNq?=
 =?us-ascii?Q?IeGoE2kVEFps9mbQun3GG+fykZ9x7tG3ACNGenhO7i6rhVZ4tO6UPMDKuTi+?=
 =?us-ascii?Q?bGQnmBx/2XEU/22+kmz2l/qtDD4GTZypfD6DXozR9+vJcFb1FFvv+6hvqI9U?=
 =?us-ascii?Q?YEaopg8l5zNts/vn3XxqNtzrocTf10qVH4x/szJv3KitYyeYJY+QP/dCiKfm?=
 =?us-ascii?Q?3y9MBjcW5WCJwDM7RzZ85VAjgRZ4E8AYJZwRJi0eOCVdxvNRAnG5EZBZRBdf?=
 =?us-ascii?Q?u3Zfs6yqECr6PdJpP6R5gELgfWI5zyVAzwcYyvRp3uf8/tTeY6YoLisPptmW?=
 =?us-ascii?Q?ZmN8fGa8apFhKoTmtQB+7PR6pjeY/hiA/pnhUbhwwcgA3/4NCHC8OH5XJaqs?=
 =?us-ascii?Q?Jo+tEjzGPhPjui9w25nxr+/LU2SImh/uEie+c0Pd4YuBMenILeMVN9ZN9LlO?=
 =?us-ascii?Q?neN6gnJPNT9w7PkNrWRjvbGOSn7fnZYeE8Bn8wZfkfwUO2jj9NDD/laKnuad?=
 =?us-ascii?Q?Da8LC7IjkxwZwXE+6FNkD0C+2PxjaHhD8hBXHBt7Fw7nedlChLuUcvmArI/W?=
 =?us-ascii?Q?qK06JdA5je+PM157UY4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:18.3222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b97710-88a5-4d1e-f4b3-08de33f4e1ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF50009C446

From: Alejandro Lucero <alucerop@amd.com>

Add unregister_region() and cxl_decoder_detach() to the accelerator
driver API for a clean exit.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/core.h   | 5 -----
 drivers/cxl/core/region.c | 4 +++-
 include/cxl/cxl.h         | 9 +++++++++
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1c1726856139..9a6775845afe 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -15,11 +15,6 @@ extern const struct device_type cxl_pmu_type;
 
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
index 8166a402373e..104caa33b7bb 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2199,6 +2199,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
 	}
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_decoder_detach, "CXL");
 
 static int __attach_target(struct cxl_region *cxlr,
 			   struct cxl_endpoint_decoder *cxled, int pos,
@@ -2393,7 +2394,7 @@ static struct cxl_region *to_cxl_region(struct device *dev)
 	return container_of(dev, struct cxl_region, dev);
 }
 
-static void unregister_region(void *_cxlr)
+void unregister_region(void *_cxlr)
 {
 	struct cxl_region *cxlr = _cxlr;
 	struct cxl_region_params *p = &cxlr->params;
@@ -2412,6 +2413,7 @@ static void unregister_region(void *_cxlr)
 	cxl_region_iomem_release(cxlr);
 	put_device(&cxlr->dev);
 }
+EXPORT_SYMBOL_NS_GPL(unregister_region, "CXL");
 
 static struct lock_class_key cxl_region_key;
 
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index f02dd817b40f..b8683c75dfde 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -255,4 +255,13 @@ struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
 						       struct cxl_region **cxlr);
 struct range;
 int cxl_get_region_range(struct cxl_region *region, struct range *range);
+enum cxl_detach_mode {
+	DETACH_ONLY,
+	DETACH_INVALIDATE,
+};
+
+int cxl_decoder_detach(struct cxl_region *cxlr,
+		       struct cxl_endpoint_decoder *cxled, int pos,
+		       enum cxl_detach_mode mode);
+void unregister_region(void *_cxlr);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


