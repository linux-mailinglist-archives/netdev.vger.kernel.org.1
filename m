Return-Path: <netdev+bounces-258853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC9WOxXrkmlSzwEAu9opvQ
	(envelope-from <netdev+bounces-258853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 11:01:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 968031422F2
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 11:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FBA53010243
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429AF21ADB7;
	Mon, 16 Feb 2026 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yh5e5VnX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF590271A9A
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771236114; cv=none; b=oYQWfOMO8xyrYTbE0aNruX5KdcnMybrhMuDM5lwK8L/ab5/jsysUMlwu42vrdHR9vS6BQ7B8YeUOS1vWftAAx+1pIzcx6+pyA2qVfA8y9h8LmPp6kAXYny8NwFhjOXYVHduLV7WQA7irOZ5UG3Kn2wNGb7WiBAqm1MqPp6NLzSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771236114; c=relaxed/simple;
	bh=yM91/vg5TBPG25eNJFh6HyzpbT1euP9F1oKZjg/qo+I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YzjNh/+PldKjZAVwTdfnYdKlW9SJDq72IOPiNX+34W3JfmyqgjCh//722eoxl5dWBMBULN4ZlWVtMvBEOQxMbokZPUvFcS1GdhoE6hk/yNTZRXFi3u52Mmf+5E9pxQ0x0qxZ+37yxC1Unyu5amzcKFDQCrmNyNnyK/oeeKUrgN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yh5e5VnX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-79631246ab3so43326357b3.1
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 02:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771236112; x=1771840912; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pModUnRgnljkNmq54G5HclIFSRt56xGs8Bv4YjgpWJU=;
        b=yh5e5VnXegjNY6o99tMxq03q9GXnEJdSH7pPI2ysyYJ9teUIx1sgAMgeYhYswZYMBf
         fmVDlukms/Uly5NpksssoJcp1UrI0yCUngMTwXLDFQpNv6TbY2oAxQFUzyhrZSvEX6Hn
         VhZaJrRrxil6KA7/zn/Figzk9zP4lix0A0eynSJYscQFpTcIvaEhU8ZzdRfYIxwiE740
         7QDG+BAT7L+JqhvsheDf+uCyxAa4NJ76mZI1xSiGw65VrLWhNm/vXNFUGPdrJJXuAxIf
         SNZrRliPqBCMa/lTWU2QGIfn9AHTu/GpIqGcdSIiGL87hOFOwDVDmvDg+rktBOS6wJpR
         YnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771236112; x=1771840912;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pModUnRgnljkNmq54G5HclIFSRt56xGs8Bv4YjgpWJU=;
        b=N4phSDH+x6qe3gi3GDywibIBT6LsmgH7ylKsbXZLmy77+O34TyUqnJpsnPHaq+er7l
         VzKKrAqNVlBrNMYzESuvTGvX5nNFEoyGz/pTQHPGi/7fVbPRyR0mEoQYStZbkAJVM6SL
         OYrboyqlunGpiEnFCvBTdT2SuGkfk6Nj8ZJcGmCPUWO9khRYzsjlbcDjjoPyKmKLWHOZ
         6C+Ux7nV0fbkxunr+d425TU1EvftW5cDtgbSTCBhg23hu0y5AyjDccv5kpdXeh+KgN0L
         T2pog05El2vF2d8l+Z6llTIyepFY3jPnBC92dIrSyQOCdSS6aOySi85eLsqPjpUVV2pG
         WehQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb0J0CNe/g/G4qkeCt0lRjGYE0c8WQTCQJ4xdWK4faRS9ukWu/pxQTrMd5crHXGqe4uUFWW3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM/vm7DNaZelGvn1WCK3doje1qbUsGicJ8lv23Jpz/Pz3aU1MX
	bePNpV6RgOCrGUzqY4mO3dyCzD6Vt6WyOLeVuk6mqGrUZROhMIAqZZx69WPy3i4Jj/k3bE4bKse
	K1wC2i2Qd/XKclQ==
X-Received: from ywbfl8.prod.google.com ([2002:a05:690c:3388:b0:796:5cad:970a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:39c:b0:795:2233:9627 with SMTP id 00721157ae682-797a0cd58b7mr93007197b3.48.1771236111585;
 Mon, 16 Feb 2026 02:01:51 -0800 (PST)
Date: Mon, 16 Feb 2026 10:01:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260216100149.3319315-1-edumazet@google.com>
Subject: [PATCH net] ping: annotate data-races in ping_lookup()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258853-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 968031422F2
X-Rspamd-Action: no action

isk->inet_num, isk->inet_rcv_saddr and sk->sk_bound_dev_if
are read locklessly in ping_lookup().

Add READ_ONCE()/WRITE_ONCE() annotations.

The race on isk->inet_rcv_saddr is probably coming from IPv6 support,
but does not deserve a specific backport.

Fixes: dbca1596bbb0 ("ping: convert to RCU lookups, get rid of rwlock")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ping.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index ebfc5a3d3ad640980b53f67ac9041783a85228c0..71d5e17719debb14ca2400edcf5a2cc3153291c6 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -148,7 +148,7 @@ void ping_unhash(struct sock *sk)
 	pr_debug("ping_unhash(isk=%p,isk->num=%u)\n", isk, isk->inet_num);
 	spin_lock(&ping_table.lock);
 	if (sk_del_node_init_rcu(sk)) {
-		isk->inet_num = 0;
+		WRITE_ONCE(isk->inet_num, 0);
 		isk->inet_sport = 0;
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 	}
@@ -181,31 +181,35 @@ static struct sock *ping_lookup(struct net *net, struct sk_buff *skb, u16 ident)
 	}
 
 	sk_for_each_rcu(sk, hslot) {
+		int bound_dev_if;
+
 		if (!net_eq(sock_net(sk), net))
 			continue;
 		isk = inet_sk(sk);
 
 		pr_debug("iterate\n");
-		if (isk->inet_num != ident)
+		if (READ_ONCE(isk->inet_num) != ident)
 			continue;
 
+		bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
 		if (skb->protocol == htons(ETH_P_IP) &&
 		    sk->sk_family == AF_INET) {
+			__be32 rcv_saddr = READ_ONCE(isk->inet_rcv_saddr);
+
 			pr_debug("found: %p: num=%d, daddr=%pI4, dif=%d\n", sk,
-				 (int) isk->inet_num, &isk->inet_rcv_saddr,
-				 sk->sk_bound_dev_if);
+				 ident, &rcv_saddr,
+				 bound_dev_if);
 
-			if (isk->inet_rcv_saddr &&
-			    isk->inet_rcv_saddr != ip_hdr(skb)->daddr)
+			if (rcv_saddr && rcv_saddr != ip_hdr(skb)->daddr)
 				continue;
 #if IS_ENABLED(CONFIG_IPV6)
 		} else if (skb->protocol == htons(ETH_P_IPV6) &&
 			   sk->sk_family == AF_INET6) {
 
 			pr_debug("found: %p: num=%d, daddr=%pI6c, dif=%d\n", sk,
-				 (int) isk->inet_num,
+				 ident,
 				 &sk->sk_v6_rcv_saddr,
-				 sk->sk_bound_dev_if);
+				 bound_dev_if);
 
 			if (!ipv6_addr_any(&sk->sk_v6_rcv_saddr) &&
 			    !ipv6_addr_equal(&sk->sk_v6_rcv_saddr,
@@ -216,8 +220,8 @@ static struct sock *ping_lookup(struct net *net, struct sk_buff *skb, u16 ident)
 			continue;
 		}
 
-		if (sk->sk_bound_dev_if && sk->sk_bound_dev_if != dif &&
-		    sk->sk_bound_dev_if != sdif)
+		if (bound_dev_if && bound_dev_if != dif &&
+		    bound_dev_if != sdif)
 			continue;
 
 		goto exit;
@@ -392,7 +396,9 @@ static void ping_set_saddr(struct sock *sk, struct sockaddr_unsized *saddr)
 	if (saddr->sa_family == AF_INET) {
 		struct inet_sock *isk = inet_sk(sk);
 		struct sockaddr_in *addr = (struct sockaddr_in *) saddr;
-		isk->inet_rcv_saddr = isk->inet_saddr = addr->sin_addr.s_addr;
+
+		isk->inet_saddr = addr->sin_addr.s_addr;
+		WRITE_ONCE(isk->inet_rcv_saddr, addr->sin_addr.s_addr);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (saddr->sa_family == AF_INET6) {
 		struct sockaddr_in6 *addr = (struct sockaddr_in6 *) saddr;
@@ -850,7 +856,8 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 	struct sk_buff *skb;
 	int copied, err;
 
-	pr_debug("ping_recvmsg(sk=%p,sk->num=%u)\n", isk, isk->inet_num);
+	pr_debug("ping_recvmsg(sk=%p,sk->num=%u)\n", isk,
+		 READ_ONCE(isk->inet_num));
 
 	err = -EOPNOTSUPP;
 	if (flags & MSG_OOB)
-- 
2.53.0.310.g728cabbaf7-goog


