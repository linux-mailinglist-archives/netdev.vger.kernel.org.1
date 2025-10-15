Return-Path: <netdev+bounces-229718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 345B7BE043E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE02C357DC0
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D718303C9E;
	Wed, 15 Oct 2025 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Bvfeaujk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1762D6E72
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554319; cv=none; b=CtkFTO9QNh9V0m34W2dUzi96mOeDOYxDxOH/qiJHPDmCKutOHyisbA29pP+4BtpKe84XjRbIuhaAWJV/NsC//9ad4XAw0esmeCkB/Im+olpodGwczEGJGh7lumoWlSmryHvj3EHBZBDGsEduYBuVAiBG8XZG7yF8EfwuUIlqz8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554319; c=relaxed/simple;
	bh=8hcW4LLgdIwuSZTepqC+cuUHn9fNkTrmT15FtHdY7bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZdSEIGxv8h1xAxCKVlVEZKDhX2hjITmonpGyK5QeOO3Du1HxwTTo0KvU6kgo+8hZwQ/mKL7OU9uLT+yzFDh4OJIA02DjcMkPEYFnKvu/Fc73F297dORcfE0FFhGv0aIJm2Qr8Of1Rzs/rmpAmHSPf7LxSZyjEEMDRdFz5ei8gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Bvfeaujk; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8C+NNjcIHde9J3Jh5Nl/UH77+AmYPOuRih1ZLe+yC1I=; t=1760554317; x=1761418317; 
	b=BvfeaujkVvjYo9cJ/zN+BHEV0uCRkYiBdXsz027VPjjfuVV6PAWtnhDZtCF5qxjNmWsbebpo7MK
	o29dc95Oc21/9tjLamR4lk4aQKLf/vhVa47nZuM0eIMAOQ0pDW/vMaobWMybyIhStL4qByAr2AeCm
	Bi3ZO+FevpHg3uqdj801m5vF3BsKxQ87PwkRQ4VKAzu+/k45fx1FzI/2Ha+KpK++gdr2bDiA2W/9z
	Rw3mQJBrlj9YNucXKjqWHrdZ6IXB7cl3TkYLnGGxFm3sn5hRRzJ4UsLhQvT3h7BJc36BsXLo3aP+z
	Ob3iKNJeRJu8qQhV1jAAJW2eLN6YT1U6WquQ==;
Received: from ouster448.stanford.edu ([172.24.72.71]:50623 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1v96bK-00063x-Ia; Wed, 15 Oct 2025 11:51:56 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v16 09/14] net: homa: create homa_outgoing.c
Date: Wed, 15 Oct 2025 11:50:56 -0700
Message-ID: <20251015185102.2444-10-ouster@cs.stanford.edu>
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
X-Scan-Signature: 636d892a427dddec818989a9dd798a86

This file does most of the work of transmitting outgoing messages.
It is also responsible for copying data from user space into skbs.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v16:
* Set hsk->error_msg (for HOMAIOCINFO)
* Refactor pipelining mechanism in homa_message_out_fill
* Retain retransmitted packets until homa_rpc_reap (to ensure that RPCs
  don't get reaped with retransmitted packets still in the tx pipeline)

Changes for v14:
* Implement homa_rpc_tx_end function

Changes for v13:
* Fix bug in homa_resend_data: wasn't fully initializing new skb.
* Fix bug in homa_tx_data_pkt_alloc: wasn't allocating enough space
  in the new skb.

Changes for v12:
* Move RPC_DEAD check in homa_xmit_data to eliminate window for
  more complete coverage.

Changes for v11:
* Cleanup and simplify use of RPC reference counts.

Changes for v10:
* Revise sparse annotations to eliminate __context__ definition
* Remove log messages after alloc errors

Changes for v9:
* Use new homa_clock abstraction layer
* Various name improvements (e.g. use "alloc" instead of "new" for functions
  that allocate memory)
* Eliminate sizeof32 define: use sizeof instead

Changes for v7:
* Implement accounting for bytes in tx skbs
* Rename UNKNOWN packet type to RPC_UNKNOWN
* Use new RPC reference counts; eliminates need for RCU
* Remove locker argument from locking functions
* Use u64 and __u64 properly
* Fix incorrect skb check in homa_message_out_fill
---
 net/homa/homa_impl.h     |  14 +
 net/homa/homa_outgoing.c | 566 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 580 insertions(+)
 create mode 100644 net/homa/homa_outgoing.c

diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
index 0be394534ad5..c7570d1f85b2 100644
--- a/net/homa/homa_impl.h
+++ b/net/homa/homa_impl.h
@@ -362,13 +362,27 @@ static inline bool homa_make_header_avl(struct sk_buff *skb)
 
 extern unsigned int homa_net_id;
 
+int      homa_fill_data_interleaved(struct homa_rpc *rpc,
+				    struct sk_buff *skb, struct iov_iter *iter);
 int      homa_ioc_info(struct socket *sock, unsigned long arg);
+int      homa_message_out_fill(struct homa_rpc *rpc,
+			       struct iov_iter *iter, int xmit);
+void     homa_message_out_init(struct homa_rpc *rpc, int length);
 void     homa_rpc_handoff(struct homa_rpc *rpc);
+int      homa_rpc_tx_end(struct homa_rpc *rpc);
+struct sk_buff *homa_tx_data_pkt_alloc(struct homa_rpc *rpc,
+				       struct iov_iter *iter, int offset,
+				       int length, int max_seg_data);
 int      homa_xmit_control(enum homa_packet_type type, void *contents,
 			   size_t length, struct homa_rpc *rpc);
+int      __homa_xmit_control(void *contents, size_t length,
+			     struct homa_peer *peer, struct homa_sock *hsk);
+void     homa_xmit_unknown(struct sk_buff *skb, struct homa_sock *hsk);
 
 int      homa_message_in_init(struct homa_rpc *rpc, int unsched);
+void     homa_resend_data(struct homa_rpc *rpc, int start, int end);
 void     homa_xmit_data(struct homa_rpc *rpc);
+void     __homa_xmit_data(struct sk_buff *skb, struct homa_rpc *rpc);
 
 /**
  * homa_net() - Return the struct homa_net associated with a particular
diff --git a/net/homa/homa_outgoing.c b/net/homa/homa_outgoing.c
new file mode 100644
index 000000000000..d349739eccb1
--- /dev/null
+++ b/net/homa/homa_outgoing.c
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: BSD-2-Clause or GPL-2.0+
+
+/* This file contains functions related to the sender side of message
+ * transmission. It also contains utility functions for sending packets.
+ */
+
+#include "homa_impl.h"
+#include "homa_peer.h"
+#include "homa_rpc.h"
+#include "homa_wire.h"
+
+#include "homa_stub.h"
+
+/**
+ * homa_message_out_init() - Initialize rpc->msgout.
+ * @rpc:       RPC whose output message should be initialized. Must be
+ *             locked by caller.
+ * @length:    Number of bytes that will eventually be in rpc->msgout.
+ */
+void homa_message_out_init(struct homa_rpc *rpc, int length)
+	__must_hold(rpc->bucket->lock)
+{
+	memset(&rpc->msgout, 0, sizeof(rpc->msgout));
+	rpc->msgout.length = length;
+	rpc->msgout.next_xmit = &rpc->msgout.packets;
+	rpc->msgout.init_time = homa_clock();
+}
+
+/**
+ * homa_fill_data_interleaved() - This function is invoked to fill in the
+ * part of a data packet after the initial header, when GSO is being used.
+ * homa_seg_hdrs must be interleaved with the data to provide the correct
+ * offset for each segment.
+ * @rpc:            RPC whose output message is being created. Must be
+ *                  locked by caller.
+ * @skb:            The packet being filled. The initial homa_data_hdr was
+ *                  created and initialized by the caller and the
+ *                  homa_skb_info has been filled in with the packet geometry.
+ * @iter:           Describes location(s) of (remaining) message data in user
+ *                  space.
+ * Return:          Either a negative errno or 0 (for success).
+ */
+int homa_fill_data_interleaved(struct homa_rpc *rpc, struct sk_buff *skb,
+			       struct iov_iter *iter)
+	__must_hold(rpc->bucket->lock)
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
+ * homa_tx_data_pkt_alloc() - Allocate a new sk_buff and fill it with an
+ * outgoing Homa data packet. The resulting packet will be a GSO packet
+ * that will eventually be segmented by the NIC.
+ * @rpc:          RPC that packet will belong to (msgout must have been
+ *                initialized). Must be locked by caller.
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
+ * Return:        A pointer to the new packet, or a negative errno. Sets
+ *                rpc->hsk->error_msg on errors.
+ */
+struct sk_buff *homa_tx_data_pkt_alloc(struct homa_rpc *rpc,
+				       struct iov_iter *iter, int offset,
+				       int length, int max_seg_data)
+	__must_hold(rpc->bucket->lock)
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
+	skb = homa_skb_alloc_tx(sizeof(struct homa_data_hdr) + length +
+			      (segs - 1) * sizeof(struct homa_seg_hdr));
+	if (!skb) {
+		rpc->hsk->error_msg = "couldn't allocate sk_buff for outgoing message";
+		return ERR_PTR(-ENOMEM);
+	}
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
+	homa_info->rpc = rpc;
+
+	if (segs > 1) {
+		homa_set_doff(h, sizeof(struct homa_data_hdr)  -
+				sizeof(struct homa_seg_hdr));
+		gso_size = max_seg_data + sizeof(struct homa_seg_hdr);
+		err = homa_fill_data_interleaved(rpc, skb, iter);
+	} else {
+		gso_size = max_seg_data;
+		err = homa_skb_append_from_iter(rpc->hsk->homa, skb, iter,
+						length);
+	}
+	if (err) {
+		rpc->hsk->error_msg = "couldn't copy message body into packet buffers";
+		goto error;
+	}
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
+ *           rpc->state will be RPC_DEAD. Sets rpc->hsk->error_msg on errors.
+ */
+int homa_message_out_fill(struct homa_rpc *rpc, struct iov_iter *iter, int xmit)
+	__must_hold(rpc->bucket->lock)
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
+	struct sk_buff **last_link;
+	struct dst_entry *dst;
+	u64 segs_per_gso;
+	/* Bytes of the message that haven't yet been copied into skbs. */
+	int bytes_left;
+	int gso_size;
+	int err;
+
+	if (unlikely(iter->count > HOMA_MAX_MESSAGE_LENGTH ||
+		     iter->count == 0)) {
+		rpc->hsk->error_msg = "message length exceeded HOMA_MAX_MESSAGE_LENGTH";
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
+	dst_release(dst);
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
+		skb = homa_tx_data_pkt_alloc(rpc, iter, offset, skb_data_bytes,
+					     max_seg_data);
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
+			rpc->hsk->error_msg = "rpc deleted while creating outgoing message";
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
+		rpc->msgout.first_not_tx = rpc->msgout.packets;
+	}
+	refcount_add(rpc->msgout.skb_memory, &rpc->hsk->sock.sk_wmem_alloc);
+	if (xmit)
+		homa_xmit_data(rpc);
+	return 0;
+
+error:
+	refcount_add(rpc->msgout.skb_memory, &rpc->hsk->sock.sk_wmem_alloc);
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
+ *             Caller must hold either the lock or a reference.
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
+	struct sk_buff *skb;
+	int extra_bytes;
+	int result;
+
+	skb = homa_skb_alloc_tx(HOMA_MAX_HEADER);
+	if (unlikely(!skb))
+		return -ENOBUFS;
+	skb_dst_set(skb, homa_get_dst(peer, hsk));
+
+	h = skb_put(skb, length);
+	memcpy(h, contents, length);
+	extra_bytes = HOMA_MIN_PKT_LENGTH - length;
+	if (extra_bytes > 0)
+		memset(skb_put(skb, extra_bytes), 0, extra_bytes);
+	skb->ooo_okay = 1;
+	if (hsk->inet.sk.sk_family == AF_INET6)
+		result = ip6_xmit(&hsk->inet.sk, skb, &peer->flow.u.ip6, 0,
+				  NULL, 0, 0);
+	else
+		result = ip_queue_xmit(&hsk->inet.sk, skb, &peer->flow);
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
+	peer = homa_peer_get(hsk, &saddr);
+	if (!IS_ERR(peer))
+		__homa_xmit_control(&unknown, sizeof(unknown), peer, hsk);
+	homa_peer_release(peer);
+}
+
+/**
+ * homa_xmit_data() - If an RPC has outbound data packets that are permitted
+ * to be transmitted according to the scheduling mechanism, arrange for
+ * them to be sent.
+ * @rpc:       RPC to check for transmittable packets. Must be locked by
+ *             caller. Note: this function will release the RPC lock while
+ *             passing packets through the RPC stack, then reacquire it
+ *             before returning. It is possible that the RPC gets terminated
+ *             when the lock isn't held, in which case the state will
+ *             be RPC_DEAD on return.
+ */
+void homa_xmit_data(struct homa_rpc *rpc)
+	__must_hold(rpc->bucket->lock)
+{
+	int length;
+
+	while (*rpc->msgout.next_xmit && rpc->state != RPC_DEAD) {
+		struct sk_buff *skb = *rpc->msgout.next_xmit;
+
+		rpc->msgout.next_xmit = &(homa_get_skb_info(skb)->next_skb);
+		length = homa_get_skb_info(skb)->data_bytes;
+		rpc->msgout.next_xmit_offset += length;
+
+		homa_rpc_unlock(rpc);
+		skb_get(skb);
+		__homa_xmit_data(skb, rpc);
+		homa_rpc_lock(rpc);
+	}
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
+	skb_dst_set(skb, homa_get_dst(rpc->peer, rpc->hsk));
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
+	__must_hold(rpc->bucket->lock)
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
+		seg_offset = sizeof(struct homa_data_hdr);
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
+			new_skb = homa_skb_alloc_tx(sizeof(struct homa_data_hdr) +
+						    seg_length);
+			if (unlikely(!new_skb))
+				goto resend_done;
+			h = __skb_put_data(new_skb, skb_transport_header(skb),
+					   sizeof(struct homa_data_hdr));
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
+			new_homa_info->next_skb = rpc->msgout.to_free;
+			new_homa_info->wire_bytes = rpc->hsk->ip_header_length
+					+ sizeof(struct homa_data_hdr)
+					+ seg_length + HOMA_ETH_OVERHEAD;
+			new_homa_info->data_bytes = seg_length;
+			new_homa_info->seg_length = seg_length;
+			new_homa_info->offset = offset;
+			new_homa_info->rpc = rpc;
+
+			rpc->msgout.to_free = new_skb;
+			rpc->msgout.num_skbs++;
+			skb_get(new_skb);
+			__homa_xmit_data(new_skb, rpc);
+		}
+	}
+
+resend_done:
+	return;
+}
+
+/**
+ * homa_rpc_tx_end() - Return the offset of the first byte in an
+ * RPC's outgoing message that has not yet been fully transmitted.
+ * "Fully transmitted" means the message has been transmitted by the
+ * NIC and the skb has been released by the driver. This is different from
+ * rpc->msgout.next_xmit_offset, which computes the first offset that
+ * hasn't yet been passed to the IP stack.
+ * @rpc:    RPC to check
+ * Return:  See above. If the message has been fully transmitted then
+ *          rpc->msgout.length is returned.
+ */
+int homa_rpc_tx_end(struct homa_rpc *rpc)
+{
+	struct sk_buff *skb = rpc->msgout.first_not_tx;
+
+	while (skb) {
+		struct homa_skb_info *homa_info = homa_get_skb_info(skb);
+
+		/* next_xmit_offset tells us whether the packet has been
+		 * passed to the IP stack. Checking the reference count tells
+		 * us whether the packet has been released by the driver
+		 * (which only happens after notification from the NIC that
+		 * transmission is complete).
+		 */
+		if (homa_info->offset >= rpc->msgout.next_xmit_offset ||
+		    refcount_read(&skb->users) > 1)
+			return homa_info->offset;
+		skb = homa_info->next_skb;
+		rpc->msgout.first_not_tx = skb;
+	}
+	return rpc->msgout.length;
+}
-- 
2.43.0


