Return-Path: <netdev+bounces-224332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0D6B83BEF
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D001C21F52
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A1D301467;
	Thu, 18 Sep 2025 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AUz+Co8Y"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F022430277F;
	Thu, 18 Sep 2025 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187117; cv=fail; b=WFPgQxfSva9rBVWPOpVZIBFSKlt0JRs52hPt8Z3t6mTz7afkzcO59oG2uPi1yyhZoQNqbuzlAoe+gXxHa60w2zwvq5VoPw9HjcI/CYbK9GbtAHHs4+FOzDjzBVtS0kwaziGDL3e51s3rbD15nEHR8hMF8QbaCJxYDBvRSgCE5vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187117; c=relaxed/simple;
	bh=Yb3fjw7YhmFQL9DKh5XTKWkEWF30NZryBQrMKZMm03o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9xihm2APHc2+lFvbHlwyUK17/v0fDqHVbbHi75KK5tjHgUeSrqgHz4PvAd0FuXNQraKn5cvfPelDDfWQ+5YvCMO3x07lQzg2FaIo/dsZis3dZ+sEhTndgOJdRO+Ar97R64OhwPAtJJdXJCGQL/Yqx5GkrxkymFKBot7xf5Chbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AUz+Co8Y; arc=fail smtp.client-ip=40.107.208.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQGVpPVtCIPVf+CSZcj/RxHX48eeV3piQLx7+6zUQfoSwRtNkxBwTayDlzW8QT0y4bDeiBwOZk2Yrb11aJu3C4Vhuh7854eIK87s8EG1+XXsPLlYsirtx9fGMKLbxYHrghEdCAkSJ3SdE8C4MHboFn2yOCv00lMZ59IA2Wxr0POAKH31Jzp6lMOXBqo42y1YQsu0q062wTX8f4VbNtnP/+/IAVLPStGoOUN4Bsi6aqYJ1yRQY9eVjwshFVltqIa6sQ17v+Vqj4SCAIuXXngY/ETQaA0F2LreMQHqNaOJWvSAQ5v2XEK5EO1um15ToearcQWszIPQm6OUuSUCP5gNWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6UAUyTKQtuL4I1zxqBTz3YHyKAYbM5lEvGGaJkuP7w=;
 b=RdK4Yxh6oWxOlp7ZE6xfEUmQc86cIR6RB2kkS+AHutOUN9ouNe080QskcaFDsd0V+erNG/353qEGQFFPC6JfIqYoBu8eqgmbj+y3CV+FLrJarZPT6swti6YU59yTwYr6CI0N3pYPsNKpod9idZOI80lQkaL/UvNIKx7UfGWx4K5sJUmQ6CVFn/23yF7T96JXUzWsW9KYAnRsKTpGTuAiQ2KcWx5S/ieQqep/IpDtaZBLRzklNIWf/6qUHjkhzteR+uHHeG9NCaKMxyiDUgPNETP8L8iefUN4uakAwQD5qC0SFMyl594Cn4vZdg0ounZRD4X2k16f+C1NHL2wukZTcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6UAUyTKQtuL4I1zxqBTz3YHyKAYbM5lEvGGaJkuP7w=;
 b=AUz+Co8YOBv/3vB/0XEAVKbVPeKTvUgZP02ycMUC4UIkC+SmQshrpJGnXemR+56MxSExpDXruV/GrFHEgZj30LYSnsYDhSCa2qsYlMydllEhrme/EzhS2brpjiPGwZ5Bq5ty18oXxjUjqo0QN0fna+fPT9YF3LBVCMWYvQ8hefo=
Received: from SN7P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::21)
 by DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 09:18:32 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::46) by SN7P222CA0003.outlook.office365.com
 (2603:10b6:806:124::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 09:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 09:18:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:29 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:29 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:18:28 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v18 18/20] sfc: create cxl region
Date: Thu, 18 Sep 2025 10:17:44 +0100
Message-ID: <20250918091746.2034285-19-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|DS2PR12MB9615:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d39592-9357-4496-4a5e-08ddf6945627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d5r8MFxTIPA11QASliJA1cYcU18pvye0h9pi1vTyUxotWYE0Ox3cLrqmuZV0?=
 =?us-ascii?Q?GhPHLWosZ/F6Agpk9DMqf7Og9uXXdl/3EmfoeN9kw4PCGlEekbs3d9CkC1W+?=
 =?us-ascii?Q?6XbGipNIK3/tbs6y6orbNJu+u6IeurmPrxg8G1+B9rgoYq+7MBUXFtm7FZ2w?=
 =?us-ascii?Q?C+PlM5Hy9pp/KY4tGgYjV2EGyuHT1x3emeSOmTK2HyIfHO7BESezl6E8sGEl?=
 =?us-ascii?Q?CdVM8rPzbFmwqkeJlK2OsaJ/UTsb3Rz2uUm9PNAF/xuD+4oD+BdyLtP4r54p?=
 =?us-ascii?Q?PYyoipiiVcAB2NEOsKKtpl0Q58gjhgHqzkJHJcq4MQzEBB4kdEcJxjZygHqd?=
 =?us-ascii?Q?jJPZ7jTnZgUJOfNrLwV3+e67ROj1AXeEIbNnyL8h2liR4nSawAH8U5YL9Dmc?=
 =?us-ascii?Q?sw9rrtZhU31bzoBj3n7CpbU8JTyMy0IZcH2d+lh+x41fa8Z+tZrDmhM3iEuv?=
 =?us-ascii?Q?agefpiPZFEZaFgTCmKa8Woa9EkBOQtKGAjqUDSXLZhlneKxyZ+/OQLCnTHV+?=
 =?us-ascii?Q?aSDMKmHVivUJNiPnM0DP72aKf6X0HeoamTqNjMlX+sQR93lBKZInu8VHNkdY?=
 =?us-ascii?Q?+pfmWsGtlpF06bi21+8UjvGiDTG6Lm0lKkVvs0KqPhXgfGIfHCpzhaAm0QqX?=
 =?us-ascii?Q?BXS5owxbS5KkBbNCID1neQ/jBQL/z601A3B0nVFqqyIayU7kCvdyKkaFtoWS?=
 =?us-ascii?Q?m1sh32UuDIvwRbo17hED3EcWM19dmYClzbi70Bpvy8ouJWzcua+BHJv+0kgH?=
 =?us-ascii?Q?5g6N0CjPIJAZEyCkUD8UnjEhXH+WF6k5pVAHoe41Ty4IzlZYnURQGsyIKwj4?=
 =?us-ascii?Q?YdIWjkEy+x0kGSSkwY6LlP4b5kq//N1nP/ZnDkpinFBIbLk3940vYOLL/1iC?=
 =?us-ascii?Q?TkzLKc/ZLPi7pKNfaQ/mGe9UN8xKSOE6lJwVovGQzq8rfwnjrguY1nGGwtUO?=
 =?us-ascii?Q?RU/z50qiNi5Y27HmczfaTQiKzcp45OiMFGBIA8TxPf8HTWQEgM/jW4cVKBT4?=
 =?us-ascii?Q?OfR15hR2/LZxbXlHq/GOzIKmHyd+71t1IkABp9o6GTnav00UuNkYbSyBl5v4?=
 =?us-ascii?Q?mX1D4Fm/xN9GtRMtRJp7w7CtwNgZ2j9WmVpslyWps8nyP9IyNCndXemljEax?=
 =?us-ascii?Q?6g8CG0LyREzokacRxpQ8qjzMaF484JIUOSFFZ4GMq9Jtnzkamxwf35fCAWzM?=
 =?us-ascii?Q?Gpx9S8bibq7Y91dwdk5P9JtQz29BV3YZsqk4XAbW4mQk5uWp5vN1JDfABBuO?=
 =?us-ascii?Q?SvMH3UUtbu3LT8Gv2QcY/fuu4nnbXTd4tOW/jQmhhNIBUVqOfG/yUtcp4CuO?=
 =?us-ascii?Q?toqPlZxwuGqUTNriSNJphaPNy6CJBVtXTekPgeuvbmMeVkIngf+1jK7SslgV?=
 =?us-ascii?Q?Z8HjVhbeEstb0+c7Yd35XJ9qXHUobrbNoah0H6d//agPTWNIDjp64vltP7B3?=
 =?us-ascii?Q?GawCQyuEAUnXmgOd69BF9PtZ2lkT8G/+R3GhEti5s40THOLjC9UVB8/rNfZh?=
 =?us-ascii?Q?WRPvfFZ49kPGvijfxFAMwD1j8CtfEKQ1GSg6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:31.6872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d39592-9357-4496-4a5e-08ddf6945627
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9615

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for creating a region using the endpoint decoder related to
a DPA range.

Add a callback for unwinding sfc cxl initialization when the endpoint port
is destroyed by potential cxl_acpi or cxl_mem modules removal.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/core.h            |  5 -----
 drivers/net/ethernet/sfc/efx_cxl.c | 22 ++++++++++++++++++++++
 include/cxl/cxl.h                  |  8 ++++++++
 3 files changed, 30 insertions(+), 5 deletions(-)

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
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 4461b7a4dc2c..85490afc7930 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -14,6 +14,16 @@
 
 #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
 
+static void efx_release_cxl_region(void *priv_cxl)
+{
+	struct efx_probe_data *probe_data = priv_cxl;
+	struct efx_cxl *cxl = probe_data->cxl;
+
+	probe_data->cxl_pio_initialised = false;
+	iounmap(cxl->ctpio_cxl);
+	cxl_put_root_decoder(cxl->cxlrd);
+}
+
 int efx_cxl_init(struct efx_probe_data *probe_data)
 {
 	struct efx_nic *efx = &probe_data->efx;
@@ -118,6 +128,16 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err_decoder;
 	}
 
+	cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1,
+					    efx_release_cxl_region,
+					    &probe_data);
+	if (IS_ERR(cxl->efx_region)) {
+		pci_err(pci_dev, "CXL accel create region failed");
+		cxl_dpa_free(cxl->cxled);
+		rc = PTR_ERR(cxl->efx_region);
+		goto err_decoder;
+	}
+
 	probe_data->cxl = cxl;
 
 	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
@@ -135,6 +155,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0,
+				   DETACH_INVALIDATE);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 	}
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index dbacefff8d60..e82f94921b5b 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -282,4 +282,12 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     struct cxl_endpoint_decoder **cxled,
 				     int ways, void (*action)(void *),
 				     void *data);
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


