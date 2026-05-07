Return-Path: <netdev+bounces-285238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCoaL6Ft/GkQQAAAu9opvQ
	(envelope-from <netdev+bounces-285238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:46:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2AD4E6FBD
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 699723024136
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603113E6DD4;
	Thu,  7 May 2026 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v3rf+VJ+"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49234E75E
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150798; cv=none; b=jQI42F6xg/nKSqVf0RWPrez28XiIvO3o0zlEm846kvAES3EH/qr1W+EL0ruQvq4Inflr3nyOkU72V5jo8gtq4iivvrHBrR7SsXvLlVx1LA0BxhUhRA6qxCgzJdbExPiLR1yINdtm6vBOmYSN/3x7Wk8GjZbAmhWkStrlJ2npf1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150798; c=relaxed/simple;
	bh=XLNA/3Hf6szgCmGtZxf+vIO5J3yddcWuAa9MX9Mt+Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X9iqVxSWgOA8NJf3yaksbPzdiv2R7UT0jrJYuEOXKJPo6LT5iJH6NX/VVy/awID0eLFEw4GoGAKsrKaoSFd1IQ81YJDaBFg0Gn/DZpm2BWTWUr5oANNks3w9ne9PNDoS3HBdooVI6DJ/UYtC/kSjVgXB6ohWhvy9SjZTh589wXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v3rf+VJ+; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778150794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E1APVSt6yoCHd9lei1r3vKIVCjO48lcPt43gmyi2l6M=;
	b=v3rf+VJ+x0nKhEaP3JzdEZyQrrXDcDdOH9bnxKvgaMMuH/Bb0QD2jQTUrvNqlhDrRaQX19
	UdMr4M6DZWYTGbY+7DZ4R2pFeNMifi3F0HY3OWJfzx0lXoDpU9C/LlZrNsPgVUjnV2g0WK
	RvalNRPLqn75niEWvt7YOnmdu1gZufo=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Joe Stringer <joe@wand.net.nz>,
	Martin KaFai Lau <kafai@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v7] net: Validate protocol in skb_steal_sock() for BPF-assigned sockets
Date: Thu,  7 May 2026 18:46:10 +0800
Message-ID: <20260507104612.236253-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 5D2AD4E6FBD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285238-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,wand.net.nz,fb.com,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

bpf_sk_assign_tcp_reqsk() can assign a TCP reqsk to a non-TCP skb,
causing a panic when the skb enters the wrong L4 receive path [1].
An initial attempt tried to fix this in the BPF helper by checking
iph->protocol, but Sashiko [2] revealed that BPF programs can bypass
this check via a TOCTOU attack by modifying iph->protocol around the
call:

    iph->protocol = IPPROTO_TCP;
    bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
    iph->protocol = IPPROTO_UDP;

Furthermore, bpf_sk_assign() has had the same class of vulnerability
since its introduction — it can assign any socket type to any skb
without protocol validation.  Since the BPF helper check alone cannot
prevent a malicious BPF program from crashing the kernel, add protocol
validation in skb_steal_sock() to reject mismatched sockets regardless
of how they were assigned.

The check is applied to all prefetched sockets.  Early demux paths
already only assign matching protocols (e.g., UDP early demux only
assigns UDP sockets to UDP skbs), so they pass the check naturally and
the extra branch is negligible.

Pass the expected protocol from callers rather than extracting it from
the IP header.  For IPv6, walking extension headers to find the L4
protocol is complex and unnecessary since each caller already knows
the protocol it handles.

[1] https://lore.kernel.org/bpf/20260403015851.148209-1-jiayuan.chen@linux.dev/
[2] https://sashiko.dev/#/patchset/20260403015851.148209-1-jiayuan.chen%40linux.dev

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Fixes: e472f88891ab ("bpf: tcp: Support arbitrary SYN Cookie.")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/net/inet6_hashtables.h |  7 ++++---
 include/net/inet_hashtables.h  |  7 ++++---
 include/net/request_sock.h     | 16 +++++++++++++++-
 net/ipv4/udp.c                 |  2 +-
 net/ipv6/udp.c                 |  2 +-
 5 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 2cc5d416bbb5..218498373a9c 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -106,12 +106,13 @@ static inline
 struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 			      const struct in6_addr *saddr, const __be16 sport,
 			      const struct in6_addr *daddr, const __be16 dport,
-			      bool *refcounted, inet6_ehashfn_t *ehashfn)
+			      bool *refcounted, inet6_ehashfn_t *ehashfn,
+			      int protocol)
 {
 	struct sock *sk, *reuse_sk;
 	bool prefetched;
 
-	sk = skb_steal_sock(skb, refcounted, &prefetched);
+	sk = skb_steal_sock(skb, refcounted, &prefetched, protocol);
 	if (!sk)
 		return NULL;
 
@@ -153,7 +154,7 @@ static inline struct sock *__inet6_lookup_skb(struct sk_buff *skb, int doff,
 	struct sock *sk;
 
 	sk = inet6_steal_sock(net, skb, doff, &ip6h->saddr, sport, &ip6h->daddr, dport,
-			      refcounted, inet6_ehashfn);
+			      refcounted, inet6_ehashfn, IPPROTO_TCP);
 	if (IS_ERR(sk))
 		return NULL;
 	if (sk)
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 6e2fe186d0dc..a2a044f93cc4 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -446,12 +446,13 @@ static inline
 struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 			     const __be32 saddr, const __be16 sport,
 			     const __be32 daddr, const __be16 dport,
-			     bool *refcounted, inet_ehashfn_t *ehashfn)
+			     bool *refcounted, inet_ehashfn_t *ehashfn,
+			     int protocol)
 {
 	struct sock *sk, *reuse_sk;
 	bool prefetched;
 
-	sk = skb_steal_sock(skb, refcounted, &prefetched);
+	sk = skb_steal_sock(skb, refcounted, &prefetched, protocol);
 	if (!sk)
 		return NULL;
 
@@ -494,7 +495,7 @@ static inline struct sock *__inet_lookup_skb(struct sk_buff *skb,
 	struct sock *sk;
 
 	sk = inet_steal_sock(net, skb, doff, iph->saddr, sport, iph->daddr, dport,
-			     refcounted, inet_ehashfn);
+			     refcounted, inet_ehashfn, IPPROTO_TCP);
 	if (IS_ERR(sk))
 		return NULL;
 	if (sk)
diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 5a9c826a7092..3469e4903aed 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -89,9 +89,11 @@ static inline struct sock *req_to_sk(struct request_sock *req)
  * @skb: sk_buff to steal the socket from
  * @refcounted: is set to true if the socket is reference-counted
  * @prefetched: is set to true if the socket was assigned from bpf
+ * @protocol: expected L4 protocol
  */
 static inline struct sock *skb_steal_sock(struct sk_buff *skb,
-					  bool *refcounted, bool *prefetched)
+					  bool *refcounted, bool *prefetched,
+					  int protocol)
 {
 	struct sock *sk = skb->sk;
 
@@ -103,6 +105,18 @@ static inline struct sock *skb_steal_sock(struct sk_buff *skb,
 
 	*prefetched = skb_sk_is_prefetched(skb);
 	if (*prefetched) {
+		/* A non-full socket here is either a reqsk or a
+		 * timewait sock, both only contain sock_common and
+		 * lack sk_protocol. Since both can only be TCP,
+		 * use IPPROTO_TCP as the protocol.
+		 */
+		if ((sk_fullsock(sk) ? sk->sk_protocol : IPPROTO_TCP) != protocol) {
+			skb_orphan(skb);
+			*prefetched = false;
+			*refcounted = false;
+			return NULL;
+		}
+
 #if IS_ENABLED(CONFIG_SYN_COOKIES)
 		if (sk->sk_state == TCP_NEW_SYN_RECV && inet_reqsk(sk)->syncookie) {
 			struct request_sock *req = inet_reqsk(sk);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0ac2bf4f8759..ceb4d29a64ac 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2618,7 +2618,7 @@ int udp_rcv(struct sk_buff *skb)
 		goto csum_error;
 
 	sk = inet_steal_sock(net, skb, sizeof(struct udphdr), saddr, uh->source, daddr, uh->dest,
-			     &refcounted, udp_ehashfn);
+			     &refcounted, udp_ehashfn, IPPROTO_UDP);
 	if (IS_ERR(sk))
 		goto no_sk;
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 15e032194ecc..d9c12cce5ace 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1106,7 +1106,7 @@ INDIRECT_CALLABLE_SCOPE int udpv6_rcv(struct sk_buff *skb)
 
 	/* Check if the socket is already available, e.g. due to early demux */
 	sk = inet6_steal_sock(net, skb, sizeof(struct udphdr), saddr, uh->source, daddr, uh->dest,
-			      &refcounted, udp6_ehashfn);
+			      &refcounted, udp6_ehashfn, IPPROTO_UDP);
 	if (IS_ERR(sk))
 		goto no_sk;
 
-- 
2.43.0


