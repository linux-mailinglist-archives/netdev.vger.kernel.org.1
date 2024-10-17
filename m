Return-Path: <netdev+bounces-136687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D934E9A29DF
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995C7280EDB
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8251F8EF1;
	Thu, 17 Oct 2024 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Svr+qtfQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E63C1F8929;
	Thu, 17 Oct 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184040; cv=fail; b=hnIvIzKbwo3UuuDaOaITz2Sio4VWKJ1iaGhncTPy14Ew+2A8+b3Itq2JHkfD2eMv/15DY4XMkLWpshJ0AU6pZRQf4aEUBJMg3TggFwiuLpEBm4O6w1K773wadNPPdWd/+jghzIPwE6y5zqRAX11+A4xPMkXyCS8WnDIftFXHYT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184040; c=relaxed/simple;
	bh=cR66PaxPLen+nQN6L1PDpnU1DHbrvJij9GtjBpQrZmk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TghfJEikfmv3x4XAb2z83fwsHEb4vcmKnCkvH2FO+OHaYSqZBN9c2WAI4kbt2MEyocfECBZD8h2EZUMgpDAuzCbnlif8mKv9+YqtcC4N7B0Onc/z2DZlDWU2Y0s33zz1AiGjmbmxWNz3/TFY53F/5OxGuemZlwOOB7dsgMNdf7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Svr+qtfQ; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HE6mCl6pLH7DqSXRNWmcVG/kf7ti+mjjbod9NtqCo/abFvYm4RJVLT00u3/OuG3XVSzz0niCWregn63nePSZKOy980a6zNOjLOdNl1sqX4ejODXDIHlggrHBja1xSX39TGcrIBqCyPD704o6cvjIE56r7BcolaxkC/x17KaFIngdwFBg9DnxgCLQ2rqhCyb9Y/7314zd9jLs07MbQopKnvmts/ysCibMgtMuHJdTs3Hx2zGcPa5xn52oWJrKcWbll9SgXarffTfnOIhzKFj3pZ0LbeUTSxfFS+Eu01eHOu5zwP7/wpevYofaD0mCJB6xmHfxymaqxlVZWyRANkG56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JF5zIRxpecZyU3WnIRwoogauMBRvCnycHuW6mLLUkG8=;
 b=CkxEevkKPWKMD4jnYIt/1aRlQoDkHXwxhBJ7wyP2AZcPvuNzDiGMylnmNzc/jik9pcnsPkwVvjsLFT26nRPgJsEspSs8TOLX5FVm+qoN+Xkgz4ROsvtctCDWH1zimgei6iZyKhCO4WqmoEgx6FzGZumU4A4odrvq2oK94NQwSlengWf5b6wHJSIOscqCyymTkU6mU9gU90ZVQvdgaMuW8Sfw6PS+FnRUbt2l4iNyYxcLxDtvMNUG1EoumRG5LuMua1tY15ORSxQIZaus4o+fDRll2MSOwC9eUf0i7UfXMo8J4rRhT0Zv8l1vCHurkWA+AC3Ye1j0BEWLqOEW75fvzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF5zIRxpecZyU3WnIRwoogauMBRvCnycHuW6mLLUkG8=;
 b=Svr+qtfQ7YsdsEpijsj0pfD1ViYXmIAeNiO3ER638hx/vPTBAZwuTrWvFnMNxeYkNvvdwHxJ87hPnVzM4tVnbxrVOi7whA3kiTzlVHzmXCkz7sLvGKgiOLeRoDD9df1N6VOkP9dUR3F+WrcUsunYAhnOcTDBNhkhv8tQ3nqaOuM=
Received: from BN9PR03CA0207.namprd03.prod.outlook.com (2603:10b6:408:f9::32)
 by PH7PR12MB6908.namprd12.prod.outlook.com (2603:10b6:510:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 16:53:51 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::ad) by BN9PR03CA0207.outlook.office365.com
 (2603:10b6:408:f9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:49 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:48 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 26/26] sfc: support pio mapping based on cxl
Date: Thu, 17 Oct 2024 17:52:25 +0100
Message-ID: <20241017165225.21206-27-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|PH7PR12MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a63091-c804-413b-0df5-08dceecc46a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f+Uc+7sAcuWve/bYHsnQEr/8gr0bt5O4tE4WJQJUTOTqWuvKZaiKTzY/xgls?=
 =?us-ascii?Q?/MUChVMbfv6kRSKpzQF9PYJmd9+xRLTQy1GZe5oVru1rHM1ev4y0B+ffZ9if?=
 =?us-ascii?Q?6ImQLSCYsAe4rF9DlZaqHXxwnL1O6bPWkTeSF8ecJNdifSq/ULLzSeICSMAE?=
 =?us-ascii?Q?S41FZtfQGGZ70uGkpR0CrtkB1eW+ja4dBxRSp+b05nHNIPbQhPkHuVD8kioS?=
 =?us-ascii?Q?IoGg4KT50mroRXjpbNAxsgrTbvJht1QL6XxZa6rRXGe3kYgD4gM0TUxR+9ap?=
 =?us-ascii?Q?a2SQWZAT+SX4nXxw19QCLuls+ZN3mNEXXc9ulXrB+BD8TMSpM2rkwdL0Cg1o?=
 =?us-ascii?Q?pSY4YGg+meDFDmcCgSBQtdQf/gShUM56aaSjVkpIHY53E+AacLijCxx8AzIp?=
 =?us-ascii?Q?QLT3NdkGEHFK0gp9sc6laSoKLPDHOghqDZA0w64bKS1xrWj4mpVkgx+QTWZj?=
 =?us-ascii?Q?Z7RbRhCEugRyhuWPW4bPGlsS+XHiIn72p1LDnH/xs0KFWkFSAzbmkIgqSmNx?=
 =?us-ascii?Q?do1He7GkIdUOS0o62s2YEaczD8tcNetUiYMoYyYEk/ceXapOzQimKF3NqWU4?=
 =?us-ascii?Q?wTnxP7/vl1Y7Dxe95+D4/dp3IQfAFrAb44DK46qo4o1RyiTVEns0dGdrJIso?=
 =?us-ascii?Q?bCnnxkNGJzr7YJ0KNTEnygsUJ28Qqh7ErEP2mXvRdcSmQ4ZsWZUTacGQetyL?=
 =?us-ascii?Q?zZQCZKUck5wIgRfvZieDxdKx+ZADk4x9mcJRtUoDhed/JJUaIrC91+0GsP0I?=
 =?us-ascii?Q?OKsozW8JfBzfwPKAtcwSdmJU3y2syCNLT56RCU5hJFseNUugFHqeSWkJ0qm5?=
 =?us-ascii?Q?vXRgvOzc72AmI6JfT5bgPGlM9nTvi2YKetXEbnmoktmIveosI4wb67VI+d6I?=
 =?us-ascii?Q?1Ob9t7AuorJLC//vHVZbRu52tbRr6Gy7aJDmhaBMS6R51W3dy8tqV+gmk8uq?=
 =?us-ascii?Q?n9wSOv7n6OMmjw1Owpjn0WnP+7Hpudf+MDQA7AotDy9mOULo4lSe2wEGzwn+?=
 =?us-ascii?Q?W6DZ2NUcmLhtGpFQeJ0zMkaYg1u4FV7rmdOxJz1J/V1Yn0bili/zStTtQeFO?=
 =?us-ascii?Q?hZzww8DxOV8w5fwmFzcsXcN1+m8ETBXWJiIMs9C2qvs/fgFSQuvQ2U1jTCw7?=
 =?us-ascii?Q?zk0Qcke15bEagXx4oUfZ+Uij3Hj2/WiNWjveMKyl81vedEZQwjbti95J1c6R?=
 =?us-ascii?Q?xZoJYxrrQqbXOJAW1anejh5lZTO4Z7ARrftqUbVbA4+F7+2kGFcsBddhvQOU?=
 =?us-ascii?Q?TwPUi+HlyzGDlbo0ZR5uB5mQmf2/gA/2HEBN5a+4ZiDiSohvDqctOeE8DOhU?=
 =?us-ascii?Q?7AEDLBsYoNYBvqv781rPgOCi9K8H+ImNSep5M32hT8kkKVHfpnhmt5mo1kNy?=
 =?us-ascii?Q?8NkMrtfkza1x5LFOZFLZFDHWLUd8WwsuAd3HK6Tz/UzGwSTyXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:50.5169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a63091-c804-413b-0df5-08dceecc46a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6908

From: Alejandro Lucero <alucerop@amd.com>

With a device supporting CXL and successfully initialised, use the cxl
region to map the memory range and use this mapping for PIO buffers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/ef10.c       | 34 +++++++++++++++++++++------
 drivers/net/ethernet/sfc/efx_cxl.c    | 19 ++++++++++++++-
 drivers/net/ethernet/sfc/mcdi_pcol.h  | 12 ++++++++++
 drivers/net/ethernet/sfc/net_driver.h |  2 ++
 drivers/net/ethernet/sfc/nic.h        |  2 ++
 5 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 7d69302ffa0a..794574151b2f 100644
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
 
@@ -949,7 +956,7 @@ static void efx_ef10_remove(struct efx_nic *efx)
 
 	efx_mcdi_rx_free_indir_table(efx);
 
-	if (nic_data->wc_membase)
+	if (nic_data->wc_membase && !efx->efx_cxl_pio_in_use)
 		iounmap(nic_data->wc_membase);
 
 	rc = efx_mcdi_free_vis(efx);
@@ -1263,8 +1270,21 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
 	iounmap(efx->membase);
 	efx->membase = membase;
 
-	/* Set up the WC mapping if needed */
-	if (wc_mem_map_size) {
+	if (!wc_mem_map_size)
+		return 0;
+
+	/* Set up the WC mapping */
+
+	if ((nic_data->datapath_caps3 &
+	    (1 << MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN)) &&
+	    efx->efx_cxl_pio_initialised) {
+		/* Using PIO through CXL mapping? */
+		nic_data->pio_write_base = efx->cxl->ctpio_cxl +
+					   (pio_write_vi_base * efx->vi_stride +
+					    ER_DZ_TX_PIOBUF - uc_mem_map_size);
+		efx->efx_cxl_pio_in_use = true;
+	} else {
+		/* Using legacy PIO BAR mapping */
 		nic_data->wc_membase = ioremap_wc(efx->membase_phys +
 						  uc_mem_map_size,
 						  wc_mem_map_size);
@@ -1279,12 +1299,12 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
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
 	netif_dbg(efx, probe, efx->net_dev,
 		  "memory BAR at %pa (virtual %p+%x UC, %p+%x WC)\n",
 		  &efx->membase_phys, efx->membase, uc_mem_map_size,
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 869129635a84..1629ffe3dccb 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -24,9 +24,9 @@ int efx_cxl_init(struct efx_nic *efx)
 	struct pci_dev *pci_dev = efx->pci_dev;
 	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
 	DECLARE_BITMAP(found, CXL_MAX_CAPS);
+	resource_size_t max, start, end;
 	struct efx_cxl *cxl;
 	struct resource res;
-	resource_size_t max;
 	u16 dvsec;
 	int rc;
 
@@ -134,12 +134,28 @@ int efx_cxl_init(struct efx_nic *efx)
 		goto err_region;
 	}
 
+	rc = cxl_get_region_params(cxl->efx_region, &start, &end);
+	if (!rc) {
+		pci_err(pci_dev, "CXL getting regions params failed");
+		goto err_region_params;
+	}
+
+	cxl->ctpio_cxl = ioremap(start, end - start);
+	if (!cxl->ctpio_cxl) {
+		pci_err(pci_dev, "CXL ioremap region failed");
+		goto err_region_params;
+	}
+
+	efx->efx_cxl_pio_initialised = true;
+
 	efx->cxl = cxl;
 #endif
 
 	return 0;
 
 #if IS_ENABLED(CONFIG_CXL_BUS)
+err_region_params:
+	cxl_accel_region_detach(efx->cxl->cxled);
 err_region:
 	cxl_dpa_free(cxl->cxled);
 err3:
@@ -157,6 +173,7 @@ void efx_cxl_exit(struct efx_nic *efx)
 {
 #if IS_ENABLED(CONFIG_CXL_BUS)
 	if (efx->cxl) {
+		iounmap(efx->cxl->ctpio_cxl);
 		cxl_accel_region_detach(efx->cxl->cxled);
 		cxl_dpa_free(efx->cxl->cxled);
 		cxl_release_resource(efx->cxl->cxlds, CXL_RES_RAM);
diff --git a/drivers/net/ethernet/sfc/mcdi_pcol.h b/drivers/net/ethernet/sfc/mcdi_pcol.h
index cd297e19cddc..c158a1e8d01b 100644
--- a/drivers/net/ethernet/sfc/mcdi_pcol.h
+++ b/drivers/net/ethernet/sfc/mcdi_pcol.h
@@ -16799,6 +16799,9 @@
 #define        MC_CMD_GET_CAPABILITIES_V7_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
 #define        MC_CMD_GET_CAPABILITIES_V7_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
 #define        MC_CMD_GET_CAPABILITIES_V7_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
+#define        MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_OFST 148
+#define        MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN 17
+#define        MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_WIDTH 1
 
 /* MC_CMD_GET_CAPABILITIES_V8_OUT msgresponse */
 #define    MC_CMD_GET_CAPABILITIES_V8_OUT_LEN 160
@@ -17303,6 +17306,9 @@
 #define        MC_CMD_GET_CAPABILITIES_V8_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
 #define        MC_CMD_GET_CAPABILITIES_V8_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
 #define        MC_CMD_GET_CAPABILITIES_V8_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
+#define        MC_CMD_GET_CAPABILITIES_V8_OUT_CXL_CONFIG_ENABLE_OFST 148
+#define        MC_CMD_GET_CAPABILITIES_V8_OUT_CXL_CONFIG_ENABLE_LBN 17
+#define        MC_CMD_GET_CAPABILITIES_V8_OUT_CXL_CONFIG_ENABLE_WIDTH 1
 /* These bits are reserved for communicating test-specific capabilities to
  * host-side test software. All production drivers should treat this field as
  * opaque.
@@ -17821,6 +17827,9 @@
 #define        MC_CMD_GET_CAPABILITIES_V9_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
 #define        MC_CMD_GET_CAPABILITIES_V9_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
 #define        MC_CMD_GET_CAPABILITIES_V9_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
+#define        MC_CMD_GET_CAPABILITIES_V9_OUT_CXL_CONFIG_ENABLE_OFST 148
+#define        MC_CMD_GET_CAPABILITIES_V9_OUT_CXL_CONFIG_ENABLE_LBN 17
+#define        MC_CMD_GET_CAPABILITIES_V9_OUT_CXL_CONFIG_ENABLE_WIDTH 1
 /* These bits are reserved for communicating test-specific capabilities to
  * host-side test software. All production drivers should treat this field as
  * opaque.
@@ -18374,6 +18383,9 @@
 #define        MC_CMD_GET_CAPABILITIES_V10_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
 #define        MC_CMD_GET_CAPABILITIES_V10_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
 #define        MC_CMD_GET_CAPABILITIES_V10_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
+#define        MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_OFST 148
+#define        MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_LBN 17
+#define        MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_WIDTH 1
 /* These bits are reserved for communicating test-specific capabilities to
  * host-side test software. All production drivers should treat this field as
  * opaque.
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 77261de65e63..893e7841ffb4 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -967,6 +967,7 @@ struct efx_cxl;
  * @dl_port: devlink port associated with the PF
  * @cxl: details of related cxl objects
  * @efx_cxl_pio_initialised: clx initialization outcome.
+ * @efx_cxl_pio_in_use: PIO using CXL mapping
  * @mem_bar: The BAR that is mapped into membase.
  * @reg_base: Offset from the start of the bar to the function control window.
  * @monitor_work: Hardware monitor workitem
@@ -1154,6 +1155,7 @@ struct efx_nic {
 	struct devlink_port *dl_port;
 	struct efx_cxl *cxl;
 	bool efx_cxl_pio_initialised;
+	bool efx_cxl_pio_in_use;
 	unsigned int mem_bar;
 	u32 reg_base;
 
diff --git a/drivers/net/ethernet/sfc/nic.h b/drivers/net/ethernet/sfc/nic.h
index 1db64fc6e909..b7148810acdb 100644
--- a/drivers/net/ethernet/sfc/nic.h
+++ b/drivers/net/ethernet/sfc/nic.h
@@ -151,6 +151,7 @@ enum {
  * @datapath_caps: Capabilities of datapath firmware (FLAGS1 field of
  *	%MC_CMD_GET_CAPABILITIES response)
  * @datapath_caps2: Further Capabilities of datapath firmware (FLAGS2 field of
+ * @datapath_caps3: Further Capabilities of datapath firmware (FLAGS3 field of
  * %MC_CMD_GET_CAPABILITIES response)
  * @rx_dpcpu_fw_id: Firmware ID of the RxDPCPU
  * @tx_dpcpu_fw_id: Firmware ID of the TxDPCPU
@@ -186,6 +187,7 @@ struct efx_ef10_nic_data {
 	bool must_check_datapath_caps;
 	u32 datapath_caps;
 	u32 datapath_caps2;
+	u32 datapath_caps3;
 	unsigned int rx_dpcpu_fw_id;
 	unsigned int tx_dpcpu_fw_id;
 	bool must_probe_vswitching;
-- 
2.17.1


