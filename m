Return-Path: <netdev+bounces-216916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8DBB35FA9
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77D97C4BDB
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 12:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9F31B424F;
	Tue, 26 Aug 2025 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WkqJOfcS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4471D5147
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212641; cv=none; b=RBXD8AbIxNrDuFAgELJetErXx1bOZOkPZCIreWNFM/CMW/SbRQkBaC5OOol5v0H8AexnHPN3Dxp4mx1XtL4hv8s8Tj67/jdSVHeGiIbabQ+xJoMvhUOHuYUnMlwEW4uZx3wJywF/rR7ls1zSaGPxlC7hCbLTns7+H0DJbIeMJk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212641; c=relaxed/simple;
	bh=C/+u3325u4tRujDXUdBYu7o/f7blOncJc0leKc5bHnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pB05lN37DMfCiEceFrt2Ah/TBnLW0xNCVNymGdnk2AgS+ab1GDn+l+N+a7U/ClWVchchwbwgFkXoCIfB0iMT7/ugWa85Ea2SGvugfQS7p5WhtRRQXXy1qXc/P/3XO06yUEHH2CkjrPIycA6orQ0VWhCG2PT3wrsSwCNsxhRt3Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WkqJOfcS; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-50f8bf67fbbso9032420137.3
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 05:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756212638; x=1756817438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W6WCfi7gaYnyN+wBiEsvJb0Qyo4DkGX6mHwmL0tyAdM=;
        b=WkqJOfcS1+byBiDjaR87K34tsCJ5AYBUgeO+/DfGxVqo0yXeFuNomebZN9/TQEro1p
         XFAlPsfnzUNKhDGMiGrQuItmVkao8Olk6BR57jyShTbyytU9HmLaP9oE4RwU1LUsLIdh
         X/7KZn+lJYsmMCoorgSNf7VO8HrdWBMffWxb4i7gBFGn1/AxXkqvjZ7psmzcFAVxTkoq
         6whD3lUTFVAKpxvF5TTRikdMsiFlr8gp5mNU89fOqqpVXZYh+g3uMfUbRFtXDEfhv/lp
         779YXBWHRPEdMfQuIxqrHmZ+vCx2/1vuOjos3JV+zJBsKG94UnFfKb+sndzQIYumTz4v
         gQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756212638; x=1756817438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6WCfi7gaYnyN+wBiEsvJb0Qyo4DkGX6mHwmL0tyAdM=;
        b=fB2JVSg/ld/O14k9vhutDXHM4Q/Coz0mdFK4Kh3YFqYe/hkKfgG/Njce3EKGxz6jyK
         LmlxhkBAV0NzEkL+ldT+YQIeCa7P95QGxNLVmeGmUHKGpb1qCyshhnI46fmx73sl66Lk
         SUFlu8SHmbU2Cqws2xREB3+biRF+ZahFfXbRUZiVv/neJ3Sbt1vvaBK0qEIvCZZMwCAv
         iUi0/LNVBbtbFv6tCMlkECn8Zan8BRiN7CKXaz8BKgeBakdor0NkHm3xalHEcajiEoGw
         wPPzU9zAzSErz8I+PR5WzZwk5y1DjrUKydBGZfnDfizycc4nD5P4eJ/ePteBD5z7sWQG
         i6Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXsbpOWlmQPiRAS23C0V5sLk8YSEpSIfeFTEKaaE7DQlyqxk53BkrUrFVn37iL8JA4Oa1HXQy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiBY75mPbrfdTcf7LbTBfx/wIYKonVmKXNkau4jih1HLL+UwSN
	DhgAKhg3jqf1NY6drWGaN0yvdX8ipQj+zXSw2eBcZQBr7hHPql3n3FuJ16FQM9KDRhVTIzA1TGM
	AyXwLDWMG8EMD6g==
X-Google-Smtp-Source: AGHT+IFuhSyjemYXfxuf8xgmOhJYpQqpZPEtRmJgniGmW0ym50CA4zSndGS8U+HG4jw4Mx3MweUy0jJLe7f5xA==
X-Received: from vsbbq6.prod.google.com ([2002:a05:6102:5346:b0:523:1f32:e6d4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:5687:b0:4c3:6393:83f4 with SMTP id ada2fe7eead31-51d0cbece39mr4866976137.2.1756212638523;
 Tue, 26 Aug 2025 05:50:38 -0700 (PDT)
Date: Tue, 26 Aug 2025 12:50:28 +0000
In-Reply-To: <20250826125031.1578842-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826125031.1578842-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826125031.1578842-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/5] net: add sk_drops_skbadd() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Existing sk_drops_add() helper is renamed to sk_drops_skbadd().

Add sk_drops_add() and convert sk_drops_inc() to use it.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skmsg.h |  2 +-
 include/net/sock.h    | 11 ++++++++---
 include/net/udp.h     |  2 +-
 net/ipv4/tcp_input.c  |  2 +-
 net/ipv4/tcp_ipv4.c   |  4 ++--
 net/ipv6/tcp_ipv6.c   |  4 ++--
 net/mptcp/protocol.c  |  2 +-
 7 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 0b9095a281b8988dfd06c69254d2bcbedcfaf6b4..49847888c287ab980531c4b78f5ab4aac5018240 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -315,7 +315,7 @@ static inline bool sk_psock_test_state(const struct sk_psock *psock,
 
 static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
 {
-	sk_drops_add(sk, skb);
+	sk_drops_skbadd(sk, skb);
 	kfree_skb(skb);
 }
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 34d7029eb622773e40e7c4ebd422d33b1c0a7836..9edb42ff06224cb8a1dd4f84af25bc22d1803ca9 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2682,9 +2682,14 @@ struct sock_skb_cb {
 #define sock_skb_cb_check_size(size) \
 	BUILD_BUG_ON((size) > SOCK_SKB_CB_OFFSET)
 
+static inline void sk_drops_add(struct sock *sk, int segs)
+{
+	atomic_add(segs, &sk->sk_drops);
+}
+
 static inline void sk_drops_inc(struct sock *sk)
 {
-	atomic_inc(&sk->sk_drops);
+	sk_drops_add(sk, 1);
 }
 
 static inline int sk_drops_read(const struct sock *sk)
@@ -2704,11 +2709,11 @@ sock_skb_set_dropcount(const struct sock *sk, struct sk_buff *skb)
 						sk_drops_read(sk) : 0;
 }
 
-static inline void sk_drops_add(struct sock *sk, const struct sk_buff *skb)
+static inline void sk_drops_skbadd(struct sock *sk, const struct sk_buff *skb)
 {
 	int segs = max_t(u16, 1, skb_shinfo(skb)->gso_segs);
 
-	atomic_add(segs, &sk->sk_drops);
+	sk_drops_add(sk, segs);
 }
 
 static inline ktime_t sock_read_timestamp(struct sock *sk)
diff --git a/include/net/udp.h b/include/net/udp.h
index e2af3bda90c9327105bb329927fd3521e51926d8..7b26d4c50f33b94507933c407531c14b8edd306a 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -627,7 +627,7 @@ static inline struct sk_buff *udp_rcv_segment(struct sock *sk,
 	return segs;
 
 drop:
-	atomic_add(drop_count, &sk->sk_drops);
+	sk_drops_add(sk, drop_count);
 	SNMP_ADD_STATS(__UDPX_MIB(sk, ipv4), UDP_MIB_INERRORS, drop_count);
 	kfree_skb(skb);
 	return NULL;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a52a747d8a55e6a405d2fb1608e979abceb51c07..f1be65af1a777a803ae402c933e539cdabff7202 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4830,7 +4830,7 @@ static bool tcp_ooo_try_coalesce(struct sock *sk,
 noinline_for_tracing static void
 tcp_drop_reason(struct sock *sk, struct sk_buff *skb, enum skb_drop_reason reason)
 {
-	sk_drops_add(sk, skb);
+	sk_drops_skbadd(sk, skb);
 	sk_skb_reason_drop(sk, skb, reason);
 }
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a0c93b24c6e0ca2eb477686e477d164b0b132e7a..7c1d612afca18b424b32ee5e97b99a68062d8436 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2254,7 +2254,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 						       &iph->saddr, &iph->daddr,
 						       AF_INET, dif, sdif);
 		if (unlikely(drop_reason)) {
-			sk_drops_add(sk, skb);
+			sk_drops_skbadd(sk, skb);
 			reqsk_put(req);
 			goto discard_it;
 		}
@@ -2399,7 +2399,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	return 0;
 
 discard_and_relse:
-	sk_drops_add(sk, skb);
+	sk_drops_skbadd(sk, skb);
 	if (refcounted)
 		sock_put(sk);
 	goto discard_it;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 8b2e7b7afbd847b5d94b30ab27779e4dc705710d..b4e56b8772730579cb85f10b147a15acce03f8e4 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1809,7 +1809,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 						       &hdr->saddr, &hdr->daddr,
 						       AF_INET6, dif, sdif);
 		if (drop_reason) {
-			sk_drops_add(sk, skb);
+			sk_drops_skbadd(sk, skb);
 			reqsk_put(req);
 			goto discard_it;
 		}
@@ -1948,7 +1948,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	return 0;
 
 discard_and_relse:
-	sk_drops_add(sk, skb);
+	sk_drops_skbadd(sk, skb);
 	if (refcounted)
 		sock_put(sk);
 	goto discard_it;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f2e728239480444ffdb297efc35303848d4c4a31..ad41c48126e44fda646f1ec1c81957db1407a6cc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -137,7 +137,7 @@ struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk)
 
 static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
 {
-	sk_drops_add(sk, skb);
+	sk_drops_skbadd(sk, skb);
 	__kfree_skb(skb);
 }
 
-- 
2.51.0.261.g7ce5a0a67e-goog


