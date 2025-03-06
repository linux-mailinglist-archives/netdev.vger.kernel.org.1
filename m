Return-Path: <netdev+bounces-172474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 774E3A54E43
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 15:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6183E7A3983
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 14:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9512518DB1A;
	Thu,  6 Mar 2025 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAMOCQDD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7197818BB9C
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272717; cv=none; b=iU7q6l3bimiXkeCeaZlBliVOjJUDpTe2fmPdodnZTZuL2L0AhkL4xVu90f0XFQoSat5FXT9pv1aeWoz47HMjiJg5UFWtFkN5tb7XQ++mKLFzC+qpVmihRRVQ1O+V8fWDIJS3dlmFTx+ZfOHZt4WTNEWXWY2YqTitHQy/2SUuwdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272717; c=relaxed/simple;
	bh=iaAU8oFM5ROk8sRCcSuiR+HddgnQIaiImuo7Zfcffw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bycybkthLuyCVmacz/g/h3iQBoGRE0bDZzqAUzrDIQ95yR7PehKcAgOCB6ajQ879JUNSRA7GjYzE4UhFEt46Q4u/1o1y9roXTNa6h2EHRx2eT0n5B64sqxzniFEbdCVngPy8eNxuAOObk9J+Hl8TEAn7VbfArSh5fIklDXb8QC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAMOCQDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CC7C4CEEC;
	Thu,  6 Mar 2025 14:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741272716;
	bh=iaAU8oFM5ROk8sRCcSuiR+HddgnQIaiImuo7Zfcffw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DAMOCQDDGrEP4cH2UrYZ9CgHLxkBx1GqHxaxsm2iYEZxiWDdiWCl5nyG2t07BT5fB
	 00kmf8fURHfeFgbYa3Gs01Xe8GlJ7N2YrHgCxSfMTAUb33TKbe7DjfM7DZ/m7QVuHB
	 2TYcCXJanAuwRnRc3hrow9yO6iYTZreSOhq7PGWJagRkrhWmvo48PxFX1YvZJ2F/TT
	 wAqzKyNQvNiAN+HA/qfyopL7yr1hV26BmHX9E19Q34V3VH8mZeXeN6vk7BZ3k5R6c4
	 SRZGNJEqbhd1HjF7Q7sp9N5ikOC0DoXt5hZBHHbH0/y+etG3qjWfNlrCDhH4SIeP8C
	 BhhxitU0sdZTQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] eth: fbnic: support ring size configuration
Date: Thu,  6 Mar 2025 06:51:50 -0800
Message-ID: <20250306145150.1757263-4-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306145150.1757263-1-kuba@kernel.org>
References: <20250306145150.1757263-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support ethtool -g / -G. Leverage the code added for -l / -L
to alloc / stop / start / free.

Check parameters against HW min/max but also our own min/max.
Min HW queue is 16 entries, we can't deal with TWQs that small
because of the queue waking logic. Add similar contraint on RCQ
for symmetry.

We need 3 sizes on Rx, as the NIC does header-data split two separate
buffer pools:
  (1) head page ring    - how many empty pages we post for headers
  (2) payload page ring - how many empty pages we post for payloads
  (3) completion ring   - where NIC produces the Rx descriptors

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v0.2:
 - trim unused defines
 - add comment
 - add info to commit msg
 - add extack
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  13 +++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 109 ++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 54368dc22328..f46616af41ea 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -24,9 +24,22 @@ struct fbnic_net;
 #define FBNIC_TX_DESC_WAKEUP	(FBNIC_MAX_SKB_DESC * 2)
 #define FBNIC_TX_DESC_MIN	roundup_pow_of_two(FBNIC_TX_DESC_WAKEUP)
 
+/* To receive the worst case packet we need:
+ *	1 descriptor for primary metadata
+ *	+ 1 descriptor for optional metadata
+ *	+ 1 descriptor for headers
+ *	+ 4 descriptors for payload
+ */
+#define FBNIC_MAX_RX_PKT_DESC	7
+#define FBNIC_RX_DESC_MIN	roundup_pow_of_two(FBNIC_MAX_RX_PKT_DESC * 2)
+
 #define FBNIC_MAX_TXQS			128u
 #define FBNIC_MAX_RXQS			128u
 
+/* These apply to TWQs, TCQ, RCQ */
+#define FBNIC_QUEUE_SIZE_MIN		16u
+#define FBNIC_QUEUE_SIZE_MAX		SZ_64K
+
 #define FBNIC_TXQ_SIZE_DEFAULT		1024
 #define FBNIC_HPQ_SIZE_DEFAULT		256
 #define FBNIC_PPQ_SIZE_DEFAULT		256
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index c1477aad98a0..0a751a2aaf73 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -191,6 +191,113 @@ static int fbnic_set_coalesce(struct net_device *netdev,
 	return 0;
 }
 
+static void
+fbnic_get_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
+		    struct kernel_ethtool_ringparam *kernel_ring,
+		    struct netlink_ext_ack *extack)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	ring->rx_max_pending = FBNIC_QUEUE_SIZE_MAX;
+	ring->rx_mini_max_pending = FBNIC_QUEUE_SIZE_MAX;
+	ring->rx_jumbo_max_pending = FBNIC_QUEUE_SIZE_MAX;
+	ring->tx_max_pending = FBNIC_QUEUE_SIZE_MAX;
+
+	ring->rx_pending = fbn->rcq_size;
+	ring->rx_mini_pending = fbn->hpq_size;
+	ring->rx_jumbo_pending = fbn->ppq_size;
+	ring->tx_pending = fbn->txq_size;
+}
+
+static void fbnic_set_rings(struct fbnic_net *fbn,
+			    struct ethtool_ringparam *ring)
+{
+	fbn->rcq_size = ring->rx_pending;
+	fbn->hpq_size = ring->rx_mini_pending;
+	fbn->ppq_size = ring->rx_jumbo_pending;
+	fbn->txq_size = ring->tx_pending;
+}
+
+static int
+fbnic_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
+		    struct kernel_ethtool_ringparam *kernel_ring,
+		    struct netlink_ext_ack *extack)
+
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_net *clone;
+	int err;
+
+	ring->rx_pending	= roundup_pow_of_two(ring->rx_pending);
+	ring->rx_mini_pending	= roundup_pow_of_two(ring->rx_mini_pending);
+	ring->rx_jumbo_pending	= roundup_pow_of_two(ring->rx_jumbo_pending);
+	ring->tx_pending	= roundup_pow_of_two(ring->tx_pending);
+
+	/* These are absolute minimums allowing the device and driver to operate
+	 * but not necessarily guarantee reasonable performance. Settings below
+	 * Rx queue size of 128 and BDQs smaller than 64 are likely suboptimal
+	 * at best.
+	 */
+	if (ring->rx_pending < max(FBNIC_QUEUE_SIZE_MIN, FBNIC_RX_DESC_MIN) ||
+	    ring->rx_mini_pending < FBNIC_QUEUE_SIZE_MIN ||
+	    ring->rx_jumbo_pending < FBNIC_QUEUE_SIZE_MIN ||
+	    ring->tx_pending < max(FBNIC_QUEUE_SIZE_MIN, FBNIC_TX_DESC_MIN)) {
+		NL_SET_ERR_MSG_MOD(extack, "requested ring size too small");
+		return -EINVAL;
+	}
+
+	if (!netif_running(netdev)) {
+		fbnic_set_rings(fbn, ring);
+		return 0;
+	}
+
+	clone = fbnic_clone_create(fbn);
+	if (!clone)
+		return -ENOMEM;
+
+	fbnic_set_rings(clone, ring);
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
+}
+
 static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
 {
 	int i;
@@ -1351,6 +1458,8 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_regs		= fbnic_get_regs,
 	.get_coalesce		= fbnic_get_coalesce,
 	.set_coalesce		= fbnic_set_coalesce,
+	.get_ringparam		= fbnic_get_ringparam,
+	.set_ringparam		= fbnic_set_ringparam,
 	.get_strings		= fbnic_get_strings,
 	.get_ethtool_stats	= fbnic_get_ethtool_stats,
 	.get_sset_count		= fbnic_get_sset_count,
-- 
2.48.1


