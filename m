Return-Path: <netdev+bounces-126167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E8696FF3C
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 04:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1552862DA
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 02:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0026749634;
	Sat,  7 Sep 2024 02:24:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5DC43AA8
	for <netdev@vger.kernel.org>; Sat,  7 Sep 2024 02:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725675890; cv=none; b=lDbWXck0KoceFPqhSlHTCMh6/0kGcg9JrE+XSNSbXvTAB2j4uG508V+rGn2UAxnywfXVZoTSVy2sALsIIIu+LTYxKJBSHxFQLyeaBBcDXHos2oGQ0eJHFNjQ1Dg5u7vzZUcDnPtM6Yujfy7s/arVoSXqspko4OKnfJCVtx9vGcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725675890; c=relaxed/simple;
	bh=WGReoeoiNY+dQrt0r/10rBPiehRHiPsz+W3h7J3fooo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aI/XZuBELXRFc7LrCld53ldLg1M4ude4FXIxgZtIe8EdEx+R8kJmgAi20NqG5ayOs7uXjNMMbP62fNBhRFnBERb9ZSg82MWVtm/900xCJcKW61KX4PyGtNivk9KUkxQK/cDVqSpclD5xB4j0Eg0xZOHgf/F0HSg6fWhBhCUTDM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id A8ADE7D126;
	Sat,  7 Sep 2024 02:24:48 +0000 (UTC)
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
Subject: [PATCH ipsec-next v11 14/16] xfrm: iptfs: add skb-fragment sharing code
Date: Fri,  6 Sep 2024 22:24:10 -0400
Message-ID: <20240907022412.1032284-15-chopps@chopps.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240907022412.1032284-1-chopps@chopps.org>
References: <20240907022412.1032284-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Avoid copying the inner packet data by sharing the skb data fragments
from the output packet skb into new inner packet skb.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 net/xfrm/xfrm_iptfs.c | 312 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 304 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 98ff553cd535..b152c6466ebb 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -81,6 +81,9 @@
 #define XFRM_IPTFS_MIN_L3HEADROOM 128
 #define XFRM_IPTFS_MIN_L2HEADROOM (L1_CACHE_BYTES > 64 ? 64 : 64 + 16)
 
+/* Min to try to share outer iptfs skb data vs copying into new skb */
+#define IPTFS_PKT_SHARE_MIN 129
+
 #define NSECS_IN_USEC 1000
 
 #define IPTFS_HRTIMER_MODE HRTIMER_MODE_REL_SOFT
@@ -236,10 +239,261 @@ static void iptfs_skb_head_to_frag(const struct sk_buff *skb, skb_frag_t *frag)
 	skb_frag_fill_page_desc(frag, page, skb->data - addr, skb_headlen(skb));
 }
 
+/**
+ * struct iptfs_skb_frag_walk - use to track a walk through fragments
+ * @fragi: current fragment index
+ * @past: length of data in fragments before @fragi
+ * @total: length of data in all fragments
+ * @nr_frags: number of fragments present in array
+ * @initial_offset: the value passed in to skb_prepare_frag_walk()
+ * @pp_recycle: copy of skb->pp_recycle
+ * @frags: the page fragments inc. room for head page
+ */
+struct iptfs_skb_frag_walk {
+	u32 fragi;
+	u32 past;
+	u32 total;
+	u32 nr_frags;
+	u32 initial_offset;
+	bool pp_recycle;
+	skb_frag_t frags[MAX_SKB_FRAGS + 1];
+};
+
+/**
+ * iptfs_skb_prepare_frag_walk() - initialize a frag walk over an skb.
+ * @skb: the skb to walk.
+ * @initial_offset: start the walk @initial_offset into the skb.
+ * @walk: the walk to initialize
+ *
+ * Future calls to skb_add_frags() will expect the @offset value to be at
+ * least @initial_offset large.
+ */
+static void iptfs_skb_prepare_frag_walk(struct sk_buff *skb, u32 initial_offset,
+					struct iptfs_skb_frag_walk *walk)
+{
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
+	skb_frag_t *frag, *from;
+	u32 i;
+
+	walk->initial_offset = initial_offset;
+	walk->fragi = 0;
+	walk->past = 0;
+	walk->total = 0;
+	walk->nr_frags = 0;
+	walk->pp_recycle = skb->pp_recycle;
+
+	if (skb->head_frag) {
+		if (initial_offset >= skb_headlen(skb)) {
+			initial_offset -= skb_headlen(skb);
+		} else {
+			frag = &walk->frags[walk->nr_frags++];
+			iptfs_skb_head_to_frag(skb, frag);
+			frag->offset += initial_offset;
+			frag->len -= initial_offset;
+			walk->total += frag->len;
+			initial_offset = 0;
+		}
+	} else {
+		WARN_ON_ONCE(skb_headlen(skb) > initial_offset);
+		initial_offset -= skb_headlen(skb);
+	}
+
+	for (i = 0; i < shinfo->nr_frags; i++) {
+		from = &shinfo->frags[i];
+		if (initial_offset >= from->len) {
+			initial_offset -= from->len;
+			continue;
+		}
+		frag = &walk->frags[walk->nr_frags++];
+		*frag = *from;
+		if (initial_offset) {
+			frag->offset += initial_offset;
+			frag->len -= initial_offset;
+			initial_offset = 0;
+		}
+		walk->total += frag->len;
+	}
+	WARN_ON_ONCE(initial_offset != 0);
+}
+
+static u32 iptfs_skb_reset_frag_walk(struct iptfs_skb_frag_walk *walk,
+				     u32 offset)
+{
+	/* Adjust offset to refer to internal walk values */
+	WARN_ON_ONCE(offset < walk->initial_offset);
+	offset -= walk->initial_offset;
+
+	/* Get to the correct fragment for offset */
+	while (offset < walk->past) {
+		walk->past -= walk->frags[--walk->fragi].len;
+		if (offset >= walk->past)
+			break;
+		WARN_ON_ONCE(walk->fragi == 0);
+	}
+	while (offset >= walk->past + walk->frags[walk->fragi].len)
+		walk->past += walk->frags[walk->fragi++].len;
+
+	/* offset now relative to this current frag */
+	offset -= walk->past;
+	return offset;
+}
+
+/**
+ * iptfs_skb_can_add_frags() - check if ok to add frags from walk to skb
+ * @skb: skb to check for adding frags to
+ * @walk: the walk that will be used as source for frags.
+ * @offset: offset from beginning of original skb to start from.
+ * @len: amount of data to add frag references to in @skb.
+ *
+ * Return: true if ok to add frags.
+ */
+static bool iptfs_skb_can_add_frags(const struct sk_buff *skb,
+				    struct iptfs_skb_frag_walk *walk,
+				    u32 offset, u32 len)
+{
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
+	u32 fragi, nr_frags, fraglen;
+
+	if (skb_has_frag_list(skb) || skb->pp_recycle != walk->pp_recycle)
+		return false;
+
+	/* Make offset relative to current frag after setting that */
+	offset = iptfs_skb_reset_frag_walk(walk, offset);
+
+	/* Verify we have array space for the fragments we need to add */
+	fragi = walk->fragi;
+	nr_frags = shinfo->nr_frags;
+	while (len && fragi < walk->nr_frags) {
+		skb_frag_t *frag = &walk->frags[fragi];
+
+		fraglen = frag->len;
+		if (offset) {
+			fraglen -= offset;
+			offset = 0;
+		}
+		if (++nr_frags > MAX_SKB_FRAGS)
+			return false;
+		if (len <= fraglen)
+			return true;
+		len -= fraglen;
+		fragi++;
+	}
+	/* We may not copy all @len but what we have will fit. */
+	return true;
+}
+
+/**
+ * iptfs_skb_add_frags() - add a range of fragment references into an skb
+ * @skb: skb to add references into
+ * @walk: the walk to add referenced fragments from.
+ * @offset: offset from beginning of original skb to start from.
+ * @len: amount of data to add frag references to in @skb.
+ *
+ * iptfs_skb_can_add_frags() should be called before this function to verify
+ * that the destination @skb is compatible with the walk and has space in the
+ * array for the to be added frag references.
+ *
+ * Return: The number of bytes not added to @skb b/c we reached the end of the
+ * walk before adding all of @len.
+ */
+static int iptfs_skb_add_frags(struct sk_buff *skb,
+			       struct iptfs_skb_frag_walk *walk, u32 offset,
+			       u32 len)
+{
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
+	u32 fraglen;
+
+	WARN_ON_ONCE(skb->pp_recycle != walk->pp_recycle);
+	if (!walk->nr_frags || offset >= walk->total + walk->initial_offset)
+		return len;
+
+	/* make offset relative to current frag after setting that */
+	offset = iptfs_skb_reset_frag_walk(walk, offset);
+	WARN_ON_ONCE(shinfo->nr_frags >= MAX_SKB_FRAGS);
+
+	while (len && walk->fragi < walk->nr_frags) {
+		skb_frag_t *frag = &walk->frags[walk->fragi];
+		skb_frag_t *tofrag = &shinfo->frags[shinfo->nr_frags];
+
+		*tofrag = *frag;
+		if (offset) {
+			tofrag->offset += offset;
+			tofrag->len -= offset;
+			offset = 0;
+		}
+		__skb_frag_ref(tofrag);
+		shinfo->nr_frags++;
+		WARN_ON_ONCE(shinfo->nr_frags > MAX_SKB_FRAGS);
+
+		/* see if we are done */
+		fraglen = tofrag->len;
+		if (len < fraglen) {
+			tofrag->len = len;
+			skb->len += len;
+			skb->data_len += len;
+			return 0;
+		}
+		/* advance to next source fragment */
+		len -= fraglen;			/* careful, use dst bv_len */
+		skb->len += fraglen;		/* careful, "   "    "     */
+		skb->data_len += fraglen;	/* careful, "   "    "     */
+		walk->past += frag->len;	/* careful, use src bv_len */
+		walk->fragi++;
+	}
+	return len;
+}
+
 /* ================================== */
 /* IPTFS Receiving (egress) Functions */
 /* ================================== */
 
+/**
+ * iptfs_pskb_add_frags() - Create and add frags into a new sk_buff.
+ * @tpl: template to create new skb from.
+ * @walk: The source for fragments to add.
+ * @off: The offset into @walk to add frags from, also used with @st and
+ *       @copy_len.
+ * @len: The length of data to add covering frags from @walk into @skb.
+ *       This must be <= @skblen.
+ * @st: The sequence state to copy from into the new head skb.
+ * @copy_len: Copy @copy_len bytes from @st at offset @off into the new skb
+ *            linear space.
+ *
+ * Create a new sk_buff `skb` using the template @tpl. Copy @copy_len bytes from
+ * @st into the new skb linear space, and then add shared fragments from the
+ * frag walk for the remaining @len of data (i.e., @len - @copy_len bytes).
+ *
+ * Return: The newly allocated sk_buff `skb` or NULL if an error occurs.
+ */
+static struct sk_buff *
+iptfs_pskb_add_frags(struct sk_buff *tpl, struct iptfs_skb_frag_walk *walk,
+		     u32 off, u32 len, struct skb_seq_state *st, u32 copy_len)
+{
+	struct sk_buff *skb;
+
+	skb = iptfs_alloc_skb(tpl, copy_len, false);
+	if (!skb)
+		return NULL;
+
+	/* this should not normally be happening */
+	if (!iptfs_skb_can_add_frags(skb, walk, off + copy_len,
+				     len - copy_len)) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	if (copy_len &&
+	    skb_copy_seq_read(st, off, skb_put(skb, copy_len), copy_len)) {
+		XFRM_INC_STATS(dev_net(st->root_skb->dev),
+			       LINUX_MIB_XFRMINERROR);
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	iptfs_skb_add_frags(skb, walk, off + copy_len, len - copy_len);
+	return skb;
+}
+
 /**
  * iptfs_pskb_extract_seq() - Create and load data into a new sk_buff.
  * @skblen: the total data size for `skb`.
@@ -430,6 +684,8 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
 			      struct skb_seq_state *st, struct sk_buff *skb,
 			      u32 data, u32 blkoff, struct list_head *list)
 {
+	struct iptfs_skb_frag_walk _fragwalk;
+	struct iptfs_skb_frag_walk *fragwalk = NULL;
 	struct sk_buff *newskb = xtfs->ra_newskb;
 	u32 remaining = skb->len - data;
 	u32 runtlen = xtfs->ra_runtlen;
@@ -582,13 +838,32 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
 	fraglen = min(blkoff, remaining);
 	copylen = min(fraglen, ipremain);
 
-	/* We verified this was true in the main receive routine */
-	WARN_ON_ONCE(skb_tailroom(newskb) < copylen);
+	/* If we may have the opportunity to share prepare a fragwalk. */
+	if (!skb_has_frag_list(skb) && !skb_has_frag_list(newskb) &&
+	    (skb->head_frag || skb->len == skb->data_len) &&
+	    skb->pp_recycle == newskb->pp_recycle) {
+		fragwalk = &_fragwalk;
+		iptfs_skb_prepare_frag_walk(skb, data, fragwalk);
+	}
 
-	/* copy fragment data into newskb */
-	if (skb_copy_seq_read(st, data, skb_put(newskb, copylen), copylen)) {
-		XFRM_INC_STATS(dev_net(skb->dev), LINUX_MIB_XFRMINBUFFERERROR);
-		goto abandon;
+	/* Try share then copy. */
+	if (fragwalk &&
+	    iptfs_skb_can_add_frags(newskb, fragwalk, data, copylen)) {
+		u32 leftover;
+
+		leftover = iptfs_skb_add_frags(newskb, fragwalk, data, copylen);
+		WARN_ON_ONCE(leftover != 0);
+	} else {
+		/* We verified this was true in the main receive routine */
+		WARN_ON_ONCE(skb_tailroom(newskb) < copylen);
+
+		/* copy fragment data into newskb */
+		if (skb_copy_seq_read(st, data, skb_put(newskb, copylen),
+				      copylen)) {
+			XFRM_INC_STATS(xs_net(xtfs->x),
+				       LINUX_MIB_XFRMINBUFFERERROR);
+			goto abandon;
+		}
 	}
 
 	if (copylen < ipremain) {
@@ -629,6 +904,8 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 	u8 hbytes[sizeof(struct ipv6hdr)];
 	struct ip_iptfs_cc_hdr iptcch;
 	struct skb_seq_state skbseq;
+	struct iptfs_skb_frag_walk _fragwalk;
+	struct iptfs_skb_frag_walk *fragwalk = NULL;
 	struct list_head sublist; /* rename this it's just a list */
 	struct sk_buff *first_skb, *defer, *next;
 	const unsigned char *old_mac;
@@ -775,6 +1052,7 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 		} else {
 			first_skb = skb;
 			first_iplen = iplen;
+			fragwalk = NULL;
 
 			/* We are going to skip over `data` bytes to reach the
 			 * start of the IP header of `iphlen` len for `iplen`
@@ -826,6 +1104,14 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 				/* all pointers could be changed now reset walk */
 				skb_abort_seq_read(&skbseq);
 				skb_prepare_seq_read(skb, data, tail, &skbseq);
+			} else if (skb->head_frag &&
+				   /* We have the IP header right now */
+				   remaining >= iphlen) {
+				fragwalk = &_fragwalk;
+				iptfs_skb_prepare_frag_walk(skb, data,
+							    fragwalk);
+				defer = skb;
+				skb = NULL;
 			} else {
 				/* We couldn't reuse the input skb so allocate a
 				 * new one.
@@ -841,8 +1127,18 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 
 		capturelen = min(iplen, remaining);
 		if (!skb) {
-			skb = iptfs_pskb_extract_seq(iplen, &skbseq, data,
-						     capturelen);
+			if (!fragwalk ||
+			    /* Large enough to be worth sharing */
+			    iplen < IPTFS_PKT_SHARE_MIN ||
+			    /* Have IP header + some data to share. */
+			    capturelen <= iphlen ||
+			    /* Try creating skb and adding frags */
+			    !(skb = iptfs_pskb_add_frags(first_skb, fragwalk,
+							 data, capturelen,
+							 &skbseq, iphlen))) {
+				skb = iptfs_pskb_extract_seq(iplen, &skbseq,
+							     data, capturelen);
+			}
 			if (!skb) {
 				/* skip to next packet or done */
 				data += capturelen;
-- 
2.46.0


