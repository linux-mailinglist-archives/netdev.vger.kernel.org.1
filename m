Return-Path: <netdev+bounces-266478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UH/DEvX7sGnCpQIAu9opvQ
	(envelope-from <netdev+bounces-266478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:21:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E5B25C61E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24ED730813C9
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43A031F98E;
	Wed, 11 Mar 2026 05:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="soteg+/N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6997C3290C9
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206449; cv=none; b=XTzC2Pu0hII1Ui9urO2iEykidtM7hnbRxk/KJA2KTIWqybzOrVVxFpVzAgm1zJ1fzIuT5GAExYmj4Sz2HG/Qeh2RaXGbFMT6uSCafAfFetAZVejYj+nmRr9TDqg9IyauWd0lxOXejLRG9+BYC9M3ZGTgZVwEoBaVnCZ0SR1ukuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206449; c=relaxed/simple;
	bh=nuyiECNHQsaKyxdFa+LWOu9lrDNoBDqpS6j6/XEdUeo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MnvozbIPZoxUGowWQxYDjHU6xhMrA+42kICmU6WBpibylN8R9InoDVVxi8+EgoxigvFPXq2Q77GyMxS/Q1R7sHxm3Vds028i5thTKQTpY3aM3zCPetOINOUn/SXSAhXk+ojHIOZw7ac7YvegYeEmbPd6wwpMF6N2AwIjoUGH4wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=soteg+/N; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3598c05c806so9921326a91.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773206448; x=1773811248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tB9nCsSSeAf242uzh5c2JLRhmsdWwpO1R9D/nDl8ogo=;
        b=soteg+/NcCnL7cgCo6HXznFKKVu//aerupSk9as1wCO9ll5pgHFHb6CqAmTSeG9jtC
         /gw6furA69Kb2UVK2U0DdJxfhHJ/blc9kSL8DWGzR9iBV+nE/qsDo6O2isvg1BNkvQ6M
         ie92Q/94q+pfxNr+grhTZ7545Ju1HI9rHj6QU178cf2FAX4sVaHCcvwuAOTwVInucdaQ
         DYo7+9oXoUS26aE+jla2wJ9eEOpiXc6kaQTTvT8+H0guA2ijltvqolusjqSybHW5zUU1
         NtJvD3WUJaoXiCerlK0PCYwWuNC+qn+isjr9ecbaNRpS4NT/onbaoV6yQho0dcM9EELQ
         iAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206448; x=1773811248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tB9nCsSSeAf242uzh5c2JLRhmsdWwpO1R9D/nDl8ogo=;
        b=MSa/ZmKHg70bob+2qKrhMq9S9/jf332T4fJNM9lWorAcPyLifpxjNbI2vt1ksEa0nU
         fraXRMpS6Q6kK58VpRUTtMEfjEEUgSD1G8sbGnT91KGFCEBHhJbTpf9OJa5NBjSmqCg8
         ic+EJn9loQD2wR9LRcXaZokKoYBUwWzM2pm44gH0hc3as0aEE81FHpWQ5dIpHptq6TFP
         REU4qX8LKUiYpalBHJw3XsGBvQJ3TOIzpotpta7Dt0VhB2XKaIA56gny542s0DUREkKt
         hhB1XNt0XuKJTa7qrxqW9HSNUanpT57D1HaYK+hyrsSW7hCKZdxeBt9y+WQ8xG48hH4h
         Bqxg==
X-Forwarded-Encrypted: i=1; AJvYcCXgZCXyJFN8VLnsZGkQlG7mmiVdiDZNxHfTVzLfkJKj5PSXBLvqhTsTW68p17HBzHJdD5ND6YE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsuyNfq67INXzGq61BVRYCfp0ujmDJN4O3XhpHKpvfv78n118M
	nGVW3On95juAiJBXSn2KZOt+IkZhhRwBL0vIlC+mhARZc5evDDhQLlnlW/wZBrIuwMnV195sGs0
	0ADeGVg==
X-Received: from pgje12.prod.google.com ([2002:a63:d94c:0:b0:c73:c3a6:69ea])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6013:b0:398:9923:7492
 with SMTP id adf61e73a8af0-398c61591e6mr1211852637.39.1773206447496; Tue, 10
 Mar 2026 22:20:47 -0700 (PDT)
Date: Wed, 11 Mar 2026 05:20:00 +0000
In-Reply-To: <20260311052020.1213705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311052020.1213705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311052020.1213705-14-kuniyu@google.com>
Subject: [PATCH v3 net-next 13/15] udp: Don't pass udptable to IPv6 socket
 lookup functions.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C5E5B25C61E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266478-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,strlen.de,google.com,gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
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
index 76f401988353..adec74531ee1 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -449,8 +449,7 @@ struct sock *udp6_lib_lookup(const struct net *net,
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
index a77d23fe2359..04e2a3ad0340 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6897,8 +6897,7 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
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
index 5ba399218d07..dd958e2b552b 100644
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
@@ -1139,11 +1132,10 @@ static int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
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
@@ -1261,7 +1253,7 @@ void udp_v6_early_demux(struct sk_buff *skb)
 
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


