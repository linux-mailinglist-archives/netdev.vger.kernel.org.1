Return-Path: <netdev+bounces-224937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F93B8BABF
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 02:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39867E6E1A
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 00:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1888248C;
	Sat, 20 Sep 2025 00:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VOd6jAsR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA2341A8F
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 00:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758326885; cv=none; b=adsYv+ONrLkl/L9m5H4OiIBhb1AUqtpep9ATIGO5ZxLIfrqZssYP9LW594gfECBGDaAgNjV09D5zQaRPoqG6mWGU1kuPAwAd/AC7ZuR9j1eDGRWfcmLttEKEu3ljWrlCqsMXTjD8jFooTavDW3mkJ5KixSFZSoJT1MwS5h5V7ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758326885; c=relaxed/simple;
	bh=4jP4OC8EVegazx5AzODqJ5ulFjhYCVTsKrt2Pc+garQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PuyXIuj5gY6Hb4gLIPOiZ71O2ngMPzzKI73IgmFlBzXp9IFszPGjJzklON/yeWToozmRkFTYhifCdiTj8VvIeF+v+Y0wcATMTi+LNru1UbEUWz6X8z/HrbhP0sBMxxEqYDja9p9D0YrD5XqPgENn6HkDb7cYsHBxkHLwqsKfbX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VOd6jAsR; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b549a25ade1so3540160a12.3
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 17:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758326883; x=1758931683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vBsFBXp3xNxFEEA+gIAMAMl0zG0ZkQ0sPQwciagzxSE=;
        b=VOd6jAsRnthS6NxAPwGxqD268s+zNBSkQ9C413mymlzbkXzKEUJBcVt2RSeLoRz4Xg
         36+Ev9DaeZzNpFjv402/4nuRm1XSKeIENDDKv5UITp8f4UcxzpYhlmq44N/kz9RktRXB
         uvxq8g933qW1vIbWxMEqTIKVFEVVEPhLkZQap1bUKv4VaiLf7MCA+6Rk+PP166Iu7l7P
         hduzSDYj/lJHh7Ejhhgg2oTqIkyvaAmmC8xhfwn0opBL+kBvzieV4V7op6psl11gnNYX
         hq4MGvElhFQ084Mc4PBvqm1Wr1A7RRC4UO/U2ZMYzLH5Ory+YkstnDZK+A8SBq77Bri1
         Piqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758326883; x=1758931683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBsFBXp3xNxFEEA+gIAMAMl0zG0ZkQ0sPQwciagzxSE=;
        b=d6g1RwjY/2EFfRLE9HALF4B7CbYeDRQzsojx6Umh4np93i0jyMlY6eUKTZDnGLTYUL
         KBKjOHU0oekxx1Dqr47dhPyxxiMu6i7eiItojKbwReCK365m+yewlapDSTDNQ3RDJqdI
         uv7IgKeiZdM8dWI98dmLW9AsATk7oeRFzsQnGiIgUx/LObfKwGRpY0wb5bHpowyiJ4WD
         +ISFHYc9LVj7hYb6IVZY1KrcCFcRRP+MRQ/dS+dQRyk4m6aJB3If5u/A7h6qaFAm+zT5
         9inh/9xGWwc0Q78y/CbSdtl5DoC4uTb16Ll4hpwnQdskC+ZmmjQCJgug1I1sLodchPky
         tcnA==
X-Forwarded-Encrypted: i=1; AJvYcCVAYSFvoXMXgGsgp0BNq2Kyepg9WFAUJql0mZoFnTgTMfsWu4Yzv99LGlmL1KmYby2cxqAChW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKjtSEV/c4YIS7LhTlxG0Lw6M7bF8hXFrnpEiTWSPkceh4mrOk
	vduICc6XqZpCojuWP3czIxsMoO0CVkhHt7Vw92gcmSclvanCHO/1M1VHmAEz7eyt9IULo4GZDbf
	lvFhd3Q==
X-Google-Smtp-Source: AGHT+IH7yuSw0EzJYNbM8354EGtZ+pVR1qQZsNJWXk3dWGkcza1vL+W1SKiDoS3XWRBqwJgJs0XKZCLtqqg=
X-Received: from pgbcy9.prod.google.com ([2002:a05:6a02:2289:b0:b55:117c:84a3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3393:b0:243:ff76:eada
 with SMTP id adf61e73a8af0-29257e11217mr8009378637.6.1758326883294; Fri, 19
 Sep 2025 17:08:03 -0700 (PDT)
Date: Sat, 20 Sep 2025 00:07:19 +0000
In-Reply-To: <20250920000751.2091731-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250920000751.2091731-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250920000751.2091731-6-kuniyu@google.com>
Subject: [PATCH v10 bpf-next/net 5/6] bpf: Introduce SK_BPF_MEMCG_FLAGS and SK_BPF_MEMCG_EXCLUSIVE.
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

If a socket has sk->sk_memcg with SK_MEMCG_EXCLUSIVE, it is decoupled
from the global protocol memory accounting.

This is controlled by net.core.memcg_exclusive sysctl, but it lacks
flexibility.

Let's support flagging (and clearing) SK_MEMCG_EXCLUSIVE via
bpf_setsockopt() at the BPF_CGROUP_INET_SOCK_CREATE hook.

  u32 flags = SK_BPF_MEMCG_EXCLUSIVE;

  bpf_setsockopt(ctx, SOL_SOCKET, SK_BPF_MEMCG_FLAGS,
                 &flags, sizeof(flags));

As with net.core.memcg_exclusive, this is inherited to child sockets,
and BPF always takes precedence over sysctl at socket(2) and accept(2).

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

Most changes are inline and hard to trace, but a microbenchmark on
__sk_mem_raise_allocated() during neper/tcp_stream showed that more
samples completed faster with SK_MEMCG_EXCLUSIVE.  This will be more
visible under tcp_mem pressure.

  # bpftrace -e 'kprobe:__sk_mem_raise_allocated { @start[tid] = nsecs; }
    kretprobe:__sk_mem_raise_allocated /@start[tid]/
    { @end[tid] = nsecs - @start[tid]; @times = hist(@end[tid]); delete(@start[tid]); }'
  # tcp_stream -6 -F 1000 -N -T 256

Without bpf prog:

  [128, 256)          3846 |                                                    |
  [256, 512)       1505326 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
  [512, 1K)        1371006 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     |
  [1K, 2K)          198207 |@@@@@@                                              |
  [2K, 4K)           31199 |@                                                   |

With bpf prog in the next patch:
  (must be attached before tcp_stream)
  # bpftool prog load sk_memcg.bpf.o /sys/fs/bpf/sk_memcg type cgroup/sock_create
  # bpftool cgroup attach /sys/fs/cgroup/test cgroup_inet_sock_create pinned /sys/fs/bpf/sk_memcg

  [128, 256)          6413 |                                                    |
  [256, 512)       1868425 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
  [512, 1K)        1101697 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                      |
  [1K, 2K)          117031 |@@@@                                                |
  [2K, 4K)           11773 |                                                    |

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v7:
  * Update commit message.

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
 include/uapi/linux/bpf.h       |  6 ++++++
 mm/memcontrol.c                |  3 +++
 net/core/filter.c              | 34 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  6 ++++++
 4 files changed, 49 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..35e3ce40ac90 100644
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
+	SK_BPF_MEMCG_EXCLUSIVE	= (1UL << 0),
+	SK_BPF_MEMCG_FLAG_MAX	= (1UL << 1),
+};
+
 struct bpf_perf_event_value {
 	__u64 counter;
 	__u64 enabled;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 88028af8ac28..b7d405b57e23 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4997,6 +4997,9 @@ EXPORT_SYMBOL(memcg_sockets_enabled_key);
 
 static void mem_cgroup_sk_set(struct sock *sk, struct mem_cgroup *memcg)
 {
+	BUILD_BUG_ON((unsigned short)SK_MEMCG_EXCLUSIVE != SK_BPF_MEMCG_EXCLUSIVE);
+	BUILD_BUG_ON((unsigned short)SK_MEMCG_FLAG_MAX != SK_BPF_MEMCG_FLAG_MAX);
+
 	sk->sk_memcg = memcg;
 
 #ifdef CONFIG_NET
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
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382..35e3ce40ac90 100644
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
+	SK_BPF_MEMCG_EXCLUSIVE	= (1UL << 0),
+	SK_BPF_MEMCG_FLAG_MAX	= (1UL << 1),
+};
+
 struct bpf_perf_event_value {
 	__u64 counter;
 	__u64 enabled;
-- 
2.51.0.470.ga7dc726c21-goog


