Return-Path: <netdev+bounces-115348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD91945ED0
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208711C21286
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03501E486A;
	Fri,  2 Aug 2024 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/js/eHH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADC01E487A
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722606042; cv=none; b=sI6SbWUkevBSOea1918gbwus1/mlmfoX7x6cuBvECmzBrCZKd/QBdN7TSu3IrT5HYVPmjN/SLQyaf0tKhR8IioPn8MDuGpSxGXUnpMoztgMCvT9ToLsVrBof/xbUYfK5PH1BxJ8f0ZOIOgK3TnMCS7xp3GVjDYrnILFxw/dMUkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722606042; c=relaxed/simple;
	bh=oakbWTV5o+pLzquEgcZMq85UtM4ha5ADS2ZoCMLBW/Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ob3uAhgB5xFZ0RSVP7EKvtJVGNzVUqLR5FbWi+Itr2x69zabXX7FsX5rK8ci4tgbMyoLjC2u7n51WAZF56CLeaq9C7XISVkjSFmb2lf9zlKVugf2wsAEFcRe1OmacFjEhGv4+loAwvcPfDdlzNdtl21xu8GHSTq7fF56DnToMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/js/eHH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-65194ea3d4dso157928657b3.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 06:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722606040; x=1723210840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cfFRtvw9VqkxG0Z6iAul2+1bjV3z4oaLcZtN7mt/vC8=;
        b=C/js/eHHvnkRaZak1pwTu7to/Y7njRyt5goNj0YBLMkoujM2Awfpd1IX7Wj7IulMg0
         FvDL8SzWYpIWbFFukehbe7PIgaX/wMmTvPtQMQIMARsiaRoZGahrs1CGWCi/5hAlU9Qg
         JSPxfHUEknfxZGC7sM8zB7SkqIGxwRrH3SFAtO2876iqYnp8GX4xcuwKz6vSvXCXDA8U
         YtSg7u7q0TT+13yBHCNEXyCTi7w+PVLd2JNkVlbuvIAsqw3Tt0jnyOfzK8Gl5FgbW46q
         3N6otkRGZW5smB5BMv/TmpE0azzNEejR+HCym9LEsAk2AHRRhsjsYPwCcOSJN9O/K1eS
         veMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722606040; x=1723210840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfFRtvw9VqkxG0Z6iAul2+1bjV3z4oaLcZtN7mt/vC8=;
        b=gPky4PEzKwTkOZxwdZYSoJSgS2QAcPxCTdiCrf131f7M+YoLFdKRcIN/j2qnVyU97Z
         kwvecb4qEIGQu5LBiyqlPzooYpPhzPnwZ+xjhpzvDrQtiNJCmpvSvtbgnjZxwpEXKNZh
         U9ofURW7mV+hXx65fkvcrwzEMgkbgj+PbIcyz1Vz2H3YsLee1IPKaZww1rmmDyJj++mK
         QUK5+oQ90WW1ZFxY8BK79tT1BJdewbsCOY7qfTM2eAjKqaOWaBbaBNRURDbnk5FWcj04
         aXAYIRl3h5u2klvXzHaAisNTkO/tZLG95IZLAf14DjOr0pUQQ2E87CF8mWLB2wzKY+al
         dW6w==
X-Forwarded-Encrypted: i=1; AJvYcCXyPF30kOhtbI2TaeH5GuVj7fiHYRwJWFRYWSgqeOOz7UKOevenRbRjnVLedgnGW6sJmoWgm9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp/KfKpZ1FO6pYaDooAD0Xb7NJ0P1lTImltadLLYyKmfW062F/
	+EmsPmWpTccj8kfzrfXqHyj7ESNHfjHtblkoEOsE6s4m3NxXN/DtlSFRCuo/b8oq7WdPFhFfaar
	5r8zVfpLUnA==
X-Google-Smtp-Source: AGHT+IGbQAUsnOt8u/I/nNq2XzRJ5JUH0jCPHtdUNHodgmmeuVpXbORGWxAFHgyh7HuCrNPceBY5JjFCTa6Pfw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:112:b0:62c:fb55:aeab with SMTP
 id 00721157ae682-6896458f799mr2619147b3.8.1722606040020; Fri, 02 Aug 2024
 06:40:40 -0700 (PDT)
Date: Fri,  2 Aug 2024 13:40:28 +0000
In-Reply-To: <20240802134029.3748005-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802134029.3748005-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802134029.3748005-5-edumazet@google.com>
Subject: [PATCH net-next 4/5] inet6: constify 'struct net' parameter of
 various lookup helpers
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Tom Herbert <tom@herbertland.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Following helpers do not touch their struct net argument:

- bpf_sk_lookup_run_v6()
- __inet6_lookup_established()
- inet6_lookup_reuseport()
- inet6_lookup_listener()
- inet6_lookup_run_sk_lookup()
- __inet6_lookup()
- inet6_lookup()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/filter.h         |  2 +-
 include/net/inet6_hashtables.h | 12 ++++++------
 net/ipv6/inet6_hashtables.c    | 13 +++++++------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 4acd1da4dac623a0af53c3df888d42326189efcf..64e1506fefb82e4adc1def9d007fdf88a88651c3 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1653,7 +1653,7 @@ static inline bool bpf_sk_lookup_run_v4(const struct net *net, int protocol,
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-static inline bool bpf_sk_lookup_run_v6(struct net *net, int protocol,
+static inline bool bpf_sk_lookup_run_v6(const struct net *net, int protocol,
 					const struct in6_addr *saddr,
 					const __be16 sport,
 					const struct in6_addr *daddr,
diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 591cbf5e4d5f86375598b9622f616ac662b0fc4e..74dd90ff5f129fe4c8adad67a642ae5070410518 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -40,7 +40,7 @@ static inline unsigned int __inet6_ehashfn(const u32 lhash,
  *
  * The sockhash lock must be held as a reader here.
  */
-struct sock *__inet6_lookup_established(struct net *net,
+struct sock *__inet6_lookup_established(const struct net *net,
 					struct inet_hashinfo *hashinfo,
 					const struct in6_addr *saddr,
 					const __be16 sport,
@@ -56,7 +56,7 @@ inet6_ehashfn_t inet6_ehashfn;
 
 INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);
 
-struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
+struct sock *inet6_lookup_reuseport(const struct net *net, struct sock *sk,
 				    struct sk_buff *skb, int doff,
 				    const struct in6_addr *saddr,
 				    __be16 sport,
@@ -64,7 +64,7 @@ struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
 				    unsigned short hnum,
 				    inet6_ehashfn_t *ehashfn);
 
-struct sock *inet6_lookup_listener(struct net *net,
+struct sock *inet6_lookup_listener(const struct net *net,
 				   struct inet_hashinfo *hashinfo,
 				   struct sk_buff *skb, int doff,
 				   const struct in6_addr *saddr,
@@ -73,7 +73,7 @@ struct sock *inet6_lookup_listener(struct net *net,
 				   const unsigned short hnum,
 				   const int dif, const int sdif);
 
-struct sock *inet6_lookup_run_sk_lookup(struct net *net,
+struct sock *inet6_lookup_run_sk_lookup(const struct net *net,
 					int protocol,
 					struct sk_buff *skb, int doff,
 					const struct in6_addr *saddr,
@@ -82,7 +82,7 @@ struct sock *inet6_lookup_run_sk_lookup(struct net *net,
 					const u16 hnum, const int dif,
 					inet6_ehashfn_t *ehashfn);
 
-static inline struct sock *__inet6_lookup(struct net *net,
+static inline struct sock *__inet6_lookup(const struct net *net,
 					  struct inet_hashinfo *hashinfo,
 					  struct sk_buff *skb, int doff,
 					  const struct in6_addr *saddr,
@@ -167,7 +167,7 @@ static inline struct sock *__inet6_lookup_skb(struct inet_hashinfo *hashinfo,
 			      iif, sdif, refcounted);
 }
 
-struct sock *inet6_lookup(struct net *net, struct inet_hashinfo *hashinfo,
+struct sock *inet6_lookup(const struct net *net, struct inet_hashinfo *hashinfo,
 			  struct sk_buff *skb, int doff,
 			  const struct in6_addr *saddr, const __be16 sport,
 			  const struct in6_addr *daddr, const __be16 dport,
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index f29f094e57a4a5da8b238246d437328569a165d3..9ec05e354baa69d14e88da37f5a9fce11e874e35 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -46,7 +46,7 @@ EXPORT_SYMBOL_GPL(inet6_ehashfn);
  *
  * The sockhash lock must be held as a reader here.
  */
-struct sock *__inet6_lookup_established(struct net *net,
+struct sock *__inet6_lookup_established(const struct net *net,
 					struct inet_hashinfo *hashinfo,
 					   const struct in6_addr *saddr,
 					   const __be16 sport,
@@ -126,7 +126,7 @@ static inline int compute_score(struct sock *sk, const struct net *net,
  * Return: NULL if sk doesn't have SO_REUSEPORT set, otherwise a pointer to
  *         the selected sock or an error.
  */
-struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
+struct sock *inet6_lookup_reuseport(const struct net *net, struct sock *sk,
 				    struct sk_buff *skb, int doff,
 				    const struct in6_addr *saddr,
 				    __be16 sport,
@@ -147,7 +147,7 @@ struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
 EXPORT_SYMBOL_GPL(inet6_lookup_reuseport);
 
 /* called with rcu_read_lock() */
-static struct sock *inet6_lhash2_lookup(struct net *net,
+static struct sock *inet6_lhash2_lookup(const struct net *net,
 		struct inet_listen_hashbucket *ilb2,
 		struct sk_buff *skb, int doff,
 		const struct in6_addr *saddr,
@@ -174,7 +174,7 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
 	return result;
 }
 
-struct sock *inet6_lookup_run_sk_lookup(struct net *net,
+struct sock *inet6_lookup_run_sk_lookup(const struct net *net,
 					int protocol,
 					struct sk_buff *skb, int doff,
 					const struct in6_addr *saddr,
@@ -199,7 +199,7 @@ struct sock *inet6_lookup_run_sk_lookup(struct net *net,
 }
 EXPORT_SYMBOL_GPL(inet6_lookup_run_sk_lookup);
 
-struct sock *inet6_lookup_listener(struct net *net,
+struct sock *inet6_lookup_listener(const struct net *net,
 		struct inet_hashinfo *hashinfo,
 		struct sk_buff *skb, int doff,
 		const struct in6_addr *saddr,
@@ -243,7 +243,8 @@ struct sock *inet6_lookup_listener(struct net *net,
 }
 EXPORT_SYMBOL_GPL(inet6_lookup_listener);
 
-struct sock *inet6_lookup(struct net *net, struct inet_hashinfo *hashinfo,
+struct sock *inet6_lookup(const struct net *net,
+			  struct inet_hashinfo *hashinfo,
 			  struct sk_buff *skb, int doff,
 			  const struct in6_addr *saddr, const __be16 sport,
 			  const struct in6_addr *daddr, const __be16 dport,
-- 
2.46.0.rc2.264.g509ed76dc8-goog


