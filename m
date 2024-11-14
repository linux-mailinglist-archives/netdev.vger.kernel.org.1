Return-Path: <netdev+bounces-144708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718779C83C4
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FB41F21D24
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 07:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D921F8EFE;
	Thu, 14 Nov 2024 07:07:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E511EBA11
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568059; cv=none; b=QX+GQ4FqlHLrzAxtElnVypoyDGVnNIR5BM2haJ+uj8kqjLP/qN1WBHF/xNBqmeCKV0r0QhNweuQ868cComUHArT1viZ+hKPYdtxWnbSb15OuLztJsSGi9ShTM8EWAye0Z3sNQt1aWSPjPG9f5vg86Tb9OdmHyfhV3APkgcPiaXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568059; c=relaxed/simple;
	bh=wHF1x2w8WoMNgQ7+RqjA9rC8WlBw8pbr0ouD1b+RVCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDxt8OKFcXcq/HalXdFXvnX2UZHbmFfVnAAnAp2ES2L9A3AHNcD/Hr1Tbd33Y7+42xoIqPEFzAR01HFTXensxd3BbK2LfAa5Dokq2eD0Oa7etLkeLMKsl42jNYslact3HvyC83JQprGbbGzaxDgilYzm3owN9ogFkWBgQ2ltNEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 87C357D135;
	Thu, 14 Nov 2024 07:07:34 +0000 (UTC)
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
Subject: [PATCH ipsec-next v14 11/15] xfrm: iptfs: handle received fragmented inner packets
Date: Thu, 14 Nov 2024 02:07:08 -0500
Message-ID: <20241114070713.3718740-12-chopps@chopps.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114070713.3718740-1-chopps@chopps.org>
References: <20241114070713.3718740-1-chopps@chopps.org>
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
 net/xfrm/xfrm_iptfs.c | 480 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 461 insertions(+), 19 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 085964fe3251..4af1f7b5818e 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -24,6 +24,21 @@
 #define IPTFS_SUBTYPE_BASIC 0
 #define IPTFS_SUBTYPE_CC 1
 
+/* ----------------------------------------------- */
+/* IP-TFS default SA values (tunnel egress/dir-in) */
+/* ----------------------------------------------- */
+
+/**
+ * define IPTFS_DEFAULT_DROP_TIME_USECS - default drop time
+ *
+ * The default IPTFS drop time in microseconds. The drop time is the amount of
+ * time before a missing out-of-order IPTFS tunnel packet is considered lost.
+ * See also the reorder window.
+ *
+ * Default 1s.
+ */
+#define IPTFS_DEFAULT_DROP_TIME_USECS 1000000
+
 /* ------------------------------------------------ */
 /* IPTFS default SA values (tunnel ingress/dir-out) */
 /* ------------------------------------------------ */
@@ -95,6 +110,13 @@ struct xfrm_iptfs_config {
  * @init_delay_ns: nanoseconds to wait to send initial IPTFS packet.
  * @iptfs_timer: output timer.
  * @payload_mtu: max payload size.
+ * @drop_lock: lock to protect reorder queue.
+ * @drop_timer: timer for considering next packet lost.
+ * @drop_time_ns: timer intervan in nanoseconds.
+ * @ra_newskb: new pkt being reassembled.
+ * @ra_wantseq: expected next sequence for reassembly.
+ * @ra_runt: last pkt bytes from very end of last skb.
+ * @ra_runtlen: size of ra_runt.
  */
 struct xfrm_iptfs_data {
 	struct xfrm_iptfs_config cfg;
@@ -108,10 +130,33 @@ struct xfrm_iptfs_data {
 	u64 init_delay_ns;	    /* nanoseconds */
 	struct hrtimer iptfs_timer; /* output timer */
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
+
+/* ================= */
+/* Utility Functions */
+/* ================= */
+
+static u64 __esp_seq(struct sk_buff *skb)
+{
+	u64 seq = ntohl(XFRM_SKB_CB(skb)->seq.input.low);
+
+	return seq | (u64)ntohl(XFRM_SKB_CB(skb)->seq.input.hi) << 32;
+}
 
 /* ======================= */
 /* IPTFS SK_BUFF Functions */
@@ -224,6 +269,63 @@ iptfs_pskb_extract_seq(u32 skblen, struct skb_seq_state *st, u32 off, int len)
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
+ * The version data has been checked to be valid (i.e., either 4 or 6).
+ *
+ * Return: the IP header size based on the IP version.
+ */
+static u32 __iptfs_iphlen(u8 *data)
+{
+	struct iphdr *iph = (struct iphdr *)data;
+
+	if (iph->version == 0x4)
+		return sizeof(*iph);
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
+ * The version data has been checked to be valid (i.e., either 4 or 6).
+ *
+ * Return: the length value.
+ */
+static u32 __iptfs_iplen(u8 *data)
+{
+	struct iphdr *iph = (struct iphdr *)data;
+
+	if (iph->version == 0x4)
+		return ntohs(iph->tot_len);
+	return ntohs(((struct ipv6hdr *)iph)->payload_len) +
+		sizeof(struct ipv6hdr);
+}
+
 /**
  * iptfs_complete_inner_skb() - finish preparing the inner packet for gro recv.
  * @x: xfrm state
@@ -273,6 +375,227 @@ static void iptfs_complete_inner_skb(struct xfrm_state *x, struct sk_buff *skb)
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
+ *
+ * Return: the new data offset to continue processing from.
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
+		XFRM_INC_STATS(xs_net(xtfs->x), LINUX_MIB_XFRMINIPTFSERROR);
+		goto abandon;
+	}
+
+	if (blkoff == 0) {
+		if ((*skb->data & 0xF0) != 0) {
+			XFRM_INC_STATS(xs_net(xtfs->x),
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
+		/* Regardless of what happens we're done with the runt */
+		xtfs->ra_runtlen = 0;
+
+		/* The start of this inner packet was at the very end of the last
+		 * iptfs payload which didn't include enough for the ip header
+		 * length field. We must have *at least* that now.
+		 */
+		rrem = sizeof(xtfs->ra_runt) - runtlen;
+		if (remaining < rrem || blkoff < rrem) {
+			XFRM_INC_STATS(xs_net(xtfs->x),
+				       LINUX_MIB_XFRMINIPTFSERROR);
+			goto abandon;
+		}
+
+		/* fill in the runt data */
+		if (skb_copy_seq_read(st, data, &xtfs->ra_runt[runtlen],
+				      rrem)) {
+			XFRM_INC_STATS(xs_net(xtfs->x),
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
+			XFRM_INC_STATS(xs_net(xtfs->x),
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
+			XFRM_INC_STATS(xs_net(xtfs->x), LINUX_MIB_XFRMINERROR);
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
+	ipremain -= newskb->len;
+	if (blkoff < ipremain) {
+		/* Corrupt data, we don't have enough to complete the packet */
+		XFRM_INC_STATS(xs_net(xtfs->x), LINUX_MIB_XFRMINIPTFSERROR);
+		goto abandon;
+	}
+
+	/* We want the IP header in linear space */
+	if (newskb->len < iphlen) {
+		iphremain = iphlen - newskb->len;
+		if (blkoff < iphremain) {
+			XFRM_INC_STATS(xs_net(xtfs->x),
+				       LINUX_MIB_XFRMINIPTFSERROR);
+			goto abandon;
+		}
+		fraglen = min(blkoff, remaining);
+		copylen = min(fraglen, iphremain);
+		if (skb_copy_seq_read(st, data, skb_put(newskb, copylen),
+				      copylen)) {
+			XFRM_INC_STATS(xs_net(xtfs->x),
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
+	/* copy fragment data into newskb */
+	if (skb_copy_seq_read(st, data, skb_put(newskb, copylen), copylen)) {
+		XFRM_INC_STATS(dev_net(skb->dev), LINUX_MIB_XFRMINBUFFERERROR);
+		goto abandon;
+	}
+
+	if (copylen < ipremain) {
+		xtfs->ra_wantseq++;
+	} else {
+		/* We are done with packet reassembly! */
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
 static bool __input_process_payload(struct xfrm_state *x, u32 data,
 				    struct skb_seq_state *skbseq,
 				    struct list_head *sublist)
@@ -280,14 +603,20 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 	u8 hbytes[sizeof(struct ipv6hdr)];
 	struct sk_buff *first_skb, *next, *skb;
 	const unsigned char *old_mac;
+	struct xfrm_iptfs_data *xtfs;
 	struct iphdr *iph;
 	struct net *net;
 	u32 remaining, iplen, iphlen, tail;
+	u32 capturelen;
+	u64 seq;
 
+	xtfs = x->mode_data;
 	net = xs_net(x);
 	skb = skbseq->root_skb;
 	first_skb = NULL;
 
+	seq = __esp_seq(skb);
+
 	/* Save the old mac header if set */
 	old_mac = skb_mac_header_was_set(skb) ? skb_mac_header(skb) : NULL;
 
@@ -312,8 +641,13 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
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
@@ -321,8 +655,13 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 			XFRM_MODE_SKB_CB(skbseq->root_skb)->tos = iph->tos;
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
 
 			iplen = be16_to_cpu(((struct ipv6hdr *)hbytes)->payload_len);
 			iplen += sizeof(struct ipv6hdr);
@@ -332,6 +671,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 				ipv6_get_dsfield((struct ipv6hdr *)iph);
 		} else if (iph->version == 0x0) {
 			/* pad */
+			data = tail;
 			break;
 		} else {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
@@ -351,14 +691,11 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 		if (!first_skb)
 			first_skb = skb;
 
-		/* Fragment handling in following commits */
-		if (iplen > remaining)
-			break;
-
-		skb = iptfs_pskb_extract_seq(iplen, skbseq, data, iplen);
+		capturelen = min(iplen, remaining);
+		skb = iptfs_pskb_extract_seq(iplen, skbseq, data, capturelen);
 		if (!skb) {
 			/* skip to next packet or done */
-			data += iplen;
+			data += capturelen;
 			continue;
 		}
 
@@ -370,18 +707,40 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 			eth_hdr(skb)->h_proto = skb->protocol;
 		}
 
-		data += iplen;
+		data += capturelen;
+
+		if (skb->len < iplen) {
+			/* Start reassembly */
+			spin_lock(&xtfs->drop_lock);
+
+			xtfs->ra_newskb = skb;
+			xtfs->ra_wantseq = seq + 1;
+			if (!hrtimer_is_queued(&xtfs->drop_timer)) {
+				/* softirq blocked lest the timer fire and interrupt us */
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
 		list_add_tail(&skb->list, sublist);
 	}
 
+	if (data != tail)
+		/* this should not happen from the above code */
+		XFRM_INC_STATS(net, LINUX_MIB_XFRMINIPTFSERROR);
+
 	/* Send the packets! */
 	list_for_each_entry_safe(skb, next, sublist, list) {
 		skb_list_del_init(skb);
 		if (xfrm_input(skb, 0, 0, -2))
 			kfree_skb(skb);
 	}
-
 done:
 	return false;
 }
@@ -400,13 +759,18 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 	struct ip_iptfs_cc_hdr iptcch;
 	struct skb_seq_state skbseq;
 	struct list_head sublist; /* rename this it's just a list */
+	struct xfrm_iptfs_data *xtfs;
 	struct ip_iptfs_hdr *ipth;
 	struct net *net;
-	u32 remaining, data;
+	u32 blkoff, data, remaining;
 	bool consumed = false;
+	u64 seq;
 
+	xtfs = x->mode_data;
 	net = xs_net(x);
 
+	seq = __esp_seq(skb);
+
 	/* Large enough to hold both types of header */
 	ipth = (struct ip_iptfs_hdr *)&iptcch;
 
@@ -441,17 +805,30 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 
 	INIT_LIST_HEAD(&sublist);
 
-	/* Fragment handling in following commits */
-	data += ntohs(ipth->block_offset);
+	/* Handle fragment at start of payload, and/or waiting reassembly. */
+
+	blkoff = ntohs(ipth->block_offset);
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
 	consumed = __input_process_payload(x, data, &skbseq, &sublist);
 done:
-	skb = skbseq.root_skb;
-	skb_abort_seq_read(&skbseq);
-
-	if (!consumed)
+	if (!consumed) {
+		skb = skbseq.root_skb;
+		skb_abort_seq_read(&skbseq);
 		kfree_skb(skb);
+	}
 
 	/* We always have dealt with the input SKB, either we are re-using it,
 	 * or we have freed it. Return EINPROGRESS so that xfrm_input stops
@@ -460,6 +837,47 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
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
+ *
+ * Returns HRTIMER_NORESTART.
+ */
+static enum hrtimer_restart iptfs_drop_timer(struct hrtimer *me)
+{
+	struct xfrm_iptfs_data *xtfs;
+	struct sk_buff *skb;
+
+	xtfs = container_of(me, typeof(*xtfs), drop_timer);
+
+	/* Drop any in progress packet */
+	spin_lock(&xtfs->drop_lock);
+	skb = xtfs->ra_newskb;
+	xtfs->ra_newskb = NULL;
+	spin_unlock(&xtfs->drop_lock);
+
+	if (skb)
+		kfree_skb_reason(skb, SKB_DROP_REASON_FRAG_REASM_TIMEOUT);
+
+	return HRTIMER_NORESTART;
+}
+
 /* ================================= */
 /* IPTFS Sending (ingress) Functions */
 /* ================================= */
@@ -1214,6 +1632,7 @@ static int iptfs_user_init(struct net *net, struct xfrm_state *x,
 
 	xc = &xtfs->cfg;
 	xc->max_queue_size = IPTFS_DEFAULT_MAX_QUEUE_SIZE;
+	xtfs->drop_time_ns = IPTFS_DEFAULT_DROP_TIME_USECS * NSECS_IN_USEC;
 	xtfs->init_delay_ns = IPTFS_DEFAULT_INIT_DELAY_USECS * NSECS_IN_USEC;
 
 	if (attrs[XFRMA_IPTFS_DONT_FRAG])
@@ -1232,6 +1651,10 @@ static int iptfs_user_init(struct net *net, struct xfrm_state *x,
 	}
 	if (attrs[XFRMA_IPTFS_MAX_QSIZE])
 		xc->max_queue_size = nla_get_u32(attrs[XFRMA_IPTFS_MAX_QSIZE]);
+	if (attrs[XFRMA_IPTFS_DROP_TIME])
+		xtfs->drop_time_ns =
+			(u64)nla_get_u32(attrs[XFRMA_IPTFS_DROP_TIME]) *
+			NSECS_IN_USEC;
 	if (attrs[XFRMA_IPTFS_INIT_DELAY])
 		xtfs->init_delay_ns =
 			(u64)nla_get_u32(attrs[XFRMA_IPTFS_INIT_DELAY]) * NSECS_IN_USEC;
@@ -1249,7 +1672,9 @@ static unsigned int iptfs_sa_len(const struct xfrm_state *x)
 	struct xfrm_iptfs_config *xc = &xtfs->cfg;
 	unsigned int l = 0;
 
-	if (x->dir == XFRM_SA_DIR_OUT) {
+	if (x->dir == XFRM_SA_DIR_IN) {
+		l += nla_total_size(sizeof(u32)); /* drop time usec */
+	} else {
 		if (xc->dont_frag)
 			l += nla_total_size(0);	  /* dont-frag flag */
 		l += nla_total_size(sizeof(u32)); /* init delay usec */
@@ -1267,7 +1692,11 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
 	int ret = 0;
 	u64 q;
 
-	if (x->dir == XFRM_SA_DIR_OUT) {
+	if (x->dir == XFRM_SA_DIR_IN) {
+		q = xtfs->drop_time_ns;
+		do_div(q, NSECS_IN_USEC);
+		ret = nla_put_u32(skb, XFRMA_IPTFS_DROP_TIME, q);
+	} else {
 		if (xc->dont_frag) {
 			ret = nla_put_flag(skb, XFRMA_IPTFS_DONT_FRAG);
 			if (ret)
@@ -1297,6 +1726,10 @@ static void __iptfs_init_state(struct xfrm_state *x,
 	hrtimer_init(&xtfs->iptfs_timer, CLOCK_MONOTONIC, IPTFS_HRTIMER_MODE);
 	xtfs->iptfs_timer.function = iptfs_delay_timer;
 
+	spin_lock_init(&xtfs->drop_lock);
+	hrtimer_init(&xtfs->drop_timer, CLOCK_MONOTONIC, IPTFS_HRTIMER_MODE);
+	xtfs->drop_timer.function = iptfs_drop_timer;
+
 	/* Modify type (esp) adjustment values */
 
 	if (x->props.family == AF_INET)
@@ -1323,6 +1756,8 @@ static int iptfs_clone_state(struct xfrm_state *x, struct xfrm_state *orig)
 	x->mode_data = xtfs;
 	xtfs->x = x;
 
+	xtfs->ra_newskb = NULL;
+
 	return 0;
 }
 
@@ -1362,6 +1797,13 @@ static void iptfs_destroy_state(struct xfrm_state *x)
 	while ((skb = __skb_dequeue(&list)))
 		kfree_skb(skb);
 
+	spin_lock_bh(&xtfs->drop_lock);
+	hrtimer_cancel(&xtfs->drop_timer);
+	spin_unlock_bh(&xtfs->drop_lock);
+
+	if (xtfs->ra_newskb)
+		kfree_skb(xtfs->ra_newskb);
+
 	kfree_sensitive(xtfs);
 
 	module_put(x->mode_cbs->owner);
-- 
2.47.0


