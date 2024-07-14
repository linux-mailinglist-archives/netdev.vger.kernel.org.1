Return-Path: <netdev+bounces-111387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 663E8930B93
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 22:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892D51C2144B
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 20:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ADB13DB88;
	Sun, 14 Jul 2024 20:23:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7116D142623
	for <netdev@vger.kernel.org>; Sun, 14 Jul 2024 20:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720988633; cv=none; b=M3sk7IjfUtebf8ePKfz8lTULgcuoD/m/7qxcb6z4Hb/R3MkFP3+RNKX+4Lf2LeFCorstVCdSNpbgjRUQGjN5xwgMCTpdNLHkQq+gx5ZtCSlIr1yz9yO7Bm6BEsUX00RBZvQ9yX5vJwtSJ2E2u2a4xXGXj9BBZ6f0GGNA357H6+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720988633; c=relaxed/simple;
	bh=rzk21jYWxsxjleDWPjeyd96/qc/yGF6rLh5JPxMJBIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUDFYKSEUk0NIKBr5pYdu+Gner543ca3Ya6gpCwcPVh3yClipbYIvPn0v6JAGeRN35i8q+gbVFAYA4cCwqO+Hh8krsiIJ3yI7Acb87ipcOWiBMGl3P/5BeV/ELXiwP/20lzPkEefuwnLcAZv1FT0JyXkGDALldZ6iEol9Sy/o1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id B18E47D12B;
	Sun, 14 Jul 2024 20:23:50 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v5 11/17] xfrm: iptfs: add fragmenting of larger than MTU user packets
Date: Sun, 14 Jul 2024 16:22:39 -0400
Message-ID: <20240714202246.1573817-12-chopps@chopps.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240714202246.1573817-1-chopps@chopps.org>
References: <20240714202246.1573817-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Add support for tunneling user (inner) packets that are larger than the
tunnel's path MTU (outer) using IP-TFS fragmentation.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 net/xfrm/xfrm_iptfs.c | 401 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 375 insertions(+), 26 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index cf6fb012e12d..933df59cd39d 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -20,11 +20,22 @@
 
 #include "xfrm_inout.h"
 
+/* 1) skb->head should be cache aligned.
+ * 2) when resv is for L2 headers (i.e., ethernet) we want the cacheline to
+ * start -16 from data.
+ * 3) when resv is for L3+L2 headers IOW skb->data points at the IPTFS payload
+ * we want data to be cache line aligned so all the pushed headers will be in
+ * another cacheline.
+ */
+#define XFRM_IPTFS_MIN_L3HEADROOM 128
+#define XFRM_IPTFS_MIN_L2HEADROOM (64 + 16)
+#define IPTFS_FRAG_COPY_MAX 256 /* max for copying to create iptfs frags */
 #define NSECS_IN_USEC 1000
 
 #define IPTFS_HRTIMER_MODE HRTIMER_MODE_REL_SOFT
 
 struct xfrm_iptfs_config {
+	bool dont_frag : 1;
 	u32 pkt_size;	    /* outer_packet_size or 0 */
 	u32 max_queue_size; /* octets */
 };
@@ -43,13 +54,71 @@ struct xfrm_iptfs_data {
 	u32 payload_mtu;	    /* max payload size */
 };
 
-static u32 iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu);
+static u32 __iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu);
 static enum hrtimer_restart iptfs_delay_timer(struct hrtimer *me);
 
 /* ================= */
 /* SK_BUFF Functions */
 /* ================= */
 
+/**
+ * iptfs_alloc_skb() - Allocate a new `skb` using a meta-data template.
+ * @tpl: the template to copy the new `skb`s meta-data from.
+ * @len: the linear length of the head data, zero is fine.
+ * @l3resv: true if reserve needs to support pushing L3 headers
+ *
+ * A new `skb` is allocated and it's meta-data is initialized from `tpl`, the
+ * head data is sized to `len` + reserved space set according to the @l3resv
+ * boolean. When @l3resv is false, resv is XFRM_IPTFS_MIN_L2HEADROOM which
+ * arranges for `skb->data - 16` (etherhdr space) to be the start of a cacheline.
+ * Otherwise, @l3resv is true and resv is either the size of headroom from `tpl` or
+ * XFRM_IPTFS_MIN_L3HEADROOM whichever is greater, which tries to align
+ * skb->data to a cacheline as all headers will be pushed on the previous
+ * cacheline bytes.
+ *
+ * When copying meta-data from the @tpl, the sk_buff->headers are not copied.
+ *
+ * Zero length skbs are allocated when we only need a head skb to hold new
+ * packet headers (basically the mac header) that sit on top of existing shared
+ * packet data.
+ *
+ * Return: the new skb or NULL.
+ */
+static struct sk_buff *iptfs_alloc_skb(struct sk_buff *tpl, u32 len,
+				       bool l3resv)
+{
+	struct sk_buff *skb;
+	u32 resv;
+
+	if (!l3resv) {
+		resv = XFRM_IPTFS_MIN_L2HEADROOM;
+	} else {
+		resv = skb_headroom(tpl);
+		if (resv < XFRM_IPTFS_MIN_L3HEADROOM)
+			resv = XFRM_IPTFS_MIN_L3HEADROOM;
+	}
+
+	skb = alloc_skb(len + resv, GFP_ATOMIC);
+	if (!skb) {
+		XFRM_INC_STATS(dev_net(tpl->dev), LINUX_MIB_XFRMINERROR);
+		return NULL;
+	}
+
+	skb_reserve(skb, resv);
+
+	/* Code from __copy_skb_header() -- we do not want any of the
+	 * tpl->headers copied over, so we aren't using `skb_copy_header()`.
+	 */
+	skb->tstamp = tpl->tstamp;
+	skb->dev = tpl->dev;
+	memcpy(skb->cb, tpl->cb, sizeof(skb->cb));
+	skb_dst_copy(skb, tpl);
+	__skb_ext_copy(skb, tpl);
+	__nf_copy(skb, tpl, false);
+
+	return skb;
+}
+
 /**
  * skb_head_to_frag() - initialize a skb_frag_t based on skb head data
  * @skb: skb with the head data
@@ -64,6 +133,39 @@ static void skb_head_to_frag(const struct sk_buff *skb, skb_frag_t *frag)
 	skb_frag_fill_page_desc(frag, page, skb->data - addr, skb_headlen(skb));
 }
 
+/**
+ * skb_copy_bits_seq - copy bits from a skb_seq_state to kernel buffer
+ * @st: source skb_seq_state
+ * @offset: offset in source
+ * @to: destination buffer
+ * @len: number of bytes to copy
+ *
+ * Copy @len bytes from @offset bytes into the source @st to the destination
+ * buffer @to. `offset` should increase (or be unchanged) with each subsequent
+ * call to this function. If offset needs to decrease from the previous use `st`
+ * should be reset first.
+ */
+static int skb_copy_bits_seq(struct skb_seq_state *st, int offset, void *to,
+			     int len)
+{
+	const u8 *data;
+	u32 sqlen;
+
+	for (;;) {
+		sqlen = skb_seq_read(offset, &data, st);
+		if (sqlen == 0)
+			return -ENOMEM;
+		if (sqlen >= len) {
+			memcpy(to, data, len);
+			return 0;
+		}
+		memcpy(to, data, sqlen);
+		to += sqlen;
+		offset += sqlen;
+		len -= sqlen;
+	}
+}
+
 /* ================================= */
 /* IPTFS Sending (ingress) Functions */
 /* ================================= */
@@ -108,7 +210,7 @@ static int iptfs_get_cur_pmtu(struct xfrm_state *x,
 {
 	struct xfrm_dst *xdst = (struct xfrm_dst *)skb_dst(skb);
 	u32 payload_mtu = xtfs->payload_mtu;
-	u32 pmtu = iptfs_get_inner_mtu(x, xdst->child_mtu_cached);
+	u32 pmtu = __iptfs_get_inner_mtu(x, xdst->child_mtu_cached);
 
 	if (payload_mtu && payload_mtu < pmtu)
 		pmtu = payload_mtu;
@@ -171,7 +273,8 @@ static int iptfs_output_collect(struct net *net, struct sock *sk,
 
 	BUG_ON(!xtfs);
 
-	pmtu = iptfs_get_cur_pmtu(x, xtfs, skb);
+	if (xtfs->cfg.dont_frag)
+		pmtu = iptfs_get_cur_pmtu(x, xtfs, skb);
 
 	/* Break apart GSO skbs. If the queue is nearing full then we want the
 	 * accounting and queuing to be based on the individual packets not on the
@@ -212,8 +315,10 @@ static int iptfs_output_collect(struct net *net, struct sock *sk,
 			continue;
 		}
 
-		/* Fragmenting handled in following commits. */
-		if (iptfs_is_too_big(sk, skb, pmtu)) {
+		/* If the user indicated no iptfs fragmenting check before
+		 * enqueue.
+		 */
+		if (xtfs->cfg.dont_frag && iptfs_is_too_big(sk, skb, pmtu)) {
 			kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_BIG);
 			continue;
 		}
@@ -259,6 +364,217 @@ static void iptfs_output_prepare_skb(struct sk_buff *skb, u32 blkoff)
 	IPCB(skb)->flags |= IPSKB_XFRM_TUNNEL_SIZE;
 }
 
+/**
+ * iptfs_copy_create_frag() - create an inner fragment skb.
+ * @st: The source packet data.
+ * @offset: offset in @st of the new fragment data.
+ * @copy_len: the amount of data to copy from @st.
+ *
+ * Create a new skb holding a single IPTFS inner packet fragment. @copy_len must
+ * not be greater than the max fragment size.
+ *
+ * Return: the new fragment skb or an ERR_PTR().
+ */
+static struct sk_buff *iptfs_copy_create_frag(struct skb_seq_state *st,
+					      u32 offset, u32 copy_len)
+{
+	struct sk_buff *src = st->root_skb;
+	struct sk_buff *skb;
+	int err;
+
+	skb = iptfs_alloc_skb(src, copy_len, true);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	/* Now copy `copy_len` data from src */
+	err = skb_copy_bits_seq(st, offset, skb_put(skb, copy_len), copy_len);
+	if (err) {
+		XFRM_INC_STATS(dev_net(src->dev), LINUX_MIB_XFRMOUTERROR);
+		kfree_skb(skb);
+		return ERR_PTR(err);
+	}
+
+	return skb;
+}
+
+/**
+ * iptfs_copy_create_frags() - create and send N-1 fragments of a larger skb.
+ * @skbp: the source packet skb (IN), skb holding the last fragment in
+ *        the fragment stream (OUT).
+ * @xtfs: IPTFS SA state.
+ * @mtu: the max IPTFS fragment size.
+ *
+ * This function is responsible for fragmenting a larger inner packet into a
+ * sequence of IPTFS payload packets. The last fragment is returned rather than
+ * being sent so that the caller can append more inner packets (aggregation) if
+ * there is room.
+ */
+static int iptfs_copy_create_frags(struct sk_buff **skbp,
+				   struct xfrm_iptfs_data *xtfs, u32 mtu)
+{
+	struct skb_seq_state skbseq;
+	struct list_head sublist;
+	struct sk_buff *skb = *skbp;
+	struct sk_buff *nskb = *skbp;
+	u32 copy_len, offset;
+	u32 to_copy = skb->len - mtu;
+	u32 blkoff = 0;
+	int err = 0;
+
+	INIT_LIST_HEAD(&sublist);
+
+	BUG_ON(skb->len <= mtu);
+	skb_prepare_seq_read(skb, 0, skb->len, &skbseq);
+
+	/* A trimmed `skb` will be sent as the first fragment, later. */
+	offset = mtu;
+	to_copy = skb->len - offset;
+	while (to_copy) {
+		/* Send all but last fragment to allow agg. append */
+		list_add_tail(&nskb->list, &sublist);
+
+		/* FUTURE: if the packet has an odd/non-aligning length we could
+		 * send less data in the penultimate fragment so that the last
+		 * fragment then ends on an aligned boundary.
+		 */
+		copy_len = to_copy <= mtu ? to_copy : mtu;
+		nskb = iptfs_copy_create_frag(&skbseq, offset, copy_len);
+		if (IS_ERR(nskb)) {
+			XFRM_INC_STATS(dev_net(skb->dev),
+				       LINUX_MIB_XFRMOUTERROR);
+			skb_abort_seq_read(&skbseq);
+			err = PTR_ERR(nskb);
+			nskb = NULL;
+			break;
+		}
+		iptfs_output_prepare_skb(nskb, to_copy);
+		offset += copy_len;
+		to_copy -= copy_len;
+		blkoff = to_copy;
+	}
+	skb_abort_seq_read(&skbseq);
+
+	/* return last fragment that will be unsent (or NULL) */
+	*skbp = nskb;
+
+	/* trim the original skb to MTU */
+	if (!err)
+		err = pskb_trim(skb, mtu);
+
+	if (err) {
+		/* Free all frags. Don't bother sending a partial packet we will
+		 * never complete.
+		 */
+		kfree_skb(nskb);
+		list_for_each_entry_safe(skb, nskb, &sublist, list) {
+			skb_list_del_init(skb);
+			kfree_skb(skb);
+		}
+		return err;
+	}
+
+	/* prepare the initial fragment with an iptfs header */
+	iptfs_output_prepare_skb(skb, 0);
+
+	/* Send all but last fragment, if we fail to send a fragment then free
+	 * the rest -- no point in sending a packet that can't be reassembled.
+	 */
+	list_for_each_entry_safe(skb, nskb, &sublist, list) {
+		skb_list_del_init(skb);
+		if (!err)
+			err = xfrm_output(NULL, skb);
+		else
+			kfree_skb(skb);
+	}
+	if (err)
+		kfree_skb(*skbp);
+	return err;
+}
+
+/**
+ * iptfs_first_should_copy() - determine if we should copy packet data.
+ * @first_skb: the first skb in the packet
+ * @mtu: the MTU.
+ *
+ * Determine if we should create subsequent skbs to hold the remaining data from
+ * a large inner packet by copying the packet data, or cloning the original skb
+ * and adjusting the offsets.
+ */
+static bool iptfs_first_should_copy(struct sk_buff *first_skb, u32 mtu)
+{
+	u32 frag_copy_max;
+
+	/* If we have less than frag_copy_max for remaining packet we copy
+	 * those tail bytes as it is more efficient.
+	 */
+	frag_copy_max = mtu <= IPTFS_FRAG_COPY_MAX ? mtu : IPTFS_FRAG_COPY_MAX;
+	if ((int)first_skb->len - (int)mtu < (int)frag_copy_max)
+		return true;
+
+	/* If we have non-linear skb just use copy */
+	if (skb_is_nonlinear(first_skb))
+		return true;
+
+	/* So we have a simple linear skb, easy to clone and share */
+	return false;
+}
+
+/**
+ * iptfs_first_skb() - handle the first dequeued inner packet for output
+ * @skbp: the source packet skb (IN), skb holding the last fragment in
+ *        the fragment stream (OUT).
+ * @xtfs: IPTFS SA state.
+ * @mtu: the max IPTFS fragment size.
+ *
+ * This function is responsible for fragmenting a larger inner packet into a
+ * sequence of IPTFS payload packets. If it needs to fragment into subsequent
+ * skb's, it will either do so by copying or cloning.
+ *
+ * The last fragment is returned rather than being sent so that the caller can
+ * append more inner packets (aggregation) if there is room.
+ *
+ */
+static int iptfs_first_skb(struct sk_buff **skbp, struct xfrm_iptfs_data *xtfs,
+			   u32 mtu)
+{
+	struct sk_buff *skb = *skbp;
+	int err;
+
+	/* Classic ESP skips the don't fragment ICMP error if DF is clear on
+	 * the inner packet or ignore_df is set. Otherwise it will send an ICMP
+	 * or local error if the inner packet won't fit it's MTU.
+	 *
+	 * With IPTFS we do not care about the inner packet DF bit. If the
+	 * tunnel is configured to "don't fragment" we error back if things
+	 * don't fit in our max packet size. Otherwise we iptfs-fragment as
+	 * normal.
+	 */
+
+	/* The opportunity for HW offload has ended */
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		err = skb_checksum_help(skb);
+		if (err)
+			return err;
+	}
+
+	/* We've split these up before queuing */
+	BUG_ON(skb_is_gso(skb));
+
+	/* Simple case -- it fits. `mtu` accounted for all the overhead
+	 * including the basic IPTFS header.
+	 */
+	if (skb->len <= mtu) {
+		iptfs_output_prepare_skb(skb, 0);
+		return 0;
+	}
+
+	if (iptfs_first_should_copy(skb, mtu))
+		return iptfs_copy_create_frags(skbp, xtfs, mtu);
+
+	/* For now we always copy */
+	return iptfs_copy_create_frags(skbp, xtfs, mtu);
+}
+
 static struct sk_buff **iptfs_rehome_fraglist(struct sk_buff **nextp,
 					      struct sk_buff *child)
 {
@@ -318,6 +634,15 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 	struct sk_buff *skb, *skb2, **nextp;
 	struct skb_shared_info *shi, *shi2;
 
+	/* If we are fragmenting due to a large inner packet we will output all
+	 * the outer IPTFS packets required to contain the fragments of the
+	 * single large inner packet. These outer packets need to be sent
+	 * consecutively (ESP seq-wise). Since this output function is always
+	 * running from a timer we do not need a lock to provide this guarantee.
+	 * We will output our packets consecutively before the timer is allowed
+	 * to run again on some other CPU.
+	 */
+
 	while ((skb = __skb_dequeue(list))) {
 		u32 mtu = iptfs_get_cur_pmtu(x, xtfs, skb);
 		bool share_ok = true;
@@ -328,7 +653,7 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 					      htons(ETH_P_IP) :
 					      htons(ETH_P_IPV6);
 
-		if (skb->len > mtu) {
+		if (skb->len > mtu && xtfs->cfg.dont_frag) {
 			/* We handle this case before enqueueing so we are only
 			 * here b/c MTU changed after we enqueued before we
 			 * dequeued, just drop these.
@@ -341,26 +666,22 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 			continue;
 		}
 
-		/* If we don't have a cksum in the packet we need to add one
-		 * before encapsulation.
+		/* Convert first inner packet into an outer IPTFS packet,
+		 * dealing with any fragmentation into multiple outer packets
+		 * if necessary.
 		 */
-		if (skb->ip_summed == CHECKSUM_PARTIAL) {
-			if (skb_checksum_help(skb)) {
-				XFRM_INC_STATS(dev_net(skb_dst(skb)->dev),
-					       LINUX_MIB_XFRMOUTERROR);
-				kfree_skb(skb);
-				continue;
-			}
-		}
-
-		/* Convert first inner packet into an outer IPTFS packet */
-		iptfs_output_prepare_skb(skb, 0);
+		if (iptfs_first_skb(&skb, xtfs, mtu))
+			continue;
 
-		/* The space remaining to send more inner packet data is `mtu` -
-		 * (skb->len - sizeof iptfs header). This is b/c the `mtu` value
-		 * has the basic IPTFS header len accounted for, and we added
-		 * that header to the skb so it is a part of skb->len, thus we
-		 * subtract it from the skb length.
+		/* If fragmentation was required the returned skb is the last
+		 * IPTFS fragment in the chain, and it's IPTFS header blkoff has
+		 * been set just past the end of the fragment data.
+		 *
+		 * In either case the space remaining to send more inner packet
+		 * data is `mtu` - (skb->len - sizeof iptfs header). This is b/c
+		 * the `mtu` value has the basic IPTFS header len accounted for,
+		 * and we added that header to the skb so it is a part of
+		 * skb->len, thus we subtract it from the skb length.
 		 */
 		remaining = mtu - (skb->len - sizeof(struct ip_iptfs_hdr));
 
@@ -601,11 +922,11 @@ static int iptfs_prepare_output(struct xfrm_state *x, struct sk_buff *skb)
 /* ========================== */
 
 /**
- * iptfs_get_inner_mtu() - return inner MTU with no fragmentation.
+ * __iptfs_get_inner_mtu() - return inner MTU with no fragmentation.
  * @x: xfrm state.
  * @outer_mtu: the outer mtu
  */
-static u32 iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu)
+static u32 __iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu)
 {
 	struct crypto_aead *aead;
 	u32 blksize;
@@ -616,6 +937,24 @@ static u32 iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu)
 		~(blksize - 1)) - 2;
 }
 
+/**
+ * iptfs_get_inner_mtu() - return the inner MTU for an IPTFS xfrm.
+ * @x: xfrm state.
+ * @outer_mtu: Outer MTU for the encapsulated packet.
+ *
+ * Return: Correct MTU taking in to account the encap overhead.
+ */
+static u32 iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu)
+{
+	struct xfrm_iptfs_data *xtfs = x->mode_data;
+
+	/* If not dont-frag we have no MTU */
+	if (!xtfs->cfg.dont_frag)
+		return x->outer_mode.family == AF_INET ? IP_MAX_MTU :
+							       IP6_MAX_MTU;
+	return __iptfs_get_inner_mtu(x, outer_mtu);
+}
+
 /**
  * iptfs_user_init() - initialize the SA with IPTFS options from netlink.
  * @net: the net data
@@ -635,6 +974,8 @@ static int iptfs_user_init(struct net *net, struct xfrm_state *x,
 	xtfs->init_delay_ns =
 		(u64)net->xfrm.sysctl_iptfs_init_delay * NSECS_IN_USEC;
 
+	if (attrs[XFRMA_IPTFS_DONT_FRAG])
+		xc->dont_frag = true;
 	if (attrs[XFRMA_IPTFS_PKT_SIZE]) {
 		xc->pkt_size = nla_get_u32(attrs[XFRMA_IPTFS_PKT_SIZE]);
 		if (!xc->pkt_size) {
@@ -666,6 +1007,8 @@ static unsigned int iptfs_sa_len(const struct xfrm_state *x)
 	unsigned int l = 0;
 
 	if (x->dir == XFRM_SA_DIR_OUT) {
+		if (xc->dont_frag)
+			l += nla_total_size(0);	  /* dont-frag flag */
 		l += nla_total_size(sizeof(u32)); /* init delay usec */
 		l += nla_total_size(sizeof(xc->max_queue_size));
 		l += nla_total_size(sizeof(xc->pkt_size));
@@ -682,6 +1025,12 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
 	u64 q;
 
 	if (x->dir == XFRM_SA_DIR_OUT) {
+		if (xc->dont_frag) {
+			ret = nla_put_flag(skb, XFRMA_IPTFS_DONT_FRAG);
+			if (ret)
+				return ret;
+		}
+
 		q = xtfs->init_delay_ns;
 		(void)do_div(q, NSECS_IN_USEC);
 		ret = nla_put_u32(skb, XFRMA_IPTFS_INIT_DELAY, q);
-- 
2.45.2


