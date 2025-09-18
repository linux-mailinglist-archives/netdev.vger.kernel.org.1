Return-Path: <netdev+bounces-224336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89126B83C0D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314EF3A3DCF
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FBD2F532F;
	Thu, 18 Sep 2025 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wy3wPX6z"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F07301482;
	Thu, 18 Sep 2025 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187122; cv=fail; b=B/jBV97aGhij1KcnnIfuP+v8V5aLW7bhvn5PienWxbVWh2qj1Iu6DYNOzRUnuzKo0XSKfk2kwDBpGszveOXrBdtKRJF4HrKb/BRK6UbQMuEnfkBmyrdF/5J131CTo9sZfhcSKCvG35qGrF3WViIm5zCkMXmgjKJgLACdHAlzyG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187122; c=relaxed/simple;
	bh=E+1d82fVST1x9K7iKIVqDhyO9mpbnz0S0XVS4ebO0HI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V28MoMXaYKSkK7Lqn7bguDA9ihhvxZf0mk7Iy6YNkzD4fxxY5dF7MhzT9B9cMcrHWjADPQgVotST+m6Wr/omdCGFocjnisNz/GP4r/ND9LPYGeLiDTvGNsIrIOWLmJQgCIFpcC0U7CYHUvzTaxH3W5nnf5aeEPI+XJX/6NRdGHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wy3wPX6z; arc=fail smtp.client-ip=40.107.209.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bh9lBQ2+96th7fwDGD2Q7qowF/kHEQgP16yFep0heU70ICy/OIfmrQJlTXzgMQ+PV9BgEria0RqkeHgu59D4QK+RnuuGokx3uwmWm3VDhVgK8Ik2WPLCSItvA1Lf4mAME9kdmmiT9cddDlcrXwzZ+EB3jlMs9xyXb465iXyjWzXtuAmXxaAAB2MsFa5vzs8rXmf0VkaHY8u8aO4SAHxeI6cL7hJdyk6LFxJga7YhN7wx3oU6juKNg+k1TXH9aFiwBn/EhB3RyQLe0lWF7CzfvZpgc5yyJgO9xB1zjW0zePfskyOOEUv6MSGUGm1vHB7pSteIwz81D7IJyoGGzYZfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RD/RzcNZkMTGb2zEl9fUxFnfSjsTsAtuYLzz0S3Byec=;
 b=VabQuKBxEKFlq9tP9iCHQ6IqTA3yInOa2zeTxqqnmOIb2muMy3aPUa/HWA3LMERqTWjm9CZyd9/yWGESVgTgUO+PhMUy1hGBmhBqLulM6pBhUOacNAS7JcA8Dm8UlaHnhI5KxJ3bKSOXhYxL2jX4g/qyqbpNEn4t/3Op0FzimRNbSKYmtzCtV0M4AWdzGhOboEpPVi9kvh40fnltL23KzVU2S5nCA88SY5xc4OzHRTw2d2LWvn1podAbNjqDQR2jN4RXJ+3oe1oyrhmjwRA9LfJcbZvrgRHOPSdG7a2n5yJk3x984nRf60JW5LsKPlLjDET3cIk5jKi9ty3EQ26NRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RD/RzcNZkMTGb2zEl9fUxFnfSjsTsAtuYLzz0S3Byec=;
 b=Wy3wPX6zuMTZLxX5LGJGSlxuJku94aJIqpzanXs4P9n1DOn7Bi/wln6ud9WCPkxA/T69RG+Xy6Ht9obGsTnE+aadoyuxBAmee7H6Fyikn0ejcExQGQwZE3ytN9SPKRur0pGIT7WbESUmW6QoVn+wVijAMJINSRalx/6b1h7iT5M=
Received: from SJ0PR03CA0132.namprd03.prod.outlook.com (2603:10b6:a03:33c::17)
 by DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 09:18:34 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::6c) by SJ0PR03CA0132.outlook.office365.com
 (2603:10b6:a03:33c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 09:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 09:18:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:32 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Sep
 2025 04:18:32 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:18:31 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v18 20/20] sfc: support pio mapping based on cxl
Date: Thu, 18 Sep 2025 10:17:46 +0100
Message-ID: <20250918091746.2034285-21-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b586b02-f1a4-4209-0def-08ddf694579c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1GEmIPvhxf7vbCPbWj6A8ND7h7N/gHgrH246NDOFHgGJomEqjLxByu2xETS3?=
 =?us-ascii?Q?2HDMTW7g+haVBT9vWzooozqB0VRnyeMlWuY+2oDp9gpcLGCMYj/mZZku9XD2?=
 =?us-ascii?Q?7MFMt9DSSejymjZcO7MLvTCZ0KxNmJ18ERCNsr7C3hV8ozpNTCDhQqEgrJln?=
 =?us-ascii?Q?pPAFFvhNhiIj71F9Uj9dk8t+eGPC18X8RssdmzZ5E0YdNJm8MNMexxhb1fEc?=
 =?us-ascii?Q?34qG3dJmcBKbPcotCl2zUxg1jM3ySFTHp2EI1YmxEU8Um5s1EahUGfv+8v/K?=
 =?us-ascii?Q?pdq0193pbE1Z2to2oGnSRO0rTEWXQw8VB8AD7GHOM0ln8pg+n1DhPAcy5oyj?=
 =?us-ascii?Q?py6acCx659Si7AeTkELSP+JQ/01qIyrmqsWBUwVaE4s5aNqOlC2ptoL2fVFr?=
 =?us-ascii?Q?Ex/KCBHOmxk9arkbDei81HyPoavB7JUaj32coQYEAk9VFVN6QCYL3/FbZVVO?=
 =?us-ascii?Q?+H+J1K9eRANylcsM3glfenPSO5g29rRYYCPxpLRbXohdYVEWLYJ/OGwIuFKu?=
 =?us-ascii?Q?oBX8ZC5z1oOAxapHBeHK+GRl94uDaK9Gb93gGaa2vmIAWgfnlg5Z0CeTMTvT?=
 =?us-ascii?Q?loF+GYdmevdjzievnbBSSOaf3F0LmZyiJJgOA8+ZRNZucTmCX6VVEXo84dlH?=
 =?us-ascii?Q?Ul2rX/ecMzIDqAPDBiaEh34yspjUffKw2PE0RIdMDOBhfAndzjtpmRF41M33?=
 =?us-ascii?Q?XLtmd6o4Nf30XgvyX36QYYz9D3TDu97oP5L5mR09iK8S7MJrBsGzR31m/61p?=
 =?us-ascii?Q?Uar/SNVUrQ4Oki3OdPjhBn/vSql9ke+nJQZuuZwVESLJ+g+JKPe1AcULZyD7?=
 =?us-ascii?Q?gFdnt/qa7z+lVO3QZ4Jq25SOQm5tYpJ20oHUrAHudlfROuj4u29I8Za/LzdQ?=
 =?us-ascii?Q?0oSvFGijiGsfoot448ndAM404JphYCYTH4/rGNHpVYwZTegfKCbyitYEtVok?=
 =?us-ascii?Q?KYR41pSQ7FjE9gHAf7AsqKBYBVNA6wsDMMSaIXK/vKZxbHAvgNzhiRRQDCza?=
 =?us-ascii?Q?P8dI1l9kEBhVHVmiVN1ex/UIKx26wV3/cwLPeKVLtb11i5LgpHzuPo0KqZ4R?=
 =?us-ascii?Q?M6u6jLGQdrXpM9uxAH9yVBQHAP5KT7XoMh4lEeY4qEN6yE7pQENcGvDx41eM?=
 =?us-ascii?Q?AqfdAdA9qSYlRYEPZPDOTQ7+E9mLYY0eiFXTbqmc5UQTBIKEo71Pbqm/VwqC?=
 =?us-ascii?Q?3V4IT0YJCuEKCZqGxKn9xujLHshCqIRdPiH0PdAxnFkzsKs8umXCGE/OeiGG?=
 =?us-ascii?Q?v5oI4FJ4iKuZymzWQrhfJYml2O9Kvk54WtOh5cnPZhnIN77+DwzffDZfu2Ej?=
 =?us-ascii?Q?qnRxbb8Smb34uHvpWBXjuMZSWdJ5mYxj0FNvRZh2yKG130vtqLXeTmQ5hdwV?=
 =?us-ascii?Q?t/n5woGi++elhBFllw1zS6fVjWYLTTQvIKIx5ZrDCMm9tlfJiCbyD6y+crrK?=
 =?us-ascii?Q?Ws17khBTkoTQA6vVRMI4o1BKRHdrorfrUqIkvkYTdfNxuyl+LiYVRj6n4j7w?=
 =?us-ascii?Q?zpVOLRS+H6yFfoaYvRXrhwCeeUZkVXU0TzE0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:34.1298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b586b02-f1a4-4209-0def-08ddf694579c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042

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
 drivers/net/ethernet/sfc/efx_cxl.c    | 32 ++++++++++++--
 drivers/net/ethernet/sfc/net_driver.h |  2 +
 drivers/net/ethernet/sfc/nic.h        |  3 ++
 5 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 47349c148c0c..7bc854e2d22a 100644
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
+			tx_queue->piobuf = NULL;
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
index 85490afc7930..3dde59003cd9 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -11,16 +11,23 @@
 
 #include "net_driver.h"
 #include "efx_cxl.h"
+#include "efx.h"
 
 #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
 
 static void efx_release_cxl_region(void *priv_cxl)
 {
 	struct efx_probe_data *probe_data = priv_cxl;
+	struct efx_nic *efx = &probe_data->efx;
 	struct efx_cxl *cxl = probe_data->cxl;
 
+	/* Next avoid contention with efx_cxl_exit() */
 	probe_data->cxl_pio_initialised = false;
+
+	/* Next makes cxl-based piobus to no be used */
+	efx_ef10_disable_piobufs(efx);
 	iounmap(cxl->ctpio_cxl);
+
 	cxl_put_root_decoder(cxl->cxlrd);
 }
 
@@ -30,6 +37,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct pci_dev *pci_dev = efx->pci_dev;
 	resource_size_t max_size;
 	struct efx_cxl *cxl;
+	struct range range;
 	u16 dvsec;
 	int rc;
 
@@ -133,17 +141,34 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 					    &probe_data);
 	if (IS_ERR(cxl->efx_region)) {
 		pci_err(pci_dev, "CXL accel create region failed");
-		cxl_dpa_free(cxl->cxled);
 		rc = PTR_ERR(cxl->efx_region);
-		goto err_decoder;
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
 
 	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
 
 	return 0;
 
+err_detach:
+	cxl_decoder_detach(NULL, cxl->cxled, 0, DETACH_INVALIDATE);
+err_dpa:
+	cxl_dpa_free(cxl->cxled);
 err_decoder:
 	cxl_put_root_decoder(cxl->cxlrd);
 err_release:
@@ -154,7 +179,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
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


