Return-Path: <netdev+bounces-208693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD962B0CC08
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 22:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD4F4E3AC1
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 20:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F6E24502E;
	Mon, 21 Jul 2025 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Clk0bBB6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ACD24466F
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130207; cv=none; b=TXpmsRlflaIlhyfpSI1/mSoYIJ9MSg1KxfK/8IWa4Ac/5PtPrgCpSJ4+/NJC74WL7rye1gE+2RwN9mrZOmAycGKmhgb6mBH+kHb4VV+3l8mD4jjs9NaH5NRXjeO2Vt0NTxM0xvLIhXFASkz1D8qh75srUg7LvLnVeKcUWSgm+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130207; c=relaxed/simple;
	bh=zcJtco0ccgJTHzB1ejYPUAyCNXBYGZIb0tH+3/ptyMM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=umiDcrmehaypyC2+IXRHMlbw132QcJ2fRug1NKOibeM+6TrGNzvYe3M21jKA5N01X+LzAFsDP+m1VGQz2Yp7rHqrQ23nRexVq8kis6LrWO+dbE7/DRhNeXI1g4duQOlIOyIBP6W1EKbcO1XCDrXyRTjUh61DzcunBD5O5oAlYYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Clk0bBB6; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74ea7007866so4349069b3a.2
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 13:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130205; x=1753735005; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xdQJmy4blGtPG7gm97FaKmrzo1iYWfvkpp5t2qCAUbc=;
        b=Clk0bBB6mB51nLdFcQLr3WhBVImmxA/5ctRlOY8hsE8C/eSxl8HsAuWkXc6/hXu+Wq
         FMFsp0+4fKezzxcCabdBjRcPzz3Ux+z369J73ePb7DyGanoHAWj2SGKG4wenuvhtKHaj
         e9riogAt86QWZyuUBoqfC8DgXZfofDFa5w43Yrlc79MZZODisPuQHqmklfUJ+cqbb1jU
         9/HPV8adXVWlDoeTlisEq1RFyp5gOc4B2hhClPmQZrA+CPQoVoKrm6LlvelFis3i2Ge9
         AWmpjllc3ZvnQ+AwvcvFL4Ewuw2/i8/NdgKfFPW1xsz6p4SJpwp9HdYeFCepnCpRezbb
         3PWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130205; x=1753735005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdQJmy4blGtPG7gm97FaKmrzo1iYWfvkpp5t2qCAUbc=;
        b=Hp3L5ZY3pRD+A+5CrK95kyJOmna9EakkVM4k5V0WrIMgI6V6yVlZGjc5KEvPWeAFcQ
         jT3QYDjob7kMpBP+mhQsyFgobhfpu9Jcd7CykHPDcflpTeQIj88cKwa0WOBvITjlw0wV
         3fcPCBqC3MgvMXiay9ryoL7KJRSSY0zw9S6hgpZqRfJRpq9cVtd+eiS/7vF7eHpNiYDN
         dmu0CEgLs/5j/DtQtl44GAKzXE67PFJOh0IfFTASFAfdfHxnxy6rlxSyymXP/PX/btku
         M2bqqSh9R+6OhoDEfqFpLImePEPVWRwSZS19osN8YlnqTbSPyGxgKgXE5ogCIlepr6l3
         DC+w==
X-Forwarded-Encrypted: i=1; AJvYcCVHq+KeFgDwGkRCAQ+GvcOYqquqMf3EeQlwfnJCcuFb8YKo2e4bBb2adO9Sp4PIGy9EBrHAuJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZR5qBjMZo+hk9pSbuXyMq3walCre0OHCLnD5tdCKKeq95D/bd
	uG/K8WIuCMc5UFg3qVpoFQLjHZTIqnh1eQNMJCSEyZ+Fouh0rMvQYlTJY5HL0M3vvpBgtHl+QEj
	UJJhNEg==
X-Google-Smtp-Source: AGHT+IH3cVl1mpYtpoQ+O+03muSwme2Q/Ci4haqA3DdzxtA/Bzy9F6BXAV1IYuYuGpbybBp0dJL0GcI6AFY=
X-Received: from pfoo21.prod.google.com ([2002:a05:6a00:1a15:b0:747:a97f:513f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3c88:b0:742:a77b:8c4
 with SMTP id d2e1a72fcca58-7572267b30cmr34198928b3a.3.1753130204945; Mon, 21
 Jul 2025 13:36:44 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:31 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-13-kuniyu@google.com>
Subject: [PATCH v1 net-next 12/13] net-memcg: Store memcg->socket_isolated in sk->sk_memcg.
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

memcg->socket_isolated can change at any time, so we must
snapshot the value for each socket to ensure consistency.

Given sk->sk_memcg can be accessed in the fast path, it would
be preferable to place the flag field in the same cache line
as sk->sk_memcg.

However, struct sock does not have such a 1-byte hole.

Let's store the flag in the lowest bit of sk->sk_memcg and
add a helper to check the bit.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h | 20 +++++++++++++++++++-
 mm/memcontrol.c    | 13 +++++++++++--
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 5e8c73731531c..2e9d76fc2bf38 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2599,10 +2599,16 @@ static inline gfp_t gfp_memcg_charge(void)
 #ifdef CONFIG_MEMCG
 
 #define MEMCG_SOCK_ISOLATED	1UL
+#define MEMCG_SOCK_FLAG_MASK	MEMCG_SOCK_ISOLATED
+#define MEMCG_SOCK_PTR_MASK	~(MEMCG_SOCK_FLAG_MASK)
 
 static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 {
-	return sk->sk_memcg;
+	unsigned long val = (unsigned long)sk->sk_memcg;
+
+	val &= MEMCG_SOCK_PTR_MASK;
+
+	return (struct mem_cgroup *)val;
 }
 
 static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
@@ -2610,6 +2616,13 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
 	return mem_cgroup_sockets_enabled && mem_cgroup_from_sk(sk);
 }
 
+static inline bool mem_cgroup_sk_isolated(const struct sock *sk)
+{
+	struct mem_cgroup *memcg = sk->sk_memcg;
+
+	return (unsigned long)memcg & MEMCG_SOCK_ISOLATED;
+}
+
 static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
@@ -2636,6 +2649,11 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
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
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0a55c12a6679b..85decc4319f96 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5098,6 +5098,15 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
 EXPORT_SYMBOL(memcg_sockets_enabled_key);
 
+static void mem_cgroup_sk_set(struct sock *sk, const struct mem_cgroup *memcg)
+{
+	unsigned long val = (unsigned long)memcg;
+
+	val |= READ_ONCE(memcg->socket_isolated);
+
+	sk->sk_memcg = (struct mem_cgroup *)val;
+}
+
 void mem_cgroup_sk_alloc(struct sock *sk)
 {
 	struct mem_cgroup *memcg;
@@ -5116,7 +5125,7 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg1_tcpmem_active(memcg))
 		goto out;
 	if (css_tryget(&memcg->css))
-		sk->sk_memcg = memcg;
+		mem_cgroup_sk_set(sk, memcg);
 out:
 	rcu_read_unlock();
 }
@@ -5138,7 +5147,7 @@ void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
 
 	mem_cgroup_sk_free(newsk);
 	css_get(&memcg->css);
-	newsk->sk_memcg = memcg;
+	mem_cgroup_sk_set(newsk, memcg);
 }
 
 /**
-- 
2.50.0.727.gbf7dc18ff4-goog


