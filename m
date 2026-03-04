Return-Path: <netdev+bounces-264025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK99APSIqGn2vQAAu9opvQ
	(envelope-from <netdev+bounces-264025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:33:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0CA2071E7
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C610304811E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 19:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D953DEAC8;
	Wed,  4 Mar 2026 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zomwpd0D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2986D3E0C4B
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652660; cv=none; b=cp/nbjOTu2loGI2Q8s6vUmvsENVQD1mIGMzdUXZ7qQSbgBpQyBi4XfYMOL7HUAoDXARjhl93Q89j01rCwwJfE1PUO7lpUlqS65rGZFtJcbGw9IRCAU+FAo6Vpimc35lWJJAshVZwVPFC7QFH21FcLE/qFByCyTZZHxaPEaPtrCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652660; c=relaxed/simple;
	bh=L1VO8HgQbp9cYt/mJ52qmN2JPQzBvkWpesdsD5gkkoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hDOfBbdKMGjN7q/T6GvbynRcGAj3rN+QmWaw4Lyrr7AyW4rO31eM1AuGQno0NpbvpyJHnpeAaqknu5/WFTHobRCnSbU0O3Mx+ht36onsb7wOlQQDJd4fu8Vi80h3CZI3fDlPaHe36UVzFNspEtbIGhL2XN7RfLQmRMzv2TDQlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zomwpd0D; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35449510446so6806311a91.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 11:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772652658; x=1773257458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yRGK7H4K6t1AF9zIeLRS2IxG5QGVOMQzvG97ud/jXRc=;
        b=Zomwpd0DLD2u4ifJA1jS/EIMIMCrvLmuRqn7zLJieJOxDDt4zupHK3dY3YQVtzZZhG
         gUVVcXgks73oC8+CX4i7+7TVmEcyHE0yXtNPaGuM5iyTRDYq93pmjBXfJAkcNcSGHMR5
         tTsHitKwiTc/VbX76fO6eJ5hjd7mGbGxXUYSDd5ix5B4rWmyLvp98DbH76Khtk7CHa7m
         cx77fXVV7OPETPvyY80Gzzm7gRQaRsSzmIzFBAtooxwJZtCR+9cTUP8QXBgK6JHz8IBF
         JzCy7u5+24lO79aXgzabGL8tpnzC0qTY6N1vRF7AN0eHUpYrb4oeC6Tu174LuHVrDErn
         KuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652658; x=1773257458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRGK7H4K6t1AF9zIeLRS2IxG5QGVOMQzvG97ud/jXRc=;
        b=Qehgh16TTuOdtwbWj/tB1OgbLbG8hsFY8pps/fLukwbUIMyPdIgwruRggzm/pyM0JV
         bO/xlEzCbpy/Blb4Clu59Snybunp+Z38UmQfuXtINaRVE8H084L1mQvaViHgh6ntYt+E
         7ON35VUAvph8Te18O9g1YEeLa9KACjGdomfllwymqRKzYh+3oglkSk2XG41JEWUMNWJ0
         GIy3T7vB2Hdu0bcOELcx71zPL3/CAzYEnksDAU52fymidzfByDSXU7kV8vio8BDhfvw0
         okqq//5Ec4gZYFU8c7v3X/zjFH0rgrYZDbc13BletXyNCVRYdDJv5Pm/Hz8ssyE2E7GH
         dl4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4KAlPFDdf6k+an1MRMLIaHAXnC/1nKIH31lMtQgmrALc3qAu8D892jTEUj83O/VJmVmBsWQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcYE2tpYo9/UOJOOPY5q8+HDpJuV4CgoioPg75LDQcYGRUp2uO
	Q6m8DuGlL6LL3soDub2Q8AiDCHrvOm2SVgW07Eb3H2SETYLnHW3e3qJ2Jv+mpJ4RijSm8XvsLL8
	MXmrMZg==
X-Received: from pjn15.prod.google.com ([2002:a17:90b:570f:b0:358:e8ed:94e4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d05:b0:359:8564:dc0e
 with SMTP id 98e67ed59e1d1-359a69adc32mr3131114a91.3.1772652658287; Wed, 04
 Mar 2026 11:30:58 -0800 (PST)
Date: Wed,  4 Mar 2026 19:28:44 +0000
In-Reply-To: <20260304193034.1870586-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260304193034.1870586-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304193034.1870586-14-kuniyu@google.com>
Subject: [PATCH v1 net-next 13/15] udp: Don't pass udptable to IPv6 socket
 lookup functions.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8E0CA2071E7
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
	TAGGED_FROM(0.00)[bounces-264025-lists,netdev=lfdr.de];
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
each, we have had to pass the pointer down to many socket
lookup functions.

UDP-Lite gone, and we do not need to do that.

Let's fetch net->ipv4.udp_table only where needed in IPv6
stack: __udp6_lib_lookup() and __udp6_lib_mcast_deliver().

__udp6_lib_err() is renamed to udpv6_err() as its wrapper
is no longer needed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/ipv6_stubs.h |  7 ++--
 include/net/udp.h        |  3 +-
 net/core/filter.c        |  3 +-
 net/ipv4/udp_diag.c      | 20 +++++-----
 net/ipv6/udp.c           | 82 ++++++++++++++++++----------------------
 net/ipv6/udp_offload.c   |  3 +-
 6 files changed, 53 insertions(+), 65 deletions(-)

diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
index d3013e721b14..907681cecde8 100644
--- a/include/net/ipv6_stubs.h
+++ b/include/net/ipv6_stubs.h
@@ -83,10 +83,9 @@ struct ipv6_bpf_stub {
 	int (*inet6_bind)(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
 			  u32 flags);
 	struct sock *(*udp6_lib_lookup)(const struct net *net,
-				     const struct in6_addr *saddr, __be16 sport,
-				     const struct in6_addr *daddr, __be16 dport,
-				     int dif, int sdif, struct udp_table *tbl,
-				     struct sk_buff *skb);
+					const struct in6_addr *saddr, __be16 sport,
+					const struct in6_addr *daddr, __be16 dport,
+					int dif, int sdif, struct sk_buff *skb);
 	int (*ipv6_setsockopt)(struct sock *sk, int level, int optname,
 			       sockptr_t optval, unsigned int optlen);
 	int (*ipv6_getsockopt)(struct sock *sk, int level, int optname,
diff --git a/include/net/udp.h b/include/net/udp.h
index 0279a2642c8f..e7409f2812e5 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -448,8 +448,7 @@ struct sock *udp6_lib_lookup(const struct net *net,
 struct sock *__udp6_lib_lookup(const struct net *net,
 			       const struct in6_addr *saddr, __be16 sport,
 			       const struct in6_addr *daddr, __be16 dport,
-			       int dif, int sdif, struct udp_table *tbl,
-			       struct sk_buff *skb);
+			       int dif, int sdif, struct sk_buff *skb);
 struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
 				 __be16 sport, __be16 dport);
 int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
diff --git a/net/core/filter.c b/net/core/filter.c
index 0d5d5a17acb2..7a3440d009a8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6895,8 +6895,7 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
 			sk = ipv6_bpf_stub->udp6_lib_lookup(net,
 							    src6, tuple->ipv6.sport,
 							    dst6, tuple->ipv6.dport,
-							    dif, sdif,
-							    net->ipv4.udp_table, NULL);
+							    dif, sdif, NULL);
 #endif
 	}
 
diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
index a010d05062a0..0899c60cce53 100644
--- a/net/ipv4/udp_diag.c
+++ b/net/ipv4/udp_diag.c
@@ -44,11 +44,11 @@ static int udp_dump_one(struct udp_table *tbl,
 #if IS_ENABLED(CONFIG_IPV6)
 	else if (req->sdiag_family == AF_INET6)
 		sk = __udp6_lib_lookup(net,
-				(struct in6_addr *)req->id.idiag_src,
-				req->id.idiag_sport,
-				(struct in6_addr *)req->id.idiag_dst,
-				req->id.idiag_dport,
-				req->id.idiag_if, 0, tbl, NULL);
+				       (struct in6_addr *)req->id.idiag_src,
+				       req->id.idiag_sport,
+				       (struct in6_addr *)req->id.idiag_dst,
+				       req->id.idiag_dport,
+				       req->id.idiag_if, 0, NULL);
 #endif
 	if (sk && !refcount_inc_not_zero(&sk->sk_refcnt))
 		sk = NULL;
@@ -185,11 +185,11 @@ static int __udp_diag_destroy(struct sk_buff *in_skb,
 
 		else
 			sk = __udp6_lib_lookup(net,
-					(struct in6_addr *)req->id.idiag_dst,
-					req->id.idiag_dport,
-					(struct in6_addr *)req->id.idiag_src,
-					req->id.idiag_sport,
-					req->id.idiag_if, 0, tbl, NULL);
+					       (struct in6_addr *)req->id.idiag_dst,
+					       req->id.idiag_dport,
+					       (struct in6_addr *)req->id.idiag_src,
+					       req->id.idiag_sport,
+					       req->id.idiag_if, 0, NULL);
 	}
 #endif
 	else {
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index fb50dcf8a384..0de28cbfe793 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -344,9 +344,9 @@ static void udp6_hash4(struct sock *sk)
 struct sock *__udp6_lib_lookup(const struct net *net,
 			       const struct in6_addr *saddr, __be16 sport,
 			       const struct in6_addr *daddr, __be16 dport,
-			       int dif, int sdif, struct udp_table *udptable,
-			       struct sk_buff *skb)
+			       int dif, int sdif, struct sk_buff *skb)
 {
+	struct udp_table *udptable = net->ipv4.udp_table;
 	unsigned short hnum = ntohs(dport);
 	struct udp_hslot *hslot2;
 	struct sock *result, *sk;
@@ -406,14 +406,13 @@ struct sock *__udp6_lib_lookup(const struct net *net,
 EXPORT_SYMBOL_GPL(__udp6_lib_lookup);
 
 static struct sock *__udp6_lib_lookup_skb(struct sk_buff *skb,
-					  __be16 sport, __be16 dport,
-					  struct udp_table *udptable)
+					  __be16 sport, __be16 dport)
 {
 	const struct ipv6hdr *iph = ipv6_hdr(skb);
 
 	return __udp6_lib_lookup(dev_net(skb->dev), &iph->saddr, sport,
 				 &iph->daddr, dport, inet6_iif(skb),
-				 inet6_sdif(skb), udptable, skb);
+				 inet6_sdif(skb), skb);
 }
 
 struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
@@ -421,14 +420,12 @@ struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
 {
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct ipv6hdr *iph = (struct ipv6hdr *)(skb->data + offset);
-	struct net *net = dev_net(skb->dev);
 	int iif, sdif;
 
 	inet6_get_iif_sdif(skb, &iif, &sdif);
 
-	return __udp6_lib_lookup(net, &iph->saddr, sport,
-				 &iph->daddr, dport, iif,
-				 sdif, net->ipv4.udp_table, NULL);
+	return __udp6_lib_lookup(dev_net(skb->dev), &iph->saddr, sport,
+				 &iph->daddr, dport, iif, sdif, NULL);
 }
 
 /* Must be called under rcu_read_lock().
@@ -440,8 +437,7 @@ struct sock *udp6_lib_lookup(const struct net *net, const struct in6_addr *saddr
 {
 	struct sock *sk;
 
-	sk =  __udp6_lib_lookup(net, saddr, sport, daddr, dport,
-				dif, 0, net->ipv4.udp_table, NULL);
+	sk =  __udp6_lib_lookup(net, saddr, sport, daddr, dport, dif, 0, NULL);
 	if (sk && !refcount_inc_not_zero(&sk->sk_refcnt))
 		sk = NULL;
 	return sk;
@@ -642,7 +638,6 @@ static int __udp6_lib_err_encap_no_sk(struct sk_buff *skb,
 static struct sock *__udp6_lib_err_encap(struct net *net,
 					 const struct ipv6hdr *hdr, int offset,
 					 struct udphdr *uh,
-					 struct udp_table *udptable,
 					 struct sock *sk,
 					 struct sk_buff *skb,
 					 struct inet6_skb_parm *opt,
@@ -673,7 +668,7 @@ static struct sock *__udp6_lib_err_encap(struct net *net,
 
 	sk = __udp6_lib_lookup(net, &hdr->daddr, uh->source,
 			       &hdr->saddr, uh->dest,
-			       inet6_iif(skb), 0, udptable, skb);
+			       inet6_iif(skb), 0, skb);
 	if (sk) {
 		up = udp_sk(sk);
 
@@ -694,29 +689,28 @@ static struct sock *__udp6_lib_err_encap(struct net *net,
 	return sk;
 }
 
-static int __udp6_lib_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
-			  u8 type, u8 code, int offset, __be32 info,
-			  struct udp_table *udptable)
+static int udpv6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
+		     u8 type, u8 code, int offset, __be32 info)
 {
-	struct ipv6_pinfo *np;
 	const struct ipv6hdr *hdr = (const struct ipv6hdr *)skb->data;
-	const struct in6_addr *saddr = &hdr->saddr;
-	const struct in6_addr *daddr = seg6_get_daddr(skb, opt) ? : &hdr->daddr;
-	struct udphdr *uh = (struct udphdr *)(skb->data+offset);
+	struct udphdr *uh = (struct udphdr *)(skb->data + offset);
+	const struct in6_addr *saddr, *daddr;
+	struct net *net = dev_net(skb->dev);
+	struct ipv6_pinfo *np;
 	bool tunnel = false;
 	struct sock *sk;
 	int harderr;
 	int err;
-	struct net *net = dev_net(skb->dev);
 
+	daddr = seg6_get_daddr(skb, opt) ? : &hdr->daddr;
+	saddr = &hdr->saddr;
 	sk = __udp6_lib_lookup(net, daddr, uh->dest, saddr, uh->source,
-			       inet6_iif(skb), inet6_sdif(skb), udptable, NULL);
+			       inet6_iif(skb), inet6_sdif(skb), NULL);
 
 	if (!sk || READ_ONCE(udp_sk(sk)->encap_type)) {
 		/* No socket for error: try tunnels before discarding */
 		if (static_branch_unlikely(&udpv6_encap_needed_key)) {
-			sk = __udp6_lib_err_encap(net, hdr, offset, uh,
-						  udptable, sk, skb,
+			sk = __udp6_lib_err_encap(net, hdr, offset, uh, sk, skb,
 						  opt, type, code, info);
 			if (!sk)
 				return 0;
@@ -808,14 +802,6 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
-static __inline__ int udpv6_err(struct sk_buff *skb,
-				struct inet6_skb_parm *opt, u8 type,
-				u8 code, int offset, __be32 info)
-{
-	return __udp6_lib_err(skb, opt, type, code, offset, info,
-			      dev_net(skb->dev)->ipv4.udp_table);
-}
-
 static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 {
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
@@ -947,19 +933,27 @@ static void udp6_csum_zero_error(struct sk_buff *skb)
  * so we don't need to lock the hashes.
  */
 static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
-		const struct in6_addr *saddr, const struct in6_addr *daddr,
-		struct udp_table *udptable, int proto)
+				    const struct in6_addr *saddr,
+				    const struct in6_addr *daddr,
+				    int proto)
 {
-	struct sock *sk, *first = NULL;
+	struct udp_table *udptable = net->ipv4.udp_table;
 	const struct udphdr *uh = udp_hdr(skb);
+	unsigned int hash2, hash2_any, offset;
 	unsigned short hnum = ntohs(uh->dest);
-	struct udp_hslot *hslot = udp_hashslot(udptable, net, hnum);
-	unsigned int offset = offsetof(typeof(*sk), sk_node);
-	unsigned int hash2 = 0, hash2_any = 0, use_hash2 = (hslot->count > 10);
-	int dif = inet6_iif(skb);
+	struct sock *sk, *first = NULL;
 	int sdif = inet6_sdif(skb);
+	int dif = inet6_iif(skb);
 	struct hlist_node *node;
+	struct udp_hslot *hslot;
 	struct sk_buff *nskb;
+	bool use_hash2;
+
+	hash2_any = 0;
+	hash2 = 0;
+	hslot = udp_hashslot(udptable, net, hnum);
+	use_hash2 = hslot->count > 10;
+	offset = offsetof(typeof(*sk), sk_node);
 
 	if (use_hash2) {
 		hash2_any = ipv6_portaddr_hash(net, &in6addr_any, hnum) &
@@ -1069,8 +1063,7 @@ static int udp6_csum_init(struct sk_buff *skb, struct udphdr *uh)
 	return 0;
 }
 
-static int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
-			  int proto)
+static int __udp6_lib_rcv(struct sk_buff *skb, int proto)
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	const struct in6_addr *saddr, *daddr;
@@ -1140,11 +1133,10 @@ static int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	 *	Multicast receive code
 	 */
 	if (ipv6_addr_is_multicast(daddr))
-		return __udp6_lib_mcast_deliver(net, skb,
-				saddr, daddr, udptable, proto);
+		return __udp6_lib_mcast_deliver(net, skb, saddr, daddr, proto);
 
 	/* Unicast */
-	sk = __udp6_lib_lookup_skb(skb, uh->source, uh->dest, udptable);
+	sk = __udp6_lib_lookup_skb(skb, uh->source, uh->dest);
 	if (sk) {
 		if (!uh->check && !udp_get_no_check6_rx(sk))
 			goto report_csum_error;
@@ -1262,7 +1254,7 @@ void udp_v6_early_demux(struct sk_buff *skb)
 
 INDIRECT_CALLABLE_SCOPE int udpv6_rcv(struct sk_buff *skb)
 {
-	return __udp6_lib_rcv(skb, dev_net(skb->dev)->ipv4.udp_table, IPPROTO_UDP);
+	return __udp6_lib_rcv(skb, IPPROTO_UDP);
 }
 
 /*
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index e003b8494dc0..778afc7453ce 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -128,8 +128,7 @@ static struct sock *udp6_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
 	inet6_get_iif_sdif(skb, &iif, &sdif);
 
 	return __udp6_lib_lookup(net, &iph->saddr, sport,
-				 &iph->daddr, dport, iif,
-				 sdif, net->ipv4.udp_table, NULL);
+				 &iph->daddr, dport, iif, sdif, NULL);
 }
 
 struct sk_buff *udp6_gro_receive(struct list_head *head, struct sk_buff *skb)
-- 
2.53.0.473.g4a7958ca14-goog


