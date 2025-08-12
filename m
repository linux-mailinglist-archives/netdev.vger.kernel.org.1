Return-Path: <netdev+bounces-213063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C32A5B23126
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 20:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828E81883FAE
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D195C2FFDDC;
	Tue, 12 Aug 2025 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YsTKnHtu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1532FFDCD
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021546; cv=none; b=HgBmqpG10y1HGVTGxKpGAt/VgYrIsDYKQDcAFQ9gwCjqgPJyUbGWYSH1X/qT3FqssChvosIA+ZbjWTlCEKJA6vcLnWlIgr2zJdEN5yw/NxN7VuNC9ELchx8/BRYLnBYsOyXN024x/ugW0fYriFYD4bXIh7jbl38J7GWeM9oeMnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021546; c=relaxed/simple;
	bh=DpTvGUJvesR0RNAUmuU/kx03NdxonaF+OWOIs2c8qNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y0wsdHT/0KzqXYDTUKrC4fz4+33Y/KYNmMUeeqXqkplrRZ9z4aX1AfOXhoKeG31Wl6cZT1eAAvcwccNV3mUjfQQksI+IgFvY7n8Bi8oTpDzyQIF8NNYZGGRI//6otClNArPHmK31si+ffXOf2J4W+3g6VKtE+WDMWAFWDFaxqBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YsTKnHtu; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76bcf2cac36so5410845b3a.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021545; x=1755626345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tnEkA+52sI8esqmC0cNEqYlTXuIo2cbdOxRfbJLXess=;
        b=YsTKnHtuFn1EzKAI+HPcJqwkbJvpVRDkdDePJVh7KmTsxqMCPgKujsx1B1BXJtD96J
         aoRXOznqBBD25Bz+/MYzywfqo5pqPAhFNvyp++inAXBRHbFzGeRQk2iypahbr3gqzT9j
         feZSJafESz+G84PSVS9zahavig8IJhItuldUt+c8Tx6UnQ/fXJ3W9YCNuwYaPXeJO7uE
         DAOzPJLGV/jsxHbyAgqGG9chcuZCIyinFlCjSMLXr+MRo7UOGPK92DyjdlOgJ2RqLqLw
         LCnfRZCJn9RH82KnquUuEKKhtuugQ3Prlor9PogwvAw4+HYhgzshg+d3F0jIuSIIj9yT
         QuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021545; x=1755626345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnEkA+52sI8esqmC0cNEqYlTXuIo2cbdOxRfbJLXess=;
        b=V6UMZj7qs8Kw/hpg4KwcY3P6cMCiQyPXoPG7NC/SiDnr//b5wDUT5x6TxjjiI75wdv
         1O70j5a8cF+4lJjFJpJy05wzSCf4G8dh3cT4O8CcqdPWc9gxe/k9zZULKOk+AsD0de8d
         Yk3majzyBCxI/FPGPw9s5ThP6L2hTlm606/N9II97XhmNQuiASIzotay8fw3nfH2mLyP
         jNMAALXnEYMY/Y4l75znkcICUrk0EXXJLYkvekgdwdFHa17tlG3IFxhzu5BdcnWqvgRS
         LBuwoBJMewnJtCrxj0q31nznH9lFSvoZ4IdLJ4KQuDM0AtY5nfT7RZvKiVxCusBpH+5w
         8o0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnAiu0y9dz6aGf/WIcTUkSbWTspMlkE8C35s3XCWVjAgKXn0S5r9tGKiNziCNY2ggRcTDCPoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgK7nyGlDSFHcFPdWWsXZeUHE39NQs5dhyhmA5F3aH+JRLKDl6
	5me7sCv+zldqKQtj0x8nYIkcvJihIA1ETf7Yi2BtGcDNDNgGLrc1b8gtMepIAibi1FrDHIIY2AC
	2rKOc5w==
X-Google-Smtp-Source: AGHT+IGoBWtNHQB4gmu0I/l/gxdqVZ0w9YFTpuFgmmNNhALMQosyvo+/jCxMWRY+Nn4mDpLorfHvQa7+8R0=
X-Received: from pfoo14.prod.google.com ([2002:a05:6a00:1a0e:b0:76b:74b4:ed62])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:885:b0:73d:fa54:afb9
 with SMTP id d2e1a72fcca58-76e20cca950mr205362b3a.7.1755021544485; Tue, 12
 Aug 2025 10:59:04 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:24 +0000
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-7-kuniyu@google.com>
Subject: [PATCH v3 net-next 06/12] net-memcg: Introduce mem_cgroup_from_sk().
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

Then, directly dereferencing sk->sk_memcg will be illegal, and we
do not want to allow touching the raw sk->sk_memcg in many places.

Let's introduce mem_cgroup_from_sk().

Other places accessing the raw sk->sk_memcg will be converted later.

Note that we cannot define the helper as an inline function in
memcontrol.h as we cannot access any fields of struct sock there
due to circular dependency, so it is placed in sock.h.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h              | 12 ++++++++++++
 mm/memcontrol.c                 | 14 +++++++++-----
 net/ipv4/inet_connection_sock.c |  2 +-
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index c8a4b283df6f..811f95ea8d00 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2594,6 +2594,18 @@ static inline gfp_t gfp_memcg_charge(void)
 	return in_softirq() ? GFP_ATOMIC : GFP_KERNEL;
 }
 
+#ifdef CONFIG_MEMCG
+static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
+{
+	return sk->sk_memcg;
+}
+#else
+static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
+{
+	return NULL;
+}
+#endif
+
 static inline long sock_rcvtimeo(const struct sock *sk, bool noblock)
 {
 	return noblock ? 0 : READ_ONCE(sk->sk_rcvtimeo);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 08c6e06750ac..2db7df32fd7c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5020,18 +5020,22 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 
 void mem_cgroup_sk_free(struct sock *sk)
 {
-	if (sk->sk_memcg)
-		css_put(&sk->sk_memcg->css);
+	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
+
+	if (memcg)
+		css_put(&memcg->css);
 }
 
 void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
 {
-	if (sk->sk_memcg == newsk->sk_memcg)
+	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
+
+	if (memcg == mem_cgroup_from_sk(newsk))
 		return;
 
 	mem_cgroup_sk_free(newsk);
-	css_get(&sk->sk_memcg->css);
-	newsk->sk_memcg = sk->sk_memcg;
+	css_get(&memcg->css);
+	newsk->sk_memcg = memcg;
 }
 
 /**
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 724bd9ed6cd4..93569bbe00f4 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -718,7 +718,7 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 		lock_sock(newsk);
 
 		mem_cgroup_sk_alloc(newsk);
-		if (newsk->sk_memcg) {
+		if (mem_cgroup_from_sk(newsk)) {
 			/* The socket has not been accepted yet, no need
 			 * to look at newsk->sk_wmem_queued.
 			 */
-- 
2.51.0.rc0.205.g4a044479a3-goog


