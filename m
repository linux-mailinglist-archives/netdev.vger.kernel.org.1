Return-Path: <netdev+bounces-136676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 157349A2A5E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6A89B2461F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ACE1F4712;
	Thu, 17 Oct 2024 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C3g/dXmY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826531F12F4;
	Thu, 17 Oct 2024 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184024; cv=fail; b=FW69nnidddyZGeKmUzLjugM/B3k2pF/tu9i5dSTMd6wKiDpT3HpHylx5KkDqzcoCqrcH6ZtARJLGC8822JJgwcQYgxUJCe+rjmioe+G8LPFTlLampWysUjL9xGeVOlIOmoiz2gneWO+aNFRhog9Kge7aksp9Me2YMo6CbIr9d6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184024; c=relaxed/simple;
	bh=icdkL5S7Ol6GZtJcALdOn//EepSKgBuN65jITM/uoH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U07Z5jfwdWkCfZaXwsHnGz/OTXpWnyGaS3yczRcg1nW1jOqz9ZSn7bUR27VKjllgXxoSQVk2fJoLXPzbVH8kFUc67exIqZ96+cuBvGVRkHjCYeS9aixOalb5WdizNUL0mna9sZWOJToZ4ZPHFJFpahwU7IBI0OeuShsOuhbqUpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C3g/dXmY; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGR034lGe7GZ/3qrfsUVcTXzuNWXvUx/HEu3xbUv5WNGfg/+48qhuOJ0HxKFXeurQSlskk8BMTs9/sXV70Gm5C3cJy6U8za2glPnvFIV99EoeyegiC3hPK3OZRfBgU71UDq6WW/Eg6wT/zXnQEdwoxB2BMz/2bhny3J+0vVH6cd6agF7jwGZpeZNY7Fuhr3GT8TeIr+9X6GckinnZm3xM+vQrURFB7lmyRoR+I3T4N9YSeWobUyJFuqu8BIf+tj1L/hLLDP+rtAvPTy06eWd2Zf1+ejm+NkDzMv4bH+4cqTQ5rgVF5NrIqiXPfVBFFwKGtzbbjLPb+KKMjVOLk1GLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vs8MMfq6AO7+EmA0ZbDDxUFyexk2QUOhkTot+s0DIHA=;
 b=tedPiky4mReWO2OYNnUm3/0l/mSzsf/C/9GcAPA+EdWMxIsGYVJsRnpVOJ+iKNVTOY4sx9lWPyI5rDmwzyK69xe8vf72hc2Uc5v9gCQ9hgnBVN57pCHgkAohshjSdgq27+tZ5QVaQBfCyCLm/vrbT7qzN90BqZ7En58YYMzXQtugY0iUGzNKfH/HAxsuBugBJgMHtsdRrFpHqtPawrUpRbjjuWN8BwntNLG1IlPSqD0lb0XXg1Dp0uW1qaRhZz7zaCUfvWa/lMggn4HrGpSWQti0ujftCyEt0EM/1CFBjf8hCJyUaJFaLYdBOeE3fe3uZcTrr0ufT+x6Wp2kHsKNHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vs8MMfq6AO7+EmA0ZbDDxUFyexk2QUOhkTot+s0DIHA=;
 b=C3g/dXmYv7fPIwa1jmbKoggCUaLanStRYPNnFgR7TjOXtuinavJXzM3dAcyUqP2WWRtxsHZyhO67vUZkZXaaqqBVEP8QR/1fojBs8lPvuSs+SksuqZlQSEQhmbYMH0IQVb8kFccAeFeXmnBNmDD9Sx03i53YB4+4MBgCp7QJa/g=
Received: from MN2PR07CA0023.namprd07.prod.outlook.com (2603:10b6:208:1a0::33)
 by DS0PR12MB8343.namprd12.prod.outlook.com (2603:10b6:8:fd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.25; Thu, 17 Oct 2024 16:53:37 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::37) by MN2PR07CA0023.outlook.office365.com
 (2603:10b6:208:1a0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:35 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:34 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 16/26] sfc: obtain root decoder with enough HPA free space
Date: Thu, 17 Oct 2024 17:52:15 +0100
Message-ID: <20241017165225.21206-17-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DS0PR12MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: 487df862-a7da-4fc2-46db-08dceecc3dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NBIWSW5GbD80caHIrOKCLsGPRZd6PME0kA835N1GjdNiCr4jKxMivpzXFP7i?=
 =?us-ascii?Q?4190C5evrocgFZPL9/G+3hzSqgIoEHfztHQmekkq6yldqtB2M9OGYi/U2gnb?=
 =?us-ascii?Q?Ru9+96tjoW6oYRxemTbSm7nYVXkGGbQm+NZzM6TDSJEd7uO87EZU+Aac4Xx9?=
 =?us-ascii?Q?9x6OFRK/KVk9eAHsFFkOBp5RwS84VeeFJOZDLL8+anDGWWnwX7Hx8cjcIuDS?=
 =?us-ascii?Q?ABDIZUp/m0adV8qwbxS4qEkXmitaTTj4iQIJDWrYrD9mbwMtx4LDUxPdQkRF?=
 =?us-ascii?Q?5iYaS3daRS8u4OpU2OIIRRpl5NxjRjxQCOQd47aCD0Oa0KydaEMyFkR9H7jS?=
 =?us-ascii?Q?m8VMD3FsoIUp5/H6u6mnUDT8bM0LCwuLov2JkO+PCvSuuoFiuq2NXu1k+XEp?=
 =?us-ascii?Q?hYz6JYeySIYkVivaylsnX2yanCagfLkqbiTmh80cKlQpQjAabDMcVORmfoAR?=
 =?us-ascii?Q?5zpy5/LlRSIUZ8PQP0K/JL+/jJpbl8SSJutgujRq7KGVn4H8gFeZU2Gbybir?=
 =?us-ascii?Q?v0gmvQm2Fwpw9wY72KRK9SrTkNcUGehF0U4SFY5eWHb+k1k7Wlb25yuB2NKG?=
 =?us-ascii?Q?hB/BhfwNDmNRUGaE1/j7TTic4j9NjgX72jxFSUdB1+e8XIYfXp8xcEfIYpHG?=
 =?us-ascii?Q?8p1PPsYOkKyTgif2/9ZluTlEO6TTAr5ETPxMk5PLUd9rrqoF9Ombx4i+B2ng?=
 =?us-ascii?Q?eTtljEGfM63NQ5OYHxpmsl8v7nXELAJFnZu+VrBXK00V05K+PRGUhwWoQpX0?=
 =?us-ascii?Q?jbYPB0qCHLb/R3ZUWl8bSY/VquA46Eubrr0pcXm1V205BHLtjza2vxctFc0R?=
 =?us-ascii?Q?oHU/Kg/h5qw2TbPF9GvCwy36zqdB4MGc5df01u8mYnqAtOFf0N5bZlmPH8F2?=
 =?us-ascii?Q?6hT1HS71WMyjwlp1nJUcgooi4XByk0bQ8qHXEq0DA0kXKTnJvh4epK0pmrCw?=
 =?us-ascii?Q?4HGRWlp77NKd+Un/OhIBCJAB1ti55qtCXfJ3ssi1snRZ0ZQBE6PHuuKpQS/9?=
 =?us-ascii?Q?uPXImyyHbELbPjMhIXol97Cdy6w4FVgAWjo+7GXQyrT3SOiqCu0RBXHhqiDY?=
 =?us-ascii?Q?3Zw4qUSjUWsHlDU2e//mUaajXWRavCI6Tde1sbuRsVr5IPl/8CPAmj1zKrQd?=
 =?us-ascii?Q?2fjxSAccZ7iKupmRTy6LOjJSvksDQPn0sLWwsrpXbGBnav7jsJoItficmnTK?=
 =?us-ascii?Q?nUpUaS85UETEAuNGZlqkRKxLJXddHYCGczIZDp4tG8LW8SN2UVIqzv4daM+k?=
 =?us-ascii?Q?ElhUxhuo6Cb6oszfV/KMsg1mi185ndFkTzLRXBYkYMPZMGAs95kuZWMjh9Dz?=
 =?us-ascii?Q?GnERS7FzH0FROPI8NBtr12WyhY8ND9dCRk2pVAd35cjfxb6ssPg1pfDR22Mj?=
 =?us-ascii?Q?6s7/jZktg3vtg8YD28EUwdYvne1T+t3CEOR5x+TNOFYWlRBx5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:35.7244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 487df862-a7da-4fc2-46db-08dceecc3dd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8343

From: Alejandro Lucero <alucerop@amd.com>

Asking for availbale HPA space is the previous step to try to obtain
an HPA range suitable to accel driver purposes.

Add this call to efx cxl initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 452421d71fbf..399bd60f2e40 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -26,6 +26,7 @@ int efx_cxl_init(struct efx_nic *efx)
 	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	struct efx_cxl *cxl;
 	struct resource res;
+	resource_size_t max;
 	u16 dvsec;
 	int rc;
 
@@ -101,6 +102,23 @@ int efx_cxl_init(struct efx_nic *efx)
 		goto err3;
 	}
 
+	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd,
+					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
+					   &max);
+
+	if (IS_ERR(cxl->cxlrd)) {
+		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
+		rc = PTR_ERR(cxl->cxlrd);
+		goto err3;
+	}
+
+	if (max < EFX_CTPIO_BUFFER_SIZE) {
+		pci_err(pci_dev, "%s: no enough free HPA space %llu < %u\n",
+			__func__, max, EFX_CTPIO_BUFFER_SIZE);
+		rc = -ENOSPC;
+		goto err3;
+	}
+
 	efx->cxl = cxl;
 #endif
 
-- 
2.17.1


