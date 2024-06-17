Return-Path: <netdev+bounces-104266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B2890BC75
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 22:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6581D1F23840
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1BB19A295;
	Mon, 17 Jun 2024 20:54:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157811991AD
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 20:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718657666; cv=none; b=sOgcJYTb6pnFBdWahGflE2Xzz+dJfWddHE24gyGJZxxOWT1VUKsEwjrXWU0kTX0STY6jzpr+74AbBvntBYjwb8Ckc/sjETjUZmTMUUoSXJbpjJUB4Ps0INbQe4IDvq4tLCAQM+0yFo0HxRv+AFjNJuHu15UjdBMpBQcMq3fd5cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718657666; c=relaxed/simple;
	bh=cyoaxHOae5oWzIzG181KFEbnqU1lVdObYpWCnijGlTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSsmu7XVAbuG9xIdluisK5GSY4GJPHDLk6HLB78yZilhodLVKgOnhjiIfOBay6h35V/eRe24Hqu1VJexbwu6FV6/UsJSpzxB7r2VBwTtYeF+k6Hj0Rn0GKMAJRljIqYBJIDD/CmVAoAgPDP5gV/Ya66Dld25eQltejojcB6EViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 7FB007D097;
	Mon, 17 Jun 2024 20:54:23 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v4 13/18] xfrm: iptfs: handle received fragmented inner packets
Date: Mon, 17 Jun 2024 16:53:11 -0400
Message-ID: <20240617205316.939774-14-chopps@chopps.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617205316.939774-1-chopps@chopps.org>
References: <20240617205316.939774-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Add support for handling receipt of partial inner packets that have
been fragmented across multiple outer IP-TFS tunnel packets.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 net/xfrm/xfrm_iptfs.c | 438 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 425 insertions(+), 13 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index ee75be187539..a8ef3eb7427c 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -55,10 +55,22 @@ struct xfrm_iptfs_data {
 	struct hrtimer iptfs_timer; /* output timer */
 	time64_t iptfs_settime;	    /* time timer was set */
 	u32 payload_mtu;	    /* max payload size */
+
+	/* Tunnel egress */
+	spinlock_t drop_lock;
+	struct hrtimer drop_timer;
+	u64 drop_time_ns;
+
+	/* Tunnel egress reassembly */
+	struct sk_buff *ra_newskb; /* new pkt being reassembled */
+	u64 ra_wantseq;		   /* expected next sequence */
+	u8 ra_runt[6];		   /* last pkt bytes from last skb */
+	u8 ra_runtlen;		   /* count of ra_runt */
 };
 
 static u32 __iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu);
 static enum hrtimer_restart iptfs_delay_timer(struct hrtimer *me);
+static enum hrtimer_restart iptfs_drop_timer(struct hrtimer *me);
 
 /* ================= */
 /* Utility Functions */
@@ -216,6 +228,63 @@ iptfs_pskb_extract_seq(u32 skblen, struct skb_seq_state *st, u32 off, int len)
 	return skb;
 }
 
+/**
+ * iptfs_input_save_runt() - save data in xtfs runt space.
+ * @xtfs: xtfs state
+ * @seq: the current sequence
+ * @buf: packet data
+ * @len: length of packet data
+ *
+ * Save the small (`len`) start of a fragmented packet in `buf` in the xtfs data
+ * runt space.
+ */
+static void iptfs_input_save_runt(struct xfrm_iptfs_data *xtfs, u64 seq,
+				  u8 *buf, int len)
+{
+	BUG_ON(xtfs->ra_newskb); /* we won't have a new SKB yet */
+
+	memcpy(xtfs->ra_runt, buf, len);
+
+	xtfs->ra_runtlen = len;
+	xtfs->ra_wantseq = seq + 1;
+}
+
+/**
+ * __iptfs_iphlen() - return the v4/v6 header length using packet data.
+ * @data: pointer at octet with version nibble
+ *
+ * The version data is expected to be valid (i.e., either 4 or 6).
+ */
+static u32 __iptfs_iphlen(u8 *data)
+{
+	struct iphdr *iph = (struct iphdr *)data;
+
+	if (iph->version == 0x4)
+		return sizeof(*iph);
+	BUG_ON(iph->version != 0x6);
+	return sizeof(struct ipv6hdr);
+}
+
+/**
+ * __iptfs_iplen() - return the v4/v6 length using packet data.
+ * @data: pointer to ip (v4/v6) packet header
+ *
+ * Grab the IPv4 or IPv6 length value in the start of the inner packet header
+ * pointed to by `data`. Assumes data len is enough for the length field only.
+ *
+ * The version data is expected to be valid (i.e., either 4 or 6).
+ */
+static u32 __iptfs_iplen(u8 *data)
+{
+	struct iphdr *iph = (struct iphdr *)data;
+
+	if (iph->version == 0x4)
+		return ntohs(iph->tot_len);
+	BUG_ON(iph->version != 0x6);
+	return ntohs(((struct ipv6hdr *)iph)->payload_len) +
+	       sizeof(struct ipv6hdr);
+}
+
 /**
  * iptfs_complete_inner_skb() - finish preparing the inner packet for gro recv.
  * @x: xfrm state
@@ -265,6 +334,238 @@ static void iptfs_complete_inner_skb(struct xfrm_state *x, struct sk_buff *skb)
 	}
 }
 
+static void __iptfs_reassem_done(struct xfrm_iptfs_data *xtfs, bool free)
+{
+	assert_spin_locked(&xtfs->drop_lock);
+
+	/* We don't care if it works locking takes care of things */
+	hrtimer_try_to_cancel(&xtfs->drop_timer);
+	if (free)
+		kfree_skb(xtfs->ra_newskb);
+	xtfs->ra_newskb = NULL;
+}
+
+/**
+ * iptfs_reassem_abort() - In-progress packet is aborted free the state.
+ * @xtfs: xtfs state
+ */
+static void iptfs_reassem_abort(struct xfrm_iptfs_data *xtfs)
+{
+	__iptfs_reassem_done(xtfs, true);
+}
+
+/**
+ * iptfs_reassem_done() - In-progress packet is complete, clear the state.
+ * @xtfs: xtfs state
+ */
+static void iptfs_reassem_done(struct xfrm_iptfs_data *xtfs)
+{
+	__iptfs_reassem_done(xtfs, false);
+}
+
+/**
+ * iptfs_reassem_cont() - Continue the reassembly of an inner packets.
+ * @xtfs: xtfs state
+ * @seq: sequence of current packet
+ * @st: seq read stat for current packet
+ * @skb: current packet
+ * @data: offset into sequential packet data
+ * @blkoff: packet blkoff value
+ * @list: list of skbs to enqueue completed packet on
+ *
+ * Process an IPTFS payload that has a non-zero `blkoff` or when we are
+ * expecting the continuation b/c we have a runt or in-progress packet.
+ */
+static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
+			      struct skb_seq_state *st, struct sk_buff *skb,
+			      u32 data, u32 blkoff, struct list_head *list)
+{
+	struct sk_buff *newskb = xtfs->ra_newskb;
+	u32 remaining = skb->len - data;
+	u32 runtlen = xtfs->ra_runtlen;
+	u32 copylen, fraglen, ipremain, iphlen, iphremain, rrem;
+
+	/* Handle packet fragment we aren't expecting */
+	if (!runtlen && !xtfs->ra_newskb)
+		return data + min(blkoff, remaining);
+
+	/* Important to remember that input to this function is an ordered
+	 * packet stream (unless the user disabled the reorder window). Thus if
+	 * we are waiting for, and expecting the next packet so we can continue
+	 * assembly, a newer sequence number indicates older ones are not coming
+	 * (or if they do should be ignored). Technically we can receive older
+	 * ones when the reorder window is disabled; however, the user should
+	 * have disabled fragmentation in this case, and regardless we don't
+	 * deal with it.
+	 *
+	 * blkoff could be zero if the stream is messed up (or it's an all pad
+	 * insertion) be careful to handle that case in each of the below
+	 */
+
+	/* Too old case: This can happen when the reorder window is disabled so
+	 * ordering isn't actually guaranteed.
+	 */
+	if (seq < xtfs->ra_wantseq)
+		return data + remaining;
+
+	/* Too new case: We missed what we wanted cleanup. */
+	if (seq > xtfs->ra_wantseq) {
+		XFRM_INC_STATS(dev_net(skb->dev),
+			       LINUX_MIB_XFRMINIPTFSERROR);
+		goto abandon;
+	}
+
+	if (blkoff == 0) {
+		if ((*skb->data & 0xF0) != 0) {
+			XFRM_INC_STATS(dev_net(skb->dev),
+				       LINUX_MIB_XFRMINIPTFSERROR);
+			goto abandon;
+		}
+		/* Handle all pad case, advance expected sequence number.
+		 * (RFC 9347 S2.2.3)
+		 */
+		xtfs->ra_wantseq++;
+		/* will end parsing */
+		return data + remaining;
+	}
+
+	if (runtlen) {
+		BUG_ON(xtfs->ra_newskb);
+
+		/* Regardless of what happens we're done with the runt */
+		xtfs->ra_runtlen = 0;
+
+		/* The start of this inner packet was at the very end of the last
+		 * iptfs payload which didn't include enough for the ip header
+		 * length field. We must have *at least* that now.
+		 */
+		rrem = sizeof(xtfs->ra_runt) - runtlen;
+		if (remaining < rrem || blkoff < rrem) {
+			XFRM_INC_STATS(dev_net(skb->dev),
+				       LINUX_MIB_XFRMINIPTFSERROR);
+			goto abandon;
+		}
+
+		/* fill in the runt data */
+		if (skb_copy_bits_seq(st, data, &xtfs->ra_runt[runtlen],
+				      rrem)) {
+			XFRM_INC_STATS(dev_net(skb->dev),
+				       LINUX_MIB_XFRMINBUFFERERROR);
+			goto abandon;
+		}
+
+		/* We have enough data to get the ip length value now,
+		 * allocate an in progress skb
+		 */
+		ipremain = __iptfs_iplen(xtfs->ra_runt);
+		if (ipremain < sizeof(xtfs->ra_runt)) {
+			/* length has to be at least runtsize large */
+			XFRM_INC_STATS(dev_net(skb->dev),
+				       LINUX_MIB_XFRMINIPTFSERROR);
+			goto abandon;
+		}
+
+		/* For the runt case we don't attempt sharing currently. NOTE:
+		 * Currently, this IPTFS implementation will not create runts.
+		 */
+
+		newskb = iptfs_alloc_skb(skb, ipremain, false);
+		if (!newskb) {
+			XFRM_INC_STATS(dev_net(skb->dev),
+				       LINUX_MIB_XFRMINERROR);
+			goto abandon;
+		}
+		xtfs->ra_newskb = newskb;
+
+		/* Copy the runt data into the buffer, but leave data
+		 * pointers the same as normal non-runt case. The extra `rrem`
+		 * recopied bytes are basically cacheline free. Allows using
+		 * same logic below to complete.
+		 */
+		memcpy(skb_put(newskb, runtlen), xtfs->ra_runt,
+		       sizeof(xtfs->ra_runt));
+	}
+
+	/* Continue reassembling the packet */
+	ipremain = __iptfs_iplen(newskb->data);
+	iphlen = __iptfs_iphlen(newskb->data);
+
+	/* Sanity check, we created the newskb knowing the IP length so the IP
+	 * length can't now be shorter.
+	 */
+	BUG_ON(newskb->len > ipremain);
+
+	ipremain -= newskb->len;
+	if (blkoff < ipremain) {
+		/* Corrupt data, we don't have enough to complete the packet */
+		XFRM_INC_STATS(dev_net(skb->dev), LINUX_MIB_XFRMINIPTFSERROR);
+		goto abandon;
+	}
+
+	/* We want the IP header in linear space */
+	if (newskb->len < iphlen)  {
+		iphremain = iphlen - newskb->len;
+		if (blkoff < iphremain) {
+			XFRM_INC_STATS(dev_net(skb->dev),
+				       LINUX_MIB_XFRMINIPTFSERROR);
+			goto abandon;
+		}
+		fraglen = min(blkoff, remaining);
+		copylen = min(fraglen, iphremain);
+		BUG_ON(skb_tailroom(newskb) < copylen);
+		if (skb_copy_bits_seq(st, data, skb_put(newskb, copylen), copylen)) {
+			XFRM_INC_STATS(dev_net(skb->dev),
+				       LINUX_MIB_XFRMINBUFFERERROR);
+			goto abandon;
+		}
+		/* this is a silly condition that might occur anyway */
+		if (copylen < iphremain) {
+			xtfs->ra_wantseq++;
+			return data + fraglen;
+		}
+		/* update data and things derived from it */
+		data += copylen;
+		blkoff -= copylen;
+		remaining -= copylen;
+		ipremain -= copylen;
+	}
+
+	fraglen = min(blkoff, remaining);
+	copylen = min(fraglen, ipremain);
+
+	/* We verified this was true in the main receive routine */
+	BUG_ON(skb_tailroom(newskb) < copylen);
+
+	/* copy fragment data into newskb */
+	if (skb_copy_bits_seq(st, data, skb_put(newskb, copylen), copylen)) {
+		XFRM_INC_STATS(dev_net(skb->dev), LINUX_MIB_XFRMINBUFFERERROR);
+		goto abandon;
+	}
+
+	if (copylen < ipremain) {
+		xtfs->ra_wantseq++;
+	} else {
+		/* We are done with packet reassembly! */
+		BUG_ON(copylen != ipremain);
+		iptfs_reassem_done(xtfs);
+		iptfs_complete_inner_skb(xtfs->x, newskb);
+		list_add_tail(&newskb->list, list);
+	}
+
+	/* will continue on to new data block or end */
+	return data + fraglen;
+
+abandon:
+	if (xtfs->ra_newskb) {
+		iptfs_reassem_abort(xtfs);
+	} else {
+		xtfs->ra_runtlen = 0;
+		xtfs->ra_wantseq = 0;
+	}
+	/* skip past fragment, maybe to end */
+	return data + min(blkoff, remaining);
+}
+
 /**
  * iptfs_input() - handle receipt of iptfs payload
  * @x: xfrm state
@@ -285,7 +586,7 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 	struct iphdr *iph;
 	struct net *net;
 	u32 remaining, iplen, iphlen, data, tail;
-	u32 blkoff;
+	u32 blkoff, capturelen;
 	u64 seq;
 
 	xtfs = x->mode_data;
@@ -331,12 +632,27 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 
 	INIT_LIST_HEAD(&sublist);
 
-	/* Fragment handling in following commits */
+	/* Handle fragment at start of payload, and/or waiting reassembly. */
+
 	blkoff = ntohs(ipth->block_offset);
-	data += blkoff;
+	/* check before locking i.e., maybe */
+	if (blkoff || xtfs->ra_runtlen || xtfs->ra_newskb) {
+		spin_lock(&xtfs->drop_lock);
+
+		/* check again after lock */
+		if (blkoff || xtfs->ra_runtlen || xtfs->ra_newskb) {
+			data = iptfs_reassem_cont(xtfs, seq, &skbseq, skb, data,
+						  blkoff, &sublist);
+		}
+
+		spin_unlock(&xtfs->drop_lock);
+	}
 
 	/* New packets */
+
 	tail = skb->len;
+	BUG_ON(xtfs->ra_newskb && data < tail);
+
 	while (data < tail) {
 		__be16 protocol = 0;
 
@@ -355,8 +671,13 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 		iph = (struct iphdr *)hbytes;
 		if (iph->version == 0x4) {
 			/* must have at least tot_len field present */
-			if (remaining < 4)
+			if (remaining < 4) {
+				/* save the bytes we have, advance data and exit */
+				iptfs_input_save_runt(xtfs, seq, hbytes,
+						      remaining);
+				data += remaining;
 				break;
+			}
 
 			iplen = be16_to_cpu(iph->tot_len);
 			iphlen = iph->ihl << 2;
@@ -364,8 +685,13 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 			XFRM_MODE_SKB_CB(skbseq.root_skb)->tos = iph->tos;
 		} else if (iph->version == 0x6) {
 			/* must have at least payload_len field present */
-			if (remaining < 6)
+			if (remaining < 6) {
+				/* save the bytes we have, advance data and exit */
+				iptfs_input_save_runt(xtfs, seq, hbytes,
+						      remaining);
+				data += remaining;
 				break;
+			}
 
 			iplen = be16_to_cpu(
 				((struct ipv6hdr *)hbytes)->payload_len);
@@ -376,6 +702,7 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 				ipv6_get_dsfield((struct ipv6hdr *)iph);
 		} else if (iph->version == 0x0) {
 			/* pad */
+			data = tail;
 			break;
 		} else {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
@@ -395,16 +722,14 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 		if (!first_skb)
 			first_skb = skb;
 
-		/* Fragment handling in following commits */
-		if (iplen > remaining)
-			break;
-
-		skb = iptfs_pskb_extract_seq(iplen, &skbseq, data, iplen);
+		capturelen = min(iplen, remaining);
+		skb = iptfs_pskb_extract_seq(iplen, &skbseq, data, capturelen);
 		if (!skb) {
 			/* skip to next packet or done */
-			data += iplen;
+			data += capturelen;
 			continue;
 		}
+		BUG_ON(skb->len != capturelen);
 
 		skb->protocol = protocol;
 		if (old_mac) {
@@ -415,11 +740,38 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 			eth_hdr(skb)->h_proto = skb->protocol;
 		}
 
-		data += iplen;
+		data += capturelen;
+
+		if (skb->len < iplen) {
+			BUG_ON(data != tail);
+			BUG_ON(xtfs->ra_newskb);
+
+			/* Start reassembly */
+			spin_lock(&xtfs->drop_lock);
+
+			xtfs->ra_newskb = skb;
+			xtfs->ra_wantseq = seq + 1;
+			if (!hrtimer_is_queued(&xtfs->drop_timer)) {
+				/* softirq blocked lest the timer fire and interrupt us */
+				BUG_ON(!in_interrupt());
+				hrtimer_start(&xtfs->drop_timer,
+					      xtfs->drop_time_ns,
+					      IPTFS_HRTIMER_MODE);
+			}
+
+			spin_unlock(&xtfs->drop_lock);
+
+			break;
+		}
+
 		iptfs_complete_inner_skb(x, skb);
 		list_add_tail(&skb->list, &sublist);
 	}
 
+	if (data != tail)
+		/* this should not happen from the above code */
+		XFRM_INC_STATS(net, LINUX_MIB_XFRMINIPTFSERROR);
+
 	/* Send the packets! */
 	list_for_each_entry_safe(skb, next, &sublist, list) {
 		skb_list_del_init(skb);
@@ -447,6 +799,45 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 	return -EINPROGRESS;
 }
 
+/**
+ * iptfs_drop_timer() - Handle drop timer expiry.
+ * @me: the timer
+ *
+ * This is similar to our input function.
+ *
+ * The drop timer is set when we start an in progress reassembly, and also when
+ * we save a future packet in the window saved array.
+ *
+ * NOTE packets in the save window are always newer WRT drop times as
+ * they get further in the future. i.e. for:
+ *
+ *    if slots (S0, S1, ... Sn) and `Dn` is the drop time for slot `Sn`,
+ *    then D(n-1) <= D(n).
+ *
+ * So, regardless of why the timer is firing we can always discard any inprogress
+ * fragment; either it's the reassembly timer, or slot 0 is going to be
+ * dropped as S0 must have the most recent drop time, and slot 0 holds the
+ * continuation fragment of the in progress packet.
+ */
+static enum hrtimer_restart iptfs_drop_timer(struct hrtimer *me)
+{
+	struct xfrm_iptfs_data *xtfs;
+	struct xfrm_state *x;
+
+	xtfs = container_of(me, typeof(*xtfs), drop_timer);
+	x = xtfs->x;
+
+	/* Drop any in progress packet */
+	spin_lock(&xtfs->drop_lock);
+	if (xtfs->ra_newskb) {
+		kfree_skb(xtfs->ra_newskb);
+		xtfs->ra_newskb = NULL;
+	}
+	spin_unlock(&xtfs->drop_lock);
+
+	return HRTIMER_NORESTART;
+}
+
 /* ================================= */
 /* IPTFS Sending (ingress) Functions */
 /* ================================= */
@@ -1254,6 +1645,8 @@ static int iptfs_user_init(struct net *net, struct xfrm_state *x,
 	xc->max_queue_size = net->xfrm.sysctl_iptfs_max_qsize;
 	xtfs->init_delay_ns =
 		(u64)net->xfrm.sysctl_iptfs_init_delay * NSECS_IN_USEC;
+	xtfs->drop_time_ns =
+		(u64)net->xfrm.sysctl_iptfs_drop_time * NSECS_IN_USEC;
 
 	if (attrs[XFRMA_IPTFS_DONT_FRAG])
 		xc->dont_frag = true;
@@ -1271,6 +1664,10 @@ static int iptfs_user_init(struct net *net, struct xfrm_state *x,
 	}
 	if (attrs[XFRMA_IPTFS_MAX_QSIZE])
 		xc->max_queue_size = nla_get_u32(attrs[XFRMA_IPTFS_MAX_QSIZE]);
+	if (attrs[XFRMA_IPTFS_DROP_TIME])
+		xtfs->drop_time_ns =
+			(u64)nla_get_u32(attrs[XFRMA_IPTFS_DROP_TIME]) *
+			NSECS_IN_USEC;
 	if (attrs[XFRMA_IPTFS_INIT_DELAY])
 		xtfs->init_delay_ns =
 			(u64)nla_get_u32(attrs[XFRMA_IPTFS_INIT_DELAY]) *
@@ -1320,7 +1717,9 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
 	if (ret)
 		return ret;
 
-	ret = nla_put_u32(skb, XFRMA_IPTFS_DROP_TIME, 0);
+	q = xtfs->drop_time_ns;
+	(void)do_div(q, NSECS_IN_USEC);
+	ret = nla_put_u32(skb, XFRMA_IPTFS_DROP_TIME, q);
 	if (ret)
 		return ret;
 
@@ -1338,6 +1737,10 @@ static int __iptfs_init_state(struct xfrm_state *x,
 	hrtimer_init(&xtfs->iptfs_timer, CLOCK_MONOTONIC, IPTFS_HRTIMER_MODE);
 	xtfs->iptfs_timer.function = iptfs_delay_timer;
 
+	spin_lock_init(&xtfs->drop_lock);
+	hrtimer_init(&xtfs->drop_timer, CLOCK_MONOTONIC, IPTFS_HRTIMER_MODE);
+	xtfs->drop_timer.function = iptfs_drop_timer;
+
 	/* Modify type (esp) adjustment values */
 
 	if (x->props.family == AF_INET)
@@ -1365,6 +1768,8 @@ static int iptfs_clone(struct xfrm_state *x, struct xfrm_state *orig)
 	if (!xtfs)
 		return -ENOMEM;
 
+	xtfs->ra_newskb = NULL;
+
 	err = __iptfs_init_state(x, xtfs);
 	if (err)
 		return err;
@@ -1395,7 +1800,14 @@ static void iptfs_delete_state(struct xfrm_state *x)
 	if (!xtfs)
 		return;
 
+	spin_lock_bh(&xtfs->drop_lock);
 	hrtimer_cancel(&xtfs->iptfs_timer);
+	hrtimer_cancel(&xtfs->drop_timer);
+	spin_unlock_bh(&xtfs->drop_lock);
+
+	if (xtfs->ra_newskb)
+		kfree_skb(xtfs->ra_newskb);
+
 	kfree_sensitive(xtfs);
 
 	module_put(x->mode_cbs->owner);
-- 
2.45.2


