Return-Path: <netdev+bounces-93084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C63D8B9FD6
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 19:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E3E1C20BA5
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 17:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864D716FF54;
	Thu,  2 May 2024 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JeoD/WjS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62CD171068
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672469; cv=none; b=N/pQ0YTI+3JCeEqUp/B3nqP/fyoiec0W8zIVfPSk/RXlQn2shhT4N371StZNgsYKQUxVdjxlMa2JD0Ph1Of2L14Gou/r3oSUpAmCvTkXHGUEEd1oEA2u4i++8eIfgVLEjIaS+92vIUQR6EUDPZ/Ljxq4iSJlW5jT1LCj26CP2b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672469; c=relaxed/simple;
	bh=JPE/R9iOz6CEOj75ldSDs5+nLaiGFRhA35raW1DFzrI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gwvguSr7IPD4uHogGH9wz+7x+nYdBov/R7ii4cwgTbGjLvva5XS3QggZzyM8JtK8rP/YO+/4nEiDg9Ta8EbQCLuS5W/qD0Dxd/3Mb5GwiZeb3LClcBhcJps5gMQ+ZcQxbCqgq8r/rNLS3XMmqbv9PIMUlu4IGSRsHgd+mfTqzzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JeoD/WjS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b2ef746c9so155483257b3.1
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 10:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714672467; x=1715277267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I/IAzFMixwHM2Thjl3XyvJFlt+EmfAIzac26ZEpeUyE=;
        b=JeoD/WjSujnwkXxl2im7ZwiSH9gFsHldgleGP7Dn8r/p1vdvKMWDi9biaIU/9xVRM1
         zL7H13lgUAyqxhX/4X8ACVpNbXHW1FXMTvhcrRh8ckKAzgGy9hgxO8ukHC2iGaEE4eAE
         gwerhIeUoUa3As4mX/zd1iu2HO6Fdh7744zqjsRKA5I92ewJTTG+4n9e66qaYHcvalYZ
         3vrzmr8CTGm80Eh+VVnyK/mmydecci1Cz66litr6AmrQ/qBW3b9h8DKJE9AlquRgNaZV
         T8e2+7LG8StsFOrb1KLdFY9fmmyvF5gvnR+NCGsaqWDHXXetJ3/wkANMgPLMYzXZECHm
         WQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714672467; x=1715277267;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/IAzFMixwHM2Thjl3XyvJFlt+EmfAIzac26ZEpeUyE=;
        b=o7SrNpn5Bq8lTCZkshQ58qWAzAo+uMrSSDuVvDKmvdLVyzU/NSWlUwySkOouOR3k5j
         wB782fZcjUK7QeCHhdYKwdtPcd0nnrAfPRP2qByuZvTPWLbjOUzwxOwNrKMHNY8OFxGA
         tE96AnVSGDQ69uCnive/yEku97P9kQXAYXwUK5AmCjhLC+ESgmaVb2o4PcWn6uA2kQP7
         Lqh0kDXiKo98AV82m0EGKGN0mXJ1EPxlyxM5fhQYNtVeDMhY05L+Scf/qG8ChTq2Wf1j
         Zzzrh1oNo9xAgrF46HbNMz39HBQ9OrzRdSTVQRfWzaDCVGNWcgvqHPV3hZXoJVRKQEUo
         BMkw==
X-Gm-Message-State: AOJu0YwZcM3FeDpLUNuNyxhxeXyt+FqFUshx7UWXGAc2BXW6xWVEDKZC
	z+I3XKRLIkTwZ+lYrC3n7DFC2d3EhgliiNbONDNU98726dMVRxuSxhD8Flyfko3ZbVp3FOLanm0
	oBI8W80zXZOqKAbE6J4VcotMfyZEga9vnDhpQxUi67DxuZz0f8ipFADQUXApY0W/tcVHaUZz2Nh
	UVPJ3dnwY7ZLIMCHfT+a9sIj7ZdxFjcugqgc95eZQPhS5t4I1SeKwOWaCSoMg=
X-Google-Smtp-Source: AGHT+IGM3AT3HA4nhlxSLvHRIQdpYJJrwZ+YU/rIbPn5l9TJ0Vxbg+AqUGepPNXiRDOQpHv+NXGq/U+qo24O/ZlkYg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:6efb:907e:8b95:d2ec])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:27c6:b0:de1:d50:ad47 with
 SMTP id ec6-20020a05690227c600b00de10d50ad47mr129541ybb.13.1714672466791;
 Thu, 02 May 2024 10:54:26 -0700 (PDT)
Date: Thu,  2 May 2024 10:54:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240502175423.2456544-1-almasrymina@google.com>
Subject: [PATCH net-next v1] Revert "net: mirror skb frag ref/unref helpers"
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Jianbo Liu <jianbol@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"

This reverts commit a580ea994fd37f4105028f5a85c38ff6508a2b25.

This revert is to resolve Dragos's report of page_pool leak here:
https://lore.kernel.org/lkml/20240424165646.1625690-2-dtatulea@nvidia.com/

The reverted patch interacts very badly with commit 2cc3aeb5eccc ("skbuff:
Fix a potential race while recycling page_pool packets"). The reverted
commit hopes that the pp_recycle + is_pp_page variables do not change
between the skb_frag_ref and skb_frag_unref operation. If such a change
occurs, the skb_frag_ref/unref will not operate on the same reference type.
In the case of Dragos's report, the grabbed ref was a pp ref, but the unref
was a page ref, because the pp_recycle setting on the skb was changed.

Attempting to fix this issue on the fly is risky. Lets revert and I hope
to reland this with better understanding and testing to ensure we don't
regress some edge case while streamlining skb reffing.

Fixes: a580ea994fd3 ("net: mirror skb frag ref/unref helpers")
Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

Cc: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jianbo Liu <jianbol@nvidia.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
---
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |  2 +-
 drivers/net/ethernet/sun/cassini.c            |  4 +-
 drivers/net/veth.c                            |  2 +-
 include/linux/skbuff_ref.h                    | 39 ++--------------
 net/core/skbuff.c                             | 46 +++++++++++++++++--
 net/tls/tls_device_fallback.c                 |  2 +-
 6 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
index 3832c2e8ea5a..e8e460a92e0e 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
@@ -1659,7 +1659,7 @@ static void chcr_ktls_copy_record_in_skb(struct sk_buff *nskb,
 	for (i = 0; i < record->num_frags; i++) {
 		skb_shinfo(nskb)->frags[i] = record->frags[i];
 		/* increase the frag ref count */
-		__skb_frag_ref(&skb_shinfo(nskb)->frags[i], nskb->pp_recycle);
+		__skb_frag_ref(&skb_shinfo(nskb)->frags[i]);
 	}

 	skb_shinfo(nskb)->nr_frags = record->num_frags;
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index f058e154a3bc..8f1f43dbb76d 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -2000,7 +2000,7 @@ static int cas_rx_process_pkt(struct cas *cp, struct cas_rx_comp *rxc,
 		skb->len      += hlen - swivel;

 		skb_frag_fill_page_desc(frag, page->buffer, off, hlen - swivel);
-		__skb_frag_ref(frag, skb->pp_recycle);
+		__skb_frag_ref(frag);

 		/* any more data? */
 		if ((words[0] & RX_COMP1_SPLIT_PKT) && ((dlen -= hlen) > 0)) {
@@ -2024,7 +2024,7 @@ static int cas_rx_process_pkt(struct cas *cp, struct cas_rx_comp *rxc,
 			frag++;

 			skb_frag_fill_page_desc(frag, page->buffer, 0, hlen);
-			__skb_frag_ref(frag, skb->pp_recycle);
+			__skb_frag_ref(frag);
 			RX_USED_ADD(page, hlen + cp->crc_size);
 		}

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 0b0293629329..426e68a95067 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -717,7 +717,7 @@ static void veth_xdp_get(struct xdp_buff *xdp)
 		return;

 	for (i = 0; i < sinfo->nr_frags; i++)
-		__skb_frag_ref(&sinfo->frags[i], false);
+		__skb_frag_ref(&sinfo->frags[i]);
 }

 static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
index 4dcdbe9fbc5f..11f0a4063403 100644
--- a/include/linux/skbuff_ref.h
+++ b/include/linux/skbuff_ref.h
@@ -8,47 +8,16 @@
 #define _LINUX_SKBUFF_REF_H

 #include <linux/skbuff.h>
-#include <net/page_pool/helpers.h>
-
-#ifdef CONFIG_PAGE_POOL
-static inline bool is_pp_page(struct page *page)
-{
-	return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
-}
-
-static inline bool napi_pp_get_page(struct page *page)
-{
-	page = compound_head(page);
-
-	if (!is_pp_page(page))
-		return false;
-
-	page_pool_ref_page(page);
-	return true;
-}
-#endif
-
-static inline void skb_page_ref(struct page *page, bool recycle)
-{
-#ifdef CONFIG_PAGE_POOL
-	if (recycle && napi_pp_get_page(page))
-		return;
-#endif
-	get_page(page);
-}

 /**
  * __skb_frag_ref - take an addition reference on a paged fragment.
  * @frag: the paged fragment
- * @recycle: skb->pp_recycle param of the parent skb. False if no parent skb.
  *
- * Takes an additional reference on the paged fragment @frag. Obtains the
- * correct reference count depending on whether skb->pp_recycle is set and
- * whether the frag is a page pool frag.
+ * Takes an additional reference on the paged fragment @frag.
  */
-static inline void __skb_frag_ref(skb_frag_t *frag, bool recycle)
+static inline void __skb_frag_ref(skb_frag_t *frag)
 {
-	skb_page_ref(skb_frag_page(frag), recycle);
+	get_page(skb_frag_page(frag));
 }

 /**
@@ -60,7 +29,7 @@ static inline void __skb_frag_ref(skb_frag_t *frag, bool recycle)
  */
 static inline void skb_frag_ref(struct sk_buff *skb, int f)
 {
-	__skb_frag_ref(&skb_shinfo(skb)->frags[f], skb->pp_recycle);
+	__skb_frag_ref(&skb_shinfo(skb)->frags[f]);
 }

 bool napi_pp_put_page(struct page *page);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5f382e94b4d1..ecc44f23e5d4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -904,6 +904,11 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }

+static bool is_pp_page(struct page *page)
+{
+	return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
+}
+
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		    unsigned int headroom)
 {
@@ -1025,6 +1030,37 @@ static bool skb_pp_recycle(struct sk_buff *skb, void *data)
 	return napi_pp_put_page(virt_to_page(data));
 }

+/**
+ * skb_pp_frag_ref() - Increase fragment references of a page pool aware skb
+ * @skb:	page pool aware skb
+ *
+ * Increase the fragment reference count (pp_ref_count) of a skb. This is
+ * intended to gain fragment references only for page pool aware skbs,
+ * i.e. when skb->pp_recycle is true, and not for fragments in a
+ * non-pp-recycling skb. It has a fallback to increase references on normal
+ * pages, as page pool aware skbs may also have normal page fragments.
+ */
+static int skb_pp_frag_ref(struct sk_buff *skb)
+{
+	struct skb_shared_info *shinfo;
+	struct page *head_page;
+	int i;
+
+	if (!skb->pp_recycle)
+		return -EINVAL;
+
+	shinfo = skb_shinfo(skb);
+
+	for (i = 0; i < shinfo->nr_frags; i++) {
+		head_page = compound_head(skb_frag_page(&shinfo->frags[i]));
+		if (likely(is_pp_page(head_page)))
+			page_pool_ref_page(head_page);
+		else
+			page_ref_inc(head_page);
+	}
+	return 0;
+}
+
 static void skb_kfree_head(void *head, unsigned int end_offset)
 {
 	if (end_offset == SKB_SMALL_HEAD_HEADROOM)
@@ -4149,7 +4185,7 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 			to++;

 		} else {
-			__skb_frag_ref(fragfrom, skb->pp_recycle);
+			__skb_frag_ref(fragfrom);
 			skb_frag_page_copy(fragto, fragfrom);
 			skb_frag_off_copy(fragto, fragfrom);
 			skb_frag_size_set(fragto, todo);
@@ -4799,7 +4835,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 			}

 			*nskb_frag = (i < 0) ? skb_head_frag_to_page_desc(frag_skb) : *frag;
-			__skb_frag_ref(nskb_frag, nskb->pp_recycle);
+			__skb_frag_ref(nskb_frag);
 			size = skb_frag_size(nskb_frag);

 			if (pos < offset) {
@@ -5930,8 +5966,10 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	/* if the skb is not cloned this does nothing
 	 * since we set nr_frags to 0.
 	 */
-	for (i = 0; i < from_shinfo->nr_frags; i++)
-		__skb_frag_ref(&from_shinfo->frags[i], from->pp_recycle);
+	if (skb_pp_frag_ref(from)) {
+		for (i = 0; i < from_shinfo->nr_frags; i++)
+			__skb_frag_ref(&from_shinfo->frags[i]);
+	}

 	to->truesize += delta;
 	to->len += len;
diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index 9237dded4467..f9e3d3d90dcf 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -278,7 +278,7 @@ static int fill_sg_in(struct scatterlist *sg_in,
 	for (i = 0; remaining > 0; i++) {
 		skb_frag_t *frag = &record->frags[i];

-		__skb_frag_ref(frag, false);
+		__skb_frag_ref(frag);
 		sg_set_page(sg_in + i, skb_frag_page(frag),
 			    skb_frag_size(frag), skb_frag_off(frag));

--
2.45.0.rc1.225.g2a3ae87e7f-goog

