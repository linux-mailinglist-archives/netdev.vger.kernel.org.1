Return-Path: <netdev+bounces-227940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 681C5BBD9A9
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FE0C4EAC80
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60CA21FF55;
	Mon,  6 Oct 2025 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tPTcQCIX"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234012222A1;
	Mon,  6 Oct 2025 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745082; cv=fail; b=EOAt9glJVaITg3VoJ0cML8e+OU86kVkSKzKBNR1D54zr4wx3ksv6/meA5KyMKKF7TJmuy4qNPMKYwDUR1r7GgLYrvO4WPKNw45snOgnVmhmLdA7Mv8pJh/UDmNjWOk5USdeguI7Q+2Fwn+vE+xlhsJZOY3LIuTFka4dipm7c9pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745082; c=relaxed/simple;
	bh=9sIMN7ppZiZ8+ZgtcaWQTQNzuzrlyEPTydZSBEEwJIY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BH4w+//9tBwrb8P6OWWVNTMa3Ua+3cZKgwvZUm1hKreFgGWxBtHHUkc2rxYsYjWNpg1TlPLNw6Ry5ktznzGnRBZr1DOSQHAyP8mJufHdMJACYmAr1QmrNcI/ZFGjDpvx/BEboGhhhetvckP36UYFk4bQN6KxCkdkORxhIVD3TDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tPTcQCIX; arc=fail smtp.client-ip=52.101.85.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6yJ96R9RkmcrKivcKBj7piTPwWPn7L9yzLaba312go30IwEwlicC1DpNjTgiZxr1IGkSe/zdYHziq0BPc6rd3ATARjPccJKs5XhaJQ+aIlxcMv2SfwsbGSjlJu0ktX40sw+yYL3f1dM7y+CGSxL8lxFqCFQIRxgCcXLB3gbeTuX4cX6BB8NWte/XkXyqLfTXsESPc/EsDSgJlgvqs5m2ibhsC6+53mGEQymX/LjtUL+9Cjq8k5vzD+EhzFlswM6Sp9WA35eKTMwqbbReIvlW8rUh5keKGA/RvCR/346dpxZrAkRQnBZGSJVlFJXM4iiPCWukJRo3PV+mQS4eOpyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyXBMvWNF34IOQwh3my2/HbCSb9rzIAq5LYWPFJ58P0=;
 b=IaFRYDw9MjOCfU2BsoZ4NOMQ2LbFVeJwUdRNzKt5aKlKmnAr/49EbE5sQiPdY6fBWx6UQvMAI6kb7o/DQRlE1fwY906d31MmUmt4pc6s8/KeqFaLZ8i8z+x8M/2tBNzbETcIKG2rXVthnEaMsCELDL2JWk6gWtwhLUp2avXTxgup8Y7MHxXZZJDsXE6+vXlDNQo1Pdl2cFqW9wZeFQkTKoiloKO5QhdXkKgLLlb3xnTBRVu5E+jkdfOMpEmzcddBUTVR0cMg+weZOVIfPjXE6YFASvGtRR1hNbcyeuWj3ZZcw9j3osBG+nJqnpmzhIUj+Cxdo8OiurKiMyLudz84Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyXBMvWNF34IOQwh3my2/HbCSb9rzIAq5LYWPFJ58P0=;
 b=tPTcQCIX7lsW18EeVm+G2Fbw1aIn303LRlaq8Lm7HfPUh5wkidi1ua5QyYuRIHeoscpYfPnd6zuHm6su2qnWC9jHgSRfiTUGVs0KiL0EfmvVcJi4xYqCusRW6XxA5Bc2V6obj1gLAGXwmHILes1X7C18HfqoXe8vZedU6WuBaVo=
Received: from SJ0PR03CA0173.namprd03.prod.outlook.com (2603:10b6:a03:338::28)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:04:31 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::18) by SJ0PR03CA0173.outlook.office365.com
 (2603:10b6:a03:338::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 10:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:04:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 03:02:42 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:02:41 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v19 22/22] sfc: support pio mapping based on cxl
Date: Mon, 6 Oct 2025 11:01:30 +0100
Message-ID: <20251006100130.2623388-23-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec11255-8b07-4a1a-6280-08de04bfbe03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hcaj0SUYoYNafLC6L4UFdrvBw6dY+q/3bgj7c2s10MHNKnNkl8TDgCfV2Mli?=
 =?us-ascii?Q?NG9UqS79cWwBFxiYjw5g6kXSrDd4cdKX/hhwwUgCieI2pfk6rxZ+CYMu0D4w?=
 =?us-ascii?Q?PcdjxEo9873HdRPO73+JaVsONmQPLP4jLA7/l8DW++HpVi50FmR7If/cNvLp?=
 =?us-ascii?Q?01H8mN46X3r8IE5uD9m3EgWOpPw2oNwW24zjyGQFZ+UDYTsmQrN8XsHL+Kkv?=
 =?us-ascii?Q?SFRYYbZEgPKJo6zDY/GeCvJSulpzUXaZWslZM16b4GIS60SDf6HVOy0hG4hu?=
 =?us-ascii?Q?58MKHvBgHhQHo5rk+fJLE5EySfFT4ZhnIYxmLe7YMK4/DzWKHJq3xGHrKEni?=
 =?us-ascii?Q?K8G2vmoMSm25iOz05Ma+ldIgHD9JRB9QuJWiFM+a4bHT+obZqYu3oWvP/H7y?=
 =?us-ascii?Q?aL63WGr93oGo2w6XOeWYWJB/OFu0ojSXDkFCzK0ncM6bTYZ4Jc3xXena5Xfn?=
 =?us-ascii?Q?yvovuQ392f5XdDIa8RRLXAeTQIUn8s7RCZPkURKkAdEYnlWsY1vC8L//CDqi?=
 =?us-ascii?Q?S4MYLvPCZ5+BHyRw4H6RWeFfxTD+A0BLHIDkuXPldaW+gHHRqZEh8opCFfee?=
 =?us-ascii?Q?+3tFgxBIy65khwChJq70F1ieohb+M2UsaBm8UUhCrFBYZXHMdLSC9V2qXhWQ?=
 =?us-ascii?Q?CNH5v9yebbZmQyOsoL1L9YL7yiHQmkcG8CN9pF6Sy2vslXTht/XvPMJsz+bZ?=
 =?us-ascii?Q?LkfLb/BQnU2dDA+RqFX3RHLpdahsPUIiUCqUmSYhS268eNT2sCnkT0LUHCuD?=
 =?us-ascii?Q?8JfBBw3kmS1cRLZp4iItxUrYRSDzudoC5eEhMHKU7KeRhxITrP7/r8av7pmC?=
 =?us-ascii?Q?/fvbUejZ1vPKKJtvlCJs9Krk7Cj2R6VdvHbU0w0BzYIubejFoVZGChsxI65b?=
 =?us-ascii?Q?YhSixRiHm7xRu6oct7ikBrlfGt9AqGHmQ6hnkGGsWPbOkQhwUZhwfMvJM+xE?=
 =?us-ascii?Q?oCJlHXN+lfZHjVtnAjK2GIypV7nr7WbeIjkL4lE+iwPuIMHpglc9c5o1DSyK?=
 =?us-ascii?Q?GziRHc/gbDf4GnP/J/2FotLIm9HJRl1nZTfohQJvlZQSAVLV6hFKG0i2QrR5?=
 =?us-ascii?Q?7eBDY1KSKUHZtnkwO/fq9a2mdc7zwZsPk+6DlJH8zEzX8HuWtGbk2tn7zvJH?=
 =?us-ascii?Q?KOc7S54HtsfUIVdH6JGH1lEF8sTFuNo8GU9+7bOfVvL4QmnLVEcYs/s9rFAY?=
 =?us-ascii?Q?rCuDIqCRwqSV70TxOgz6fB0d3+hh0T5ZRH9RPHjFMwlxgTjFvJborX/OA3S+?=
 =?us-ascii?Q?Cp+0o9+nGOmaumm1ii698WsPxmG3HPnF7b2/RMJg0zhXzIgoZMzfNwUiFEdM?=
 =?us-ascii?Q?dfYeDdu8oh2uZOlVuaQ+bbPmyIl0u4lGO6PivxBfqJJDJS3dSLXfW5BMm6+G?=
 =?us-ascii?Q?6iyrTrS/mt9pzDgBR0Mhez5bygKXV95w2wTb2RRIWAP9qyPigcZ6VMrhqcck?=
 =?us-ascii?Q?TK33WJAo0PHFuIPxioOqKXuVoTezsIJB+Bc+0oRMls4tuUVhYZnkGqtLEonL?=
 =?us-ascii?Q?sfi3PtzSe4WPOjwvg2gXR1Sk2CpSxrufmkxDuNxLBcJ+7uI9DkXz66d7kWRV?=
 =?us-ascii?Q?pYeu6Mt4omEd5uHorn4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:04:30.4989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec11255-8b07-4a1a-6280-08de04bfbe03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240

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
 drivers/net/ethernet/sfc/ef10.c       | 50 +++++++++++++++++++++++----
 drivers/net/ethernet/sfc/efx.h        |  1 -
 drivers/net/ethernet/sfc/efx_cxl.c    | 31 ++++++++++++++---
 drivers/net/ethernet/sfc/net_driver.h |  2 ++
 drivers/net/ethernet/sfc/nic.h        |  3 ++
 5 files changed, 75 insertions(+), 12 deletions(-)

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
diff --git a/drivers/net/ethernet/sfc/efx.h b/drivers/net/ethernet/sfc/efx.h
index 45e191686625..057d30090894 100644
--- a/drivers/net/ethernet/sfc/efx.h
+++ b/drivers/net/ethernet/sfc/efx.h
@@ -236,5 +236,4 @@ static inline bool efx_rwsem_assert_write_locked(struct rw_semaphore *sem)
 
 int efx_xdp_tx_buffers(struct efx_nic *efx, int n, struct xdp_frame **xdpfs,
 		       bool flush);
-
 #endif /* EFX_EFX_H */
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 79fe99d83f9f..a84ce45398c1 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -11,6 +11,7 @@
 #include <cxl/pci.h>
 #include "net_driver.h"
 #include "efx_cxl.h"
+#include "efx.h"
 
 #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
 
@@ -20,6 +21,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct pci_dev *pci_dev = efx->pci_dev;
 	resource_size_t max_size;
 	struct efx_cxl *cxl;
+	struct range range;
 	u16 dvsec;
 	int rc;
 
@@ -119,19 +121,40 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1);
 	if (IS_ERR(cxl->efx_region)) {
 		pci_err(pci_dev, "CXL accel create region failed");
-		cxl_put_root_decoder(cxl->cxlrd);
-		cxl_dpa_free(cxl->cxled);
-		return PTR_ERR(cxl->efx_region);
+		rc = PTR_ERR(cxl->efx_region);
+		goto err_dpa;
+	}
+
+	rc = cxl_get_region_range(cxl->efx_region, &range);
+	if (rc) {
+		pci_err(pci_dev, "CXL getting regions params failed");
+		goto err_detach;
+	}
+
+	cxl->ctpio_cxl = ioremap(range.start, range.end - range.start + 1);
+	if (!cxl->ctpio_cxl) {
+		pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
+		rc = -ENOMEM;
+		goto err_detach;
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
 {
-	if (probe_data->cxl) {
+	if (probe_data->cxl_pio_initialised) {
+		iounmap(probe_data->cxl->ctpio_cxl);
 		cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0,
 				   DETACH_INVALIDATE);
 		cxl_dpa_free(probe_data->cxl->cxled);
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


