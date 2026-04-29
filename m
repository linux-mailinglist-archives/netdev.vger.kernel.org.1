Return-Path: <netdev+bounces-282449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BG7GNA+8mlypAEAu9opvQ
	(envelope-from <netdev+bounces-282449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:24:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0A649826F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8248D3074AC5
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29BE40FDAD;
	Wed, 29 Apr 2026 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9q9IlrV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA97221723;
	Wed, 29 Apr 2026 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777483284; cv=none; b=i78WiA1/KM9gvfr5GbutBQffI0ulXkVMoJUdqLjTtrq3UWEd63EZMD28uICbSkbXw77+M4oZd/Wk4d06FvNmKOM90kWWUg7Lbp9yqx0lF0pF/vDPRKIex5GukII8gw2i1MIi5Kpb+mh7k9J4eIYsIZhmIqLb40ywDwX+yB3iYoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777483284; c=relaxed/simple;
	bh=1cBIpQ9aLppMsBzdk2K03CSWCfbmpNrt9lwop9BHqdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXL2AeC0h/sHzj77jUhS5a6fPpyevuUVWxBnHerXVG7H4TWkFeK7Yl4cKdz4ZoUemMcwOkBJLaEVnlWrZT1xrPo/J9u/AcqU8lH+IPyoBWniOpIFyVk40QmQRzh2dWpLlBB9qkLffwh8bIbEHL2FUcmfKo43l5MTY0hhGZF1hoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9q9IlrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDD6C2BCC7;
	Wed, 29 Apr 2026 17:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777483284;
	bh=1cBIpQ9aLppMsBzdk2K03CSWCfbmpNrt9lwop9BHqdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M9q9IlrV1D++szawI5M5qCwBp0JnucogxIWLOZSBKSyZTCSUwWYyRzXksneaB6HmF
	 RVT6t+mfxs6xi0McWnLpkJJz3aoFjpGXynrsSnpZ2fomQ/voKLxNozpwcsjHL56J7U
	 dJb8ku8wHW1QQkYoWweovgeEEaoNRPF25FA8TMUnzkf/0Hi/suJZLEczWYLvmLDBhR
	 lws5h1MbgTBZ52og1Nu6P9tYABW/LXW4xiMn0uT7vLWWKrYcwt3ebBF/AMvNtp+MRs
	 XkU6T72tVIf3tQxWGE++MyyTS7HhoBeH96+2zBEXOnmOP0X+Mx8Qu+893CyQrY5Csa
	 OxcUeGGABSIWA==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	kernel-team@cloudflare.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 2/5] veth: implement Byte Queue Limits (BQL) for latency reduction
Date: Wed, 29 Apr 2026 19:20:29 +0200
Message-ID: <20260429172036.1028526-3-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429172036.1028526-1-hawk@kernel.org>
References: <20260429172036.1028526-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AB0A649826F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,cloudflare.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-282449-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Jesper Dangaard Brouer <hawk@kernel.org>

Commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to
reduce TX drops") gave qdiscs control over veth by returning
NETDEV_TX_BUSY when the ptr_ring is full (DRV_XOFF).  That commit noted
a known limitation: the 256-entry ptr_ring sits in front of the qdisc as
a dark buffer, adding base latency because the qdisc has no visibility
into how many bytes are already queued there.

Add BQL support so the qdisc gets feedback and can begin shaping traffic
before the ring fills.  In testing with fq_codel, BQL reduces ping RTT
under UDP load from ~6.61ms to ~0.36ms (18x).

Charge a fixed VETH_BQL_UNIT (1) per packet rather than skb->len, so
the DQL limit tracks packets-in-flight.  Unlike a physical NIC, veth
has no link speed -- the ptr_ring drains at CPU speed and is
packet-indexed, not byte-indexed, so bytes are not the natural unit.
With byte-based charging, small packets sneak many more entries into
the ring before STACK_XOFF fires, deepening the dark buffer under
mixed-size workloads.  Testing with a concurrent min-size packet flood
shows 3.7x ping RTT degradation with skb->len charging versus no
change with fixed-unit charging.

Charge BQL inside veth_xdp_rx() under the ptr_ring producer_lock, after
confirming the ring is not full.  The charge must precede the produce
because the NAPI consumer can run on another CPU and complete the SKB
the instant it becomes visible in the ring.  Doing both under the same
lock avoids a pre-charge/undo pattern -- BQL is only charged when
produce is guaranteed to succeed.

BQL is enabled only when a real qdisc is attached (guarded by
!qdisc_txq_has_no_queue), as HARD_TX_LOCK provides serialization
for TXQ modification like dql_queued(). For lltx devices, like veth,
this HARD_TX_LOCK serialization isn't provided.  The ptr_ring
producer_lock provides additional serialization that would allow
BQL to work correctly even with noqueue, though that combination
is not currently enabled, as the netstack will drop and warn.

Track per-SKB BQL state via a VETH_BQL_FLAG pointer tag in the ptr_ring
entry.  This is necessary because the qdisc can be replaced live while
SKBs are in-flight -- each SKB must carry the charge decision made at
enqueue time rather than re-checking the peer's qdisc at completion.

Complete per-SKB in veth_xdp_rcv() rather than in bulk, so STACK_XOFF
clears promptly when producer and consumer run on different CPUs.

BQL introduces a second independent queue-stop mechanism (STACK_XOFF)
alongside the existing DRV_XOFF (ring full).  Both must be clear for
the queue to transmit.  Reset BQL state in veth_napi_del_range() after
synchronize_net() to avoid racing with in-flight veth_poll() calls.
Clamp the reset loop to the peer's real_num_tx_queues, since the peer
may have fewer TX queues than the local device has RX queues (e.g. when
veth is enslaved to a bond with XDP attached).

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/veth.c | 76 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 11 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index e35df717e65e..3de25ba34a90 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -34,9 +34,13 @@
 #define DRV_VERSION	"1.0"
 
 #define VETH_XDP_FLAG		BIT(0)
+#define VETH_BQL_FLAG		BIT(1)
 #define VETH_RING_SIZE		256
 #define VETH_XDP_HEADROOM	(XDP_PACKET_HEADROOM + NET_IP_ALIGN)
 
+/* Fixed BQL charge: DQL limit tracks packets-in-flight, not bytes */
+#define VETH_BQL_UNIT		1
+
 #define VETH_XDP_TX_BULK_SIZE	16
 #define VETH_XDP_BATCH		16
 
@@ -280,6 +284,21 @@ static bool veth_is_xdp_frame(void *ptr)
 	return (unsigned long)ptr & VETH_XDP_FLAG;
 }
 
+static bool veth_ptr_is_bql(void *ptr)
+{
+	return (unsigned long)ptr & VETH_BQL_FLAG;
+}
+
+static struct sk_buff *veth_ptr_to_skb(void *ptr)
+{
+	return (void *)((unsigned long)ptr & ~VETH_BQL_FLAG);
+}
+
+static void *veth_skb_to_ptr(struct sk_buff *skb, bool bql)
+{
+	return bql ? (void *)((unsigned long)skb | VETH_BQL_FLAG) : skb;
+}
+
 static struct xdp_frame *veth_ptr_to_xdp(void *ptr)
 {
 	return (void *)((unsigned long)ptr & ~VETH_XDP_FLAG);
@@ -295,7 +314,7 @@ static void veth_ptr_free(void *ptr)
 	if (veth_is_xdp_frame(ptr))
 		xdp_return_frame(veth_ptr_to_xdp(ptr));
 	else
-		kfree_skb(ptr);
+		kfree_skb(veth_ptr_to_skb(ptr));
 }
 
 static void __veth_xdp_flush(struct veth_rq *rq)
@@ -309,19 +328,33 @@ static void __veth_xdp_flush(struct veth_rq *rq)
 	}
 }
 
-static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
+static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb, bool do_bql,
+		       struct netdev_queue *txq)
 {
-	if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb)))
+	struct ptr_ring *ring = &rq->xdp_ring;
+
+	spin_lock(&ring->producer_lock);
+	if (unlikely(!ring->size) || __ptr_ring_full(ring)) {
+		spin_unlock(&ring->producer_lock);
 		return NETDEV_TX_BUSY; /* signal qdisc layer */
+	}
+
+	/* BQL charge before produce; consumer cannot see entry yet */
+	if (do_bql)
+		netdev_tx_sent_queue(txq, VETH_BQL_UNIT);
+
+	__ptr_ring_produce(ring, veth_skb_to_ptr(skb, do_bql));
+	spin_unlock(&ring->producer_lock);
 
 	return NET_RX_SUCCESS; /* same as NETDEV_TX_OK */
 }
 
 static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,
-			    struct veth_rq *rq, bool xdp)
+			    struct veth_rq *rq, bool xdp, bool do_bql,
+			    struct netdev_queue *txq)
 {
 	return __dev_forward_skb(dev, skb) ?: xdp ?
-		veth_xdp_rx(rq, skb) :
+		veth_xdp_rx(rq, skb, do_bql, txq) :
 		__netif_rx(skb);
 }
 
@@ -352,6 +385,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct net_device *rcv;
 	int length = skb->len;
 	bool use_napi = false;
+	bool do_bql = false;
 	int ret, rxq;
 
 	rcu_read_lock();
@@ -375,8 +409,11 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	skb_tx_timestamp(skb);
+	txq = netdev_get_tx_queue(dev, rxq);
 
-	ret = veth_forward_skb(rcv, skb, rq, use_napi);
+	/* BQL charge happens inside veth_xdp_rx() under producer_lock */
+	do_bql = use_napi && !qdisc_txq_has_no_queue(txq);
+	ret = veth_forward_skb(rcv, skb, rq, use_napi, do_bql, txq);
 	switch (ret) {
 	case NET_RX_SUCCESS: /* same as NETDEV_TX_OK */
 		if (!use_napi)
@@ -388,8 +425,6 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 		/* If a qdisc is attached to our virtual device, returning
 		 * NETDEV_TX_BUSY is allowed.
 		 */
-		txq = netdev_get_tx_queue(dev, rxq);
-
 		if (qdisc_txq_has_no_queue(txq)) {
 			dev_kfree_skb_any(skb);
 			goto drop;
@@ -412,6 +447,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 		net_crit_ratelimited("%s(%s): Invalid return code(%d)",
 				     __func__, dev->name, ret);
 	}
+
 	rcu_read_unlock();
 
 	return ret;
@@ -900,7 +936,8 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 
 static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			struct veth_xdp_tx_bq *bq,
-			struct veth_stats *stats)
+			struct veth_stats *stats,
+			struct netdev_queue *peer_txq)
 {
 	int i, done = 0, n_xdpf = 0;
 	void *xdpf[VETH_XDP_BATCH];
@@ -928,9 +965,13 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			}
 		} else {
 			/* ndo_start_xmit */
-			struct sk_buff *skb = ptr;
+			bool bql_charged = veth_ptr_is_bql(ptr);
+			struct sk_buff *skb = veth_ptr_to_skb(ptr);
 
 			stats->xdp_bytes += skb->len;
+			if (peer_txq && bql_charged)
+				netdev_tx_completed_queue(peer_txq, 1, VETH_BQL_UNIT);
+
 			skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
 			if (skb) {
 				if (skb_shared(skb) || skb_unclone(skb, GFP_ATOMIC))
@@ -975,7 +1016,7 @@ static int veth_poll(struct napi_struct *napi, int budget)
 	peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
 
 	xdp_set_return_frame_no_direct();
-	done = veth_xdp_rcv(rq, budget, &bq, &stats);
+	done = veth_xdp_rcv(rq, budget, &bq, &stats, peer_txq);
 
 	if (stats.xdp_redirect > 0)
 		xdp_do_flush();
@@ -1073,6 +1114,7 @@ static int __veth_napi_enable(struct net_device *dev)
 static void veth_napi_del_range(struct net_device *dev, int start, int end)
 {
 	struct veth_priv *priv = netdev_priv(dev);
+	struct net_device *peer;
 	int i;
 
 	for (i = start; i < end; i++) {
@@ -1091,6 +1133,17 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
 		ptr_ring_cleanup(&rq->xdp_ring, veth_ptr_free);
 	}
 
+	/* Reset BQL on peer's txqs: remaining ring items were freed above
+	 * without BQL completion, so DQL state must be reset.
+	 */
+	peer = rtnl_dereference(priv->peer);
+	if (peer) {
+		int peer_end = min(end, (int)peer->real_num_tx_queues);
+
+		for (i = start; i < peer_end; i++)
+			netdev_tx_reset_queue(netdev_get_tx_queue(peer, i));
+	}
+
 	for (i = start; i < end; i++) {
 		page_pool_destroy(priv->rq[i].page_pool);
 		priv->rq[i].page_pool = NULL;
@@ -1740,6 +1793,7 @@ static void veth_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_PHONY_HEADROOM;
 	dev->priv_flags |= IFF_DISABLE_NETPOLL;
 	dev->lltx = true;
+	dev->bql = true;
 
 	dev->netdev_ops = &veth_netdev_ops;
 	dev->xdp_metadata_ops = &veth_xdp_metadata_ops;
-- 
2.43.0


