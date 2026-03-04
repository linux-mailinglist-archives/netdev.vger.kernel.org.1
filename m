Return-Path: <netdev+bounces-264020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AmrDauIqGn2vQAAu9opvQ
	(envelope-from <netdev+bounces-264020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:31:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D85E20719B
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6B25302A7E7
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 19:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99CB3B3BE5;
	Wed,  4 Mar 2026 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GSGn2fO6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B693D1CCA
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652652; cv=none; b=a470PAz3DAsfCy48K3q5yZZFSqsLM9mj53Z+Mh4OlM4y7hOi9kA+gIaQ81HD2Bk7eA/eVPTs6sGm86pD/o3D1yGq3F4i+Sg5B9HN7AttyAzIgaK+3e5htk7AAuazNQ/PEWdf112cjOIPo2c3DJGxo/DdeEYg9ddMeCByv0pXG0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652652; c=relaxed/simple;
	bh=fOhXhdaxWPN5f5+U8zDZfuq6U8qBy66tgFPkPmaVank=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rzGLhbcQGQXTKGwXc6kOct9NJjrqTu86oqZqyJxSd4Qp8N8e8oFRfRUqnM3zXTag0cB1zeSIK1mYUVJIEtuhyeQyo/K241gzZzWf5v2TPDiA+GDWzg7InDe5btIdeMzMlkpkdAcQaZ3W+oUYaSb6mH0iFv1Pt79VgAGM90Q798o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GSGn2fO6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c737ced4036so485144a12.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 11:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772652650; x=1773257450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=24KE5RMQJnToNOubRCFrHR8VRMDcJZWLR2Vu1vp5L+Y=;
        b=GSGn2fO6TGjlgu7gB0wVdX5iNL8gec6AKZjSxy+HNt4gpMIxz69iEMZmeiDqqTn/0K
         aHeB7moz+cQbGl3C25s+qTmzypBpP/tuOqfBS2c20q5NstU+kzVa5d6ZarHRQLZBta1V
         RuDaZd8f4jYM7LZlQNuSGKmE1Nx42FS4kbb8INIILHqeLpZBz3afa1D4yhu+CK2uQBG9
         H3DLgENKQBRiezfVH3bl5yHAT9UjEaAFbYGYBvI7zJ8mD+dvgA2r0l5SdLBNtHwFSnjL
         Gab9hHhYGxKgrr3kIMLRwHMS8+bN1wTsJ1/Qkn/nPK4Jxmub1x2SFUVHs0MFXJsl9YY/
         4x+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652650; x=1773257450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24KE5RMQJnToNOubRCFrHR8VRMDcJZWLR2Vu1vp5L+Y=;
        b=SHTBrPLjCOYu/LZLGMtnbsw2ULO98VnTw4YvSD7hSTzVvsX4hCa7TozmLx4O8EBzUN
         WRTWufiVKwaS6l3qt1Rd+ipL5yWGZ2AfEmnzTCl3rU/rPH7YUpW3FJFRe1O+z55oiidZ
         idYE/wT4uUzX0I0bJwYfNRK5OgHf2Pdy4Ui0n/AkHAUPk10Oh6/Yc3i3sLOGHQI938O2
         BU/zsPPh3VLNpnSTJHtClTdMVQ3r0OW0+YXWCNf+0MD5HdJ3fyEd27nlHXNUTdMV1R3b
         q243wdRR+qedWSnhrlJwfj6K/RyUieVMNqUV7nn9P+fT3TZou7S363c5LLNRbGwqm3o6
         h+fQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0QKYgkTxidfO3PiYv1r8ynjuoa+cghvxmojjAKpnv/GnPFYn4S/6JBhqV3SJTl2KTXBxnge8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9JUmRcR3i1s9nC4qIEcrwjeQDHvdlKonG1CIyTmUxdsH7Wzjk
	ocb9w8a2SQ1w1V+k9McA9uLjKqL82AV9/SMz4ve6JVOfuBj70LlhCMy106S2rwm1/aMZp5I5ukD
	9IgwJ8w==
X-Received: from pgac15.prod.google.com ([2002:a05:6a02:294f:b0:c6e:228a:f070])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e93:b0:35d:5d40:6d78
 with SMTP id adf61e73a8af0-3982e1757f4mr2953019637.46.1772652650319; Wed, 04
 Mar 2026 11:30:50 -0800 (PST)
Date: Wed,  4 Mar 2026 19:28:39 +0000
In-Reply-To: <20260304193034.1870586-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260304193034.1870586-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304193034.1870586-9-kuniyu@google.com>
Subject: [PATCH v1 net-next 08/15] udp: Remove partial csum code in TX.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5D85E20719B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264020-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

UDP TX paths also have some code for UDP-Lite partial
checksum:

  * udplite_csum() in udp_send_skb() and udp_v6_send_skb()
  * udplite_getfrag() in udp_sendmsg() and udpv6_sendmsg()

Let's remove such code.

Now, we can use IPPROTO_UDP directly instead of sk->sk_protocol
or fl6->flowi6_proto for csum_tcpudp_magic() and csum_ipv6_magic().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
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
index 1fc87a1b081d..efdab50a58a0 100644
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


