Return-Path: <netdev+bounces-295458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mpJGIjMBImr5RQEAu9opvQ
	(envelope-from <netdev+bounces-295458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:50:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B61643DDC
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:50:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Nqnuyzoj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295458-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295458-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 496EB304EA29
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF6A18CC13;
	Thu,  4 Jun 2026 22:47:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15E029E117
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:47:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613248; cv=none; b=dPcpdr+Cxf1Yf+SPVqzgxCIlcM+7RE+lV65UkDiRdAG4FIqGdEo+Uu3DeBvFgj4Ok7eqTv77kXO7vmjdmmaGmBS19cAUpbpx4238LIcSngZRX8Qjwok8Gq/ot/xrXAJGSSNxDWxnkRtEa0AjsNrhXRdWPkuw78Gbaps15OlFeDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613248; c=relaxed/simple;
	bh=6pLcVcN7xh4CDhA4JS0zGRY9mdAa8AFNN6bUow8/VVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RwHB2RyFHwpTZnjrlMdp10Zbm1s6LU6rtKpnFC40ev+UvIv3S3tnw3M5qqxPqKo7/CjlJcDHA8cTHcQ1KfvoXtbm/JYLoHTcpkLxxfhXrHgaQL3UIYB8zo8C+9lXeJtQV7Ns0Ce2nqx2ExV2cewVLlbZt+dSzQoh4RzfTt5Tbrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nqnuyzoj; arc=none smtp.client-ip=209.85.216.74
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d6389bbf4so1135001a91.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780613245; x=1781218045; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XvZEheOknSj4SDQgEshO0akCDgpLmkqRad0rN6bw3Es=;
        b=Nqnuyzoj1hcbeyaj6Yn2LCZm78M7s+Xu5/6qwmjjVyLRKjGrh62G8RyzU9yjRRWPNV
         63QPFNAe4vdB16ykWsSKzZbF6xnR4g5T+1pD9NEPvhVbG6HZqMY8CYkr2r3ByxOPYe4m
         VZj1qoND+WXfqIZyAENDdo+Gq+xWciFUJbldnGTyTdQd9tjHPjrInjNU0gMPkDI6abht
         8Km8KCmgEz+TdzshEHEM+cqtHbn5VMz+cAIByP8lweNJbv0dKk2Ja+RJ07NApnqmDvfz
         QYKJvp6f5vp1wpuqaonosYM+UMX3KMzoCS2sXlKVkToXRADdT9J0NsxXsJA8D3hyV2+z
         6q4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780613245; x=1781218045;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvZEheOknSj4SDQgEshO0akCDgpLmkqRad0rN6bw3Es=;
        b=oS3VeAbDgQJWANlhfT3YitMZi8OLMqz+JsHB6zCCF8NNhGBS0fEXsaGEcjAqQnj7yI
         /q9WeqvJUzYkDU6KoI1/5ZV313gLrN0UZVtRDsmlvupecaZuTs+Id/ODSUy8RaaUBaNK
         kDysDSxcsTijXUDgZxqtXfsVyiPY+sSSlfH29pAgDxsCozFFlaI+/4kpoUnBG/twFkrP
         ZjfvxQESXve7iYjN2usmcN+JI16hbB64HyNwHJt/0gJmFFUgjx612Y4MNlmyU476uc6+
         GBOkmutMPSALMNzp93UNj5EG6U0QFehNXLQL6KhWZgHG8zx2et+/R40xHcvFJUzHSFiZ
         7hPw==
X-Forwarded-Encrypted: i=1; AFNElJ/LMviLLS7N5a/AhIj4Fcr5/G+4668qbnZb9BiiLB7mPJwEiqUO0jkRjwQG6SByfYSdNTC5oZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwH2Ns+Be+yaLXW86CkJLQKzk0SMCd4wZCnQnl4E07X02f46q0
	5l3GNdPtQwLqpXMZPXk320britdh49xu5pw/H5JL9+G6p6mc3gMTAEbCnFMgpuIGLQmbCi472AD
	JkF591Q==
X-Received: from pfqr1.prod.google.com ([2002:aa7:9ec1:0:b0:842:4878:6a38])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e390:b0:3b4:8e36:5fb6
 with SMTP id adf61e73a8af0-3b4ccd1e5cdmr1160844637.2.1780613244923; Thu, 04
 Jun 2026 15:47:24 -0700 (PDT)
Date: Thu,  4 Jun 2026 22:46:25 +0000
In-Reply-To: <20260604224712.3209821-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604224712.3209821-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604224712.3209821-8-kuniyu@google.com>
Subject: [PATCH v3 net-next 07/15] net: Remove rtnl_held of struct fib_dump_filter.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295458-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7B61643DDC

Commit 22e36ea9f5d7 ("inet: allow ip_valid_fib_dump_req() to
be called with RTNL or RCU") introduced the rtnl_held field in
struct fib_dump_filter to switch __dev_get_by_index() and
dev_get_by_index_rcu() depending on the caller's context.

This field served as an interim measure while we were incrementally
converting all callers of ip_valid_fib_dump_req() to RCU.

Now that all users (IPv4, IPv6, ipmr, ip6mr, and MPLS) have
been converted to RCU, the field is no longer necessary.

Let's remove it.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/ip_fib.h    |  1 -
 net/ipv4/fib_frontend.c | 19 ++++++-------------
 net/ipv4/ipmr.c         |  4 +---
 net/ipv6/ip6_fib.c      |  1 -
 net/ipv6/ip6mr.c        |  4 +---
 net/mpls/af_mpls.c      |  6 ++----
 6 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 318593743b6e..1142ffad7444 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -269,7 +269,6 @@ struct fib_dump_filter {
 	bool			filter_set;
 	bool			dump_routes;
 	bool			dump_exceptions;
-	bool			rtnl_held;
 	unsigned char		protocol;
 	unsigned char		rt_type;
 	unsigned int		flags;
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 1dab44e13d3b..ceeb87b13b93 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -946,9 +946,6 @@ int ip_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
 	struct rtmsg *rtm;
 	int err, i;
 
-	if (filter->rtnl_held)
-		ASSERT_RTNL();
-
 	rtm = nlmsg_payload(nlh, sizeof(*rtm));
 	if (!rtm) {
 		NL_SET_ERR_MSG(extack, "Invalid header for FIB dump request");
@@ -992,10 +989,8 @@ int ip_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
 			break;
 		case RTA_OIF:
 			ifindex = nla_get_u32(tb[i]);
-			if (filter->rtnl_held)
-				filter->dev = __dev_get_by_index(net, ifindex);
-			else
-				filter->dev = dev_get_by_index_rcu(net, ifindex);
+
+			filter->dev = dev_get_by_index_rcu(net, ifindex);
 			if (!filter->dev)
 				return -ENODEV;
 			break;
@@ -1017,18 +1012,16 @@ EXPORT_SYMBOL_GPL(ip_valid_fib_dump_req);
 
 static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 {
+	const struct nlmsghdr *nlh = cb->nlh;
+	struct net *net = sock_net(skb->sk);
 	struct fib_dump_filter filter = {
 		.dump_routes = true,
 		.dump_exceptions = true,
-		.rtnl_held = false,
 	};
-	const struct nlmsghdr *nlh = cb->nlh;
-	struct net *net = sock_net(skb->sk);
-	unsigned int h, s_h;
-	unsigned int e = 0, s_e;
-	struct fib_table *tb;
+	unsigned int e = 0, s_e, h, s_h;
 	struct hlist_head *head;
 	int dumped = 0, err = 0;
+	struct fib_table *tb;
 
 	rcu_read_lock();
 	if (cb->strict_check) {
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 2628cd3a93a6..78dbeecf71bb 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2777,9 +2777,7 @@ static int ipmr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 
 static int ipmr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	struct fib_dump_filter filter = {
-		.rtnl_held = false,
-	};
+	struct fib_dump_filter filter = {};
 	int err;
 
 	rcu_read_lock();
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index b897b3c5023b..fc95738ded76 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -633,7 +633,6 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 	struct rt6_rtnl_dump_arg arg = {
 		.filter.dump_exceptions = true,
 		.filter.dump_routes = true,
-		.filter.rtnl_held = false,
 	};
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 380e5eb9416d..8c8ad1753c75 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2745,9 +2745,7 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 static int ip6mr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	const struct nlmsghdr *nlh = cb->nlh;
-	struct fib_dump_filter filter = {
-		.rtnl_held = false,
-	};
+	struct fib_dump_filter filter = {};
 	int err;
 
 	rcu_read_lock();
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 26340a7306b5..ca504d9626cf 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2221,12 +2221,10 @@ static bool mpls_rt_uses_dev(struct mpls_route *rt,
 
 static int mpls_dump_routes(struct sk_buff *skb, struct netlink_callback *cb)
 {
+	struct mpls_route __rcu **platform_label;
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
-	struct mpls_route __rcu **platform_label;
-	struct fib_dump_filter filter = {
-		.rtnl_held = false,
-	};
+	struct fib_dump_filter filter = {};
 	unsigned int flags = NLM_F_MULTI;
 	size_t platform_labels;
 	unsigned int index;
-- 
2.54.0.1032.g2f8565e1d1-goog


