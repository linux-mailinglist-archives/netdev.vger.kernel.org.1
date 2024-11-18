Return-Path: <netdev+bounces-145964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6139D15B7
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16B31F239C6
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97611C174E;
	Mon, 18 Nov 2024 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tZL3773L"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D961C173F;
	Mon, 18 Nov 2024 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948330; cv=fail; b=A9Btia5TcpXewfQb4QSQn0NnbwgDAk0fDIT5A9E+9Ia+xQ3Wz8gF9H87FGSJAK3j+AL1FCpNGXpQK3HmX89HGdenihPafdd/RReqJgjL6Eu7/C2r6rUZ6O8dQ8gAlGmVq5NzlHrG9IfbLCLfSv5YAzechoGP7WspuYDnIybAZBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948330; c=relaxed/simple;
	bh=kuuMeTAsxpcd7Q1p105WV9RAZu6NpVi611HVJBa4X+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zg5BXeyr3SQ1x/bIHvPgfS93IaZmhXlbR6bR7MoNiE7DYh6fo6yfYPdE4swOdQVeFzqBkKnAlIHkaKjeErCk5wVoM3kYZxAm+api1ZAilJ7z2GoZPl+ZnhgrlmvOhd2FOTSlawbISaCIP8C/ABy66L3XYyqFpVM7wu7d5kyVIEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tZL3773L; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mH3RdjGYCKh5TsHPcqz0BK1q93vLJbCM/U+kREpFiKL1iOMbaogkyeSHix1hmUiVQyWo9QtX+FBNV24SGYd9qO1medcUToL+SnbIyPNQPHga9z0He/c4fR5ZjpXL2bYxZh0R4azrPWHicpovYAs6ig/Q9K00n8P+IDD65ztVHdP9HQkDGLJ0wu00kTi/gNySatWZFRhNi6WOD3ppq9DpENy/Q1bn28m26PBo+WDALk4idjgaKx5yloJVp1vgV61307sLn+3BgwqNxP1CWNLoOG6juWIZw7kDl8pZdB9XU12EwIQQrhFTelWjK3p87onbs+mUEER0N52fdx/KBWg0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfQgc4g1di7vmY8U703jHmWsKTOzxvLARBD8MjOMLds=;
 b=f+TmT+veW1SQDsiTw2A1PtK5uF1BD4Dbspw3AHzoC4hyBbSAu68Ho86EmtW02LYyjP7/O7nLlg5XwrGTRNgSjhbZwT+QBQmhrbtcjmUK/lHo0WEDNNvCLwkkoVp8xTXhRJuwR1NXimBfDQvijkyQJmPKzY4vcH1NWQDWON/Fcka7VbEbWTHgVtIHcFADZ3jLWB6HsbKKTNDdvL95I1hH/PVOMtpsi3F2zoyhDPYgIafGXVWEyks7yK6hdJWdmXcFQiG3j9yHT5I37LNTkRvKM6taR3+Y0H2RriGkZrBRyik/QYce7Czcn7ZZ6Z/QLKgTMtyCo8aSjqDBVV6hphP+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfQgc4g1di7vmY8U703jHmWsKTOzxvLARBD8MjOMLds=;
 b=tZL3773LDEuJeDjon2AjUbpfOdifelvepqkjEuFfpcLdta0rkOCWVSVhnfSaMreErhAcD674W5Z4yY7lUdDMjZOcnrJJI+6VhmwX8eaamek/23gbxMuFceh3iPxRguV3GcQx7oeFvXsWk6qRod1ytT+f0UEkEx831D8i8XO0MfQ=
Received: from BYAPR06CA0048.namprd06.prod.outlook.com (2603:10b6:a03:14b::25)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 16:45:25 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::f2) by BYAPR06CA0048.outlook.office365.com
 (2603:10b6:a03:14b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 16:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:45:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:22 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:45:20 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 27/27] sfc: support pio mapping based on cxl
Date: Mon, 18 Nov 2024 16:44:34 +0000
Message-ID: <20241118164434.7551-28-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|CH3PR12MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: fff023cb-37a6-4355-6615-08dd07f06663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lUAyzCsMqclKZB+Z4hmaskWnHqZNU5k6/ENj3I8S4KN7Fd/c4z2l8A9a/gfc?=
 =?us-ascii?Q?BdmtkOxxTR8theSfOR08z4ibUgd16L+A830AKB1nhnPpdJa3Ctpmb1MLISkQ?=
 =?us-ascii?Q?xbfaSTpnplcozWsZz1QLQ2D3gp6YLaZ0R1kJc3uFnxYNkYPFpBdbLRey0Pr+?=
 =?us-ascii?Q?6kUPJpwWo4A9vNLyQqAyEqdEYF01F1CH6oHbfuzvwt4aNupw9kqPR/VTFwOr?=
 =?us-ascii?Q?cDd+W7FjlD7MxsEfC+br4AjawQ7GmFcDAjN0YmkAga/TCxIZ0Ljkrtpcm5CO?=
 =?us-ascii?Q?Q3zVDdFZFYMXlu/5A593vQjxHHC50vVejWMcateMlf0FYmNY0Us5+uXdrDBF?=
 =?us-ascii?Q?5QFMm54WpSocknZNylU+xNbXwc8uNwKKasgIE31wCpZ8I56rD6n0bSHglVza?=
 =?us-ascii?Q?Mo9L+1eK/f8YLdwvPLgXum9FWtjHiFXMUhUDrXv2x0PMKOzjEE+yZ6ikjxPE?=
 =?us-ascii?Q?NJaAa091WDrC1z7L7awmEMmSmTCa13Stay/Omgx568R0UGg0UHoOXzdsxyu5?=
 =?us-ascii?Q?1J8HdMYeZWnZ15iSwiNqkClYUNaDCpueBostXy6EXrDc0uKhzLWBAJN+lWnW?=
 =?us-ascii?Q?ld8mY9V8of3PXcX0sfTXkCg5ZuLkxi4N6jzdppVXVsljLkAGnbtnFQzQTitu?=
 =?us-ascii?Q?f4yl2tutLXJQqvrrQEVsIs4SLbIr4aSsiBHCd6UKTOVL266g7eA08WswWSau?=
 =?us-ascii?Q?Z5Re56fNDkoAOAiARYAHfWnVUsuNKdg10cxRNcpZSWLLE/465mDCLMEJ0gqM?=
 =?us-ascii?Q?VCW6FysQ4Fr/+t9nWtly061dzJyst9vzzMRA9+Dh5Kj3GYG0GgHxY9Liugju?=
 =?us-ascii?Q?KHCakv21cO34Qx1OAYEGJdTslTi9UApvVXks0RsEl7ZPc2PtuDyzdSTDLjpF?=
 =?us-ascii?Q?t7hGv8ZYuiR9nSs5y3tVBFVbmBFe1KYvyfhBXgXHX3MUHcc9qUoLYa60NaAv?=
 =?us-ascii?Q?m1EyNx7jOhTBfViNb9U3CyAlzLCH2FmMke7eAL1Pt9PE2B72tjtmWqMbz+Z0?=
 =?us-ascii?Q?uaIJH6dESy/qbkGD2dK+iO0jdukmqzE9eKHJM6w41CRnnJYN4VCPoSAziRxD?=
 =?us-ascii?Q?6YYf3xXQ+DkFoGF5DXErYxOR2oj2cXW8/mAHgmGa+6HAvSz7KupGjyoQ7Wt+?=
 =?us-ascii?Q?glWJj51/zSRchurtg0QZCfq19y7RKUkdRNx3WHu1B43KAto47ZEzo4gZN9lj?=
 =?us-ascii?Q?zBUQXdZWK2NT7xDIRwR1n3lrOp1hRWEaSlAsXZAj1rkPrZCXcsCULCXdPZHA?=
 =?us-ascii?Q?uqyFOCnGBkE3HZywn/IoRKhG4R/KQPp1nrfKWgXuAeTF65kmH8lbN16m1Mmr?=
 =?us-ascii?Q?SennA3M2ExMUsj99BJn22UAZQKaIsGQa0qo1CXLDeK8LsMCdsEmDmBwVlgFX?=
 =?us-ascii?Q?Hyzoz/2oa+hAgZYsD6hoJKrft2U4MkqSe448SdX58uOm9go0Qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:45:24.5314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fff023cb-37a6-4355-6615-08dd07f06663
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583

From: Alejandro Lucero <alucerop@amd.com>

With a device supporting CXL and successfully initialised, use the cxl
region to map the memory range and use this mapping for PIO buffers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/ef10.c       | 49 +++++++++++++++++++++++----
 drivers/net/ethernet/sfc/efx_cxl.c    | 18 +++++++++-
 drivers/net/ethernet/sfc/mcdi_pcol.h  | 12 +++++++
 drivers/net/ethernet/sfc/net_driver.h |  2 ++
 drivers/net/ethernet/sfc/nic.h        |  3 ++
 5 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index de131fc5fa0b..d19e42dd8dbd 100644
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
index de8d6bca9300..f727c53e287f 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -23,10 +23,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct efx_nic *efx = &probe_data->efx;
 	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
 	DECLARE_BITMAP(found, CXL_MAX_CAPS);
+	resource_size_t max, start, end;
 	struct pci_dev *pci_dev;
 	struct efx_cxl *cxl;
 	struct resource res;
-	resource_size_t max;
 	u16 dvsec;
 	int rc;
 
@@ -135,10 +135,25 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err_region;
 	}
 
+	rc = cxl_get_region_params(cxl->efx_region, &start, &end);
+	if (rc) {
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
 	probe_data->cxl = cxl;
+	probe_data->cxl_pio_initialised = true;
 
 	return 0;
 
+err_region_params:
+	cxl_accel_region_detach(cxl->cxled);
 err_region:
 	cxl_dpa_free(cxl->cxled);
 err3:
@@ -154,6 +169,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		iounmap(probe_data->cxl->ctpio_cxl);
 		cxl_accel_region_detach(probe_data->cxl->cxled);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
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
index efc6d90380b9..fcf3058f64d8 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1170,6 +1170,7 @@ struct efx_cxl;
  * @efx: Efx NIC details
  * @cxl: details of related cxl objects
  * @cxl_pio_initialised: cxl initialization outcome.
++ * @cxl_pio_in_use: PIO using CXL mapping
  */
 struct efx_probe_data {
 	struct pci_dev *pci_dev;
@@ -1177,6 +1178,7 @@ struct efx_probe_data {
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


