Return-Path: <netdev+bounces-178456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A27A77181
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 01:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D40168DEE
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5E21D581;
	Mon, 31 Mar 2025 23:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="qmctI6bq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA3821C9F2
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 23:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743464836; cv=none; b=aVm4Y59Q20DKi/djJotJfBg5Kwydhxd6f91XrU8H2PqIXKm1F83XRNYgAWwnQ5haknPXUKjbqREqeG05FxQft8LRyD+TtCHetuSS2Ow5F+Bm+nKtyQPOLakAYN8wE+cNonGBJBEHXtoi7eRfd/7JkwVqTO2qLcIlOfRhSWKPzMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743464836; c=relaxed/simple;
	bh=BXR1MrWPY9vvwOkHKRY6tyFz2WEp76r1WEV1ZfMgeNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K700d7daMdUOV4w7MGXPiievA1q4xwgpwKF9XU33juLUmRJyhbudb7G7F0rzHTajQPzcNajiXNjokyy51VUkZzIUNZyhzp7a3BCHbbn3Pjh0jDqhASdxst33k5ycRo2zHl/o0U7xwSWt+CUMMCRlnU4fRFcLHgIvRAfjiRNYB5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=qmctI6bq; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NnWWN/TIamZukOq3QZOH613BbNfX5bbnuy4HS0Wo6NI=; t=1743464834; x=1744328834; 
	b=qmctI6bqk01nsJCz4yRn3L4OFGfa9ML45FJ+DuKua0do678ELOKCKrHFRC0j1qyarnCc3bHKGVC
	6ItMytnQrC5dlbwTwZmBN4XivSDR6K37VhUaQzJv7UP92ok3tLaqCVVUsep+fjWLCicMsY7iXbfkd
	4iao5s9TRO4oKLLNhpL3KHBtMBodvmzWahGhJGmP26tsv6KLSGAd2Coo8ZsmpXVPeO56nRymIo7tE
	Dv5KJl2uS7O0MYf+mxZAFRcg0BNv97VNZglNdK/SD5UOGL7K8ZIZ6hVMpJgYtWW0x+eoiqonndf2y
	Tz8EN2b7dE2WDyGlgdAdWvE0ufJRuUx02GFw==;
Received: from ouster448.stanford.edu ([172.24.72.71]:55223 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tzOqV-000219-EA; Mon, 31 Mar 2025 16:47:13 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v7 09/14] net: homa: create homa_outgoing.c
Date: Mon, 31 Mar 2025 16:45:42 -0700
Message-ID: <20250331234548.62070-10-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250331234548.62070-1-ouster@cs.stanford.edu>
References: <20250331234548.62070-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: f3e76a9988285b3a80a86622b8bb322a

This file does most of the work of transmitting outgoing messages.
It is responsible for copying data from user space into skbs and
it also implements the "pacer", which throttles output if necessary
to prevent queue buildup in the NIC. Note: the pacer eventually
needs to be replaced with a Homa-specific qdisc, which can better
manage simultaneous transmissions by Homa and TCP. The current
implementation can coexist with TCP and doesn't harm TCP, but
Homa's latency suffers when TCP runs concurrently.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v7:
* Implement accounting for bytes in tx skbs
* Rename UNKNOWN packet type to RPC_UNKNOWN
* Use new RPC reference counts; eliminates need for RCU
* Remove locker argument from locking functions
* Use u64 and __u64 properly
* Fix incorrect skb check in homa_message_out_fill
---
 net/homa/homa_outgoing.c | 835 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 835 insertions(+)
 create mode 100644 net/homa/homa_outgoing.c

diff --git a/net/homa/homa_outgoing.c b/net/homa/homa_outgoing.c
new file mode 100644
index 000000000000..bfc8b93592ee
--- /dev/null
+++ b/net/homa/homa_outgoing.c
@@ -0,0 +1,835 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+/* This file contains functions related to the sender side of message
+ * transmission. It also contains utility functions for sending packets.
+ */
+
+#include "homa_impl.h"
+#include "homa_peer.h"
+#include "homa_rpc.h"
+#include "homa_wire.h"
+#include "homa_stub.h"
+
+/**
+ * homa_message_out_init() - Initialize rpc->msgout.
+ * @rpc:       RPC whose output message should be initialized.
+ * @length:    Number of bytes that will eventually be in rpc->msgout.
+ */
+void homa_message_out_init(struct homa_rpc *rpc, int length)
+{
+	memset(&rpc->msgout, 0, sizeof(rpc->msgout));
+	rpc->msgout.length = length;
+	rpc->msgout.next_xmit = &rpc->msgout.packets;
+	rpc->msgout.init_ns = sched_clock();
+}
+
+/**
+ * homa_fill_data_interleaved() - This function is invoked to fill in the
+ * part of a data packet after the initial header, when GSO is being used.
+ * homa_seg_hdrs must be interleaved with the data to provide the correct
+ * offset for each segment.
+ * @rpc:            RPC whose output message is being created.
+ * @skb:            The packet being filled. The initial homa_data_hdr was
+ *                  created and initialized by the caller and the
+ *                  homa_skb_info has been filled in with the packet geometry.
+ * @iter:           Describes location(s) of (remaining) message data in user
+ *                  space.
+ * Return:          Either a negative errno or 0 (for success).
+ */
+int homa_fill_data_interleaved(struct homa_rpc *rpc, struct sk_buff *skb,
+			       struct iov_iter *iter)
+{
+	struct homa_skb_info *homa_info = homa_get_skb_info(skb);
+	int seg_length = homa_info->seg_length;
+	int bytes_left = homa_info->data_bytes;
+	int offset = homa_info->offset;
+	int err;
+
+	/* Each iteration of the following loop adds info for one packet,
+	 * which includes a homa_seg_hdr followed by the data for that
+	 * segment. The first homa_seg_hdr was already added by the caller.
+	 */
+	while (1) {
+		struct homa_seg_hdr seg;
+
+		if (bytes_left < seg_length)
+			seg_length = bytes_left;
+		err = homa_skb_append_from_iter(rpc->hsk->homa, skb, iter,
+						seg_length);
+		if (err != 0)
+			return err;
+		bytes_left -= seg_length;
+		offset += seg_length;
+
+		if (bytes_left == 0)
+			break;
+
+		seg.offset = htonl(offset);
+		err = homa_skb_append_to_frag(rpc->hsk->homa, skb, &seg,
+					      sizeof(seg));
+		if (err != 0)
+			return err;
+	}
+	return 0;
+}
+
+/**
+ * homa_new_data_packet() - Allocate a new sk_buff and fill it with a Homa
+ * data packet. The resulting packet will be a GSO packet that will eventually
+ * be segmented by the NIC.
+ * @rpc:          RPC that packet will belong to (msgout must have been
+ *                initialized).
+ * @iter:         Describes location(s) of (remaining) message data in user
+ *                space.
+ * @offset:       Offset in the message of the first byte of data in this
+ *                packet.
+ * @length:       How many bytes of data to include in the skb. Caller must
+ *                ensure that this amount of data isn't too much for a
+ *                well-formed GSO packet, and that iter has at least this
+ *                much data.
+ * @max_seg_data: Maximum number of bytes of message data that can go in
+ *                a single segment of the GSO packet.
+ * Return: A pointer to the new packet, or a negative errno.
+ */
+struct sk_buff *homa_new_data_packet(struct homa_rpc *rpc,
+				     struct iov_iter *iter, int offset,
+				     int length, int max_seg_data)
+{
+	struct homa_skb_info *homa_info;
+	struct homa_data_hdr *h;
+	struct sk_buff *skb;
+	int err, gso_size;
+	u64 segs;
+
+	segs = length + max_seg_data - 1;
+	do_div(segs, max_seg_data);
+
+	/* Initialize the overall skb. */
+	skb = homa_skb_new_tx(sizeof32(struct homa_data_hdr) + length +
+			      (segs - 1) * sizeof32(struct homa_seg_hdr));
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	/* Fill in the Homa header (which will be replicated in every
+	 * network packet by GSO).
+	 */
+	h = (struct homa_data_hdr *)skb_put(skb, sizeof(struct homa_data_hdr));
+	h->common.sport = htons(rpc->hsk->port);
+	h->common.dport = htons(rpc->dport);
+	h->common.sequence = htonl(offset);
+	h->common.type = DATA;
+	homa_set_doff(h, sizeof(struct homa_data_hdr));
+	h->common.checksum = 0;
+	h->common.sender_id = cpu_to_be64(rpc->id);
+	h->message_length = htonl(rpc->msgout.length);
+	h->ack.client_id = 0;
+	homa_peer_get_acks(rpc->peer, 1, &h->ack);
+	h->retransmit = 0;
+	h->seg.offset = htonl(offset);
+
+	homa_info = homa_get_skb_info(skb);
+	homa_info->next_skb = NULL;
+	homa_info->wire_bytes = length + segs * (sizeof(struct homa_data_hdr)
+			+  rpc->hsk->ip_header_length + HOMA_ETH_OVERHEAD);
+	homa_info->data_bytes = length;
+	homa_info->seg_length = max_seg_data;
+	homa_info->offset = offset;
+
+	if (segs > 1) {
+		homa_set_doff(h, sizeof(struct homa_data_hdr)  -
+				sizeof32(struct homa_seg_hdr));
+		gso_size = max_seg_data + sizeof(struct homa_seg_hdr);
+		err = homa_fill_data_interleaved(rpc, skb, iter);
+	} else {
+		gso_size = max_seg_data;
+		err = homa_skb_append_from_iter(rpc->hsk->homa, skb, iter,
+						length);
+	}
+	if (err)
+		goto error;
+
+	if (segs > 1) {
+		skb_shinfo(skb)->gso_segs = segs;
+		skb_shinfo(skb)->gso_size = gso_size;
+
+		/* It's unclear what gso_type should be used to force software
+		 * GSO; the value below seems to work...
+		 */
+		skb_shinfo(skb)->gso_type =
+		    rpc->hsk->homa->gso_force_software ? 0xd : SKB_GSO_TCPV6;
+	}
+	return skb;
+
+error:
+	homa_skb_free_tx(rpc->hsk->homa, skb);
+	return ERR_PTR(err);
+}
+
+/**
+ * homa_message_out_fill() - Initializes information for sending a message
+ * for an RPC (either request or response); copies the message data from
+ * user space and (possibly) begins transmitting the message.
+ * @rpc:     RPC for which to send message; this function must not
+ *           previously have been called for the RPC. Must be locked. The RPC
+ *           will be unlocked while copying data, but will be locked again
+ *           before returning.
+ * @iter:    Describes location(s) of message data in user space.
+ * @xmit:    Nonzero means this method should start transmitting packets;
+ *           transmission will be overlapped with copying from user space.
+ *           Zero means the caller will initiate transmission after this
+ *           function returns.
+ *
+ * Return:   0 for success, or a negative errno for failure. It is possible
+ *           for the RPC to be freed while this function is active. If that
+ *           happens, copying will cease, -EINVAL will be returned, and
+ *           rpc->state will be RPC_DEAD.
+ */
+int homa_message_out_fill(struct homa_rpc *rpc, struct iov_iter *iter, int xmit)
+	__releases(rpc->bucket_lock)
+	__acquires(rpc->bucket_lock)
+{
+	/* Geometry information for packets:
+	 * mtu:              largest size for an on-the-wire packet (including
+	 *                   all headers through IP header, but not Ethernet
+	 *                   header).
+	 * max_seg_data:     largest amount of Homa message data that fits
+	 *                   in an on-the-wire packet (after segmentation).
+	 * max_gso_data:     largest amount of Homa message data that fits
+	 *                   in a GSO packet (before segmentation).
+	 */
+	int mtu, max_seg_data, max_gso_data;
+
+	struct sk_buff **last_link;
+	struct dst_entry *dst;
+	u64 segs_per_gso;
+	int overlap_xmit;
+
+	/* Bytes of the message that haven't yet been copied into skbs. */
+	int bytes_left;
+
+	int gso_size;
+	int err;
+
+	homa_rpc_hold(rpc);
+	if (unlikely(iter->count > HOMA_MAX_MESSAGE_LENGTH ||
+		     iter->count == 0)) {
+		err = -EINVAL;
+		goto error;
+	}
+	homa_message_out_init(rpc, iter->count);
+
+	/* Compute the geometry of packets. */
+	dst = homa_get_dst(rpc->peer, rpc->hsk);
+	mtu = dst_mtu(dst);
+	max_seg_data = mtu - rpc->hsk->ip_header_length
+			- sizeof(struct homa_data_hdr);
+	gso_size = dst->dev->gso_max_size;
+	if (gso_size > rpc->hsk->homa->max_gso_size)
+		gso_size = rpc->hsk->homa->max_gso_size;
+
+	/* Round gso_size down to an even # of mtus. */
+	segs_per_gso = gso_size - rpc->hsk->ip_header_length -
+			sizeof(struct homa_data_hdr) +
+			sizeof(struct homa_seg_hdr);
+	do_div(segs_per_gso, max_seg_data +
+			sizeof(struct homa_seg_hdr));
+	if (segs_per_gso == 0)
+		segs_per_gso = 1;
+	max_gso_data = segs_per_gso * max_seg_data;
+
+	overlap_xmit = rpc->msgout.length > 2 * max_gso_data;
+	homa_skb_stash_pages(rpc->hsk->homa, rpc->msgout.length);
+
+	/* Each iteration of the loop below creates one GSO packet. */
+	last_link = &rpc->msgout.packets;
+	for (bytes_left = rpc->msgout.length; bytes_left > 0; ) {
+		int skb_data_bytes, offset;
+		struct sk_buff *skb;
+
+		homa_rpc_unlock(rpc);
+		skb_data_bytes = max_gso_data;
+		offset = rpc->msgout.length - bytes_left;
+		if (skb_data_bytes > bytes_left)
+			skb_data_bytes = bytes_left;
+		skb = homa_new_data_packet(rpc, iter, offset, skb_data_bytes,
+					   max_seg_data);
+		if (IS_ERR(skb)) {
+			err = PTR_ERR(skb);
+			homa_rpc_lock(rpc);
+			goto error;
+		}
+		bytes_left -= skb_data_bytes;
+
+		homa_rpc_lock(rpc);
+		if (rpc->state == RPC_DEAD) {
+			/* RPC was freed while we were copying. */
+			err = -EINVAL;
+			homa_skb_free_tx(rpc->hsk->homa, skb);
+			goto error;
+		}
+		*last_link = skb;
+		last_link = &(homa_get_skb_info(skb)->next_skb);
+		*last_link = NULL;
+		rpc->msgout.num_skbs++;
+		rpc->msgout.skb_memory += skb->truesize;
+		rpc->msgout.copied_from_user = rpc->msgout.length - bytes_left;
+		if (overlap_xmit && list_empty(&rpc->throttled_links) &&
+		    xmit)
+			homa_add_to_throttled(rpc);
+	}
+	refcount_add(rpc->msgout.skb_memory, &rpc->hsk->sock.sk_wmem_alloc);
+	homa_rpc_put(rpc);
+	if (!overlap_xmit && xmit)
+		homa_xmit_data(rpc, false);
+	return 0;
+
+error:
+	refcount_add(rpc->msgout.skb_memory, &rpc->hsk->sock.sk_wmem_alloc);
+	homa_rpc_put(rpc);
+	return err;
+}
+
+/**
+ * homa_xmit_control() - Send a control packet to the other end of an RPC.
+ * @type:      Packet type, such as DATA.
+ * @contents:  Address of buffer containing the contents of the packet.
+ *             Only information after the common header must be valid;
+ *             the common header will be filled in by this function.
+ * @length:    Length of @contents (including the common header).
+ * @rpc:       The packet will go to the socket that handles the other end
+ *             of this RPC. Addressing info for the packet, including all of
+ *             the fields of homa_common_hdr except type, will be set from this.
+ *
+ * Return:     Either zero (for success), or a negative errno value if there
+ *             was a problem.
+ */
+int homa_xmit_control(enum homa_packet_type type, void *contents,
+		      size_t length, struct homa_rpc *rpc)
+{
+	struct homa_common_hdr *h = contents;
+
+	h->type = type;
+	h->sport = htons(rpc->hsk->port);
+	h->dport = htons(rpc->dport);
+	h->sender_id = cpu_to_be64(rpc->id);
+	return __homa_xmit_control(contents, length, rpc->peer, rpc->hsk);
+}
+
+/**
+ * __homa_xmit_control() - Lower-level version of homa_xmit_control: sends
+ * a control packet.
+ * @contents:  Address of buffer containing the contents of the packet.
+ *             The caller must have filled in all of the information,
+ *             including the common header.
+ * @length:    Length of @contents.
+ * @peer:      Destination to which the packet will be sent.
+ * @hsk:       Socket via which the packet will be sent.
+ *
+ * Return:     Either zero (for success), or a negative errno value if there
+ *             was a problem.
+ */
+int __homa_xmit_control(void *contents, size_t length, struct homa_peer *peer,
+			struct homa_sock *hsk)
+{
+	struct homa_common_hdr *h;
+	struct dst_entry *dst;
+	struct sk_buff *skb;
+	int extra_bytes;
+	int result;
+
+	dst = homa_get_dst(peer, hsk);
+	skb = homa_skb_new_tx(HOMA_MAX_HEADER);
+	if (unlikely(!skb))
+		return -ENOBUFS;
+	dst_hold(dst);
+	skb_dst_set(skb, dst);
+
+	h = skb_put(skb, length);
+	memcpy(h, contents, length);
+	extra_bytes = HOMA_MIN_PKT_LENGTH - length;
+	if (extra_bytes > 0)
+		memset(skb_put(skb, extra_bytes), 0, extra_bytes);
+	skb->ooo_okay = 1;
+	skb_get(skb);
+	if (hsk->inet.sk.sk_family == AF_INET6)
+		result = ip6_xmit(&hsk->inet.sk, skb, &peer->flow.u.ip6, 0,
+				  NULL, 0, 0);
+	else
+		result = ip_queue_xmit(&hsk->inet.sk, skb, &peer->flow);
+	if (unlikely(result != 0)) {
+		/* It appears that ip*_xmit frees skbuffs after
+		 * errors; the following code is to raise an alert if
+		 * this isn't actually the case. The extra skb_get above
+		 * and kfree_skb call below are needed to do the check
+		 * accurately (otherwise the buffer could be freed and
+		 * its memory used for some other purpose, resulting in
+		 * a bogus "reference count").
+		 */
+		if (refcount_read(&skb->users) > 1) {
+			if (hsk->inet.sk.sk_family == AF_INET6)
+				pr_notice("ip6_xmit didn't free Homa control packet (type %d) after error %d\n",
+					  h->type, result);
+			else
+				pr_notice("ip_queue_xmit didn't free Homa control packet (type %d) after error %d\n",
+					  h->type, result);
+		}
+	}
+	kfree_skb(skb);
+	return result;
+}
+
+/**
+ * homa_xmit_unknown() - Send an RPC_UNKNOWN packet to a peer.
+ * @skb:         Buffer containing an incoming packet; identifies the peer to
+ *               which the RPC_UNKNOWN packet should be sent.
+ * @hsk:         Socket that should be used to send the RPC_UNKNOWN packet.
+ */
+void homa_xmit_unknown(struct sk_buff *skb, struct homa_sock *hsk)
+{
+	struct homa_common_hdr *h = (struct homa_common_hdr *)skb->data;
+	struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
+	struct homa_rpc_unknown_hdr unknown;
+	struct homa_peer *peer;
+
+	unknown.common.sport = h->dport;
+	unknown.common.dport = h->sport;
+	unknown.common.type = RPC_UNKNOWN;
+	unknown.common.sender_id = cpu_to_be64(homa_local_id(h->sender_id));
+	peer = homa_peer_find(hsk->homa->peers, &saddr, &hsk->inet);
+	if (!IS_ERR(peer))
+		__homa_xmit_control(&unknown, sizeof(unknown), peer, hsk);
+}
+
+/**
+ * homa_xmit_data() - If an RPC has outbound data packets that are permitted
+ * to be transmitted according to the scheduling mechanism, arrange for
+ * them to be sent (some may be sent immediately; others may be sent
+ * later by the pacer thread).
+ * @rpc:       RPC to check for transmittable packets. Must be locked by
+ *             caller. Note: this function will release the RPC lock while
+ *             passing packets through the RPC stack, then reacquire it
+ *             before returning. It is possible that the RPC gets freed
+ *             when the lock isn't held, in which case the state will
+ *             be RPC_DEAD on return.
+ * @force:     True means send at least one packet, even if the NIC queue
+ *             is too long. False means that zero packets may be sent, if
+ *             the NIC queue is sufficiently long.
+ */
+void homa_xmit_data(struct homa_rpc *rpc, bool force)
+	__releases(rpc->bucket_lock)
+	__acquires(rpc->bucket_lock)
+{
+	struct homa *homa = rpc->hsk->homa;
+
+	homa_rpc_hold(rpc);
+	while (*rpc->msgout.next_xmit) {
+		struct sk_buff *skb = *rpc->msgout.next_xmit;
+
+		if ((rpc->msgout.length - rpc->msgout.next_xmit_offset)
+				>= homa->throttle_min_bytes) {
+			if (!homa_check_nic_queue(homa, skb, force)) {
+				homa_add_to_throttled(rpc);
+				break;
+			}
+		}
+
+		rpc->msgout.next_xmit = &(homa_get_skb_info(skb)->next_skb);
+		rpc->msgout.next_xmit_offset +=
+				homa_get_skb_info(skb)->data_bytes;
+
+		homa_rpc_unlock(rpc);
+		skb_get(skb);
+		__homa_xmit_data(skb, rpc);
+		force = false;
+		homa_rpc_lock(rpc);
+		if (rpc->state == RPC_DEAD)
+			break;
+	}
+	homa_rpc_put(rpc);
+}
+
+/**
+ * __homa_xmit_data() - Handles packet transmission stuff that is common
+ * to homa_xmit_data and homa_resend_data.
+ * @skb:      Packet to be sent. The packet will be freed after transmission
+ *            (and also if errors prevented transmission).
+ * @rpc:      Information about the RPC that the packet belongs to.
+ */
+void __homa_xmit_data(struct sk_buff *skb, struct homa_rpc *rpc)
+{
+	struct dst_entry *dst;
+
+	dst = homa_get_dst(rpc->peer, rpc->hsk);
+	dst_hold(dst);
+	skb_dst_set(skb, dst);
+
+	skb->ooo_okay = 1;
+	skb->ip_summed = CHECKSUM_PARTIAL;
+	skb->csum_start = skb_transport_header(skb) - skb->head;
+	skb->csum_offset = offsetof(struct homa_common_hdr, checksum);
+	if (rpc->hsk->inet.sk.sk_family == AF_INET6)
+		ip6_xmit(&rpc->hsk->inet.sk, skb, &rpc->peer->flow.u.ip6,
+			 0, NULL, 0, 0);
+	else
+		ip_queue_xmit(&rpc->hsk->inet.sk, skb, &rpc->peer->flow);
+}
+
+/**
+ * homa_resend_data() - This function is invoked as part of handling RESEND
+ * requests. It retransmits the packet(s) containing a given range of bytes
+ * from a message.
+ * @rpc:      RPC for which data should be resent.
+ * @start:    Offset within @rpc->msgout of the first byte to retransmit.
+ * @end:      Offset within @rpc->msgout of the byte just after the last one
+ *            to retransmit.
+ */
+void homa_resend_data(struct homa_rpc *rpc, int start, int end)
+{
+	struct homa_skb_info *homa_info;
+	struct sk_buff *skb;
+
+	if (end <= start)
+		return;
+
+	/* Each iteration of this loop checks one packet in the message
+	 * to see if it contains segments that need to be retransmitted.
+	 */
+	for (skb = rpc->msgout.packets; skb; skb = homa_info->next_skb) {
+		int seg_offset, offset, seg_length, data_left;
+		struct homa_data_hdr *h;
+
+		homa_info = homa_get_skb_info(skb);
+		offset = homa_info->offset;
+		if (offset >= end)
+			break;
+		if (start >= (offset + homa_info->data_bytes))
+			continue;
+
+		offset = homa_info->offset;
+		seg_offset = sizeof32(struct homa_data_hdr);
+		data_left = homa_info->data_bytes;
+		if (skb_shinfo(skb)->gso_segs <= 1) {
+			seg_length = data_left;
+		} else {
+			seg_length = homa_info->seg_length;
+			h = (struct homa_data_hdr *)skb_transport_header(skb);
+		}
+		for ( ; data_left > 0; data_left -= seg_length,
+		     offset += seg_length,
+		     seg_offset += skb_shinfo(skb)->gso_size) {
+			struct homa_skb_info *new_homa_info;
+			struct sk_buff *new_skb;
+			int err;
+
+			if (seg_length > data_left)
+				seg_length = data_left;
+
+			if (end <= offset)
+				goto resend_done;
+			if ((offset + seg_length) <= start)
+				continue;
+
+			/* This segment must be retransmitted. */
+			new_skb = homa_skb_new_tx(sizeof(struct homa_data_hdr)
+					+ seg_length);
+			if (unlikely(!new_skb))
+				goto resend_done;
+			h = __skb_put_data(new_skb, skb_transport_header(skb),
+					   sizeof32(struct homa_data_hdr));
+			h->common.sequence = htonl(offset);
+			h->seg.offset = htonl(offset);
+			h->retransmit = 1;
+			err = homa_skb_append_from_skb(rpc->hsk->homa, new_skb,
+						       skb, seg_offset,
+						       seg_length);
+			if (err != 0) {
+				pr_err("%s got error %d from homa_skb_append_from_skb\n",
+				       __func__, err);
+				kfree_skb(new_skb);
+				goto resend_done;
+			}
+
+			new_homa_info = homa_get_skb_info(new_skb);
+			new_homa_info->wire_bytes = rpc->hsk->ip_header_length
+					+ sizeof(struct homa_data_hdr)
+					+ seg_length + HOMA_ETH_OVERHEAD;
+			new_homa_info->data_bytes = seg_length;
+			new_homa_info->seg_length = seg_length;
+			new_homa_info->offset = offset;
+			homa_check_nic_queue(rpc->hsk->homa, new_skb, true);
+			__homa_xmit_data(new_skb, rpc);
+		}
+	}
+
+resend_done:
+	return;
+}
+
+/**
+ * homa_check_nic_queue() - This function is invoked before passing a packet
+ * to the NIC for transmission. It serves two purposes. First, it maintains
+ * an estimate of the NIC queue length. Second, it indicates to the caller
+ * whether the NIC queue is so full that no new packets should be queued
+ * (Homa's SRPT depends on keeping the NIC queue short).
+ * @homa:     Overall data about the Homa protocol implementation.
+ * @skb:      Packet that is about to be transmitted.
+ * @force:    True means this packet is going to be transmitted
+ *            regardless of the queue length.
+ * Return:    Nonzero is returned if either the NIC queue length is
+ *            acceptably short or @force was specified. 0 means that the
+ *            NIC queue is at capacity or beyond, so the caller should delay
+ *            the transmission of @skb. If nonzero is returned, then the
+ *            queue estimate is updated to reflect the transmission of @skb.
+ */
+int homa_check_nic_queue(struct homa *homa, struct sk_buff *skb, bool force)
+{
+	u64 idle, new_idle, clock, ns_for_packet;
+	int bytes;
+
+	bytes = homa_get_skb_info(skb)->wire_bytes;
+	ns_for_packet = homa->ns_per_mbyte;
+	ns_for_packet *= bytes;
+	do_div(ns_for_packet, 1000000);
+	while (1) {
+		clock = sched_clock();
+		idle = atomic64_read(&homa->link_idle_time);
+		if ((clock + homa->max_nic_queue_ns) < idle && !force &&
+		    !(homa->flags & HOMA_FLAG_DONT_THROTTLE))
+			return 0;
+		if (idle < clock)
+			new_idle = clock + ns_for_packet;
+		else
+			new_idle = idle + ns_for_packet;
+
+		/* This method must be thread-safe. */
+		if (atomic64_cmpxchg_relaxed(&homa->link_idle_time, idle,
+					     new_idle) == idle)
+			break;
+	}
+	return 1;
+}
+
+/**
+ * homa_pacer_main() - Top-level function for the pacer thread.
+ * @transport:  Pointer to struct homa.
+ *
+ * Return:         Always 0.
+ */
+int homa_pacer_main(void *transport)
+{
+	struct homa *homa = (struct homa *)transport;
+	bool work_left;
+
+	homa->pacer_wake_time = sched_clock();
+	while (1) {
+		if (homa->pacer_exit) {
+			homa->pacer_wake_time = 0;
+			break;
+		}
+		work_left = homa_pacer_xmit(homa);
+
+		/* Sleep this thread if the throttled list is empty. Even
+		 * if the throttled list isn't empty, call the scheduler
+		 * to give other processes a chance to run (if we don't,
+		 * softirq handlers can get locked out, which prevents
+		 * incoming packets from being handled).
+		 */
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (work_left)
+			__set_current_state(TASK_RUNNING);
+		homa->pacer_wake_time = 0;
+		schedule();
+		homa->pacer_wake_time = sched_clock();
+		__set_current_state(TASK_RUNNING);
+	}
+	kthread_complete_and_exit(&homa_pacer_kthread_done, 0);
+	return 0;
+}
+
+/**
+ * homa_pacer_xmit() - Transmit packets from  the throttled list. Note:
+ * this function may be invoked from either process context or softirq (BH)
+ * level. This function is invoked from multiple places, not just in the
+ * pacer thread. The reason for this is that (as of 10/2019) Linux's scheduling
+ * of the pacer thread is unpredictable: the thread may block for long periods
+ * of time (e.g., because it is assigned to the same CPU as a busy interrupt
+ * handler). This can result in poor utilization of the network link. So,
+ * this method gets invoked from other places as well, to increase the
+ * likelihood that we keep the link busy. Those other invocations are not
+ * guaranteed to happen, so the pacer thread provides a backstop.
+ * @homa:    Overall data about the Homa protocol implementation.
+ * Return:   False if there are no throttled RPCs at the time this
+ *           function returns, true if there are throttled RPCs or
+ *           if the answer is unknown at the time of return.
+ */
+bool homa_pacer_xmit(struct homa *homa)
+{
+	struct homa_rpc *rpc;
+	bool result = true;
+	int i;
+
+	/* Make sure only one instance of this function executes at a
+	 * time.
+	 */
+	if (!spin_trylock_bh(&homa->pacer_mutex))
+		return true;
+
+	/* Each iteration through the following loop sends one packet. We
+	 * limit the number of passes through this loop in order to cap the
+	 * time spent in one call to this function (see note in
+	 * homa_pacer_main about interfering with softirq handlers).
+	 */
+	for (i = 0; i < 5; i++) {
+		u64 idle_time, now;
+
+		/* If the NIC queue is too long, wait until it gets shorter. */
+		now = sched_clock();
+		idle_time = atomic64_read(&homa->link_idle_time);
+		while ((now + homa->max_nic_queue_ns) < idle_time) {
+			/* If we've xmitted at least one packet then
+			 * return (this helps with testing and also
+			 * allows homa_pacer_main to yield the core).
+			 */
+			if (i != 0)
+				goto done;
+			now = sched_clock();
+		}
+		/* Note: when we get here, it's possible that the NIC queue is
+		 * still too long because other threads have queued packets,
+		 * but we transmit anyway so we don't starve (see perf.text
+		 * for more info).
+		 */
+
+		/* Lock the first throttled RPC. This may not be possible
+		 * because we have to hold throttle_lock while locking
+		 * the RPC; that means we can't wait for the RPC lock because
+		 * of lock ordering constraints (see sync.txt). Thus, if
+		 * the RPC lock isn't available, do nothing. Holding the
+		 * throttle lock while locking the RPC is important because
+		 * it keeps the RPC from being deleted before it can be locked.
+		 */
+		homa_throttle_lock(homa);
+		homa->pacer_fifo_count -= homa->pacer_fifo_fraction;
+		if (homa->pacer_fifo_count <= 0) {
+			struct homa_rpc *cur;
+			u64 oldest = ~0;
+
+			homa->pacer_fifo_count += 1000;
+			rpc = NULL;
+			list_for_each_entry(cur, &homa->throttled_rpcs,
+						throttled_links) {
+				if (cur->msgout.init_ns < oldest) {
+					rpc = cur;
+					oldest = cur->msgout.init_ns;
+				}
+			}
+		} else {
+			rpc = list_first_entry_or_null(&homa->throttled_rpcs,
+						       struct homa_rpc,
+						       throttled_links);
+		}
+		if (!rpc) {
+			result = false;
+			homa_throttle_unlock(homa);
+			break;
+		}
+		if (!homa_rpc_try_lock(rpc)) {
+			homa_throttle_unlock(homa);
+			break;
+		}
+		homa_throttle_unlock(homa);
+
+		homa_xmit_data(rpc, true);
+
+		/* Note: rpc->state could be RPC_DEAD here, but the code
+		 * below should work anyway.
+		 */
+		if (!*rpc->msgout.next_xmit) {
+			/* Nothing more to transmit from this message (right
+			 * now), so remove it from the throttled list.
+			 */
+			homa_throttle_lock(homa);
+			if (!list_empty(&rpc->throttled_links))
+				list_del_init(&rpc->throttled_links);
+			result = !list_empty(&homa->throttled_rpcs);
+			homa_throttle_unlock(homa);
+		}
+		homa_rpc_unlock(rpc);
+	}
+done:
+	spin_unlock_bh(&homa->pacer_mutex);
+	return result;
+}
+
+/**
+ * homa_pacer_stop() - Will cause the pacer thread to exit (waking it up
+ * if necessary); doesn't return until after the pacer thread has exited.
+ * @homa:    Overall data about the Homa protocol implementation.
+ */
+void homa_pacer_stop(struct homa *homa)
+{
+	homa->pacer_exit = true;
+	wake_up_process(homa->pacer_kthread);
+	kthread_stop(homa->pacer_kthread);
+	homa->pacer_kthread = NULL;
+}
+
+/**
+ * homa_add_to_throttled() - Make sure that an RPC is on the throttled list
+ * and wake up the pacer thread if necessary.
+ * @rpc:     RPC with outbound packets that have been granted but can't be
+ *           sent because of NIC queue restrictions. Must be locked by caller.
+ */
+void homa_add_to_throttled(struct homa_rpc *rpc)
+	__must_hold(&rpc->bucket->lock)
+{
+	struct homa *homa = rpc->hsk->homa;
+	struct homa_rpc *candidate;
+	int bytes_left;
+	int checks = 0;
+	u64 now;
+
+	if (!list_empty(&rpc->throttled_links))
+		return;
+	now = sched_clock();
+	homa->throttle_add = now;
+	bytes_left = rpc->msgout.length - rpc->msgout.next_xmit_offset;
+	homa_throttle_lock(homa);
+	list_for_each_entry(candidate, &homa->throttled_rpcs,
+				throttled_links) {
+		int bytes_left_cand;
+
+		checks++;
+
+		/* Watch out: the pacer might have just transmitted the last
+		 * packet from candidate.
+		 */
+		bytes_left_cand = candidate->msgout.length -
+				candidate->msgout.next_xmit_offset;
+		if (bytes_left_cand > bytes_left) {
+			list_add_tail(&rpc->throttled_links,
+					  &candidate->throttled_links);
+			goto done;
+		}
+	}
+	list_add_tail(&rpc->throttled_links, &homa->throttled_rpcs);
+done:
+	homa_throttle_unlock(homa);
+	wake_up_process(homa->pacer_kthread);
+}
+
+/**
+ * homa_remove_from_throttled() - Make sure that an RPC is not on the
+ * throttled list.
+ * @rpc:     RPC of interest.
+ */
+void homa_remove_from_throttled(struct homa_rpc *rpc)
+{
+	if (unlikely(!list_empty(&rpc->throttled_links))) {
+		homa_throttle_lock(rpc->hsk->homa);
+		list_del(&rpc->throttled_links);
+		homa_throttle_unlock(rpc->hsk->homa);
+		INIT_LIST_HEAD(&rpc->throttled_links);
+	}
+}
+
-- 
2.34.1


