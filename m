Return-Path: <netdev+bounces-193327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AF0AC38A0
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6E916BB59
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 04:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651C81BD9C1;
	Mon, 26 May 2025 04:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="TxrLQCqw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85251CAA65
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 04:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748233754; cv=none; b=bERzwJxMYv7idvQtKk53uyxHBqKE+5tL0+Z2GYpE8uqEWJT/Yccvpxcmxql1zhy1NVZgX6ziuzbf6PWZTEkDfY0SrqeigIh7rXwIiwC44ylCIzRdjfaCIyuWx1aIihdDiPmV6knyyCbKBgLsLZCPDjiAkUJIFXdp5/62GVPhElQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748233754; c=relaxed/simple;
	bh=hDYCePE88w9+3xJn0QWF9hTLU9f3hYwb2OPIqHVigv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sielfA90YAUxk1uHQlvPOihsrKmvggmqpWS305USML9xuNn2+FK9aR6wr3Szmm5gjOHzo65P5jX4y+S0NeAqJMZLSWh3G8DyyLVekvXhmT2TVWzCFe+ATE518hLBU04MmnucrsGDv2KmoV1ZFIyXbc9Y81764718Ly9wpxfzVS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=TxrLQCqw; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2SkKNvEdSs+6wU/kHWEbOcBQPDAzlNO3qZu/AfZ2pLM=; t=1748233751; x=1749097751; 
	b=TxrLQCqwRbWpOjoriVT7r/Bz6BjPnedd9KD8IZC6bbabB21of5gwIxf+b0JN1EYYS0Y2dHs3UD9
	0ble38JPXYEXZe4HmtMmtbGv2MK5tRoWs+QyPwI8AfvmDQLw9O5m0Brh6dWi3Cspd1bmX8jCDqsGe
	p1vLjg3b/r0v9oiqB4/2L9OYPny4AwJpjPsTlUVzbSg54RMZ/5oBi78V03tM6x29hxgv5a9gHjahf
	pR402N/8XwBVzwTGC8xnfMuKIuQEwBj2hJjgDvLBROxErnsPOUx4lP4iqEKdt69sbnAvm05C+SQrr
	Mdc/hsBdHqFp+nQwr63Wt4T4GWn6750szqQw==;
Received: from 70-228-78-207.lightspeed.sntcca.sbcglobal.net ([70.228.78.207]:54961 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uJPSX-0006Qy-Oh; Sun, 25 May 2025 21:29:11 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v9 12/15] net: homa: create homa_incoming.c
Date: Sun, 25 May 2025 21:28:14 -0700
Message-ID: <20250526042819.2526-13-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250526042819.2526-1-ouster@cs.stanford.edu>
References: <20250526042819.2526-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 30c11f1097f8a6d8734ac6ba305ffda0

This file contains most of the code for handling incoming packets,
including top-level dispatching code plus specific handlers for each
pack type. It also contains code for dispatching fully-received
messages to waiting application threads.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v9:
* Add support for homa_net objects
* Use new homa_clock abstraction layer
* Various name improvements (e.g. use "alloc" instead of "new" for functions
  that allocate memory)

Changes for v7:
* API change for homa_rpc_handoff
* Refactor waiting mechanism for incoming packets: simplify wait
  criteria and use standard Linux mechanisms for waiting, use
  new homa_interest struct
* Reject unauthorized incoming request messages
* Improve documentation for code that spins (and reduce spin length)
* Use RPC reference counts, eliminate RPC_HANDING_OFF flag
* Replace erroneous use of "safe" list iteration with "rcu" version
* Remove locker argument from locking functions
* Check incoming messages against HOMA_MAX_MESSAGE_LENGTH
* Use u64 and __u64 properly
---
 net/homa/homa_impl.h     |  15 +
 net/homa/homa_incoming.c | 827 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 842 insertions(+)
 create mode 100644 net/homa/homa_incoming.c

diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
index af18ceac2e0d..4f9fd9997d28 100644
--- a/net/homa/homa_impl.h
+++ b/net/homa/homa_impl.h
@@ -385,21 +385,36 @@ static inline bool homa_make_header_avl(struct sk_buff *skb)
 
 extern unsigned int homa_net_id;
 
+void     homa_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
+		      struct homa_rpc *rpc);
+void     homa_add_packet(struct homa_rpc *rpc, struct sk_buff *skb);
+int      homa_copy_to_user(struct homa_rpc *rpc);
+void     homa_data_pkt(struct sk_buff *skb, struct homa_rpc *rpc);
 void     homa_destroy(struct homa *homa);
+void     homa_dispatch_pkts(struct sk_buff *skb);
 int      homa_fill_data_interleaved(struct homa_rpc *rpc,
 				    struct sk_buff *skb, struct iov_iter *iter);
+struct homa_gap *homa_gap_alloc(struct list_head *next, int start, int end);
+void     homa_gap_retry(struct homa_rpc *rpc);
 int      homa_init(struct homa *homa);
 int      homa_message_out_fill(struct homa_rpc *rpc,
 			       struct iov_iter *iter, int xmit);
 void     homa_message_out_init(struct homa_rpc *rpc, int length);
+void     homa_need_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
+			   struct homa_rpc *rpc);
 void     homa_net_destroy(struct homa_net *hnet);
 int      homa_net_init(struct homa_net *hnet, struct net *net,
 		       struct homa *homa);
+void     homa_resend_pkt(struct sk_buff *skb, struct homa_rpc *rpc,
+			 struct homa_sock *hsk);
 void     homa_rpc_handoff(struct homa_rpc *rpc);
 void     homa_spin(int ns);
 struct sk_buff *homa_tx_data_pkt_alloc(struct homa_rpc *rpc,
 				       struct iov_iter *iter, int offset,
 				       int length, int max_seg_data);
+void     homa_rpc_unknown_pkt(struct sk_buff *skb, struct homa_rpc *rpc);
+int      homa_wait_private(struct homa_rpc *rpc, int nonblocking);
+struct homa_rpc *homa_wait_shared(struct homa_sock *hsk, int nonblocking);
 int      homa_xmit_control(enum homa_packet_type type, void *contents,
 			   size_t length, struct homa_rpc *rpc);
 int      __homa_xmit_control(void *contents, size_t length,
diff --git a/net/homa/homa_incoming.c b/net/homa/homa_incoming.c
new file mode 100644
index 000000000000..0fcb17f332f9
--- /dev/null
+++ b/net/homa/homa_incoming.c
@@ -0,0 +1,827 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+/* This file contains functions that handle incoming Homa messages. */
+
+#include "homa_impl.h"
+#include "homa_interest.h"
+#include "homa_peer.h"
+#include "homa_pool.h"
+
+/**
+ * homa_message_in_init() - Constructor for homa_message_in.
+ * @rpc:          RPC whose msgin structure should be initialized. The
+ *                msgin struct is assumed to be zeroes.
+ * @length:       Total number of bytes in message.
+ * Return:        Zero for successful initialization, or a negative errno
+ *                if rpc->msgin could not be initialized.
+ */
+int homa_message_in_init(struct homa_rpc *rpc, int length)
+	__must_hold(rpc_bucket_lock)
+{
+	int err;
+
+	if (length > HOMA_MAX_MESSAGE_LENGTH)
+		return -EINVAL;
+
+	rpc->msgin.length = length;
+	skb_queue_head_init(&rpc->msgin.packets);
+	INIT_LIST_HEAD(&rpc->msgin.gaps);
+	rpc->msgin.bytes_remaining = length;
+	err = homa_pool_alloc_msg(rpc);
+	if (err != 0) {
+		rpc->msgin.length = -1;
+		return err;
+	}
+	return 0;
+}
+
+/**
+ * homa_gap_alloc() - Allocate a new gap and add it to a gap list.
+ * @next:   Add the new gap just before this list element.
+ * @start:  Offset of first byte covered by the gap.
+ * @end:    Offset of byte just after the last one covered by the gap.
+ * Return:  Pointer to the new gap, or NULL if memory couldn't be allocated
+ *          for the gap object.
+ */
+struct homa_gap *homa_gap_alloc(struct list_head *next, int start, int end)
+{
+	struct homa_gap *gap;
+
+	gap = kmalloc(sizeof(*gap), GFP_ATOMIC);
+	if (!gap)
+		return NULL;
+	gap->start = start;
+	gap->end = end;
+	gap->time = homa_clock();
+	list_add_tail(&gap->links, next);
+	return gap;
+}
+
+/**
+ * homa_gap_retry() - Send RESEND requests for all of the unreceived
+ * gaps in a message.
+ * @rpc:     RPC to check; must be locked by caller.
+ */
+void homa_gap_retry(struct homa_rpc *rpc)
+	__must_hold(rpc_bucket_lock)
+{
+	struct homa_resend_hdr resend;
+	struct homa_gap *gap;
+
+	list_for_each_entry(gap, &rpc->msgin.gaps, links) {
+		resend.offset = htonl(gap->start);
+		resend.length = htonl(gap->end - gap->start);
+		homa_xmit_control(RESEND, &resend, sizeof(resend), rpc);
+	}
+}
+
+/**
+ * homa_add_packet() - Add an incoming packet to the contents of a
+ * partially received message.
+ * @rpc:   Add the packet to the msgin for this RPC.
+ * @skb:   The new packet. This function takes ownership of the packet
+ *         (the packet will either be freed or added to rpc->msgin.packets).
+ */
+void homa_add_packet(struct homa_rpc *rpc, struct sk_buff *skb)
+	__must_hold(rpc_bucket_lock)
+{
+	struct homa_data_hdr *h = (struct homa_data_hdr *)skb->data;
+	struct homa_gap *gap, *dummy, *gap2;
+	int start = ntohl(h->seg.offset);
+	int length = homa_data_len(skb);
+	int end = start + length;
+
+	if ((start + length) > rpc->msgin.length)
+		goto discard;
+
+	if (start == rpc->msgin.recv_end) {
+		/* Common case: packet is sequential. */
+		rpc->msgin.recv_end += length;
+		goto keep;
+	}
+
+	if (start > rpc->msgin.recv_end) {
+		/* Packet creates a new gap. */
+		if (!homa_gap_alloc(&rpc->msgin.gaps,
+				    rpc->msgin.recv_end, start)) {
+			pr_err("Homa couldn't allocate gap: insufficient memory\n");
+			goto discard;
+		}
+		rpc->msgin.recv_end = end;
+		goto keep;
+	}
+
+	/* Must now check to see if the packet fills in part or all of
+	 * an existing gap.
+	 */
+	list_for_each_entry_safe(gap, dummy, &rpc->msgin.gaps, links) {
+		/* Is packet at the start of this gap? */
+		if (start <= gap->start) {
+			if (end <= gap->start)
+				continue;
+			if (start < gap->start)
+				goto discard;
+			if (end > gap->end)
+				goto discard;
+			gap->start = end;
+			if (gap->start >= gap->end) {
+				list_del(&gap->links);
+				kfree(gap);
+			}
+			goto keep;
+		}
+
+		/* Is packet at the end of this gap? BTW, at this point we know
+		 * the packet can't cover the entire gap.
+		 */
+		if (end >= gap->end) {
+			if (start >= gap->end)
+				continue;
+			if (end > gap->end)
+				goto discard;
+			gap->end = start;
+			goto keep;
+		}
+
+		/* Packet is in the middle of the gap; must split the gap. */
+		gap2 = homa_gap_alloc(&gap->links, gap->start, start);
+		if (!gap2) {
+			pr_err("Homa couldn't allocate gap for split: insufficient memory\n");
+			goto discard;
+		}
+		gap2->time = gap->time;
+		gap->start = end;
+		goto keep;
+	}
+
+discard:
+	kfree_skb(skb);
+	return;
+
+keep:
+	__skb_queue_tail(&rpc->msgin.packets, skb);
+	rpc->msgin.bytes_remaining -= length;
+}
+
+/**
+ * homa_copy_to_user() - Copy as much data as possible from incoming
+ * packet buffers to buffers in user space.
+ * @rpc:     RPC for which data should be copied. Must be locked by caller.
+ * Return:   Zero for success or a negative errno if there is an error.
+ *           It is possible for the RPC to be freed while this function
+ *           executes (it releases and reacquires the RPC lock). If that
+ *           happens, -EINVAL will be returned and the state of @rpc
+ *           will be RPC_DEAD. Clears the RPC_PKTS_READY bit in @rpc->flags
+ *           if all available packets have been copied out.
+ */
+int homa_copy_to_user(struct homa_rpc *rpc)
+	__must_hold(rpc_bucket_lock)
+{
+#define MAX_SKBS 20
+	struct sk_buff *skbs[MAX_SKBS];
+	int error = 0;
+	int n = 0;             /* Number of filled entries in skbs. */
+	int i;
+
+	/* Tricky note: we can't hold the RPC lock while we're actually
+	 * copying to user space, because (a) it's illegal to hold a spinlock
+	 * while copying to user space and (b) we'd like for homa_softirq
+	 * to add more packets to the RPC while we're copying these out.
+	 * So, collect a bunch of packets to copy, then release the lock,
+	 * copy them, and reacquire the lock.
+	 */
+	while (true) {
+		struct sk_buff *skb;
+
+		if (rpc->state == RPC_DEAD) {
+			error = -EINVAL;
+			break;
+		}
+
+		skb = __skb_dequeue(&rpc->msgin.packets);
+		if (skb) {
+			skbs[n] = skb;
+			n++;
+			if (n < MAX_SKBS)
+				continue;
+		}
+		if (n == 0) {
+			atomic_andnot(RPC_PKTS_READY, &rpc->flags);
+			break;
+		}
+
+		/* At this point we've collected a batch of packets (or
+		 * run out of packets); copy any available packets out to
+		 * user space.
+		 */
+		homa_rpc_hold(rpc);
+		homa_rpc_unlock(rpc);
+
+		/* Each iteration of this loop copies out one skb. */
+		for (i = 0; i < n; i++) {
+			struct homa_data_hdr *h = (struct homa_data_hdr *)
+					skbs[i]->data;
+			int pkt_length = homa_data_len(skbs[i]);
+			int offset = ntohl(h->seg.offset);
+			int buf_bytes, chunk_size;
+			struct iov_iter iter;
+			int copied = 0;
+			char __user *dst;
+
+			/* Each iteration of this loop copies to one
+			 * user buffer.
+			 */
+			while (copied < pkt_length) {
+				chunk_size = pkt_length - copied;
+				dst = homa_pool_get_buffer(rpc, offset + copied,
+							   &buf_bytes);
+				if (buf_bytes < chunk_size) {
+					if (buf_bytes == 0) {
+						/* skb has data beyond message
+						 * end?
+						 */
+						break;
+					}
+					chunk_size = buf_bytes;
+				}
+				error = import_ubuf(READ, dst, chunk_size,
+						    &iter);
+				if (error)
+					goto free_skbs;
+				error = skb_copy_datagram_iter(skbs[i],
+							       sizeof(*h) +
+							       copied,  &iter,
+							       chunk_size);
+				if (error)
+					goto free_skbs;
+				copied += chunk_size;
+			}
+		}
+
+free_skbs:
+		for (i = 0; i < n; i++)
+			kfree_skb(skbs[i]);
+		n = 0;
+		atomic_or(APP_NEEDS_LOCK, &rpc->flags);
+		homa_rpc_lock(rpc);
+		atomic_andnot(APP_NEEDS_LOCK, &rpc->flags);
+		homa_rpc_put(rpc);
+		if (error)
+			break;
+	}
+	return error;
+}
+
+/**
+ * homa_dispatch_pkts() - Top-level function that processes a batch of packets,
+ * all related to the same RPC.
+ * @skb:       First packet in the batch, linked through skb->next.
+ */
+void homa_dispatch_pkts(struct sk_buff *skb)
+{
+#define MAX_ACKS 10
+	const struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
+	struct homa_data_hdr *h = (struct homa_data_hdr *)skb->data;
+	u64 id = homa_local_id(h->common.sender_id);
+	int dport = ntohs(h->common.dport);
+
+	/* Used to collect acks from data packets so we can process them
+	 * all at the end (can't process them inline because that may
+	 * require locking conflicting RPCs). If we run out of space just
+	 * ignore the extra acks; they'll be regenerated later through the
+	 * explicit mechanism.
+	 */
+	struct homa_ack acks[MAX_ACKS];
+	struct homa_rpc *rpc = NULL;
+	struct homa_sock *hsk;
+	struct homa_net *hnet;
+	struct sk_buff *next;
+	int num_acks = 0;
+
+	/* Find the appropriate socket.*/
+	hnet = homa_net_from_skb(skb);
+	hsk = homa_sock_find(hnet, dport);
+	if (!hsk || (!homa_is_client(id) && !hsk->is_server)) {
+		if (skb_is_ipv6(skb))
+			icmp6_send(skb, ICMPV6_DEST_UNREACH,
+				   ICMPV6_PORT_UNREACH, 0, NULL, IP6CB(skb));
+		else
+			icmp_send(skb, ICMP_DEST_UNREACH,
+				  ICMP_PORT_UNREACH, 0);
+		while (skb) {
+			next = skb->next;
+			kfree_skb(skb);
+			skb = next;
+		}
+		if (hsk)
+			sock_put(&hsk->sock);
+		return;
+	}
+
+	/* Each iteration through the following loop processes one packet. */
+	for (; skb; skb = next) {
+		h = (struct homa_data_hdr *)skb->data;
+		next = skb->next;
+
+		/* Relinquish the RPC lock temporarily if it's needed
+		 * elsewhere.
+		 */
+		if (rpc) {
+			int flags = atomic_read(&rpc->flags);
+
+			if (flags & APP_NEEDS_LOCK) {
+				homa_rpc_unlock(rpc);
+
+				/* This short spin is needed to ensure that the
+				 * other thread gets the lock before this thread
+				 * grabs it again below (the need for this
+				 * was confirmed experimentally in 2/2025;
+				 * without it, the handoff fails 20-25% of the
+				 * time). Furthermore, the call to homa_spin
+				 * seems to allow the other thread to acquire
+				 * the lock more quickly.
+				 */
+				homa_spin(100);
+				rpc = NULL;
+			}
+		}
+
+		/* Find and lock the RPC if we haven't already done so. */
+		if (!rpc) {
+			if (!homa_is_client(id)) {
+				/* We are the server for this RPC. */
+				if (h->common.type == DATA) {
+					int created;
+
+					/* Create a new RPC if one doesn't
+					 * already exist.
+					 */
+					rpc = homa_rpc_alloc_server(hsk, &saddr,
+								    h,
+								    &created);
+					if (IS_ERR(rpc)) {
+						pr_warn("homa_pkt_dispatch couldn't create server rpc: error %lu",
+							-PTR_ERR(rpc));
+						rpc = NULL;
+						goto discard;
+					}
+				} else {
+					rpc = homa_rpc_find_server(hsk, &saddr,
+								   id);
+				}
+			} else {
+				rpc = homa_rpc_find_client(hsk, id);
+			}
+		}
+		if (unlikely(!rpc)) {
+			if (h->common.type != NEED_ACK &&
+			    h->common.type != ACK &&
+			    h->common.type != RESEND)
+				goto discard;
+		} else {
+			if (h->common.type == DATA ||
+			    h->common.type == BUSY ||
+			    h->common.type == NEED_ACK)
+				rpc->silent_ticks = 0;
+			rpc->peer->outstanding_resends = 0;
+		}
+
+		switch (h->common.type) {
+		case DATA:
+			if (h->ack.client_id) {
+				/* Save the ack for processing later, when we
+				 * have released the RPC lock.
+				 */
+				if (num_acks < MAX_ACKS) {
+					acks[num_acks] = h->ack;
+					num_acks++;
+				}
+			}
+			homa_data_pkt(skb, rpc);
+			break;
+		case RESEND:
+			homa_resend_pkt(skb, rpc, hsk);
+			break;
+		case RPC_UNKNOWN:
+			homa_rpc_unknown_pkt(skb, rpc);
+			break;
+		case BUSY:
+			/* Nothing to do for these packets except reset
+			 * silent_ticks, which happened above.
+			 */
+			goto discard;
+		case NEED_ACK:
+			homa_need_ack_pkt(skb, hsk, rpc);
+			break;
+		case ACK:
+			homa_ack_pkt(skb, hsk, rpc);
+			break;
+			goto discard;
+		}
+		continue;
+
+discard:
+		kfree_skb(skb);
+	}
+	if (rpc)
+		homa_rpc_unlock(rpc);
+
+	while (num_acks > 0) {
+		num_acks--;
+		homa_rpc_acked(hsk, &saddr, &acks[num_acks]);
+	}
+
+	if (hsk->dead_skbs >= 2 * hsk->homa->dead_buffs_limit)
+		/* We get here if other approaches are not keeping up with
+		 * reaping dead RPCs. See "RPC Reaping Strategy" in
+		 * homa_rpc_reap code for details.
+		 */
+		homa_rpc_reap(hsk, false);
+	sock_put(&hsk->sock);
+}
+
+/**
+ * homa_data_pkt() - Handler for incoming DATA packets
+ * @skb:     Incoming packet; size known to be large enough for the header.
+ *           This function now owns the packet.
+ * @rpc:     Information about the RPC corresponding to this packet.
+ *           Must be locked by the caller.
+ */
+void homa_data_pkt(struct sk_buff *skb, struct homa_rpc *rpc)
+	__must_hold(rpc_bucket_lock)
+{
+	struct homa_data_hdr *h = (struct homa_data_hdr *)skb->data;
+
+	if (rpc->state != RPC_INCOMING && homa_is_client(rpc->id)) {
+		if (unlikely(rpc->state != RPC_OUTGOING))
+			goto discard;
+		rpc->state = RPC_INCOMING;
+		if (homa_message_in_init(rpc, ntohl(h->message_length)) != 0)
+			goto discard;
+	} else if (rpc->state != RPC_INCOMING) {
+		/* Must be server; note that homa_rpc_alloc_server already
+		 * initialized msgin and allocated buffers.
+		 */
+		if (unlikely(rpc->msgin.length >= 0))
+			goto discard;
+	}
+
+	if (rpc->msgin.num_bpages == 0)
+		/* Drop packets that arrive when we can't allocate buffer
+		 * space. If we keep them around, packet buffer usage can
+		 * exceed available cache space, resulting in poor
+		 * performance.
+		 */
+		goto discard;
+
+	homa_add_packet(rpc, skb);
+
+	if (skb_queue_len(&rpc->msgin.packets) != 0 &&
+	    !(atomic_read(&rpc->flags) & RPC_PKTS_READY)) {
+		atomic_or(RPC_PKTS_READY, &rpc->flags);
+		homa_rpc_handoff(rpc);
+	}
+
+	return;
+
+discard:
+	kfree_skb(skb);
+}
+
+/**
+ * homa_resend_pkt() - Handler for incoming RESEND packets
+ * @skb:     Incoming packet; size already verified large enough for header.
+ *           This function now owns the packet.
+ * @rpc:     Information about the RPC corresponding to this packet; must
+ *           be locked by caller, but may be NULL if there is no RPC matching
+ *           this packet
+ * @hsk:     Socket on which the packet was received.
+ */
+void homa_resend_pkt(struct sk_buff *skb, struct homa_rpc *rpc,
+		     struct homa_sock *hsk)
+	__must_hold(rpc_bucket_lock)
+{
+	struct homa_resend_hdr *h = (struct homa_resend_hdr *)skb->data;
+	struct homa_busy_hdr busy;
+
+	if (!rpc) {
+		homa_xmit_unknown(skb, hsk);
+		goto done;
+	}
+
+	if (!homa_is_client(rpc->id) && rpc->state != RPC_OUTGOING) {
+		/* We are the server for this RPC and don't yet have a
+		 * response packet, so just send BUSY.
+		 */
+		homa_xmit_control(BUSY, &busy, sizeof(busy), rpc);
+		goto done;
+	}
+	if (ntohl(h->length) == 0)
+		/* This RESEND is from a server just trying to determine
+		 * whether the client still cares about the RPC; return
+		 * BUSY so the server doesn't time us out.
+		 */
+		homa_xmit_control(BUSY, &busy, sizeof(busy), rpc);
+	homa_resend_data(rpc, ntohl(h->offset),
+			 ntohl(h->offset) + ntohl(h->length));
+
+done:
+	kfree_skb(skb);
+}
+
+/**
+ * homa_rpc_unknown_pkt() - Handler for incoming RPC_UNKNOWN packets.
+ * @skb:     Incoming packet; size known to be large enough for the header.
+ *           This function now owns the packet.
+ * @rpc:     Information about the RPC corresponding to this packet. Must
+ *           be locked by caller.
+ */
+void homa_rpc_unknown_pkt(struct sk_buff *skb, struct homa_rpc *rpc)
+	__must_hold(rpc_bucket_lock)
+{
+	if (homa_is_client(rpc->id)) {
+		if (rpc->state == RPC_OUTGOING) {
+			/* It appears that everything we've already transmitted
+			 * has been lost; retransmit it.
+			 */
+			homa_resend_data(rpc, 0, rpc->msgout.next_xmit_offset);
+			goto done;
+		}
+	} else {
+		homa_rpc_end(rpc);
+	}
+done:
+	kfree_skb(skb);
+}
+
+/**
+ * homa_need_ack_pkt() - Handler for incoming NEED_ACK packets
+ * @skb:     Incoming packet; size already verified large enough for header.
+ *           This function now owns the packet.
+ * @hsk:     Socket on which the packet was received.
+ * @rpc:     The RPC named in the packet header, or NULL if no such
+ *           RPC exists. The RPC has been locked by the caller.
+ */
+void homa_need_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
+		       struct homa_rpc *rpc)
+	__must_hold(rpc_bucket_lock)
+{
+	struct homa_common_hdr *h = (struct homa_common_hdr *)skb->data;
+	const struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
+	u64 id = homa_local_id(h->sender_id);
+	struct homa_peer *peer;
+	struct homa_ack_hdr ack;
+
+	/* Return if it's not safe for the peer to purge its state
+	 * for this RPC (the RPC still exists and we haven't received
+	 * the entire response), or if we can't find peer info.
+	 */
+	if (rpc && (rpc->state != RPC_INCOMING ||
+		    rpc->msgin.bytes_remaining)) {
+		goto done;
+	} else {
+		peer = homa_peer_get(hsk, &saddr);
+		if (IS_ERR(peer))
+			goto done;
+	}
+
+	/* Send an ACK for this RPC. At the same time, include all of the
+	 * other acks available for the peer. Note: can't use rpc below,
+	 * since it may be NULL.
+	 */
+	ack.common.type = ACK;
+	ack.common.sport = h->dport;
+	ack.common.dport = h->sport;
+	ack.common.sender_id = cpu_to_be64(id);
+	ack.num_acks = htons(homa_peer_get_acks(peer,
+						HOMA_MAX_ACKS_PER_PKT,
+						ack.acks));
+	__homa_xmit_control(&ack, sizeof(ack), peer, hsk);
+	homa_peer_release(peer);
+
+done:
+	kfree_skb(skb);
+}
+
+/**
+ * homa_ack_pkt() - Handler for incoming ACK packets
+ * @skb:     Incoming packet; size already verified large enough for header.
+ *           This function now owns the packet.
+ * @hsk:     Socket on which the packet was received.
+ * @rpc:     The RPC named in the packet header, or NULL if no such
+ *           RPC exists. The RPC lock will be dead on return.
+ */
+void homa_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
+		  struct homa_rpc *rpc)
+	__must_hold(rpc_bucket_lock)
+{
+	const struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
+	struct homa_ack_hdr *h = (struct homa_ack_hdr *)skb->data;
+	int i, count;
+
+	if (rpc)
+		homa_rpc_end(rpc);
+
+	count = ntohs(h->num_acks);
+	if (count > 0) {
+		if (rpc) {
+			/* Must temporarily release rpc's lock because
+			 * homa_rpc_acked needs to acquire RPC locks.
+			 */
+			homa_rpc_hold(rpc);
+			homa_rpc_unlock(rpc);
+			for (i = 0; i < count; i++)
+				homa_rpc_acked(hsk, &saddr, &h->acks[i]);
+			homa_rpc_lock(rpc);
+			homa_rpc_put(rpc);
+		} else {
+			for (i = 0; i < count; i++)
+				homa_rpc_acked(hsk, &saddr, &h->acks[i]);
+		}
+	}
+	kfree_skb(skb);
+}
+
+/**
+ * homa_wait_private() - Waits until the response has been received for
+ * a specific RPC or the RPC has failed with an error.
+ * @rpc:          RPC to wait for; an error will be returned if the RPC is
+ *                not a client RPC or not private. Must be locked by caller.
+ * @nonblocking:  Nonzero means return immediately if @rpc not ready.
+ * Return:  0 if the response has been successfully received, otherwise
+ *          a negative errno.
+ */
+int homa_wait_private(struct homa_rpc *rpc, int nonblocking)
+	__must_hold(&rpc->bucket->lock)
+{
+	struct homa_interest interest;
+	int result = 0;
+
+	if (!(atomic_read(&rpc->flags) & RPC_PRIVATE))
+		return -EINVAL;
+
+	homa_rpc_hold(rpc);
+
+	/* Each iteration through this loop waits until rpc needs attention
+	 * in some way (e.g. packets have arrived), then deals with that need
+	 * (e.g. copy to user space). It may take many iterations until the
+	 * RPC is ready for the application.
+	 */
+	while (1) {
+		if (!rpc->error)
+			rpc->error = homa_copy_to_user(rpc);
+		if (rpc->error) {
+			result = rpc->error;
+			break;
+		}
+		if (rpc->msgin.length >= 0 &&
+		    rpc->msgin.bytes_remaining == 0 &&
+		    skb_queue_len(&rpc->msgin.packets) == 0)
+			break;
+
+		result = homa_interest_init_private(&interest, rpc);
+		if (result != 0)
+			break;
+
+		homa_rpc_unlock(rpc);
+		result = homa_interest_wait(&interest, nonblocking);
+
+		atomic_or(APP_NEEDS_LOCK, &rpc->flags);
+		homa_rpc_lock(rpc);
+		atomic_andnot(APP_NEEDS_LOCK, &rpc->flags);
+		homa_interest_unlink_private(&interest);
+
+		/* If homa_interest_wait returned an error but the interest
+		 * actually got ready, then ignore the error.
+		 */
+		if (result != 0 && atomic_read(&interest.ready) == 0)
+			break;
+	}
+
+	homa_rpc_put(rpc);
+	return result;
+}
+
+/**
+ * homa_wait_shared() - Wait for the completion of any non-private
+ * incoming message on a socket.
+ * @hsk:          Socket on which to wait. Must not be locked.
+ * @nonblocking:  Nonzero means return immediately if no RPC is ready.
+ *
+ * Return:    Pointer to an RPC with a complete incoming message or nonzero
+ *            error field, or a negative errno (usually -EINTR). If an RPC
+ *            is returned it will be locked and the caller must unlock.
+ */
+struct homa_rpc *homa_wait_shared(struct homa_sock *hsk, int nonblocking)
+{
+	struct homa_interest interest;
+	struct homa_rpc *rpc;
+	int result;
+
+	INIT_LIST_HEAD(&interest.links);
+	init_waitqueue_head(&interest.wait_queue);
+	/* Each iteration through this loop waits until an RPC needs attention
+	 * in some way (e.g. packets have arrived), then deals with that need
+	 * (e.g. copy to user space). It may take many iterations until an
+	 * RPC is ready for the application.
+	 */
+	while (1) {
+		homa_sock_lock(hsk);
+		if (hsk->shutdown) {
+			rpc = ERR_PTR(-ESHUTDOWN);
+			homa_sock_unlock(hsk);
+			goto done;
+		}
+		if (!list_empty(&hsk->ready_rpcs)) {
+			rpc = list_first_entry(&hsk->ready_rpcs,
+					       struct homa_rpc,
+					       ready_links);
+			homa_rpc_hold(rpc);
+			list_del_init(&rpc->ready_links);
+			if (!list_empty(&hsk->ready_rpcs)) {
+				/* There are still more RPCs available, so
+				 * let Linux know.
+				 */
+				hsk->sock.sk_data_ready(&hsk->sock);
+			}
+			homa_sock_unlock(hsk);
+		} else {
+			homa_interest_init_shared(&interest, hsk);
+			homa_sock_unlock(hsk);
+			result = homa_interest_wait(&interest, nonblocking);
+			homa_interest_unlink_shared(&interest);
+
+			if (result != 0) {
+				/* If homa_interest_wait returned an error
+				 * (e.g. -EAGAIN) but in the meantime the
+				 * interest received a handoff, ignore the
+				 * error.
+				 */
+				if (atomic_read(&interest.ready) == 0) {
+					rpc = ERR_PTR(result);
+					goto done;
+				}
+			}
+
+			rpc = interest.rpc;
+			if (!rpc) {
+				rpc = ERR_PTR(-ESHUTDOWN);
+				goto done;
+			}
+		}
+
+		atomic_or(APP_NEEDS_LOCK, &rpc->flags);
+		homa_rpc_lock(rpc);
+		atomic_andnot(APP_NEEDS_LOCK, &rpc->flags);
+		homa_rpc_put(rpc);
+		if (!rpc->error)
+			rpc->error = homa_copy_to_user(rpc);
+		if (rpc->error) {
+			if (rpc->state != RPC_DEAD)
+				break;
+		} else if (rpc->msgin.bytes_remaining == 0 &&
+		    skb_queue_len(&rpc->msgin.packets) == 0)
+			break;
+		homa_rpc_unlock(rpc);
+	}
+
+done:
+	return rpc;
+}
+
+/**
+ * homa_rpc_handoff() - This function is called when the input message for
+ * an RPC is ready for attention from a user thread. It notifies a waiting
+ * reader and/or queues the RPC, as appropriate.
+ * @rpc:                RPC to handoff; must be locked.
+ */
+void homa_rpc_handoff(struct homa_rpc *rpc)
+	__must_hold(rpc_bucket_lock)
+{
+	struct homa_sock *hsk = rpc->hsk;
+	struct homa_interest *interest;
+
+	if (atomic_read(&rpc->flags) & RPC_PRIVATE) {
+		homa_interest_notify_private(rpc);
+		return;
+	}
+
+	/* Shared RPC; if there is a waiting thread, hand off the RPC;
+	 * otherwise enqueue it.
+	 */
+	homa_sock_lock(hsk);
+	if (!list_empty(&hsk->interests)) {
+		interest = list_first_entry(&hsk->interests,
+					    struct homa_interest, links);
+		list_del_init(&interest->links);
+		interest->rpc = rpc;
+		homa_rpc_hold(rpc);
+		atomic_set_release(&interest->ready, 1);
+		wake_up(&interest->wait_queue);
+	} else if (list_empty(&rpc->ready_links)) {
+		list_add_tail(&rpc->ready_links, &hsk->ready_rpcs);
+		hsk->sock.sk_data_ready(&hsk->sock);
+	}
+	homa_sock_unlock(hsk);
+}
+
-- 
2.43.0


