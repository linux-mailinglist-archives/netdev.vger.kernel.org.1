Return-Path: <netdev+bounces-247915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E95D0083A
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 01:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD3EE30039C7
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 00:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A19212FB9;
	Thu,  8 Jan 2026 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqWmDDEP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4814D1F872D
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 00:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767833924; cv=none; b=aHS7i3hNPr9/eRm3LRzZXyLz8JZvtQ72Kv3zBsOdFLINSHz+AGCTOqQx5EUUi0oJUnhBLFmC8n8STD/5L1wUL4AOHNnlINhOxk3U5e5PnLOoAYSD7/btZnIch7r/1nA0hSyFdgmWQcPraEGmITZ6B4r4pfOqE7X3OcmXN8VQz1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767833924; c=relaxed/simple;
	bh=yEzJ3QFqJEMOCSgYnwJO8nTuZMKBVcvq+HA+PHxU/yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WDKUrKYYd++xPPB3Lc2NwkwHiAG8TdOl9ShRD3kOUj9SsFWSj4k5fTc3eJF8BRghcRn2P22GmqrBuv7BWDpdDbDvoxxsPlcUpaY8DBRCHjpy2pIgIe/idBWkAa4VZQZz2rr7278B9XNWkim9hdOiWbeRORu7HaXs/jPPNQLV3sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqWmDDEP; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79088484065so29522627b3.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 16:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767833921; x=1768438721; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxcwUUyeLF3N634r0h3gWr//mt0sjdpsyX6Na76fXWE=;
        b=gqWmDDEPzvDw3i1jVToG2tazNKarZJzsS929m/vevyyO7dcoGz5fxgkB+PY1Yr6aFO
         PtmkGLadnFUCuZHsio/RIpTDJC+aArfNi/37oTJ1PPnt7kB+UKZeTwJY40OuKwvLvKni
         vCF2NL3X6p2Uqkoxm3E8E+H3qhHci6WEnU3lz6oPWxi5xDR4DPsXVYM2i9nvnb6reuYI
         OKo4oOHfujsv/8YNwfR5XzMpRu8QS96/adf9n7s1tbhVbtfISj12s14WvRhO+J/oZZ+T
         Lc3NivwqQyZhaiO609f/s1CIO8gaEUqJ50DY9tyy8rF3cZX6DYm+mt7u9qewqVN8RhhD
         +I8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767833921; x=1768438721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lxcwUUyeLF3N634r0h3gWr//mt0sjdpsyX6Na76fXWE=;
        b=INcgmGXJ18KWnjKpGm3DB399X8ilxr9abli6aez8A7HDdjcnd/g/nLgiN7Y9XiUNPz
         5ej+F5iX4wiZQ53Qgb6y80vW3Ry0z+wO0gsIfcGO7+B9rSh8MgVytb4/3fxpwrhptERA
         ZSgOukb3VMYk1m9qcvbMw5VsFFj6lJ6223hgMr/sz3oze97TEs5N1rJ4J6zqjf7E5TRI
         2J2kaifaZ5Pq8lbm1baT02KvM53gZkkySgFK8QKWTI4IovDrRygnTCWqrzpFrc4lZP1R
         B35pOQTbgv71T2+PFJrPhyluhRmwGDrF4yYifMVPx4MDAS/znpxdcN09MypmRgVvpPH+
         WNRg==
X-Gm-Message-State: AOJu0YxUO4qIUjK8cfbQxVlDvZ3XpTori0RnjoZO0R29IVJXU2L8iNbA
	5fWxFFRXwYwgh6VfApET3GQSiOfuPXdx5xeJCluA4mXJ1Cicv82a2oi2
X-Gm-Gg: AY/fxX7LbQmV5EF/4tf+0mGTeuCVjJB1kYnIOZ39d8K+kJDm9LmvNh+/2z1fSohVX4U
	angnb8D1VsnzGofn+yUELFKj+TclQem46kEcH8g18aJAMcILEeRv4TQ+6XfyF3X7a2aMEhl/q/d
	le/oMjEyuA1cQPMu+mQh3bOwlP113rj6vIIMZZ8UFWdSGLuzlxO0pM/T7Wyg5M1IkxahGmiRPZZ
	URjEAR3IPplT41FM45buhJILe1xtOLiyMHA7geWcGWJdZoG3IjvCxqzAQ1kWo8NE4CUwUxvke7o
	VVHBjeepQoqXhj5xuckHiiuQa8uKXroq210tjnLIVoNghR59DnE7kpcBH4TzWLMRVCkCk0A7SVf
	AIDAeWL3N94oypcd9dE9DS99EYUKbyMVKAzd7tRRuWXwlmEZT5TBNqblIJMlDRMCXvgrM67zMoj
	DjlUbe4DfwnHaF7yZNwkEd
X-Google-Smtp-Source: AGHT+IFHk0bBnJUnAJm0mlyVWIOTUg1tPnVZCbcNGWEk8FS2m/HgVqpWwGTUKe/5Fp4+/MYhz2UfHg==
X-Received: by 2002:a05:690c:4910:b0:78f:bede:57c0 with SMTP id 00721157ae682-790b5758118mr90008177b3.23.1767833921038;
        Wed, 07 Jan 2026 16:58:41 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:44::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d89d4c9sm2728934d50.14.2026.01.07.16.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 16:58:40 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 07 Jan 2026 16:57:36 -0800
Subject: [PATCH net-next v8 2/5] net: devmem: refactor sock_devmem_dontneed
 for autorelease split
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-2-92c968631496@meta.com>
References: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-0-92c968631496@meta.com>
In-Reply-To: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-0-92c968631496@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

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

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/core/sock.c | 52 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 45c98bf524b2..a5932719b191 100644
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


