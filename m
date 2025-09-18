Return-Path: <netdev+bounces-224322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33552B83BE3
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61284524E60
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A514730171B;
	Thu, 18 Sep 2025 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XNa+lVGT"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA92301022;
	Thu, 18 Sep 2025 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187112; cv=fail; b=p3hKwgM22algGBkgbRDGHHeOSX9/c0doAMicdNlhgzQfCm0Xh8xnjVgAfFN50sM2s8Yfxx1hdxLGdX0zCqSajy+i+Wd6LmqNgNGt9kkjVwIAXl++6Ca1VdeCDusg7quudB/cwgUX8c1U1bN97W+GukVP9AwSscig0CB7Le8VLY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187112; c=relaxed/simple;
	bh=9nmDYuRwQCnvMOG3JwUxKCqK+wGtFkKZHPuZuu+Jaqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIK3USnGJVUa4VkB+au159YhZpZqHz8DMddDJYOPluVu5aTXeFd548KVWxtYZXH5/bUt+s1jZks5bZvhO0mpe0PnTA3Zw7Bzkxf06+x2SG2+RSG+teYS0I9IsbBaB12j2YdY9u/pXQHCCqWYPwTNMOw/gUflHpPUVZ73TV5idgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XNa+lVGT; arc=fail smtp.client-ip=52.101.85.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpuBCyLhnKCMTAIz/xaBARLwCTfGI2OU2XGvB+IeZpBAStMbPCSuQUsyhRLCGGFCcGiGchvf0xShnL4lgwzEhPZZce96rz4XSpejykaDoJ2rIIE4+Kc1vgO1thGoJTWvYzMqobp7swhJzuY2WRvRAAK69pM83bHrXYb0VYukx9zSziHgh4fo0cuesoo5cLbU2FrNyAkyn3467xGzFeOTgSUGFHpiQalsXyTGxag8QRr93aEr6DYoMnysyYrtvpQuYWSTcFzpmoF7NIXP3da79VnnmBTh+PWmrIg7+aCTxdbyzTxqVRJyg7cVkJEccHaKgLo06vIUogT0SuMxW/7v7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jtThj5C2Nx7QmYC4XzpsoQtlrSSXwML1WB1w+/Yx3o=;
 b=pxz+ZS9vctv8OccFGglUAOWBVUz2FU+HpeCDuSELsRpgr5YvB3Y827C7XlX2m5jQHr+Ubns6EaUVC85lwDbWtYQJaJCwh2JdNSgUgaFWaZkQ6ATaDTXYAJsvFAkKHVqP/e//TFDH061E9cOT8aOAI/W8yAQ5CupNXWSuHCu6GGzL5+W20X/aasH3CuejObZ8hPZVMJ/sUn29tAtCJuYlMZUQ/KjX3C2mqNd9+5XjdF0VHaThUUeODRa1oQyJTpGDURX224HUt+L5JJ2d0euLtPzighuRtc0Z2rhwAbvoP2MRknnj2Fvtdtc3Z0XzojEZWV0jGL9ggKcUk0TKyMU1og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jtThj5C2Nx7QmYC4XzpsoQtlrSSXwML1WB1w+/Yx3o=;
 b=XNa+lVGTC2tERgmTqhjqL7ztHBNCL/FCl/DXM+cwCDc09qcSJMGzS02z/KUCQJuyDfn2qVjytsLUEGGS5jYdlL/OY87Nb2d0UmQ5pVzYpCyk0hd4illQzhC0Osk75/xV5eohj9ddJ8RN4IbbKmpnyhSlk0I/nrZ7Lm4esogspTg=
Received: from BL0PR0102CA0043.prod.exchangelabs.com (2603:10b6:208:25::20) by
 IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Thu, 18 Sep 2025 09:18:27 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::1c) by BL0PR0102CA0043.outlook.office365.com
 (2603:10b6:208:25::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 09:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 09:18:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:20 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Sep
 2025 04:18:19 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:18:18 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v18 12/20] sfc: get endpoint decoder
Date: Thu, 18 Sep 2025 10:17:38 +0100
Message-ID: <20250918091746.2034285-13-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d4f067-88f5-4744-47d0-08ddf6945392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G2IKW+gQdFKaQ0qFr1H+Cz+dJmXyY+ECa6RkWi2kP2avdTyYnhYhzl5weZqI?=
 =?us-ascii?Q?U8c7Vuu4wELVTyoLK+iYkncYTLE6FGYwe0fE4bo3+WQVFZyDO839g9JOZQb9?=
 =?us-ascii?Q?do0hr6ku3WrEUHglQqpb17/IYHiUDR1V3Bp9DB8lDhY5rx3d3JZ2ZhZGJwZz?=
 =?us-ascii?Q?0O2g8VUrwMWdcGtu5cXSn40kw089T7nDR2JyaKa4WdvvP3/6XbHeYEiFzHyU?=
 =?us-ascii?Q?H6AaBRP0uz8p2oIGvztzAnk69RtKTRc6jqoZt4MkEb6uSLUALPzuxibl6dbX?=
 =?us-ascii?Q?+HSePaszMP9HRZU+JLNLi6T9zmiWVl58POswreznBTwTEzXWdX2hWWLVBk+O?=
 =?us-ascii?Q?kyudzSqKK7AXKTrWMpBizev1H/Aa51tS6P6PC7X1ZCxkJ3LWmn7Bgdmg9WQm?=
 =?us-ascii?Q?se5BdbaCSTF+rZYFw+ql51/6d3H5SzZ5dajQ2qknwfNkWa6zohkEFK4I+qBd?=
 =?us-ascii?Q?g7RUqr6t9z+WRCCuHZPCZ7VEXtk7scK1/MPgnMgn87KKcvNDUjmZsnWHP+5l?=
 =?us-ascii?Q?nrL+vbuS2BRzMoJqv3q5E3rx0qBB/z4/xmCpAhAbefwBst6wLBtvr5F1qGNz?=
 =?us-ascii?Q?6IDmvAXsAL4vUgNffOAnMME0y79HUwBdkHO0egaNaqAN2m8qayfV1oSWTiuj?=
 =?us-ascii?Q?ilq3sg5Gk/PlB1Qr6rDuLeTjor13HdJWEhbhBDuXfDHyUxdyaHkT+CrqMvSG?=
 =?us-ascii?Q?uYSUKeupvL1AqgLFWXoZhqND6xGNERjSOSf/HWltG+O945WCfYmdmgmUDlUv?=
 =?us-ascii?Q?wtgwxR3Nb7o/gGNSmtkcytBWGC/QGCTHQTZOD3zdpuF5kVS+i+FsE0ToyHc1?=
 =?us-ascii?Q?pwDfliQwHcq4/PpLPF110OgBEz9JsYAl9Uk4psRyhTv5XU2oBEWHTOif1wb6?=
 =?us-ascii?Q?mQ4i500DbWjzJJTUd1OLlNZm8RpYia/bCjRntvDg91A38ScvNAWe1ZhHu36w?=
 =?us-ascii?Q?r628A42GeSgEUrsAnD4oR+1d1jArgyD3zTnbmBcvZ9A5PWJNW1solzhlF3av?=
 =?us-ascii?Q?4oBYa5hYSVi5nw0laRddB/hxhvDLlkpWxO4sTPN/lpuLFx5XngKEHzQ24GmR?=
 =?us-ascii?Q?Oc7+rD7tDjOGkc4PWqzdLjbQ13dGJ61rTmTJ4vWfPlYSLXll5esJFPLNAFNo?=
 =?us-ascii?Q?WcStOlBa8HFmiOK2m6irs7z3jzx/uD3ZjICkNSAivlzYCP134zIOAk5TXgvc?=
 =?us-ascii?Q?GPn504fhwsr1fLttFmdivhlv5IB7a2IYLrlxNcAnCckJ5WBl0rSBVPKHTAya?=
 =?us-ascii?Q?dl/YFkZBM1vlQcleh8ANQ+0W55nPrxnrJqBKSvyseAK4HNUXJUdhJLac6Lh6?=
 =?us-ascii?Q?r/b47BcxHzlJAB1hOQKfhF6v1DD14z2onCtgnfnFGDVJoeH+sRn1GC8gpGQr?=
 =?us-ascii?Q?3typ/IwE+QNAgQxP7Q+AyZNfzaGbpN3c58M+eUTJ/p/ToQh+AqGgHQwTVqNV?=
 =?us-ascii?Q?o4I7jNxZAdDfnISjFBDHTnx2I+2sRplPo+S084Zq4VrcaJ5viy7KhQCruAQq?=
 =?us-ascii?Q?GIN6nUCCbVbat6mJhNaLmWkpqmuHkwPoRp04?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:27.3737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d4f067-88f5-4744-47d0-08ddf6945392
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index d29594e71027..4461b7a4dc2c 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -99,16 +99,23 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
 	if (IS_ERR(cxl->cxlrd)) {
 		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
-		cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
-		return PTR_ERR(cxl->cxlrd);
+		rc = PTR_ERR(cxl->cxlrd);
+		goto err_release;
 	}
 
 	if (max_size < EFX_CTPIO_BUFFER_SIZE) {
 		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
 			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
-		cxl_put_root_decoder(cxl->cxlrd);
-		cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
-		return -ENOSPC;
+		rc = -ENOSPC;
+		goto err_decoder;
+	}
+
+	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
+				     EFX_CTPIO_BUFFER_SIZE);
+	if (IS_ERR(cxl->cxled)) {
+		pci_err(pci_dev, "CXL accel request DPA failed");
+		rc = PTR_ERR(cxl->cxled);
+		goto err_decoder;
 	}
 
 	probe_data->cxl = cxl;
@@ -116,12 +123,21 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
 
 	return 0;
+
+err_decoder:
+	cxl_put_root_decoder(cxl->cxlrd);
+err_release:
+	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
+
+	return rc;
 }
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
-	if (probe_data->cxl)
+	if (probe_data->cxl) {
+		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
+	}
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


