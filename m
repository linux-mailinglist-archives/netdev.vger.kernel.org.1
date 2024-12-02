Return-Path: <netdev+bounces-148184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14FC9E0A49
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE3BFB4181E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896DD1DB527;
	Mon,  2 Dec 2024 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hFXRy8i+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37B51DC19A;
	Mon,  2 Dec 2024 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159603; cv=fail; b=gV/JoFSHEXB4akJA1Mj+ceKv7IKy6gvZy5a+QcKKycwV30yme0zeUJKU3nzmtJfWxGoi+LxMyj8S2xupW+B/jLnPgJPrUAPycXlQRnRygd/JmXAnQFMmOQ1OwA/ewbv7vUmMhlW85HnrNBFZKf+Ay5vPeTlYIq++11qjM7vUu5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159603; c=relaxed/simple;
	bh=svSN/B+Fqi8zhals7mYpls322/XPt2Sjgvle/DADihE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eq2VdEquoNzaeuRF8sefdjZx3TQ+XHrwUdWf2HtVUcb20tmAi7UUaemuWekcwSyfOufuiih2Offpez7ub/ebGGJBvoFsFHNeOVOBG98d3UL1XTgFY2DsFX7lF12Fx2njjZJc0v5k19OGhKKfJQY2VR1C7BH4CYzyiVIurD4vyAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hFXRy8i+; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfuxlXjnLA25RyKbJyFYND5oYMUvTqDHfTcAf4YqgAuVYzmJHBIEM8UoVJSd+NYgdnrR3neeshE8y5h0+2PL999xFF46uSQtyDHGv/Ah3kBtvgJMo99ONZqmfvIRiVXi2NWa4jAbM+RljNLg5sgut+dQOklCHEqGCec8CK01F7+7/or9QWmmKWYWXXw+VMxpvFYle20zfdtzaCjsG7Kj2GRCfhafT9LNVZOaFfbScqlMcpJUZLyf+bh3xL8bIhg79BN+N5V8j1lIB9PSReXwgLqVn0AI4P1gdTOuHb32EEoU7fm/Lfoy7kyA0lo1fhFDIdjCwQKKlXiI2spnN/t4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teh1XCd8mXXfMw5FhpwdIKIdg5pYGJNMHqiE4UnWvG0=;
 b=VSRG9pCXf5gdJbZH9FIQGBJ+d42fPqu4/cTOZeANABNHneunqKy2UBlP8TKDugwxZ88wM3IRJwUU6BDSab0MFmf9aH4FcAu4GlbfaKtWqah8mKFKTCuUwcfI1TC6BX1F9bTuYU1kVadQhE1Sbb2MqCh4QTUfefIPzH1y/sdvcIN2Kt6ZVPqyXbS4pONfhH6gthNaj6fzb1NaHP4Gd3V+70tI54AZTfXO7TeSqJrRaeYK2qw/CLi4vlX81orgKEPK0oEqvjwLXbQQX2PsAaJ1c7SMT9467uBpaygal6LGWqhHqVe2Cgnb3oAoW4bAncExiWyUtMaCFSAqp+JJxvB6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teh1XCd8mXXfMw5FhpwdIKIdg5pYGJNMHqiE4UnWvG0=;
 b=hFXRy8i+6F/IjDZVH4WjkhbMktZ/5kbytAVbjeDLjn5pKO3IDefOUYSRAKvuRpul0VR95jGrDFMFVtS4DzPWVlZlizDygDV5B+VFn/E9BncW3WInkihNCVRghG8Iqd3yEyaAm/Py7TeNabjdPOqmYI+etuYBLKe5/29SO6F4rLE=
Received: from BN9PR03CA0519.namprd03.prod.outlook.com (2603:10b6:408:131::14)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 17:13:16 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::a4) by BN9PR03CA0519.outlook.office365.com
 (2603:10b6:408:131::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 17:13:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:13:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:13:15 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:13:14 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 28/28] sfc: support pio mapping based on cxl
Date: Mon, 2 Dec 2024 17:12:22 +0000
Message-ID: <20241202171222.62595-29-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|IA0PR12MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 11421c71-8bdf-4fbe-d9e5-08dd12f49c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ujT2iM1Z493e6s4fDFmS7yg5Haso/p84gb8f/zC610lqABfPASBR97Lhxipw?=
 =?us-ascii?Q?pCEvj6Oa/3ONiaCL40qw3ICalDqMTG6xIiBsOT/7c7J252LllbQN26xd0yLU?=
 =?us-ascii?Q?QF8ePv+umFokqDA88yPBfMQMeS2TMr81Q4TgUOQepTRKlNhT5o/EwUa1kaf7?=
 =?us-ascii?Q?IBsqjLKES7wDtJjhpaXFYsxk/ObBZ1UL4ecm68SBP2LEDNMgM9TRfzwgtsMJ?=
 =?us-ascii?Q?VbUWnwxnWrOJ+OslyrjS4m96wTH5rJHjLCdMqC8d8TLHSSU8SEWmxO4ytOvR?=
 =?us-ascii?Q?ivq3O8jSkD17sQQy7YI6M4UpHnJ84dVRY/w+A/p4K7LjCT1uZU1vw32P3jPm?=
 =?us-ascii?Q?7h6sWKsIiFKt4CNkMczOkJmfaHJpNnZCdD0EsyNCTYBl6PUfWj+EKVBbVSUl?=
 =?us-ascii?Q?6HIFXHt0ubkilTs9HsUqUHa1wj6q8X2adaWUT+wj9XG4Axt49DBILdf29aw+?=
 =?us-ascii?Q?rvNA9V1f6WzAVnio53b6s5WdPfR5qk0IvCWvTD/9MSqgUqlVvreE3UW9dYur?=
 =?us-ascii?Q?txPFOtIRUTjEipPYVFky1P9IDLF1LKn/B3C66f/+6KjrvSjej2A9bfrhhhuG?=
 =?us-ascii?Q?FlIXw+uYDr45Yv/231epGQpOKW9068eLiC8Cr3yOyFOCBzDF6h4XrYDTHZCx?=
 =?us-ascii?Q?HnIZCPYu73bp1Za5kUEOsG5pmCy9J3W9J9otcbkLcoZeo9e0pUvut6Se5CO6?=
 =?us-ascii?Q?JdlHgn+zPeNUCxejxzKPxBKyuEyXQLBEEr0UfaukfGw4FvUJQspS7xmxl3Gi?=
 =?us-ascii?Q?uStJZpxaHdMr0LafJyJEXCNBnD0afZr+oZrV0QPPWf7jlK5DW4gC0HNqZ/Qf?=
 =?us-ascii?Q?lNfY9WT55COuTuvDmD+qUpu0vIoSwev3cfyugGX3xeUciWo1Nw9ArrWBnw6j?=
 =?us-ascii?Q?KKiFzoKvF0cO0BeHldjEShofH8dgZjSAjTDSofPnbm14b4fv02elHLne7ozR?=
 =?us-ascii?Q?dfL+3lvyI8fPrHZLv5DfpUF4SO24zWUcATjyQGXHan55TLBTERIc9tUL0YPN?=
 =?us-ascii?Q?IxVAluL2odTv/A8GfZjS0UgbORlzQX2QpXN/EOo4v15YjZn6krGHz26211D7?=
 =?us-ascii?Q?c41LUX+T4w3YTdyym2rzIKOlck5ANzIwrPrgBsw8FZoa3l9F1VUlfVf6fU2x?=
 =?us-ascii?Q?oZrKBY5nfPoFeXsgI0DvaZTMl2XedBQIpjksdyNQipM8ZoFCMnho0KkqvVUv?=
 =?us-ascii?Q?5X+o8ABcqoM6T5Pt2FfN+AttvhEvzTZi07NULygCUuRNU+l+NqUPKBqczSia?=
 =?us-ascii?Q?HWKy4HkTnjrGk5TAAS4A7VcXDLixu3VsuxwzVUT0fqXgm2aRovIcrB7llmS4?=
 =?us-ascii?Q?Xmw0P59a1R0c81yfUOorTQWEHFEt2VcUhJNK7g497LWoeIFVi0zZYyNgxkKL?=
 =?us-ascii?Q?XIrFUvnnrxdx5W6bec+H2BOnMk7CV3kHGg8hDSEjVIUZ02oVpeKzGR2OAwNK?=
 =?us-ascii?Q?eHDXTc9U1YzXMDjYm02seVSm+fmxLKawgMovMdqGpVgoIgBohmHctQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:13:16.0348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11421c71-8bdf-4fbe-d9e5-08dd12f49c5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046

From: Alejandro Lucero <alucerop@amd.com>

With a device supporting CXL and successfully initialised, use the cxl
region to map the memory range and use this mapping for PIO buffers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/ef10.c       | 49 +++++++++++++++++++++++----
 drivers/net/ethernet/sfc/efx_cxl.c    | 19 ++++++++++-
 drivers/net/ethernet/sfc/net_driver.h |  2 ++
 drivers/net/ethernet/sfc/nic.h        |  3 ++
 4 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 452009ed7a43..f2aeffc323c6 100644
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
 
@@ -1263,8 +1281,27 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
 	iounmap(efx->membase);
 	efx->membase = membase;
 
-	/* Set up the WC mapping if needed */
-	if (wc_mem_map_size) {
+	if (!wc_mem_map_size) {
+		netif_dbg(efx, probe, efx->net_dev, "wc_mem_map_size is 0\n");
+		return 0;
+	}
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
@@ -1279,12 +1316,12 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
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
index 71b32fc48ca7..78eb8aa9702a 100644
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
+		pci_err(pci_dev, "CXL ioremap region failed");
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
index 7f11ff200c25..79b0e6663f23 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1209,6 +1209,7 @@ struct efx_cxl;
  * @efx: Efx NIC details
  * @cxl: details of related cxl objects
  * @cxl_pio_initialised: cxl initialization outcome.
++ * @cxl_pio_in_use: PIO using CXL mapping
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


