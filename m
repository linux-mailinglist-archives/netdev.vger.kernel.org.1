Return-Path: <netdev+bounces-156612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88676A07231
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D425F7A272C
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91134218827;
	Thu,  9 Jan 2025 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="dlbEWGgV"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22728217F54
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736416147; cv=none; b=PDOg/l6n4brToSChoPP0I4EO0TPCKg5PsCVdVcvoKt4sTN78IJksc5PyNTm/FivVB0VKA7Qj2fclIKovCKioG2fx6njP4/vkvGk+SkqsC0DobuYEIAhqs4gTDYHGbCDLVdJ7jPRSzpCfpnlkGDQZGuioXQz0I4NER4GpG9Yme1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736416147; c=relaxed/simple;
	bh=+VZoDYUn1MtvPJIO2orVCSFHymrE4FQy5tBCba9igV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrAxfokch21UoMOZ98lslOVIVk+WX9z/WAubs6wU5uPiBQtUMX4GtgTes8jBfaEz+Bb1IZ5dDnHerG0+mDs6sWzBm8pgYGCrRolSsYZG9oFM5qcz8fqnJGa5DV84DPIisJD+PgqLh+tNSKe5/dLd92LyXQMJzo8GZkn0kM/AXSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=dlbEWGgV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 88DED20868;
	Thu,  9 Jan 2025 10:49:01 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YNirI9QR2VY2; Thu,  9 Jan 2025 10:49:00 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C93C52088F;
	Thu,  9 Jan 2025 10:48:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C93C52088F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1736416137;
	bh=H6msWwNHJiBz4Yo5fuY+2M5xRCRX1+BwsjIRyXXZUj4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=dlbEWGgVrVL/bVEKKjOWPJqOWhfiNAc8oBOxBuB39Whis326CLUU/olM6spCaVxe/
	 drGAD737IhpEPQXuG4w26IZuFlS0CGjpTYyzTyWCbPLbD/e6QKwYLmhywVcIG5EMRY
	 ZYKTlJVCOGzV4SOwYWT9+yfhUQjrUtYlHkShFfDKZaLE8hDk/KVy5pzgrFHPCsGfdF
	 czSAGvyp9TYtBl89P91qCYDFfNsbLOt4FhFJWKTPhSTkwMYiPfuQFwA50+8DT6K8oq
	 BTK+usVI7l2QGFggL+qzVn8v47EgicDbQYkH7KvxvrN1oesobRRGeKn/UvIkehYwS2
	 tTq9Yfjc25J+A==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 9 Jan 2025 10:48:57 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 10:48:56 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id AEFDF31841B0; Thu,  9 Jan 2025 10:43:29 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 13/17] xfrm: iptfs: add skb-fragment sharing code
Date: Thu, 9 Jan 2025 10:43:17 +0100
Message-ID: <20250109094321.2268124-14-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109094321.2268124-1-steffen.klassert@secunet.com>
References: <20250109094321.2268124-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Christian Hopps <chopps@labn.net>

Avoid copying the inner packet data by sharing the skb data fragments
from the output packet skb into new inner packet skb.

Signed-off-by: Christian Hopps <chopps@labn.net>
Tested-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_iptfs.c | 296 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 290 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 8538fb02ae8a..1258158e57ba 100644
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
@@ -234,10 +237,254 @@ static void iptfs_skb_head_to_frag(const struct sk_buff *skb, skb_frag_t *frag)
 	skb_frag_fill_page_desc(frag, page, skb->data - addr, skb_headlen(skb));
 }
 
+/**
+ * struct iptfs_skb_frag_walk - use to track a walk through fragments
+ * @fragi: current fragment index
+ * @past: length of data in fragments before @fragi
+ * @total: length of data in all fragments
+ * @nr_frags: number of fragments present in array
+ * @initial_offset: the value passed in to skb_prepare_frag_walk()
+ * @frags: the page fragments inc. room for head page
+ * @pp_recycle: copy of skb->pp_recycle
+ */
+struct iptfs_skb_frag_walk {
+	u32 fragi;
+	u32 past;
+	u32 total;
+	u32 nr_frags;
+	u32 initial_offset;
+	skb_frag_t frags[MAX_SKB_FRAGS + 1];
+	bool pp_recycle;
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
+}
+
+static u32 iptfs_skb_reset_frag_walk(struct iptfs_skb_frag_walk *walk,
+				     u32 offset)
+{
+	/* Adjust offset to refer to internal walk values */
+	offset -= walk->initial_offset;
+
+	/* Get to the correct fragment for offset */
+	while (offset < walk->past) {
+		walk->past -= walk->frags[--walk->fragi].len;
+		if (offset >= walk->past)
+			break;
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
+	if (!walk->nr_frags || offset >= walk->total + walk->initial_offset)
+		return len;
+
+	/* make offset relative to current frag after setting that */
+	offset = iptfs_skb_reset_frag_walk(walk, offset);
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
@@ -423,6 +670,8 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
 			      struct skb_seq_state *st, struct sk_buff *skb,
 			      u32 data, u32 blkoff, struct list_head *list)
 {
+	struct iptfs_skb_frag_walk _fragwalk;
+	struct iptfs_skb_frag_walk *fragwalk = NULL;
 	struct sk_buff *newskb = xtfs->ra_newskb;
 	u32 remaining = skb->len - data;
 	u32 runtlen = xtfs->ra_runtlen;
@@ -567,10 +816,26 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
 	fraglen = min(blkoff, remaining);
 	copylen = min(fraglen, ipremain);
 
-	/* copy fragment data into newskb */
-	if (skb_copy_seq_read(st, data, skb_put(newskb, copylen), copylen)) {
-		XFRM_INC_STATS(dev_net(skb->dev), LINUX_MIB_XFRMINBUFFERERROR);
-		goto abandon;
+	/* If we may have the opportunity to share prepare a fragwalk. */
+	if (!skb_has_frag_list(skb) && !skb_has_frag_list(newskb) &&
+	    (skb->head_frag || skb->len == skb->data_len) &&
+	    skb->pp_recycle == newskb->pp_recycle) {
+		fragwalk = &_fragwalk;
+		iptfs_skb_prepare_frag_walk(skb, data, fragwalk);
+	}
+
+	/* Try share then copy. */
+	if (fragwalk &&
+	    iptfs_skb_can_add_frags(newskb, fragwalk, data, copylen)) {
+		iptfs_skb_add_frags(newskb, fragwalk, data, copylen);
+	} else {
+		/* copy fragment data into newskb */
+		if (skb_copy_seq_read(st, data, skb_put(newskb, copylen),
+				      copylen)) {
+			XFRM_INC_STATS(xs_net(xtfs->x),
+				       LINUX_MIB_XFRMINBUFFERERROR);
+			goto abandon;
+		}
 	}
 
 	if (copylen < ipremain) {
@@ -601,6 +866,8 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 				    struct list_head *sublist)
 {
 	u8 hbytes[sizeof(struct ipv6hdr)];
+	struct iptfs_skb_frag_walk _fragwalk;
+	struct iptfs_skb_frag_walk *fragwalk = NULL;
 	struct sk_buff *defer, *first_skb, *next, *skb;
 	const unsigned char *old_mac;
 	struct xfrm_iptfs_data *xtfs;
@@ -694,6 +961,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 		} else {
 			first_skb = skb;
 			first_iplen = iplen;
+			fragwalk = NULL;
 
 			/* We are going to skip over `data` bytes to reach the
 			 * start of the IP header of `iphlen` len for `iplen`
@@ -745,6 +1013,13 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 				/* all pointers could be changed now reset walk */
 				skb_abort_seq_read(skbseq);
 				skb_prepare_seq_read(skb, data, tail, skbseq);
+			} else if (skb->head_frag &&
+				   /* We have the IP header right now */
+				   remaining >= iphlen) {
+				fragwalk = &_fragwalk;
+				iptfs_skb_prepare_frag_walk(skb, data, fragwalk);
+				defer = skb;
+				skb = NULL;
 			} else {
 				/* We couldn't reuse the input skb so allocate a
 				 * new one.
@@ -760,8 +1035,17 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 
 		capturelen = min(iplen, remaining);
 		if (!skb) {
-			skb = iptfs_pskb_extract_seq(iplen, skbseq, data,
-						     capturelen);
+			if (!fragwalk ||
+			    /* Large enough to be worth sharing */
+			    iplen < IPTFS_PKT_SHARE_MIN ||
+			    /* Have IP header + some data to share. */
+			    capturelen <= iphlen ||
+			    /* Try creating skb and adding frags */
+			    !(skb = iptfs_pskb_add_frags(first_skb, fragwalk,
+							 data, capturelen,
+							 skbseq, iphlen))) {
+				skb = iptfs_pskb_extract_seq(iplen, skbseq, data, capturelen);
+			}
 			if (!skb) {
 				/* skip to next packet or done */
 				data += capturelen;
-- 
2.34.1


