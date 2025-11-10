Return-Path: <netdev+bounces-237244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C143C47AF7
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9C142094A
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EEE31814C;
	Mon, 10 Nov 2025 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UQLPktac"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDCD315D36;
	Mon, 10 Nov 2025 15:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789067; cv=fail; b=HEF+ibe4T50/BzIoX9jau1uZbG/O3dRRKw1uFWe5uNsTDIfLScoBfm7LdIS5Sw3rG8IsJo0fwdsYhxOgaLV+qrP6OU2RUbXfitWSbk9dyMXnEQrc66Dx5m7w49ir6SMRv07h8q0Ha2czJOOHkApypGfaYr8UnsaDubI2Lahyzr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789067; c=relaxed/simple;
	bh=8VU7mteEVM3Xloicp00M74ErCULSyfQLxhuAQU8Qgic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVTCCTTkNowU+y86wDog7hjeoQUM13qXS6BSDuszF72HijllvQHhIC8/lOZp6Mv16fmccYf7eygUTh49DCoKawuGAv+69vdeiZKGVkuyCO+wmmmIrcLaMFsHeSVHyqAqkmnq7hLBVzAoAi2kxXBX4M/T0FntG5f3nJqcVBuxHG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UQLPktac; arc=fail smtp.client-ip=40.93.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZoQ3KyFvclyVJgTtVkNAJjeCNDWD3Q5utFGTCX7XvfKgtYC6roXHJTykQUthRnJl8xMPGYH2AzdHkXr3sSqqI1106Xat6SfO0D3GIwejkcYXWz6ihKtZkuzr3XIom9JyFfYI2YOOi5HB/joZIOvotQovfZEwPM92nxRvo83SMjdIhc7Zc6xsdL5d11i7DYzc91K07hLeI5LPFsJLmj5FwDoPIjRpWmWi148Z5WyjcUnmvXCJvJrby+HNH98Ht86WCnRkTZLFduAldpbbMExZvkNpxYj+UhAgx03TfWcv8CZhFS09pW9CWN/ZTDZciL5vKI6xcNVO1svviWw+1RFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkkMkufSqlrqJ1HN+IwJrfN6tNpyaES66VEy98f/RjA=;
 b=kP3ZFKvD5B54ZBro2gPb6uPCye9UmeC7DOWwuqlS3z/AVJ3uMOGqPK8Zkd1PsprVFArgyegUeKAcpKL9utljHxEpp6x2fraGk4RPJMRbrvfuSPTD5d+vDspkePbttXnSFDYSGImaRAMr0mECw5zrMD90mcN75EimzG4APe5BcaRuD8DI+2l2dfc1uThcw40R691b3AaKlNkpjTWF8T7OflMBotno8pdH55oSxkPNx2JnJrBOKuEem86FmaCUozWnpVwNnauMdhVJxU84x9lKYb1EU7mdhPlYllQTiZJdx1Z1c5ghKsCyqVE/SEO4QF8lG4sba3Ddc5WaYyU+7hxwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkkMkufSqlrqJ1HN+IwJrfN6tNpyaES66VEy98f/RjA=;
 b=UQLPktaccCLvgWfmKcWbMdUH4wpSPrXwFJgjUGw304UkYFheodJ7uWofGkox85UYrwT93YIVjBfsJbYMkirYibW173KjqGsIolqrnx1GEJNM7AcbhigIqnv0OYbkHNbfhtbLo0q4tQ335LKRydLQsKLr4VQ3Z79WZIO0GEgNVco=
Received: from BN9PR03CA0907.namprd03.prod.outlook.com (2603:10b6:408:107::12)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Mon, 10 Nov
 2025 15:37:42 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::97) by BN9PR03CA0907.outlook.office365.com
 (2603:10b6:408:107::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:40 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Nov
 2025 09:37:40 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:39 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v20 22/22] sfc: support pio mapping based on cxl
Date: Mon, 10 Nov 2025 15:36:57 +0000
Message-ID: <20251110153657.2706192-23-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e910735-7187-4970-4e03-08de206f16c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NVdpoLHCIOGULPL3W6IDdv68qxJyR+lwr/aOD4Kzvp3JQ6fzVKK1VZyKAJPk?=
 =?us-ascii?Q?C3QhHOAt38MmJlc6yn/PnjICGuUJy1Zob+JUkdou74xINz/Fnq0Y6aLT7/Vb?=
 =?us-ascii?Q?MdjTlzFaFJFv/qCYMiG3KKabcMpTtTph1q3Tem5lCdeb29ifBnKUBf2Z9jUB?=
 =?us-ascii?Q?wn1pTRxHjh0vqGP1tEx6fk1miFg+7PhErzeoZXSQOvMVnjC0Ggo1VDiPlYJl?=
 =?us-ascii?Q?Sq+pXpfxP0CiLvXUshVvy7iKTGUCCufZOcGnl3VkvsHgHQqznbxGC1LKGfF6?=
 =?us-ascii?Q?dYnNkYStCOhHqhQ00Z5NO98/LO4Cs+3Y89la6gAnXM13tDensEt34AcSOcs7?=
 =?us-ascii?Q?0Okia+uU7A+IzyQIW5neNE6owe2er1+6AbHU33GSMlZ3Ps2ZU1BLNUPa+wKc?=
 =?us-ascii?Q?NOnWcSPbf3Q6EXoHfJ3xJhuqeOuYVJEwEF/X8Pq9cZOJSCYe1+b+4fXbkRtz?=
 =?us-ascii?Q?YSM79L8ogDIsxv8dZcAI78k/XdDBmQJh1/XRRPQZe6XU/eIghnPaP0Opuodk?=
 =?us-ascii?Q?I20w0+OCOrrueADrFxo7TFPXtn0g4PmbuDxM1mUji7khypNJpeKttFeSa9G8?=
 =?us-ascii?Q?7a+IN9c1Lz2lB67F58GXM0QHkFroWajt1YX3MqhWdzwK4rJhI7VGObSv34ql?=
 =?us-ascii?Q?z/VvXPBa/R7+9xPwDRTL2iQLMYyrzCMBTPMK69g4QilLj10w+uQAjhlPLYrj?=
 =?us-ascii?Q?YPRPC0w+y7QZAsOTbQMht2eO5xFmmAuwClx5dDy8RqVkbu22LxyJP4XtxAs7?=
 =?us-ascii?Q?y/bvgrFvrE6KuiW+nOLl1FDAAYXTT63Pwel8e+d4//N83YDUgfYp/lYY5Qy7?=
 =?us-ascii?Q?OxifVxDYKXf0C0EiOfNIrR+0AhFNi+rZjYe2Ecyx7fmPan4lUxpl6VvYbT1m?=
 =?us-ascii?Q?VqrpXnAy8Y3gIFH4uOQI1NJGrLfl98BgWvcI7Re29KTCzj459BBrb1AhIeam?=
 =?us-ascii?Q?fQ2JdxPKXJJecU5BivElzamsMmZ0lItuA1n0uAXqBgKZSPdny8DAVgM2uc0a?=
 =?us-ascii?Q?ArQQd/11Z0wXNSag9mMSymO4SnMF6888pfPBlQzX5cpw6ZgfOqvQJNiYXA8C?=
 =?us-ascii?Q?3T3WA9mtwGo9P2S/CS72CTcUnoeO+CNNVAfUrmrYnlnhCab5Juhksc5Fi9qk?=
 =?us-ascii?Q?EdLATVoGlSWdzf70pznG9ptRiEb14nQnTNN5BoY2Q1Wg1EH6/tDKjiVN1kud?=
 =?us-ascii?Q?HJCc4/WHMIEm2hr/bYM7SchaGpTxb6A84ZujsZhA9jOqV6W5BoZO6p/mSjp1?=
 =?us-ascii?Q?j5kQYzPxfoQliK0VWYBBZCp8LSA/Vu5XGzb3dnDUSyaOEJ64PWdjQ6oe105b?=
 =?us-ascii?Q?K7yhm6T6HUVvfSVCwtENX0dPPlEHjx8Mo7Df3akSfBjMXQt+bP7DMCEYEwAA?=
 =?us-ascii?Q?WILoLqYaaqvfYHfyeLJUYemPA2yfjzLSpk08sLBwQClCXThLEKIvxAYGCgQM?=
 =?us-ascii?Q?PK8HSqoeqv6zOTDnxmVQpQcIrJh7WEAaYxrNRsJBqD023exFNEIsx7gUGOFK?=
 =?us-ascii?Q?2D/Ab5V5fUao6oT9Wp1nl9axBL1O3xhacD38VQmu/7zo4vYNLfI33LYJoX79?=
 =?us-ascii?Q?5emfv/Oep0IGCdHcR3w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:42.7971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e910735-7187-4970-4e03-08de206f16c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726

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
 drivers/net/ethernet/sfc/efx_cxl.c    | 31 ++++++++++++++---
 drivers/net/ethernet/sfc/net_driver.h |  2 ++
 drivers/net/ethernet/sfc/nic.h        |  3 ++
 4 files changed, 75 insertions(+), 11 deletions(-)

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


