Return-Path: <netdev+bounces-203619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35658AF688E
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 05:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B25B7B5014
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F8C22B8C5;
	Thu,  3 Jul 2025 03:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="K7ErUQQx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E20A226D02
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 03:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751512601; cv=none; b=LhATv7xAp23URd3zLnyimPPWInTeZYMadkq8wQWjcMPLVvPe16Kdj/tx1FMALWDzkB7xp/xwfsTvF2M9YEFwRfQpMynJxfNSGz3DyxW/Fmz0VuuJFocxAc7iHBgP9YOv4snAqnEjtoVc83QMUpVcxXbgsV/0atbGkXYc1Mo/WTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751512601; c=relaxed/simple;
	bh=Or9sueRtB8S4yZ843PJ1CY4OC7cqsUUZioAyVEQDqZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5PoeuFYYT7HbPJ8Pa1x/ILQW/poGiA18siUeQOtw9Gzxz1GaYE44mADrZgknR3xwdAB5JfAQb7c9/0o3Bys7syyAF0O+cobbfGuENCndt8kw7rsdCLRLre7kOw1RlGeKxtyDb/tjJCBKMJa+0+20Rj2/y+wsGgl3kKyyqCccWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=K7ErUQQx; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rbe7GE72MjhOA5AAUHNroH4b+IBMby1kEG60XQ39lxQ=; t=1751512598; x=1752376598; 
	b=K7ErUQQxU4VGS1pEA57eN/AW2lrmCw/Xq4smFs2NUphzOgjhiCjKAm4MwVkYtMGkl2kqEl6v+T/
	/T0+ayDaGBPpDraJkijQqfTwptH/BI/2k8mNeD0xRSp+2cxzUnvHFTciaaJzEVdjTlxGubiKPkYsj
	YZZFBhGTTYRvz+t8nN721qG41XlpBHV98mE0MEjZsZd4U+WR+MHZ+tSkscngA3BSfLMx0Ht3STNWj
	JRvdcWfvVxZLJ1f+B7r/kb3cang7+wsSSbqHyldRg08o2MFFCDYeSk8yemZ4PShvPUtGnkQvr22Ki
	9Kt8T0bD6E48V0UQ5jAM9f3xh6m9H7SL0ccA==;
Received: from 70-228-78-207.lightspeed.sntcca.sbcglobal.net ([70.228.78.207]:54972 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uXAR8-0006te-VA; Wed, 02 Jul 2025 20:16:38 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v10 09/15] net: homa: create homa_rpc.h and homa_rpc.c
Date: Wed,  2 Jul 2025 20:13:17 -0700
Message-ID: <20250703031445.569-10-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250703031445.569-1-ouster@cs.stanford.edu>
References: <20250703031445.569-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 1.7
X-Scan-Signature: a6df86540247d0b4a8d144746d3dceee

These files provide basic functions for managing remote procedure calls,
which are the fundamental entities managed by Homa. Each RPC consists
of a request message from a client to a server, followed by a response
message returned from the server to the client.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v10:
* Replace __u16 with u16, __u8 with u8, etc.
* Improve documentation
* Revise sparse annotations to eliminate __context__ definition
* Use kzalloc instead of __GFP_ZERO
* Fix issues from xmastree, sparse, etc.

Changes for v9:
* Eliminate reap.txt; move its contents into code as a comment
  in homa_rpc_reap
* Various name improvements (e.g. use "alloc" instead of "new" for functions
  that allocate memory)
* Add support for homa_net objects
* Use new homa_clock abstraction layer

Changes for v8:
* Updates to reflect pacer refactoring

Changes for v7:
* Implement accounting for bytes in tx skbs
* Fix potential races related to homa->active_rpcs
* Refactor waiting mechanism for incoming packets: simplify wait
  criteria and use standard Linux mechanisms for waiting
* Add reference counting for RPCs (homa_rpc_hold, homa_rpc_put)
* Remove locker argument from locking functions
* Rename homa_rpc_free to homa_rpc_end
* Use u64 and __u64 properly
* Use __skb_queue_purge instead of skb_queue_purge
* Use __GFP_ZERO in kmalloc calls
* Eliminate spurious RCU usage
---
 net/homa/homa_impl.h |   3 +
 net/homa/homa_rpc.c  | 638 +++++++++++++++++++++++++++++++++++++++++++
 net/homa/homa_rpc.h  | 485 ++++++++++++++++++++++++++++++++
 3 files changed, 1126 insertions(+)
 create mode 100644 net/homa/homa_rpc.c
 create mode 100644 net/homa/homa_rpc.h

diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
index 919aa2237bfa..6dd24383efa2 100644
--- a/net/homa/homa_impl.h
+++ b/net/homa/homa_impl.h
@@ -379,10 +379,13 @@ static inline bool homa_make_header_avl(struct sk_buff *skb)
 
 extern unsigned int homa_net_id;
 
+void     homa_rpc_handoff(struct homa_rpc *rpc);
 int      homa_xmit_control(enum homa_packet_type type, void *contents,
 			   size_t length, struct homa_rpc *rpc);
 void     homa_xmit_data(struct homa_rpc *rpc, bool force);
 
+int      homa_message_in_init(struct homa_rpc *rpc, int unsched);
+
 /**
  * homa_net_from_net() - Return the struct homa_net associated with a particular
  * struct net.
diff --git a/net/homa/homa_rpc.c b/net/homa/homa_rpc.c
new file mode 100644
index 000000000000..5328bca68086
--- /dev/null
+++ b/net/homa/homa_rpc.c
@@ -0,0 +1,638 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+/* This file contains functions for managing homa_rpc structs. */
+
+#include "homa_impl.h"
+#include "homa_interest.h"
+#include "homa_pacer.h"
+#include "homa_peer.h"
+#include "homa_pool.h"
+#include "homa_stub.h"
+
+/**
+ * homa_rpc_alloc_client() - Allocate and initialize a client RPC (one that
+ * is used to issue an outgoing request). Doesn't send any packets. Invoked
+ * with no locks held.
+ * @hsk:      Socket to which the RPC belongs.
+ * @dest:     Address of host (ip and port) to which the RPC will be sent.
+ *
+ * Return:    A printer to the newly allocated object, or a negative
+ *            errno if an error occurred. The RPC will be locked; the
+ *            caller must eventually unlock it.
+ */
+struct homa_rpc *homa_rpc_alloc_client(struct homa_sock *hsk,
+				       const union sockaddr_in_union *dest)
+	__cond_acquires(crpc->bucket->lock)
+{
+	struct in6_addr dest_addr_as_ipv6 = canonical_ipv6_addr(dest);
+	struct homa_rpc_bucket *bucket;
+	struct homa_rpc *crpc;
+	int err;
+
+	crpc = kzalloc(sizeof(*crpc), GFP_KERNEL);
+	if (unlikely(!crpc))
+		return ERR_PTR(-ENOMEM);
+
+	/* Initialize fields that don't require the socket lock. */
+	crpc->hsk = hsk;
+	crpc->id = atomic64_fetch_add(2, &hsk->homa->next_outgoing_id);
+	bucket = homa_client_rpc_bucket(hsk, crpc->id);
+	crpc->bucket = bucket;
+	crpc->state = RPC_OUTGOING;
+	crpc->peer = homa_peer_get(hsk, &dest_addr_as_ipv6);
+	if (IS_ERR(crpc->peer)) {
+		err = PTR_ERR(crpc->peer);
+		crpc->peer = NULL;
+		goto error;
+	}
+	crpc->dport = ntohs(dest->in6.sin6_port);
+	crpc->msgin.length = -1;
+	crpc->msgout.length = -1;
+	INIT_LIST_HEAD(&crpc->ready_links);
+	INIT_LIST_HEAD(&crpc->buf_links);
+	INIT_LIST_HEAD(&crpc->dead_links);
+	INIT_LIST_HEAD(&crpc->throttled_links);
+	crpc->resend_timer_ticks = hsk->homa->timer_ticks;
+	crpc->magic = HOMA_RPC_MAGIC;
+	crpc->start_time = homa_clock();
+
+	/* Initialize fields that require locking. This allows the most
+	 * expensive work, such as copying in the message from user space,
+	 * to be performed without holding locks. Also, can't hold spin
+	 * locks while doing things that could block, such as memory allocation.
+	 */
+	homa_bucket_lock(bucket, crpc->id);
+	homa_sock_lock(hsk);
+	if (hsk->shutdown) {
+		homa_sock_unlock(hsk);
+		homa_rpc_unlock(crpc);
+		err = -ESHUTDOWN;
+		goto error;
+	}
+	hlist_add_head(&crpc->hash_links, &bucket->rpcs);
+	rcu_read_lock();
+	list_add_tail_rcu(&crpc->active_links, &hsk->active_rpcs);
+	rcu_read_unlock();
+	homa_sock_unlock(hsk);
+
+	return crpc;
+
+error:
+	if (crpc->peer)
+		homa_peer_release(crpc->peer);
+	kfree(crpc);
+	return ERR_PTR(err);
+}
+
+/**
+ * homa_rpc_alloc_server() - Allocate and initialize a server RPC (one that is
+ * used to manage an incoming request). If appropriate, the RPC will also
+ * be handed off (we do it here, while we have the socket locked, to avoid
+ * acquiring the socket lock a second time later for the handoff).
+ * @hsk:      Socket that owns this RPC.
+ * @source:   IP address (network byte order) of the RPC's client.
+ * @h:        Header for the first data packet received for this RPC; used
+ *            to initialize the RPC.
+ * @created:  Will be set to 1 if a new RPC was created and 0 if an
+ *            existing RPC was found.
+ *
+ * Return:  A pointer to a new RPC, which is locked, or a negative errno
+ *          if an error occurred. If there is already an RPC corresponding
+ *          to h, then it is returned instead of creating a new RPC.
+ */
+struct homa_rpc *homa_rpc_alloc_server(struct homa_sock *hsk,
+				       const struct in6_addr *source,
+				       struct homa_data_hdr *h, int *created)
+	__cond_acquires(srpc->bucket->lock)
+{
+	u64 id = homa_local_id(h->common.sender_id);
+	struct homa_rpc_bucket *bucket;
+	struct homa_rpc *srpc = NULL;
+	int err;
+
+	if (!hsk->buffer_pool)
+		return ERR_PTR(-ENOMEM);
+
+	/* Lock the bucket, and make sure no-one else has already created
+	 * the desired RPC.
+	 */
+	bucket = homa_server_rpc_bucket(hsk, id);
+	homa_bucket_lock(bucket, id);
+	hlist_for_each_entry(srpc, &bucket->rpcs, hash_links) {
+		if (srpc->id == id &&
+		    srpc->dport == ntohs(h->common.sport) &&
+		    ipv6_addr_equal(&srpc->peer->addr, source)) {
+			/* RPC already exists; just return it instead
+			 * of creating a new RPC.
+			 */
+			*created = 0;
+			return srpc;
+		}
+	}
+
+	/* Initialize fields that don't require the socket lock. */
+	srpc = kzalloc(sizeof(*srpc), GFP_ATOMIC);
+	if (!srpc) {
+		err = -ENOMEM;
+		goto error;
+	}
+	srpc->hsk = hsk;
+	srpc->bucket = bucket;
+	srpc->state = RPC_INCOMING;
+	srpc->peer = homa_peer_get(hsk, source);
+	if (IS_ERR(srpc->peer)) {
+		err = PTR_ERR(srpc->peer);
+		srpc->peer = NULL;
+		goto error;
+	}
+	srpc->dport = ntohs(h->common.sport);
+	srpc->id = id;
+	srpc->msgin.length = -1;
+	srpc->msgout.length = -1;
+	INIT_LIST_HEAD(&srpc->ready_links);
+	INIT_LIST_HEAD(&srpc->buf_links);
+	INIT_LIST_HEAD(&srpc->dead_links);
+	INIT_LIST_HEAD(&srpc->throttled_links);
+	srpc->resend_timer_ticks = hsk->homa->timer_ticks;
+	srpc->magic = HOMA_RPC_MAGIC;
+	srpc->start_time = homa_clock();
+	err = homa_message_in_init(srpc, ntohl(h->message_length));
+	if (err != 0)
+		goto error;
+
+	/* Initialize fields that require socket to be locked. */
+	homa_sock_lock(hsk);
+	if (hsk->shutdown) {
+		homa_sock_unlock(hsk);
+		err = -ESHUTDOWN;
+		goto error;
+	}
+	hlist_add_head(&srpc->hash_links, &bucket->rpcs);
+	list_add_tail_rcu(&srpc->active_links, &hsk->active_rpcs);
+	homa_sock_unlock(hsk);
+	if (ntohl(h->seg.offset) == 0 && srpc->msgin.num_bpages > 0) {
+		atomic_or(RPC_PKTS_READY, &srpc->flags);
+		homa_rpc_handoff(srpc);
+	}
+	*created = 1;
+	return srpc;
+
+error:
+	homa_bucket_unlock(bucket, id);
+	if (srpc && srpc->peer)
+		homa_peer_release(srpc->peer);
+	kfree(srpc);
+	return ERR_PTR(err);
+}
+
+/**
+ * homa_rpc_acked() - This function is invoked when an ack is received
+ * for an RPC; if the RPC still exists, is freed.
+ * @hsk:     Socket on which the ack was received. May or may not correspond
+ *           to the RPC, but can sometimes be used to avoid a socket lookup.
+ * @saddr:   Source address from which the act was received (the client
+ *           note for the RPC)
+ * @ack:     Information about an RPC from @saddr that may now be deleted
+ *           safely.
+ */
+void homa_rpc_acked(struct homa_sock *hsk, const struct in6_addr *saddr,
+		    struct homa_ack *ack)
+{
+	u16 server_port = ntohs(ack->server_port);
+	u64 id = homa_local_id(ack->client_id);
+	struct homa_sock *hsk2 = hsk;
+	struct homa_rpc *rpc;
+
+	if (hsk->port != server_port) {
+		/* Without RCU, sockets other than hsk can be deleted
+		 * out from under us.
+		 */
+		hsk2 = homa_sock_find(hsk->hnet, server_port);
+		if (!hsk2)
+			return;
+	}
+	rpc = homa_rpc_find_server(hsk2, saddr, id);
+	if (rpc) {
+		homa_rpc_end(rpc);
+		homa_rpc_unlock(rpc); /* Locked by homa_rpc_find_server. */
+	}
+	if (hsk->port != server_port)
+		sock_put(&hsk2->sock);
+}
+
+/**
+ * homa_rpc_end() - Stop all activity on an RPC and begin the process of
+ * releasing its resources; this process will continue in the background
+ * until homa_rpc_reap eventually completes it.
+ * @rpc:  Structure to clean up, or NULL. Must be locked. Its socket must
+ *        not be locked. Once this function returns the caller should not
+ *        use the RPC except to unlock it.
+ */
+void homa_rpc_end(struct homa_rpc *rpc)
+	__must_hold(rpc->bucket->lock)
+{
+	/* The goal for this function is to make the RPC inaccessible,
+	 * so that no other code will ever access it again. However, don't
+	 * actually release resources or tear down the internal structure
+	 * of the RPC; leave that to homa_rpc_reap, which runs later. There
+	 * are two reasons for this. First, releasing resources may be
+	 * expensive, so we don't want to keep the caller waiting; homa_rpc_reap
+	 * will run in situations where there is time to spare. Second, there
+	 * may be other code that currently has pointers to this RPC but
+	 * temporarily released the lock (e.g. to copy data to/from user space).
+	 * It isn't safe to clean up until that code has finished its work and
+	 * released any pointers to the RPC (homa_rpc_reap will ensure that
+	 * this has happened). So, this function should only make changes
+	 * needed to make the RPC inaccessible.
+	 */
+	if (!rpc || rpc->state == RPC_DEAD)
+		return;
+	rpc->state = RPC_DEAD;
+	rpc->error = -EINVAL;
+
+	/* Unlink from all lists, so no-one will ever find this RPC again. */
+	homa_sock_lock(rpc->hsk);
+	__hlist_del(&rpc->hash_links);
+	list_del_rcu(&rpc->active_links);
+	list_add_tail(&rpc->dead_links, &rpc->hsk->dead_rpcs);
+	__list_del_entry(&rpc->ready_links);
+	__list_del_entry(&rpc->buf_links);
+	homa_interest_notify_private(rpc);
+
+	if (rpc->msgin.length >= 0) {
+		rpc->hsk->dead_skbs += skb_queue_len(&rpc->msgin.packets);
+		while (1) {
+			struct homa_gap *gap;
+
+			gap = list_first_entry_or_null(&rpc->msgin.gaps,
+						       struct homa_gap, links);
+			if (!gap)
+				break;
+			list_del(&gap->links);
+			kfree(gap);
+		}
+	}
+	rpc->hsk->dead_skbs += rpc->msgout.num_skbs;
+	if (rpc->hsk->dead_skbs > rpc->hsk->homa->max_dead_buffs)
+		/* This update isn't thread-safe; it's just a
+		 * statistic so it's OK if updates occasionally get
+		 * missed.
+		 */
+		rpc->hsk->homa->max_dead_buffs = rpc->hsk->dead_skbs;
+
+	homa_sock_unlock(rpc->hsk);
+	homa_pacer_unmanage_rpc(rpc);
+}
+
+/**
+ * homa_rpc_abort() - Terminate an RPC.
+ * @rpc:     RPC to be terminated.  Must be locked by caller.
+ * @error:   A negative errno value indicating the error that caused the abort.
+ *           If this is a client RPC, the error will be returned to the
+ *           application; if it's a server RPC, the error is ignored and
+ *           we just free the RPC.
+ */
+void homa_rpc_abort(struct homa_rpc *rpc, int error)
+	__must_hold(rpc->bucket->lock)
+{
+	if (!homa_is_client(rpc->id)) {
+		homa_rpc_end(rpc);
+		return;
+	}
+	rpc->error = error;
+	homa_rpc_handoff(rpc);
+}
+
+/**
+ * homa_abort_rpcs() - Abort all RPCs to/from a particular peer.
+ * @homa:    Overall data about the Homa protocol implementation.
+ * @addr:    Address (network order) of the destination whose RPCs are
+ *           to be aborted.
+ * @port:    If nonzero, then RPCs will only be aborted if they were
+ *	     targeted at this server port.
+ * @error:   Negative errno value indicating the reason for the abort.
+ */
+void homa_abort_rpcs(struct homa *homa, const struct in6_addr *addr,
+		     int port, int error)
+{
+	struct homa_socktab_scan scan;
+	struct homa_sock *hsk;
+	struct homa_rpc *rpc;
+
+	for (hsk = homa_socktab_start_scan(homa->socktab, &scan); hsk;
+	     hsk = homa_socktab_next(&scan)) {
+		/* Skip the (expensive) lock acquisition if there's no
+		 * work to do.
+		 */
+		if (list_empty(&hsk->active_rpcs))
+			continue;
+		if (!homa_protect_rpcs(hsk))
+			continue;
+		rcu_read_lock();
+		list_for_each_entry_rcu(rpc, &hsk->active_rpcs, active_links) {
+			if (!ipv6_addr_equal(&rpc->peer->addr, addr))
+				continue;
+			if (port && rpc->dport != port)
+				continue;
+			homa_rpc_lock(rpc);
+			homa_rpc_abort(rpc, error);
+			homa_rpc_unlock(rpc);
+		}
+		rcu_read_unlock();
+		homa_unprotect_rpcs(hsk);
+	}
+	homa_socktab_end_scan(&scan);
+}
+
+/**
+ * homa_rpc_reap() - Invoked to release resources associated with dead
+ * RPCs for a given socket.
+ * @hsk:      Homa socket that may contain dead RPCs. Must not be locked by the
+ *            caller; this function will lock and release.
+ * @reap_all: False means do a small chunk of work; there may still be
+ *            unreaped RPCs on return. True means reap all dead RPCs for
+ *            hsk.  Will busy-wait if reaping has been disabled for some RPCs.
+ *
+ * Return: A return value of 0 means that we ran out of work to do; calling
+ *         again will do no work (there could be unreaped RPCs, but if so,
+ *         they cannot currently be reaped).  A value greater than zero means
+ *         there is still more reaping work to be done.
+ */
+int homa_rpc_reap(struct homa_sock *hsk, bool reap_all)
+{
+	/* RPC Reaping Strategy:
+	 *
+	 * (Note: there are references to this comment elsewhere in the
+	 * Homa code)
+	 *
+	 * Most of the cost of reaping comes from freeing sk_buffs; this can be
+	 * quite expensive for RPCs with long messages.
+	 *
+	 * The natural time to reap is when homa_rpc_end is invoked to
+	 * terminate an RPC, but this doesn't work for two reasons. First,
+	 * there may be outstanding references to the RPC; it cannot be reaped
+	 * until all of those references have been released. Second, reaping
+	 * is potentially expensive and RPC termination could occur in
+	 * homa_softirq when there are short messages waiting to be processed.
+	 * Taking time to reap a long RPC could result in significant delays
+	 * for subsequent short RPCs.
+	 *
+	 * Thus Homa doesn't reap immediately in homa_rpc_end. Instead, dead
+	 * RPCs are queued up and reaping occurs in this function, which is
+	 * invoked later when it is less likely to impact latency. The
+	 * challenge is to do this so that (a) we don't allow large numbers of
+	 * dead RPCs to accumulate and (b) we minimize the impact of reaping
+	 * on latency.
+	 *
+	 * The primary place where homa_rpc_reap is invoked is when threads
+	 * are waiting for incoming messages. The thread has nothing else to
+	 * do (it may even be polling for input), so reaping can be performed
+	 * with no latency impact on the application.  However, if a machine
+	 * is overloaded then it may never wait, so this mechanism isn't always
+	 * sufficient.
+	 *
+	 * Homa now reaps in two other places, if reaping while waiting for
+	 * messages isn't adequate:
+	 * 1. If too may dead skbs accumulate, then homa_timer will call
+	 *    homa_rpc_reap.
+	 * 2. If this timer thread cannot keep up with all the reaping to be
+	 *    done then as a last resort homa_dispatch_pkts will reap in small
+	 *    increments (a few sk_buffs or RPCs) for every incoming batch
+	 *    of packets . This is undesirable because it will impact Homa's
+	 *    performance.
+	 *
+	 * During the introduction of homa_pools for managing input
+	 * buffers, freeing of packets for incoming messages was moved to
+	 * homa_copy_to_user under the assumption that this code wouldn't be
+	 * on the critical path. However, there is evidence that with
+	 * fast networks (e.g. 100 Gbps) copying to user space is the
+	 * bottleneck for incoming messages, and packet freeing takes about
+	 * 20-25% of the total time in homa_copy_to_user. So, it may eventually
+	 * be desirable to remove packet freeing out of homa_copy_to_user.
+	 */
+#define BATCH_MAX 20
+	struct homa_rpc *rpcs[BATCH_MAX];
+	struct sk_buff *skbs[BATCH_MAX];
+	int num_skbs, num_rpcs;
+	struct homa_rpc *rpc;
+	struct homa_rpc *tmp;
+	int i, batch_size;
+	int skbs_to_reap;
+	int result = 0;
+	int rx_frees;
+
+	/* Each iteration through the following loop will reap
+	 * BATCH_MAX skbs.
+	 */
+	skbs_to_reap = hsk->homa->reap_limit;
+	while (skbs_to_reap > 0 && !list_empty(&hsk->dead_rpcs)) {
+		batch_size = BATCH_MAX;
+		if (!reap_all) {
+			if (batch_size > skbs_to_reap)
+				batch_size = skbs_to_reap;
+			skbs_to_reap -= batch_size;
+		}
+		num_skbs = 0;
+		num_rpcs = 0;
+		rx_frees = 0;
+
+		homa_sock_lock(hsk);
+		if (atomic_read(&hsk->protect_count)) {
+			homa_sock_unlock(hsk);
+			if (reap_all)
+				continue;
+			return 0;
+		}
+
+		/* Collect buffers and freeable RPCs. */
+		list_for_each_entry_safe(rpc, tmp, &hsk->dead_rpcs,
+					 dead_links) {
+			int refs;
+
+			/* Make sure that all outstanding uses of the RPC have
+			 * completed. We can only be sure if the reference
+			 * count is zero when we're holding the lock. Note:
+			 * it isn't safe to block while locking the RPC here,
+			 * since we hold the socket lock.
+			 */
+			if (homa_rpc_try_lock(rpc)) {
+				refs = atomic_read(&rpc->refs);
+				homa_rpc_unlock(rpc);
+			} else {
+				refs = 1;
+			}
+			if (refs != 0)
+				continue;
+			rpc->magic = 0;
+
+			/* For Tx sk_buffs, collect them here but defer
+			 * freeing until after releasing the socket lock.
+			 */
+			if (rpc->msgout.length >= 0) {
+				while (rpc->msgout.packets) {
+					skbs[num_skbs] = rpc->msgout.packets;
+					rpc->msgout.packets = homa_get_skb_info(
+						rpc->msgout.packets)->next_skb;
+					num_skbs++;
+					rpc->msgout.num_skbs--;
+					if (num_skbs >= batch_size)
+						goto release;
+				}
+			}
+
+			/* In the normal case rx sk_buffs will already have been
+			 * freed before we got here. Thus it's OK to free
+			 * immediately in rare situations where there are
+			 * buffers left.
+			 */
+			if (rpc->msgin.length >= 0 &&
+			    !skb_queue_empty_lockless(&rpc->msgin.packets)) {
+				rx_frees += skb_queue_len(&rpc->msgin.packets);
+				__skb_queue_purge(&rpc->msgin.packets);
+			}
+
+			/* If we get here, it means all packets have been
+			 *  removed from the RPC.
+			 */
+			rpcs[num_rpcs] = rpc;
+			num_rpcs++;
+			list_del(&rpc->dead_links);
+			WARN_ON(refcount_sub_and_test(rpc->msgout.skb_memory,
+						      &hsk->sock.sk_wmem_alloc));
+			if (num_rpcs >= batch_size)
+				goto release;
+		}
+
+		/* Free all of the collected resources; release the socket
+		 * lock while doing this.
+		 */
+release:
+		hsk->dead_skbs -= num_skbs + rx_frees;
+		result = !list_empty(&hsk->dead_rpcs) &&
+				(num_skbs + num_rpcs) != 0;
+		homa_sock_unlock(hsk);
+		homa_skb_free_many_tx(hsk->homa, skbs, num_skbs);
+		for (i = 0; i < num_rpcs; i++) {
+			rpc = rpcs[i];
+
+			if (unlikely(rpc->msgin.num_bpages))
+				homa_pool_release_buffers(rpc->hsk->buffer_pool,
+							  rpc->msgin.num_bpages,
+							  rpc->msgin.bpage_offsets);
+			if (rpc->msgin.length >= 0) {
+				while (1) {
+					struct homa_gap *gap;
+
+					gap = list_first_entry_or_null(
+							&rpc->msgin.gaps,
+							struct homa_gap,
+							links);
+					if (!gap)
+						break;
+					list_del(&gap->links);
+					kfree(gap);
+				}
+			}
+			if (rpc->peer) {
+				homa_peer_release(rpc->peer);
+				rpc->peer = NULL;
+			}
+			rpc->state = 0;
+			kfree(rpc);
+		}
+		homa_sock_wakeup_wmem(hsk);
+		if (!result && !reap_all)
+			break;
+	}
+	homa_pool_check_waiting(hsk->buffer_pool);
+	return result;
+}
+
+/**
+ * homa_abort_sock_rpcs() - Abort all outgoing (client-side) RPCs on a given
+ * socket.
+ * @hsk:         Socket whose RPCs should be aborted.
+ * @error:       Zero means that the aborted RPCs should be freed immediately.
+ *               A nonzero value means that the RPCs should be marked
+ *               complete, so that they can be returned to the application;
+ *               this value (a negative errno) will be returned from
+ *               recvmsg.
+ */
+void homa_abort_sock_rpcs(struct homa_sock *hsk, int error)
+{
+	struct homa_rpc *rpc;
+
+	if (list_empty(&hsk->active_rpcs))
+		return;
+	if (!homa_protect_rpcs(hsk))
+		return;
+	rcu_read_lock();
+	list_for_each_entry_rcu(rpc, &hsk->active_rpcs, active_links) {
+		if (!homa_is_client(rpc->id))
+			continue;
+		homa_rpc_lock(rpc);
+		if (rpc->state == RPC_DEAD) {
+			homa_rpc_unlock(rpc);
+			continue;
+		}
+		if (error)
+			homa_rpc_abort(rpc, error);
+		else
+			homa_rpc_end(rpc);
+		homa_rpc_unlock(rpc);
+	}
+	rcu_read_unlock();
+	homa_unprotect_rpcs(hsk);
+}
+
+/**
+ * homa_rpc_find_client() - Locate client-side information about the RPC that
+ * a packet belongs to, if there is any. Thread-safe without socket lock.
+ * @hsk:      Socket via which packet was received.
+ * @id:       Unique identifier for the RPC.
+ *
+ * Return:    A pointer to the homa_rpc for this id, or NULL if none.
+ *            The RPC will be locked; the caller must eventually unlock it
+ *            by invoking homa_rpc_unlock.
+ */
+struct homa_rpc *homa_rpc_find_client(struct homa_sock *hsk, u64 id)
+	__cond_acquires(crpc->bucket->lock)
+{
+	struct homa_rpc_bucket *bucket = homa_client_rpc_bucket(hsk, id);
+	struct homa_rpc *crpc;
+
+	homa_bucket_lock(bucket, id);
+	hlist_for_each_entry(crpc, &bucket->rpcs, hash_links) {
+		if (crpc->id == id)
+			return crpc;
+	}
+	homa_bucket_unlock(bucket, id);
+	return NULL;
+}
+
+/**
+ * homa_rpc_find_server() - Locate server-side information about the RPC that
+ * a packet belongs to, if there is any. Thread-safe without socket lock.
+ * @hsk:      Socket via which packet was received.
+ * @saddr:    Address from which the packet was sent.
+ * @id:       Unique identifier for the RPC (must have server bit set).
+ *
+ * Return:    A pointer to the homa_rpc matching the arguments, or NULL
+ *            if none. The RPC will be locked; the caller must eventually
+ *            unlock it by invoking homa_rpc_unlock.
+ */
+struct homa_rpc *homa_rpc_find_server(struct homa_sock *hsk,
+				      const struct in6_addr *saddr, u64 id)
+	__cond_acquires(srpc->bucket->lock)
+{
+	struct homa_rpc_bucket *bucket = homa_server_rpc_bucket(hsk, id);
+	struct homa_rpc *srpc;
+
+	homa_bucket_lock(bucket, id);
+	hlist_for_each_entry(srpc, &bucket->rpcs, hash_links) {
+		if (srpc->id == id && ipv6_addr_equal(&srpc->peer->addr, saddr))
+			return srpc;
+	}
+	homa_bucket_unlock(bucket, id);
+	return NULL;
+}
diff --git a/net/homa/homa_rpc.h b/net/homa/homa_rpc.h
new file mode 100644
index 000000000000..c389986fb152
--- /dev/null
+++ b/net/homa/homa_rpc.h
@@ -0,0 +1,485 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+
+/* This file defines homa_rpc and related structs.  */
+
+#ifndef _HOMA_RPC_H
+#define _HOMA_RPC_H
+
+#include <linux/percpu-defs.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+
+#include "homa_sock.h"
+#include "homa_wire.h"
+
+/* Forward references. */
+struct homa_ack;
+
+/**
+ * struct homa_message_out - Describes a message (either request or response)
+ * for which this machine is the sender.
+ */
+struct homa_message_out {
+	/**
+	 * @length: Total bytes in message (excluding headers).  A value
+	 * less than 0 means this structure is uninitialized and therefore
+	 * not in use (all other fields will be zero in this case).
+	 */
+	int length;
+
+	/** @num_skbs: Total number of buffers currently in @packets. */
+	int num_skbs;
+
+	/**
+	 * @skb_memory: Total number of bytes of memory occupied by
+	 * the sk_buffs for this message.
+	 */
+	int skb_memory;
+
+	/**
+	 * @copied_from_user: Number of bytes of the message that have
+	 * been copied from user space into skbs in @packets.
+	 */
+	int copied_from_user;
+
+	/**
+	 * @packets: Singly-linked list of all packets in message, linked
+	 * using homa_next_skb. The list is in order of offset in the message
+	 * (offset 0 first); each sk_buff can potentially contain multiple
+	 * data_segments, which will be split into separate packets by GSO.
+	 * This list grows gradually as data is copied in from user space,
+	 * so it may not be complete.
+	 */
+	struct sk_buff *packets;
+
+	/**
+	 * @next_xmit: Pointer to pointer to next packet to transmit (will
+	 * either refer to @packets or homa_next_skb(skb) for some skb
+	 * in @packets).
+	 */
+	struct sk_buff **next_xmit;
+
+	/**
+	 * @next_xmit_offset: All bytes in the message, up to but not
+	 * including this one, have been transmitted.
+	 */
+	int next_xmit_offset;
+
+	/**
+	 * @init_time: homa_clock() time when this structure was initialized.
+	 * Used to find the oldest outgoing message.
+	 */
+	u64 init_time;
+};
+
+/**
+ * struct homa_gap - Represents a range of bytes within a message that have
+ * not yet been received.
+ */
+struct homa_gap {
+	/** @start: offset of first byte in this gap. */
+	int start;
+
+	/** @end: offset of byte just after last one in this gap. */
+	int end;
+
+	/**
+	 * @time: homa_clock() time when the gap was first detected.
+	 * As of 7/2024 this isn't used for anything.
+	 */
+	u64 time;
+
+	/** @links: for linking into list in homa_message_in. */
+	struct list_head links;
+};
+
+/**
+ * struct homa_message_in - Holds the state of a message received by
+ * this machine; used for both requests and responses.
+ */
+struct homa_message_in {
+	/**
+	 * @length: Payload size in bytes. A value less than 0 means this
+	 * structure is uninitialized and therefore not in use.
+	 */
+	int length;
+
+	/**
+	 * @packets: DATA packets for this message that have been received but
+	 * not yet copied to user space (no particular order).
+	 */
+	struct sk_buff_head packets;
+
+	/**
+	 * @recv_end: Offset of the byte just after the highest one that
+	 * has been received so far.
+	 */
+	int recv_end;
+
+	/**
+	 * @gaps: List of homa_gaps describing all of the bytes with
+	 * offsets less than @recv_end that have not yet been received.
+	 */
+	struct list_head gaps;
+
+	/**
+	 * @bytes_remaining: Amount of data for this message that has
+	 * not yet been received; will determine the message's priority.
+	 */
+	int bytes_remaining;
+
+	/**
+	 * @num_bpages: The number of entries in @bpage_offsets used for this
+	 * message (0 means buffers not allocated yet).
+	 */
+	u32 num_bpages;
+
+	/**
+	 * @bpage_offsets: Describes buffer space allocated for this message.
+	 * Each entry is an offset from the start of the buffer region.
+	 * All but the last pointer refer to areas of size HOMA_BPAGE_SIZE.
+	 */
+	u32 bpage_offsets[HOMA_MAX_BPAGES];
+
+};
+
+/**
+ * struct homa_rpc - One of these structures exists for each active
+ * RPC. The same structure is used to manage both outgoing RPCs on
+ * clients and incoming RPCs on servers.
+ */
+struct homa_rpc {
+	/** @hsk:  Socket that owns the RPC. */
+	struct homa_sock *hsk;
+
+	/**
+	 * @bucket: Pointer to the bucket in hsk->client_rpc_buckets or
+	 * hsk->server_rpc_buckets where this RPC is linked. Used primarily
+	 * for locking the RPC (which is done by locking its bucket).
+	 */
+	struct homa_rpc_bucket *bucket;
+
+	/**
+	 * @state: The current state of this RPC:
+	 *
+	 * @RPC_OUTGOING:     The RPC is waiting for @msgout to be transmitted
+	 *                    to the peer.
+	 * @RPC_INCOMING:     The RPC is waiting for data @msgin to be received
+	 *                    from the peer; at least one packet has already
+	 *                    been received.
+	 * @RPC_IN_SERVICE:   Used only for server RPCs: the request message
+	 *                    has been read from the socket, but the response
+	 *                    message has not yet been presented to the kernel.
+	 * @RPC_DEAD:         RPC has been deleted and is waiting to be
+	 *                    reaped. In some cases, information in the RPC
+	 *                    structure may be accessed in this state.
+	 *
+	 * Client RPCs pass through states in the following order:
+	 * RPC_OUTGOING, RPC_INCOMING, RPC_DEAD.
+	 *
+	 * Server RPCs pass through states in the following order:
+	 * RPC_INCOMING, RPC_IN_SERVICE, RPC_OUTGOING, RPC_DEAD.
+	 */
+	enum {
+		RPC_OUTGOING            = 5,
+		RPC_INCOMING            = 6,
+		RPC_IN_SERVICE          = 8,
+		RPC_DEAD                = 9
+	} state;
+
+	/**
+	 * @flags: Additional state information: an OR'ed combination of
+	 * various single-bit flags. See below for definitions. Must be
+	 * manipulated with atomic operations because some of the manipulations
+	 * occur without holding the RPC lock.
+	 */
+	atomic_t flags;
+
+	/* Valid bits for @flags:
+	 * RPC_PKTS_READY -        The RPC has input packets ready to be
+	 *                         copied to user space.
+	 * APP_NEEDS_LOCK -        Means that code in the application thread
+	 *                         needs the RPC lock (e.g. so it can start
+	 *                         copying data to user space) so others
+	 *                         (e.g. SoftIRQ processing) should relinquish
+	 *                         the lock ASAP. Without this, SoftIRQ can
+	 *                         lock out the application for a long time,
+	 *                         preventing data copies to user space from
+	 *                         starting (and they limit throughput at
+	 *                         high network speeds).
+	 * RPC_PRIVATE -           This RPC will be waited on in "private" mode,
+	 *                         where the app explicitly requests the
+	 *                         response from this particular RPC.
+	 */
+#define RPC_PKTS_READY        1
+#define APP_NEEDS_LOCK        4
+#define RPC_PRIVATE           8
+
+	/**
+	 * @refs: Number of unmatched calls to homa_rpc_hold; it's not safe
+	 * to free the RPC until this is zero.
+	 */
+	atomic_t refs;
+
+	/**
+	 * @peer: Information about the other machine (the server, if
+	 * this is a client RPC, or the client, if this is a server RPC).
+	 * If non-NULL then we own a reference on the object.
+	 */
+	struct homa_peer *peer;
+
+	/** @dport: Port number on @peer that will handle packets. */
+	u16 dport;
+
+	/**
+	 * @id: Unique identifier for the RPC among all those issued
+	 * from its port. The low-order bit indicates whether we are
+	 * server (1) or client (0) for this RPC.
+	 */
+	u64 id;
+
+	/**
+	 * @completion_cookie: Only used on clients. Contains identifying
+	 * information about the RPC provided by the application; returned to
+	 * the application with the RPC's result.
+	 */
+	u64 completion_cookie;
+
+	/**
+	 * @error: Only used on clients. If nonzero, then the RPC has
+	 * failed and the value is a negative errno that describes the
+	 * problem.
+	 */
+	int error;
+
+	/**
+	 * @msgin: Information about the message we receive for this RPC
+	 * (for server RPCs this is the request, for client RPCs this is the
+	 * response).
+	 */
+	struct homa_message_in msgin;
+
+	/**
+	 * @msgout: Information about the message we send for this RPC
+	 * (for client RPCs this is the request, for server RPCs this is the
+	 * response).
+	 */
+	struct homa_message_out msgout;
+
+	/**
+	 * @hash_links: Used to link this object into a hash bucket for
+	 * either @hsk->client_rpc_buckets (for a client RPC), or
+	 * @hsk->server_rpc_buckets (for a server RPC).
+	 */
+	struct hlist_node hash_links;
+
+	/**
+	 * @ready_links: Used to link this object into @hsk->ready_rpcs.
+	 */
+	struct list_head ready_links;
+
+	/**
+	 * @buf_links: Used to link this RPC into @hsk->waiting_for_bufs.
+	 * If the RPC isn't on @hsk->waiting_for_bufs, this is an empty
+	 * list pointing to itself.
+	 */
+	struct list_head buf_links;
+
+	/**
+	 * @active_links: For linking this object into @hsk->active_rpcs.
+	 * The next field will be LIST_POISON1 if this RPC hasn't yet been
+	 * linked into @hsk->active_rpcs. Access with RCU.
+	 */
+	struct list_head active_links;
+
+	/** @dead_links: For linking this object into @hsk->dead_rpcs. */
+	struct list_head dead_links;
+
+	/**
+	 * @private_interest: If there is a thread waiting for this RPC in
+	 * homa_wait_private, then this points to that thread's interest.
+	 */
+	struct homa_interest *private_interest;
+
+	/**
+	 * @throttled_links: Used to link this RPC into
+	 * homa->pacer.throttled_rpcs. If this RPC isn't in
+	 * homa->pacer.throttled_rpcs, this is an empty
+	 * list pointing to itself.
+	 */
+	struct list_head throttled_links;
+
+	/**
+	 * @silent_ticks: Number of times homa_timer has been invoked
+	 * since the last time a packet indicating progress was received
+	 * for this RPC, so we don't need to send a resend for a while.
+	 */
+	int silent_ticks;
+
+	/**
+	 * @resend_timer_ticks: Value of homa->timer_ticks the last time
+	 * we sent a RESEND for this RPC.
+	 */
+	u32 resend_timer_ticks;
+
+	/**
+	 * @done_timer_ticks: The value of homa->timer_ticks the first
+	 * time we noticed that this (server) RPC is done (all response
+	 * packets have been transmitted), so we're ready for an ack.
+	 * Zero means we haven't reached that point yet.
+	 */
+	u32 done_timer_ticks;
+
+	/**
+	 * @magic: when the RPC is alive, this holds a distinct value that
+	 * is unlikely to occur naturally. The value is cleared when the
+	 * RPC is reaped, so we can detect accidental use of an RPC after
+	 * it has been reaped.
+	 */
+#define HOMA_RPC_MAGIC 0xdeadbeef
+	int magic;
+
+	/**
+	 * @start_time: homa_clock() time when this RPC was created. Used
+	 * occasionally for testing.
+	 */
+	u64 start_time;
+};
+
+void     homa_abort_rpcs(struct homa *homa, const struct in6_addr *addr,
+			 int port, int error);
+void     homa_abort_sock_rpcs(struct homa_sock *hsk, int error);
+void     homa_rpc_abort(struct homa_rpc *crpc, int error);
+struct homa_rpc
+	*homa_rpc_alloc_client(struct homa_sock *hsk,
+			       const union sockaddr_in_union *dest);
+struct homa_rpc
+	*homa_rpc_alloc_server(struct homa_sock *hsk,
+			       const struct in6_addr *source,
+			       struct homa_data_hdr *h, int *created);
+void     homa_rpc_end(struct homa_rpc *rpc);
+struct homa_rpc
+	*homa_rpc_find_client(struct homa_sock *hsk, u64 id);
+struct homa_rpc
+	*homa_rpc_find_server(struct homa_sock *hsk,
+			      const struct in6_addr *saddr, u64 id);
+void     homa_rpc_acked(struct homa_sock *hsk, const struct in6_addr *saddr,
+			struct homa_ack *ack);
+void     homa_rpc_end(struct homa_rpc *rpc);
+int      homa_rpc_reap(struct homa_sock *hsk, bool reap_all);
+
+/**
+ * homa_rpc_lock() - Acquire the lock for an RPC.
+ * @rpc:    RPC to lock.
+ */
+static inline void homa_rpc_lock(struct homa_rpc *rpc)
+	__acquires(rpc->bucket->lock)
+{
+	homa_bucket_lock(rpc->bucket, rpc->id);
+}
+
+/**
+ * homa_rpc_try_lock() - Acquire the lock for an RPC if it is available.
+ * @rpc:       RPC to lock.
+ * Return:     Nonzero if lock was successfully acquired, zero if it is
+ *             currently owned by someone else.
+ */
+static inline int homa_rpc_try_lock(struct homa_rpc *rpc)
+	__cond_acquires(rpc->bucket->lock)
+{
+	if (!spin_trylock_bh(&rpc->bucket->lock))
+		return 0;
+	return 1;
+}
+
+/**
+ * homa_rpc_unlock() - Release the lock for an RPC.
+ * @rpc:   RPC to unlock.
+ */
+static inline void homa_rpc_unlock(struct homa_rpc *rpc)
+	__releases(rpc->bucket->lock)
+{
+	homa_bucket_unlock(rpc->bucket, rpc->id);
+}
+
+/**
+ * homa_protect_rpcs() - Ensures that no RPCs will be reaped for a given
+ * socket until homa_sock_unprotect is called. Typically used by functions
+ * that want to scan the active RPCs for a socket without holding the socket
+ * lock.  Multiple calls to this function may be in effect at once. See
+ * "Homa Locking Strategy" in homa_impl.h for more info on why this function
+ * is needed.
+ * @hsk:    Socket whose RPCs should be protected. Must not be locked
+ *          by the caller; will be locked here.
+ *
+ * Return:  1 for success, 0 if the socket has been shutdown, in which
+ *          case its RPCs cannot be protected.
+ */
+static inline int homa_protect_rpcs(struct homa_sock *hsk)
+{
+	int result;
+
+	homa_sock_lock(hsk);
+	result = !hsk->shutdown;
+	if (result)
+		atomic_inc(&hsk->protect_count);
+	homa_sock_unlock(hsk);
+	return result;
+}
+
+/**
+ * homa_unprotect_rpcs() - Cancel the effect of a previous call to
+ * homa_sock_protect(), so that RPCs can once again be reaped.
+ * @hsk:    Socket whose RPCs should be unprotected.
+ */
+static inline void homa_unprotect_rpcs(struct homa_sock *hsk)
+{
+	atomic_dec(&hsk->protect_count);
+}
+
+/**
+ * homa_rpc_hold() - Increment the reference count on an RPC, which will
+ * prevent it from being freed until homa_rpc_put() is called. Used in
+ * situations where a pointer to the RPC needs to be retained during a
+ * period where it is unprotected by locks.
+ * @rpc:      RPC on which to take a reference.
+ */
+static inline void homa_rpc_hold(struct homa_rpc *rpc)
+{
+	atomic_inc(&rpc->refs);
+}
+
+/**
+ * homa_rpc_put() - Release a reference on an RPC (cancels the effect of
+ * a previous call to homa_rpc_put).
+ * @rpc:      RPC to release.
+ */
+static inline void homa_rpc_put(struct homa_rpc *rpc)
+{
+	atomic_dec(&rpc->refs);
+}
+
+/**
+ * homa_is_client(): returns true if we are the client for a particular RPC,
+ * false if we are the server.
+ * @id:  Id of the RPC in question.
+ * Return: true if we are the client for RPC id, false otherwise
+ */
+static inline bool homa_is_client(u64 id)
+{
+	return (id & 1) == 0;
+}
+
+/**
+ * homa_rpc_needs_attention() - Returns true if @rpc has failed or if
+ * its incoming message is ready for attention by an application thread
+ * (e.g., packets are ready to copy to user space).
+ * @rpc: RPC to check.
+ * Return: See above
+ */
+static inline bool homa_rpc_needs_attention(struct homa_rpc *rpc)
+{
+	return (rpc->error != 0 || atomic_read(&rpc->flags) & RPC_PKTS_READY);
+}
+
+#endif /* _HOMA_RPC_H */
-- 
2.43.0


