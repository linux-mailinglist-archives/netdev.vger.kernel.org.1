Return-Path: <netdev+bounces-212555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C812B21341
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 19:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908563E3554
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE1D2DAFCE;
	Mon, 11 Aug 2025 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HREiEbvx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4F32D6E7B
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933504; cv=none; b=FQteYQMQ4rkBmBYEYQQHKWWlwhhUz1Xa8pasCo3DlEYxGNrEZGAbYzMQJaTggaqpK5TMV+0wlgIGE8l31goZU1ZlCxnBMkF1lWUjxF+kvKK5ncZ+jJ/d9NGl9iU4b4hjFqKeE4EeSsWp2wj91BDqi3gBmx7tQwO66MLKdZB0sG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933504; c=relaxed/simple;
	bh=scmT+L01eD7wAA+tQ1VYtZfqLo/bIBN/pToeFw110+w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HwgQGGNyjadnnZSquiMdXPideA8PW4jJT8dIWOe3b1gMYC2fYHL4WtDk36/5OkQHypwIFjbcrnde3zdgsfm96myd/Om89HE5Xfo3MwXQ+G9kXCplVHXfqX1yD6Jpz17Gey1H7bzi5RHkQj0+FWjexmV8fe/9NW9d/gKNHIllRyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HREiEbvx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2403c86ff97so68653655ad.1
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933502; x=1755538302; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/1GHMwnAvIaqWLJyXzy2eGeZ3loP62R3df/KRW2nnvI=;
        b=HREiEbvxiSTQ2x8nmbCXHgURN3m6dk/nRLovveODVh5bp1WUraF+WFOS1dQyiTiOxY
         Rb1uORbIhe/CQsvUwGutvVXVCy8MpdVqHEKiwu8nnGS85yYjj5XoTIbsvVkDbkHr2Rkf
         Z7TC3oi0iwoCxywX696yTfB+fve6kq4xuc9JpzIEzkn6KuHkyGmYsp5jU9HZ7xuvv0Jc
         sUszOO4RsK0+5UyPS9hGROZlM5mI7wH4fulCByHwJBsvUJvVlSLCXgCSWjuYshg4Z8x4
         bWIKU7R6B51Py3JaTnR2HSmGMGCrLJqbQCSWm7f0HCniTuYEIIZwYl9ccLR7qPsr3+8P
         qBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933502; x=1755538302;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1GHMwnAvIaqWLJyXzy2eGeZ3loP62R3df/KRW2nnvI=;
        b=GfKjxHB37K22SMhhs3h6dQ3hWO0smO7fqXLGMKwMwf4C/FJkyMb8X2g8SXkaWjI2ed
         lMLNUbyu2A7v8981S07tHlg01v9rITO83elX0RQYPusQbguWrPmcIgd0UDIjFVSHKHb8
         Sg6DNSENGZnoCc6UlPpwD/Fi/eMVElpxiEjmK/BoXeI3dlCcXdusBipjwdXGijOuyhZM
         +mRQZwjx2AezlIR/a0oTws8Z1P96jCYnCHuQ8Qqf3SZjjpu7KTA5K604vpKaXXQHbxbb
         E/3FzDmHKvaE6v5q6DhR1R51oYm3avcVJSA9UrHywzu6p9kDqvsgV9CxVMkvf52OClaR
         7VhA==
X-Forwarded-Encrypted: i=1; AJvYcCVrnU6r+Sy0WvCFfLbstrh8rvfqLOS4r2IqksaOWiX1pnEnn2+ATZ2RAc+ZqGFu7G01zAG8Cew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvznetS+Y++gAQ0gnLw4QTLQ3s+v8zgZ/UJdSTNESk/X2xQuYg
	0KjlSdi8S5FNKVxJ45iWZztsulvlDBNRMifzdp8DyW9ClpNtB3fEkgHg86vJbCP6D81al1ZLK/v
	mCYQWog==
X-Google-Smtp-Source: AGHT+IFMNgVf+Ayq9j3qMwMUXApKfzqqa1VJ0zOmoONCV2R4q5dCIl1lgeXBjm87U9qu7vPQAjok3apSCjM=
X-Received: from pjxx5.prod.google.com ([2002:a17:90b:58c5:b0:31f:b2f:aeed])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea08:b0:240:4faa:75cd
 with SMTP id d9443c01a7336-242c225554emr205010325ad.48.1754933501503; Mon, 11
 Aug 2025 10:31:41 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:35 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-8-kuniyu@google.com>
Subject: [PATCH v2 net-next 07/12] net-memcg: Introduce mem_cgroup_sk_enabled().
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
2.51.0.rc0.155.g4a0f42376b-goog


