Return-Path: <netdev+bounces-276171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDx4IUR21WlC6gcAu9opvQ
	(envelope-from <netdev+bounces-276171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:25:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A9E3B5028
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0D3830DD02A
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532F437C11D;
	Tue,  7 Apr 2026 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZiMu4rld"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9316837CD51
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596820; cv=none; b=nspuj+V+B8nE41WVT0sjfgwrz7z82Dmgur68NDHYh4miofLDajXkQ/52GiiJ/RkaVKjaqX7bf3v6TONH9itbUxEjy+fI+duuQB7feNXAlhVdDFQVZUyVn1f/G5ye1vuUaR3qXIH5/7sVksgiLur8gWljxkTVjYIGnei+F6kagyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596820; c=relaxed/simple;
	bh=FjqwrGN/8gj3oCyZN7MQvjn/tvH4R4MQQh2VKaJfJWo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jQWMSR6FeTAaeMi31RmR8RYk2W43fJ6cg0s24TFId6GteTMf0azhi2sb4YE8UXtfc6MLbgfGP5+NCaz71QpuncSC+LtQoj1ldSLdG08X2DuM/FumwiYzNI0h7JIMJCvrbm5NKAtOlCQHqx840iNhZaz+TRqHYhU8+xoSE5JZGPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZiMu4rld; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b0be75dfd4so65408525ad.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775596817; x=1776201617; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ApelnbHimlZVV/b/WyiM4KiZS+jcbgo+Q9bzoIjLpRA=;
        b=ZiMu4rldrAhAO3IUHEl1KDPkIWSFbDd4Ta4TreGcfL2VnHq51bh8phUe3YXeURu6G3
         E7nceuJs0FovwmxHgCAgwvHMp0rddwjn7wGntM+oQo3NFStur6gy3f98JEG5OU1X4jXw
         Ltz4pWBWnbCQ3syaQpvyf92qai/QaO6BRFpgJdY6qSNIlnxcyAEAXdsuv2xK9o7Ckjdg
         EVsMHIS/dpAi0om+sj7UwEb4QIiYONpcRRVrbq+pyS8lUC4lu7QRzPCuu0JFKGtQ4IEE
         PtaRnn0JwX0m770MHzwp1ikg8sVkJWhALU2XhgLexv13tH93JBjAtXDVfE0P8XFN7nU9
         t26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596817; x=1776201617;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApelnbHimlZVV/b/WyiM4KiZS+jcbgo+Q9bzoIjLpRA=;
        b=pQqS1lS4hicq9VYwXEWUaK2UnJimIQgAroGHKHJS8YTiJ4GAHfNjN2TtjjkdiuwPPe
         yL2gtXPa3E1eabMnhIH2FPVr2T1QXvv57lajUKjuV6r7B/mvIqlbGOHpywEvBOxDLAZU
         dE8zvnmeEmmZxWGux84N89gZKQxDCYY3jo6n+wjVWssA1GykdRS5JTRa+VYHIJSCS/eF
         JaejodBJ/L3AaYTvrKlZdaTWE2KNeqhsqd4sf/vXPiLSwlJr5XhzLk2itX2ejx4nYgfe
         hgvF8+qBWn6pGc59LKKN6waUUbuUZc+b85MRp9mVVk/lPsIXg8WwWQnjqPRBaS/QeVeC
         nQXw==
X-Forwarded-Encrypted: i=1; AJvYcCWg1dFcHj+b+ugyGo0kTUMgqfta1K0ErVbyQXm+x6H3xnFJvlGEVgRFqK/g75RzNYAOsx8/I5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQL++RTXcU/M4gzYVTLR8en9CAyp3oF+IRwqVdBWAblVkR4/T4
	hIdioyd74a/W1fkpVVzNWqWwrY3OeAFsGtrI1w3Ns4I5d/bDmXwFU380Pd/p0uZiES6eVnN+zTt
	GdkAPCA==
X-Received: from plwp5.prod.google.com ([2002:a17:903:2485:b0:2b2:5974:d3cc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef4f:b0:2b0:663f:6b53
 with SMTP id d9443c01a7336-2b28180e4cfmr181351255ad.13.1775596816551; Tue, 07
 Apr 2026 14:20:16 -0700 (PDT)
Date: Tue,  7 Apr 2026 21:19:41 +0000
In-Reply-To: <20260407212001.2368593-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407212001.2368593-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407212001.2368593-9-kuniyu@google.com>
Subject: [PATCH v3 net-next 08/15] net: Remove rtnl_held of struct fib_dump_filter.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276171-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11A9E3B5028
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 2566b4a1f80b..c0fc606b0ae9 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2770,9 +2770,7 @@ static int ipmr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 
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
index cd28bea8c11a..b9c048b6f1ca 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2750,9 +2750,7 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
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
2.53.0.1213.gd9a14994de-goog


