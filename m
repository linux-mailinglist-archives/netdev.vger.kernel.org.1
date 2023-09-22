Return-Path: <netdev+bounces-35648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C20B7AA760
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 05:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 149F72825E2
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 03:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2305A34;
	Fri, 22 Sep 2023 03:42:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C9F1844
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 03:42:29 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A66CC
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:42:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d852a6749bcso2188859276.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695354147; x=1695958947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yZ00QPdMplMoTUVV9Lms/pPXb57cNmLUZmJ/rCICjWE=;
        b=dSTWKKp//H53U5FuUPMujXVIMXlQ75RD90uUd52gIQ5gbEeMmWsmk8Yw0qmsUYW4nP
         u4uDN//t1EBohMnCQBqQrDkv9C2pDl55PEQWzI4hN60SuXWBX99kzBzOXavPZxw3oEcE
         WtWn5wVb2hmZbR5aMZ2zUf8hwu6zS955tphm3hq1UrlBNywXB+Zp6BIeM++aXK5Js4rl
         7TCcEQ8f4/v/01O1l7NBLasDlcW6X7c9yenhvVeEyjJIAs1oK3DH8rMZd3AD3uvbSc4c
         4SPwK1yCqfTLAC7pqHJE7GGjVCnZxAxvGSg0V+G2ZVNjDMK5oZ0MI2z8rIdlST0aYDPk
         kH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695354147; x=1695958947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZ00QPdMplMoTUVV9Lms/pPXb57cNmLUZmJ/rCICjWE=;
        b=B9EkPDWCPKRbjzqKPSWor4woFh9hTB3XAI04ePzlpOzQxM3MMAvQtue6kDPpB3m//e
         Z6MInoY2ncoqgpWfVgiLEPlOKn+VxqE2M9987qBB6hw46/a5YQPwioFlXRau6fgEZmK+
         ykEuvdoRSUbI5zHiH2fUGKHGlDAjOtq0uorx3+0zDNxFLO/wJPOXjYYIOmKh/9bjKxtb
         B8iZm12sd8FnP+F/vBteIBy1jfKUbDPnAObZ0TNhBVAyDnx8U4Rci6b7g8F5Rruvvabj
         R4A6s82n9Qnnik2PJv/Iz0BVxENeJaCsR67yQuFldWC7qtC0FTrdKbL3ho6gf7rkjww3
         mB1g==
X-Gm-Message-State: AOJu0YyC1Djo0Ws5Lb9AzTRym4G6Nb/xYGCMZmD4T+vQJFhNcoStZYOU
	ieCpnCoNhVSDyyFa+K9pRBsSGje5hrksbA==
X-Google-Smtp-Source: AGHT+IFg9db6pgTgc/5mU2fD2mxnyagblX13ZEkvIYqZwKFnFAQFjti54b9AGj5C0uOFkEnmxMhkkquRt9cFBw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:15c4:b0:d7a:6a4c:b657 with SMTP
 id l4-20020a05690215c400b00d7a6a4cb657mr110798ybu.0.1695354146888; Thu, 21
 Sep 2023 20:42:26 -0700 (PDT)
Date: Fri, 22 Sep 2023 03:42:15 +0000
In-Reply-To: <20230922034221.2471544-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230922034221.2471544-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922034221.2471544-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/8] inet: implement lockless IP_MTU_DISCOVER
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

inet->pmtudisc can be read locklessly.

Implement proper lockless reads and writes to inet->pmtudisc

ip_sock_set_mtu_discover() can now be called from arbitrary
contexts.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/net/ip.h                | 13 ++++++++-----
 net/ipv4/ip_output.c            |  7 ++++---
 net/ipv4/ip_sockglue.c          | 17 ++++++-----------
 net/ipv4/ping.c                 |  2 +-
 net/ipv4/raw.c                  |  2 +-
 net/ipv4/udp.c                  |  2 +-
 net/netfilter/ipvs/ip_vs_sync.c |  2 +-
 7 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 3489a1cca5e7bc315ba646f6bc125b2b6ded9416..46933a0d98eac2db40c2e88006125588b8f8143e 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -434,19 +434,22 @@ int ip_dont_fragment(const struct sock *sk, const struct dst_entry *dst)
 
 static inline bool ip_sk_accept_pmtu(const struct sock *sk)
 {
-	return inet_sk(sk)->pmtudisc != IP_PMTUDISC_INTERFACE &&
-	       inet_sk(sk)->pmtudisc != IP_PMTUDISC_OMIT;
+	u8 pmtudisc = READ_ONCE(inet_sk(sk)->pmtudisc);
+
+	return pmtudisc != IP_PMTUDISC_INTERFACE &&
+	       pmtudisc != IP_PMTUDISC_OMIT;
 }
 
 static inline bool ip_sk_use_pmtu(const struct sock *sk)
 {
-	return inet_sk(sk)->pmtudisc < IP_PMTUDISC_PROBE;
+	return READ_ONCE(inet_sk(sk)->pmtudisc) < IP_PMTUDISC_PROBE;
 }
 
 static inline bool ip_sk_ignore_df(const struct sock *sk)
 {
-	return inet_sk(sk)->pmtudisc < IP_PMTUDISC_DO ||
-	       inet_sk(sk)->pmtudisc == IP_PMTUDISC_OMIT;
+	u8 pmtudisc = READ_ONCE(inet_sk(sk)->pmtudisc);
+
+	return pmtudisc < IP_PMTUDISC_DO || pmtudisc == IP_PMTUDISC_OMIT;
 }
 
 static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index adad16f1e872ce20941a087b3965fdb040868d4e..2be281f184a5fe5a695ccd51fabe69fa45bea0b8 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1387,8 +1387,8 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	struct ip_options *opt = NULL;
 	struct rtable *rt = (struct rtable *)cork->dst;
 	struct iphdr *iph;
+	u8 pmtudisc, ttl;
 	__be16 df = 0;
-	__u8 ttl;
 
 	skb = __skb_dequeue(queue);
 	if (!skb)
@@ -1418,8 +1418,9 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	/* DF bit is set when we want to see DF on outgoing frames.
 	 * If ignore_df is set too, we still allow to fragment this frame
 	 * locally. */
-	if (inet->pmtudisc == IP_PMTUDISC_DO ||
-	    inet->pmtudisc == IP_PMTUDISC_PROBE ||
+	pmtudisc = READ_ONCE(inet->pmtudisc);
+	if (pmtudisc == IP_PMTUDISC_DO ||
+	    pmtudisc == IP_PMTUDISC_PROBE ||
 	    (skb->len <= dst_mtu(&rt->dst) &&
 	     ip_dont_fragment(sk, &rt->dst)))
 		df = htons(IP_DF);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 4ad3003378ae6b186513000264f77b54a7babe6d..6d874cc03c8b4e88d79ebc50a6db105606b6ae60 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -622,9 +622,7 @@ int ip_sock_set_mtu_discover(struct sock *sk, int val)
 {
 	if (val < IP_PMTUDISC_DONT || val > IP_PMTUDISC_OMIT)
 		return -EINVAL;
-	lock_sock(sk);
-	inet_sk(sk)->pmtudisc = val;
-	release_sock(sk);
+	WRITE_ONCE(inet_sk(sk)->pmtudisc, val);
 	return 0;
 }
 EXPORT_SYMBOL(ip_sock_set_mtu_discover);
@@ -1050,6 +1048,8 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		WRITE_ONCE(inet->mc_ttl, val);
 		return 0;
+	case IP_MTU_DISCOVER:
+		return ip_sock_set_mtu_discover(sk, val);
 	}
 
 	err = 0;
@@ -1107,11 +1107,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 	case IP_TOS:	/* This sets both TOS and Precedence */
 		__ip_sock_set_tos(sk, val);
 		break;
-	case IP_MTU_DISCOVER:
-		if (val < IP_PMTUDISC_DONT || val > IP_PMTUDISC_OMIT)
-			goto e_inval;
-		inet->pmtudisc = val;
-		break;
 	case IP_UNICAST_IF:
 	{
 		struct net_device *dev = NULL;
@@ -1595,6 +1590,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_MULTICAST_TTL:
 		val = READ_ONCE(inet->mc_ttl);
 		goto copyval;
+	case IP_MTU_DISCOVER:
+		val = READ_ONCE(inet->pmtudisc);
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1634,9 +1632,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_TOS:
 		val = inet->tos;
 		break;
-	case IP_MTU_DISCOVER:
-		val = inet->pmtudisc;
-		break;
 	case IP_MTU:
 	{
 		struct dst_entry *dst;
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 4dd809b7b18867154df42bc28809b886913e253c..50d12b0c8d46fdcd9b448c3ebc90395ebf426075 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -551,7 +551,7 @@ void ping_err(struct sk_buff *skb, int offset, u32 info)
 		case ICMP_DEST_UNREACH:
 			if (code == ICMP_FRAG_NEEDED) { /* Path MTU discovery */
 				ipv4_sk_update_pmtu(skb, sk, info);
-				if (inet_sock->pmtudisc != IP_PMTUDISC_DONT) {
+				if (READ_ONCE(inet_sock->pmtudisc) != IP_PMTUDISC_DONT) {
 					err = EMSGSIZE;
 					harderr = 1;
 					break;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 4b5db5d1edc279df1fd7412af2845a7a79c95ec8..ade1aecd7c71184d753a28a67bc9b30087247db4 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -239,7 +239,7 @@ static void raw_err(struct sock *sk, struct sk_buff *skb, u32 info)
 		if (code > NR_ICMP_UNREACH)
 			break;
 		if (code == ICMP_FRAG_NEEDED) {
-			harderr = inet->pmtudisc != IP_PMTUDISC_DONT;
+			harderr = READ_ONCE(inet->pmtudisc) != IP_PMTUDISC_DONT;
 			err = EMSGSIZE;
 		} else {
 			err = icmp_err_convert[code].errno;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c3ff984b63547daf0ecfb4ab96956aee2f8d589d..731a723dc80816f0b5b0803d7397f7e9e8cd8b09 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -750,7 +750,7 @@ int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
 	case ICMP_DEST_UNREACH:
 		if (code == ICMP_FRAG_NEEDED) { /* Path MTU discovery */
 			ipv4_sk_update_pmtu(skb, sk, info);
-			if (inet->pmtudisc != IP_PMTUDISC_DONT) {
+			if (READ_ONCE(inet->pmtudisc) != IP_PMTUDISC_DONT) {
 				err = EMSGSIZE;
 				harderr = 1;
 				break;
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 3eed1670224888acf639cff06537ddf2505461bb..4f6c795588fbdbf084154025b8172e0fd2ea7384 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1335,7 +1335,7 @@ static void set_mcast_pmtudisc(struct sock *sk, int val)
 
 	/* setsockopt(sock, SOL_IP, IP_MTU_DISCOVER, &val, sizeof(val)); */
 	lock_sock(sk);
-	inet->pmtudisc = val;
+	WRITE_ONCE(inet->pmtudisc, val);
 #ifdef CONFIG_IP_VS_IPV6
 	if (sk->sk_family == AF_INET6) {
 		struct ipv6_pinfo *np = inet6_sk(sk);
-- 
2.42.0.515.g380fc7ccd1-goog


