Return-Path: <netdev+bounces-170964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF303A4ADC4
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 21:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDAD87A72C9
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 20:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6651E9900;
	Sat,  1 Mar 2025 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L0LeM8eg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAE51E8837
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740860073; cv=none; b=WzmRXS5hxgLGfLRP+nP+yPQzNR3L1w7MzgnSJF12YJpX14O8KvzA64qrGWA+XMWUd/9sHvJ2mQ9Sk8GjxA2wWOFPF4BRrjHg4L3x6sar1MhA8oLiJXD0aVJ0vyCcWS63rlg2xB87C9LdemdW4L8HkR0NFmzvDkkdjPUauI/UYjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740860073; c=relaxed/simple;
	bh=jJEg6DPCUrCdloRmhIEpIIn3TlheT8iOCqKCFwjnDNY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iCE7CIEFOhbiJMwL6Gg3r5evhknL4Z5hVI+Pi28FjCo+OSPeBlMuFHnyIkdQOEFSq5KO6YCg9FFh1L3QFEQWu4p8YpZ7/L+5ROvvcwfo433mKcWEkE//jWHuJVv98ltC+Ubxzt0qjwljCqoUmvi5cCxAKx4U5+4UwhEiMT7qNYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L0LeM8eg; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-474bb848a7dso31264241cf.2
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 12:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740860070; x=1741464870; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m3Gyz5Irr4onbWnuRNrk3cSUnmfOdTGAT+oq3uDi84M=;
        b=L0LeM8egyKA5QLjMdvkq6Lf0zl45FehMG8Kz6Chny0+tbn6PLp17UNfMC/E3Ih70XZ
         O/lKc1cLts/NuGMf5h54glWAazF0TmgYEcXpI5iUZ+HEz3oPSJmEMrlwmK/TwOt7+0yL
         ObUIukNTqJAetU13d0ur/doYRNTKk4WBEGs6DcCtI8Q4Pc6uIZKodM3dYRFIHdbslrbI
         wrH8ORXGIKYzEbDmfagk+giaUSnjslLmvq75itoWh15/mTSCMsVh5ZSM8oPQpoHCMmlE
         n0L93Ix16hg06Yth6jWmrsDC2bqcq1BpCFLFmYLGFq+OVSwBWcpNcidtu2ep2Jhh/Cvi
         YFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740860070; x=1741464870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3Gyz5Irr4onbWnuRNrk3cSUnmfOdTGAT+oq3uDi84M=;
        b=oFkQwYQGXVJFSkMcXrhiXgp2uDWRWEDAqwk2t8Kv0aCOFXZviKo4iAt4zUxX5EdT38
         N8aXl0FSm6pJWmXlvt7RDFqJXqLoFK0HJ6R0pIsjmuxxwevg3tvr9SD98CSFHTc3TGY/
         LLLzEsJfXOOBHDnBXU8YhKw9g+YJ8Cmjp1jcsye2B/4eE4hPr1F5I9vXLI/jimot6/qs
         B+sBfBNv/jQDJ6sFUWIK2rRYnarpQmkvajlTHOEA6MPiwZYZj0btb3GRn5alUGEzLRXo
         9AoemJmzLlVpYLW4jobidzFtW05prcuCXu4W43HpUs7DNdI0mQoDWxzmhuIU2vYL9kVG
         GCvg==
X-Forwarded-Encrypted: i=1; AJvYcCU/bb6GW1+qwEFSe39vJxUDPJH9kjDVB7QWay+9Ip0lsMEJWUcQ6Mdx4qwT7O/9DqBpN4V2RD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZT87dIOx7L9RmPmhDbjX8J7s86yrqzaHPL/2aNo/zHOsNMnix
	rewQfe+aQiNZLajr/OxLNjl4kwnEMUWLzTs5VcOhWjIJaguiYuEDkNul0XbdD81J0API/qwqgEQ
	x5dX+qVzp+g==
X-Google-Smtp-Source: AGHT+IEHnIXAq5bw35LGECvPIokxcE1X1dEF9irvFqmAS3DdIBHluGiYgfL82FO7Q7ZXXLAwdboKAtMq2urjlw==
X-Received: from qtbbq12.prod.google.com ([2002:a05:622a:1c0c:b0:471:f86c:c303])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5751:0:b0:471:c962:11da with SMTP id d75a77b69052e-474bc0a1fc6mr125657141cf.27.1740860070654;
 Sat, 01 Mar 2025 12:14:30 -0800 (PST)
Date: Sat,  1 Mar 2025 20:14:21 +0000
In-Reply-To: <20250301201424.2046477-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250301201424.2046477-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250301201424.2046477-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/6] tcp: convert to dev_net_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

TCP uses of dev_net() are under RCU protection, change them
to dev_net_rcu() to get LOCKDEP support.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/inet6_hashtables.h |  2 +-
 include/net/inet_hashtables.h  |  2 +-
 net/ipv4/tcp_ipv4.c            | 12 ++++++------
 net/ipv4/tcp_metrics.c         |  6 +++---
 net/ipv6/tcp_ipv6.c            | 22 +++++++++++-----------
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 74dd90ff5f129fe4c8adad67a642ae5070410518..c32878c69179dac5a7fcfa098a297420d9adfab2 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -150,7 +150,7 @@ static inline struct sock *__inet6_lookup_skb(struct inet_hashinfo *hashinfo,
 					      int iif, int sdif,
 					      bool *refcounted)
 {
-	struct net *net = dev_net(skb_dst(skb)->dev);
+	struct net *net = dev_net_rcu(skb_dst(skb)->dev);
 	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	struct sock *sk;
 
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 5eea47f135a421ce8275d4cd83c5771b3f448e5c..da818fb0205fed6b4120946bc032e67e046b716f 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -492,7 +492,7 @@ static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
 					     const int sdif,
 					     bool *refcounted)
 {
-	struct net *net = dev_net(skb_dst(skb)->dev);
+	struct net *net = dev_net_rcu(skb_dst(skb)->dev);
 	const struct iphdr *iph = ip_hdr(skb);
 	struct sock *sk;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 218f01a8cc5f6c410043f07293e9e51840c1f1cb..ae07613e4f335063723f49d7fd70a240412922ef 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -494,14 +494,14 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 {
 	const struct iphdr *iph = (const struct iphdr *)skb->data;
 	struct tcphdr *th = (struct tcphdr *)(skb->data + (iph->ihl << 2));
-	struct tcp_sock *tp;
+	struct net *net = dev_net_rcu(skb->dev);
 	const int type = icmp_hdr(skb)->type;
 	const int code = icmp_hdr(skb)->code;
-	struct sock *sk;
 	struct request_sock *fastopen;
+	struct tcp_sock *tp;
 	u32 seq, snd_una;
+	struct sock *sk;
 	int err;
-	struct net *net = dev_net(skb->dev);
 
 	sk = __inet_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
 				       iph->daddr, th->dest, iph->saddr,
@@ -786,7 +786,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 	arg.iov[0].iov_base = (unsigned char *)&rep;
 	arg.iov[0].iov_len  = sizeof(rep.th);
 
-	net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
+	net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
 
 	/* Invalid TCP option size or twice included auth */
 	if (tcp_parse_auth_options(tcp_hdr(skb), &md5_hash_location, &aoh))
@@ -1961,7 +1961,7 @@ EXPORT_SYMBOL(tcp_v4_do_rcv);
 
 int tcp_v4_early_demux(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	const struct iphdr *iph;
 	const struct tcphdr *th;
 	struct sock *sk;
@@ -2172,7 +2172,7 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
 
 int tcp_v4_rcv(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	enum skb_drop_reason drop_reason;
 	int sdif = inet_sdif(skb);
 	int dif = inet_iif(skb);
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 95669935494ef8003a1877e2b86c76bd27307afd..4251670e328c83b55eff7bbda3cc3d97d78563a8 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -170,7 +170,7 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
 	bool reclaim = false;
 
 	spin_lock_bh(&tcp_metrics_lock);
-	net = dev_net(dst->dev);
+	net = dev_net_rcu(dst->dev);
 
 	/* While waiting for the spin-lock the cache might have been populated
 	 * with this entry and so we have to check again.
@@ -273,7 +273,7 @@ static struct tcp_metrics_block *__tcp_get_metrics_req(struct request_sock *req,
 		return NULL;
 	}
 
-	net = dev_net(dst->dev);
+	net = dev_net_rcu(dst->dev);
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
@@ -318,7 +318,7 @@ static struct tcp_metrics_block *tcp_get_metrics(struct sock *sk,
 	else
 		return NULL;
 
-	net = dev_net(dst->dev);
+	net = dev_net_rcu(dst->dev);
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d01088ab80d24eb0f829166faae791221d95bf9e..fe75ad8e606cbca77d69326dc00273e7b214edee 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -376,7 +376,7 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 {
 	const struct ipv6hdr *hdr = (const struct ipv6hdr *)skb->data;
 	const struct tcphdr *th = (struct tcphdr *)(skb->data+offset);
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	struct request_sock *fastopen;
 	struct ipv6_pinfo *np;
 	struct tcp_sock *tp;
@@ -866,16 +866,16 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 				 int oif, int rst, u8 tclass, __be32 label,
 				 u32 priority, u32 txhash, struct tcp_key *key)
 {
-	const struct tcphdr *th = tcp_hdr(skb);
-	struct tcphdr *t1;
-	struct sk_buff *buff;
-	struct flowi6 fl6;
-	struct net *net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
-	struct sock *ctl_sk = net->ipv6.tcp_sk;
+	struct net *net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
 	unsigned int tot_len = sizeof(struct tcphdr);
+	struct sock *ctl_sk = net->ipv6.tcp_sk;
+	const struct tcphdr *th = tcp_hdr(skb);
 	__be32 mrst = 0, *topt;
 	struct dst_entry *dst;
-	__u32 mark = 0;
+	struct sk_buff *buff;
+	struct tcphdr *t1;
+	struct flowi6 fl6;
+	u32 mark = 0;
 
 	if (tsecr)
 		tot_len += TCPOLEN_TSTAMP_ALIGNED;
@@ -1041,7 +1041,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
 	if (!sk && !ipv6_unicast_destination(skb))
 		return;
 
-	net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
+	net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
 	/* Invalid TCP option size or twice included auth */
 	if (tcp_parse_auth_options(th, &md5_hash_location, &aoh))
 		return;
@@ -1740,6 +1740,7 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
 
 INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 {
+	struct net *net = dev_net_rcu(skb->dev);
 	enum skb_drop_reason drop_reason;
 	int sdif = inet6_sdif(skb);
 	int dif = inet6_iif(skb);
@@ -1749,7 +1750,6 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	bool refcounted;
 	int ret;
 	u32 isn;
-	struct net *net = dev_net(skb->dev);
 
 	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (skb->pkt_type != PACKET_HOST)
@@ -2001,7 +2001,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 
 void tcp_v6_early_demux(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	const struct ipv6hdr *hdr;
 	const struct tcphdr *th;
 	struct sock *sk;
-- 
2.48.1.711.g2feabab25a-goog


