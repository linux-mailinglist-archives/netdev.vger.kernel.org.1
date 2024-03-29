Return-Path: <netdev+bounces-83356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D7389207C
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C49428649F
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BE817E;
	Fri, 29 Mar 2024 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jIq89dIQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B87B1C06
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726330; cv=none; b=tKcu3TgmHWlBomIRynfRB5wGiTQR3Alddbl5u+UbIB9IFK21vpgV6xfia510k30atar8hJ01KClFbRWvtxA5P9c6NXhthsGGNQjnRUGtrgviZwGGkxzkkJGWUR/NjCEyfNaLy33yDoct6D8/vukQXRi3g4pLZO6AP9KZtBjvbK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726330; c=relaxed/simple;
	bh=f3d556cLhbNhaXPV7Njw3Rtk9Y+pUetTRY0/92RRbfo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BdDSsXf697AYjUGm9qwSKd6SDK+/xfnDJ402I4iOoq2fLJKBOkeZD73MdZHMdEE8IdFEKIO3dwjmXS2Q0YA9ERCvxO74o/QDTZEr/ny1A1i/N9F3sI4FnKBhOi2YZfqPbAqZu4PRIOG17OLDuB0y+pSo5GJ+ZO+u947NEr9LMiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jIq89dIQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-611e89cf3b5so33867817b3.3
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711726327; x=1712331127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xmI3x6N+H2eGhdvvwaXrGDU49PCgb+8fxWs2HOJvcPA=;
        b=jIq89dIQWeIcUdhJe5iiTS8wbnCCMULswLiueLoA8VXtgFrjkBTgMTkkrUVtr8S861
         3XW/T/eGzVqUdydPi79y9dHBCjHlsZkxvGrbs7S7wjxK34ypeQ+8k3WVwvQ9t8R+JyIX
         Gu1x0xDiWTwjRRf3T/mFchAQ7D0A1qvEHXHljW6Fylzb5T2rH2lgA6RMnlozpKuMWuHU
         LKL7f05vNonQ7GaCxNz6b7TDupVWgSlDvZQ45uNlsMkt/XIhfZAn5KoM30PEJyQgZZ4X
         oShG2eBUkDxuvnbyS+TAcyva98cCyEBnjiVT8BlWeej7cU9iiKWcl5p06b/BPz2GTWFp
         Dwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711726327; x=1712331127;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xmI3x6N+H2eGhdvvwaXrGDU49PCgb+8fxWs2HOJvcPA=;
        b=j73k1v1jLrhAhx14bH3BfNAYWbP4Q7pC8PqFW0P7mHnrupIb2krMDh+AOIlveN/SqN
         0Lgt4QUMMJNcNo2ZVxnW7YxHsEXPMYwycQrG8mSN4qaWmFhETbrk+u58uVgLe+ztdGv5
         WBBFO1GtFpjXcwPWI5Hl8Wa44LciMThTmydwqG10Bj16ZllN7dvJO0K5K4g4sgJ1zf1H
         wtPxvvs+dZiA0mgp9q2IEFimpo6HLMX2foHcxFBysnqM/Jj1As7tItpVsSQwUA1ycBmc
         0N8/jPNxShACyoIfXxUCMNe8bggSlNiFRw3TGPzSz1Gq/n9Z00m2EJWu7BV4h38eN2C2
         BV3g==
X-Gm-Message-State: AOJu0Yz2yO5GBG3POXFpr6v1Nx9Q34hILpVUsjWMZhv4XC+X4A56j2TF
	PgKCyv72Skrc0xcntgou3/cERQvnn+fGOqmLH77oKvIHlH2et0edxkw/1VFe1grN+zAA0+VsV7S
	jgcauYn+mNg==
X-Google-Smtp-Source: AGHT+IEJIYe5bpmlKFYLmHnw4R9RfNNQ/0KsYWW6SxkLHKDjFIDam5qfzxkeK7dVkttRnRIbntCOfc/uvrzCBg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:cc01:0:b0:611:9c16:6cb8 with SMTP id
 o1-20020a0dcc01000000b006119c166cb8mr594204ywd.10.1711726327569; Fri, 29 Mar
 2024 08:32:07 -0700 (PDT)
Date: Fri, 29 Mar 2024 15:32:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329153203.345203-1-edumazet@google.com>
Subject: [PATCH net-next] tcp/dccp: do not care about families in inet_twsk_purge()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"

We lost ability to unload ipv6 module a long time ago.

Instead of calling expensive inet_twsk_purge() twice,
we can handle all families in one round.

Also remove an extra line added in my prior patch,
per Kuniyuki Iwashima feedback.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/netdev/20240327192934.6843-1-kuniyu@amazon.com/
---
 include/net/inet_timewait_sock.h | 2 +-
 include/net/tcp.h                | 2 +-
 net/dccp/ipv4.c                  | 2 +-
 net/dccp/ipv6.c                  | 6 ------
 net/ipv4/inet_timewait_sock.c    | 9 +++------
 net/ipv4/tcp_ipv4.c              | 2 +-
 net/ipv4/tcp_minisocks.c         | 6 +++---
 net/ipv6/tcp_ipv6.c              | 6 ------
 8 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index f28da08a37b4e97f366279be47192019c901ed47..2a536eea9424ea4fad65a1321217b07d2346e638 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -111,7 +111,7 @@ static inline void inet_twsk_reschedule(struct inet_timewait_sock *tw, int timeo
 
 void inet_twsk_deschedule_put(struct inet_timewait_sock *tw);
 
-void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family);
+void inet_twsk_purge(struct inet_hashinfo *hashinfo);
 
 static inline
 struct net *twsk_net(const struct inet_timewait_sock *twsk)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6ae35199d3b3c159ba029ff74b109c56a7c7d2fc..6eaad953385e15772e8267b94ad7bf8864c18a2d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -353,7 +353,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
 void tcp_twsk_destructor(struct sock *sk);
-void tcp_twsk_purge(struct list_head *net_exit_list, int family);
+void tcp_twsk_purge(struct list_head *net_exit_list);
 ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
 			struct pipe_inode_info *pipe, size_t len,
 			unsigned int flags);
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 44b033fe1ef6859df0703c7e580cf20c771ad479..9fc9cea4c251bfb94904f1ba3b42f54fd9195dd0 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -1039,7 +1039,7 @@ static void __net_exit dccp_v4_exit_net(struct net *net)
 
 static void __net_exit dccp_v4_exit_batch(struct list_head *net_exit_list)
 {
-	inet_twsk_purge(&dccp_hashinfo, AF_INET);
+	inet_twsk_purge(&dccp_hashinfo);
 }
 
 static struct pernet_operations dccp_v4_ops = {
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index ded07e09f8135aaf6aaa08f0adcb009d8614223c..c8ca703dc331a1a030e380daba7bcf6d382d79d6 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -1119,15 +1119,9 @@ static void __net_exit dccp_v6_exit_net(struct net *net)
 	inet_ctl_sock_destroy(pn->v6_ctl_sk);
 }
 
-static void __net_exit dccp_v6_exit_batch(struct list_head *net_exit_list)
-{
-	inet_twsk_purge(&dccp_hashinfo, AF_INET6);
-}
-
 static struct pernet_operations dccp_v6_ops = {
 	.init   = dccp_v6_init_net,
 	.exit   = dccp_v6_exit_net,
-	.exit_batch = dccp_v6_exit_batch,
 	.id	= &dccp_v6_pernet_id,
 	.size   = sizeof(struct dccp_v6_pernet),
 };
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index b0cc07d9a568c5dc52bd29729862bcb03e5d595d..e28075f0006e333897ad379ebc8c87fc3f9643bd 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -264,7 +264,7 @@ void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo, bool rearm)
 EXPORT_SYMBOL_GPL(__inet_twsk_schedule);
 
 /* Remove all non full sockets (TIME_WAIT and NEW_SYN_RECV) for dead netns */
-void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
+void inet_twsk_purge(struct inet_hashinfo *hashinfo)
 {
 	struct inet_ehash_bucket *head = &hashinfo->ehash[0];
 	unsigned int ehash_mask = hashinfo->ehash_mask;
@@ -273,7 +273,6 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
 	struct sock *sk;
 
 	for (slot = 0; slot <= ehash_mask; slot++, head++) {
-
 		if (hlist_nulls_empty(&head->chain))
 			continue;
 
@@ -288,15 +287,13 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
 					     TCPF_NEW_SYN_RECV))
 				continue;
 
-			if (sk->sk_family != family ||
-			    refcount_read(&sock_net(sk)->ns.count))
+			if (refcount_read(&sock_net(sk)->ns.count))
 				continue;
 
 			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
 				continue;
 
-			if (unlikely(sk->sk_family != family ||
-				     refcount_read(&sock_net(sk)->ns.count))) {
+			if (refcount_read(&sock_net(sk)->ns.count)) {
 				sock_gen_put(sk);
 				goto restart;
 			}
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a22ee58387518ac5ea602d0f66be41dfa0f4c1ee..1e0a9762f92e608c99ef7781dbdaa1ba9479b39d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3501,7 +3501,7 @@ static void __net_exit tcp_sk_exit_batch(struct list_head *net_exit_list)
 {
 	struct net *net;
 
-	tcp_twsk_purge(net_exit_list, AF_INET);
+	tcp_twsk_purge(net_exit_list);
 
 	list_for_each_entry(net, net_exit_list, exit_list) {
 		inet_pernet_hashinfo_free(net->ipv4.tcp_death_row.hashinfo);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index f0761f060a8376236983a660eea48a6e0ba94de4..5b21a07ddf9aa5593d21cb856f0e0ea2f45b1eef 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -388,7 +388,7 @@ void tcp_twsk_destructor(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(tcp_twsk_destructor);
 
-void tcp_twsk_purge(struct list_head *net_exit_list, int family)
+void tcp_twsk_purge(struct list_head *net_exit_list)
 {
 	bool purged_once = false;
 	struct net *net;
@@ -396,9 +396,9 @@ void tcp_twsk_purge(struct list_head *net_exit_list, int family)
 	list_for_each_entry(net, net_exit_list, exit_list) {
 		if (net->ipv4.tcp_death_row.hashinfo->pernet) {
 			/* Even if tw_refcount == 1, we must clean up kernel reqsk */
-			inet_twsk_purge(net->ipv4.tcp_death_row.hashinfo, family);
+			inet_twsk_purge(net->ipv4.tcp_death_row.hashinfo);
 		} else if (!purged_once) {
-			inet_twsk_purge(&tcp_hashinfo, family);
+			inet_twsk_purge(&tcp_hashinfo);
 			purged_once = true;
 		}
 	}
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 3f4cba49e9ee6520987993dcea082e6065b4688b..5ae74f661d25f9328af2a771bd801065a6522308 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2389,15 +2389,9 @@ static void __net_exit tcpv6_net_exit(struct net *net)
 	inet_ctl_sock_destroy(net->ipv6.tcp_sk);
 }
 
-static void __net_exit tcpv6_net_exit_batch(struct list_head *net_exit_list)
-{
-	tcp_twsk_purge(net_exit_list, AF_INET6);
-}
-
 static struct pernet_operations tcpv6_net_ops = {
 	.init	    = tcpv6_net_init,
 	.exit	    = tcpv6_net_exit,
-	.exit_batch = tcpv6_net_exit_batch,
 };
 
 int __init tcpv6_init(void)
-- 
2.44.0.478.gd926399ef9-goog


