Return-Path: <netdev+bounces-115349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8AE945ED1
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F76D1F2337A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85D81E487A;
	Fri,  2 Aug 2024 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tva4QQl1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196951E4EE8
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722606044; cv=none; b=tMiHMeMMrrE8HrIS29xzoscVlEu3z/EBTqFJnuHPMbwOPhmi5Hx4GZFckmivCUd4dpjpUPi7hLo3KzNoEu/p6CtUut6A/S0t2v9U6O+0M+mQj9qI80WbBGfDCWDBdroo8QcroKR5FsDm+8w9OBjxd8CD7u1UjDqmwbfnVngGVYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722606044; c=relaxed/simple;
	bh=2Glza3dJ0RpAAgALc4nO1PaIqGZhs1DBn0m7rOkiRWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b1McUr7vmKttYgpM5AtfLiPdVG4HkoAUprJEn18EcOIpJCmaBPPJer7BesAlKjet4SJLNBYdLWq34s6kkXsvTlYv+EVgiKQLsbQ7ULhwEmTDJhQg9d1V8U8CMe3JoC6iIrOKeZnCW0Pasq9VFY8LCC5PaLaRq2WxtcR2PHxLNxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tva4QQl1; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-44fe92a34d2so115218691cf.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 06:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722606042; x=1723210842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iJCD9E0BGO+udSkWv5s+vPmVAmzrYKRy5J3lskBd7Ks=;
        b=Tva4QQl1CtSAsb981kzdTZdRDt59m6I4qzP+8DvVZwkcV0VovO2u9SoxL+qU7tE1q4
         Xm0pde/qYatMH1jLAkivB2OgFP/LWNcj2kWBrHesQWe1y6sCD1vN9bfiyWWsS3JuYUO+
         saoJR6H5fkdMJGyj6K7hqyPKNlMV52qHx1jTPqeecaYh018PhqB5g3WVwSUNWZt0pZ5M
         zP9x0EmYziY7998s6B24rKTsNTxgZxNLZkGQu+zZUu2SwvCI9Zq8lCqixyT5Z8eJdH7h
         sHuQj1E2g7zzZHOJN6eXAliaB961Q68ZEAVpsYSkra4WJOz22A1JQmysySPX/Jt3Bjg1
         MHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722606042; x=1723210842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJCD9E0BGO+udSkWv5s+vPmVAmzrYKRy5J3lskBd7Ks=;
        b=Gw9LWT84cwdotqwUGPaYi9NFgOPYT7SV01V9vqVVWBiTQEZdDAM/cix36FmKn/0+xS
         txhzuWV/mkmnP19N5v2sHejbDFmM2Ax6lYb/mllMo1Fu9CLEmLh7xMPEppFAOYhSrjIa
         C2if6lCsI6efYtQA5J+2GCfiBm1kbG7SqYXUCwObb7DuGKOaTyfe8QiE0O6z5Ib84Hat
         5ZypV6gr9u4TTyP83bL5UlrLVAjUgdXkYAPjSWp58tqckjcGYF1DCIPrprcRk+QcUVl5
         omupfKglT1R9GH4c2ByGW+Yv85bUHBb6RR5OcmyLykaND8FFfE78MigR8QPvhh0YLAs7
         e4Tw==
X-Forwarded-Encrypted: i=1; AJvYcCV4lcgf0JpPY7kxGBLXG5c1JorbnQCiSUirft5D81jnv+1+CmDSiscMLCZMQCcDBfnbT5Y66MAYRYeUTgM1PymrBUOZlowD
X-Gm-Message-State: AOJu0Yz+cRtazOI3eWbJxqx798lFP/LX97uyelDDijhSZDZRpJXxCVWZ
	8LyPnbJsA8AJFnNy8w49NahMsEv7XXgVkVkSDRsUl2TapItXDI95RMWAtYhTV+Jht3b+u+XM1+O
	LPMwBh1hQ5w==
X-Google-Smtp-Source: AGHT+IEDJCUzzoiYtt79oMyQbnc5Pm8H8F1CQF+3+mnMyB7AtiHn4F8uyHVFjY4i/hc59DR5BmvVtOMXDbxf1A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:622a:180f:b0:446:4a66:bf25 with SMTP
 id d75a77b69052e-451892cae76mr256931cf.11.1722606041828; Fri, 02 Aug 2024
 06:40:41 -0700 (PDT)
Date: Fri,  2 Aug 2024 13:40:29 +0000
In-Reply-To: <20240802134029.3748005-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802134029.3748005-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802134029.3748005-6-edumazet@google.com>
Subject: [PATCH net-next 5/5] ipv6: udp: constify 'struct net' parameter of
 socket lookups
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Tom Herbert <tom@herbertland.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Following helpers do not touch their 'struct net' argument.

- udp6_lib_lookup()
- __udp6_lib_lookup()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ipv6_stubs.h | 2 +-
 include/net/udp.h        | 4 ++--
 net/ipv6/udp.c           | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
index 11cefd50704da8c6b81810fd45c54b243e9709cb..8a3465c8c2c5ce810ab2cd0b5008f63ee2aa0f37 100644
--- a/include/net/ipv6_stubs.h
+++ b/include/net/ipv6_stubs.h
@@ -82,7 +82,7 @@ extern const struct ipv6_stub *ipv6_stub __read_mostly;
 struct ipv6_bpf_stub {
 	int (*inet6_bind)(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 			  u32 flags);
-	struct sock *(*udp6_lib_lookup)(struct net *net,
+	struct sock *(*udp6_lib_lookup)(const struct net *net,
 				     const struct in6_addr *saddr, __be16 sport,
 				     const struct in6_addr *daddr, __be16 dport,
 				     int dif, int sdif, struct udp_table *tbl,
diff --git a/include/net/udp.h b/include/net/udp.h
index a0217e3cfe4f8c79d53479ce0bb8ad8fcd32e2a8..5ca53b1cec67472be861283290a1165f89a2ac5a 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -305,11 +305,11 @@ struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
 			       struct udp_table *tbl, struct sk_buff *skb);
 struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
 				 __be16 sport, __be16 dport);
-struct sock *udp6_lib_lookup(struct net *net,
+struct sock *udp6_lib_lookup(const struct net *net,
 			     const struct in6_addr *saddr, __be16 sport,
 			     const struct in6_addr *daddr, __be16 dport,
 			     int dif);
-struct sock *__udp6_lib_lookup(struct net *net,
+struct sock *__udp6_lib_lookup(const struct net *net,
 			       const struct in6_addr *saddr, __be16 sport,
 			       const struct in6_addr *daddr, __be16 dport,
 			       int dif, int sdif, struct udp_table *tbl,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 6602a2e9cdb5324b6cd22d9c915455eb316779d8..52dfbb2ff1a80eb26dfb38598764dfaf2610ee84 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -114,7 +114,7 @@ void udp_v6_rehash(struct sock *sk)
 	udp_lib_rehash(sk, new_hash);
 }
 
-static int compute_score(struct sock *sk, struct net *net,
+static int compute_score(struct sock *sk, const struct net *net,
 			 const struct in6_addr *saddr, __be16 sport,
 			 const struct in6_addr *daddr, unsigned short hnum,
 			 int dif, int sdif)
@@ -160,7 +160,7 @@ static int compute_score(struct sock *sk, struct net *net,
 }
 
 /* called with rcu_read_lock() */
-static struct sock *udp6_lib_lookup2(struct net *net,
+static struct sock *udp6_lib_lookup2(const struct net *net,
 		const struct in6_addr *saddr, __be16 sport,
 		const struct in6_addr *daddr, unsigned int hnum,
 		int dif, int sdif, struct udp_hslot *hslot2,
@@ -217,7 +217,7 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 }
 
 /* rcu_read_lock() must be held */
-struct sock *__udp6_lib_lookup(struct net *net,
+struct sock *__udp6_lib_lookup(const struct net *net,
 			       const struct in6_addr *saddr, __be16 sport,
 			       const struct in6_addr *daddr, __be16 dport,
 			       int dif, int sdif, struct udp_table *udptable,
@@ -300,7 +300,7 @@ struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
  * Does increment socket refcount.
  */
 #if IS_ENABLED(CONFIG_NF_TPROXY_IPV6) || IS_ENABLED(CONFIG_NF_SOCKET_IPV6)
-struct sock *udp6_lib_lookup(struct net *net, const struct in6_addr *saddr, __be16 sport,
+struct sock *udp6_lib_lookup(const struct net *net, const struct in6_addr *saddr, __be16 sport,
 			     const struct in6_addr *daddr, __be16 dport, int dif)
 {
 	struct sock *sk;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


