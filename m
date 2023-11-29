Return-Path: <netdev+bounces-51970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0BA7FCCE5
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D7D28335F
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02E73D7B;
	Wed, 29 Nov 2023 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nG5ADdOr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E41C1727
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 18:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701225087; x=1732761087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RY503YBjusXJKrPjOxDrCVl/izYp7cWf6KspGXBhZSg=;
  b=nG5ADdOrvNbvurKWW/aczAYkZ5nKvhq60y1weNUIEOK4Kwo1XpZnc8zY
   WTVypa/3QNJ/6Z79EGBbnOa4QOKzvwO1I94q16SgxpCoI/QzBAEKWNUCR
   3+FRmIaef4dkEW9ijp2xMhZNojBi3nogbWKJdI2qeEOH+DT06kNai5Mjs
   4=;
X-IronPort-AV: E=Sophos;i="6.04,234,1695686400"; 
   d="scan'208";a="47017046"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:31:26 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id 2446F40D80;
	Wed, 29 Nov 2023 02:31:26 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:20157]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.167:2525] with esmtp (Farcaster)
 id 4b8a7391-cacd-4f6e-b3a6-6d2d87a103fd; Wed, 29 Nov 2023 02:31:25 +0000 (UTC)
X-Farcaster-Flow-ID: 4b8a7391-cacd-4f6e-b3a6-6d2d87a103fd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 29 Nov 2023 02:31:24 +0000
Received: from 88665a182662.ant.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 02:31:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Eric
 Dumazet" <edumazert@google.com>
Subject: [PATCH v3 net-next 4/8] tcp: Don't pass cookie to __cookie_v[46]_check().
Date: Tue, 28 Nov 2023 18:29:20 -0800
Message-ID: <20231129022924.96156-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231129022924.96156-1-kuniyu@amazon.com>
References: <20231129022924.96156-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

tcp_hdr(skb) and SYN Cookie are passed to __cookie_v[46]_check(), but
none of the callers passes cookie other than ntohl(th->ack_seq) - 1.

Let's fetch it in __cookie_v[46]_check() instead of passing the cookie
over and over.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Eric Dumazet <edumazert@google.com>
---
 include/linux/netfilter_ipv6.h   |  8 ++++----
 include/net/tcp.h                |  6 ++----
 net/core/filter.c                | 15 ++++-----------
 net/ipv4/syncookies.c            | 15 ++++++++-------
 net/ipv6/syncookies.c            | 15 ++++++++-------
 net/netfilter/nf_synproxy_core.c |  4 ++--
 6 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/include/linux/netfilter_ipv6.h b/include/linux/netfilter_ipv6.h
index 7834c0be2831..61aa48f46dd7 100644
--- a/include/linux/netfilter_ipv6.h
+++ b/include/linux/netfilter_ipv6.h
@@ -51,7 +51,7 @@ struct nf_ipv6_ops {
 	u32 (*cookie_init_sequence)(const struct ipv6hdr *iph,
 				    const struct tcphdr *th, u16 *mssp);
 	int (*cookie_v6_check)(const struct ipv6hdr *iph,
-			       const struct tcphdr *th, __u32 cookie);
+			       const struct tcphdr *th);
 #endif
 	void (*route_input)(struct sk_buff *skb);
 	int (*fragment)(struct net *net, struct sock *sk, struct sk_buff *skb,
@@ -179,16 +179,16 @@ static inline u32 nf_ipv6_cookie_init_sequence(const struct ipv6hdr *iph,
 }
 
 static inline int nf_cookie_v6_check(const struct ipv6hdr *iph,
-				     const struct tcphdr *th, __u32 cookie)
+				     const struct tcphdr *th)
 {
 #if IS_ENABLED(CONFIG_SYN_COOKIES)
 #if IS_MODULE(CONFIG_IPV6)
 	const struct nf_ipv6_ops *v6_ops = nf_get_ipv6_ops();
 
 	if (v6_ops)
-		return v6_ops->cookie_v6_check(iph, th, cookie);
+		return v6_ops->cookie_v6_check(iph, th);
 #elif IS_BUILTIN(CONFIG_IPV6)
-	return __cookie_v6_check(iph, th, cookie);
+	return __cookie_v6_check(iph, th);
 #endif
 #endif
 	return 0;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index d2f0736b76b8..2b2c79c7bbcd 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -491,8 +491,7 @@ void inet_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb);
 struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 				 struct request_sock *req,
 				 struct dst_entry *dst, u32 tsoff);
-int __cookie_v4_check(const struct iphdr *iph, const struct tcphdr *th,
-		      u32 cookie);
+int __cookie_v4_check(const struct iphdr *iph, const struct tcphdr *th);
 struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb);
 struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 					    const struct tcp_request_sock_ops *af_ops,
@@ -586,8 +585,7 @@ bool cookie_ecn_ok(const struct tcp_options_received *opt,
 		   const struct net *net, const struct dst_entry *dst);
 
 /* From net/ipv6/syncookies.c */
-int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th,
-		      u32 cookie);
+int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th);
 struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb);
 
 u32 __cookie_v6_init_sequence(const struct ipv6hdr *iph,
diff --git a/net/core/filter.c b/net/core/filter.c
index 7e4d7c3bcc84..0adaa4afa35f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7238,7 +7238,6 @@ BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len
 	   struct tcphdr *, th, u32, th_len)
 {
 #ifdef CONFIG_SYN_COOKIES
-	u32 cookie;
 	int ret;
 
 	if (unlikely(!sk || th_len < sizeof(*th)))
@@ -7260,8 +7259,6 @@ BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len
 	if (tcp_synq_no_recent_overflow(sk))
 		return -ENOENT;
 
-	cookie = ntohl(th->ack_seq) - 1;
-
 	/* Both struct iphdr and struct ipv6hdr have the version field at the
 	 * same offset so we can cast to the shorter header (struct iphdr).
 	 */
@@ -7270,7 +7267,7 @@ BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len
 		if (sk->sk_family == AF_INET6 && ipv6_only_sock(sk))
 			return -EINVAL;
 
-		ret = __cookie_v4_check((struct iphdr *)iph, th, cookie);
+		ret = __cookie_v4_check((struct iphdr *)iph, th);
 		break;
 
 #if IS_BUILTIN(CONFIG_IPV6)
@@ -7281,7 +7278,7 @@ BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len
 		if (sk->sk_family != AF_INET6)
 			return -EINVAL;
 
-		ret = __cookie_v6_check((struct ipv6hdr *)iph, th, cookie);
+		ret = __cookie_v6_check((struct ipv6hdr *)iph, th);
 		break;
 #endif /* CONFIG_IPV6 */
 
@@ -7734,9 +7731,7 @@ static const struct bpf_func_proto bpf_tcp_raw_gen_syncookie_ipv6_proto = {
 BPF_CALL_2(bpf_tcp_raw_check_syncookie_ipv4, struct iphdr *, iph,
 	   struct tcphdr *, th)
 {
-	u32 cookie = ntohl(th->ack_seq) - 1;
-
-	if (__cookie_v4_check(iph, th, cookie) > 0)
+	if (__cookie_v4_check(iph, th) > 0)
 		return 0;
 
 	return -EACCES;
@@ -7757,9 +7752,7 @@ BPF_CALL_2(bpf_tcp_raw_check_syncookie_ipv6, struct ipv6hdr *, iph,
 	   struct tcphdr *, th)
 {
 #if IS_BUILTIN(CONFIG_IPV6)
-	u32 cookie = ntohl(th->ack_seq) - 1;
-
-	if (__cookie_v6_check(iph, th, cookie) > 0)
+	if (__cookie_v6_check(iph, th) > 0)
 		return 0;
 
 	return -EACCES;
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 8b7d7d7788af..c08428d63d11 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -189,12 +189,14 @@ __u32 cookie_v4_init_sequence(const struct sk_buff *skb, __u16 *mssp)
  * Check if a ack sequence number is a valid syncookie.
  * Return the decoded mss if it is, or 0 if not.
  */
-int __cookie_v4_check(const struct iphdr *iph, const struct tcphdr *th,
-		      u32 cookie)
+int __cookie_v4_check(const struct iphdr *iph, const struct tcphdr *th)
 {
+	__u32 cookie = ntohl(th->ack_seq) - 1;
 	__u32 seq = ntohl(th->seq) - 1;
-	__u32 mssind = check_tcp_syn_cookie(cookie, iph->saddr, iph->daddr,
-					    th->source, th->dest, seq);
+	__u32 mssind;
+
+	mssind = check_tcp_syn_cookie(cookie, iph->saddr, iph->daddr,
+				      th->source, th->dest, seq);
 
 	return mssind < ARRAY_SIZE(msstab) ? msstab[mssind] : 0;
 }
@@ -332,7 +334,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 {
 	struct ip_options *opt = &TCP_SKB_CB(skb)->header.h4.opt;
 	const struct tcphdr *th = tcp_hdr(skb);
-	__u32 cookie = ntohl(th->ack_seq) - 1;
 	struct tcp_options_received tcp_opt;
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_request_sock *ireq;
@@ -354,7 +355,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	if (tcp_synq_no_recent_overflow(sk))
 		goto out;
 
-	mss = __cookie_v4_check(ip_hdr(skb), th, cookie);
+	mss = __cookie_v4_check(ip_hdr(skb), th);
 	if (mss == 0) {
 		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
 		goto out;
@@ -384,7 +385,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	ireq = inet_rsk(req);
 	treq = tcp_rsk(req);
 	treq->rcv_isn		= ntohl(th->seq) - 1;
-	treq->snt_isn		= cookie;
+	treq->snt_isn		= ntohl(th->ack_seq) - 1;
 	treq->ts_off		= 0;
 	treq->txhash		= net_tx_rndhash();
 	req->mss		= mss;
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 106376cbc9de..4cd26c481168 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -114,12 +114,14 @@ __u32 cookie_v6_init_sequence(const struct sk_buff *skb, __u16 *mssp)
 	return __cookie_v6_init_sequence(iph, th, mssp);
 }
 
-int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th,
-		      __u32 cookie)
+int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th)
 {
+	__u32 cookie = ntohl(th->ack_seq) - 1;
 	__u32 seq = ntohl(th->seq) - 1;
-	__u32 mssind = check_tcp_syn_cookie(cookie, &iph->saddr, &iph->daddr,
-					    th->source, th->dest, seq);
+	__u32 mssind;
+
+	mssind = check_tcp_syn_cookie(cookie, &iph->saddr, &iph->daddr,
+				      th->source, th->dest, seq);
 
 	return mssind < ARRAY_SIZE(msstab) ? msstab[mssind] : 0;
 }
@@ -128,7 +130,6 @@ EXPORT_SYMBOL_GPL(__cookie_v6_check);
 struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
-	__u32 cookie = ntohl(th->ack_seq) - 1;
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct tcp_options_received tcp_opt;
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -150,7 +151,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	if (tcp_synq_no_recent_overflow(sk))
 		goto out;
 
-	mss = __cookie_v6_check(ipv6_hdr(skb), th, cookie);
+	mss = __cookie_v6_check(ipv6_hdr(skb), th);
 	if (mss == 0) {
 		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
 		goto out;
@@ -213,7 +214,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	req->ts_recent		= tcp_opt.saw_tstamp ? tcp_opt.rcv_tsval : 0;
 	treq->snt_synack	= 0;
 	treq->rcv_isn = ntohl(th->seq) - 1;
-	treq->snt_isn = cookie;
+	treq->snt_isn = ntohl(th->ack_seq) - 1;
 	treq->ts_off = 0;
 	treq->txhash = net_tx_rndhash();
 
diff --git a/net/netfilter/nf_synproxy_core.c b/net/netfilter/nf_synproxy_core.c
index 467671f2d42f..fbbc4fd37349 100644
--- a/net/netfilter/nf_synproxy_core.c
+++ b/net/netfilter/nf_synproxy_core.c
@@ -617,7 +617,7 @@ synproxy_recv_client_ack(struct net *net,
 	struct synproxy_net *snet = synproxy_pernet(net);
 	int mss;
 
-	mss = __cookie_v4_check(ip_hdr(skb), th, ntohl(th->ack_seq) - 1);
+	mss = __cookie_v4_check(ip_hdr(skb), th);
 	if (mss == 0) {
 		this_cpu_inc(snet->stats->cookie_invalid);
 		return false;
@@ -1034,7 +1034,7 @@ synproxy_recv_client_ack_ipv6(struct net *net,
 	struct synproxy_net *snet = synproxy_pernet(net);
 	int mss;
 
-	mss = nf_cookie_v6_check(ipv6_hdr(skb), th, ntohl(th->ack_seq) - 1);
+	mss = nf_cookie_v6_check(ipv6_hdr(skb), th);
 	if (mss == 0) {
 		this_cpu_inc(snet->stats->cookie_invalid);
 		return false;
-- 
2.30.2


