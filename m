Return-Path: <netdev+bounces-264561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIjjB8P6qWk7JAEAu9opvQ
	(envelope-from <netdev+bounces-264561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:50:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FB3218A7D
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6F6E3030FCF
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 21:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC47A3603DD;
	Thu,  5 Mar 2026 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j8lH4XhJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544DA35F5F9
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747432; cv=none; b=T2CVy9suvEr3IFkw8+8Rf7AJXIfjY+iAxsNq3bFWLP65YJubNhXjUNNUapYH+YskAD9+XSPar25lCUvcTW6NQwWxVkgoYR83NXmKe7zTDMfENkc4BjnDEqp4AaXUoYSX4C/q4ccqQmZWqOnR3wcnoYizzEQ0uxlEMtFct/FTDJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747432; c=relaxed/simple;
	bh=LbfqhkyIjSD96r6zvNMmWBsCPtWbaotlOFq3RNNZmEQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kxdak63nUslOspiLaI/qNYAMgIREJoVwAQsVvdQKFOIJXXI4gsApWsshpxpfG/paA+C/SW3IYBU5ZkZ1pXxmWSHtf3S2bnNgGXhujvvbKXNqnTZUDwns/eyFWn0FgOAnpuB7hY4SQWUyq8SjRJV1rOBSuWHUg81xzZhkOIBj5lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j8lH4XhJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae3f446ccfso53093665ad.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 13:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772747431; x=1773352231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f9y9/YcJaBMGqGTgmQjeiJTFrQ5BMS1nyXfY+BJq8fw=;
        b=j8lH4XhJ+3HS61TNHzD8+EnEYYukjy+zziRBTWFdBwz/AFdZITA6xa0scJ9WN9slYp
         DJcfpL8hNNHavaIXtNl1azr8Uq/tr5h663VmEE9A3jlVoNk+503JgcN07noO0AlcUxW7
         DiwEd3DtR0dlZ5LdRbY6ayCNARlcGKbTpfvz0unNse1PgQPkTdYTBeHuDa7tl5hcKk+B
         d7he0ZzpPSs/vWmseu34Jbtd/1NrGse/8nuYi0FKbWBebh821J8+lbQ88dl2pxh9i9t2
         GD0/aIH135ZRnEBtPOzSMsHSkya8uOD+B5vqSK7mo1pZBgD+7LU3CC8IFGKa/2BeNsCk
         dQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747431; x=1773352231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9y9/YcJaBMGqGTgmQjeiJTFrQ5BMS1nyXfY+BJq8fw=;
        b=KcIThNXECS2NgXvvkCcbC4h2nVx3TrQ91BjNU9pigl+/7s4mf5ePMgZHgyq3M9Zg6b
         Pg1RMRWTxORGWVSeTRtxI7a+jKsr5wsjkWnjf/xu8gkIgj+gdrRkmXClL7Mc7MxAv9I6
         FzKiEITmY9tOnA536Oz7MNZ1gcC8tkk/E5YARrYXvEZ4kCVA33gAHRFuIMjPSeomRTIv
         aVKF572EFcX/psB0veiAuyEKd36MKDfr7HrVb9HCDnjy/JybG/PuWO60WtSHod3MtYsO
         9EMNh0mmts6r0gau0iwdXZ9YHr3Pl2iXjHhrawz5KuC5HNBMwupuvFZ0zY638OhyfFhj
         N+ow==
X-Forwarded-Encrypted: i=1; AJvYcCX8cAE8/r7ShrkjiUz4o1KC6dCykLtBMmKT01otJizb8c0HRiclByFSNN94lEeGxOKKvrEtoYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQcMtPkoAn5hM86CWFttb077l19XPbLoz3wESIjcL9iMh2n/8
	Fft3ZTY1gzcnvxgWamTTri6ivz9WAFluJed7Mh9izJC+1ZvWRNj9nyLGi5NtLCSAydkxn+yG1DG
	q9gdcUQ==
X-Received: from plly23.prod.google.com ([2002:a17:902:7c97:b0:2ad:ca86:4f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c40d:b0:2ae:5b64:12d2
 with SMTP id d9443c01a7336-2ae82458878mr326805ad.40.1772747430402; Thu, 05
 Mar 2026 13:50:30 -0800 (PST)
Date: Thu,  5 Mar 2026 21:49:53 +0000
In-Reply-To: <20260305215013.2984628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305215013.2984628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305215013.2984628-8-kuniyu@google.com>
Subject: [PATCH v2 net-next 07/15] udp: Remove partial csum code in RX.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: B9FB3218A7D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264561-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,strlen.de,google.com,gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/net/udp.h     | 17 ++-------
 include/net/udplite.h | 34 ------------------
 net/ipv4/udp.c        | 83 ++++++++-----------------------------------
 net/ipv6/udp.c        | 83 +++++++++++--------------------------------
 4 files changed, 38 insertions(+), 179 deletions(-)

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
index 38ce5d887878..51a3e3d3d4a9 100644
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


