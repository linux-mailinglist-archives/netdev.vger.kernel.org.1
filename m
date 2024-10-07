Return-Path: <netdev+bounces-132716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A2E992E1D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9A01F2191B
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3CA1D7E5C;
	Mon,  7 Oct 2024 13:59:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DC21D5CDD
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309597; cv=none; b=RlcRK7zXfzXIegvnpN0yJqejNxrFCnhpJu+Ebj/w062Pi7PoY6JOMD3aJGaAFcLutrO2CUBFG3EmaNvnkEZRfhpktMMb1C+wU+T4K1R9SIhxYCbj+X0lgkVrYC9lcnwagr3clxdLnXJXByDHoQfBykaERTh2IXAGxfl126xvSus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309597; c=relaxed/simple;
	bh=fASgLa4RpK/nUyaGfQaQVWorPo8ejMvZm8vSqlxU+Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+zY46Yd43BAk8vxON59CWAxyyvlNp+krYv348L4b8M2Z/zuqsSmoFliuzOV9tIWU2IZIR1PtOgRpzXL94O7GTiW+bfibZtepb68u5TmIXwqtF8tve2XQuSQWoPeNRry6Sz4K2AA2lIawcO122nVRA55Yeid05fAISOSz+0ov6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 413527D1D6;
	Mon,  7 Oct 2024 13:59:51 +0000 (UTC)
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
Subject: [PATCH ipsec-next v12 10/16] xfrm: iptfs: add fragmenting of larger than MTU user packets
Date: Mon,  7 Oct 2024 09:59:22 -0400
Message-ID: <20241007135928.1218955-11-chopps@chopps.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241007135928.1218955-1-chopps@chopps.org>
References: <20241007135928.1218955-1-chopps@chopps.org>
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
 net/xfrm/xfrm_iptfs.c | 350 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 321 insertions(+), 29 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 627b10ed4db0..7343ed77160c 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -46,12 +46,29 @@
  */
 #define IPTFS_DEFAULT_MAX_QUEUE_SIZE	(1024 * 10240)
 
+/* Assumed: skb->head is cache aligned.
+ *
+ * L2 Header resv: Arrange for cacheline to start at skb->data - 16 to keep the
+ * to-be-pushed L2 header in the same cacheline as resulting `skb->data` (i.e.,
+ * the L3 header). If cacheline size is > 64 then skb->data + pushed L2 will all
+ * be in a single cacheline if we simply reserve 64 bytes.
+ *
+ * L3 Header resv: For L3+L2 headers (i.e., skb->data points at the IPTFS payload)
+ * we want `skb->data` to be cacheline aligned and all pushed L2L3 headers will
+ * be in their own cacheline[s]. 128 works for cachelins up to 128 bytes, for
+ * any larger cacheline sizes the pushed headers will simply share the cacheline
+ * with the start of the IPTFS payload (skb->data).
+ */
+#define XFRM_IPTFS_MIN_L3HEADROOM 128
+#define XFRM_IPTFS_MIN_L2HEADROOM (L1_CACHE_BYTES > 64 ? 64 : 64 + 16)
+
 #define NSECS_IN_USEC 1000
 
 #define IPTFS_HRTIMER_MODE HRTIMER_MODE_REL_SOFT
 
 /**
  * struct xfrm_iptfs_config - configuration for the IPTFS tunnel.
+ * @dont_frag: true to inhibit fragmenting across IPTFS outer packets.
  * @pkt_size: size of the outer IP packet. 0 to use interface and MTU discovery,
  *	otherwise the user specified value.
  * @max_queue_size: The maximum number of octets allowed to be queued to be sent
@@ -59,6 +76,7 @@
  *	packets enqueued.
  */
 struct xfrm_iptfs_config {
+	bool dont_frag : 1;
 	u32 pkt_size;	    /* outer_packet_size or 0 */
 	u32 max_queue_size; /* octets */
 };
@@ -88,13 +106,73 @@ struct xfrm_iptfs_data {
 	u32 payload_mtu;	    /* max payload size */
 };
 
-static u32 iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu);
+static u32 __iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu);
 static enum hrtimer_restart iptfs_delay_timer(struct hrtimer *me);
 
 /* ======================= */
 /* IPTFS SK_BUFF Functions */
 /* ======================= */
 
+/**
+ * iptfs_alloc_skb() - Allocate a new `skb`.
+ * @tpl: the skb to copy required meta-data from.
+ * @len: the linear length of the head data, zero is fine.
+ * @l3resv: true if skb reserve needs to support pushing L3 headers
+ *
+ * A new `skb` is allocated and required meta-data is copied from `tpl`, the
+ * head data is sized to `len` + reserved space set according to the @l3resv
+ * boolean.
+ *
+ * When @l3resv is false, resv is XFRM_IPTFS_MIN_L2HEADROOM which arranges for
+ * `skb->data - 16`  which is a good guess for good cache alignment (placing the
+ * to be pushed L2 header at the start of a cacheline.
+ *
+ * Otherwise, @l3resv is true and resv is set to the correct reserved space for
+ * dst->dev plus the calculated L3 overhead for the xfrm dst or
+ * XFRM_IPTFS_MIN_L3HEADROOM whichever is larger. This is then cache aligned so
+ * that all the headers will commonly fall in a cacheline when possible.
+ *
+ * l3resv=true is used on tunnel ingress (tx), because we need to reserve for
+ * the new IPTFS packet (i.e., L2+L3 headers). On tunnel egress (rx) the data
+ * being copied into the skb includes the user L3 headers already so we only
+ * need to reserve for L2.
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
+		struct dst_entry *dst = skb_dst(tpl);
+
+		resv = LL_RESERVED_SPACE(dst->dev) + dst->header_len;
+		resv = max(resv, XFRM_IPTFS_MIN_L3HEADROOM);
+		resv = L1_CACHE_ALIGN(resv);
+	}
+
+	skb = alloc_skb(len + resv, GFP_ATOMIC | __GFP_NOWARN);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, resv);
+
+	if (!l3resv) {
+		/* xfrm_input resume needs dev and xfrm ext from tunnel pkt */
+		skb->dev = tpl->dev;
+		__skb_ext_copy(skb, tpl);
+	}
+
+	/* dropped by xfrm_input, used by xfrm_output */
+	skb_dst_copy(skb, tpl);
+
+	return skb;
+}
+
 /**
  * iptfs_skb_head_to_frag() - initialize a skb_frag_t based on skb head data
  * @skb: skb with the head data
@@ -153,7 +231,7 @@ static int iptfs_get_cur_pmtu(struct xfrm_state *x,
 {
 	struct xfrm_dst *xdst = (struct xfrm_dst *)skb_dst(skb);
 	u32 payload_mtu = xtfs->payload_mtu;
-	u32 pmtu = iptfs_get_inner_mtu(x, xdst->child_mtu_cached);
+	u32 pmtu = __iptfs_get_inner_mtu(x, xdst->child_mtu_cached);
 
 	if (payload_mtu && payload_mtu < pmtu)
 		pmtu = payload_mtu;
@@ -216,7 +294,8 @@ static int iptfs_output_collect(struct net *net, struct sock *sk,
 
 	WARN_ON_ONCE(!xtfs);
 
-	pmtu = iptfs_get_cur_pmtu(x, xtfs, skb);
+	if (xtfs->cfg.dont_frag)
+		pmtu = iptfs_get_cur_pmtu(x, xtfs, skb);
 
 	/* Break apart GSO skbs. If the queue is nearing full then we want the
 	 * accounting and queuing to be based on the individual packets not on the
@@ -256,8 +335,10 @@ static int iptfs_output_collect(struct net *net, struct sock *sk,
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
@@ -301,6 +382,186 @@ static void iptfs_output_prepare_skb(struct sk_buff *skb, u32 blkoff)
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
+	err = skb_copy_seq_read(st, offset, skb_put(skb, copy_len), copy_len);
+	if (err) {
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
+ *
+ * Return: 0 on success or a negative error code on failure
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
+	int err = 0;
+
+	INIT_LIST_HEAD(&sublist);
+
+	WARN_ON_ONCE(skb->len <= mtu);
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
+		copy_len = min(to_copy, mtu);
+		nskb = iptfs_copy_create_frag(&skbseq, offset, copy_len);
+		if (IS_ERR(nskb)) {
+			XFRM_INC_STATS(xs_net(xtfs->x), LINUX_MIB_XFRMOUTERROR);
+			skb_abort_seq_read(&skbseq);
+			err = PTR_ERR(nskb);
+			nskb = NULL;
+			break;
+		}
+		iptfs_output_prepare_skb(nskb, to_copy);
+		offset += copy_len;
+		to_copy -= copy_len;
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
+ * iptfs_first_skb() - handle the first dequeued inner packet for output
+ * @skbp: the source packet skb (IN), skb holding the last fragment in
+ *        the fragment stream (OUT).
+ * @xtfs: IPTFS SA state.
+ * @mtu: the max IPTFS fragment size.
+ *
+ * This function is responsible for fragmenting a larger inner packet into a
+ * sequence of IPTFS payload packets.
+ *
+ * The last fragment is returned rather than being sent so that the caller can
+ * append more inner packets (aggregation) if there is room.
+ *
+ * Return: 0 on success or a negative error code on failure
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
+	WARN_ON_ONCE(skb_is_gso(skb));
+
+	/* Consider the buffer Tx'd and no longer owned */
+	skb_orphan(skb);
+
+	/* Simple case -- it fits. `mtu` accounted for all the overhead
+	 * including the basic IPTFS header.
+	 */
+	if (skb->len <= mtu) {
+		iptfs_output_prepare_skb(skb, 0);
+		return 0;
+	}
+
+	return iptfs_copy_create_frags(skbp, xtfs, mtu);
+}
+
 static struct sk_buff **iptfs_rehome_fraglist(struct sk_buff **nextp,
 					      struct sk_buff *child)
 {
@@ -360,6 +621,15 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
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
@@ -370,7 +640,7 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 					htons(ETH_P_IP) :
 					htons(ETH_P_IPV6);
 
-		if (skb->len > mtu) {
+		if (skb->len > mtu && xtfs->cfg.dont_frag) {
 			/* We handle this case before enqueueing so we are only
 			 * here b/c MTU changed after we enqueued before we
 			 * dequeued, just drop these.
@@ -381,29 +651,22 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
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
-		/* Consider the buffer Tx'd and no longer owned */
-		skb_orphan(skb);
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
 
@@ -649,11 +912,13 @@ static int iptfs_prepare_output(struct xfrm_state *x, struct sk_buff *skb)
 /* ========================== */
 
 /**
- * iptfs_get_inner_mtu() - return inner MTU with no fragmentation.
+ * __iptfs_get_inner_mtu() - return inner MTU with no fragmentation.
  * @x: xfrm state.
  * @outer_mtu: the outer mtu
+ *
+ * Return: Correct MTU taking in to account the encap overhead.
  */
-static u32 iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu)
+static u32 __iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu)
 {
 	struct crypto_aead *aead;
 	u32 blksize;
@@ -664,6 +929,23 @@ static u32 iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu)
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
+		return x->outer_mode.family == AF_INET ? IP_MAX_MTU : IP6_MAX_MTU;
+	return __iptfs_get_inner_mtu(x, outer_mtu);
+}
+
 /**
  * iptfs_user_init() - initialize the SA with IPTFS options from netlink.
  * @net: the net data
@@ -685,6 +967,8 @@ static int iptfs_user_init(struct net *net, struct xfrm_state *x,
 	xc->max_queue_size = IPTFS_DEFAULT_MAX_QUEUE_SIZE;
 	xtfs->init_delay_ns = IPTFS_DEFAULT_INIT_DELAY_USECS * NSECS_IN_USEC;
 
+	if (attrs[XFRMA_IPTFS_DONT_FRAG])
+		xc->dont_frag = true;
 	if (attrs[XFRMA_IPTFS_PKT_SIZE]) {
 		xc->pkt_size = nla_get_u32(attrs[XFRMA_IPTFS_PKT_SIZE]);
 		if (!xc->pkt_size) {
@@ -718,6 +1002,8 @@ static unsigned int iptfs_sa_len(const struct xfrm_state *x)
 	unsigned int l = 0;
 
 	if (x->dir == XFRM_SA_DIR_OUT) {
+		if (xc->dont_frag)
+			l += nla_total_size(0);	  /* dont-frag flag */
 		l += nla_total_size(sizeof(u32)); /* init delay usec */
 		l += nla_total_size(sizeof(xc->max_queue_size));
 		l += nla_total_size(sizeof(xc->pkt_size));
@@ -734,6 +1020,12 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
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
2.46.0


