Return-Path: <netdev+bounces-257633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNgLH28mhmlSKAQAu9opvQ
	(envelope-from <netdev+bounces-257633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:35:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E81410123A
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47F733013967
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 17:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3486D423A8E;
	Fri,  6 Feb 2026 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFPihMqF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E069242669A
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399290; cv=none; b=PxXex9pipMSzrXtMhHEvjomxz3yhymAVjfBVrrJsX4ohidctCu3SDItM2DOgHRnjRkH8fupd/T+XZt3l8pafvGNHt0eY+X5C4YvLwATuDRs+TA9gGFaeNJCJD1VhcKq5oYaj9HeWkWI9cC6qqhNsvHHfxx1SMWx/vOFYBHJjVQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399290; c=relaxed/simple;
	bh=udxaCcIPaguzwVfkzUb7hZLMrpzXKIP/DnRmjC1R7iY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dVmBluuyPvzRdH0m/yLLMtyOe5HhlkwbEbD2vm1TQzyq/MBRYgDIWBGhu6jmmkiar0/Qhy+CbgRU3B3u5tc5CGksFsc2DzHvt0dF+xE1+7qyc2X22ZeZ55I3z/v1pegGk7tNnpyq7V19jkuaFEzAleJoBfpl5vE7Ry04P0HI9p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bFPihMqF; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c70b4b53e4so349227285a.1
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 09:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770399289; x=1771004089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1RpNDij1xxD2Q39jpe3AmZbZeSuelV9wAzBpY2ikYg4=;
        b=bFPihMqFGi/PrLSevkz+IgCZXy1M4t89dAiz+n1AYLyzpi7+SuskshSgY1u3YYMUkk
         OvyPODI5sBNUxLowMTpf5w6curZLGItrs3UmwWuBf0laB2S2ip8DaQUw1upeyPAFEMTW
         pCEMvpSipaLAYFr/jc6r81drDn5BjFVyYiSYE0UOtv+Td4vJuHxu5pQzwYRCYfoiPB3s
         xM+WWjVA0SYsOicbrT/9hgEdvBs6GXCAEIYw1QzrnPT25iaZpj9TialrHilZJSrEotHh
         Cq2nLHsHxfs1Z41oUp0a3g5kA/vvCl3A6A1r1yqz3HSQKrTVI/6kVybyREMS0DjbhfLn
         Dh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399289; x=1771004089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RpNDij1xxD2Q39jpe3AmZbZeSuelV9wAzBpY2ikYg4=;
        b=ZVfcOLoVYwMhHUM3K+FSf/9Kz+Hh7BoLVgYEMzT8mupo/rjH/ikoBdWpLWjQsPvTbz
         s6sRpLjn6OJEF75TIwp7ylFe0kOuq4kfG8Xv54EyZHYE1A2QdiPpaBSOjZY9DqmZFol6
         mryK1uppnrGQbdn2ktmylLXRs01OKRN1iho3I8v6OZ6kfV5MFbDDRavdvwNJ2zVAu4Fi
         2u2nrN9EDGlL06jr6STCbqPtOTyKHloUQKRP3N7GQP5vK0z52ELXoLF8ppiCNmJLaQW1
         ModyH9y98JwQXwnAxk2/ux7x509cJ3maJjq4ov4ibDFCKoPdlmDzzrggmeI7gYV0zoNW
         UpFA==
X-Forwarded-Encrypted: i=1; AJvYcCVYv1OwsCt9mK/rWZRRr5U6GnZuRVekAFUBsCyu/ZWY4MuEYe0s7sfvbY7tGaWVUviLrAMeBOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO1FHJ8E/4niEu+gLAlDwSmE4pYVJFPuCplj3c83uhgZyPAO6g
	xaNszCRACxofkLGH9O4axs+N1oRCIczSafO6LTka8Az1H3oViCpIZs5Yve5wmtzFSiDHOj/H1d1
	y38MNPXMyHcj5rQ==
X-Received: from qkbbp34.prod.google.com ([2002:a05:620a:45a2:b0:8c5:6c8b:7d92])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:218a:b0:8cb:65f:8429 with SMTP id af79cd13be357-8cb065f850amr75846685a.90.1770399288914;
 Fri, 06 Feb 2026 09:34:48 -0800 (PST)
Date: Fri,  6 Feb 2026 17:34:24 +0000
In-Reply-To: <20260206173426.1638518-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260206173426.1638518-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206173426.1638518-6-edumazet@google.com>
Subject: [PATCH net-next 5/7] tcp: populate inet->cork.fl.u.ip6 in tcp_v6_connect()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257633-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E81410123A
X-Rspamd-Action: no action

Instead of using private @fl6 and @final variables
use respectively inet->cork.fl.u.ip6 and np->final.

As explained in commit 85d05e281712 ("ipv6: change inet6_sk_rebuild_header()
to use inet->cork.fl.u.ip6"):

TCP v6 spends a good amount of time rebuilding a fresh fl6 at each
transmit in inet6_csk_xmit()/inet6_csk_route_socket().

TCP v4 caches the information in inet->cork.fl.u.ip4 instead.

After this patch, active TCP ipv6 flows have correctly initialized
inet->cork.fl.u.ip6 structure.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/tcp_ipv6.c | 47 +++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index c65a5bfd322a1db5dc3fbc406e577f0ccb044c23..0fbcb39b3aa709e936a518865e2d16c4027081dd 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -138,15 +138,15 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 {
 	struct sockaddr_in6 *usin = (struct sockaddr_in6 *) uaddr;
 	struct inet_connection_sock *icsk = inet_csk(sk);
-	struct in6_addr *saddr = NULL, *final_p, final;
 	struct inet_timewait_death_row *tcp_death_row;
 	struct ipv6_pinfo *np = tcp_inet6_sk(sk);
+	struct in6_addr *saddr = NULL, *final_p;
 	struct inet_sock *inet = inet_sk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct net *net = sock_net(sk);
 	struct ipv6_txoptions *opt;
 	struct dst_entry *dst;
-	struct flowi6 fl6;
+	struct flowi6 *fl6;
 	int addr_type;
 	int err;
 
@@ -156,14 +156,15 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	if (usin->sin6_family != AF_INET6)
 		return -EAFNOSUPPORT;
 
-	memset(&fl6, 0, sizeof(fl6));
+	fl6 = &inet_sk(sk)->cork.fl.u.ip6;
+	memset(fl6, 0, sizeof(*fl6));
 
 	if (inet6_test_bit(SNDFLOW, sk)) {
-		fl6.flowlabel = usin->sin6_flowinfo&IPV6_FLOWINFO_MASK;
-		IP6_ECN_flow_init(fl6.flowlabel);
-		if (fl6.flowlabel&IPV6_FLOWLABEL_MASK) {
+		fl6->flowlabel = usin->sin6_flowinfo & IPV6_FLOWINFO_MASK;
+		IP6_ECN_flow_init(fl6->flowlabel);
+		if (fl6->flowlabel & IPV6_FLOWLABEL_MASK) {
 			struct ip6_flowlabel *flowlabel;
-			flowlabel = fl6_sock_lookup(sk, fl6.flowlabel);
+			flowlabel = fl6_sock_lookup(sk, fl6->flowlabel);
 			if (IS_ERR(flowlabel))
 				return -EINVAL;
 			fl6_sock_release(flowlabel);
@@ -212,7 +213,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	}
 
 	sk->sk_v6_daddr = usin->sin6_addr;
-	np->flow_label = fl6.flowlabel;
+	np->flow_label = fl6->flowlabel;
 
 	/*
 	 *	TCP over IPv4
@@ -260,24 +261,24 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	if (!ipv6_addr_any(&sk->sk_v6_rcv_saddr))
 		saddr = &sk->sk_v6_rcv_saddr;
 
-	fl6.flowi6_proto = IPPROTO_TCP;
-	fl6.daddr = sk->sk_v6_daddr;
-	fl6.saddr = saddr ? *saddr : np->saddr;
-	fl6.flowlabel = ip6_make_flowinfo(np->tclass, np->flow_label);
-	fl6.flowi6_oif = sk->sk_bound_dev_if;
-	fl6.flowi6_mark = sk->sk_mark;
-	fl6.fl6_dport = usin->sin6_port;
-	fl6.fl6_sport = inet->inet_sport;
-	if (IS_ENABLED(CONFIG_IP_ROUTE_MULTIPATH) && !fl6.fl6_sport)
-		fl6.flowi6_flags = FLOWI_FLAG_ANY_SPORT;
-	fl6.flowi6_uid = sk_uid(sk);
+	fl6->flowi6_proto = IPPROTO_TCP;
+	fl6->daddr = sk->sk_v6_daddr;
+	fl6->saddr = saddr ? *saddr : np->saddr;
+	fl6->flowlabel = ip6_make_flowinfo(np->tclass, np->flow_label);
+	fl6->flowi6_oif = sk->sk_bound_dev_if;
+	fl6->flowi6_mark = sk->sk_mark;
+	fl6->fl6_dport = usin->sin6_port;
+	fl6->fl6_sport = inet->inet_sport;
+	if (IS_ENABLED(CONFIG_IP_ROUTE_MULTIPATH) && !fl6->fl6_sport)
+		fl6->flowi6_flags = FLOWI_FLAG_ANY_SPORT;
+	fl6->flowi6_uid = sk_uid(sk);
 
 	opt = rcu_dereference_protected(np->opt, lockdep_sock_is_held(sk));
-	final_p = fl6_update_dst(&fl6, opt, &final);
+	final_p = fl6_update_dst(fl6, opt, &np->final);
 
-	security_sk_classify_flow(sk, flowi6_to_flowi_common(&fl6));
+	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
-	dst = ip6_dst_lookup_flow(net, sk, &fl6, final_p);
+	dst = ip6_dst_lookup_flow(net, sk, fl6, final_p);
 	if (IS_ERR(dst)) {
 		err = PTR_ERR(dst);
 		goto failure;
@@ -287,7 +288,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	tcp_death_row = &sock_net(sk)->ipv4.tcp_death_row;
 
 	if (!saddr) {
-		saddr = &fl6.saddr;
+		saddr = &fl6->saddr;
 
 		err = inet_bhash2_update_saddr(sk, saddr, AF_INET6);
 		if (err)
-- 
2.53.0.rc2.204.g2597b5adb4-goog


