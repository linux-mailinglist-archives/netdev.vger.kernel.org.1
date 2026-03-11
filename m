Return-Path: <netdev+bounces-266479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MqJGv37sGnCpQIAu9opvQ
	(envelope-from <netdev+bounces-266479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:22:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F0025C62E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC9FE3084119
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80A4299A94;
	Wed, 11 Mar 2026 05:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xY4Gp2vT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EAA325727
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206451; cv=none; b=XRF3HXMmiWu6H0MJVl+ckuLq6TZX2hz8yPTwBBcFUnlRnpKl9yVyQmU3RTWKs3+L0+oQ0FgwV3lW3uA/D0huwpHrJWWcS0FkDbey7rcqoEAE1T9z8/KgcVzz+4RWZF/Bsm+hFdgPkWD/d5nSXhgb+BhMoHLD4pVA/Baf6P8gANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206451; c=relaxed/simple;
	bh=Hurud/w7/UfV8kSAZghR3UQFoXkeZXAm2RaMQfxBKtI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YDCHPN7D1iMAdbFSiA1l+nI24jgjPicVTzQaLDy6BrgSEv9DKdamAm6VVwZlU6PRrwxqMmyVP7JKoxvlawKuttQjXIqllBXWG0pU/3x7R0xp88fYcVhk0wsNPtdnnzmakiSxGs1BbDn4QAZEegWB81QLSz+b0VrtWyAVkMw/oRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xY4Gp2vT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso13573858a91.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773206449; x=1773811249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NA0oZvJXoTai5177HaAPEJgSPZBpHce3qmRL8kl4GJA=;
        b=xY4Gp2vTZ1vLnzFtA9Wgv5G/wBHaB7k53E2cAVycY/UWp4nmv11VKAh4XMuS8HGeNv
         OA4Mg+WPuudeE/j9fnWHkOha+5q3uhPlY5ERULWGwGznVEd4O0OSayLDwBfSql+AH374
         976EqKr6RZGjsblurBMKptSmDzooEl3YYiTBe076AEoW6F2s2piR9gH16MeMw9z+s2j0
         9av7WqZxBjuqQ5jokIYcVr4q3T/IpukxqFt6rM7ag5ZX0MHeS6B3yj/syvsJl6qk3fLc
         9o5l8Tw54yAqOL0V7Pbg71XmMfVE4lDxPFBFXEOREtUizreW+KNNjxsZFGW8gPZR5OEF
         wcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206449; x=1773811249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NA0oZvJXoTai5177HaAPEJgSPZBpHce3qmRL8kl4GJA=;
        b=NQ0oDxFnQTDGIKdWon4bnY9RSg8ub5SFuJMjowxQT2DqnOuzRIms5f0FzsUy+pB5JG
         AZvDyIBqCfeK0adHop0yQvcLBgzlsk8yATCB2IYw6PAn7F3afUmryZWLIcYqH6Z1e+5T
         G3m2+88rl9dZSl6wLLA/SfsSLPgor1zJP2u66dS5ClUJGivIkMdW3sl2IfQahnSEnMw6
         ctUlxPY16r68ChH69FdcxjfIPSEpyB83KHOckmJO/64nTSvnDeP6gySss0RZhmuDkgjW
         uyjRAtvbeeYPCsLrM0SKO/Y7JQ8MxavoidvrXSuTCNdRuZdrgXIE2aMTfnmXD0h1Kjd1
         cq1w==
X-Forwarded-Encrypted: i=1; AJvYcCXXS+vaZnybbaQRwI9D6Lz8Vjmn5y6zQAU9qt4QU6B+u2zIz/97HYjrw/W6IMLQ0vqXi6hKB58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqBKuvlfgVEyWnw6VPKpDXndO6R0BGO+mfKEffp/LOQHxyLAwW
	nTomHZu8AT3SJ7FZH7HrPgwaYSUcwnh86oERkUwH1O6S3VULD01nPc5EICVHl/wBBOE8wwNpPnp
	RZ+Xo1w==
X-Received: from pjxu10.prod.google.com ([2002:a17:90a:db4a:b0:354:c1db:b113])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48c1:b0:359:f6f8:57b8
 with SMTP id 98e67ed59e1d1-35a011d018dmr1239068a91.1.1773206449225; Tue, 10
 Mar 2026 22:20:49 -0700 (PDT)
Date: Wed, 11 Mar 2026 05:20:01 +0000
In-Reply-To: <20260311052020.1213705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311052020.1213705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311052020.1213705-15-kuniyu@google.com>
Subject: [PATCH v3 net-next 14/15] udp: Don't pass udptable to IPv4 socket
 lookup functions.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 21F0025C62E
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
	TAGGED_FROM(0.00)[bounces-266479-lists,netdev=lfdr.de];
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/net/udp.h      |  5 ++-
 net/core/filter.c      |  2 +-
 net/ipv4/udp.c         | 75 +++++++++++++++++++-----------------------
 net/ipv4/udp_diag.c    | 61 ++++++++++++----------------------
 net/ipv4/udp_offload.c |  3 +-
 5 files changed, 59 insertions(+), 87 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index adec74531ee1..8262e2b215b4 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -437,9 +437,8 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
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
index 04e2a3ad0340..9746bf588a00 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6882,7 +6882,7 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
 		else
 			sk = __udp4_lib_lookup(net, src4, tuple->ipv4.sport,
 					       dst4, tuple->ipv4.dport,
-					       dif, sdif, net->ipv4.udp_table, NULL);
+					       dif, sdif, NULL);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		struct in6_addr *src6 = (struct in6_addr *)&tuple->ipv6.saddr;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index fd0bad44d111..dff803e7d6a8 100644
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
@@ -2491,18 +2480,24 @@ EXPORT_IPV6_MOD(udp_sk_rx_dst_set);
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
@@ -2607,15 +2602,14 @@ static int udp_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
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
 
@@ -2667,10 +2661,9 @@ static int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
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
@@ -2854,7 +2847,7 @@ enum skb_drop_reason udp_v4_early_demux(struct sk_buff *skb)
 
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


