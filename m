Return-Path: <netdev+bounces-264022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ6cDdeIqGn2vQAAu9opvQ
	(envelope-from <netdev+bounces-264022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:32:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A037C2071E0
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C3B6303E3B5
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 19:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C7D3DFC65;
	Wed,  4 Mar 2026 19:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dXkBVEPW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784B03DEAC8
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652655; cv=none; b=Y3bUXaHObFVgs6nG5C3lu00lHr4py5gdjvqBv+uuVdJhQad7S843m3Yd3LvuufNcBp+KKE4Xh3Uz3GtxuyvLO/j4iHEDV71awdWzI5e5OAN/FcUMceSdXTfqpj86lFc9/AdZChqWjvw3geNfxTnh0dPceKj/cOdvPezSM+a0pDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652655; c=relaxed/simple;
	bh=0A0XgumOM/8wVzdPzJKBzjeYXjB1iEyGHEFoQ8j7LIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HnIy7mTUpKEWFOJdKFM23akRONRymXvNKt+cR+IYus37MzJk7ixK2rUAcXINgA94MOKpTcZivCWnjg9wsaXN1eSeUoV0qP8c8Q5OBlTRlxjkW/tqG55WQpHgtdJQw0vwyDo0Gk8ZlWYr3o/jmPp0xzrAR4pP1zbsgcYHn3KsFDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dXkBVEPW; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae4f27033cso35771795ad.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 11:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772652654; x=1773257454; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GvBb3JMRu50XoNRPg6A47Sqi8itOVdNn7XmQUKceWqA=;
        b=dXkBVEPWYu57CkPv6xgUXQFtva9/Q63hAetiKKY4cnpu3Av3Jqxq+gFxyILZG1C77j
         053oPSwVDtOrIG+oSBRS/hTC4igiGsDYHUlooNH9suThUVb6o1ueD1qbKnp1Rg2feZnh
         lbm2yL3A1/3kYpKRMnFcpwTtzijgq+XpJc4eBoz6qDqsgpr7IpnkK1ZCI0V+tJpAeQnB
         bHot/MXGU7IPiJ+LlHHTEKLtkpgdfjjuhv7mkiZ/hlWTXEmE0P2lkISj9rqoZHQRpnyg
         VeS26FscGqPJgIULSzgUdOJqvAOICd4d+o397M91pkqncT/mClX9+BI7eQvd9YWDFw6h
         ZELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652654; x=1773257454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvBb3JMRu50XoNRPg6A47Sqi8itOVdNn7XmQUKceWqA=;
        b=J9/1kK9YvQ/XYRENLljPcqPI3ybJdsLO69VpamB2TbRr+4bxgrYRjgD63baE/HhkcB
         0kI5QEyoT8ghTpzuzFLtbXxVTZ88O8fdubY5rGNwcTYPt2sQC21wupNlhGm5RgvMSGVe
         V8IJj25qmCht2LkAg5MTrwDnMNHtR2vOqkUcJ8SnwOm1RJ9BHz2KdiDLPnF1/vNfsP8r
         z7I6AJ4tmR6TgqqI7LzaCnOUwh9/jnW5yhzZXQ6zgEpZKSeK6tmmqVCT2TDw0bljTktO
         78A5By6aPM4/XUgANZOP1onkDPiXdNuE7DVBLZDyCeN2EQWdy5eNt4Xm6HykH9a8rmR6
         ChWA==
X-Forwarded-Encrypted: i=1; AJvYcCVT6JhXUhWOq0FrrS/GB6b99KMFqvu+4MY7EqPs8Ly7TrcpEe26sL4rHJ3b/EQeL1njYqjigws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuSMRbMunyh+8fS5GSRbwV5qGab5N64+Djf7wa3USybBk/sEvQ
	k2Qa6vswPLsjonD88TxQe/QqVr9wXAGsatm1GhPz1s23Hrnmu5PJlrhNm6w+pqw/7ueD2zYzIgo
	FSxWM/Q==
X-Received: from pjbch13.prod.google.com ([2002:a17:90a:f40d:b0:359:95ec:5a3b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3bc7:b0:340:bc27:97bd
 with SMTP id 98e67ed59e1d1-359a69c7960mr2895710a91.9.1772652653699; Wed, 04
 Mar 2026 11:30:53 -0800 (PST)
Date: Wed,  4 Mar 2026 19:28:41 +0000
In-Reply-To: <20260304193034.1870586-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260304193034.1870586-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304193034.1870586-11-kuniyu@google.com>
Subject: [PATCH v1 net-next 10/15] udp: Remove struct proto.h.udp_table.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A037C2071E0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264022-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Since UDP and UDP-Lite had dedicated socket hash tables for
each, we have had to fetch them from different pointers.

UDP always has its global or per-netns table in
net->ipv4.udp_table and struct proto.h.udp_table is NULL.

OTOH, UDP-Lite had only one global table in the pointer.

We no longer use the field.

Let's remove it and udp_get_table_prot().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h |  1 -
 net/ipv4/udp.c     | 26 ++++++++++++--------------
 net/ipv6/udp.c     |  1 -
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 16a1b8895206..7d51ac9e7d9a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1392,7 +1392,6 @@ struct proto {
 
 	union {
 		struct inet_hashinfo	*hashinfo;
-		struct udp_table	*udp_table;
 		struct raw_hashinfo	*raw_hash;
 		struct smc_hashinfo	*smc_hash;
 	} h;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 4174a302eeea..de8d55a9ea5d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -134,11 +134,6 @@ EXPORT_PER_CPU_SYMBOL_GPL(udp_memory_per_cpu_fw_alloc);
 #define MAX_UDP_PORTS 65536
 #define PORTS_PER_CHAIN (MAX_UDP_PORTS / UDP_HTABLE_SIZE_MIN_PERNET)
 
-static struct udp_table *udp_get_table_prot(struct sock *sk)
-{
-	return sk->sk_prot->h.udp_table ? : sock_net(sk)->ipv4.udp_table;
-}
-
 static int udp_lib_lport_inuse(struct net *net, __u16 num,
 			       const struct udp_hslot *hslot,
 			       unsigned long *bitmap,
@@ -240,11 +235,13 @@ static int udp_reuseport_add_sock(struct sock *sk, struct udp_hslot *hslot)
 int udp_lib_get_port(struct sock *sk, unsigned short snum,
 		     unsigned int hash2_nulladdr)
 {
-	struct udp_table *udptable = udp_get_table_prot(sk);
 	struct udp_hslot *hslot, *hslot2;
 	struct net *net = sock_net(sk);
+	struct udp_table *udptable;
 	int error = -EADDRINUSE;
 
+	udptable = net->ipv4.udp_table;
+
 	if (!snum) {
 		DECLARE_BITMAP(bitmap, PORTS_PER_CHAIN);
 		unsigned short first, last;
@@ -2224,12 +2221,13 @@ EXPORT_IPV6_MOD(udp_disconnect);
 void udp_lib_unhash(struct sock *sk)
 {
 	if (sk_hashed(sk)) {
-		struct udp_table *udptable = udp_get_table_prot(sk);
 		struct udp_hslot *hslot, *hslot2;
+		struct net *net = sock_net(sk);
+		struct udp_table *udptable;
 
 		sock_rps_delete_flow(sk);
-		hslot  = udp_hashslot(udptable, sock_net(sk),
-				      udp_sk(sk)->udp_port_hash);
+		udptable = net->ipv4.udp_table;
+		hslot  = udp_hashslot(udptable, net, udp_sk(sk)->udp_port_hash);
 		hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
 
 		spin_lock_bh(&hslot->lock);
@@ -2238,7 +2236,7 @@ void udp_lib_unhash(struct sock *sk)
 		if (sk_del_node_init_rcu(sk)) {
 			hslot->count--;
 			inet_sk(sk)->inet_num = 0;
-			sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+			sock_prot_inuse_add(net, sk->sk_prot, -1);
 
 			spin_lock(&hslot2->lock);
 			hlist_del_init_rcu(&udp_sk(sk)->udp_portaddr_node);
@@ -2258,11 +2256,12 @@ EXPORT_IPV6_MOD(udp_lib_unhash);
 void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 {
 	if (sk_hashed(sk)) {
-		struct udp_table *udptable = udp_get_table_prot(sk);
 		struct udp_hslot *hslot, *hslot2, *nhslot2;
+		struct net *net = sock_net(sk);
+		struct udp_table *udptable;
 
-		hslot = udp_hashslot(udptable, sock_net(sk),
-				     udp_sk(sk)->udp_port_hash);
+		udptable = net->ipv4.udp_table;
+		hslot = udp_hashslot(udptable, net, udp_sk(sk)->udp_port_hash);
 		hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
 		nhslot2 = udp_hashslot2(udptable, newhash);
 		udp_sk(sk)->udp_portaddr_hash = newhash;
@@ -3168,7 +3167,6 @@ struct proto udp_prot = {
 	.sysctl_wmem_offset	= offsetof(struct net, ipv4.sysctl_udp_wmem_min),
 	.sysctl_rmem_offset	= offsetof(struct net, ipv4.sysctl_udp_rmem_min),
 	.obj_size		= sizeof(struct udp_sock),
-	.h.udp_table		= NULL,
 	.diag_destroy		= udp_abort,
 };
 EXPORT_SYMBOL(udp_prot);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 49c315d0154d..abbea5bcbd6f 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1925,7 +1925,6 @@ struct proto udpv6_prot = {
 	.sysctl_rmem_offset     = offsetof(struct net, ipv4.sysctl_udp_rmem_min),
 	.obj_size		= sizeof(struct udp6_sock),
 	.ipv6_pinfo_offset = offsetof(struct udp6_sock, inet6),
-	.h.udp_table		= NULL,
 	.diag_destroy		= udp_abort,
 };
 
-- 
2.53.0.473.g4a7958ca14-goog


