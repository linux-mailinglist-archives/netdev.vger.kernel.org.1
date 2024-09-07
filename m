Return-Path: <netdev+bounces-126228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF4A9700DC
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97EBB2857DD
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06721537B9;
	Sat,  7 Sep 2024 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1Yo4mYet"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D17015B561;
	Sat,  7 Sep 2024 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697204; cv=fail; b=KBTMvpWJ0g+TAdw1MrJ+E+oeD4ylAfBsuzfVniroUvbEwTDpB2PfGXnjlE1uayQ+n+dYZxyDL+Zv4WXQrWGKbdW8BLMGsjjhkcFnxv+jk1rkfnFv4ioSRcXwnrRdpWf9OTPzGuarwT+fdTd7z8M6ANKJ3cLhB7+yL1H1/9XPc20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697204; c=relaxed/simple;
	bh=7GX6wIfJL5Gi/Ty6yGhWnBvgjsMoJjS9XScxPCDZD48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJsouTZvW425AWRGKS9YLTM1reNCfiqsvj+F2OWFEUs1wKMMXHV7BhE669WT4O3tgxsvJWI0TLexdjj0D8ri5Pal3JxP8WeJXm4PKzRS+Vlv/joKvxkqted3ji7dBZgB2grf1cP0X1ZDyqFPpLbPw0DoTS2PIUMv7v5s8ADqzHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1Yo4mYet; arc=fail smtp.client-ip=40.107.102.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHBxj6KW+R1U6SiEhL4Z7iKOtGZjEonRbCt5MAMHXU8h8eZw5gXzZUq9B3uMmwkO2PaK0DXinsb7H3mA1DXqDsY/BqeeOGQuyKSrJD7YSnr8OjMEDG9pURIo7d2delZRq17RBIz76Sr2vN2gd3CcjUa3LfsWGpBuuJAS5W0zsVmrOobIuCXUh8A92VeHrjbCaBOs1PP8Df99jPJxUmHGGeua4eXH3stZKzO2WEe7c4XkannwN3let7uf67LWT4Y1N/K2CWTuJ+fYqOcGe8i4FE9NShgk7qryiY4Hu6pExEroNsWF76zzCk4xwVW9fm2NVZ0uUxkiJRWpm1857C7U2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nombQutZ7tb66ymj7wDLaJLA0to7Z0ZjG6RUub4ZZJo=;
 b=Y/zIJk7Pk99Yva11B+QEjPFAok/VXnvRLnkZ6u5eanhLkZNjMvFnoswtBwH6QiABKyjVt6u1Ibwu5YclQveqSS2Zx5PyLw5ZSMEUP9nip0HP2HGCN6GC09dCvQy4RCKh8J2TGjaX88wUeCUArzFsd4IGAFN0CdpeqEZ1hgaJp6IP5DnAY+aRBX7/1yjuSTm3h1r0oAGfuc1NH90Qc15SEvjE2A48jENoXmYvk67RRrZOdEVCdvNf2AOJD2J5mrBH9An0WC+odVcaA7G0fcVeQBHIesED3GzuhrAIvfKCA5yOWBej/0pnRfoaREvN203ofD1K++KXXT/xE2ZdHn13uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nombQutZ7tb66ymj7wDLaJLA0to7Z0ZjG6RUub4ZZJo=;
 b=1Yo4mYetX7oUNB3CmHrXhKqODY+g3ogiZqSUEsBqeHUWTV8xJEiLwOTs4Myeouv9Q2MKCTYxfhqSNj165XvLji4BVzTFqat2Ny16CboK4vhpr5t99ZO/WvtIZR7rnd7/HEfZYvo+v9OQdlJh39bczMXYWpmol7sikc6I0lFprKs=
Received: from DM6PR02CA0135.namprd02.prod.outlook.com (2603:10b6:5:1b4::37)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Sat, 7 Sep
 2024 08:19:58 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::1d) by DM6PR02CA0135.outlook.office365.com
 (2603:10b6:5:1b4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:57 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:56 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 20/20] efx: support pio mapping based on cxl
Date: Sat, 7 Sep 2024 09:18:36 +0100
Message-ID: <20240907081836.5801-21-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|DS7PR12MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e2437b-487c-4fb5-1185-08dccf15dcf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xxQM1YNunuoAqxiGOZYYlq39XU+/GHPr/j/vqktd0U0qVJPwIGk52AZolu4O?=
 =?us-ascii?Q?QGjK7vIjR8E3nuCTm7KD4AOpwioCSHm2hXXOq9R0CYlEOx50gToc7ChNNBLg?=
 =?us-ascii?Q?VvU64opQOkJjIZgfwsVeYbwiAhh/V0utUmUhddcj5c4T+2Vq/P1vSJsu8W6N?=
 =?us-ascii?Q?YCkt7sJYC0472jOiZltgyEFH5tAt7GeDhp1Ahlkl37T4YSW1tF3mSsgjDPEb?=
 =?us-ascii?Q?Op+DFaRj1M0yVCafHHggVwjBQMn+4uMHPhpDCvnWjs/OvTYcf6JW1cHXFTux?=
 =?us-ascii?Q?XS0iCpacTBi0PNY0X43zCufCOfgYwNSx9xx6eZk+eziR1PQwUkpGQ6A4Ecbz?=
 =?us-ascii?Q?HFGsVb0ffkv7ZerTR2cF2+tW0RTcZXQH6cAhFINufhou1DJq7BJOEuurWoHZ?=
 =?us-ascii?Q?/BpLlvoznt0zp8Io82TWgm+mbPO2uUBUDng7G4HpqO8tMKLSIe/CQEoTzOLZ?=
 =?us-ascii?Q?GI9l0o7tH3ZpJBvWxTaoGPw88huuKPRHOkNtALrsQLVeJCwzPjJ1lrg3vS67?=
 =?us-ascii?Q?LuspKo5wj2g1Yo7fNgDgGSjqmLp6T+ukM5VabGN3ZvRU6Su84TMvFtXgVjBC?=
 =?us-ascii?Q?xSqO1Sa+KRzvKhyQ7jHiqpuH6/qbwZNxOdmXiQywy4Jrw/qHN7tWGWxcPZcb?=
 =?us-ascii?Q?w6jvagDuJ6kYnax4iGWXw/BunBfHmyoaP/BWpPamgiZymZJJofkNESyTmle1?=
 =?us-ascii?Q?ZZcUVykfZup8b0w610lL3N45z881+qhsCu+wPvGZz3Ex+IHr6eso/6YzYw9a?=
 =?us-ascii?Q?JgLJA5OGKHjjM1ePQ1Lqp3cZbNOb0hFRkMFmpHJeZ2XzjlB+35FiMdtszKi1?=
 =?us-ascii?Q?FVwkqTbi9ktmvMMVmhuwioL5lXMDu+GVvBxKklw3rCygaVod5MP1MNlmUjjJ?=
 =?us-ascii?Q?hlydo+x6mDmPl0CS21BukWqn2kqtxssTMTtKVMGMf7pJ7y6RYT4GI8FEEszR?=
 =?us-ascii?Q?VzBLxcbrRadczZEcQ/KtHFRyttIQ9pjlwkm40D3FxYdBFvN4CMT+Z/FZeNQH?=
 =?us-ascii?Q?Usqs5JZoFfqIXDHC6bxK9y7NGMR1D+n+LmV6U9UU3o+aLew3ZRoYnGcVMWc3?=
 =?us-ascii?Q?Ueku1W7p6iJK6qOFuNQPe0TDInbmrabAzXTaaxofzLf1umDV9wVdN/bfZQEs?=
 =?us-ascii?Q?I+4nC3eepZqTlN6dMEfxs97tI/0RfdD7t1Gt9V3r9wZEFSM2yYlGc0LIbG+5?=
 =?us-ascii?Q?9BZ/KxMemJXoQR5F7lVVa947eVNQD3/MmWUYuC7tFtIDALLZ7u+8o/taXRAc?=
 =?us-ascii?Q?WTjHVwKZkrH5tuj9c1nBms6aq0r+5iU0EConSjke2bZaWqdVthQRiaeFgZaE?=
 =?us-ascii?Q?pVb6ojnn1HcD8TzKz7tQKNQp5lp/WWG7v1Q9tnRcKx4MsnGdx8G/yN2lYN5Q?=
 =?us-ascii?Q?UAm30ehcPtVD245l614G6dyHTam6ppLwWb8exxke+fxYuU77h5JvowkyKZ4W?=
 =?us-ascii?Q?7fCLSQu+5YhCbFeo7Um9UNZlVQbNOiOW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:58.6919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e2437b-487c-4fb5-1185-08dccf15dcf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744

From: Alejandro Lucero <alucerop@amd.com>

With a device supporting CXL and successfully initialised, use the cxl
region to map the memory range and use this mapping for PIO buffers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/ef10.c       | 32 +++++++++++++++++++++------
 drivers/net/ethernet/sfc/efx_cxl.c    | 20 ++++++++++++++++-
 drivers/net/ethernet/sfc/mcdi_pcol.h  | 12 ++++++++++
 drivers/net/ethernet/sfc/net_driver.h |  2 ++
 drivers/net/ethernet/sfc/nic.h        |  2 ++
 5 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 7d69302ffa0a..d4e64cd0f7a4 100644
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
 
@@ -949,7 +956,7 @@ static void efx_ef10_remove(struct efx_nic *efx)
 
 	efx_mcdi_rx_free_indir_table(efx);
 
-	if (nic_data->wc_membase)
+	if (nic_data->wc_membase && !efx->efx_cxl_pio_in_use)
 		iounmap(nic_data->wc_membase);
 
 	rc = efx_mcdi_free_vis(efx);
@@ -1263,8 +1270,19 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
 	iounmap(efx->membase);
 	efx->membase = membase;
 
-	/* Set up the WC mapping if needed */
-	if (wc_mem_map_size) {
+	if (!wc_mem_map_size)
+		return 0;
+
+	/* Using PIO through CXL mapping? */
+	if ((nic_data->datapath_caps3 &
+	    (1 << MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN)) &&
+	    efx->efx_cxl_pio_initialised) {
+		nic_data->pio_write_base = efx->cxl->ctpio_cxl +
+					   (pio_write_vi_base * efx->vi_stride +
+					    ER_DZ_TX_PIOBUF - uc_mem_map_size);
+		efx->efx_cxl_pio_in_use = true;
+	} else {
+		/* Using legacy PIO BAR mapping */
 		nic_data->wc_membase = ioremap_wc(efx->membase_phys +
 						  uc_mem_map_size,
 						  wc_mem_map_size);
@@ -1279,12 +1297,12 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
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
index dd2dbfb8ba15..ef57f833b8a7 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -21,9 +21,9 @@
 int efx_cxl_init(struct efx_nic *efx)
 {
 	struct pci_dev *pci_dev = efx->pci_dev;
+	resource_size_t start, end, max = 0;
 	struct efx_cxl *cxl;
 	struct resource res;
-	resource_size_t max;
 	u16 dvsec;
 	int rc;
 
@@ -132,10 +132,27 @@ int efx_cxl_init(struct efx_nic *efx)
 		goto err_region;
 	}
 
+	rc = cxl_get_region_params(cxl->efx_region, &start, &end);
+	if (rc) {
+		pci_err(pci_dev, "CXL getting regions params failed");
+		goto err_map;
+	}
+
+	cxl->ctpio_cxl = ioremap(start, end - start);
+	if (!cxl->ctpio_cxl) {
+		pci_err(pci_dev, "CXL ioremap region failed");
+		rc = -EIO;
+		goto err_map;
+	}
+
+	efx->efx_cxl_pio_initialised = true;
+
 	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
 
 	return 0;
 
+err_map:
+		cxl_region_detach(cxl->cxled);
 err_region:
 	cxl_dpa_free(efx->cxl->cxled);
 err_release:
@@ -151,6 +168,7 @@ int efx_cxl_init(struct efx_nic *efx)
 void efx_cxl_exit(struct efx_nic *efx)
 {
 	if (efx->cxl) {
+		iounmap(efx->cxl->ctpio_cxl);
 		cxl_region_detach(efx->cxl->cxled);
 		cxl_dpa_free(efx->cxl->cxled);
 		cxl_release_resource(efx->cxl->cxlds, CXL_ACCEL_RES_RAM);
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
index 77261de65e63..893e7841ffb4 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -967,6 +967,7 @@ struct efx_cxl;
  * @dl_port: devlink port associated with the PF
  * @cxl: details of related cxl objects
  * @efx_cxl_pio_initialised: clx initialization outcome.
+ * @efx_cxl_pio_in_use: PIO using CXL mapping
  * @mem_bar: The BAR that is mapped into membase.
  * @reg_base: Offset from the start of the bar to the function control window.
  * @monitor_work: Hardware monitor workitem
@@ -1154,6 +1155,7 @@ struct efx_nic {
 	struct devlink_port *dl_port;
 	struct efx_cxl *cxl;
 	bool efx_cxl_pio_initialised;
+	bool efx_cxl_pio_in_use;
 	unsigned int mem_bar;
 	u32 reg_base;
 
diff --git a/drivers/net/ethernet/sfc/nic.h b/drivers/net/ethernet/sfc/nic.h
index 1db64fc6e909..b7148810acdb 100644
--- a/drivers/net/ethernet/sfc/nic.h
+++ b/drivers/net/ethernet/sfc/nic.h
@@ -151,6 +151,7 @@ enum {
  * @datapath_caps: Capabilities of datapath firmware (FLAGS1 field of
  *	%MC_CMD_GET_CAPABILITIES response)
  * @datapath_caps2: Further Capabilities of datapath firmware (FLAGS2 field of
+ * @datapath_caps3: Further Capabilities of datapath firmware (FLAGS3 field of
  * %MC_CMD_GET_CAPABILITIES response)
  * @rx_dpcpu_fw_id: Firmware ID of the RxDPCPU
  * @tx_dpcpu_fw_id: Firmware ID of the TxDPCPU
@@ -186,6 +187,7 @@ struct efx_ef10_nic_data {
 	bool must_check_datapath_caps;
 	u32 datapath_caps;
 	u32 datapath_caps2;
+	u32 datapath_caps3;
 	unsigned int rx_dpcpu_fw_id;
 	unsigned int tx_dpcpu_fw_id;
 	bool must_probe_vswitching;
-- 
2.17.1


