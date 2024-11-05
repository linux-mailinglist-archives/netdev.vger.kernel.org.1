Return-Path: <netdev+bounces-141847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044F29BC82E
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889C81F241D6
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 08:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6A81D26E1;
	Tue,  5 Nov 2024 08:38:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0081D1753
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795917; cv=none; b=avCTGnSlFVPJZhDvtAgBCFCZOVfP5KQCZYIm+RmTMrcuDuw1IJCcn0S8ubXoERVlhqWbjOWgGo8/kebbCd8ZnD1tDVtcZyUc7NB7NYlLlWMCp18VA7Oq9LKaZxoHdnUVg853du5JX0K7LfvmWLPNa4PxHvwaLfQ6Rw8Y39p/+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795917; c=relaxed/simple;
	bh=N3MyIfyTOjtKiyFwIhrpaUHZ/eTiSdtkK1lGIazxmRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIE6UAirys+3ETcNx7fZL5lo1eoLus0CiHVjCUB4OIx1rr8xepOwnjkxkenG3Fuv19ZGhULwqIKHs3W95oh4IhIpbCgoMU6GIa4Ym4kjyrVTPG3A6iJDBHbPzYWdGFUAUYtzu5a3ZCD9u+7iKU6pEPO2j0qcA/ktM5Du6XImV40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id C7BED7D11A;
	Tue,  5 Nov 2024 08:38:34 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Antony Antony <antony@phenome.org>,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v13 14/15] xfrm: iptfs: handle reordering of received packets
Date: Tue,  5 Nov 2024 03:37:58 -0500
Message-ID: <20241105083759.2172771-15-chopps@chopps.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105083759.2172771-1-chopps@chopps.org>
References: <20241105083759.2172771-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Handle the receipt of the outer tunnel packets out-of-order. Pointers to
the out-of-order packets are saved in a window (array) awaiting needed
prior packets. When the required prior packets are received the now
in-order packets are then passed on to the regular packet receive code.
A timer is used to consider missing earlier packet as lost so the
algorithm will advance.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 net/xfrm/xfrm_iptfs.c | 497 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 484 insertions(+), 13 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 1258158e57ba..3ca7d2a04ea6 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -39,6 +39,17 @@
  */
 #define IPTFS_DEFAULT_DROP_TIME_USECS 1000000
 
+/**
+ * define IPTFS_DEFAULT_REORDER_WINDOW - default reorder window size
+ *
+ * The default IPTFS reorder window size. The reorder window size dictates the
+ * maximum number of IPTFS tunnel packets in a sequence that may arrive out of
+ * order.
+ *
+ * Default 3. (tcp folks suggested)
+ */
+#define IPTFS_DEFAULT_REORDER_WINDOW 3
+
 /* ------------------------------------------------ */
 /* IPTFS default SA values (tunnel ingress/dir-out) */
 /* ------------------------------------------------ */
@@ -95,14 +106,22 @@
  * @max_queue_size: The maximum number of octets allowed to be queued to be sent
  *	over the IPTFS SA. The queue size is measured as the size of all the
  *	packets enqueued.
+ * @reorder_win_size: the number slots in the reorder window, thus the number of
+ *	packets that may arrive out of order.
  * @dont_frag: true to inhibit fragmenting across IPTFS outer packets.
  */
 struct xfrm_iptfs_config {
 	u32 pkt_size;	    /* outer_packet_size or 0 */
 	u32 max_queue_size; /* octets */
+	u16 reorder_win_size;
 	u8 dont_frag : 1;
 };
 
+struct skb_wseq {
+	struct sk_buff *skb;
+	u64 drop_time;
+};
+
 /**
  * struct xfrm_iptfs_data - mode specific xfrm state.
  * @cfg: IPTFS tunnel config.
@@ -113,6 +132,10 @@ struct xfrm_iptfs_config {
  * @init_delay_ns: nanoseconds to wait to send initial IPTFS packet.
  * @iptfs_timer: output timer.
  * @payload_mtu: max payload size.
+ * @w_seq_set: true after first seq received.
+ * @w_wantseq: waiting for this seq number as next to process (in order).
+ * @w_saved: the saved buf array (reorder window).
+ * @w_savedlen: the saved len (not size).
  * @drop_lock: lock to protect reorder queue.
  * @drop_timer: timer for considering next packet lost.
  * @drop_time_ns: timer intervan in nanoseconds.
@@ -134,12 +157,16 @@ struct xfrm_iptfs_data {
 	struct hrtimer iptfs_timer; /* output timer */
 	u32 payload_mtu;	    /* max payload size */
 
-	/* Tunnel egress */
+	/* Tunnel input reordering */
+	bool w_seq_set;		  /* true after first seq received */
+	u64 w_wantseq;		  /* expected next sequence */
+	struct skb_wseq *w_saved; /* the saved buf array */
+	u32 w_savedlen;		  /* the saved len (not size) */
 	spinlock_t drop_lock;
 	struct hrtimer drop_timer;
 	u64 drop_time_ns;
 
-	/* Tunnel egress reassembly */
+	/* Tunnel input reassembly */
 	struct sk_buff *ra_newskb; /* new pkt being reassembled */
 	u64 ra_wantseq;		   /* expected next sequence */
 	u8 ra_runt[6];		   /* last pkt bytes from last skb */
@@ -1123,15 +1150,13 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 }
 
 /**
- * iptfs_input() - handle receipt of iptfs payload
+ * iptfs_input_ordered() - handle next in order IPTFS payload.
  * @x: xfrm state
- * @skb: the packet
+ * @skb: current packet
  *
  * Process the IPTFS payload in `skb` and consume it afterwards.
- *
- * Returns 0.
  */
-static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
+static void iptfs_input_ordered(struct xfrm_state *x, struct sk_buff *skb)
 {
 	struct ip_iptfs_cc_hdr iptcch;
 	struct skb_seq_state skbseq;
@@ -1206,12 +1231,355 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 		skb_abort_seq_read(&skbseq);
 		kfree_skb(skb);
 	}
+}
 
-	/* We always have dealt with the input SKB, either we are re-using it,
-	 * or we have freed it. Return EINPROGRESS so that xfrm_input stops
-	 * processing it.
+/* ------------------------------- */
+/* Input (Egress) Re-ordering Code */
+/* ------------------------------- */
+
+static void __vec_shift(struct xfrm_iptfs_data *xtfs, u32 shift)
+{
+	u32 savedlen = xtfs->w_savedlen;
+
+	if (shift > savedlen)
+		shift = savedlen;
+	if (shift != savedlen)
+		memcpy(xtfs->w_saved, xtfs->w_saved + shift,
+		       (savedlen - shift) * sizeof(*xtfs->w_saved));
+	memset(xtfs->w_saved + savedlen - shift, 0,
+	       shift * sizeof(*xtfs->w_saved));
+	xtfs->w_savedlen -= shift;
+}
+
+static void __reorder_past(struct xfrm_iptfs_data *xtfs, struct sk_buff *inskb,
+			   struct list_head *freelist)
+{
+	list_add_tail(&inskb->list, freelist);
+}
+
+static u32 __reorder_drop(struct xfrm_iptfs_data *xtfs, struct list_head *list)
+
+{
+	struct skb_wseq *s, *se;
+	const u32 savedlen = xtfs->w_savedlen;
+	time64_t now = ktime_get_raw_fast_ns();
+	u32 count = 0;
+	u32 scount = 0;
+
+	if (xtfs->w_saved[0].drop_time > now)
+		goto set_timer;
+
+	++xtfs->w_wantseq;
+
+	/* Keep flushing packets until we reach a drop time greater than now. */
+	s = xtfs->w_saved;
+	se = s + savedlen;
+	do {
+		/* Walking past empty slots until we reach a packet */
+		for (; s < se && !s->skb; s++) {
+			if (s->drop_time > now)
+				goto outerdone;
+		}
+		/* Sending packets until we hit another empty slot. */
+		for (; s < se && s->skb; scount++, s++)
+			list_add_tail(&s->skb->list, list);
+	} while (s < se);
+outerdone:
+
+	count = s - xtfs->w_saved;
+	if (count) {
+		xtfs->w_wantseq += count;
+
+		/* Shift handled slots plus final empty slot into slot 0. */
+		__vec_shift(xtfs, count);
+	}
+
+	if (xtfs->w_savedlen) {
+set_timer:
+		/* Drifting is OK */
+		hrtimer_start(&xtfs->drop_timer,
+			      xtfs->w_saved[0].drop_time - now,
+			      IPTFS_HRTIMER_MODE);
+	}
+	return scount;
+}
+
+static void __reorder_this(struct xfrm_iptfs_data *xtfs, struct sk_buff *inskb,
+			   struct list_head *list)
+{
+	struct skb_wseq *s, *se;
+	const u32 savedlen = xtfs->w_savedlen;
+	u32 count = 0;
+
+	/* Got what we wanted. */
+	list_add_tail(&inskb->list, list);
+	++xtfs->w_wantseq;
+	if (!savedlen)
+		return;
+
+	/* Flush remaining consecutive packets. */
+
+	/* Keep sending until we hit another missed pkt. */
+	for (s = xtfs->w_saved, se = s + savedlen; s < se && s->skb; s++)
+		list_add_tail(&s->skb->list, list);
+	count = s - xtfs->w_saved;
+	if (count)
+		xtfs->w_wantseq += count;
+
+	/* Shift handled slots plus final empty slot into slot 0. */
+	__vec_shift(xtfs, count + 1);
+}
+
+/* Set the slot's drop time and all the empty slots below it until reaching a
+ * filled slot which will already be set.
+ */
+static void iptfs_set_window_drop_times(struct xfrm_iptfs_data *xtfs, int index)
+{
+	const u32 savedlen = xtfs->w_savedlen;
+	struct skb_wseq *s = xtfs->w_saved;
+	time64_t drop_time;
+
+	assert_spin_locked(&xtfs->drop_lock);
+
+	if (savedlen > index + 1) {
+		/* we are below another, our drop time and the timer are already set */
+		return;
+	}
+	/* we are the most future so get a new drop time. */
+	drop_time = ktime_get_raw_fast_ns();
+	drop_time += xtfs->drop_time_ns;
+
+	/* Walk back through the array setting drop times as we go */
+	s[index].drop_time = drop_time;
+	while (index-- > 0 && !s[index].skb)
+		s[index].drop_time = drop_time;
+
+	/* If we walked all the way back, schedule the drop timer if needed */
+	if (index == -1 && !hrtimer_is_queued(&xtfs->drop_timer))
+		hrtimer_start(&xtfs->drop_timer, xtfs->drop_time_ns,
+			      IPTFS_HRTIMER_MODE);
+}
+
+static void __reorder_future_fits(struct xfrm_iptfs_data *xtfs,
+				  struct sk_buff *inskb,
+				  struct list_head *freelist)
+{
+	const u64 inseq = __esp_seq(inskb);
+	const u64 wantseq = xtfs->w_wantseq;
+	const u64 distance = inseq - wantseq;
+	const u32 savedlen = xtfs->w_savedlen;
+	const u32 index = distance - 1;
+
+	/* Handle future sequence number received which fits in the window.
+	 *
+	 * We know we don't have the seq we want so we won't be able to flush
+	 * anything.
 	 */
-	return -EINPROGRESS;
+
+	/* slot count is 4, saved size is 3 savedlen is 2
+	 *
+	 * "window boundary" is based on the fixed window size
+	 * distance is also slot number
+	 * index is an array index (i.e., - 1 of slot)
+	 * : : - implicit NULL after array len
+	 *
+	 *          +--------- used length (savedlen == 2)
+	 *          |   +----- array size (nslots - 1 == 3)
+	 *          |   |   + window boundary (nslots == 4)
+	 *          V   V | V
+	 *                |
+	 *  0   1   2   3 |   slot number
+	 * ---  0   1   2 |   array index
+	 *     [-] [b] : :|   array
+	 *
+	 * "2" "3" "4" *5*|   seq numbers
+	 *
+	 * We receive seq number 5
+	 * distance == 3 [inseq(5) - w_wantseq(2)]
+	 * index == 2 [distance(6) - 1]
+	 */
+
+	if (xtfs->w_saved[index].skb) {
+		/* a dup of a future */
+		list_add_tail(&inskb->list, freelist);
+		return;
+	}
+
+	xtfs->w_saved[index].skb = inskb;
+	xtfs->w_savedlen = max(savedlen, index + 1);
+	iptfs_set_window_drop_times(xtfs, index);
+}
+
+static void __reorder_future_shifts(struct xfrm_iptfs_data *xtfs,
+				    struct sk_buff *inskb,
+				    struct list_head *list)
+{
+	const u32 nslots = xtfs->cfg.reorder_win_size + 1;
+	const u64 inseq = __esp_seq(inskb);
+	u32 savedlen = xtfs->w_savedlen;
+	u64 wantseq = xtfs->w_wantseq;
+	struct skb_wseq *wnext;
+	struct sk_buff *slot0;
+	u32 beyond, shifting, slot;
+	u64 distance;
+
+	/* Handle future sequence number received.
+	 *
+	 * IMPORTANT: we are at least advancing w_wantseq (i.e., wantseq) by 1
+	 * b/c we are beyond the window boundary.
+	 *
+	 * We know we don't have the wantseq so that counts as a drop.
+	 */
+
+	/* example: slot count is 4, array size is 3 savedlen is 2, slot 0 is
+	 * the missing sequence number.
+	 *
+	 * the final slot at savedlen (index savedlen - 1) is always occupied.
+	 *
+	 * beyond is "beyond array size" not savedlen.
+	 *
+	 *          +--------- array length (savedlen == 2)
+	 *          |   +----- array size (nslots - 1 == 3)
+	 *          |   | +- window boundary (nslots == 4)
+	 *          V   V |
+	 *                |
+	 *  0   1   2   3 |   slot number
+	 * ---  0   1   2 |   array index
+	 *     [b] [c] : :|   array
+	 *                |
+	 * "2" "3" "4" "5"|*6*  seq numbers
+	 *
+	 * We receive seq number 6
+	 * distance == 4 [inseq(6) - w_wantseq(2)]
+	 * newslot == distance
+	 * index == 3 [distance(4) - 1]
+	 * beyond == 1 [newslot(4) - lastslot((nslots(4) - 1))]
+	 * shifting == 1 [min(savedlen(2), beyond(1)]
+	 * slot0_skb == [b], and should match w_wantseq
+	 *
+	 *                +--- window boundary (nslots == 4)
+	 *  0   1   2   3 | 4   slot number
+	 * ---  0   1   2 | 3   array index
+	 *     [b] : : : :|     array
+	 * "2" "3" "4" "5" *6*  seq numbers
+	 *
+	 * We receive seq number 6
+	 * distance == 4 [inseq(6) - w_wantseq(2)]
+	 * newslot == distance
+	 * index == 3 [distance(4) - 1]
+	 * beyond == 1 [newslot(4) - lastslot((nslots(4) - 1))]
+	 * shifting == 1 [min(savedlen(1), beyond(1)]
+	 * slot0_skb == [b] and should match w_wantseq
+	 *
+	 *                +-- window boundary (nslots == 4)
+	 *  0   1   2   3 | 4   5   6   slot number
+	 * ---  0   1   2 | 3   4   5   array index
+	 *     [-] [c] : :|             array
+	 * "2" "3" "4" "5" "6" "7" *8*  seq numbers
+	 *
+	 * savedlen = 2, beyond = 3
+	 * iter 1: slot0 == NULL, missed++, lastdrop = 2 (2+1-1), slot0 = [-]
+	 * iter 2: slot0 == NULL, missed++, lastdrop = 3 (2+2-1), slot0 = [c]
+	 * 2 < 3, extra = 1 (3-2), missed += extra, lastdrop = 4 (2+2+1-1)
+	 *
+	 * We receive seq number 8
+	 * distance == 6 [inseq(8) - w_wantseq(2)]
+	 * newslot == distance
+	 * index == 5 [distance(6) - 1]
+	 * beyond == 3 [newslot(6) - lastslot((nslots(4) - 1))]
+	 * shifting == 2 [min(savedlen(2), beyond(3)]
+	 *
+	 * slot0_skb == NULL changed from [b] when "savedlen < beyond" is true.
+	 */
+
+	/* Now send any packets that are being shifted out of saved, and account
+	 * for missing packets that are exiting the window as we shift it.
+	 */
+
+	distance = inseq - wantseq;
+	beyond = distance - (nslots - 1);
+
+	/* If savedlen > beyond we are shifting some, else all. */
+	shifting = min(savedlen, beyond);
+
+	/* slot0 is the buf that just shifted out and into slot0 */
+	slot0 = NULL;
+	wnext = xtfs->w_saved;
+	for (slot = 1; slot <= shifting; slot++, wnext++) {
+		/* handle what was in slot0 before we occupy it */
+		if (slot0)
+			list_add_tail(&slot0->list, list);
+		slot0 = wnext->skb;
+		wnext->skb = NULL;
+	}
+
+	/* slot0 is now either NULL (in which case it's what we now are waiting
+	 * for, or a buf in which case we need to handle it like we received it;
+	 * however, we may be advancing past that buffer as well..
+	 */
+
+	/* Handle case where we need to shift more than we had saved, slot0 will
+	 * be NULL iff savedlen is 0, otherwise slot0 will always be
+	 * non-NULL b/c we shifted the final element, which is always set if
+	 * there is any saved, into slot0.
+	 */
+	if (savedlen < beyond) {
+		if (savedlen != 0)
+			list_add_tail(&slot0->list, list);
+		slot0 = NULL;
+		/* slot0 has had an empty slot pushed into it */
+	}
+
+	/* Remove the entries */
+	__vec_shift(xtfs, beyond);
+
+	/* Advance want seq */
+	xtfs->w_wantseq += beyond;
+
+	/* Process drops here when implementing congestion control */
+
+	/* We've shifted. plug the packet in at the end. */
+	xtfs->w_savedlen = nslots - 1;
+	xtfs->w_saved[xtfs->w_savedlen - 1].skb = inskb;
+	iptfs_set_window_drop_times(xtfs, xtfs->w_savedlen - 1);
+
+	/* if we don't have a slot0 then we must wait for it */
+	if (!slot0)
+		return;
+
+	/* If slot0, seq must match new want seq */
+
+	/* slot0 is valid, treat like we received expected. */
+	__reorder_this(xtfs, slot0, list);
+}
+
+/* Receive a new packet into the reorder window. Return a list of ordered
+ * packets from the window.
+ */
+static void iptfs_input_reorder(struct xfrm_iptfs_data *xtfs,
+				struct sk_buff *inskb, struct list_head *list,
+				struct list_head *freelist)
+{
+	const u32 nslots = xtfs->cfg.reorder_win_size + 1;
+	u64 inseq = __esp_seq(inskb);
+	u64 wantseq;
+
+	assert_spin_locked(&xtfs->drop_lock);
+
+	if (unlikely(!xtfs->w_seq_set)) {
+		xtfs->w_seq_set = true;
+		xtfs->w_wantseq = inseq;
+	}
+	wantseq = xtfs->w_wantseq;
+
+	if (likely(inseq == wantseq))
+		__reorder_this(xtfs, inskb, list);
+	else if (inseq < wantseq)
+		__reorder_past(xtfs, inskb, freelist);
+	else if ((inseq - wantseq) < nslots)
+		__reorder_future_fits(xtfs, inskb, freelist);
+	else
+		__reorder_future_shifts(xtfs, inskb, list);
 }
 
 /**
@@ -1238,23 +1606,92 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
  */
 static enum hrtimer_restart iptfs_drop_timer(struct hrtimer *me)
 {
+	struct sk_buff *skb, *next;
+	struct list_head list;
 	struct xfrm_iptfs_data *xtfs;
-	struct sk_buff *skb;
+	struct xfrm_state *x;
+	u32 count;
 
 	xtfs = container_of(me, typeof(*xtfs), drop_timer);
+	x = xtfs->x;
+
+	INIT_LIST_HEAD(&list);
 
-	/* Drop any in progress packet */
 	spin_lock(&xtfs->drop_lock);
+
+	/* Drop any in progress packet */
 	skb = xtfs->ra_newskb;
 	xtfs->ra_newskb = NULL;
+
+	/* Now drop as many packets as we should from the reordering window
+	 * saved array
+	 */
+	count = xtfs->w_savedlen ? __reorder_drop(xtfs, &list) : 0;
+
 	spin_unlock(&xtfs->drop_lock);
 
 	if (skb)
 		kfree_skb_reason(skb, SKB_DROP_REASON_FRAG_REASM_TIMEOUT);
 
+	if (count) {
+		list_for_each_entry_safe(skb, next, &list, list) {
+			skb_list_del_init(skb);
+			iptfs_input_ordered(x, skb);
+		}
+	}
+
 	return HRTIMER_NORESTART;
 }
 
+/**
+ * iptfs_input() - handle receipt of iptfs payload
+ * @x: xfrm state
+ * @skb: the packet
+ *
+ * We have an IPTFS payload order it if needed, then process newly in order
+ * packets.
+ *
+ * Return: -EINPROGRESS to inform xfrm_input to stop processing the skb.
+ */
+static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
+{
+	struct list_head freelist, list;
+	struct xfrm_iptfs_data *xtfs = x->mode_data;
+	struct sk_buff *next;
+
+	/* Fast path for no reorder window. */
+	if (xtfs->cfg.reorder_win_size == 0) {
+		iptfs_input_ordered(x, skb);
+		goto done;
+	}
+
+	/* Fetch list of in-order packets from the reordering window as well as
+	 * a list of buffers we need to now free.
+	 */
+	INIT_LIST_HEAD(&list);
+	INIT_LIST_HEAD(&freelist);
+
+	spin_lock(&xtfs->drop_lock);
+	iptfs_input_reorder(xtfs, skb, &list, &freelist);
+	spin_unlock(&xtfs->drop_lock);
+
+	list_for_each_entry_safe(skb, next, &list, list) {
+		skb_list_del_init(skb);
+		iptfs_input_ordered(x, skb);
+	}
+
+	list_for_each_entry_safe(skb, next, &freelist, list) {
+		skb_list_del_init(skb);
+		kfree_skb(skb);
+	}
+done:
+	/* We always have dealt with the input SKB, either we are re-using it,
+	 * or we have freed it. Return EINPROGRESS so that xfrm_input stops
+	 * processing it.
+	 */
+	return -EINPROGRESS;
+}
+
 /* ================================= */
 /* IPTFS Sending (ingress) Functions */
 /* ================================= */
@@ -2009,11 +2446,24 @@ static int iptfs_user_init(struct net *net, struct xfrm_state *x,
 
 	xc = &xtfs->cfg;
 	xc->max_queue_size = IPTFS_DEFAULT_MAX_QUEUE_SIZE;
+	xc->reorder_win_size = IPTFS_DEFAULT_REORDER_WINDOW;
 	xtfs->drop_time_ns = IPTFS_DEFAULT_DROP_TIME_USECS * NSECS_IN_USEC;
 	xtfs->init_delay_ns = IPTFS_DEFAULT_INIT_DELAY_USECS * NSECS_IN_USEC;
 
 	if (attrs[XFRMA_IPTFS_DONT_FRAG])
 		xc->dont_frag = true;
+	if (attrs[XFRMA_IPTFS_REORDER_WINDOW])
+		xc->reorder_win_size =
+			nla_get_u16(attrs[XFRMA_IPTFS_REORDER_WINDOW]);
+	/* saved array is for saving 1..N seq nums from wantseq */
+	if (xc->reorder_win_size) {
+		xtfs->w_saved = kcalloc(xc->reorder_win_size,
+					sizeof(*xtfs->w_saved), GFP_KERNEL);
+		if (!xtfs->w_saved) {
+			NL_SET_ERR_MSG(extack, "Cannot alloc reorder window");
+			return -ENOMEM;
+		}
+	}
 	if (attrs[XFRMA_IPTFS_PKT_SIZE]) {
 		xc->pkt_size = nla_get_u32(attrs[XFRMA_IPTFS_PKT_SIZE]);
 		if (!xc->pkt_size) {
@@ -2051,6 +2501,7 @@ static unsigned int iptfs_sa_len(const struct xfrm_state *x)
 
 	if (x->dir == XFRM_SA_DIR_IN) {
 		l += nla_total_size(sizeof(u32)); /* drop time usec */
+		l += nla_total_size(sizeof(xc->reorder_win_size));
 	} else {
 		if (xc->dont_frag)
 			l += nla_total_size(0);	  /* dont-frag flag */
@@ -2073,6 +2524,11 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
 		q = xtfs->drop_time_ns;
 		do_div(q, NSECS_IN_USEC);
 		ret = nla_put_u32(skb, XFRMA_IPTFS_DROP_TIME, q);
+		if (ret)
+			return ret;
+
+		ret = nla_put_u16(skb, XFRMA_IPTFS_REORDER_WINDOW,
+				  xc->reorder_win_size);
 	} else {
 		if (xc->dont_frag) {
 			ret = nla_put_flag(skb, XFRMA_IPTFS_DONT_FRAG);
@@ -2134,6 +2590,14 @@ static int iptfs_clone_state(struct xfrm_state *x, struct xfrm_state *orig)
 	xtfs->x = x;
 
 	xtfs->ra_newskb = NULL;
+	if (xtfs->cfg.reorder_win_size) {
+		xtfs->w_saved = kcalloc(xtfs->cfg.reorder_win_size,
+					sizeof(*xtfs->w_saved), GFP_KERNEL);
+		if (!xtfs->w_saved) {
+			kfree_sensitive(xtfs);
+			return -ENOMEM;
+		}
+	}
 
 	return 0;
 }
@@ -2160,6 +2624,7 @@ static void iptfs_destroy_state(struct xfrm_state *x)
 {
 	struct xfrm_iptfs_data *xtfs = x->mode_data;
 	struct sk_buff_head list;
+	struct skb_wseq *s, *se;
 	struct sk_buff *skb;
 
 	if (!xtfs)
@@ -2181,6 +2646,12 @@ static void iptfs_destroy_state(struct xfrm_state *x)
 	if (xtfs->ra_newskb)
 		kfree_skb(xtfs->ra_newskb);
 
+	for (s = xtfs->w_saved, se = s + xtfs->w_savedlen; s < se; s++) {
+		if (s->skb)
+			kfree_skb(s->skb);
+	}
+
+	kfree_sensitive(xtfs->w_saved);
 	kfree_sensitive(xtfs);
 
 	module_put(x->mode_cbs->owner);
-- 
2.47.0


