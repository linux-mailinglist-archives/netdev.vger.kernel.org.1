Return-Path: <netdev+bounces-184305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 617A9A948AD
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 20:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11DE318881F1
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 18:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE21920C47C;
	Sun, 20 Apr 2025 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8n4df9O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9DD1853
	for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745172345; cv=none; b=rGSjOPhN6DvCgWlELhzKjXcQ5xy7kTk8vj8IQZEDpPRsImsQpjw9pNRpJFkNnQ4SZz0CbmcZW/xRU8hyaejhYa4sGQu1fb6xpd44CDz0C3KfxXfZEQNNVflexrn8vTk7+bASZf8lSCw9p5SrrnwPQtUnmD/qeuA7CfQMIejO+qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745172345; c=relaxed/simple;
	bh=yRs/4KRnJWyuQQoFaKu6bc0w8h9lbnMjhVjj2mPzFrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DETRXd0voTXvdYR2OxtxKt8OONJrbofU89sNMUuvIINvtpUEM3u2fH5w5dmzjv40OChcFyr75sdRZ20CjBHqqSG8emWwjFTQalIUYxx9/K6/siAgpgHTcpEBkGc3hv3MwPWTCyB7BA5DGHn9iXNaKcKi6bf4LZYI4URd/d35H08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8n4df9O; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ecfbf8fa76so40162606d6.0
        for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 11:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745172343; x=1745777143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FNzZ56proBOBcHfkZtSoJqynYiPq0siS/n70Qcj5qw=;
        b=W8n4df9OCfyY6nHGO8bpNXk0KuNKsk5MtJo6Uzc5tgKTkD9ngaXK9W/UoimjuAwaoF
         9DXBf9mRpW/T/aTkUhGCsnFx+GE+EXEK5t4QULgoB/8iYl+j/m0OOr1SwB940PGkFEi8
         wk1a7ipd1mLrhJrxA4SuzJUkY/mqr4tvYAhNjyaI8/+Qb5pNoFy3v2nxnQJf5DWVPZoe
         mi42y01qkPaH2ezqY//02S/wFPZ3keaKOnnr2aEug9EsF5hT4FEhjarAYo5X752kUE/O
         V2z9P/TBBrRUWNwgR4Wfk9buJMu7Y7rBqKkqBO1VtnzguLwZiXGIV0Sc33iMVQt31/By
         s0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745172343; x=1745777143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FNzZ56proBOBcHfkZtSoJqynYiPq0siS/n70Qcj5qw=;
        b=XL8uUQGcGh9xtKhrStX1MgeJTnSqaexxGjCpq+qq1jgDwvFCu8oodIHUU3w3+08nBM
         cJkXkvJp170HfCc6gwY1jB519csi15xZz6Y5Uc4fjyEuOgTUxPMjePL1hSl3FFv05O8m
         AqfpGQEA8LWrPH1DLo1bv0aMf0Hu4mlwHizlvdOViYG0bWUeZHYS8QXcZkfQRbYBT3k7
         MRWuG9feQaX3xIg/OnCmQ4z36UvkCmmCFwoZILwdAr8TnOhgcN1DEd8PepoxS39SwfX7
         Por23NBC4BV0iP1v8KBq1sJs2Bq0yE2yPzhO0bfFGI+/XD4X99pIK+36vpQ+dYX4Qicf
         lnwA==
X-Gm-Message-State: AOJu0YxCBhAE6Wea2BM2gcZ9qdo9JTmh+kX/JKJc7HNiEaJ1ChXFuSuC
	0QDd7u4KNfEPjo7tuqtXSeLnFFaeUV92xEt3yvKZNGLsZdXQsSlUvUKdzg==
X-Gm-Gg: ASbGncto/yz1aCo1rRUwxtyXiUy8bm4c+t1tp8OFD2YUEVKTTCAs0XAmjGoCqkAZ1Yy
	W0luuKybHtcosjHgMnSgWVbzV+gt4BfSBVF43N+hYbFvSRZRueq3ZIEPgxDL3LA8UEfOO5eX0M8
	93WnhgMlAHaj2FkWmfdky66plbQ/gHyEcM7ruz8ELnfgrUD2VouoDmPOMBoTlMP4ZHkIKiei6El
	eRYIJyDCx/5XkKBIdxZBhieCeTSjgshH3AaX+EvA2YAzQf8gUqo4v7rDcv6FSjppI1DJFF6C03V
	Viq0OOJk3gd76oFjNae6jVSKH4Nxfh8Xika9uhvz7IvFaBL0hLrsJLezGuktF2Mbq7m6dTabPwQ
	BhJp1fxIrcSCOQypNfF1I5IlFP+cueuGgswqgL30GfCRBLWLozxQNZw==
X-Google-Smtp-Source: AGHT+IGrvx+aKR+4gQ+STpVGktMCyMx1q8Guw4R6zXNjAuVhDoIhF29SpVPdLlJprJzG5odHOWpylg==
X-Received: by 2002:ad4:5d6b:0:b0:6e8:ec85:831c with SMTP id 6a1803df08f44-6f2c4650cd9mr192308366d6.35.1745172342781;
        Sun, 20 Apr 2025 11:05:42 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c21cccsm34333676d6.106.2025.04.20.11.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 11:05:42 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	idosch@nvidia.com,
	kuniyu@amazon.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 1/3] ipv4: prefer multipath nexthop that matches source address
Date: Sun, 20 Apr 2025 14:04:29 -0400
Message-ID: <20250420180537.2973960-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
In-Reply-To: <20250420180537.2973960-1-willemdebruijn.kernel@gmail.com>
References: <20250420180537.2973960-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

With multipath routes, try to ensure that packets leave on the device
that is associated with the source address.

Avoid the following tcpdump example:

    veth0 Out IP 10.1.0.2.38640 > 10.2.0.3.8000: Flags [S]
    veth1 Out IP 10.1.0.2.38648 > 10.2.0.3.8000: Flags [S]

Which can happen easily with the most straightforward setup:

    ip addr add 10.0.0.1/24 dev veth0
    ip addr add 10.1.0.1/24 dev veth1

    ip route add 10.2.0.3 nexthop via 10.0.0.2 dev veth0 \
    			  nexthop via 10.1.0.2 dev veth1

This is apparently considered WAI, based on the comment in
ip_route_output_key_hash_rcu:

    * 2. Moreover, we are allowed to send packets with saddr
    *    of another iface. --ANK

It may be ok for some uses of multipath, but not all. For instance,
when using two ISPs, a router may drop packets with unknown source.

The behavior occurs because tcp_v4_connect makes three route
lookups when establishing a connection:

1. ip_route_connect calls to select a source address, with saddr zero.
2. ip_route_connect calls again now that saddr and daddr are known.
3. ip_route_newports calls again after a source port is also chosen.

With a route with multiple nexthops, each lookup may make a different
choice depending on available entropy to fib_select_multipath. So it
is possible for 1 to select the saddr from the first entry, but 3 to
select the second entry. Leading to the above situation.

Address this by preferring a match that matches the flowi4 saddr. This
will make 2 and 3 make the same choice as 1. Continue to update the
backup choice until a choice that matches saddr is found.

Do this in fib_select_multipath itself, rather than passing an fl4_oif
constraint, to avoid changing non-multipath route selection. Commit
e6b45241c57a ("ipv4: reset flowi parameters on route connect") shows
how that may cause regressions.

Also read ipv4.sysctl_fib_multipath_use_neigh only once. No need to
refresh in the loop.

This does not happen in IPv6, which performs only one lookup.

Signed-off-by: Willem de Bruijn <willemb@google.com>

Side-quest: I wonder if the second route lookup in ip_route_connect
is vestigial since the introduction of the third route lookup with
ip_route_newports. IPv6 has neither second nor third lookup, which
hints that perhaps both can be removed.
---
 include/net/ip_fib.h     |  3 ++-
 net/ipv4/fib_semantics.c | 39 +++++++++++++++++++++++++--------------
 net/ipv4/route.c         |  2 +-
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index e3864b74e92a..48bb3cf41469 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -574,7 +574,8 @@ static inline u32 fib_multipath_hash_from_keys(const struct net *net,
 
 int fib_check_nh(struct net *net, struct fib_nh *nh, u32 table, u8 scope,
 		 struct netlink_ext_ack *extack);
-void fib_select_multipath(struct fib_result *res, int hash);
+void fib_select_multipath(struct fib_result *res, int hash,
+			  const struct flowi4 *fl4);
 void fib_select_path(struct net *net, struct fib_result *res,
 		     struct flowi4 *fl4, const struct sk_buff *skb);
 
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index f68bb9e34c34..b5d21763dfaf 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2168,34 +2168,45 @@ static bool fib_good_nh(const struct fib_nh *nh)
 	return !!(state & NUD_VALID);
 }
 
-void fib_select_multipath(struct fib_result *res, int hash)
+void fib_select_multipath(struct fib_result *res, int hash,
+			  const struct flowi4 *fl4)
 {
 	struct fib_info *fi = res->fi;
 	struct net *net = fi->fib_net;
-	bool first = false;
+	bool found = false;
+	bool use_neigh;
+	__be32 saddr;
 
 	if (unlikely(res->fi->nh)) {
 		nexthop_path_fib_result(res, hash);
 		return;
 	}
 
+	use_neigh = READ_ONCE(net->ipv4.sysctl_fib_multipath_use_neigh);
+	saddr = fl4 ? fl4->saddr : 0;
+
 	change_nexthops(fi) {
-		if (READ_ONCE(net->ipv4.sysctl_fib_multipath_use_neigh)) {
-			if (!fib_good_nh(nexthop_nh))
-				continue;
-			if (!first) {
-				res->nh_sel = nhsel;
-				res->nhc = &nexthop_nh->nh_common;
-				first = true;
-			}
+		if (use_neigh && !fib_good_nh(nexthop_nh))
+			continue;
+
+		if (!found) {
+			res->nh_sel = nhsel;
+			res->nhc = &nexthop_nh->nh_common;
+			found = !saddr || nexthop_nh->nh_saddr == saddr;
 		}
 
 		if (hash > atomic_read(&nexthop_nh->fib_nh_upper_bound))
 			continue;
 
-		res->nh_sel = nhsel;
-		res->nhc = &nexthop_nh->nh_common;
-		return;
+		if (!saddr || nexthop_nh->nh_saddr == saddr) {
+			res->nh_sel = nhsel;
+			res->nhc = &nexthop_nh->nh_common;
+			return;
+		}
+
+		if (found)
+			return;
+
 	} endfor_nexthops(fi);
 }
 #endif
@@ -2210,7 +2221,7 @@ void fib_select_path(struct net *net, struct fib_result *res,
 	if (fib_info_num_path(res->fi) > 1) {
 		int h = fib_multipath_hash(net, fl4, skb, NULL);
 
-		fib_select_multipath(res, h);
+		fib_select_multipath(res, h, fl4);
 	}
 	else
 #endif
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 49cffbe83802..e5e4c71be3af 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2154,7 +2154,7 @@ ip_mkroute_input(struct sk_buff *skb, struct fib_result *res,
 	if (res->fi && fib_info_num_path(res->fi) > 1) {
 		int h = fib_multipath_hash(res->fi->fib_net, NULL, skb, hkeys);
 
-		fib_select_multipath(res, h);
+		fib_select_multipath(res, h, NULL);
 		IPCB(skb)->flags |= IPSKB_MULTIPATH;
 	}
 #endif
-- 
2.49.0.805.g082f7c87e0-goog


