Return-Path: <netdev+bounces-153560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 933C49F8A4F
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDEA21885C4C
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1268E13AA2D;
	Fri, 20 Dec 2024 02:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aX0ayKpF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CFD13635B
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 02:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734663172; cv=none; b=aVXDw4QcaY4HWSnNtCd9GJRfok2/b1arHosZhPQLmAHZkIWekjMaPc32SBOJ7aZEoVbmINXmHRKFtdI0GsRkyJjplaxHsCP9l8t04KKCPGz7uPpjt0uGRarO6ue8WlVI/7pZ5qk5YgcYAnsFE39/Htlbj+mHI73tRS3oQ74EfNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734663172; c=relaxed/simple;
	bh=+msa4EE83QXFb8BhaMHN9jJ2vIDyWNWOYGYMA9c7+18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9SF+7I6LERngN8c+jsbebXnZrNL1HiNzO7AX/F1cb1hYsSyHWvUue20w4UmOR2dfy+eDWMWvGj3eb1PcVcSpyX7rJcMZVw/TvCKDP2TrZ7uqhpUSHWHip61cv9nMQ/hXGMglJ0as98hHSM2/PVV16reZnEo5YilOS10JitQB+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aX0ayKpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB2CC4CED7;
	Fri, 20 Dec 2024 02:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734663171;
	bh=+msa4EE83QXFb8BhaMHN9jJ2vIDyWNWOYGYMA9c7+18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aX0ayKpFr4jbvUsACSbSmcPnD7tV9OWr5jLjV+ljvwljNnhwlimYds3tk/MLWVQBc
	 evzw4owEJXXGvuA2iyUXr/cKffWrV4nG13+zkvEF3Vg5bKbrrsikXBewCr9lmqUNv5
	 vAWqljaXk/vQwfAmiTfhACD6jZh4K8vpHy46qCGFn5VaC/B2R+3Sv3iK6SWk82Uatz
	 4/9Ri13Ftw5scYH1rXgzflqH9AMh4TGOtiX4cR5CwoPcVUMXgoCGED4XknHy1cz6jd
	 Ik0pNoXkccD2v4hiT6GlRvL/tlzWwYbiJFcDSgFgv5vqKzopCBz8P3158rqcWwQEZQ
	 9Ngl5UMC26kkQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 10/10] eth: fbnic: support ring channel set while up
Date: Thu, 19 Dec 2024 18:52:41 -0800
Message-ID: <20241220025241.1522781-11-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220025241.1522781-1-kuba@kernel.org>
References: <20241220025241.1522781-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the channel count changes. Copy the netdev priv,
allocate new channels using it. Stop, swap, start.
Then free the copy of the priv along with the channels it
holds, which are now the channels that used to be on the
real priv.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   1 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 121 +++++++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |  11 ++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  |   8 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   5 +
 7 files changed, 143 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index ed527209b30c..14751f16e125 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -162,6 +162,7 @@ int fbnic_napi_request_irq(struct fbnic_dev *fbd,
 			   struct fbnic_napi_vector *nv);
 void fbnic_napi_free_irq(struct fbnic_dev *fbd,
 			 struct fbnic_napi_vector *nv);
+void fbnic_synchronize_irq(struct fbnic_dev *fbd, int nr);
 int fbnic_request_irq(struct fbnic_dev *dev, int nr, irq_handler_t handler,
 		      unsigned long flags, const char *name, void *data);
 void fbnic_free_irq(struct fbnic_dev *dev, int nr, void *data);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index d2fe97ae6a71..20cd9f5f89e2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -65,6 +65,76 @@ static void fbnic_get_regs(struct net_device *netdev,
 	fbnic_csr_get_regs(fbn->fbd, data, &regs->version);
 }
 
+static struct fbnic_net *fbnic_clone_create(struct fbnic_net *orig)
+{
+	struct fbnic_net *clone;
+
+	clone = kmemdup(orig, sizeof(*orig), GFP_KERNEL);
+	if (!clone)
+		return NULL;
+
+	memset(clone->tx, 0, sizeof(clone->tx));
+	memset(clone->rx, 0, sizeof(clone->rx));
+	memset(clone->napi, 0, sizeof(clone->napi));
+	return clone;
+}
+
+static void fbnic_clone_swap_cfg(struct fbnic_net *orig,
+				 struct fbnic_net *clone)
+{
+	swap(clone->rcq_size, orig->rcq_size);
+	swap(clone->hpq_size, orig->hpq_size);
+	swap(clone->ppq_size, orig->ppq_size);
+	swap(clone->txq_size, orig->txq_size);
+	swap(clone->num_rx_queues, orig->num_rx_queues);
+	swap(clone->num_tx_queues, orig->num_tx_queues);
+	swap(clone->num_napi, orig->num_napi);
+}
+
+static void fbnic_aggregate_vector_counters(struct fbnic_net *fbn,
+					    struct fbnic_napi_vector *nv)
+{
+	int i, j;
+
+	for (i = 0; i < nv->txt_count; i++) {
+		fbnic_aggregate_ring_tx_counters(fbn, &nv->qt[i].sub0);
+		fbnic_aggregate_ring_tx_counters(fbn, &nv->qt[i].sub1);
+		fbnic_aggregate_ring_tx_counters(fbn, &nv->qt[i].cmpl);
+	}
+
+	for (j = 0; j < nv->rxt_count; j++, i++) {
+		fbnic_aggregate_ring_rx_counters(fbn, &nv->qt[i].sub0);
+		fbnic_aggregate_ring_rx_counters(fbn, &nv->qt[i].sub1);
+		fbnic_aggregate_ring_rx_counters(fbn, &nv->qt[i].cmpl);
+	}
+}
+
+static void fbnic_clone_swap(struct fbnic_net *orig,
+			     struct fbnic_net *clone)
+{
+	struct fbnic_dev *fbd = orig->fbd;
+	unsigned int i;
+
+	for (i = 0; i < max(clone->num_napi, orig->num_napi); i++)
+		fbnic_synchronize_irq(fbd, FBNIC_NON_NAPI_VECTORS + i);
+	for (i = 0; i < orig->num_napi; i++)
+		fbnic_aggregate_vector_counters(orig, orig->napi[i]);
+
+	fbnic_clone_swap_cfg(orig, clone);
+
+	for (i = 0; i < ARRAY_SIZE(orig->napi); i++)
+		swap(clone->napi[i], orig->napi[i]);
+	for (i = 0; i < ARRAY_SIZE(orig->tx); i++)
+		swap(clone->tx[i], orig->tx[i]);
+	for (i = 0; i < ARRAY_SIZE(orig->rx); i++)
+		swap(clone->rx[i], orig->rx[i]);
+}
+
+static void fbnic_clone_free(struct fbnic_net *clone)
+{
+	kfree(clone);
+}
+
 static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
 {
 	int i;
@@ -342,6 +412,8 @@ static int fbnic_set_channels(struct net_device *netdev,
 	struct fbnic_net *fbn = netdev_priv(netdev);
 	unsigned int max_napis, standalone;
 	struct fbnic_dev *fbd = fbn->fbd;
+	struct fbnic_net *clone;
+	int err;
 
 	max_napis = fbd->num_irqs - FBNIC_NON_NAPI_VECTORS;
 	standalone = ch->rx_count + ch->tx_count;
@@ -363,7 +435,54 @@ static int fbnic_set_channels(struct net_device *netdev,
 		return 0;
 	}
 
-	return -EBUSY;
+	clone = fbnic_clone_create(fbn);
+	if (!clone)
+		return -ENOMEM;
+
+	fbnic_set_queues(clone, ch, max_napis);
+
+	err = fbnic_alloc_napi_vectors(clone);
+	if (err)
+		goto err_free_clone;
+
+	err = fbnic_alloc_resources(clone);
+	if (err)
+		goto err_free_napis;
+
+	fbnic_down_noidle(fbn);
+	err = fbnic_wait_all_queues_idle(fbn->fbd, true);
+	if (err)
+		goto err_start_stack;
+
+	err = fbnic_set_netif_queues(clone);
+	if (err)
+		goto err_start_stack;
+
+	/* Nothing can fail past this point */
+	fbnic_flush(fbn);
+
+	fbnic_clone_swap(fbn, clone);
+
+	/* Reset RSS indirection table */
+	fbnic_reset_indir_tbl(fbn);
+
+	fbnic_up(fbn);
+
+	fbnic_free_resources(clone);
+	fbnic_free_napi_vectors(clone);
+	fbnic_clone_free(clone);
+
+	return 0;
+
+err_start_stack:
+	fbnic_flush(fbn);
+	fbnic_up(fbn);
+	fbnic_free_resources(clone);
+err_free_napis:
+	fbnic_free_napi_vectors(clone);
+err_free_clone:
+	fbnic_clone_free(clone);
+	return err;
 }
 
 static int
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index a8ea7b6774a8..1bbc0e56f3a0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -146,6 +146,17 @@ void fbnic_pcs_irq_disable(struct fbnic_dev *fbd)
 	free_irq(fbd->pcs_msix_vector, fbd);
 }
 
+void fbnic_synchronize_irq(struct fbnic_dev *fbd, int nr)
+{
+	struct pci_dev *pdev = to_pci_dev(fbd->dev);
+	int irq = pci_irq_vector(pdev, nr);
+
+	if (irq < 0)
+		return;
+
+	synchronize_irq(irq);
+}
+
 int fbnic_request_irq(struct fbnic_dev *fbd, int nr, irq_handler_t handler,
 		      unsigned long flags, const char *name, void *data)
 {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 0986c8f120a8..a392ac1cc4f2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -65,6 +65,7 @@ struct fbnic_net {
 int __fbnic_open(struct fbnic_net *fbn);
 void fbnic_up(struct fbnic_net *fbn);
 void fbnic_down(struct fbnic_net *fbn);
+void fbnic_down_noidle(struct fbnic_net *fbn);
 
 struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd);
 void fbnic_netdev_free(struct fbnic_dev *fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 32702dc4a066..6cbbc2ee3e1f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -145,7 +145,7 @@ void fbnic_up(struct fbnic_net *fbn)
 	fbnic_service_task_start(fbn);
 }
 
-static void fbnic_down_noidle(struct fbnic_net *fbn)
+void fbnic_down_noidle(struct fbnic_net *fbn)
 {
 	fbnic_service_task_stop(fbn);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 92fc1ad6ed6f..bb54ce5f5787 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1045,8 +1045,8 @@ irqreturn_t fbnic_msix_clean_rings(int __always_unused irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void fbnic_aggregate_ring_rx_counters(struct fbnic_net *fbn,
-					     struct fbnic_ring *rxr)
+void fbnic_aggregate_ring_rx_counters(struct fbnic_net *fbn,
+				      struct fbnic_ring *rxr)
 {
 	struct fbnic_queue_stats *stats = &rxr->stats;
 
@@ -1056,8 +1056,8 @@ static void fbnic_aggregate_ring_rx_counters(struct fbnic_net *fbn,
 	fbn->rx_stats.dropped += stats->dropped;
 }
 
-static void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
-					     struct fbnic_ring *txr)
+void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
+				      struct fbnic_ring *txr)
 {
 	struct fbnic_queue_stats *stats = &txr->stats;
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 92c671135ad7..c2a94f31f71b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -120,6 +120,11 @@ netdev_features_t
 fbnic_features_check(struct sk_buff *skb, struct net_device *dev,
 		     netdev_features_t features);
 
+void fbnic_aggregate_ring_rx_counters(struct fbnic_net *fbn,
+				      struct fbnic_ring *rxr);
+void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
+				      struct fbnic_ring *txr);
+
 int fbnic_alloc_napi_vectors(struct fbnic_net *fbn);
 void fbnic_free_napi_vectors(struct fbnic_net *fbn);
 int fbnic_alloc_resources(struct fbnic_net *fbn);
-- 
2.47.1


