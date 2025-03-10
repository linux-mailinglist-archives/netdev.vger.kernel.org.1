Return-Path: <netdev+bounces-173675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A5CA5A594
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 560437A319B
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A721E25E1;
	Mon, 10 Mar 2025 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lvMeJVSh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058211DF739;
	Mon, 10 Mar 2025 21:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640673; cv=fail; b=DfiO3mFzQMEg34Ckn02CWy/tAazBrtCPKBCfUXsxBucvEvvpxN6HZYA3xghGEYC/4dr59+HwfUJtVQt1JbooJh7KO1pjCN31LyQyqZqfeHZIN+gaLFP/NEQ3z/mGFXcexBp1A6rH5yISM0Lq0+/6cWCL+dEvOr3xnxgyfa2GKOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640673; c=relaxed/simple;
	bh=pBKbg6Q2w5L5aCvjPz0xDHLtuRxvssaKCuxLhBbsN3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQsma5kRzvJjrSVC+Cy+406z0Tu0SCK5wFrgEiP6Jo+PofA+pGYQfX0xYVCBqdBRxTcQQTqYwPZzVN7pG1pbRS5fkIZwsK12AkyMfFdEjh1bztpXpOfmDnH9qaZ2BcHJPEzalLc3okDM1gj3nG9z4WPG9oR40N9YWAL6Ym/sujU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lvMeJVSh; arc=fail smtp.client-ip=40.107.95.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RE7BJjIBNtYZbhAMFdk4ZIUq/VuNPd/bRAJUpNCephF9/59cx6BdHTbrxbCXpKkhuf7wuJXdSlKRdGiMXN6fMq0B1AG3Wqz52TiePonA3bEaSyuOnUjrIkFIbU7Wtij+oqaCC0cvKybof8sEphO5IUSxUEcjCGOzeTTrVEQEuCPjmBwLLgzGgsy2JSJYxftwrnp1UBsn4ohtWHLTbpXKuZJuWppNySd05vyVjgG90SU5+YiAMnojb7qSc5DtEmrnpyoRvPSHj1JbZ08KkTYOD9aFW3j2UuE36BhRfgCJItOoIbPCfqN7/ZARiYEhl1sP/pPt55cT+5ZwUKGhNjl0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ac7aw7KzUt66tfv7JpvtFGVWDirj1zxlhcfV46oV1yI=;
 b=Fvg4t2d3TS5vcbmRX08c9WlC0h7H1hh+bGGpJyUxtWeoJ3taRmX/RwgjyqqdYfp70lEaBNfXVsDsqQgw30jkEEbtyZcQb1YkTxxbTOk0ZJKYFtUJw1944Wb7SmcRVb55Go4EenGNcjnscO3E3Pmj/2tfHYZ96wGEMKUmIL0ok5hnmANg37HOr6ITgj/LsWt0lWzfYahGa2p8jkfxruCbKheZOD7ofHIQWYS/sxsh9jP1Gr7ZaM413JAq46b0lfOjbW/4msl4jebdR8KEvtE8DcI7gTYD02ninhROCuruQFpGuSQVluScoorjW86jXvYABpytppOedK05ktALXYYePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac7aw7KzUt66tfv7JpvtFGVWDirj1zxlhcfV46oV1yI=;
 b=lvMeJVSh8I6pEiY8KVjpuTxj7Igyr8W2NrA97Zkf/H7qxxTnKfB7ULy2Rf4d3PWIvLfdmds4qPqJ9Ra2U+GWxs6DNpXEYLWt/DIfA/tA2u2K1tRbhnjlh6momOAoou89GqI+xjNluQT5GJasirX5iHKRcNUI3dYDTqqzMB9FCps=
Received: from SJ0PR03CA0188.namprd03.prod.outlook.com (2603:10b6:a03:2ef::13)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:04:28 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::62) by SJ0PR03CA0188.outlook.office365.com
 (2603:10b6:a03:2ef::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 21:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:04:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:26 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:04:24 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH v11 23/23] sfc: support pio mapping based on cxl
Date: Mon, 10 Mar 2025 21:03:40 +0000
Message-ID: <20250310210340.3234884-24-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: fa70a7d2-c3ec-4fd5-d964-08dd60172573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4ZulI+YYe1OdU7Zs/pF6fiWCLxLJIGkZPjjJgRbD/zElHEsKJTjRZZTheO5z?=
 =?us-ascii?Q?WKBG5ibxbLVB3YDsbDnDIjW1PFBp6AoP7rtmtqKZbjmWc7GRjUPTA5krJ4VE?=
 =?us-ascii?Q?Gw+zbfxst7Rnuqo6piJmZVKRz9lsdB4jjpz9JdqffFYlx1T8sTeuyfVCRzBI?=
 =?us-ascii?Q?Ai3MIgHh2yANjTWzm8VBBDe8XfdurjGiaxHoitWYZFRdp5SGron1H4eiZm5y?=
 =?us-ascii?Q?I1oCV8iagObE4TftPOwyWReLPgBzHu2uZiYvyYKy8VQA7uIgzIO3G4CQuVUk?=
 =?us-ascii?Q?82n+mjDg411fpMSZIh6ipDpAC0KmeuMaG1RK5nIitFCr7l0WDM+djLtEJ6ZD?=
 =?us-ascii?Q?mP/A0Kjy7MI8iSd8TTg6hEtNURfhlgJcZArfROyCO54kxGUdS9a1A3HrDB8A?=
 =?us-ascii?Q?JgVvh7GVBcXqViIpoBlQL3ftXKuL0TM42HdDxlRJd8JEAcLujdVtHx6VpuFr?=
 =?us-ascii?Q?NNmDS9gvd/HhtwBv+uv9DwsvEV0bmQssbf+mm6PXATzrfruyG8YtDofhExKt?=
 =?us-ascii?Q?AN7Mj8gpbRlRIgUN4PWZSwAVrDG8vxTtuZ58eTGTSqJjeH6zL3f/p5Dmbmvi?=
 =?us-ascii?Q?wTA1wxiNJ9BJL0+xuWnq2e+ookJKJKo6GqRyX9Trie5s9g+44L1PwFOIIHYm?=
 =?us-ascii?Q?x9OJpDlNE9+ubhUq8lc/P49GAcu9opfte24W47U0oF6aOqnt5To9I9yuEvI2?=
 =?us-ascii?Q?he/ufRvpc0Uk0bwzrDhcnpbcPsrpIYMmHS12+qXvR1bJzklLRXekiBAvEUcL?=
 =?us-ascii?Q?MvJyP23/Jy+sns9mjlSebossg01vyoSMBNhRLA7VG1m0jJHE47a05yhL8mSp?=
 =?us-ascii?Q?VKLmtNx0aInHVLnKLS7ACzBpqiHWIFH/hRLTKaiRhoDRhv2uYZM/x6f0t8ZC?=
 =?us-ascii?Q?xUT3sFqHr5JtNHTt+GL4etjScFkk1A6YIX9Gi34dGl2LpfihKei1MaMk3Er7?=
 =?us-ascii?Q?C6Dd/mxIav/7c/GdWKo4P9O8Fne9baCYrcSVYe7UFsCgdAlnfvscPe0fATy+?=
 =?us-ascii?Q?/LjkLC8/fJuRVSt1FUpP4KGau7ddr46ymzxzxXypV8dEmPo0qBuvqhjLJNTX?=
 =?us-ascii?Q?8CT5pv3x+eGPBoIDvVlkFKe+cKyVJCmaor/rbsOanc6OohUDEaL1Dbue1CwF?=
 =?us-ascii?Q?6ResDAH5Gs7RuDV0W7ireb6N2bHupeehs2IMrziNYbKlAtT9Jatq+MdPVMhi?=
 =?us-ascii?Q?U0gdRvCGaeMTg+vY/ZdDzOGbcfVNIH3oXA7hcDdGEVdjtfEIE3CYpSIkfQnB?=
 =?us-ascii?Q?eT5n6WGN2PURwS8rTeG5Nc48NG5WPgGbgbNOwwlAi0L+RGjwiJmCgK3K5iFP?=
 =?us-ascii?Q?inayJEOmTfKV15HzPamQ7yjvbnD1QDjIc9Kcbo379Fgoj4/vR5nibTkswz5x?=
 =?us-ascii?Q?qR5JRDshbkLwnT9La4HTGMw/cOLCsl9fTBnK5AMtOkzBPpliGJudo2NjO9vs?=
 =?us-ascii?Q?wFC8QtTQwLj0yzxZvRqbM3I5W40sdKv7hiUFGksDv+BTG8gqjXi/NNu5u9eJ?=
 =?us-ascii?Q?/vp8teDZxUIhguM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:04:28.3623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa70a7d2-c3ec-4fd5-d964-08dd60172573
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940

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


