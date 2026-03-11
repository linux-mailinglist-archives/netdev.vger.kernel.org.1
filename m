Return-Path: <netdev+bounces-266473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOzzJur7sGnCpQIAu9opvQ
	(envelope-from <netdev+bounces-266473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:21:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9AE25C60F
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB549311C7F8
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC9D31F98E;
	Wed, 11 Mar 2026 05:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RC5MTJ71"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB17F274B32
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206441; cv=none; b=dNjlzUMQxUd9qspYr1dNjxaJrrbBZyYvXnZCLwhjNLQ904RScKzLf9N5hDKVmlFzxaa3ERVpg+BVgrNZvDSlTGSAQ+jWxrhwUIvRibOMXg5FYcAnmJT0MvHOPzgUyhV2KvCQJhYE/MJQ30WSnuYrPHKl5pkO/7AwQDXhdZBjrHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206441; c=relaxed/simple;
	bh=ulyEzYbnBu0F0jAi6nXoH32XA1fkCs2V8/kzPM4BjCE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fKZV5TnSPGl69//frBoJ9YN25FkE5qi4iLeiqxjJ8+ubuSCku7QAI+NtjdQ1i+jy7aSeVyhVTtZrp69RANJ8riLmU7wLYsLS9UJ+HG6w2Q9bqJpmOSaoSdEBU5AGgBmOfwcO20UFdqw2aOQmiC82cEdtE3jLuwW3N3tF26m7mvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RC5MTJ71; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae669a8ff1so419277195ad.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773206439; x=1773811239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4f5WB44Mo9d3CDsmWXp8rhxbpI98M/vyBo88SvZeuMY=;
        b=RC5MTJ71EaSaTsHgzaN5AASkgxWAVLSHR0hjw09wgdzXVv/N+z69upbINcvuE2IPm+
         mbvIThbYhvZI7WQG3BriTS4pQ9V1OUT3goctHpkQEpIHMv3R0OdFul97NXJLMgs5nqgC
         BFKwKzn/ZIOAArxLyEjIGISzyCX7YTylFAUNQVa1/Sem2HlqdQF1EzUy+x05eZJCylCi
         rs+Jesnz40MNOue72vKKFlqOrqlnC8O2lckLLfBp3JzT/uvh4MGiQ4xswqpiXonyknON
         +plrXQGt/yvKm+Ky0qd8i36rNtaOXn+JU8fpuYB79E8STz+LmT9A0dyHtv9UT+JgFUo9
         eMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206439; x=1773811239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4f5WB44Mo9d3CDsmWXp8rhxbpI98M/vyBo88SvZeuMY=;
        b=C8AIfbfFHlkXW9Fqs20N/f7k6yyLBjEPzXgzzL2taua3qS3iT9VZjuc8Yej+S4ZE0k
         pmsjq53MEMTLV82IcY315sf77YE1lT3DKoafsIi7Kwa+Md7RrnokJMePL0ihDlKBj99V
         iI9ltzvwQMg5uR3duMvH/SOEU65KXFRzzygIOllMqh1YcghA8QX2/gDi8TtRpqYWWoxh
         G3te+vmYry8ibLp9ihnEzd6Hv2Xo1kHHUMDfCjwkgzuKwciFLw8gpZUebMT6GvbF1jaR
         1+zviwt4vFwVvrMyVp4kZiXxnVhJsCavf9lsIwc0XPyrJQ4eKltnFP3hNB2KJ3Bd9y8v
         QtnA==
X-Forwarded-Encrypted: i=1; AJvYcCWzr1u149z3+SpXgLaKL3E/h9W2z9ByGZ2AAcn3+zab4JCDOoJFmwCjL6CnlQAHuOkFn7y2BZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIZd4i4L8P4vWc9qJOKHenQgJBjNgW4W4wOnB2wsvTYP3q4Q6u
	OiZnIMvgw8j7G6C3EwGcU+1fQRuphSP3VzGnpU9/cMKofGERHlvRCB5MLSPlUhdcMOKkCXLA0DO
	tWol0AA==
X-Received: from plbkp6.prod.google.com ([2002:a17:903:2806:b0:2aa:d708:7f2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f92:b0:2ae:593c:48fe
 with SMTP id d9443c01a7336-2aeae7a3d47mr13727475ad.13.1773206439147; Tue, 10
 Mar 2026 22:20:39 -0700 (PDT)
Date: Wed, 11 Mar 2026 05:19:55 +0000
In-Reply-To: <20260311052020.1213705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311052020.1213705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311052020.1213705-9-kuniyu@google.com>
Subject: [PATCH v3 net-next 08/15] udp: Remove partial csum code in TX.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 3B9AE25C60F
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
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266473-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,strlen.de,google.com,gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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
index d42fb9330c22..9a2c8ff96e83 100644
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
index bf5430ea66f0..511e3f898be5 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1370,13 +1370,13 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
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
@@ -1403,7 +1403,7 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 			kfree_skb(skb);
 			return -EINVAL;
 		}
-		if (is_udplite || dst_xfrm(skb_dst(skb))) {
+		if (dst_xfrm(skb_dst(skb))) {
 			kfree_skb(skb);
 			return -EIO;
 		}
@@ -1419,21 +1419,18 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
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
 
@@ -1473,27 +1470,26 @@ static int udp_v6_push_pending_frames(struct sock *sk)
 
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
 
@@ -1552,7 +1548,6 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (len > INT_MAX - sizeof(struct udphdr))
 		return -EMSGSIZE;
 
-	getfrag  =  is_udplite ?  udplite_getfrag : ip_generic_getfrag;
 	if (READ_ONCE(up->pending)) {
 		if (READ_ONCE(up->pending) == AF_INET)
 			return udp_sendmsg(sk, msg, len);
@@ -1654,7 +1649,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	opt = ipv6_fixup_options(&opt_space, opt);
 	ipc6.opt = opt;
 
-	fl6->flowi6_proto = sk->sk_protocol;
+	fl6->flowi6_proto = IPPROTO_UDP;
 	fl6->flowi6_mark = ipc6.sockc.mark;
 	fl6->daddr = *daddr;
 	if (ipv6_addr_any(&fl6->saddr) && !ipv6_addr_any(&np->saddr))
@@ -1721,7 +1716,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (!corkreq) {
 		struct sk_buff *skb;
 
-		skb = ip6_make_skb(sk, getfrag, msg, ulen,
+		skb = ip6_make_skb(sk, ip_generic_getfrag, msg, ulen,
 				   sizeof(struct udphdr), &ipc6,
 				   dst_rt6_info(dst),
 				   msg->msg_flags, &cork);
@@ -1747,8 +1742,9 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
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


