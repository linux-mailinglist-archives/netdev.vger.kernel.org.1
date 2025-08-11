Return-Path: <netdev+bounces-212556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897BEB21346
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 19:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C26E3E4B0A
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926C12DE1FE;
	Mon, 11 Aug 2025 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gqi9u/Fo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B8F2D47E0
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933505; cv=none; b=Z+I61T8JlagTuo2ywsQ04bg2dRWY6uZoban/nPMr7Xj3aE5NNrS3SNsT6JFS4PNdrX927m8NZvwzDa34BB+MFr+pzpEl5P4e0qbqijCCEkHHXLBxsPSQ1ModCW3o0Twcrg+qPbNKLLdrsIcXadW98aUwjSh7LQbYmLjApczUeQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933505; c=relaxed/simple;
	bh=gaEivgXfEYeeBWuRFL2zEmiDtbCL7eGp6LY2EyRWEnA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rISoWpDfdBjvv+rQoJqvZE86tJfCd8oPdApRQgXEmI+hPm4gr8/RjNTDb21VyPzDEscvR8MSUBWDaQRYPFzRS31MrQTrrXUNRoPedhwHKGQnxNoe4FzBplrxPLYCua4ixKZYVXSMFzbUgV78K/+rFbeoCIMZsPp02WgDcEEjmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gqi9u/Fo; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b46ec2ebf19so697132a12.1
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 10:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933503; x=1755538303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+1u6jMeY2ieN9JTNQfSbMa5Js54FEKg2f0HWf6b31A=;
        b=gqi9u/FoiJowRWTbGMjScf37GznvoxUxD5G9Kb8xyUPbnZyrV/AiW/0+YWmT3hoFYX
         9QC0gAuLaNcFZQZLE+Ivi2Rw+L1MTdYqXPmpNVyefFygQB8BChrMQDlYcsAXZaQEDh2b
         r5pa1d4n32HGRKb9f309hLm7EOEQe+fbohomPfPOQb5KdryEVuS307z+5G/31ursIfQn
         /jT7u1OnbKMDxx2mZ29h7KbWkiKkQiWDuJdr0/RSlfDtLwYTHWbvVlzsNy46jYQodQvB
         6eG0UxWobr0q7ZYtc3+n1V17r/eFJvOR6cWGf252DSRtNzOR7vuc8PT1+oEI4SE0DGEm
         MEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933503; x=1755538303;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+1u6jMeY2ieN9JTNQfSbMa5Js54FEKg2f0HWf6b31A=;
        b=adtpKMzXFxCx9HMcXcMPV9yI3vUAkPjjiKl9NGbf/EZVWeGz+1Jo9PgID/D2C00X5r
         Ne++HLo7xbXd0Wusp3GHdqjuxU3ubFsxmyJIgCOUsAmJesBoTySKcBPVhvRnkj0d654c
         msAK01iQlndnobdRFtkMIjG0DNhqJwPhxjOi14Tg2eEsAKGGHL6Le8M/6C0EN2pcuJt3
         bZWgSkJyuuICKPXe8ToXQiFkjziqN8Fou1cdy00d0XZxkle3SQxfTlf+J3gTJcWtuTS/
         T0Iw30h2dmlkN0D+fH1pW8X1/5rYPIjluS4q1tZ2w4i6E914bT2MbYSyV5bNs1/GJUbC
         v2Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVHhuBolthUlU2El+cdl5oYrswxppf7L/dyUWLhKlAkKc87m0y0cbGmaiA2Cfbc0dw062QqPS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQs0oCsdL1jo+cqIgfLgArZdYA4ZbpbkBwWct4Y/rG9u9GznbX
	N7GfPozkRF9s39sSm/0DTbV4PYt6/XSTcKfnulReBroj2TgIM1wt/BPmT4+vVSX31IFJ2Jb0mHQ
	6kxy1XA==
X-Google-Smtp-Source: AGHT+IF+332pvw2sB451OsHxyvelGplXYYulyN1CCJNVXmCoa3JJJxGz6VI5u5TgIIL1LHaViiMtLlcnWFI=
X-Received: from plnd3.prod.google.com ([2002:a17:903:1983:b0:23f:efa6:2e49])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32ca:b0:234:f4da:7eed
 with SMTP id d9443c01a7336-242fc3a34d1mr5329425ad.44.1754933503244; Mon, 11
 Aug 2025 10:31:43 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:36 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-9-kuniyu@google.com>
Subject: [PATCH v2 net-next 08/12] net-memcg: Pass struct sock to mem_cgroup_sk_(un)?charge().
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

Then, we cannot pass the raw pointer to mem_cgroup_charge_skmem()
and mem_cgroup_uncharge_skmem().

Let's pass struct sock to the functions.

While at it, they are renamed to match other functions starting
with mem_cgroup_sk_.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/memcontrol.h      | 29 ++++++++++++++++++++++++-----
 mm/memcontrol.c                 | 18 +++++++++++-------
 net/core/sock.c                 | 24 +++++++++++-------------
 net/ipv4/inet_connection_sock.c |  2 +-
 net/ipv4/tcp_output.c           |  3 +--
 5 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 25921fbec685..0837d3de3a68 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1596,15 +1596,16 @@ static inline void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 #endif	/* CONFIG_CGROUP_WRITEBACK */
 
 struct sock;
-bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
-			     gfp_t gfp_mask);
-void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages);
 #ifdef CONFIG_MEMCG
 extern struct static_key_false memcg_sockets_enabled_key;
 #define mem_cgroup_sockets_enabled static_branch_unlikely(&memcg_sockets_enabled_key)
+
 void mem_cgroup_sk_alloc(struct sock *sk);
 void mem_cgroup_sk_free(struct sock *sk);
 void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk);
+bool mem_cgroup_sk_charge(const struct sock *sk, unsigned int nr_pages,
+			  gfp_t gfp_mask);
+void mem_cgroup_sk_uncharge(const struct sock *sk, unsigned int nr_pages);
 
 #if BITS_PER_LONG < 64
 static inline void mem_cgroup_set_socket_pressure(struct mem_cgroup *memcg)
@@ -1660,13 +1661,31 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
 void reparent_shrinker_deferred(struct mem_cgroup *memcg);
 #else
 #define mem_cgroup_sockets_enabled 0
-static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
-static inline void mem_cgroup_sk_free(struct sock *sk) { };
+
+static inline void mem_cgroup_sk_alloc(struct sock *sk)
+{
+}
+
+static inline void mem_cgroup_sk_free(struct sock *sk)
+{
+}
 
 static inline void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
 {
 }
 
+static inline bool mem_cgroup_sk_charge(const struct sock *sk,
+					unsigned int nr_pages,
+					gfp_t gfp_mask)
+{
+	return false;
+}
+
+static inline void mem_cgroup_sk_uncharge(const struct sock *sk,
+					  unsigned int nr_pages)
+{
+}
+
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
 	return false;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2db7df32fd7c..d32b7a547f42 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5039,17 +5039,19 @@ void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
 }
 
 /**
- * mem_cgroup_charge_skmem - charge socket memory
- * @memcg: memcg to charge
+ * mem_cgroup_sk_charge - charge socket memory
+ * @sk: socket in memcg to charge
  * @nr_pages: number of pages to charge
  * @gfp_mask: reclaim mode
  *
  * Charges @nr_pages to @memcg. Returns %true if the charge fit within
  * @memcg's configured limit, %false if it doesn't.
  */
-bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
-			     gfp_t gfp_mask)
+bool mem_cgroup_sk_charge(const struct sock *sk, unsigned int nr_pages,
+			  gfp_t gfp_mask)
 {
+	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
+
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return memcg1_charge_skmem(memcg, nr_pages, gfp_mask);
 
@@ -5062,12 +5064,14 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
 }
 
 /**
- * mem_cgroup_uncharge_skmem - uncharge socket memory
- * @memcg: memcg to uncharge
+ * mem_cgroup_sk_uncharge - uncharge socket memory
+ * @sk: socket in memcg to uncharge
  * @nr_pages: number of pages to uncharge
  */
-void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
+void mem_cgroup_sk_uncharge(const struct sock *sk, unsigned int nr_pages)
 {
+	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
+
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
 		memcg1_uncharge_skmem(memcg, nr_pages);
 		return;
diff --git a/net/core/sock.c b/net/core/sock.c
index ab658fe23e1e..5537ca263858 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1041,8 +1041,8 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	pages = sk_mem_pages(bytes);
 
 	/* pre-charge to memcg */
-	charged = mem_cgroup_charge_skmem(sk->sk_memcg, pages,
-					  GFP_KERNEL | __GFP_RETRY_MAYFAIL);
+	charged = mem_cgroup_sk_charge(sk, pages,
+				       GFP_KERNEL | __GFP_RETRY_MAYFAIL);
 	if (!charged)
 		return -ENOMEM;
 
@@ -1054,7 +1054,7 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	 */
 	if (allocated > sk_prot_mem_limits(sk, 1)) {
 		sk_memory_allocated_sub(sk, pages);
-		mem_cgroup_uncharge_skmem(sk->sk_memcg, pages);
+		mem_cgroup_sk_uncharge(sk, pages);
 		return -ENOMEM;
 	}
 	sk_forward_alloc_add(sk, pages << PAGE_SHIFT);
@@ -3263,17 +3263,16 @@ EXPORT_SYMBOL(sk_wait_data);
  */
 int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
+	bool memcg_enabled = false, charged = false;
 	struct proto *prot = sk->sk_prot;
-	struct mem_cgroup *memcg = NULL;
-	bool charged = false;
 	long allocated;
 
 	sk_memory_allocated_add(sk, amt);
 	allocated = sk_memory_allocated(sk);
 
 	if (mem_cgroup_sk_enabled(sk)) {
-		memcg = sk->sk_memcg;
-		charged = mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge());
+		memcg_enabled = true;
+		charged = mem_cgroup_sk_charge(sk, amt, gfp_memcg_charge());
 		if (!charged)
 			goto suppress_allocation;
 	}
@@ -3347,10 +3346,9 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 		 */
 		if (sk->sk_wmem_queued + size >= sk->sk_sndbuf) {
 			/* Force charge with __GFP_NOFAIL */
-			if (memcg && !charged) {
-				mem_cgroup_charge_skmem(memcg, amt,
-					gfp_memcg_charge() | __GFP_NOFAIL);
-			}
+			if (memcg_enabled && !charged)
+				mem_cgroup_sk_charge(sk, amt,
+						     gfp_memcg_charge() | __GFP_NOFAIL);
 			return 1;
 		}
 	}
@@ -3360,7 +3358,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 	sk_memory_allocated_sub(sk, amt);
 
 	if (charged)
-		mem_cgroup_uncharge_skmem(memcg, amt);
+		mem_cgroup_sk_uncharge(sk, amt);
 
 	return 0;
 }
@@ -3399,7 +3397,7 @@ void __sk_mem_reduce_allocated(struct sock *sk, int amount)
 	sk_memory_allocated_sub(sk, amount);
 
 	if (mem_cgroup_sk_enabled(sk))
-		mem_cgroup_uncharge_skmem(sk->sk_memcg, amount);
+		mem_cgroup_sk_uncharge(sk, amount);
 
 	if (sk_under_global_memory_pressure(sk) &&
 	    (sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)))
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 93569bbe00f4..0ef1eacd539d 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -727,7 +727,7 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 		}
 
 		if (amt)
-			mem_cgroup_charge_skmem(newsk->sk_memcg, amt, gfp);
+			mem_cgroup_sk_charge(newsk, amt, gfp);
 		kmem_cache_charge(newsk, gfp);
 
 		release_sock(newsk);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 37fb320e6f70..dfbac0876d96 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3579,8 +3579,7 @@ void sk_forced_mem_schedule(struct sock *sk, int size)
 	sk_memory_allocated_add(sk, amt);
 
 	if (mem_cgroup_sk_enabled(sk))
-		mem_cgroup_charge_skmem(sk->sk_memcg, amt,
-					gfp_memcg_charge() | __GFP_NOFAIL);
+		mem_cgroup_sk_charge(sk, amt, gfp_memcg_charge() | __GFP_NOFAIL);
 }
 
 /* Send a FIN. The caller locks the socket for us.
-- 
2.51.0.rc0.155.g4a0f42376b-goog


