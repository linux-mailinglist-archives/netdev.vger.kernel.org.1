Return-Path: <netdev+bounces-243804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F16F5CA7815
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 13:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B68B13122592
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 12:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E093314CD;
	Fri,  5 Dec 2025 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NmjNWoB+"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013022.outbound.protection.outlook.com [40.107.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0286C32C936;
	Fri,  5 Dec 2025 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935631; cv=fail; b=ihbaqbMVtLQVwnvD9PA6ple6hhb1kemRugo+fk4CzlGLne7pMWJpOcvjhSgOAfnhDaT16V2dijn7Fyq9NScy5aezHMkGLDC5HpnjD9SG5gSXdMcDJTbXy0dJRS3U+VNQMPRyWjJNC8G4rOxQmg/IC8mys0QdnQ9Cu/rbf7EoLvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935631; c=relaxed/simple;
	bh=LZt+FAn4lIFWBgXPL3ToS0bMB6gF5GFV8BjX1trDXUY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pm8H8JvGivDJDuhSVtaWoHg6MDonVCyXGUT5paoO0BvJLfRhfFjDxigPBuk1Fei0XI9zjH6mA/yLL6UwGAOye7bdiS3huREHw6uqOV79HTDY6RRm7C0t960969OvzJznvOHqSsWyMzdVaOFdaUmmpu+il08Xl1PeOM216rTQgZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NmjNWoB+; arc=fail smtp.client-ip=40.107.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oqw4BR+U/zYbAC4Wwab0jWkgeN+n5KWquiq/Rfl5x6qZoVTi3htUJMpVFWoqkyYUok4lbGL/GTWSmOQxfFh3XpRm+CSuUJasTjI/XTq5jfGvX6An9YXI2XJRPLlAhk901GNfk7nk6lOzrIHys9F5uozhz8IPcirJI28nVSypAWj5YbSZNNaZKhww9JdRbGP1YDD5CiDu9yenyhOSARBLRZU0RW+UQzngJt4N01AlVjUwcHD97CNb/DcQFyGDwEaAeOI/wgnydxRJbZceEsllfdStWmAiNo5qZ9zKrMbAJHzzWlxWlOdpoQCjbC6e5WNSK8f7K1tKKISafcZC0XMNOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD2GMa7asjD5eDACsvxutaMxsFeXGv7s58CX8RcGUGE=;
 b=UjbobaLddS4MEdytZaZYwEX9DqtVM+CtoPMPjg041uL8uRkuTHBvIUAyMzjvR/qGCsbAeFpOn9mjug1hk5rqNIW2ILGHAI98CdD/5+dcsQF3BvhMThuU7R0C0+E7heBEJYcVvxqRHdLmuxrdAS9jLYurLkDY2pVwg/D+iECwZRtLIbxme9l6ZjtB2qeFH60Xvsi5Ejh0EZOLul+2+LIG105NquXk9X7SbVZIArjx5SmgxJtXy5iZAm5XIuKBNKm5s2Y4PzzbPKqLNUsKIEnYv208d8YvAJ6sJ8xQvk/9va9/qKVO039r/k2m0G76G9DNW48I54OLdn//7MTQZJ9cxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD2GMa7asjD5eDACsvxutaMxsFeXGv7s58CX8RcGUGE=;
 b=NmjNWoB+VzxWjRdzZLiPQGEzyap8qIeAiXVG55YLZbbvwQmHyb9JQzC/4PAB3SnmVRwH7W5bQ7cyEmSk2wOmVUoTd/LwxVqbkoJPqUaVJoCDxXzMPqvx9Sf4EybYjN3Cd2qJgT11u0+3tDaBUqAcSCiUpvpU01/SJHtRlWP00s0=
Received: from SA0PR12CA0011.namprd12.prod.outlook.com (2603:10b6:806:6f::16)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 11:53:37 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:6f:cafe::eb) by SA0PR12CA0011.outlook.office365.com
 (2603:10b6:806:6f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 11:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 11:53:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:35 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:34 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v22 25/25] sfc: support pio mapping based on cxl
Date: Fri, 5 Dec 2025 11:52:48 +0000
Message-ID: <20251205115248.772945-26-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: 9481d331-85f9-4244-8ece-08de33f4ece4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vUqSMiNSHDxd3Z7mC9TyAerL3eengzac80ZU9k+cVGFJSFpXTOZe4ocg4apq?=
 =?us-ascii?Q?YVIOKOvhPcME3PXKjUang16rolLwNG50Gpypv+3sjtQ6+bQrNyCDBXssu9YX?=
 =?us-ascii?Q?UGEk/yOXTfBqBvZ+qT2rfHeMGmLnXehkZchrC2zU4YES3VCOi7ylESqgiRsj?=
 =?us-ascii?Q?XDNuLSg9w6CHgBKs29gocKX8ETD7G7MAgrWG4NmCP0u+8Ahz1BjmgBzS5IpZ?=
 =?us-ascii?Q?NZBidqmO9fieI6MOgdwiesPmzfveycT0tjo3/ibwhIbp64AtrF5MnwCCUhnr?=
 =?us-ascii?Q?rV0+BmfODPVfSrINxdfrQfHsk9h4CzYlGl+VqsMfuvg9MFGhJAgiia/+Y/tp?=
 =?us-ascii?Q?zvFAh1fncDaRYfzNTwf4BBAv5ynceOZM2wA3Bh8MlgDnIWb4ODP88lX4VHj9?=
 =?us-ascii?Q?ysJViza05Po3fFjJD+BhrBXqwrlFqe+OjaJ+AKvSeEVgwiP6yVEuLPvBc1oU?=
 =?us-ascii?Q?1c/JTLCG1zYm9YvdJUo/XhtDaumWHJA33Yemf2BhM3lWAphjlRajjic6TQ/S?=
 =?us-ascii?Q?Rao0buOX2fN+2FvPRh6h9q2HToiCaG58hr+7RICh21BD15dPxyNPoEni+tjr?=
 =?us-ascii?Q?UDo8V+3CmuniQmzjel6YgTLDEqhLZefMOKk7F7wDJIrwbu1gNEDLnBvdNbgz?=
 =?us-ascii?Q?Gsc5xt1HyJFfl+p2QW6V2pfD7os0NbwwFTOJaYeXjd240UCX1oqMyTp34XFS?=
 =?us-ascii?Q?MCoHWJ0i3LPnOd+jzqbtY+JO97RiTsbYpY2Nw3b7iyxLP2g+XlFH4PqGBhzc?=
 =?us-ascii?Q?2dTmFGKwG8CNhc+byc9BgzqPgTwePRnfn9/l+t1CtQ+bRQKpiAmn0HsCerOW?=
 =?us-ascii?Q?KDbGdpquvfMu1UUWrj/MZEJ7xiT0rtnWr7BrnBwkGwkoBqeNzijKYZDBXzaw?=
 =?us-ascii?Q?/iFVPjLu/iYWyXrn0EBhKKeSq6FomOrRUKw1JtklmTVsp8emM9Rmg+4u0dpC?=
 =?us-ascii?Q?egcuQui825zNehHgZQishSiBsMtpsImeWQQxB8J5K8Yy9O9qgsyb0nRdRdqo?=
 =?us-ascii?Q?CEhc8++nETJ6X1hM1g7dePk/lkql6KUx9R4SVH62h+SAS0hyokT7r8U1JD8M?=
 =?us-ascii?Q?Fwg9rkwSGmVWRQXIF8DCAEhizxB9JxaToyZe8w+5BAdVzt5xLdMVTmzqnAkv?=
 =?us-ascii?Q?ApnBDxLejkJjQLoQJl0VxqGmoXC0d/Gen6GR9/nJYAc8LbwU/T0c8aro8gPE?=
 =?us-ascii?Q?+Zye8AZAQJmvPY8QSig2UYlCrfa4b8iyUlGb2uEtzi0KRAXwSBi33AmVQ3GY?=
 =?us-ascii?Q?9JpMM52I7wtdAKksAleTSEktWYqbhkeNzjGbnw3kT5Ekg0uNIjYr3a56UOcA?=
 =?us-ascii?Q?OwoeWV5Qtgv+KCqj7RdgF1AHvnSKMlGhl7RnyaPP70MPd00E9oeZeqzkb9JF?=
 =?us-ascii?Q?cSmpevk3o82qKQAix68vI99AJ+lUVTu3fLjwbe+xULhU3pBH18CglFW3nR3w?=
 =?us-ascii?Q?3TXPGgh9jdyKL+UP0C+hzwJ1pXzryW8MDICs2kATFLhVsYIBVu0cmZ0MAePH?=
 =?us-ascii?Q?BLmmVTMZOHJ7JmFT94v6JF3lojOPAjb50qggSFE7GYkOlf+sMCSxgt3+VX7u?=
 =?us-ascii?Q?qp2+THUbaZ27hOEz8SA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:37.1979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9481d331-85f9-4244-8ece-08de33f4ece4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5628

From: Alejandro Lucero <alucerop@amd.com>

A PIO buffer is a region of device memory to which the driver can write a
packet for TX, with the device handling the transmit doorbell without
requiring a DMA for getting the packet data, which helps reducing latency
in certain exchanges. With CXL mem protocol this latency can be lowered
further.

With a device supporting CXL and successfully initialised, use the cxl
region to map the memory range and use this mapping for PIO buffers.

Add the disabling of those CXL-based PIO buffers if the callback for
potential cxl endpoint removal by the CXL code happens.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/ef10.c       | 50 +++++++++++++++++++++++----
 drivers/net/ethernet/sfc/efx_cxl.c    | 39 +++++++++++++++------
 drivers/net/ethernet/sfc/net_driver.h |  2 ++
 drivers/net/ethernet/sfc/nic.h        |  3 ++
 4 files changed, 77 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index fcec81f862ec..2bb6d3136c7c 100644
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
index 18b487d0cac3..024a92632c56 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -11,6 +11,7 @@
 #include <cxl/pci.h>
 #include "net_driver.h"
 #include "efx_cxl.h"
+#include "efx.h"
 
 #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
 
@@ -140,15 +141,35 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1);
 		if (IS_ERR(cxl->efx_region)) {
 			pci_err(pci_dev, "CXL accel create region failed");
-			cxl_put_root_decoder(cxl->cxlrd);
-			cxl_dpa_free(cxl->cxled);
-			return PTR_ERR(cxl->efx_region);
+			rc = PTR_ERR(cxl->efx_region);
+			goto err_dpa;
+		}
+
+		rc = cxl_get_region_range(cxl->efx_region, &range);
+		if (rc) {
+			pci_err(pci_dev, "CXL getting regions params failed");
+			goto err_detach;
+		}
+
+		cxl->ctpio_cxl = ioremap(range.start, range.end - range.start + 1);
+		if (!cxl->ctpio_cxl) {
+			pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
+			rc = -ENOMEM;
+			goto err_detach;
 		}
 	}
 
 	probe_data->cxl = cxl;
+	probe_data->cxl_pio_initialised = true;
 
 	return 0;
+
+err_detach:
+	cxl_decoder_detach(NULL, cxl->cxled, 0, DETACH_INVALIDATE);
+err_dpa:
+	cxl_put_root_decoder(cxl->cxlrd);
+	cxl_dpa_free(cxl->cxled);
+	return rc;
 }
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
@@ -156,13 +177,11 @@ void efx_cxl_exit(struct efx_probe_data *probe_data)
 	if (!probe_data->cxl)
 		return;
 
-	if (probe_data->cxl->hdm_was_committed) {
-		iounmap(probe_data->cxl->ctpio_cxl);
-		cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0,
-				   DETACH_INVALIDATE);
-	} else {
-		cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0,
-				   DETACH_INVALIDATE);
+	iounmap(probe_data->cxl->ctpio_cxl);
+	cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0,
+			   DETACH_INVALIDATE);
+
+	if (!probe_data->cxl->hdm_was_committed) {
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 	}
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 3964b2c56609..bea4eecdf842 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1207,6 +1207,7 @@ struct efx_cxl;
  * @efx: Efx NIC details
  * @cxl: details of related cxl objects
  * @cxl_pio_initialised: cxl initialization outcome.
+ * @cxl_pio_in_use: PIO using CXL mapping
  */
 struct efx_probe_data {
 	struct pci_dev *pci_dev;
@@ -1214,6 +1215,7 @@ struct efx_probe_data {
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


