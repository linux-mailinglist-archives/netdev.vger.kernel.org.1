Return-Path: <netdev+bounces-303589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id almxN9zvRGpz3goAu9opvQ
	(envelope-from <netdev+bounces-303589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:45:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0F96EC561
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:45:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=y7mtsW5f;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303589-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303589-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98BC23106FBC
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7475441931D;
	Wed,  1 Jul 2026 10:41:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D014D409114
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:41:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902505; cv=fail; b=BJaw+l+tZEpkL8gy52v7jP1VzdibIdQZJnrs75cLwaqJSoexQi1YpzyLFU7BV6qdoJFQlk9fHP0YUmnrtVBhlBlh0gwXd4CmHwWaagP+u/VAspoN33hydjgEi0l5SwTpwSTX5x2zidCv5NknPIk9f98sc397hZSIRQRT/zbT5vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902505; c=relaxed/simple;
	bh=5UT9XbEsLIKLRLtBOmfOk7/OQHMRpC261cTo0TT1Bp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLbWVbtNILfMIzuhok1Ad28wB7zIuR9V4oRgfJORQP44XVwQOl807R3qCwKwwwvW4txohSEIlkiQMwBwLDKjvf4JBvOnJAjsyIwKVOGRuAlO162K4bF6cDJd7LguMf+kxkJMdg3LyaoJFmRpFUNGMi3Uj/NJWkfSNQChUs8LMxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y7mtsW5f; arc=fail smtp.client-ip=40.107.209.6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxbmVTXzQ/oKyHFAxmijDadXxOk49dz9SX/jljwfCQhucLVDL/B5HUyIKIHZqWxpZuK18Eg2EHl34qWGSfYiWg9cEYFckOLfubRG2955/OSrBNMUfRLlSOeRe6qkb7QeGhVH/eWCsu0E7KJj8FAgcPuAbLZeqvnh7WNp7WimS2x+vVlOw1Hyyxf4KGqjQAy2+OEHRUjIUn8hj4Nvjf6Z37PRWxVoifaLnUri4NyDNRts8JoOJ3RorxK8gni6xM9FYVve+mLtd8wnek11S31vtl0CKD9DtmOyfPjzDxMkCV5xHgX7YDaZUEXqIs5yCGMd/o72fh95zpAmvoRF78lmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfxhrpoBNqJxWHmX9H9tV3kBYdXHyhJwNKlPR4i6tjs=;
 b=WE+kPj2OXCQy+xbFHt7I5V8u1bXsCVtyrvTh7pFH3xB8rZMYNinq7uQvJzk92uuDPpxSEJpyy1wcI+TmRXyZEqOQnueaV5hXKAtOZk816YOWIuBQRQq9XPXuaDngGU7OpDb3aGkALiqUr3l0i1B+fPhv6mdiao+MuK9WgiwKTUl/NOYa4AW8t76MioI/uESNZ1r+QDavleGN8eAFG+59lLp0/iy0w3wj2qATsAZrmsMGAKIBU2vlNN5gOImpG+n/Dm2p0KoDPkLJM/zmddR5PeVxkh4S7+aN7DkP5SQN6kyAuVWLklW341su4TdHwVOfAdUJlcEqHVutuOGRQSzpzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfxhrpoBNqJxWHmX9H9tV3kBYdXHyhJwNKlPR4i6tjs=;
 b=y7mtsW5fSsHOmVwRZY15rxGTRMQgI/UMWrod//3bhKQPqLrXVT9207q7IkUhYeiWGcc/8XifdWil3+IQRwpzFeotSpchcK/WquDms/TCojl9lVhJOzRxpsmR6CZtYn87UmauXyfA/5la50jG2xeLXrDoxwM4Ru6ieaBdPnu+2/0=
Received: from SA9PR13CA0143.namprd13.prod.outlook.com (2603:10b6:806:27::28)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:41:39 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::f) by SA9PR13CA0143.outlook.office365.com
 (2603:10b6:806:27::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 10:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 10:41:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 05:41:39 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Wed, 1 Jul 2026 05:41:38 -0500
From: <alejandro.lucero-palau@amd.com>
To: <netdev@vger.kernel.org>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH net 7/7] sfc: support pio mapping based on cxl
Date: Wed, 1 Jul 2026 12:38:05 +0100
Message-ID: <20260701113805.14072-8-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701113805.14072-1-alejandro.lucero-palau@amd.com>
References: <20260701113805.14072-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 2076bb09-59f9-42ce-22d4-08ded75d555d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|56012099006|18002099003|11063799006|22082099003|6133799003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info:
	0kkV5Rtdb3+1achudQOU6FtLDDyxuvXSFW0GThIkmddXIy09kOHcnRdpmYdWMDobuBsJMwuHw77FuTUTpwi09tU2uPmHRibjjGm+aFvpxU4Ej8KkKP0upP7HBbcN5HAwWig1cb1/zEA+6GKIImG8wMKa4rnZRiw2YPj7A/Tcxh3erZ49LzfDpOUSfb+QjoAcDuQ4hC36nd+E/0XUzPew7MaMiz/NXGphQgM31KGiQVOsiY5CUhMAX3layIA8suvi7PvYiYPIpF7YcL3BO8RHdAU6LTkzyVtbCnZmrkbwjbqbketCPgLjF1Lg0kwsSPh+AxX0GRqaw00qFMsBgjv+4j1D2r1QXthaypfjchCkAqt3jRjRcuad30AZuakMc9K2saTnmEXOzCU+HLUYrU2Gdo+xmOfRcq8qZNtvGcr6m3x1LHjBDdUsEWtr7V2o6+iHN/xRkwqiZDlw2mYNseGPiT/L7WhUBi7ICu9t/16WtmfOiaqk10RTA1pdvkhx8pzBteM1bRZWlZEYfKA8RjA4NIFHggP2uF9bajhSUAgCxRa2CWVTT9zKSlqZTGeGijj6rlKy+pgHuAZWQdRb+szMqozo/fUyKrzwGPXBhvTvL/Ybg+idp91JNa9Mzm4OAc+WGiFVGpTn8oELQC98/fmfvGN+plM9BTFUUDZX6tzzkdw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(56012099006)(18002099003)(11063799006)(22082099003)(6133799003)(3023799007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/hvfvGz5DtIb9ChdJsbuAdj8sBdPTMlF90pueHSD3o4nMl8qMvUHvzrjvvw6r/lgEs+7tvw2xfd87j+AhSvToz4bIXLrYJn1+2gK7I9jbYlqg0ctj3fLrnPDTt/0doD8Egbh8bNJRxZ3oOHalW/JTRN7evGVMWd4cx6oFjlBzpzAQBfRu32bHY5ETIrDAA07RcFY/6J2BGcwpsGQtcpeLrN0ZuooRj+eOmVwUKoVNUGaoe6K/Ha/wY55MDouMj9m9qGmm73Go+UCa7/dwa5bQD0ETaK2quLn5tTfjZoTBGRskphnpKyK/9R3/ZtGEVRxnc1zbApFMRNhjXicoeYX89ZRRjmnUCg45N+5VBu/Mj8v6DTkymcaLM73SE0U774VlAXayocfhWZ2/Db7IlWf2xsAkx9zAL06hHUrjlmJ7gEHVZN+1tVy4L2R3NtadJ6s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:41:39.6946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2076bb09-59f9-42ce-22d4-08ded75d555d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[amd.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:dave.jiang@intel.com,m:alucerop@amd.com,m:ecree.xilinx@gmail.com,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303589-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,intel.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F0F96EC561

From: Alejandro Lucero <alucerop@amd.com>

A PIO buffer is a region of device memory to which the driver can write a
packet for TX, with the device handling the transmit doorbell without
requiring a DMA for getting the packet data, which helps reducing latency
in certain exchanges. With CXL mem protocol this latency can be lowered
further.

With a device supporting CXL and successfully initialised, use the cxl
region to map the memory range and use this mapping for PIO buffers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Link: https://patch.msgid.link/20260630151346.31201-6-alejandro.lucero-palau@amd.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/ef10.c       | 41 ++++++++++++++++++++++-----
 drivers/net/ethernet/sfc/efx_cxl.c    |  1 +
 drivers/net/ethernet/sfc/net_driver.h |  2 ++
 drivers/net/ethernet/sfc/nic.h        |  3 ++
 4 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 7e04f115bbaa..73bc064929f6 100644
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
 
@@ -1140,6 +1147,9 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
 	unsigned int channel_vis, pio_write_vi_base, max_vis;
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
 	unsigned int uc_mem_map_size, wc_mem_map_size;
+#ifdef CONFIG_SFC_CXL
+	struct efx_probe_data *probe_data;
+#endif
 	void __iomem *membase;
 	int rc;
 
@@ -1263,8 +1273,23 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
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
+		/* Using PIO through CXL mapping */
+		nic_data->pio_write_base = probe_data->cxl->ctpio_cxl;
+		nic_data->pio_write_vi_base = pio_write_vi_base;
+	} else
+#endif
+	{
+		/* Using legacy PIO BAR mapping */
 		nic_data->wc_membase = ioremap_wc(efx->membase_phys +
 						  uc_mem_map_size,
 						  wc_mem_map_size);
@@ -1279,12 +1304,14 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
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
+
 	netif_dbg(efx, probe, efx->net_dev,
 		  "memory BAR at %pa (virtual %p+%x UC, %p+%x WC)\n",
 		  &efx->membase_phys, efx->membase, uc_mem_map_size,
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 3e7c950f83e9..348d7404cd7a 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -88,6 +88,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return -ENOMEM;
 	}
 
+	probe_data->cxl_pio_initialised = true;
 	probe_data->cxl = cxl;
 
 	return 0;
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 563e6a6e85f1..3964b2c56609 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1206,12 +1206,14 @@ struct efx_cxl;
  * @pci_dev: The PCI device
  * @efx: Efx NIC details
  * @cxl: details of related cxl objects
+ * @cxl_pio_initialised: cxl initialization outcome.
  */
 struct efx_probe_data {
 	struct pci_dev *pci_dev;
 	struct efx_nic efx;
 #ifdef CONFIG_SFC_CXL
 	struct efx_cxl *cxl;
+	bool cxl_pio_initialised;
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


