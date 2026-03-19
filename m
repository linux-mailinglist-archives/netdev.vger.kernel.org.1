Return-Path: <netdev+bounces-269543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKfwNVMnvGkxtgIAu9opvQ
	(envelope-from <netdev+bounces-269543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:41:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D35E02CEFB7
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19973306ED81
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5804D3EE1E3;
	Thu, 19 Mar 2026 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jnfntKyd"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010013.outbound.protection.outlook.com [40.93.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA753EAC83;
	Thu, 19 Mar 2026 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938021; cv=fail; b=BwcegoYVsjfsalSSNudAUiwAuxUcSKS0qRoxXn+JX6tloiIzYw9uO6gZtzlvaBAMgA9v7Pg2oKZPehPOMlR3sYy/Ntk5aNoXYC3GR9a1bUUxOYCUpgysLdlObv+jgZ3CYrQ//oilK05oJ8iWPCop7mWA6pGBHDyCX+r9vH3Xn74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938021; c=relaxed/simple;
	bh=5t4NKf0j+SXzgf5SCIsB//5lQpHU0Kzix4I4EDcI6hE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVOOJcQZ7MYoguZk+3jH3ytSOcHXuHETwKl+dZDXZFK0WfjhOv2wqaIuwPFAhoXkpPbYKf+5Lrv/CDwuoO6lADN0tn/P5POkOlfuzFGxSF2NZNV30ccv4SsTjq6rF5g6kGGnpZqWJimMKx2aMUcJtOVWpZS3M08+SpfcRxWdOes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jnfntKyd; arc=fail smtp.client-ip=40.93.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwVDhP3u+SnVUJ4rWd6XigYHvO5XRrCDWvXMB7OhhitJGA32GKQI7/PxR4nButkyyH2S4J7Uv0EAK28vuce1NvlPY0O6vUjquvo7CAnk1lUI/EHDXqJxPsrcccpUNqiCPNzdth45AMOcnMaQlPMLXq9T7pqnTs9eM4D2xLJPbDAVNAzJTOe8xKsC2tsIPGiC+DgoFNyJtl49PzV1UaB9P9PvcYYM/EdLK/XOg0ajPc8ZAGlXhU4XUHGIyuh5x9C7vz7gLTKKOxysSHvYrf2HyPNHeBN7ErkLn/gyyDRGpF7lZJUyCwrVuGIhTbabEgPOB/n5cAhqA+15Mqu/+tjoCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRyarCsVsCZSla8kHKhCHaGZGv7x8BLtoxROpxUPfCE=;
 b=JzXE+7F3mkrL0pZfDrVJMfRXv5DxKcDoZ8k6tumvdkcpk7hb/Ra0sQvq4psQxQOq/m6n87is/CAsy6kwHdEx40XGFn/L8np2zAeUDGMC0dbue77n37On/W0ROJwUHruiYFuD6lSaiDrZFkYWO26NRIT+M6UZthR9Wc0uCG22lkBjKtEL2AJ8JyuHb11AHQQYWhK07vbESgj6z4QZECorGRgWga4e6jQ4QALrqZOjaBFTiCTtA48u9l6qOvr2c1dGUsApsLSAEf3LGPV0t7XBY7AsDCLGwowDsaJ3VUn5ZX0tIQ2ep5eKRV0zfl8qDIesJIN/fXE1Ki00fhGYNMA0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRyarCsVsCZSla8kHKhCHaGZGv7x8BLtoxROpxUPfCE=;
 b=jnfntKydHAmzMh4qUxL2wHoJTHvcOUt39DEYC+bUEhjTDSP6ACnixfuBI6ScgnefHNZSJwpfmMxAINBYXrtUN1GLJtgXjwXCCUx+V93bB6QNaYuzRUAX+9r6k6bOLqJQH+GBCFCKDgX/dfmqHxF1MmKPy0NAreb/dL3FfH+0m4w=
Received: from CH0PR03CA0062.namprd03.prod.outlook.com (2603:10b6:610:cc::7)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 16:33:29 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::e4) by CH0PR03CA0062.outlook.office365.com
 (2603:10b6:610:cc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 16:33:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 16:33:28 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 11:33:25 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>
Subject: [PATCH v3 net-next 2/3] amd-xgbe: optimize TX shutdown on link-down
Date: Thu, 19 Mar 2026 22:02:50 +0530
Message-ID: <20260319163251.1808611-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319163251.1808611-1-Raju.Rangoju@amd.com>
References: <20260319163251.1808611-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 251c5999-3586-4cdf-659a-08de85d54021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xW8ERcjvZH5Dx4KiVSECA/MnFg+SLntmhr+vdKkjDo+Msw7drrjNzcpncUgKQshg9QKSxVe5vlvNIjwZ7TAwJ2mR6h57Y2Q8oZZWJ0fAWaaqnxO+IWbMaeT859Itjou+ViOjYbRNmpN6lKO0tipVRozdAVFXHaZ0YcRPOwfGQvNewvWMrwpGONwA3DXcqRRuCFfdqHcrlDLz3gqimNJqZJaMmjjtPwKHXTFTnQraihAAZ93reCcKjCv1hX3uRqKNw+QbWBJ6VxwF9BgKFPId2wUBK+DwpRDklW65YEN7Rg8KF3DUolmRewA0nBbldXfUjvzaw5QXgsSmXlLXNNKjB9QOslo0vcQqOnaTweyzScrZBZMhOooXo/cmIR2rHOJZKJBmjHTgb3cyhRQWyBGU63+1mJOG1f3D3z7oj4vjc/7uFoWoIepmWRYv2rjy/scIRx0DLgdcU3J7NDQwtDZkx3VlQpYmwTGdJ8ecoRm7yl5iD/RAOd/MKal5FofQjJTm5P3uxlbPzKqSRze9mLJWld1FgBGm4wExNYp7+SCk35X7vzUu1M1t10zjuZ12F4xOOYPQN8TGEELjJ+VbyMPFRhXAHt9+0bakKWzyxZDhOluCifX3QR552iTYpCz3NBf9ZdMPGvS17UZ3KYueuCFJn7ZNIxDyfxJsHpXMiELcir+shpVkSQzpRG2/agc//w8fJiVlQHmhL8veCTUv/77iHzZjyoZ4zW+GF4JFOjMD3dsOfap4lDGL357SKWaHVVgHxhCffTkf9HxKIXgUQdSd4Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ABJ1OEPma6VuLwQlXyqvtXfaMx0Clb1awUHtOUWz3fYsETaU6iXL4JcJWezgt8REkar2MUHHu8k9VhGymNeFN237MDO0b+n0zmudmwQ9gHwqowMoqvNKpBXL0ppnPR2OaYRBNzoV5TtBFrHfTDLBXJPh7ts1hWWwWkX2xdTt5H3FpqmkzZQ2O7asVDf9yxmDiPfbFyg5eIj0TSiwG72hSqAqVKnytLU1byUT1L/8spp+TD2ezeDHqKczgwVXpUK7LlTSo7PSgWk4NzHDyEjizA0H81TyHF3JJA24MmWeiXkxqPRCnjQ0PSqsBGNM2lgt1FAkrc6UwsujKmAKt+BxfG+VIipEHXrsevie4Z2ZuuRcWDKDzThjBF3nVQOaVexLvUmNzxLjAv+l60+R6lmF5V0yyOUoqaLzKl9EMTalnuC3mCaaOuxBaSAoP7x/1r3J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:33:28.2883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 251c5999-3586-4cdf-659a-08de85d54021
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269543-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.972];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D35E02CEFB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Optimize the TX shutdown sequence when link goes down by skipping
futile hardware wait operations and immediately stopping TX queues.

Current behavior creates delays and resource issues during link-down:

1. xgbe_txq_prepare_tx_stop() waits up to XGBE_DMA_STOP_TIMEOUT for
   TX queues to drain, but when link is down, hardware will never
   complete the pending descriptors. This causes unnecessary delays
   during interface shutdown.

2. TX queues remain active after link-down, allowing the network stack
   to continue queuing packets that cannot be transmitted. This leads
   to resource buildup and complicates recovery.

This patch adds two optimizations:

Optimization 1: Skip TX queue drain when link is down
  In xgbe_txq_prepare_tx_stop(), detect link-down state and return
  immediately instead of waiting for hardware. Abandoned descriptors
  will be cleaned up by the force-cleanup mechanism (next patch).

Optimization 2: Immediate TX queue stop on link-down
  In xgbe_phy_adjust_link(), call netif_tx_stop_all_queues() as soon
  as link-down is detected. Also wake TX queues on link-up to resume
  transmission.

Benefits:
  - Faster interface shutdown (no pointless timeout waits)
  - Prevents packet queue buildup in network stack
  - Cleaner state management during link transitions
  - Enables orderly descriptor cleanup by NAPI poll

Note: We do not call netdev_tx_reset_queue() on link-down because
NAPI poll may still be running, which would trigger BQL assertions.
BQL state is cleaned up naturally during descriptor reclamation.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c  |  9 +++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index f1357619097e..b7bf74c6bb47 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -3186,7 +3186,16 @@ static void xgbe_txq_prepare_tx_stop(struct xgbe_prv_data *pdata,
 	/* The Tx engine cannot be stopped if it is actively processing
 	 * packets. Wait for the Tx queue to empty the Tx fifo.  Don't
 	 * wait forever though...
+	 *
+	 * Optimization: Skip the wait when link is down. Hardware won't
+	 * complete TX processing, so waiting serves no purpose and only
+	 * delays interface shutdown. Descriptors will be reclaimed via
+	 * the force-cleanup path in tx_poll.
 	 */
+
+	if (!pdata->phy.link)
+		return;
+
 	tx_timeout = jiffies + (XGBE_DMA_STOP_TIMEOUT * HZ);
 	while (time_before(jiffies, tx_timeout)) {
 		tx_status = XGMAC_MTL_IOREAD(pdata, queue, MTL_Q_TQDR);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 7675bb98f029..fa0df6181207 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1047,11 +1047,29 @@ static void xgbe_phy_adjust_link(struct xgbe_prv_data *pdata)
 		if (pdata->phy_link != pdata->phy.link) {
 			new_state = 1;
 			pdata->phy_link = pdata->phy.link;
+
+			/* Link is coming up - wake TX queues */
+			netif_tx_wake_all_queues(pdata->netdev);
 		}
 	} else if (pdata->phy_link) {
 		new_state = 1;
 		pdata->phy_link = 0;
 		pdata->phy_speed = SPEED_UNKNOWN;
+
+		/* Proactive TX queue management on link-down.
+		 *
+		 * Immediately stop TX queues to enable clean link-down
+		 * handling:
+		 * - Prevents queueing packets that can't be transmitted
+		 * - Allows orderly descriptor cleanup by NAPI poll
+		 * - Enables rapid failover in link aggregation configurations
+		 *
+		 * Note: We do NOT call netdev_tx_reset_queue() here because
+		 * NAPI poll may still be running and would trigger BQL
+		 * assertion. BQL state is cleaned up naturally during
+		 * descriptor reclamation.
+		 */
+		netif_tx_stop_all_queues(pdata->netdev);
 	}
 
 	if (new_state && netif_msg_link(pdata))
-- 
2.34.1


