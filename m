Return-Path: <netdev+bounces-301373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TLhxFLOLOmo2/gcAu9opvQ
	(envelope-from <netdev+bounces-301373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:35:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6E46B77ED
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:35:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ahYpNpRN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301373-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301373-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3145030B96EF
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 13:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39D137C916;
	Tue, 23 Jun 2026 13:33:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742DF37BE74;
	Tue, 23 Jun 2026 13:33:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221612; cv=none; b=Hrx61avtjwUSJPCtDY0yjLsoD9Sa5gQh7IeGmAmaj000ntwEvtS2VlrZrZy+C7mYMGP7bxN8NVKmTlT3JB+IHfh53UYbHJJ3S7NIgwgeAj7KAGq6ooH7Miv2W+U1O4CNZ2bPfPCKwWytmbzRxkemqQ9Ynjpp+WF6d6xS1nQbmJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221612; c=relaxed/simple;
	bh=NGl2cPE3G06zK1isKDNsgc88FNuQebzB+qzAK6MBUMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UeA5AZS49jdd+s63MnKlW6Am4sSrtruGwibcneK2YNM4IwRCAXVXRXIYvvA0iDcPzk/0owBOEkhErtl2S6WSebFmVbcs1u1hyTs3yGbSDT5QB06L1q40fPybBcZBu0zFixuSymsOmxfcmEb15jXaPZ/x/GccfRdRCcJF/WxAXo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahYpNpRN; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782221610; x=1813757610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NGl2cPE3G06zK1isKDNsgc88FNuQebzB+qzAK6MBUMQ=;
  b=ahYpNpRNda9KOTgF8OqpyY8L9tTrIFf6PflUPJRJ6g/9R2232U1PvGEo
   dwEPCBwLpj6+KzdsDUhTePWY9tLG5l3ePlnTXGH6jlvObIR/p6K42jtfx
   ZCmM9B145bcpDpev2SH4L9T6gVkfJBTKA5cl1Y1SuBlLgIzoiFh87CviO
   jYb27FGHmPHs5yvJ4Zku66XVLW4SFasxlubiLoJvzQiE2PFggVoRLwn39
   otuQObX7fUv9cN63KnSsR0EXiWUAaqeBD5ijwePdYRLO2aQZLBfTv3XNs
   hFxb8M4DHc/SWRdYm0SMHvvZlFRoDJ0hKcFWB/aH469tv0IWlA/Gu0/fT
   w==;
X-CSE-ConnectionGUID: 7kTosZJ5SfWT3BrU/0ujzw==
X-CSE-MsgGUID: txZEvzIYShKPJZSFZ8BiQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83153556"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="83153556"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 06:33:30 -0700
X-CSE-ConnectionGUID: zNk4bXImSC2mctWi4D6ljQ==
X-CSE-MsgGUID: ITCwqASGRQuXMRqXBnnQFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="251447518"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jun 2026 06:33:27 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net 5/7] xsk: reclaim invalid multi-buffer Tx descs in ZC path
Date: Tue, 23 Jun 2026 15:32:38 +0200
Message-Id: <20260623133240.1048434-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301373-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:bjorn@kernel.org,m:maciej.fijalkowski@intel.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE6E46B77ED

Currently, the zero-copy Tx batching path stops when it encounters an
invalid descriptor. For multi-buffer packets this can leave descriptors
consumed from the Tx ring without returning their buffers to userspace
through the completion ring.

Handle invalid multi-buffer packets as a packet-sized unit. Keep
descriptors that are valid for transmission separate from descriptors
that are consumed only because they belong to an invalid multi-buffer
packet. The former are returned to the driver as Tx work, while the
latter are written to the CQ address area so they can be reclaimed by
userspace.

The batched path can retain drain state when the producer has not yet
supplied the end of an invalid packet. Do not allow a second Tx socket to
join the pool while such state exists. Gate the batched data path while a
same-pool bind waits for pre-existing readers, then either add the new
socket or fail the bind with -EAGAIN. This guarantees that drain state is
handled only by the singular batched path and avoids teaching the shared
UMEM fallback path about multi-buffer packet draining.

The reclaim-only descriptors must not be submitted to the completion
ring immediately when they follow real Tx descriptors in the same batch.
Drivers may complete only part of the Tx work returned by
xsk_tx_peek_release_desc_batch(), and publishing the reclaim descriptors
too early would also publish earlier real Tx descriptors that the driver
has not completed yet.

Track the number of driver-visible Tx descriptors that precede pending
reclaim descriptors. xsk_tx_completed() first advances through the real
Tx completions and submits the reclaim descriptors only after all earlier
Tx descriptors in the CQ address order have been completed. If a batch
contains only reclaim descriptors, complete them immediately because
there is no driver-visible Tx work in front of them.

This preserves CQ ordering while ensuring that every descriptor consumed
as part of an invalid multi-buffer packet is eventually returned to
userspace.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xsk_buff_pool.h |  6 ++++
 net/xdp/xsk.c               | 62 +++++++++++++++++++++++++++++++---
 net/xdp/xsk_buff_pool.c     | 66 +++++++++++++++++++++++++++++++++++++
 net/xdp/xsk_queue.h         | 66 +++++++++++++++++++++++++++----------
 4 files changed, 177 insertions(+), 23 deletions(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index ccb3b350001f..4e5abacfcbb7 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -78,9 +78,12 @@ struct xsk_buff_pool {
 	u32 chunk_size;
 	u32 chunk_shift;
 	u32 frame_len;
+	u32 reclaim_descs;
+	u32 tx_zc_pending_descs;
 	u32 xdp_zc_max_segs;
 	u8 tx_metadata_len; /* inherited from umem */
 	u8 cached_need_wakeup;
+	bool tx_share_pending;
 	bool uses_need_wakeup;
 	bool unaligned;
 	bool tx_sw_csum;
@@ -113,6 +116,9 @@ void xp_get_pool(struct xsk_buff_pool *pool);
 bool xp_put_pool(struct xsk_buff_pool *pool);
 void xp_clear_dev(struct xsk_buff_pool *pool);
 void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs);
+int xp_prepare_xsk_tx_share(struct xsk_buff_pool *pool, struct xdp_sock *xs,
+			    bool *pending);
+void xp_finish_xsk_tx_share(struct xsk_buff_pool *pool);
 void xp_del_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs);
 
 /* AF_XDP, and XDP core. */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 43791647cf18..2dda854c6590 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -499,6 +499,18 @@ void __xsk_map_flush(struct list_head *flush_list)
 
 void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
 {
+	if (unlikely(pool->reclaim_descs)) {
+		if (nb_entries < pool->tx_zc_pending_descs) {
+			pool->tx_zc_pending_descs -= nb_entries;
+			xskq_prod_submit_n(pool->cq, nb_entries);
+			return;
+		}
+
+		pool->tx_zc_pending_descs = 0;
+		nb_entries += pool->reclaim_descs;
+		pool->reclaim_descs = 0;
+	}
+
 	xskq_prod_submit_n(pool->cq, nb_entries);
 }
 EXPORT_SYMBOL(xsk_tx_completed);
@@ -576,9 +588,20 @@ static u32 xsk_tx_peek_release_fallback(struct xsk_buff_pool *pool, u32 max_entr
 
 u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
 {
+	struct xsk_tx_batch batch = {};
 	struct xdp_sock *xs;
+	u32 cq_cached_prod;
 
 	rcu_read_lock();
+
+	/* Pairs with the release stores in xp_prepare_xsk_tx_share() and
+	 * xp_finish_xsk_tx_share(). If bind is converting a singular Tx pool
+	 * to shared, do not enter the singular batched path.
+	 */
+	if (smp_load_acquire(&pool->tx_share_pending))
+		goto out;
+	if (unlikely(pool->reclaim_descs))
+		goto out;
 	if (!list_is_singular(&pool->xsk_tx_list)) {
 		/* Fallback to the non-batched version */
 		rcu_read_unlock();
@@ -586,10 +609,8 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
 	}
 
 	xs = list_first_or_null_rcu(&pool->xsk_tx_list, struct xdp_sock, tx_list);
-	if (!xs) {
-		nb_pkts = 0;
+	if (!xs)
 		goto out;
-	}
 
 	nb_pkts = xskq_cons_nb_entries(xs->tx, nb_pkts);
 
@@ -603,19 +624,38 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
 	if (!nb_pkts)
 		goto out;
 
-	nb_pkts = xskq_cons_read_desc_batch(xs->tx, pool, nb_pkts);
+	batch = xskq_cons_read_desc_batch(xs, pool, nb_pkts);
+	nb_pkts = xsk_tx_batch_cq_descs(&batch);
 	if (!nb_pkts) {
 		xs->tx->queue_empty_descs++;
 		goto out;
 	}
 
 	__xskq_cons_release(xs->tx);
+	cq_cached_prod = pool->cq->cached_prod;
+
 	xskq_prod_write_addr_batch(pool->cq, pool->tx_descs, nb_pkts);
+
+	if (unlikely(batch.reclaim_descs)) {
+		u32 cq_pending_descs;
+
+		/* CQ is positional. Descriptors already written but not
+		 * submitted must complete before any reclaim-only descriptors
+		 * appended below.
+		 */
+		cq_pending_descs = cq_cached_prod - xskq_get_prod(pool->cq);
+
+		pool->tx_zc_pending_descs = batch.tx_descs + cq_pending_descs;
+		pool->reclaim_descs = batch.reclaim_descs;
+		if (unlikely(!pool->tx_zc_pending_descs))
+			xsk_tx_completed(pool, 0);
+	}
+
 	xs->sk.sk_write_space(&xs->sk);
 
 out:
 	rcu_read_unlock();
-	return nb_pkts;
+	return batch.tx_descs;
 }
 EXPORT_SYMBOL(xsk_tx_peek_release_desc_batch);
 
@@ -1442,6 +1482,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 	struct sockaddr_xdp *sxdp = (struct sockaddr_xdp *)addr;
 	struct sock *sk = sock->sk;
 	struct xdp_sock *xs = xdp_sk(sk);
+	bool tx_share_pending = false;
 	struct net_device *dev;
 	int bound_dev_if;
 	u32 flags, qid;
@@ -1549,6 +1590,13 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 				goto out_unlock;
 			}
 
+			err = xp_prepare_xsk_tx_share(umem_xs->pool, xs,
+						      &tx_share_pending);
+			if (err) {
+				sockfd_put(sock);
+				goto out_unlock;
+			}
+
 			xp_get_pool(umem_xs->pool);
 			xs->pool = umem_xs->pool;
 
@@ -1559,6 +1607,8 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 			if (xs->tx && !xs->pool->tx_descs) {
 				err = xp_alloc_tx_descs(xs->pool, xs);
 				if (err) {
+					if (tx_share_pending)
+						xp_finish_xsk_tx_share(xs->pool);
 					xp_put_pool(xs->pool);
 					xs->pool = NULL;
 					sockfd_put(sock);
@@ -1598,6 +1648,8 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 	xs->sg = !!(xs->umem->flags & XDP_UMEM_SG_FLAG);
 	xs->queue_id = qid;
 	xp_add_xsk(xs->pool, xs);
+	if (tx_share_pending)
+		xp_finish_xsk_tx_share(xs->pool);
 
 	if (qid < dev->real_num_rx_queues) {
 		struct netdev_rx_queue *rxq;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 1f28a9641571..6fa732a843a9 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -22,6 +22,72 @@ void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs)
 	spin_unlock(&pool->xsk_tx_list_lock);
 }
 
+int xp_prepare_xsk_tx_share(struct xsk_buff_pool *pool, struct xdp_sock *xs,
+			    bool *pending)
+{
+	struct xdp_sock *tmp;
+	int err = 0;
+
+	*pending = false;
+	if (!xs->tx)
+		return 0;
+
+	spin_lock(&pool->xsk_tx_list_lock);
+	if (!list_is_singular(&pool->xsk_tx_list)) {
+		spin_unlock(&pool->xsk_tx_list_lock);
+		return 0;
+	}
+
+	if (pool->tx_share_pending) {
+		spin_unlock(&pool->xsk_tx_list_lock);
+		return -EAGAIN;
+	}
+
+	/* Pairs with the acquire load in xsk_tx_peek_release_desc_batch().
+	 * Stop new singular batched Tx readers before synchronize_net()
+	 * waits for readers that may already have observed a singular list.
+	 */
+	smp_store_release(&pool->tx_share_pending, true);
+	*pending = true;
+	spin_unlock(&pool->xsk_tx_list_lock);
+
+	/* A batch that observed a singular Tx socket list before the gate was
+	 * armed may set drain_cont. Wait for all such readers before checking
+	 * whether the pool can safely become shared.
+	 */
+	synchronize_net();
+
+	spin_lock(&pool->xsk_tx_list_lock);
+	list_for_each_entry(tmp, &pool->xsk_tx_list, tx_list) {
+		if (READ_ONCE(tmp->drain_cont)) {
+			err = -EAGAIN;
+			break;
+		}
+	}
+
+	if (err) {
+		/* Pairs with the acquire load in xsk_tx_peek_release_desc_batch().
+		 * No socket was added; clear the gate so Tx can resume.
+		 */
+		smp_store_release(&pool->tx_share_pending, false);
+		*pending = false;
+	}
+	spin_unlock(&pool->xsk_tx_list_lock);
+
+	return err;
+}
+
+void xp_finish_xsk_tx_share(struct xsk_buff_pool *pool)
+{
+	spin_lock(&pool->xsk_tx_list_lock);
+	/* Pairs with the acquire load in xsk_tx_peek_release_desc_batch().
+	 * Publish the preceding xp_add_xsk() list update before allowing Tx
+	 * to observe that the share transition has finished.
+	 */
+	smp_store_release(&pool->tx_share_pending, false);
+	spin_unlock(&pool->xsk_tx_list_lock);
+}
+
 void xp_del_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs)
 {
 	if (!xs->tx)
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 3e3fbb73d23e..99fa62e0d337 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -58,6 +58,16 @@ struct parsed_desc {
 	u32 valid;
 };
 
+struct xsk_tx_batch {
+	u32 tx_descs;
+	u32 reclaim_descs;
+};
+
+static inline u32 xsk_tx_batch_cq_descs(const struct xsk_tx_batch *batch)
+{
+	return batch->tx_descs + batch->reclaim_descs;
+}
+
 /* The structure of the shared state of the rings are a simple
  * circular buffer, as outlined in
  * Documentation/core-api/circular-buffers.rst. For the Rx and
@@ -263,17 +273,19 @@ static inline void parse_desc(struct xsk_queue *q, struct xsk_buff_pool *pool,
 	parsed->mb = xp_mb_desc(desc);
 }
 
-static inline
-u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
-			      u32 max)
+static inline struct xsk_tx_batch
+xskq_cons_read_desc_batch(struct xdp_sock *xs, struct xsk_buff_pool *pool,
+			  u32 max)
 {
-	u32 cached_cons = q->cached_cons, nb_entries = 0;
 	struct xdp_desc *descs = pool->tx_descs;
-	u32 total_descs = 0, nr_frags = 0;
+	bool drain = READ_ONCE(xs->drain_cont);
+	u32 cached_cons, nb_entries = 0;
+	struct xsk_tx_batch batch = {};
+	struct xsk_queue *q = xs->tx;
+	u32 nr_frags = 0;
+
+	cached_cons = q->cached_cons;
 
-	/* track first entry, if stumble upon *any* invalid descriptor, rewind
-	 * current packet that consists of frags and stop the processing
-	 */
 	while (cached_cons != q->cached_prod && nb_entries < max) {
 		struct xdp_rxtx_ring *ring = (struct xdp_rxtx_ring *)q->ring;
 		u32 idx = cached_cons & q->ring_mask;
@@ -282,26 +294,44 @@ u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
 		descs[nb_entries] = ring->desc[idx];
 		cached_cons++;
 		parse_desc(q, pool, &descs[nb_entries], &parsed);
-		if (unlikely(!parsed.valid))
-			break;
+		if (unlikely(!parsed.valid)) {
+			if (!drain && !nr_frags && !parsed.mb)
+				break;
+
+			drain = true;
+		}
+
+		nr_frags++;
+		nb_entries++;
 
 		if (likely(!parsed.mb)) {
-			total_descs += (nr_frags + 1);
-			nr_frags = 0;
-		} else {
-			nr_frags++;
-			if (nr_frags == pool->xdp_zc_max_segs) {
+			if (unlikely(drain)) {
+				batch.reclaim_descs = nr_frags;
+				WRITE_ONCE(xs->drain_cont, false);
 				nr_frags = 0;
 				break;
 			}
+
+			batch.tx_descs += nr_frags;
+			nr_frags = 0;
+			continue;
 		}
-		nb_entries++;
+
+		if (nr_frags == pool->xdp_zc_max_segs)
+			drain = true;
 	}
 
-	cached_cons -= nr_frags;
+	if (nr_frags) {
+		if (drain) {
+			batch.reclaim_descs = nr_frags;
+			WRITE_ONCE(xs->drain_cont, true);
+		} else {
+			cached_cons -= nr_frags;
+		}
+	}
 	/* Release valid plus any invalid entries */
 	xskq_cons_release_n(q, cached_cons - q->cached_cons);
-	return total_descs;
+	return batch;
 }
 
 /* Functions for consumers */
-- 
2.43.0


