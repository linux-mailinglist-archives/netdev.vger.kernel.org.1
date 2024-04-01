Return-Path: <netdev+bounces-83819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB598946BA
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 23:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26802281CC4
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 21:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8684556760;
	Mon,  1 Apr 2024 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HjKnPO1X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB455E75
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008251; cv=none; b=t5RyjQxhbkojVvg+aS8A4hnlUu2pkXcFofeuj346A24KGscF9M0DhLd6Z0tr+hLoNSwmBvCnPncUxesupcbLI8QnD35pcYSxKjjXWurhK+gDumX1YL/s6R5IfThuGBXkoIvsQnil1kp1R6OGW7A5xliINAQ0t/Ik2/FtrVy00TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008251; c=relaxed/simple;
	bh=6iZBHoWjr0SW3V6W6W27wiyE26vfswz1Bipp3C2ZJ1U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tHqAg+uQ6vSoa9aSx49dbhBhpkCvkIY7x7lIdbEyNjsjErLdaw8TOGcNc7W+pS1uTWav7hl1ZvWTOiiQrmDKCdhHvwhmAg1C4HmqzaLqZ1R0pDj7s5NKB7SvLOsNS9kxDJFQdZCTqKJJ7TSDS8kMosQnYGHktuwNr2lWqvc8hUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HjKnPO1X; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc4563611cso6982427276.3
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 14:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712008249; x=1712613049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vXRjUgtATZ0E/Y+63Z5tthtMhFwiRvlicbw1JhZ19s0=;
        b=HjKnPO1X+5vnnXZwur65PtAbEkhrJjqCGqoJ0jp0cSakPTSxdYEohUFjCbOQ63JyPa
         wk7QyPA0hZ/tnOLPqnGYfhypKU4lABA+f8H7yYq4Px5ZB2xqQsSWgpXy8Spx6zuuvhDv
         /MrP32IQRGNX9IS8ySxabzO9O+WUxS1cIpqq/tpNiV6no+YrO9qjPkyKsO3eCgjXUDXy
         WBdumj/i1PQFkhfJ1NaDL4TthEFAe0CzWQXGoA4+fkiPexcbcc7riRLIoBXzxaihJIUH
         xqIxfQ1ijIv0tPs7lYsq285Ak1Y0pnz5YgEB5PyiFWLtx6qsRovXpxX9iIgSVq6lLlOx
         to9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712008249; x=1712613049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXRjUgtATZ0E/Y+63Z5tthtMhFwiRvlicbw1JhZ19s0=;
        b=oM5MS4IbPgLjgxwFlkp86axaPB/Ihog9ensX4Qxm070P5GR5YM/uj242C89YqtjFp9
         o4Vvfu/qC7WOMzuDk3IzX0lqqQtbxtNzlBWBLdPaIDUp7aY5msBl6mgSUjQBPLND6ATp
         2Ew2h9uWVQ4XP+QAPyToiq4ZS+TSvvPH3+jf0/MdcMR9S4/+FiD5jeRWD2lhDV5SmpQc
         pgbQi7hZIIDYuR8d7gQHQnUOiV/KlURT+tjSdgZOZvfLxA0dqhQEhy1qCSlEKBhLaRYi
         jRRh4uLTNoOOnekkL4GnQy6UAQVcGgoKwi4t9vx9J35hkGJqS9bqD3kUUhWrXHZn72nF
         adrQ==
X-Gm-Message-State: AOJu0YzmKCg2se+tGEJOeY+EeqvFvlDPQeB9d7Cez+l84W1f67ZOX4QC
	IZJvq6aaSPhxAcrykuGZAjUufCYfnHqoD9xUXTs6kEq1/61Q9b/YVHy6LldubRJVBxtjPkqID+U
	4M1ADRx4rbBcZqJm/N5lqw73S34Eys+I/IdK8MkmFJBOYubAT9ryDYOXcaQWyEFPJgOW4uUri/Y
	gbbVfXuNKjaWl5buhWlzji5u7nr0C6PbGwXVcKbX5DUhUAQx5DM4L2Bw+wIUo=
X-Google-Smtp-Source: AGHT+IFGadfogXIS8kOngK5G9vWIutCMBx8L4gKWUrm8XeH+h8lfoSVo1ljXz4C/IkewoV3oHHDRSuJKCxCHbdkprQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b337:405b:46e7:9bd9])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:72d:b0:dc8:5e26:f4d7 with
 SMTP id l13-20020a056902072d00b00dc85e26f4d7mr3443884ybt.13.1712008248349;
 Mon, 01 Apr 2024 14:50:48 -0700 (PDT)
Date: Mon,  1 Apr 2024 14:50:37 -0700
In-Reply-To: <20240401215042.1877541-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401215042.1877541-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401215042.1877541-2-almasrymina@google.com>
Subject: [PATCH net-next v3 1/3] net: make napi_frag_unref reuse skb_page_unref
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
index b7f1ecdaec38..a6b5596dc0cb 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3513,10 +3513,10 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 bool napi_pp_put_page(struct page *page, bool napi_safe);
 
 static inline void
-skb_page_unref(const struct sk_buff *skb, struct page *page, bool napi_safe)
+skb_page_unref(struct page *page, bool recycle, bool napi_safe)
 {
 #ifdef CONFIG_PAGE_POOL
-	if (skb->pp_recycle && napi_pp_put_page(page, napi_safe))
+	if (recycle && napi_pp_put_page(page, napi_safe))
 		return;
 #endif
 	put_page(page);
@@ -3525,13 +3525,7 @@ skb_page_unref(const struct sk_buff *skb, struct page *page, bool napi_safe)
 static inline void
 napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 {
-	struct page *page = skb_frag_page(frag);
-
-#ifdef CONFIG_PAGE_POOL
-	if (recycle && napi_pp_put_page(page, napi_safe))
-		return;
-#endif
-	put_page(page);
+	skb_page_unref(skb_frag_page(frag), recycle, napi_safe);
 }
 
 /**
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index d33d12421814..3d2c252c5570 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -114,7 +114,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(skb, sg_page(sg), false);
+			skb_page_unref(sg_page(sg), skb->pp_recycle, false);
 }
 
 #ifdef CONFIG_INET_ESPINTCP
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 7371886d4f9f..4fe4f97f5420 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -131,7 +131,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(skb, sg_page(sg), false);
+			skb_page_unref(sg_page(sg), skb->pp_recycle, false);
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
-- 
2.44.0.478.gd926399ef9-goog


