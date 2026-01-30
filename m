Return-Path: <netdev+bounces-255261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBUlEfwdfWlQQQIAu9opvQ
	(envelope-from <netdev+bounces-255261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:09:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE262BEB54
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B131306FBF5
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C84D3876BE;
	Fri, 30 Jan 2026 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zyXqEBjx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D558B388876
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769806998; cv=none; b=NxxqpqBWRiIbZozz0q7RZ0KAR14vMsP/+/JjggJfm9Qd0tQJxWEArQD1hK7PfoN9fMJ+yGTmr/SqyN7GbFkDhnFTDC4yU4eF72udzy+wOqkNfcEEMjOkTnse65Xc6rV4MfMtCZLYUdvlWrMke+vKD4EMqB0uQESDCQmgW0MqQe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769806998; c=relaxed/simple;
	bh=w+sA1rtAhjCUPQoyuIxhCu2G9JO1zb/Gt3r9YsUIue4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zr1EtbQ4t1XuAXavMe4aIRSA2eEozBn42av4Tqi2M/5yM+/H3OCM//PdYn1EjLddlbJWzr0FFBsqp5YQlHsxltF71Ah9TNzP7bD/sS6m/pYPV5qHqg//ua5fR4ebWrYQzh/dEPk3QXjcapzERllVgtGaicEQMzIhe9hES5UTIbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zyXqEBjx; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-5033c483b76so84114081cf.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769806996; x=1770411796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZquStuqfSOsiiQmJc9tpnTqnmOQPWfq8rhVQJrfE7kA=;
        b=zyXqEBjxVHPxIXSR6n9xlIC+P+lvIHz7WJcDMaxTv0giwgstSYy13Q03stvykMojbt
         qEoJNm8YLVnzzrJz2++eVV/iAKQBtvEeYhksEKroOAp8sZeexbJGSz9+yhxXO5O3ojhT
         uUTnmlqHsgyXqAT8ZjAZKefiSzBm+IqAFcfZEIzOtuW+nRW0KL0cPqzCQfUACWK7iygZ
         Zbi8EIpW+W49DS8MAYgEFaEIilkrvZnAiOcyrt2t6sw8J2efGNOKAm1+JlbbVmUANNe6
         ubANVjROBolrLabt+Otbu2on0IBUCkBA1N4RuzBCEJDXrsNgG7A8glFl/cI6n4lsjGx7
         pS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769806996; x=1770411796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZquStuqfSOsiiQmJc9tpnTqnmOQPWfq8rhVQJrfE7kA=;
        b=W/deUS0Nsz0xbIB5AS/jfO3Bjt1nX9q1Rn6S9nN1hdbSGXyzbVJhttXrHbYymfX4HB
         4klTE0P5mX7elCBuoyf83yGnwaZKWt97BY00I9N+zbPFiIDZOkAuS2dhJ0lnfTVaaiVG
         ky6YM8WVEUOlQstF2nA0XAf1SJ6i2YdQ11XAEJwx96m3fKWHJ++jNDKLTpRbDPhp3T/b
         DxavPuL5suwB5v3bN8EvTKDdoIUSeKq/P8A3l1BCcS38ii58q/fnO0mB4ijON4xWNulX
         MJcMVH5kgdQwElRPicRATxbmleuuSSMKH4ES+Ra0NG0rr2rcG+PqrEJFnXRQ7+0yog8s
         FYvg==
X-Forwarded-Encrypted: i=1; AJvYcCWG9sDK/k1FGwJ73lcOylib6y1NEvBQZU0BpXQj91ECEa3ztEKN8VK42QQF2jkyf0y0gnqrHlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0AYrv2oxbuKPi1r4R4Kyjyeod1dAGoEURlCMOP8Qg5pqnv1UQ
	3sBLjLQAJcx6McgUDYAWbrpYI+7Ff1wp6wtShZ4rIobx94KkiMzMDQXwmBldKG4DCmDyFtKERhs
	NIIv7JmDT9/PAaw==
X-Received: from qtqp23.prod.google.com ([2002:ac8:7417:0:b0:503:3412:57be])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5a0e:0:b0:4ec:ee04:8831 with SMTP id d75a77b69052e-505d2297723mr62946611cf.57.1769806995742;
 Fri, 30 Jan 2026 13:03:15 -0800 (PST)
Date: Fri, 30 Jan 2026 21:03:02 +0000
In-Reply-To: <20260130210303.3888261-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260130210303.3888261-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260130210303.3888261-8-edumazet@google.com>
Subject: [PATCH net-next 7/8] ipv4: use dst4_mtu() instead of dst_mtu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255261-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE262BEB54
X-Rspamd-Action: no action

When we expect an IPv4 dst, use dst4_mtu() instead of dst_mtu()
to save some code space.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/icmp.c                     |  2 +-
 net/ipv4/ip_output.c                |  4 ++--
 net/ipv4/ip_sockglue.c              |  2 +-
 net/ipv4/ipmr.c                     |  2 +-
 net/ipv4/netfilter/nf_reject_ipv4.c |  2 +-
 net/ipv4/tcp_ipv4.c                 | 13 ++++++-------
 net/ipv6/sit.c                      |  2 +-
 7 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 19c9c838967f761a8b3a1b07cea5c5ec932bf12d..1d362a17a1c446e8d988162b164c5096a7f5d9dc 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -945,7 +945,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 
 	/* RFC says return as much as we can without exceeding 576 bytes. */
 
-	room = dst_mtu(&rt->dst);
+	room = dst4_mtu(&rt->dst);
 	if (room > 576)
 		room = 576;
 	room -= sizeof(struct iphdr) + icmp_param->replyopts.opt.optlen;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 75fcb58795bbbd97d9544c05b245675ad1d1383a..e4790cc7b5c2ec7d6893d4141ca250ec05a4a2f5 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1300,7 +1300,7 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 		return -EFAULT;
 
 	cork->fragsize = ip_sk_use_pmtu(sk) ?
-			 dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
+			 dst4_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
 
 	if (!inetdev_valid_mtu(cork->fragsize))
 		return -ENETUNREACH;
@@ -1439,7 +1439,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	pmtudisc = READ_ONCE(inet->pmtudisc);
 	if (pmtudisc == IP_PMTUDISC_DO ||
 	    pmtudisc == IP_PMTUDISC_PROBE ||
-	    (skb->len <= dst_mtu(&rt->dst) &&
+	    (skb->len <= dst4_mtu(&rt->dst) &&
 	     ip_dont_fragment(sk, &rt->dst)))
 		df = htons(IP_DF);
 
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 6d9c5c20b1c4f93bd54283b5aadbb9bc61c24685..c062d9519818024e01746eec20eb3c036226f77e 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1634,7 +1634,7 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		val = 0;
 		dst = sk_dst_get(sk);
 		if (dst) {
-			val = dst_mtu(dst);
+			val = dst4_mtu(dst);
 			dst_release(dst);
 		}
 		if (!val)
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index ca9eaee4c2ef5f5cdc03608291ad1a0dc187d657..131382c388e95707f27dd7d43be9b9ee2f62c85d 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1895,7 +1895,7 @@ static int ipmr_prepare_xmit(struct net *net, struct mr_table *mrt,
 			return -1;
 	}
 
-	if (skb->len+encap > dst_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
+	if (skb->len+encap > dst4_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
 		/* Do not fragment multicasts. Alas, IPv4 does not
 		 * allow to send ICMP, so that packets will disappear
 		 * to blackhole.
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index fae4aa4a5f0955849c6a4ba85bc925c33cd9e102..fecf6621f679f9d435803a7bd522b38bf3de7ef4 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -303,7 +303,7 @@ void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		goto free_nskb;
 
 	/* "Never happens" */
-	if (nskb->len > dst_mtu(skb_dst(nskb)))
+	if (nskb->len > dst4_mtu(skb_dst(nskb)))
 		goto free_nskb;
 
 	nf_ct_attach(nskb, oldskb);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ffdf52fbf6463b41d7c712f3710b681ecdf6e2d7..349ae751f9d0ea4090627717719c5afc573260fc 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -374,7 +374,7 @@ void tcp_v4_mtu_reduced(struct sock *sk)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	struct dst_entry *dst;
-	u32 mtu;
+	u32 mtu, dmtu;
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))
 		return;
@@ -386,15 +386,14 @@ void tcp_v4_mtu_reduced(struct sock *sk)
 	/* Something is about to be wrong... Remember soft error
 	 * for the case, if this connection will not able to recover.
 	 */
-	if (mtu < dst_mtu(dst) && ip_dont_fragment(sk, dst))
+	dmtu = dst4_mtu(dst);
+	if (mtu < dmtu && ip_dont_fragment(sk, dst))
 		WRITE_ONCE(sk->sk_err_soft, EMSGSIZE);
 
-	mtu = dst_mtu(dst);
-
 	if (inet->pmtudisc != IP_PMTUDISC_DONT &&
 	    ip_sk_accept_pmtu(sk) &&
-	    inet_csk(sk)->icsk_pmtu_cookie > mtu) {
-		tcp_sync_mss(sk, mtu);
+	    inet_csk(sk)->icsk_pmtu_cookie > dmtu) {
+		tcp_sync_mss(sk, dmtu);
 
 		/* Resend the TCP packet because it's
 		 * clear that the old packet has been
@@ -1760,7 +1759,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 
 	tcp_ca_openreq_child(newsk, dst);
 
-	tcp_sync_mss(newsk, dst_mtu(dst));
+	tcp_sync_mss(newsk, dst4_mtu(dst));
 	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index cf37ad9686e698bf781df84f348d89ea7160ec63..439c8a1c662520d1769c0a60a5e9ae2cc0196d15 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -962,7 +962,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 	}
 
 	if (df) {
-		mtu = dst_mtu(&rt->dst) - t_hlen;
+		mtu = dst4_mtu(&rt->dst) - t_hlen;
 
 		if (mtu < IPV4_MIN_MTU) {
 			DEV_STATS_INC(dev, collisions);
-- 
2.53.0.rc1.225.gd81095ad13-goog


