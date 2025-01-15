Return-Path: <netdev+bounces-158615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F1EA12B50
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 20:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66901660AD
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 19:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965B31D61AA;
	Wed, 15 Jan 2025 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="bZqwQGIW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF5C1D7E42
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736967653; cv=none; b=jvNYilB5ZcTzEx/dS+zCMA566eDyFzL07ECervL9+QDwC9L27wktAkhHrD9kR+NvL4n99ksOlU9GlRQu+fpE7qXF0H5725Rm3W17NOhw5TDt6p8CccQDRF5PrzbgP+Tz5lCD4Zvyo4d+5vfI28ql27a2ikrEgWeQFqCGX94t+w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736967653; c=relaxed/simple;
	bh=rVqV6PgYaYQlLBEVIizRnfKzHUKwEODd4R7bwrapkMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOiZQPa1Q1k0aEWWnv82BXDK4vdihTk6O2tHzxMUUboDRvM+2+neSph7zR2FFhViLTYFSiMmpGoD6j1JFMteLqNS1GwhFCqRPk3m2T8u1QLi0m8OaxnB0DWqz8FJHAHHxQVkzpg0b4C2jehOejyFLrdeTF1Th13F3Z9vwv7PlvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=bZqwQGIW; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Jc114UgpRI9z0mgAl4jQ6BsWU876Widu0/20VgsAjWI=; t=1736967622; x=1737831622; 
	b=bZqwQGIWshW1E7ZwpjldHY/9GFcaigRAi047ZMtPyTp+K9aH0BY+0y46khitV/046O+FIuIhUbd
	qjlNQviAUGryneIwX+M1qU91n7Z4JM9zoAM5aUDNkQqVZh+tXdBLewAsaUm/TIL8EcsBsCcOJ/NNv
	t45XrT7edZpxnSc/zs7F4U7xs1Jyht+uoee8K7BQPXLHZLJFPKymJ6I779tc27G+AAiq8nXM7fll6
	XaaNwO9qIT1b8MQ52zUU69AoUWF0vd0CDuqVZPSLvZjANOOdH04WWYALydtmSP6vu/4N+41gMJHT3
	RaFYITLfjlbJDhv53mZi1iAMFV0jdOUlOWGA==;
Received: from ouster448.stanford.edu ([172.24.72.71]:52661 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tY8cm-0002BF-7c; Wed, 15 Jan 2025 11:00:22 -0800
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v6 07/12] net: homa: create homa_sock.h and homa_sock.c
Date: Wed, 15 Jan 2025 10:59:31 -0800
Message-ID: <20250115185937.1324-8-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250115185937.1324-1-ouster@cs.stanford.edu>
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -99.2
X-Scan-Signature: bc7013430af16dbc2db192df27e31311

These files provide functions for managing the state that Homa keeps
for each open Homa socket.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 net/homa/homa_sock.c | 388 ++++++++++++++++++++++++++++++++++++++++
 net/homa/homa_sock.h | 410 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 798 insertions(+)
 create mode 100644 net/homa/homa_sock.c
 create mode 100644 net/homa/homa_sock.h

diff --git a/net/homa/homa_sock.c b/net/homa/homa_sock.c
new file mode 100644
index 000000000000..991219c6a096
--- /dev/null
+++ b/net/homa/homa_sock.c
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+/* This file manages homa_sock and homa_socktab objects. */
+
+#include "homa_impl.h"
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
+	INIT_LIST_HEAD(&socktab->active_scans);
+}
+
+/**
+ * homa_socktab_destroy() - Destructor for homa_socktabs.
+ * @socktab:  The object to destroy.
+ */
+void homa_socktab_destroy(struct homa_socktab *socktab)
+{
+	struct homa_socktab_scan scan;
+	struct homa_sock *hsk;
+
+	for (hsk = homa_socktab_start_scan(socktab, &scan); hsk;
+			hsk = homa_socktab_next(&scan)) {
+		homa_sock_destroy(hsk);
+	}
+	homa_socktab_end_scan(&scan);
+}
+
+/**
+ * homa_socktab_start_scan() - Begin an iteration over all of the sockets
+ * in a socktab.
+ * @socktab:   Socktab to scan.
+ * @scan:      Will hold the current state of the scan; any existing
+ *             contents are discarded.
+ *
+ * Return:     The first socket in the table, or NULL if the table is
+ *             empty.
+ *
+ * Each call to homa_socktab_next will return the next socket in the table.
+ * All sockets that are present in the table at the time this function is
+ * invoked will eventually be returned, as long as they are not removed
+ * from the table. It is safe to remove sockets from the table and/or
+ * delete them while the scan is in progress. If a socket is removed from
+ * the table during the scan, it may or may not be returned by
+ * homa_socktab_next. New entries added during the scan may or may not be
+ * returned. The caller must hold an RCU read lock when invoking the
+ * scan-related methods here, as well as when manipulating sockets returned
+ * during the scan. It is safe to release and reacquire the RCU read lock
+ * during a scan, as long as no socket is held when the read lock is
+ * released and homa_socktab_next isn't invoked until the RCU read lock
+ * is reacquired.
+ */
+struct homa_sock *homa_socktab_start_scan(struct homa_socktab *socktab,
+					  struct homa_socktab_scan *scan)
+{
+	scan->socktab = socktab;
+	scan->current_bucket = -1;
+	scan->next = NULL;
+
+	spin_lock_bh(&socktab->write_lock);
+	list_add_tail_rcu(&scan->scan_links, &socktab->active_scans);
+	spin_unlock_bh(&socktab->write_lock);
+
+	return homa_socktab_next(scan);
+}
+
+/**
+ * homa_socktab_next() - Return the next socket in an iteration over a socktab.
+ * @scan:      State of the scan.
+ *
+ * Return:     The next socket in the table, or NULL if the iteration has
+ *             returned all of the sockets in the table. Sockets are not
+ *             returned in any particular order. It's possible that the
+ *             returned socket has been destroyed.
+ */
+struct homa_sock *homa_socktab_next(struct homa_socktab_scan *scan)
+{
+	struct homa_socktab_links *links;
+	struct homa_sock *hsk;
+
+	while (1) {
+		while (!scan->next) {
+			struct hlist_head *bucket;
+
+			scan->current_bucket++;
+			if (scan->current_bucket >= HOMA_SOCKTAB_BUCKETS)
+				return NULL;
+			bucket = &scan->socktab->buckets[scan->current_bucket];
+			scan->next = (struct homa_socktab_links *)
+				      rcu_dereference(hlist_first_rcu(bucket));
+		}
+		links = scan->next;
+		hsk = links->sock;
+		scan->next = (struct homa_socktab_links *)
+				rcu_dereference(hlist_next_rcu(&links->hash_links));
+		return hsk;
+	}
+}
+
+/**
+ * homa_socktab_end_scan() - Must be invoked on completion of each scan
+ * to clean up state associated with the scan.
+ * @scan:      State of the scan.
+ */
+void homa_socktab_end_scan(struct homa_socktab_scan *scan)
+{
+	spin_lock_bh(&scan->socktab->write_lock);
+	list_del(&scan->scan_links);
+	spin_unlock_bh(&scan->socktab->write_lock);
+}
+
+/**
+ * homa_sock_init() - Constructor for homa_sock objects. This function
+ * initializes only the parts of the socket that are owned by Homa.
+ * @hsk:    Object to initialize.
+ * @homa:   Homa implementation that will manage the socket.
+ *
+ * Return: 0 for success, otherwise a negative errno.
+ */
+int homa_sock_init(struct homa_sock *hsk, struct homa *homa)
+{
+	struct homa_socktab *socktab = homa->port_map;
+	int starting_port;
+	int result = 0;
+	int i;
+
+	spin_lock_bh(&socktab->write_lock);
+	atomic_set(&hsk->protect_count, 0);
+	spin_lock_init(&hsk->lock);
+	hsk->last_locker = "none";
+	atomic_set(&hsk->protect_count, 0);
+	hsk->homa = homa;
+	hsk->ip_header_length = (hsk->inet.sk.sk_family == AF_INET)
+			? HOMA_IPV4_HEADER_LENGTH : HOMA_IPV6_HEADER_LENGTH;
+	hsk->shutdown = false;
+	starting_port = homa->prev_default_port;
+	while (1) {
+		homa->prev_default_port++;
+		if (homa->prev_default_port < HOMA_MIN_DEFAULT_PORT)
+			homa->prev_default_port = HOMA_MIN_DEFAULT_PORT;
+		if (!homa_sock_find(socktab, homa->prev_default_port))
+			break;
+		if (homa->prev_default_port == starting_port) {
+			spin_unlock_bh(&socktab->write_lock);
+			hsk->shutdown = true;
+			return -EADDRNOTAVAIL;
+		}
+	}
+	hsk->port = homa->prev_default_port;
+	hsk->inet.inet_num = hsk->port;
+	hsk->inet.inet_sport = htons(hsk->port);
+	hsk->socktab_links.sock = hsk;
+	hlist_add_head_rcu(&hsk->socktab_links.hash_links,
+			   &socktab->buckets[homa_port_hash(hsk->port)]);
+	INIT_LIST_HEAD(&hsk->active_rpcs);
+	INIT_LIST_HEAD(&hsk->dead_rpcs);
+	hsk->dead_skbs = 0;
+	INIT_LIST_HEAD(&hsk->waiting_for_bufs);
+	INIT_LIST_HEAD(&hsk->ready_requests);
+	INIT_LIST_HEAD(&hsk->ready_responses);
+	INIT_LIST_HEAD(&hsk->request_interests);
+	INIT_LIST_HEAD(&hsk->response_interests);
+	for (i = 0; i < HOMA_CLIENT_RPC_BUCKETS; i++) {
+		struct homa_rpc_bucket *bucket = &hsk->client_rpc_buckets[i];
+
+		spin_lock_init(&bucket->lock);
+		INIT_HLIST_HEAD(&bucket->rpcs);
+		bucket->id = i;
+	}
+	for (i = 0; i < HOMA_SERVER_RPC_BUCKETS; i++) {
+		struct homa_rpc_bucket *bucket = &hsk->server_rpc_buckets[i];
+
+		spin_lock_init(&bucket->lock);
+		INIT_HLIST_HEAD(&bucket->rpcs);
+		bucket->id = i + 1000000;
+	}
+	hsk->buffer_pool = kzalloc(sizeof(*hsk->buffer_pool), GFP_ATOMIC);
+	if (!hsk->buffer_pool)
+		result = -ENOMEM;
+	spin_unlock_bh(&socktab->write_lock);
+	return result;
+}
+
+/*
+ * homa_sock_unlink() - Unlinks a socket from its socktab and does
+ * related cleanups. Once this method returns, the socket will not be
+ * discoverable through the socktab.
+ */
+void homa_sock_unlink(struct homa_sock *hsk)
+{
+	struct homa_socktab *socktab = hsk->homa->port_map;
+	struct homa_socktab_scan *scan;
+
+	/* If any scans refer to this socket, advance them to refer to
+	 * the next socket instead.
+	 */
+	spin_lock_bh(&socktab->write_lock);
+	list_for_each_entry(scan, &socktab->active_scans, scan_links) {
+		if (!scan->next || scan->next->sock != hsk)
+			continue;
+		scan->next = (struct homa_socktab_links *)
+				rcu_dereference(hlist_next_rcu(&scan->next->hash_links));
+	}
+	hlist_del_rcu(&hsk->socktab_links.hash_links);
+	spin_unlock_bh(&socktab->write_lock);
+}
+
+/**
+ * homa_sock_shutdown() - Disable a socket so that it can no longer
+ * be used for either sending or receiving messages. Any system calls
+ * currently waiting to send or receive messages will be aborted.
+ * @hsk:       Socket to shut down.
+ */
+void homa_sock_shutdown(struct homa_sock *hsk)
+	__acquires(&hsk->lock)
+	__releases(&hsk->lock)
+{
+	struct homa_interest *interest;
+	struct homa_rpc *rpc;
+
+	homa_sock_lock(hsk, "homa_socket_shutdown");
+	if (hsk->shutdown) {
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
+	 * See sync.txt for additional information about locking.
+	 */
+	hsk->shutdown = true;
+	homa_sock_unlink(hsk);
+	homa_sock_unlock(hsk);
+
+	list_for_each_entry_rcu(rpc, &hsk->active_rpcs, active_links) {
+		homa_rpc_lock(rpc, "homa_sock_shutdown");
+		homa_rpc_free(rpc);
+		homa_rpc_unlock(rpc);
+	}
+
+	homa_sock_lock(hsk, "homa_socket_shutdown #2");
+	list_for_each_entry(interest, &hsk->request_interests, request_links)
+		wake_up_process(interest->thread);
+	list_for_each_entry(interest, &hsk->response_interests, response_links)
+		wake_up_process(interest->thread);
+	homa_sock_unlock(hsk);
+
+	while (!list_empty(&hsk->dead_rpcs))
+		homa_rpc_reap(hsk, 1000);
+
+	if (hsk->buffer_pool) {
+		homa_pool_destroy(hsk->buffer_pool);
+		kfree(hsk->buffer_pool);
+		hsk->buffer_pool = NULL;
+	}
+}
+
+/**
+ * homa_sock_destroy() - Destructor for homa_sock objects. This function
+ * only cleans up the parts of the object that are owned by Homa.
+ * @hsk:       Socket to destroy.
+ */
+void homa_sock_destroy(struct homa_sock *hsk)
+{
+	homa_sock_shutdown(hsk);
+	sock_set_flag(&hsk->inet.sk, SOCK_RCU_FREE);
+}
+
+/**
+ * homa_sock_bind() - Associates a server port with a socket; if there
+ * was a previous server port assignment for @hsk, it is abandoned.
+ * @socktab:   Hash table in which the binding will be recorded.
+ * @hsk:       Homa socket.
+ * @port:      Desired server port for @hsk. If 0, then this call
+ *             becomes a no-op: the socket will continue to use
+ *             its randomly assigned client port.
+ *
+ * Return:  0 for success, otherwise a negative errno.
+ */
+int homa_sock_bind(struct homa_socktab *socktab, struct homa_sock *hsk,
+		   __u16 port)
+{
+	struct homa_sock *owner;
+	int result = 0;
+
+	if (port == 0)
+		return result;
+	if (port >= HOMA_MIN_DEFAULT_PORT)
+		return -EINVAL;
+	homa_sock_lock(hsk, "homa_sock_bind");
+	spin_lock_bh(&socktab->write_lock);
+	if (hsk->shutdown) {
+		result = -ESHUTDOWN;
+		goto done;
+	}
+
+	owner = homa_sock_find(socktab, port);
+	if (owner) {
+		if (owner != hsk)
+			result = -EADDRINUSE;
+		goto done;
+	}
+	hlist_del_rcu(&hsk->socktab_links.hash_links);
+	hsk->port = port;
+	hsk->inet.inet_num = port;
+	hsk->inet.inet_sport = htons(hsk->port);
+	hlist_add_head_rcu(&hsk->socktab_links.hash_links,
+			   &socktab->buckets[homa_port_hash(port)]);
+done:
+	spin_unlock_bh(&socktab->write_lock);
+	homa_sock_unlock(hsk);
+	return result;
+}
+
+/**
+ * homa_sock_find() - Returns the socket associated with a given port.
+ * @socktab:    Hash table in which to perform lookup.
+ * @port:       The port of interest.
+ * Return:      The socket that owns @port, or NULL if none.
+ *
+ * Note: this function uses RCU list-searching facilities, but it doesn't
+ * call rcu_read_lock. The caller should do that, if the caller cares (this
+ * way, the caller's use of the socket will also be protected).
+ */
+struct homa_sock *homa_sock_find(struct homa_socktab *socktab,  __u16 port)
+{
+	struct homa_socktab_links *link;
+	struct homa_sock *result = NULL;
+
+	hlist_for_each_entry_rcu(link, &socktab->buckets[homa_port_hash(port)],
+				 hash_links) {
+		struct homa_sock *hsk = link->sock;
+
+		if (hsk->port == port) {
+			result = hsk;
+			break;
+		}
+	}
+	return result;
+}
+
+/**
+ * homa_sock_lock_slow() - This function implements the slow path for
+ * acquiring a socketC lock. It is invoked when a socket lock isn't immediately
+ * available. It waits for the lock, but also records statistics about
+ * the waiting time.
+ * @hsk:    socket to  lock.
+ */
+void homa_sock_lock_slow(struct homa_sock *hsk)
+	__acquires(&hsk->lock)
+{
+	spin_lock_bh(&hsk->lock);
+}
+
+/**
+ * homa_bucket_lock_slow() - This function implements the slow path for
+ * locking a bucket in one of the hash tables of RPCs. It is invoked when a
+ * lock isn't immediately available. It waits for the lock, but also records
+ * statistics about the waiting time.
+ * @bucket:    The hash table bucket to lock.
+ * @id:        ID of the particular RPC being locked (multiple RPCs may
+ *             share a single bucket lock).
+ */
+void homa_bucket_lock_slow(struct homa_rpc_bucket *bucket, __u64 id)
+	__acquires(&bucket->lock)
+{
+	spin_lock_bh(&bucket->lock);
+}
diff --git a/net/homa/homa_sock.h b/net/homa/homa_sock.h
new file mode 100644
index 000000000000..48ae69ec05bb
--- /dev/null
+++ b/net/homa/homa_sock.h
@@ -0,0 +1,410 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
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
+void     homa_sock_lock_slow(struct homa_sock *hsk);
+
+/**
+ * define HOMA_SOCKTAB_BUCKETS - Number of hash buckets in a homa_socktab.
+ * Must be a power of 2.
+ */
+#define HOMA_SOCKTAB_BUCKETS 1024
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
+	 * consist of homa_socktab_link objects.
+	 */
+	struct hlist_head buckets[HOMA_SOCKTAB_BUCKETS];
+
+	/**
+	 * @active_scans: List of homa_socktab_scan structs for all scans
+	 * currently underway on this homa_socktab.
+	 */
+	struct list_head active_scans;
+};
+
+/**
+ * struct homa_socktab_links - Used to link homa_socks into the hash chains
+ * of a homa_socktab.
+ */
+struct homa_socktab_links {
+	/** @hash_links: links this element into the hash chain. */
+	struct hlist_node hash_links;
+
+	/** @sock: Homa socket structure. */
+	struct homa_sock *sock;
+};
+
+/**
+ * struct homa_socktab_scan - Records the state of an iteration over all
+ * the entries in a homa_socktab, in a way that permits RCU-safe deletion
+ * of entries.
+ */
+struct homa_socktab_scan {
+	/** @socktab: The table that is being scanned. */
+	struct homa_socktab *socktab;
+
+	/**
+	 * @current_bucket: the index of the bucket in socktab->buckets
+	 * currently being scanned. If >= HOMA_SOCKTAB_BUCKETS, the scan
+	 * is complete.
+	 */
+	int current_bucket;
+
+	/**
+	 * @next: the next socket to return from homa_socktab_next (this
+	 * socket has not yet been returned). NULL means there are no
+	 * more sockets in the current bucket.
+	 */
+	struct homa_socktab_links *next;
+
+	/**
+	 * @scan_links: Used to link this scan into @socktab->scans.
+	 */
+	struct list_head scan_links;
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
+	 * the bucket. Must be held whenever manipulating an RPC in
+	 * this bucket. This dual purpose permits clean and safe
+	 * deletion and garbage collection of RPCs.
+	 */
+	spinlock_t lock;
+
+	/** @rpcs: list of RPCs that hash to this bucket. */
+	struct hlist_head rpcs;
+
+	/**
+	 * @id: identifier for this bucket, used in error messages etc.
+	 * It's the index of the bucket within its hash table bucket
+	 * array, with an additional offset to separate server and
+	 * client RPCs.
+	 */
+	int id;
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
+	 * @lock: Must be held when modifying fields such as interests
+	 * and lists of RPCs. This lock is used in place of sk->sk_lock
+	 * because it's used differently (it's always used as a simple
+	 * spin lock).  See sync.txt for more on Homa's synchronization
+	 * strategy.
+	 */
+	spinlock_t lock;
+
+	/**
+	 * @last_locker: identifies the code that most recently acquired
+	 * @lock successfully. Occasionally used for debugging.
+	 */
+	char *last_locker;
+
+	/**
+	 * @protect_count: counts the number of calls to homa_protect_rpcs
+	 * for which there have not yet been calls to homa_unprotect_rpcs.
+	 * See sync.txt for more info.
+	 */
+	atomic_t protect_count;
+
+	/**
+	 * @homa: Overall state about the Homa implementation. NULL
+	 * means this socket has been deleted.
+	 */
+	struct homa *homa;
+
+	/**
+	 * @shutdown: True means the socket is no longer usable (either
+	 * shutdown has already been invoked, or the socket was never
+	 * properly initialized).
+	 */
+	bool shutdown;
+
+	/**
+	 * @port: Port number: identifies this socket uniquely among all
+	 * those on this node.
+	 */
+	__u16 port;
+
+	/**
+	 * @ip_header_length: Length of IP headers for this socket (depends
+	 * on IPv4 vs. IPv6).
+	 */
+	int ip_header_length;
+
+	/**
+	 * @socktab_links: Links this socket into the homa_socktab
+	 * based on @port.
+	 */
+	struct homa_socktab_links socktab_links;
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
+	 * @dead_rpcs: Contains RPCs for which homa_rpc_free has been
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
+	 * @ready_requests: Contains server RPCs whose request message is
+	 * in a state requiring attention from  a user process. The head is
+	 * oldest, i.e. next to return.
+	 */
+	struct list_head ready_requests;
+
+	/**
+	 * @ready_responses: Contains client RPCs whose response message is
+	 * in a state requiring attention from a user process. The head is
+	 * oldest, i.e. next to return.
+	 */
+	struct list_head ready_responses;
+
+	/**
+	 * @request_interests: List of threads that want to receive incoming
+	 * request messages.
+	 */
+	struct list_head request_interests;
+
+	/**
+	 * @response_interests: List of threads that want to receive incoming
+	 * response messages.
+	 */
+	struct list_head response_interests;
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
+
+	/**
+	 * @buffer_pool: used to allocate buffer space for incoming messages.
+	 * Storage is dynamically allocated.
+	 */
+	struct homa_pool *buffer_pool;
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
+void               homa_bucket_lock_slow(struct homa_rpc_bucket *bucket,
+					 __u64 id);
+int                homa_sock_bind(struct homa_socktab *socktab,
+				  struct homa_sock *hsk, __u16 port);
+void               homa_sock_destroy(struct homa_sock *hsk);
+struct homa_sock  *homa_sock_find(struct homa_socktab *socktab, __u16 port);
+int                homa_sock_init(struct homa_sock *hsk, struct homa *homa);
+void               homa_sock_shutdown(struct homa_sock *hsk);
+void               homa_sock_unlink(struct homa_sock *hsk);
+int                homa_socket(struct sock *sk);
+void               homa_socktab_destroy(struct homa_socktab *socktab);
+void               homa_socktab_end_scan(struct homa_socktab_scan *scan);
+void               homa_socktab_init(struct homa_socktab *socktab);
+struct homa_sock  *homa_socktab_next(struct homa_socktab_scan *scan);
+struct homa_sock  *homa_socktab_start_scan(struct homa_socktab *socktab,
+					   struct homa_socktab_scan *scan);
+
+/**
+ * homa_sock_lock() - Acquire the lock for a socket. If the socket
+ * isn't immediately available, record stats on the waiting time.
+ * @hsk:     Socket to lock.
+ * @locker:  Static string identifying where the socket was locked;
+ *           used to track down deadlocks.
+ */
+static inline void homa_sock_lock(struct homa_sock *hsk, const char *locker)
+	__acquires(&hsk->lock)
+{
+	if (!spin_trylock_bh(&hsk->lock))
+		homa_sock_lock_slow(hsk);
+}
+
+/**
+ * homa_sock_unlock() - Release the lock for a socket.
+ * @hsk:   Socket to lock.
+ */
+static inline void homa_sock_unlock(struct homa_sock *hsk)
+	__releases(&hsk->lock)
+{
+	spin_unlock_bh(&hsk->lock);
+}
+
+/**
+ * homa_port_hash() - Hash function for port numbers.
+ * @port:   Port number being looked up.
+ *
+ * Return:  The index of the bucket in which this port will be found (if
+ *          it exists.
+ */
+static inline int homa_port_hash(__u16 port)
+{
+	/* We can use a really simple hash function here because client
+	 * port numbers are allocated sequentially and server port numbers
+	 * are unpredictable.
+	 */
+	return port & (HOMA_SOCKTAB_BUCKETS - 1);
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
+static inline struct homa_rpc_bucket *homa_client_rpc_bucket(struct homa_sock *hsk,
+							     __u64 id)
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
+static inline struct homa_rpc_bucket *homa_server_rpc_bucket(struct homa_sock *hsk,
+							     __u64 id)
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
+ * @bucket:    Bucket to lock
+ * @id:        ID of the RPC that is requesting the lock. Normally ignored,
+ *             but used occasionally for diagnostics and debugging.
+ * @locker:    Static string identifying the locking code. Normally ignored,
+ *             but used occasionally for diagnostics and debugging.
+ */
+static inline void homa_bucket_lock(struct homa_rpc_bucket *bucket,
+				    __u64 id, const char *locker)
+{
+	if (!spin_trylock_bh(&bucket->lock))
+		homa_bucket_lock_slow(bucket, id);
+}
+
+/**
+ * homa_bucket_unlock() - Release the lock for an RPC hash table bucket.
+ * @bucket:   Bucket to unlock.
+ * @id:       ID of the RPC that was using the lock.
+ */
+static inline void homa_bucket_unlock(struct homa_rpc_bucket *bucket, __u64 id)
+	__releases(&bucket->lock)
+{
+	spin_unlock_bh(&bucket->lock);
+}
+
+static inline struct homa_sock *homa_sk(const struct sock *sk)
+{
+	return (struct homa_sock *)sk;
+}
+
+#endif /* _HOMA_SOCK_H */
-- 
2.34.1


