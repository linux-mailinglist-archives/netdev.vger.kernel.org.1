Return-Path: <netdev+bounces-264019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJJWMLOIqGn2vQAAu9opvQ
	(envelope-from <netdev+bounces-264019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:32:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5DB2071A3
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A2E9302C762
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 19:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCF53DFC76;
	Wed,  4 Mar 2026 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tboNkzHH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9663793DD
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652651; cv=none; b=OUgYPPDUnuoOg0rtbNhbRyzSGuM68zJhYl9YqeoitXvzlxPAX7zR3e6+dtuMAWx6VVCXIKNzD59NdWXmzZOBlsiPGfejHH0Y4GA4zP1ZimkyQxMraQytfGbZnZOL5pHBdoi3RoHw7+pU8iorSRj0jpptz/qGfwdF4WkX53BFzuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652651; c=relaxed/simple;
	bh=wuplFXfUZfE4iuIci27LQvI78pnGbWhaAHE6ycjyvuU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jGZUJQmr1AhcnC/y++QDaaqhx7YPD1c0/txYvF1VCy2aUU3G9BICn/9O8KxksFkIiXkNPz1KwOmiAcP215LCEX2HDL9b96amj1QHjFwbkzkNFW6ssHJ9oLeTDm4lqDWS6f3BUJXoQphLUNEHSBon/AWskS5D8M52v5RB0jVQhho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tboNkzHH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35985522c1aso13597821a91.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 11:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772652649; x=1773257449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=10kDYzgmi6vXZZHjBIyFM/bVSCIb0K9wdYFl9yGSrAc=;
        b=tboNkzHH+XnotKTZ+MsFEyQALweIBEVENp/DbMPqJin0UqwB0mJptvpzNGBMEo8O4Y
         RFY+rzZTJZrvM1YqDl6eXIOdEpfcyYxGi4Ua4wd9PLuqijo3X6GPqt43LS/tnpe0LAUT
         iqMT4M8HUweIzXVB0nfjxai9uD1pZeQgXrsOhkRQv6P1II4j0PoFxiP1Ofu036H+Fh8r
         jdEYVa52yZ+I1GNbVynHdUur/8DrChja2Lmbcku0TrvjziIXEqFUqDIIW6cozzu6V4wg
         35wQ1skfJwNJUYTwRoG3vbGN0pjsGoN/npVSAiisHqv0b08bj6n+//i0AmowrOurakrp
         dHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652649; x=1773257449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10kDYzgmi6vXZZHjBIyFM/bVSCIb0K9wdYFl9yGSrAc=;
        b=qx8P3MA9Fw2WmuP82uZ3kI+6beGAzVUpYIJwSxiyo2+ieva4CIoLMoIr9FuRm6YcOo
         GMmVb5bcqfFohW2VeooeyR3r3BzWbtHJYKjho+UsJDtaQPipsPCNbfipgoY9GyROPb7e
         JVw4ROTXd9o9aZMTgjbsZMjnrlgBdvAbMOhrTTgb+IuQthXYH1xFAfaFd3eLfUYo6jhO
         rG04PySedZkBBPluvPR1+PL6z1WoI9ozXTRUt8xzwM1h61sMSbjdUkaFgMTJkWQjcO2C
         YwaIotvXls/FtZL+lW8qZdrWzXU1iQ+WjCLVtNpomSxqwKSgIw+UEFMwLNNc4+/fQ01g
         VAVg==
X-Forwarded-Encrypted: i=1; AJvYcCVTTwBHrY8OkUYq3y9PcbkOeTgyVxKC3SoBS1vMUMJjvKFDevGQkqneWNwHPRSW9KKMA5v/vEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRgd/7pL72gjmw/uecau3FirjMcIBO8T1jIaggjF8MhLSZBZ0g
	1Uepb16GHvKJyTz0a90/Lmd0OJF6QI5YJeFQpT7oDWuu+6vufbnLUiGV7skiygKhMz8MfG+FDP/
	XaXxDYg==
X-Received: from pjbok9.prod.google.com ([2002:a17:90b:1d49:b0:359:964c:aba3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d604:b0:354:bfb7:db0c
 with SMTP id 98e67ed59e1d1-359a6a3bce5mr2280858a91.22.1772652648688; Wed, 04
 Mar 2026 11:30:48 -0800 (PST)
Date: Wed,  4 Mar 2026 19:28:38 +0000
In-Reply-To: <20260304193034.1870586-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260304193034.1870586-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304193034.1870586-8-kuniyu@google.com>
Subject: [PATCH v1 net-next 07/15] udp: Remove partial csum code in RX.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4D5DB2071A3
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264019-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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
 include/net/udp.h     | 17 ++-------
 include/net/udplite.h | 34 ------------------
 net/ipv4/udp.c        | 83 ++++++++-----------------------------------
 net/ipv6/udp.c        | 83 +++++++++++--------------------------------
 4 files changed, 38 insertions(+), 179 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 242dd850c760..27c3c0c9cf7c 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -31,11 +31,9 @@
 #include <linux/indirect_call_wrapper.h>
 
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
@@ -44,8 +42,6 @@ struct udp_skb_cb {
 		struct inet6_skb_parm	h6;
 #endif
 	} header;
-	__u16		cscov;
-	__u8		partial_cov;
 };
 #define UDP_SKB_CB(__skb)	((struct udp_skb_cb *)((__skb)->cb))
 
@@ -215,13 +211,11 @@ extern int sysctl_udp_wmem_min;
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
@@ -272,7 +266,6 @@ static inline void udp_csum_pull_header(struct sk_buff *skb)
 		skb->csum = csum_partial(skb->data, sizeof(struct udphdr),
 					 skb->csum);
 	skb_pull_rcsum(skb, sizeof(struct udphdr));
-	UDP_SKB_CB(skb)->cscov -= sizeof(struct udphdr);
 }
 
 typedef struct sock *(*udp_lookup_t)(const struct sk_buff *skb, __be16 sport,
@@ -640,9 +633,6 @@ static inline struct sk_buff *udp_rcv_segment(struct sock *sk,
 
 static inline void udp_post_segment_fix_csum(struct sk_buff *skb)
 {
-	/* UDP-lite can't land here - no GRO */
-	WARN_ON_ONCE(UDP_SKB_CB(skb)->partial_cov);
-
 	/* UDP packets generated with UDP_SEGMENT and traversing:
 	 *
 	 * UDP tunnel(xmit) -> veth (segmentation) -> veth (gro) -> UDP tunnel (rx)
@@ -656,7 +646,6 @@ static inline void udp_post_segment_fix_csum(struct sk_buff *skb)
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
index 034203319578..1fc87a1b081d 100644
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
@@ -2439,42 +2434,6 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -2608,29 +2567,14 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
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
@@ -2658,7 +2602,7 @@ static int udp_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
 {
 	int ret;
 
-	if (inet_get_convert_csum(sk) && uh->check && !IS_UDPLITE(sk))
+	if (inet_get_convert_csum(sk) && uh->check)
 		skb_checksum_try_convert(skb, IPPROTO_UDP, inet_compute_pseudo);
 
 	ret = udp_queue_rcv_skb(sk, skb);
@@ -2703,14 +2647,15 @@ static int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	if (ulen > skb->len)
 		goto short_packet;
 
-	if (proto == IPPROTO_UDP) {
-		/* UDP validates ulen. */
-		if (ulen < sizeof(*uh) || pskb_trim_rcsum(skb, ulen))
+	/* UDP validates ulen. */
+	if (ulen < sizeof(*uh)) {
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
index 07308b7156a6..49100b9e78cd 100644
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
@@ -1132,26 +1093,24 @@ static int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
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
+	/* UDP validates ulen. */
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


