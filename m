Return-Path: <netdev+bounces-213064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3E6B23119
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 20:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49EB37AD42A
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C20F2FFDEE;
	Tue, 12 Aug 2025 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tbOwFn8C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA312FFDDF
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021548; cv=none; b=tJUJL8OUthH8ZEnZCsPnL9SnylyzUArulD2uTjoW/YUCAGQ56WlHZNgnqVXGfCAswT0nwKjS4EfL+wcLtsiMlxAnDT9B3G40+6EZ1ALR+HMQxMIIEbnuvuXnnXwKDQwvZvndPfRnJ66cnjcNZ2cH8MJqhc6ra7I05AKGp9gJTBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021548; c=relaxed/simple;
	bh=KZsxQ9Vejvjn3ihqtI+VvNwL3Rw10GiDSiQrIYh5KLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WcQGD4wlKufBxZRMpdnx6jS9N6pgZYmyxdPmtI/9JQSuaKQr34084dKFY7OpCJTSLxEexmvs8CBKOpwoToQEcuwt1yCQ3BSfUCgk9tR8pzT/xiDLNHGt8CJ/jkxK6Ck6GWrenNIfGsxAeCWx6bWWGJkU3fDsHfNUTlXPAizSCoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tbOwFn8C; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76be0be9ee1so5911798b3a.2
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021546; x=1755626346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lmzqnAc1jsyellKSOYCRzvGhauBIubxeUGW9qtoYYWI=;
        b=tbOwFn8C0PmsR+c9g6bf2Jjc0zRNz+I8B6nlJ29FM76pstdddb8K+LIAsG5Kp7t6zA
         3kXSl99zO6u1A8bufo52HPZqIWVGRJ709VMXXoR+LC6HvtfLxxRtLsmMyH5Goze+ciA8
         gGS6G6dSQJweqwPcFYRcD7yAq5s5gpboifthkaUTxFW3WRaDE7CMwtt4CDIwzFwJxgA8
         mPBW3bU8TUZLW/Coj7Pk5fEipnYA9J1KS2/eL+eOO3jdXdt2Sh/d3zJxp+8F2jmWeAUn
         YuokHlG2DWkxQQbrqMO9lm8yo8XvrxMfr0X1RJ5ERraNUTTjWoLC+gT3Yl0cUTmYaHAj
         8bLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021546; x=1755626346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmzqnAc1jsyellKSOYCRzvGhauBIubxeUGW9qtoYYWI=;
        b=YUwjmF55MfadTxJ385iCc6MU2xzalsl4Z9CB1UdU1FOlDyWdvNNLx6ERIH48+9lrl7
         5lpnSCfRt49homoZGm1BrUkYDposeSKtD+z99oj9d8gBp+uEq31E8bHasi8sDRwkqPel
         qj+4hYay9jrGwXRpFc6dKGchmHslFaUsEdTGCdCxpoRYcUw0FCuJLmnTuJqnivzr/JqC
         G7a1EMPQ5NE5uWyDCDI99RI7BeWkOiNVahdwLiFyJYjPL1Xu59lFIqsZT8r1vdyEuwsO
         Z5vafIR3CqzGc4qOshOIHn2aAkk5JtZ9P5olAKjz8KZNy0sYnDD7M7yWMVxTuOHsbEpP
         g1Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVllCshwi2zF139LfA8g4lXLTsI6TFhahHM4ny1u6PMoaLYKRTJ4geVvy59qHABZOiRFGWnbPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl3PRwVchCKxsOImQg4DePBLg2yf10Yrs1vBJtatNetfbze+TW
	g2/cwifrxtV4BLlsw8Jchp1Ev9fLHlDEjeCg5oaRJFctO02dJDiRaPWPnU2dQmOL5cdzz0u2tVI
	pJgESoQ==
X-Google-Smtp-Source: AGHT+IGdZk7MwPY5BeI43bceFVbz9bcwzyVjG/myi4TvBkOWcTUGeu9X1TXG1+jvSNdfiHL0s8PKRPjYYcg=
X-Received: from pfbcn7.prod.google.com ([2002:a05:6a00:3407:b0:739:8cd6:c16c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:887:b0:76b:f9f0:bef2
 with SMTP id d2e1a72fcca58-76e20fb0e4emr135908b3a.14.1755021546076; Tue, 12
 Aug 2025 10:59:06 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:25 +0000
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-8-kuniyu@google.com>
Subject: [PATCH v3 net-next 07/12] net-memcg: Introduce mem_cgroup_sk_enabled().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

The socket memcg feature is enabled by a static key and
only works for non-root cgroup.

We check both conditions in many places.

Let's factorise it as a helper function.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/proto_memory.h |  2 +-
 include/net/sock.h         | 10 ++++++++++
 include/net/tcp.h          |  2 +-
 net/core/sock.c            |  6 +++---
 net/ipv4/tcp_output.c      |  2 +-
 net/mptcp/subflow.c        |  2 +-
 6 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/net/proto_memory.h b/include/net/proto_memory.h
index a6ab2f4f5e28..859e63de81c4 100644
--- a/include/net/proto_memory.h
+++ b/include/net/proto_memory.h
@@ -31,7 +31,7 @@ static inline bool sk_under_memory_pressure(const struct sock *sk)
 	if (!sk->sk_prot->memory_pressure)
 		return false;
 
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
+	if (mem_cgroup_sk_enabled(sk) &&
 	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
 		return true;
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 811f95ea8d00..3efdf680401d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2599,11 +2599,21 @@ static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 {
 	return sk->sk_memcg;
 }
+
+static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
+{
+	return mem_cgroup_sockets_enabled && mem_cgroup_from_sk(sk);
+}
 #else
 static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 {
 	return NULL;
 }
+
+static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
+{
+	return false;
+}
 #endif
 
 static inline long sock_rcvtimeo(const struct sock *sk, bool noblock)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 526a26e7a150..9f01b6be6444 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -275,7 +275,7 @@ extern unsigned long tcp_memory_pressure;
 /* optimized version of sk_under_memory_pressure() for TCP sockets */
 static inline bool tcp_under_memory_pressure(const struct sock *sk)
 {
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
+	if (mem_cgroup_sk_enabled(sk) &&
 	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
 		return true;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 000940ecf360..ab658fe23e1e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1032,7 +1032,7 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	bool charged;
 	int pages;
 
-	if (!mem_cgroup_sockets_enabled || !sk->sk_memcg || !sk_has_account(sk))
+	if (!mem_cgroup_sk_enabled(sk) || !sk_has_account(sk))
 		return -EOPNOTSUPP;
 
 	if (!bytes)
@@ -3271,7 +3271,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 	sk_memory_allocated_add(sk, amt);
 	allocated = sk_memory_allocated(sk);
 
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg) {
+	if (mem_cgroup_sk_enabled(sk)) {
 		memcg = sk->sk_memcg;
 		charged = mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge());
 		if (!charged)
@@ -3398,7 +3398,7 @@ void __sk_mem_reduce_allocated(struct sock *sk, int amount)
 {
 	sk_memory_allocated_sub(sk, amount);
 
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
+	if (mem_cgroup_sk_enabled(sk))
 		mem_cgroup_uncharge_skmem(sk->sk_memcg, amount);
 
 	if (sk_under_global_memory_pressure(sk) &&
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index caf11920a878..37fb320e6f70 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3578,7 +3578,7 @@ void sk_forced_mem_schedule(struct sock *sk, int size)
 	sk_forward_alloc_add(sk, amt << PAGE_SHIFT);
 	sk_memory_allocated_add(sk, amt);
 
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
+	if (mem_cgroup_sk_enabled(sk))
 		mem_cgroup_charge_skmem(sk->sk_memcg, amt,
 					gfp_memcg_charge() | __GFP_NOFAIL);
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6fb635a95baf..4874147e0b17 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1723,7 +1723,7 @@ static void mptcp_attach_cgroup(struct sock *parent, struct sock *child)
 	}
 #endif /* CONFIG_SOCK_CGROUP_DATA */
 
-	if (mem_cgroup_sockets_enabled && parent->sk_memcg)
+	if (mem_cgroup_sk_enabled(parent))
 		mem_cgroup_sk_inherit(parent, child);
 }
 
-- 
2.51.0.rc0.205.g4a044479a3-goog


