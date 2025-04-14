Return-Path: <netdev+bounces-182304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C7CA886FC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706625666E4
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0535027A13F;
	Mon, 14 Apr 2025 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zPsrqona"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D2A27A903;
	Mon, 14 Apr 2025 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643666; cv=fail; b=dWyClxDWsoelpIVLU4iTnwYzWVmHx5RQqFMY68uNtnkxEYRwrQ0kh0gS1vmgrV9Ac7T3+1Lw8dzMd80G/Qi8khl8NhNJwaUkAokdzmJxyv9nGABAyLdW3Pq9x4IVlE8yleFjzkcK55aQd/lDy4Vmk+Pj47rGBt6Kwne5wGdbICg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643666; c=relaxed/simple;
	bh=Qrv7GvfdSsYllMxaZ5HpdpV0WmSWK2C90aplt/7gZNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PISJCJxmEwp6xCuvtf2CYuESoLAWFaiJoFzQMRBiAzPW2+5GsZ5gwIAOyYvKBe2OjWPjUADqC7wSvS0G8sNDPAWlauF1C2ySsQMNltkyK+InrtlprD3L5RWV6j26Q4/JiiBrwTGe4lrfQjD41nlGXXDf/AJY439SMLrxao8T/Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zPsrqona; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzvNjqq91bSa27g5gmiLtAwzFiv22Pd+Rc3Q+fcJkzv1V8IqvkXBP/NcPaKjh21HAPqrLxY4iii1Pj0JGYk6Ez8h3GXE4IE1EeOhbfGr9TG6cAgl0ct9T89jXO1Vm3c7M/EskGz1xDrnLWqY+VYFVxTZKnLWgYzGtC2X7hcAGOd4IHsTrXhVv2Inwx2ymW6RXlbaXwMqtfy0baQq2wz4QwlCA2vgp6dtoD8lFdkCS/ZqZ8TmpNrI8JE4/UdzYpGXsBQ8kOG61pIzwdyp7ydkxrPv9tJV8u+rvxdhlbDDOvHDSO6fWzbLN0p2otmYwidkY5aGHDa7ptZDhjm4CU1lPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMcRChR4OsiZ/YAhPvTX3krx7uwxA1pI6v+FQP5837E=;
 b=RUuXUpwj0VjS8aNjY/okdhX6/oiuL1NHifcrNZ2kEs+5Qz3gXBLujWUTk1kH+WVH3+K/7T9De6EASvv4vB51VYEufiw1E1XSWGAR4GB1sagHW5vJUSmehzPa0h16YgNzqzgvYCY0trntc0rhptICxLJJEeTXv/e6UNS///GfyNIV1c4V0aEyKqhzeMJ9ci0dqyAOJCxsZdPngyU6D4H0AOgNXNoI/n3ONcxgAGUdLNj7c/BLEuo2mrC62DdhjC9BEP0DNJ+InR5ho0jYqiLNkwm/TkaYylxf8UCebO7r0eEX48IfwWhB5VhL5VuPBDT23w+ehwhUNAfNgCRncQnrVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMcRChR4OsiZ/YAhPvTX3krx7uwxA1pI6v+FQP5837E=;
 b=zPsrqonaPp/tcKrgv6w5ZyuFXBKwJFb79704Bhl7ka7PZR2d/ttNa+dx/D8oNxlShcES0qE9ELeh5riRGjb2mKvJS27PytSSVkR1rbH/yc1nWgzYhpvxYpGhm8Bn8kbhSc90+DoLmYT539csQpzEQCgz+ePXh/Zt2Rhuu2TR4h0=
Received: from PH1PEPF000132E7.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::27)
 by PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 15:14:22 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2a01:111:f403:f912::1) by PH1PEPF000132E7.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.31 via Frontend Transport; Mon,
 14 Apr 2025 15:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:14:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:20 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:14:18 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH v13 22/22] sfc: support pio mapping based on cxl
Date: Mon, 14 Apr 2025 16:13:36 +0100
Message-ID: <20250414151336.3852990-23-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|PH7PR12MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b9f591-092d-47b0-d3a8-08dd7b67094d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DUowsrg7O47qP30YPCMj+v16/67U3goHFAiDOmvu2PnRDe2C7QPfpgK78JZf?=
 =?us-ascii?Q?cEvXCla6L+mprs67AeZrwvC4BR7b17Mv/oMWk18J2A1PCllGUPCA5kbyleqH?=
 =?us-ascii?Q?NivwsnIo/q3zb3Et1ICslDbv7722p5sQ8kG4vmJoeQpvIMGVj4x49mt57Hoh?=
 =?us-ascii?Q?j67yGh9nQJn/z5CcKEzzHI/g/+yaKEPraMJ6OaxinrSYQPZ5D+jlaQ3/tncI?=
 =?us-ascii?Q?mkKN4BBuIGyRo93ED4cIMi9tYY1PHUWebE2Cm/7n3GTZXGj0HO0MWydT2/Pq?=
 =?us-ascii?Q?h/lBQ7olgYz1ua9/fpMuWzY8Kw4vL186k3fzgpoHHB2rwxqenpQwqfmW5LcD?=
 =?us-ascii?Q?oiqOYG4s2DSIaDJwpOEheRS5BbQXQi22GATopHLQAm41HUkPixpvbPqNArgI?=
 =?us-ascii?Q?iXCk4uxXltMI7lj8tuOtvjrHIoE+cw4TAKCV6hGuOkPjYVubEEj1mOCuureC?=
 =?us-ascii?Q?UNlvRWaQRtLh8Y3nO2rIUHI38hrWiQrEfm6KdjKJnzX6BQk2fBw13KOU8J3I?=
 =?us-ascii?Q?Zlm5cb6w530fNbF+zymExHZDuNYx4kCVAPxqKoDTgDKyaPB6XG92w79b/y77?=
 =?us-ascii?Q?KoCunh9KJRNKH6WOZBQ84PRO7RNjFeJqQgx6s8b5I9LYI13dZrbmrjsfyRKA?=
 =?us-ascii?Q?iJCmmaqjMlNOcQjmw8FW3sO5gy76k1Vo3jVjMytWMoQFKUdMNiH2rs/di5UI?=
 =?us-ascii?Q?u3VSbepjU4KnXgLC3250PqXLVzGgqkN+FvKhCBeR+VHaIqS9wJEE1QGwuXdZ?=
 =?us-ascii?Q?JLBqRrR0qAlNL7LARr+9wL5qnWS/4XtzyzYGceYVVBypUFkP27cohCuSLE3F?=
 =?us-ascii?Q?z/1PuwsA3Z2lWrWGvu7Y1BZlJrYIu9kNgQxk+S4tkAfQK7VSdSoT2Mj9vmof?=
 =?us-ascii?Q?kx/56BmOwJA475ReyhHD0Xvahl0oZopzBVCaTiGtTj51+kRFlge9ttjXQjyl?=
 =?us-ascii?Q?D9evnBX0WoMjSXS8W4ZWL12/Y7dZT/WAC3aX7N/fErmJztlIS3u/a5hxAqGm?=
 =?us-ascii?Q?gtcpSQ3+w8fDELPm+XRCV5oiIoK7EUdACCY9tmpGl4QqDv7XyIHTInoiowz0?=
 =?us-ascii?Q?SELE4/vCKXAs8d/L6C+J6SRe3zJwLkwCsfbGY/iL92BP3DCxM6S1Um60rPyT?=
 =?us-ascii?Q?wssPIkV5Wn+yb/8TaOmXz8yuQSU/gI1JjoCuwhfHoY8vkWI55qVdujsehn9l?=
 =?us-ascii?Q?9Rsc2EucNRa+qGcuWCFmJ6H8p8szI5WeIVAIFQYmqxjt4QzWIN6mfHf/5mM/?=
 =?us-ascii?Q?n4gN0NtromrUxt6elt9GV8bmbhq2cHUYzWBiezcZh15lsX2Z76JNJJK7If2c?=
 =?us-ascii?Q?gKEM0galqsKB54jG5owjsliZslMmMrGM6NSHa1ojBHfLR6N23f47tNGUOGhe?=
 =?us-ascii?Q?nYQ7O7YbHPPfjG5piKBG9tPVRM5c0DMc6TtOkq76pugwQqNDwru7X5QUVxzh?=
 =?us-ascii?Q?FqsVv8dXzn7h7aalxHItb80XFTTbU9tL04IMeW9OiwmaBhvsiw3kPJC75Tws?=
 =?us-ascii?Q?MRjlhfM6k08jOXCGajLRsKS0uomB1Rk9a8B9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:14:22.2703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b9f591-092d-47b0-d3a8-08dd7b67094d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039

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
index 43154da5524a..90301d25ba28 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -28,6 +28,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	resource_size_t max_size;
 	struct efx_cxl *cxl;
+	struct range range;
 	u16 dvsec;
 	int rc;
 
@@ -119,10 +120,26 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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
@@ -133,6 +150,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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


