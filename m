Return-Path: <netdev+bounces-245652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA29CD44C9
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 20:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5F5530054BA
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 19:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94F630E839;
	Sun, 21 Dec 2025 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qn1sxazC"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B330DD3D
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766345237; cv=none; b=pOsLpnfO50Z7/Lcfycs/GEgmBd6RHhjzBXgAamzuMwS1lkG7h7nj1IVlFJB9MIhJZ2+n41gYLFMskqh0AjXkOoiUP6CaNEt5Kba95kYmB0YOXw8OBn/PmsuXR3HDWKYP0DrUiJ2HN/Umo57iFE6dIUehDQF0iOt87VvgcdvM3z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766345237; c=relaxed/simple;
	bh=BJLuhj97g7Q+UOrjTrZHe1+yCx6iPYucW7P+RNAgnTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DnNv5kTS1qK3Ja3yv+mS/hosxE5hMS2nHj0MfMEsDg73lahSq8M4+PbapNhWf2B8sTq+dMde/rsWceof4YpeQH1o7yE/vAfuG4DDDFN8dOP/R4WMF2Lkvhwa5NV35TTL/WbYm5377D4JcRATh4CQvYy9ore11GLghYuwxx0gTw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qn1sxazC; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766345232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JuVWF9IqyykpsNh+vlGB5mztCxwDtgi6Ahu314m2ByI=;
	b=Qn1sxazCspokboW4Pw5Fmw055zlF11UwmnvdDBTFFTHqUG5ZFAgThbq93l+R19L4PBwpxm
	cOvnJu2830WPEDB/8nu/B1FSN7bvDBRX+VoCSobU29cA0NdQf55kRIPy5acAOJtfQhQANo
	pZzpiXz2YQBUKxx+2OtFd8Zq6Ew6/VI=
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
Subject: [PATCH net v3 1/2] net: fib: restore ECMP balance from loopback
Date: Sun, 21 Dec 2025 19:26:38 +0000
Message-ID: <20251221192639.3911901-1-vadim.fedorenko@linux.dev>
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
nexthops while now it uses the latest nexthop from the group. To fix the
issue introduce next hop scoring system where next hops with source
address equal to requested will always have higher priority.

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
v2 -> v3:
- add early break in case next hop with the highest possible score is
  found (Ido)
v1 -> v2:
- add score calculation for nexthop to keep original logic
- adjust commit message to explain the config
- use dummy device instead of loopback
---
 net/ipv4/fib_semantics.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index a5f3c8459758..0caf38e44c73 100644
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
@@ -2190,24 +2190,18 @@ void fib_select_multipath(struct fib_result *res, int hash,
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
+			if (nh_score == 3 || (!saddr && nh_score == 1))
+				return;
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


