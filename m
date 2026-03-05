Return-Path: <netdev+bounces-264562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDe7Ecn6qWncIwEAu9opvQ
	(envelope-from <netdev+bounces-264562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:51:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2802E218A8C
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E40530390B4
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 21:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8419F3612D7;
	Thu,  5 Mar 2026 21:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXuhnbRQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D10A35F5FE
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747434; cv=none; b=q4FaK5UoT8pAAffhYTYAh4i/YLlb/N4eMo0D77JPzsQjpl4TeFlymcBieAjUrV9H8qjEPnYQ2J9oe1XNrKFE9UOjhcPPko6EfSA4vqPuQuFSYxbRViMo0EhHmcrVK+euuXe9/7s1uuX7Sk+V2PIFvgsfyFcRTSGWiceLgN9Usjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747434; c=relaxed/simple;
	bh=wlQd6krDjzcLBn2YP0rHnxH+3AF+G7CCkiYFb/aJ8xo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i/7KjcU2MgXs9GXGD0Jz/D18zZdr5LeM9BGuiKCQ6+jYVhwOGVqf1Co8CIOmO2Kgf1xh+ZNiiBr74VXecfXs3MN411H+cv0t5soooe7CCW1hc1oJ8kap/qc2yg7P9dGgZiYL2/xGmP2ogcvNVKn24U11eYjr4HktiUiBW4Gn+BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JXuhnbRQ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c737b6686ddso1311445a12.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 13:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772747432; x=1773352232; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a+2PaH7WouXSU7Nxnshd86swVTl/hiAOIEUvdyoPU08=;
        b=JXuhnbRQqjXT33WKbaHqe/+5q/JlG1kOtDAHTXu0tW+K5IFwXy4voNMB4qLGcLr0KY
         +YfcgTcn79lcWuzRvjXkhhJ3lMHJB3As3exfK+6bwraqsat1h3UOtwLtzgPzjMfJJIiV
         1qTu2PjsW6IH5US+/qePVhgetWmUaKSOpzVwn2PTZrisLBpVDHhtR/3UYkhvZ2WFCqHU
         M0db5AvhDGQHYBbVd+Pz94NKOlTx//uW/xYCWmKgICA17rXZqJabtH9k5utYYd8mZMF0
         +q9MR9+rPWj40qRkv1/4i5rquG+kD3LTXbNe9q5Z+qcH2lwmj09VIylGN0C7ca7E6f7x
         GTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747432; x=1773352232;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+2PaH7WouXSU7Nxnshd86swVTl/hiAOIEUvdyoPU08=;
        b=g5YBzjPNTHuQgd8FXVD8YJ+VyDlw7ceiJjqScCEuGlTL3V7qWnRdjYKfz05Waz/8Od
         clQb+xpcJXXxYAglfmNdZ3kykWC3kKS3cCctVCzb63Rm52nU/vWKoHi7JhcscrmK+ldP
         1wW/e3XeYHTvvFSy6v2/yFEwQQrqC3swOKpPoQwgG2N+IYr7v0J5LGrP7Fhi7WZBx2F4
         ++4ryk+VdpXxAioUdeB3t+xmacHpaOXtr4drxAJ/c0ZlAO2wLSEBclETX2w3TjTu9+ju
         nNdSXojERx7VhaaYxWWOwuQ3baPH5sxewOaJH0xnjbnu+M2aOmX1H4VHanp6nD9jryyk
         rLng==
X-Forwarded-Encrypted: i=1; AJvYcCUdUDB4gLgMSb1wh3xpNlRTOUjxM1WTJDzzMJ0xWDwK8JUgKYX7h8OtMVpoe+jUMINz4a4WR9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj65b56EUpJ+Jx5jt4O0doQc2ryXY9ViuMzZAeF8g1qaVmwtlT
	oo28nnHayQNg1Be1BZCI4bSi3QIr6Fb/XprZ9hHE1mKyJfTz7bpPjroBaR+ELYA6SyIu3ktWLrt
	yGMPZZA==
X-Received: from pgbcn9.prod.google.com ([2002:a05:6a02:a89:b0:c73:9c66:99b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748c:b0:36a:d3c9:efa5
 with SMTP id adf61e73a8af0-398590b65ecmr25029637.52.1772747432072; Thu, 05
 Mar 2026 13:50:32 -0800 (PST)
Date: Thu,  5 Mar 2026 21:49:54 +0000
In-Reply-To: <20260305215013.2984628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305215013.2984628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305215013.2984628-9-kuniyu@google.com>
Subject: [PATCH v2 net-next 08/15] udp: Remove partial csum code in TX.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2802E218A8C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264562-lists,netdev=lfdr.de];
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

UDP TX paths also have some code for UDP-Lite partial
checksum:

  * udplite_csum() in udp_send_skb() and udp_v6_send_skb()
  * udplite_getfrag() in udp_sendmsg() and udpv6_sendmsg()

Let's remove such code.

Now, we can use IPPROTO_UDP directly instead of sk->sk_protocol
or fl6->flowi6_proto for csum_tcpudp_magic() and csum_ipv6_magic().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/net/udplite.h | 35 --------------------------
 net/ipv4/udp.c        | 58 ++++++++++++++++---------------------------
 net/ipv6/udp.c        | 54 +++++++++++++++++++---------------------
 3 files changed, 47 insertions(+), 100 deletions(-)

diff --git a/include/net/udplite.h b/include/net/udplite.h
index 0456a14c993b..6bfa1d6833d1 100644
--- a/include/net/udplite.h
+++ b/include/net/udplite.h
@@ -12,39 +12,4 @@
 #define UDPLITE_SEND_CSCOV   10 /* sender partial coverage (as sent)      */
 #define UDPLITE_RECV_CSCOV   11 /* receiver partial coverage (threshold ) */
 
-/*
- *	Checksum computation is all in software, hence simpler getfrag.
- */
-static __inline__ int udplite_getfrag(void *from, char *to, int  offset,
-				      int len, int odd, struct sk_buff *skb)
-{
-	struct msghdr *msg = from;
-	return copy_from_iter_full(to, len, &msg->msg_iter) ? 0 : -EFAULT;
-}
-
-/*
- * 	Checksumming routines
- */
-
-/* Fast-path computation of checksum. Socket may not be locked. */
-static inline __wsum udplite_csum(struct sk_buff *skb)
-{
-	const int off = skb_transport_offset(skb);
-	const struct sock *sk = skb->sk;
-	int len = skb->len - off;
-
-	if (udp_test_bit(UDPLITE_SEND_CC, sk)) {
-		u16 pcslen = READ_ONCE(udp_sk(sk)->pcslen);
-
-		if (pcslen < len) {
-			if (pcslen > 0)
-				len = pcslen;
-			udp_hdr(skb)->len = htons(pcslen);
-		}
-	}
-	skb->ip_summed = CHECKSUM_NONE;     /* no HW support for checksumming */
-
-	return skb_checksum(skb, off, len, 0);
-}
-
 #endif	/* _UDPLITE_H */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 51a3e3d3d4a9..7d83e694115c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1120,20 +1120,19 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 			struct inet_cork *cork)
 {
 	struct sock *sk = skb->sk;
-	struct inet_sock *inet = inet_sk(sk);
+	int offset, len, datalen;
 	struct udphdr *uh;
 	int err;
-	int is_udplite = IS_UDPLITE(sk);
-	int offset = skb_transport_offset(skb);
-	int len = skb->len - offset;
-	int datalen = len - sizeof(*uh);
-	__wsum csum = 0;
+
+	offset = skb_transport_offset(skb);
+	len = skb->len - offset;
+	datalen = len - sizeof(*uh);
 
 	/*
 	 * Create a UDP header
 	 */
 	uh = udp_hdr(skb);
-	uh->source = inet->inet_sport;
+	uh->source = inet_sk(sk)->inet_sport;
 	uh->dest = fl4->fl4_dport;
 	uh->len = htons(len);
 	uh->check = 0;
@@ -1154,7 +1153,7 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 			kfree_skb(skb);
 			return -EINVAL;
 		}
-		if (is_udplite || dst_xfrm(skb_dst(skb))) {
+		if (dst_xfrm(skb_dst(skb))) {
 			kfree_skb(skb);
 			return -EIO;
 		}
@@ -1170,26 +1169,18 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 		}
 	}
 
-	if (is_udplite)  				 /*     UDP-Lite      */
-		csum = udplite_csum(skb);
-
-	else if (sk->sk_no_check_tx) {			 /* UDP csum off */
-
+	if (sk->sk_no_check_tx) {			 /* UDP csum off */
 		skb->ip_summed = CHECKSUM_NONE;
 		goto send;
-
 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) { /* UDP hardware csum */
 csum_partial:
-
 		udp4_hwcsum(skb, fl4->saddr, fl4->daddr);
 		goto send;
-
-	} else
-		csum = udp_csum(skb);
+	}
 
 	/* add protocol-dependent pseudo-header */
 	uh->check = csum_tcpudp_magic(fl4->saddr, fl4->daddr, len,
-				      sk->sk_protocol, csum);
+				      IPPROTO_UDP, udp_csum(skb));
 	if (uh->check == 0)
 		uh->check = CSUM_MANGLED_0;
 
@@ -1270,26 +1261,23 @@ EXPORT_IPV6_MOD_GPL(udp_cmsg_send);
 
 int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
+	int corkreq = udp_test_bit(CORK, sk) || msg->msg_flags & MSG_MORE;
 	DEFINE_RAW_FLEX(struct ip_options_rcu, opt_copy, opt.__data,
 			IP_OPTIONS_DATA_FIXED_SIZE);
+	DECLARE_SOCKADDR(struct sockaddr_in *, usin, msg->msg_name);
+	int ulen = len, free = 0, connected = 0;
 	struct inet_sock *inet = inet_sk(sk);
 	struct udp_sock *up = udp_sk(sk);
-	DECLARE_SOCKADDR(struct sockaddr_in *, usin, msg->msg_name);
+	__be32 daddr, faddr, saddr;
+	struct rtable *rt = NULL;
 	struct flowi4 fl4_stack;
-	struct flowi4 *fl4;
-	int ulen = len;
 	struct ipcm_cookie ipc;
-	struct rtable *rt = NULL;
-	int free = 0;
-	int connected = 0;
-	__be32 daddr, faddr, saddr;
-	u8 scope;
-	__be16 dport;
-	int err, is_udplite = IS_UDPLITE(sk);
-	int corkreq = udp_test_bit(CORK, sk) || msg->msg_flags & MSG_MORE;
-	int (*getfrag)(void *, char *, int, int, int, struct sk_buff *);
 	struct sk_buff *skb;
+	struct flowi4 *fl4;
+	__be16 dport;
 	int uc_index;
+	u8 scope;
+	int err;
 
 	if (len > 0xFFFF)
 		return -EMSGSIZE;
@@ -1301,8 +1289,6 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (msg->msg_flags & MSG_OOB) /* Mirror BSD error message compatibility */
 		return -EOPNOTSUPP;
 
-	getfrag = is_udplite ? udplite_getfrag : ip_generic_getfrag;
-
 	fl4 = &inet->cork.fl.u.ip4;
 	if (READ_ONCE(up->pending)) {
 		/*
@@ -1444,7 +1430,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 		flowi4_init_output(fl4, ipc.oif, ipc.sockc.mark,
 				   ipc.tos & INET_DSCP_MASK, scope,
-				   sk->sk_protocol, flow_flags, faddr, saddr,
+				   IPPROTO_UDP, flow_flags, faddr, saddr,
 				   dport, inet->inet_sport,
 				   sk_uid(sk));
 
@@ -1478,7 +1464,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (!corkreq) {
 		struct inet_cork cork;
 
-		skb = ip_make_skb(sk, fl4, getfrag, msg, ulen,
+		skb = ip_make_skb(sk, fl4, ip_generic_getfrag, msg, ulen,
 				  sizeof(struct udphdr), &ipc, &rt,
 				  &cork, msg->msg_flags);
 		err = PTR_ERR(skb);
@@ -1509,7 +1495,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 do_append_data:
 	up->len += ulen;
-	err = ip_append_data(sk, fl4, getfrag, msg, ulen,
+	err = ip_append_data(sk, fl4, ip_generic_getfrag, msg, ulen,
 			     sizeof(struct udphdr), &ipc, &rt,
 			     corkreq ? msg->msg_flags|MSG_MORE : msg->msg_flags);
 	if (err)
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 49100b9e78cd..402b3b821480 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1371,13 +1371,13 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 			   struct inet_cork *cork)
 {
 	struct sock *sk = skb->sk;
+	int offset, len, datalen;
 	struct udphdr *uh;
 	int err = 0;
-	int is_udplite = IS_UDPLITE(sk);
-	__wsum csum = 0;
-	int offset = skb_transport_offset(skb);
-	int len = skb->len - offset;
-	int datalen = len - sizeof(*uh);
+
+	offset = skb_transport_offset(skb);
+	len = skb->len - offset;
+	datalen = len - sizeof(*uh);
 
 	/*
 	 * Create a UDP header
@@ -1404,7 +1404,7 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 			kfree_skb(skb);
 			return -EINVAL;
 		}
-		if (is_udplite || dst_xfrm(skb_dst(skb))) {
+		if (dst_xfrm(skb_dst(skb))) {
 			kfree_skb(skb);
 			return -EIO;
 		}
@@ -1420,21 +1420,18 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 		}
 	}
 
-	if (is_udplite)
-		csum = udplite_csum(skb);
-	else if (udp_get_no_check6_tx(sk)) {   /* UDP csum disabled */
+	if (udp_get_no_check6_tx(sk)) {   /* UDP csum disabled */
 		skb->ip_summed = CHECKSUM_NONE;
 		goto send;
 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) { /* UDP hardware csum */
 csum_partial:
 		udp6_hwcsum_outgoing(sk, skb, &fl6->saddr, &fl6->daddr, len);
 		goto send;
-	} else
-		csum = udp_csum(skb);
+	}
 
 	/* add protocol-dependent pseudo-header */
 	uh->check = csum_ipv6_magic(&fl6->saddr, &fl6->daddr,
-				    len, fl6->flowi6_proto, csum);
+				    len, IPPROTO_UDP, udp_csum(skb));
 	if (uh->check == 0)
 		uh->check = CSUM_MANGLED_0;
 
@@ -1474,27 +1471,26 @@ static int udp_v6_push_pending_frames(struct sock *sk)
 
 int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
-	struct ipv6_txoptions opt_space;
-	struct udp_sock *up = udp_sk(sk);
-	struct inet_sock *inet = inet_sk(sk);
-	struct ipv6_pinfo *np = inet6_sk(sk);
+	int corkreq = udp_test_bit(CORK, sk) || msg->msg_flags & MSG_MORE;
 	DECLARE_SOCKADDR(struct sockaddr_in6 *, sin6, msg->msg_name);
-	struct in6_addr *daddr, *final_p, final;
-	struct ipv6_txoptions *opt = NULL;
 	struct ipv6_txoptions *opt_to_free = NULL;
+	struct in6_addr *daddr, *final_p, final;
 	struct ip6_flowlabel *flowlabel = NULL;
+	struct inet_sock *inet = inet_sk(sk);
+	struct ipv6_pinfo *np = inet6_sk(sk);
+	struct ipv6_txoptions *opt = NULL;
+	struct udp_sock *up = udp_sk(sk);
+	struct ipv6_txoptions opt_space;
+	int addr_len = msg->msg_namelen;
 	struct inet_cork_full cork;
-	struct flowi6 *fl6 = &cork.fl.u.ip6;
-	struct dst_entry *dst;
 	struct ipcm6_cookie ipc6;
-	int addr_len = msg->msg_namelen;
 	bool connected = false;
+	struct dst_entry *dst;
+	struct flowi6 *fl6;
 	int ulen = len;
-	int corkreq = udp_test_bit(CORK, sk) || msg->msg_flags & MSG_MORE;
 	int err;
-	int is_udplite = IS_UDPLITE(sk);
-	int (*getfrag)(void *, char *, int, int, int, struct sk_buff *);
 
+	fl6 = &cork.fl.u.ip6;
 	ipcm6_init_sk(&ipc6, sk);
 	ipc6.gso_size = READ_ONCE(up->gso_size);
 
@@ -1553,7 +1549,6 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (len > INT_MAX - sizeof(struct udphdr))
 		return -EMSGSIZE;
 
-	getfrag  =  is_udplite ?  udplite_getfrag : ip_generic_getfrag;
 	if (READ_ONCE(up->pending)) {
 		if (READ_ONCE(up->pending) == AF_INET)
 			return udp_sendmsg(sk, msg, len);
@@ -1655,7 +1650,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	opt = ipv6_fixup_options(&opt_space, opt);
 	ipc6.opt = opt;
 
-	fl6->flowi6_proto = sk->sk_protocol;
+	fl6->flowi6_proto = IPPROTO_UDP;
 	fl6->flowi6_mark = ipc6.sockc.mark;
 	fl6->daddr = *daddr;
 	if (ipv6_addr_any(&fl6->saddr) && !ipv6_addr_any(&np->saddr))
@@ -1722,7 +1717,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (!corkreq) {
 		struct sk_buff *skb;
 
-		skb = ip6_make_skb(sk, getfrag, msg, ulen,
+		skb = ip6_make_skb(sk, ip_generic_getfrag, msg, ulen,
 				   sizeof(struct udphdr), &ipc6,
 				   dst_rt6_info(dst),
 				   msg->msg_flags, &cork);
@@ -1748,8 +1743,9 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 do_append_data:
 	up->len += ulen;
-	err = ip6_append_data(sk, getfrag, msg, ulen, sizeof(struct udphdr),
-			      &ipc6, fl6, dst_rt6_info(dst),
+	err = ip6_append_data(sk, ip_generic_getfrag, msg, ulen,
+			      sizeof(struct udphdr), &ipc6, fl6,
+			      dst_rt6_info(dst),
 			      corkreq ? msg->msg_flags|MSG_MORE : msg->msg_flags);
 	if (err)
 		udp_v6_flush_pending_frames(sk);
-- 
2.53.0.473.g4a7958ca14-goog


