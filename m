Return-Path: <netdev+bounces-189832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5407AB3D3D
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA40619E4E44
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3124E294A1B;
	Mon, 12 May 2025 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BZlMrOYJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE312949EA;
	Mon, 12 May 2025 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066305; cv=fail; b=S7mRJGLo/oJXh0a7x/P5TzpNk4dN+8Ut0AKLup7NrDhYCitt1zt/cLB1eeM6k8u00l/EV55Qn9xqTRnFAmPtcxy6KLYh53nsIxF+FGNn2BqhHR1pctT3xW+1TsWZ60wwDq2H7d0F7lIkU7icWlY3bIPCRFTp5/3g9Ud3S5deByM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066305; c=relaxed/simple;
	bh=CQvToMn0Hkj45sUdPWqmW0TXZcMWaxNTXQA8DGudPck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+5E4fX8c52xHvw6NZg6VEPgoxRxp+coNIRUmsGUGTklROn7MFlEMaBg9mriAbtJqeDvKR8fe6mOi0HMB7mZWhxq/eEhHoqfKUKY+I7UwZYltTtBceWS8Mw+eAig1HFv/BvTKW3JUe6+fJoe+K9c1KOinOgZcchmvyastyi5d18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BZlMrOYJ; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dlod4/x+vjNrQHRYLt9iq1WKvSb5E2qvRCOZL2quox8Yk7OEWhEOx+zUWxp5x8jk3rlE6FwVqYdhJrKBAK3e/qdYtUMMtshVAaxFDPmw+srYwMaW8hWm6FkOPNVcA0WPtPVm5GbI1c7ZpjVRyaDiwb2D0xbhhSpO1OMZ2MTYNlDHMluoVdcNKeQgpTjCCpuZuW2Yk7YPH1705mpFcbBSQfDhoS8wastuaMRsbaVDf4oR2j9EeVcFak+6syajd3x9nZcW42WikYd4XT3Hs/5mCuatcO/qwXapmkt5jMuI+0XClLyqG8a62uui1MRmcro0PTngQxrp1oOXY7NQNw9SMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUoPjnEpEFSYl2Nw8MbPencdCLXzn3lhwPZI0x0O06o=;
 b=S8uI7xn6nOhc5qZN3zBpkhiCKyB6mHJvEiug3QtMNwkcIG38PK2faIZTW7FseLIVnUD86S4vpRcOKxx+VXdPgorS/27O+x3rM4pgODaoWSyYhXe/+b08d/AdTacpz9skVWMC04+2feq7sGYy26svX5MFyOIjMW0Z66JtHX2t4Nh1JUIakzxRWN/kz5Z/2VxG+9kvYfoVIiwA/vPa6FZElxdOQXMjCEInpUNdMfxfjMRglWul4xANWZVXy75CToQZbpGxov7IcDp+JFTReGSL+LTR/lvSnc6oDlLsJB+rWBR4CnqqhyMzOvPPWpfkpJL6pgruj4CZ8LksEh9eNplarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUoPjnEpEFSYl2Nw8MbPencdCLXzn3lhwPZI0x0O06o=;
 b=BZlMrOYJjAEaU+qJCtQNni1VPnS2yReREzMr1J7C1anypuThMFOVfy9w6BxCGCmvUWNRU4kHS3qYF2WMDMG431YrnSTsbXeHy+IdqbvbwTbY5mFpkgm+/7e5aXZNmQdXM4t9N0FK968TWqhXsh5fNpUfSDnDrBO0sb00xKty2mE=
Received: from SN6PR16CA0060.namprd16.prod.outlook.com (2603:10b6:805:ca::37)
 by SA3PR12MB8439.namprd12.prod.outlook.com (2603:10b6:806:2f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Mon, 12 May
 2025 16:11:41 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:805:ca:cafe::2d) by SN6PR16CA0060.outlook.office365.com
 (2603:10b6:805:ca::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Mon,
 12 May 2025 16:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:39 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:38 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v15 22/22] sfc: support pio mapping based on cxl
Date: Mon, 12 May 2025 17:10:55 +0100
Message-ID: <20250512161055.4100442-23-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|SA3PR12MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: fb549ff7-afcf-4a3a-cdde-08dd916fae99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7ps+pEsSRB0N/DgsBUBuhWyn+VxNBpOPjbN9HrWmOxVa5kdb/0s8XpPU2RLx?=
 =?us-ascii?Q?JpyG2zfJU2d6zlEe1aj1rXoPLRV2cS/xy096jPIqGStIzoP/Z5sFkDUNBCn7?=
 =?us-ascii?Q?AmPLi4HpO8vMPpI+xe7lztZ6SuMUtaY+ry/347Y5HaWfhtfp5uc6BBYqaoKA?=
 =?us-ascii?Q?ckmXsn7H/D4gnfcIPubfuLiXafUn5Ovm5gHTgGmGrn98ObBOsoKW6MQU7m+P?=
 =?us-ascii?Q?KB7e1D3PNE47V8Wsx/Cjoz06xkEw6ckNL/NO9TNsIj+TQWzUZsQbzBhSvIaN?=
 =?us-ascii?Q?qYRvqTozueaJ9+VesRPa7ZlSNVs5BzWjd/d8odn4S7/5hSU3qL1hznsslIFS?=
 =?us-ascii?Q?B1WYVrnpTiJDRWT1gcJ9AxfBBFCjv+4qF6B/gEyvuXZ+VryZ51gPsG2tV6KO?=
 =?us-ascii?Q?nABK6mpxYcgY9sFBDSZ0h6pzWSRBfv0bJmB+3qAZLlyrhSf8pd778EKg1jeZ?=
 =?us-ascii?Q?UE6VUaINa6BMCw9XrLUh3BJdEWzFepo027paKssBAt1wHdljKiDjOsA0oZCM?=
 =?us-ascii?Q?iwINLB4ibijEjHEfz5byF2dU4SnPzJ1fiUx9OoBMKEzcWl1+b3cKVAsjpjz5?=
 =?us-ascii?Q?2TYOk1HNJnU5ZEf1sVtenuLFvqCerYGKAgqD6t6Kmf11/fCg7BJWoEI2ukvP?=
 =?us-ascii?Q?W5JUFJ8LDZqCTP8nfIh84tRrL3N6t193a3el+7diprHGNB7weNLzS3Yj2ldV?=
 =?us-ascii?Q?0WZg2zz6g68cMchDD7zeW4TjBLooGhOSVT8jp/J7cJwZonrYJ5rjfSPyHXVb?=
 =?us-ascii?Q?vleavM/BoAuQ18+YG3xWPdb3u0L6ZXYR4/nw08jAG/yvlGG5F0soIkJ1oN9d?=
 =?us-ascii?Q?2K5EesXWWg30Kv8CXJyWyZ4UeiafSMUyN+ck4vQJ8K3gxs4xtoX2jF67C4Tz?=
 =?us-ascii?Q?Qgqu5Ak/w62aiekOdTiOanrLOgtdNKKm23e063tEOJPybuOdGtXvWLni2QB/?=
 =?us-ascii?Q?NCvieDMBjxi+rTPiiBqjpmg6b77l9unLDn/mNXOmO3wwCOjjB0/pMBUwgxzW?=
 =?us-ascii?Q?NDHvOdp3OYgymsNIwLbt7kgxudV+Y037QBsQ2SdB0TDZsuwJHmuvu8YTALbE?=
 =?us-ascii?Q?F33MdtJgW2/imS60kyt7dyEojqK99Wj5Lsagy7jr04PiiM5pky4qcE+QiuoK?=
 =?us-ascii?Q?Kr+deomf2KHcZn5hn1kk5X+ocUzBwkwtxFQQ6N2fdG+QwLGwqE15MCRpgHOS?=
 =?us-ascii?Q?lqSNj7Dot+gQaGvMNgGJPXrnFRne7xZlhlxcLJxffB7k2Qh7Fa386lKr12Xs?=
 =?us-ascii?Q?o9b6BsJg3otDLuh//2RZh6LN1o26jwSQJw/B5NkIkYX5pSygBRaFItAXOroo?=
 =?us-ascii?Q?ikAS4aaLN4BSHVwu1dD0oLNtb16ynoBOlACYdrMjthFNs9XI3OnVjakdBHrG?=
 =?us-ascii?Q?xL21WcPckV+rKCYpXyc/5hyfq8oFtN2EnvxiF5sLzBbEcJyaT3r7i1GropvA?=
 =?us-ascii?Q?b8pOxGETMaNJFr1za1w+bPmDNrUC8Qlohbcvv5bTX03coTmK1rP/oFoTgMyL?=
 =?us-ascii?Q?Ykh+Kv8Crh2PC3PcEA7gV+GHKu9aeqciwnxS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:41.2460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb549ff7-afcf-4a3a-cdde-08dd916fae99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8439

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


