Return-Path: <netdev+bounces-82677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177B888F134
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 22:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C216029E358
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 21:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9394154426;
	Wed, 27 Mar 2024 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jp5kpTB3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34E4153802
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575934; cv=none; b=hYRDxI0jHx2hgt69//8b3Ki+whL+tMUFKTHW4+dNP7z+cUgey+/YtlpH/Lx4LOCl8+SuFJZLVqs4U8wX0Rcvz1Pzom6N285qbDeXXbehlMiUT1MafyG21FS+CUa1hgHPbozMkRGVjcStH5qDLwYRNoZyhA9KGaXaI9kJZGAAYbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575934; c=relaxed/simple;
	bh=UFh9WIe9rm3vbiPkPQJfYCpA8I+9vkOzZY11SDb6fDU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fi7v4ywV2frelFMyTb0kCR/GEmzjywDB5EZi8BYYqWs0j7sfyNU2JnhLsopOL5+/k6mCAYR92S/L+uSddgVNe7AVNuHNzOc/2c7xQaTgBCtyQ2dcZOs4rudtjubjnPHP2DCe0BGje/CPAfUpq7uUE7bdVR8X2qPzAB82SsOCx/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jp5kpTB3; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso391388276.0
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 14:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711575932; x=1712180732; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7nhCSN7ZlS5U7nzl7rNYNpzESUVtaxwKFd/9+3DX9HA=;
        b=Jp5kpTB3KxpwbXFO5WjI4fINDtkg2QBHOo0z2tN9ofZMumD7TH5V/1udcyqW4R5jEB
         Io/dUvgLRR7T9oEBQoyL8HqQxk7PFfM6m6kvB0Rx+NCBZrqHQ2YpI8DEtdQYMM9Rfc3h
         DxOdfjncFlEA0PDxwiblt80iygy/9bbBCMrnzvgPc5hx0eY25OFVq5hGHDugVTTND78q
         EMDbFhJMu9D0Pu4RH55V5Gt8f5SdB/+vGk9dFLiAjRX+WM4ZePhzMJjI7/VQo1yNci7S
         KoaWet+96nilNQmlpXCMv2/ZacFUiprUb5p8aowtRsI75RN2lDs1GPAwpuNLmSg2Vwl+
         QReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575932; x=1712180732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nhCSN7ZlS5U7nzl7rNYNpzESUVtaxwKFd/9+3DX9HA=;
        b=IgfnXgA68I92E1HNepwuPbYP/vt8deGj2IDawIbBq4DvNdefmsPiNtuhw1oTg5I8Es
         hSdm6oH0jZd42wpvDODVt8oNWnzHTrrY2MfAgXxT+sPsiliHbnW86dZHtQ/4Vdcp+zYj
         +XuWuufS7f+T9dP8KuXyqGCT1QOoqJj4WBLMYVEk37oqLbDunVtdVxwN7vZYQTRzaMNs
         9PpI34iFIY2H436vYUR9UK46OxvnwJyfhi+kuYwdWQde9WuqLPUBE08NDRrhkwhC0XvR
         1ZgKNuysySahNTvdzg/A25Ql4E/HQOZktUuF/aamhfXiSAFeDXd0cyAKa7Ib3k/EHPw3
         1pDA==
X-Gm-Message-State: AOJu0YzrpiRIu2N/0shmeqi7wQjrR3ThQ2vPvWLj323Lak70dFHhPK4B
	PkI5XoTKw1glcvTN3aPJF8kUbFe9+Py2pS4meBRBKMGm6RiuJQSWRcVhj2QRHjQw4crKfXcd82q
	tgnRLesEdgX5OokL0XQUSYuKNGozlq+km48EVk5UwDJk7yYe8C1kxnkWiV3+UBaFQOp3Mi/jUIQ
	haBCXjikPeLqpT+ymlycJ/E9yxQ/MlCSfQfPq5AKNOi2ltkj/vNLdY2A1t4sY=
X-Google-Smtp-Source: AGHT+IFiiv618YyP5fRdIU/0IHkoi6CzDlRKCzAH4g50/1TpW13MEqg2OxQ5+JaxPx6CPrRX8XqMN6rT5+evY9uAVQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b757:6e7b:2156:cabc])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:2311:b0:dbe:d0a9:2be8 with
 SMTP id do17-20020a056902231100b00dbed0a92be8mr118134ybb.0.1711575931557;
 Wed, 27 Mar 2024 14:45:31 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:45:20 -0700
In-Reply-To: <20240327214523.2182174-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327214523.2182174-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327214523.2182174-3-almasrymina@google.com>
Subject: [PATCH net-next v2 2/3] net: mirror skb frag ref/unref helpers
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
	Dragos Tatulea <dtatulea@nvidia.com>
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
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |  2 +-
 drivers/net/ethernet/sun/cassini.c            |  4 +-
 include/linux/skbuff.h                        | 22 ++++++--
 net/core/skbuff.c                             | 54 ++++++-------------
 4 files changed, 38 insertions(+), 44 deletions(-)

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
 
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index bafa5c9ff59a..058d72a2a250 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3494,15 +3494,29 @@ static inline struct page *skb_frag_page(const skb_frag_t *frag)
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
@@ -3514,7 +3528,7 @@ static inline void __skb_frag_ref(skb_frag_t *frag)
  */
 static inline void skb_frag_ref(struct sk_buff *skb, int f)
 {
-	__skb_frag_ref(&skb_shinfo(skb)->frags[f]);
+	__skb_frag_ref(&skb_shinfo(skb)->frags[f], skb->pp_recycle);
 }
 
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 17617c29be2d..5c86ecaceb6c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1005,6 +1005,19 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
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
+	page_pool_ref_page(head_page);
+	return true;
+}
+EXPORT_SYMBOL(napi_pp_get_page);
+
 bool napi_pp_put_page(struct page *page, bool napi_safe)
 {
 	bool allow_direct = false;
@@ -1057,37 +1070,6 @@ static bool skb_pp_recycle(struct sk_buff *skb, void *data, bool napi_safe)
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
@@ -4196,7 +4178,7 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 			to++;
 
 		} else {
-			__skb_frag_ref(fragfrom);
+			__skb_frag_ref(fragfrom, skb->pp_recycle);
 			skb_frag_page_copy(fragto, fragfrom);
 			skb_frag_off_copy(fragto, fragfrom);
 			skb_frag_size_set(fragto, todo);
@@ -4846,7 +4828,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 			}
 
 			*nskb_frag = (i < 0) ? skb_head_frag_to_page_desc(frag_skb) : *frag;
-			__skb_frag_ref(nskb_frag);
+			__skb_frag_ref(nskb_frag, nskb->pp_recycle);
 			size = skb_frag_size(nskb_frag);
 
 			if (pos < offset) {
@@ -5977,10 +5959,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
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
2.44.0.396.g6e790dbe36-goog


