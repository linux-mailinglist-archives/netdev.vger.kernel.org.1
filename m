Return-Path: <netdev+bounces-270487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJv6NI4nwWmbRAQAu9opvQ
	(envelope-from <netdev+bounces-270487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:44:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F47B2F1619
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4ABF304CE98
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99B43988E6;
	Mon, 23 Mar 2026 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WHQgZBIP"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFCC3976B7;
	Mon, 23 Mar 2026 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265533; cv=fail; b=ExwCWuv8kNjdY/LltURSzh5vDEclHemI6WNIPa8Clb/1/s4NePRa13egHcfiRGfMUaNeJocQx+iP7hyR0kpLCG7QWMBJS1CzuwbTdsx9tJKqFa2zkbw359EBX9wxW03FdpVhcLoa8jP8OfGXQ3q74nvxdIVcOVQRSNfLPVR/sxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265533; c=relaxed/simple;
	bh=9y+EIBJgNYTtgveQUNwLagJkKBOe9EAHHLaLK3nVcUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kY08LN0E2NYZT26ltJMpQlph/YPNo2NeNBKyIDtSsFomGuNrhDbmqHsXyzYkI20qSWnx/H/lX4MFtEPtTfiuqDmG8zs1Yfl+B+E+JlX28z+kYzl0TJq2NclYLo4h7ly6i/uHv/rBIrRBk+bc0VcxQeWidLF07jXjz/vZjP6XEvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WHQgZBIP; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMS6yFpGuI/f+ltUt3749XZyNr0Xcni0dB02VkGfGfBW1XSy2sZ7alLTXj1k5DIQjcymQwNBWcnWVk+H1gsglvW+8JYUuXn4FEl0Tw3wPF7Ub3WNDiNW2JdZs6n1B1/oXp1Qcg/xdOj1wJJu9a5ndpddaTSeR4oULcn1yYGktwVSzCkLPDVgYXQ+8hcTMzBw5hKLyneziUv3bg1J7vn64xit0t3ltu3aScSOkJS35encThJHkPE9WuTiRp3SBLi2ihVlWyhqYEGZZWgnxZ6rLFR+jWa3Z0uOxr6AkULIM9f636zgdovGual2W1gG+DR9boPw3gziz1kRbvNAo/MeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcGhmGjKSi5SKgMjs8mKXFPj5OAwkrFnhhJTeW5jX9o=;
 b=GjcBVt8NgI+zMwuyh8lDxGRnES9W3JcsSK0uZCSyBLVRvB08qmKO+PSykqg+OBl/aIBf000F2Cky2nDMyJU5yoYNFAEEsFRKFzT/N43hQXzYi148m0kcdfRDK3ZZuK6Ta7K7GLGZgI/hO0hkfjPPDTeKcUsGaClZCHNO6wOlYC2xyeCOuEwNLhMVR9+cFJOt1veojL49slQpW6HJFD72bSeUVbA4LchYRn6SxizRa8KrFkwMEtTQSrA1ONFq6K8CNlqmz6sT8L80SfdYf4JhziBa757oBTeMIrUGCcARujetnbhRtvvPsmyNIlJKqtJ6EvctVkPcvOeLzhjXLOAryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcGhmGjKSi5SKgMjs8mKXFPj5OAwkrFnhhJTeW5jX9o=;
 b=WHQgZBIPQQQU9Nm5SIujCmVNfgHAxOyIRDW4/qw8JhHlMJsKN5smUspemP4MAs0BxRx93SfmZ9Je0bCZjf00gmLov0qhNbsnk5DjOUbpj3VLbfbm627jw18ecv/mAZxcAWFJzMYYpZEG8SL+RO+V6o0ZdcLZr00dDZJgMDR359c=
Received: from CYXPR03CA0061.namprd03.prod.outlook.com (2603:10b6:930:d1::26)
 by PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 11:32:07 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::a3) by CYXPR03CA0061.outlook.office365.com
 (2603:10b6:930:d1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 11:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:32:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 23 Mar
 2026 06:31:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Mar
 2026 06:31:42 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 06:31:41 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v24 11/11] sfc: support pio mapping based on cxl
Date: Mon, 23 Mar 2026 11:31:17 +0000
Message-ID: <20260323113117.2352709-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|PH8PR12MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: 839c7407-d9bb-497a-6a67-08de88cfd0c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	diTB1wcbVKYFc5WfdL2MCTrhttSd/U8sKkvBtES/IEyeFpGwmzSPenwAHZM2nWjKMa3uMwCZVTU9YfmVojQHN3clBBhtdPmSQIHwD0OV663fb9g60YrBd+d/rvEloLm2XB85EYPPIFze8uyJ+9oCRaAe5VNjyLrrqtLGVrCK1ZwE1IWOnC6k7iZm33BK03xfNzW6e9wZpfPpd7cO+5b9MU4OHQOsh+hdKgSqdjD3PB9MuEuEqaCN1Zdi8lsqfJJz8y3rokB+HOq6zTJFFzjFwr9wKIiyhx1dTQFmy+WQzKc5uDPzjtD4zrZuA3HR3IFbFaYr2SuRX6y+GgsZTYjX0F2WPjxuW37Ve7OU09On2fQCIHOzABQLpH9IB1xzxsDxHDkt2ZBj3QfmfUHYSZiUpLcPr50OiUhsW4MkikdezqErQFr7xcr79VaZUowJOaNKgKnsvzrmejlqbQNqRHCrod7gkI6MhxF4LklRVzV6HDioLjPoSOuHo9tfPDs0vmUZditzBGldrmMQx1beUXPqqDJoV2WFu5AWEWqhtf4rr9o3+EWger19Peb0t4fnRuTqLlEm4tDb+oSig8nqjlBbvx4maZReQMFd4jZRXbte8OMitk1/lvdqYVQ3doCgthm5Ls1JRoe/XoJs9ma4ntVFXQV6aIomkYsKperHgDTFT874zu89UnnSP4GxIMrOA334lUdJTvn/3SRsxGNJFXKTY367PLFkCcSprUxqSqYtB4c65EXaBHO5+/NFrplTpOG0IFybwBrwHzwidEw49Z+Iow==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J0Sk3r9SE1KSKnI4NKqsJVKPNpEVwKCXcZet6QJr2hxnl+PlbMbTXHIxxPOGiCXg0gnJpGpIl7YcVXoKKFtvWud01terd0HX2ZThvF5dvPtwy1CCQtJt5DK5NJ+UprhCs1voCBUsCdhT0l10G3Gui/UaBG3chm/poIxb2o7SKIyV00rknwplsOC3dz2kR1GhSKnrhiN/+TKDH8YjNrfwCSORgQGlhVZjM99SvKBfLyqdZv98BTVzwbp6rpAkyg9XSZjfa+gRUptqzeWXNac94tuDo8lX4bec4ItKyz3E8rYGxnsxcQgPx2DSbrasaj5JkEfY0uwKHp2nM8KCDWjpPSzq68dQiWDwDOmzyLltclRJSf19ac6lqg5IRD1oVZL9GQ+AKZTaHU1n6qFurszyhpW+vGVgv1flPssEdwvYt82+frp2rze2tt9S/A+Lovi5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:32:07.4696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 839c7407-d9bb-497a-6a67-08de88cfd0c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270487-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,amd.com:dkim,amd.com:email,amd.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5F47B2F1619
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/ethernet/sfc/ef10.c       | 53 +++++++++++++++++++++++----
 drivers/net/ethernet/sfc/efx_cxl.c    |  1 +
 drivers/net/ethernet/sfc/net_driver.h |  2 +
 drivers/net/ethernet/sfc/nic.h        |  3 ++
 4 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 7e04f115bbaa..ae422bac329e 100644
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
 
@@ -1263,8 +1281,28 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
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
+
+		nic_data->pio_write_vi_base = pio_write_vi_base;
+
+		probe_data->cxl_pio_in_use = true;
+	} else
+#endif
+	{
+		/* Using legacy PIO BAR mapping */
 		nic_data->wc_membase = ioremap_wc(efx->membase_phys +
 						  uc_mem_map_size,
 						  wc_mem_map_size);
@@ -1279,12 +1317,13 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
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
index 78f926300943..ec614f9242b2 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -102,6 +102,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
 
 	probe_data->cxl = cxl;
+	probe_data->cxl_pio_initialised = true;
 
 	return 0;
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
index ec3b2df43b68..7480f9995dfb 100644
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
@@ -187,6 +189,7 @@ struct efx_ef10_nic_data {
 	bool must_check_datapath_caps;
 	u32 datapath_caps;
 	u32 datapath_caps2;
+	u32 datapath_caps3;
 	unsigned int rx_dpcpu_fw_id;
 	unsigned int tx_dpcpu_fw_id;
 	bool must_probe_vswitching;
-- 
2.34.1


