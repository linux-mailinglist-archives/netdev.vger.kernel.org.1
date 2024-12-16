Return-Path: <netdev+bounces-152303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99E39F3595
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8350A7A329F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6EE204F9F;
	Mon, 16 Dec 2024 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E94MmbkD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DA014D6EB;
	Mon, 16 Dec 2024 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365500; cv=fail; b=DVCJFq0dxhbOXd5tuKrM+tBvcZU0XdilUSWJRvIDeycE/+MCVKuhjJgWgJzEy0R+8pDI7keEbSpKBgaX6bDwIeT20pzHD7gQiyj8Nq28AYr8kmhw81uEB8IB2emvR7oeKkAvtajVhRMzwPY0ytqcfjkxSEiQdlaJkP+a8pebFNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365500; c=relaxed/simple;
	bh=6etGr64/tiwBHphXw3E2sy9bGbtQ2KvIxvHQ8V/TkBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V96sU7Dcng6Of0djnts1FJIleUWn1jbGs9tbYmPEL2FtTb5eOcLjWcZ6k9krwkkltN+jmzQGD7hVcUDDfixi09rUbAZP7hGxndmvgMyVUR02spSzlNeKrnoYLrfNy0O/dGR6FrD7bwnwGax9oJDm8jy3GHAQ9hMnvkzI+//0NfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E94MmbkD; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STrx8iDh6nNLuLhjDgKaZXKbch5DT26XPj5XwJmVuNum+waBwmEvIEXDT1mdxuGKKO429dvsMXFBysQ0ubI1+iz3OE5wmFGFEVVZ8VvSV94lWVzP7Jy3GYm8/Tqr8MEOZras5aseC16jVW54IUjgA+vd4J/TkJKoPZSV59AxNCzhjRvyMloH2rJD8QcfQ8ltqduH7adB9Lk0feTShQVWO97llV4uQNSxwdObdiGSEpQ9xyDOogtkQenXf2mjes/44TnxFkC1bzpgsCM/WTkgMGLfRpobaRUkl4ztANPJy90AbfaCSZTrwnU/zvrLg0gP/sP50Fi+CZWEQfPuhRZHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8Jnx+/lIdn9SW/7c9455bPY/6v0kWyrkDAREwZ+0H0=;
 b=DdPfHS91weo99+RIshciGzw/vPuh575wYBmUUdtv4Qe+P+KH4oy2dxMnyOR9oQlnvr3KLAMBMWmgGUEgcu388z6zz1nhy3cbkXjxjG/xIK+1H2QBcoo/QDdfCSRQccMcr/pGtd3WnHkLj2h93FNuoWYsx9X00VVL09ImYQqpjEF/PesU5jww7XoAV+1tnuAIjpYp9HBOf0q9V/+ES5EGcXGUxaV2IFwNwZ1mi1aBR5D8hgKPQuM2fa+ttqhFTm5Zp861OEPtslhZ0ffVFw0BU7Z98Wvr3kze0n7bnV9bvNRnKDwnfTCvVG1wN2tpJayVvVnkRYciVN4TCuYvzQ2lGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8Jnx+/lIdn9SW/7c9455bPY/6v0kWyrkDAREwZ+0H0=;
 b=E94MmbkD+Eljoh+UUZKNVnzGeiY2MrykWIaG38benLhBzboaCZDC+1YQu5UPtuJzKC8qRHudyc2qAl197K8ytoQIygh5FH+R6wEZUQW3Qbxn3FJZoXLjBSFXFpkaKw8odmakQpcLemz5GTgqqsnFVR2SMe97jjDgwTSC5bzPUIA=
Received: from SJ0PR13CA0061.namprd13.prod.outlook.com (2603:10b6:a03:2c4::6)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:11:34 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::32) by SJ0PR13CA0061.outlook.office365.com
 (2603:10b6:a03:2c4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.9 via Frontend Transport; Mon,
 16 Dec 2024 16:11:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:33 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:32 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:31 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 27/27] sfc: support pio mapping based on cxl
Date: Mon, 16 Dec 2024 16:10:42 +0000
Message-ID: <20241216161042.42108-28-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b3997e0-392c-4be8-35f1-08dd1dec4fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SsRlEFfDtQwvlKSu8LEG3sGo0kLAxvyQ12a/whunLC9aFcHFVRr2K1rzWj7a?=
 =?us-ascii?Q?vKhD1AEcxk3dOjSzda9KOML1psXv/lmRYsQWdrgHUqdPL52nM69FwL2/lpzK?=
 =?us-ascii?Q?hVPVzKgl3SEd6hvTFBVg8sws11paeinoodekDmd8FfBxMFFL02kUmlkAWw/W?=
 =?us-ascii?Q?hgmJs/zlMKsL/k4eCHe1l9Tjnltk6dopNLvsvM7Jcu+KJbIVvXfmpt1Ih+Xv?=
 =?us-ascii?Q?VzVVfWDK3NTXPNEPPzsMeiuUfhPtL9Wg1z5jw4P7OhyRxhXgEoMYWLmWVeYj?=
 =?us-ascii?Q?9jvUjrWMvhdkgGO3kYUUdFGf+XVJ2OoBkkD4fhOfZK0yPnaSC6o5vm4sRCZ6?=
 =?us-ascii?Q?Ov1lrVuw8KXQpsra78QmB4DwsdAwEsVJLc0TrwgsA8iOLPwp50gTLwPRSQ1N?=
 =?us-ascii?Q?8I21L3QIj3vla70ohm/HgmFew9S1lX2RWDVMoI0LfGSThTH0ZeqSs3pFXm3Z?=
 =?us-ascii?Q?9KiW4sNGk23FfzbromO7hohK+nhH1ZqQx4ecAKbr4WdF4gBVxlCLFIyh9BrU?=
 =?us-ascii?Q?CzMfzMOZsScVpZzbmgWF3AtT7Mdxl+uIsrHPyvr2CdRZfo2aPmGGkxcZE+kK?=
 =?us-ascii?Q?B7CJ70NM4O80e49LIraxsBYu8IXRhXFcHMacoRb1CDqVquX18BqEJDJK+Zqk?=
 =?us-ascii?Q?6AHmnqB4225/80Ug9a1VKZMeXXTTlwEfes/lII1+BeZqhw+QenOFgHDK0bPD?=
 =?us-ascii?Q?aPpIHtEPopis32BwISBjriF6GQsH0qAcvd8OGFCUgW2p3Bt7lkB1/z445e1k?=
 =?us-ascii?Q?lRC2nv/a2Os7bjUFCsKZLuZxZAqq3uvOrCcRSmVTjabptjg8TDsqWHhrDZUQ?=
 =?us-ascii?Q?0EPZqqItxGGmh3NpxnzqjeyTrJMhZ7KKpGBIHy0Ozr9nltskRT2lzsBPq7GY?=
 =?us-ascii?Q?gMVrg9+z1eH7H+YrXtCyIJs0gs060+VdAZ703uHJirFdhiVBq6FP4NHzgq6F?=
 =?us-ascii?Q?AUbJoNJIdC9b2Wx28541g9+Kq+GbG1nWp2rjDKvGCT9MnwMSHAclMmHcLs6H?=
 =?us-ascii?Q?tmlD4ieRKvhzly1F+ZfTMZYiO292+HUfT3qHGxay1bj6Tz+ENsqGWBM6yeEY?=
 =?us-ascii?Q?X34IDHIQPpOkdeziuYBIHyZ13pXMJzzhMt0J2HnQEIENZSaM+oHKCXdBQzso?=
 =?us-ascii?Q?ExVOWDN2VS+me7FvzeOOh43fspBBa8Oirfxf+nfjwpR30sScSDzaQf1sm2n6?=
 =?us-ascii?Q?rJMYMCsGy7RtxSuQqnDD/ZRmb1cIbuVaXhuWCqw2KqMqp+1isUD+q4/dJrEc?=
 =?us-ascii?Q?QpNovDElL10U7Cxzb8Oc9uPG1dyucp/u9NQHgSeVT7hqc+9dh/IL+sUvCp+Z?=
 =?us-ascii?Q?AKDBsKx/C3w1hWjkwduV6FAQGekQvWHrTvzg3yqdFOiZwiXIFtUUkHuk0V5R?=
 =?us-ascii?Q?OHBqQrtKlT31Ql1foo/3TaHsE+HFyDHlDDUkspt799cH3viXQLrYmXsyaLTc?=
 =?us-ascii?Q?/drz8wk2EsYjoeO4HdehroIjhQUmrP+jtS30/RpxnYhrTMMbH2suO9ZdsJUg?=
 =?us-ascii?Q?6ssY53TqPaesm+1z0z4/GUF6DS8BXz/ubZOF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:34.1679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3997e0-392c-4be8-35f1-08dd1dec4fb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294

From: Alejandro Lucero <alucerop@amd.com>

With a device supporting CXL and successfully initialised, use the cxl
region to map the memory range and use this mapping for PIO buffers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef10.c       | 50 +++++++++++++++++++++++----
 drivers/net/ethernet/sfc/efx_cxl.c    | 17 +++++++++
 drivers/net/ethernet/sfc/net_driver.h |  2 ++
 drivers/net/ethernet/sfc/nic.h        |  3 ++
 4 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 452009ed7a43..ce323af3586e 100644
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
index 7367ba28a40f..6eab6dfd7ebd 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -27,6 +27,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct pci_dev *pci_dev;
 	struct efx_cxl *cxl;
 	struct resource res;
+	struct range range;
 	u16 dvsec;
 	int rc;
 
@@ -136,10 +137,25 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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
 err_memdev:
@@ -154,6 +170,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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


