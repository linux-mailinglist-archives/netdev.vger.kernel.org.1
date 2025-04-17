Return-Path: <netdev+bounces-183936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30677A92CB4
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3F44484B6
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BB22222C1;
	Thu, 17 Apr 2025 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qklV8+QA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F46204C0C;
	Thu, 17 Apr 2025 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925417; cv=fail; b=nuFaM9Xq/pg9lSG3vAiJeMmMu1W4M/a1YqgxYli9fwpHp9Mk3dUj6QqNV/yBL3llgYF+/Azb2pcs7OzoullyBp9pUw3TdVq7Y5o/8v8A3nb9OsADkJq0vNILTeho2g45fO6ai8rIgxNPnoKW7C7UXAuDuAKm51FcZwzoavyAmvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925417; c=relaxed/simple;
	bh=CQvToMn0Hkj45sUdPWqmW0TXZcMWaxNTXQA8DGudPck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvBc2swOsAhlILXSY0GTDPY9Ue5EbLsLgLn+N9/Btz7Nv5ziT96tnqSbm/FWu8aK4gsB/gfMAgY7P7rDoUWl1YwjC/f1CMRFiaIesRsGX7cY9tgnl5LsQ9An3vVWisjMhNgUHbfni4SWCNy54vYEfu/7bYlJPJc+qlPDHK3NYGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qklV8+QA; arc=fail smtp.client-ip=40.107.95.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZlO/pw+rcWBi4gdHlkF3YmTgcFQC0b2pZuAYuHoQIDs7WD6zBJGj1+tfhUnhYyaTpAcDT74m3BBDprd9Ppbe+MIytKr+hBhjgzVwhutvORK96E2LRsWq/LwGrso8g5wHSX5tKB4/RrUB4tRSHpYNJXHdF4MdEquwZnlrq1lRC9Y/UlXLuMIClQi5hQ0nueuItg69He6Jhw/odOK1mKhvD/ywLYDieZodve8Y9vZM8fxuF5B4TaO778I4ZlMLs6f1Jtj6oEqaj8MFQ+nUCHV7GpyZKxAGvnFxhKNFCuCP8VbRv03S2ObrKR16qy8TnGWCXwRtQ55yblObgOduvTaUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUoPjnEpEFSYl2Nw8MbPencdCLXzn3lhwPZI0x0O06o=;
 b=wqte5NgBCDPb9+A2jftyCJBtyWArcGEWoOe+nkWDT91ezi/ohOJG7UZFTLxsDP4/0cIk3oA4pX2bXL/jETKOJ/haH9yXrcRLtIhYusRFV9+EVR7RthIxr3reryfL7onMJ8Cnf2JDYFVJuF4OhcoiY1yolKcJ2Z64+6z8tM0tg1fnB4+okzVlGxUNg10M9yh5rWCJ/0EE5wy9wiHDPG+rFwxi2fadYXKIaUK6SmNRsGIA3RdZiYcckh4kXY9MYcZPfEaQo9qLWDHbhv/gKTrCNCAIwxzbKnh4Da884hVVCpvqnKfsfhsTfXTIfKCOfYI8qHjYY5q++lZG9kmrbHOVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUoPjnEpEFSYl2Nw8MbPencdCLXzn3lhwPZI0x0O06o=;
 b=qklV8+QAZBqqcua6b4KNPCUM63Kc9CI9RYL38UhBRWpP/aV6R0zbkug2LPoo+X2zjLFxy7QPXIT8xSgLwU4JIRziSBxKJhWlIsz989Jlgdh/min/SJTKqHf/FZOfnpzY9f/AScqxynMSY778I97fOsExEUIgQJe91+1l5Z5mbPE=
Received: from MN2PR11CA0022.namprd11.prod.outlook.com (2603:10b6:208:23b::27)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.35; Thu, 17 Apr 2025 21:30:11 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::49) by MN2PR11CA0022.outlook.office365.com
 (2603:10b6:208:23b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Thu,
 17 Apr 2025 21:30:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:30:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:30:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:30:09 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:30:08 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v14 22/22] sfc: support pio mapping based on cxl
Date: Thu, 17 Apr 2025 22:29:25 +0100
Message-ID: <20250417212926.1343268-23-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c42b1cf-0642-4084-a8a8-08dd7df70849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K/COiYkAJmP/wjAG3UONHZfHu1mUEeQ+x/7BaLpwjqbiSuStJeTq4qfGfp4q?=
 =?us-ascii?Q?f+sXsWNQ4Q2mmTPujspOS3aNRf1gFwxr8qFwrxwnl+TOvaDWnm1N6ZTcCyxC?=
 =?us-ascii?Q?4f/U3/Lc4Q2+kjQzPyW+qkc8poc78vd7iMRA5Ex/MyxLPASZbmptvkwekaFo?=
 =?us-ascii?Q?/y37J6eu7Fk+TY56Gj29sE1Nw1aYu3GBM/Hp5P7vowrxOhQHkPXjlKZ64yo9?=
 =?us-ascii?Q?GT2qWgFRRUysNUE+HExQCuHlfiHZXguQat8n6WF8g8xY6yBDGEpGQEk2iuPW?=
 =?us-ascii?Q?tPWkDP9glSRBGuD1ipgJRAW05cBNGDf+wx1q1a5fCL1w5l+i2jqH+D/coa2y?=
 =?us-ascii?Q?Cov458mHIxgp+EzziQE1mRwDgKAUcjIGjLLNzmbV0h+CrXsOpfxk7QupR8Rg?=
 =?us-ascii?Q?iNEt5kKvhlQjQrFbMyfoswAt1K4SXyUd+0lRmGrbyv/2BrNaxbbyqYfiMEKM?=
 =?us-ascii?Q?1WJU3az4fjKAY/Kp1YoBcWidtsaBlfqqmW5gJ5V4nc4fUWgHcndXYMGLjQyZ?=
 =?us-ascii?Q?t1yccIAJ32e0uUrFpbC6mQyJMxmezCGXoZV430af4Gzj+bBuL1eBY7t4ZBmp?=
 =?us-ascii?Q?/eL/sr0IunX+3R16SyJFKCTUFEmBEeN6Yyis+bLevyumWE0NzGvo0X+K3CI3?=
 =?us-ascii?Q?JIfUxkvwSdD+t/HgE6Qy8yJDOEdZ+Rx62U/Pxn3Zpw1P/es+4zhNKJDnjUK/?=
 =?us-ascii?Q?QL5keBjIBf4XGUIhE74lSsAzBwPX5J7zUMpmZPZm/t2ed1s3H/dBKlTiOwoZ?=
 =?us-ascii?Q?i0xO/zRGjBfMbLpzBt0eh5RyulaZA6AxIDGnl7pTLmAFii3kG/kE5l97sMDh?=
 =?us-ascii?Q?zY3RnNQLH4rTD6m3FvVIFUeqTtEhuUIEny5V1kiln018W1dpTZxEdOh4o9AQ?=
 =?us-ascii?Q?8jW87NzKBmgwx8B8+KU2cQQ9M925xtYQxSmHTjknGaTQ9lMKE9xKtWa81Zc0?=
 =?us-ascii?Q?UbCqibk2IUnjPu1vdD94Y5aW/uxvOgE2UC2pGYQZhoLw9y9XzCtOAm6K2PPb?=
 =?us-ascii?Q?KF0QRtF84bHbMjrir3lO042Xcq2sKM8seJbpiQ7aS6A0CS4Mvh26/aHcHCrt?=
 =?us-ascii?Q?sOlQYc3uw/oHJfnhVYk5ErSJVccHuH4YQrTiWKrdE1A9No6uH77q6cK9LkNN?=
 =?us-ascii?Q?Gc+FSh+EUQVZRi0/gpmEVNSSgaM/RYQJg315dI9YOF9DxeqFDb3PzM9rIJvh?=
 =?us-ascii?Q?sjO6/tl57kSmdyqt7xdwALo20YauuD8eGu9oS3CaIEfLzW11TcJ7nnVPB6Ke?=
 =?us-ascii?Q?1Ua8kszi00X25i6X4zC+JMrgpEgDjHnr+gFKqLSLXjFRMAmBd8KNZVSieQs7?=
 =?us-ascii?Q?MU5VKOen0D+Dq7CUIYbvgrJIjWyc9iTOQMtH4dE1Y9QDDONlHp7YEjYvzKyN?=
 =?us-ascii?Q?qAmZzg2q2e/VbQf84bQsM5Hrr+zGamE2E/waSD/tKSBHrYnW+pc3DDNuDikw?=
 =?us-ascii?Q?Oj1TB0+NpkfKDwyW5XzvH4cs8D2PDJHtNZIF0L/xI+wQiC60dpIJtRmOmUMJ?=
 =?us-ascii?Q?IyNXOgBMfRqfpI39EGOaqnd+MQecbLTIZDAV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:30:10.5480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c42b1cf-0642-4084-a8a8-08dd7df70849
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820

From: Alejandro Lucero <alucerop@amd.com>

With a device supporting CXL and successfully initialised, use the cxl
region to map the memory range and use this mapping for PIO buffers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/ef10.c       | 50 +++++++++++++++++++++++----
 drivers/net/ethernet/sfc/efx_cxl.c    | 18 ++++++++++
 drivers/net/ethernet/sfc/net_driver.h |  2 ++
 drivers/net/ethernet/sfc/nic.h        |  3 ++
 4 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 47349c148c0c..1a13fdbbc1b3 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -24,6 +24,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <net/udp_tunnel.h>
+#include "efx_cxl.h"
 
 /* Hardware control for EF10 architecture including 'Huntington'. */
 
@@ -106,7 +107,7 @@ static int efx_ef10_get_vf_index(struct efx_nic *efx)
 
 static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
 {
-	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V4_OUT_LEN);
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V7_OUT_LEN);
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
 	size_t outlen;
 	int rc;
@@ -177,6 +178,12 @@ static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
 			  efx->num_mac_stats);
 	}
 
+	if (outlen < MC_CMD_GET_CAPABILITIES_V7_OUT_LEN)
+		nic_data->datapath_caps3 = 0;
+	else
+		nic_data->datapath_caps3 = MCDI_DWORD(outbuf,
+						      GET_CAPABILITIES_V7_OUT_FLAGS3);
+
 	return 0;
 }
 
@@ -919,6 +926,9 @@ static void efx_ef10_forget_old_piobufs(struct efx_nic *efx)
 static void efx_ef10_remove(struct efx_nic *efx)
 {
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
+#ifdef CONFIG_SFC_CXL
+	struct efx_probe_data *probe_data;
+#endif
 	int rc;
 
 #ifdef CONFIG_SFC_SRIOV
@@ -949,7 +959,12 @@ static void efx_ef10_remove(struct efx_nic *efx)
 
 	efx_mcdi_rx_free_indir_table(efx);
 
+#ifdef CONFIG_SFC_CXL
+	probe_data = container_of(efx, struct efx_probe_data, efx);
+	if (nic_data->wc_membase && !probe_data->cxl_pio_in_use)
+#else
 	if (nic_data->wc_membase)
+#endif
 		iounmap(nic_data->wc_membase);
 
 	rc = efx_mcdi_free_vis(efx);
@@ -1140,6 +1155,9 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
 	unsigned int channel_vis, pio_write_vi_base, max_vis;
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
 	unsigned int uc_mem_map_size, wc_mem_map_size;
+#ifdef CONFIG_SFC_CXL
+	struct efx_probe_data *probe_data;
+#endif
 	void __iomem *membase;
 	int rc;
 
@@ -1263,8 +1281,25 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
 	iounmap(efx->membase);
 	efx->membase = membase;
 
-	/* Set up the WC mapping if needed */
-	if (wc_mem_map_size) {
+	if (!wc_mem_map_size)
+		goto skip_pio;
+
+	/* Set up the WC mapping */
+
+#ifdef CONFIG_SFC_CXL
+	probe_data = container_of(efx, struct efx_probe_data, efx);
+	if ((nic_data->datapath_caps3 &
+	    (1 << MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN)) &&
+	    probe_data->cxl_pio_initialised) {
+		/* Using PIO through CXL mapping? */
+		nic_data->pio_write_base = probe_data->cxl->ctpio_cxl +
+					   (pio_write_vi_base * efx->vi_stride +
+					    ER_DZ_TX_PIOBUF - uc_mem_map_size);
+		probe_data->cxl_pio_in_use = true;
+	} else
+#endif
+	{
+		/* Using legacy PIO BAR mapping */
 		nic_data->wc_membase = ioremap_wc(efx->membase_phys +
 						  uc_mem_map_size,
 						  wc_mem_map_size);
@@ -1279,12 +1314,13 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
 			nic_data->wc_membase +
 			(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
 			 uc_mem_map_size);
-
-		rc = efx_ef10_link_piobufs(efx);
-		if (rc)
-			efx_ef10_free_piobufs(efx);
 	}
 
+	rc = efx_ef10_link_piobufs(efx);
+	if (rc)
+		efx_ef10_free_piobufs(efx);
+
+skip_pio:
 	netif_dbg(efx, probe, efx->net_dev,
 		  "memory BAR at %pa (virtual %p+%x UC, %p+%x WC)\n",
 		  &efx->membase_phys, efx->membase, uc_mem_map_size,
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 4323f1243f7c..95c543c06f27 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -28,6 +28,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	};
 	resource_size_t max_size;
 	struct efx_cxl *cxl;
+	struct range range;
 	u16 dvsec;
 	int rc;
 
@@ -118,10 +119,26 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err_region;
 	}
 
+	rc = cxl_get_region_range(cxl->efx_region, &range);
+	if (rc) {
+		pci_err(pci_dev, "CXL getting regions params failed");
+		goto err_region_params;
+	}
+
+	cxl->ctpio_cxl = ioremap(range.start, range.end - range.start + 1);
+	if (!cxl->ctpio_cxl) {
+		pci_err(pci_dev, "CXL ioremap region (%pra) pfailed", &range);
+		rc = -ENOMEM;
+		goto err_region_params;
+	}
+
 	probe_data->cxl = cxl;
+	probe_data->cxl_pio_initialised = true;
 
 	return 0;
 
+err_region_params:
+	cxl_accel_region_detach(cxl->cxled);
 err_region:
 	cxl_dpa_free(cxl->cxled);
 sfc_put_decoder:
@@ -132,6 +149,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		iounmap(probe_data->cxl->ctpio_cxl);
 		cxl_accel_region_detach(probe_data->cxl->cxled);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 0e685b8a9980..894b62d6ada9 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1209,6 +1209,7 @@ struct efx_cxl;
  * @efx: Efx NIC details
  * @cxl: details of related cxl objects
  * @cxl_pio_initialised: cxl initialization outcome.
+ * @cxl_pio_in_use: PIO using CXL mapping
  */
 struct efx_probe_data {
 	struct pci_dev *pci_dev;
@@ -1216,6 +1217,7 @@ struct efx_probe_data {
 #ifdef CONFIG_SFC_CXL
 	struct efx_cxl *cxl;
 	bool cxl_pio_initialised;
+	bool cxl_pio_in_use;
 #endif
 };
 
diff --git a/drivers/net/ethernet/sfc/nic.h b/drivers/net/ethernet/sfc/nic.h
index 9fa5c4c713ab..c87cc9214690 100644
--- a/drivers/net/ethernet/sfc/nic.h
+++ b/drivers/net/ethernet/sfc/nic.h
@@ -152,6 +152,8 @@ enum {
  *	%MC_CMD_GET_CAPABILITIES response)
  * @datapath_caps2: Further Capabilities of datapath firmware (FLAGS2 field of
  * %MC_CMD_GET_CAPABILITIES response)
+ * @datapath_caps3: Further Capabilities of datapath firmware (FLAGS3 field of
+ * %MC_CMD_GET_CAPABILITIES response)
  * @rx_dpcpu_fw_id: Firmware ID of the RxDPCPU
  * @tx_dpcpu_fw_id: Firmware ID of the TxDPCPU
  * @must_probe_vswitching: Flag: vswitching has yet to be setup after MC reboot
@@ -186,6 +188,7 @@ struct efx_ef10_nic_data {
 	bool must_check_datapath_caps;
 	u32 datapath_caps;
 	u32 datapath_caps2;
+	u32 datapath_caps3;
 	unsigned int rx_dpcpu_fw_id;
 	unsigned int tx_dpcpu_fw_id;
 	bool must_probe_vswitching;
-- 
2.34.1


