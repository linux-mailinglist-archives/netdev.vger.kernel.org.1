Return-Path: <netdev+bounces-115347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 294C8945ECF
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBD0283699
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373B61E487E;
	Fri,  2 Aug 2024 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tj5gCUii"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9A31E486A
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722606041; cv=none; b=gZaDVI3T+PzoORo/JGivnyonTYzXTXbQYsUmGE3aTVYX41WnOOFMew4fO/1LtxyOLcMO0KZqe4DvztCwa8Tv7rhbv3/B4jgc+v3KcqANqN2OHVNA/Mhhp/nLpmbjhxdu8ghj0QvU39iW+qNk5bd9ieTVUK3xtUffqeneaxy6RQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722606041; c=relaxed/simple;
	bh=6zjoTz6EDwOEkjpOLaGGkURo9+ggn0TYjO+dqFmZZQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X/yeKM0hpVSWiRbUepNhzWS3AuSaEhvLZ77FtBuEuPoRbl1tjssDVeMUtfwMORpBWrKSSCfB/4VxDWJ0MLhU6r+KRdqf1rDbItQZanGGA09YL9xT+sANfe86kjiX908wsa/4RtCunTePs68dHhKSsA1eSwfjmDEalNH3KaUbyXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tj5gCUii; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64b70c4a269so152871417b3.1
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722606038; x=1723210838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b1y2ZM9IdEGayT9P3CUQeRyXf3F1RxpY5mc/K/Y+2Fs=;
        b=tj5gCUiipK3rG9quqlp02adUnPuXScnc3/K3o52xizGyGDti8fhTruxr9EbC5Jzd13
         8gQ2MQOnImn91K2jit5I3zaQrMe7rwFKdg6OKlo/xRu+PKkhijwN7pV3RBxrHKa4cMqV
         aj7cTd5wa6aqstnu7ESXt7MH+U5QXz+hCCusU7NV973KkTAtdDxYo/EJUNFPPZa5NNus
         sCOE7vD9aHxwziUPRshThZFnOmghdjkbdK2DlD550CopEtTICEWp1NLHcc2caTM6SM3Y
         VV7S/dJ1qiJSBgFCACciP1gSONIcOutSHZyWcR8R1C3okjnpa8BQGcCmfbCb/R95zjpJ
         Rbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722606038; x=1723210838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1y2ZM9IdEGayT9P3CUQeRyXf3F1RxpY5mc/K/Y+2Fs=;
        b=UDC4VQobVCLyme6MD5LDhzfwfsL0DHpX+6hjKtcUsjYdCckmnmfxX3mTwSW+xz6bP5
         M9kLe6azx93a6pCUQZRyd1xv/WLLd9fl00UTVYSwYpVW/kxKt+bBnT3tg7o79UhJMrU2
         /fuVsXElLMm/yxIl1faL8CBB7/SK6La5sTOa5Dm0h+0X8wqxvO11Ibqi+NapYEESwqkg
         Ym7qIYu1nx6HkdZ7OCAgLnAPNS8Rt6ochY8d/UwDBA9daWN6Ogo8LjCVh0JDOa5KdrK1
         dKKeuqzbalG9kbmF1A4YfzdQSlnJ/t6qFGY1SvLWoxZ4WLJnxWcxaa3rIW9SDjVwiCaI
         uQpg==
X-Forwarded-Encrypted: i=1; AJvYcCXkbxEF4NqcBPR+JyULrxQ+xmp4eIMmtXeVs/CzXrEj46qApvEYAgP+WwT4e+8AsVyeZOMzC3+NHwVpnbVmUUFVhSCZ1kO+
X-Gm-Message-State: AOJu0YxHReIzM/I0LmEEXuqwMXQB5cR3A1XDkVyaksQToyW655WAAbLI
	FZrGQpvyZxeLDPbkepPWTy2TPGtfuRcOmeMqRrjxIseTkzFEwVkr6uqhNMNk2r+UhPAUba6wrft
	kqwu1+iXJaQ==
X-Google-Smtp-Source: AGHT+IE5em3Njm4+CpBPKTb/r5ILn9cSRFIzZZUWh5tLBpzSik2DSPeYShgeWGcBmxS26isB237cQZOqWtokcg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:c0a:b0:e0b:5200:d93f with SMTP
 id 3f1490d57ef6-e0bde1fc85bmr5052276.3.1722606038519; Fri, 02 Aug 2024
 06:40:38 -0700 (PDT)
Date: Fri,  2 Aug 2024 13:40:27 +0000
In-Reply-To: <20240802134029.3748005-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802134029.3748005-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802134029.3748005-4-edumazet@google.com>
Subject: [PATCH net-next 3/5] udp: constify 'struct net' parameter of socket lookups
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Tom Herbert <tom@herbertland.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Following helpers do not touch their 'struct net' argument.

- udp_sk_bound_dev_eq()
- udp4_lib_lookup()
- __udp4_lib_lookup()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/udp.h | 10 ++++++----
 net/ipv4/udp.c    |  8 ++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index c4e05b14b648a4a98b67a8da5ed1e29f2413f35c..a0217e3cfe4f8c79d53479ce0bb8ad8fcd32e2a8 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -79,7 +79,8 @@ struct udp_table {
 extern struct udp_table udp_table;
 void udp_table_init(struct udp_table *, const char *);
 static inline struct udp_hslot *udp_hashslot(struct udp_table *table,
-					     struct net *net, unsigned int num)
+					     const struct net *net,
+					     unsigned int num)
 {
 	return &table->hash[udp_hashfn(net, num, table->mask)];
 }
@@ -245,7 +246,7 @@ static inline int udp_rqueue_get(struct sock *sk)
 	return sk_rmem_alloc_get(sk) - READ_ONCE(udp_sk(sk)->forward_deficit);
 }
 
-static inline bool udp_sk_bound_dev_eq(struct net *net, int bound_dev_if,
+static inline bool udp_sk_bound_dev_eq(const struct net *net, int bound_dev_if,
 				       int dif, int sdif)
 {
 #if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
@@ -296,9 +297,10 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		       sockptr_t optval, unsigned int optlen,
 		       int (*push_pending_frames)(struct sock *));
-struct sock *udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport,
+struct sock *udp4_lib_lookup(const struct net *net, __be32 saddr, __be16 sport,
 			     __be32 daddr, __be16 dport, int dif);
-struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport,
+struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
+			       __be16 sport,
 			       __be32 daddr, __be16 dport, int dif, int sdif,
 			       struct udp_table *tbl, struct sk_buff *skb);
 struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 49c622e743e87fca17da555ef0a65bdb4aeed336..ddb86baaea6c87a9645f3baa6e4ab695cd539de4 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -365,7 +365,7 @@ int udp_v4_get_port(struct sock *sk, unsigned short snum)
 	return udp_lib_get_port(sk, snum, hash2_nulladdr);
 }
 
-static int compute_score(struct sock *sk, struct net *net,
+static int compute_score(struct sock *sk, const struct net *net,
 			 __be32 saddr, __be16 sport,
 			 __be32 daddr, unsigned short hnum,
 			 int dif, int sdif)
@@ -420,7 +420,7 @@ u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 lport,
 }
 
 /* called with rcu_read_lock() */
-static struct sock *udp4_lib_lookup2(struct net *net,
+static struct sock *udp4_lib_lookup2(const struct net *net,
 				     __be32 saddr, __be16 sport,
 				     __be32 daddr, unsigned int hnum,
 				     int dif, int sdif,
@@ -480,7 +480,7 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 /* UDP is nearly always wildcards out the wazoo, it makes no sense to try
  * harder than this. -DaveM
  */
-struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr,
+struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
 		__be16 sport, __be32 daddr, __be16 dport, int dif,
 		int sdif, struct udp_table *udptable, struct sk_buff *skb)
 {
@@ -561,7 +561,7 @@ struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
  * Does increment socket refcount.
  */
 #if IS_ENABLED(CONFIG_NF_TPROXY_IPV4) || IS_ENABLED(CONFIG_NF_SOCKET_IPV4)
-struct sock *udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport,
+struct sock *udp4_lib_lookup(const struct net *net, __be32 saddr, __be16 sport,
 			     __be32 daddr, __be16 dport, int dif)
 {
 	struct sock *sk;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


