Return-Path: <netdev+bounces-85494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCF589B015
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 11:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696231C20A70
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 09:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C30171D8;
	Sun,  7 Apr 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0yqLmFSR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63DF14295
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712482412; cv=none; b=rcD/b5Lbus3oyBA6A5e0zYTHNS84TOh8fG4N+KY0etCY2sBFye94iQJkC/DuUVd3O2JR8VrmwV3/bUj2kgtFLB4+6sdm10UkPfntG0wZAaFwZU4BDIcgIfa9HBqjY3qcYa3OSNSQNmhuGV9xvHnsLbMhC0PD5HQ2faxB1jNf8KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712482412; c=relaxed/simple;
	bh=Hrp+md+8YLT4mRwz7YWy1yrXTL6gTeCUynDeJu6EF40=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hg9f/89s5iMVoDp/wPpCGrxZsW9pRVlglQwVYu5YAJqpfvinJTNO6InPSyBQEBJzK6WafFCEp4I2iA1PvfnZAvku0IVhwuqjswl0My3dxOk1hhSA1PMXgqiCMmwMPW/1SvmVY7zSLVwVlBqi+0VpFOnnOazQAWDXDJa1vqaikgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0yqLmFSR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso5124444276.1
        for <netdev@vger.kernel.org>; Sun, 07 Apr 2024 02:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712482410; x=1713087210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zt3JVf9pxS5FsJysIzUO1FjSPv03D2t2MKk+pZbb8PY=;
        b=0yqLmFSRc/3288js9w9VgyZLNauN7Bb34I+gPKmeXnF7QCSwiuwUyn7z3z2csJtRyG
         Y8RjfzF6vG0Rwy6/XvpbTcV7mUggJUo7uoEfR3Kb0vBxJcDVivDjabkeuXZy0cu4E6jV
         ahqcI3AZuhQgjA8wQxOJLeOFcQDUlN3mRiML5TCAXFs0b/OvpdoZLkZO9z07G1VAx/jz
         qSq/w0q2DAB470fkRyK1Zf2Uoif0N+xTqCsUgbLbm18SXBqpxfYypGE0w2V4y9QREMyX
         RBlst8lKouSPMfZpgX0oAGQ6GtKodIs1W7pVtNeIKOTFTzHJiOcko7SU76gQxqjqnrR2
         PpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712482410; x=1713087210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zt3JVf9pxS5FsJysIzUO1FjSPv03D2t2MKk+pZbb8PY=;
        b=Oo8TCYCtFK8XxC1EPBOV6n5tHihdmVcDKPwJl28CRa/XRbGtkVo6N8YRdhQSpagSI4
         Kfrpdfgq+A4sIp5972uvcNY2al7q2vRhFl4z8CoQZhVHj/mWdZ2aq0yRs/cYXByH6KwT
         eHV2pLJneYhFvsJrCd0CRT+z2k6pRyDpanGeMkCQVsv8E8avxdzlj8VNz/vk7q8HQEjn
         sykbNPoMecIX56DNT/AZN2baBgRXeKXhh/vuYhos4CdgF64VVo76j7KCsZFN2YSO5Kga
         A4cTlpGFbFIZzdo/pEMDZLZg10ogto294wJYMKiVcqdcDyihCDrW0rT7gmJnkh5l36qm
         RLxg==
X-Forwarded-Encrypted: i=1; AJvYcCV6skyMR9M0dpoQEmpLvmOWgkXcRSN61BbpXuHZudhgw61FAFkbpFZiKyJJf4KyfT1YNarqcj/6+MBoRHA6LL13BMEPXVY9
X-Gm-Message-State: AOJu0Ywx8h64F9l0zsXLZZm4dV9gZ87Zcm9/zplSdEaHS3jXJHtxTIss
	/ZONQQoNJ2zNwWU40F9AJe+3VyM9QSSpUa3CRVq0XfNIQ4esi8XrU/6wu3zIybFVU7haoIGztt2
	T/YSl1HJ60g==
X-Google-Smtp-Source: AGHT+IHDA3R8j9o4TjkQP9E6q+MGcMQd1jekA1PpJqaO3CS2qtVQGLVAzY2KopbtzkAOQYhmuDOm2G+Vqztrvw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:6911:0:b0:dcc:79ab:e522 with SMTP id
 e17-20020a256911000000b00dcc79abe522mr471743ybc.11.1712482409961; Sun, 07 Apr
 2024 02:33:29 -0700 (PDT)
Date: Sun,  7 Apr 2024 09:33:21 +0000
In-Reply-To: <20240407093322.3172088-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240407093322.3172088-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240407093322.3172088-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] tcp: propagate tcp_tw_isn via an extra parameter
 to ->route_req()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_v6_init_req() reads TCP_SKB_CB(skb)->tcp_tw_isn to find
out if the request socket is created by a SYN hitting a TIMEWAIT socket.

This has been buggy for a decade, lets directly pass the information
from tcp_conn_request().

This is a preparatory patch to make the following one easier to review.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h    |  3 ++-
 net/ipv4/tcp_input.c |  2 +-
 net/ipv4/tcp_ipv4.c  |  3 ++-
 net/ipv6/tcp_ipv6.c  | 10 ++++++----
 net/mptcp/subflow.c  | 10 ++++++----
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9ab5b37e9d532cdf26dd423810b07912ef4abd75..fa0ab77acee23654b22e97615de983fc04eee319 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2284,7 +2284,8 @@ struct tcp_request_sock_ops {
 	struct dst_entry *(*route_req)(const struct sock *sk,
 				       struct sk_buff *skb,
 				       struct flowi *fl,
-				       struct request_sock *req);
+				       struct request_sock *req,
+				       u32 tw_isn);
 	u32 (*init_seq)(const struct sk_buff *skb);
 	u32 (*init_ts_off)(const struct net *net, const struct sk_buff *skb);
 	int (*send_synack)(const struct sock *sk, struct dst_entry *dst,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 1f28a2561795cf48ee7dbf638c15c773c8b8c84c..48c275e6ef02bfc5dd98f0878c752841f949c714 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7160,7 +7160,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	/* Note: tcp_v6_init_req() might override ir_iif for link locals */
 	inet_rsk(req)->ir_iif = inet_request_bound_dev_if(sk, skb);
 
-	dst = af_ops->route_req(sk, skb, &fl, req);
+	dst = af_ops->route_req(sk, skb, &fl, req, isn);
 	if (!dst)
 		goto drop_and_free;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 52963c3bb8ca7380692f7be6e15d687c45e8673a..81e2f05c244d1671980a34bb756f528f3e6debcc 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1666,7 +1666,8 @@ static void tcp_v4_init_req(struct request_sock *req,
 static struct dst_entry *tcp_v4_route_req(const struct sock *sk,
 					  struct sk_buff *skb,
 					  struct flowi *fl,
-					  struct request_sock *req)
+					  struct request_sock *req,
+					  u32 tw_isn)
 {
 	tcp_v4_init_req(req, sk, skb);
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index cffebaec66f1ab60f1dde00b8bd8cc7a595bdc91..5141f7033abd8bb03bc4e162066ca4befe343bdc 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -793,7 +793,8 @@ static int tcp_v6_md5_hash_skb(char *md5_hash,
 
 static void tcp_v6_init_req(struct request_sock *req,
 			    const struct sock *sk_listener,
-			    struct sk_buff *skb)
+			    struct sk_buff *skb,
+			    u32 tw_isn)
 {
 	bool l3_slave = ipv6_l3mdev_skb(TCP_SKB_CB(skb)->header.h6.flags);
 	struct inet_request_sock *ireq = inet_rsk(req);
@@ -807,7 +808,7 @@ static void tcp_v6_init_req(struct request_sock *req,
 	    ipv6_addr_type(&ireq->ir_v6_rmt_addr) & IPV6_ADDR_LINKLOCAL)
 		ireq->ir_iif = tcp_v6_iif(skb);
 
-	if (!TCP_SKB_CB(skb)->tcp_tw_isn &&
+	if (!tw_isn &&
 	    (ipv6_opt_accepted(sk_listener, skb, &TCP_SKB_CB(skb)->header.h6) ||
 	     np->rxopt.bits.rxinfo ||
 	     np->rxopt.bits.rxoinfo || np->rxopt.bits.rxhlim ||
@@ -820,9 +821,10 @@ static void tcp_v6_init_req(struct request_sock *req,
 static struct dst_entry *tcp_v6_route_req(const struct sock *sk,
 					  struct sk_buff *skb,
 					  struct flowi *fl,
-					  struct request_sock *req)
+					  struct request_sock *req,
+					  u32 tw_isn)
 {
-	tcp_v6_init_req(req, sk, skb);
+	tcp_v6_init_req(req, sk, skb, tw_isn);
 
 	if (security_inet_conn_request(sk, skb, req))
 		return NULL;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6042a47da61be8bc3000ab485fe6fbb7bff387b6..294390a9cd431024b84a56feae9b9c895111393e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -284,7 +284,8 @@ EXPORT_SYMBOL_GPL(mptcp_subflow_init_cookie_req);
 static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 					      struct sk_buff *skb,
 					      struct flowi *fl,
-					      struct request_sock *req)
+					      struct request_sock *req,
+					      u32 tw_isn)
 {
 	struct dst_entry *dst;
 	int err;
@@ -292,7 +293,7 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 	tcp_rsk(req)->is_mptcp = 1;
 	subflow_init_req(req, sk);
 
-	dst = tcp_request_sock_ipv4_ops.route_req(sk, skb, fl, req);
+	dst = tcp_request_sock_ipv4_ops.route_req(sk, skb, fl, req, tw_isn);
 	if (!dst)
 		return NULL;
 
@@ -351,7 +352,8 @@ static int subflow_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
 static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 					      struct sk_buff *skb,
 					      struct flowi *fl,
-					      struct request_sock *req)
+					      struct request_sock *req,
+					      u32 tw_isn)
 {
 	struct dst_entry *dst;
 	int err;
@@ -359,7 +361,7 @@ static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 	tcp_rsk(req)->is_mptcp = 1;
 	subflow_init_req(req, sk);
 
-	dst = tcp_request_sock_ipv6_ops.route_req(sk, skb, fl, req);
+	dst = tcp_request_sock_ipv6_ops.route_req(sk, skb, fl, req, tw_isn);
 	if (!dst)
 		return NULL;
 
-- 
2.44.0.478.gd926399ef9-goog


