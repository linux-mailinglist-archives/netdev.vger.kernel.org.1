Return-Path: <netdev+bounces-245765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A87CD72A6
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 21:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E92D300101A
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 20:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39F2335070;
	Mon, 22 Dec 2025 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clNCuI6p"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905022FFF89
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766437149; cv=none; b=c72DzShhzzc6yw/+MisuLV0/M3YBm7G0a6fwja1Bj2eTiog43Yv1HI/OU0N6rrjbuV9sDdnanSetAN88ahtRCE1K0S2mHlOLnxpboeeiazrDmcBeK0Rudzs3aXgqbLhCVNOyPduyH3A+lKnMrWN2M4Z1PPaKUIyEdsNkoKCwC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766437149; c=relaxed/simple;
	bh=zrH0rCca/GPIQIehK22W2OOmldfIzIvXGKKmPshJhZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usDOysH84tLusRilRPlEaVZD6nrT97ZXS0GvXZgvJGFmZyWz7wb0FVhA6aqDHIFKzC4SGZO/oeTCOdChVyyFSKPTE+MaEkChqJsWk1nu5Rm55C0te8c7bxQf1fHsqrQGlXk03ECs84QzERV5govGlkjr5A4TGqLbYrVsUei292M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=clNCuI6p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766437143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVE3fo5w5v8UeIW6bhL1Xo2/xMYcKkBVCl4O9sCy5C4=;
	b=clNCuI6piMGx9YJ+BdmVbSiWZnx5elIIpNUXoGGSr4oN/KJWb95O97clZgu5lEizXKtp6J
	xRBK1uXTDeLN9lVDo6cIulMCAlFhrflGnLLtR7RpO1GKDjkOSh0/a2iPmGbrjzIbXDOXHH
	xG07U4Phc6jskqybACjWQD/SgEkwCg4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-jta4VtCSNG68wOPKruAtOQ-1; Mon,
 22 Dec 2025 15:58:59 -0500
X-MC-Unique: jta4VtCSNG68wOPKruAtOQ-1
X-Mimecast-MFC-AGG-ID: jta4VtCSNG68wOPKruAtOQ_1766437138
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6F9C19560A5;
	Mon, 22 Dec 2025 20:58:57 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.32.178])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 06238180045B;
	Mon, 22 Dec 2025 20:58:53 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jkarrenpalo@gmail.com,
	tglx@linutronix.de,
	mingo@kernel.org,
	allison.henderson@oracle.com,
	matttbe@kernel.org,
	petrm@nvidia.com,
	bigeasy@linutronix.de
Subject: [RFC net 5/6] hsr: Implement more robust duplicate discard for PRP
Date: Mon, 22 Dec 2025 21:57:35 +0100
Message-ID: <af4bd23b0a4b417b9ce26d77c1d153cfaf78ec64.1766433800.git.fmaurer@redhat.com>
In-Reply-To: <cover.1766433800.git.fmaurer@redhat.com>
References: <cover.1766433800.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The PRP duplicate discard algorithm does not work reliably with certain
link faults. Especially with packet loss on one link, the duplicate discard
algorithm drops valid packets which leads to packet loss on the PRP
interface where the link fault should in theory be perfectly recoverable by
PRP. This happens because the algorithm opens the drop window on the lossy
link, covering received and lost sequence numbers. If the other, non-lossy
link receives the duplicate for a lost frame, it is within the drop window
of the lossy link and therefore dropped.

Since IEC 62439-3:2012, a node has one sequence number counter for frames
it sends, instead of one sequence number counter for each destination.
Therefore, a node can not expect to receive contiguous sequence numbers
from a sender. A missing sequence number can be totally normal (if the
sender intermittently communicates with another node) or mean a frame was
lost.

The algorithm, as previously implemented in commit 05fd00e5e7b1 ("net: hsr:
Fix PRP duplicate detection"), was part of IEC 62439-3:2010 (HSRv0/PRPv0)
but was removed with IEC 62439-3:2012 (HSRv1/PRPv1). Since that, no
algorithm is specified but up to implementers. It should be "designed such
that it never rejects a legitimate frame, while occasional acceptance of a
duplicate can be tolerated" (IEC 62439-3:2021).

For the duplicate discard algorithm, this means that 1) we need to track
the sequence numbers individually to account for non-contiguous sequence
numbers, and 2) we should always err on the side of accepting a duplicate
than dropping a valid frame.

The idea of the new algorithm is to store the seen sequence numbers in a
bitmap. To keep the size of the bitmap in control, we store it as a "sparse
bitmap" where the bitmap is split into blocks and not all blocks exist at
the same time. The sparse bitmap is implemented using an xarray that keeps
the references to the individual blocks and a backing ring buffer that
stores the actual blocks. New blocks are initialized in the buffer and
added to the xarray as needed when new frames arrive. Existing blocks are
removed in two conditions:
1. The block found for an arriving sequence number is old and therefore not
   relevant to the duplicate discard algorithm anymore, i.e., it has been
   added more than than the entry forget time ago. In this case, the block
   is removed from the xarray and marked as forgotten (by setting its
   timestamp to 0).
2. Space is needed in the ring buffer for a new block. In this case, the
   block is removed from the xarray, if it hasn't already been forgotten
   (by 1.). Afterwards, the new block is initialized in its place.

All of this still happens under seq_out_lock, to prevent concurrent
access to the blocks.

Fixes: 05fd00e5e7b1 ("net: hsr: Fix PRP duplicate detection")
Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 net/hsr/hsr_framereg.c | 181 ++++++++++++++++++++++++++---------------
 net/hsr/hsr_framereg.h |  24 +++++-
 2 files changed, 138 insertions(+), 67 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 3a2a2fa7a0a3..c6e9d3a2648a 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -126,13 +126,28 @@ void hsr_del_self_node(struct hsr_priv *hsr)
 		kfree_rcu(old, rcu_head);
 }
 
+static void hsr_free_node(struct hsr_node *node)
+{
+	xa_destroy(&node->seq_blocks);
+	kfree(node->block_buf);
+	kfree(node);
+}
+
+static void hsr_free_node_rcu(struct rcu_head *rn)
+{
+	struct hsr_node *node = container_of(rn, struct hsr_node, rcu_head);
+	hsr_free_node(node);
+}
+
 void hsr_del_nodes(struct list_head *node_db)
 {
 	struct hsr_node *node;
 	struct hsr_node *tmp;
 
-	list_for_each_entry_safe(node, tmp, node_db, mac_list)
-		kfree(node);
+	list_for_each_entry_safe(node, tmp, node_db, mac_list) {
+		list_del(&node->mac_list);
+		hsr_free_node(node);
+	}
 }
 
 void prp_handle_san_frame(bool san, enum hsr_port_type port,
@@ -176,11 +191,7 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 	for (i = 0; i < HSR_PT_PORTS; i++) {
 		new_node->time_in[i] = now;
 		new_node->time_out[i] = now;
-	}
-	for (i = 0; i < HSR_PT_PORTS; i++) {
 		new_node->seq_out[i] = seq_out;
-		new_node->seq_expected[i] = seq_out + 1;
-		new_node->seq_start[i] = seq_out + 1;
 	}
 
 	if (san && hsr->proto_ops->handle_san_frame)
@@ -194,11 +205,20 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 		if (ether_addr_equal(node->macaddress_B, addr))
 			goto out;
 	}
+
+	new_node->block_buf = kcalloc(HSR_MAX_SEQ_BLOCKS,
+				      sizeof(struct hsr_seq_block),
+				      GFP_ATOMIC);
+	if (!new_node->block_buf)
+		goto out;
+
+	xa_init(&new_node->seq_blocks);
 	list_add_tail_rcu(&new_node->mac_list, node_db);
 	spin_unlock_bh(&hsr->list_lock);
 	return new_node;
 out:
 	spin_unlock_bh(&hsr->list_lock);
+	kfree(new_node->block_buf);
 	kfree(new_node);
 	return node;
 }
@@ -283,6 +303,9 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 /* Use the Supervision frame's info about an eventual macaddress_B for merging
  * nodes that has previously had their macaddress_B registered as a separate
  * node.
+ * TODO Merging PRP nodes currently looses the info on received sequence numbers
+ * from one node. This may lead to some duplicates being received but does no
+ * harm otherwise.
  */
 void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 {
@@ -398,7 +421,7 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 	if (!node_curr->removed) {
 		list_del_rcu(&node_curr->mac_list);
 		node_curr->removed = true;
-		kfree_rcu(node_curr, rcu_head);
+		call_rcu(&node_curr->rcu_head, hsr_free_node_rcu);
 	}
 	spin_unlock_bh(&hsr->list_lock);
 
@@ -505,17 +528,66 @@ int hsr_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
 	return 0;
 }
 
-/* Adaptation of the PRP duplicate discard algorithm described in wireshark
- * wiki (https://wiki.wireshark.org/PRP)
- *
- * A drop window is maintained for both LANs with start sequence set to the
- * first sequence accepted on the LAN that has not been seen on the other LAN,
- * and expected sequence set to the latest received sequence number plus one.
- *
- * When a frame is received on either LAN it is compared against the received
- * frames on the other LAN. If it is outside the drop window of the other LAN
- * the frame is accepted and the drop window is updated.
- * The drop window for the other LAN is reset.
+static bool hsr_seq_block_is_old(struct hsr_seq_block *block)
+{
+	unsigned long expiry = msecs_to_jiffies(HSR_ENTRY_FORGET_TIME);
+
+	return time_is_before_jiffies(block->time + expiry);
+}
+
+static void hsr_forget_seq_block(struct hsr_node *node,
+				 struct hsr_seq_block *block)
+{
+	if (block->time)
+		xa_erase(&node->seq_blocks, block->block_idx);
+	block->time = 0;
+}
+
+/* Get the currently active sequence number block. If there is no block yet, or
+ * the existing one is expired, a new block is created. The idea is to maintain
+ * a "sparse bitmap" where a bitmap for the whole sequence number space is
+ * split into blocks and not all blocks exist all the time. The blocks can
+ * expire after time (in low traffic situations) or when they are replaced in
+ * the backing fixed size buffer (in high traffic situations).
+ */
+static struct hsr_seq_block *hsr_get_active_seq_block(struct hsr_node *node, u16 seq_nr)
+{
+	struct hsr_seq_block *block, *res;
+	u16 block_idx;
+
+	block_idx = seq_nr >> HSR_SEQ_BLOCK_SHIFT;
+	block = xa_load(&node->seq_blocks, block_idx);
+
+	if (block && hsr_seq_block_is_old(block)) {
+		hsr_forget_seq_block(node, block);
+		block = NULL;
+	}
+
+	if (!block) {
+		block = &node->block_buf[node->next_block];
+		hsr_forget_seq_block(node, block);
+
+		memset(block, 0, sizeof(*block));
+		block->time = jiffies;
+		block->block_idx = block_idx;
+
+		res = xa_store(&node->seq_blocks, block_idx, block, GFP_ATOMIC);
+		if (xa_is_err(res))
+			return NULL;
+
+		node->next_block = (node->next_block + 1) & (HSR_MAX_SEQ_BLOCKS - 1);
+	}
+
+	return block;
+}
+
+/* PRP duplicate discard algorithm: we maintain a bitmap where we set a bit for
+ * every seen sequence number. The bitmap is split into blocks and the block
+ * management is detailed in hsr_get_active_seq_block(). In any case, we err on
+ * the side of accepting a packet, as the specification requires the algorithm
+ * to be "designed such that it never rejects a legitimate frame, while
+ * occasional acceptance of a duplicate can be tolerated." (IEC 62439-3:2021,
+ * 4.1.10.3).
  *
  * 'port' is the outgoing interface
  * 'frame' is the frame to be sent
@@ -526,18 +598,21 @@ int hsr_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
  */
 int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
 {
-	enum hsr_port_type other_port;
-	enum hsr_port_type rcv_port;
+	struct hsr_seq_block *block;
+	u16 sequence_nr, seq_bit;
 	struct hsr_node *node;
-	u16 sequence_diff;
-	u16 sequence_exp;
-	u16 sequence_nr;
 
-	/* out-going frames are always in order
-	 * and can be checked the same way as for HSR
-	 */
-	if (frame->port_rcv->type == HSR_PT_MASTER)
-		return hsr_register_frame_out(port, frame);
+	node = frame->node_src;
+	sequence_nr = frame->sequence_nr;
+
+	// out-going frames are always in order
+	if (frame->port_rcv->type == HSR_PT_MASTER) {
+		spin_lock_bh(&node->seq_out_lock);
+		node->time_out[port->type] = jiffies;
+		node->seq_out[port->type] = sequence_nr;
+		spin_unlock_bh(&node->seq_out_lock);
+		return 0;
+	}
 
 	/* for PRP we should only forward frames from the slave ports
 	 * to the master port
@@ -545,47 +620,25 @@ int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
 	if (port->type != HSR_PT_MASTER)
 		return 1;
 
-	node = frame->node_src;
-	sequence_nr = frame->sequence_nr;
-	sequence_exp = sequence_nr + 1;
-	rcv_port = frame->port_rcv->type;
-	other_port = rcv_port == HSR_PT_SLAVE_A ? HSR_PT_SLAVE_B :
-				 HSR_PT_SLAVE_A;
-
 	spin_lock_bh(&node->seq_out_lock);
-	if (time_is_before_jiffies(node->time_out[port->type] +
-	    msecs_to_jiffies(HSR_ENTRY_FORGET_TIME)) ||
-	    (node->seq_start[rcv_port] == node->seq_expected[rcv_port] &&
-	     node->seq_start[other_port] == node->seq_expected[other_port])) {
-		/* the node hasn't been sending for a while
-		 * or both drop windows are empty, forward the frame
-		 */
-		node->seq_start[rcv_port] = sequence_nr;
-	} else if (seq_nr_before(sequence_nr, node->seq_expected[other_port]) &&
-		   seq_nr_before_or_eq(node->seq_start[other_port], sequence_nr)) {
-		/* drop the frame, update the drop window for the other port
-		 * and reset our drop window
-		 */
-		node->seq_start[other_port] = sequence_exp;
-		node->seq_expected[rcv_port] = sequence_exp;
-		node->seq_start[rcv_port] = node->seq_expected[rcv_port];
-		spin_unlock_bh(&node->seq_out_lock);
-		return 1;
-	}
 
-	/* update the drop window for the port where this frame was received
-	 * and clear the drop window for the other port
-	 */
-	node->seq_start[other_port] = node->seq_expected[other_port];
-	node->seq_expected[rcv_port] = sequence_exp;
-	sequence_diff = sequence_exp - node->seq_start[rcv_port];
-	if (sequence_diff > PRP_DROP_WINDOW_LEN)
-		node->seq_start[rcv_port] = sequence_exp - PRP_DROP_WINDOW_LEN;
+	block = hsr_get_active_seq_block(node, sequence_nr);
+	if (WARN_ON_ONCE(!block))
+		goto out_new;
+
+	seq_bit = sequence_nr & HSR_SEQ_BLOCK_MASK;
+	if (test_and_set_bit(seq_bit, block->seq_nrs))
+		goto out_seen;
 
 	node->time_out[port->type] = jiffies;
 	node->seq_out[port->type] = sequence_nr;
+out_new:
 	spin_unlock_bh(&node->seq_out_lock);
 	return 0;
+
+out_seen:
+	spin_unlock_bh(&node->seq_out_lock);
+	return 1;
 }
 
 #if IS_MODULE(CONFIG_PRP_DUP_DISCARD_KUNIT_TEST)
@@ -672,7 +725,7 @@ void hsr_prune_nodes(struct timer_list *t)
 				list_del_rcu(&node->mac_list);
 				node->removed = true;
 				/* Note that we need to free this entry later: */
-				kfree_rcu(node, rcu_head);
+				call_rcu(&node->rcu_head, hsr_free_node_rcu);
 			}
 		}
 	}
@@ -706,7 +759,7 @@ void hsr_prune_proxy_nodes(struct timer_list *t)
 				list_del_rcu(&node->mac_list);
 				node->removed = true;
 				/* Note that we need to free this entry later: */
-				kfree_rcu(node, rcu_head);
+				call_rcu(&node->rcu_head, hsr_free_node_rcu);
 			}
 		}
 	}
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index b04948659d84..804543d5191c 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -74,9 +74,26 @@ bool hsr_is_node_in_db(struct list_head *node_db,
 
 int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame);
 
+
+#define HSR_SEQ_BLOCK_SHIFT 7 /* 128 bits */
+#define HSR_SEQ_BLOCK_SIZE (1 << HSR_SEQ_BLOCK_SHIFT)
+#define HSR_SEQ_BLOCK_MASK (HSR_SEQ_BLOCK_SIZE - 1)
+#define HSR_MAX_SEQ_BLOCKS 64
+
+struct hsr_seq_block {
+	unsigned long		time;
+	u16			block_idx;
+	DECLARE_BITMAP(seq_nrs, HSR_SEQ_BLOCK_SIZE);
+};
+
+struct hsr_block_buf {
+	struct hsr_seq_block	*buf;
+	int			next;
+};
+
 struct hsr_node {
 	struct list_head	mac_list;
-	/* Protect R/W access to seq_out */
+	/* Protect R/W access to seq_out and seq_blocks */
 	spinlock_t		seq_out_lock;
 	unsigned char		macaddress_A[ETH_ALEN];
 	unsigned char		macaddress_B[ETH_ALEN];
@@ -91,8 +108,9 @@ struct hsr_node {
 	u16			seq_out[HSR_PT_PORTS];
 	bool			removed;
 	/* PRP specific duplicate handling */
-	u16			seq_expected[HSR_PT_PORTS];
-	u16			seq_start[HSR_PT_PORTS];
+	struct xarray		seq_blocks;
+	struct hsr_seq_block	*block_buf;
+	int			next_block;
 	struct rcu_head		rcu_head;
 };
 
-- 
2.52.0


