Return-Path: <netdev+bounces-124651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A11696A5F6
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5760028217D
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DE618FDC3;
	Tue,  3 Sep 2024 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XeZZAIEs"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A313218DF90
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386188; cv=none; b=BPxAIL2/Udi/+LiGzsBRbZkgyyg8Sm97A/DDXzCh3utPwngmjfQSjC426fMfsbSYQh1fmz1/SAoiWDEJZhg/zr9UJj31tlTBzPUelWU1/ibegCx6kVP/YzHfXzX1YQ85rFES/52H967Zczh/0iniJOkTwD5kITLXGhTRUzHS32U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386188; c=relaxed/simple;
	bh=3nIgv+VkbQkodNGoc1UpID5+UlAl7V5gUUdSzJC/B+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TVJmX4wdR2wt+dfCrN4KBIyok2fJ6n8h55Oifbl+ChDsmioozN5z1+ibsbrRaVAc3KklHPVqR0+MqMd9cY6LDmuAGWesxjojhxtJkVFvC+/KPUKH2F8JsJq8PQCP34N4Ir7VwjDzyaa66PvWXvww4zKFWVinn8a0Yw//kKexNC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XeZZAIEs; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725386184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uMaKcjVy5+XrZWFlhMRiA/a2YFL8yyNpsMTkKScyJVE=;
	b=XeZZAIEscINdjFk6Ln61kUER3PliM9WFipduzrvHT+6IvJ5JvFnjk4as3XGdx2a9KwAuC1
	lU3o06kFbEBesBHGxTLKCvE1/54/5rfMHoZigrT0efzY1MPolSwuUltwLYKAW7ffN26U3W
	zCzZOT5Uinkeh8876xowjyaenoDBLgw=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net] net: xilinx: axienet: Fix packet counting
Date: Tue,  3 Sep 2024 13:56:19 -0400
Message-Id: <20240903175619.4133633-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

axienet_free_tx_chain returns the number of DMA descriptors it's
handled. However, axienet_tx_poll treats the return as the number of
packets. When scatter-gather SKBs are enabled, a single packet may use
multiple DMA descriptors, which causes incorrect packet counts. Fix this
by explicitly keepting track of the number of packets processed as
separate from the DMA descriptors.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 .../net/ethernet/xilinx/xilinx_axienet_main.c | 29 +++++++++++--------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 9aeb7b9f3ae4..86da628f66fd 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -670,21 +670,21 @@ static int axienet_device_reset(struct net_device *ndev)
  * @force:	Whether to clean descriptors even if not complete
  * @sizep:	Pointer to a u32 filled with the total sum of all bytes
  *		in all cleaned-up descriptors. Ignored if NULL.
- * @budget:	NAPI budget (use 0 when not called from NAPI poll)
+ * @budget:	NAPI budget (use INT_MAX when not called from NAPI poll)
  *
  * Would either be called after a successful transmit operation, or after
  * there was an error when setting up the chain.
- * Returns the number of descriptors handled.
+ * Returns the number of packets handled.
  */
 static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 				 int nr_bds, bool force, u32 *sizep, int budget)
 {
 	struct axidma_bd *cur_p;
 	unsigned int status;
+	int i, packets = 0;
 	dma_addr_t phys;
-	int i;
 
-	for (i = 0; i < nr_bds; i++) {
+	for (i = 0; i < nr_bds && packets < budget; i++) {
 		cur_p = &lp->tx_bd_v[(first_bd + i) % lp->tx_bd_num];
 		status = cur_p->status;
 
@@ -701,8 +701,10 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 				 (cur_p->cntrl & XAXIDMA_BD_CTRL_LENGTH_MASK),
 				 DMA_TO_DEVICE);
 
-		if (cur_p->skb && (status & XAXIDMA_BD_STS_COMPLETE_MASK))
+		if (cur_p->skb && (status & XAXIDMA_BD_STS_COMPLETE_MASK)) {
 			napi_consume_skb(cur_p->skb, budget);
+			packets++;
+		}
 
 		cur_p->app0 = 0;
 		cur_p->app1 = 0;
@@ -718,7 +720,13 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 			*sizep += status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
 	}
 
-	return i;
+	if (!force) {
+		lp->tx_bd_ci += i;
+		if (lp->tx_bd_ci >= lp->tx_bd_num)
+			lp->tx_bd_ci %= lp->tx_bd_num;
+	}
+
+	return packets;
 }
 
 /**
@@ -891,13 +899,10 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
 	u32 size = 0;
 	int packets;
 
-	packets = axienet_free_tx_chain(lp, lp->tx_bd_ci, budget, false, &size, budget);
+	packets = axienet_free_tx_chain(lp, lp->tx_bd_ci, lp->tx_bd_num, false,
+					&size, budget);
 
 	if (packets) {
-		lp->tx_bd_ci += packets;
-		if (lp->tx_bd_ci >= lp->tx_bd_num)
-			lp->tx_bd_ci %= lp->tx_bd_num;
-
 		u64_stats_update_begin(&lp->tx_stat_sync);
 		u64_stats_add(&lp->tx_packets, packets);
 		u64_stats_add(&lp->tx_bytes, size);
@@ -1003,7 +1008,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 				netdev_err(ndev, "TX DMA mapping error\n");
 			ndev->stats.tx_dropped++;
 			axienet_free_tx_chain(lp, orig_tail_ptr, ii + 1,
-					      true, NULL, 0);
+					      true, NULL, INT_MAX);
 			return NETDEV_TX_OK;
 		}
 		desc_set_phys_addr(lp, phys, cur_p);
-- 
2.35.1.1320.gc452695387.dirty


