Return-Path: <netdev+bounces-292310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FLWKrH3FmrUywcAu9opvQ
	(envelope-from <netdev+bounces-292310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:54:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E305E5606
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED8D1301BA78
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C60421A08;
	Wed, 27 May 2026 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGUyqxVZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3852F421EF8;
	Wed, 27 May 2026 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890084; cv=none; b=WyZeNDeTLw9i6wJ1U7EpXgZ01cvWxVosunDSbJEXifxAsaN42k4CJUIERCoVR1epMmOMvOkBq+oootDkqaNy6AeFoUm72dinZXmnY0gClMzueaV6abKfIZDcuyPrqrP8pmm5UMhDjDdq6wNwR8xWFVv1Df+B6RbdZsmNHhbfiTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890084; c=relaxed/simple;
	bh=Yy4Gt4aFye5JnmKyYUFK+AR4vsm2XFeQ/m1d2hBS7qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FygOQhZ2PRrf7HR63JcEFRbZkYZB0x7f9P+bNNkLsxX/QxfttiCt/gpjaUn+/C42OIaGs4SlxcGamHNtdGxPZeuWIl6RIM7homdHz2+DEIxHM9O7+dfFTrvCRiKyVTCe3ccyY3YfL9bg95AUFiTaSjgVuIos7qABnBZW6Woa/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGUyqxVZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2E01F000E9;
	Wed, 27 May 2026 13:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779890077;
	bh=UlOaUS7TXUGx3YtTh2z7CrtLGwyGtIup6lIGoTqcR7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VGUyqxVZ9vjfUl6nRK+DWhl31C57qdGDjf3WwvWuck2Gm7wMlyYxoiCRHRRmKAG8l
	 5ApTQWQobJY8hf42K/SBtoJo49vIdX7DEZ3FUBVcvRk7WWKsXyT/jhev9w5UyX0J1P
	 Ypv/HlJ8WoI5NW2w10jGffO6hlGHQ0u1q9FHltbHyS6a8hYfvX+u3qXT+zCOh0GOvF
	 UziCioumYPt/uNbdXHpaCpFhsrz4YnMniCzuGnGJX0ZayG8xi8tmB6Mm0+ska2d0JQ
	 Cw/Sgm1x09ra9befXiwpohqWYkI3Lt9kQ3JZAmXezW8diTMkFK6074hkQrJ3OjzH+g
	 x63CY+cldrWLA==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
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
Subject: [PATCH net-next v6 2/5] veth: implement Byte Queue Limits (BQL) for latency reduction
Date: Wed, 27 May 2026 15:54:13 +0200
Message-ID: <20260527135418.1166665-3-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527135418.1166665-1-hawk@kernel.org>
References: <20260527135418.1166665-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-292310-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 28E305E5606
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/veth.c | 86 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 75 insertions(+), 11 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 0cfb19b760dd..21ff78533943 100644
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
+	if (unlikely(__ptr_ring_check_produce(ring))) {
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
 
@@ -348,10 +381,11 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
 	struct veth_rq *rq = NULL;
-	struct netdev_queue *txq;
+	struct netdev_queue *txq = NULL;
 	struct net_device *rcv;
 	int length = skb->len;
 	bool use_napi = false;
+	bool do_bql = false;
 	int ret, rxq;
 
 	rcu_read_lock();
@@ -375,8 +409,12 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	skb_tx_timestamp(skb);
-
-	ret = veth_forward_skb(rcv, skb, rq, use_napi);
+	if (rxq < dev->real_num_tx_queues) {
+		txq = netdev_get_tx_queue(dev, rxq);
+		/* BQL charge happens inside veth_xdp_rx() under producer_lock */
+		do_bql = use_napi && !qdisc_txq_has_no_queue(txq);
+	}
+	ret = veth_forward_skb(rcv, skb, rq, use_napi, do_bql, txq);
 	switch (ret) {
 	case NET_RX_SUCCESS: /* same as NETDEV_TX_OK */
 		if (!use_napi)
@@ -412,6 +450,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 		net_crit_ratelimited("%s(%s): Invalid return code(%d)",
 				     __func__, dev->name, ret);
 	}
+
 	rcu_read_unlock();
 
 	return ret;
@@ -900,7 +939,8 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 
 static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			struct veth_xdp_tx_bq *bq,
-			struct veth_stats *stats)
+			struct veth_stats *stats,
+			struct netdev_queue *peer_txq)
 {
 	int i, done = 0, n_xdpf = 0;
 	void *xdpf[VETH_XDP_BATCH];
@@ -928,9 +968,13 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
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
@@ -976,7 +1020,7 @@ static int veth_poll(struct napi_struct *napi, int budget)
 		   netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
 
 	xdp_set_return_frame_no_direct();
-	done = veth_xdp_rcv(rq, budget, &bq, &stats);
+	done = veth_xdp_rcv(rq, budget, &bq, &stats, peer_txq);
 
 	if (stats.xdp_redirect > 0)
 		xdp_do_flush();
@@ -1074,6 +1118,7 @@ static int __veth_napi_enable(struct net_device *dev)
 static void veth_napi_del_range(struct net_device *dev, int start, int end)
 {
 	struct veth_priv *priv = netdev_priv(dev);
+	struct net_device *peer;
 	int i;
 
 	for (i = start; i < end; i++) {
@@ -1092,6 +1137,24 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
 		ptr_ring_cleanup(&rq->xdp_ring, veth_ptr_free);
 	}
 
+	/* Reset BQL and wake stopped peer txqs.  A concurrent veth_xmit()
+	 * may have set DRV_XOFF between rcu_assign_pointer(napi, NULL) and
+	 * synchronize_net(), and NAPI can no longer clear it.
+	 * Only wake when the device is still up.
+	 */
+	peer = rtnl_dereference(priv->peer);
+	if (peer) {
+		int peer_end = min_t(int, end, peer->real_num_tx_queues);
+
+		for (i = start; i < peer_end; i++) {
+			struct netdev_queue *txq = netdev_get_tx_queue(peer, i);
+
+			netdev_tx_reset_queue(txq);
+			if (netif_running(dev))
+				netif_tx_wake_queue(txq);
+		}
+	}
+
 	for (i = start; i < end; i++) {
 		page_pool_destroy(priv->rq[i].page_pool);
 		priv->rq[i].page_pool = NULL;
@@ -1741,6 +1804,7 @@ static void veth_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_PHONY_HEADROOM;
 	dev->priv_flags |= IFF_DISABLE_NETPOLL;
 	dev->lltx = true;
+	dev->bql = true;
 
 	dev->netdev_ops = &veth_netdev_ops;
 	dev->xdp_metadata_ops = &veth_xdp_metadata_ops;
-- 
2.43.0


