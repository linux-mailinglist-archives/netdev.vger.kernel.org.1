Return-Path: <netdev+bounces-212557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D06B3B21340
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 19:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414D61A219BE
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D9F2DF3CF;
	Mon, 11 Aug 2025 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RxWPVgWx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C132D6E7B
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933507; cv=none; b=p8Q450caDd5RhZ12A1ur9Bj19BPmoCSlt6WZa9eR5RNO5O8rJ8DV4PsWFxXrO7bYC4bAm8gF4+eCFuJQCu2yGaUnHWs9NwyPXUWUPtSFNJ1qE6P96CckY9RsdVdfwW49a8hmtZRrfgaDJPz7PGicCu6IZ1kGZdfQe7j2rLtMvtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933507; c=relaxed/simple;
	bh=ZAz1mVorVRFB618WT7mmuym45O0GXG2XAc0+SY/lJcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tgz5ne4lQjpcANVFWCZmzoVUmynSoDa3EWM4/G2lVZ5yOZV+PM2NTOAo6FtCoWkIlFNqKy72Q48gp8qFsS+YDYeSqRFqZriTWLIL2fpzqPE6GNNLmSP3Bt+H+qXbsUZ0L5256T471T9BKxiqaCWe57Wlhpe5zK8eKUQ5b/nKgQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RxWPVgWx; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4225ab1829so3372945a12.0
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933505; x=1755538305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5aWSC3VweCjbJoCLklfizXMRwOKGjiP4PRbbUtyan4=;
        b=RxWPVgWx5tin7I4Fwr2uMm6VI5XTLrPfhiFlNQBiFeRFQv/OS6Yniuk3/Q21JYyaz2
         QK3LpA3hQYVYSdp/qLUVfEt1T9GYu1IcmQIav7kWDSp4lkrqk5WdKhMaviJ3e/8kMlE+
         2+gvIhYPtAwmwUSbqBtaNkLA07x9V11N/DetbS0mgOnN9O/rX6PCmYEqucxsLeoeYoCd
         AVa2kKBpSDSUxjGSUNRn9yLRMSe0ze180n7v/D67UgZYi5TuSK+F27BmhW7p/4e0TVJ1
         e2CpkbBbjE6X8e9iCCBcNKnZJOqS2hR7KQ90mLhHoO0AmDlq4J9upI1FnNFYzzbl3zxH
         2Q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933505; x=1755538305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5aWSC3VweCjbJoCLklfizXMRwOKGjiP4PRbbUtyan4=;
        b=dvW45CJF5U3qa9kVW04X83vV9xYlVTFp/fNZqu3yxfRiPZonyjENQQ+F/QY2u/qK7X
         mdR0xeIsOvVBnz6e1KOW7PuAzjaeGQlGoYVwBZZUJ/ERHYHlpxcrNcwqv6aNvsPMrQ9W
         S8XM6dIEHGc1D/ChYaWF03Lj8FeCtLrxcUn460oilj6chIkcaXoHh650qE8hm7BPzdfF
         cBfUHcNXBMxyryz8g/ekdd1hx3ql4lqsZG3r+dVzWwovWgUQCVlImCLq45K+FSvwLc51
         /+zD+IP0wg7nEEqyiu623cG5fojtZSa8lD1YFCB/8S6vt8VQKo3s+8xC6P5cezLdfvrk
         iWZA==
X-Forwarded-Encrypted: i=1; AJvYcCVjGli5HTtYjcak+L5rJTnpQDS7ZBSMIC1IebNwqdCbA/uBqJ8mopA2RZEYzTRy6TzopLLimCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXa/nCynAnCSDLkDaLWoWmYH6C66biYK4Q4nTNVSftug8tGADP
	zO2D09fjE0aYie4B8ap7pDafh+XTxQ+Vl8Ak+pS59EKyuh4MuTnN9TMPpjCOgPOIRVOthVdA+63
	yaieINA==
X-Google-Smtp-Source: AGHT+IEtI0hZmQkLl6do9xR5bq6fk+hkwUvmFCZYReLtL0+PGPBf8SbdQd0pvNwlObuC5a18Dro3jK8mXEE=
X-Received: from plbmi15.prod.google.com ([2002:a17:902:fccf:b0:23f:cd4f:c45d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecc2:b0:234:f4da:7eeb
 with SMTP id d9443c01a7336-242c1ffb1f7mr164182355ad.7.1754933504815; Mon, 11
 Aug 2025 10:31:44 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:37 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-10-kuniyu@google.com>
Subject: [PATCH v2 net-next 09/12] net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
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
2.51.0.rc0.155.g4a0f42376b-goog


