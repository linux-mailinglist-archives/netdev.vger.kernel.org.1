Return-Path: <netdev+bounces-229714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAA6BE0432
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 355534E7D44
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C1E3016EB;
	Wed, 15 Oct 2025 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="lW5DrJX3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413F91F1537
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554311; cv=none; b=XbyBEqCmtLhHd5pJVsw35BvJLGeTt1IntXAmFIKlx+l6K0PCiXNfXjd1Fx2NLdD8WFCd8hpFkJx25A3rSom8de31AQGbWXI/8vh0OazDVHsHzm8WyHEjELnunZy3jL2gBCqhxCM1ykISOEVi0oBBCdsgd++B9SuC9Xlg0Gbdu8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554311; c=relaxed/simple;
	bh=/k0m8yzpVurdyJe1QR5bbGgiSaPkffEmgz7PZ9CTeFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCZ7LbgZfU2YPSStqTGAwZ2+HP3t0pz3myY7tpVW+cq9ITQfF++r7NQbTO4ejZIyZtNzjpVg4UYLfF+YaXnRDSzyjn/dJSRD53ydQ192JjgP80P31ItLxGyaAit92H17eX+P9c7rzMOjpZZe4x9BoDmoPfy4GMzNfAMu3avGubU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=lW5DrJX3; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8mj5NZdHNSOPJCopVP3ApYvAR591DQbWD7sBphzAqZA=; t=1760554309; x=1761418309; 
	b=lW5DrJX3SZceknsN+pNUX5ypvfn4XUwls/9grbEUrdFbE7pAiDvauZKCq6i1dx6CoSW8QcMCt3z
	xYgqwbDVCvCvzubwiBIFxGou65BfYeiQ58PHqZrupX/5i57qlmpKUtDw6V9tgTDJREQMUif2GR7w7
	HGdnt0qP0xrTIqrdgV0TkcQjyrzczYrLrxkp5IqP76VSP/CD5VGC/6a+Rtar1CrCklO8TxZbKAAn7
	WyoJAm2fqTJU4FXiMMXvvSUcpbX2okQPFP2lVlRTdDNjl7u7d+EFfNcj/3//BwyEVwPAacp4EZxWO
	KSdgOgzRvDUa8sJ49XXkXoi4wT9AXvKHf7Og==;
Received: from ouster448.stanford.edu ([172.24.72.71]:50623 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1v96bB-00063x-81; Wed, 15 Oct 2025 11:51:47 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v16 05/14] net: homa: create homa_peer.h and homa_peer.c
Date: Wed, 15 Oct 2025 11:50:52 -0700
Message-ID: <20251015185102.2444-6-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20251015185102.2444-1-ouster@cs.stanford.edu>
References: <20251015185102.2444-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: dd8e6172254ef2eaf3b2839fd0ac99ff

Homa needs to keep a small amount of information for each peer that
it has communicated with. These files define that state and provide
functions for storing and accessing it.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v16:
* Clean up and simplify reference counting mechanism (use refcount_t
  instead of atomic_t, eliminate dead_peers mechanism)
* Fix synchronization bugs in homa_dst_refresh (use RCU properly)
* Remove addr field of struct homa_peer
* Create separate header file for murmurhash hash function

Changes for v11:
* Clean up sparse annotations

Changes for v10:
* Use kzalloc instead of __GFP_ZERO
* Remove log messages after alloc errors
* Fix issues found by sparse, xmastree.py, etc.
* Add missing initialization for peertab->lock

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
 net/homa/homa_peer.c   | 571 +++++++++++++++++++++++++++++++++++++++++
 net/homa/homa_peer.h   | 312 ++++++++++++++++++++++
 net/homa/murmurhash3.h |  44 ++++
 3 files changed, 927 insertions(+)
 create mode 100644 net/homa/homa_peer.c
 create mode 100644 net/homa/homa_peer.h
 create mode 100644 net/homa/murmurhash3.h

diff --git a/net/homa/homa_peer.c b/net/homa/homa_peer.c
new file mode 100644
index 000000000000..5b47284ef6e4
--- /dev/null
+++ b/net/homa/homa_peer.c
@@ -0,0 +1,571 @@
+// SPDX-License-Identifier: BSD-2-Clause or GPL-2.0+
+
+/* This file provides functions related to homa_peer and homa_peertab
+ * objects.
+ */
+
+#include "homa_impl.h"
+#include "homa_peer.h"
+#include "homa_rpc.h"
+#include "murmurhash3.h"
+
+static const struct rhashtable_params ht_params = {
+	.key_len     = sizeof(struct homa_peer_key),
+	.key_offset  = offsetof(struct homa_peer, ht_key),
+	.head_offset = offsetof(struct homa_peer, ht_linkage),
+	.nelem_hint = 10000,
+	.hashfn = murmurhash3,
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
+	peertab = kzalloc(sizeof(*peertab), GFP_KERNEL);
+	if (!peertab)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock_init(&peertab->lock);
+	err = rhashtable_init(&peertab->ht, &ht_params);
+	if (err) {
+		kfree(peertab);
+		return ERR_PTR(err);
+	}
+	peertab->ht_valid = true;
+	rhashtable_walk_enter(&peertab->ht, &peertab->ht_iter);
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
+			homa_peer_release(peer);
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
+ * homa_peer_release_fn() - This function is invoked for each entry in
+ * the peer hash table by the rhashtable code when the table is being
+ * deleted. It frees its argument.
+ * @object:     homa_peer to free.
+ * @dummy:      Not used.
+ */
+void homa_peer_release_fn(void *object, void *dummy)
+{
+	struct homa_peer *peer = object;
+
+	homa_peer_release(peer);
+}
+
+/**
+ * homa_peer_free_peertab() - Destructor for homa_peertabs.
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
+		rhashtable_free_and_destroy(&peertab->ht, homa_peer_release_fn,
+					    NULL);
+	}
+	kfree(peertab);
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
+	if (peertab->num_peers < peertab->gc_threshold)
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
+			homa_peer_release(peer);
+			peertab->num_peers--;
+			peer->ht_key.hnet->num_peers--;
+		}
+	}
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
+ *              will be incremented for the returned peer. Sets hsk->error_msg
+ *              on errors.
+ */
+struct homa_peer *homa_peer_alloc(struct homa_sock *hsk,
+				  const struct in6_addr *addr)
+{
+	struct homa_peer *peer;
+	int status;
+
+	peer = kzalloc(sizeof(*peer), GFP_ATOMIC);
+	if (!peer) {
+		hsk->error_msg = "couldn't allocate memory for homa_peer";
+		return (struct homa_peer *)ERR_PTR(-ENOMEM);
+	}
+	peer->ht_key.addr = *addr;
+	peer->ht_key.hnet = hsk->hnet;
+	refcount_set(&peer->refs, 1);
+	peer->access_jiffies = jiffies;
+	spin_lock_init(&peer->lock);
+	peer->current_ticks = -1;
+
+	status = homa_peer_reset_dst(peer, hsk);
+	if (status != 0) {
+		hsk->error_msg = "couldn't find route for peer";
+		kfree(peer);
+		return ERR_PTR(status);
+	}
+	return peer;
+}
+
+/**
+ * homa_peer_free() - Release any resources in a peer and free the homa_peer
+ * struct. Invoked by the RCU mechanism via homa_peer_release.
+ * @head:   Pointer to the rcu_head field of the peer to free.
+ */
+void homa_peer_free(struct rcu_head *head)
+{
+	struct homa_peer *peer;
+
+	peer = container_of(head, struct homa_peer, rcu_head);
+	dst_release(rcu_dereference(peer->dst));
+	kfree(peer);
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
+		peer = other;
+	} else if (other) {
+		/* Someone else already created the desired peer; use that
+		 * one instead of ours.
+		 */
+		homa_peer_release(peer);
+		homa_peer_hold(other);
+		peer = other;
+		peer->access_jiffies = jiffies;
+	} else {
+		homa_peer_hold(peer);
+		peertab->num_peers++;
+		key.hnet->num_peers++;
+	}
+	spin_unlock_bh(&peertab->lock);
+	rcu_read_unlock();
+	return peer;
+}
+
+/**
+ * homa_get_dst() - Returns destination information associated with a peer,
+ * updating it if the cached information is stale.
+ * @peer:   Peer whose destination information is desired.
+ * @hsk:    Homa socket with which the dst will be used; needed by lower-level
+ *          code to recreate the dst.
+ * Return:  Up-to-date destination for peer; a reference has been taken
+ *          on this dst_entry, which the caller must eventually release.
+ */
+struct dst_entry *homa_get_dst(struct homa_peer *peer, struct homa_sock *hsk)
+{
+	struct dst_entry *dst;
+	int pass;
+
+	rcu_read_lock();
+	for (pass = 0; ; pass++) {
+		do {
+			/* This loop repeats only if we happen to fetch
+			 * the dst right when it is being reset.
+			 */
+			dst = rcu_dereference(peer->dst);
+		} while (!dst_hold_safe(dst));
+
+		/* After the first pass it's OK to return an obsolete dst
+		 * (we're basically giving up; continuing could result in
+		 * an infinite loop if homa_dst_refresh can't create a new dst).
+		 */
+		if (dst_check(dst, peer->dst_cookie) || pass > 0)
+			break;
+		dst_release(dst);
+		homa_peer_reset_dst(peer, hsk);
+	}
+	rcu_read_unlock();
+	return dst;
+}
+
+/**
+ * homa_peer_reset_dst() - Find an appropriate dst_entry for a peer and
+ * store it in the peer's dst field. If the field is already set, the
+ * current value is assumed to be stale and will be discarded if a new
+ * dst_entry can be created.
+ * @peer:   The peer whose dst field should be reset.
+ * @hsk:    Socket that will be used for sending packets.
+ * Return:  Zero for success, or a negative errno if there was an error
+ *          (in which case the existing value for the dst field is left
+ *          in place).
+ */
+int homa_peer_reset_dst(struct homa_peer *peer, struct homa_sock *hsk)
+{
+	struct dst_entry *dst;
+	int result = 0;
+
+	homa_peer_lock(peer);
+	memset(&peer->flow, 0, sizeof(peer->flow));
+	if (hsk->sock.sk_family == AF_INET) {
+		struct rtable *rt;
+
+		flowi4_init_output(&peer->flow.u.ip4, hsk->sock.sk_bound_dev_if,
+				   hsk->sock.sk_mark, hsk->inet.tos,
+				   RT_SCOPE_UNIVERSE, hsk->sock.sk_protocol, 0,
+				   ipv6_to_ipv4(peer->addr),
+				   hsk->inet.inet_saddr, 0, 0,
+				   hsk->sock.sk_uid);
+		security_sk_classify_flow(&hsk->sock,
+					  &peer->flow.u.__fl_common);
+		rt = ip_route_output_flow(sock_net(&hsk->sock),
+					  &peer->flow.u.ip4, &hsk->sock);
+		if (IS_ERR(rt)) {
+			result = PTR_ERR(rt);
+			goto done;
+		}
+		dst = &rt->dst;
+		peer->dst_cookie = 0;
+	} else {
+		peer->flow.u.ip6.flowi6_oif = hsk->sock.sk_bound_dev_if;
+		peer->flow.u.ip6.flowi6_iif = LOOPBACK_IFINDEX;
+		peer->flow.u.ip6.flowi6_mark = hsk->sock.sk_mark;
+		peer->flow.u.ip6.flowi6_scope = RT_SCOPE_UNIVERSE;
+		peer->flow.u.ip6.flowi6_proto = hsk->sock.sk_protocol;
+		peer->flow.u.ip6.flowi6_flags = 0;
+		peer->flow.u.ip6.flowi6_secid = 0;
+		peer->flow.u.ip6.flowi6_tun_key.tun_id = 0;
+		peer->flow.u.ip6.flowi6_uid = hsk->sock.sk_uid;
+		peer->flow.u.ip6.daddr = peer->addr;
+		peer->flow.u.ip6.saddr = hsk->inet.pinet6->saddr;
+		peer->flow.u.ip6.fl6_dport = 0;
+		peer->flow.u.ip6.fl6_sport = 0;
+		peer->flow.u.ip6.mp_hash = 0;
+		peer->flow.u.ip6.__fl_common.flowic_tos = hsk->inet.tos;
+		peer->flow.u.ip6.flowlabel = ip6_make_flowinfo(hsk->inet.tos,
+							       0);
+		security_sk_classify_flow(&hsk->sock,
+					  &peer->flow.u.__fl_common);
+		dst = ip6_dst_lookup_flow(sock_net(&hsk->sock), &hsk->sock,
+					  &peer->flow.u.ip6, NULL);
+		if (IS_ERR(dst)) {
+			result = PTR_ERR(dst);
+			goto done;
+		}
+		peer->dst_cookie = rt6_get_cookie(dst_rt6_info(dst));
+	}
+
+	/* From the standpoint of homa_get_dst, peer->dst is not updated
+	 * atomically with peer->dst_cookie, which means homa_get_dst could
+	 * use a new cookie with an old dest. Fortunately, this is benign; at
+	 * worst, it might cause an obsolete dst to be reused (resulting in
+	 * a lost packet) or a valid dst to be replaced (resulting in
+	 * unnecessary work).
+	 */
+	dst_release(rcu_replace_pointer(peer->dst, dst, true));
+
+done:
+	homa_peer_unlock(peer);
+	return result;
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
index 000000000000..5e145be2ab1a
--- /dev/null
+++ b/net/homa/homa_peer.h
@@ -0,0 +1,312 @@
+/* SPDX-License-Identifier: BSD-2-Clause or GPL-2.0+ */
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
+	/** @rcu_head: Holds state of a pending call_rcu invocation. */
+	struct rcu_head rcu_head;
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
+	 * work aggressively to reclaim peers for that homa_net. Set
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
+	 * with IPv4-mapped IPv6 addresses. Must be the first variable in
+	 * the struct, because of union in homa_peer.
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
+	union {
+		/**
+		 * @addr: IPv6 address for the machine (IPv4 addresses are
+		 * stored as IPv4-mapped IPv6 addresses).
+		 */
+		struct in6_addr addr;
+
+		/** @ht_key: The hash table key for this peer in peertab->ht. */
+		struct homa_peer_key ht_key;
+	};
+
+	/**
+	 * @refs: Number of outstanding references to this peer. Includes
+	 * one reference for the entry in peertab->ht, plus one for each
+	 * unmatched call to homa_peer_hold; the peer gets freed when
+	 * this value becomes zero.
+	 */
+	refcount_t refs;
+
+	/**
+	 * @access_jiffies: Time in jiffies of most recent access to this
+	 * peer.
+	 */
+	unsigned long access_jiffies;
+
+	/**
+	 * @ht_linkage: Used by rashtable implement to link this peer into
+	 * peertab->ht.
+	 */
+	struct rhash_head ht_linkage;
+
+	/**
+	 * @lock: used to synchronize access to fields in this struct, such
+	 * as @num_acks, @acks, @dst, and @dst_cookie.
+	 */
+	spinlock_t lock ____cacheline_aligned_in_smp;
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
+	 * @dst: Used to route packets to this peer; this object owns a
+	 * reference that must eventually be released.
+	 */
+	struct dst_entry __rcu *dst;
+
+	/**
+	 * @dst_cookie: Used to check whether dst is still valid. This is
+	 * accessed without synchronization, which is racy, but the worst
+	 * that can happen is using an obsolete dst.
+	 */
+	u32 dst_cookie;
+
+	/**
+	 * @flow: Addressing info used to create @dst and also required
+	 * when transmitting packets.
+	 */
+	struct flowi flow;
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
+	/** @rcu_head: Holds state of a pending call_rcu invocation. */
+	struct rcu_head rcu_head;
+};
+
+void     homa_dst_refresh(struct homa_peertab *peertab,
+			  struct homa_peer *peer, struct homa_sock *hsk);
+struct dst_entry
+	*homa_get_dst(struct homa_peer *peer, struct homa_sock *hsk);
+void     homa_peer_add_ack(struct homa_rpc *rpc);
+struct homa_peer
+	*homa_peer_alloc(struct homa_sock *hsk, const struct in6_addr *addr);
+struct homa_peertab
+	*homa_peer_alloc_peertab(void);
+int      homa_peer_dointvec(const struct ctl_table *table, int write,
+			    void *buffer, size_t *lenp, loff_t *ppos);
+void     homa_peer_free(struct rcu_head *head);
+void     homa_peer_free_net(struct homa_net *hnet);
+void     homa_peer_free_peertab(struct homa_peertab *peertab);
+void     homa_peer_gc(struct homa_peertab *peertab);
+struct homa_peer
+	*homa_peer_get(struct homa_sock *hsk, const struct in6_addr *addr);
+int      homa_peer_get_acks(struct homa_peer *peer, int count,
+			    struct homa_ack *dst);
+int      homa_peer_pick_victims(struct homa_peertab *peertab,
+				struct homa_peer *victims[], int max_victims);
+int      homa_peer_prefer_evict(struct homa_peertab *peertab,
+				struct homa_peer *peer1,
+				struct homa_peer *peer2);
+void     homa_peer_release_fn(void *object, void *dummy);
+int      homa_peer_reset_dst(struct homa_peer *peer, struct homa_sock *hsk);
+void     homa_peer_update_sysctl_deps(struct homa_peertab *peertab);
+
+/**
+ * homa_peer_lock() - Acquire the lock for a peer.
+ * @peer:    Peer to lock.
+ */
+static inline void homa_peer_lock(struct homa_peer *peer)
+	__acquires(peer->lock)
+{
+	spin_lock_bh(&peer->lock);
+}
+
+/**
+ * homa_peer_unlock() - Release the lock for a peer.
+ * @peer:   Peer to lock.
+ */
+static inline void homa_peer_unlock(struct homa_peer *peer)
+	__releases(peer->lock)
+{
+	spin_unlock_bh(&peer->lock);
+}
+
+/**
+ * homa_peer_hold() - Increment the reference count on an RPC, which will
+ * prevent it from being freed until homa_peer_release() is called.
+ * @peer:      Object on which to take a reference.
+ */
+static inline void homa_peer_hold(struct homa_peer *peer)
+{
+	refcount_inc(&peer->refs);
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
+	if (refcount_dec_and_test(&peer->refs))
+		call_rcu(&peer->rcu_head, homa_peer_free);
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
+	const struct homa_peer_key *key = arg->key;
+	const struct homa_peer *peer = obj;
+
+	return !(ipv6_addr_equal(&key->addr, &peer->ht_key.addr) &&
+		 peer->ht_key.hnet == key->hnet);
+}
+
+#endif /* _HOMA_PEER_H */
diff --git a/net/homa/murmurhash3.h b/net/homa/murmurhash3.h
new file mode 100644
index 000000000000..1ed1f0b67a93
--- /dev/null
+++ b/net/homa/murmurhash3.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: BSD-2-Clause or GPL-2.0+ */
+
+/* This file contains a limited implementation of MurmurHash3; it is
+ * used for rhashtables instead of the default jhash because it is
+ * faster (25 ns. vs. 40 ns as of May 2025)
+ */
+
+/**
+ * murmurhash3() - Hash function.
+ * @data:    Pointer to key for which a hash is desired.
+ * @len:     Length of the key; must be a multiple of 4.
+ * @seed:    Seed for the hash.
+ * Return:   A 32-bit hash value for the given key.
+ */
+static inline u32 murmurhash3(const void *data, u32 len, u32 seed)
+{
+	const u32 c1 = 0xcc9e2d51;
+	const u32 c2 = 0x1b873593;
+	const u32 *key = data;
+	u32 h = seed;
+
+	len = len >> 2;
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
+	/* Total number of input bytes */
+	h ^= len * 4;
+
+	h ^= h >> 16;
+	h *= 0x85ebca6b;
+	h ^= h >> 13;
+	h *= 0xc2b2ae35;
+	h ^= h >> 16;
+	return h;
+}
-- 
2.43.0


