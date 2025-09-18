Return-Path: <netdev+bounces-214190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFBBB28713
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 22:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B032DB60426
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D51930DEB1;
	Fri, 15 Aug 2025 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KrSaBXO9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771C73090F5
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289070; cv=none; b=SrAX/WbGMZG5doWg5vG6FqWGJFu1SrsEAWUQWnLmOcJTCLw7qERTDxHBiUmD4LTDDqcVGVy7oohNjBjXvIoK3ORyDdhMFHnxj7WMwD7rL21l2KqOuaE66uZ1egqurIeboQMctWMVGJrrsalab4ubiuTcoWMXcEnIK5kSKN9u1bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289070; c=relaxed/simple;
	bh=vh18PK56P28TAsZ8ZPMuAn9/KE5M8PEvCAMdT85jx+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NxCmKOSb56sBDn28yIXWnBC5MLuvay02fesWZ004ujCl5TNhxwD4ipdbv+T+mSC8JdBCYdwbczmsN7/Cod0fKAAZbKNoPGEYbux7eSo8xXWHMszo4hxwKBnUJ4hSxH0Vi53dqZJ/445GVujKG5ghUQjnM0aLgqiGgm6yVreq6H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KrSaBXO9; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2eb9bb19so3492746b3a.3
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 13:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289067; x=1755893867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQG0GMWGg0EW29pjW9cSPQlAKpK49JIR3c7s4HvSqPM=;
        b=KrSaBXO9D5vh+0ly6fEv3wOWn8rlbhbTeDRzwuOggRMndQuSS7hgWmKR5QKaXIjMUY
         jXv+EyKahm0MY8pue+oKDk8PBP2sVXIetDj68Y3/o3PiX9KVMLAEXmAqG4ixA1WyxwEL
         2Jtw9LLAj3T2firdzHKgM19KRb4tQrsxdSsojX5jrvXNHYqDo22RSfFtjdkUHmd50+Yn
         7Tunvk3I0pmgH0BoVDaGvMXvRqjTHK7mA6LvH+6WFXc4RKb++I8d1Pr496sLZjIIyT60
         PlBiYKLmcB9FvzS2HkLX2yUWlDo/kXfpOKq+DXsw2p7PSTboY48zVt7G1hLRNBr4Ze76
         ZUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289067; x=1755893867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQG0GMWGg0EW29pjW9cSPQlAKpK49JIR3c7s4HvSqPM=;
        b=db1GtVMYkpO2MKFCYD3BZQ/OFgZt+1rRTFLwfl13bWCZSX+t76CUU6MvAWUTWByx5B
         tHOlkD5aYRIwmG/+6pHIMK0hc1dsJINIsQFyfsM10DtlQ9Cn2qCXSDaf5urIltU89rz5
         uyvxnG0+XspfIfzJSQsE455h9/2FSvk64kkE8cp6Pd9dsgH7YSbIyHEWxO7r/YgmhTf4
         5eZtDz4NglpXk3AuzditaY1wKwFnkSMjIYUzcCN0xbclXzkQr8SNNcPS7k2LjCdypddg
         WIU+PDDgxaqYYnBNTNzLfvpJ6nYgRTckOE9Fzf/sQHXydEI7YVFYg8MVE0SLbGwSAsLR
         tYGA==
X-Forwarded-Encrypted: i=1; AJvYcCUWuxzQ+BVUAfAvj/hgyJf7aIjovXGa+1v0pPDrybDWn1EhlS/r3eiSat/Fy/0ePekhdT0wuBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQxCrAR91+vo99SjbcbnMnFAGlSveQUUCxK6M1sqHS38ProgMi
	HiZKc/0SkWjXcqUM889m79Hw/bQNkiaUoEXhgu2oAt/FWZchTeOXUR0gyXV3leszHrLG0/scBxL
	125euJg==
X-Google-Smtp-Source: AGHT+IFp46sq2D48DZO0gUoHI4Uo8szEk8EClj8DpiFjSc+NkMZfkRfKF8J0RyyXgIbY22ezjmDiUSSBttE=
X-Received: from pfbfb7.prod.google.com ([2002:a05:6a00:2d87:b0:76b:b0c5:347c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88d0:0:b0:748:2ac2:f8c3
 with SMTP id d2e1a72fcca58-76e448632b2mr5380061b3a.24.1755289067566; Fri, 15
 Aug 2025 13:17:47 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:17 +0000
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815201712.1745332-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-10-kuniyu@google.com>
Subject: [PATCH v5 net-next 09/10] net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
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

We will store a flag in the lowest bit of sk->sk_memcg.

Then, we cannot pass the raw pointer to mem_cgroup_under_socket_pressure().

Let's pass struct sock to it and rename the function to match other
functions starting with mem_cgroup_sk_.

Note that the helper is moved to sock.h to use mem_cgroup_from_sk().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 18 ------------------
 include/net/proto_memory.h |  2 +-
 include/net/sock.h         | 22 ++++++++++++++++++++++
 include/net/tcp.h          |  2 +-
 4 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0837d3de3a68..fb27e3d2fdac 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1642,19 +1642,6 @@ static inline u64 mem_cgroup_get_socket_pressure(struct mem_cgroup *memcg)
 }
 #endif
 
-static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
-{
-#ifdef CONFIG_MEMCG_V1
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		return !!memcg->tcpmem_pressure;
-#endif /* CONFIG_MEMCG_V1 */
-	do {
-		if (time_before64(get_jiffies_64(), mem_cgroup_get_socket_pressure(memcg)))
-			return true;
-	} while ((memcg = parent_mem_cgroup(memcg)));
-	return false;
-}
-
 int alloc_shrinker_info(struct mem_cgroup *memcg);
 void free_shrinker_info(struct mem_cgroup *memcg);
 void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
@@ -1686,11 +1673,6 @@ static inline void mem_cgroup_sk_uncharge(const struct sock *sk,
 {
 }
 
-static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
-{
-	return false;
-}
-
 static inline void set_shrinker_bit(struct mem_cgroup *memcg,
 				    int nid, int shrinker_id)
 {
diff --git a/include/net/proto_memory.h b/include/net/proto_memory.h
index 859e63de81c4..8e91a8fa31b5 100644
--- a/include/net/proto_memory.h
+++ b/include/net/proto_memory.h
@@ -32,7 +32,7 @@ static inline bool sk_under_memory_pressure(const struct sock *sk)
 		return false;
 
 	if (mem_cgroup_sk_enabled(sk) &&
-	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
+	    mem_cgroup_sk_under_memory_pressure(sk))
 		return true;
 
 	return !!READ_ONCE(*sk->sk_prot->memory_pressure);
diff --git a/include/net/sock.h b/include/net/sock.h
index 3efdf680401d..3bc4d566f7d0 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2604,6 +2604,23 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
 {
 	return mem_cgroup_sockets_enabled && mem_cgroup_from_sk(sk);
 }
+
+static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
+
+#ifdef CONFIG_MEMCG_V1
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return !!memcg->tcpmem_pressure;
+#endif /* CONFIG_MEMCG_V1 */
+
+	do {
+		if (time_before64(get_jiffies_64(), mem_cgroup_get_socket_pressure(memcg)))
+			return true;
+	} while ((memcg = parent_mem_cgroup(memcg)));
+
+	return false;
+}
 #else
 static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 {
@@ -2614,6 +2631,11 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
 {
 	return false;
 }
+
+static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
+{
+	return false;
+}
 #endif
 
 static inline long sock_rcvtimeo(const struct sock *sk, bool noblock)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9f01b6be6444..2936b8175950 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -276,7 +276,7 @@ extern unsigned long tcp_memory_pressure;
 static inline bool tcp_under_memory_pressure(const struct sock *sk)
 {
 	if (mem_cgroup_sk_enabled(sk) &&
-	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
+	    mem_cgroup_sk_under_memory_pressure(sk))
 		return true;
 
 	return READ_ONCE(tcp_memory_pressure);
-- 
2.51.0.rc1.163.g2494970778-goog


