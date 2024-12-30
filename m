Return-Path: <netdev+bounces-154595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E139C9FEB2B
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390CD3A29B2
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68FD19D88F;
	Mon, 30 Dec 2024 21:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IVDUkrRE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3F41B6544;
	Mon, 30 Dec 2024 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595144; cv=fail; b=ELNYBUf1GxfUZFpFMQUa56+yT68Ec4LImK2v5PQ1vCGr98vsqbVI281ZfeINCmryI78Fb5EHGRwu3anAxEqC6NZAPLNKmYIwEsN7bouMkGXJspHvggrDBFXEfMJMLo80K+10umpa48X0Aqkfovq8lpMTR9hYKJcgRQoB+Q92ck4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595144; c=relaxed/simple;
	bh=YQ5QR150fAFiAW1evrwqoYTeWGmaRiazulr0vFVhZsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSaIfYWz/5TeqX/C3jFcKUKQ67UUilJlABY13ex1w7Z/U2s+KqgrKdtu2bvol7nh6tauzlT/LNhEwJaSVuGMChlkuEjGQpWOjN1S4IOGQ0yb8/QVH15kAF7WTc/FoZctI0ali0yUZoPhQXc7BXDz4R/6SKQ61VkLXLNfzTA32sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IVDUkrRE; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2M5hlAMsu/8YEkFv3Tz4tF9+f/2fzGWHk+leEyz1u9if5i3ng4Ymxkj281ZhnXg+oTd/3g7vKaGgcq+/8fFdLMaLogd2wrfSltBjExActoTHepXGb0leztbqscA3P79uayCarM1S6QULBIw/sqVCWqxh6k5CDmk1D36lwUuLD+Ld+8PFpegR3tdGY4ToS4ufgxZUIG5fursOkv6iRxBaQctr4W9DxpVwgGqeASefaTdxKSC70p0VMQp25L7DaUW66gjO+le6N1ChG71VzCUYQo5gVX/xfTvJE9l0lp+M0HkA+wyjfekrdhclEdgSqivKBIf3XaR6o7knqqv+c135A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhs5Wj2lkaQBtimO3sPwIuCjlqpc8bAlqpB0PXCIhRg=;
 b=exfzmPQd+cXZpzpRrzd3wgukQEoam3jCFFwO/ZUuGc+kPLXf7oba0wIG4AlK7VmGS4qs5K9O9H8s2YIJe8CZAHsmukGb2XqTfbmRR3vMes13C0/9aqh0N66LW06YmpsOfBN+NpsOEZy2pvNg7lBnEPAG8le92ZeMJ72YtVyfufTdNgR3ht96ed7WsRL8RuU7GYlL1pf+lQUDBGaLiQyNzM9IzynODn0+6PdoH0CL6m9Nx7vx6bU9DNWcbDtfpq0TV5nYPeO3yJk4jF+IGGkd0+6xQVCn4YTimlRICatJQkU8RZcQyIlqXrevY1sedwXFDH++8HegpXiabccMotz2kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhs5Wj2lkaQBtimO3sPwIuCjlqpc8bAlqpB0PXCIhRg=;
 b=IVDUkrRErb7gYFKM0vsp2CAFwf4gxGQ8Ue1pYSTZacH5boXW898djq20lfZNB2/IfQm4a0HPpyjyD9Ysv2sbBB1lEELco1Zz2PJT8tiZsPaAqII3tnUpQqkh19CuzWFFxWtny8QUX3npQkWbSymF6B2uH1o1EcUqfcBWR0IU8Yg=
Received: from SJ0PR03CA0375.namprd03.prod.outlook.com (2603:10b6:a03:3a1::20)
 by PH7PR12MB8594.namprd12.prod.outlook.com (2603:10b6:510:1b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Mon, 30 Dec
 2024 21:45:34 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::89) by SJ0PR03CA0375.outlook.office365.com
 (2603:10b6:a03:3a1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.18 via Frontend Transport; Mon,
 30 Dec 2024 21:45:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:33 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:33 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:32 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 27/27] sfc: support pio mapping based on cxl
Date: Mon, 30 Dec 2024 21:44:45 +0000
Message-ID: <20241230214445.27602-28-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|PH7PR12MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a1ade8-7c2f-4f5d-973a-08dd291b4a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vwrVjptfE4necIJuATBugZjK6V5qC02KVoCIWvdNQRjJGV9yueaejKBTp2Pn?=
 =?us-ascii?Q?ko29uc5XTyq+064nADd/RtBUCustT63h1/bL0liwi6Bb9owR3xG6U3vqtV1S?=
 =?us-ascii?Q?PF81Q95Upg7WLOfbPvWCkU7NYPhjdgls5rMSXr7/zO9BmQ9FqCXxKfhgMIo7?=
 =?us-ascii?Q?28t8pLEWigWct7oGbV/b+3Ymm1jQsVfIbEeGzcBAvb0Q78qLrAubEv6nroYL?=
 =?us-ascii?Q?Tr7qnqUUScV1/ogkBbx1ZWrrmCOcOr3+REECKGcJ1QZ5JuhIT8khEWWQVQUQ?=
 =?us-ascii?Q?3ge9zTqYC0ur2sY/WNLmRM6wRRCmP4h90R+mr1V4VrYNM2otIF2gwAxb+ZkM?=
 =?us-ascii?Q?J174CE1q3uVZpexbeRYi1Ij6plBCyed5Ga4nMQXVLoNq/LgPct8S1/YaeJV/?=
 =?us-ascii?Q?04B4UFsXNTvqQRQk20YOWpizanxfcwBB6vEizi1HSLwwDQgDAT9hq4SIal9f?=
 =?us-ascii?Q?s2DHqo/nCRAmuPyFzlot3HWQ38WWx0aplBipWLpFJ2rkWch8npzhg6TFD9WM?=
 =?us-ascii?Q?8YVQoq8SolhPzESnnHxOYgeJBltXj0zxQiDsHOnyRXbeCG2AYn2W5cSkDPr9?=
 =?us-ascii?Q?c91khD9F72SoLdSO9dUogna1QVg0i8U6nvQJHq0OmxVYQ9OyudSCT3FNfuBe?=
 =?us-ascii?Q?Bt7szVxAe1eTVAroGK0CmjOf5S5oUseSON34+xA+R6wfNgHpuWkwl22tMS4s?=
 =?us-ascii?Q?bLa6AKp50x/c+rkYA6Psn4TAcfYQCBTx++ys69MrfBTWoWRAcGqBo+tJ2uaN?=
 =?us-ascii?Q?qqR4Hr7ZPQtwM4rIhPxG1gUDILGE8pHH4sSJMCiuXHcktmGN+oZ4bhiNVFSh?=
 =?us-ascii?Q?I6+vOS7cKlw2K9oYomiJfrC4eOmy4jzE3WQXsERpvzfHZIkAc11DzCd+inNq?=
 =?us-ascii?Q?9LpUaWlD2L4xPmol23ukB4Xr69FdMfxhtSrQRLkbJoqpurHKQtMBFbXgbjQ1?=
 =?us-ascii?Q?C85jBImpFxZx50kA+FWdjJrnsnXIRo2itfl0PCH24v61brkz2In7hf61H2ah?=
 =?us-ascii?Q?edrqdVAKZDp1+zNLdWvr3kj/QpAyo/9z7JUFpBEVRiLZOa/QnH+tir56Czpg?=
 =?us-ascii?Q?5FvIHW/KXKnjz1IREag29DBobLWJNFsORlHBj4tzxV4BryAE1pdXP7phN5nQ?=
 =?us-ascii?Q?hEKjqftDlAJYJ2uNGyCZ6wdSbFIhvGazAdxVBNCvpjeIHIHpkOgc7Lgvt9e9?=
 =?us-ascii?Q?rJkkoh4fp7KSBkeJUWWG/nLD7YMEB2Rt6x5P5lzdAkmgxrpR00HojHCWrBrI?=
 =?us-ascii?Q?9fKG47QCZGBXgmmqBAd6HzM1HhWch2HWQ1FjtdbORaVtYUQEarn2HY2fFqSw?=
 =?us-ascii?Q?XupA7fVjNYtxHYPCwYqZ5YE/+rSuG6X9tsiD8lho8l1pQM74PHSUaVSxlnYj?=
 =?us-ascii?Q?ONgm9hqpqQbMop7LlrRCvzoT4zkVZdqPTjspplRyPpwOYJLPRnNITh94FsES?=
 =?us-ascii?Q?LNPDsE5Vc46iRndFM5hJOXdI0SvYcp6Afi1I5mlVTizmAjAbes5iNc5MN3r2?=
 =?us-ascii?Q?S2CxILwpAgtGT7A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:34.6917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a1ade8-7c2f-4f5d-973a-08dd291b4a90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8594

From: Alejandro Lucero <alucerop@amd.com>

With a device supporting CXL and successfully initialised, use the cxl
region to map the memory range and use this mapping for PIO buffers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef10.c       | 50 +++++++++++++++++++++++----
 drivers/net/ethernet/sfc/efx_cxl.c    | 18 ++++++++++
 drivers/net/ethernet/sfc/net_driver.h |  2 ++
 drivers/net/ethernet/sfc/nic.h        |  3 ++
 4 files changed, 66 insertions(+), 7 deletions(-)

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
index 30d51dc94b43..f2dad9881b5a 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -27,6 +27,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	resource_size_t max_size;
 	struct efx_cxl *cxl;
 	struct resource res;
+	struct range range;
 	u16 dvsec;
 	int rc;
 
@@ -136,10 +137,26 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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
 err_memdev:
@@ -154,6 +171,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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


