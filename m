Return-Path: <netdev+bounces-269024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F/qHEOuumlXagIAu9opvQ
	(envelope-from <netdev+bounces-269024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:53:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E28F62BC641
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48923304C497
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B604EED8;
	Wed, 18 Mar 2026 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KryodIHP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A301E3D88FF
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841720; cv=none; b=Ns/ZODqqSOKHeGQNvBSyF6iGkYet8hgTGhlmlSw7khsc3WfyD7bS1/5FANwl8kHfF7D+bCHQNlRTmivcZNuAMli5YrY+Auk9s1bIDLmlIk0SKo0zzksU9i6IRsxGRS9xkwKKncf7dhRaFmeNaG0gHAIVP0ybjVo/1BuMuIYZ/Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841720; c=relaxed/simple;
	bh=w+pKXxIdL/Szk9oLkeOrBc3yNqUSfLJnNNvlt2HTXvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0tKNeKEYBzvMXgnM+XI1ru4nDGZskKpJVzdc0w5rX+IjjQ4xYvcc3I3Ltc21adt4U16jnubfHfKmpc5LwOtgQ/Cli7TdSNpI0yt2Zfg68I4WBkpDktb8rtdA37z0HqLo/TZuwbRTi/T9K/ulUl32XFcdVUNjT9NnuqZk4lt95Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KryodIHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B092FC19424;
	Wed, 18 Mar 2026 13:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773841720;
	bh=w+pKXxIdL/Szk9oLkeOrBc3yNqUSfLJnNNvlt2HTXvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KryodIHPM64tpz0cvvca4yVWCkdOz9Hy/x0+McMqqpDew/ROCpn3lFrNxAvm7aoTd
	 lDTAZLz2PTnVxN/1T5OSKkcJv+uHMCDqfogT0Q6c239D3zjro4+xNg+Jk5d5Sv8Tg9
	 cEk66LwYDO8ryAKLhAEhIliEWAcE8CZ4I42glil6E/OusyButOByjuDalu0aCTT5cZ
	 7VuxRqqqlOjfCU6kg/E5ZmZ/+PqqKMG6bsPF1D2/HN9jDJQh+kiCPoybc/gy2kpyY5
	 PsjUGMrYqgojvhfRN2MXTYu3a6OhuWMQzLbLqXnCrlkxDFSr0c+UUU4jWngYLl+XJV
	 JWagIKJziiDeA==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	toke@toke.dk,
	sdf@fomichev.me,
	j.koeppeler@tu-berlin.de,
	mfreemon@cloudflare.com,
	carges@cloudflare.com
Subject: [RFC PATCH net-next 2/6] veth: implement Byte Queue Limits (BQL) for latency reduction
Date: Wed, 18 Mar 2026 14:48:22 +0100
Message-ID: <20260318134826.1281205-3-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318134826.1281205-1-hawk@kernel.org>
References: <20260318134826.1281205-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-269024-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-berlin.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:email]
X-Rspamd-Queue-Id: E28F62BC641
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jesper Dangaard Brouer <hawk@kernel.org>

Add BQL support to the veth driver to dynamically limit the number of
bytes queued in the ptr_ring, giving the qdisc earlier feedback to shape
traffic and reduce latency.

The BQL charge (netdev_tx_sent_queue) is placed in veth_xmit() BEFORE
veth_forward_skb() produces the SKB into the ptr_ring. This ordering is
critical: with threaded NAPI the consumer runs on a separate CPU and can
complete the SKB (calling dql_completed) before veth_xmit() returns. If
the charge happened after the produce, the completion could race ahead
of the charge, violating dql_completed()'s invariant that completed
bytes never exceed queued bytes (BUG_ON).

Whether an SKB was BQL-charged is tracked per-SKB using a VETH_BQL_FLAG
bit in the ptr_ring pointer (BIT(1), alongside the existing VETH_XDP_FLAG
BIT(0)). The do_bql flag from veth_xmit() propagates through
veth_forward_skb() and veth_xdp_rx() into the ptr_ring entry. On the
completion side in veth_xdp_rcv(), veth_ptr_is_bql() reads the flag to
decide whether to call netdev_tx_completed_queue(). Per-SKB tracking is
necessary because the qdisc can be replaced live (e.g. noqueue->sfq or
vice versa via 'tc qdisc replace') while SKBs are already in-flight in
the ptr_ring. SKBs charged under the old qdisc must complete correctly
regardless of what qdisc is attached when the consumer runs, so each
SKB carries its own BQL-charged state rather than re-checking the peer's
qdisc at completion time.

Completion is done per-SKB inside veth_xdp_rcv() as each packet is
consumed from the ptr_ring. Per-SKB granularity ensures STACK_XOFF is
cleared promptly, which is important for threaded NAPI where producer
and consumer run on separate CPUs.

The completion byte count uses skb->len + ETH_HLEN to match the charge
value. veth_xmit() captures length = skb->len before veth_forward_skb()
calls eth_type_trans(), which pulls the 14-byte Ethernet header. Without
adding ETH_HLEN back, the per-packet deficit prevents DQL from ever
seeing inprogress == 0 (queue empty), so the DQL limit never increases
from its initial value of 0 and BQL becomes silently ineffective.

Only SKBs from the ndo_start_xmit path are tracked. XDP frames entering
via ndo_xdp_xmit bypass veth_xmit() entirely and are never charged to
BQL, so they are correctly excluded from completion accounting.

BQL state is reset on the peer's txqs in veth_napi_del_range() after
ptr_ring_cleanup() frees remaining items without BQL completion. The
peer dereference is placed after synchronize_net() to ensure no
in-flight veth_poll() calls can race with the reset.

BQL's STACK_XOFF operates independently from the existing DRV_XOFF
backpressure mechanism (ptr_ring full). netif_tx_wake_queue() at the end
of veth_poll() clears only DRV_XOFF, while netdev_tx_completed_queue()
clears only STACK_XOFF. Both must be clear for the queue to transmit.
The existing NAPI scheduling guarantee (every successful veth_xmit()
calls __veth_xdp_flush(), plus the napi_complete_done() ring re-check)
ensures NAPI always runs when items are in the ring, preventing stuck
STACK_XOFF state.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Reported-by: Mike Freemon <mfreemon@cloudflare.com>
Reported-by: Chris Arges <carges@cloudflare.com>
Tested-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
---
 drivers/net/veth.c | 70 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index e35df717e65e..bad49e0d0bfc 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -34,6 +34,7 @@
 #define DRV_VERSION	"1.0"
 
 #define VETH_XDP_FLAG		BIT(0)
+#define VETH_BQL_FLAG		BIT(1)
 #define VETH_RING_SIZE		256
 #define VETH_XDP_HEADROOM	(XDP_PACKET_HEADROOM + NET_IP_ALIGN)
 
@@ -280,6 +281,21 @@ static bool veth_is_xdp_frame(void *ptr)
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
@@ -295,7 +311,7 @@ static void veth_ptr_free(void *ptr)
 	if (veth_is_xdp_frame(ptr))
 		xdp_return_frame(veth_ptr_to_xdp(ptr));
 	else
-		kfree_skb(ptr);
+		kfree_skb(veth_ptr_to_skb(ptr));
 }
 
 static void __veth_xdp_flush(struct veth_rq *rq)
@@ -309,19 +325,20 @@ static void __veth_xdp_flush(struct veth_rq *rq)
 	}
 }
 
-static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
+static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb, bool do_bql)
 {
-	if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb)))
+	if (unlikely(ptr_ring_produce(&rq->xdp_ring,
+				     veth_skb_to_ptr(skb, do_bql))))
 		return NETDEV_TX_BUSY; /* signal qdisc layer */
 
 	return NET_RX_SUCCESS; /* same as NETDEV_TX_OK */
 }
 
 static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,
-			    struct veth_rq *rq, bool xdp)
+			    struct veth_rq *rq, bool xdp, bool do_bql)
 {
 	return __dev_forward_skb(dev, skb) ?: xdp ?
-		veth_xdp_rx(rq, skb) :
+		veth_xdp_rx(rq, skb, do_bql) :
 		__netif_rx(skb);
 }
 
@@ -352,6 +369,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct net_device *rcv;
 	int length = skb->len;
 	bool use_napi = false;
+	bool do_bql = false;
 	int ret, rxq;
 
 	rcu_read_lock();
@@ -375,21 +393,27 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	skb_tx_timestamp(skb);
+	txq = netdev_get_tx_queue(dev, rxq);
 
-	ret = veth_forward_skb(rcv, skb, rq, use_napi);
+	/* BQL charge before forward: consumer may complete on another
+	 * CPU before we return.  BQL is only valid with a real qdisc.
+	 */
+	do_bql = use_napi && !qdisc_txq_has_no_queue(txq);
+	if (do_bql)
+		netdev_tx_sent_queue(txq, length);
+
+	ret = veth_forward_skb(rcv, skb, rq, use_napi, do_bql);
 	switch (ret) {
 	case NET_RX_SUCCESS: /* same as NETDEV_TX_OK */
 		if (!use_napi)
 			dev_sw_netstats_tx_add(dev, 1, length);
 		else
 			__veth_xdp_flush(rq);
-		break;
+		goto out;
 	case NETDEV_TX_BUSY:
 		/* If a qdisc is attached to our virtual device, returning
 		 * NETDEV_TX_BUSY is allowed.
 		 */
-		txq = netdev_get_tx_queue(dev, rxq);
-
 		if (qdisc_txq_has_no_queue(txq)) {
 			dev_kfree_skb_any(skb);
 			goto drop;
@@ -412,6 +436,11 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 		net_crit_ratelimited("%s(%s): Invalid return code(%d)",
 				     __func__, dev->name, ret);
 	}
+
+	/* Reverse BQL charge -- SKB didn't make it into the ptr_ring */
+	if (do_bql)
+		netdev_tx_completed_queue(txq, 1, length);
+out:
 	rcu_read_unlock();
 
 	return ret;
@@ -900,7 +929,8 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 
 static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			struct veth_xdp_tx_bq *bq,
-			struct veth_stats *stats)
+			struct veth_stats *stats,
+			struct netdev_queue *peer_txq)
 {
 	int i, done = 0, n_xdpf = 0;
 	void *xdpf[VETH_XDP_BATCH];
@@ -928,9 +958,14 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			}
 		} else {
 			/* ndo_start_xmit */
-			struct sk_buff *skb = ptr;
+			bool bql_charged = veth_ptr_is_bql(ptr);
+			struct sk_buff *skb = veth_ptr_to_skb(ptr);
 
 			stats->xdp_bytes += skb->len;
+			if (peer_txq && bql_charged)
+				netdev_tx_completed_queue(peer_txq, 1,
+							 skb->len + ETH_HLEN);
+
 			skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
 			if (skb) {
 				if (skb_shared(skb) || skb_unclone(skb, GFP_ATOMIC))
@@ -975,7 +1010,7 @@ static int veth_poll(struct napi_struct *napi, int budget)
 	peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
 
 	xdp_set_return_frame_no_direct();
-	done = veth_xdp_rcv(rq, budget, &bq, &stats);
+	done = veth_xdp_rcv(rq, budget, &bq, &stats, peer_txq);
 
 	if (stats.xdp_redirect > 0)
 		xdp_do_flush();
@@ -1073,6 +1108,7 @@ static int __veth_napi_enable(struct net_device *dev)
 static void veth_napi_del_range(struct net_device *dev, int start, int end)
 {
 	struct veth_priv *priv = netdev_priv(dev);
+	struct net_device *peer;
 	int i;
 
 	for (i = start; i < end; i++) {
@@ -1091,6 +1127,15 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
 		ptr_ring_cleanup(&rq->xdp_ring, veth_ptr_free);
 	}
 
+	/* Reset BQL on peer's txqs: remaining ring items were freed above
+	 * without BQL completion, so DQL state must be reset.
+	 */
+	peer = rtnl_dereference(priv->peer);
+	if (peer) {
+		for (i = start; i < end; i++)
+			netdev_tx_reset_queue(netdev_get_tx_queue(peer, i));
+	}
+
 	for (i = start; i < end; i++) {
 		page_pool_destroy(priv->rq[i].page_pool);
 		priv->rq[i].page_pool = NULL;
@@ -1740,6 +1785,7 @@ static void veth_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_PHONY_HEADROOM;
 	dev->priv_flags |= IFF_DISABLE_NETPOLL;
 	dev->lltx = true;
+	dev->bql = true;
 
 	dev->netdev_ops = &veth_netdev_ops;
 	dev->xdp_metadata_ops = &veth_xdp_metadata_ops;
-- 
2.43.0


