Return-Path: <netdev+bounces-78193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25D18744D4
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E4028475E
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE661D545;
	Wed,  6 Mar 2024 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ztbWNPcz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C813B1CF80
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769571; cv=none; b=IrYr8W4vJHf/S7VnHJJ6ZRX/iVeI/wmYEI51NQ+1ATW/rEz4rC8Gy8dB0epE56e8cj+zrohQsx6qVLAgKG8jidGfS+y9tmAZq1PaF/8e2a6dFM0jxJU4susvYPzvaNDN5SxVW4WiUPYe8wQ6GIWaYIvmily7ViP2LtCamt32TqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769571; c=relaxed/simple;
	bh=khDX1NqsTJ9RPOY9O4VL8crdpbXjnQtyVbhkxavyF4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nt9v23AGYCTCzwZ2kkK+JbFEVFDQ0h5KEpn7j/RfU3PiScUXZK/kSl/lh6MbMiRLm4VLex0IPyYNNE3KYVMjfZwOpdRwpI0K8n5jF8NHz4o1pqQWkmrm7yDebxQ3h/f+M6jnt2A51jO8wTvtdxRplwHmakNqTYOu+vUhDTQeS0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ztbWNPcz; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso376230276.3
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 15:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709769569; x=1710374369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bsusLBjAmN/j7GjAiSGCt1oC9MYmKOkLL/UwY6A5Vuw=;
        b=ztbWNPczxE1TcKjbeUEecDqxEvyrdI2rTkhJO+LZ8loh7JYRUTuXalfHRQZAw/damW
         Z0jcAczRl6yX/DbtRpeNyNjQd7bhs0qUZfk4+A/QPbE2T1Du+p1nNDSgIwH0+EeEZuoX
         Q3Edy6UUPKkitkGe1BL/Ntj+u8lWQX2uqAp1UQ5rMMSggbZArHY78FkbO8JyhLnOde0O
         p9tyOlj1DcDbdPEUwcOIsQWhjlNKt1kyhox7i45VQlQsz08PlTThLFkdsO571XHm5kpx
         Td4oFpGIWujS0us4+2/65ICV8hYieH3gnai23SGYX4Q6tDpZzdmjdabyQ0pPD1/P+HT6
         j7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709769569; x=1710374369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsusLBjAmN/j7GjAiSGCt1oC9MYmKOkLL/UwY6A5Vuw=;
        b=Uqn7Lh3eATiZmqUiftX8as3bZqutsg/HqmNoRz+SAl0N1sNgdWHGCH/fQyk1B/OTDk
         mpzh77qbu5gRRtbW9FadUVeSDwQXVtfhkPN4kKb+MvKJBmmFy908EwM5Ex4l1ADz0mUH
         c99CIlnufQyZ9ei6XWpdvOlCo0YkFlqP00/+6rfpFOPiBBdvNPklDKNkaGP1E2ZlfUPB
         UcL1tYArAoWPLcNO0UyVs5/qcmGk/UYFJTxo56EQSNkx2MKxQ2fCNruGCIwVT+YTXNzw
         ed8NLZz8lIzY1N7/YfcC9bQE8tV5X4v8HLVCPIUWCd77oUpj/as/whu7ZuxuvBPvvlPV
         zedA==
X-Gm-Message-State: AOJu0Yx8kB1KXFy7bLUgBzXovXciAGzqeLJV4rlfHpCQPQlbA9zSKOwT
	m2nUt8upGzHo03C7gBx5LqCQLls62m77s+IjvPj14KzV+s6bCnjQv0HgCgu+Qbo2vLbTelB8tjU
	iYnjTq/Dg6l9kTUP/a31hsCB0TTmgmR0QAC/AlaZ/BvgVcvl6mTQh+a7QIdSch+FMyFWjU40cF+
	94Ik/bdLNMXzoJL6v2OLDHgjf0sCgBkbTUUhD+4FVASnkeQQw2YiKOgv3Uuzg=
X-Google-Smtp-Source: AGHT+IFok183EvQuz7zmWuQx/gTm3LYQx324qpqHRVGJifubx6V5VcYl7QKhTuMsK2W9+CKTPYwvTSx6S026SzGVrg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:daeb:5bc6:353c:6d72])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:724:b0:dcc:5a91:aee9 with
 SMTP id l4-20020a056902072400b00dcc5a91aee9mr4017202ybt.7.1709769568316; Wed,
 06 Mar 2024 15:59:28 -0800 (PST)
Date: Wed,  6 Mar 2024 15:59:19 -0800
In-Reply-To: <20240306235922.282781-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306235922.282781-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306235922.282781-2-almasrymina@google.com>
Subject: [RFC PATCH net-next v1 1/2] net: mirror skb frag ref/unref helpers
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Mirko Lindner <mlindner@marvell.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Refactor some of the skb frag ref/unref helpers for improved clarity.

Implement napi_pp_get_page() to be the mirror counterpart of
napi_pp_put_page().

Implement napi_frag_ref() to be the mirror counterpart of
napi_frag_unref().

Improve __skb_frag_ref() to become a mirror counterpart of
__skb_frag_unref(). Previously unref could handle pp & non-pp pages,
while the ref could only handle non-pp pages. Now both the ref & unref
helpers can correctly handle both pp & non-pp pages.

Now that __skb_frag_ref() can handle both pp & non-pp pages, remove
skb_pp_frag_ref(), and use __skb_frag_ref() instead.  This lets us
remove pp specific handling from skb_try_coalesce.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/linux/skbuff.h | 24 +++++++++++++++---
 net/core/skbuff.c      | 56 ++++++++++++++----------------------------
 2 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index d577e0bee18d..51316b0e20bc 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3477,15 +3477,31 @@ static inline struct page *skb_frag_page(const skb_frag_t *frag)
 	return netmem_to_page(frag->netmem);
 }
 
+bool napi_pp_get_page(struct page *page);
+
+static inline void napi_frag_ref(skb_frag_t *frag, bool recycle)
+{
+#ifdef CONFIG_PAGE_POOL
+	struct page *page = skb_frag_page(frag);
+
+	if (recycle && napi_pp_get_page(page))
+		return;
+#endif
+	get_page(page);
+}
+
 /**
  * __skb_frag_ref - take an addition reference on a paged fragment.
  * @frag: the paged fragment
+ * @recycle: skb->pp_recycle param of the parent skb.
  *
- * Takes an additional reference on the paged fragment @frag.
+ * Takes an additional reference on the paged fragment @frag. Obtains the
+ * correct reference count depending on whether skb->pp_recycle is set and
+ * whether the frag is a page pool frag.
  */
-static inline void __skb_frag_ref(skb_frag_t *frag)
+static inline void __skb_frag_ref(skb_frag_t *frag, bool recycle)
 {
-	get_page(skb_frag_page(frag));
+	napi_frag_ref(frag, recycle);
 }
 
 /**
@@ -3497,7 +3513,7 @@ static inline void __skb_frag_ref(skb_frag_t *frag)
  */
 static inline void skb_frag_ref(struct sk_buff *skb, int f)
 {
-	__skb_frag_ref(&skb_shinfo(skb)->frags[f]);
+	__skb_frag_ref(&skb_shinfo(skb)->frags[f], skb->pp_recycle);
 }
 
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 1f918e602bc4..6d234faa9d9e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1006,6 +1006,21 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 EXPORT_SYMBOL(skb_cow_data_for_xdp);
 
 #if IS_ENABLED(CONFIG_PAGE_POOL)
+bool napi_pp_get_page(struct page *page)
+{
+
+	struct page *head_page;
+
+	head_page = compound_head(page);
+
+	if (!is_pp_page(page))
+		return false;
+
+	page_pool_ref_page(head_page);
+	return true;
+}
+EXPORT_SYMBOL(napi_pp_get_page);
+
 bool napi_pp_put_page(struct page *page, bool napi_safe)
 {
 	bool allow_direct = false;
@@ -1058,37 +1073,6 @@ static bool skb_pp_recycle(struct sk_buff *skb, void *data, bool napi_safe)
 	return napi_pp_put_page(virt_to_page(data), napi_safe);
 }
 
-/**
- * skb_pp_frag_ref() - Increase fragment references of a page pool aware skb
- * @skb:	page pool aware skb
- *
- * Increase the fragment reference count (pp_ref_count) of a skb. This is
- * intended to gain fragment references only for page pool aware skbs,
- * i.e. when skb->pp_recycle is true, and not for fragments in a
- * non-pp-recycling skb. It has a fallback to increase references on normal
- * pages, as page pool aware skbs may also have normal page fragments.
- */
-static int skb_pp_frag_ref(struct sk_buff *skb)
-{
-	struct skb_shared_info *shinfo;
-	struct page *head_page;
-	int i;
-
-	if (!skb->pp_recycle)
-		return -EINVAL;
-
-	shinfo = skb_shinfo(skb);
-
-	for (i = 0; i < shinfo->nr_frags; i++) {
-		head_page = compound_head(skb_frag_page(&shinfo->frags[i]));
-		if (likely(is_pp_page(head_page)))
-			page_pool_ref_page(head_page);
-		else
-			page_ref_inc(head_page);
-	}
-	return 0;
-}
-
 static void skb_kfree_head(void *head, unsigned int end_offset)
 {
 	if (end_offset == SKB_SMALL_HEAD_HEADROOM)
@@ -4199,7 +4183,7 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 			to++;
 
 		} else {
-			__skb_frag_ref(fragfrom);
+			__skb_frag_ref(fragfrom, skb->pp_recycle);
 			skb_frag_page_copy(fragto, fragfrom);
 			skb_frag_off_copy(fragto, fragfrom);
 			skb_frag_size_set(fragto, todo);
@@ -4849,7 +4833,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 			}
 
 			*nskb_frag = (i < 0) ? skb_head_frag_to_page_desc(frag_skb) : *frag;
-			__skb_frag_ref(nskb_frag);
+			__skb_frag_ref(nskb_frag, nskb->pp_recycle);
 			size = skb_frag_size(nskb_frag);
 
 			if (pos < offset) {
@@ -5980,10 +5964,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	/* if the skb is not cloned this does nothing
 	 * since we set nr_frags to 0.
 	 */
-	if (skb_pp_frag_ref(from)) {
-		for (i = 0; i < from_shinfo->nr_frags; i++)
-			__skb_frag_ref(&from_shinfo->frags[i]);
-	}
+	for (i = 0; i < from_shinfo->nr_frags; i++)
+		__skb_frag_ref(&from_shinfo->frags[i], from->pp_recycle);
 
 	to->truesize += delta;
 	to->len += len;
-- 
2.44.0.278.ge034bb2e1d-goog


