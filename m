Return-Path: <netdev+bounces-166561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 649C1A3675A
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFEC172D50
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33E11DE4E1;
	Fri, 14 Feb 2025 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RwrD6Osz"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C84C1DACA7
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567593; cv=none; b=JDubRI84nKXThjNVtwLTp7DKZc65cgxPKHjnmyOCkiLeh5YVLJy6O/8lIGEtfI/hCRgnwYRS1k/GcyxLHYHsbWibSVwonqS040DmKvAZllESknBNa03aIjZG/+fBz04nFsPYk4agmmrWazI6mmu3TLo9dr2FjVCVUeqEDpVoT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567593; c=relaxed/simple;
	bh=z9Xzujvvg6zlRRYiyDR0lzDHTRg71nCDdVcnYXJD3ok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fQjBU0sx+WvDY4zW9VBCWwAiK//CWeIbE/ftInBmeHEMwCgbw5z17f1agYuqjGAeaN4TndbTzW08cMq8VA4xUdGDVF0rV3ElLyt4iZ78klCigAMHHyoY6Vsc/rU3pmaztowl65udReGJm+QSMGkhWN/T8sGNmIHFugVJCE00PCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RwrD6Osz; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739567588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p2wzRXm7QAsa6gYMN0V+PftNHpoKOXWltWFcIe8BjkY=;
	b=RwrD6OszqtC7ow6NcqQULCNirHcDdR6iHYzN5e7xfUOhhVU0+nwGBWn2N1eYq9nPU8a9mz
	lk8LCY5KTscMXErzxhk6Yd3WPyWMRlgTcwHTr5rfo5XA7mUdGzHHL1aESFG4GEOtDWqTFd
	pYf6xelsh2bxQrlGWsnsot2gmVVYOZ0=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next] net: xilinx: axienet: Implement BQL
Date: Fri, 14 Feb 2025 16:12:52 -0500
Message-Id: <20250214211252.2615573-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Implement byte queue limits to allow queueing disciplines to account for
packets enqueued in the ring buffers but not yet transmitted.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 0673b2694e4c..7406e00de0fb 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1002,6 +1002,7 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
 					&size, budget);
 
 	if (packets) {
+		netdev_completed_queue(ndev, packets, size);
 		u64_stats_update_begin(&lp->tx_stat_sync);
 		u64_stats_add(&lp->tx_packets, packets);
 		u64_stats_add(&lp->tx_bytes, size);
@@ -1125,6 +1126,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	if (++new_tail_ptr >= lp->tx_bd_num)
 		new_tail_ptr = 0;
 	WRITE_ONCE(lp->tx_bd_tail, new_tail_ptr);
+	netdev_sent_queue(ndev, skb->len);
 
 	/* Start the transfer */
 	axienet_dma_out_addr(lp, XAXIDMA_TX_TDESC_OFFSET, tail_p);
@@ -1751,6 +1753,7 @@ static int axienet_stop(struct net_device *ndev)
 		dma_release_channel(lp->tx_chan);
 	}
 
+	netdev_reset_queue(ndev);
 	axienet_iow(lp, XAE_IE_OFFSET, 0);
 
 	if (lp->eth_irq > 0)
@@ -2676,6 +2679,7 @@ static void axienet_dma_err_handler(struct work_struct *work)
 			   ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
 
 	axienet_dma_stop(lp);
+	netdev_reset_queue(ndev);
 
 	for (i = 0; i < lp->tx_bd_num; i++) {
 		cur_p = &lp->tx_bd_v[i];
-- 
2.35.1.1320.gc452695387.dirty


