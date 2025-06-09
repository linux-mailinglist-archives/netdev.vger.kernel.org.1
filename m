Return-Path: <netdev+bounces-195756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A7EAD22A7
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADE13A9CD9
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 15:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FAB20E70F;
	Mon,  9 Jun 2025 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="G2wqe5Gd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7BF20B80A
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483684; cv=none; b=oVC+YNp+LW2Q5/YSuxktG6aE+4Xl4M6NjoNBH2rtChj34ZO1OfSGuVpOzd0k9zb2i8D/1EQhh4banTs30Hss0pvQMurqQ2K9vPNm5ZXl+yv1rMytUKdq9S1whpqZ4kal9wWUNDKmvkAmbxsUYrx8g+SHE8mfSaUBr3WakLx/a4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483684; c=relaxed/simple;
	bh=lDetTmPDXSxCTZHg6MZuQ+rBwSKeUJeE1cln9tVXB6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYaGPe/d0Ebz7nWVp14MF69wHprnmi8gy+Uw5bTGlbTApwQ65OKlnelcRp6VXGDT1fcgPx9aDo8Er8oKK9GSqHB+2IKI49tQFqo7VE0LnrvjvwBtf6Mru325lO9Yr1uuTVA5V4oxYcJRvKs1wMVC1AgVk6anfrxnB9MNOqsfMNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=G2wqe5Gd; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mg1J2UH4D4i4/jYLyrMiFXW93LgQvRndQ0EqDWvmhXc=; t=1749483682; x=1750347682; 
	b=G2wqe5Gdt8GEOzgoYKuPgeZuGpHXmdCbOiEywHGBs8MuZQEtEKmvxtAREirOUfhEjOtxL+YTqtY
	W4gFm85Ynjd0u6t90jlUrB8fme6AY5y9pUtsGULqga+uSAO5H5M5Q26GCBmaaHJQJo7ZeFXlpsKqk
	8W8Cw/jMOlXtuYKRSwHS1EIU5GEStpCgsicDq71GwmKwgsh6Bw4f7xmXqyBMfVxNcNMkVlKlAyvvg
	wrVDmvWAP6M/OOD18+xU3LCC8dsW29bPi9gQOihta9sTLEttiq+GxRifvXTOMo3Ow+ysWDA7aWTRz
	7wBIY5PQilbu+Cjw5UobKFBMH6yCkIKC4z/Q==;
Received: from 70-228-78-207.lightspeed.sntcca.sbcglobal.net ([70.228.78.207]:55275 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uOech-0003cu-Fu; Mon, 09 Jun 2025 08:41:21 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v9 05/15] net: homa: create homa_peer.h and homa_peer.c
Date: Mon,  9 Jun 2025 08:40:38 -0700
Message-ID: <20250609154051.1319-6-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250609154051.1319-1-ouster@cs.stanford.edu>
References: <20250609154051.1319-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Scan-Signature: 6018b843980a2de42c80c5cf2d8a3dd5

Homa needs to keep a small amount of information for each peer that
it has communicated with. These files define that state and provide
functions for storing and accessing it.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v9:
* Add support for homa_net objects
* Implement limits on the number of active homa_peer objects. This includes
  adding reference counts in homa_peers and adding code to release peers
  where there are too many.
* Switch to using rhashtable to store homa_peers; the table is shared
  across all network namespaces, though individual peers are namespace-
  specific
* Invoke dst->ops->check in addition to checking the obsolete flag
* Various name improvements
* Remove the homa_peertab_gc_dsts mechanism, which is unnecessary

Changes for v7:
* Remove homa_peertab_get_peers
* Remove "lock_slow" functions, which don't add functionality in this
  patch
* Remove unused fields from homa_peer structs
* Use u64 and __u64 properly
* Add lock annotations
* Refactor homa_peertab_get_peers
* Use __GFP_ZERO in kmalloc calls
---
 net/homa/homa_impl.h |   3 +
 net/homa/homa_peer.c | 596 +++++++++++++++++++++++++++++++++++++++++++
 net/homa/homa_peer.h | 373 +++++++++++++++++++++++++++
 3 files changed, 972 insertions(+)
 create mode 100644 net/homa/homa_peer.c
 create mode 100644 net/homa/homa_peer.h

diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
index 7c634c24ffaf..a7912f03d47a 100644
--- a/net/homa/homa_impl.h
+++ b/net/homa/homa_impl.h
@@ -385,6 +385,9 @@ static inline bool homa_make_header_avl(struct sk_buff *skb)
 
 extern unsigned int homa_net_id;
 
+int      homa_xmit_control(enum homa_packet_type type, void *contents,
+			   size_t length, struct homa_rpc *rpc);
+
 /**
  * homa_net_from_net() - Return the struct homa_net associated with a particular
  * struct net.
diff --git a/net/homa/homa_peer.c b/net/homa/homa_peer.c
new file mode 100644
index 000000000000..136c6be97d26
--- /dev/null
+++ b/net/homa/homa_peer.c
@@ -0,0 +1,596 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+/* This file provides functions related to homa_peer and homa_peertab
+ * objects.
+ */
+
+#include "homa_impl.h"
+#include "homa_peer.h"
+#include "homa_rpc.h"
+
+const struct rhashtable_params ht_params = {
+	.key_len     = sizeof(struct homa_peer_key),
+	.key_offset  = offsetof(struct homa_peer, ht_key),
+	.head_offset = offsetof(struct homa_peer, ht_linkage),
+	.nelem_hint = 10000,
+	.hashfn = homa_peer_hash,
+	.obj_cmpfn = homa_peer_compare
+};
+
+/**
+ * homa_peer_alloc_peertab() - Allocate and initialize a homa_peertab.
+ *
+ * Return:    A pointer to the new homa_peertab, or ERR_PTR(-errno) if there
+ *            was a problem.
+ */
+struct homa_peertab *homa_peer_alloc_peertab(void)
+{
+	struct homa_peertab *peertab;
+	int err;
+
+	peertab = kmalloc(sizeof(*peertab), GFP_KERNEL | __GFP_ZERO);
+	if (!peertab) {
+		pr_err("%s couldn't create peertab: kmalloc failure", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	err = rhashtable_init(&peertab->ht, &ht_params);
+	if (err) {
+		kfree(peertab);
+		return ERR_PTR(err);
+	}
+	peertab->ht_valid = true;
+	rhashtable_walk_enter(&peertab->ht, &peertab->ht_iter);
+	INIT_LIST_HEAD(&peertab->dead_peers);
+	peertab->gc_threshold = 5000;
+	peertab->net_max = 10000;
+	peertab->idle_secs_min = 10;
+	peertab->idle_secs_max = 120;
+
+	homa_peer_update_sysctl_deps(peertab);
+	return peertab;
+}
+
+/**
+ * homa_peer_free_net() - Garbage collect all of the peer information
+ * associated with a particular network namespace.
+ * @hnet:    Network namespace whose peers should be freed. There must not
+ *           be any active sockets or RPCs for this namespace.
+ */
+void homa_peer_free_net(struct homa_net *hnet)
+{
+	struct homa_peertab *peertab = hnet->homa->peertab;
+	struct rhashtable_iter iter;
+	struct homa_peer *peer;
+
+	spin_lock_bh(&peertab->lock);
+	peertab->gc_stop_count++;
+	spin_unlock_bh(&peertab->lock);
+
+	rhashtable_walk_enter(&peertab->ht, &iter);
+	rhashtable_walk_start(&iter);
+	while (1) {
+		peer = rhashtable_walk_next(&iter);
+		if (!peer)
+			break;
+		if (IS_ERR(peer))
+			continue;
+		if (peer->ht_key.hnet != hnet)
+			continue;
+		if (rhashtable_remove_fast(&peertab->ht, &peer->ht_linkage,
+					   ht_params) == 0) {
+			homa_peer_free(peer);
+			hnet->num_peers--;
+			peertab->num_peers--;
+		}
+	}
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
+	WARN(hnet->num_peers != 0, "%s ended up with hnet->num_peers %d",
+	     __func__, hnet->num_peers);
+
+	spin_lock_bh(&peertab->lock);
+	peertab->gc_stop_count--;
+	spin_unlock_bh(&peertab->lock);
+}
+
+/**
+ * homa_peer_free_fn() - This function is invoked for each entry in
+ * the peer hash table by the rhashtable code when the table is being
+ * deleted. It frees its argument.
+ * @object:     struct homa_peer to free.
+ * @dummy:      Not used.
+ */
+void homa_peer_free_fn(void *object, void *dummy)
+{
+	struct homa_peer *peer = object;
+
+	homa_peer_free(peer);
+}
+
+/**
+ * homa_peer_free_peertab() - Destructor for homa_peertabs. After this
+ * function returns, it is unsafe to use any results from previous calls
+ * to homa_peer_get, since all existing homa_peer objects will have been
+ * destroyed.
+ * @peertab:  The table to destroy.
+ */
+void homa_peer_free_peertab(struct homa_peertab *peertab)
+{
+	spin_lock_bh(&peertab->lock);
+	peertab->gc_stop_count++;
+	spin_unlock_bh(&peertab->lock);
+
+	if (peertab->ht_valid) {
+		rhashtable_walk_exit(&peertab->ht_iter);
+		rhashtable_free_and_destroy(&peertab->ht, homa_peer_free_fn,
+					    NULL);
+	}
+	while (!list_empty(&peertab->dead_peers))
+		homa_peer_free_dead(peertab);
+	kfree(peertab);
+}
+
+/**
+ * homa_peer_rcu_callback() - This function is invoked as the callback
+ * for an invocation of call_rcu. It just marks a peertab to indicate that
+ * it was invoked.
+ * @head:    Contains information used to locate the peertab.
+ */
+void homa_peer_rcu_callback(struct rcu_head *head)
+{
+	struct homa_peertab *peertab;
+
+	peertab = container_of(head, struct homa_peertab, rcu_head);
+	atomic_set(&peertab->call_rcu_pending, 0);
+}
+
+/**
+ * homa_peer_free_dead() - Release peers on peertab->dead_peers
+ * if possible.
+ * @peertab:    Check the dead peers here.
+ */
+void homa_peer_free_dead(struct homa_peertab *peertab)
+	__must_hold(&peertab->lock)
+{
+	struct homa_peer *peer, *tmp;
+
+	/* A dead peer can be freed only if:
+	 * (a) there are no call_rcu calls pending (if there are, it's
+	 *     possible that a new reference might get created for the
+	 *     peer)
+	 * (b) the peer's reference count is zero.
+	 */
+	if (atomic_read(&peertab->call_rcu_pending))
+		return;
+	list_for_each_entry_safe(peer, tmp, &peertab->dead_peers, dead_links) {
+		if (atomic_read(&peer->refs) == 0) {
+			list_del_init(&peer->dead_links);
+			homa_peer_free(peer);
+		}
+	}
+}
+
+/**
+ * homa_peer_wait_dead() - Don't return until all of the dead peers have
+ * been freed.
+ * @peertab:    Overall information about peers, which includes a dead list.
+ *
+ */
+void homa_peer_wait_dead(struct homa_peertab *peertab)
+{
+	while (1) {
+		spin_lock_bh(&peertab->lock);
+		homa_peer_free_dead(peertab);
+		if (list_empty(&peertab->dead_peers)) {
+			spin_unlock_bh(&peertab->lock);
+			return;
+		}
+		spin_unlock_bh(&peertab->lock);
+	}
+}
+
+/**
+ * homa_peer_prefer_evict() - Given two peers, determine which one is
+ * a better candidate for eviction.
+ * @peertab:    Overall information used to manage peers.
+ * @peer1:      First peer.
+ * @peer2:      Second peer.
+ * Return:      True if @peer1 is a better candidate for eviction than @peer2.
+ */
+int homa_peer_prefer_evict(struct homa_peertab *peertab,
+			   struct homa_peer *peer1,
+			   struct homa_peer *peer2)
+{
+	/* Prefer a peer whose homa-net is over its limit; if both are either
+	 * over or under, then prefer the peer with the shortest idle time.
+	 */
+	if (peer1->ht_key.hnet->num_peers > peertab->net_max) {
+		if (peer2->ht_key.hnet->num_peers <= peertab->net_max)
+			return true;
+		else
+			return peer1->access_jiffies < peer2->access_jiffies;
+	}
+	if (peer2->ht_key.hnet->num_peers > peertab->net_max)
+		return false;
+	else
+		return peer1->access_jiffies < peer2->access_jiffies;
+}
+
+/**
+ * homa_peer_pick_victims() - Select a few peers that can be freed.
+ * @peertab:      Choose peers that are stored here.
+ * @victims:      Return addresses of victims here.
+ * @max_victims:  Limit on how many victims to choose (and size of @victims
+ *                array).
+ * Return:        The number of peers stored in @victims; may be zero.
+ */
+int homa_peer_pick_victims(struct homa_peertab *peertab,
+			   struct homa_peer *victims[], int max_victims)
+{
+	struct homa_peer *peer;
+	int num_victims = 0;
+	int to_scan;
+	int i, idle;
+
+	/* Scan 2 peers for every potential victim and keep the "best"
+	 * peers for removal.
+	 */
+	rhashtable_walk_start(&peertab->ht_iter);
+	for (to_scan = 2 * max_victims; to_scan > 0; to_scan--) {
+		peer = rhashtable_walk_next(&peertab->ht_iter);
+		if (!peer) {
+			/* Reached the end of the table; restart at
+			 * the beginning.
+			 */
+			rhashtable_walk_stop(&peertab->ht_iter);
+			rhashtable_walk_exit(&peertab->ht_iter);
+			rhashtable_walk_enter(&peertab->ht, &peertab->ht_iter);
+			rhashtable_walk_start(&peertab->ht_iter);
+			peer = rhashtable_walk_next(&peertab->ht_iter);
+			if (!peer)
+				break;
+		}
+		if (IS_ERR(peer)) {
+			/* rhashtable decided to restart the search at the
+			 * beginning.
+			 */
+			peer = rhashtable_walk_next(&peertab->ht_iter);
+			if (!peer || IS_ERR(peer))
+				break;
+		}
+
+		/* Has this peer been idle long enough to be candidate for
+		 * eviction?
+		 */
+		idle = jiffies - peer->access_jiffies;
+		if (idle < peertab->idle_jiffies_min)
+			continue;
+		if (idle < peertab->idle_jiffies_max &&
+		    peer->ht_key.hnet->num_peers <= peertab->net_max)
+			continue;
+
+		/* Sort the candidate into the existing list of victims. */
+		for (i = 0; i < num_victims; i++) {
+			if (peer == victims[i]) {
+				/* This can happen if there aren't very many
+				 * peers and we wrapped around in the hash
+				 * table.
+				 */
+				peer = NULL;
+				break;
+			}
+			if (homa_peer_prefer_evict(peertab, peer, victims[i])) {
+				struct homa_peer *tmp;
+
+				tmp = victims[i];
+				victims[i] = peer;
+				peer = tmp;
+			}
+		}
+
+		if (num_victims < max_victims && peer) {
+			victims[num_victims] = peer;
+			num_victims++;
+		}
+	}
+	rhashtable_walk_stop(&peertab->ht_iter);
+	return num_victims;
+}
+
+/**
+ * homa_peer_gc() - This function is invoked by Homa at regular intervals;
+ * its job is to ensure that the number of peers stays within limits.
+ * If the number grows too large, it selectively deletes peers to get
+ * back under the limit.
+ * @peertab:   Structure whose peers should be considered for garbage
+ *             collection.
+ */
+void homa_peer_gc(struct homa_peertab *peertab)
+{
+#define EVICT_BATCH_SIZE 5
+	struct homa_peer *victims[EVICT_BATCH_SIZE];
+	int num_victims;
+	int i;
+
+	spin_lock_bh(&peertab->lock);
+	if (peertab->gc_stop_count != 0)
+		goto done;
+	if (!list_empty(&peertab->dead_peers))
+		homa_peer_free_dead(peertab);
+	if (atomic_read(&peertab->call_rcu_pending) ||
+	    peertab->num_peers < peertab->gc_threshold)
+		goto done;
+	num_victims = homa_peer_pick_victims(peertab, victims,
+					     EVICT_BATCH_SIZE);
+	if (num_victims == 0)
+		goto done;
+
+	for (i = 0; i < num_victims; i++) {
+		struct homa_peer *peer = victims[i];
+
+		if (rhashtable_remove_fast(&peertab->ht, &peer->ht_linkage,
+					   ht_params) == 0) {
+			list_add_tail(&peer->dead_links, &peertab->dead_peers);
+			peertab->num_peers--;
+			peer->ht_key.hnet->num_peers--;
+		}
+	}
+	atomic_set(&peertab->call_rcu_pending, 1);
+	call_rcu(&peertab->rcu_head, homa_peer_rcu_callback);
+done:
+	spin_unlock_bh(&peertab->lock);
+}
+
+/**
+ * homa_peer_alloc() - Allocate and initialize a new homa_peer object.
+ * @hsk:        Socket for which the peer will be used.
+ * @addr:       Address of the desired host: IPv4 addresses are represented
+ *              as IPv4-mapped IPv6 addresses.
+ * Return:      The peer associated with @addr, or a negative errno if an
+ *              error occurred. On a successful return the reference count
+ *              will be incremented for the returned peer.
+ */
+struct homa_peer *homa_peer_alloc(struct homa_sock *hsk,
+				  const struct in6_addr *addr)
+{
+	struct homa_peer *peer;
+	struct dst_entry *dst;
+
+	peer = kmalloc(sizeof(*peer), GFP_ATOMIC | __GFP_ZERO);
+	if (!peer)
+		return (struct homa_peer *)ERR_PTR(-ENOMEM);
+	peer->ht_key.addr = *addr;
+	peer->ht_key.hnet = hsk->hnet;
+	INIT_LIST_HEAD(&peer->dead_links);
+	atomic_set(&peer->refs, 1);
+	peer->access_jiffies = jiffies;
+	peer->addr = *addr;
+	dst = homa_peer_get_dst(peer, hsk);
+	if (IS_ERR(dst)) {
+		kfree(peer);
+		return (struct homa_peer *)dst;
+	}
+	peer->dst = dst;
+	peer->current_ticks = -1;
+	spin_lock_init(&peer->ack_lock);
+	return peer;
+}
+
+/**
+ * homa_peer_free() - Release any resources in a peer and free the homa_peer
+ * struct.
+ * @peer:       Structure to free. Must not currently be linked into
+ *              peertab->ht.
+ */
+void homa_peer_free(struct homa_peer *peer)
+{
+	dst_release(peer->dst);
+
+	if (atomic_read(&peer->refs) == 0)
+		kfree(peer);
+	else
+		WARN(1, "%s found peer with reference count %d",
+		     __func__, atomic_read(&peer->refs));
+}
+
+/**
+ * homa_peer_get() - Returns the peer associated with a given host; creates
+ * a new homa_peer if one doesn't already exist.
+ * @hsk:        Socket where the peer will be used.
+ * @addr:       Address of the desired host: IPv4 addresses are represented
+ *              as IPv4-mapped IPv6 addresses.
+ *
+ * Return:      The peer associated with @addr, or a negative errno if an
+ *              error occurred. On a successful return the reference count
+ *              will be incremented for the returned peer. The caller must
+ *              eventually call homa_peer_release to release the reference.
+ */
+struct homa_peer *homa_peer_get(struct homa_sock *hsk,
+				const struct in6_addr *addr)
+{
+	struct homa_peertab *peertab = hsk->homa->peertab;
+	struct homa_peer *peer, *other;
+	struct homa_peer_key key;
+
+	key.addr = *addr;
+	key.hnet = hsk->hnet;
+	rcu_read_lock();
+	peer = rhashtable_lookup(&peertab->ht, &key, ht_params);
+	if (peer) {
+		homa_peer_hold(peer);
+		peer->access_jiffies = jiffies;
+		rcu_read_unlock();
+		return peer;
+	}
+
+	/* No existing entry, so we have to create a new one. */
+	peer = homa_peer_alloc(hsk, addr);
+	if (IS_ERR(peer)) {
+		rcu_read_unlock();
+		return peer;
+	}
+	spin_lock_bh(&peertab->lock);
+	other = rhashtable_lookup_get_insert_fast(&peertab->ht,
+						  &peer->ht_linkage, ht_params);
+	if (IS_ERR(other)) {
+		/* Couldn't insert; return the error info. */
+		homa_peer_release(peer);
+		homa_peer_free(peer);
+		peer = other;
+	} else if (other) {
+		/* Someone else already created the desired peer; use that
+		 * one instead of ours.
+		 */
+		homa_peer_release(peer);
+		homa_peer_free(peer);
+		peer = other;
+		homa_peer_hold(peer);
+		peer->access_jiffies = jiffies;
+	} else {
+		peertab->num_peers++;
+		key.hnet->num_peers++;
+	}
+	spin_unlock_bh(&peertab->lock);
+	rcu_read_unlock();
+	return peer;
+}
+
+/**
+ * homa_dst_refresh() - This method is called when the dst for a peer is
+ * obsolete; it releases that dst and creates a new one.
+ * @peertab:  Table containing the peer.
+ * @peer:     Peer whose dst is obsolete.
+ * @hsk:      Socket that will be used to transmit data to the peer.
+ */
+void homa_dst_refresh(struct homa_peertab *peertab, struct homa_peer *peer,
+		      struct homa_sock *hsk)
+{
+	struct dst_entry *dst;
+
+	dst = homa_peer_get_dst(peer, hsk);
+	if (IS_ERR(dst))
+		return;
+	dst_release(peer->dst);
+	peer->dst = dst;
+}
+
+/**
+ * homa_peer_get_dst() - Find an appropriate dst structure (either IPv4
+ * or IPv6) for a peer.
+ * @peer:   The peer for which a dst is needed. Note: this peer's flow
+ *          struct will be overwritten.
+ * @hsk:    Socket that will be used for sending packets.
+ * Return:  The dst structure (or an ERR_PTR); a reference has been taken.
+ */
+struct dst_entry *homa_peer_get_dst(struct homa_peer *peer,
+				    struct homa_sock *hsk)
+{
+	memset(&peer->flow, 0, sizeof(peer->flow));
+	if (hsk->sock.sk_family == AF_INET) {
+		struct rtable *rt;
+
+		flowi4_init_output(&peer->flow.u.ip4, hsk->sock.sk_bound_dev_if,
+				   hsk->sock.sk_mark, hsk->inet.tos,
+				   RT_SCOPE_UNIVERSE, hsk->sock.sk_protocol, 0,
+				   peer->addr.in6_u.u6_addr32[3],
+				   hsk->inet.inet_saddr, 0, 0,
+				   hsk->sock.sk_uid);
+		security_sk_classify_flow(&hsk->sock,
+					  &peer->flow.u.__fl_common);
+		rt = ip_route_output_flow(sock_net(&hsk->sock),
+					  &peer->flow.u.ip4, &hsk->sock);
+		if (IS_ERR(rt))
+			return (struct dst_entry *)(PTR_ERR(rt));
+		return &rt->dst;
+	}
+	peer->flow.u.ip6.flowi6_oif = hsk->sock.sk_bound_dev_if;
+	peer->flow.u.ip6.flowi6_iif = LOOPBACK_IFINDEX;
+	peer->flow.u.ip6.flowi6_mark = hsk->sock.sk_mark;
+	peer->flow.u.ip6.flowi6_scope = RT_SCOPE_UNIVERSE;
+	peer->flow.u.ip6.flowi6_proto = hsk->sock.sk_protocol;
+	peer->flow.u.ip6.flowi6_flags = 0;
+	peer->flow.u.ip6.flowi6_secid = 0;
+	peer->flow.u.ip6.flowi6_tun_key.tun_id = 0;
+	peer->flow.u.ip6.flowi6_uid = hsk->sock.sk_uid;
+	peer->flow.u.ip6.daddr = peer->addr;
+	peer->flow.u.ip6.saddr = hsk->inet.pinet6->saddr;
+	peer->flow.u.ip6.fl6_dport = 0;
+	peer->flow.u.ip6.fl6_sport = 0;
+	peer->flow.u.ip6.mp_hash = 0;
+	peer->flow.u.ip6.__fl_common.flowic_tos = hsk->inet.tos;
+	peer->flow.u.ip6.flowlabel = ip6_make_flowinfo(hsk->inet.tos, 0);
+	security_sk_classify_flow(&hsk->sock, &peer->flow.u.__fl_common);
+	return ip6_dst_lookup_flow(sock_net(&hsk->sock), &hsk->sock,
+			&peer->flow.u.ip6, NULL);
+}
+
+/**
+ * homa_peer_add_ack() - Add a given RPC to the list of unacked
+ * RPCs for its server. Once this method has been invoked, it's safe
+ * to delete the RPC, since it will eventually be acked to the server.
+ * @rpc:    Client RPC that has now completed.
+ */
+void homa_peer_add_ack(struct homa_rpc *rpc)
+{
+	struct homa_peer *peer = rpc->peer;
+	struct homa_ack_hdr ack;
+
+	homa_peer_lock(peer);
+	if (peer->num_acks < HOMA_MAX_ACKS_PER_PKT) {
+		peer->acks[peer->num_acks].client_id = cpu_to_be64(rpc->id);
+		peer->acks[peer->num_acks].server_port = htons(rpc->dport);
+		peer->num_acks++;
+		homa_peer_unlock(peer);
+		return;
+	}
+
+	/* The peer has filled up; send an ACK message to empty it. The
+	 * RPC in the message header will also be considered ACKed.
+	 */
+	memcpy(ack.acks, peer->acks, sizeof(peer->acks));
+	ack.num_acks = htons(peer->num_acks);
+	peer->num_acks = 0;
+	homa_peer_unlock(peer);
+	homa_xmit_control(ACK, &ack, sizeof(ack), rpc);
+}
+
+/**
+ * homa_peer_get_acks() - Copy acks out of a peer, and remove them from the
+ * peer.
+ * @peer:    Peer to check for possible unacked RPCs.
+ * @count:   Maximum number of acks to return.
+ * @dst:     The acks are copied to this location.
+ *
+ * Return:   The number of acks extracted from the peer (<= count).
+ */
+int homa_peer_get_acks(struct homa_peer *peer, int count, struct homa_ack *dst)
+{
+	/* Don't waste time acquiring the lock if there are no ids available. */
+	if (peer->num_acks == 0)
+		return 0;
+
+	homa_peer_lock(peer);
+
+	if (count > peer->num_acks)
+		count = peer->num_acks;
+	memcpy(dst, &peer->acks[peer->num_acks - count],
+	       count * sizeof(peer->acks[0]));
+	peer->num_acks -= count;
+
+	homa_peer_unlock(peer);
+	return count;
+}
+
+/**
+ * homa_peer_update_sysctl_deps() - Update any peertab fields that depend
+ * on values set by sysctl. This function is invoked anytime a peer sysctl
+ * value is updated.
+ * @peertab:   Struct to update.
+ */
+void homa_peer_update_sysctl_deps(struct homa_peertab *peertab)
+{
+	peertab->idle_jiffies_min = peertab->idle_secs_min * HZ;
+	peertab->idle_jiffies_max = peertab->idle_secs_max * HZ;
+}
+
diff --git a/net/homa/homa_peer.h b/net/homa/homa_peer.h
new file mode 100644
index 000000000000..3b3f7cccee9f
--- /dev/null
+++ b/net/homa/homa_peer.h
@@ -0,0 +1,373 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+
+/* This file contains definitions related to managing peers (homa_peer
+ * and homa_peertab).
+ */
+
+#ifndef _HOMA_PEER_H
+#define _HOMA_PEER_H
+
+#include "homa_wire.h"
+#include "homa_sock.h"
+
+#include <linux/rhashtable.h>
+
+struct homa_rpc;
+
+/**
+ * struct homa_peertab - Stores homa_peer objects, indexed by IPv6
+ * address.
+ */
+struct homa_peertab {
+	/**
+	 * @lock: Used to synchronize updates to @ht as well as other
+	 * operations on this object.
+	 */
+	spinlock_t lock;
+
+	/** @ht: Hash table that stores all struct peers. */
+	struct rhashtable ht;
+
+	/** @ht_iter: Used to scan ht to find peers to garbage collect. */
+	struct rhashtable_iter ht_iter;
+
+	/** @num_peers: Total number of peers currently in @ht. */
+	int num_peers;
+
+	/**
+	 * @ht_valid: True means ht and ht_iter have been initialized and must
+	 * eventually be destroyed.
+	 */
+	bool ht_valid;
+
+	/**
+	 * @dead_peers: List of peers that have been removed from ht
+	 * but can't yet be freed (because they have nonzero reference
+	 * counts or an rcu sync point hasn't been reached).
+	 */
+	struct list_head dead_peers;
+
+	/** @rcu_head: Holds state of a pending call_rcu invocation. */
+	struct rcu_head rcu_head;
+
+	/**
+	 * @call_rcu_pending: Nonzero means that call_rcu has been
+	 * invoked but it has not invoked the callback function; until the
+	 * callback has been invoked we can't free peers on dead_peers or
+	 * invoke call_rcu again (which means we can't add more peers to
+	 * dead_peers).
+	 */
+	atomic_t call_rcu_pending;
+
+	/**
+	 * @gc_stop_count: Nonzero means that peer garbage collection
+	 * should not be performed (conflicting state changes are underway).
+	 */
+	int gc_stop_count;
+
+	/**
+	 * @gc_threshold: If @num_peers is less than this, don't bother
+	 * doing any peer garbage collection. Set externally via sysctl.
+	 */
+	int gc_threshold;
+
+	/**
+	 * @net_max: If the number of peers for a homa_net exceeds this number,
+	 * work aggressivley to reclaim peers for that homa_net. Set
+	 * externally via sysctl.
+	 */
+	int net_max;
+
+	/**
+	 * @idle_secs_min: A peer will not be considered for garbage collection
+	 * under any circumstances if it has been idle less than this many
+	 * seconds. Set externally via sysctl.
+	 */
+	int idle_secs_min;
+
+	/**
+	 * @idle_jiffies_min: Same as idle_secs_min except in units
+	 * of jiffies.
+	 */
+	unsigned long idle_jiffies_min;
+
+	/**
+	 * @idle_secs_max: A peer that has been idle for less than
+	 * this many seconds will not be considered for garbage collection
+	 * unless its homa_net has more than @net_threshold peers. Set
+	 * externally via sysctl.
+	 */
+	int idle_secs_max;
+
+	/**
+	 * @idle_jiffies_max: Same as idle_secs_max except in units
+	 * of jiffies.
+	 */
+	unsigned long idle_jiffies_max;
+
+};
+
+/**
+ * struct homa_peer_key - Used to look up homa_peer structs in an rhashtable.
+ */
+struct homa_peer_key {
+	/**
+	 * @addr: Address of the desired host. IPv4 addresses are represented
+	 * with IPv4-mapped IPv6 addresses.
+	 */
+	struct in6_addr addr;
+
+	/** @hnet: The network namespace in which this peer is valid. */
+	struct homa_net *hnet;
+};
+
+/**
+ * struct homa_peer - One of these objects exists for each machine that we
+ * have communicated with (either as client or server).
+ */
+struct homa_peer {
+	/** @ht_key: The hash table key for this peer in peertab->ht. */
+	struct homa_peer_key ht_key;
+
+	/**
+	 * @ht_linkage: Used by rashtable implement to link this peer into
+	 * peertab->ht.
+	 */
+	struct rhash_head ht_linkage;
+
+	/** @dead_links: Used to link this peer into peertab->dead_peers. */
+	struct list_head dead_links;
+
+	/**
+	 * @refs: Number of unmatched calls to homa_peer_hold; it's not safe
+	 * to free this object until the reference count is zero.
+	 */
+	atomic_t refs ____cacheline_aligned_in_smp;
+
+	/**
+	 * @access_jiffies: Time in jiffies of most recent access to this
+	 * peer.
+	 */
+	unsigned long access_jiffies;
+
+	/**
+	 * @addr: IPv6 address for the machine (IPv4 addresses are stored
+	 * as IPv4-mapped IPv6 addresses).
+	 */
+	struct in6_addr addr ____cacheline_aligned_in_smp;
+
+	/** @flow: Addressing info needed to send packets. */
+	struct flowi flow;
+
+	/**
+	 * @dst: Used to route packets to this peer; we own a reference
+	 * to this, which we must eventually release.
+	 */
+	struct dst_entry *dst;
+
+	/**
+	 * @outstanding_resends: the number of resend requests we have
+	 * sent to this server (spaced @homa.resend_interval apart) since
+	 * we received a packet from this peer.
+	 */
+	int outstanding_resends;
+
+	/**
+	 * @most_recent_resend: @homa->timer_ticks when the most recent
+	 * resend was sent to this peer.
+	 */
+	int most_recent_resend;
+
+	/**
+	 * @least_recent_rpc: of all the RPCs for this peer scanned at
+	 * @current_ticks, this is the RPC whose @resend_timer_ticks
+	 * is farthest in the past.
+	 */
+	struct homa_rpc *least_recent_rpc;
+
+	/**
+	 * @least_recent_ticks: the @resend_timer_ticks value for
+	 * @least_recent_rpc.
+	 */
+	u32 least_recent_ticks;
+
+	/**
+	 * @current_ticks: the value of @homa->timer_ticks the last time
+	 * that @least_recent_rpc and @least_recent_ticks were computed.
+	 * Used to detect the start of a new homa_timer pass.
+	 */
+	u32 current_ticks;
+
+	/**
+	 * @resend_rpc: the value of @least_recent_rpc computed in the
+	 * previous homa_timer pass. This RPC will be issued a RESEND
+	 * in the current pass, if it still needs one.
+	 */
+	struct homa_rpc *resend_rpc;
+
+	/**
+	 * @num_acks: the number of (initial) entries in @acks that
+	 * currently hold valid information.
+	 */
+	int num_acks;
+
+	/**
+	 * @acks: info about client RPCs whose results have been completely
+	 * received.
+	 */
+	struct homa_ack acks[HOMA_MAX_ACKS_PER_PKT];
+
+	/**
+	 * @ack_lock: used to synchronize access to @num_acks and @acks.
+	 */
+	spinlock_t ack_lock;
+};
+
+void     homa_dst_refresh(struct homa_peertab *peertab,
+			  struct homa_peer *peer, struct homa_sock *hsk);
+void     homa_peer_add_ack(struct homa_rpc *rpc);
+struct homa_peer
+	*homa_peer_alloc(struct homa_sock *hsk, const struct in6_addr *addr);
+struct homa_peertab
+	*homa_peer_alloc_peertab(void);
+int      homa_peer_dointvec(const struct ctl_table *table, int write,
+			    void *buffer, size_t *lenp, loff_t *ppos);
+void     homa_peer_free(struct homa_peer *peer);
+void     homa_peer_free_dead(struct homa_peertab *peertab);
+void     homa_peer_free_fn(void *object, void *dummy);
+void     homa_peer_free_net(struct homa_net *hnet);
+void     homa_peer_free_peertab(struct homa_peertab *peertab);
+void     homa_peer_gc(struct homa_peertab *peertab);
+struct homa_peer
+	*homa_peer_get(struct homa_sock *hsk, const struct in6_addr *addr);
+int      homa_peer_get_acks(struct homa_peer *peer, int count,
+			    struct homa_ack *dst);
+struct dst_entry
+	*homa_peer_get_dst(struct homa_peer *peer, struct homa_sock *hsk);
+int      homa_peer_pick_victims(struct homa_peertab *peertab,
+				struct homa_peer *victims[], int max_victims);
+int      homa_peer_prefer_evict(struct homa_peertab *peertab,
+				struct homa_peer *peer1,
+				struct homa_peer *peer2);
+void     homa_peer_rcu_callback(struct rcu_head *head);
+void     homa_peer_wait_dead(struct homa_peertab *peertab);
+void     homa_peer_update_sysctl_deps(struct homa_peertab *peertab);
+
+/**
+ * homa_peer_lock() - Acquire the lock for a peer's @ack_lock.
+ * @peer:    Peer to lock.
+ */
+static inline void homa_peer_lock(struct homa_peer *peer)
+	__acquires(&peer->ack_lock)
+{
+	spin_lock_bh(&peer->ack_lock);
+}
+
+/**
+ * homa_peer_unlock() - Release the lock for a peer's @unacked_lock.
+ * @peer:   Peer to lock.
+ */
+static inline void homa_peer_unlock(struct homa_peer *peer)
+	__releases(&peer->ack_lock)
+{
+	spin_unlock_bh(&peer->ack_lock);
+}
+
+/**
+ * homa_get_dst() - Returns destination information associated with a peer,
+ * updating it if the cached information is stale.
+ * @peer:   Peer whose destination information is desired.
+ * @hsk:    Homa socket; needed by lower-level code to recreate the dst.
+ * Return:  Up-to-date destination for peer; a reference has been taken
+ *          on this dst_entry, which the caller must eventually release.
+ */
+static inline struct dst_entry *homa_get_dst(struct homa_peer *peer,
+					     struct homa_sock *hsk)
+{
+	if (unlikely(peer->dst->obsolete &&
+		     !peer->dst->ops->check(peer->dst, 0)))
+		homa_dst_refresh(hsk->homa->peertab, peer, hsk);
+	dst_hold(peer->dst);
+	return peer->dst;
+}
+
+/**
+ * homa_peer_hold() - Increment the reference count on an RPC, which will
+ * prevent it from being freed until homa_peer_release() is called.
+ * @peer:      Object on which to take a reference.
+ */
+static inline void homa_peer_hold(struct homa_peer *peer)
+{
+	atomic_inc(&peer->refs);
+}
+
+/**
+ * homa_peer_release() - Release a reference on a peer (cancels the effect of
+ * a previous call to homa_peer_hold). If the reference count becomes zero
+ * then the peer may be deleted at any time.
+ * @peer:      Object to release.
+ */
+static inline void homa_peer_release(struct homa_peer *peer)
+{
+	atomic_dec(&peer->refs);
+}
+
+/**
+ * homa_peer_hash() - Hash function used for @peertab->ht.
+ * @data:    Pointer to key for which a hash is desired. Must actually
+ *           be a struct homa_peer_key.
+ * @dummy:   Not used
+ * @seed:    Seed for the hash.
+ * Return:   A 32-bit hash value for the given key.
+ */
+static inline u32 homa_peer_hash(const void *data, u32 dummy, u32 seed)
+{
+	/* This is MurmurHash3, used instead of the jhash default because it
+	 * is faster (25 ns vs. 40 ns as of May 2025).
+	 */
+	BUILD_BUG_ON(sizeof(struct homa_peer_key) & 0x3);
+	const u32 len = sizeof(struct homa_peer_key) >> 2;
+	const u32 c1 = 0xcc9e2d51;
+	const u32 c2 = 0x1b873593;
+	const u32 *key = data;
+	u32 h = seed;
+
+	for (size_t i = 0; i < len; i++) {
+		u32 k = key[i];
+
+		k *= c1;
+		k = (k << 15) | (k >> (32 - 15));
+		k *= c2;
+
+		h ^= k;
+		h = (h << 13) | (h >> (32 - 13));
+		h = h * 5 + 0xe6546b64;
+	}
+
+	h ^= len * 4;  // Total number of input bytes
+
+	h ^= h >> 16;
+	h *= 0x85ebca6b;
+	h ^= h >> 13;
+	h *= 0xc2b2ae35;
+	h ^= h >> 16;
+	return h;
+}
+
+/**
+ * homa_peer_compare() - Comparison function for entries in @peertab->ht.
+ * @arg:   Contains one of the keys to compare.
+ * @obj:   homa_peer object containing the other key to compare.
+ * Return: 0 means the keys match, 1 means mismatch.
+ */
+static inline int homa_peer_compare(struct rhashtable_compare_arg *arg,
+				    const void *obj)
+{
+	const struct homa_peer *peer = obj;
+	const struct homa_peer_key *key = arg->key;
+
+	return !(ipv6_addr_equal(&key->addr, &peer->ht_key.addr) &&
+		 peer->ht_key.hnet == key->hnet);
+}
+
+#endif /* _HOMA_PEER_H */
-- 
2.43.0


