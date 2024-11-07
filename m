Return-Path: <netdev+bounces-143067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3BB9C10A7
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0261C22AA2
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 21:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC7A21859A;
	Thu,  7 Nov 2024 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F4ZgETcx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6A021791B
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 21:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013422; cv=none; b=Wxw06DLtBOYvJHhqD3uv6uqU+gvgwrLk3js0Pqwn45WmzHf6aP0h0bmi4FW8ici6m3sHTviT2KT+3mnrnfPfJUkQaz4NfiGmsuZcXAHPCP0PfDuBsIlrRiXP91U7Q6GuAgIuMGlUnPZJGKxINWhLvCwzuRL8Xq/3P5MUDTwA0UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013422; c=relaxed/simple;
	bh=civGn8AOLnkkItaTkVumLX3t2LIKqYvKfLEoz3kM/bU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=szw6kMDVPQpJTic7E6Ez8DOiH+Nqyp3BXH9iyr6uDxzANsAkAWBuLvhlETemKaxZrx8FZ5W6Odtq+YeWdXpoqDZz21dpkqP1fQ27SBlD8j/zRm3K+5YJvKD/FxZSjYy9fpm61gep0fW0tmG6KcksFWJiJ3scWGeKbcayHsQrQl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F4ZgETcx; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3313b47a95so2800179276.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 13:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731013419; x=1731618219; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5SJO6M4C9QFKKYkluqAfeLLMUm8DSpI0xGxHzKk7nR8=;
        b=F4ZgETcxbSNaAfR7TLLlsCu7Vlz0Y8YRoP8niWAtNa/Y9u0Z5kiUoJ0s1dGst8RWxW
         GjyyPCoEH1sSXRlw+COiQq/lqolqNyBIqZVX9tZF6GOr1OATvy6vdKp84B8cr1Pn9xrG
         dRMXO3WSb4/laZM1Db0LNBwcE+NNPgCHwxCe48F92PEFZmZbmoAL2zqruJioWMp6pOgl
         NO9TIsFAe7TsJ0Vcny4xhc3efVn82biUST0KJ/5fFtf8VHwY0Lu/Rk9Wrk/QOY9Tdb83
         a8s5SAURyNaTcCd19NiqpsHvEI2uaCIt5ItSu/nyX70WIpIna+KxBwMhPk/sz++p4MHA
         WcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731013419; x=1731618219;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5SJO6M4C9QFKKYkluqAfeLLMUm8DSpI0xGxHzKk7nR8=;
        b=DPuYKLvV/o/1wYJ+V0nWQ9GXg978gMQujLUFiKTFUlp+mbF1CvWKVfnp/s9H+K4/GY
         yKONZw6fA4L4pmeWt0q6UfoD/CW/lQTcdwB4aovG6Lp+YXbIoYVRl/FMGVADTE/1VVhX
         UNLxwhGqULNrnvyjDUSvENAoX7RbAXYj4dvWrDGdln3jTxQEZnzL4lDIwQcv54X8RsiH
         9Y+zn04uv+Q50bNTuP68tIQQCH5qFKief1QP725tLYTDbIRvxgbt9N4Z4mwNaaIAUnqC
         unj1aYGfcTt6ll8bIaLhqViqvCs5kgwfOlMpCLrVXKF0OBs4Bojk38RDLLVwpm6o6noz
         J9PA==
X-Gm-Message-State: AOJu0Yxc0s2q9mqlDWa8VlgqFzx52NcEZY2tobC7JU63orkKrAfO3ugv
	TcuLJzgG/e22HobZVvbIdPZiRm4wRl2NNrKBmmuFhkQXX4n2Y3+Wx7aEhdmP0acLFDwE6CsC+Bd
	Abv4LbbpsYn11qfmK+l1FL9OS0mnXeXjYyxqFuzX9JfG8MYpmvNyPt0L7BmtpZ3gDKz39haOGHS
	jpvnKq6wuxOZCyQF9/8x20Ss8q5CbBugGWqMoo818g72xdcWFnBUXTKNLimPs=
X-Google-Smtp-Source: AGHT+IHjwx7sH6wFSQU3Jtjhv7wdoD0ysl51bSGbhAjx0kaPpMRTbmj2GudU/nj89S1B95sa7RR3EZifPgYc9aTqMQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:bc84:0:b0:e2b:d0e9:1cdc with SMTP
 id 3f1490d57ef6-e337f908f8dmr505276.10.1731013418661; Thu, 07 Nov 2024
 13:03:38 -0800 (PST)
Date: Thu,  7 Nov 2024 21:03:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107210331.3044434-1-almasrymina@google.com>
Subject: [PATCH net v2 1/2] net: fix SO_DEVMEM_DONTNEED looping too long
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Mina Almasry <almasrymina@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Yi Lai <yi1.lai@linux.intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"

Exit early if we're freeing more than 1024 frags, to prevent
looping too long.

Also minor code cleanups:
- Flip checks to reduce indentation.
- Use sizeof(*tokens) everywhere for consistentcy.

Cc: Yi Lai <yi1.lai@linux.intel.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v2:
- Retain token check to prevent allocation of too much memory.
- Exit early instead of pre-checking in a loop so that we don't penalize
  well behaved applications (sdf)

---
 net/core/sock.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 039be95c40cf..da50df485090 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1052,32 +1052,34 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 
 #ifdef CONFIG_PAGE_POOL
 
-/* This is the number of tokens that the user can SO_DEVMEM_DONTNEED in
- * 1 syscall. The limit exists to limit the amount of memory the kernel
- * allocates to copy these tokens.
+/* This is the number of tokens and frags that the user can SO_DEVMEM_DONTNEED
+ * in 1 syscall. The limit exists to limit the amount of memory the kernel
+ * allocates to copy these tokens, and to prevent looping over the frags for
+ * too long.
  */
 #define MAX_DONTNEED_TOKENS 128
+#define MAX_DONTNEED_FRAGS 1024
 
 static noinline_for_stack int
 sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
 {
 	unsigned int num_tokens, i, j, k, netmem_num = 0;
 	struct dmabuf_token *tokens;
+	int ret = 0, num_frags = 0;
 	netmem_ref netmems[16];
-	int ret = 0;
 
 	if (!sk_is_tcp(sk))
 		return -EBADF;
 
-	if (optlen % sizeof(struct dmabuf_token) ||
+	if (optlen % sizeof(*tokens) ||
 	    optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
 		return -EINVAL;
 
-	tokens = kvmalloc_array(optlen, sizeof(*tokens), GFP_KERNEL);
+	num_tokens = optlen / sizeof(*tokens);
+	tokens = kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL);
 	if (!tokens)
 		return -ENOMEM;
 
-	num_tokens = optlen / sizeof(struct dmabuf_token);
 	if (copy_from_sockptr(tokens, optval, optlen)) {
 		kvfree(tokens);
 		return -EFAULT;
@@ -1086,24 +1088,28 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
 	xa_lock_bh(&sk->sk_user_frags);
 	for (i = 0; i < num_tokens; i++) {
 		for (j = 0; j < tokens[i].token_count; j++) {
+			if (++num_frags > MAX_DONTNEED_FRAGS)
+				goto frag_limit_reached;
+
 			netmem_ref netmem = (__force netmem_ref)__xa_erase(
 				&sk->sk_user_frags, tokens[i].token_start + j);
 
-			if (netmem &&
-			    !WARN_ON_ONCE(!netmem_is_net_iov(netmem))) {
-				netmems[netmem_num++] = netmem;
-				if (netmem_num == ARRAY_SIZE(netmems)) {
-					xa_unlock_bh(&sk->sk_user_frags);
-					for (k = 0; k < netmem_num; k++)
-						WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
-					netmem_num = 0;
-					xa_lock_bh(&sk->sk_user_frags);
-				}
-				ret++;
+			if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
+				continue;
+
+			netmems[netmem_num++] = netmem;
+			if (netmem_num == ARRAY_SIZE(netmems)) {
+				xa_unlock_bh(&sk->sk_user_frags);
+				for (k = 0; k < netmem_num; k++)
+					WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
+				netmem_num = 0;
+				xa_lock_bh(&sk->sk_user_frags);
 			}
+			ret++;
 		}
 	}
 
+frag_limit_reached:
 	xa_unlock_bh(&sk->sk_user_frags);
 	for (k = 0; k < netmem_num; k++)
 		WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
-- 
2.47.0.277.g8800431eea-goog


