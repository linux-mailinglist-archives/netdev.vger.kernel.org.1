Return-Path: <netdev+bounces-190437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D048EAB6CB4
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B60C4C2B2E
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892F3280314;
	Wed, 14 May 2025 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dlkayE4F"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF8027AC3A;
	Wed, 14 May 2025 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229316; cv=fail; b=TALjmHackMy5tIvRgq3DhllUEqG1wvJkGELQ/yEKK5X2TOu/QnbAVGThNc/EJSWH1wwAvYhvT2QjwywW38Ph4HCil2+hcmSs2sDjOEfbVoVqYbsXC0YIbjNEbi6ywrsb1X4DWINxfp/+2sHS6vsr4OFnLQXX9nY0UU//HOxvhs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229316; c=relaxed/simple;
	bh=qJrje2K61K7ckBM2L3X2P6rqhmwD7x2qzwJtFBqfsSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=evmdGYmPxCQEHn6g5coeRgLzorkr9R4deqaD3hp2Xd5sHWmxd5O0Jnhkl0dWSLVM9b+dwtuF+D8NhJQ9jOeBVDzK6Q6d0oizDV6SSGZWD9il+MC41pBEVZRu+OGlIXJfnaBxfNcEswwWcZHf74mod7loP0sjRhEKs0KdawVaTM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dlkayE4F; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esbke821f1J69dukjpKCFwYXa0J3M8TOflFyRasHGl1xh7fhEgFEFRjMNUL1SDrmj2UETcOiU7f85TzB+Mfe2e3piV3aPKpEc5LmULQya/1lnED2SNBk4giGucXJxQ2rGp+ozfn9xKt/YjBmy1VObU3KTx9/uRiZop4t/91jLqbt7CbE1fYSY2RPhfJv55OGVnSNOPh1pUCmDdEl3Bo3Bw5SSrETc4glsPUDfhQOvPcmEVf5hTaAMqz4al/kVBiWeROpokY9yXsCszSqyHtiAApH5Gxq/NBFTHRCmq/ZtHDw/AAeshXN56sv3pK4evFU8AaKtL05DsLkjfYowXKb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7InK1qy+ktx9emWZEFsXRYMRbez3sGgEvSeZxC0ldM=;
 b=ecl7fOUOBqVR2qsBn++T/lqCVgxswsGzt9AeHMXg26ah58ExoGR6PpuierCrNEPERksHNIEJnOG4CZn1EkjzFTXwf3Bh1fkmgQ99r5CgPzw/bwhkb/ozxQ/VfrCvHxeghPjJCSK+Bo2Il55i5+y0Iutfkl5FeNCCI1erB9tc6jn1wNHbfemR7t6+F4CY3Xb7JXfm4sFDXE24Tj5fd1CX7D5zRNCFKUbFkb1qWSYoM7+BgfuFga7j2ixeZSluyOHTeETeAQh4HnO1NQIDqbmNmGegKw8l5x37uvbd88oU3z24FOKFEmbp1fidJdzqfjzYVBJbCw4Iem/4osk9/IIyIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7InK1qy+ktx9emWZEFsXRYMRbez3sGgEvSeZxC0ldM=;
 b=dlkayE4FGhZYsnqCaKNrw6EyfsNiDX6Z8p8/LK19B+sWMvQz1K20/b5ecfq8hsoGKcfN3x09gwJ+oywGwfT+YHr5r6d7/FETqZM5DO8FE6L5xruy981lJ4qF/6r1zM08zTQi1RrnSHfQMoce30JF8qxzWD6chA5wrKfzoBNRnUs=
Received: from BN8PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:d4::19)
 by PH7PR12MB7938.namprd12.prod.outlook.com (2603:10b6:510:276::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 13:28:30 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::e) by BN8PR04CA0045.outlook.office365.com
 (2603:10b6:408:d4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Wed,
 14 May 2025 13:28:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:28:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:29 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:28:28 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v16 22/22] sfc: support pio mapping based on cxl
Date: Wed, 14 May 2025 14:27:43 +0100
Message-ID: <20250514132743.523469-23-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|PH7PR12MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: d24eca73-0ab5-4fb0-d58a-08dd92eb3775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3fYLP/oTEXL1xa0WvqDQ413L4J0k0w/f8LjSDlxvdT5jrPc+tH51Q2I0Yyy+?=
 =?us-ascii?Q?TexVbN6734xG71csjQLgluHzp4m/GOLg3qbJHNJ02O/vxuGbha6QZnGlpm65?=
 =?us-ascii?Q?t6itFO2aIXp1aPk3ACW+Pkb3RlgVbc4TsLE3d1TBhP1ocDkwsXiSoaictoEQ?=
 =?us-ascii?Q?dM8Uk8tweAiz4gw9pVRKJK9FJ5PpRIiM8n42MjRjijz/tlwdaxf1TSkA4nS1?=
 =?us-ascii?Q?IV425zAXxpASKYWBuhlOSsLR8IPLpYUcqb+jVmRh5lDzguZ5o++fLCjIQIwf?=
 =?us-ascii?Q?kJC+r7bmXI+HvurxQd32Dnpcp3pRnPwNhrFF6z+iWfiwIXCVozPnkB7a/QJJ?=
 =?us-ascii?Q?GqsjSLoFuAULbAcCc3tZz5a+bPHUwWzGQc3tLF1ogiGCFOBW3ag4qQmbcc8h?=
 =?us-ascii?Q?x0++s2n2n+FZQZYLAMLp3wBRImSuuOT4j04TNSn4OboJv26PxyZ8iYmMJQeJ?=
 =?us-ascii?Q?KT24QYxWdg0K9c6NMF6iPi9VUu3f2M4abf8UVzefjKfSTkjy9IYQJMc/yggr?=
 =?us-ascii?Q?pm6ooLXfNe0wXeeY7Di2qH+042ZtRx4X/K41sBJaorruD0ME3HZm6kXHi4Cz?=
 =?us-ascii?Q?o0cKQG3nvX5cY1CWsKKx0ZMZus6SCJCyhiF/83RMor59m4S2FhvpuuMuArE0?=
 =?us-ascii?Q?w+uvXS7MQq5FWRJvOqnfa3TbKLBRZEddSeW6PES86OKjcoGtaC3H7+4do+A+?=
 =?us-ascii?Q?gXo2NMGIsPyBU/C1ucIq6uxc1gMg9Ewq8kK7IW6V5q0P9LYY4PWF734yOTmc?=
 =?us-ascii?Q?90Kx3iF/h9NhpSuES/TWnb+qC7m3iLVaE8pkDUOxqcGi+IsqOLf4pSD3i8b/?=
 =?us-ascii?Q?MHcXOIL9QZ7RxzkAilVwuQQ9eQvSyvWzRnWkKHgcsXtNrWE+fns2ZjEF7NaC?=
 =?us-ascii?Q?jNPB0S7YzsbLE9d/rduWL6JG4g6uZi+4i/eA1F1de7PcidnnGVQ/OdFCSQDV?=
 =?us-ascii?Q?7sSMsuTHsAWkd7Rec/9xlfunZNVg3+J9VLKKn64LtMok1hXe33lFv0o6ifQo?=
 =?us-ascii?Q?7unoVjhPbg+PPbuPQumDY6uy14QeYHlZj3HUZzOWeSDHBHGWYOOnYyRkx0H3?=
 =?us-ascii?Q?xARdshGI3xUpWHhjaVXOgLSaJWjGqCY2S9D9U+A3Scf81nBW3afDWQ84V4BG?=
 =?us-ascii?Q?PfaWl0IujlEc7Kx8Dv+g82enIWipY8JrcQLku0ulvrDdJs3lDX6XChhfR904?=
 =?us-ascii?Q?l0kjQx0/KBUCphKxnx1tqz8JCCBj7U6c4RqefU9+5c4m6+xGkuhZQ1aWh3a2?=
 =?us-ascii?Q?9XyWF00K2YEBDec2BttwXxkk+9kEiTxXmNgib6+Gl1Cio6PgQZK2/ti/oH7p?=
 =?us-ascii?Q?EoT4Vrzo73F8wBRjEvDKoy3tG9wJkem4NRIx8KYfe1cX+r6FmRXlLDSHOWlH?=
 =?us-ascii?Q?vKp5WhOFrqP15c9ofnLO9yLotmPfGgmblKYmLPiINbgudyhEvQ0Hi/jVaKE0?=
 =?us-ascii?Q?sXGW3LiEdOsyZLv9lcpQRS8JgiSeLM52JnrcahRGGeGZHwlCoa6gsSXPkZO+?=
 =?us-ascii?Q?6dpn05jPPSFGC27E55Z+H4jxrMnqYZbIAx+P?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:28:30.1475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d24eca73-0ab5-4fb0-d58a-08dd92eb3775
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7938

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
index 960293a04ed3..efa3cf1a56c3 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -28,6 +28,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	};
 	resource_size_t max_size;
 	struct efx_cxl *cxl;
+	struct range range;
 	u16 dvsec;
 	int rc;
 
@@ -117,10 +118,26 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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
@@ -131,6 +148,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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


