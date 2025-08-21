Return-Path: <netdev+bounces-215499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC582B2EE08
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28BC15C7746
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 06:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2CA2DEA9E;
	Thu, 21 Aug 2025 06:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4WCPDp3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F45221F24
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755756971; cv=none; b=rbeSLf9ail89oZuFMrFulGlGkdxYayXqoybSTWrJi6Bf5FvLLQhsIH8u3mVnRjMia29UcBH8Fk2IyYV8EOqLBJijYGTjQJf2XxF1zFtn4qN3Je1Ee/FGDc43RwpadftslCVlyT/MFCEpkGrnGXdEs0wO7cW/PHy7Q/px2YFKwQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755756971; c=relaxed/simple;
	bh=ELVNPza4Z91rxybsIdy7zQw83x9W4+PTRn+Z+5PtjEs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uRjF440Afs9YpwmOENULgHxhLI3ruio62useByvhnJxdjZ25GtGvRxz+kmna+c53YebQTc0DvCd3RfM6yB2+7+8JLZRpNgl7C0lNTe/06ocSLlv2OMi/eYmaI1K8jcoCcVscmpsmUZCyRpXf8qRTMd0OTLtUDNPgnZv2rxEmlRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E4WCPDp3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2e8e28e1so2048947b3a.1
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 23:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755756969; x=1756361769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mlh+yGcxYgl7D94FZub001jRMmvLpDrZgHzPDBVSPFs=;
        b=E4WCPDp3QtdC+wfr0ZxZAQ7JD4F8woXJbcJ+sU5JIYpUdHVgWkd05RHpInIQ3qPfQS
         0YCcQUkbvVgZNjbwc9vnhjUt2mhjmlq7zkCwjyAoMCacy13ufNNbkA2YyF1dPILZTkNJ
         0LZN7CIWgPekQeV/lA8ER2hP2knKcWeZ2hT2Bzyn4D9zYbRGXPAQzTdlX4mcpGiMT9ek
         fuU/pV2NbqaEekXYMf+W6Xo3nJf0bUanNvUYXO+GnEM6fMMwCM2ppot0SwRRla9AP2lZ
         kWJcSMgQ9CENVDO1hPOTHSZpOvIflkrV2WErtqZ+05V2pVxYlLPGa7wHd6fYzdp40l4c
         4iZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755756969; x=1756361769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mlh+yGcxYgl7D94FZub001jRMmvLpDrZgHzPDBVSPFs=;
        b=LsvNiQ5V30U5rqxcilE5tScyCrqT0K57VncYFI4unNx1k0ooFnb67ftnBZlTge7tEF
         5OC9/aXH+j0EQ+7Y7MJjd3oCjAV5A1I4AkgYgGwz/03kl1uKpUVifGWA88s2zF1Djzzx
         xq3CYhvNZ3hVBkI6ChOAGdUyAOenCytV3S+tJUkwyKszmEpQKkuG9IW3Ek0GuuIPmtDK
         9eoW9R47lbOHYU24efpOyCDFW22jjTvFVTtzfHkPQG98O93J7GneNOa50LFSBn3cm/mD
         HGg/1qonMudkc/dBtRbxnHL1YWcw8r6ZsuQWW7zYoY+3PnYjqoJcUJUTrMq3oXf/eA2L
         Jo9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+n+We3uuFCzu2xd19httZ9u6bMehQ7PHBQHC0RQaQ2kxusyiIsZ3jq7e+/NfHVwlfg1DOUmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe3kDX7mZ/FkYr3HIvIU2clLL9eI5SzNYgZlA12fRJuc4A6LW/
	G+GAa6vZ3guuNjYU68wDwazNH8zP2ozvzt1Y7IlL+k/d8fdUdhE6qfKCZcDu/D1DlutoL+rZdRb
	pxgNzrQ==
X-Google-Smtp-Source: AGHT+IFDfRoysGHVA1xjjEAadzhIV3pest5gu8Isp8bD5ZynGEjMoAoYxiFRIQVdAPKX96YtGczJ/RpOFTE=
X-Received: from pfud9.prod.google.com ([2002:a05:6a00:10c9:b0:76b:fb08:20e9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:140d:b0:76e:885a:c1ce
 with SMTP id d2e1a72fcca58-76ea3230284mr1614586b3a.32.1755756968542; Wed, 20
 Aug 2025 23:16:08 -0700 (PDT)
Date: Thu, 21 Aug 2025 06:15:17 +0000
In-Reply-To: <20250821061540.2876953-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821061540.2876953-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821061540.2876953-7-kuniyu@google.com>
Subject: [PATCH v1 net-next 6/7] tcp: Don't pass hashinfo to inet_diag helpers.
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
2.51.0.rc1.193.gad69d77794-goog


