Return-Path: <netdev+bounces-261073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNaOIChdn2lRagQAu9opvQ
	(envelope-from <netdev+bounces-261073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 21:35:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D44FD19D4DB
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 21:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A6A03013D67
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 20:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654AD30CDAE;
	Wed, 25 Feb 2026 20:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gP8x4zQ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED58A2D780C
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051749; cv=none; b=gbrFSmbb1mGjGMIraTe+OOya2f3StqsewX6nTd6zkXt5IE8d5iFZWxCsAWFfKaLObsnCfAKJ0jtEfAPYawQQrPnCWBsuwibFku8qJugfcWblVlPU8QwFgVmEoyie+UeSY6noQN1a84cGNLvtA9mOHPqaqDzJ+zJi9/2nmqMVx74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051749; c=relaxed/simple;
	bh=mZ2Rnrh9DO3kBbGGvuWY0PDeh2g3Z5Kkamp6fYg++UM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cFFTYY0nOEXfLRaM8O/ZopqSPOwgCHVDFt6650Y9wsDwVkiXiSccADPnYRctIMjF7+CEkztP4X8dm82yVLYK7QbTR6AXvEOAKZSrIJ178cA2o6DZpH8tXSIbXoNAVtL5VMnINlzHjI0OYFklCYoEPugrABl6gcDWSL9C77w0XEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gP8x4zQ9; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-506b3fb32a1so682236111cf.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 12:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772051747; x=1772656547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sdsT1o9zXTNYRDs0/R0qL/yZ4r8y5jhlLIKliDRQZq4=;
        b=gP8x4zQ9SnJw562/wimv37GC1ZQznnGe9MEywNIIGCyCoX9+2878elLg60K9HHPUd6
         gTbBFGJNyHGq36UbkoF/t+NQ2QWdFUau14NrS+VtDjggMRV3J79RTazCyiQbhoKuS7yZ
         rZIY6RrQRoy1bB7oNNXgTsnxEIDkLIQeHfmRchrgGSIpoCvOrR5jzr3mdyX0AEK6xhdB
         dLLjGxp0e1tAkqEY4YS9MvtKrZ1HgpS2jbZeKVWFhvoBYrBDDTbB05WwofzwpxSQBhZW
         3L6thgimzAoJwIVexPM5YRWiJCW0Ie8XYUPq+0qOCGl2AgtPHjwUpslssYAOrXBJbO9O
         eKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772051747; x=1772656547;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sdsT1o9zXTNYRDs0/R0qL/yZ4r8y5jhlLIKliDRQZq4=;
        b=F8jGi4V4s+y6zO8MUtxzpX+gXxvBcgSue8uYnqvLcek8XWx77nfArquGTuKQ6LDBru
         T1+hpvoe4kN27k+8N+66l3NzDzOI4P0600sXqimRHiW0HqdNdDYmXNwaockHEGH0CRI1
         7uRXocRWlMAXyav4+k/8DdCPN8Jdlr0JFmCfreT3EHhFNHi0XMS/ZgTdYQ2vFxAxCCrl
         mIcQnsPqM56IEmwXFYtAvNZnV8flVPnqVcezVfZmiQAc9hFmzrsfhnIeC4J1ztWb+Hea
         XANd1Sn8Q6azn3holhdx+aEpP5CNbcjq6lVcoIw9w42pPtVqjbzqaupU1bwLVlynklji
         39cQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8lsgimRy0674wAv728nLYkx1O1hsD2g66FIgCxrYy3t7bUn9Sr7ugIrMXf0j7Pj/jhXQSwN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiDIdQWNkZlAs9YeY7fQ1qR4Ili6vUB1/cxUkAlL558UoRyjNN
	YvrF14tPgv3s/B1rvkXF+SPYnQhA9gLIBIf1+pPjOYqt8AnsrfaYdD/ALG1Wftp8flJSkepFwDP
	4TEp4Oe42SAnC0g==
X-Received: from qtwr7.prod.google.com ([2002:a05:622a:347:b0:504:8a53:d22e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:584b:0:b0:506:6caf:3cab with SMTP id d75a77b69052e-50741f38661mr27325621cf.26.1772051746778;
 Wed, 25 Feb 2026 12:35:46 -0800 (PST)
Date: Wed, 25 Feb 2026 20:35:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225203545.1512417-1-edumazet@google.com>
Subject: [PATCH net] inet: annotate data-races around isk->inet_num
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261073-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.969];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D44FD19D4DB
X-Rspamd-Action: no action

UDP/TCP lookups are using RCU, thus isk->inet_num accesses
should use READ_ONCE() and WRITE_ONCE() where needed.

Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hlist_nulls")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet6_hashtables.h | 2 +-
 include/net/inet_hashtables.h  | 2 +-
 include/net/ip.h               | 2 +-
 net/ipv4/inet_hashtables.c     | 8 ++++----
 net/ipv4/tcp_diag.c            | 2 +-
 net/ipv6/inet6_hashtables.c    | 3 ++-
 6 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 282e29237d9367f3e9a602a9e2964e291a3bf263..c16de5b7963fdb166b6f04420174a7a83a2e7973 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -175,7 +175,7 @@ static inline bool inet6_match(const struct net *net, const struct sock *sk,
 {
 	if (!net_eq(sock_net(sk), net) ||
 	    sk->sk_family != AF_INET6 ||
-	    sk->sk_portpair != ports ||
+	    READ_ONCE(sk->sk_portpair) != ports ||
 	    !ipv6_addr_equal(&sk->sk_v6_daddr, saddr) ||
 	    !ipv6_addr_equal(&sk->sk_v6_rcv_saddr, daddr))
 		return false;
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index ac05a52d9e1382cd7ed88ff07eab67ec42a2ede0..5a979dcab5383907560eddd6249a9d77c4d95978 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -345,7 +345,7 @@ static inline bool inet_match(const struct net *net, const struct sock *sk,
 			      int dif, int sdif)
 {
 	if (!net_eq(sock_net(sk), net) ||
-	    sk->sk_portpair != ports ||
+	    READ_ONCE(sk->sk_portpair) != ports ||
 	    sk->sk_addrpair != cookie)
 	        return false;
 
diff --git a/include/net/ip.h b/include/net/ip.h
index 69d5cef460040558529e1fdd3e9336986e843362..7f9abd457e0181fc7d0b351916c75210331a31bd 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -101,7 +101,7 @@ static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
 
 	ipcm->oif = READ_ONCE(inet->sk.sk_bound_dev_if);
 	ipcm->addr = inet->inet_saddr;
-	ipcm->protocol = inet->inet_num;
+	ipcm->protocol = READ_ONCE(inet->inet_num);
 }
 
 #define IPCB(skb) ((struct inet_skb_parm*)((skb)->cb))
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index f5826ec4bcaa864d63f0f4e314cb2878530cb381..46817b4c141b61b23cec14a220b89e27110a07ce 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -200,7 +200,7 @@ static bool inet_bind2_bucket_addr_match(const struct inet_bind2_bucket *tb2,
 void inet_bind_hash(struct sock *sk, struct inet_bind_bucket *tb,
 		    struct inet_bind2_bucket *tb2, unsigned short port)
 {
-	inet_sk(sk)->inet_num = port;
+	WRITE_ONCE(inet_sk(sk)->inet_num, port);
 	inet_csk(sk)->icsk_bind_hash = tb;
 	inet_csk(sk)->icsk_bind2_hash = tb2;
 	sk_add_bind_node(sk, &tb2->owners);
@@ -224,7 +224,7 @@ static void __inet_put_port(struct sock *sk)
 	spin_lock(&head->lock);
 	tb = inet_csk(sk)->icsk_bind_hash;
 	inet_csk(sk)->icsk_bind_hash = NULL;
-	inet_sk(sk)->inet_num = 0;
+	WRITE_ONCE(inet_sk(sk)->inet_num, 0);
 	sk->sk_userlocks &= ~SOCK_CONNECT_BIND;
 
 	spin_lock(&head2->lock);
@@ -352,7 +352,7 @@ static inline int compute_score(struct sock *sk, const struct net *net,
 {
 	int score = -1;
 
-	if (net_eq(sock_net(sk), net) && sk->sk_num == hnum &&
+	if (net_eq(sock_net(sk), net) && READ_ONCE(sk->sk_num) == hnum &&
 			!ipv6_only_sock(sk)) {
 		if (sk->sk_rcv_saddr != daddr)
 			return -1;
@@ -1206,7 +1206,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 
 		sk->sk_hash = 0;
 		inet_sk(sk)->inet_sport = 0;
-		inet_sk(sk)->inet_num = 0;
+		WRITE_ONCE(inet_sk(sk)->inet_num, 0);
 
 		if (tw)
 			inet_twsk_bind_unhash(tw, hinfo);
diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index d83efd91f461c8ad0157faeebae051b32cb07bf4..7935702e394b26d1ea2f2a990f645e0a681c6fbd 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -509,7 +509,7 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			if (r->sdiag_family != AF_UNSPEC &&
 			    sk->sk_family != r->sdiag_family)
 				goto next_normal;
-			if (r->id.idiag_sport != htons(sk->sk_num) &&
+			if (r->id.idiag_sport != htons(READ_ONCE(sk->sk_num)) &&
 			    r->id.idiag_sport)
 				goto next_normal;
 			if (r->id.idiag_dport != sk->sk_dport &&
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 5e1da088d8e11977c2ae92401eb4124e4af3b734..182d38e6d6d8dac30ea06b90daf8a7f328866063 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -95,7 +95,8 @@ static inline int compute_score(struct sock *sk, const struct net *net,
 {
 	int score = -1;
 
-	if (net_eq(sock_net(sk), net) && inet_sk(sk)->inet_num == hnum &&
+	if (net_eq(sock_net(sk), net) &&
+	    READ_ONCE(inet_sk(sk)->inet_num) == hnum &&
 	    sk->sk_family == PF_INET6) {
 		if (!ipv6_addr_equal(&sk->sk_v6_rcv_saddr, daddr))
 			return -1;
-- 
2.53.0.414.gf7e9f6c205-goog


