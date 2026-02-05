Return-Path: <netdev+bounces-257195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPbZFZGjhGmo4AMAu9opvQ
	(envelope-from <netdev+bounces-257195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:05:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A93DF3BED
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6FED307653B
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 13:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3873F3E95B2;
	Thu,  5 Feb 2026 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJilIFre"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DF93E958E
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299901; cv=none; b=uuVVOSkJsfSkJ87l0K99pGhT3QKSn+LZ5WC9y2Wln9YjEsvEkpurZffo3gBkkbO+Qwt3usrVXbHfPWFn+UBlWyJKNJxwN4Qtvf+tvUYvcTNkyWKtQB8cWfL4+oZmr8OmCtbv0KWuMg6AOFuliMO6BNBhS7bRTy9Mmpgucmd96sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299901; c=relaxed/simple;
	bh=KFIJWYDk0LPmipyBE2XmhZ5lNl7+s3bkN9vsX7IpxCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4ZUcXsi4A0/mL6N78VXyXYtWGW6OuzSMu+FSShoioc8Be8w1rUkklHzF08ny9gA7bl/zjvtRDkh53NDxt6TVzJUhKxTp6JvNc2D4zAfLHW4oavbUxDwX7Yot4qAuxnMRoaXripTeM6ciAgt7/QRNoKwJlfYt4Rd3iFpL4/GhfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RJilIFre; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770299899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PVHYb6htX6Gf6M4T0l/e5hSU8wZ8UlANWHS/PIe1TTc=;
	b=RJilIFre4cs6eSVAYV5xbTglqVib/PLjF1QKaCiqeGMrBk17neqjWobP10+Beb0UUJzOJg
	7nPCOOrlHwmWU0TEvkc1DePrS/+AjzdkCKNBAiX4KSgMyMm+NmWLH/+FGk0Vu551dXQMOP
	XW8FZBtl3eLsJH5LPt5fixnMvE2M8So=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-TN80yDKWMNqEXwGglMJ3Sg-1; Thu,
 05 Feb 2026 08:58:16 -0500
X-MC-Unique: TN80yDKWMNqEXwGglMJ3Sg-1
X-Mimecast-MFC-AGG-ID: TN80yDKWMNqEXwGglMJ3Sg_1770299894
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2F741800451;
	Thu,  5 Feb 2026 13:58:14 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.32.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3CE819560A7;
	Thu,  5 Feb 2026 13:58:10 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jkarrenpalo@gmail.com,
	tglx@kernel.org,
	mingo@kernel.org,
	bigeasy@linutronix.de,
	matttbe@kernel.org,
	allison.henderson@oracle.com,
	petrm@nvidia.com,
	antonio@openvpn.net,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH net-next v4 6/8] hsr: Implement more robust duplicate discard for HSR
Date: Thu,  5 Feb 2026 14:57:33 +0100
Message-ID: <36dc3bc5bdb7e68b70bb5ef86f53ca95a3f35418.1770299429.git.fmaurer@redhat.com>
In-Reply-To: <cover.1770299429.git.fmaurer@redhat.com>
References: <cover.1770299429.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net,smile.fr];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257195-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fr:email,linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A93DF3BED
X-Rspamd-Action: no action

The HSR duplicate discard algorithm had even more basic problems than the
described for PRP in the previous patch. It relied only on the last
received sequence number to decide if a new frame should be forwarded to
any port. This does not work correctly in any case where frames are
received out of order. The linked bug report claims that this can even
happen with perfectly fine links due to the order in which incoming frames
are processed (which can be unexpected on multi-core systems). The issue
also occasionally shows up in the HSR selftests. The main reason is that
the sequence number that was last forwarded to the master port may have
skipped a number which will in turn never be delivered to the host.

As the problem (we accidentally skip over a sequence number that has not
been received but will be received in the future) is similar to PRP, we can
apply a similar solution. The duplicate discard algorithm based on the
"sparse bitmap" works well for HSR if it is extended to track one bitmap
for each port (A, B, master, interlink). To do this, change the sequence
number blocks to contain a flexible array member as the last member that
can keep chunks for as many bitmaps as we need. This design makes it easy
to reuse the same algorithm in a potential PRP RedBox implementation.

The duplicate discard algorithm functions are modified to deal with
sequence number blocks of different sizes and to correctly use the array of
bitmap chunks. There is a notable speciality for HSR: the port type has a
special port type NONE with value 0. This leads to the number of port types
being 5 instead of actually 4. To save memory, remove the NONE port from
the bitmap (by subtracting 1) when setting up the block buffer and when
accessing the bitmap chunks in the array.

Removing the old algorithm allows us to get rid of a few fields that are
not needed any more: time_out and seq_out for each port. We can also remove
some functions that were only necessary for the previous duplicate discard
algorithm.

The removal of seq_out is possible despite its previous usage in
hsr_register_frame_in: it was used to prevent updates to time_in when
"invalid" sequence numbers were received. With the new duplicate discard
algorithm, time_in has no relevance for the expiry of sequence numbers
anymore. They will expire based on the timestamps in the sequence number
blocks after at most 400ms. There is no need that a node "re-registers" to
"resume communication": after 400ms, all sequence numbers are accepted
again. Also, according to the IEC 62439-3:2021, all nodes are supposed to
send no traffic for 500ms after boot to lead exactly to this expiry of seen
sequence numbers. time_in is still used for pruning nodes from the node
table after no traffic has been received for 60sec. Pruning is only needed
if the node is really gone and has not been sending any traffic for that
period.

seq_out was also used to report the last incoming sequence number from a
node through netlink. I am not sure how useful this value is to userspace
at all, but added getting it from the sequence number blocks. This number
can be outdated after node merging until a new block has been added.

Update the KUnit test for the PRP duplicate discard so that the node
allocation matches and expectations on the removed fields are removed.

Reported-by: Yoann Congal <yoann.congal@smile.fr>
Closes: https://lore.kernel.org/netdev/7d221a07-8358-4c0b-a09c-3b029c052245@smile.fr/
Signed-off-by: Felix Maurer <fmaurer@redhat.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_framereg.c         | 216 +++++++++++++++++----------------
 net/hsr/hsr_framereg.h         |  20 ++-
 net/hsr/prp_dup_discard_test.c |  38 ++----
 3 files changed, 131 insertions(+), 143 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 7e21e607efc6..7d87f304ded4 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -20,23 +20,6 @@
 #include "hsr_framereg.h"
 #include "hsr_netlink.h"
 
-/* seq_nr_after(a, b) - return true if a is after (higher in sequence than) b,
- * false otherwise.
- */
-static bool seq_nr_after(u16 a, u16 b)
-{
-	/* Remove inconsistency where
-	 * seq_nr_after(a, b) == seq_nr_before(a, b)
-	 */
-	if ((int)b - a == 32768)
-		return false;
-
-	return (((s16)(b - a)) < 0);
-}
-
-#define seq_nr_before(a, b)		seq_nr_after((b), (a))
-#define seq_nr_before_or_eq(a, b)	(!seq_nr_after((a), (b)))
-
 bool hsr_addr_is_redbox(struct hsr_priv *hsr, unsigned char *addr)
 {
 	if (!hsr->redbox || !is_valid_ether_addr(hsr->macaddress_redbox))
@@ -164,18 +147,16 @@ void prp_handle_san_frame(bool san, enum hsr_port_type port,
 		node->san_b = true;
 }
 
-/* Allocate an hsr_node and add it to node_db. 'addr' is the node's address_A;
- * seq_out is used to initialize filtering of outgoing duplicate frames
- * originating from the newly added node.
+/* Allocate an hsr_node and add it to node_db. 'addr' is the node's address_A.
  */
 static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 				     struct list_head *node_db,
-				     unsigned char addr[],
-				     u16 seq_out, bool san,
+				     unsigned char addr[], bool san,
 				     enum hsr_port_type rx_port)
 {
 	struct hsr_node *new_node, *node = NULL;
 	unsigned long now;
+	size_t block_sz;
 	int i;
 
 	new_node = kzalloc(sizeof(*new_node), GFP_ATOMIC);
@@ -185,9 +166,13 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 	ether_addr_copy(new_node->macaddress_A, addr);
 	spin_lock_init(&new_node->seq_out_lock);
 
-	new_node->block_buf = kcalloc(HSR_MAX_SEQ_BLOCKS,
-				      sizeof(struct hsr_seq_block),
-				      GFP_ATOMIC);
+	if (hsr->prot_version == PRP_V1)
+		new_node->seq_port_cnt = 1;
+	else
+		new_node->seq_port_cnt = HSR_PT_PORTS - 1;
+
+	block_sz = hsr_seq_block_size(new_node);
+	new_node->block_buf = kcalloc(HSR_MAX_SEQ_BLOCKS, block_sz, GFP_ATOMIC);
 	if (!new_node->block_buf)
 		goto free;
 
@@ -199,8 +184,6 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 	now = jiffies;
 	for (i = 0; i < HSR_PT_PORTS; i++) {
 		new_node->time_in[i] = now;
-		new_node->time_out[i] = now;
-		new_node->seq_out[i] = seq_out;
 	}
 
 	if (san && hsr->proto_ops->handle_san_frame)
@@ -245,7 +228,6 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 	struct ethhdr *ethhdr;
 	struct prp_rct *rct;
 	bool san = false;
-	u16 seq_out;
 
 	if (!skb_mac_header_was_set(skb))
 		return NULL;
@@ -282,24 +264,13 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 		/* Check if skb contains hsr_ethhdr */
 		if (skb->mac_len < sizeof(struct hsr_ethhdr))
 			return NULL;
-
-		/* Use the existing sequence_nr from the tag as starting point
-		 * for filtering duplicate frames.
-		 */
-		seq_out = hsr_get_skb_sequence_nr(skb) - 1;
 	} else {
 		rct = skb_get_PRP_rct(skb);
-		if (rct && prp_check_lsdu_size(skb, rct, is_sup)) {
-			seq_out = prp_get_skb_sequence_nr(rct);
-		} else {
-			if (rx_port != HSR_PT_MASTER)
-				san = true;
-			seq_out = HSR_SEQNR_START;
-		}
+		if (!rct && rx_port != HSR_PT_MASTER)
+			san = true;
 	}
 
-	return hsr_add_node(hsr, node_db, ethhdr->h_source, seq_out,
-			    san, rx_port);
+	return hsr_add_node(hsr, node_db, ethhdr->h_source, san, rx_port);
 }
 
 static bool hsr_seq_block_is_old(struct hsr_seq_block *block)
@@ -328,6 +299,7 @@ VISIBLE_IF_KUNIT struct hsr_seq_block *hsr_get_seq_block(struct hsr_node *node,
 							 u16 block_idx)
 {
 	struct hsr_seq_block *block, *res;
+	size_t block_sz;
 
 	block = xa_load(&node->seq_blocks, block_idx);
 
@@ -337,10 +309,11 @@ VISIBLE_IF_KUNIT struct hsr_seq_block *hsr_get_seq_block(struct hsr_node *node,
 	}
 
 	if (!block) {
-		block = &node->block_buf[node->next_block];
+		block_sz = hsr_seq_block_size(node);
+		block = node->block_buf + node->next_block * block_sz;
 		hsr_forget_seq_block(node, block);
 
-		memset(block, 0, sizeof(*block));
+		memset(block, 0, block_sz);
 		block->time = jiffies;
 		block->block_idx = block_idx;
 
@@ -420,8 +393,7 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 	if (!node_real)
 		/* No frame received from AddrA of this node yet */
 		node_real = hsr_add_node(hsr, node_db, hsr_sp->macaddress_A,
-					 HSR_SEQNR_START - 1, true,
-					 port_rcv->type);
+					 true, port_rcv->type);
 	if (!node_real)
 		goto done; /* No mem */
 	if (node_real == node_curr)
@@ -468,8 +440,6 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 			node_real->time_in_stale[i] =
 						node_curr->time_in_stale[i];
 		}
-		if (seq_nr_after(node_curr->seq_out[i], node_real->seq_out[i]))
-			node_real->seq_out[i] = node_curr->seq_out[i];
 	}
 
 	xa_for_each(&node_curr->seq_blocks, idx, src_blk) {
@@ -480,8 +450,10 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 		if (!merge_blk)
 			continue;
 		merge_blk->time = min(merge_blk->time, src_blk->time);
-		bitmap_or(merge_blk->seq_nrs, merge_blk->seq_nrs,
-			  src_blk->seq_nrs, HSR_SEQ_BLOCK_SIZE);
+		for (i = 0; i < node_real->seq_port_cnt; i++) {
+			bitmap_or(merge_blk->seq_nrs[i], merge_blk->seq_nrs[i],
+				  src_blk->seq_nrs[i], HSR_SEQ_BLOCK_SIZE);
+		}
 	}
 	spin_unlock_bh(&node_real->seq_out_lock);
 	node_real->addr_B_port = port_rcv->type;
@@ -558,60 +530,28 @@ void hsr_addr_subst_dest(struct hsr_node *node_src, struct sk_buff *skb,
 void hsr_register_frame_in(struct hsr_node *node, struct hsr_port *port,
 			   u16 sequence_nr)
 {
-	/* Don't register incoming frames without a valid sequence number. This
-	 * ensures entries of restarted nodes gets pruned so that they can
-	 * re-register and resume communications.
-	 */
-	if (!(port->dev->features & NETIF_F_HW_HSR_TAG_RM) &&
-	    seq_nr_before(sequence_nr, node->seq_out[port->type]))
-		return;
-
 	node->time_in[port->type] = jiffies;
 	node->time_in_stale[port->type] = false;
 }
 
-/* 'skb' is a HSR Ethernet frame (with a HSR tag inserted), with a valid
- * ethhdr->h_source address and skb->mac_header set.
- *
- * Return:
- *	 1 if frame can be shown to have been sent recently on this interface,
- *	 0 otherwise, or
- *	 negative error code on error
- */
-int hsr_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
-{
-	struct hsr_node *node = frame->node_src;
-	u16 sequence_nr = frame->sequence_nr;
-
-	spin_lock_bh(&node->seq_out_lock);
-	if (seq_nr_before_or_eq(sequence_nr, node->seq_out[port->type]) &&
-	    time_is_after_jiffies(node->time_out[port->type] +
-	    msecs_to_jiffies(HSR_ENTRY_FORGET_TIME))) {
-		spin_unlock_bh(&node->seq_out_lock);
-		return 1;
-	}
-
-	node->time_out[port->type] = jiffies;
-	node->seq_out[port->type] = sequence_nr;
-	spin_unlock_bh(&node->seq_out_lock);
-	return 0;
-}
-
-/* PRP duplicate discard algorithm: we maintain a bitmap where we set a bit for
+/* Duplicate discard algorithm: we maintain a bitmap where we set a bit for
  * every seen sequence number. The bitmap is split into blocks and the block
  * management is detailed in hsr_get_seq_block(). In any case, we err on the
  * side of accepting a packet, as the specification requires the algorithm to
  * be "designed such that it never rejects a legitimate frame, while occasional
  * acceptance of a duplicate can be tolerated." (IEC 62439-3:2021, 4.1.10.3).
+ * While this requirement is explicit for PRP, applying it to HSR does no harm
+ * either.
  *
- * 'port' is the outgoing interface
  * 'frame' is the frame to be sent
+ * 'port_type' is the type of the outgoing interface
  *
  * Return:
  *	 1 if frame can be shown to have been sent recently on this interface,
  *	 0 otherwise
  */
-int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
+static int hsr_check_duplicate(struct hsr_frame_info *frame,
+			       unsigned int port_type)
 {
 	u16 sequence_nr, seq_bit, block_idx;
 	struct hsr_seq_block *block;
@@ -620,20 +560,8 @@ int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
 	node = frame->node_src;
 	sequence_nr = frame->sequence_nr;
 
-	/* out-going frames are always in order */
-	if (frame->port_rcv->type == HSR_PT_MASTER) {
-		spin_lock_bh(&node->seq_out_lock);
-		node->time_out[port->type] = jiffies;
-		node->seq_out[port->type] = sequence_nr;
-		spin_unlock_bh(&node->seq_out_lock);
+	if (WARN_ON_ONCE(port_type >= node->seq_port_cnt))
 		return 0;
-	}
-
-	/* for PRP we should only forward frames from the slave ports
-	 * to the master port
-	 */
-	if (port->type != HSR_PT_MASTER)
-		return 1;
 
 	spin_lock_bh(&node->seq_out_lock);
 
@@ -643,11 +571,9 @@ int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
 		goto out_new;
 
 	seq_bit = hsr_seq_block_bit(sequence_nr);
-	if (__test_and_set_bit(seq_bit, block->seq_nrs))
+	if (__test_and_set_bit(seq_bit, block->seq_nrs[port_type]))
 		goto out_seen;
 
-	node->time_out[port->type] = jiffies;
-	node->seq_out[port->type] = sequence_nr;
 out_new:
 	spin_unlock_bh(&node->seq_out_lock);
 	return 0;
@@ -656,6 +582,49 @@ int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
 	spin_unlock_bh(&node->seq_out_lock);
 	return 1;
 }
+
+/* HSR duplicate discard: we check if the same frame has already been sent on
+ * this outgoing interface. The check follows the general duplicate discard
+ * algorithm.
+ *
+ * 'port' is the outgoing interface
+ * 'frame' is the frame to be sent
+ *
+ * Return:
+ *	 1 if frame can be shown to have been sent recently on this interface,
+ *	 0 otherwise
+ */
+int hsr_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
+{
+	return hsr_check_duplicate(frame, port->type - 1);
+}
+
+/* PRP duplicate discard: we only consider frames that are received on port A
+ * or port B and should go to the master port. For those, we check if they have
+ * already been received by the host, i.e., master port. The check uses the
+ * general duplicate discard algorithm, but without tracking multiple ports.
+ *
+ * 'port' is the outgoing interface
+ * 'frame' is the frame to be sent
+ *
+ * Return:
+ *	 1 if frame can be shown to have been sent recently on this interface,
+ *	 0 otherwise
+ */
+int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
+{
+	/* out-going frames are always in order */
+	if (frame->port_rcv->type == HSR_PT_MASTER)
+		return 0;
+
+	/* for PRP we should only forward frames from the slave ports
+	 * to the master port
+	 */
+	if (port->type != HSR_PT_MASTER)
+		return 1;
+
+	return hsr_check_duplicate(frame, 0);
+}
 EXPORT_SYMBOL_IF_KUNIT(prp_register_frame_out);
 
 static struct hsr_port *get_late_port(struct hsr_priv *hsr,
@@ -806,6 +775,39 @@ void *hsr_get_next_node(struct hsr_priv *hsr, void *_pos,
 	return NULL;
 }
 
+/* Fill the last sequence number that has been received from node on if1 by
+ * finding the last sequence number sent on port B; accordingly get the last
+ * received sequence number for if2 using sent sequence numbers on port A.
+ */
+static void fill_last_seq_nrs(struct hsr_node *node, u16 *if1_seq, u16 *if2_seq)
+{
+	struct hsr_seq_block *block;
+	unsigned int block_off;
+	size_t block_sz;
+	u16 seq_bit;
+
+	spin_lock_bh(&node->seq_out_lock);
+
+	/* Get last inserted block */
+	block_off = (node->next_block - 1) & (HSR_MAX_SEQ_BLOCKS - 1);
+	block_sz = hsr_seq_block_size(node);
+	block = node->block_buf + block_off * block_sz;
+
+	if (!bitmap_empty(block->seq_nrs[HSR_PT_SLAVE_B - 1],
+			  HSR_SEQ_BLOCK_SIZE)) {
+		seq_bit = find_last_bit(block->seq_nrs[HSR_PT_SLAVE_B - 1],
+					HSR_SEQ_BLOCK_SIZE);
+		*if1_seq = (block->block_idx << HSR_SEQ_BLOCK_SHIFT) | seq_bit;
+	}
+	if (!bitmap_empty(block->seq_nrs[HSR_PT_SLAVE_A - 1],
+			  HSR_SEQ_BLOCK_SIZE)) {
+		seq_bit = find_last_bit(block->seq_nrs[HSR_PT_SLAVE_A - 1],
+					HSR_SEQ_BLOCK_SIZE);
+		*if2_seq = (block->block_idx << HSR_SEQ_BLOCK_SHIFT) | seq_bit;
+	}
+	spin_unlock_bh(&node->seq_out_lock);
+}
+
 int hsr_get_node_data(struct hsr_priv *hsr,
 		      const unsigned char *addr,
 		      unsigned char addr_b[ETH_ALEN],
@@ -846,8 +848,10 @@ int hsr_get_node_data(struct hsr_priv *hsr,
 		*if2_age = jiffies_to_msecs(tdiff);
 
 	/* Present sequence numbers as if they were incoming on interface */
-	*if1_seq = node->seq_out[HSR_PT_SLAVE_B];
-	*if2_seq = node->seq_out[HSR_PT_SLAVE_A];
+	*if1_seq = 0;
+	*if2_seq = 0;
+	if (hsr->prot_version != PRP_V1)
+		fill_last_seq_nrs(node, if1_seq, if2_seq);
 
 	if (node->addr_B_port != HSR_PT_NONE) {
 		port = hsr_port_get_hsr(hsr, node->addr_B_port);
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index 686f2a595400..c65ecb925734 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -89,12 +89,15 @@ struct hsr_seq_block *hsr_get_seq_block(struct hsr_node *node, u16 block_idx);
 struct hsr_seq_block {
 	unsigned long		time;
 	u16			block_idx;
-	DECLARE_BITMAP(seq_nrs, HSR_SEQ_BLOCK_SIZE);
+	/* Should be a flexible array member of what DECLARE_BITMAP() would
+	 * produce.
+	 */
+	unsigned long		seq_nrs[][BITS_TO_LONGS(HSR_SEQ_BLOCK_SIZE)];
 };
 
 struct hsr_node {
 	struct list_head	mac_list;
-	/* Protect R/W access to seq_out and seq_blocks */
+	/* Protect R/W access seq_blocks */
 	spinlock_t		seq_out_lock;
 	unsigned char		macaddress_A[ETH_ALEN];
 	unsigned char		macaddress_B[ETH_ALEN];
@@ -102,17 +105,22 @@ struct hsr_node {
 	enum hsr_port_type	addr_B_port;
 	unsigned long		time_in[HSR_PT_PORTS];
 	bool			time_in_stale[HSR_PT_PORTS];
-	unsigned long		time_out[HSR_PT_PORTS];
 	/* if the node is a SAN */
 	bool			san_a;
 	bool			san_b;
-	u16			seq_out[HSR_PT_PORTS];
 	bool			removed;
-	/* PRP specific duplicate handling */
+	/* Duplicate detection */
 	struct xarray		seq_blocks;
-	struct hsr_seq_block	*block_buf;
+	void			*block_buf;
 	unsigned int		next_block;
+	unsigned int		seq_port_cnt;
 	struct rcu_head		rcu_head;
 };
 
+static inline size_t hsr_seq_block_size(struct hsr_node *node)
+{
+	WARN_ON_ONCE(node->seq_port_cnt == 0);
+	return struct_size_t(struct hsr_seq_block, seq_nrs, node->seq_port_cnt);
+}
+
 #endif /* __HSR_FRAMEREG_H */
diff --git a/net/hsr/prp_dup_discard_test.c b/net/hsr/prp_dup_discard_test.c
index bfa3d318ec04..b028e71e6a0f 100644
--- a/net/hsr/prp_dup_discard_test.c
+++ b/net/hsr/prp_dup_discard_test.c
@@ -15,12 +15,15 @@ struct prp_test_data {
 
 static struct prp_test_data *build_prp_test_data(struct kunit *test)
 {
+	size_t block_sz;
+
 	struct prp_test_data *data = kunit_kzalloc(test,
 		sizeof(struct prp_test_data), GFP_USER);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, data);
 
-	data->node.block_buf = kunit_kcalloc(test, HSR_MAX_SEQ_BLOCKS,
-					     sizeof(struct hsr_seq_block),
+	data->node.seq_port_cnt = 1;
+	block_sz = hsr_seq_block_size(&data->node);
+	data->node.block_buf = kunit_kcalloc(test, HSR_MAX_SEQ_BLOCKS, block_sz,
 					     GFP_ATOMIC);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, data->node.block_buf);
 
@@ -30,8 +33,6 @@ static struct prp_test_data *build_prp_test_data(struct kunit *test)
 	data->frame.node_src = &data->node;
 	data->frame.port_rcv = &data->port_rcv;
 	data->port_rcv.type = HSR_PT_SLAVE_A;
-	data->node.seq_out[HSR_PT_MASTER] = 0;
-	data->node.time_out[HSR_PT_MASTER] = jiffies;
 	data->port.type = HSR_PT_MASTER;
 
 	return data;
@@ -48,7 +49,7 @@ static void check_prp_frame_seen(struct kunit *test, struct prp_test_data *data,
 	KUNIT_EXPECT_NOT_NULL(test, block);
 
 	seq_bit = sequence_nr & HSR_SEQ_BLOCK_MASK;
-	KUNIT_EXPECT_TRUE(test, test_bit(seq_bit, block->seq_nrs));
+	KUNIT_EXPECT_TRUE(test, test_bit(seq_bit, block->seq_nrs[0]));
 }
 
 static void check_prp_frame_unseen(struct kunit *test,
@@ -62,7 +63,7 @@ static void check_prp_frame_unseen(struct kunit *test,
 	KUNIT_EXPECT_NOT_NULL(test, block);
 
 	seq_bit = sequence_nr & HSR_SEQ_BLOCK_MASK;
-	KUNIT_EXPECT_FALSE(test, test_bit(seq_bit, block->seq_nrs));
+	KUNIT_EXPECT_FALSE(test, test_bit(seq_bit, block->seq_nrs[0]));
 }
 
 static void prp_dup_discard_forward(struct kunit *test)
@@ -73,30 +74,20 @@ static void prp_dup_discard_forward(struct kunit *test)
 	data->frame.sequence_nr = 2;
 	KUNIT_EXPECT_EQ(test, 0,
 			prp_register_frame_out(&data->port, &data->frame));
-	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
-			data->node.seq_out[HSR_PT_MASTER]);
-	KUNIT_EXPECT_EQ(test, jiffies, data->node.time_out[HSR_PT_MASTER]);
 	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 }
 
 static void prp_dup_discard_drop_duplicate(struct kunit *test)
 {
 	struct prp_test_data *data = build_prp_test_data(test);
-	unsigned long time = jiffies - 10;
 
 	data->frame.sequence_nr = 2;
 	KUNIT_EXPECT_EQ(test, 0,
 			prp_register_frame_out(&data->port, &data->frame));
-	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
-			data->node.seq_out[HSR_PT_MASTER]);
 	check_prp_frame_seen(test, data, data->frame.sequence_nr);
-	data->node.time_out[HSR_PT_MASTER] = time;
 
 	KUNIT_EXPECT_EQ(test, 1,
 			prp_register_frame_out(&data->port, &data->frame));
-	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
-			data->node.seq_out[HSR_PT_MASTER]);
-	KUNIT_EXPECT_EQ(test, time, data->node.time_out[HSR_PT_MASTER]);
 	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 }
 
@@ -123,9 +114,6 @@ static void prp_dup_discard_entry_timeout(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, 0,
 			prp_register_frame_out(&data->port, &data->frame));
-	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
-			data->node.seq_out[HSR_PT_MASTER]);
-	KUNIT_EXPECT_EQ(test, jiffies, data->node.time_out[HSR_PT_MASTER]);
 	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 	check_prp_frame_unseen(test, data, 7);
 }
@@ -139,16 +127,12 @@ static void prp_dup_discard_out_of_sequence(struct kunit *test)
 	data->frame.sequence_nr = 9;
 	KUNIT_EXPECT_EQ(test, 0,
 			prp_register_frame_out(&data->port, &data->frame));
-	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
-			data->node.seq_out[HSR_PT_MASTER]);
 	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 
 	/* 1st old frame, should be accepted */
 	data->frame.sequence_nr = 8;
 	KUNIT_EXPECT_EQ(test, 0,
 			prp_register_frame_out(&data->port, &data->frame));
-	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
-			data->node.seq_out[HSR_PT_MASTER]);
 	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 
 	/* 2nd frame should be dropped */
@@ -162,8 +146,6 @@ static void prp_dup_discard_out_of_sequence(struct kunit *test)
 	data->port_rcv.type = HSR_PT_SLAVE_A;
 	KUNIT_EXPECT_EQ(test, 0,
 			prp_register_frame_out(&data->port, &data->frame));
-	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
-			data->node.seq_out[HSR_PT_MASTER]);
 	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 
 	/* and next one is dropped */
@@ -178,20 +160,14 @@ static void prp_dup_discard_lan_b_late(struct kunit *test)
 	/* LAN B is behind */
 	struct prp_test_data *data = build_prp_test_data(test);
 
-	data->node.seq_out[HSR_PT_MASTER] = 8;
-
 	data->frame.sequence_nr = 9;
 	KUNIT_EXPECT_EQ(test, 0,
 			prp_register_frame_out(&data->port, &data->frame));
-	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
-			data->node.seq_out[HSR_PT_MASTER]);
 	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 
 	data->frame.sequence_nr = 10;
 	KUNIT_EXPECT_EQ(test, 0,
 			prp_register_frame_out(&data->port, &data->frame));
-	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
-			data->node.seq_out[HSR_PT_MASTER]);
 	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 
 	data->frame.sequence_nr = 9;
-- 
2.52.0


