Return-Path: <netdev+bounces-83820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 076388946BB
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 23:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754E21F225A7
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 21:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29EF54FBB;
	Mon,  1 Apr 2024 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WuNm0p3b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC12554FAC
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008255; cv=none; b=nOVeFOvK0m7mC22k3M0l76FJcLjxdhY8WMjO0MBKXRNUKMAEG6KER+3JRmC/sKy1I2nXaIPfyp+PbjjcG4pEHMU2YDtkiL1Nd0YrsrJx90EVGDRUfPZuNYfyedR7ra6dcrfAuSsNENIGvKv7X2nvhUjeg6Wi+WCzhecGN+LhagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008255; c=relaxed/simple;
	bh=Al2L+U/fB7j6TwXX2+zf6Bdg1+YylbkEbJBCbRWdeqE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lvi6osea4s0QbJa7PhJkhJFYtORuzwf0vMwO1JSWhLUfQcNxxADAy4v7vGKENBCqTNZmq/wXxT/F2HC0wCoe4AG1O5HxXm2XprBLy3R3296Gv/Jq7ntJ213rWvfBb7PbSxMLCWxfEgTw8rij0szPvKFYWKmBqKdRr1dF6efx+vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WuNm0p3b; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60ccc3cfa39so73979757b3.2
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 14:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712008253; x=1712613053; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HQgeDPgrSEDZD6GhBq5cXu5ulSSJGNPUjkrXoP9adkA=;
        b=WuNm0p3b/mlY4ONRslYGjy7KcdGt2h/Nb8H4dDUDHZID+GXzdxp60KSnotdKb+mj6P
         Z/36Qph6MhSbbQQEs5esQ6YcA8R6WbcPvlMYWrn/E1KE7JJyV9cN2KVSLdz2+71PToXg
         mGNsJNpXdxohfckXh+DidzBdWq0MpG9wjD8T/eGW0ZEayMSvS3iQMR69Pr0Q4WFMk+/g
         WxbRbn3hSCbDwJ80K40iLQsFLxj+ZMZzVpkz0Vq60WKFnwqDc06ity9YW2FQHnhOGT9+
         vtiffSQwBri8LPwdQjr8FpmMxzwx84mDbtNW+nteYvIu0ipjYhj10c4sD3Dt+/hUTIPI
         0Zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712008253; x=1712613053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQgeDPgrSEDZD6GhBq5cXu5ulSSJGNPUjkrXoP9adkA=;
        b=FUl4LKxkm8wDmGTG1I6DYkkaaSiFT1bJAx1fAEuqIcyAtaoIFJquqVoyl9FTaTGVqy
         ZQRViQvF/llQR49D7al2uLdP+2so3uVxcOwOndAXhOfTRzpg7i071EiaJ0DfSTWz/g+2
         25+qTFQC/F2aeXTBVH4gFZ1R1KSyFKKDosREwN+WUQPzkE9HzxTZhtTlDCnNe13MGhYr
         ByhwhSwjxQXftINnvtezcH20H7ccxyt9N9VNBowVkcsJdteM6FTewszzABDd6uJhxiRV
         kryXaQVhX7oUjvQFCi1gYAz0dXE8wQ0SkCiebCrf2zAVUrpE28QagCWk0LO2ApQ00MhF
         80dg==
X-Gm-Message-State: AOJu0Ywpq17NBURA1b71J83HlSb9q7McE80fS4XH2fZs1fCL6D+syHDS
	7YAQf3Jq+k5M1OsVyb9eLUob6kcwJZWTAX8derXiZa6EqaasnLtu08VPg4e0a3qIX+mvhbnt8ft
	zHn2gaTs7/hnuRqkN5a43LaR64Q+Yt84op/25fjmMgUX1i7GtlMqbFLvhIYC/cdUElgAZGFM1BJ
	H8tI/qRG47qjR1lBDFYktcGlgphNjd2icnjhk6la7u7qBHzi3umpNxMvmRY1I=
X-Google-Smtp-Source: AGHT+IG67OeeFsTFVWjEn9D72dtBvKlCeiL9nv9cFNxpPw5Urq1GS9sn+da9FbcvzwePSAOgsA9F3XSQ8fxqW+ZtiA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b337:405b:46e7:9bd9])
 (user=almasrymina job=sendgmr) by 2002:a81:f910:0:b0:611:7166:1a4d with SMTP
 id x16-20020a81f910000000b0061171661a4dmr2790727ywm.3.1712008253032; Mon, 01
 Apr 2024 14:50:53 -0700 (PDT)
Date: Mon,  1 Apr 2024 14:50:38 -0700
In-Reply-To: <20240401215042.1877541-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401215042.1877541-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401215042.1877541-3-almasrymina@google.com>
Subject: [PATCH net-next v3 2/3] net: mirror skb frag ref/unref helpers
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mirko Lindner <mlindner@marvell.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Maxim Mikityanskiy <maxtram95@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Simon Horman <horms@kernel.org>, 
	Yunsheng Lin <linyunsheng@huawei.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, David Howells <dhowells@redhat.com>, 
	Florian Westphal <fw@strlen.de>, Aleksander Lobakin <aleksander.lobakin@intel.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
	Liang Chen <liangchen.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Refactor some of the skb frag ref/unref helpers for improved clarity.

Implement napi_pp_get_page() to be the mirror counterpart of
napi_pp_put_page().

Implement skb_page_ref() to be the mirror of skb_page_unref().

Improve __skb_frag_ref() to become a mirror counterpart of
__skb_frag_unref(). Previously unref could handle pp & non-pp pages,
while the ref could only handle non-pp pages. Now both the ref & unref
helpers can correctly handle both pp & non-pp pages.

Now that __skb_frag_ref() can handle both pp & non-pp pages, remove
skb_pp_frag_ref(), and use __skb_frag_ref() instead.  This lets us
remove pp specific handling from skb_try_coalesce.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

---

v3:
- Fix build errors reported by patchwork.
- Fix drivers/net/veth.c & tls_device_fallback.c callsite I missed to update.
- Fix page_pool_ref_page(head_page) -> page_pool_ref_page(page)

---
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |  2 +-
 drivers/net/ethernet/sun/cassini.c            |  4 +-
 drivers/net/veth.c                            |  2 +-
 include/linux/skbuff.h                        | 22 ++++++--
 net/core/skbuff.c                             | 54 ++++++-------------
 net/tls/tls_device_fallback.c                 |  2 +-
 6 files changed, 40 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
index 6482728794dd..f9b0a9533985 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
@@ -1658,7 +1658,7 @@ static void chcr_ktls_copy_record_in_skb(struct sk_buff *nskb,
 	for (i = 0; i < record->num_frags; i++) {
 		skb_shinfo(nskb)->frags[i] = record->frags[i];
 		/* increase the frag ref count */
-		__skb_frag_ref(&skb_shinfo(nskb)->frags[i]);
+		__skb_frag_ref(&skb_shinfo(nskb)->frags[i], false);
 	}
 
 	skb_shinfo(nskb)->nr_frags = record->num_frags;
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index bfb903506367..fabba729e1b8 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -1999,7 +1999,7 @@ static int cas_rx_process_pkt(struct cas *cp, struct cas_rx_comp *rxc,
 		skb->len      += hlen - swivel;
 
 		skb_frag_fill_page_desc(frag, page->buffer, off, hlen - swivel);
-		__skb_frag_ref(frag);
+		__skb_frag_ref(frag, false);
 
 		/* any more data? */
 		if ((words[0] & RX_COMP1_SPLIT_PKT) && ((dlen -= hlen) > 0)) {
@@ -2023,7 +2023,7 @@ static int cas_rx_process_pkt(struct cas *cp, struct cas_rx_comp *rxc,
 			frag++;
 
 			skb_frag_fill_page_desc(frag, page->buffer, 0, hlen);
-			__skb_frag_ref(frag);
+			__skb_frag_ref(frag, false);
 			RX_USED_ADD(page, hlen + cp->crc_size);
 		}
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index bcdfbf61eb66..6160a3e8d341 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -716,7 +716,7 @@ static void veth_xdp_get(struct xdp_buff *xdp)
 		return;
 
 	for (i = 0; i < sinfo->nr_frags; i++)
-		__skb_frag_ref(&sinfo->frags[i]);
+		__skb_frag_ref(&sinfo->frags[i], false);
 }
 
 static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a6b5596dc0cb..849d78554b50 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3483,15 +3483,29 @@ static inline struct page *skb_frag_page(const skb_frag_t *frag)
 	return netmem_to_page(frag->netmem);
 }
 
+bool napi_pp_get_page(struct page *page);
+
+static inline void skb_page_ref(struct page *page, bool recycle)
+{
+#ifdef CONFIG_PAGE_POOL
+	if (recycle && napi_pp_get_page(page))
+		return;
+#endif
+	get_page(page);
+}
+
 /**
  * __skb_frag_ref - take an addition reference on a paged fragment.
  * @frag: the paged fragment
+ * @recycle: skb->pp_recycle param of the parent skb. False if no parent skb.
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
+	skb_page_ref(skb_frag_page(frag), recycle);
 }
 
 /**
@@ -3503,7 +3517,7 @@ static inline void __skb_frag_ref(skb_frag_t *frag)
  */
 static inline void skb_frag_ref(struct sk_buff *skb, int f)
 {
-	__skb_frag_ref(&skb_shinfo(skb)->frags[f]);
+	__skb_frag_ref(&skb_shinfo(skb)->frags[f], skb->pp_recycle);
 }
 
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a1be84be5d35..d878f2e67567 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1004,6 +1004,19 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 EXPORT_SYMBOL(skb_cow_data_for_xdp);
 
 #if IS_ENABLED(CONFIG_PAGE_POOL)
+bool napi_pp_get_page(struct page *page)
+{
+
+	page = compound_head(page);
+
+	if (!is_pp_page(page))
+		return false;
+
+	page_pool_ref_page(page);
+	return true;
+}
+EXPORT_SYMBOL(napi_pp_get_page);
+
 bool napi_pp_put_page(struct page *page, bool napi_safe)
 {
 	bool allow_direct = false;
@@ -1056,37 +1069,6 @@ static bool skb_pp_recycle(struct sk_buff *skb, void *data, bool napi_safe)
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
@@ -4195,7 +4177,7 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 			to++;
 
 		} else {
-			__skb_frag_ref(fragfrom);
+			__skb_frag_ref(fragfrom, skb->pp_recycle);
 			skb_frag_page_copy(fragto, fragfrom);
 			skb_frag_off_copy(fragto, fragfrom);
 			skb_frag_size_set(fragto, todo);
@@ -4845,7 +4827,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 			}
 
 			*nskb_frag = (i < 0) ? skb_head_frag_to_page_desc(frag_skb) : *frag;
-			__skb_frag_ref(nskb_frag);
+			__skb_frag_ref(nskb_frag, nskb->pp_recycle);
 			size = skb_frag_size(nskb_frag);
 
 			if (pos < offset) {
@@ -5976,10 +5958,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
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
diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index 4e7228f275fa..d4000b4a1f7d 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -277,7 +277,7 @@ static int fill_sg_in(struct scatterlist *sg_in,
 	for (i = 0; remaining > 0; i++) {
 		skb_frag_t *frag = &record->frags[i];
 
-		__skb_frag_ref(frag);
+		__skb_frag_ref(frag, false);
 		sg_set_page(sg_in + i, skb_frag_page(frag),
 			    skb_frag_size(frag), skb_frag_off(frag));
 
-- 
2.44.0.478.gd926399ef9-goog


