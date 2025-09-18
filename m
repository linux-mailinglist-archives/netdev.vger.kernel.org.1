Return-Path: <netdev+bounces-224326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA85B83BE6
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29870540849
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982EF302CD7;
	Thu, 18 Sep 2025 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vsMHRybD"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A6302157;
	Thu, 18 Sep 2025 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187115; cv=fail; b=jnyU4OITOjRD/LtDwTbZX+a2aFNbhzi7Pp7QPrgObESm3Va3GSlA1H+UGXXhdwVNP2rRxssaLGzcaHcSPyFYALoPsyKomMm8Cp1iA6UBSLhWVqZj9Vko5mzu4O869HvdB8LG0Zb51q7ixmZyhRihbC0tErixr/nMhxSQtuzA4mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187115; c=relaxed/simple;
	bh=fUhTqNsjyyx8HVi2rPQosqmaOMz4e8d1V2LUkNh8mBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PA9dEjvUjtfai5ltQYkd+P7tZK4Z7rgjpgA+47q80OidV5Yxhjjsqx+n1sg3c/h9Sfjfd5JnQy8cNTtLSINPwc6gTaK27AZcBWDpdGrGxBvZRNFpjAAH3BV8sj+TmfOxDvloagM8Bw6T6FuNxmrSmCJnmol1YJVlGbEARwHZ0es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vsMHRybD; arc=fail smtp.client-ip=40.107.208.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reCMGL5ctTXrPAVnsZcxhz9pxaOA0mloxFUexdiwp2k5pkahRXE//eLCEbpnWfFOspRpouyt39160WCNaroCxR2+UBcPgDWRcpM9Q0/gl1AH0jZKcyG8VfSjNPBNGGsUwZMP/F5NiiXC2qX/ktcxdrOB/+uiJ7sWDCdpSz4JPq/shYkh42j2mm3rnyzL+pAN+NfAXgAHLznvSAIP5BCCR+ddgLo+SBWZkQ6zrqlSe/zg387lq4c4J/2cUI6lwB1CE9xKNxgqWHdStVKl9qj9VjiB1sDcQTpZYDpkI7d3M3OBIzqrRq0aQ5caSv+HyxRsGJ9ovnvDWTvJd/fgaFybEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2laThSXXLYugFLxCElEPnnGehTAWj1Zpe1OPWf7Iqc=;
 b=JLLNRcytAxjCX3JgCZhZoGq4myDvBzSryPxaBhAD5ZKiET0E+Dln2zFl0CtzQPWI++qn88Hrd/3ZNyZFbUtMGgzEgZgwoDrVSC+N8xv4WRT+ibj1z1W44KaKQILS5MALfeN3n3fqSogvaT/+fiPKznfvhadF2knGl4KIA++TkpirrRY2+yQ4c9a+/KOj/P4Nibik/rbpAGDDiToNtTXxXxctldGcxuEoZfCCUscXthkVCAnvEGEemnGC4U3+lqTgcqKG7Yb1nKizMFUY0XNk0+DioEtxrE54aJuU+AspaB+K8B8kkame/xdqWbGCXDZxZ/NjPffvTEH/S0R9MqHN+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2laThSXXLYugFLxCElEPnnGehTAWj1Zpe1OPWf7Iqc=;
 b=vsMHRybDBY+sOQ32Q8p6CVfFjoF9s0vuLFbTg5IL8C5z8fy9wBmQnjIPpO/Qh4s6CjiPqyHwe/pHL1GUC1CE4tSP4AyZzmHmhPK+ZoZcTNK27r8CakhAfePkO7PfM0teSRqN2CLCdNPZEqT56XLbzeJI7k/rVvigKLJHnZ4RZ0k=
Received: from SN7P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::29)
 by CH8PR12MB9816.namprd12.prod.outlook.com (2603:10b6:610:262::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 09:18:30 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::62) by SN7P222CA0015.outlook.office365.com
 (2603:10b6:806:124::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 09:18:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 09:18:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:16 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:18:15 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v18 10/20] sfc: get root decoder
Date: Thu, 18 Sep 2025 10:17:36 +0100
Message-ID: <20250918091746.2034285-11-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|CH8PR12MB9816:EE_
X-MS-Office365-Filtering-Correlation-Id: e6dc1e7a-2f3d-4a42-5aeb-08ddf6945534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F2RzCabfVgo702I+ph1wSShBBVe3njxFOBpiU3Xl7FRrNcOp9KM0RYumvjPu?=
 =?us-ascii?Q?5z6ZM8yiYoVy1gKox/54xN2JAAgE9EZwMJATcc2ZS8wY05hKhJwYY6Zp02Kj?=
 =?us-ascii?Q?fajG0yFPe3uofWnp0QcoTGhVoJLv4hgNm1Ivm8VKGrQPddS+HN4g6X+SO3ob?=
 =?us-ascii?Q?+C2Q5X5q0cbmBdPIvMp1Fg6MBcFtXkx/jshUNVCRzpPNnOtVY2eE95jxe5wG?=
 =?us-ascii?Q?gC7zJbaeNmQJ7YF1Jm2mwIbA+u210XWfFNEKU4/STn3iEQ1KWbrr+gcl93b8?=
 =?us-ascii?Q?VKim8vhrm6BArnPgYoJnsECuyxYmEb82kB3dy3CUW5ugqo2FWvWqL7dzKU+p?=
 =?us-ascii?Q?5pQVkQqA1pjunY3ieciGHKFMF+r9ZlNEI1xlt/XnU1aIvas6DTwC5bRXdLSF?=
 =?us-ascii?Q?Qi96UvkWdjxyWXO+OKgF3/Et5TT/Wlv7lK1GXgSZgDpdMqru2U09bF8gQJb3?=
 =?us-ascii?Q?0Dvnklm/T3zUlvx8JkQuaXeGy1cueWbiU8r/6AboSfX+ZymgityodIwQTI1V?=
 =?us-ascii?Q?yfz9gXpOtjfW3NYycyiTfbj9nkyn9E5b003Y0BFT+jZjn6Id37HIpQsTJLCU?=
 =?us-ascii?Q?w/IFlJBL8Qvh/ctmkl1cLjoa43+yfLZN0aDi3VPI26+kD7C5q8LD6dq9Ajf8?=
 =?us-ascii?Q?2nvtE6oikge08jV/tq8EY6gMqahXSCK8dkex43yxUOUb2O8bsP335sIOSZwW?=
 =?us-ascii?Q?XTdvvOmi2gqEh3zlMx+zJki1TtwcG4AUFULQ84x2qZNcW9ghZDRSit6DAcnY?=
 =?us-ascii?Q?pUb58lBxkZX5QgWTg0/m2J9eQioZQZFWhbwwLbta5tNLlSzeg8TyCeSX3xQP?=
 =?us-ascii?Q?Q/o6XB5j2DyvRCyJdjbktqYr967F7prHfHcDyEwAORd2M5zXQiL6FbtGd9NI?=
 =?us-ascii?Q?MebEunsBBxvBw34cSrAsRK8Er9DwxIhv8LrmwaqwqX1/TB0caE+XB/mGOXzv?=
 =?us-ascii?Q?xmSqTupJLhrbZ15mVJTvl3KObXwM/0v46fNsWiraXHNbeSxoPOYLYGCm4q7H?=
 =?us-ascii?Q?a/L5oL/VkieEj5zW1EUSij5Wpg3hJEoqIab7JL9mrpz8okKihHeU+M7cPPhI?=
 =?us-ascii?Q?Nnl41UWdvnMM3mzU2vG1ffyHsPqwoLjUGwXgPqCV/MjoqSwLJ6OLd0z74qdF?=
 =?us-ascii?Q?uI4zd8AFPb08s0yR2del1phe64HqaQYBOym/FhQaSW1u/lcVbmzrZlF1lOVL?=
 =?us-ascii?Q?64jkDzdRm+DJWU7gWYY3pI5WoD65jaAVxriMpHfxJ+rCz3GE+AqO6uKmkBzO?=
 =?us-ascii?Q?U7OthZXQHXh8QLakqYSHfYphFMRUM4Il5tLQ5tys3aFh6X9mkasJHxnSJxUw?=
 =?us-ascii?Q?UG6c0NGhM60zG7awGfapJ9cnzuMtmfSIq+JCgjpGXqEr4fal4mqTkv+zG+wU?=
 =?us-ascii?Q?wB+T6+WYSTtm5CkrznS1zYsGMXegB62+HU5sD3Iqyt+qA8QcTm2ZcdTfoIJk?=
 =?us-ascii?Q?o6f+pJKl3FZoxQ+xi6i+l4vLpO3nXvA2Lu1X8XHN21nJ383M07uk68TAHSWf?=
 =?us-ascii?Q?zeO/G3f9nZAhet/ni0Bw855GuABW/bjEx60r?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:30.0955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6dc1e7a-2f3d-4a42-5aeb-08ddf6945534
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9816

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting HPA (Host Physical Address) to use from a
CXL root decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/cxl.h                  | 15 ---------------
 drivers/net/ethernet/sfc/Kconfig   |  1 +
 drivers/net/ethernet/sfc/efx_cxl.c | 27 +++++++++++++++++++++++++++
 include/cxl/cxl.h                  | 14 ++++++++++++++
 4 files changed, 42 insertions(+), 15 deletions(-)

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
index 177c60b269d6..d29594e71027 100644
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
@@ -88,13 +89,39 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return PTR_ERR(cxl->cxlmd);
 	}
 
+	cxl->endpoint = cxl_acquire_endpoint(cxl->cxlmd);
+	if (IS_ERR(cxl->endpoint))
+		return PTR_ERR(cxl->endpoint);
+
+	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
+					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
+					   &max_size);
+
+	if (IS_ERR(cxl->cxlrd)) {
+		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
+		cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
+		return PTR_ERR(cxl->cxlrd);
+	}
+
+	if (max_size < EFX_CTPIO_BUFFER_SIZE) {
+		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
+			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
+		cxl_put_root_decoder(cxl->cxlrd);
+		cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
+		return -ENOSPC;
+	}
+
 	probe_data->cxl = cxl;
 
+	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
+
 	return 0;
 }
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
+	if (probe_data->cxl)
+		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 }
 
 MODULE_IMPORT_NS("CXL");
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 7722d4190573..788700fb1eb2 100644
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


