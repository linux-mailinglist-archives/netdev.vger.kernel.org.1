Return-Path: <netdev+bounces-230185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B857DBE50F5
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 20:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CBB942034A
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 18:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B5622D4D3;
	Thu, 16 Oct 2025 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPBHzjG1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3081122DFA4
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639360; cv=none; b=mJRlVz9o5lOCrE5++Pmwv5t9lQm5DM8DlSRPK2D27pHvuWnqks3nz6DS5U5JxKGD6Aw6cWVDCpPmc8e6fKZ6hhIJPnS+Go2we1F/EiaTIr2LC8AO7FWo7hbQo2xGWGyllee8rK2hB7rydcTsT+amM8yY6zjdu5k6D83YHXESyVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639360; c=relaxed/simple;
	bh=x5Jaq+JBpq38mlqi7Gg+Gf05Q932HBORuzTUpeVtz3o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LnyQtTiSbx8IooD6Icc9T5MbmeuvwGoZVLorUFMS0UMeyZz9qWsMaZFzfwELe5kconeooI3VMonijRT7KZKsEI77Bnzwkoj6KyOx+scGWJbOjjiQQ0vg2bYt8O9CbBe+RziHVFzCtRQEDLcVinT+og4hx0KAgVAkf3S2e/uQeBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aPBHzjG1; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8635d47553dso311464585a.0
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 11:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760639358; x=1761244158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4l8SQ4OOK172Q3dBpkpKC++uxZPZsG2CboZhjDRqWsI=;
        b=aPBHzjG1wzCY4fk9NkiXovn1sswrhjc1cd80NLWyVvszDXcCYX57a3HkAhzcmtEKn+
         ih4nWMo3PtkFXPIZWPpP8ojWHzprBY3v4Tf+JTwMOT2unMkZ8e0D51gbeWoZyRHeaOlQ
         HMhtiI5AC9DlcqoYSdia+kf2EKivemU1S5JG6BOj7WQYWJPQwCjDHvYKsrs2BefYICX/
         PA4RA9ggXsOizX8Cq0sL5P3xEPeXxD7JO0pQyBjPBYF0/KiZGFOr+xutjN5/Q3UB6hR3
         oz+mvIApI9zx6odVyWs5sllLSO/VPsP6/qlB27Vmal88hqR1qq47ANbQ1AnXzawoON6p
         5XAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760639358; x=1761244158;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4l8SQ4OOK172Q3dBpkpKC++uxZPZsG2CboZhjDRqWsI=;
        b=Sd6mzou8FB0WrxaIWJmuMUa5zuRr3fWTlLOmUIaYZVYM/wPjfr8OO2kLWbnd9Ttxz8
         dYgg7EgR4lpWNel4ZkAH+kr6HH7Bjal9cmWlVPtyehEhEra+1oqRYFylt8J3t/1ZCEfZ
         eB0Gen1fYAX91qPVRdhDB8qBbRaJ9gZe6sayVDMa7w69IrIJOMHQdnbfT4BYA7vpG56w
         SvBdFNAC/DDSwahAkrH+ooDNVIq5sRPUAAyfADrZd5LKmp5/x+1F6VHEEjyzMoXZilQk
         8qYtrkG8m5+BTVJb+AAiEOWu1vP/5Z0wsL6w1QTRzu4D+VSDKI7YStUQX0hfsiO8QwXi
         Jcxg==
X-Forwarded-Encrypted: i=1; AJvYcCWR+i0axRn3vTIMl+f7Bg/Pe1hC9bDH6Q4AIkpVTTmZtElGvpJWkEV20RG/FF7/yndOfI4W0KY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Iq6PRyf5Xi6SFIsvTgL/8wlBG08ihKdp1HAu9piHgVhizgzA
	zOr+KIP2ijBGXo4T/Amyb+aK3ExYUupBi40xgM44zyLpAD0QCI2VnGBwkeJ/aad+sr+hX5FUOwg
	x+armnbego+N7Ig==
X-Google-Smtp-Source: AGHT+IFDP5LQL4KwcSL67L1COA1D2rc2jC5gopfag37kf44Qh8PyNevZw0CfOifBN3bRSojw4bv5W2ZulOiJbg==
X-Received: from qknwj8.prod.google.com ([2002:a05:620a:5748:b0:84b:6051:b4f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4725:b0:890:e3e:a64 with SMTP id af79cd13be357-8906e9a44cfmr151925385a.35.1760639357959;
 Thu, 16 Oct 2025 11:29:17 -0700 (PDT)
Date: Thu, 16 Oct 2025 18:29:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016182911.1132792-1-edumazet@google.com>
Subject: [PATCH v2 net-next] net: shrink napi_skb_cache_{put,get}() and napi_skb_cache_get_bulk()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"

Following loop in napi_skb_cache_put() is unrolled by the compiler
even if CONFIG_KASAN is not enabled:

for (i = NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
	kasan_mempool_unpoison_object(nc->skb_cache[i],
				kmem_cache_size(net_hotdata.skbuff_cache));

We have 32 times this sequence, for a total of 384 bytes.

	48 8b 3d 00 00 00 00 	net_hotdata.skbuff_cache,%rdi
	e8 00 00 00 00       	call   kmem_cache_size

This is because kmem_cache_size() is not an inline and not const,
and kasan_unpoison_object_data() is an inline function.

Cache kmem_cache_size() result in a variable, so that
the compiler can remove dead code (and variable) when/if
CONFIG_KASAN is unset.

After this patch, napi_skb_cache_put() is inlined in its callers,
and we avoid one kmem_cache_size() call in napi_skb_cache_get()
and napi_skb_cache_get_bulk().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/core/skbuff.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index bc12790017b0b5c0be99f8fb9d362b3730fa4eb0..143a2ddf0d56ed8037bd46bddc1d7aeac296085c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -274,6 +274,11 @@ void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 }
 EXPORT_SYMBOL(__netdev_alloc_frag_align);
 
+/* Cache kmem_cache_size(net_hotdata.skbuff_cache) to help the compiler
+ * remove dead code (and skbuff_cache_size) when CONFIG_KASAN is unset.
+ */
+static u32 skbuff_cache_size __read_mostly;
+
 static struct sk_buff *napi_skb_cache_get(void)
 {
 	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
@@ -293,7 +298,7 @@ static struct sk_buff *napi_skb_cache_get(void)
 
 	skb = nc->skb_cache[--nc->skb_count];
 	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
-	kasan_mempool_unpoison_object(skb, kmem_cache_size(net_hotdata.skbuff_cache));
+	kasan_mempool_unpoison_object(skb, skbuff_cache_size);
 
 	return skb;
 }
@@ -345,11 +350,9 @@ u32 napi_skb_cache_get_bulk(void **skbs, u32 n)
 
 get:
 	for (u32 base = nc->skb_count - n, i = 0; i < n; i++) {
-		u32 cache_size = kmem_cache_size(net_hotdata.skbuff_cache);
-
 		skbs[i] = nc->skb_cache[base + i];
 
-		kasan_mempool_unpoison_object(skbs[i], cache_size);
+		kasan_mempool_unpoison_object(skbs[i], skbuff_cache_size);
 		memset(skbs[i], 0, offsetof(struct sk_buff, tail));
 	}
 
@@ -1428,7 +1431,7 @@ static void napi_skb_cache_put(struct sk_buff *skb)
 	if (unlikely(nc->skb_count == NAPI_SKB_CACHE_SIZE)) {
 		for (i = NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
 			kasan_mempool_unpoison_object(nc->skb_cache[i],
-						kmem_cache_size(net_hotdata.skbuff_cache));
+						skbuff_cache_size);
 
 		kmem_cache_free_bulk(net_hotdata.skbuff_cache, NAPI_SKB_CACHE_HALF,
 				     nc->skb_cache + NAPI_SKB_CACHE_HALF);
@@ -5116,6 +5119,8 @@ void __init skb_init(void)
 					      offsetof(struct sk_buff, cb),
 					      sizeof_field(struct sk_buff, cb),
 					      NULL);
+	skbuff_cache_size = kmem_cache_size(net_hotdata.skbuff_cache);
+
 	net_hotdata.skbuff_fclone_cache = kmem_cache_create("skbuff_fclone_cache",
 						sizeof(struct sk_buff_fclones),
 						0,
-- 
2.51.0.858.gf9c4a03a3a-goog


