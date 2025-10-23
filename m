Return-Path: <netdev+bounces-232261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C44C037A3
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 23:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FC63A374A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 21:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16FF2C11F8;
	Thu, 23 Oct 2025 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3bmhMCT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F45292918
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761253235; cv=none; b=hVHDH7DzzS4d5GhTgdBUdWqmFwd5EE/RLWSaAGvAsgaD7CAHzSazjglfFpbQ7YOx3AHaCpgvbjy7U8vkq+htbqdtBtaOC9CzwFjSktI4Lh0SoBLrcLMWKxXIuR4VpYgEyf/H9Ep2K8H1y+E9r5wBEUjaMKJ9BEUk72bnM+Bm5zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761253235; c=relaxed/simple;
	bh=gXo9qbz0VuCHxtbMD6pT4iuXLZL3lwwihvU29sxTKFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mFzcLYwsAc7O9QWZmcUNpFR8v4ePpdrXq5AKyXkqhC1ejUnFDsCRcjXbJWHt4esiqa+20dt8EHtgTyBaBySa40psvSlveBI5EGSg9Koxz6OACfe8pGfTZwUcf/6GScKvE683/Ld8mZCyXDYzO0Tw9gukCNGtz8yq++oaNbse2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3bmhMCT; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-783fa3af3bdso15689937b3.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761253233; x=1761858033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQD284fTBTbrkTq+WZ5fQmnQt2qjwJsfpEi9I4GFfrI=;
        b=m3bmhMCT09Q9AQcAmF1weSiVikcvW+LyruZrTzO8OLZNxYfKN5NY0VJr4DEG+QwqzB
         MbHh2tkbqkXuTIRl7ytOnFxF3fmzVqWNbfTj5frlX7ZzB64OR8rf7vJEwkP8otuwZfqB
         Cy0NmWUwv8pueirW1VIkLkddZkW8h9SYNH4EPCdQnEzOYKkEFhJRfmH+cRg96+3cRhYY
         q0chyXoQTQGPXKJb5KSMO2vQ3oHqbIP6iJrCCxea7GQwYZUZa2NyjrYeB/A4zrBmB7lt
         kuFgDy2Def+vmOYB+5WjelLA+BHsZG7N/mCunF1doxgfJXsfIPBOpZlbWCugE29BSJIr
         7rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761253233; x=1761858033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQD284fTBTbrkTq+WZ5fQmnQt2qjwJsfpEi9I4GFfrI=;
        b=XKEmScbP8leoSChKod6HnRqV1CthEHwy6chdSgAI4nBk362eJrnR8p3N+85E+zKTf3
         dNo5yBDrVhaeL0B2t3m+/kZDbn5R85R3MqYMAdRpoVdkdzu2FYw//yf0xHaeHD4KB//Z
         bBNtqf7z86NRFZH534bXrgNtkzAjc8AILoKy8Qhxrf2bcPMUS3k+ysyN44wzzLhZ/KSk
         juku2yRDsx/dS51q38HuL6SlV9Bas6yV25BYAs0BgnB5bubrTcoRo12zY8eeK0y+Ua62
         ogrt+vNTI2OJQqQ3y8PjDUrUuNDjJsZl4nodfyjm0Yvda023wfIoKYouIUudC19HOkS4
         aQDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9meFl1QuyILOvCmbl178MKGCk0gew3oSVTSrwlaIJ0carUnCXcK6QAtrEiN4twnD+3TUf2hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymD04KuR25s6Gj+ZPECX/A1wJK9iBPBlTj+r6FWz8JjbLPv9le
	VTLNBilOs5bmrompCpB4Xu6lhvvkdXbnOuwXS4kGEZhmB4cuJYDMTd/F
X-Gm-Gg: ASbGncstXQKJg+5TgTVC6KoJAe6IvlZ7bfCSIsBTUOIi20Xc4dqLjJhM+9V7eF9sM3f
	LIZpKW+In9hyGSE0xXfM36swpE8M2+mEKLA91i3etc813f8qro8yoAA3wHkrzICY20ZC7jWUISq
	RjvFobJOvx0SQPWAWb4hpgGHG2GdYQKUijDV3UVtqqXDbkhuAITBM6959c2Okhw4ApUUMJ1sH1c
	+GX18HnJ64LzMnuCbw6i6aSlPf88+pdn5l0FhZbRBTd7oY2ipk1cqqfT9HF+qHEgFt1UOcLaAfG
	gJS/qA/1mbzhzTnr656g/4wqekYbQUnRVNQqzARSKJ9ATLEbtuYBw9IweST2ihveMeJ+0+VIcxA
	qK0Bza/PsBF+xFzLoCDmw7ve5jQF0fw3nsDqRsVuV+qirju8p3qL53DiZ0JT8Xp6CjBN/sZW+Nu
	pTWIuR+/mEy1spMLcskBTycA==
X-Google-Smtp-Source: AGHT+IHG/Cr/c5i3KEq5Iudl/DqdJmXfAjdFgBWwqT8Ofxgiwu4nbIqyDzUfL0S4iZJRC+QoUa35Ag==
X-Received: by 2002:a05:690e:144e:b0:63e:1d55:725e with SMTP id 956f58d0204a3-63e1d55738bmr16418017d50.58.1761253232907;
        Thu, 23 Oct 2025 14:00:32 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f378ef44dsm969494d50.7.2025.10.23.14.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:00:32 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 13:58:21 -0700
Subject: [PATCH net-next v5 2/4] net: devmem: refactor sock_devmem_dontneed
 for autorelease split
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-2-47cb85f5259e@meta.com>
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
In-Reply-To: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Refactor sock_devmem_dontneed() in preparation for supporting both
autorelease and manual token release modes.

Split the function into two parts:
- sock_devmem_dontneed(): handles input validation, token allocation,
  and copying from userspace
- sock_devmem_dontneed_autorelease(): performs the actual token release
  via xarray lookup and page pool put

This separation allows a future commit to add a parallel
sock_devmem_dontneed_manual_release() function that uses a different
token tracking mechanism (per-niov reference counting) without
duplicating the input validation logic.

The refactoring is purely mechanical with no functional change. Only
intended to minimize the noise in subsequent patches.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/core/sock.c | 52 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index a99132cc0965..e7b378753763 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1082,30 +1082,13 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 #define MAX_DONTNEED_FRAGS 1024
 
 static noinline_for_stack int
-sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
+sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *tokens,
+				 unsigned int num_tokens)
 {
-	unsigned int num_tokens, i, j, k, netmem_num = 0;
-	struct dmabuf_token *tokens;
+	unsigned int i, j, k, netmem_num = 0;
 	int ret = 0, num_frags = 0;
 	netmem_ref netmems[16];
 
-	if (!sk_is_tcp(sk))
-		return -EBADF;
-
-	if (optlen % sizeof(*tokens) ||
-	    optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
-		return -EINVAL;
-
-	num_tokens = optlen / sizeof(*tokens);
-	tokens = kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL);
-	if (!tokens)
-		return -ENOMEM;
-
-	if (copy_from_sockptr(tokens, optval, optlen)) {
-		kvfree(tokens);
-		return -EFAULT;
-	}
-
 	xa_lock_bh(&sk->sk_user_frags);
 	for (i = 0; i < num_tokens; i++) {
 		for (j = 0; j < tokens[i].token_count; j++) {
@@ -1135,6 +1118,35 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
 	for (k = 0; k < netmem_num; k++)
 		WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
 
+	return ret;
+}
+
+static noinline_for_stack int
+sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
+{
+	struct dmabuf_token *tokens;
+	unsigned int num_tokens;
+	int ret;
+
+	if (!sk_is_tcp(sk))
+		return -EBADF;
+
+	if (optlen % sizeof(*tokens) ||
+	    optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
+		return -EINVAL;
+
+	num_tokens = optlen / sizeof(*tokens);
+	tokens = kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL);
+	if (!tokens)
+		return -ENOMEM;
+
+	if (copy_from_sockptr(tokens, optval, optlen)) {
+		kvfree(tokens);
+		return -EFAULT;
+	}
+
+	ret = sock_devmem_dontneed_autorelease(sk, tokens, num_tokens);
+
 	kvfree(tokens);
 	return ret;
 }

-- 
2.47.3


