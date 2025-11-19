Return-Path: <netdev+bounces-240147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9618FC70CE3
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8B2A355F7B
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8373730D1;
	Wed, 19 Nov 2025 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pXZ98h13"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33BB311975;
	Wed, 19 Nov 2025 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580207; cv=fail; b=ZLlX0wRrK7lxSbwbfCH/kRrvPmSAi3PFfpfs2Orj32Z9ejS/mfiZYJWq1oiHUM4eyfZ6kq2z/aZaRLNlhuxOiGoDkxpfmQmEEyJopoHiY3yAr/HZ1W43bm+iWKRqkyhvGeu1HNkrtrpUAu0nL6jyOAbAz+Gx4Fm/b2B5KUMLovM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580207; c=relaxed/simple;
	bh=8EO+YYICOhyFPpXwJktGuLrmZ9QWMra8cSkB3cFVlb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/7kd1zTqxhKvWnoEM8rDoPXyYX/bjh9Tonz2lkGDXeRmBW2zVD1Vsx7PUkGdo/P8dH6BTDLaacUYEoi+P2HXBTFPzAvM9jpKYKvviGTRwSQD1ArnsxDHlndA4UyNO8f7v+eolYg37IXdO1up17GpowL5fnCy23juryka9vpZV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pXZ98h13; arc=fail smtp.client-ip=52.101.52.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDkgyQ1PLNkl7kY2r7+o8OFiXq2Qc0/X3HyxG21IG/2RhU2SUF3TPN4e2s3oR1Ja4LJJC/QH3VDg5U0wgH0Rkwm77oIRINmDbZ0hqHhMwj76x/KuwNpBp72FqkpGR6hxu7/M0TZYgMHShClm/kbvFu8dzh1cx7QIVirZVfOhlLFDjXaNPuOT3opgWP7PT+0HQZMWSni6t+2BX8nWro8RwL2sK+zkRG6k5R727+IWHNOQleJybiCsdvJq+MaI0un05NcxQCihbsuIgL6XcID4Lh0ACB+S4MT/5k+g8IVgejg+OGUYkA+meIzJS8kJAXsvLe8etEE9xqQ/kdYcG+G0xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F6y8TpiQAcm4HKcPk7PaxWy5bVX0SnmEmJUkEjCBEg=;
 b=VEIFJoCkMlVh/rvUFXmy8p5xSNafaLJfCTUcykO+c8xGno8fiSi6M47fPwJDtEMqvbWtBUwUtFm8RQuLGF466ZfOfOTTT7gU2oOOi3UtvUqalay496VVlx4loBsxCUjCph6sxT0CB9Ix+ESyccTSPYpg1ztGp/DTv0UwJARVvKxiDEfOb5VoITfb3hpCKBjDgjp4h/g5sAhe/7XZSIdXakbRetUy/UArG+99xJUZHjhMcCKi2jWxKKGR9et3v/n3Cn/caRUIdbZoFieelaZdMCSrPmP6L7eehUvZzMMSRHITiHI6fg5t4A6uIzEnH75K3a4uPA0LKwlVrAm/i7LDOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F6y8TpiQAcm4HKcPk7PaxWy5bVX0SnmEmJUkEjCBEg=;
 b=pXZ98h13SORVAALzd4Jamd9X7QAW7/Cd6PZn1Dhavv3gCTmujRC2XfHhF4H6bQWxbkbGOu5NZnqbj/e8rVLvniM7CJvZMqr54UzKxB31TAb60of5FH+NkVHrwxmtzTbe15hNZBXar4FKNu02DLtwr7/eEARR4dFkXz59F7/f9tA=
Received: from SJ0PR03CA0335.namprd03.prod.outlook.com (2603:10b6:a03:39c::10)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:23:09 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::78) by SJ0PR03CA0335.outlook.office365.com
 (2603:10b6:a03:39c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:23:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 19 Nov
 2025 11:23:06 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Nov
 2025 13:23:06 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:23:04 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v21 13/23] sfc: get root decoder
Date: Wed, 19 Nov 2025 19:22:26 +0000
Message-ID: <20251119192236.2527305-14-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c4549e4-edc1-4946-2675-08de27a112c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ccvbuWS4PzTypU+ZSYz5pDDuHVUVNTJQFzkLhoLnO7hwTQIXF76Dn6IQrncw?=
 =?us-ascii?Q?pf5pR+8pOdBifQBLZusNaLec4kS6Lu9AQqhL7kvJ1gSGH9KaGUqF9vpIuoSg?=
 =?us-ascii?Q?7XPFYA3JUbRRo0O0dsu7j25FKuyzZAwesq2066mL3fcL1g7wjO0ZonN6yoy9?=
 =?us-ascii?Q?jNShzi3tU5OoqLHsgdQzOsxp6HWOH79LtwRKTU2s1IZvOmiPbcZRC47D8iwe?=
 =?us-ascii?Q?+D5sgORwXD7fhscjgSrJGIbyWrNrniAgxBaSw3vbdqDdIN0e0IaJeVCnYzo5?=
 =?us-ascii?Q?DHrTGU3RBiS5yk8hkxS0O06Kee6qmV0bpDphaNrD6IsvtgYmCjcxm1y/Wfaq?=
 =?us-ascii?Q?RQ09b94E2VLazY2Qwy6yyNEN5dG6FYpk3lP5PdDSUcxfLQHPw8dyqdj6VcQi?=
 =?us-ascii?Q?5umrsnHkhWKv5SLWg8rPpZhbkPwRf3viXiurpgFIGe0A4JjczSaxZJ4hPrBR?=
 =?us-ascii?Q?lnlFAQv16SDRUX2B7i7yqHMJKFJu/9ZrPyI4ATRsRKU14q3hXd1EGCDCfL2K?=
 =?us-ascii?Q?6+Pacs0XgyO0d3QjaLiN8zIeBvM2gzP/GuLtslYwzTDSlkv75auobUv2bJUi?=
 =?us-ascii?Q?89Z+6bdKrMlGv2/pcYLhJNOXB+VrKOFW1Z2CwMnMH4RI7tMyaYzg/POzK8d5?=
 =?us-ascii?Q?GEXR3WleVltD18p/h4bx9Gk7rWepY0CTTWnt2N9lql+q32J6S8l8hfJHsD09?=
 =?us-ascii?Q?xceMP9OllvANGk0fNNum6FkQqMaYHlXYAYvBLrGWPEaMPiOvYawj/LftUpNH?=
 =?us-ascii?Q?AhXMkWSUM4/m+URYF6hINBka6xX+6GOH3gZUWj+mwx3xiUaWtZK/FtLZDxfs?=
 =?us-ascii?Q?+O6RMp5eny3G2auprtBW6U1pVNIQg44BjNyDjp7cgoRjKqRYUASXZrAGxNIS?=
 =?us-ascii?Q?18j7yXs923Y5/aV1/Oq14CeDMZ9iOc60nBhp7/QLJvcpagAKtGo5QzakvPtD?=
 =?us-ascii?Q?vtZlF0rVTRVQi8LMsjDhgBesE1PCDMBwREb8EUdY6Eue8XQsoo87/rbtyAf/?=
 =?us-ascii?Q?GR4loRO1Vp2e4C02nnAZSSvdV+XY+iZ8j46IADvkC3toPpzkfXZ5cDuF6B9Y?=
 =?us-ascii?Q?OX6q1HAebjjVz9hYAg13NV1WRqewJJWApUYDMUk2LyMcjAWgJXps5V2w5sKJ?=
 =?us-ascii?Q?9RzkZH9WmcVD5LSetACxMeJEyIvUxY3ZU9+KXFodwDnOfa+bLgeQEjUq9YZN?=
 =?us-ascii?Q?GKUcFgJIjxDDLPiMytGv1Yt+0nGuLBONhTocG8j4knPoTo50CbeJcLWeS8hb?=
 =?us-ascii?Q?2OGbfNDWY3FVu1mVw+KMoeqs2TaG0JZFiRxWf2a0Q1ox+FBhFC+1KiMCNMs3?=
 =?us-ascii?Q?tDboeVGyH5yMJsNCi7R1aVeUVYi+qjyOoLWy4qTSEF5Hm0Su7ABXEVW6j58y?=
 =?us-ascii?Q?Es7VayS0oZC/fUnvWy+GIErlELYR8SpA/Q1SahFX0+forhxA0MI4fR1ly4zA?=
 =?us-ascii?Q?QBjE0eJgNA2sCZZRj5DdtouwCVl5dhCVRUcDvWlf8Cf1ebk0SYJEwrY8NbRq?=
 =?us-ascii?Q?d16vm2pDqjIjxWYpS30wV2hKC32euOlxSpKaQU1kaHljJAwTazLAKguNnIXv?=
 =?us-ascii?Q?0S+wZZ3nQT/IpEQ+99w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:23:09.0474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4549e4-edc1-4946-2675-08de27a112c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting HPA (Host Physical Address) to use from a
CXL root decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/cxl.h                  | 15 ---------------
 drivers/net/ethernet/sfc/Kconfig   |  1 +
 drivers/net/ethernet/sfc/efx_cxl.c | 20 ++++++++++++++++++++
 include/cxl/cxl.h                  | 14 ++++++++++++++
 4 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 78845e0e3e4f..5441a296c351 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -220,21 +220,6 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
 
-/*
- * cxl_decoder flags that define the type of memory / devices this
- * decoder supports as well as configuration lock status See "CXL 2.0
- * 8.2.5.12.7 CXL HDM Decoder 0 Control Register" for details.
- * Additionally indicate whether decoder settings were autodetected,
- * user customized.
- */
-#define CXL_DECODER_F_RAM   BIT(0)
-#define CXL_DECODER_F_PMEM  BIT(1)
-#define CXL_DECODER_F_TYPE2 BIT(2)
-#define CXL_DECODER_F_TYPE3 BIT(3)
-#define CXL_DECODER_F_LOCK  BIT(4)
-#define CXL_DECODER_F_ENABLE    BIT(5)
-#define CXL_DECODER_F_MASK  GENMASK(5, 0)
-
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
 	CXL_DECODER_HOSTONLYMEM = 3,
diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index 979f2801e2a8..e959d9b4f4ce 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -69,6 +69,7 @@ config SFC_MCDI_LOGGING
 config SFC_CXL
 	bool "Solarflare SFC9100-family CXL support"
 	depends on SFC && CXL_BUS >= SFC
+	depends on CXL_REGION
 	default SFC
 	help
 	  This enables SFC CXL support if the kernel is configuring CXL for
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index f6eda93e67e2..d7c34c978434 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 {
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
+	resource_size_t max_size;
 	struct efx_cxl *cxl;
 	u16 dvsec;
 	int rc;
@@ -90,6 +91,23 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return PTR_ERR(cxl->cxlmd);
 	}
 
+	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
+					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
+					   &max_size);
+
+	if (IS_ERR(cxl->cxlrd)) {
+		dev_err(&pci_dev->dev, "cxl_get_hpa_freespace failed\n");
+		return PTR_ERR(cxl->cxlrd);
+	}
+
+	if (max_size < EFX_CTPIO_BUFFER_SIZE) {
+		dev_err(&pci_dev->dev,
+			"%s: not enough free HPA space %pap < %u\n",
+			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
+		cxl_put_root_decoder(cxl->cxlrd);
+		return -ENOSPC;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -97,6 +115,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
+	if (probe_data->cxl)
+		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 }
 
 MODULE_IMPORT_NS("CXL");
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 2ec514c77021..2966b95e80a6 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -153,6 +153,20 @@ struct cxl_dpa_partition {
 
 #define CXL_NR_PARTITIONS_MAX 2
 
+/*
+ * cxl_decoder flags that define the type of memory / devices this
+ * decoder supports as well as configuration lock status See "CXL 2.0
+ * 8.2.5.12.7 CXL HDM Decoder 0 Control Register" for details.
+ * Additionally indicate whether decoder settings were autodetected,
+ * user customized.
+ */
+#define CXL_DECODER_F_RAM   BIT(0)
+#define CXL_DECODER_F_PMEM  BIT(1)
+#define CXL_DECODER_F_TYPE2 BIT(2)
+#define CXL_DECODER_F_TYPE3 BIT(3)
+#define CXL_DECODER_F_LOCK  BIT(4)
+#define CXL_DECODER_F_ENABLE    BIT(5)
+
 struct cxl_memdev_ops {
 	int (*probe)(struct cxl_memdev *cxlmd);
 };
-- 
2.34.1


