Return-Path: <netdev+bounces-190436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A94A0AB6CB5
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4F919E8F7A
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DDD281364;
	Wed, 14 May 2025 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hww6ORjT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10BB280314;
	Wed, 14 May 2025 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229314; cv=fail; b=u+TgpFnmzatKAXbIy900l8Fa6DBBq5TGo50lZRAlG+jM3xtHWT8ENk+oXaQ1ozXsHfhkWoPuVmFKD5WdU8i0PxNPT6k/CxCn0K0VraVNOhE0XmgnUKCtkzdoA7uUeTJCAR8scPHzvHUjr88eMXz+x53QPvoTfsgC5Xdui4gx3es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229314; c=relaxed/simple;
	bh=Kyjw5TSko9hNekCIGZ3CNEUo9bZNud28um4j60THGGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/Q04I2HV+hXQ/C4RwAmwiUJaOWAvGrxFUYcq3d/u7G63XwcDDLh+Fxl5IWlIXtJKOAMb1pw8XG73esTduTGadrNQ/h3I4F6tXKGO5MSf61PIebcJRxvgO+U6TRBzPr73V3n2P5iMqYcOQev2P8hyJyDZvaNa/BCNvUOI1h/0Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hww6ORjT; arc=fail smtp.client-ip=40.107.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGq0J9v3/RiDQjlGbe2doM9qzJ9qdVYqrfadHE5grZLTztQ32YSIc6JQDkyNuASk7iBpNkhpKhETDdKlCHj8S6GvXffjse803zA8GQeRaQLF2D/oR9CrzfaUxlZDp3S70fMezRVxjLd4Z/Czfybtqati4NAOF+k3CwOl/YV23qVq7JgLJGpPOmtXgmq/L8o8rBsFosPcB7xNNEjoeWwScRNK4cQ9EACtPq2EC/jIQVulQm+aXuC2mz2sRwwtCxVHWMWQFSZoAfL9KMXHRX5TtOJ3Oh2AWW2x4L1zIF7XVcnuRu9wQkcFqKy2At8BbkpyYSV6Q6rTtOktHtvAGVrmqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boEvLG4ALwjGfjhj5iFeOw872unotDB+rmRcUaS6ITQ=;
 b=vKTVptofkDa5Rp44+TGveKBzlWbnDro8JnNv534G/zhAKOngGLvsUWbvRSJZVlYyC4N3gGAiM5gyckuGbxO3kelCNt0vlhmQ9gKoYGdkHJxVyuHRYRDdaYAtWqfAgvx5OmhZJE+rALCgxVH1/rQKweN8ehOAUjsX4MMnsaPKdgN1uvEcD20e1C6K3SPay7w3eI8eLJOsdNJzLGzoq9lwKOlidKOr5EvMIZaLzuktSRB8ODzXB/wbdx0UXzHO/wto0HmKNPGxSCK4nCIPI379jfpBU3moS3bcTwGLz/rbYnEyxnIndOazR8jZfRfaYskdCAn3aw52I+Fe9CeiNNnDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boEvLG4ALwjGfjhj5iFeOw872unotDB+rmRcUaS6ITQ=;
 b=hww6ORjTCy3D8sjbTnCdTh63MiKA0S4qnDX1pv25f91bqPQZ8VubuwOih1ACJLWsfBjQIHJmS2gBiZmTW3N7lqLKrI4yN+vMlPR+1WFnT+eMFnOkGtY0j3NKRWWJ3meHWXlAowLPYFF00rVqE0HIPAUhSF56PLZMS3LRr2+Pjqk=
Received: from BN0PR04CA0061.namprd04.prod.outlook.com (2603:10b6:408:ea::6)
 by PH7PR12MB7891.namprd12.prod.outlook.com (2603:10b6:510:27a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 13:28:29 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::c7) by BN0PR04CA0061.outlook.office365.com
 (2603:10b6:408:ea::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Wed,
 14 May 2025 13:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:28:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:27 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:28:26 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v16 21/22] cxl: Add function for obtaining region range
Date: Wed, 14 May 2025 14:27:42 +0100
Message-ID: <20250514132743.523469-22-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|PH7PR12MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 453527ae-7883-4cdd-d603-08dd92eb369f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bohTuzpEulAK3cUnqOAxUHbG0u4j3pMdBNvECuHZM14rAO103UakOtGz9GXg?=
 =?us-ascii?Q?tvvBQFb4IcTfy007qWzaX4qHylBn9gfya22BIV3Zt9ScXO7ReNnkl/HQrdcw?=
 =?us-ascii?Q?yuUXCqOT0zPEkAPPLPRlh1f/WRVzR8dZftkVGmtAQ3ECPQhmmXilYzIWoYB9?=
 =?us-ascii?Q?np0e6wHJuXZRHKsmo5+9/f6Yu4xV0HfWw+iiwCruZdcYwrCWSA3fKwELBYoR?=
 =?us-ascii?Q?NG6fbZ3NceJqDjfQbfwjs+luun25j/XYTLUWdKdbTWl3rK8QlhENNMDpv1Ug?=
 =?us-ascii?Q?gdi1sA3fA3ser/EpC+uch2NQZyLBiMvdOhBNPKTDXgKmHQdgqY9a7aCsCIQV?=
 =?us-ascii?Q?Hku1yfGjkXHqzmkbIwjSgP96NG8xBglBhTYV54Wvz+oFCYBTfjAHOSJ+MLUv?=
 =?us-ascii?Q?q9GNvQxF36L4CR+Pq4sVYeWDmS5ohEw8PBjq9nIx68IE9UOkbymFU1btnRTs?=
 =?us-ascii?Q?ndvOqP2zhx/H6/Kdzu7mIQuftPXm4m8uOKnZvF1q56v9Apa/weHrojUAb3hA?=
 =?us-ascii?Q?ZrHZRIqwLUt0wpcwKvW4UHY+6Dln1f13j8iQT4b2na3RJQjdd+q6SboLkeIY?=
 =?us-ascii?Q?YNfmPYCjGOq7TairQ80+UfjbFRZL2HUQSEI9bPACCKydnerQGNe6t5hl5weU?=
 =?us-ascii?Q?JdJRCT2GA6CrNGK1Cdu+5X7K6duR0W61E8Je/Auos8kRcJOn0P/EdUlqwAVg?=
 =?us-ascii?Q?Je8X+0+ftoiApGpQDdnG4LrSf2gxEn1ADa+/SjSj7go0y6FCbHWLrEAS1UYk?=
 =?us-ascii?Q?dWvCGJ1d7bwbvq5jOybDDjSQi/YqhAC2kYjOIig1cNv9bCUMB4aLGm29h4dj?=
 =?us-ascii?Q?3MtOrvOqXtmH1XADZnaNg2TI587mrIqj4BFc98DcUDOreQKQmL/1DpK0Il25?=
 =?us-ascii?Q?cI+2g8Mq329VE2zQrRr2o667dmUVu3JuX9+9sC1l7zWda0+IDcLUpfysejOi?=
 =?us-ascii?Q?fSuT1yX3UrdPlRlT62YsoQCk7/k9kqRkFeNIajTUzw1LS/JsLlyxHZBzeQRK?=
 =?us-ascii?Q?N/OYpXqmIX5OYbO4rfokTXxDoOc5gCjlZ6HiqCB3IcTQ0dk5pL0yMt/ypfJl?=
 =?us-ascii?Q?X5XsyEjJwKVX0+l3DEpRqi+2uyhi3+i7gbGi3QME8127k9STQrElAef7/HO5?=
 =?us-ascii?Q?eK3pXoQHuErMq3PIURJLNgjf4u91yhMZ6V1Px8OH64mSv5uZdexTpzYJMAFo?=
 =?us-ascii?Q?8OflYzmrgS1m3Gr1iZDmp3uHX1cyVUguauozN6MkteK/qiqYGsgSwJOm00/1?=
 =?us-ascii?Q?XmdN6wUvniob6DbP1PcAQtvdNOq8gwK7Yzz4EChQ09d53PcgFKVZ67qrRtYn?=
 =?us-ascii?Q?Bbm5/Y2GqO5J6oMaAUrywWYjs1KwPWu8LZfnbf5C79Yo8NKVVPw0tTiLifNK?=
 =?us-ascii?Q?NClLTQCGJ/Cq3lr6kSFr3oTqx+EBjbAOFgDOhnDsF8aSLaZrHIRW4uB7TFc7?=
 =?us-ascii?Q?lQmfkmQ93BTBgpnsa2fLG80yKJubs3z2iy34vUig8hqr7yORVxKdsu65J2Ri?=
 =?us-ascii?Q?1oEBrGk1geGVE6PzhcIiYQsiBcyVLfUufzZ+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:28:28.7418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 453527ae-7883-4cdd-d603-08dd92eb369f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7891

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
index 06647bae210f..9b7c6b8304d6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2726,6 +2726,29 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
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
index 867dd33adaff..f6977eafd7e9 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -287,4 +287,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     bool no_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
+struct range;
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


