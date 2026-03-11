Return-Path: <netdev+bounces-266472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEDtAuL7sGnCpQIAu9opvQ
	(envelope-from <netdev+bounces-266472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:21:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6010525C600
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9487331A2EFA
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BCD314D15;
	Wed, 11 Mar 2026 05:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Psf2IT8Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB27325727
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206440; cv=none; b=Y9spwTlWQGzR9LO0Trui5UmkZRSd9ukXIDZybj7ef8F0AAFryxHIXUcrplcY/5TUZ1J/f9WyQhw4x2sGP3D12zQQcwSvpNl1xBUloKGH5KfNMJzUcjzBNPR2x7QXeVbH6vb/kgrHhBz0AONgxUlHkYWXbIJ6erjPToHh4r9wlkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206440; c=relaxed/simple;
	bh=xje2ykAVVvoE5ht+hwsaur0gUjgkxE3YpA45CLrjWic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fF2SegL9rWgR3ZLFIT2onHrgxndmRzJ7Poz+CYL0vsli2S6R4i6xbmNSMwVeftReF5E09p7x1WqNsIFN0YlBEqhOoLjFGPmEkEq1XaNofdDys3S/23NvY1oabjGdkXL5wLzzzdqpVvWSNOGd5aMfQ4QfSKUTjOOESmQ7qBknlaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Psf2IT8Y; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3598733bec0so56286765a91.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773206438; x=1773811238; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z6pUgaELUtAOjBnAcptNDD80glqdZBm2VjGbJhJvvw0=;
        b=Psf2IT8YXGQYyO8ttk1iqCXMJzDOeSIQuXSTGTh66OS2YTMgUCptPaHbcDgyewwuDO
         8KYBLQP+KWlfeW1N5p3r1bCFpUv8G2pN5A9SNhM6NnHBRfzV3lv0liEgSzXCySfIAMuM
         H78pciycK0Sl3hGwmCvCWExnbHsix14gn9S+92f2xdshlhMGu/MUmsqUsi4rYMgjPTtq
         XLQMdACehKVj9DlC/7HfRSO1ClPN4XiT/XoO4HKWXp6oPkxTaDCnwg74NH1Lc5JSUpBd
         vgC4IiGOgxULi3VBYnNKr8IEk7+1GDGTGFpoH8+bN7UBcZp0G3Hfh3/s/g8Q5HR6WRS6
         uW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206438; x=1773811238;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6pUgaELUtAOjBnAcptNDD80glqdZBm2VjGbJhJvvw0=;
        b=rwxAhLsmZjEXCJ8/fUABEIGIlY85EgLb9DtTJoHkv8aNI8HXfPaD3/zBs0rk3Shf0I
         MSVzpBdVndTSBJnnqoQINfRyU/eD36tmx2s3T0cTjkHzv9ZBK+NXtYcgue8LXBCTv0Wt
         0IktXWNcb26zKv7N8WuR9r3kK2FqGnF/fl4ewWwJItXuBXnaLe2+x0YxuFmCvqv4S0SN
         S6DGhqL+HLH/nnbnn6ZIe0H2IEFhjyNopUpuvJkF12rwKoLcFBjBMpzTWGhMT+PxkxkG
         5xSh8AE+Qnel4W4taiyG4qBI6SUwoxdnVac+hHDZG5vi1U97S8/BFYLa5o4OfvzlqvMB
         sp7g==
X-Forwarded-Encrypted: i=1; AJvYcCVvd7w//u0p+cd2bTGaS+P+UmKnCHIYbdFWCzR3tFawOr5Ms/xwV3Fyetly+ddEew1nPrPifHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztn4T+KtzgOde27tKs1HyEpCkLuQyTc1X/H1CldXJp8gBsJfKl
	0fy6Z/yrSS8mAoHiIb/pJMmKhKFFWIOYx8doQrTnWTi100Rajx4ASxCC2iJZ6AIGEKYTcMYRcuw
	OX6USvw==
X-Received: from pjbfz2.prod.google.com ([2002:a17:90b:242:b0:356:20f7:5344])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:cb06:b0:359:ff8a:ee54
 with SMTP id 98e67ed59e1d1-35a011a6eb3mr943965a91.2.1773206437653; Tue, 10
 Mar 2026 22:20:37 -0700 (PDT)
Date: Wed, 11 Mar 2026 05:19:54 +0000
In-Reply-To: <20260311052020.1213705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311052020.1213705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311052020.1213705-8-kuniyu@google.com>
Subject: [PATCH v3 net-next 07/15] udp: Remove partial csum code in RX.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6010525C600
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-266472-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,strlen.de,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

UDP-Lite supports the partial checksum and the coverage is
stored in the position of the length field of struct udphdr.

In RX paths, udp4_csum_init() / udp6_csum_init() save the value
in UDP_SKB_CB(skb)->cscov and set UDP_SKB_CB(skb)->partial_cov
to 1 if the coverage is not full.

The subsequent processing diverges depending on the value,
but such paths are now dead.

Also, these functions have some code guarded for UDP:

  * udp_unicast_rcv_skb / udp6_unicast_rcv_skb
  * __udp4_lib_rcv() and __udp6_lib_rcv().

Let's remove the partial csum code and the unnecessary
guard for UDP-Lite in RX.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v3: Correct ulen < skb->len case in __udp4_lib_rcv()
---
 include/net/udp.h     | 17 ++-------
 include/net/udplite.h | 34 -----------------
 net/ipv4/udp.c        | 85 ++++++++-----------------------------------
 net/ipv6/udp.c        | 82 ++++++++++-------------------------------
 4 files changed, 39 insertions(+), 179 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 264c10607d2e..bc275cda9f8c 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -32,11 +32,9 @@
 #include <linux/math.h>
 
 /**
- *	struct udp_skb_cb  -  UDP(-Lite) private variables
+ *	struct udp_skb_cb  -  UDP private variables
  *
  *	@header:      private variables used by IPv4/IPv6
- *	@cscov:       checksum coverage length (UDP-Lite only)
- *	@partial_cov: if set indicates partial csum coverage
  */
 struct udp_skb_cb {
 	union {
@@ -45,8 +43,6 @@ struct udp_skb_cb {
 		struct inet6_skb_parm	h6;
 #endif
 	} header;
-	__u16		cscov;
-	__u8		partial_cov;
 };
 #define UDP_SKB_CB(__skb)	((struct udp_skb_cb *)((__skb)->cb))
 
@@ -216,13 +212,11 @@ extern int sysctl_udp_wmem_min;
 struct sk_buff;
 
 /*
- *	Generic checksumming routines for UDP(-Lite) v4 and v6
+ *	Generic checksumming routines for UDP v4 and v6
  */
 static inline __sum16 __udp_lib_checksum_complete(struct sk_buff *skb)
 {
-	return (UDP_SKB_CB(skb)->cscov == skb->len ?
-		__skb_checksum_complete(skb) :
-		__skb_checksum_complete_head(skb, UDP_SKB_CB(skb)->cscov));
+	return __skb_checksum_complete(skb);
 }
 
 static inline int udp_lib_checksum_complete(struct sk_buff *skb)
@@ -273,7 +267,6 @@ static inline void udp_csum_pull_header(struct sk_buff *skb)
 		skb->csum = csum_partial(skb->data, sizeof(struct udphdr),
 					 skb->csum);
 	skb_pull_rcsum(skb, sizeof(struct udphdr));
-	UDP_SKB_CB(skb)->cscov -= sizeof(struct udphdr);
 }
 
 typedef struct sock *(*udp_lookup_t)(const struct sk_buff *skb, __be16 sport,
@@ -641,9 +634,6 @@ static inline struct sk_buff *udp_rcv_segment(struct sock *sk,
 
 static inline void udp_post_segment_fix_csum(struct sk_buff *skb)
 {
-	/* UDP-lite can't land here - no GRO */
-	WARN_ON_ONCE(UDP_SKB_CB(skb)->partial_cov);
-
 	/* UDP packets generated with UDP_SEGMENT and traversing:
 	 *
 	 * UDP tunnel(xmit) -> veth (segmentation) -> veth (gro) -> UDP tunnel (rx)
@@ -657,7 +647,6 @@ static inline void udp_post_segment_fix_csum(struct sk_buff *skb)
 	 * a valid csum after the segmentation.
 	 * Additionally fixup the UDP CB.
 	 */
-	UDP_SKB_CB(skb)->cscov = skb->len;
 	if (skb->ip_summed == CHECKSUM_NONE && !skb->csum_valid)
 		skb->csum_valid = 1;
 }
diff --git a/include/net/udplite.h b/include/net/udplite.h
index fdd769745ac4..0456a14c993b 100644
--- a/include/net/udplite.h
+++ b/include/net/udplite.h
@@ -25,40 +25,6 @@ static __inline__ int udplite_getfrag(void *from, char *to, int  offset,
 /*
  * 	Checksumming routines
  */
-static inline int udplite_checksum_init(struct sk_buff *skb, struct udphdr *uh)
-{
-	u16 cscov;
-
-        /* In UDPv4 a zero checksum means that the transmitter generated no
-         * checksum. UDP-Lite (like IPv6) mandates checksums, hence packets
-         * with a zero checksum field are illegal.                            */
-	if (uh->check == 0) {
-		net_dbg_ratelimited("UDPLite: zeroed checksum field\n");
-		return 1;
-	}
-
-	cscov = ntohs(uh->len);
-
-	if (cscov == 0)		 /* Indicates that full coverage is required. */
-		;
-	else if (cscov < 8  || cscov > skb->len) {
-		/*
-		 * Coverage length violates RFC 3828: log and discard silently.
-		 */
-		net_dbg_ratelimited("UDPLite: bad csum coverage %d/%d\n",
-				    cscov, skb->len);
-		return 1;
-
-	} else if (cscov < skb->len) {
-        	UDP_SKB_CB(skb)->partial_cov = 1;
-		UDP_SKB_CB(skb)->cscov = cscov;
-		if (skb->ip_summed == CHECKSUM_COMPLETE)
-			skb->ip_summed = CHECKSUM_NONE;
-		skb->csum_valid = 0;
-        }
-
-	return 0;
-}
 
 /* Fast-path computation of checksum. Socket may not be locked. */
 static inline __wsum udplite_csum(struct sk_buff *skb)
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 10082095e633..d42fb9330c22 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2072,14 +2072,13 @@ EXPORT_IPV6_MOD(udp_read_skb);
 INDIRECT_CALLABLE_SCOPE
 int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 {
-	struct inet_sock *inet = inet_sk(sk);
 	DECLARE_SOCKADDR(struct sockaddr_in *, sin, msg->msg_name);
-	struct sk_buff *skb;
-	unsigned int ulen, copied;
 	int off, err, peeking = flags & MSG_PEEK;
-	int is_udplite = IS_UDPLITE(sk);
+	struct inet_sock *inet = inet_sk(sk);
 	struct net *net = sock_net(sk);
 	bool checksum_valid = false;
+	unsigned int ulen, copied;
+	struct sk_buff *skb;
 
 	if (flags & MSG_ERRQUEUE)
 		return ip_recv_error(sk, msg, len);
@@ -2097,14 +2096,10 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 	else if (copied < ulen)
 		msg->msg_flags |= MSG_TRUNC;
 
-	/*
-	 * If checksum is needed at all, try to do it while copying the
-	 * data.  If the data is truncated, or if we only want a partial
-	 * coverage checksum (UDP-Lite), do it before the copy.
+	/* If checksum is needed at all, try to do it while copying the
+	 * data.  If the data is truncated, do it before the copy.
 	 */
-
-	if (copied < ulen || peeking ||
-	    (is_udplite && UDP_SKB_CB(skb)->partial_cov)) {
+	if (copied < ulen || peeking) {
 		checksum_valid = udp_skb_csum_unnecessary(skb) ||
 				!__udp_lib_checksum_complete(skb);
 		if (!checksum_valid)
@@ -2444,42 +2439,6 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 		/* FALLTHROUGH -- it's a UDP Packet */
 	}
 
-	/*
-	 * 	UDP-Lite specific tests, ignored on UDP sockets
-	 */
-	if (unlikely(udp_test_bit(UDPLITE_RECV_CC, sk) &&
-		     UDP_SKB_CB(skb)->partial_cov)) {
-		u16 pcrlen = READ_ONCE(up->pcrlen);
-
-		/*
-		 * MIB statistics other than incrementing the error count are
-		 * disabled for the following two types of errors: these depend
-		 * on the application settings, not on the functioning of the
-		 * protocol stack as such.
-		 *
-		 * RFC 3828 here recommends (sec 3.3): "There should also be a
-		 * way ... to ... at least let the receiving application block
-		 * delivery of packets with coverage values less than a value
-		 * provided by the application."
-		 */
-		if (pcrlen == 0) {          /* full coverage was set  */
-			net_dbg_ratelimited("UDPLite: partial coverage %d while full coverage %d requested\n",
-					    UDP_SKB_CB(skb)->cscov, skb->len);
-			goto drop;
-		}
-		/* The next case involves violating the min. coverage requested
-		 * by the receiver. This is subtle: if receiver wants x and x is
-		 * greater than the buffersize/MTU then receiver will complain
-		 * that it wants x while sender emits packets of smaller size y.
-		 * Therefore the above ...()->partial_cov statement is essential.
-		 */
-		if (UDP_SKB_CB(skb)->cscov < pcrlen) {
-			net_dbg_ratelimited("UDPLite: coverage %d too small, need min %d\n",
-					    UDP_SKB_CB(skb)->cscov, pcrlen);
-			goto drop;
-		}
-	}
-
 	prefetch(&sk->sk_rmem_alloc);
 	if (rcu_access_pointer(sk->sk_filter) &&
 	    udp_lib_checksum_complete(skb))
@@ -2613,29 +2572,14 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
  * Otherwise, csum completion requires checksumming packet body,
  * including udp header and folding it to skb->csum.
  */
-static inline int udp4_csum_init(struct sk_buff *skb, struct udphdr *uh,
-				 int proto)
+static inline int udp4_csum_init(struct sk_buff *skb, struct udphdr *uh)
 {
 	int err;
 
-	UDP_SKB_CB(skb)->partial_cov = 0;
-	UDP_SKB_CB(skb)->cscov = skb->len;
-
-	if (proto == IPPROTO_UDPLITE) {
-		err = udplite_checksum_init(skb, uh);
-		if (err)
-			return err;
-
-		if (UDP_SKB_CB(skb)->partial_cov) {
-			skb->csum = inet_compute_pseudo(skb, proto);
-			return 0;
-		}
-	}
-
 	/* Note, we are only interested in != 0 or == 0, thus the
 	 * force to int.
 	 */
-	err = (__force int)skb_checksum_init_zero_check(skb, proto, uh->check,
+	err = (__force int)skb_checksum_init_zero_check(skb, IPPROTO_UDP, uh->check,
 							inet_compute_pseudo);
 	if (err)
 		return err;
@@ -2663,7 +2607,7 @@ static int udp_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
 {
 	int ret;
 
-	if (inet_get_convert_csum(sk) && uh->check && !IS_UDPLITE(sk))
+	if (inet_get_convert_csum(sk) && uh->check)
 		skb_checksum_try_convert(skb, IPPROTO_UDP, inet_compute_pseudo);
 
 	ret = udp_queue_rcv_skb(sk, skb);
@@ -2708,14 +2652,17 @@ static int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	if (ulen > skb->len)
 		goto short_packet;
 
-	if (proto == IPPROTO_UDP) {
-		/* UDP validates ulen. */
-		if (ulen < sizeof(*uh) || pskb_trim_rcsum(skb, ulen))
+	if (ulen < sizeof(*uh))
+		goto short_packet;
+
+	if (ulen < skb->len) {
+		if (pskb_trim_rcsum(skb, ulen))
 			goto short_packet;
+
 		uh = udp_hdr(skb);
 	}
 
-	if (udp4_csum_init(skb, uh, proto))
+	if (udp4_csum_init(skb, uh))
 		goto csum_error;
 
 	sk = inet_steal_sock(net, skb, sizeof(struct udphdr), saddr, uh->source, daddr, uh->dest,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 07308b7156a6..bf5430ea66f0 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -469,15 +469,13 @@ INDIRECT_CALLABLE_SCOPE
 int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		  int flags)
 {
+	int off, is_udp4, err, peeking = flags & MSG_PEEK;
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct inet_sock *inet = inet_sk(sk);
-	struct sk_buff *skb;
-	unsigned int ulen, copied;
-	int off, err, peeking = flags & MSG_PEEK;
-	int is_udplite = IS_UDPLITE(sk);
 	struct udp_mib __percpu *mib;
 	bool checksum_valid = false;
-	int is_udp4;
+	unsigned int ulen, copied;
+	struct sk_buff *skb;
 
 	if (flags & MSG_ERRQUEUE)
 		return ipv6_recv_error(sk, msg, len);
@@ -501,14 +499,10 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	is_udp4 = (skb->protocol == htons(ETH_P_IP));
 	mib = __UDPX_MIB(sk, is_udp4);
 
-	/*
-	 * If checksum is needed at all, try to do it while copying the
-	 * data.  If the data is truncated, or if we only want a partial
-	 * coverage checksum (UDP-Lite), do it before the copy.
+	/* If checksum is needed at all, try to do it while copying the
+	 * data.  If the data is truncated, do it before the copy.
 	 */
-
-	if (copied < ulen || peeking ||
-	    (is_udplite && UDP_SKB_CB(skb)->partial_cov)) {
+	if (copied < ulen || peeking) {
 		checksum_valid = udp_skb_csum_unnecessary(skb) ||
 				!__udp_lib_checksum_complete(skb);
 		if (!checksum_valid)
@@ -870,25 +864,6 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 		/* FALLTHROUGH -- it's a UDP Packet */
 	}
 
-	/*
-	 * UDP-Lite specific tests, ignored on UDP sockets (see net/ipv4/udp.c).
-	 */
-	if (unlikely(udp_test_bit(UDPLITE_RECV_CC, sk) &&
-		     UDP_SKB_CB(skb)->partial_cov)) {
-		u16 pcrlen = READ_ONCE(up->pcrlen);
-
-		if (pcrlen == 0) {          /* full coverage was set  */
-			net_dbg_ratelimited("UDPLITE6: partial coverage %d while full coverage %d requested\n",
-					    UDP_SKB_CB(skb)->cscov, skb->len);
-			goto drop;
-		}
-		if (UDP_SKB_CB(skb)->cscov < pcrlen) {
-			net_dbg_ratelimited("UDPLITE6: coverage %d too small, need min %d\n",
-					    UDP_SKB_CB(skb)->cscov, pcrlen);
-			goto drop;
-		}
-	}
-
 	prefetch(&sk->sk_rmem_alloc);
 	if (rcu_access_pointer(sk->sk_filter) &&
 	    udp_lib_checksum_complete(skb))
@@ -1053,7 +1028,7 @@ static int udp6_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
 {
 	int ret;
 
-	if (inet_get_convert_csum(sk) && uh->check && !IS_UDPLITE(sk))
+	if (inet_get_convert_csum(sk) && uh->check)
 		skb_checksum_try_convert(skb, IPPROTO_UDP, ip6_compute_pseudo);
 
 	ret = udpv6_queue_rcv_skb(sk, skb);
@@ -1064,24 +1039,10 @@ static int udp6_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
 	return 0;
 }
 
-static int udp6_csum_init(struct sk_buff *skb, struct udphdr *uh, int proto)
+static int udp6_csum_init(struct sk_buff *skb, struct udphdr *uh)
 {
 	int err;
 
-	UDP_SKB_CB(skb)->partial_cov = 0;
-	UDP_SKB_CB(skb)->cscov = skb->len;
-
-	if (proto == IPPROTO_UDPLITE) {
-		err = udplite_checksum_init(skb, uh);
-		if (err)
-			return err;
-
-		if (UDP_SKB_CB(skb)->partial_cov) {
-			skb->csum = ip6_compute_pseudo(skb, proto);
-			return 0;
-		}
-	}
-
 	/* To support RFC 6936 (allow zero checksum in UDP/IPV6 for tunnels)
 	 * we accept a checksum of zero here. When we find the socket
 	 * for the UDP packet we'll check if that socket allows zero checksum
@@ -1090,7 +1051,7 @@ static int udp6_csum_init(struct sk_buff *skb, struct udphdr *uh, int proto)
 	 * Note, we are only interested in != 0 or == 0, thus the
 	 * force to int.
 	 */
-	err = (__force int)skb_checksum_init_zero_check(skb, proto, uh->check,
+	err = (__force int)skb_checksum_init_zero_check(skb, IPPROTO_UDP, uh->check,
 							ip6_compute_pseudo);
 	if (err)
 		return err;
@@ -1132,26 +1093,23 @@ static int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	if (ulen > skb->len)
 		goto short_packet;
 
-	if (proto == IPPROTO_UDP) {
-		/* UDP validates ulen. */
+	/* Check for jumbo payload */
+	if (ulen == 0)
+		ulen = skb->len;
 
-		/* Check for jumbo payload */
-		if (ulen == 0)
-			ulen = skb->len;
+	if (ulen < sizeof(*uh))
+		goto short_packet;
 
-		if (ulen < sizeof(*uh))
+	if (ulen < skb->len) {
+		if (pskb_trim_rcsum(skb, ulen))
 			goto short_packet;
 
-		if (ulen < skb->len) {
-			if (pskb_trim_rcsum(skb, ulen))
-				goto short_packet;
-			saddr = &ipv6_hdr(skb)->saddr;
-			daddr = &ipv6_hdr(skb)->daddr;
-			uh = udp_hdr(skb);
-		}
+		saddr = &ipv6_hdr(skb)->saddr;
+		daddr = &ipv6_hdr(skb)->daddr;
+		uh = udp_hdr(skb);
 	}
 
-	if (udp6_csum_init(skb, uh, proto))
+	if (udp6_csum_init(skb, uh))
 		goto csum_error;
 
 	/* Check if the socket is already available, e.g. due to early demux */
-- 
2.53.0.473.g4a7958ca14-goog


