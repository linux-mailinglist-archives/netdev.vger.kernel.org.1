Return-Path: <netdev+bounces-84544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0877A897402
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 17:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8542428A4E6
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 15:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CCA14A603;
	Wed,  3 Apr 2024 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zberM467"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E214A096
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158132; cv=none; b=sDBqCC3Ab7zsTjLN4ir8TDZj5/GlymYuaRbGLuJ8xSjJYJogIfEVcpkF0bG33pFW1eCDk8ncg4gGa35mETdCMcoO48kBMMiFaYyndy31cwGsBrusbM/J2vcb0CKCHHdLPL7hVBu/ki2HFqEguf3bx3isTz90FLNPK0sysWp5Gfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158132; c=relaxed/simple;
	bh=qI/WTLfanKJmZ34UlJ0XO8JlnMX3COqXLh2LGzSj/Tk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CW+NvbqxDDzk59EDwrzJL/K/DzYIViCD8c4Wx3+qIQWpyH+45T+JPFLMBNXKnMwq2Qhu1NdpUZSUhzvikcAAfIQ3Q/7X0IKUrzA/rHmqL0ORdhuA5Vhrirzgh45lqH+HZjNsYOoOGUKGRLzvm92FKEzbxTVAw5p7N+luGXrIWsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zberM467; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd62fa1f9so97191627b3.0
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712158130; x=1712762930; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f30V4mJ6zBXpnDX7YMJN+GSwZJV8AwOhj9hRQ6MYBsI=;
        b=zberM4677e4bPkumEwLfvfwgZ/gGDMyO8AIKUvwHJvNZhMDT8QCBwRS6MrA4Ry9Rm3
         dHsipjRVSB8TYLnrPNwimhcuze0cv1XkG9mucJ5yJdqABLE4qHQFBt3OGuMsETcXaLlD
         AFdFtiYdVfZ+bMFrF8eKRqRxfGDB49pv8isVlAA53db/0amLjQHtdV7OM8QIM/097/9s
         0vhfl2H33dtQZyNP/5R1qhPKUW8Viu5w+GWCgq9o+3cfERm3UNGG/WHejV+GYfaCD08U
         ePfPc3i8i5eWEPhMxN2u63NCfWlm4PRukq2WnzOXetnze9AmpmOc8CxNFqN4xzURa/An
         wo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712158130; x=1712762930;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f30V4mJ6zBXpnDX7YMJN+GSwZJV8AwOhj9hRQ6MYBsI=;
        b=G1cNTl9muXzF3uBwq0Qch6w4kkN1XyvJhQMbMA8kBsLvctkrZ2Zsl3MC2N8GTxDY8i
         8NJ9uAS3P+fAe8belKpk2OZLIUBpQCCVL0qEMTkda5Oq7T4P14WJH1g1f0ybGeVoR57s
         YRnPOx6hiJvTA3cY4rGfKBf3OQsUEPwUt54ZGDk4L8x3v++P57yxfdB64kZJYRUnG7wE
         yyfTyV9hks41+Q95RUyNhdY84xnVQ0abCfXaCICqRNSUqL1dOf/1CSaxqqHCnSxviIXh
         6WbyH+nwWxZM4djHBQOWU8Xt5E94Haaik2pF2Rmy0bhjYnFVP7Alw1Fx8I2LjVVzprff
         X3xw==
X-Gm-Message-State: AOJu0YyTrLoaP7ksdNu2yiZMgyRBldat91BKp4sTv564xLvH9FbUfzye
	nb030OLdkN2cpPhaQgELhn6lXwb8g0pX8OEFFn3+YXGgisdB6rk8tqc+iTKUjw7MEr4kC+qBk3n
	TPNZlQkoY7pxNSSmo7j7U3DlNrba2/nG72GuIconOwt97rBnCyPKdzQeZIvxPJb4AVXaHLVRdYO
	xaVuOyFVxjuVjBlVzOOl3xVzi5+69bYAU2wQtd7B/GLXCEe0B/z91ESH8Knfs=
X-Google-Smtp-Source: AGHT+IGzZVWQFKGFPRlSV+1U40c2zc08NGC6CIm6+7ow+62WSgAyqJwDMpv69O41zQOGQ11r0GAMxvoCgYHdQi/kIQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:1726:7620:90a1:78b9])
 (user=almasrymina job=sendgmr) by 2002:a81:9a93:0:b0:610:3b7a:c179 with SMTP
 id r141-20020a819a93000000b006103b7ac179mr3808941ywg.8.1712158129686; Wed, 03
 Apr 2024 08:28:49 -0700 (PDT)
Date: Wed,  3 Apr 2024 08:28:40 -0700
In-Reply-To: <20240403152844.4061814-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240403152844.4061814-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403152844.4061814-2-almasrymina@google.com>
Subject: [PATCH net-next v4 1/3] net: make napi_frag_unref reuse skb_page_unref
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Florian Westphal <fw@strlen.de>, David Howells <dhowells@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"

The implementations of these 2 functions are almost identical. Remove
the implementation of napi_frag_unref, and make it a call into
skb_page_unref so we don't duplicate the implementation.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/linux/skbuff.h | 12 +++---------
 net/ipv4/esp4.c        |  2 +-
 net/ipv6/esp6.c        |  2 +-
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 03ea36a82cdd..7dcbd27e1497 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3513,10 +3513,10 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
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
@@ -3525,13 +3525,7 @@ skb_page_unref(const struct sk_buff *skb, struct page *page)
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


