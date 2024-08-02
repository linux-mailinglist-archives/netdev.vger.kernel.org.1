Return-Path: <netdev+bounces-115346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F53945ECE
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D041F222E2
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162C21E486D;
	Fri,  2 Aug 2024 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJ5cUs/L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFD01E485B
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722606040; cv=none; b=BeOogsYGibwIZTJWPvfgnqZN0t90y4hW1l9Qe3Ry1hFW+m2TfKmSujAuYoHmu8k1C1bF5DbyljeUqEpz++yMYNbJ8A1mntEV3r6wFPDf9GPOS7kAtKWHOuKWv/zNOIakJwUxZenGRdrlo/YUkV0xAT/QdDef6ae04QLyjOAULoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722606040; c=relaxed/simple;
	bh=tyyH640+l+MA9Jf+TfbxkFuk52tJt0TSRt9Ih56Xm5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mBHd220lJJfmEX8PpE6hP6C0tcOBHa0njqYVOgevk9/M86V5jzNoFYs48IqI0C5KcpKkKhtDfcGOloAPNOZ0X/gE4FQ5sTPSw8Elz9T4S6XcyCkbMOGiWUEEh7V5R1vW7ID7k97QTvDQ1ihuAx2tPX1Vr6RrsRWNyymilScjlGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJ5cUs/L; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7a1d737f940so532616385a.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722606037; x=1723210837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M7qOqghSjWdpJk3mrrs1cNVxDem0EoTuaZfvapvG15c=;
        b=IJ5cUs/LwMWmWnl+Hrw9mHcyFrXvpOBoNiolplj9gr7vdXBJM7RGRvmJWsZuD4qAZa
         dpheIgDhl7VmwV9ya6w9z37MDVE3RXYhMLfsVsZHfIdjKzIE1Ts1ii53yx0PoSdQobgN
         TCIvnk0Ggqxj3iRqw6DM4eTzVTsVhnUzDVhJ36KawYopZRPwOdtDErGfFLt8gdZJ8zQy
         br5EdWChJZ6OQ9PkDUH1ATbARST7ZNjs68N1vKn+AGhYI/9w0uSNvD8Ons7eyiMsTEUx
         LPZmdyLcmeUnK0+N8bzmCtxpztXXunn/HTC60lph5SRe6eYePlCu0UnYma3jHRXGnkpf
         TpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722606037; x=1723210837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7qOqghSjWdpJk3mrrs1cNVxDem0EoTuaZfvapvG15c=;
        b=NtCO0UiIKbVUokK8XkyK2AJ+tO7Xj7DUiDlpu2TWn9hTHs0u58dR7nJyJB5q/gG/4c
         ArQp8VnYjNvmqNHj0bd/wsb/893JZRxwDOWafHmDhTeiTD3h5XUtez7LRk+nkhYNa39e
         pWPwYyjrvFAUlf/bWWDvVmovAJb8+k+Fw4JvqT2NxTVZopYTGqN3Kc3QadUvPtSr6oX9
         NUzv8UuHnQaQ/BnrIOdTBrXkp9WgaOn0CX7Y5UIykNarI08xdInhZWIsgqjrXW+JQSvt
         dxKMazUsyK/ZOdTOvAzs7tptH+0Gz1V0XRIJmxvBge/3+CzeW5gLAbTLjzztet5MyhwL
         b9UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcGuusJcvf6FeXMrE3G6qgbD4AKEcXfu/vFaj8BBn5ZrKYYAYJriiCN5QmxeG5c2E8CHTfAyaTsd+GRb89Qk2O/hYlC9Ia
X-Gm-Message-State: AOJu0YzmNHZP7P1FP0rGxJVTPcEd4w/Hw/L0cfrTT/s8sI8O/fYW1hSc
	K/88/g4tGgaeVscclR5obJZM1pUaF/lL/G0dpXK7ERFGyNxPsnQ9JpKL0kDPTaNaP6R/OtgX8Vf
	MMDHiLPFLoA==
X-Google-Smtp-Source: AGHT+IHwAirQoQmr05ThDsTs20/kDBKdUBxepURgxCYbnzaDf8IXPUuoc91xeq4j1N+s25ta90x5UHZ5OuwiSg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6214:20aa:b0:6b5:db40:8dd1 with SMTP
 id 6a1803df08f44-6bb98509fa7mr1359286d6.0.1722606037229; Fri, 02 Aug 2024
 06:40:37 -0700 (PDT)
Date: Fri,  2 Aug 2024 13:40:26 +0000
In-Reply-To: <20240802134029.3748005-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802134029.3748005-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802134029.3748005-3-edumazet@google.com>
Subject: [PATCH net-next 2/5] inet: constify 'struct net' parameter of various
 lookup helpers
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Tom Herbert <tom@herbertland.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Following helpers do not touch their struct net argument:

- bpf_sk_lookup_run_v4()
- inet_lookup_reuseport()
- inet_lhash2_lookup()
- inet_lookup_run_sk_lookup()
- __inet_lookup_listener()
- __inet_lookup_established()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/filter.h        |  2 +-
 include/net/inet_hashtables.h |  8 ++++----
 net/ipv4/inet_hashtables.c    | 10 +++++-----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index b6672ff61407fc8dd56e4555e30f1a3c9dc238dc..4acd1da4dac623a0af53c3df888d42326189efcf 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1616,7 +1616,7 @@ extern struct static_key_false bpf_sk_lookup_enabled;
 		_all_pass || _selected_sk ? SK_PASS : SK_DROP;		\
 	 })
 
-static inline bool bpf_sk_lookup_run_v4(struct net *net, int protocol,
+static inline bool bpf_sk_lookup_run_v4(const struct net *net, int protocol,
 					const __be32 saddr, const __be16 sport,
 					const __be32 daddr, const u16 dport,
 					const int ifindex, struct sock **psk)
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 1cc8b7ca20a10c1b0c8a6b9a029e5f8b4a1e846d..5eea47f135a421ce8275d4cd83c5771b3f448e5c 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -304,7 +304,7 @@ int __inet_hash(struct sock *sk, struct sock *osk);
 int inet_hash(struct sock *sk);
 void inet_unhash(struct sock *sk);
 
-struct sock *__inet_lookup_listener(struct net *net,
+struct sock *__inet_lookup_listener(const struct net *net,
 				    struct inet_hashinfo *hashinfo,
 				    struct sk_buff *skb, int doff,
 				    const __be32 saddr, const __be16 sport,
@@ -368,7 +368,7 @@ static inline bool inet_match(const struct net *net, const struct sock *sk,
 /* Sockets in TCP_CLOSE state are _always_ taken out of the hash, so we need
  * not check it for lookups anymore, thanks Alexey. -DaveM
  */
-struct sock *__inet_lookup_established(struct net *net,
+struct sock *__inet_lookup_established(const struct net *net,
 				       struct inet_hashinfo *hashinfo,
 				       const __be32 saddr, const __be16 sport,
 				       const __be32 daddr, const u16 hnum,
@@ -382,13 +382,13 @@ inet_ehashfn_t inet_ehashfn;
 
 INDIRECT_CALLABLE_DECLARE(inet_ehashfn_t udp_ehashfn);
 
-struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
+struct sock *inet_lookup_reuseport(const struct net *net, struct sock *sk,
 				   struct sk_buff *skb, int doff,
 				   __be32 saddr, __be16 sport,
 				   __be32 daddr, unsigned short hnum,
 				   inet_ehashfn_t *ehashfn);
 
-struct sock *inet_lookup_run_sk_lookup(struct net *net,
+struct sock *inet_lookup_run_sk_lookup(const struct net *net,
 				       int protocol,
 				       struct sk_buff *skb, int doff,
 				       __be32 saddr, __be16 sport,
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 3d913dbd028404b1a1bf4dc3f988133e4a1d52ec..9bfcfd016e18275fb50fea8d77adc8a64fb12494 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -348,7 +348,7 @@ static inline int compute_score(struct sock *sk, const struct net *net,
  * Return: NULL if sk doesn't have SO_REUSEPORT set, otherwise a pointer to
  *         the selected sock or an error.
  */
-struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
+struct sock *inet_lookup_reuseport(const struct net *net, struct sock *sk,
 				   struct sk_buff *skb, int doff,
 				   __be32 saddr, __be16 sport,
 				   __be32 daddr, unsigned short hnum,
@@ -374,7 +374,7 @@ EXPORT_SYMBOL_GPL(inet_lookup_reuseport);
  */
 
 /* called with rcu_read_lock() : No refcount taken on the socket */
-static struct sock *inet_lhash2_lookup(struct net *net,
+static struct sock *inet_lhash2_lookup(const struct net *net,
 				struct inet_listen_hashbucket *ilb2,
 				struct sk_buff *skb, int doff,
 				const __be32 saddr, __be16 sport,
@@ -401,7 +401,7 @@ static struct sock *inet_lhash2_lookup(struct net *net,
 	return result;
 }
 
-struct sock *inet_lookup_run_sk_lookup(struct net *net,
+struct sock *inet_lookup_run_sk_lookup(const struct net *net,
 				       int protocol,
 				       struct sk_buff *skb, int doff,
 				       __be32 saddr, __be16 sport,
@@ -423,7 +423,7 @@ struct sock *inet_lookup_run_sk_lookup(struct net *net,
 	return sk;
 }
 
-struct sock *__inet_lookup_listener(struct net *net,
+struct sock *__inet_lookup_listener(const struct net *net,
 				    struct inet_hashinfo *hashinfo,
 				    struct sk_buff *skb, int doff,
 				    const __be32 saddr, __be16 sport,
@@ -488,7 +488,7 @@ void sock_edemux(struct sk_buff *skb)
 }
 EXPORT_SYMBOL(sock_edemux);
 
-struct sock *__inet_lookup_established(struct net *net,
+struct sock *__inet_lookup_established(const struct net *net,
 				  struct inet_hashinfo *hashinfo,
 				  const __be32 saddr, const __be16 sport,
 				  const __be32 daddr, const u16 hnum,
-- 
2.46.0.rc2.264.g509ed76dc8-goog


