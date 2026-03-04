Return-Path: <netdev+bounces-263804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB15Gl8kqGl3ogAAu9opvQ
	(envelope-from <netdev+bounces-263804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:23:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C491FFA7F
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6393730361BB
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 12:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AF73A63E4;
	Wed,  4 Mar 2026 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fWYlfog/"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00C3370D52;
	Wed,  4 Mar 2026 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772627037; cv=fail; b=pLnCHKDuylD3ByIpNmry2sBtF9WJBRE/PuwdXDtpHJnwBHIO20tH/uR29bwnP/ILwxgbqoOMMbKv6y4N8flCabOzbljcRoFmJsiRva8tKxYC3Kbz64neVj99MEauxQKlPL0WCNnyxUSAypr1Njc4Oa/XKwdXUdyEYOllL62p1I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772627037; c=relaxed/simple;
	bh=NSfZoElNP2B65fTx61wDGTI7KHvXoRrlx8idm9JiLQc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkAIy+K2wD9QJ4DSrvMVNVBC32I98NKkqswl2L6z45JY0p1I5yGbdyJUUX3MmxDlkaDY9j8awj7PY1zIOMNSBUCMngZJDRIzhwwPs80H/5geG6ZaWy8cSvS/ajj0ch9Eh4A01k6PXAbbnPHgcNGAjp1acXYNikDD0oQ8+Mg4q8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fWYlfog/; arc=fail smtp.client-ip=40.107.208.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pcha8nG1/gNyLqrYhGRTph0/8UPXR5AJ+ai2LWoDRKxdzIaLmnVXtyf88AC3aWKFEvNYzX73CQrEoWt5c5r75I8l/0AhJZEC4VGChmnxi1+qUVKtUfe2USNgsFOp/GCGLMk7nOrHG1dI6GIwFzHtERLjI5Ls8F3wtNZ40UChVZR+AHlZk0XJsppfpJnzuG7pl+3OgDHWaMuV+VMgJysTK1KuO7htJ45DbzuO7DHlZ7jhO/LYeNAzusOX3hFj13DXkjvzQ7CpimWvwW439Knn3S09nR7SVAvVAG4xHAwU3GpQ/9miR/ZtZ7A9wT6XKSTxuOQSOZvXngvwh9EdKbALUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuR7BEgTCGJudX59o3wdLp0dUpucU1y8bPd7DJJANw8=;
 b=lY4pm6hl+Jgy6JuTDjB3BzitotG9G8a0Fj7JECLomGbI8HiYwJaoSuNkpWBYfvYpdP4bVkH7gVp2oQLuo01obQd9uS+sJV3sjCTEl+g7A4thKENl4idlNYvprvvNwKgXKqy0CieQa4VgLEhB8e3kqBIXdWDlL0vBLHSCI582aty4ahJ1bncx1aXkwR4VYQ1CelgWqFK1rvHSREr/bXmtqKrwK/4+uY/XwO6spcRq9ZITOBq6zgzGEwF1RiAg4XDuhPklJaSqOJwqcZz123APNf37F0Zk63UxiNQoJzZX2mDvkIe8tRbZ4ZaFDmwpLmNyNKMskuVWuyFVoI3bWOX9XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuR7BEgTCGJudX59o3wdLp0dUpucU1y8bPd7DJJANw8=;
 b=fWYlfog/c2BeiKdeYTuj64kJL7D0v3etsXloPKIbNbQ2xnLmP1E87R30eS4Z/jwV6IZnDEfvsKM13AYDP39eVsdMXUxsGYJ6SKX7jtd6BN0d0oIGJinPRBxhQIEJt8x0RewXow6mDOg++zs/suqzjRyrMJaVUv80C5Qlxn3De8g=
Received: from CH2PR14CA0009.namprd14.prod.outlook.com (2603:10b6:610:60::19)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 12:23:50 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::8f) by CH2PR14CA0009.outlook.office365.com
 (2603:10b6:610:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend
 Transport; Wed, 4 Mar 2026 12:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 12:23:50 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 06:23:47 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net 2/3] amd-xgbe: prevent CRC errors during RX adaptation with AN disabled
Date: Wed, 4 Mar 2026 17:53:04 +0530
Message-ID: <20260304122305.812541-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304122305.812541-1-Raju.Rangoju@amd.com>
References: <20260304122305.812541-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: e775739c-709e-4f59-3dba-08de79e8e450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	bp4cikuHfoRGZkquj9gxIK8/zG4tTaM+OUkmGRM4fpkMVQXqpz7SJjjFDZ4+rvif/ZZYHC6z3vz73HR98/bA0DdEouCH8pnQimjYGwgBsa8U70GcrGkeXgKMkXc6mu7WQjAWtCL8htxmp5gJqoij/j3Rf0JBXjZochyN7DuUCdjJCwFHWhMM1UUKicM11ucgID6uFkRkCBRSyTzqWANcwKEBFrLF8+LEV/VyqzlqSkFY0/ysjDDnPL+zD569r9/IhqPOzhCQPsi4D+hXq2iqTJz/Xk5+y3xOWvWeVQaLRR9D6l7fW1xxGUkAGuPeSMYz1gvRoMqRa/Q3mWyGXuSUOe7Tn4UxMuHG3/jF/4uL8B5j+WKqx0o0c2XyhTsDq60wFxD9YBhJYNzyAL8oU00GxfQeQYIDw6rgtFDjVBlC7fZWj9RMbWs70LNfTcUrnBFqK/eJ5Voir4tvl8N9VbHWM7Eb9neddaO0LZnX1fXGZW9bWdm7VD7x+WZMtO4JcX60RcLrJH9MvdwD524R+serZwYepFhlekQBGiR0dNClbmgyTDAQrUbrC6SI4shVdhWVKQztmuBjR+/nB7+9cb4jC0rPGTSRU4papilQbbELXd9WsewwvocAw7EgnJQDWpd6tD+2t5/9XsffXI2B1bWkzdm9Rslq8fLK6OJahPj8P3D2JQ+LHIkqMn8GCNHoQPYC5d8R5H1d5g8yOwotJ14fYxy07KV1KtUSE73N0pAaLis+WxK87EScaN6p443zBxskAQnHhxPjaMVxsaj85burVw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DQfHbZygpxk8s1athq1/hKJ4mmOxrCp3LpRnqQdPWoVD8mrkdRmpbZ+FNou5sYOwTHFx/5KSA86z/Nmbakl43kqMnXmDtWc3ougLxnOu6uWb5VrUcEE9C+9tuHCgaM9jxgUIjBLnhJzeYvF4H69+gDm9i6+1zEqSmOqsfWOc63trTknb/RaI6U+FJ51G292WIinRrMC53yceGPTE2H41IJdyuJL195u92xWniPAPw4Wp0DknYfcCAfWZjO+hDY8hf7SMVu6pPC8aF3XQNA1LdKRIchGM9e+j0RgybArjEss5POSW34QfPu8Uz2HgVN6A1cNdXML8XJlKhL7iMaw38D3/ZSap6C0hqhEFA7K73X2yiL63PtotgO5qS0ZTFTY/6X6uxTDfTZrINMPsTPf+RwvGxjZv4lg2mNSoj9QqakExS7fr6/Uybn+qSO5e4E02
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 12:23:50.2446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e775739c-709e-4f59-3dba-08de79e8e450
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
X-Rspamd-Queue-Id: 00C491FFA7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263804-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

When operating in 10GBASE-KR mode with auto-negotiation disabled and RX
adaptation enabled, CRC errors can occur during the RX adaptation
process. This happens because the driver continues transmitting and
receiving packets while adaptation is in progress.

Fix this by stopping TX/RX immediately when the link goes down and RX
adaptation needs to be re-triggered, and only re-enabling TX/RX after
adaptation completes and the link is confirmed up. Introduce a flag to
track whether TX/RX was disabled for adaptation so it can be restored
correctly.

This prevents packets from being transmitted or received during the RX
adaptation window and avoids CRC errors from corrupted frames.

Fixes: 4f3b20bfbb75 ("amd-xgbe: add support for rx-adaptation")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 61 ++++++++++++++++++++-
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  4 ++
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 457d6049291f..880949051c3c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -2017,6 +2017,50 @@ static void xgbe_phy_rx_adaptation(struct xgbe_prv_data *pdata)
 	xgbe_rx_adaptation(pdata);
 }
 
+/*
+ * xgbe_phy_stop_data_path - Stop TX/RX to prevent packet corruption
+ * @pdata: driver private data
+ *
+ * This function stops the data path (TX and RX) to prevent packet
+ * corruption during critical PHY operations like RX adaptation.
+ * Must be called before initiating RX adaptation when link goes down.
+ */
+static void xgbe_phy_stop_data_path(struct xgbe_prv_data *pdata)
+{
+	if (pdata->rx_adapt_data_path_stopped)
+		return;
+
+	netif_dbg(pdata, link, pdata->netdev,
+		  "stopping data path for RX adaptation\n");
+
+	/* Stop TX/RX to prevent packet corruption during RX adaptation */
+	pdata->hw_if.disable_tx(pdata);
+	pdata->hw_if.disable_rx(pdata);
+
+	pdata->rx_adapt_data_path_stopped = true;
+}
+
+/*
+ * xgbe_phy_start_data_path - Re-enable TX/RX after RX adaptation
+ * @pdata: driver private data
+ *
+ * This function re-enables the data path (TX and RX) after RX adaptation
+ * has completed successfully. Only called when link is confirmed up.
+ */
+static void xgbe_phy_start_data_path(struct xgbe_prv_data *pdata)
+{
+	if (!pdata->rx_adapt_data_path_stopped)
+		return;
+
+	netif_dbg(pdata, link, pdata->netdev,
+		  "restarting data path after RX adaptation\n");
+
+	pdata->hw_if.enable_rx(pdata);
+	pdata->hw_if.enable_tx(pdata);
+
+	pdata->rx_adapt_data_path_stopped = false;
+}
+
 static void xgbe_phy_rx_reset(struct xgbe_prv_data *pdata)
 {
 	int reg;
@@ -2826,6 +2870,10 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
 	if (pdata->en_rx_adap) {
 		/* if the link is available and adaptation is done,
 		 * declare link up
+		 *
+		 * Note: When link is up and adaptation is done, we can
+		 * safely re-enable the data path if it was stopped
+		 * for adaptation.
 		 */
 		if ((reg & MDIO_STAT1_LSTATUS) && pdata->rx_adapt_done)
 			return 1;
@@ -2833,6 +2881,14 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
 		 * retrigger the adaptation logic. (if the mode is not set,
 		 * then issue mailbox command first)
 		 */
+
+		/* CRITICAL: Stop data path BEFORE triggering RX adaptation
+		 * to prevent CRC errors from packets corrupted during
+		 * the adaptation process. This is especially important
+		 * when AN is OFF in 10G KR mode.
+		 */
+		xgbe_phy_stop_data_path(pdata);
+
 		if (pdata->mode_set) {
 			xgbe_phy_rx_adaptation(pdata);
 		} else {
@@ -2840,8 +2896,11 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
 			xgbe_phy_set_mode(pdata, phy_data->cur_mode);
 		}
 
-		if (pdata->rx_adapt_done)
+		if (pdata->rx_adapt_done) {
+			/* Adaptation complete, safe to re-enable data path */
+			xgbe_phy_start_data_path(pdata);
 			return 1;
+		}
 	} else if (reg & MDIO_STAT1_LSTATUS)
 		return 1;
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 4333d269ee84..75c021b38a28 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1266,6 +1266,10 @@ struct xgbe_prv_data {
 	bool en_rx_adap;
 	int rx_adapt_retries;
 	bool rx_adapt_done;
+	/* Flag to track if data path (TX/RX) was stopped for RX adaptation.
+	 * This prevents packet corruption during the adaptation window.
+	 */
+	unsigned int rx_adapt_data_path_stopped;
 	bool mode_set;
 	bool sph;
 };
-- 
2.34.1


