Return-Path: <netdev+bounces-124650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B03296A5E5
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32ED31C21166
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561A418DF90;
	Tue,  3 Sep 2024 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N08CB+jL"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D90718DF92
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725385925; cv=none; b=Rh1pk6WvjRfYXTw3K+6IS0duHTkjqPJJnN2NmsRPnHMNymFXL4Ob7ZTqnC+EEIn2H72jmMNltZC1y+eKjj+yNWmlEAdikQz77Gj2fcGKYKHuseVHa1CbJ7p7oxM/9+GaFo8+n7QsHI6RKAdo36Rc0P5ZcQsZ3T/04x0Hzzb5xyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725385925; c=relaxed/simple;
	bh=UeLXJklQ8pQZXSGosRpzdX4dNQGU5PtQW80YrI2BlRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qM4EG4KDI0dv1B4F8V8dRwC2bIegM4smqY6djIBxPfR0qIFUjyVbOuDw5+BbADs5U/o5or4nZ0HhogNlHnZTcQ2DazLI+qENFRK9h5GMydoR7IehHNp1pBzLQ0PFphxHbg0G81ZKlghSPW+vTTSqE2rL+Jf48eBg1BpA3J5GwnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N08CB+jL; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725385920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=arCXP/c/bQi1qoEO/wOkAyALABugDqpI7zGDaG9Y0Js=;
	b=N08CB+jLABGe2ZJvDO9//a6PyfXSUSRsFOB1qBArK9UXncQoBCoiJNm50gkPeG5RYtUeeh
	JMKGAzeuhUcppwpnPB6LdTdV/tf4qxow3RnYdnZLMFKH32jVEfYs2mio847enRKKVmoKSk
	3DeCiEv0kwC8jnM++92mKyTjcJvi72Y=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andy Chiu <andy.chiu@sifive.com>,
	Ariane Keller <ariane.keller@tik.ee.ethz.ch>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net] net: xilinx: axienet: Fix race in axienet_stop
Date: Tue,  3 Sep 2024 13:51:41 -0400
Message-Id: <20240903175141.4132898-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

axienet_dma_err_handler can race with axienet_stop in the following
manner:

CPU 1                       CPU 2
======================      ==================
axienet_stop()
    napi_disable()
    axienet_dma_stop()
                            axienet_dma_err_handler()
                                napi_disable()
                                axienet_dma_stop()
                                axienet_dma_start()
                                napi_enable()
    cancel_work_sync()
    free_irq()

Fix this by setting a flag in axienet_stop telling
axienet_dma_err_handler not to bother doing anything. I chose not to use
disable_work_sync to allow for easier backporting.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
---

 drivers/net/ethernet/xilinx/xilinx_axienet.h      | 3 +++
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 09c9f9787180..1223fcc1a8da 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -436,6 +436,8 @@ struct skbuf_dma_descriptor {
  * @tx_bytes:	TX byte count for statistics
  * @tx_stat_sync: Synchronization object for TX stats
  * @dma_err_task: Work structure to process Axi DMA errors
+ * @stopping:   Set when @dma_err_task shouldn't do anything because we are
+ *              about to stop the device.
  * @tx_irq:	Axidma TX IRQ number
  * @rx_irq:	Axidma RX IRQ number
  * @eth_irq:	Ethernet core IRQ number
@@ -507,6 +509,7 @@ struct axienet_local {
 	struct u64_stats_sync tx_stat_sync;
 
 	struct work_struct dma_err_task;
+	bool stopping;
 
 	int tx_irq;
 	int rx_irq;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 9aeb7b9f3ae4..9eb300fc3590 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1460,6 +1460,7 @@ static int axienet_init_legacy_dma(struct net_device *ndev)
 	struct axienet_local *lp = netdev_priv(ndev);
 
 	/* Enable worker thread for Axi DMA error handling */
+	lp->stopping = false;
 	INIT_WORK(&lp->dma_err_task, axienet_dma_err_handler);
 
 	napi_enable(&lp->napi_rx);
@@ -1580,6 +1581,9 @@ static int axienet_stop(struct net_device *ndev)
 	dev_dbg(&ndev->dev, "axienet_close()\n");
 
 	if (!lp->use_dmaengine) {
+		WRITE_ONCE(lp->stopping, true);
+		flush_work(&lp->dma_err_task);
+
 		napi_disable(&lp->napi_tx);
 		napi_disable(&lp->napi_rx);
 	}
@@ -2154,6 +2158,10 @@ static void axienet_dma_err_handler(struct work_struct *work)
 						dma_err_task);
 	struct net_device *ndev = lp->ndev;
 
+	/* Don't bother if we are going to stop anyway */
+	if (READ_ONCE(lp->stopping))
+		return;
+
 	napi_disable(&lp->napi_tx);
 	napi_disable(&lp->napi_rx);
 
-- 
2.35.1.1320.gc452695387.dirty


