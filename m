Return-Path: <netdev+bounces-264026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePDUDf6IqGn2vQAAu9opvQ
	(envelope-from <netdev+bounces-264026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:33:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 995CD2071EE
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09C39304C2F5
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 19:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD123DFC80;
	Wed,  4 Mar 2026 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u4PrPlFh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968403DEAF6
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652662; cv=none; b=FWwm3xJV2ab8z53nXhedslyEmMK2d4+tHe/KEgP0W9XzMLB/4QQ38B4uyRB61pPO0kaVrwWbmhAnrZjhBBb31T+hVRoOGr1AkEKjxFvPjI+PnIhrsUqH8MfjytIYxWs9hpdvrgFwnv/IPVP2DkUYiRRLTMJ816bQvae93ezfiww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652662; c=relaxed/simple;
	bh=sX3VORtoXHBEfr0cWv/74v1vuW4fST7CkSiMyZ8dzsc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tv237KXMQXXsBwxzM7RLwIPI9xuvOmhenYayAvr8ugiDe0iTSwrNFx/U4EAv62owaME3y06MgmYRkEN0PzJKpyrCHX8m6jTlmWCIYKPZfxwlSsRd74Cg2B60ADb5WQJ1YMyWtJL2QFTuxnW2LWZmFni9YdAPh4RHtxgfnsJpvBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u4PrPlFh; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354bc535546so5799876a91.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 11:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772652660; x=1773257460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YSHD+rNgP486mBxT4V0+VtNFO4oM2lMXMThS0Jr66Js=;
        b=u4PrPlFhR0siqGIiup7yJogGA5icB7VOyQCd/9e756yg4PNimLj258L1KkavwRtW7M
         YDWGaW3sJIa/9RTeYEcK1Mjb16hKypTBzY3hHumh18K3XpbPEsxFUrr3qhzUe2Fty81w
         DkqIdfzN3KpteadQFUof5hrcQV2JaMli5jbahLR/ToeIJk5JMYkKkK7bEFebdmkFEpTY
         JRnI1Oz0S413f/4Vnrn39vcj1I7vWmcMO9FpTlUMY/Nep7rUlUT+r+/cPCd2VpNh3nXB
         fdtxlaVPt0nBJPYOPTV4n84hyIK7nzxWIcw1yQaFSMiklQ6Xpx+EwbWDNxKX4xgY5dp8
         wo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652660; x=1773257460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSHD+rNgP486mBxT4V0+VtNFO4oM2lMXMThS0Jr66Js=;
        b=QqdqxiLMKWi/getj2HyrttdB7zbOlARXMSTsxsOr5mYVWE9gtA3iagu8SUv1RCCKFS
         cxnBTa8brdf0xaKKHemRlYd14ybE6h0qXvgH6TPkW7tCb9732sj3hxqAHQepwW6m/4iR
         diuGE+7FbDQVthaU+BlB/tBWq1O9xIFMd1ghl8oTJSyjeINEZ2xOn9I6dABCzCkjNVtM
         I9fbj+GA47MlGMuiNDEjiXtiBhovOyQMVtmULTMULrDrju6kjx1eCKFedBma8nMZHfEB
         KKnO8AHqch9dLQyE50UlRgCDNctQ9et87iwoqqUOYW2D3OoLq2wTeZC2CmVlBTiRWjMN
         SNOw==
X-Forwarded-Encrypted: i=1; AJvYcCWSkQ20y+qW9wyqtPQ+ZzxKk0FLOXszppTkGOBb2gU3kp8hUNZtv70IbkyNS+Ts+87+ZFIsxi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzof/UZQBjfPodcPFTMNi7MKV7IhO8mCwUfRXkbN/q7v8V2o+UY
	FkprCTVZGk33ufUL0ueLGYdKxDkqergtYjQKrea+6uDud5JwdRtpqOJmKVie1L1zI+e1KDS8yhw
	1btcVGg==
X-Received: from pjbcu12.prod.google.com ([2002:a17:90a:fa8c:b0:359:9633:e147])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d86:b0:359:8a78:569c
 with SMTP id 98e67ed59e1d1-359a6a4c897mr2962362a91.25.1772652659837; Wed, 04
 Mar 2026 11:30:59 -0800 (PST)
Date: Wed,  4 Mar 2026 19:28:45 +0000
In-Reply-To: <20260304193034.1870586-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260304193034.1870586-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304193034.1870586-15-kuniyu@google.com>
Subject: [PATCH v1 net-next 14/15] udp: Don't pass udptable to IPv4 socket
 lookup functions.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 995CD2071EE
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
	TAGGED_FROM(0.00)[bounces-264026-lists,netdev=lfdr.de];
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

Let's fetch net->ipv4.udp_table only where needed in IPv4
stack: __udp4_lib_lookup(), __udp4_lib_mcast_deliver(),
and udp_diag_dump().

Some functions are renamed as the wrapper functions are no
longer needed.

  __udp4_lib_err()     -> udp_err()
  __udp_diag_destroy() -> udp_diag_destroy()
  udp_dump_one()       -> udp_diag_dump_one()
  udp_dump()           -> udp_diag_dump()

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/udp.h      |  5 ++-
 net/core/filter.c      |  2 +-
 net/ipv4/udp.c         | 75 +++++++++++++++++++-----------------------
 net/ipv4/udp_diag.c    | 61 ++++++++++++----------------------
 net/ipv4/udp_offload.c |  3 +-
 5 files changed, 59 insertions(+), 87 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index e7409f2812e5..3028cd6d1927 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -436,9 +436,8 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 struct sock *udp4_lib_lookup(const struct net *net, __be32 saddr, __be16 sport,
 			     __be32 daddr, __be16 dport, int dif);
 struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
-			       __be16 sport,
-			       __be32 daddr, __be16 dport, int dif, int sdif,
-			       struct udp_table *tbl, struct sk_buff *skb);
+			       __be16 sport, __be32 daddr, __be16 dport,
+			       int dif, int sdif, struct sk_buff *skb);
 struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
 				 __be16 sport, __be16 dport);
 struct sock *udp6_lib_lookup(const struct net *net,
diff --git a/net/core/filter.c b/net/core/filter.c
index 7a3440d009a8..de6ef1915af3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6880,7 +6880,7 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
 		else
 			sk = __udp4_lib_lookup(net, src4, tuple->ipv4.sport,
 					       dst4, tuple->ipv4.dport,
-					       dif, sdif, net->ipv4.udp_table, NULL);
+					       dif, sdif, NULL);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		struct in6_addr *src6 = (struct in6_addr *)&tuple->ipv6.saddr;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 5b445779b0a0..2ae35ca1bb3f 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -673,9 +673,10 @@ EXPORT_IPV6_MOD(udp4_hash4);
  * harder than this. -DaveM
  */
 struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
-		__be16 sport, __be32 daddr, __be16 dport, int dif,
-		int sdif, struct udp_table *udptable, struct sk_buff *skb)
+			       __be16 sport, __be32 daddr, __be16 dport,
+			       int dif, int sdif, struct sk_buff *skb)
 {
+	struct udp_table *udptable = net->ipv4.udp_table;
 	unsigned short hnum = ntohs(dport);
 	struct udp_hslot *hslot2;
 	struct sock *result, *sk;
@@ -741,14 +742,13 @@ struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
 EXPORT_SYMBOL_GPL(__udp4_lib_lookup);
 
 static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
-						 __be16 sport, __be16 dport,
-						 struct udp_table *udptable)
+						 __be16 sport, __be16 dport)
 {
 	const struct iphdr *iph = ip_hdr(skb);
 
 	return __udp4_lib_lookup(dev_net(skb->dev), iph->saddr, sport,
 				 iph->daddr, dport, inet_iif(skb),
-				 inet_sdif(skb), udptable, skb);
+				 inet_sdif(skb), skb);
 }
 
 struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
@@ -756,14 +756,12 @@ struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
 {
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
-	struct net *net = dev_net(skb->dev);
 	int iif, sdif;
 
 	inet_get_iif_sdif(skb, &iif, &sdif);
 
-	return __udp4_lib_lookup(net, iph->saddr, sport,
-				 iph->daddr, dport, iif,
-				 sdif, net->ipv4.udp_table, NULL);
+	return __udp4_lib_lookup(dev_net(skb->dev), iph->saddr, sport,
+				 iph->daddr, dport, iif, sdif, NULL);
 }
 
 /* Must be called under rcu_read_lock().
@@ -775,8 +773,7 @@ struct sock *udp4_lib_lookup(const struct net *net, __be32 saddr, __be16 sport,
 {
 	struct sock *sk;
 
-	sk = __udp4_lib_lookup(net, saddr, sport, daddr, dport,
-			       dif, 0, net->ipv4.udp_table, NULL);
+	sk = __udp4_lib_lookup(net, saddr, sport, daddr, dport, dif, 0, NULL);
 	if (sk && !refcount_inc_not_zero(&sk->sk_refcnt))
 		sk = NULL;
 	return sk;
@@ -866,7 +863,6 @@ static int __udp4_lib_err_encap_no_sk(struct sk_buff *skb, u32 info)
 static struct sock *__udp4_lib_err_encap(struct net *net,
 					 const struct iphdr *iph,
 					 struct udphdr *uh,
-					 struct udp_table *udptable,
 					 struct sock *sk,
 					 struct sk_buff *skb, u32 info)
 {
@@ -894,8 +890,7 @@ static struct sock *__udp4_lib_err_encap(struct net *net,
 	}
 
 	sk = __udp4_lib_lookup(net, iph->daddr, uh->source,
-			       iph->saddr, uh->dest, skb->dev->ifindex, 0,
-			       udptable, NULL);
+			       iph->saddr, uh->dest, skb->dev->ifindex, 0, NULL);
 	if (sk) {
 		up = udp_sk(sk);
 
@@ -924,29 +919,28 @@ static struct sock *__udp4_lib_err_encap(struct net *net,
  * header points to the first 8 bytes of the udp header.  We need
  * to find the appropriate port.
  */
-
-static int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
+int udp_err(struct sk_buff *skb, u32 info)
 {
-	struct inet_sock *inet;
 	const struct iphdr *iph = (const struct iphdr *)skb->data;
-	struct udphdr *uh = (struct udphdr *)(skb->data+(iph->ihl<<2));
 	const int type = icmp_hdr(skb)->type;
 	const int code = icmp_hdr(skb)->code;
+	struct net *net = dev_net(skb->dev);
+	struct inet_sock *inet;
 	bool tunnel = false;
+	struct udphdr *uh;
 	struct sock *sk;
 	int harderr;
 	int err;
-	struct net *net = dev_net(skb->dev);
 
+	uh = (struct udphdr *)(skb->data + (iph->ihl << 2));
 	sk = __udp4_lib_lookup(net, iph->daddr, uh->dest,
 			       iph->saddr, uh->source, skb->dev->ifindex,
-			       inet_sdif(skb), udptable, NULL);
+			       inet_sdif(skb), NULL);
 
 	if (!sk || READ_ONCE(udp_sk(sk)->encap_type)) {
 		/* No socket for error: try tunnels before discarding */
 		if (static_branch_unlikely(&udp_encap_needed_key)) {
-			sk = __udp4_lib_err_encap(net, iph, uh, udptable, sk, skb,
-						  info);
+			sk = __udp4_lib_err_encap(net, iph, uh, sk, skb, info);
 			if (!sk)
 				return 0;
 		} else
@@ -1019,11 +1013,6 @@ static int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udpta
 	return 0;
 }
 
-int udp_err(struct sk_buff *skb, u32 info)
-{
-	return __udp4_lib_err(skb, info, dev_net(skb->dev)->ipv4.udp_table);
-}
-
 /*
  * Throw away all pending data and cancel the corking. Socket is locked.
  */
@@ -2486,18 +2475,24 @@ EXPORT_IPV6_MOD(udp_sk_rx_dst_set);
 static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 				    struct udphdr  *uh,
 				    __be32 saddr, __be32 daddr,
-				    struct udp_table *udptable,
 				    int proto)
 {
-	struct sock *sk, *first = NULL;
+	struct udp_table *udptable = net->ipv4.udp_table;
+	unsigned int hash2, hash2_any, offset;
 	unsigned short hnum = ntohs(uh->dest);
-	struct udp_hslot *hslot = udp_hashslot(udptable, net, hnum);
-	unsigned int hash2 = 0, hash2_any = 0, use_hash2 = (hslot->count > 10);
-	unsigned int offset = offsetof(typeof(*sk), sk_node);
+	struct sock *sk, *first = NULL;
 	int dif = skb->dev->ifindex;
 	int sdif = inet_sdif(skb);
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
 		hash2_any = ipv4_portaddr_hash(net, htonl(INADDR_ANY), hnum) &
@@ -2602,15 +2597,14 @@ static int udp_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
  *	All we need to do is get the socket, and then do a checksum.
  */
 
-static int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
-			  int proto)
+static int __udp4_lib_rcv(struct sk_buff *skb, int proto)
 {
+	struct rtable *rt = skb_rtable(skb);
+	struct net *net = dev_net(skb->dev);
 	struct sock *sk = NULL;
-	struct udphdr *uh;
 	unsigned short ulen;
-	struct rtable *rt = skb_rtable(skb);
 	__be32 saddr, daddr;
-	struct net *net = dev_net(skb->dev);
+	struct udphdr *uh;
 	bool refcounted;
 	int drop_reason;
 
@@ -2660,10 +2654,9 @@ static int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	}
 
 	if (rt->rt_flags & (RTCF_BROADCAST|RTCF_MULTICAST))
-		return __udp4_lib_mcast_deliver(net, skb, uh,
-						saddr, daddr, udptable, proto);
+		return __udp4_lib_mcast_deliver(net, skb, uh, saddr, daddr, proto);
 
-	sk = __udp4_lib_lookup_skb(skb, uh->source, uh->dest, udptable);
+	sk = __udp4_lib_lookup_skb(skb, uh->source, uh->dest);
 	if (sk)
 		return udp_unicast_rcv_skb(sk, skb, uh);
 no_sk:
@@ -2847,7 +2840,7 @@ enum skb_drop_reason udp_v4_early_demux(struct sk_buff *skb)
 
 int udp_rcv(struct sk_buff *skb)
 {
-	return __udp4_lib_rcv(skb, dev_net(skb->dev)->ipv4.udp_table, IPPROTO_UDP);
+	return __udp4_lib_rcv(skb, IPPROTO_UDP);
 }
 
 static void udp_destroy_sock(struct sock *sk)
diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
index 0899c60cce53..f4b24e628cf8 100644
--- a/net/ipv4/udp_diag.c
+++ b/net/ipv4/udp_diag.c
@@ -24,23 +24,24 @@ static int sk_diag_dump(struct sock *sk, struct sk_buff *skb,
 				 net_admin);
 }
 
-static int udp_dump_one(struct udp_table *tbl,
-			struct netlink_callback *cb,
-			const struct inet_diag_req_v2 *req)
+static int udp_diag_dump_one(struct netlink_callback *cb,
+			     const struct inet_diag_req_v2 *req)
 {
 	struct sk_buff *in_skb = cb->skb;
-	int err;
 	struct sock *sk = NULL;
 	struct sk_buff *rep;
-	struct net *net = sock_net(in_skb->sk);
+	struct net *net;
+	int err;
+
+	net = sock_net(in_skb->sk);
 
 	rcu_read_lock();
 	if (req->sdiag_family == AF_INET)
 		/* src and dst are swapped for historical reasons */
 		sk = __udp4_lib_lookup(net,
-				req->id.idiag_src[0], req->id.idiag_sport,
-				req->id.idiag_dst[0], req->id.idiag_dport,
-				req->id.idiag_if, 0, tbl, NULL);
+				       req->id.idiag_src[0], req->id.idiag_sport,
+				       req->id.idiag_dst[0], req->id.idiag_dport,
+				       req->id.idiag_if, 0, NULL);
 #if IS_ENABLED(CONFIG_IPV6)
 	else if (req->sdiag_family == AF_INET6)
 		sk = __udp6_lib_lookup(net,
@@ -85,14 +86,15 @@ static int udp_dump_one(struct udp_table *tbl,
 	return err;
 }
 
-static void udp_dump(struct udp_table *table, struct sk_buff *skb,
-		     struct netlink_callback *cb,
-		     const struct inet_diag_req_v2 *r)
+static void udp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
+			  const struct inet_diag_req_v2 *r)
 {
 	bool net_admin = netlink_net_capable(cb->skb, CAP_NET_ADMIN);
 	struct net *net = sock_net(skb->sk);
 	int num, s_num, slot, s_slot;
+	struct udp_table *table;
 
+	table = net->ipv4.udp_table;
 	s_slot = cb->args[0];
 	num = s_num = cb->args[1];
 
@@ -139,18 +141,6 @@ static void udp_dump(struct udp_table *table, struct sk_buff *skb,
 	cb->args[1] = num;
 }
 
-static void udp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
-			  const struct inet_diag_req_v2 *r)
-{
-	udp_dump(sock_net(cb->skb->sk)->ipv4.udp_table, skb, cb, r);
-}
-
-static int udp_diag_dump_one(struct netlink_callback *cb,
-			     const struct inet_diag_req_v2 *req)
-{
-	return udp_dump_one(sock_net(cb->skb->sk)->ipv4.udp_table, cb, req);
-}
-
 static void udp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 		void *info)
 {
@@ -159,9 +149,8 @@ static void udp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 }
 
 #ifdef CONFIG_INET_DIAG_DESTROY
-static int __udp_diag_destroy(struct sk_buff *in_skb,
-			      const struct inet_diag_req_v2 *req,
-			      struct udp_table *tbl)
+static int udp_diag_destroy(struct sk_buff *in_skb,
+			    const struct inet_diag_req_v2 *req)
 {
 	struct net *net = sock_net(in_skb->sk);
 	struct sock *sk;
@@ -171,18 +160,17 @@ static int __udp_diag_destroy(struct sk_buff *in_skb,
 
 	if (req->sdiag_family == AF_INET)
 		sk = __udp4_lib_lookup(net,
-				req->id.idiag_dst[0], req->id.idiag_dport,
-				req->id.idiag_src[0], req->id.idiag_sport,
-				req->id.idiag_if, 0, tbl, NULL);
+				       req->id.idiag_dst[0], req->id.idiag_dport,
+				       req->id.idiag_src[0], req->id.idiag_sport,
+				       req->id.idiag_if, 0, NULL);
 #if IS_ENABLED(CONFIG_IPV6)
 	else if (req->sdiag_family == AF_INET6) {
 		if (ipv6_addr_v4mapped((struct in6_addr *)req->id.idiag_dst) &&
 		    ipv6_addr_v4mapped((struct in6_addr *)req->id.idiag_src))
 			sk = __udp4_lib_lookup(net,
-					req->id.idiag_dst[3], req->id.idiag_dport,
-					req->id.idiag_src[3], req->id.idiag_sport,
-					req->id.idiag_if, 0, tbl, NULL);
-
+					       req->id.idiag_dst[3], req->id.idiag_dport,
+					       req->id.idiag_src[3], req->id.idiag_sport,
+					       req->id.idiag_if, 0, NULL);
 		else
 			sk = __udp6_lib_lookup(net,
 					       (struct in6_addr *)req->id.idiag_dst,
@@ -216,13 +204,6 @@ static int __udp_diag_destroy(struct sk_buff *in_skb,
 
 	return err;
 }
-
-static int udp_diag_destroy(struct sk_buff *in_skb,
-			    const struct inet_diag_req_v2 *req)
-{
-	return __udp_diag_destroy(in_skb, req, sock_net(in_skb->sk)->ipv4.udp_table);
-}
-
 #endif
 
 static const struct inet_diag_handler udp_diag_handler = {
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 6b1654c1ad4a..98e92da726b5 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -869,8 +869,7 @@ static struct sock *udp4_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
 	inet_get_iif_sdif(skb, &iif, &sdif);
 
 	return __udp4_lib_lookup(net, iph->saddr, sport,
-				 iph->daddr, dport, iif,
-				 sdif, net->ipv4.udp_table, NULL);
+				 iph->daddr, dport, iif, sdif, NULL);
 }
 
 INDIRECT_CALLABLE_SCOPE
-- 
2.53.0.473.g4a7958ca14-goog


