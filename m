Return-Path: <netdev+bounces-277583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB/sLDVp2Wn5pQgAu9opvQ
	(envelope-from <netdev+bounces-277583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:18:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C363DCD1D
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D58B1302B70B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3554F3B0AE5;
	Fri, 10 Apr 2026 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UUOBafbN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F9E3ACA5B
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855866; cv=none; b=mlkzBGQzY7Mk3k7gEMcSvVWBwq+Ru8uV4GGDDs8b90pIsJk0pgntQ45Lid0X7O5ttZ8k2DZvaacIEBuoNGCvBYw+2J3RJuJb+n/uuHAm2OhIzuYAJ+Sv2MXtkSstnoMZejEJVOT3xAa6ut/FvxLgedk6QkThnssysbHkOUM1Brs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855866; c=relaxed/simple;
	bh=YixuOTkeXGZHhzz/HeFKmZaSkURnjaLWd0mQRKm4zOQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jGzLDP+pkicZ31bwmxwJsV42Jq5xm9EkbKgDmQNWIlZE56mti1Hyg3+7uiWKqbj7TtDQ/y1ojmk4ziKzGmCoRSvyWTEpcqEzCaMxOXmwDKzHYH/BVz4I92/XlMtmsKct6Dsg8f8VZQZ8FDNuOnsgilQ/DsDEr0XlJFFrw5IF33w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UUOBafbN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so1226171a12.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775855864; x=1776460664; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LuX3koZKD+gaWEQkVDGnOBIDv8RmAh11Z5LhM26grpg=;
        b=UUOBafbN5YiO1gnE4jt7XaJTjO9X39z7QXWWBtWj9lbqQDykFmkbLwzNmKNSumjGEn
         e1qskTudZdwvjm4r/4dw3iZXVQqrvRYCkdNuXCCaZMUtbLzfGjXXOoyJ3zWlprrTUfhk
         Vc8dRGOllq9xOIKAjxmIbdYRQPVhXjTbTLJY9zY4ou77bvDMrBA8X6ImcM4xSQDKLKvN
         PeKsollrDXGAJsuVt2KAXd9xboSjEA0G3D2ho28rCU1EFLDUO2rlbVhCgxIxhfHN6qAo
         qX0AeRvVDYXH5WWJRek+B7u8IRmrths7YaavLzaKe9ol7Qd6k8eCXhQG5TRMxaOWkh67
         cJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855864; x=1776460664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LuX3koZKD+gaWEQkVDGnOBIDv8RmAh11Z5LhM26grpg=;
        b=rkGyOPPE/CjISPivLEJMMy10E7wac5xfqKgh/juPgFZXi2giVla9NbA6vEIAkpcwWd
         Wrm2wGkxev/StaQQAHZTLBSjg2zncttXxqCG9x9dLvEwolUKsD9Vp2BE4qVwtCwsP2g1
         xBBh5/VOGKaq/oAMFpPStChK/0+UJzP7ml+AsRqG+KY8FQZJyTAGYo94blJBarrcWOFs
         2oZMBECt3NdAr7HY7BPzZfndBBDsee7Svnd49K2Pa5kSc7jE+dx/480U0oh4zVg9Nf4b
         zlqjRX9D8S5Sh04ghldRIm4CCxDRxJwJysxhgWGCjrkunaSMRw+58cGLb2/6JDozRoPT
         6Gxg==
X-Forwarded-Encrypted: i=1; AJvYcCUk9UoEZvLuZfqjijzrJs2sc2M75RNaVyabUmNrnugUOaoxz5G+eCfJ+KEJWlg6xt5jfpzzxrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2OVOplXoUPwOzWfE1aWhUF2FD9iY4HDejrEaKzLGRKjQp/1gb
	6T3lQnG4zcv4eA3VhTk9nObjyumERHweMxSxtdv4sQUPQIGTro/g1P7BJgyID3UQ424Sk57iNqH
	3o49fbQ==
X-Received: from pgbs65.prod.google.com ([2002:a63:5e44:0:b0:c0e:3543:bdb0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:728b:b0:395:acfc:b679
 with SMTP id adf61e73a8af0-39fc9509e72mr9390127637.18.1775855863933; Fri, 10
 Apr 2026 14:17:43 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:17:03 +0000
In-Reply-To: <20260410211726.1668756-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410211726.1668756-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410211726.1668756-8-kuniyu@google.com>
Subject: [PATCH v2 net-next 07/15] net: Remove rtnl_held of struct fib_dump_filter.
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277583-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8C363DCD1D
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
index 8a08d09b4c30..fa168513295d 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2767,9 +2767,7 @@ static int ipmr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 
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
index 9d02cd3b274c..2b04e52ec61c 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2747,9 +2747,7 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
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


