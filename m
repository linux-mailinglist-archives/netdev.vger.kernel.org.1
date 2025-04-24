Return-Path: <netdev+bounces-185597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3B0A9B117
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6DC188DAA9
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E7217A5BD;
	Thu, 24 Apr 2025 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmIqpV49"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401EC38DEC
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745505356; cv=none; b=Hmxqz7HZGQPKCunCmZvSylbf9kE7AQKfrkCsNUf8OImVOdVxMCaEGNu9BqItL/ULNZSEZyGYH5sO7kZaTgXD3hpPFA77Bh6RcbkeVk5Qkf629FqJKsM2fcfRxg5dX9tyuefLpXujKj5f1nHdJaWhEap1K+UJpmTD3VW964Q9LUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745505356; c=relaxed/simple;
	bh=WnIMoW1DiDmw/8YScKlz0i8JcLbl+YzutyEA/RzALRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ds75dDUASXgKdSesCT0Mqqzp7WIDGiqU4eo7vfzNe9T77yKrT7TOWH9BrWTs2WSi9zfHmihg2wVEP4SUerej9MmfVOuZDiMaIFyRLOan5agljtpTt4oBLucDnAgqqZp5OyDx95vLh/hOs4YSYyhFBBnaKc9a/O+aP5XVrviz4j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmIqpV49; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c7913bab2cso113788185a.0
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745505354; x=1746110154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6M427Xydljnos5t55GpZZ7PD6jzK2VY4cLbw98d/6g=;
        b=nmIqpV49dwnp7TXNsTlGwq48TI2p2u7da4G18fTY4SZHFE/O90oOf/4lRSRYQg5+/7
         CoZ25JAitQEt3qp5NYMJLjh3S/kjqstwHNzYSioDyEIhL1dtLqsMzLRP3pqykY5/qFVD
         r0wjHsONsfhQ5aciJxeTh5amzg6PGVCFWS14/KiD6LFzkI4qQVnXZrhwxFviiBUsTb5x
         Mldi2SafNZb1590vXUm1YP4CRYCeB2QMxKvpGBJI4enzfTfTV67MyNKNhVw10ZyCuG19
         OJsp98XliUi1l1mfkvOZzZWKZtpZ4XVwvHhpN0zFh3GM+JsB7JOJa9IUInIKlm1bBVin
         jMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745505354; x=1746110154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6M427Xydljnos5t55GpZZ7PD6jzK2VY4cLbw98d/6g=;
        b=udRzDLj5ltPJLqthY4wH6w4zPI210pybgpxw3ZfY5d5JWFY1Ik1J5FeiHBbL8vOL2D
         ymmm34vLQhKkwFnrUqI9FAZ5bCPTIkMPkgUfiBhfQiERpV5xgFAPvoOWvfo+DhYnQ1Df
         eFS4kt3GT8DNf2tnn+3OmVyFe/Z8Rb04qRr/q7D+vddYXXONJmnxsh+BEMwnoMXoLnAW
         R2BfsAD5itBK79tky/XuwLzGhwWOGhzvDMSdG5nuCUys5NUipzLZNkCQsES+rLHy6Hsi
         dto7ARA8+fxcsLJWn6veNR9AzpAGUeCwiorjxkVKsfMZNVPULHVM9nwbVVsb4sWUcSbi
         Fvyw==
X-Gm-Message-State: AOJu0YwtbMk70RXk38U+T8DVkyie/VOD9eAs9C8AvmAxDVC3IW2Lop9e
	3KReXQKQM44tO85Qi5evqbd30lEtg2RmGPvaKpMjuLBxvziZnGIdYDsM3A==
X-Gm-Gg: ASbGncv8krZWjGNelI8cLUvGs37umLL/RYN3QrAaCfo5VIVnpbN/vi4krrHaxaP7l9J
	Jar1m1zVxMetpPHtwQCq/QteDaKABMdVjqaaU3fxJoSezvVUNRjbcSfByp5ak0oZxqKHr8VtT/o
	CmXp7ZFXC4px9PaMLBuoSXB1EMEKHYSRQuNkKwvfh0oaw1Tu+p86Vt3vym4mPAZlVB3Oc56loYU
	HmBOt9TsZ64rctgQ2ukA07RH7CnPLN4Nu8zNGEx83cNu/aO/QQeHXeMqnJv0UYND70kkkdl2hLV
	uePFhFe+LFC55DJy8RrKdAQknRtYQJzyb6yLJOVJQeyt73jynxdtuhPE1phNBWxCw6qMV/RtKOd
	TrkBoAMH6j35oE9825xaXijqC8eCzXn5ihnulX44cT0U=
X-Google-Smtp-Source: AGHT+IEzP/UZt4WP7+AO2xDSdFP+0GX0qKTxm3saIFhDlnpHlvL0ayTBtv/CQg45sEPBpmt6Ej6VJw==
X-Received: by 2002:a05:620a:4554:b0:7c7:c77a:81c with SMTP id af79cd13be357-7c956f47e4fmr481026185a.51.1745505353929;
        Thu, 24 Apr 2025 07:35:53 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958c91a8dsm94743985a.1.2025.04.24.07.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 07:35:53 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/3] ipv4: prefer multipath nexthop that matches source address
Date: Thu, 24 Apr 2025 10:35:18 -0400
Message-ID: <20250424143549.669426-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
In-Reply-To: <20250424143549.669426-1-willemdebruijn.kernel@gmail.com>
References: <20250424143549.669426-1-willemdebruijn.kernel@gmail.com>
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
Reviewed-by: David Ahern <dsahern@kernel.org>
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
index 5326f1501af0..2371f311a1e1 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2170,34 +2170,45 @@ static bool fib_good_nh(const struct fib_nh *nh)
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
@@ -2212,7 +2223,7 @@ void fib_select_path(struct net *net, struct fib_result *res,
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


