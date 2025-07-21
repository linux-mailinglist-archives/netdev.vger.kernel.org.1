Return-Path: <netdev+bounces-208687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016C7B0CBF7
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 22:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A46E546A7A
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 20:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762DF241685;
	Mon, 21 Jul 2025 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZANpqWv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F156524166F
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 20:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130198; cv=none; b=P+HLjIoZchziLrU1+sn9hTjmFcFYr137B6PFD2ECBG7j3l7DJnfMkCjaO+wK+c9KPaRdWKr8RY4UOho3QBTG0n9QMm/gSVUw/m1m9kSCQ96hjHPCVBd8UOctrvcASxsk+8GyyJPBJShGlnmpfHi2JbcJCjGM/dVAHbsAXkHXzYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130198; c=relaxed/simple;
	bh=wN2CF4G/nCvFEdVvHYYf1Bhf5FKqcQYYZZZXgtBjYY4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sqgLie0YEQTiCSbHdNFxmdQ2FBS3wQ9l7r9TP8OOKUPuk5OT2q9Qg751xpJsVUH0fh6z0VpfUMmxlrHV2oXqjlYjJiJRdPP1FvSQnPx2Y685NTTboJL+POWy+IdN3TloIIsfmhb/dSm9DnpAYGmC3EbRzBIPBfvzyatG8v4i6hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZANpqWv; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74d15d90cdbso4039718b3a.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 13:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130196; x=1753734996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mrGASm3CxvureKJlvs5onpPMiZoMQw1GHMHnORXuhuQ=;
        b=DZANpqWv6hmMDLoJK8AeahpFKdnzkwLxvp6jaMZH34XrC6FbVv1j0vMPVL+DdMRsMM
         WSykJRSYAXmOANW2r9c1jPEqgNz8nrXGughNjjo01BPks5Ov1hsnakR7q3DNu5+ezoqL
         o2Rknp39RpDMkUzQ2rgD45ltZfETyedhaBZNZfDr0Bp7cUpdPlJSf+rYToiOzdCA2Dws
         YfUgzMUDPp5aUm9HE/6eQZIjK5qc3xjOQvcnErWwJY4jVhnYEi59Kerycn1I83GFEFGL
         IaeSVyfRWvxz6MbxWH8/8WtImwPY5TkLIt16V5f/TtMQs6e8FE4/C+9aSRzTWWSxnh4b
         61vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130196; x=1753734996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mrGASm3CxvureKJlvs5onpPMiZoMQw1GHMHnORXuhuQ=;
        b=Js1BXYU8AGpuR3eVHeLtSNc+QfvcurOV00YyT1qJKa/7xFwSEfDd7LQWaqzlT/pQhC
         eKGF1evhDs8HqoVlhIVIESTUoK2mvV1YsERVaR9BUphwNuQ0l/bIp+0tfglLSQmAX08p
         EVBorO53vLUAqbi2kdNdHL6YdW2Fv+sW+OqWe+rxfWNPuh9f2IfOE2sCpcZZRVLu0kSI
         mf99i7bDFEgoxDEta6mLMOVNPzGgESdnFw2s1Gz4dVVAbNeUi7t9Su0wjeL6Lxeo6rhs
         kfaNVBpxBFphiPeGYZNUL5EaVRdxNwHT7UsUZ6VIcDHvnjKnsm/RZpSmhkvM3MIYx6N2
         pvPA==
X-Forwarded-Encrypted: i=1; AJvYcCVCin9Jlf7X0EFxaOPoPAEKIN9tiVT8nmaJ6Sd78IbfGeaJMPrFjN2bnooEwXQ0wwhYUM2fIXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWzL/PsYQHR523cxME7oqt+yL8cqe5rcW4n7FQsP6CE+e5p9Oe
	ns+oH1BAqHCzhuojeKXtUBJgshF9kl1ZaD6n90LRHP/kXjA9x0TOuIWNUBuLZyq/Ne0OhESYsje
	060+zUQ==
X-Google-Smtp-Source: AGHT+IFThfJRCKKDOR0Nefiu/tzdT/WdSWlskFFKFs1Y1mRRZJXgb5GsFfKf6cD/RAM/mAjuTqVBtl3aIvc=
X-Received: from pfbcw5.prod.google.com ([2002:a05:6a00:4505:b0:748:f4a1:ae2e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2189:b0:748:68dd:eb8c
 with SMTP id d2e1a72fcca58-7572487561emr30325627b3a.23.1753130196319; Mon, 21
 Jul 2025 13:36:36 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:25 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-7-kuniyu@google.com>
Subject: [PATCH v1 net-next 06/13] net-memcg: Introduce mem_cgroup_from_sk().
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

Then, directly dereferencing sk->sk_memcg will be illegal, and we
do not want to allow touching the raw sk->sk_memcg in many places.

Let's introduce mem_cgroup_from_sk().

Other places accessing the raw sk->sk_memcg will be converted later.

Note that we cannot define the helper as an inline function in
memcontrol.h as we cannot access any fields of struct sock there
due to circular dependency, so it is placed in sock.h.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h              | 12 ++++++++++++
 mm/memcontrol.c                 | 14 +++++++++-----
 net/ipv4/inet_connection_sock.c |  2 +-
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index c8a4b283df6fc..811f95ea8d00c 100644
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
index 54eb25d8d555c..89b33e635cf89 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5086,18 +5086,22 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 
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
index 724bd9ed6cd48..93569bbe00f44 100644
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
2.50.0.727.gbf7dc18ff4-goog


