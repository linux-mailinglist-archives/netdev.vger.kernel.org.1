Return-Path: <netdev+bounces-252392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Mg7FzJBcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:24:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A81A768B17
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1074D96670C
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FEF354AD6;
	Thu, 22 Jan 2026 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRxgWAqH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC0B34DB6F
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093867; cv=none; b=cHS0MbgQY3DEAdl1dC0cReNKpoEz6KU1baTQ5h1R+0ZuWTXLw3T+Jx0j9mqSLNN5teVguoH7bXYTHTpL3ek1CGC26/rPzfg1PizZM+fYi64EGLRhAQfxjagq9BlxtYi9q40zgKLMOrpp3SV4GHiubGFrDZ5GI52X3Dg9CCtmPOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093867; c=relaxed/simple;
	bh=fE6O5RMeBnWi1be54x0xz3Zb02FNuoj/RvPBR0ueNf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6qQjItjSB9pZXA0pB4+xmx/KQqy++UIPUmq+FvIQAmJaNmPczvvX1wB/p/53gOuuAXoIA0JyZ+OebBnyJ9xtJwrMNHU3kF5TXtWHTf1WjOsq6nef230luLyJs9B8a/UmbF+2nZZ72e+WXxTcnYcgMX8a2bqaodJMaZ1fFNz83E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRxgWAqH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769093864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tEW17Asr/0AKEBm5kahyP+xPXl2xeaPZpYgKkzisXLM=;
	b=NRxgWAqHemcqYd/w6bETsLTuSDMQvGxVW65stlwuObIPohvkt2URqdR+oH+TlRJHGELZEv
	5p30zAvu/h8LCs/xSxisojC/ROkmiGo0yE+WQmLaL6U5ykVuDFizU9OdakQBXr2FvQt/Mu
	/TZesqcEKBZvVyziOL4y4GYYBEzjm8E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-8BiS8GhfPSCwuOCpGMUd0w-1; Thu,
 22 Jan 2026 09:57:40 -0500
X-MC-Unique: 8BiS8GhfPSCwuOCpGMUd0w-1
X-Mimecast-MFC-AGG-ID: 8BiS8GhfPSCwuOCpGMUd0w_1769093859
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE93718005AF;
	Thu, 22 Jan 2026 14:57:38 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.45.225.113])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0487E1800665;
	Thu, 22 Jan 2026 14:57:33 +0000 (UTC)
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
	petrm@nvidia.com,
	antonio@openvpn.net,
	bigeasy@linutronix.de,
	Steffen Lindner <steffen.lindner@de.abb.com>
Subject: [PATCH net-next v2 4/9] hsr: Implement more robust duplicate discard for PRP
Date: Thu, 22 Jan 2026 15:56:59 +0100
Message-ID: <fe1dbc483482e98fbc286290a2a3e88f555894d4.1769093335.git.fmaurer@redhat.com>
In-Reply-To: <cover.1769093335.git.fmaurer@redhat.com>
References: <cover.1769093335.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252392-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net,de.abb.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[abb.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: A81A768B17
X-Rspamd-Action: no action

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
   added more than the entry forget time ago. In this case, the block is
   removed from the xarray and marked as forgotten (by setting its
   timestamp to 0).
2. Space is needed in the ring buffer for a new block. In this case, the
   block is removed from the xarray, if it hasn't already been forgotten
   (by 1.). Afterwards, the new block is initialized in its place.

This has the nice property that we can reliably track sequence numbers on
low traffic situations (where they expire based on their timestamp) and
more quickly forget sequence numbers in high traffic situations before they
potentially wrap over and repeat before they are expired.

When nodes are merged, the blocks are merged as well. The timestamp of a
merged block is set to the minimum of the two timestamps to never keep
around a seen sequence number for too long. The bitmaps are or'd to mark
all seen sequence numbers as seen.

All of this still happens under seq_out_lock, to prevent concurrent
access to the blocks.

Reported-by: Steffen Lindner <steffen.lindner@de.abb.com>
Fixes: 05fd00e5e7b1 ("net: hsr: Fix PRP duplicate detection")
Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---

Notes:
    The bug was reported by Steffen directly to us, I asked for permission
    to add his Reported-by tag.

 net/hsr/hsr_framereg.c | 203 +++++++++++++++++++++++++++--------------
 net/hsr/hsr_framereg.h |  21 ++++-
 2 files changed, 152 insertions(+), 72 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 3a2a2fa7a0a3..70b3819e9298 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -35,7 +35,6 @@ static bool seq_nr_after(u16 a, u16 b)
 
 #define seq_nr_before(a, b)		seq_nr_after((b), (a))
 #define seq_nr_before_or_eq(a, b)	(!seq_nr_after((a), (b)))
-#define PRP_DROP_WINDOW_LEN 32768
 
 bool hsr_addr_is_redbox(struct hsr_priv *hsr, unsigned char *addr)
 {
@@ -126,13 +125,29 @@ void hsr_del_self_node(struct hsr_priv *hsr)
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
+
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
@@ -158,7 +173,7 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 				     u16 seq_out, bool san,
 				     enum hsr_port_type rx_port)
 {
-	struct hsr_node *new_node, *node;
+	struct hsr_node *new_node, *node = NULL;
 	unsigned long now;
 	int i;
 
@@ -169,6 +184,14 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 	ether_addr_copy(new_node->macaddress_A, addr);
 	spin_lock_init(&new_node->seq_out_lock);
 
+	new_node->block_buf = kcalloc(HSR_MAX_SEQ_BLOCKS,
+				      sizeof(struct hsr_seq_block),
+				      GFP_ATOMIC);
+	if (!new_node->block_buf)
+		goto free;
+
+	xa_init(&new_node->seq_blocks);
+
 	/* We are only interested in time diffs here, so use current jiffies
 	 * as initialization. (0 could trigger an spurious ring error warning).
 	 */
@@ -176,11 +199,7 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
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
@@ -199,6 +218,8 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 	return new_node;
 out:
 	spin_unlock_bh(&hsr->list_lock);
+	kfree(new_node->block_buf);
+free:
 	kfree(new_node);
 	return node;
 }
@@ -280,6 +301,59 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 			    san, rx_port);
 }
 
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
+static struct hsr_seq_block *hsr_get_seq_block(struct hsr_node *node,
+					       u16 block_idx)
+{
+	struct hsr_seq_block *block, *res;
+
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
+		node->next_block =
+			(node->next_block + 1) & (HSR_MAX_SEQ_BLOCKS - 1);
+	}
+
+	return block;
+}
+
 /* Use the Supervision frame's info about an eventual macaddress_B for merging
  * nodes that has previously had their macaddress_B registered as a separate
  * node.
@@ -288,16 +362,18 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 {
 	struct hsr_node *node_curr = frame->node_src;
 	struct hsr_port *port_rcv = frame->port_rcv;
+	struct hsr_seq_block *src_blk, *merge_blk;
 	struct hsr_priv *hsr = port_rcv->hsr;
-	struct hsr_sup_payload *hsr_sp;
 	struct hsr_sup_tlv *hsr_sup_tlv;
+	struct hsr_sup_payload *hsr_sp;
 	struct hsr_node *node_real;
 	struct sk_buff *skb = NULL;
 	struct list_head *node_db;
 	struct ethhdr *ethhdr;
-	int i;
-	unsigned int pull_size = 0;
 	unsigned int total_pull_size = 0;
+	unsigned int pull_size = 0;
+	unsigned long idx;
+	int i;
 
 	/* Here either frame->skb_hsr or frame->skb_prp should be
 	 * valid as supervision frame always will have protocol
@@ -391,6 +467,18 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 		if (seq_nr_after(node_curr->seq_out[i], node_real->seq_out[i]))
 			node_real->seq_out[i] = node_curr->seq_out[i];
 	}
+
+	xa_for_each(&node_curr->seq_blocks, idx, src_blk) {
+		if (hsr_seq_block_is_old(src_blk))
+			continue;
+
+		merge_blk = hsr_get_seq_block(node_real, src_blk->block_idx);
+		if (!merge_blk)
+			continue;
+		merge_blk->time = min(merge_blk->time, src_blk->time);
+		bitmap_or(merge_blk->seq_nrs, merge_blk->seq_nrs,
+			  src_blk->seq_nrs, HSR_SEQ_BLOCK_SIZE);
+	}
 	spin_unlock_bh(&node_real->seq_out_lock);
 	node_real->addr_B_port = port_rcv->type;
 
@@ -398,7 +486,7 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 	if (!node_curr->removed) {
 		list_del_rcu(&node_curr->mac_list);
 		node_curr->removed = true;
-		kfree_rcu(node_curr, rcu_head);
+		call_rcu(&node_curr->rcu_head, hsr_free_node_rcu);
 	}
 	spin_unlock_bh(&hsr->list_lock);
 
@@ -505,17 +593,12 @@ int hsr_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
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
+/* PRP duplicate discard algorithm: we maintain a bitmap where we set a bit for
+ * every seen sequence number. The bitmap is split into blocks and the block
+ * management is detailed in hsr_get_seq_block(). In any case, we err on the
+ * side of accepting a packet, as the specification requires the algorithm to
+ * be "designed such that it never rejects a legitimate frame, while occasional
+ * acceptance of a duplicate can be tolerated." (IEC 62439-3:2021, 4.1.10.3).
  *
  * 'port' is the outgoing interface
  * 'frame' is the frame to be sent
@@ -526,18 +609,21 @@ int hsr_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
  */
 int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
 {
-	enum hsr_port_type other_port;
-	enum hsr_port_type rcv_port;
+	u16 sequence_nr, seq_bit, block_idx;
+	struct hsr_seq_block *block;
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
@@ -545,47 +631,26 @@ int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
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
+	block_idx = hsr_seq_block_index(sequence_nr);
+	block = hsr_get_seq_block(node, block_idx);
+	if (!block)
+		goto out_new;
+
+	seq_bit = hsr_seq_block_bit(sequence_nr);
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
@@ -672,7 +737,7 @@ void hsr_prune_nodes(struct timer_list *t)
 				list_del_rcu(&node->mac_list);
 				node->removed = true;
 				/* Note that we need to free this entry later: */
-				kfree_rcu(node, rcu_head);
+				call_rcu(&node->rcu_head, hsr_free_node_rcu);
 			}
 		}
 	}
@@ -706,7 +771,7 @@ void hsr_prune_proxy_nodes(struct timer_list *t)
 				list_del_rcu(&node->mac_list);
 				node->removed = true;
 				/* Note that we need to free this entry later: */
-				kfree_rcu(node, rcu_head);
+				call_rcu(&node->rcu_head, hsr_free_node_rcu);
 			}
 		}
 	}
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index b04948659d84..d4d1fa70039f 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -74,9 +74,23 @@ bool hsr_is_node_in_db(struct list_head *node_db,
 
 int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame);
 
+#define HSR_SEQ_BLOCK_SHIFT 7 /* 128 bits */
+#define HSR_SEQ_BLOCK_SIZE (1 << HSR_SEQ_BLOCK_SHIFT)
+#define HSR_SEQ_BLOCK_MASK (HSR_SEQ_BLOCK_SIZE - 1)
+#define HSR_MAX_SEQ_BLOCKS 64
+
+#define hsr_seq_block_index(sequence_nr) ((sequence_nr) >> HSR_SEQ_BLOCK_SHIFT)
+#define hsr_seq_block_bit(sequence_nr) ((sequence_nr) & HSR_SEQ_BLOCK_MASK)
+
+struct hsr_seq_block {
+	unsigned long		time;
+	u16			block_idx;
+	DECLARE_BITMAP(seq_nrs, HSR_SEQ_BLOCK_SIZE);
+};
+
 struct hsr_node {
 	struct list_head	mac_list;
-	/* Protect R/W access to seq_out */
+	/* Protect R/W access to seq_out and seq_blocks */
 	spinlock_t		seq_out_lock;
 	unsigned char		macaddress_A[ETH_ALEN];
 	unsigned char		macaddress_B[ETH_ALEN];
@@ -91,8 +105,9 @@ struct hsr_node {
 	u16			seq_out[HSR_PT_PORTS];
 	bool			removed;
 	/* PRP specific duplicate handling */
-	u16			seq_expected[HSR_PT_PORTS];
-	u16			seq_start[HSR_PT_PORTS];
+	struct xarray		seq_blocks;
+	struct hsr_seq_block	*block_buf;
+	unsigned int		next_block;
 	struct rcu_head		rcu_head;
 };
 
-- 
2.52.0


