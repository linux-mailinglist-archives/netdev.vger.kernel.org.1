Return-Path: <netdev+bounces-200686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E3DAE684D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945D01BC81CE
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E532D29BA;
	Tue, 24 Jun 2025 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aDQRw+Iu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002DC2D23B8;
	Tue, 24 Jun 2025 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774498; cv=fail; b=E0b1ebyW6y9cDH9wra7YoiSku8aYh9FqtOmfRi3stzrfy0LJyRj95DIhtkiMsh/mp0AoXpHSTQLp085MCdM0bHQKXMgtAZ+pour4WB963eB5UPXh9PURGCEL/OE77xHsqNup6vsGGeLo+dEcAO8v/kinog91fzq+Wt61r87vnIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774498; c=relaxed/simple;
	bh=avS/5qC3QaCoYsRNfx6EiGKcOo5vrOkdDExFyf6PJsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jItv5JtkrZYMhfGwoH1RvlecRSlp02PslfoCd46PlhE0VyEus9g/isVcy9OWjFKtXIpaxA449+pnOSeRKhak7UzDsbeM1lwb3uQ4+cJdqBop0yXW3RE9bbw61us9x4sP/cFwp8tigpK9xwUmgVMhCvoVf+W3+hC7rrBSCbAzAbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aDQRw+Iu; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKmfD3nLZe9JF37gWCz9nJk+4IWKQS1KRd7Ty3HJCQwyrGPvz+qJss0oPMusSRE6TDlq5L+iD8xqhCkM9JQcQR2/cajfRNp3rLh/XVSS+exNY4VLmPvovECF2A1Py1NxZcSDVcWNzg7fmn5Lmry15wL0E4OHOOc1lVFUeddCDFBzDwDpSSDa3vornaF8o52740R32fVC/e8yD+B1sn4QZZn8AjG+/9iBIdp6C331CglSC4Zj2+/gTatCP8YNJykigWpUnkMiKYUQPC3vgpdaaPiYnkTjYRL0H8Wb+acSBHDX/17Kuu9FK7s+XFqp4OZRvduRY7+KxhQuHlJETmKVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VT+EUQSZUETfuCwhuDHZAl+pIHy7eay5eaVL3wtLpPM=;
 b=do3GqoBJRKnuYtHdrqFGoRhmsTOk+Vms6RSzeiT7hzgrRbNDhjHpbUMh8vae/q3ak02gvzL6C9lCP9zJsq3UWUjotK9K2W5JTbkcqpyvbASbk+4u54OcwRn40rk5rGbQXjmhgMhTYLzTwW7+yE3MQhl4txgSPBmxFvealQ2ab1TwSJj8yotq2TXQhNyi7HoMS1r0PZ4K7GbVE2omJMrFsfXLoWHG+P+fmdyyB7lDoAas576XgIMceB3ecjBqDHsRcCojk+mHQS19m55PyAregUjj/284JBKfB7ttPks+zvXX4fETaD4oHIt6YrDUVxDyKRvfZwQcWxN2YOD4un/sKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT+EUQSZUETfuCwhuDHZAl+pIHy7eay5eaVL3wtLpPM=;
 b=aDQRw+IuK2BJGirNbr866NC+eTtOkvKmy5KKcCn1wMOdexaHN9E0ElBns0+8TkgMquL+LSYik9wT6cyp6KtnLDxaMOZq7Vu/mjqzaPWFtpMeMV60FanlNIJmKmKxDXRudw8QXqbgPsJL/2JOlib/Pb84niOUgrtPJTsDZvCjr4U=
Received: from SA9PR10CA0015.namprd10.prod.outlook.com (2603:10b6:806:a7::20)
 by DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 24 Jun
 2025 14:14:50 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::40) by SA9PR10CA0015.outlook.office365.com
 (2603:10b6:806:a7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 14:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:47 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:46 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v17 22/22] sfc: support pio mapping based on cxl
Date: Tue, 24 Jun 2025 15:13:55 +0100
Message-ID: <20250624141355.269056-23-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|DM4PR12MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: cf0bbdf7-ddf4-4c15-acfc-08ddb3297b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oCVe6bb70Ff9mXhsTkpAyn1ag464hV0BXWAQhasKi89WgPDgMX/KT0uc9urZ?=
 =?us-ascii?Q?EXRg1JFILqZOuKU5/wsCjdE6+Rk/oDGQmCKZYnOKjpqO9zaqpS6lN4xDQQpo?=
 =?us-ascii?Q?mE7pNMEOvBzCxNs6yZJKUaXNa2MKeLJSHJrXJW6uOHqaPh3rK8lCWlxE+fJ/?=
 =?us-ascii?Q?zgS6l35oKLe/vyC6UgXqSk9/xMuvEGDEGsQyki/86USGG5Q4geFhooJfAYYx?=
 =?us-ascii?Q?CyLLqFih3sscxPd1gicMmmySQumBCMNAhpWfulGT0YV81w/XMwWRvgZrqh1s?=
 =?us-ascii?Q?5gs4HMmR7pq3WX1VbXru8+ylBBk0LrUIDF2v1kioxx6XrhJGZT23EUTy0pPV?=
 =?us-ascii?Q?y++fAbNUfHhuHYEcOFdWIWqzd4xVf6s9RcH1/MlQx4mswWIjefxqD5tvwWwq?=
 =?us-ascii?Q?5m9M+z2tgPEsCdQQcHl6jZw1Ku2mvl2pDk/PBqCs0Gw6nDKnqYAMD0PwOkn6?=
 =?us-ascii?Q?OTR7etVq5TymeKVCqDuFOeQ0vNBT/URA2hxvrRgioRV2W/LrFAx+Jv3zfdKP?=
 =?us-ascii?Q?C44SvwP5GsBgIiO70YRQdaO1EWpzUUpCg2lms8RPUx+Em2KGDOc6lAwK87tL?=
 =?us-ascii?Q?i50u6gs1CsMPKzOSiSmNApW+T/SJ5bDd4CsNMTD+QRD6tf+et71VcOJdnkuj?=
 =?us-ascii?Q?q/Dk2R4hH6YsJ3Q+FWAzMPnCuDnLRn8Wo4QvtSzlCFCLnq3xlqljz4oPNfPX?=
 =?us-ascii?Q?vuIBl+AobtlLoyuuJeYbgFnqUilKMLPny/tIuW6avikgzMHco8ve7tGFNHDi?=
 =?us-ascii?Q?XMf//e43O2CmigoNQh/FmTQlz3EAqXVUMDISBih+PzeZ9bLR8oFOwzfcoHtz?=
 =?us-ascii?Q?DSbKg6b+JccozFiOzXJuquxUPROwFsDYKg5qERohWlGNuXCpq6LXWuXcLWJr?=
 =?us-ascii?Q?akG+aukice6hIAKqfdOFJJN4xmBCyl75sBgS8GI+q+hh4daLhz88CbqsR0o+?=
 =?us-ascii?Q?uu905+Nnv5Tzu+K1KVhBUz4hd0hGeg35rrj8Eph3tmE3a9UvA6xfdxlstfjW?=
 =?us-ascii?Q?j4xZZVdFvGMU4Wl6xywVS8Q1kJLuKpUkYF5aMPuO91DALcWtnE2uOxn4zrxl?=
 =?us-ascii?Q?4FkLDD7UT61Pn/vrxYpU4KWt/V4vpCaFV83eKPON6Fp4JtulIbyTUkMihAfU?=
 =?us-ascii?Q?5yfl+EDvjrApkvF6PnFadcryW2KYOdHaVFmSgfiHVrNqHNfhXUfeU3imNP2b?=
 =?us-ascii?Q?FCzvZQAeS7BlY+9pc7tscRLgqCybj5GTPsB/mbHrHRZ7yF7dHb2BRG9tv2iT?=
 =?us-ascii?Q?7nL1XLkC57PvJMe58vPdWPVrXK/XvJstsVrFqh+SXgtiF4eu4kjO174n5dGC?=
 =?us-ascii?Q?1lZRDIRd7uW9XbUWsROL599iY1Npkm1SvXGGLFsJcFV80sPvhEpg+9uanRN4?=
 =?us-ascii?Q?yK6BGVfWYGmcANDTrwatZuOUrKwX+3yK2z9bV0XsB0urJLKHloVZ3rPa+GDc?=
 =?us-ascii?Q?ge6ou1i63WVY4Zx3xQYCsuVLMrsFSy8B+emTi0NEkwFutoL1LclHtA+Xjm1R?=
 =?us-ascii?Q?RgW80ZxAAUZ7Vu4+UvgmhC5krF9piSMDU2tq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:50.0795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0bbdf7-ddf4-4c15-acfc-08ddb3297b61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064

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
---
 drivers/net/ethernet/sfc/ef10.c       | 62 ++++++++++++++++++++++++---
 drivers/net/ethernet/sfc/efx.h        |  1 +
 drivers/net/ethernet/sfc/efx_cxl.c    | 21 +++++++++
 drivers/net/ethernet/sfc/net_driver.h |  2 +
 drivers/net/ethernet/sfc/nic.h        |  3 ++
 5 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 47349c148c0c..87904fff40fc 100644
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
 
@@ -771,6 +778,18 @@ static int efx_ef10_alloc_piobufs(struct efx_nic *efx, unsigned int n)
 	return rc;
 }
 
+#ifdef CONFIG_SFC_CXL
+void efx_ef10_disable_piobufs(struct efx_nic *efx)
+{
+	struct efx_tx_queue *tx_queue;
+	struct efx_channel *channel;
+
+	efx_for_each_channel(channel, efx)
+		efx_for_each_channel_tx_queue(tx_queue, channel)
+				tx_queue->piobuf = NULL;
+}
+#endif
+
 static int efx_ef10_link_piobufs(struct efx_nic *efx)
 {
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
@@ -919,6 +938,9 @@ static void efx_ef10_forget_old_piobufs(struct efx_nic *efx)
 static void efx_ef10_remove(struct efx_nic *efx)
 {
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
+#ifdef CONFIG_SFC_CXL
+	struct efx_probe_data *probe_data;
+#endif
 	int rc;
 
 #ifdef CONFIG_SFC_SRIOV
@@ -949,7 +971,12 @@ static void efx_ef10_remove(struct efx_nic *efx)
 
 	efx_mcdi_rx_free_indir_table(efx);
 
+#ifdef CONFIG_SFC_CXL
+	probe_data = container_of(efx, struct efx_probe_data, efx);
+	if (nic_data->wc_membase && !probe_data->cxl_pio_in_use)
+#else
 	if (nic_data->wc_membase)
+#endif
 		iounmap(nic_data->wc_membase);
 
 	rc = efx_mcdi_free_vis(efx);
@@ -1140,6 +1167,9 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
 	unsigned int channel_vis, pio_write_vi_base, max_vis;
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
 	unsigned int uc_mem_map_size, wc_mem_map_size;
+#ifdef CONFIG_SFC_CXL
+	struct efx_probe_data *probe_data;
+#endif
 	void __iomem *membase;
 	int rc;
 
@@ -1263,8 +1293,25 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
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
@@ -1279,12 +1326,13 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
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
diff --git a/drivers/net/ethernet/sfc/efx.h b/drivers/net/ethernet/sfc/efx.h
index 45e191686625..37fd1cf96582 100644
--- a/drivers/net/ethernet/sfc/efx.h
+++ b/drivers/net/ethernet/sfc/efx.h
@@ -237,4 +237,5 @@ static inline bool efx_rwsem_assert_write_locked(struct rw_semaphore *sem)
 int efx_xdp_tx_buffers(struct efx_nic *efx, int n, struct xdp_frame **xdpfs,
 		       bool flush);
 
+void efx_ef10_disable_piobufs(struct efx_nic *efx);
 #endif /* EFX_EFX_H */
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 7365effe974e..a9f48946dcf5 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -15,14 +15,17 @@
 
 #include "net_driver.h"
 #include "efx_cxl.h"
+#include "efx.h"
 
 #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
 
 static void efx_release_cxl_region(void *priv_cxl)
 {
 	struct efx_probe_data *probe_data = priv_cxl;
+	struct efx_nic *efx = &probe_data->efx;
 	struct efx_cxl *cxl = probe_data->cxl;
 
+	efx_ef10_disable_piobufs(efx);
 	iounmap(cxl->ctpio_cxl);
 	cxl_put_root_decoder(cxl->cxlrd);
 	probe_data->cxl_pio_initialised = false;
@@ -34,6 +37,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct pci_dev *pci_dev = efx->pci_dev;
 	resource_size_t max_size;
 	struct efx_cxl *cxl;
+	struct range range;
 	u16 dvsec;
 	int rc;
 
@@ -135,10 +139,26 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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
 
 	goto endpoint_release;
 
+err_region_params:
+	cxl_decoder_kill_region(cxl->cxled);
 err_region:
 	cxl_dpa_free(cxl->cxled);
 put_root_decoder:
@@ -151,6 +171,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl_pio_initialised) {
+		iounmap(probe_data->cxl->ctpio_cxl);
 		cxl_decoder_kill_region(probe_data->cxl->cxled);
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


