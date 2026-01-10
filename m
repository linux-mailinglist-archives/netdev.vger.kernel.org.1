Return-Path: <netdev+bounces-248659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F4BD0CD0E
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 03:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47AC630492BF
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 02:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E382580F2;
	Sat, 10 Jan 2026 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmh4gQv6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7C823EAA1
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011544; cv=none; b=IVkNA96BjsripRlZVFuiy1XEGvkS/GjIqDQfUNCMHdvxEGbXGrVk9d2xgfGLR9Bqr8K/UZNZYaKsohl8xxC9e1sVjZ/DS1aWzG0/QnJ3W77lxufkxQ1ccRKXWnu/vEDmwBEi21l1GhKp9ILtnMpxE1d3WOMEYk4MkTFHonOFWmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011544; c=relaxed/simple;
	bh=/8irlWx212MZNFNuTQquG/o/4qXs4GzUcqgDeIkWkeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZSDyfvOK3D3CvnqaVHtSdRMdAviTTagmC2VoVtfoEzaViPFKrJwetkZhuas1J7qn5Eoqt5V6FYCUmOmJC6n38ZyBXQ8n2ZdkEtbWeY/nyCkmqHeeQPKGuvb2yta5wiiiMS/7iP22YVioup+Oz2pjtvz6kOf6Xic6oLdqd/8brGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pmh4gQv6; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-646b8d2431dso4141898d50.2
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 18:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768011542; x=1768616342; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJwRH55S+4zS4rc7LIeDbyFWVKjFx7zOxvxC4DTtZFU=;
        b=Pmh4gQv6CDB0sn4MOfoJNJplhGdYkdl806mn+HX/jQdzPnHdNtrmIAkAo6WQeipPFj
         q9IP8/gve/ApA78ioiaTE2hknb/mgSj2O66aYQia5uxObrhYl3SKgYdWUGtyM9GUoHIp
         YgdmgchvIoPttlKzKoVZXqls4rg02rtkJuweYqJSeD2oyD5i2I82qZhEKy6Mczv/KMBl
         CFkzK0QFpNV2jpONeDQsqjBid0Eclzv7/ESnvQriZUGTGIez7szNmuh+x3NKf5eGMRyC
         bntgEz+0P95+q2V4sfu5TeyGDkHRG9/cwbCJXisuHKvThcw/lwl+Y9e8bkDwUdV2KN07
         GNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768011542; x=1768616342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vJwRH55S+4zS4rc7LIeDbyFWVKjFx7zOxvxC4DTtZFU=;
        b=L/LU8OdgEFf9saEL6gR0/h+AC/RjkbvKuzJzvSi1LC0f9sSDR7PoNB7f/wEyHTy2sR
         Fa4vRoSfHJKrsbnt2j+imt+SJCkKK5THG2TsH/wsPeMAcF5wtbL6FW4psT3iLn0ClgLE
         g8VQcUgxgmFknFs7TrjyKN/U3gJLRnQPB9QGZZ98IgHBiVTMfLpezHFEz33gqe/WNQ71
         v2tExFmtFgUTxay3NptNyYlDPCGVIZhteP5rT7InGy0kfaUBnms3yTSL95Nfo6f36vC3
         oDY7oPPIQ0higNWjyr99PvnHWNG9XJeGcv+SVw5ifcXLWkhugIacf7xfm0UX//pkkb3x
         QkCw==
X-Forwarded-Encrypted: i=1; AJvYcCV/jHrK5sueOx8Eoh12RuTihFy/uJZKsPZu8t6kyvJU9/+tjjHBUwX3lg86rXPIBBVQ/Mr95qE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk7f4NLSaWBuIff5gRf4db6O+jhHbpSdLjXaBDOcSHbdwUFZrc
	IYiyCWzwTJmTTxn3bzlXzNYcYZYa2I96G5qCZnc9DkB9UA0Fge1aUhYk
X-Gm-Gg: AY/fxX43Ofr0FxqqgnUApPwpRJA2sNpRoAM+3GLpcZ4gPI1lP12TjyQsAVxI6ngZG4P
	avrIedI1//EZVGxFPwMeqNnfNQzsW+c4UuI3PxvilThvh1dGCxdrNZQxS3Yo0dGeUPqttY87QT9
	EaXQMxGf4m01Q5o5GfbpCV+OS/pOCCj1BUND9BxHyDmkzzXAbvW5EdTbxD8gnWXjM8XXJwB43Bz
	P11awSeoJJA0LRnBAbG9BJjxJUGPMdi3B7ajQNegjZto/xA/Zsp1dU8PZAJNqnHd548xf+m1dli
	R7mXb+0VUw5PJFRTEMKZUEgESI1e/UhJ1CqPtON4UKK/qLLCCIqF/xjgYMtKC+I+JsaxRZsg7Pj
	lqdkCCFaJ05qFO5X5iDzYtrdJfI22YRBqcLpv+VCmGjO1TNxgtkEtUuEfXCAzhRboiK1mNh5mBk
	QKjSMJFLS7+Q==
X-Google-Smtp-Source: AGHT+IFOmZSfq1+B/UIacsFnpLVgmv9FPVdwArttfHVymmNEdJMthIaDrn+0zcXw3EHB1ioYKpS2zw==
X-Received: by 2002:a53:e319:0:b0:644:7b34:7bd2 with SMTP id 956f58d0204a3-64716c804d2mr7062728d50.75.1768011541886;
        Fri, 09 Jan 2026 18:19:01 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8b241csm5204761d50.19.2026.01.09.18.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 18:19:01 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 09 Jan 2026 18:18:16 -0800
Subject: [PATCH net-next v9 2/5] net: devmem: refactor sock_devmem_dontneed
 for autorelease split
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-2-8042930d00d7@meta.com>
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
In-Reply-To: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
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
index a1c8b47b0d56..f6526f43aa6e 100644
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


