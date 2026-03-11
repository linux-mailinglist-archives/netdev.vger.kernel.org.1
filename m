Return-Path: <netdev+bounces-266475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL0PJ/v7sGnCpQIAu9opvQ
	(envelope-from <netdev+bounces-266475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:22:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0568525C625
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE45831218C1
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E94E30ACE6;
	Wed, 11 Mar 2026 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QkJ9cfEr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EDB299A94
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206444; cv=none; b=P5aioHD+fAMzYuPtr2stOHK4VFCaIj+QLrAYIqnsl8bdgs8Ool0z4jz253ssfd3d5LfKAOuHGUA5vIpdHCO18HZYJ+BUh0kX7AOUdLZYS/G7gQftNwsMIwQochMkgnGMgfWhRskcjkKeQwIZC2lqKeEVSRI6ARyX9fqMPfXod7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206444; c=relaxed/simple;
	bh=x61s3hd5ifIBnvsdRT9h6QM0vJAmJZYtVxN/2QdhGCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hUEauV4cEL0H323ZT2MBfyHQbW6cspX9vD96M0bM8cqD1X1OZqQZo+fgJ2LRu7pBdyYNR4Ir1hVgbNG7K6TX92CgnnVg41+c+Lrv6uiPqAddr+wYawRh2D8LNG0xaB8cGne+3ZC7rpasifTq/LJqoWyMQzarC7SAMpAh3bo+j1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QkJ9cfEr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35986cc87a6so9403968a91.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773206442; x=1773811242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SHASvaFQjLosCRw4elQt3aiS9in3uftmElRvV7B/9UI=;
        b=QkJ9cfErC/L3gwYEjp8sY5k4ZXHqsQtw62qANWSd3IA0fowf3u5jwMSdz6jdj4IuW5
         aJCQyotBsHgrBbe89ny6wjcq/82tg5F+48hFDvq8p09JOO5Uam2TCIYoj7rGdU8Vw6j/
         /NnIFxm+WhipAsn3bpT5J/RBTEQEsCRm42obh5jltEizmsiJiOzXCuT4k7u3Pu3398hO
         opW2b2YaFOXX9sa4jnqFnm/dt7LCdgHx46ILmR9B8BBnMa6GbHpI4c6bnhAi7FJ6L12b
         WAcJ14NwE/vw8CmW8cnuMgbYogdgZPFfWc+OriKv+I4lbINWfzlwwE5LpB4iFFE3sg54
         BrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206442; x=1773811242;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHASvaFQjLosCRw4elQt3aiS9in3uftmElRvV7B/9UI=;
        b=cXVOh8anUZrg5ZMU7JEM/dwnfPunaPR19yB2tSipZ2sROTe9Hg3LRfJMoQE/7XYEFq
         3O71FN7js+7Jzc3n1knMpOWXM7s3axa4ln1XRRBqmg2UsQorndjWRV75FgP6hse+XwBP
         1UWn/6njxeF4iyBhrzjMbyHj4Jf9j+/V2LYyGUzEdkY4F2qp8APfF5qhD0CU4wk6rZ2v
         zTNGMmOWX9nmENE/+b3upvS6p5rx5pvV8/eXXvJRExNbwNFWeuf++xVB7FGcs/EpzeeC
         NMOYtDXhFPVcKyXNzeOOeHFpTmUAqey+9RrWnlOf3k6lf876DAbGuMw9tS6y15SoLd7x
         5zIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx8ZHEOozANNkUQwkVsH51wm1bO9slAnegPV3XGORUgXOML4r1hUvGL9K1svcnE9bIWwZEkoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcpcN350el19aWwtEBVfx6m+uXgoghH8Yq7xcupWLQUgQDqW9F
	WYMgi4EtA0Qpq76vFfFlfMmcuu2WCkl3KmpiM6YMvW/NTOJQohSwDIPSogc2yw3kT6CY5iisvHc
	li9X47g==
X-Received: from pjm15.prod.google.com ([2002:a17:90b:2fcf:b0:359:8cf1:f846])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17cb:b0:340:be44:dd0b
 with SMTP id 98e67ed59e1d1-35a019e8afbmr1356266a91.34.1773206442394; Tue, 10
 Mar 2026 22:20:42 -0700 (PDT)
Date: Wed, 11 Mar 2026 05:19:57 +0000
In-Reply-To: <20260311052020.1213705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311052020.1213705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311052020.1213705-11-kuniyu@google.com>
Subject: [PATCH v3 net-next 10/15] udp: Remove struct proto.h.udp_table.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0568525C625
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266475-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,strlen.de,google.com,gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Since UDP and UDP-Lite had dedicated socket hash tables for
each, we have had to fetch them from different pointers.

UDP always has its global or per-netns table in
net->ipv4.udp_table and struct proto.h.udp_table is NULL.

OTOH, UDP-Lite had only one global table in the pointer.

We no longer use the field.

Let's remove it and udp_get_table_prot().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
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
index d47ca721ef0d..a7ca727347ce 100644
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
 
@@ -3175,7 +3174,6 @@ struct proto udp_prot = {
 	.sysctl_wmem_offset	= offsetof(struct net, ipv4.sysctl_udp_wmem_min),
 	.sysctl_rmem_offset	= offsetof(struct net, ipv4.sysctl_udp_rmem_min),
 	.obj_size		= sizeof(struct udp_sock),
-	.h.udp_table		= NULL,
 	.diag_destroy		= udp_abort,
 };
 EXPORT_SYMBOL(udp_prot);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index c3d8b5ede164..5bddbf457b61 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1924,7 +1924,6 @@ struct proto udpv6_prot = {
 	.sysctl_rmem_offset     = offsetof(struct net, ipv4.sysctl_udp_rmem_min),
 	.obj_size		= sizeof(struct udp6_sock),
 	.ipv6_pinfo_offset = offsetof(struct udp6_sock, inet6),
-	.h.udp_table		= NULL,
 	.diag_destroy		= udp_abort,
 };
 
-- 
2.53.0.473.g4a7958ca14-goog


