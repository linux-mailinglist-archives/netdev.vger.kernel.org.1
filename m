Return-Path: <netdev+bounces-178332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E547CA76935
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD223B0959
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963F9221F0E;
	Mon, 31 Mar 2025 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TxLir4zH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11hn2205.outbound.protection.outlook.com [52.100.171.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77CA22172C;
	Mon, 31 Mar 2025 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.100.171.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432415; cv=fail; b=pzHi91XNtR6QDbIYwUN5lyUiTTDnA55myDDNCSm5ppxbqxCBI6iSgKYCG6rSXp7MuSxJ5Ig4ceykkZGLgO5rTEx6czs66t0LzB5rASX0WzGHhSiPz6sPOsXiXGvZYtzKpLOVBgWSJEZoLyGicX54Bsr2Jzj/A6WoQvcP/+5LNso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432415; c=relaxed/simple;
	bh=pBKbg6Q2w5L5aCvjPz0xDHLtuRxvssaKCuxLhBbsN3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yz81dsxCi9cZMjm7BA9E55KFTjBx00lvzhibdtbhQQ1Hmo/78F7FYqUyNbelJ3j0CsMyGyEyBg7qgEOthk2ovcSOVza5iNDHwlBvF8zxu+9e3LfBVltLuP/KWiqQPkERPC9hZC0I2NsAMS5oKvOqfiZBEVCywWCSlwJYt1iurFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TxLir4zH; arc=fail smtp.client-ip=52.100.171.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZW259lzj1+DwcyUw0g0xdaZEKB9ph0pMK6LnxyhQFAxxcJvEzTHjoEFq2DnIyzfyYVAsKAwrBpHyIWBMUirzyAfJJk6ZSiT6SqWFI2s6nxUh9rXxAL8ltiuOmoftg7P6P36lVfad7bUVjUKv4KQFrFUwtL9L7SJqa9wvSDvkeGdHHfxxgfqlraiNiDSpcFo1+aAZREsHU8dAK2zG9hnB8TBnB1bSEs2KlIIF3Dc3dBBYqnSnbZpbGkewY0Jgwnp3jkQ6DIlmYlvPX7X9yurfGhZu15djPkcBXNdLNH6scDfXLyiitVEKXTNyRAX93uDiUnItXi8wTS5xoB0ox6FTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ac7aw7KzUt66tfv7JpvtFGVWDirj1zxlhcfV46oV1yI=;
 b=fVjQoJmyIBIXW50I1F+jVF550VlH+jNcIXNbTpJrAU0EkJbVNCy7/Gun3lhVMLwNxgNAXw6xZ9cgORaLnpnu31i93sxZgY6mxTOKYBWD+PGObIZvsqPBhqUoTkIy95QZpDM0/T8gs4l1q3xh8aWgzYo0dBwabZH2cfW9HphgWW21IKoRRZRNYMNePREptHlZ8fiVkPilKGs2s9fWvs1QbA+ecxceWjvY458FhkcE4lN8bxgrcjxn7P8ffmD3EhClIEHIZk/6VXuJtXcxgzWprztJV9xSfci+ljuNEMFcg+xxNqQeya7aSHXTv5bDdImvH5MAoId/MXEhsU/B3XEG6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac7aw7KzUt66tfv7JpvtFGVWDirj1zxlhcfV46oV1yI=;
 b=TxLir4zH2X56E3RNgWXWGsix7x3TYYk+1vIS42awcu0IaD1SXoqfzmgbwNZkuZkg4t90awaMJbpElbqgGQkwjrSEccs0X+dN2w3veXDjDfU2aHOpV6ZONHELSCIfQXl2wW+763thIeOI01FnpRYEh3s0BZESzsErStkMAm5reXI=
Received: from PH8P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::17)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 14:46:49 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::47) by PH8P221CA0012.outlook.office365.com
 (2603:10b6:510:2d8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.36 via Frontend Transport; Mon,
 31 Mar 2025 14:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:46 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:45 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH v12 23/23] sfc: support pio mapping based on cxl
Date: Mon, 31 Mar 2025 15:45:55 +0100
Message-ID: <20250331144555.1947819-24-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: e6dd7fcf-b4e1-4380-e6a3-08dd7062ddd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|1800799024|36860700013|82310400026|376014|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WqBaFWVCT+2hJdeC4dMtGNEpQpSCzRNvqv2W/YhYXSo276llUl7zL7H3MmL7?=
 =?us-ascii?Q?7pjCLLvOq+2Hea8AdxVqp1BYIXnsV6ycaCoFQTrfRj9nxsFXjufHt/9g5B1i?=
 =?us-ascii?Q?BYyYfWVWw9ofk4qaJc7L6LgcMM8izPOydOhH/H9epkiIezgwjDJC3YT5JP6B?=
 =?us-ascii?Q?KAHsBCQ6cXij8k42VQn4bNvQo2Bt7vkcEGf349JywIOSJdN0kNNJkfNkaLk+?=
 =?us-ascii?Q?p7ooqeQU2O+rODo6iXWDomx3oU+D/mlJBSNYclxMN1D4F7pBYo4p69DsKSz7?=
 =?us-ascii?Q?AKJ0JubZz6OO3tSukDZExZbZBa89bN0FmmJKAy8YRR8I3oaEBTjZdAVboRsM?=
 =?us-ascii?Q?o3F88/pNdydar/g76PKwnlM16ww6xdpLitHrNjWekqxsA0Iusw8d/qjj1s/G?=
 =?us-ascii?Q?0cY9vHW6ppiM0c+ZCM8G9gnBr1ExZtd2y/+mAloPwxckE5WJtFSecnOwQXjB?=
 =?us-ascii?Q?unxoMmQyCcRITtfLcXAkoUUin/9vB9Aue+vAam3j79wbNwKRRjE7BqW6xovW?=
 =?us-ascii?Q?ieL8A/i2YaSNQpV/YWEE//4GLeIJPzUTYQ8rYt/iTf7enlVmUZ3/Xwy2GTyJ?=
 =?us-ascii?Q?rQoc6QSxLl736l7Oy7FsnwXGN78faXyZrJbxMPZzdcHmEbHmG7SDYT6kNepo?=
 =?us-ascii?Q?hRrVOjVz0oq6R+UYZEoQ1ehVoCDMiJf10XS5tBzGFk/xQ53hJqZxCrFzijDm?=
 =?us-ascii?Q?CrFwCQyWgyl7ASnrVJGXTN4QdzoNe58f/6PqY00oiJV2MMehosYxshKpQS4J?=
 =?us-ascii?Q?yLaT93gb9niH+jS0PPtc2nsmOzcvVa3TG0P9mIs2dH9r5Ltb4dVcQ4mMCYAe?=
 =?us-ascii?Q?XyZJ+RDlrAG82w3mi6Ocf/9Gc3e03g7NAmUJ8rB1KG249tocHoLyDcYHlgcV?=
 =?us-ascii?Q?MY/PGXSjR9wGKdFi2Y+el0cN1MJdMgFx026H7G11//oBb1jbK4zl9JChv3fd?=
 =?us-ascii?Q?ypZJbBJunHr9Qhwim44om21Gb+jOyEsK6g+/e7zXhqmzvLAgmEnlkJQSlGaY?=
 =?us-ascii?Q?xaZ2fPm+AGMJtqqHsQX28o39oPJBJQZBmvwZ8ssQBqBK8hlThTyuLFVwUK/6?=
 =?us-ascii?Q?uy9krGuWZJtni6Bqe2w9nr2zRs159VnneEEYi4qRsyop7pUL19o4y5T+kbpq?=
 =?us-ascii?Q?as1zYcPzSEkPCayWms66N1fABFk/criF1FWKDLF0OuNIW3sf5RnG3TgLMwdP?=
 =?us-ascii?Q?h4wumxPBQAU1IxRQRME7ORG2TipGeIFKve8C0JuZVi5d5ttje9xCherc4g3d?=
 =?us-ascii?Q?OCTSwBx6y0m9febzPIjCxCX1KJGlE7lfcdhmGlB3FyjZq129WvV93StlI9dG?=
 =?us-ascii?Q?BXmcEtJuaAmh/Qnnvi2t9rhZtyeBfm78PPvpD7jK7kOIWu0bhet1czATloGw?=
 =?us-ascii?Q?y/TiLmX+Ztm9wdCzMMg4J8KVKFLh1nE1cTm2G8GhLRMBdKuxpKRsB5mC5vRb?=
 =?us-ascii?Q?L0T6BB8TJYAd1N/6kPYL3VMRvWw3PRA2EEPRF5qfI/jYrxmgn5gCmIqnHw7R?=
 =?us-ascii?Q?NDi/bxQFs45M4Ek=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(34020700016)(1800799024)(36860700013)(82310400026)(376014)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:48.7004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6dd7fcf-b4e1-4380-e6a3-08dd7062ddd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016

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
index 424efc61cc84..04176a33831b 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -26,6 +26,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	resource_size_t max_size;
 	struct efx_cxl *cxl;
+	struct range range;
 	u16 dvsec;
 	int rc;
 
@@ -121,10 +122,26 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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
 	cxl_dpa_free(probe_data->cxl->cxled);
 sfc_put_decoder:
@@ -135,6 +152,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		iounmap(probe_data->cxl->ctpio_cxl);
 		cxl_accel_region_detach(probe_data->cxl->cxled);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index a2626bcd6a41..86cf49a922cb 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1211,6 +1211,7 @@ struct efx_cxl;
  * @efx: Efx NIC details
  * @cxl: details of related cxl objects
  * @cxl_pio_initialised: cxl initialization outcome.
+ * @cxl_pio_in_use: PIO using CXL mapping
  */
 struct efx_probe_data {
 	struct pci_dev *pci_dev;
@@ -1218,6 +1219,7 @@ struct efx_probe_data {
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


