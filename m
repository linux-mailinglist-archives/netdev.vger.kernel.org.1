Return-Path: <netdev+bounces-244591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 137C9CBB04C
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 14:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B788306519F
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 13:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6843090E2;
	Sat, 13 Dec 2025 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fNcPkFAi"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F88C194A76
	for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765634366; cv=none; b=RsNLDsLw//VhdSIzbbixsjqnMsEj7o1Wwvw/yIbojfrw+mOqoN19G7uUTb46zFgrGR4Q63WsJe5I2neTmnnFhrhJqUvqqOVdHxUKSp0fLYC5gfkktdvv2x+bBr3Na8Q5tV3vHekX5gYzaz3Q59Mt9jUnLdgrxOu7a4R82uEXi4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765634366; c=relaxed/simple;
	bh=6mz3Sk0nB920yhU1m9YovtZfS+FjR2z70SEo1eu8US0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qm6gRMoNPj89B3hZRKWJ2W11BtR2mCnQkhHEUYhLktPW+7pU+PNGos87254l63JP8M8tWqscwWHG7JJPPyGrlMHY/xIHibYs5z6Ax+AUSUmRDGQiKN568zzBy3lMOchpIHtDtT+qxhB3/6axHJ/Z7B5obHV0e1Za7sa4TVbvrUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fNcPkFAi; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765634361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GTDxYJQPT8emYBJUqV+ZsH0oCatiUBlnnnKRHyPAo0E=;
	b=fNcPkFAi7Pbghyes869eImpS4aoXPDnFWfhncE8udBp9ScCczIyrL+tStUBHfhzTbCTJB9
	mHvp3CD9XvV/5yBsXV4VTpDbsLAotWLUgA4C1ifFWcltZsjCh5/hm95Hk1mjCo9XjP1DOk
	6Z0NOkiEpb1omOBx1Gy1xliRS6R0cGI=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.ord>
Cc: Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net 1/2] net: fib: restore ECMP balance from loopback
Date: Sat, 13 Dec 2025 13:58:48 +0000
Message-ID: <20251213135849.2054677-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Preference of nexthop with source address broke ECMP for packets with
source address from loopback interface. Original behaviour was to
balance over nexthops while now it uses the latest nexthop from the
group.

For the case with 198.51.100.1/32 assigned to lo:

before:
   done | grep veth | awk ' {print $(NF-2)}' | sort | uniq -c:
    255 veth3

after:
   done | grep veth | awk ' {print $(NF-2)}' | sort | uniq -c:
    122 veth1
    133 veth3

Fixes: 32607a332cfe ("ipv4: prefer multipath nexthop that matches source address")
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 net/ipv4/fib_semantics.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index a5f3c8459758..c54b4ad9c280 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2165,9 +2165,9 @@ static bool fib_good_nh(const struct fib_nh *nh)
 void fib_select_multipath(struct fib_result *res, int hash,
 			  const struct flowi4 *fl4)
 {
+	bool first = false, found = false;
 	struct fib_info *fi = res->fi;
 	struct net *net = fi->fib_net;
-	bool found = false;
 	bool use_neigh;
 	__be32 saddr;
 
@@ -2190,23 +2190,24 @@ void fib_select_multipath(struct fib_result *res, int hash,
 		    (use_neigh && !fib_good_nh(nexthop_nh)))
 			continue;
 
-		if (!found) {
+		if (saddr && nexthop_nh->nh_saddr == saddr) {
 			res->nh_sel = nhsel;
 			res->nhc = &nexthop_nh->nh_common;
-			found = !saddr || nexthop_nh->nh_saddr == saddr;
+			return;
 		}
 
-		if (hash > nh_upper_bound)
-			continue;
-
-		if (!saddr || nexthop_nh->nh_saddr == saddr) {
+		if (!first) {
 			res->nh_sel = nhsel;
 			res->nhc = &nexthop_nh->nh_common;
-			return;
+			first = true;
 		}
 
-		if (found)
-			return;
+		if (found || hash > nh_upper_bound)
+			continue;
+
+		res->nh_sel = nhsel;
+		res->nhc = &nexthop_nh->nh_common;
+		found = true;
 
 	} endfor_nexthops(fi);
 }
-- 
2.47.3


