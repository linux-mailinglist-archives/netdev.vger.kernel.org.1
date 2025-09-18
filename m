Return-Path: <netdev+bounces-213835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEBAB2700A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 22:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEDA1B63595
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 20:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C7425B2E4;
	Thu, 14 Aug 2025 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9ZNf9+6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14925A337
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202168; cv=none; b=Gqz+fahTohA3joj/PVGfDSjJQnll0smCks+26NOEZPTG+feUsk5Ka5I06MS9FSIQK4eX4vJ8YvU8KOmCxkJ2lAWcuczskYYUmEtlcqHV2yz5ZvH5WG3FPrxN4e0EdlL9m2XhchM58iLWUWT0qQa7AXaYkdNUDXPU8lG+61r5Vf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202168; c=relaxed/simple;
	bh=9e+MQL+1kufw9HczfwR0qRzJsdj8exP9jCcEPhaMv6Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VJBJYZ6FgHpd2hGnFcn/AI+2udBGIkbdOW1BzJdb59WmlUZO+GU9HglSGXJw+hc9ZXj2Q6QEQlqMZqDSn8pu/bN1V/nhlghC7H8vgyeySHmGy84QmcUYlSHwwRErD/xqv2zqlSeVFW8wq/9FSEB/8zJFLvmHh2cQU8QG+3d2Gy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K9ZNf9+6; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24458121274so15659595ad.2
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 13:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202165; x=1755806965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RN4H8OhMESZggI/pZXAKf5UmJPFi9rM002XSMoc6emQ=;
        b=K9ZNf9+6D3qcxyOOf2HOfujJ8pprYGgnPCD/TKzho5ajcDZdFyTkNScoQjYmBZYu+L
         oEe0tmX6mcuKaDn51bknTCiQ6vpilDYoESN++cT7/jernunl00kZGGlLQEDhuycuwZv7
         KbwLOxDojdWjCl/9oE8XgjdhNNLrqd3bXQFEHkh/VyNsvrfAiGnD2xgjb5nB9kepkLv3
         YvYsiRndESeWD0O92/FeTMZcKp8j713g141DI4OFC/tqOCmAZoRuNua+7PSrmhZWj4VZ
         +VlKv3Mkm7tkpKIgxLc+TWZeqPfsw+FAMdIMExXgr/FLfLN2p/UQaC3QTNR5m+tMm3Aj
         1evA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202165; x=1755806965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RN4H8OhMESZggI/pZXAKf5UmJPFi9rM002XSMoc6emQ=;
        b=JjA/QORudzEmUGmvNlGgwW1R1O8xL+QzJbdkfE276uDHDFHVztEQ1ogzvC06225tLA
         wYbOgATpELAWDAc1crBhgSAA2teE3NAUCOkwBKHFGgzE/HwfM1+7+5A7hI2jhN7PDy2o
         l/nuVo6TC4ccjxbw6P12pifR8FbdHA6tCH7RDzVyihc/cl0U4PgrKaLnJmg8PaW7FcQz
         RjSONnrQnyPahMZ9ZkQwTNEzPkDgqfeHsPe4qCsq/Byg9NKKU7CbowhjQKPvD1flZD+2
         ZWfdC//F7C8l3ItZqw581bqX4ZXSnApRr88c0T0mZzJZDXV9+A4+OAOEjUwsWfS1Pw4t
         cUKw==
X-Forwarded-Encrypted: i=1; AJvYcCVUZR2TxFrpRLo8hl6GPvMsFqNGiKlDVWCLuAOtIxNbfnGI6fvzRtER9uSqTHRigb87m8MydFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSEjZD1ki0CvLDUBulX3RvNFFmzCKos7EjiUhx6RLEOCHtEbpH
	+/ypJtuY0duG72nL9ZZXpfYISN1wBa8giYK54FamWjME4l3quKRr6eCrkVFHZ/mIK3g2uKybTp6
	u8MSsFQ==
X-Google-Smtp-Source: AGHT+IGjybKWRKb8eGBGrIqhLAFzL1Ig08nwLcmkE6zoBHcD3GY1TtW/rYf6Ml05cqJS44L2U3FStQ7jMm0=
X-Received: from pjbnc16.prod.google.com ([2002:a17:90b:37d0:b0:312:dbc:f731])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32d2:b0:234:8ef1:aa7b
 with SMTP id d9443c01a7336-24458a4c885mr60555155ad.20.1755202165500; Thu, 14
 Aug 2025 13:09:25 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:39 +0000
In-Reply-To: <20250814200912.1040628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-8-kuniyu@google.com>
Subject: [PATCH v4 net-next 07/10] net-memcg: Introduce mem_cgroup_sk_enabled().
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
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/net/proto_memory.h |  2 +-
 include/net/sock.h         | 10 ++++++++++
 include/net/tcp.h          |  2 +-
 net/core/sock.c            |  6 +++---
 net/ipv4/tcp_output.c      |  2 +-
 5 files changed, 16 insertions(+), 6 deletions(-)

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
-- 
2.51.0.rc1.163.g2494970778-goog


