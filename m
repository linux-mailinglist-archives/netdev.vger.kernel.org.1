Return-Path: <netdev+bounces-150359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882E49E9EA5
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 20:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD5B16747A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E827119D072;
	Mon,  9 Dec 2024 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FUG0CJ3H"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A1C18A6B2;
	Mon,  9 Dec 2024 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770528; cv=fail; b=gBY4fg0Q6BZnEY+8nz2QeaEuBYK+eBq+7gMNc5+zAh5KHJuWOkW87iz0HbQoeJYIA87bWMkt6FoVmfoRQc+WxFopV7OW+ULb95z5oWINxUOcytkULseE6VUxTaC19gjxITQQ8EsVD4I9z2Nk/NpDDT89FG9Utj4BK3+p6ggvItE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770528; c=relaxed/simple;
	bh=w22aB/jeB269Hsp8h1i3Iuz0fEU94YnlszUXxp0JCz4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7bemGeh1i//aa/Nh8ZNt/YsS4RmBvsYNOWuGwrHwOwnIXlsRj0BUSOfWmrYkT/1a5tXUtvOiWkv1WVlIFbIkYXV4mXVf/q2kV+uPm29/ATyUa4jAJXNU2Mt58XnngK6Jq5k1NA6n4CWofZPSsoygkm+F0XtRtdAAi+Apu44a9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FUG0CJ3H; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFatrhzmZrkQOko1Q8b4DiNFSdtjqMHZ5ajZW8MmKeEdB8C0V36az6FHaZGOAihy7R8OxUbVQ59DHyaC6las9wVbQAD5seGECuPly2Le10msWrReMFaiG0aaou3cTf8K3oltGZO4NBqkfZw6w0TA274Jb2MnnYmQgokiFeU/ws54yeyzJM3pF+XpN96tB0z/MFNKLJC32Y/ePQYD9C09G1HkphS8URFli4HiMnBS0P6z/71T8WxnICebA1r+JWufoogh6j3Ck3H/8DdNHpKhfjVO/1N/o7TvXnWJXlwqPMAGs2PY0Bap14PB7/K1OkDDdpnGXNbVig7JXAebj3SDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcYRe9foDpJzNuEeMfkMqtUEjEIOjghtRQVA6YW1X4A=;
 b=hZjX6RM9oCNdCRM3nPOm8Qrj257ikzIhruH+RFg8rPT093PvDI/aTjiuXJzI5QI4JBuwTjkSdGVqox8/JJrRCUoK0hp6ipE0pKtey+Q0Ms1uJv3KgqziYITvLluaN8F7N3y+SDke9+PbAUTDSMSNAPXUbO4VGfIenMyXOnHz5EWGLjQlt1wqNvJbJOfq0CdiVyN/n32l9OPudrz8PZXV/4Kay+j2EV8olDNnp75gdEOtciQ7+xHcDJzVyndY3AUUX5LmfyBrhqDcVwVoCg+gm99LMG9839fdsMpgh6b5gS0XTaWySzpuABQGoPw5osxDcaHLqltNPOcD1LuZwRxh0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcYRe9foDpJzNuEeMfkMqtUEjEIOjghtRQVA6YW1X4A=;
 b=FUG0CJ3HJXzjZXPbSqJiW9oxHTIviVk1OWIrf1ssEMJlG1AUEcr8LpphMu7bJKguuwFcZ82rSR+D/O8sOrRlKUCpojfPewZNO0Eeo/NHrL4lW3ZXOcf7OjtTjoI+fGXwAgBlDf2YPVvHmzSRwBZK1Evx+fK/5SA0x/D9gwpmo3s=
Received: from BN0PR10CA0017.namprd10.prod.outlook.com (2603:10b6:408:143::26)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 18:55:22 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:408:143:cafe::3e) by BN0PR10CA0017.outlook.office365.com
 (2603:10b6:408:143::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Mon,
 9 Dec 2024 18:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Mon, 9 Dec 2024 18:55:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:21 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:55:19 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 28/28] sfc: support pio mapping based on cxl
Date: Mon, 9 Dec 2024 18:54:29 +0000
Message-ID: <20241209185429.54054-29-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a2a1d21-efef-431b-6066-08dd18830891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1PRy/eZIw7ztXQ/IVpHQua6yKrceymug8gQHIkMtW9q+RiHgpN0WIDSYJmbx?=
 =?us-ascii?Q?xvc3xi2Li+GqyJQ2dlYP/AwP3pCk9iy1l09pEBJ9iO3KHkKBQ0XhnDS4vRps?=
 =?us-ascii?Q?uxl4nMvpQLYmxm0bEfBao31upJZeI3Bc3m1rVxoDWjxao12+93AWCOBpnbz3?=
 =?us-ascii?Q?DLLxGJRTYm9LmoHJdQtrznNaNtIzIBmJ6af4ztONM29ODxGO8yVtffZHBFit?=
 =?us-ascii?Q?esdPS/nzxyw7/oz0qJZ/pMl0WVkX50OMHmrt53F0vJVlANUejsCxoephXyqL?=
 =?us-ascii?Q?7w6qNPaaiixsVmtvLCJJAyVN554zyLvEPVuufuhecsJ2zfH6KldkjhoGQua8?=
 =?us-ascii?Q?k9PsgPwKqFvtdFR4cxNtYWxTrQNfIpR4u6iGTAaqX/oPYCwtZ2tKS70fas+C?=
 =?us-ascii?Q?tQGG0/8bkH84YteXx3xcCSsIrsm87015r+Op5C3yUJBC/dSKzZWdwwN/hTB6?=
 =?us-ascii?Q?KW6gtoDuV2WpwYqShiZeFttMDdN4w2dqIz3zT60antSZI5LpiSEJd7GWRTex?=
 =?us-ascii?Q?pJuSlbgZRrPnyi5xK16dtBPwWfudPjQm1Q5SelYDS09C7gGb+AUMA9pkNALd?=
 =?us-ascii?Q?u82FV4g13rpfYNISEmkT+xxYYuAqsTuSoHJzpcWUsNE2O8d80dvYOic2XZqG?=
 =?us-ascii?Q?mPVnJbYJVBrN5/2/nWZjuao96e3SVfgkJ2rMT8PHC0/m1HWair873pAJKchB?=
 =?us-ascii?Q?BEf97opoLdq/tFBLKqs1eRCSt8UsSyzNyY6s6DtbXyTCdYLSdn9X4ZJMZl2q?=
 =?us-ascii?Q?YD/Ry4Ui6D0VmJLXkLbdJHieR9fhw1n0SLbIBhMU2ffRoY/Jsx2e74YtmR/3?=
 =?us-ascii?Q?M+QcTTkbpd9HUyGnCAkyvL6krTHPRBbA61v4E9yTBWYkPq+2bbnLlgbvCJUX?=
 =?us-ascii?Q?bjUY3o8eyVglxd9zMHrgvz9r8BF7I9COxyRE1EwS9WOCuNnUFfOGLOUobfq9?=
 =?us-ascii?Q?fm/rZPDqSa1Z16RV8O9D2T9SGzC8UqB1ZKIcnY+IONbvAViOp6goxrDi9xct?=
 =?us-ascii?Q?JHPz3o7WqL2TKJuJmlA9CUuwh/7C0Hogx7RzT4DIv2QUG/GPz1j6tjgP9YX3?=
 =?us-ascii?Q?vXvzVlP5i3/ZgZ/ltFkzFgRr99yhX65KXc25JhEMAIIRGGwISraIkn3FwPCB?=
 =?us-ascii?Q?gYc/cUZzuwXBkQiyNOZZoO5ixkHq7WmKrwMFHfIyARIMCZ3nJ4uM1APkGGIS?=
 =?us-ascii?Q?IrZsLS2weZRPHGaZd7a7nRqbmn1sGYScUz/enGUI22t30Lp98TZ8qyYpGR2s?=
 =?us-ascii?Q?G0/h9OISBIOHL5pTmzqfen8fdpDAIpBq/ZjhKLVPAdRpER5LHtz0Q2ByxEMZ?=
 =?us-ascii?Q?+T2rRV72fekAD5Ob0G4tZ+c7xpgQzsowd404jgwuKQ1aL1EWUVtu40ng7lQp?=
 =?us-ascii?Q?3rh1/1ewfz3dXnYdOFF+8Ib8SLiHa7Wt3bO3q/H2S48D+wWmJ/wpRH27ABAC?=
 =?us-ascii?Q?QD0I+TG0R+Ot6BBuEVyvXu4TJbLjw3Jtq59aeBu25c8ptqigI156ow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:55:21.9381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2a1d21-efef-431b-6066-08dd18830891
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571

From: Alejandro Lucero <alucerop@amd.com>

With a device supporting CXL and successfully initialised, use the cxl
region to map the memory range and use this mapping for PIO buffers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/ef10.c       | 48 +++++++++++++++++++++++----
 drivers/net/ethernet/sfc/efx_cxl.c    | 19 ++++++++++-
 drivers/net/ethernet/sfc/net_driver.h |  2 ++
 drivers/net/ethernet/sfc/nic.h        |  3 ++
 4 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 452009ed7a43..4587ca884c03 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -24,6 +24,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <net/udp_tunnel.h>
+#include "efx_cxl.h"
 
 /* Hardware control for EF10 architecture including 'Huntington'. */
 
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
+		goto out;
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
+out:
 	netif_dbg(efx, probe, efx->net_dev,
 		  "memory BAR at %pa (virtual %p+%x UC, %p+%x WC)\n",
 		  &efx->membase_phys, efx->membase, uc_mem_map_size,
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index e7c121368b0a..2de0edda873c 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -24,9 +24,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
 	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	struct pci_dev *pci_dev;
+	resource_size_t max;
 	struct efx_cxl *cxl;
 	struct resource res;
-	resource_size_t max;
+	struct range range;
 	u16 dvsec;
 	int rc;
 
@@ -135,10 +136,25 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err_region;
 	}
 
+	rc = cxl_get_region_range(cxl->efx_region, &range);
+	if (rc) {
+		pci_err(pci_dev, "CXL getting regions params failed");
+		goto err_region_params;
+	}
+
+	cxl->ctpio_cxl = ioremap(range.start, range.end - range.start);
+	if (!cxl->ctpio_cxl) {
+		pci_err(pci_dev, "CXL ioremap region (%pra) pfailed", &range);
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
 err3:
@@ -153,6 +169,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		iounmap(probe_data->cxl->ctpio_cxl);
 		cxl_accel_region_detach(probe_data->cxl->cxled);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 7f11ff200c25..90b884039058 100644
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
2.17.1


