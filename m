Return-Path: <netdev+bounces-249015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D62D12B83
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3C0D305BC1E
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 13:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7E425FA29;
	Mon, 12 Jan 2026 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vzSKUPpJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE5D358D23
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768223719; cv=none; b=KhGwGeCnhRxY+G/E6BUJPrlZi2oBIe8lwf+ZSnDRN4fqQpqTbIFgkAPAgdM6T8qQ3qzJ+3SmjzNyWeiXk4mGePcPQilzCMTsb55XItbtcazvirK06ZJuisBcvPnaN46LbioHMxfoq6K2HQ6k2o79Zvwdal2V495KQObctkySXTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768223719; c=relaxed/simple;
	bh=LhOcpeJcHqa1igwCqRc5+tNMu/qR8by9bvyDzIqbNHw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WFRM2Hp57AR1kiJQd51Hn8i0ci2qBGzyuRQI1R2co6uMkUMiU55otlNUeiQ+0Ktio9OyobbrN6CCbS8boe9h+Fa3TaHL3yI4kRODXxndzFCojQ1Bpv03mUKbbtg5Fqa6stgQQ22gnyiptX1kyBM+DMmYmGZqvNYCXyjRvd8uk3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vzSKUPpJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-79043e14dfdso82013657b3.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 05:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768223717; x=1768828517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YSKPMjUKQFZkXncdezhcC0dL3TdZP2aGdtekHJ7PVwo=;
        b=vzSKUPpJ/LS1PYjjf0U1yfJd7cg5LZJ4YUdkUKdGLfN1baqP7u17YBAvO2u6KxQa//
         QhqyObbTOJ/8RIRBiRH+am1tgD4PjybQR7Jz/Rnfu119KO2tN5Q1T62y6ph2oLSU0hUZ
         GkPUWnd78bgMcXCyOVbw2QdaMj6QxzmAN6AmAh9ttyRJO4o5h8tAGD/lk3WsWkqwFL46
         +D4OFRY2F9A1DL/dvJ915YlF95/+59QX0fGgA5DFfxO8Bs2zLTdNAUfG22AkHt9RE3X4
         8IKmTTqiinreRgZwZM5iCE7sNbiI0yUpBuLqJIY/xr+zO3NDTspIwRzlR9rE7bl5k6AF
         3z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768223717; x=1768828517;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YSKPMjUKQFZkXncdezhcC0dL3TdZP2aGdtekHJ7PVwo=;
        b=op0vnEwSiQwI4ZZ9tt5we9fYm1uplMMY8ylJSX9eCRfRfNABI9GrckUK4mzNHvF3W/
         j0xUwR/EvvX018qveeEq+w+JmMcyCkJC7Zgde3bKql+jicU89aJr8Zp3fvyl+P6qPUc7
         ZEhwBj201WcMCHOiDi4NcFsvkNX219pYNdI01poweOLaiMpf5wluMd8toq9WmTsPVbtj
         Qy9/5ZgXosVL9a0Jk36lq7Zo0m8YtwboWLXsyKuXCGswpw3Yr1omhjzpJDqOTq6mDMV7
         3PP7bVxzRI/eOye/8nYOeG5ng5FcBZJC8BXXXX32VQKBgzpLhX9xgWbYLp4o2LPVrkAA
         8Xuw==
X-Forwarded-Encrypted: i=1; AJvYcCVQvCxTqGbYo6o4z9sGW8fzDdAQzxRZk/6tjuNMwpFgLq19bvGe0DdKXlCpeI1vjXBHRmwKkTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJkMWpLLSbIPfM2CVZgrub24x43LgWdqu5huMB5wdlDV521YtQ
	C0TuFWWLm1HSlS/Al8Yp3t/tuhprR7ffsEHo12IoMihPC5DNDKb2d7a3n/xjvRSg8847kZj95L7
	G1HtdGosnEsuHiw==
X-Google-Smtp-Source: AGHT+IFBbVlN/l9YvwZ1uax9Mv65fCDUhkOVfeRVUW71MdGjvA11TAoddfwFho9qNmqB60e4VkejUCZiTCoMRA==
X-Received: from ywbme3-n2.prod.google.com ([2002:a05:690c:8683:20b0:786:98b0:a64d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:b42:b0:647:108c:15b with SMTP id 956f58d0204a3-64716c0618cmr14234435d50.65.1768223716850;
 Mon, 12 Jan 2026 05:15:16 -0800 (PST)
Date: Mon, 12 Jan 2026 13:15:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260112131515.4051589-1-edumazet@google.com>
Subject: [PATCH net-next] net: inline napi_skb_cache_get()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

clang is inlining it already, gcc (14.2) does not.

Small space cost (215 bytes on x86_64) but faster sk_buff allocations.

$ scripts/bloat-o-meter -t net/core/skbuff.gcc.before.o net/core/skbuff.gcc.after.o
add/remove: 0/1 grow/shrink: 4/1 up/down: 359/-144 (215)
Function                                     old     new   delta
__alloc_skb                                  471     611    +140
napi_build_skb                               245     363    +118
napi_alloc_skb                               331     416     +85
skb_copy_ubufs                              1869    1885     +16
skb_shift                                   1445    1413     -32
napi_skb_cache_get                           112       -    -112
Total: Before=59941, After=60156, chg +0.36%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a56133902c0d9c47b45a4a19b228b151456e5051..9e94590914b7f9b1cc748262c73eb5aa4f9d2df8 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -280,7 +280,7 @@ EXPORT_SYMBOL(__netdev_alloc_frag_align);
  */
 static u32 skbuff_cache_size __read_mostly;
 
-static struct sk_buff *napi_skb_cache_get(bool alloc)
+static inline struct sk_buff *napi_skb_cache_get(bool alloc)
 {
 	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
 	struct sk_buff *skb;
-- 
2.52.0.457.g6b5491de43-goog


