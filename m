Return-Path: <netdev+bounces-163062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 041EDA294D7
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04893AD342
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD93A18A924;
	Wed,  5 Feb 2025 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J21RSf1C"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920218A6A9;
	Wed,  5 Feb 2025 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768845; cv=fail; b=cp+u+aQsXI84qbXzRHFImvzQQC/+tFaLJtAy7PTgJZdRH6D9x6tm/hHWubz2PwiJdK5pf4ybXhuzac/ag/6AAK3JvgxVQiX2eIT4jPprdUDUXk0/U+AH9TpoNB54FhOWtNsDJfD5ABaxtPn9xpX08sO670491+dRGJbDUAJhXAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768845; c=relaxed/simple;
	bh=mFHZqbJV1S431E03Hz8Hq5zL629JP2dzcnopuDouzRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cD7tp45sCUqhXSZh+Ll/9RpCVrQ4q4aP+cniHpSCkSM9e85dhmck9IfbKmobCR48SgidvUpdlOjdrR/Gxo4wxL/py7PQPmT37xFnN49W2/9FEgA+LfOjGGhuFslD2K8TxhoMUrSR3+5v4PvK1UGMw+gMAjudGANYcxqBGqxLabw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J21RSf1C; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSKEROBM86PdPrRwA17dY5m3IIwtOzWIxsSMTsrCQ2GfX81CMMupNx1IOgmAxWkJbFIywS1GADTmuPSaHp63tOSKj6DEYFVpG5KtEhuRUa6OuWrxZp9I8MgJ0VyI+PbKx9LfF5ZSKzZ4bkKoayeYcbNLCNvi3uYluegPbpxsyi5/9Hc4w6KImUuNxKxi23rQgJ00C90Gbh30Xug1KKX2wl5KiKHJihbdQmB4qkMxbvbwv/8JjmPfWYWYw+fSFWcMCJ5Pj3qYAOlFMDrMFfKVeC76XoTBiuELPhKLZzb+8wa2Ya7HDDXYk8ger0UuxEFfH0P5MwyY9/MGQsj6/UXQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dqvw5rSR1sT7IfSLN/OPa4xrGDXTmPEafOxw9+C/bcs=;
 b=SFIXAP+RZu9WfthCSVAo84kIiIyiQTgKaMqmCdSrdX+nm1fBPvMo8AC0qZmKlRACKHMQC5fIX8sFO+XgxRlApUKZHUQjeapRh3SNlJlcUiEUkpvr3otJAX70TWwUdzuPsKcYA/9yE/8rgp4hn7+C7knRQd6KUr4oFiJGzJ6gw3PpPjlloV1yGy/dU6yCm4rB6l+sYLa+kXSOOZE7D44oZ+kNRdA8NMp/9EWNW+JYw2tc4j60Ws7HV4lkdeg9mtEY6ARzyYt83uKuj6njPimPYkwj/hgBypW5wqbG99xr20e/p168DzauC+1PensqsRj1+k0DSP+SfD8Rr8jNfQZ80g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dqvw5rSR1sT7IfSLN/OPa4xrGDXTmPEafOxw9+C/bcs=;
 b=J21RSf1CDwDv0qmdkVLID88x8qtddjY7Xs9tlDKMmAS2limOfVWKWIhJ9Ptbntn8ck8PfAqaFJmgkmO7nuExnghHilwBf2rKML6G1Zu0R/GWDTjsbK8F0h2Ft2EIv9WNnpp5YI/AwBwCgv9HJd59tUO992fz0suvcJkkJzdH5XI=
Received: from DS2PEPF00004557.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::511) by SJ0PR12MB6855.namprd12.prod.outlook.com
 (2603:10b6:a03:47e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 15:20:38 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:2c:400:0:1007:0:8) by DS2PEPF00004557.outlook.office365.com
 (2603:10b6:f:fc00::511) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.2 via Frontend Transport; Wed, 5
 Feb 2025 15:20:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:35 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:34 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 26/26] sfc: support pio mapping based on cxl
Date: Wed, 5 Feb 2025 15:19:50 +0000
Message-ID: <20250205151950.25268-27-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: 95dc629b-76f2-4c54-957a-08dd45f8a548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tLo/jMBUeox8NiBPHQg1bBTsYuODZmdrw3FbIfEVz1oirfAr7bfOltTag8nc?=
 =?us-ascii?Q?geeKKpIDjyVbqtq8NLo226+bFEBcwWAKkm8YRgXyMZQnhsH9m9AG8hxnW8g6?=
 =?us-ascii?Q?5zLrPHKV8YYguWKV7z5E75+hpwWF23N7ZNDmQkJhwYA876pP/lxafm4oBmx9?=
 =?us-ascii?Q?eNN2PBLpGwDNf9jW67npCmiuuvRL0CsnGwkpWEcwBr8tDrir13XIk6kBvqid?=
 =?us-ascii?Q?p4MHylNXWHCr8JRYmUyBAWdY1PUP7+onF18SRCXXz3wBZNq4Hw+BTHsCIwFp?=
 =?us-ascii?Q?3iZRHuZpzwwHGlMtgOLhJ/ifQS/sQL+VvrqmxGOE1ywsSwxIMgncOA7E2om4?=
 =?us-ascii?Q?+1xqIw+/h2/vsMi+HJ+4XHErrwqP1QRo2C3mZvXqzU/yOxVLP3KiAoV6/ZWE?=
 =?us-ascii?Q?9C3eVJECfndt7jdGuIi23s9to3lXdqFPd+mx1uNj+mLIniLXdaAI7LozEBa9?=
 =?us-ascii?Q?jMTdBgeC2iootPk9wW8D77uRHGil0iGktdRrBHANswSsvCpbmo9SqeMaH5rm?=
 =?us-ascii?Q?7MXoq6XPpVii0IWdvjZtnZb5ze9E20OXp+yJOcVGOkvV7/JIFOxpCjw7JW+e?=
 =?us-ascii?Q?yuK22UOVcTlkpwCw1flkkwFn5AuqEtrVVEfZ6B5LcUj2Mcupi3ldCT07lZaZ?=
 =?us-ascii?Q?T0c2IWZtBhDbkCuHfqwqZ/JLA6YJ+HvIwxnsdslMBMd7nIAEfq9FIatokyUz?=
 =?us-ascii?Q?SG0+mwpLQH2EtgF5e7AcBz6No6TSw6m+IQ0EfO/8sIhxXXyX8kDR1Zup8425?=
 =?us-ascii?Q?VzRT6mz1h2f7EiG/Ub6Ylxowrmje3buG1UOYdKDZqZMJjwogEvb+Xl/hZQ+8?=
 =?us-ascii?Q?iIbje717IHo46DpHWwxiSLgbQhRTJkZebSrvj7V8IAKD33Jp0uwoJl8Q1rld?=
 =?us-ascii?Q?Qsj76cz6DbiL5+/DvXXiRACSGsD9dE/zFjUm5X/yvoXdHftFOGpcMflMtsSo?=
 =?us-ascii?Q?w65/5Bcmu6jAwH2W2HA/x+KZ2xl+iS6HOY8dJzPbYdTFE0hgOstPokE48PVk?=
 =?us-ascii?Q?jkXNL9wNhYXcMu3U+zKsDQ2l9OmYO+RX1L1nJ2umL0qW/i1zpzwSDXQ91JFi?=
 =?us-ascii?Q?b/XIYUVQZ2pHTnIYJp+sGmSVyRYOmnmW6iHUT+UjAh9U7Tn3yWvsSOnXmgkl?=
 =?us-ascii?Q?HxNx7z7Pu6c46i1TQmvR2v5OQ+39Dp0iw+E/fVN3MZzcsB3GHgC6hnwPLJtI?=
 =?us-ascii?Q?7C3MVjpZSRz8UrBrqop/MBOKdSs7FIyNSPeVY65HkxLt/PLSte3UGHiMt0vp?=
 =?us-ascii?Q?5zp3qqygmHq1HLXzYEdeEjkbfkuU9JwcWrilFYGVSdCmoxCxDSNVdcXbc0jY?=
 =?us-ascii?Q?fjsAAPchXz83rYjM0dAsmnvEQPBeq7VsRgVdkKBOAdwf7sXN+LdhAD9fF2sl?=
 =?us-ascii?Q?yfhKmGlnk7t7CTcLUsgsBASJjy7HdJCgHN1EgtB8mN1cHh79mFZdJ3hRFNON?=
 =?us-ascii?Q?c/fHP1k+zQSZcPeKjEZDuZUtXocJ5Xi28wO5bvCtr0qWNOcD+rGcwUB7ONGj?=
 =?us-ascii?Q?FUK4xmJbCFnWLhA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:38.2588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dc629b-76f2-4c54-957a-08dd45f8a548
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855

From: Alejandro Lucero <alucerop@amd.com>

With a device supporting CXL and successfully initialised, use the cxl
region to map the memory range and use this mapping for PIO buffers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef10.c       | 50 +++++++++++++++++++++++----
 drivers/net/ethernet/sfc/efx_cxl.c    | 20 ++++++++++-
 drivers/net/ethernet/sfc/net_driver.h |  2 ++
 drivers/net/ethernet/sfc/nic.h        |  3 ++
 4 files changed, 67 insertions(+), 8 deletions(-)

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
index eac849b4e0aa..76991da1d2a9 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -27,6 +27,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	resource_size_t max_size;
 	struct mds_info sfc_mds_info;
+	struct range range;
 	struct efx_cxl *cxl;
 
 	u16 dvsec;
@@ -136,12 +137,28 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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
-	cxl_dpa_free(probe_data->cxl->cxled);
+	cxl_dpa_free(cxl->cxled);
 err_regs:
 	kfree(probe_data->cxl);
 	return rc;
@@ -151,6 +168,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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
2.17.1


