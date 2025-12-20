Return-Path: <netdev+bounces-245568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FD1CD2610
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 04:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0038130019CB
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 03:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DC027FD4F;
	Sat, 20 Dec 2025 03:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cvoMVv4+"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683A9257843
	for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766201059; cv=none; b=WZfIvw93JDy5d30n14Xr+UH/Edi2TUOop/QQCeV2On2QNroZAmEAq4r8T9Xz2cJITh3VXULuoRxR1Jp9iDgScE+TnYHavigsZx6k4wf4gBKz77X3a029bEkWXVSbhH/3g1Fab3MwYgj1RLPy9+QM0pD0bW2BNkPPfLonm9UenxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766201059; c=relaxed/simple;
	bh=WAerXKm905/agovh8P4nMi09By5tY8uN2EO7mpRj6Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MyTsvh8Jch8rutSI7/l9OzVNrGVc+xIY2YoSiNDjEvOijXqKjl1TnBWhip38WzgMCa2tHgMh4Ls7Oo63MrR6F64rje0ivVmdlShfWi3OxmtVLPbapXJ5rnHraWlQHhxYH1H/Xu8vwhYYMy1NIwOOnucSlHQC0Rn+Q1+05QDADTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cvoMVv4+; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766201050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kd7Q+89EmohlwN7IswgTxPUrtzMZ/Wldno5SqVZ35q4=;
	b=cvoMVv4+G9VzckbC9q8mcpBibgUaBQeQu6iNdrnibPyZ4Kwgcnm+8fm2FEuFH9x8FkiDbB
	KIia9+yzJJuGJ2c9dxfwGGI+CFj79OECMwUtvqMzwRxtaer4YcdvwFCQC9LPXGzfGM62oN
	5lEUPZjT5WV3N7w46k86Ke1+5lV7hao=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net v2 1/2] net: fib: restore ECMP balance from loopback
Date: Sat, 20 Dec 2025 03:23:34 +0000
Message-ID: <20251220032335.3517241-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Preference of nexthop with source address broke ECMP for packets with
source addresses which are not in the broadcast domain, but rather added
to loopback/dummy interfaces. Original behaviour was to balance over
nexthops while now it uses the latest nexthop from the group.

For the case with 198.51.100.1/32 assigned to dummy0 and routed using
192.0.2.0/24 and 203.0.113.0/24 networks:

2: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
    link/ether d6:54:8a:ff:78:f5 brd ff:ff:ff:ff:ff:ff
    inet 198.51.100.1/32 scope global dummy0
       valid_lft forever preferred_lft forever
7: veth1@if6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 06:ed:98:87:6d:8a brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 192.0.2.2/24 scope global veth1
       valid_lft forever preferred_lft forever
    inet6 fe80::4ed:98ff:fe87:6d8a/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
9: veth3@if8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether ae:75:23:38:a0:d2 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 203.0.113.2/24 scope global veth3
       valid_lft forever preferred_lft forever
    inet6 fe80::ac75:23ff:fe38:a0d2/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever

~ ip ro list:
default
	nexthop via 192.0.2.1 dev veth1 weight 1
	nexthop via 203.0.113.1 dev veth3 weight 1
192.0.2.0/24 dev veth1 proto kernel scope link src 192.0.2.2
203.0.113.0/24 dev veth3 proto kernel scope link src 203.0.113.2

before:
   for i in {1..255} ; do ip ro get 10.0.0.$i; done | grep veth | awk ' {print $(NF-2)}' | sort | uniq -c:
    255 veth3

after:
   for i in {1..255} ; do ip ro get 10.0.0.$i; done | grep veth | awk ' {print $(NF-2)}' | sort | uniq -c:
    122 veth1
    133 veth3

Fixes: 32607a332cfe ("ipv4: prefer multipath nexthop that matches source address")
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
v1 -> v2:

- add score calculation for nexthop to keep original logic
- adjust commit message to explain the config
- use dummy device instead of loopback
---

 net/ipv4/fib_semantics.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index a5f3c8459758..4d3650d20ff2 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2167,8 +2167,8 @@ void fib_select_multipath(struct fib_result *res, int hash,
 {
 	struct fib_info *fi = res->fi;
 	struct net *net = fi->fib_net;
-	bool found = false;
 	bool use_neigh;
+	int score = -1;
 	__be32 saddr;
 
 	if (unlikely(res->fi->nh)) {
@@ -2180,7 +2180,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
 	saddr = fl4 ? fl4->saddr : 0;
 
 	change_nexthops(fi) {
-		int nh_upper_bound;
+		int nh_upper_bound, nh_score = 0;
 
 		/* Nexthops without a carrier are assigned an upper bound of
 		 * minus one when "ignore_routes_with_linkdown" is set.
@@ -2190,24 +2190,16 @@ void fib_select_multipath(struct fib_result *res, int hash,
 		    (use_neigh && !fib_good_nh(nexthop_nh)))
 			continue;
 
-		if (!found) {
+		if (saddr && nexthop_nh->nh_saddr == saddr)
+			nh_score += 2;
+		if (hash <= nh_upper_bound)
+			nh_score++;
+		if (score < nh_score) {
 			res->nh_sel = nhsel;
 			res->nhc = &nexthop_nh->nh_common;
-			found = !saddr || nexthop_nh->nh_saddr == saddr;
+			score = nh_score;
 		}
 
-		if (hash > nh_upper_bound)
-			continue;
-
-		if (!saddr || nexthop_nh->nh_saddr == saddr) {
-			res->nh_sel = nhsel;
-			res->nhc = &nexthop_nh->nh_common;
-			return;
-		}
-
-		if (found)
-			return;
-
 	} endfor_nexthops(fi);
 }
 #endif
-- 
2.47.3


