Return-Path: <netdev+bounces-216131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0669B3229D
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 21:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00E54B60241
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 19:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4BA2D1932;
	Fri, 22 Aug 2025 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XVHrjwmJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1F2D191C
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889711; cv=none; b=lLuscvE+FFGHQWtZw/t52tkuGxmzFKM9rW5TknusLvylWN9uz1XpswMLtf7NSEdlRYmBp5L2jp23EjdLFdPe0yl2xB7sVWAFrOHy3iik7YFhIr1NKiELtqzfMt3CirDnsxY/73V+7M9rcF0JCAAXne5b+AfiZ6BOJ93QZuUR1TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889711; c=relaxed/simple;
	bh=1r6zEBGFTJligIoG2He7YqRdAp4+W9HvKgoKbAXknn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M9+r78teYPVk/atxZbwyiweimA7976+uIH0OR5EUH891UXt6JEX4jJCfeweTEJMzqLy6x4txMtk3aEf6EZB6X/TQFdoqX4ESNSvVYg7bsjgHi7HmiiKxcil+7tiI0mjFRZPTB4PY5cibP4INZZZDXPZzG0YVzjE1vRIu1pXBgAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XVHrjwmJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-323266c83f6so2500949a91.0
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 12:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755889709; x=1756494509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tgq8q7gtv5EVeUswbUtk6i+yjx0VTgodyvZ2FsMLTzo=;
        b=XVHrjwmJYbOsCa0dEURyFlxsbFZ/OjNPFLZnzlkE1hnvt/yILNb7XQRZDefzbn3FF+
         Q9AgLJXhi5upTtFcl/MCp3ZEuF3Y11kaUXT6fjM6xQbFi7glzRZosF7+ObcHNvHw8sRA
         BMpW5XY6KfDNMroFcAtqYyEq1Xnnp0QZAMlDjYADQFeNjHeOvYfFqpmGLYHCgrBuXHcB
         mCZ0M7Gz9V5itrjSbxJnxo/NynN0GpCoYDQbqpoZnBE7l3FPprpFTGnuVO7OqK3jRUDd
         IeCGfcfwqQzm992I3TXPhCxKrxzEgwxIHlFkaRrjuR1kkB8udC51gMx/3MU4VxQ529fb
         MKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755889709; x=1756494509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tgq8q7gtv5EVeUswbUtk6i+yjx0VTgodyvZ2FsMLTzo=;
        b=G16UNLb/9naEW4DXJsIOL2DJMgr6y2kkX917GR9eWXqohC0FOHoqwEtaWLbLKWEMEQ
         +Gwl0ZugOXrc8boSAD/d0StmCDKsWckPLbJbYH/eQHepcEkJlw5fWZ7hluCwQ964uZdl
         H81ETkp0CpFbhMU610A8y3Z54yjs3qM9ypAw2vv0kJlZE/Grk6HjMjVufeUxQLIfytoH
         8lQMxy+Mhyaf+VHIzCHp6v2u47mnLbu2v163el5okyqn+6Crftpk+mSUtBMWaAPR9iyN
         aH7yopMojtA3Xovi+cu5nUVdvTWxNt6rRlYHICcM3J8DdIBiVK0/vdymggI5n1IdyZIx
         j2xg==
X-Forwarded-Encrypted: i=1; AJvYcCVMc1FkSqJOFsATSU1bXYXIBV/BtpxdWxRDMNdf4YzHo2SaQDkFvtAsPjkYj67aulSGr+ShNgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkQe3XDpmHQagKOyhkc2H5Ujtml1xjAkiFPDyqIXM7vKfjmD+h
	o3tGyH0YsNZOApFQ2SG5gMI7TOeMg9rm1WlKG+crivTlwc/huh9+VGaweU3eSK5VA4K6nk5vU0M
	apmngaw==
X-Google-Smtp-Source: AGHT+IGJ00tLBQmH3OCbqaChJMxQwgsFHqFLiR1RmjgujkIUZfAVWkFhr0FJdZiytF8fjfJmUOl/0UnO2Sc=
X-Received: from pjbsw5.prod.google.com ([2002:a17:90b:2c85:b0:311:485b:d057])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2541:b0:324:e431:e426
 with SMTP id 98e67ed59e1d1-3251d5a6f2emr5278762a91.17.1755889709123; Fri, 22
 Aug 2025 12:08:29 -0700 (PDT)
Date: Fri, 22 Aug 2025 19:07:00 +0000
In-Reply-To: <20250822190803.540788-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822190803.540788-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822190803.540788-6-kuniyu@google.com>
Subject: [PATCH v2 net-next 5/6] tcp: Don't pass hashinfo to inet_diag helpers.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These inet_diag functions required struct inet_hashinfo because
they are shared by TCP and DCCP:

  * inet_diag_dump_icsk()
  * inet_diag_dump_one_icsk()
  * inet_diag_find_one_icsk()

DCCP has gone, and we don't need to pass hashinfo down to them.

Let's fetch net->ipv4.tcp_death_row.hashinfo directly in the first
2 functions.

Note that inet_diag_find_one_icsk() don't need hashinfo since the
previous patch.

We will move TCP-specific functions to tcp_diag.c in the next patch.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/inet_diag.h |  6 ++----
 net/ipv4/inet_diag.c      | 10 +++++-----
 net/ipv4/tcp_diag.c       | 17 +++--------------
 3 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
index a9033696b0aa..34de992b5bd9 100644
--- a/include/linux/inet_diag.h
+++ b/include/linux/inet_diag.h
@@ -48,15 +48,13 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 		      struct sk_buff *skb, struct netlink_callback *cb,
 		      const struct inet_diag_req_v2 *req,
 		      u16 nlmsg_flags, bool net_admin);
-void inet_diag_dump_icsk(struct inet_hashinfo *h, struct sk_buff *skb,
+void inet_diag_dump_icsk(struct sk_buff *skb,
 			 struct netlink_callback *cb,
 			 const struct inet_diag_req_v2 *r);
-int inet_diag_dump_one_icsk(struct inet_hashinfo *hashinfo,
-			    struct netlink_callback *cb,
+int inet_diag_dump_one_icsk(struct netlink_callback *cb,
 			    const struct inet_diag_req_v2 *req);
 
 struct sock *inet_diag_find_one_icsk(struct net *net,
-				     struct inet_hashinfo *hashinfo,
 				     const struct inet_diag_req_v2 *req);
 
 int inet_diag_bc_sk(const struct nlattr *_bc, struct sock *sk);
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 9d909734cf8a..fa4175b7f202 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -519,7 +519,6 @@ static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
 }
 
 struct sock *inet_diag_find_one_icsk(struct net *net,
-				     struct inet_hashinfo *hashinfo,
 				     const struct inet_diag_req_v2 *req)
 {
 	struct sock *sk;
@@ -562,8 +561,7 @@ struct sock *inet_diag_find_one_icsk(struct net *net,
 }
 EXPORT_SYMBOL_GPL(inet_diag_find_one_icsk);
 
-int inet_diag_dump_one_icsk(struct inet_hashinfo *hashinfo,
-			    struct netlink_callback *cb,
+int inet_diag_dump_one_icsk(struct netlink_callback *cb,
 			    const struct inet_diag_req_v2 *req)
 {
 	struct sk_buff *in_skb = cb->skb;
@@ -573,7 +571,7 @@ int inet_diag_dump_one_icsk(struct inet_hashinfo *hashinfo,
 	struct sock *sk;
 	int err;
 
-	sk = inet_diag_find_one_icsk(net, hashinfo, req);
+	sk = inet_diag_find_one_icsk(net, req);
 	if (IS_ERR(sk))
 		return PTR_ERR(sk);
 
@@ -1018,7 +1016,7 @@ static void twsk_build_assert(void)
 #endif
 }
 
-void inet_diag_dump_icsk(struct inet_hashinfo *hashinfo, struct sk_buff *skb,
+void inet_diag_dump_icsk(struct sk_buff *skb,
 			 struct netlink_callback *cb,
 			 const struct inet_diag_req_v2 *r)
 {
@@ -1026,10 +1024,12 @@ void inet_diag_dump_icsk(struct inet_hashinfo *hashinfo, struct sk_buff *skb,
 	struct inet_diag_dump_data *cb_data = cb->data;
 	struct net *net = sock_net(skb->sk);
 	u32 idiag_states = r->idiag_states;
+	struct inet_hashinfo *hashinfo;
 	int i, num, s_i, s_num;
 	struct nlattr *bc;
 	struct sock *sk;
 
+	hashinfo = net->ipv4.tcp_death_row.hashinfo;
 	bc = cb_data->inet_diag_nla_bc;
 	if (idiag_states & TCPF_SYN_RECV)
 		idiag_states |= TCPF_NEW_SYN_RECV;
diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index 45e174b8cd22..7cd9d032efdd 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -180,21 +180,13 @@ static size_t tcp_diag_get_aux_size(struct sock *sk, bool net_admin)
 static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			  const struct inet_diag_req_v2 *r)
 {
-	struct inet_hashinfo *hinfo;
-
-	hinfo = sock_net(cb->skb->sk)->ipv4.tcp_death_row.hashinfo;
-
-	inet_diag_dump_icsk(hinfo, skb, cb, r);
+	inet_diag_dump_icsk(skb, cb, r);
 }
 
 static int tcp_diag_dump_one(struct netlink_callback *cb,
 			     const struct inet_diag_req_v2 *req)
 {
-	struct inet_hashinfo *hinfo;
-
-	hinfo = sock_net(cb->skb->sk)->ipv4.tcp_death_row.hashinfo;
-
-	return inet_diag_dump_one_icsk(hinfo, cb, req);
+	return inet_diag_dump_one_icsk(cb, req);
 }
 
 #ifdef CONFIG_INET_DIAG_DESTROY
@@ -202,13 +194,10 @@ static int tcp_diag_destroy(struct sk_buff *in_skb,
 			    const struct inet_diag_req_v2 *req)
 {
 	struct net *net = sock_net(in_skb->sk);
-	struct inet_hashinfo *hinfo;
 	struct sock *sk;
 	int err;
 
-	hinfo = net->ipv4.tcp_death_row.hashinfo;
-	sk = inet_diag_find_one_icsk(net, hinfo, req);
-
+	sk = inet_diag_find_one_icsk(net, req);
 	if (IS_ERR(sk))
 		return PTR_ERR(sk);
 
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


