Return-Path: <netdev+bounces-158616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3988BA12B51
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 20:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390881888CA7
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 19:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429F71D7E42;
	Wed, 15 Jan 2025 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Unl0yWpS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DA71D88C4
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736967655; cv=none; b=Q/Mt42gvNpOw8BfBYAO7sH7wN2lcIOiewFMEwJya8DVf2SC2G+RcD5ipwzHOT6YGKWoepLq9jVRxpIliS+ln5Wwui1OD959bYRjRWZcpzzINgr7V1MCR3hjoA73UgSikpQPjHSID+tnMGbnzDDbrgNtbDmyiiXUV5Z8D79FPZtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736967655; c=relaxed/simple;
	bh=jy0pxHpdfTxcGKolwuyM4STcjkgXGXwsiJ+5BPKSa0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ueO/hMSI3Au0lGpcADrO9CSdfxLL+xoBe5da1QLgp+4icEOf8TR/0PgMmZYOX2QacKtbWu2Xl2pFLrqFt1ZAgrdD0kASxaXJ0WT52wXj0+eaSMZfXergyyH8ThuwrczSQyZB5qNUhQJJLColej6Vwr6LwEbJ4d+MCUxrn35KDWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Unl0yWpS; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jkk9KcNUWO2hygnaL7CwUSoV3G+iK+0K0HOgOQ2+UcE=; t=1736967624; x=1737831624; 
	b=Unl0yWpSOYAtAcSX3E3LbOvqtNI4XfpwB6LPKGWKeAA+ZNOtMz9uDb1yttD/bSlnEiTVybLgg2l
	qZ/FO2zi/dU0auinTDCoA8m1zUdabX2fjelX00JJ+a0Q1Jd15n5oBPWp27vOEJNde6pJSBN4GaGhG
	HxZ8sdCPLlDzUwqW+SZ7wMXLuNhSLyTD5amu8gFQUV1Ad1KHIajPA6PDlOZDn4gDDcNkozszcHXzt
	H0mGnHE6GZ/gBBb+qGggRAB4HYPa1BINHOj+Wgzfyq1pd64dzWJnEJhvM63OCPZ6Q+AMMsgdybGUv
	i+rEBFjjOS2EZk14gz1iqsHjkqN+0abZ/6BA==;
Received: from ouster448.stanford.edu ([172.24.72.71]:52661 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tY8co-0002BF-4U; Wed, 15 Jan 2025 11:00:24 -0800
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v6 08/12] net: homa: create homa_incoming.c
Date: Wed, 15 Jan 2025 10:59:32 -0800
Message-ID: <20250115185937.1324-9-ouster@cs.stanford.edu>
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
X-Scan-Signature: ad492ba45620d7af06704235a0975f77

This file contains most of the code for handling incoming packets,
including top-level dispatching code plus specific handlers for each
pack type. It also contains code for dispatching fully-received
messages to waiting application threads.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 net/homa/homa_incoming.c | 1076 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 1076 insertions(+)
 create mode 100644 net/homa/homa_incoming.c

diff --git a/net/homa/homa_incoming.c b/net/homa/homa_incoming.c
new file mode 100644
index 000000000000..c7630bf6d1fb
--- /dev/null
+++ b/net/homa/homa_incoming.c
@@ -0,0 +1,1076 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+/* This file contains functions that handle incoming Homa messages.
+ */
+
+#include "homa_impl.h"
+#include "homa_peer.h"
+#include "homa_pool.h"
+
+/**
+ * homa_message_in_init() - Constructor for homa_message_in.
+ * @rpc:          RPC whose msgin structure should be initialized.
+ * @length:       Total number of bytes in message.
+ * Return:        Zero for successful initialization, or a negative errno
+ *                if rpc->msgin could not be initialized.
+ */
+int homa_message_in_init(struct homa_rpc *rpc, int length)
+{
+	int err;
+
+	rpc->msgin.length = length;
+	skb_queue_head_init(&rpc->msgin.packets);
+	rpc->msgin.recv_end = 0;
+	INIT_LIST_HEAD(&rpc->msgin.gaps);
+	rpc->msgin.bytes_remaining = length;
+	rpc->msgin.resend_all = 0;
+	rpc->msgin.num_bpages = 0;
+	err = homa_pool_allocate(rpc);
+	if (err != 0)
+		return err;
+	return 0;
+}
+
+/**
+ * homa_gap_new() - Create a new gap and add it to a list.
+ * @next:   Add the new gap just before this list element.
+ * @start:  Offset of first byte covered by the gap.
+ * @end:    Offset of byte just after the last one covered by the gap.
+ * Return:  Pointer to the new gap, or NULL if memory couldn't be allocated
+ *          for the gap object.
+ */
+struct homa_gap *homa_gap_new(struct list_head *next, int start, int end)
+{
+	struct homa_gap *gap;
+
+	gap = kmalloc(sizeof(*gap), GFP_ATOMIC);
+	if (!gap)
+		return NULL;
+	gap->start = start;
+	gap->end = end;
+	gap->time = sched_clock();
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
+		if (!homa_gap_new(&rpc->msgin.gaps,
+				  rpc->msgin.recv_end, start)) {
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
+		gap2 = homa_gap_new(&gap->links, gap->start, start);
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
+ *           will be RPC_DEAD.
+ */
+int homa_copy_to_user(struct homa_rpc *rpc)
+	__releases(rpc->bucket_lock)
+	__acquires(rpc->bucket_lock)
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
+		if (n == 0)
+			break;
+
+		/* At this point we've collected a batch of packets (or
+		 * run out of packets); copy any available packets out to
+		 * user space.
+		 */
+		atomic_or(RPC_COPYING_TO_USER, &rpc->flags);
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
+			char *dst;
+
+			/* Each iteration of this loop copies to one
+			 * user buffer.
+			 */
+			while (copied < pkt_length) {
+				chunk_size = pkt_length - copied;
+				dst = homa_pool_get_buffer(rpc, offset + copied,
+							   &buf_bytes);
+				if (buf_bytes < chunk_size) {
+					if (buf_bytes == 0)
+						/* skb has data beyond message
+						 * end?
+						 */
+						break;
+					chunk_size = buf_bytes;
+				}
+				error = import_ubuf(READ, (void __user *)dst,
+						    chunk_size, &iter);
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
+		homa_rpc_lock(rpc, "homa_copy_to_user");
+		atomic_andnot(APP_NEEDS_LOCK | RPC_COPYING_TO_USER,
+			      &rpc->flags);
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
+ * @homa:      Overall information about the Homa transport.
+ */
+void homa_dispatch_pkts(struct sk_buff *skb, struct homa *homa)
+{
+#define MAX_ACKS 10
+	const struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
+	struct homa_data_hdr *h = (struct homa_data_hdr *)skb->data;
+	__u64 id = homa_local_id(h->common.sender_id);
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
+	struct sk_buff *next;
+	int num_acks = 0;
+
+	/* Find the appropriate socket.*/
+	hsk = homa_sock_find(homa->port_map, dport);
+	if (!hsk) {
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
+				homa_spin(200);
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
+					rpc = homa_rpc_new_server(hsk, &saddr,
+								  h, &created);
+					if (IS_ERR(rpc)) {
+						pr_warn("homa_pkt_dispatch couldn't create server rpc: error %lu",
+							-PTR_ERR(rpc));
+						rpc = NULL;
+						goto discard;
+					}
+				} else {
+					rpc = homa_find_server_rpc(hsk, &saddr,
+								   id);
+				}
+			} else {
+				rpc = homa_find_client_rpc(hsk, id);
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
+		case UNKNOWN:
+			homa_unknown_pkt(skb, rpc);
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
+			rpc = NULL;
+
+			/* It isn't safe to process more packets once we've
+			 * released the RPC lock (this should never happen).
+			 */
+			while (next) {
+				WARN_ONCE(next, "%s found extra packets after AC<\n",
+					  __func__);
+				skb = next;
+				next = skb->next;
+				kfree_skb(skb);
+			}
+			break;
+		default:
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
+		/* We get here if neither homa_wait_for_message
+		 * nor homa_timer can keep up with reaping dead
+		 * RPCs. See reap.txt for details.
+		 */
+		homa_rpc_reap(hsk, false);
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
+		/* Must be server; note that homa_rpc_new_server already
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
+		homa_sock_lock(rpc->hsk, "homa_data_pkt");
+		homa_rpc_handoff(rpc);
+		homa_sock_unlock(rpc->hsk);
+	}
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
+ * homa_unknown_pkt() - Handler for incoming UNKNOWN packets.
+ * @skb:     Incoming packet; size known to be large enough for the header.
+ *           This function now owns the packet.
+ * @rpc:     Information about the RPC corresponding to this packet.
+ */
+void homa_unknown_pkt(struct sk_buff *skb, struct homa_rpc *rpc)
+{
+	if (homa_is_client(rpc->id)) {
+		if (rpc->state == RPC_OUTGOING) {
+			/* It appears that everything we've already transmitted
+			 * has been lost; retransmit it.
+			 */
+			homa_resend_data(rpc, 0, rpc->msgout.next_xmit_offset);
+			goto done;
+		}
+
+	} else {
+		homa_rpc_free(rpc);
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
+{
+	struct homa_common_hdr *h = (struct homa_common_hdr *)skb->data;
+	const struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
+	__u64 id = homa_local_id(h->sender_id);
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
+		peer = homa_peer_find(hsk->homa->peers, &saddr, &hsk->inet);
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
+ *           RPC exists. The RPC has been locked by the caller but will
+ *           be unlocked here.
+ */
+void homa_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
+		  struct homa_rpc *rpc)
+	__releases(rpc->bucket_lock)
+{
+	const struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
+	struct homa_ack_hdr *h = (struct homa_ack_hdr *)skb->data;
+	int i, count;
+
+	if (rpc) {
+		homa_rpc_free(rpc);
+		homa_rpc_unlock(rpc);
+	}
+
+	count = ntohs(h->num_acks);
+	for (i = 0; i < count; i++)
+		homa_rpc_acked(hsk, &saddr, &h->acks[i]);
+	kfree_skb(skb);
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
+{
+	if (!homa_is_client(rpc->id)) {
+		homa_rpc_free(rpc);
+		return;
+	}
+	rpc->error = error;
+	homa_sock_lock(rpc->hsk, "homa_rpc_abort");
+	if (!rpc->hsk->shutdown)
+		homa_rpc_handoff(rpc);
+	homa_sock_unlock(rpc->hsk);
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
+	struct homa_rpc *rpc, *tmp;
+	struct homa_sock *hsk;
+
+	rcu_read_lock();
+	for (hsk = homa_socktab_start_scan(homa->port_map, &scan); hsk;
+	     hsk = homa_socktab_next(&scan)) {
+		/* Skip the (expensive) lock acquisition if there's no
+		 * work to do.
+		 */
+		if (list_empty(&hsk->active_rpcs))
+			continue;
+		if (!homa_protect_rpcs(hsk))
+			continue;
+		list_for_each_entry_safe(rpc, tmp, &hsk->active_rpcs,
+					 active_links) {
+			if (!ipv6_addr_equal(&rpc->peer->addr, addr))
+				continue;
+			if (port && rpc->dport != port)
+				continue;
+			homa_rpc_lock(rpc, "rpc_abort_rpcs");
+			homa_rpc_abort(rpc, error);
+			homa_rpc_unlock(rpc);
+		}
+		homa_unprotect_rpcs(hsk);
+	}
+	homa_socktab_end_scan(&scan);
+	rcu_read_unlock();
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
+	struct homa_rpc *rpc, *tmp;
+
+	rcu_read_lock();
+	if (list_empty(&hsk->active_rpcs))
+		goto done;
+	if (!homa_protect_rpcs(hsk))
+		goto done;
+	list_for_each_entry_safe(rpc, tmp, &hsk->active_rpcs, active_links) {
+		if (!homa_is_client(rpc->id))
+			continue;
+		homa_rpc_lock(rpc, "homa_abort_sock_rpcs");
+		if (rpc->state == RPC_DEAD) {
+			homa_rpc_unlock(rpc);
+			continue;
+		}
+		if (error)
+			homa_rpc_abort(rpc, error);
+		else
+			homa_rpc_free(rpc);
+		homa_rpc_unlock(rpc);
+	}
+	homa_unprotect_rpcs(hsk);
+done:
+	rcu_read_unlock();
+}
+
+/**
+ * homa_register_interests() - Records information in various places so
+ * that a thread will be woken up if an RPC that it cares about becomes
+ * available.
+ * @interest:     Used to record information about the messages this thread is
+ *                waiting on. The initial contents of the structure are
+ *                assumed to be undefined.
+ * @hsk:          Socket on which relevant messages will arrive.  Must not be
+ *                locked.
+ * @flags:        Flags field from homa_recvmsg_args; see manual entry for
+ *                details.
+ * @id:           If non-zero, then the caller is interested in receiving
+ *                the response for this RPC (@id must be a client request).
+ * Return:        Either zero or a negative errno value. If a matching RPC
+ *                is already available, information about it will be stored in
+ *                interest.
+ */
+int homa_register_interests(struct homa_interest *interest,
+			    struct homa_sock *hsk, int flags, __u64 id)
+{
+	struct homa_rpc *rpc = NULL;
+	int locked = 1;
+
+	homa_interest_init(interest);
+	if (id != 0) {
+		if (!homa_is_client(id))
+			return -EINVAL;
+		rpc = homa_find_client_rpc(hsk, id); /* Locks rpc. */
+		if (!rpc)
+			return -EINVAL;
+		if (rpc->interest && rpc->interest != interest) {
+			homa_rpc_unlock(rpc);
+			return -EINVAL;
+		}
+	}
+
+	/* Need both the RPC lock (acquired above) and the socket lock to
+	 * avoid races.
+	 */
+	homa_sock_lock(hsk, "homa_register_interests");
+	if (hsk->shutdown) {
+		homa_sock_unlock(hsk);
+		if (rpc)
+			homa_rpc_unlock(rpc);
+		return -ESHUTDOWN;
+	}
+
+	if (id != 0) {
+		if ((atomic_read(&rpc->flags) & RPC_PKTS_READY) || rpc->error)
+			goto claim_rpc;
+		rpc->interest = interest;
+		interest->reg_rpc = rpc;
+		homa_rpc_unlock(rpc);
+	}
+
+	locked = 0;
+	if (flags & HOMA_RECVMSG_RESPONSE) {
+		if (!list_empty(&hsk->ready_responses)) {
+			rpc = list_first_entry(&hsk->ready_responses,
+					       struct homa_rpc,
+					       ready_links);
+			goto claim_rpc;
+		}
+		/* Insert this thread at the *front* of the list;
+		 * we'll get better cache locality if we reuse
+		 * the same thread over and over, rather than
+		 * round-robining between threads.  Same below.
+		 */
+		list_add(&interest->response_links,
+			 &hsk->response_interests);
+	}
+	if (flags & HOMA_RECVMSG_REQUEST) {
+		if (!list_empty(&hsk->ready_requests)) {
+			rpc = list_first_entry(&hsk->ready_requests,
+					       struct homa_rpc, ready_links);
+			/* Make sure the interest isn't on the response list;
+			 * otherwise it might receive a second RPC.
+			 */
+			if (!list_empty(&interest->response_links))
+				list_del_init(&interest->response_links);
+			goto claim_rpc;
+		}
+		list_add(&interest->request_links, &hsk->request_interests);
+	}
+	homa_sock_unlock(hsk);
+	return 0;
+
+claim_rpc:
+	list_del_init(&rpc->ready_links);
+	if (!list_empty(&hsk->ready_requests) ||
+	    !list_empty(&hsk->ready_responses)) {
+		hsk->sock.sk_data_ready(&hsk->sock);
+	}
+
+	/* This flag is needed to keep the RPC from being reaped during the
+	 * gap between when we release the socket lock and we acquire the
+	 * RPC lock.
+	 */
+	atomic_or(RPC_HANDING_OFF, &rpc->flags);
+	homa_sock_unlock(hsk);
+	if (!locked) {
+		atomic_or(APP_NEEDS_LOCK, &rpc->flags);
+		homa_rpc_lock(rpc, "homa_register_interests");
+		atomic_andnot(APP_NEEDS_LOCK, &rpc->flags);
+		locked = 1;
+	}
+	atomic_andnot(RPC_HANDING_OFF, &rpc->flags);
+	homa_interest_set_rpc(interest, rpc, locked);
+	return 0;
+}
+
+/**
+ * homa_wait_for_message() - Wait for receipt of an incoming message
+ * that matches the parameters. Various other activities can occur while
+ * waiting, such as reaping dead RPCs and copying data to user space.
+ * @hsk:          Socket where messages will arrive.
+ * @flags:        Flags field from homa_recvmsg_args; see manual entry for
+ *                details.
+ * @id:           If non-zero, then a response message matching this id may
+ *                be returned (@id must refer to a client request).
+ *
+ * Return:   Pointer to an RPC that matches @flags and @id, or a negative
+ *           errno value. The RPC will be locked; the caller must unlock.
+ */
+struct homa_rpc *homa_wait_for_message(struct homa_sock *hsk, int flags,
+				       __u64 id)
+	__acquires(&rpc->bucket_lock)
+{
+	struct homa_rpc *result = NULL;
+	struct homa_interest interest;
+	struct homa_rpc *rpc = NULL;
+	int error;
+
+	/* Each iteration of this loop finds an RPC, but it might not be
+	 * in a state where we can return it (e.g., there might be packets
+	 * ready to transfer to user space, but the incoming message isn't yet
+	 * complete). Thus it could take many iterations of this loop
+	 * before we have an RPC with a complete message.
+	 */
+	while (1) {
+		error = homa_register_interests(&interest, hsk, flags, id);
+		rpc = homa_interest_get_rpc(&interest);
+		if (rpc)
+			goto found_rpc;
+		if (error < 0) {
+			result = ERR_PTR(error);
+			goto found_rpc;
+		}
+
+		/* There is no ready RPC so far. Clean up dead RPCs before
+		 * going to sleep (or returning, if in nonblocking mode).
+		 */
+		while (1) {
+			int reaper_result;
+
+			rpc = homa_interest_get_rpc(&interest);
+			if (rpc)
+				goto found_rpc;
+			reaper_result = homa_rpc_reap(hsk, false);
+			if (reaper_result == 0)
+				break;
+
+			/* Give NAPI and SoftIRQ tasks a chance to run. */
+			schedule();
+		}
+		if (flags & HOMA_RECVMSG_NONBLOCKING) {
+			result = ERR_PTR(-EAGAIN);
+			goto found_rpc;
+		}
+
+		/* Now it's time to sleep. */
+		set_current_state(TASK_INTERRUPTIBLE);
+		rpc = homa_interest_get_rpc(&interest);
+		if (!rpc && !hsk->shutdown)
+			schedule();
+		__set_current_state(TASK_RUNNING);
+
+found_rpc:
+		/* If we get here, it means either an RPC is ready for our
+		 * attention or an error occurred.
+		 *
+		 * First, clean up all of the interests. Must do this before
+		 * making any other decisions, because until we do, an incoming
+		 * message could still be passed to us. Note: if we went to
+		 * sleep, then this info was already cleaned up by whoever
+		 * woke us up. Also, values in the interest may change between
+		 * when we test them below and when we acquire the socket lock,
+		 * so they have to be checked again after locking the socket.
+		 */
+		if (interest.reg_rpc ||
+		    !list_empty(&interest.request_links) ||
+		    !list_empty(&interest.response_links)) {
+			homa_sock_lock(hsk, "homa_wait_for_message");
+			if (interest.reg_rpc)
+				interest.reg_rpc->interest = NULL;
+			if (!list_empty(&interest.request_links))
+				list_del_init(&interest.request_links);
+			if (!list_empty(&interest.response_links))
+				list_del_init(&interest.response_links);
+			homa_sock_unlock(hsk);
+		}
+
+		/* Now check to see if we received an RPC handoff (note that
+		 * this could have happened anytime up until we reset the
+		 * interests above).
+		 */
+		rpc = homa_interest_get_rpc(&interest);
+		if (rpc) {
+			if (!interest.locked) {
+				atomic_or(APP_NEEDS_LOCK, &rpc->flags);
+				homa_rpc_lock(rpc, "homa_wait_for_message");
+				atomic_andnot(APP_NEEDS_LOCK | RPC_HANDING_OFF,
+					      &rpc->flags);
+			} else {
+				atomic_andnot(RPC_HANDING_OFF, &rpc->flags);
+			}
+			if (!rpc->error)
+				rpc->error = homa_copy_to_user(rpc);
+			if (rpc->state == RPC_DEAD) {
+				homa_rpc_unlock(rpc);
+				continue;
+			}
+			if (rpc->error)
+				goto done;
+			atomic_andnot(RPC_PKTS_READY, &rpc->flags);
+			if (rpc->msgin.bytes_remaining == 0 &&
+			    !skb_queue_len(&rpc->msgin.packets))
+				goto done;
+			homa_rpc_unlock(rpc);
+		}
+
+		/* A complete message isn't available: check for errors. */
+		if (IS_ERR(result))
+			return result;
+		if (signal_pending(current))
+			return ERR_PTR(-EINTR);
+
+		/* No message and no error; try again. */
+	}
+
+done:
+	return rpc;
+}
+
+/**
+ * homa_choose_interest() - Given a list of interests for an incoming
+ * message, choose the best one to handle it (if any).
+ * @homa:        Overall information about the Homa transport.
+ * @head:        Head pointers for the list of interest: either
+ *		 hsk->request_interests or hsk->response_interests.
+ * @offset:      Offset of "next" pointers in the list elements (either
+ *               offsetof(request_links) or offsetof(response_links).
+ * Return:       An interest to use for the incoming message, or NULL if none
+ *               is available. If possible, this function tries to pick an
+ *               interest whose thread is running on a core that isn't
+ *               currently busy doing Homa transport work.
+ */
+struct homa_interest *homa_choose_interest(struct homa *homa,
+					   struct list_head *head, int offset)
+{
+	struct homa_interest *backup = NULL;
+	struct homa_interest *interest;
+	struct list_head *pos;
+
+	list_for_each(pos, head) {
+		interest = (struct homa_interest *)(((char *)pos) - offset);
+		if (!backup)
+			backup = interest;
+	}
+
+	/* All interested threads are on busy cores; return the first. */
+	return backup;
+}
+
+/**
+ * homa_rpc_handoff() - This function is called when the input message for
+ * an RPC is ready for attention from a user thread. It either notifies
+ * a waiting reader or queues the RPC.
+ * @rpc:                RPC to handoff; must be locked. The caller must
+ *			also have locked the socket for this RPC.
+ */
+void homa_rpc_handoff(struct homa_rpc *rpc)
+{
+	struct homa_sock *hsk = rpc->hsk;
+	struct homa_interest *interest;
+
+	if ((atomic_read(&rpc->flags) & RPC_HANDING_OFF) ||
+	    !list_empty(&rpc->ready_links))
+		return;
+
+	/* First, see if someone is interested in this RPC specifically.
+	 */
+	if (rpc->interest) {
+		interest = rpc->interest;
+		goto thread_waiting;
+	}
+
+	/* Second, check the interest list for this type of RPC. */
+	if (homa_is_client(rpc->id)) {
+		interest = homa_choose_interest(hsk->homa,
+						&hsk->response_interests,
+						offsetof(struct homa_interest,
+							 response_links));
+		if (interest)
+			goto thread_waiting;
+		list_add_tail(&rpc->ready_links, &hsk->ready_responses);
+	} else {
+		interest = homa_choose_interest(hsk->homa,
+						&hsk->request_interests,
+						offsetof(struct homa_interest,
+							 request_links));
+		if (interest)
+			goto thread_waiting;
+		list_add_tail(&rpc->ready_links, &hsk->ready_requests);
+	}
+
+	/* If we get here, no-one is waiting for the RPC, so it has been
+	 * queued.
+	 */
+
+	/* Notify the poll mechanism. */
+	hsk->sock.sk_data_ready(&hsk->sock);
+	return;
+
+thread_waiting:
+	/* We found a waiting thread. The following 3 lines must be here,
+	 * before clearing the interest, in order to avoid a race with
+	 * homa_wait_for_message (which won't acquire the socket lock if
+	 * the interest is clear).
+	 */
+	atomic_or(RPC_HANDING_OFF, &rpc->flags);
+	homa_interest_set_rpc(interest, rpc, 0);
+
+	/* Clear the interest. This serves two purposes. First, it saves
+	 * the waking thread from acquiring the socket lock again, which
+	 * reduces contention on that lock). Second, it ensures that
+	 * no-one else attempts to give this interest a different RPC.
+	 */
+	if (interest->reg_rpc) {
+		interest->reg_rpc->interest = NULL;
+		interest->reg_rpc = NULL;
+	}
+	if (!list_empty(&interest->request_links))
+		list_del_init(&interest->request_links);
+	if (!list_empty(&interest->response_links))
+		list_del_init(&interest->response_links);
+	wake_up_process(interest->thread);
+}
+
+/**
+ * homa_incoming_sysctl_changed() - Invoked whenever a sysctl value is changed;
+ * any input-related parameters that depend on sysctl-settable values.
+ * @homa:    Overall data about the Homa protocol implementation.
+ */
+void homa_incoming_sysctl_changed(struct homa *homa)
+{
+}
-- 
2.34.1


