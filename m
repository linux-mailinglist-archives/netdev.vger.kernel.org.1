Return-Path: <netdev+bounces-208690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C79B0CBFC
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 22:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3940B546BD2
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 20:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF402242D7E;
	Mon, 21 Jul 2025 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NM0pfkxl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2675C242925
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130202; cv=none; b=saEkyRviePfE/KRHr94EuFzgKqMpxQU5HufWUqMB5Uoo8q/mX/G+grGyyqO+WkSnrZU+NM2VnmOnoS2HvXoq//0PEEgs61qu0IkqrZSvbBhP/GLBw3OKK79HBRFsNv9gKsP5I7cswYISxxessdmeBS1/C/34V9l9c3l0hOiEhTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130202; c=relaxed/simple;
	bh=vZGJ9wL2tKP1C/bt03aiYtXRl3GT/mAQoyMnOiZ1Zas=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dsi7S9SUcuFuJt1CJJQ5L+ACG3m1uS9O4Ugc5qJ7oVoryaWruNnDaxUv/B47vuGUkw5PXeb9uxruiyvin79W8Qm8JRUG52zrCj+AeoISdsit++GbVXbOvzH76hQukYjm2P/NeumEjKEWGKPf6u4uPJvkPAkV25YJ5wCK4FW1fBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NM0pfkxl; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31cb5cc3edcso3865906a91.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 13:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130200; x=1753735000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y8n9gDKu0Z+DKg5LJ3hwVCmIJaGqgWwDHBafRHDkb0E=;
        b=NM0pfkxlj/ohKRrorVRLTgDsaLF5oz4JuQQ3WlwuvxPTZ3z89kXBijL2cd92LU1d+0
         JaZLEDIq5XKvKlFTJPNdhMIfBqIc6mQMJZKI3ZZJ3ioC4AAG28NYn9+dbq1vag15XiPV
         x7tj1KiTy6jQ2i7dUXBr4OZ54l0s5iCWeoIAvFZv7eLfyELGMrwaKA5RIgOwDnV1H5si
         wIjrBGVg/+FRONmfMUPM6ujg5H8I+p3LZGYTXLgXPHDmd5ILK3HAwqMThhYltc3JLz43
         iXdPgDMVZm1/45hKGJuAaMVODAWioT85mdsHVpNF5RYzvypsbBtysYZy8FsBhBVRkYdJ
         Ws0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130200; x=1753735000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8n9gDKu0Z+DKg5LJ3hwVCmIJaGqgWwDHBafRHDkb0E=;
        b=E34gc7UNY05eSheGpc0G1RN8bIYjYotpNLLMCS0o5+owa0B2Bi1ctIEzi7cYZ3viB9
         40Jb83D2j6Bzf577hog1qk9XqS13IhdmQesuqBW9WE9HyYC5SldA2xrGM/2T6+c9uPRW
         1g2DZ1sLo1yjsnDgnXeAda7YZsw/HD/DdzJeR+l3BL+n++XZboT/VMh/SuKupuzsvaWE
         xlvz3Zyrz5i3+VPtTa+Gr+Spa5GGHmLjzR7p/wr9cxaGa1Fg4CIqBGHsWmmGhcInFwf6
         +pu0Mx8H1VIP9Yg/M0SAVyI3LG5/rHnMnyI1aekbdmoOcnbsMc5Ut/guyiunMAnAq2h6
         3kzw==
X-Forwarded-Encrypted: i=1; AJvYcCWZGtFDWFDtrnguefzAoTnfSv0c073mFNYI/jkE83OGmVhl5T87T5JxJ2wwrPWfYCmlw1P9ja8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyFLzwjd+3jZb1ejGNddDcL3xRBzwOBB4ycQTlM7yvtAFAWxy1
	CsugWkSR71SB9Gmv3vZNrcFkjab5IGON4vm+HsLjnGaqrYoKpbcM3ghomUzC0udbxhGGSxuBtwN
	ZV/f9Rg==
X-Google-Smtp-Source: AGHT+IFqBDBMTU4J8DYFBRw9/E8jIm7feevzb9voFXceLD2erJ4yjibft5LsmkvUX4Te4RL5m3uzw1eIikw=
X-Received: from pjb8.prod.google.com ([2002:a17:90b:2f08:b0:311:a879:981f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:544f:b0:312:26d9:d5b2
 with SMTP id 98e67ed59e1d1-31c9f2b5292mr34202138a91.0.1753130200564; Mon, 21
 Jul 2025 13:36:40 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:28 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-10-kuniyu@google.com>
Subject: [PATCH v1 net-next 09/13] net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

We will store a flag in the lowest bit of sk->sk_memcg.

Then, we cannot pass the raw pointer to mem_cgroup_under_socket_pressure().

Let's pass struct sock to it and rename the function to match other
functions starting with mem_cgroup_sk_.

Note that the helper is moved to sock.h to use mem_cgroup_from_sk().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/memcontrol.h | 18 ------------------
 include/net/proto_memory.h |  2 +-
 include/net/sock.h         | 21 +++++++++++++++++++++
 include/net/tcp.h          |  2 +-
 4 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9ccbcddbe3b8e..211712ec57d1a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1605,19 +1605,6 @@ bool mem_cgroup_sk_charge(const struct sock *sk, unsigned int nr_pages,
 			  gfp_t gfp_mask);
 void mem_cgroup_sk_uncharge(const struct sock *sk, unsigned int nr_pages);
 
-static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
-{
-#ifdef CONFIG_MEMCG_V1
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		return !!memcg->tcpmem_pressure;
-#endif /* CONFIG_MEMCG_V1 */
-	do {
-		if (time_before(jiffies, READ_ONCE(memcg->socket_pressure)))
-			return true;
-	} while ((memcg = parent_mem_cgroup(memcg)));
-	return false;
-}
-
 int alloc_shrinker_info(struct mem_cgroup *memcg);
 void free_shrinker_info(struct mem_cgroup *memcg);
 void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
@@ -1649,11 +1636,6 @@ static inline void mem_cgroup_sk_uncharge(const struct sock *sk,
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
index 859e63de81c49..8e91a8fa31b52 100644
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
index 3efdf680401dd..efb2f659236d4 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2604,6 +2604,22 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
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
+	do {
+		if (time_before(jiffies, READ_ONCE(memcg->socket_pressure)))
+			return true;
+	} while ((memcg = parent_mem_cgroup(memcg)));
+
+	return false;
+}
 #else
 static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 {
@@ -2614,6 +2630,11 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
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
index f9a0eb242e65c..9ffe971a1856b 100644
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
2.50.0.727.gbf7dc18ff4-goog


