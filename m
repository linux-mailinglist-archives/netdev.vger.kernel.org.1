Return-Path: <netdev+bounces-227926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8ACBBD951
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF974349CDF
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C1021FF33;
	Mon,  6 Oct 2025 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NzkvaJj1"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D676A21D585;
	Mon,  6 Oct 2025 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745043; cv=fail; b=RI8LyqRGm0vnZDE9BExDe+i+j3Ix7TBybgh3/GRYp/PR1MZfJBJCM8LkY93I7/JeQxHVZaQtT8W+bEDHfzoA9/kilafqA1nS0GmMW9OL4Nprh5mQ8ea+aoFby61ytRNYdjmxuAtQ9KpheEOpcbD0GLhbZUfcT7VHJ8bh8reg5vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745043; c=relaxed/simple;
	bh=xUAy7x61+RmjVN6vCxoHYd1v0qtKS8MhO/04QaQ6/OQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ob8ZDBhaIxFVbu6E9P4ESryS0Gz3flpxcNEKOQWjlfxfH/YfonPsLhWP6cmYj9X/zy5IJiJjHuhXMlrs+0fJwI3UI2b1ijsFEnxUVsLfGLI5Xua3w8llBixpulo3n9kMNg3mnnfbA2PnPujuK9kgf3zlOnuXKOhFUQ1us2wqhDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NzkvaJj1; arc=fail smtp.client-ip=52.101.61.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSwg1MyZpevIMGHeUUu5vyYxNrJjm8zTl3dDG63iYerUSyRxt6GtEMoc9KxLVRfQ8u0t30ZERK2R9St7M+yiG3e3fp+J2ODACAnQT1NqUiexQ0V2R5DGbtPmR1X2bPIf0G1B2Y1qdWVrG8GhTtjOpwUul9NM0t29XOZOLi+X6zkARws7+vlRV4F8TLKDuWorByDVUOxew7bd/mUhNBz120vdOWfgBWgfeBRtOaUHwh6NaYCULaazubI651qY/aodcSOnrOrlLZEH/aiCaw+14MndPlB1bpOoFGx9GmaUPZB8WEQa5O/rNqAnXaX88pE4GrLzh1R015gkyf8PzLQdUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54klePKt9XgKQiEizEfhVYVJShZIQ8pFlPBk4cuCr6o=;
 b=C7zF6o3lEnB91hxgKrJq21VijCHYpe05mBFR2JiF260a4RxJupuMcJHCSCgJ7r/ASOPjq4RauI3XfchPKIjnLyR8vQpgFW3dL388rqKuKIFB37rYXon0FXK+cmiqGLNeizw4X4knMpiRl03lmls2p3VcMw8D1KdGL6ah7oReEgL7kAe3xjOY4Hpl9vBzM4BfmCEa071mIb/dAD5FF7vTFESXg/cY2/Oj6lIf3OpBjOXKut5PzAu3YWjDTgsXIIOKBrLV21J8dWsDfB678HvtZl6IWfPEwcaIX2ERphAvvfTLXLVSh4ZgH6d5t6x9ty6X0xwpmILLoB2NZa9QibzgGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54klePKt9XgKQiEizEfhVYVJShZIQ8pFlPBk4cuCr6o=;
 b=NzkvaJj1TGR4zMpwQHkGsjAc2MtwheHzf9yWe46AGyw3DW/DiX2HEBPYTD1qljCCtgQFLeEu3HvRIeZpwnrzB6/0HecxOXbAPPdJNqNFf8nkgPgPpozNrCQpCZO7LsbbT+cpdoNuUbeHjO26H+AKVa6aGNUxLflArsypG4x1uP4=
Received: from CH5PR04CA0022.namprd04.prod.outlook.com (2603:10b6:610:1f4::19)
 by LV9PR12MB9782.namprd12.prod.outlook.com (2603:10b6:408:2f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:03:55 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::ec) by CH5PR04CA0022.outlook.office365.com
 (2603:10b6:610:1f4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 10:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:03:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 6 Oct
 2025 03:02:26 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Oct
 2025 05:02:26 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:02:25 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v19 12/22] sfc: get root decoder
Date: Mon, 6 Oct 2025 11:01:20 +0100
Message-ID: <20251006100130.2623388-13-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|LV9PR12MB9782:EE_
X-MS-Office365-Filtering-Correlation-Id: f515325f-9d24-4b71-8c18-08de04bfa903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7TmhDB76LG9IKJR92CVKVGT19ONezj0IyQw0kvjfOgbQCGEvy9uLCmbk5HLQ?=
 =?us-ascii?Q?q10iWvtHFSe4VbL9q+wfi5nPIW2G0sPb4uExaDjc7FDjMuXT7PAAGOjs5faX?=
 =?us-ascii?Q?Lu/aUrJVui6GaJRPwVSjXosM6RnaHvw4jQS/TpsAxIEVG6rMraFA+djLrSgU?=
 =?us-ascii?Q?8R8klFJW/EaD6Mq9EUhIdB6UJ85N5D3XgxZsW1+zZzvIyevHpuDlV2Oc8+qb?=
 =?us-ascii?Q?oAlhW5FOAZKyN1H1kLBaBe4IwRc2KiVTDlba+t+ui0s1dEuE7KMOF6QW7/tM?=
 =?us-ascii?Q?KgMWuT/FjlqRHfXjmMi9Vjiq+ZgnL6oMMlnHegBZvbh7Vx2rg9UdtHhlJLkt?=
 =?us-ascii?Q?mfW4dm+/TJ4EFuHn6Me41ehW1obOTO0Rg/NfRF4L5e1xr7CgKcka60wKzCWl?=
 =?us-ascii?Q?iPzu39hCJxRFGJRfGIKiJZoYoZf5IVvOJ9b668OvgZx4sd3PHOnJtXNcGume?=
 =?us-ascii?Q?SXDagT1j8k8GbvNKf6UbdLRITdWPV1YzhlAcFy4oaDnZSBx4qec5pbqIfjB6?=
 =?us-ascii?Q?8lez599lxNXdXOTVvNKCar6GEDfC6ghasAPnNElXhSrcbLPa1CG/rIs2e8L7?=
 =?us-ascii?Q?qtDuce4W1bUsRmB65pWpZaqERpVnQcuFj48NAC28yImhxqD9/bwa0WIG8uNw?=
 =?us-ascii?Q?v8FQPTOcIDHvrRPNBoEOZFeRwr44LpI8njDWgC7FGk0RFr2fZGRWQVeDGGE0?=
 =?us-ascii?Q?eWZc5PDpwwzAE/XkpS754HqWMB7Y3b+zeO8YmDwn71aPhplQ+pk3m8KRHcsu?=
 =?us-ascii?Q?lj8OiDmM4z9P2UnzyAPrWw6a0kQyWmjeh8jHZ2foIoTu3sLmh9Cavig0l2CU?=
 =?us-ascii?Q?whOGqcYJZjVEcd8ML9Zx29kIMyLw+1DKgSPz/9SewnwO3vqI88buRRfFyhOB?=
 =?us-ascii?Q?dfqPtibt9MVm28Z9toAUBdFFhFaxOWWwb44ikMWC9HcCgsY5uCNv/V1lGrLa?=
 =?us-ascii?Q?eJozwtCYvvV1ehLaTScr+wLYWaB1jKUPnA6f7yhxZT12yG9l3Umj8ATVKJ94?=
 =?us-ascii?Q?PU4TmrF0DUaktY8OIjlhLBd2x5tKOiGV/tbmcMAgFBnXFCUEKvRnQjDm52Pr?=
 =?us-ascii?Q?zvezn7oelbxRA8kKzN+KtyKu/c71KFPBNX7XJvYCmqbyYPmM6nffYaf7lu8o?=
 =?us-ascii?Q?75ctLSPrtD+j2vAC1hn6jgFl8M428Kc/4ki13g+BTJfnZmvqwy30SZjFsFVo?=
 =?us-ascii?Q?/aRbx2KwEYlQqNvI43vtIcGieOXUMC2UTjhscP44bMW9+eMuU/D/CL7AFImw?=
 =?us-ascii?Q?9tg3gyA43pKRrfyUX6InF5ldnOchVGp0jVhbNok+KiRWuekiqB/xR3g5BZ1z?=
 =?us-ascii?Q?/hwU1RgBvq3N6Lcvu8tkGjf2jWp05pRSYObWza6X7Pc0vuZUib5NbLbkVjPN?=
 =?us-ascii?Q?cvGqOpAldputEGCnvv0Ep0Lv8p/taHwLzhv7v5K8u6TZOE3Xp5bPxrgt4lIF?=
 =?us-ascii?Q?iVoB1mfsbMG4az0lXKmc/q3CqZEGB53W2BjJrZuRYwqLc56C1lj1guVWup4b?=
 =?us-ascii?Q?Xdm41Eo1uQVZR1DKANTjpZZK4i8szHsQq/Dpq4ORebxh5Wp5anpOPXxfCn2s?=
 =?us-ascii?Q?UGO4AUSL9H9Rcr6/OOE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:03:55.3500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f515325f-9d24-4b71-8c18-08de04bfa903
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9782

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
index 076640e91ee0..ab490b5a9457 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -219,21 +219,6 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
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


