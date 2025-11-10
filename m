Return-Path: <netdev+bounces-237235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80DDC47A28
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2199A3AE946
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E42D2EBB84;
	Mon, 10 Nov 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A98NMMk+"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013057.outbound.protection.outlook.com [40.93.196.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24C5274FC1;
	Mon, 10 Nov 2025 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789055; cv=fail; b=id3pgLsjKqRm4il0+YIhRjFapUUfvghZO6QqNe7JZqI8a82byInnQA/C/ZS558ZxaSdL/6Eolw0fN3F6CIkHPewBSy3rWeMYNaSVXBrkmpThHoXFej+4jlCeuGExzMU6tFpsOZfkIXRiJB2iWpNGzane/3cXylHja58pT2FRxgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789055; c=relaxed/simple;
	bh=8EO+YYICOhyFPpXwJktGuLrmZ9QWMra8cSkB3cFVlb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNgM4RVFDV/OV6uuw69fZuYJkNXcOQLGXenPyaBqHubmBfvUr+6KBHjytGLfpAePh6HRGpDIkfsNaWba8bdJeYXImFjCdsZhKZ1SuA8lH2MYeatYZIGQlO6MxsLeB+xlVC+SZ8KQ8iAgOyEzExsorf4MNThsxFlcG/39sEb5z1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A98NMMk+; arc=fail smtp.client-ip=40.93.196.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0xs5YD06Cgf2GNJ9ToaGgFwyVaPXQoqGK9yzdQlqcuk79GgWvDWdN9HflJtgkPzYIjdmV7X4t1PiHgyWxDyD9hljbWxRaEdLHsLe/VZtdZ9jO8kIvQ7EzYHuREvAEpblNDj3GUaAacUtCyOWtrgCO/Y1BPlMjrgAje9VAjKd9k+oZEv51Wk1wBdK1kwQk34yK8TAQrYLr3dPGxOiYqpKY7yBvIno/uhT8vi5Box9EPDQpgHOvBiMhEHZ8KyvbDYzfL80mtOiWyfqhzyHVyTSOJclD0cuwsJko1qgT2Up18SeBclHS9wcBMqU5w7S2wolXoreHoYI1n8gcIryHadiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F6y8TpiQAcm4HKcPk7PaxWy5bVX0SnmEmJUkEjCBEg=;
 b=q8qAC3epN0pP1C7UwHs5/Azdk68Ps9AZ7OtBf9wJHtLk9JcCPQQZ7trDAotveC4U9ugFUOKYNPjxlhnvco9VfCKeXPYQravS1tbnIkqyphoO8WPTj/MGCPC2hveKVgek/B+ko7+LmlMMrkpOPOaC/JMMf3ctR16szXCv7hQiUX7ZxEyONA+ejrhly9Q4q3d9OBixIAd7Ma/dAbc6kwcMlaU4tC8GvdsXOprQPe/IiaPFriOQGmkvGcjBVnZqDqjzqTUsiHYWQEj0mxLIKuLkR1E98tRIhiTX2WS46/zqpI8sfLUaLRVv1Y2LKlMPw2QH9q23iThVKz4Rv38hn7zqug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F6y8TpiQAcm4HKcPk7PaxWy5bVX0SnmEmJUkEjCBEg=;
 b=A98NMMk+kznoQDtUJ3VxbE+eQv4ohhhIQRYD/cGOa3cQXV0ToHYugqEbGrEb+ybWuKHYYAxryrzprqI7UL8KuV/pcbyc2qvIpSnLyr+VtfHnkUFeOAx9/xEiNwdwFod7pAahr++rX387dvwHk1uFWJyaPRUIm1k28lYGSMSdPD0=
Received: from MN0P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::30)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:37:31 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::c0) by MN0P222CA0028.outlook.office365.com
 (2603:10b6:208:531::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:24 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:24 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:23 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v20 12/22] sfc: get root decoder
Date: Mon, 10 Nov 2025 15:36:47 +0000
Message-ID: <20251110153657.2706192-13-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c947c17-6cee-40d8-4f41-08de206f0fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pEmOIp1RxgPQNCyPeEsZsoKFFELjlO8RjGNSFkV0uoZ8FNMbE32G8ZxaTKbn?=
 =?us-ascii?Q?gRF5/2ik1UdMI9UKuWaZg6sBPaucyQIQNDjot0NvF0KNW/G58D5a9LfhB6VF?=
 =?us-ascii?Q?IcUPIisjS5E68nta40bLe9snIA5bOqs/P7CV2e33FWvRrUS2EnJrsKGjxc9h?=
 =?us-ascii?Q?lcvNXE9i+goNN101qEW/89AcGaVkGwsshT1Zu19GopsZurNVke0RgRdaaYgn?=
 =?us-ascii?Q?/nIPxAOaECgCWEGtKQxgWo+bXnUaiWmRmi3IpXRo1AhTWKTNOXTHca/xO/2u?=
 =?us-ascii?Q?AHSuQr/hSPgA0Cw79XVCPyzfsz1cTDRM5NfpqmHCcro2qQqKkdUmVAZ7e/or?=
 =?us-ascii?Q?UATtKkXJacYKA4mVxKaHoAqEKnRQpmwEyG0WahQz+j/ytplF15i6HwrRvivg?=
 =?us-ascii?Q?dQi4m3IQTgFndFtKfGeqH6StrhkMysLmr+nJ+luhuzAEahbPkzznSssaLDrU?=
 =?us-ascii?Q?sOTyU6KTrwbeQhWmbtu6jmoZvWwquySYbFG7MBeZC1VuakKrRZbWlmziq5jL?=
 =?us-ascii?Q?bpilWTeHqVQojqJdmHlAoz3sDzhgmjA8hCZYJ5z53SX34IfILG/FVNgZGgLK?=
 =?us-ascii?Q?e25QtMykno3WMEHELeKdlEZN3K7ir74wC4BhQ48vGXjbdXfN3f7Tg21VtSiy?=
 =?us-ascii?Q?ObQsqjJuFfQCTZVfHuxiur7TtQpRY1j/njY4fmrfZO2YyqMvSr6WYd6te+FV?=
 =?us-ascii?Q?Hn/WjheKPKfvM7toaE22WYSg9B05ioJ0uY1BVOTJwxfZKgcvtLiAcBsjQors?=
 =?us-ascii?Q?d8ywEU9+6tZxCw+uofK7iMS+A0ccc6UWvzNk8JinbkNb9J3elZjOTMDonEzr?=
 =?us-ascii?Q?RjCCd38VQwejtaPs4hIcsE4xPqAls0/TLYodwb4T2e7XlpNSK3lVCWV3Y1Po?=
 =?us-ascii?Q?/5YV3hY8gL/x1TdIR4Cf3htycN69Yp6ZQqasfVxqedkwBBXCdZVckRSmFhEf?=
 =?us-ascii?Q?o8pzxe0GywqTBiOXJtsh6zMAJTPB0AZP5B5m/qzeaOGgxp7RZFU+Lq8kPx+v?=
 =?us-ascii?Q?bYK8NsMg1hkCtzCVYl/YkYkSgecpfnfxYg4t+nI58ZQQeHy0Os0756KG2+A9?=
 =?us-ascii?Q?Pkih3PYn9R9v3PodUglBNtUWuC164bAKv/BdG83KyWJYUJKmnxEY8kln0IfW?=
 =?us-ascii?Q?VIizkgsDb14a6Ua4piPZmEIP0MnwKG821W5WAlK74ulJ916SmjB25KkcuFkD?=
 =?us-ascii?Q?XfoxH6tuCfcuc/TCjHYBxzbmbt9a4iBjRKdoV0xqKfU9ivWu5/NIWcowKPLz?=
 =?us-ascii?Q?BF9Tb2syHo72s3faDsf6KVnzVtxyTtsBzOT0yvxHFzRq+DAi2EOjeKoXGROA?=
 =?us-ascii?Q?dRbRKFJpDN0Wy4fMDSf3lpHj7tQ0S9F2EYKMDO1Opon2Rdgdy96X3T8HpKyW?=
 =?us-ascii?Q?Fr4aQSIeVgsUw+12D3G9rBMMFQH7oLB8k0vSu5HREhWyJoMJQBbSw2X08eck?=
 =?us-ascii?Q?bsjjaBCZOddpjdJR00ptlKDQ0UmiN8f49/Y6AIuHPB5YCNPmc5WEl5JhvbDD?=
 =?us-ascii?Q?qskOWITFW5puUs6n4g+jNhQD2mkL2vx1J39l0OWH5zsD/5c1WY2dXC2OiYth?=
 =?us-ascii?Q?7tr47YzCSwPjsybbtgc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:31.1777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c947c17-6cee-40d8-4f41-08de206f0fd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495

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


