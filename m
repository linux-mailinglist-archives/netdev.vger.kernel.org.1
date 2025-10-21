Return-Path: <netdev+bounces-231408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E0BBF8F9C
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B2819C4077
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 21:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9B42BE638;
	Tue, 21 Oct 2025 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJDPZEX4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D5E2957CD
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761083073; cv=none; b=j8Xdvh/G4rAKXL99RCVnGQzMAwhO+lgJViwsVSqD7I+Xf6X3rpqLiI9AivPbZD9/z3XETWgzN1Ejj5uw+Tl6vMOL05EMuMicsCd8kNvqoxwPwP4LKM/LF2u4ayFMLuxYkf35VWLwRxRs9pek3QcxG+Utg8gVEousGkr+M79k+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761083073; c=relaxed/simple;
	bh=tPI6tOx2Bnfb8N36L8RQII8lQKj5/fU4eKUBY09Xars=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GsbBHHtLz005T7Qc4OPfc+kpyU30WvNycY6tEkukp7egkCwkR83bC/TB72Qhr31Lys36doFtoCw78bAI/mDDrPGyuRTiG+bKvKcWlmVKQf0l5saKKoJmmJnGT3CluB7BR75wOOR2uY/BeP/MVrqp2QJB8aGqCHIh4owXRHtmIbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TJDPZEX4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33baf262850so6036242a91.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 14:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761083071; x=1761687871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3qjK0ySS8hZEhrCqzMTCx0uVBDgzLWq2ttDSe6JLDc=;
        b=TJDPZEX4ShxZRHUQ14vTF98uMj7zInSIxo37SPgdIttkccuRCCdRQ7hnS2F6Kg9Y7R
         MHegsJ/i5zK1+jnZ7wTaSHL18aqMnMYyD5BlShkg6xtVmlNp47RVz9cHWSlTQXcNzIl+
         uXuaK/JmkrXEhkacWYHZzsRR2qtPi8EYU1tNx7jE4merChmoD9JWvG7UQd7/cBXFaeNA
         Tt4pio6AXQj/isvMEcFzSCZ9nNT1bclC+XeKkRuQ5+3A7L+Jiu/I6mkdmGCsVrEiLWMX
         Z2CeX1f/E3t4Q8/HN2kjO+C1gtFJh1/BomW0T0sLvtzcoJ5IW2zhcuYhGayzs2acrRHH
         i4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761083071; x=1761687871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3qjK0ySS8hZEhrCqzMTCx0uVBDgzLWq2ttDSe6JLDc=;
        b=q6LOwPe7BdwS1GpsMrAGdlBy7wNYqKu1D9pXTo11zLH2tiFRYbEndPtJe8jSsoJFKS
         p4lmR7cmwsQ6NLH9Dl7KngwNepEO2BljG9qDyHjVZDFL+BU5TtwWMEAE+T8byFslrid0
         EujPkI/UqKqDz5yd7ayVJQDpg/K3mko19wReTGE0amOH5wpll8QMnD24Lj1JfXrFVqIb
         a+Z6RN/l7Bif7fnKEzJWe8xn1YFxwJ3Xromnu3ZXavpSfphboMqtOo9eS4xDVZXuExsr
         nIRd4OcWph4OtF/7VB3mnQlgAICEOImJedsruwxmWFQQ7E1q0Pf9KqD824x5ssRX0ZHh
         AEHA==
X-Forwarded-Encrypted: i=1; AJvYcCXxFr7VrRb8/j8X5p2uJmeqiR1VC5fieSb5nw+bIBsFLm5dguvvtXPyIX/LTx5BfuXiGCwnWjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4XMm+d1GxkrzsWPIyirJdbLVHr4jAtim/fD4+aYuqjYB+lvRQ
	tIOAhhEHyLSXgKFpAv48XjmUN7MmQ4ZQUAVM0wDojAnSaPkfdV3X94QGdA2WSEXcWXrJfTchna1
	AyA9VGw==
X-Google-Smtp-Source: AGHT+IED/iav1kJwxa2ZPXDW3APsHrgabyLVwT3LlOMKasIestzyowPVCID9qcRmHVSaZEvo8RtnDJUp6Yk=
X-Received: from pjso17.prod.google.com ([2002:a17:90a:c091:b0:32e:3830:65f2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2686:b0:32e:e18a:3691
 with SMTP id 98e67ed59e1d1-33bcf919f1fmr26758053a91.35.1761083070874; Tue, 21
 Oct 2025 14:44:30 -0700 (PDT)
Date: Tue, 21 Oct 2025 21:43:21 +0000
In-Reply-To: <20251021214422.1941691-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251021214422.1941691-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251021214422.1941691-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 4/8] net: Add sk_clone().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sctp_accept() will use sk_clone_lock(), but it will be called
with the parent socket locked, and sctp_migrate() acquires the
child lock later.

Let's add no lock version of sk_clone_lock().

Note that lockdep complains if we simply use bh_lock_sock_nested().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h |  7 ++++++-
 net/core/sock.c    | 21 ++++++++++++++-------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 01ce231603db0..c7e58b8e8a907 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1822,7 +1822,12 @@ struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 void sk_free(struct sock *sk);
 void sk_net_refcnt_upgrade(struct sock *sk);
 void sk_destruct(struct sock *sk);
-struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority);
+struct sock *sk_clone(const struct sock *sk, const gfp_t priority, bool lock);
+
+static inline struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
+{
+	return sk_clone(sk, priority, true);
+}
 
 struct sk_buff *sock_wmalloc(struct sock *sk, unsigned long size, int force,
 			     gfp_t priority);
diff --git a/net/core/sock.c b/net/core/sock.c
index a99132cc09656..0a3021f8f8c16 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2462,13 +2462,16 @@ static void sk_init_common(struct sock *sk)
 }
 
 /**
- *	sk_clone_lock - clone a socket, and lock its clone
- *	@sk: the socket to clone
- *	@priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
+ * sk_clone - clone a socket
+ * @sk: the socket to clone
+ * @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
+ * @lock: if true, lock the cloned sk
  *
- *	Caller must unlock socket even in error path (bh_unlock_sock(newsk))
+ * If @lock is true, the clone is locked by bh_lock_sock(), and
+ * caller must unlock socket even in error path by bh_unlock_sock().
  */
-struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
+struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
+		      bool lock)
 {
 	struct proto *prot = READ_ONCE(sk->sk_prot);
 	struct sk_filter *filter;
@@ -2497,9 +2500,13 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 		__netns_tracker_alloc(sock_net(newsk), &newsk->ns_tracker,
 				      false, priority);
 	}
+
 	sk_node_init(&newsk->sk_node);
 	sock_lock_init(newsk);
-	bh_lock_sock(newsk);
+
+	if (lock)
+		bh_lock_sock(newsk);
+
 	newsk->sk_backlog.head	= newsk->sk_backlog.tail = NULL;
 	newsk->sk_backlog.len = 0;
 
@@ -2595,7 +2602,7 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 	newsk = NULL;
 	goto out;
 }
-EXPORT_SYMBOL_GPL(sk_clone_lock);
+EXPORT_SYMBOL_GPL(sk_clone);
 
 static u32 sk_dst_gso_max_size(struct sock *sk, const struct net_device *dev)
 {
-- 
2.51.0.915.g61a8936c21-goog


