Return-Path: <netdev+bounces-240155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FD1C70CB9
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 1217B29B98
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB6D377E94;
	Wed, 19 Nov 2025 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oytoQ0I0"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AED036A03B;
	Wed, 19 Nov 2025 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580221; cv=fail; b=BslM8rWAYcp6/5FrYMJu3dxC39sCjL9sh5B2UPWBxmyaV8NoRnQ+tRUHxZlf2Q5tYMGcxO3o2yDD8iVrWkDmgidyMbenw3Y8OnKWspHVM9fgaiEa4Qygiow7PRBfygHXEt8QXvTDmPgNjYtPSfp8xx2cS3l7Q8Y/3rqorXSPcW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580221; c=relaxed/simple;
	bh=ighbXaI+GKFUPwUqc+73a/qvUXwmQm3K68yZVg3A0vY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h3HCJg1hArgPgcowi7INuvpxjH6C7RMSgwwiCwWDFXrmL/oX71PXfnnWl2vLCfmxT7LzPDhufc/pK312rkZ3eGTihMLeNsjgZEaBXGjP5KkmYOVr8srJxaXlLGyq4/PoW5acR/FvjYFiephcBF8L/Aw03Qg/PN2lhDZlscu0sY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oytoQ0I0; arc=fail smtp.client-ip=52.101.46.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWXfb8oq7mMheVndfMeckhGqqjC3Ve6tmILnmBmTcPRvrwhoXfiItz0bGGtZhWYOYb9iMBmBs+/PSvs1dT1SDG3opxQ7FalGMYMtBQshKzzIkJN8EGCp6c5c/vZRzDUUuyb90oUZndGpOJRHZYlrh1Qu8KYPshTTcqBAzMa6rd7KXgj5Wf/KoELCyiF3r4wfyDn+nxWLHpBsr3LGKrDHNqrRCbpx8J/oDoeFICxuBEKGi/5twxO8EVZEyv54r60Bs+co9c4JHgnCBQfx2oLqqmeLvjEzWF3Pxfnz3p9nGNXfbbccUPPm/A0Fs0HJuJVOUV0+0Sv1ZMqpD+hkLFsvhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WU2qlN3qnNBmZ00lMtlUiMIC7AnkDJgbev75mwxlos=;
 b=DIKIBeZIBlR51NAFtHJWOFy+6qAzsuNtwk2EKRf3n+DHKnif19jlvxhUNWtAmqXMgVp8TPnvHAdzf9/P692q9PKytnzLRrBDlbaYtjtWMmbvo9HDM+6558mXunMjHnAEgbaFWo9glpQVEsHngTa4ycb4EfL0S0+op+Xmt7klJ2gioFqdFTkFo+5ID2goeF92v1MTHV0lVKLJuVoxTStr+CLmKzoLphyLXnLw1y2JDZFKhXUHi2c05YdRsPb1oBnH/tQ7G2rZvJRDXcgz9yPz5O1LBhvlHwRcJozIJONsp7GWQ2NKWxf6K3bKf6A4JkWyKLY5kGH8EA/tM8MM+z6nhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WU2qlN3qnNBmZ00lMtlUiMIC7AnkDJgbev75mwxlos=;
 b=oytoQ0I0+WWPgQjnnNulQt9z43TuXkEUIzbjNbYSdAzMuK9T0PVjexuVYngnIiS/gZ01OBh8867jppcXBYh+Ct1m25EOt8vASP4fpN7Qxxa/h0v/rOmrkepiXHzZ3fVyGkhmQGaDYLE1hxdGJSUwh+OM/LlW6m8LYzYBJCm3S0c=
Received: from SJ0PR13CA0181.namprd13.prod.outlook.com (2603:10b6:a03:2c3::6)
 by PH0PR12MB7472.namprd12.prod.outlook.com (2603:10b6:510:1e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:23:25 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::38) by SJ0PR13CA0181.outlook.office365.com
 (2603:10b6:a03:2c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:23:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 19 Nov
 2025 11:23:23 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Nov
 2025 13:23:22 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:23:21 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v21 23/23] sfc: support pio mapping based on cxl
Date: Wed, 19 Nov 2025 19:22:36 +0000
Message-ID: <20251119192236.2527305-24-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|PH0PR12MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 4597347f-71e9-4a99-8410-08de27a11b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?91XEMRMOdh91Gmzu3fFr8BKofkIRJeHK1xeodDYG61F90DKQ2h7ZhyfzAl78?=
 =?us-ascii?Q?1dETAOAXpfwFjnQqLamB4Bk5VdZGGZx6nd/vphbvvLCx7QDxTU9jPEiTGNwb?=
 =?us-ascii?Q?P+eieGwo9lGgQqFogOgKYUH2+l7CAvw+Ka8m6RormSkE1DD6FzWfRCwCUAO5?=
 =?us-ascii?Q?Gi4VonhlYTZ+xJDndf5yClIYo+p6WcM3qSr3g+BofvKcw48HVQiG681OWV7y?=
 =?us-ascii?Q?4uegULHuYwjew/s7nPIIGEAbYooNOFkKKJJ18E/w6lWJaOh7XJKqIyxNqIvD?=
 =?us-ascii?Q?9gI7CWaTPjTnFsxZvS4S7XLc8ITiAEtry0SrFzEqjIrXaBf8k5ItEZyDvXNC?=
 =?us-ascii?Q?THeL35d/n3fyF7BgELXsosv3I3Og1OMA7rc7sUj3/eqdpJeofohQFQvkB+nz?=
 =?us-ascii?Q?a5XZTSfgdZjWB3YXyAZGmIYCc3CWRao+05cvR3/7fjZuR4h2tVk0c5k6i9p1?=
 =?us-ascii?Q?HrbcKfITDmSTQq6lvU22Tuz4NJyFyAEsLv+G7CPeAricrt9R0mLjzUsUapYj?=
 =?us-ascii?Q?OJ5sKBpNAgb36onQtDsrPHfVPyjcji3AhCzTwcHKSs/Vj8yxPk3wQoGD+sJT?=
 =?us-ascii?Q?cILdcmSuVM8Orw8nIHb8WxQ2irD2T03/ZGSD/sKvVn/GTIyEdsYpzdwJFO7e?=
 =?us-ascii?Q?EVqH5IQTrPZpovewKNlaPZoSlFV0kECkO6UZD5OxFVaU9hPaP1AcS4aU6qv9?=
 =?us-ascii?Q?A9lCaCSVFcpzjLASQY0MGYJTXt9GpWfCZa1snSchi85Wa0hNsZzFryWu7Agi?=
 =?us-ascii?Q?m8HfxXonizarglkAocGQHGNWZW5/rDxDdtp5/kJRIVmoCNe+7fqqq91/4GPm?=
 =?us-ascii?Q?eV1+OPKJoyV4JQHKPmHj96NEb2t/0vO+4BKOqF3TjJnseRFbimw7UO2dHeGh?=
 =?us-ascii?Q?2GITHsRrrCTTsCJYDVijR978xCRkfy52ogvDedHD8Ewdohzhj5tulDl7xshV?=
 =?us-ascii?Q?loiG0nhH79sZ0A2bTz2b9iifqz4zplrUurm3/u97hnV/tviN7p0H/EshwVFE?=
 =?us-ascii?Q?0PRoAwVrcSwra8VOPjEtzC9ygF1hWbrDgNeus9jqndEBclPSs1RHhJr5OC4M?=
 =?us-ascii?Q?HBFmK5jIOMdJJWOcJTZJwndu6vczLLzQkMgFSJxZGcPKCy7pOh/hDp2j0Aab?=
 =?us-ascii?Q?L1BtVX+lvR59o6AjvYN/abi1QELILu3ZH47RH6ZBA9kdYp5FpkAP/xEuIUOY?=
 =?us-ascii?Q?Gueib7f0FWMITTZhULIklawWPVJ5LPTK1xGpDJLSebI4wF2uJqMmsNwpHWLp?=
 =?us-ascii?Q?ggM6t/JtUuO682ibzlVmmj1ItNK/AzYrIj9Eb0SnIVNH1N7Z+eVmMKUt8EUd?=
 =?us-ascii?Q?wB2FJh1yh/7+6nwPurQtz41b1PdfHjqPyuE3UZrU9X1f7jLo38tum+Y4t55m?=
 =?us-ascii?Q?rgokXHDLn7vXt2rTJWoyhVkOurEZiGorZ/lF06dKd7hp/VSNkeLbbbb9ugH7?=
 =?us-ascii?Q?4dTrrrrW1QujrXogKxerS2byIl7ir/QjAGPU4k9JuzPQkpOQqIwFFOwXQ7UO?=
 =?us-ascii?Q?Yhtjx4sFTESJoOxM9d4ccgX0YuBKvpbfJ5OHzW9PlA3ZsEPTQn3rRmnLnCyY?=
 =?us-ascii?Q?fjeYrOl+OthWCWxojnw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:23:23.7061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4597347f-71e9-4a99-8410-08de27a11b89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472

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
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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


