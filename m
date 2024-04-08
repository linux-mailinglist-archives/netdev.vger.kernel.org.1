Return-Path: <netdev+bounces-85837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F3989C844
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 17:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2F4284F50
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C75F1411CD;
	Mon,  8 Apr 2024 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZChAChPV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC554140E40
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590208; cv=none; b=t2LkTsRZ9chh84ciPYSaiq2i5+dZCDPnwmwcghk450fUvhb6BbOLUe8zAWVGprtrVXBkhl2Bzz2F0JDst1pR5G3SqVUKDDVb2VCF0ADLGzeDbMjI1B1I2soft5pc2iRwRI1RJaAn5WaDuadQXeKaV2vs94fyzzDFOXhJ5bF8HKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590208; c=relaxed/simple;
	bh=Smf4aywmigwysrSIcOcqw9bvaWWtvxCh+z00bSuHAcY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hrQut2OPBZM6RJlRFVADZarnYUPdAdLQtKwiIb5ms1eDsDqYXb1QjpJhL7otg5esbvtBY4rq6rvEj3feslCQTuksXwyT8oitLE1RXugRlWqVy3B67xvTKhQyLzpOoZNs+lKMfpdB3/dLdSVYgTNT1JAcY/aD0gf1RmXgkEoiuUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZChAChPV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a20c33f06so53545937b3.2
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712590206; x=1713195006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ASL93255NaCWCo+CYsAiAClfDvlTbN+MqYwKv6ZLMw=;
        b=ZChAChPV8opt7/UhwCZ+DPzHek2zQ2w7eVdjPYNfDzI2Yy1Ot1Xb/Cd6aDrAee4u8h
         CZ/h4BhgG8ywQcJwR3CUjosT08nwe4nadkDvCAMvJwSqpiduEd8AJeFU+9oH7fTba/Ad
         ITe8sqI2TO4HbQFirccmh8dXUCWl/i8V+dU5FyNhm1H2hWIrfKzH45e+HFoTgFciy05S
         PJnfiMQBiMyTdZ6hvfgs9U0j6XIuHqEdHlkcs9Z79nnXMF8kKbFe3Oj3wK7jLRCp1b/f
         QHlk5Y0rvbhebUePeaZofGokgupYsZ9F3c5rstkDVc61hm54E7RFl+dQP2fDPdt4q9nh
         PnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712590206; x=1713195006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ASL93255NaCWCo+CYsAiAClfDvlTbN+MqYwKv6ZLMw=;
        b=nzPcE/LEVa6a55b+xm7FWRGHgF+QmqwkyaTTG0wiNdfaJlDaPpWXWSLNG1wqjIxdBw
         8iFHOrJU+bJV5Qiqp1u6VVIuiLiwAvFxqmqktyJptf8Cx4+yhEOceXW0ftRHT9ztBYQQ
         hr+tuuY3vd7bMVlXIRRP5ftbmU2WWDG7MT9GrQUotlMQuKaVW7qSIZUinWvlD0mjWYHk
         zn0dhO/FobxNikUV46I6jW4lZVd+gDyp4x5cnENi7fViQat9/AGibnKluN7M3ISpsYvt
         aVlG8cGHoyCOsOSKp6Dfq6q7DqY9rVc/P2g//ewZOuPPwuBSDrrUwc0bxI/LLOmrFMmB
         ynRg==
X-Gm-Message-State: AOJu0Yx1a3m18SmCDeloGMBzcrdcq8tYLOVSYVoCN2JfhqC86PjpmWOY
	oToywmAsyoYRenWm7oVhQyIQufIerZyAIismsDXdQ/80B/zLZxmbP10wTeAGGOElE5wvM/AmpeG
	TOOhu+PFdCfWocx5O3KRtxxLXNB/qAvHoU98ciou1L1j7kngGXLtPv11wCafinS4VWz2QCvYsfC
	p+h7jYHrZ3200hycEvvZZOav9p2rHNbI6MRvclTe7rgqvkPiYjpqv60Hm+0qw=
X-Google-Smtp-Source: AGHT+IHXvDrx0RfrpDfk+CeWB/a5GDfltDvqCr1L7MJCzD0FqFc/C0bRoo7LD/8GYLg36JJS/efD6eFuQ7KRgW6Ebw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:ca23:d62d:de32:7c93])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:1108:b0:dc7:865b:22c6 with
 SMTP id o8-20020a056902110800b00dc7865b22c6mr721592ybu.8.1712590205499; Mon,
 08 Apr 2024 08:30:05 -0700 (PDT)
Date: Mon,  8 Apr 2024 08:29:56 -0700
In-Reply-To: <20240408153000.2152844-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240408153000.2152844-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408153000.2152844-2-almasrymina@google.com>
Subject: [PATCH net-next v5 1/3] net: make napi_frag_unref reuse skb_page_unref
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

The implementations of these 2 functions are almost identical. Remove
the implementation of napi_frag_unref, and make it a call into
skb_page_unref so we don't duplicate the implementation.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
 include/linux/skbuff.h | 12 +++---------
 net/ipv4/esp4.c        |  2 +-
 net/ipv6/esp6.c        |  2 +-
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 7dfb906d92f7..c0ff85bb087a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3522,10 +3522,10 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 bool napi_pp_put_page(struct page *page);
 
 static inline void
-skb_page_unref(const struct sk_buff *skb, struct page *page)
+skb_page_unref(struct page *page, bool recycle)
 {
 #ifdef CONFIG_PAGE_POOL
-	if (skb->pp_recycle && napi_pp_put_page(page))
+	if (recycle && napi_pp_put_page(page))
 		return;
 #endif
 	put_page(page);
@@ -3534,13 +3534,7 @@ skb_page_unref(const struct sk_buff *skb, struct page *page)
 static inline void
 napi_frag_unref(skb_frag_t *frag, bool recycle)
 {
-	struct page *page = skb_frag_page(frag);
-
-#ifdef CONFIG_PAGE_POOL
-	if (recycle && napi_pp_put_page(page))
-		return;
-#endif
-	put_page(page);
+	skb_page_unref(skb_frag_page(frag), recycle);
 }
 
 /**
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 3d647c9a7a21..40330253f076 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -114,7 +114,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(skb, sg_page(sg));
+			skb_page_unref(sg_page(sg), skb->pp_recycle);
 }
 
 #ifdef CONFIG_INET_ESPINTCP
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index fe8d53f5a5ee..fb431d0a3475 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -131,7 +131,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(skb, sg_page(sg));
+			skb_page_unref(sg_page(sg), skb->pp_recycle);
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
-- 
2.44.0.478.gd926399ef9-goog


