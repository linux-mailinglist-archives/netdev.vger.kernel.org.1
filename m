Return-Path: <netdev+bounces-211093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ACEB1695D
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 01:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C1B560A8F
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 23:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CA423B619;
	Wed, 30 Jul 2025 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="V7z7/O1E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3706A23AE83
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 23:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753919187; cv=none; b=XfIkYH8R5ovOoZz0DdTMpuLigcCt2uk2ioTZXcz2IqsxB+wvH9a8r6SceFebcFbj39bguzF79VNomvzIFBfZvD7SSd0K5xb6opZElimeghBpj2oD0L1/Ftu3bOJrK0AWsdSBbBj+1ZVAAz+G/nx/I8xz7q5RmuB2JqjRk4v4rLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753919187; c=relaxed/simple;
	bh=e1y81ce7fL5kgN1l2KA60RvbwOxs5LXK68M7GE2zO9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkXQ1D2691dg4S4+vH+1Q42U3ccV7608vMGOTMdzYVacsiFJNLaUJcm2ZmH4R+gPBBS+xzZiXJn1txrE/fF+LlxuERGKqhyDqQnJFQC7E9D2urwEtL5GdlDJ3JUJed5w5I4zkScD1qYL8/h6X88GkDztKgwsxs2y8Pm0KIr5u9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=V7z7/O1E; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4lf3XvKQOAyT6Kjdouu5MzBSv+qa1pNSzuZIAYa0fWc=; t=1753919185; x=1754783185; 
	b=V7z7/O1E7qRK5EXD7iOoN3XDNyVaY5KwfwH1vvoXl5yTY2xHJrBUuLNT1+d3bjOE08pirSMHcUU
	H+mReRxoBEQSbNCi0Fpey3f5vHJLotYaYQxTTmA6maAfNqCtukrjvfnGgcEtXg+RUHhPPtcB6e5US
	CxwCA2wEFJ7fRhlW38MQw7d7VzpbxM74qnOxsZ/GSZVOoa+842Cd75UCgzU3lIQbYvL/fcsgkTz3n
	aD2DJUEgQA3cGroNfIB0fiMpWA6DlCEPvNE9SdjLsbGoYIO+oX/C1f2MXfaGS2EZWHUbBsDFRQXVI
	IV1Rr4lbX4aZpLjWUDFsCkwL5fCXfYcMf98A==;
Received: from ouster448.stanford.edu ([172.24.72.71]:58817 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uhGV4-0006n4-TW; Wed, 30 Jul 2025 16:46:24 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [RFC net-next v13 06/15] net: homa: create homa_sock.h and homa_sock.c
Date: Wed, 30 Jul 2025 16:45:34 -0700
Message-ID: <20250730234544.4357-7-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250730234544.4357-1-ouster@cs.stanford.edu>
References: <20250730234544.4357-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -99.2
X-Scan-Signature: ff036c1f86a3f5d41553b34ad40872e7

These files provide functions for managing the state that Homa keeps
for each open Homa socket.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v11:
* Clean up sparse annotations

Changes for v10:
* Revise sparse annotations to eliminate __context__ definition
* Replace __u16 with u16, __u8 with u8, etc.
* Use the destroy function from struct proto properly (fixes races in
  socket cleanup)

Changes for v9:
* Add support for homa_net objects; there is now a single socket table shared
  across all network namespaces
* Set SOCK_RCU_FREE in homa_sock_init, not homa_sock_shutdown
* Various name improvements (e.g. use "alloc" instead of "new" for functions
  that allocate memory)

Changes for v8:
* Update for new homa_pool APIs

Changes for v7:
* Refactor homa_sock_start_scan etc. (take a reference on the socket, so
  homa_socktab::active_scans and struct homa_socktab_links are no longer
  needed; encapsulate RCU usage entirely in homa_sock.c).
* Add functions for tx memory accounting
* Refactor waiting mechanism for incoming messages
* Add hsk->is_server, setsockopt SO_HOMA_SERVER
* Remove "lock_slow" functions, which don't add functionality in this
  patch series
* Remove locker argument from locking functions
* Use u64 and __u64 properly
* Take a reference to the socket in homa_sock_find
---
 net/homa/homa_sock.c | 432 +++++++++++++++++++++++++++++++++++++++++++
 net/homa/homa_sock.h | 408 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 840 insertions(+)
 create mode 100644 net/homa/homa_sock.c
 create mode 100644 net/homa/homa_sock.h

diff --git a/net/homa/homa_sock.c b/net/homa/homa_sock.c
new file mode 100644
index 000000000000..f3e2ec0be64e
--- /dev/null
+++ b/net/homa/homa_sock.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: BSD-2-Clause or GPL-2.0+
+
+/* This file manages homa_sock and homa_socktab objects. */
+
+#include "homa_impl.h"
+#include "homa_interest.h"
+#include "homa_peer.h"
+#include "homa_pool.h"
+
+/**
+ * homa_socktab_init() - Constructor for homa_socktabs.
+ * @socktab:  The object to initialize; previous contents are discarded.
+ */
+void homa_socktab_init(struct homa_socktab *socktab)
+{
+	int i;
+
+	spin_lock_init(&socktab->write_lock);
+	for (i = 0; i < HOMA_SOCKTAB_BUCKETS; i++)
+		INIT_HLIST_HEAD(&socktab->buckets[i]);
+}
+
+/**
+ * homa_socktab_destroy() - Destructor for homa_socktabs: deletes all
+ * existing sockets.
+ * @socktab:  The object to destroy.
+ * @hnet:     If non-NULL, only sockets for this namespace are deleted.
+ */
+void homa_socktab_destroy(struct homa_socktab *socktab, struct homa_net *hnet)
+{
+	struct homa_socktab_scan scan;
+	struct homa_sock *hsk;
+
+	for (hsk = homa_socktab_start_scan(socktab, &scan); hsk;
+			hsk = homa_socktab_next(&scan)) {
+		if (hnet && hnet != hsk->hnet)
+			continue;
+
+		/* In actual use there should be no sockets left when this
+		 * function is invoked, so the code below will never be
+		 * invoked. However, it is useful during unit tests.
+		 */
+		homa_sock_shutdown(hsk);
+		homa_sock_destroy(&hsk->sock);
+	}
+	homa_socktab_end_scan(&scan);
+}
+
+/**
+ * homa_socktab_start_scan() - Begin an iteration over all of the sockets
+ * in a socktab.
+ * @socktab:   Socktab to scan.
+ * @scan:      Will hold the current state of the scan; any existing
+ *             contents are discarded. The caller must eventually pass this
+ *             to homa_socktab_end_scan.
+ *
+ * Return:     The first socket in the table, or NULL if the table is
+ *             empty. If non-NULL, a reference is held on the socket to
+ *             prevent its deletion.
+ *
+ * Each call to homa_socktab_next will return the next socket in the table.
+ * All sockets that are present in the table at the time this function is
+ * invoked will eventually be returned, as long as they are not removed
+ * from the table. It is safe to remove sockets from the table while the
+ * scan is in progress. If a socket is removed from the table during the scan,
+ * it may or may not be returned by homa_socktab_next. New entries added
+ * during the scan may or may not be returned.
+ */
+struct homa_sock *homa_socktab_start_scan(struct homa_socktab *socktab,
+					  struct homa_socktab_scan *scan)
+{
+	scan->socktab = socktab;
+	scan->hsk = NULL;
+	scan->current_bucket = -1;
+
+	return homa_socktab_next(scan);
+}
+
+/**
+ * homa_socktab_next() - Return the next socket in an iteration over a socktab.
+ * @scan:      State of the scan.
+ *
+ * Return:     The next socket in the table, or NULL if the iteration has
+ *             returned all of the sockets in the table.  If non-NULL, a
+ *             reference is held on the socket to prevent its deletion.
+ *             Sockets are not returned in any particular order. It's
+ *             possible that the returned socket has been destroyed.
+ */
+struct homa_sock *homa_socktab_next(struct homa_socktab_scan *scan)
+{
+	struct hlist_head *bucket;
+	struct hlist_node *next;
+
+	rcu_read_lock();
+	if (scan->hsk) {
+		sock_put(&scan->hsk->sock);
+		next = rcu_dereference(hlist_next_rcu(&scan->hsk->socktab_links));
+		if (next)
+			goto success;
+	}
+	for (scan->current_bucket++;
+	     scan->current_bucket < HOMA_SOCKTAB_BUCKETS;
+	     scan->current_bucket++) {
+		bucket = &scan->socktab->buckets[scan->current_bucket];
+		next = rcu_dereference(hlist_first_rcu(bucket));
+		if (next)
+			goto success;
+	}
+	scan->hsk = NULL;
+	rcu_read_unlock();
+	return NULL;
+
+success:
+	scan->hsk =  hlist_entry(next, struct homa_sock, socktab_links);
+	sock_hold(&scan->hsk->sock);
+	rcu_read_unlock();
+	return scan->hsk;
+}
+
+/**
+ * homa_socktab_end_scan() - Must be invoked on completion of each scan
+ * to clean up state associated with the scan.
+ * @scan:      State of the scan.
+ */
+void homa_socktab_end_scan(struct homa_socktab_scan *scan)
+{
+	if (scan->hsk) {
+		sock_put(&scan->hsk->sock);
+		scan->hsk = NULL;
+	}
+}
+
+/**
+ * homa_sock_init() - Constructor for homa_sock objects. This function
+ * initializes only the parts of the socket that are owned by Homa.
+ * @hsk:    Object to initialize. The Homa-specific parts must have been
+ *          initialized to zeroes by the caller.
+ *
+ * Return: 0 for success, otherwise a negative errno.
+ */
+int homa_sock_init(struct homa_sock *hsk)
+{
+	struct homa_pool *buffer_pool;
+	struct homa_socktab *socktab;
+	struct homa_sock *other;
+	struct homa_net *hnet;
+	struct homa *homa;
+	int starting_port;
+	int result = 0;
+	int i;
+
+	hnet = (struct homa_net *)net_generic(sock_net(&hsk->sock),
+					      homa_net_id);
+	homa = hnet->homa;
+	socktab = homa->socktab;
+
+	/* Initialize fields outside the Homa part. */
+	hsk->sock.sk_sndbuf = homa->wmem_max;
+	sock_set_flag(&hsk->inet.sk, SOCK_RCU_FREE);
+
+	/* Do things requiring memory allocation before locking the socket,
+	 * so that GFP_ATOMIC is not needed.
+	 */
+	buffer_pool = homa_pool_alloc(hsk);
+	if (IS_ERR(buffer_pool))
+		return PTR_ERR(buffer_pool);
+
+	/* Initialize Homa-specific fields. */
+	hsk->homa = homa;
+	hsk->hnet = hnet;
+	hsk->buffer_pool = buffer_pool;
+
+	/* Pick a default port. Must keep the socktab locked from now
+	 * until the new socket is added to the socktab, to ensure that
+	 * no other socket chooses the same port.
+	 */
+	spin_lock_bh(&socktab->write_lock);
+	starting_port = hnet->prev_default_port;
+	while (1) {
+		hnet->prev_default_port++;
+		if (hnet->prev_default_port < HOMA_MIN_DEFAULT_PORT)
+			hnet->prev_default_port = HOMA_MIN_DEFAULT_PORT;
+		other = homa_sock_find(hnet, hnet->prev_default_port);
+		if (!other)
+			break;
+		sock_put(&other->sock);
+		if (hnet->prev_default_port == starting_port) {
+			spin_unlock_bh(&socktab->write_lock);
+			hsk->shutdown = true;
+			hsk->homa = NULL;
+			result = -EADDRNOTAVAIL;
+			goto error;
+		}
+	}
+	hsk->port = hnet->prev_default_port;
+	hsk->inet.inet_num = hsk->port;
+	hsk->inet.inet_sport = htons(hsk->port);
+
+	hsk->is_server = false;
+	hsk->shutdown = false;
+	hsk->ip_header_length = (hsk->inet.sk.sk_family == AF_INET) ?
+				sizeof(struct iphdr) : sizeof(struct ipv6hdr);
+	spin_lock_init(&hsk->lock);
+	atomic_set(&hsk->protect_count, 0);
+	INIT_LIST_HEAD(&hsk->active_rpcs);
+	INIT_LIST_HEAD(&hsk->dead_rpcs);
+	hsk->dead_skbs = 0;
+	INIT_LIST_HEAD(&hsk->waiting_for_bufs);
+	INIT_LIST_HEAD(&hsk->ready_rpcs);
+	INIT_LIST_HEAD(&hsk->interests);
+	for (i = 0; i < HOMA_CLIENT_RPC_BUCKETS; i++) {
+		struct homa_rpc_bucket *bucket = &hsk->client_rpc_buckets[i];
+
+		spin_lock_init(&bucket->lock);
+		bucket->id = i;
+		INIT_HLIST_HEAD(&bucket->rpcs);
+	}
+	for (i = 0; i < HOMA_SERVER_RPC_BUCKETS; i++) {
+		struct homa_rpc_bucket *bucket = &hsk->server_rpc_buckets[i];
+
+		spin_lock_init(&bucket->lock);
+		bucket->id = i + 1000000;
+		INIT_HLIST_HEAD(&bucket->rpcs);
+	}
+	hlist_add_head_rcu(&hsk->socktab_links,
+			   &socktab->buckets[homa_socktab_bucket(hnet,
+								 hsk->port)]);
+	spin_unlock_bh(&socktab->write_lock);
+	return result;
+
+error:
+	homa_pool_free(buffer_pool);
+	return result;
+}
+
+/*
+ * homa_sock_unlink() - Unlinks a socket from its socktab and does
+ * related cleanups. Once this method returns, the socket will not be
+ * discoverable through the socktab.
+ * @hsk:  Socket to unlink.
+ */
+void homa_sock_unlink(struct homa_sock *hsk)
+{
+	struct homa_socktab *socktab = hsk->homa->socktab;
+
+	spin_lock_bh(&socktab->write_lock);
+	hlist_del_rcu(&hsk->socktab_links);
+	spin_unlock_bh(&socktab->write_lock);
+}
+
+/**
+ * homa_sock_shutdown() - Disable a socket so that it can no longer
+ * be used for either sending or receiving messages. Any system calls
+ * currently waiting to send or receive messages will be aborted. This
+ * function will terminate any existing use of the socket, but it does
+ * not free up socket resources: that happens in homa_sock_destroy.
+ * @hsk:       Socket to shut down.
+ */
+void homa_sock_shutdown(struct homa_sock *hsk)
+{
+	struct homa_interest *interest;
+	struct homa_rpc *rpc;
+
+	homa_sock_lock(hsk);
+	if (hsk->shutdown || !hsk->homa) {
+		homa_sock_unlock(hsk);
+		return;
+	}
+
+	/* The order of cleanup is very important, because there could be
+	 * active operations that hold RPC locks but not the socket lock.
+	 * 1. Set @shutdown; this ensures that no new RPCs will be created for
+	 *    this socket (though some creations might already be in progress).
+	 * 2. Remove the socket from its socktab: this ensures that
+	 *    incoming packets for the socket will be dropped.
+	 * 3. Go through all of the RPCs and delete them; this will
+	 *    synchronize with any operations in progress.
+	 * 4. Perform other socket cleanup: at this point we know that
+	 *    there will be no concurrent activities on individual RPCs.
+	 * 5. Don't delete the buffer pool until after all of the RPCs
+	 *    have been reaped.
+	 * See "Homa Locking Strategy" in homa_impl.h for additional information
+	 * about locking.
+	 */
+	hsk->shutdown = true;
+	homa_sock_unlink(hsk);
+	homa_sock_unlock(hsk);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(rpc, &hsk->active_rpcs, active_links) {
+		homa_rpc_lock(rpc);
+		homa_rpc_end(rpc);
+		homa_rpc_unlock(rpc);
+	}
+	rcu_read_unlock();
+
+	homa_sock_lock(hsk);
+	while (!list_empty(&hsk->interests)) {
+		interest = list_first_entry(&hsk->interests,
+					    struct homa_interest, links);
+		list_del_init(&interest->links);
+		atomic_set_release(&interest->ready, 1);
+		wake_up(&interest->wait_queue);
+	}
+	homa_sock_unlock(hsk);
+}
+
+/**
+ * homa_sock_destroy() - Release all of the internal resources associated
+ * with a socket; is invoked at time when that is safe (i.e., all references
+ * on the socket have been dropped).
+ * @sk:       Socket to destroy.
+ */
+void homa_sock_destroy(struct sock *sk)
+{
+	struct homa_sock *hsk = homa_sk(sk);
+
+	if (!hsk->homa)
+		return;
+
+	while (!list_empty(&hsk->dead_rpcs))
+		homa_rpc_reap(hsk, true);
+
+	WARN_ON_ONCE(refcount_read(&hsk->sock.sk_wmem_alloc) != 1);
+
+	if (hsk->buffer_pool) {
+		homa_pool_free(hsk->buffer_pool);
+		hsk->buffer_pool = NULL;
+	}
+}
+
+/**
+ * homa_sock_bind() - Associates a server port with a socket; if there
+ * was a previous server port assignment for @hsk, it is abandoned.
+ * @hnet:      Network namespace with which port is associated.
+ * @hsk:       Homa socket.
+ * @port:      Desired server port for @hsk. If 0, then this call
+ *             becomes a no-op: the socket will continue to use
+ *             its randomly assigned client port.
+ *
+ * Return:  0 for success, otherwise a negative errno.
+ */
+int homa_sock_bind(struct homa_net *hnet, struct homa_sock *hsk,
+		   u16 port)
+{
+	struct homa_socktab *socktab = hnet->homa->socktab;
+	struct homa_sock *owner;
+	int result = 0;
+
+	if (port == 0)
+		return result;
+	if (port >= HOMA_MIN_DEFAULT_PORT)
+		return -EINVAL;
+	homa_sock_lock(hsk);
+	spin_lock_bh(&socktab->write_lock);
+	if (hsk->shutdown) {
+		result = -ESHUTDOWN;
+		goto done;
+	}
+
+	owner = homa_sock_find(hnet, port);
+	if (owner) {
+		sock_put(&owner->sock);
+		if (owner != hsk)
+			result = -EADDRINUSE;
+		goto done;
+	}
+	hlist_del_rcu(&hsk->socktab_links);
+	hsk->port = port;
+	hsk->inet.inet_num = port;
+	hsk->inet.inet_sport = htons(hsk->port);
+	hlist_add_head_rcu(&hsk->socktab_links,
+			   &socktab->buckets[homa_socktab_bucket(hnet, port)]);
+	hsk->is_server = true;
+done:
+	spin_unlock_bh(&socktab->write_lock);
+	homa_sock_unlock(hsk);
+	return result;
+}
+
+/**
+ * homa_sock_find() - Returns the socket associated with a given port.
+ * @hnet:       Network namespace where the socket will be used.
+ * @port:       The port of interest.
+ * Return:      The socket that owns @port, or NULL if none. If non-NULL
+ *              then this method has taken a reference on the socket and
+ *              the caller must call sock_put to release it.
+ */
+struct homa_sock *homa_sock_find(struct homa_net *hnet, u16 port)
+{
+	int bucket = homa_socktab_bucket(hnet, port);
+	struct homa_sock *result = NULL;
+	struct homa_sock *hsk;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(hsk, &hnet->homa->socktab->buckets[bucket],
+				 socktab_links) {
+		if (hsk->port == port && hsk->hnet == hnet) {
+			result = hsk;
+			sock_hold(&hsk->sock);
+			break;
+		}
+	}
+	rcu_read_unlock();
+	return result;
+}
+
+/**
+ * homa_sock_wait_wmem() - Block the thread until @hsk's usage of tx
+ * packet memory drops below the socket's limit.
+ * @hsk:          Socket of interest.
+ * @nonblocking:  If there's not enough memory, return -EWOLDBLOCK instead
+ *                of blocking.
+ * Return: 0 for success, otherwise a negative errno.
+ */
+int homa_sock_wait_wmem(struct homa_sock *hsk, int nonblocking)
+{
+	long timeo = hsk->sock.sk_sndtimeo;
+	int result;
+
+	if (nonblocking)
+		timeo = 0;
+	set_bit(SOCK_NOSPACE, &hsk->sock.sk_socket->flags);
+	result = wait_event_interruptible_timeout(*sk_sleep(&hsk->sock),
+				homa_sock_wmem_avl(hsk) || hsk->shutdown,
+				timeo);
+	if (signal_pending(current))
+		return -EINTR;
+	if (result == 0)
+		return -EWOULDBLOCK;
+	return 0;
+}
diff --git a/net/homa/homa_sock.h b/net/homa/homa_sock.h
new file mode 100644
index 000000000000..1f649c1da628
--- /dev/null
+++ b/net/homa/homa_sock.h
@@ -0,0 +1,408 @@
+/* SPDX-License-Identifier: BSD-2-Clause or GPL-2.0+ */
+
+/* This file defines structs and other things related to Homa sockets.  */
+
+#ifndef _HOMA_SOCK_H
+#define _HOMA_SOCK_H
+
+/* Forward declarations. */
+struct homa;
+struct homa_pool;
+
+/* Number of hash buckets in a homa_socktab. Must be a power of 2. */
+#define HOMA_SOCKTAB_BUCKET_BITS 10
+#define HOMA_SOCKTAB_BUCKETS BIT(HOMA_SOCKTAB_BUCKET_BITS)
+
+/**
+ * struct homa_socktab - A hash table that maps from port numbers (either
+ * client or server) to homa_sock objects.
+ *
+ * This table is managed exclusively by homa_socktab.c, using RCU to
+ * minimize synchronization during lookups.
+ */
+struct homa_socktab {
+	/**
+	 * @write_lock: Controls all modifications to this object; not needed
+	 * for socket lookups (RCU is used instead). Also used to
+	 * synchronize port allocation.
+	 */
+	spinlock_t write_lock;
+
+	/**
+	 * @buckets: Heads of chains for hash table buckets. Chains
+	 * consist of homa_sock objects.
+	 */
+	struct hlist_head buckets[HOMA_SOCKTAB_BUCKETS];
+};
+
+/**
+ * struct homa_socktab_scan - Records the state of an iteration over all
+ * the entries in a homa_socktab, in a way that is safe against concurrent
+ * reclamation of sockets.
+ */
+struct homa_socktab_scan {
+	/** @socktab: The table that is being scanned. */
+	struct homa_socktab *socktab;
+
+	/**
+	 * @hsk: Points to the current socket in the iteration, or NULL if
+	 * we're at the beginning or end of the iteration. If non-NULL then
+	 * we are holding a reference to this socket.
+	 */
+	struct homa_sock *hsk;
+
+	/**
+	 * @current_bucket: The index of the bucket in socktab->buckets
+	 * currently being scanned (-1 if @hsk == NULL).
+	 */
+	int current_bucket;
+};
+
+/**
+ * struct homa_rpc_bucket - One bucket in a hash table of RPCs.
+ */
+
+struct homa_rpc_bucket {
+	/**
+	 * @lock: serves as a lock both for this bucket (e.g., when
+	 * adding and removing RPCs) and also for all of the RPCs in
+	 * the bucket. Must be held whenever looking up an RPC in
+	 * this bucket or manipulating an RPC in the bucket. This approach
+	 * has the following properties:
+	 * 1. An RPC can be looked up and locked (a common operation) with
+	 *    a single lock acquisition.
+	 * 2. Looking up and locking are atomic: there is no window of
+	 *    vulnerability where someone else could delete an RPC after
+	 *    it has been looked up and before it has been locked.
+	 * 3. The lookup mechanism does not use RCU.  This is important because
+	 *    RPCs are created rapidly and typically live only a few tens of
+	 *    microseconds.  As of May 2027 RCU introduces a lag of about
+	 *    25 ms before objects can be deleted; for RPCs this would result
+	 *    in hundreds or thousands of RPCs accumulating before RCU allows
+	 *    them to be deleted.
+	 * This approach has the disadvantage that RPCs within a bucket share
+	 * locks and thus may not be able to work concurrently, but there are
+	 * enough buckets in the table to make such colllisions rare.
+	 *
+	 * See "Homa Locking Strategy" in homa_impl.h for more info about
+	 * locking.
+	 */
+	spinlock_t lock;
+
+	/**
+	 * @id: identifier for this bucket, used in error messages etc.
+	 * It's the index of the bucket within its hash table bucket
+	 * array, with an additional offset to separate server and
+	 * client RPCs.
+	 */
+	int id;
+
+	/** @rpcs: list of RPCs that hash to this bucket. */
+	struct hlist_head rpcs;
+};
+
+/**
+ * define HOMA_CLIENT_RPC_BUCKETS - Number of buckets in hash tables for
+ * client RPCs. Must be a power of 2.
+ */
+#define HOMA_CLIENT_RPC_BUCKETS 1024
+
+/**
+ * define HOMA_SERVER_RPC_BUCKETS - Number of buckets in hash tables for
+ * server RPCs. Must be a power of 2.
+ */
+#define HOMA_SERVER_RPC_BUCKETS 1024
+
+/**
+ * struct homa_sock - Information about an open socket.
+ */
+struct homa_sock {
+	/* Info for other network layers. Note: IPv6 info (struct ipv6_pinfo
+	 * comes at the very end of the struct, *after* Homa's data, if this
+	 * socket uses IPv6).
+	 */
+	union {
+		/** @sock: generic socket data; must be the first field. */
+		struct sock sock;
+
+		/**
+		 * @inet: generic Internet socket data; must also be the
+		 first field (contains sock as its first member).
+		 */
+		struct inet_sock inet;
+	};
+
+	/**
+	 * @homa: Overall state about the Homa implementation. NULL
+	 * means this socket was never initialized or has been deleted.
+	 */
+	struct homa *homa;
+
+	/**
+	 * @hnet: Overall state specific to the network namespace for
+	 * this socket.
+	 */
+	struct homa_net *hnet;
+
+	/**
+	 * @buffer_pool: used to allocate buffer space for incoming messages.
+	 * Storage is dynamically allocated.
+	 */
+	struct homa_pool *buffer_pool;
+
+	/**
+	 * @port: Port number: identifies this socket uniquely among all
+	 * those on this node.
+	 */
+	u16 port;
+
+	/**
+	 * @is_server: True means that this socket can act as both client
+	 * and server; false means the socket is client-only.
+	 */
+	bool is_server;
+
+	/**
+	 * @shutdown: True means the socket is no longer usable (either
+	 * shutdown has already been invoked, or the socket was never
+	 * properly initialized).
+	 */
+	bool shutdown;
+
+	/**
+	 * @ip_header_length: Length of IP headers for this socket (depends
+	 * on IPv4 vs. IPv6).
+	 */
+	int ip_header_length;
+
+	/** @socktab_links: Links this socket into a homa_socktab bucket. */
+	struct hlist_node socktab_links;
+
+	/* Information above is (almost) never modified; start a new
+	 * cache line below for info that is modified frequently.
+	 */
+
+	/**
+	 * @lock: Must be held when modifying fields such as interests
+	 * and lists of RPCs. This lock is used in place of sk->sk_lock
+	 * because it's used differently (it's always used as a simple
+	 * spin lock).  See "Homa Locking Strategy" in homa_impl.h
+	 * for more on Homa's synchronization strategy.
+	 */
+	spinlock_t lock ____cacheline_aligned_in_smp;
+
+	/**
+	 * @protect_count: counts the number of calls to homa_protect_rpcs
+	 * for which there have not yet been calls to homa_unprotect_rpcs.
+	 */
+	atomic_t protect_count;
+
+	/**
+	 * @active_rpcs: List of all existing RPCs related to this socket,
+	 * including both client and server RPCs. This list isn't strictly
+	 * needed, since RPCs are already in one of the hash tables below,
+	 * but it's more efficient for homa_timer to have this list
+	 * (so it doesn't have to scan large numbers of hash buckets).
+	 * The list is sorted, with the oldest RPC first. Manipulate with
+	 * RCU so timer can access without locking.
+	 */
+	struct list_head active_rpcs;
+
+	/**
+	 * @dead_rpcs: Contains RPCs for which homa_rpc_end has been
+	 * called, but their packet buffers haven't yet been freed.
+	 */
+	struct list_head dead_rpcs;
+
+	/** @dead_skbs: Total number of socket buffers in RPCs on dead_rpcs. */
+	int dead_skbs;
+
+	/**
+	 * @waiting_for_bufs: Contains RPCs that are blocked because there
+	 * wasn't enough space in the buffer pool region for their incoming
+	 * messages. Sorted in increasing order of message length.
+	 */
+	struct list_head waiting_for_bufs;
+
+	/**
+	 * @ready_rpcs: List of all RPCs that are ready for attention from
+	 * an application thread.
+	 */
+	struct list_head ready_rpcs;
+
+	/**
+	 * @interests: List of threads that are currently waiting for
+	 * incoming messages via homa_wait_shared.
+	 */
+	struct list_head interests;
+
+	/**
+	 * @client_rpc_buckets: Hash table for fast lookup of client RPCs.
+	 * Modifications are synchronized with bucket locks, not
+	 * the socket lock.
+	 */
+	struct homa_rpc_bucket client_rpc_buckets[HOMA_CLIENT_RPC_BUCKETS];
+
+	/**
+	 * @server_rpc_buckets: Hash table for fast lookup of server RPCs.
+	 * Modifications are synchronized with bucket locks, not
+	 * the socket lock.
+	 */
+	struct homa_rpc_bucket server_rpc_buckets[HOMA_SERVER_RPC_BUCKETS];
+};
+
+/**
+ * struct homa_v6_sock - For IPv6, additional IPv6-specific information
+ * is present in the socket struct after Homa-specific information.
+ */
+struct homa_v6_sock {
+	/** @homa: All socket info except for IPv6-specific stuff. */
+	struct homa_sock homa;
+
+	/** @inet6: Socket info specific to IPv6. */
+	struct ipv6_pinfo inet6;
+};
+
+int                homa_sock_bind(struct homa_net *hnet, struct homa_sock *hsk,
+				  u16 port);
+void               homa_sock_destroy(struct sock *sk);
+struct homa_sock  *homa_sock_find(struct homa_net *hnet, u16 port);
+int                homa_sock_init(struct homa_sock *hsk);
+void               homa_sock_shutdown(struct homa_sock *hsk);
+void               homa_sock_unlink(struct homa_sock *hsk);
+int                homa_sock_wait_wmem(struct homa_sock *hsk, int nonblocking);
+void               homa_socktab_destroy(struct homa_socktab *socktab,
+					struct homa_net *hnet);
+void               homa_socktab_end_scan(struct homa_socktab_scan *scan);
+void               homa_socktab_init(struct homa_socktab *socktab);
+struct homa_sock  *homa_socktab_next(struct homa_socktab_scan *scan);
+struct homa_sock  *homa_socktab_start_scan(struct homa_socktab *socktab,
+					   struct homa_socktab_scan *scan);
+
+/**
+ * homa_sock_lock() - Acquire the lock for a socket.
+ * @hsk:     Socket to lock.
+ */
+static inline void homa_sock_lock(struct homa_sock *hsk)
+	__acquires(hsk->lock)
+{
+	spin_lock_bh(&hsk->lock);
+}
+
+/**
+ * homa_sock_unlock() - Release the lock for a socket.
+ * @hsk:   Socket to lock.
+ */
+static inline void homa_sock_unlock(struct homa_sock *hsk)
+	__releases(hsk->lock)
+{
+	spin_unlock_bh(&hsk->lock);
+}
+
+/**
+ * homa_socktab_bucket() - Compute the bucket number in a homa_socktab
+ * that will contain a particular socket.
+ * @hnet:   Network namespace of the desired socket.
+ * @port:   Port number of the socket.
+ *
+ * Return:  The index of the bucket in which a socket matching @hnet and
+ *          @port will be found (if it exists).
+ */
+static inline int homa_socktab_bucket(struct homa_net *hnet, u16 port)
+{
+	return hash_32((uintptr_t)hnet ^ port, HOMA_SOCKTAB_BUCKET_BITS);
+}
+
+/**
+ * homa_client_rpc_bucket() - Find the bucket containing a given
+ * client RPC.
+ * @hsk:      Socket associated with the RPC.
+ * @id:       Id of the desired RPC.
+ *
+ * Return:    The bucket in which this RPC will appear, if the RPC exists.
+ */
+static inline struct homa_rpc_bucket
+		*homa_client_rpc_bucket(struct homa_sock *hsk, u64 id)
+{
+	/* We can use a really simple hash function here because RPC ids
+	 * are allocated sequentially.
+	 */
+	return &hsk->client_rpc_buckets[(id >> 1)
+			& (HOMA_CLIENT_RPC_BUCKETS - 1)];
+}
+
+/**
+ * homa_server_rpc_bucket() - Find the bucket containing a given
+ * server RPC.
+ * @hsk:         Socket associated with the RPC.
+ * @id:          Id of the desired RPC.
+ *
+ * Return:    The bucket in which this RPC will appear, if the RPC exists.
+ */
+static inline struct homa_rpc_bucket
+		*homa_server_rpc_bucket(struct homa_sock *hsk, u64 id)
+{
+	/* Each client allocates RPC ids sequentially, so they will
+	 * naturally distribute themselves across the hash space.
+	 * Thus we can use the id directly as hash.
+	 */
+	return &hsk->server_rpc_buckets[(id >> 1)
+			& (HOMA_SERVER_RPC_BUCKETS - 1)];
+}
+
+/**
+ * homa_bucket_lock() - Acquire the lock for an RPC hash table bucket.
+ * @bucket:    Bucket to lock.
+ * @id:        Id of the RPC on whose behalf the bucket is being locked.
+ *             Used only for metrics.
+ */
+static inline void homa_bucket_lock(struct homa_rpc_bucket *bucket, u64 id)
+	__acquires(bucket->lock)
+{
+	spin_lock_bh(&bucket->lock);
+}
+
+/**
+ * homa_bucket_unlock() - Release the lock for an RPC hash table bucket.
+ * @bucket:   Bucket to unlock.
+ * @id:       ID of the RPC that was using the lock.
+ */
+static inline void homa_bucket_unlock(struct homa_rpc_bucket *bucket, u64 id)
+	__releases(bucket->lock)
+{
+	spin_unlock_bh(&bucket->lock);
+}
+
+static inline struct homa_sock *homa_sk(const struct sock *sk)
+{
+	return (struct homa_sock *)sk;
+}
+
+/**
+ * homa_sock_wmem_avl() - Returns true if the socket is within its limit
+ * for output memory usage. False means that no new messages should be sent
+ * until memory is freed.
+ * @hsk:   Socket of interest.
+ * Return: See above.
+ */
+static inline bool homa_sock_wmem_avl(struct homa_sock *hsk)
+{
+	return refcount_read(&hsk->sock.sk_wmem_alloc) < hsk->sock.sk_sndbuf;
+}
+
+/**
+ * homa_sock_wakeup_wmem() - Invoked when tx packet memory has been freed;
+ * if memory usage is below the limit and there are tasks waiting for memory,
+ * wake them up.
+ * @hsk:   Socket of interest.
+ */
+static inline void homa_sock_wakeup_wmem(struct homa_sock *hsk)
+{
+	if (test_bit(SOCK_NOSPACE, &hsk->sock.sk_socket->flags) &&
+	    homa_sock_wmem_avl(hsk)) {
+		clear_bit(SOCK_NOSPACE, &hsk->sock.sk_socket->flags);
+		wake_up_interruptible_poll(sk_sleep(&hsk->sock), EPOLLOUT);
+	}
+}
+
+#endif /* _HOMA_SOCK_H */
-- 
2.43.0


