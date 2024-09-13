Return-Path: <netdev+bounces-128132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5809782FA
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 16:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1745B25888
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 14:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C402629F;
	Fri, 13 Sep 2024 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JSwCJzus"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982B23CF65
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239137; cv=none; b=hHYqdamVwGRD2dQ45jHzeoS6KNgWesByC4UYunKdhewpJQgKfvlCqLW9AuYblO5UxH7qBtNE6xc/NMMKxzB0PkGgmAj0man6FG05hUvAoMbOa+a8YKsrBpeqGINAsTXVsf90ogsfmVcBi185UzINLeKnRAkqYg2k8wdArZnWs0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239137; c=relaxed/simple;
	bh=QYJAT449u0J4RfzwfdVOFXD6V9MVsaV3hOZoa9qmVro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l/n0cnVVMjJeLU1LXWAyW+ruRwAFDx/4RZJk0kEtDT8UcklZ/txUZNYE7zvmMgWxy7LPSz1UC0FIddHeFHgVS/YV9TeBKkVojXzpjGq9IWqLc42KwYGZbyIiGbMW6pEn1VcBNWnp36VTiqxKZC9V7po4QfuMQ+5YoF9AcqxaWKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JSwCJzus; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726239131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TYpo3SEOUQJxC0I/V/RNMCTVReqQRSdjKs/mEViJgkE=;
	b=JSwCJzusti1A/7MnBoW0SdpgmLYSWNNSOt81uWPH0o4VXTiWIS3e8aJ9BlMbaR6X5J+E5r
	Y1sEUpfQbkgGiWIalCvehP7IyJxpoKvMFNZGtSkCUZFC8L81Y7S8XbJpT3bn22y36LCQuz
	UYIABA5Q3t6THWWjq1+v/2V84p1DyCE=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Michal Simek <michal.simek@amd.com>,
	Suraj <Suraj.Gupta2@amd.com>,
	Harini <harini.katakam@amd.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net v3] net: xilinx: axienet: Fix packet counting
Date: Fri, 13 Sep 2024 10:51:56 -0400
Message-Id: <20240913145156.2283067-1-sean.anderson@linux.dev>
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

Budget does not affect the number of Tx completions we can process for
NAPI, so we use the ring size as the limit instead of budget. As we no
longer return the number of descriptors processed to axienet_tx_poll, we
now update tx_bd_ci in axienet_free_tx_chain.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v3:
- Don't limit transmit packets processed to budget, since it doesn't
  apply to Tx completions. This allows a few more simplifications.
- Add a note to the commit message regarding the movement of the
  tx_bd_ci update

Changes in v2:
- Only call napi_consume_skb with non-zero budget when force is false

 .../net/ethernet/xilinx/xilinx_axienet_main.c | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 9eb300fc3590..1beb439deaf3 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -674,15 +674,15 @@ static int axienet_device_reset(struct net_device *ndev)
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
 
 	for (i = 0; i < nr_bds; i++) {
 		cur_p = &lp->tx_bd_v[(first_bd + i) % lp->tx_bd_num];
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
-- 
2.35.1.1320.gc452695387.dirty


