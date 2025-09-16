Return-Path: <netdev+bounces-223609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6D0B59B15
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE6F7B6102
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EC9311942;
	Tue, 16 Sep 2025 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvA/RY+V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D106E194A73
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034457; cv=none; b=HMJUyudcUyuW8t0eS64jqBqnMN+Qqvp8QuF3P95VUD/QiRBr28J0F/6Iz/Eb1ERSEHwwsTxigHNFjA0gO+yxqbdSWM8/VWmZlK6ho2cmoshqTaTPP6usEsPYjdUhMJaU60pc5OBTiGxre8USGP4xGSgX7MbTVTPjN7H8BNXcQDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034457; c=relaxed/simple;
	bh=PoJVCS6WWLaVlWZEDHW7KoJcksUmkQ5dyAk1Sa7mDwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ukrByTLUABwwgfdyUoOukuaMOxZhCfOJntWGE5gQj62w+rJMaP/64sg9pjhnYyYJg4c6/PCB/LRzbqY8834v1AYdTvhvRh1flKCuuLOkOQwk+TsJPbQj+Dtwqr23Q4SfF7F//OyhwIqhoGlAd21fQDrzTbdeWFCnCFf6Dne005Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvA/RY+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31B7C4CEEB;
	Tue, 16 Sep 2025 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758034457;
	bh=PoJVCS6WWLaVlWZEDHW7KoJcksUmkQ5dyAk1Sa7mDwQ=;
	h=From:To:Cc:Subject:Date:From;
	b=nvA/RY+V7CxeZPJohZrJ30ZJxXh1TXzWHVuShBaLaYzzu+3X2qJC0Nis3CLsi7J6F
	 sSTP4DPcNC7rqcWvnne95mo6BM2lWU+vZRj3XL7epvebscsSmEvXfvQVxbmTY/HaAr
	 BkJ+xyOsS0hTbhPn+OhyWmuSCbx6UftrPBZJCO0I3LmTBZLXpkFVil+jvYqfHCJEp1
	 NyzTk4qNkNiSt+oVs/+L1gVInUfSck8L7ON2PzKFD+kmPzXiu/sMOtB4iNNrsDT6pg
	 ozXLF3JKx++7qsYZwUak6/7DZPPB+dcOldW14myCLdiPJ+c6kZJbm/DNxweFA2+i1g
	 KqU+WphOpphNg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	Jakub Kicinski <kuba@kernel.org>,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v2] eth: fbnic: support devmem Tx
Date: Tue, 16 Sep 2025 07:54:01 -0700
Message-ID: <20250916145401.1464550-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support devmem Tx. We already use skb_frag_dma_map(), we just need
to make sure we don't try to unmap the frags. Check if frag is
unreadable and mark the ring entry.

  # ./tools/testing/selftests/drivers/net/hw/devmem.py
  TAP version 13
  1..3
  ok 1 devmem.check_rx
  ok 2 devmem.check_tx
  ok 3 devmem.check_tx_chunks
  # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Acked-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - fix the unmap on Tx error path
v1: https://lore.kernel.org/20250911144327.1630532-1-kuba@kernel.org
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c   | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index dd35de301870..d12b4cad84a5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -712,6 +712,7 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netdev->netdev_ops = &fbnic_netdev_ops;
 	netdev->stat_ops = &fbnic_stat_ops;
 	netdev->queue_mgmt_ops = &fbnic_queue_mgmt_ops;
+	netdev->netmem_tx = true;
 
 	fbnic_set_ethtool_ops(netdev);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index ac555e045e34..cf773cc78e40 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -37,6 +37,8 @@ struct fbnic_xmit_cb {
 
 #define FBNIC_XMIT_CB(__skb) ((struct fbnic_xmit_cb *)((__skb)->cb))
 
+#define FBNIC_XMIT_NOUNMAP	((void *)1)
+
 static u32 __iomem *fbnic_ring_csr_base(const struct fbnic_ring *ring)
 {
 	unsigned long csr_base = (unsigned long)ring->doorbell;
@@ -315,6 +317,7 @@ fbnic_tx_map(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 	unsigned int tail = ring->tail, first;
 	unsigned int size, data_len;
 	skb_frag_t *frag;
+	bool is_net_iov;
 	dma_addr_t dma;
 	__le64 *twd;
 
@@ -330,6 +333,7 @@ fbnic_tx_map(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 	if (size > FIELD_MAX(FBNIC_TWD_LEN_MASK))
 		goto dma_error;
 
+	is_net_iov = false;
 	dma = dma_map_single(dev, skb->data, size, DMA_TO_DEVICE);
 
 	for (frag = &skb_shinfo(skb)->frags[0];; frag++) {
@@ -342,6 +346,8 @@ fbnic_tx_map(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 				   FIELD_PREP(FBNIC_TWD_LEN_MASK, size) |
 				   FIELD_PREP(FBNIC_TWD_TYPE_MASK,
 					      FBNIC_TWD_TYPE_AL));
+		if (is_net_iov)
+			ring->tx_buf[tail] = FBNIC_XMIT_NOUNMAP;
 
 		tail++;
 		tail &= ring->size_mask;
@@ -355,6 +361,7 @@ fbnic_tx_map(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 		if (size > FIELD_MAX(FBNIC_TWD_LEN_MASK))
 			goto dma_error;
 
+		is_net_iov = skb_frag_is_net_iov(frag);
 		dma = skb_frag_dma_map(dev, frag, 0, size, DMA_TO_DEVICE);
 	}
 
@@ -390,6 +397,8 @@ fbnic_tx_map(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 		twd = &ring->desc[tail];
 		if (tail == first)
 			fbnic_unmap_single_twd(dev, twd);
+		else if (ring->tx_buf[tail] == FBNIC_XMIT_NOUNMAP)
+			ring->tx_buf[tail] = NULL;
 		else
 			fbnic_unmap_page_twd(dev, twd);
 	}
@@ -574,7 +583,11 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 		desc_cnt--;
 
 		while (desc_cnt--) {
-			fbnic_unmap_page_twd(nv->dev, &ring->desc[head]);
+			if (ring->tx_buf[head] != FBNIC_XMIT_NOUNMAP)
+				fbnic_unmap_page_twd(nv->dev,
+						     &ring->desc[head]);
+			else
+				ring->tx_buf[head] = NULL;
 			head++;
 			head &= ring->size_mask;
 		}
-- 
2.51.0


