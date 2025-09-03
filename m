Return-Path: <netdev+bounces-219677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C440B42967
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AAAE162710
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55889369327;
	Wed,  3 Sep 2025 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pU5TCKh0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C7A3629A4
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926168; cv=none; b=P2iTF1uEuljHa+FdE40w8Dr8RZtmS1N6B5klFR7Cy3YRXH447juwcXESKo5vBAFsl9UXpO8rlG+FVMrOpskZmlkwZGbydc3/QZiM6lhTb2oJKg5nBUqneklhQJ+CtTDu8IlhpfWnY7Fp+RMxVLAY4hqKizv3TN2O/K3r8I22+N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926168; c=relaxed/simple;
	bh=w03MV8gc2Wo1be4kDYj2HfmsGJaCah8r+PRRwbnXIIo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iwWxPzHQMWw+XpI34qYKM/Z7BhV9cnG1qiS5gwgaTngNOHBqWlYiXQag57qax73SU9l5KSMG3vCaVcHHkJgceVrLSvl/9a3NboUUen0uP4n/yvMtNnPoiwj8t/wXVVIBlvEnKdyazbsX4LfwQmGt7ZTPYDQ9bzrCbzUh5IQhyZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pU5TCKh0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-327b5e7f2f6so155131a91.2
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 12:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756926166; x=1757530966; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=isnHGvMu4+udZoSYszP9gjuFr2CJ+4WEkifuXjinTFk=;
        b=pU5TCKh0StklEqZ3F0uNgKAJuRTt+3BQkKnfiTOVC2mo0dSrycmKgMQ4RkWlvMPJ0C
         SHOiPxIqMAI2qEszZTVArIW85ABWcrh6sO/rLyaQIT4ktymyOdIJYKWCMx8Q/ywxVlPg
         d3UimLoIdxlh2sxX627PMb3nKpIlB9ueaTs7sSVs/TaOQJvg/87HojMDJOdh+SoCEtlZ
         jUOpDjvZost+zwphBhTT7gA51AmCQls8LlL3glqU5PtjrcGgsYthCvPw/i+cDMZ6yYqP
         Ik1qkOMWnLLjPsU3RH9g91VbfBRlYphjX3auPuUaKS9rykL6fkGEx+zqVRlM//h+FW3q
         o+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756926166; x=1757530966;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isnHGvMu4+udZoSYszP9gjuFr2CJ+4WEkifuXjinTFk=;
        b=Jlq5IeOFikk7JiFPDNUaLjag5ftL2cR6Tk5xtWE/rBvHZysX3NRmYNRvY9QMqgcLdM
         VOhy9wHcwvCZkjdNEYsdCuEuKd6Ii9+9pEmjOOWTNv4VDzPfjLDh10FATthHUjqub9sM
         2yrjjKAkLDg89KOQCAvUel6PH8SbiIRRNs8TN4ZbuqJMI2d/4WDUEc9fs2ViZHEaFBYO
         M3kAHpQ0cJI4Hp6PzcGb/1bu+kUTUl/sOGpwdi5uEhK0DasWqdAx/wG7SmIl4JCrYVHR
         z4nPS6/YRWK6GEFG55AOANlC9N4P7s9KXlPeT3RGKkB51SMkof1f9M9HYHmeDGCSoXr5
         Gb+w==
X-Forwarded-Encrypted: i=1; AJvYcCXT0ah374RSRizDgDIHVPe52cHIoYCzCPZA1JYUHLUAgBIUofgyfYnjqXbxTatWDPyAUIEqaZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFgXlCHkdYiXVn+JfrkRX9kZ6cZmaxf/iXsczmZdcoq92vTevN
	ZeWAJ+r4PRIjiOKlL93qW38y5VaV8TtRc+klT1lRZ0J8DcNS8EgvuqcMpz9wzLKkHgzBHUwNP/g
	HzB6l5w==
X-Google-Smtp-Source: AGHT+IFV+u8fL/cP9Emz7QzbUzEiu/OucrZMcJkKeQnDmHXwCDAcP9+bUpj1RdiLdJEMlxnZvPkxhP8Rzh4=
X-Received: from pjbeu6.prod.google.com ([2002:a17:90a:f946:b0:31c:32f8:3f88])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:544c:b0:32b:6eed:d203
 with SMTP id 98e67ed59e1d1-32b6eedd3bamr3352076a91.24.1756926165857; Wed, 03
 Sep 2025 12:02:45 -0700 (PDT)
Date: Wed,  3 Sep 2025 19:02:02 +0000
In-Reply-To: <20250903190238.2511885-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250903190238.2511885-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903190238.2511885-4-kuniyu@google.com>
Subject: [PATCH v5 bpf-next/net 3/5] bpf: Introduce SK_BPF_MEMCG_FLAGS and SK_BPF_MEMCG_SOCK_ISOLATED.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will decouple sockets from the global protocol memory accounting
if sockets have SK_BPF_MEMCG_SOCK_ISOLATED.

This can be flagged (and cleared) at the BPF_CGROUP_INET_SOCK_CREATE
hook by bpf_setsockopt() and is inherited to child sockets.

  u32 flags = SK_BPF_MEMCG_SOCK_ISOLATED;

  bpf_setsockopt(ctx, SOL_SOCKET, SK_BPF_MEMCG_FLAGS,
                 &flags, sizeof(flags));

SK_BPF_MEMCG_FLAGS is only supported at BPF_CGROUP_INET_SOCK_CREATE
and not supported on other hooks for some reasons:

  1. UDP charges memory under sk->sk_receive_queue.lock instead
     of lock_sock()

  2. For TCP child sockets, memory accounting is adjusted only in
     __inet_accept() which sk->sk_memcg allocation is deferred to

  3. Modifying the flag after skb is charged to sk requires such
     adjustment during bpf_setsockopt() and complicates the logic
     unnecessarily

We can support other hooks later if a real use case justifies that.

Given sk->sk_memcg can be accessed in the fast path, it would
be preferable to place the flag field in the same cache line as
sk->sk_memcg.

However, struct sock does not have such a 1-byte hole.

Let's store the flag in the lowest bit of sk->sk_memcg and add
a helper to check the bit.

In the next patch, if mem_cgroup_sk_isolated() returns true,
the socket will not be charged to sk->sk_prot->memory_allocated.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v5:
  * Limit getsockopt() to BPF_CGROUP_INET_SOCK_CREATE

v4:
  * Only allow inet_create() to set flags
  * Inherit flags from listener to child in sk_clone_lock()
  * Support clearing flags

v3:
  * Allow setting flags without sk->sk_memcg in sk_bpf_set_get_memcg_flags()
  * Preserve flags in __inet_accept()

v2:
  * s/mem_cgroup_sk_set_flag/mem_cgroup_sk_set_flags/ when CONFIG_MEMCG=n
  * Use CONFIG_CGROUP_BPF instead of CONFIG_BPF_SYSCALL for ifdef
---
 include/net/sock.h             | 50 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/bpf.h       |  6 ++++
 net/core/filter.c              | 34 +++++++++++++++++++++++
 net/core/sock.c                |  1 +
 net/ipv4/af_inet.c             |  4 +++
 tools/include/uapi/linux/bpf.h |  6 ++++
 6 files changed, 101 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 63a6a48afb48..703cb9116c6e 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2596,10 +2596,41 @@ static inline gfp_t gfp_memcg_charge(void)
 	return in_softirq() ? GFP_ATOMIC : GFP_KERNEL;
 }
 
+#define SK_BPF_MEMCG_FLAG_MASK	(SK_BPF_MEMCG_FLAG_MAX - 1)
+#define SK_BPF_MEMCG_PTR_MASK	~SK_BPF_MEMCG_FLAG_MASK
+
 #ifdef CONFIG_MEMCG
 static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 {
+#ifdef CONFIG_CGROUP_BPF
+	unsigned long val = (unsigned long)sk->sk_memcg;
+
+	val &= SK_BPF_MEMCG_PTR_MASK;
+	return (struct mem_cgroup *)val;
+#else
 	return sk->sk_memcg;
+#endif
+}
+
+static inline void mem_cgroup_sk_set_flags(struct sock *sk, unsigned short flags)
+{
+#ifdef CONFIG_CGROUP_BPF
+	unsigned long val = (unsigned long)mem_cgroup_from_sk(sk);
+
+	val |= flags;
+	sk->sk_memcg = (struct mem_cgroup *)val;
+#endif
+}
+
+static inline unsigned short mem_cgroup_sk_get_flags(const struct sock *sk)
+{
+#ifdef CONFIG_CGROUP_BPF
+	unsigned long val = (unsigned long)sk->sk_memcg;
+
+	return val & SK_BPF_MEMCG_FLAG_MASK;
+#else
+	return 0;
+#endif
 }
 
 static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
@@ -2607,6 +2638,11 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
 	return mem_cgroup_sockets_enabled && mem_cgroup_from_sk(sk);
 }
 
+static inline bool mem_cgroup_sk_isolated(const struct sock *sk)
+{
+	return mem_cgroup_sk_get_flags(sk) & SK_BPF_MEMCG_SOCK_ISOLATED;
+}
+
 static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
@@ -2629,11 +2665,25 @@ static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 	return NULL;
 }
 
+static inline void mem_cgroup_sk_set_flags(struct sock *sk, unsigned short flags)
+{
+}
+
+static inline unsigned short mem_cgroup_sk_get_flags(const struct sock *sk)
+{
+	return 0;
+}
+
 static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
 {
 	return false;
 }
 
+static inline bool mem_cgroup_sk_isolated(const struct sock *sk)
+{
+	return false;
+}
+
 static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
 {
 	return false;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..52b8c2278589 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7182,6 +7182,7 @@ enum {
 	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
 	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
 	SK_BPF_CB_FLAGS		= 1009, /* Get or set sock ops flags in socket */
+	SK_BPF_MEMCG_FLAGS	= 1010, /* Get or Set flags saved in sk->sk_memcg */
 };
 
 enum {
@@ -7204,6 +7205,11 @@ enum {
 						 */
 };
 
+enum {
+	SK_BPF_MEMCG_SOCK_ISOLATED	= (1UL << 0),
+	SK_BPF_MEMCG_FLAG_MAX		= (1UL << 1),
+};
+
 struct bpf_perf_event_value {
 	__u64 counter;
 	__u64 enabled;
diff --git a/net/core/filter.c b/net/core/filter.c
index 31b259f02ee9..df2496120076 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5723,9 +5723,39 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
+static int sk_bpf_set_get_memcg_flags(struct sock *sk,
+				      char *optval, int optlen,
+				      bool getopt)
+{
+	u32 flags;
+
+	if (optlen != sizeof(u32))
+		return -EINVAL;
+
+	if (!sk_has_account(sk))
+		return -EOPNOTSUPP;
+
+	if (getopt) {
+		*(u32 *)optval = mem_cgroup_sk_get_flags(sk);
+		return 0;
+	}
+
+	flags = *(u32 *)optval;
+	if (flags >= SK_BPF_MEMCG_FLAG_MAX)
+		return -EINVAL;
+
+	mem_cgroup_sk_set_flags(sk, flags);
+
+	return 0;
+}
+
 BPF_CALL_5(bpf_sock_create_setsockopt, struct sock *, sk, int, level,
 	   int, optname, char *, optval, int, optlen)
 {
+	if (IS_ENABLED(CONFIG_MEMCG) &&
+	    level == SOL_SOCKET && optname == SK_BPF_MEMCG_FLAGS)
+		return sk_bpf_set_get_memcg_flags(sk, optval, optlen, false);
+
 	return __bpf_setsockopt(sk, level, optname, optval, optlen);
 }
 
@@ -5743,6 +5773,10 @@ static const struct bpf_func_proto bpf_sock_create_setsockopt_proto = {
 BPF_CALL_5(bpf_sock_create_getsockopt, struct sock *, sk, int, level,
 	   int, optname, char *, optval, int, optlen)
 {
+	if (IS_ENABLED(CONFIG_MEMCG) &&
+	    level == SOL_SOCKET && optname == SK_BPF_MEMCG_FLAGS)
+		return sk_bpf_set_get_memcg_flags(sk, optval, optlen, true);
+
 	return __bpf_getsockopt(sk, level, optname, optval, optlen);
 }
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 8002ac6293dc..ae30d7d54498 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2515,6 +2515,7 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 #ifdef CONFIG_MEMCG
 	/* sk->sk_memcg will be populated at accept() time */
 	newsk->sk_memcg = NULL;
+	mem_cgroup_sk_set_flags(newsk, mem_cgroup_sk_get_flags(sk));
 #endif
 
 	cgroup_sk_clone(&newsk->sk_cgrp_data);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index d42757f74c6e..9b62f1ae13ba 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -758,12 +758,16 @@ void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *new
 	    (!IS_ENABLED(CONFIG_IP_SCTP) ||
 	     sk_is_tcp(newsk) || sk_is_mptcp(newsk))) {
 		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
+		unsigned short flags;
 
+		flags = mem_cgroup_sk_get_flags(newsk);
 		mem_cgroup_sk_alloc(newsk);
 
 		if (mem_cgroup_from_sk(newsk)) {
 			int amt;
 
+			mem_cgroup_sk_set_flags(newsk, flags);
+
 			/* The socket has not been accepted yet, no need
 			 * to look at newsk->sk_wmem_queued.
 			 */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382..52b8c2278589 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7182,6 +7182,7 @@ enum {
 	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
 	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
 	SK_BPF_CB_FLAGS		= 1009, /* Get or set sock ops flags in socket */
+	SK_BPF_MEMCG_FLAGS	= 1010, /* Get or Set flags saved in sk->sk_memcg */
 };
 
 enum {
@@ -7204,6 +7205,11 @@ enum {
 						 */
 };
 
+enum {
+	SK_BPF_MEMCG_SOCK_ISOLATED	= (1UL << 0),
+	SK_BPF_MEMCG_FLAG_MAX		= (1UL << 1),
+};
+
 struct bpf_perf_event_value {
 	__u64 counter;
 	__u64 enabled;
-- 
2.51.0.338.gd7d06c2dae-goog


