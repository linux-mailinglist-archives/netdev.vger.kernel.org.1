Return-Path: <netdev+bounces-271117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEfdJoWowmkyggQAu9opvQ
	(envelope-from <netdev+bounces-271117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:06:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BC3317AE0
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79DCD3052D37
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97C4014A5;
	Tue, 24 Mar 2026 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UdLtMqYm"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18163FFAA0;
	Tue, 24 Mar 2026 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364061; cv=fail; b=OZA+1Xs27dCEnVnw6gtiHTqbK2KSwwIFEsKZ91sW4COI2rhuo536cCIJINOpkbqzldHmvRrRT8H5j9TXrsi1MjsWLO2AofIwE9sGmrSwZeXaCF9npO8oxua9Ary/uwEdMSRezpXrnyR7xwoUWZuNAk5YTvOyDJEfHHW+kVIR/JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364061; c=relaxed/simple;
	bh=Ey4lvG51ccME4BAdsKx9o1fWse39ILhpdDi2Fw6yYOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DObluGSH89tOv9b+UIfNBQ/i8iN/iStykLJl/7a5xjARb9M9yoGRr7hg3DuLrdLi4QEngQfL2ip1Mq/ps85vRUVVZky91gPlKxzfQWGrn6oieZSobTOEb6m1cwoFJREgoynuLrHeUdAXdXYopNsLRiOGsURcE76JJDbKsqET8mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UdLtMqYm; arc=fail smtp.client-ip=52.101.52.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SB7wcRgDhko2Y+rN96SOiIF5kvPX7taAgv7fMm50rbAaD9ATbkOt3teVQb3NnkkJR/Ej9QAnMNitjg3zCD9TAEp2mkAYU41yyZQQMsduSs21naZSyJ65LVqa6OpJpz9WHvNR8AIwbCuXG69xLPPe8HsB+OmK6OE0kbMpy4u/XBHn4lmSX5F0AKE820xV6SvhbsSpjzArhEwA6zGj1ZJvY15f3CptfybUDJT2jrh46wmbbaPATUVz0yiexs914jtThEnqYzCsDjpAOpSlb6vsCyq2KUi80zcv+VsCyszoyUoKntNbvV+p/0d0zz0Ol0v9f+Tcs88wKDxpufa5QYdYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OkNDbfqNYkWEd6na3FA+WiA8ea+lgrEfpBKAoleC1I=;
 b=uVrM4jzZeagg8HYha6uQAktT6ea7dg44pwvmWIYggRkX5EOcXnKvpj4/R5iGbci4rhw1ep8bjXlOUQkezgTY8YMuXMpjEj6izNhk9uWM60VE6rA/HWjGOtZz/nQnjRVnTqUnJpMu2d3PpozY8NewRuJPKrgmuY06IGvh4qPKbFPUUFUBsAO7p8fOTyuyEtbpV8bxYXkw7d+oOueCKM9byRMqLM9HXT/ne+qyyDX09vb/Pr+XZiIW9JsZOw1kzYxyMDyI+VeXSP5XQnTHPDgloajjYI2NgGHuXRMm0ZwHlMsNt/E8pzpc6RZ+PCkKkq3A72Tau6rMpFhZUSjlnefBCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OkNDbfqNYkWEd6na3FA+WiA8ea+lgrEfpBKAoleC1I=;
 b=UdLtMqYmt/dVnmZaVLFfBAh5IaFmSPjJuogRhEmTUVJEBXKedVBaI4JHIuyJKJkEhYkN7UFG8KU5JRkban5DaMXnbp1xrO8AVRMuvpVuTIPruuI6OqiXvLTO5HzuTKTXQoJ9hkaXZJLs9yLvnCachXffn3o+R64JQPeBFmp3wKA=
Received: from BYAPR21CA0029.namprd21.prod.outlook.com (2603:10b6:a03:114::39)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 14:54:14 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::82) by BYAPR21CA0029.outlook.office365.com
 (2603:10b6:a03:114::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.6 via Frontend Transport; Tue,
 24 Mar 2026 14:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 14:54:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 09:54:04 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 07:54:04 -0700
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 24 Mar 2026 09:54:01 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<sean.anderson@linux.dev>, <radhey.shyam.pandey@amd.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <harini.katakam@amd.com>
Subject: [PATCH net 2/2] net: xilinx: axienet: Fix BQL accounting for multi-BD TX packets
Date: Tue, 24 Mar 2026 20:23:52 +0530
Message-ID: <20260324145353.1899248-3-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20260324145353.1899248-1-suraj.gupta2@amd.com>
References: <20260324145353.1899248-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: b08a7bc2-ef22-4e25-3164-08de89b53760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	98KVodJY2tkZ+bp19le/ELiJqOr8S9afIe2g5gUY0TeoJo4Yo1lKy3eKDTZKFGYbDiG16G7VH0zLQ0YfVKe70CUwzusrGSQnjv61bjqviwM98PI4uU2GPiPhMn2vggdakWEB70LEqAX+8As25xCuyLA+cAGCxNMK+jm9VUau5CRIHQKv4Bq+4SxpL7kH7/41CF7oBUGqfpxngTOrd9EI3xZuAFwfUchnlDjuO+kR3/g2icMJwxSLSSQj6qk6tGn5vL2kuiwhFYvcrZzKRNPTEXNzP1xBntLFkEXygrcZLMefh/Bk/d7XgHq/9yjPGD9KLGSfFhpgIG/l8cS03gNxE4jMZM/BXNKwcHK3Fo1ukjMZiTIijugrOXYz0ONHvKeQTBLzcg6+DsE17rzxhLnYaOBHuMem67z/wYoqW9cfbRIxfbpWKqd8XDDgO7XZhzasgVfYP0KxFZVGsynUDlOWyUbPd9NCEzKMXa+l+PdlKluQRN9i0hX8TT48hbJtcdgAycy18bsv1lcyPzMac4Iny7sBjGXhEToc5d77NB4PZjAAA5KP+AAQ0MkLNlUMKbWrHyRILtFC4cKsEXPmd6gMxuaZ532ZGh5KE3PMq6EpKno3L/HKZrll6gbAtwa6v4nX2A+TtsnMKkFi5aWAFjwZ1SRBb4Q3yeZaVIm3clwlMSWm7miU28Uw5k08aMb43DAkRQf22/gZWBNxbCNNiwsG871FTGWESoQhIETDuvUC7SyiPxS33yYmtenqOkp4JOiJEyke7eSB8JSHHdGjogOrlw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bs0pD23hrhZOrEIOO+3PZvlsITu6r3GScg2t8MxjkRlZ0SOTep8LuheK1hwSKs52Vy0E6Y4kwRT2Q9h2II9hcrrsOSOXWGH3UhLljbr6+5a5yH6r3mOD6lObrFDdOW3pGzrLT414r5b1+Z+ST0j0CQjH+npDrdNHZ1hQOsTfwg/eg5HtuQEzX2GYCgcfCxFrdewPAZ9Th7dFmF/mf4mBIDjV6Na5HOQzfhRgSh9iXgEdPhy/tLAeocyt/vj3lwDVV8kzktC2oW55PuaRqrAbzgz8qLRyachN6+tEz7TP4P+ApKV8gIx67A99IqiH1Z6IYzT9Hdvo19CevyOwYsGDVyIxV2iQTEgrZ0MOIUA3u2vRypvyUofxOaYejl9Aqz+ekt8qNhi82nshXRvIagzj1FEcwVp66BKynCVZ5aaOWW1/0Q2jEsOZD+n1YkYR7EQN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:54:14.3193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b08a7bc2-ef22-4e25-3164-08de89b53760
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271117-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.gupta2@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A8BC3317AE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a TX packet spans multiple buffer descriptors (scatter-gather),
the per-BD byte count is accumulated into a local variable that resets
on each NAPI poll. If the BDs for a single packet complete across
different polls, the earlier bytes are lost and never credited to BQL.
This causes BQL to think bytes are permanently in-flight, eventually
stalling the TX queue.

Fix this by replacing the local accumulator with a persistent counter
(tx_compl_bytes) that survives across polls and is reset only after
updating BQL and stats.

Fixes: c900e49d58eb ("net: xilinx: axienet: Implement BQL")
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  3 +++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 20 +++++++++----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 602389843342..a4444c939451 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -509,6 +509,8 @@ struct skbuf_dma_descriptor {
  *		complete. Only updated at runtime by TX NAPI poll.
  * @tx_bd_tail:	Stores the index of the next Tx buffer descriptor in the ring
  *              to be populated.
+ * @tx_compl_bytes: Accumulates TX completion length until a full packet is
+ *              reported to the stack.
  * @tx_packets: TX packet count for statistics
  * @tx_bytes:	TX byte count for statistics
  * @tx_stat_sync: Synchronization object for TX stats
@@ -592,6 +594,7 @@ struct axienet_local {
 	u32 tx_bd_num;
 	u32 tx_bd_ci;
 	u32 tx_bd_tail;
+	u32 tx_compl_bytes;
 	u64_stats_t tx_packets;
 	u64_stats_t tx_bytes;
 	struct u64_stats_sync tx_stat_sync;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index b06e4c37ff61..95bf61986cb7 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -692,6 +692,8 @@ static void axienet_dma_stop(struct axienet_local *lp)
 	axienet_lock_mii(lp);
 	__axienet_device_reset(lp);
 	axienet_unlock_mii(lp);
+
+	lp->tx_compl_bytes = 0;
 }
 
 /**
@@ -770,8 +772,6 @@ static int axienet_device_reset(struct net_device *ndev)
  * @first_bd:	Index of first descriptor to clean up
  * @nr_bds:	Max number of descriptors to clean up
  * @force:	Whether to clean descriptors even if not complete
- * @sizep:	Pointer to a u32 filled with the total sum of all bytes
- *		in all cleaned-up descriptors. Ignored if NULL.
  * @budget:	NAPI budget (use 0 when not called from NAPI poll)
  *
  * Would either be called after a successful transmit operation, or after
@@ -780,7 +780,7 @@ static int axienet_device_reset(struct net_device *ndev)
  * Return: The number of packets handled.
  */
 static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
-				 int nr_bds, bool force, u32 *sizep, int budget)
+				 int nr_bds, bool force, int budget)
 {
 	struct axidma_bd *cur_p;
 	unsigned int status;
@@ -819,8 +819,8 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 		cur_p->cntrl = 0;
 		cur_p->status = 0;
 
-		if (sizep)
-			*sizep += status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
+		if (!force)
+			lp->tx_compl_bytes += status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
 	}
 
 	if (!force) {
@@ -999,18 +999,18 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
 {
 	struct axienet_local *lp = container_of(napi, struct axienet_local, napi_tx);
 	struct net_device *ndev = lp->ndev;
-	u32 size = 0;
 	int packets;
 
 	packets = axienet_free_tx_chain(lp, lp->tx_bd_ci, lp->tx_bd_num, false,
-					&size, budget);
+					budget);
 
 	if (packets) {
-		netdev_completed_queue(ndev, packets, size);
+		netdev_completed_queue(ndev, packets, lp->tx_compl_bytes);
 		u64_stats_update_begin(&lp->tx_stat_sync);
 		u64_stats_add(&lp->tx_packets, packets);
-		u64_stats_add(&lp->tx_bytes, size);
+		u64_stats_add(&lp->tx_bytes, lp->tx_compl_bytes);
 		u64_stats_update_end(&lp->tx_stat_sync);
+		lp->tx_compl_bytes = 0;
 
 		/* Matches barrier in axienet_start_xmit */
 		smp_mb();
@@ -1115,7 +1115,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 				netdev_err(ndev, "TX DMA mapping error\n");
 			ndev->stats.tx_dropped++;
 			axienet_free_tx_chain(lp, orig_tail_ptr, ii + 1,
-					      true, NULL, 0);
+					      true, 0);
 			dev_kfree_skb_any(skb);
 			return NETDEV_TX_OK;
 		}
-- 
2.49.1


