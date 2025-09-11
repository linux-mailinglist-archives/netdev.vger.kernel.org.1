Return-Path: <netdev+bounces-222185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962A5B53600
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3292D7AFA88
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730AC33769B;
	Thu, 11 Sep 2025 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekGDjM5K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E31C313543
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601814; cv=none; b=hwukUi9aCns+iVGQ7HzbLoS1sIyT2iQXXtj14fA8x451Cqot3gLuthO29iZFMotuRgf0XQcQ0fwFyr1WNvWHwIZ3aGCA2D4ciCdn7i/Dkhs/W63O5KC2fHreVs11NArD6cD0sf8oLp0jlGlw0I3FLjJhGvD00qVuoZpeGXr2OCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601814; c=relaxed/simple;
	bh=5joYKHJyn+/bG1/2W2XI6/SUAwVGFDnecK7PJm4GL2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y06qAsAb1HXzm7i05YCVZu8thTkbmZkveRPyWuetbSYJ1rwxLbaCkuuKAKQwhSdRVf1SP7jhXKt1tFneQbJvilin65wQ2u/BVl5oOM681s6COTAHZtxqf8oofec9SydobJgQmCxPfDBnyrNY96ZK6XmEb9vmUjcHmwrNP9Btmy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekGDjM5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A78BC4CEF0;
	Thu, 11 Sep 2025 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757601813;
	bh=5joYKHJyn+/bG1/2W2XI6/SUAwVGFDnecK7PJm4GL2o=;
	h=From:To:Cc:Subject:Date:From;
	b=ekGDjM5KMruPggDPYPauMwagAzORyFmcF1RCRfdmqpp7uFY6Q2X89RoRgfwkV+kSe
	 YZRiFIi0AtKeyyNcj8OjTls/pwlRP9IklQTqXIaCAFDfQB20BFO0+syc4Yhdr9Bd60
	 Ca+x6duxBGRGx6rLN6ylKfcSSs537dEkwyiMOAzreihxwI3RqqLflZe63XNNo0cr9f
	 Wsl7+0uniNtlXuO+obIN9r4K4JCXezG/LuMO9tlKJUvYoVlH0vRHrNA/nN9w0wUkOz
	 KmaAQQ5Fbq6Dwav2XFV2qCZbJuh24OpUl82DuHbvo4x3HbKMTZy83Mjfn7Cwo5LSsl
	 pHJOVMkMFwJ1A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	almasrymina@google.com,
	alexanderduyck@fb.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] eth: fbnic: support devmem Tx
Date: Thu, 11 Sep 2025 07:43:27 -0700
Message-ID: <20250911144327.1630532-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c   | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

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
index ac555e045e34..286ad628a557 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -37,6 +37,8 @@ struct fbnic_xmit_cb {
 
 #define FBNIC_XMIT_CB(__skb) ((struct fbnic_xmit_cb *)((__skb)->cb))
 
+#define FBNIC_XMIT_NOUNMAP	(void *)1
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
 
@@ -387,6 +394,7 @@ fbnic_tx_map(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 	while (tail != first) {
 		tail--;
 		tail &= ring->size_mask;
+		ring->tx_buf[tail] = NULL;
 		twd = &ring->desc[tail];
 		if (tail == first)
 			fbnic_unmap_single_twd(dev, twd);
@@ -574,7 +582,11 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
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


