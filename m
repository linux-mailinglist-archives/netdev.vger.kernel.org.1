Return-Path: <netdev+bounces-297913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kwB3HqoyKmrIjwMAu9opvQ
	(envelope-from <netdev+bounces-297913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 05:59:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA2A66E1A9
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 05:59:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b="Y/T9eeIl";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297913-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297913-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88FCC3055C0A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 03:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D903314B7;
	Thu, 11 Jun 2026 03:59:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C925A2BB;
	Thu, 11 Jun 2026 03:59:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150349; cv=none; b=EO/Fa0BNZVH/PcnYvBRGs4CGubiG7nlL9RRSde9jo+fr40YqSrQnjwzLMCA/ml36Rv0E1dxllb/WbvjUrcGXJ+Lvmtx8yVVPBFLBcDMkP6NuyIAI5/lTHiutfnASog6B5JJDeAIBPsSS4mprIw7ADM7mfqvTaF5vPQslTJk3/F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150349; c=relaxed/simple;
	bh=0c1biHXE2JVfF7C4Sk/Ryd7cx9+Z4ltauuZtj6sHRgI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DhbQMYtd5IkzdDTAKN33k4kHpVkpZCbohXHjvY4wjxT+y89AyZWTV9JXGhPWTdU9Mn0PT/KwGiRkIpjHkRhRaIZpdfnE0OnP1jW9Y6q9rQSykofECs1xL12q/6bITSmyDGXsGK32S3KHuXNQ+26SPfPa/Q+oMwcU+UXJnCHU6i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Y/T9eeIl; arc=none smtp.client-ip=45.254.49.198
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 41f0e5d6d;
	Thu, 11 Jun 2026 11:53:41 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	maze@google.com,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Runyu Xiao <runyu.xiao@seu.edu.cn>
Subject: [PATCH net v3] raw: annotate lockless match fields in raw_v4_match()
Date: Thu, 11 Jun 2026 11:53:18 +0800
Message-Id: <20260611035318.1091442-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eb4d0763c03a1kunmcd53f94414d5d5
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGBlMVh0aGUlJSB5KSU5JGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Y/T9eeIlrXKWjxmki4HajpgKU3S0U+O4qO/RrsQdQtgbKVedwqeAjSxkiMge0waUxG5zTmYLbN34mDpkGA0vZjznqoGw1Nl2eWmhR3yDPc7+GVdwQ7D4l21UVROWw5T2D5gygWUJLPnxrSeDIvmZkLZpqf83clCDyoy3h3proZA=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=d2RJFk+EYT38DLr2YOS+FWKWboEV0TPNsT/ueO1shyg=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297913-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:maze@google.com,m:kuniyu@google.com,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:runyu.xiao@seu.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BA2A66E1A9

raw_v4_match() is a lockless match helper under sk_for_each_rcu(). It
still reads inet->inet_daddr, inet->inet_rcv_saddr and
sk->sk_bound_dev_if with plain loads while bind, connect and disconnect
paths can update the same match fields concurrently.

Annotate only those mutable match fields in raw_v4_match(), and do so
at the point of use instead of hoisting the bound-device read before
the earlier short-circuit tests.

Also annotate the corresponding IPv4 writers so the read side matches
explicit WRITE_ONCE() updates when those same fields are modified.

Fixes: 0daf07e52709 ("raw: convert raw sockets to RCU")
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
v3:
- drop the inet_num annotation for raw sockets
- cover inet_daddr as well
- avoid hoisting sk_bound_dev_if into a temporary variable
- annotate the matching IPv4 writer paths

v2:
- note that inet_num and sk_bound_dev_if already have WRITE_ONCE() writers
- add WRITE_ONCE() in raw_bind() for inet_rcv_saddr
- previous version: https://lore.kernel.org/r/20260601073937.1137673-1-runyu.xiao@seu.edu.cn

 include/net/ip.h    |  3 ++-
 net/ipv4/datagram.c |  4 ++--
 net/ipv4/raw.c      | 23 ++++++++++++++++-------
 net/ipv4/udp.c      |  4 ++--
 4 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 7f2fe1a8401b..3902e8b58699 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -679,7 +679,8 @@ static inline void ip_ipgre_mc_map(__be32 naddr, const unsigned char *broadcast,
 
 static __inline__ void inet_reset_saddr(struct sock *sk)
 {
-	inet_sk(sk)->inet_rcv_saddr = inet_sk(sk)->inet_saddr = 0;
+	inet_sk(sk)->inet_saddr = 0;
+	WRITE_ONCE(inet_sk(sk)->inet_rcv_saddr, 0);
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family == PF_INET6) {
 		struct ipv6_pinfo *np = inet6_sk(sk);
diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
index 1614593b6d72..7d25519a6cdd 100644
--- a/net/ipv4/datagram.c
+++ b/net/ipv4/datagram.c
@@ -63,12 +63,12 @@ int __ip4_datagram_connect(struct sock *sk, struct sockaddr_unsized *uaddr, int
 	}
 
 	/* Update addresses before rehashing */
-	inet->inet_daddr = fl4->daddr;
+	WRITE_ONCE(inet->inet_daddr, fl4->daddr);
 	inet->inet_dport = usin->sin_port;
 	if (!inet->inet_saddr)
 		inet->inet_saddr = fl4->saddr;
 	if (!inet->inet_rcv_saddr) {
-		inet->inet_rcv_saddr = fl4->saddr;
+		WRITE_ONCE(inet->inet_rcv_saddr, fl4->saddr);
 		if (sk->sk_prot->rehash)
 			sk->sk_prot->rehash(sk);
 	}
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 5aaf9c62c8e1..dfb294b5c794 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -120,13 +120,21 @@ bool raw_v4_match(struct net *net, const struct sock *sk, unsigned short num,
 		  __be32 raddr, __be32 laddr, int dif, int sdif)
 {
 	const struct inet_sock *inet = inet_sk(sk);
+	__be32 daddr, rcv_saddr;
 
-	if (net_eq(sock_net(sk), net) && inet->inet_num == num	&&
-	    !(inet->inet_daddr && inet->inet_daddr != raddr) 	&&
-	    !(inet->inet_rcv_saddr && inet->inet_rcv_saddr != laddr) &&
-	    raw_sk_bound_dev_eq(net, sk->sk_bound_dev_if, dif, sdif))
-		return true;
-	return false;
+	if (!net_eq(sock_net(sk), net) || inet->inet_num != num)
+		return false;
+
+	daddr = READ_ONCE(inet->inet_daddr);
+	if (daddr && daddr != raddr)
+		return false;
+
+	rcv_saddr = READ_ONCE(inet->inet_rcv_saddr);
+	if (rcv_saddr && rcv_saddr != laddr)
+		return false;
+
+	return raw_sk_bound_dev_eq(net, READ_ONCE(sk->sk_bound_dev_if),
+				   dif, sdif);
 }
 EXPORT_SYMBOL_GPL(raw_v4_match);
 
@@ -724,7 +732,8 @@ static int raw_bind(struct sock *sk, struct sockaddr_unsized *uaddr,
 					 chk_addr_ret))
 		goto out;
 
-	inet->inet_rcv_saddr = inet->inet_saddr = addr->sin_addr.s_addr;
+	inet->inet_saddr = addr->sin_addr.s_addr;
+	WRITE_ONCE(inet->inet_rcv_saddr, addr->sin_addr.s_addr);
 	if (chk_addr_ret == RTN_MULTICAST || chk_addr_ret == RTN_BROADCAST)
 		inet->inet_saddr = 0;  /* Use device */
 	sk_dst_reset(sk);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0ac2bf4f8759..5d3e07f3ac27 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2156,10 +2156,10 @@ int __udp_disconnect(struct sock *sk, int flags)
 	 */
 
 	sk->sk_state = TCP_CLOSE;
-	inet->inet_daddr = 0;
+	WRITE_ONCE(inet->inet_daddr, 0);
 	inet->inet_dport = 0;
 	sock_rps_reset_rxhash(sk);
-	sk->sk_bound_dev_if = 0;
+	WRITE_ONCE(sk->sk_bound_dev_if, 0);
 	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK)) {
 		inet_reset_saddr(sk);
 		if (sk->sk_prot->rehash &&
-- 
2.34.1

