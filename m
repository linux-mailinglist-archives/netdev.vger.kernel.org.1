Return-Path: <netdev+bounces-264564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EKcDwL7qWlcJAEAu9opvQ
	(envelope-from <netdev+bounces-264564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:52:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBCF218ABC
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48386304F237
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 21:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C127B35F196;
	Thu,  5 Mar 2026 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VHq6Jplk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F78A35F8C9
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747437; cv=none; b=P5Oq3mg3+g5l2hNjlGZl/QwtxK13R8OtT5xbpG8dXkkqRhKzxDppMWOVvOowF3goy/1j0BTwdCCAUI3iwg14f2TLHj3WXUHlP2kMeWya8a3cdPO1PM2HoOkGFNKRBtK4wTKvSa75fKofpekS3jmuEyr4W0le+YRE8xXf7eipv+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747437; c=relaxed/simple;
	bh=cc9s2jYnZNvHkEWHtHr3XIDsnsN4T9IKteAIYyI7hjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uRbBwbCQwzGmJPhTtSYl6jsDUs0Zj2ZneYv4Jll5LeKTi6h9XwMe/ZcWqqT/f79i8koQn2vwEW+YNWGP8gWZF9zVrLz8xATfpdPjvXyRaqWndWchmnsk6YhB+ocYPKREoeSuE3RE2mAELjoZ/1nGLQLT0/LfNLMKUPEXxv1ietQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VHq6Jplk; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae5031c6b1so44445635ad.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 13:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772747436; x=1773352236; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SKUdJHalRWDdFJWXai/nJirwzPFb0G+e5QloZK0CtTw=;
        b=VHq6JplktoS/6ovZ8w7ddu+t50UkB9J5SWG1KCazTaU49pkO1mgFltDIgz4CEeaLoL
         iFV3xlx/XsP09ooThICHq1DZx01NZyiClW7zsOb/JSHQC1hU+C0YCCoq6i4//3jAw7By
         iYMXpnxTD98x0MdqutsuJm+AVDf8P8G4hA2oZe8p2Vpz+YxZ+BdxCZTsQiTZBzU3l0OQ
         Q7WpcRmj3nzehRRkAkpdGzkIGqwAU7tCO8+tbGA+WYG3+eCEO1PFu0KDa1Do9hlqaLsv
         ABe9fbr2txri8puHyUd0eDQlPp0Dynb8P0/NuaYtJVGC1KR1lshjTnGVIA6XLkgWCUyR
         xMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747436; x=1773352236;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKUdJHalRWDdFJWXai/nJirwzPFb0G+e5QloZK0CtTw=;
        b=w+ZMoS25Pq7ukOfxi1x/L3jGnM1Rg5LksH7x37MD2+1Ja9+NZqjqMP5R9g4gWMQSrW
         /o4BX/CiPJ230S7UXDlXyI/6PSlMsZJiMOzAmqbwQDqdGWI8TXYRPgRiqDz9/A2MkB3i
         QzOR4S+vxMb9sOJKidvOks5IVTYsq4MKeSmsofMwT/4Lc6aiAFZ3MxHoRchpNyevI+fh
         4g6/1HRBWs8+aYAl2o9aGvS6GYrG6llJj1szyFbUC+uLUuxlRxL9WiZ4S/S5pEF37PP5
         /8uzR6hCV+Cozi2EDtTTl+m31jXYefJd7Hw3kzo//kNqAE4Jyamu3bCBZxr1tIHj08SQ
         vFkA==
X-Forwarded-Encrypted: i=1; AJvYcCW2yp5M110yrbQyt9QXBYaJSItyBql6ReiDGr62gEkOln++J85S0OS4yeeW0yqhW2qPLwVmK8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzOXyBc2MmwtpNm60XGNO33d7/w/5EuguBEQP7BMs0gkZBzYab
	6PmUH0c4e7o0eZTNXzRQ5DpnRnqG2DW0rL1kieWSH6f+ssLbJQPw727cD+ZXKS7VFnPqZKhDqZc
	+JHM/qg==
X-Received: from pllk17.prod.google.com ([2002:a17:902:7611:b0:2ad:ad2a:b8f9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19e5:b0:2a7:cb46:706e
 with SMTP id d9443c01a7336-2ae8243227emr349155ad.35.1772747435667; Thu, 05
 Mar 2026 13:50:35 -0800 (PST)
Date: Thu,  5 Mar 2026 21:49:56 +0000
In-Reply-To: <20260305215013.2984628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305215013.2984628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305215013.2984628-11-kuniyu@google.com>
Subject: [PATCH v2 net-next 10/15] udp: Remove struct proto.h.udp_table.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: ABBCF218ABC
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
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264564-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,strlen.de,google.com,gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
index 99abcc1e690a..432b4c5e7ad4 100644
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


