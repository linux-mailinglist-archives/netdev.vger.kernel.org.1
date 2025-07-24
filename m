Return-Path: <netdev+bounces-209754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB70B10B39
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A781CE3D59
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473D62D641F;
	Thu, 24 Jul 2025 13:19:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEDC2D77EA
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363156; cv=none; b=h8bn6kh9q2i0brsn3YDsAbituMj2PnlG3WhSogyLHeLcK/EAuYn5ePPz2Sjec97jJmL0cbsJjhy9A7MKnS89S5g3acigfItsqUHJl2IbSCyLWo4+d96M/UmAXkircu1g4DiMzt6nT3nax0TBJ5FhRzIR4ZTptBfqMUJ92pYg+Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363156; c=relaxed/simple;
	bh=WMDglNwABQCw+mHTLdN3VNNNAebH3R3VrZIyYMvudko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Btoj5T54ZPQqXUMlFRE3S0Z29a+9JimbBjd0LXiM3qePuWUy5jUcjekDevjRZn9NViRyTLP1nXEiOBYQzsDh3OL0Onco1WKPucJvgBaCUwRulgIMRVeKEiWlXcC5l0iocNafVLf66h0/TkxDqQ06FbATWAt5rdnorpqFK5fm01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from [2001:67c:370:1998:30cb:b625:4f9:61b4] (helo=alea.q.nox.tf)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <equinox@diac24.net>)
	id 1uevql-00000002yTP-1NLc;
	Thu, 24 Jul 2025 15:19:07 +0200
Received: from equinox by alea.q.nox.tf with local (Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1uevqO-000000008NK-3d56;
	Thu, 24 Jul 2025 15:18:44 +0200
From: David Lamparter <equinox@diac24.net>
To: netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: David Lamparter <equinox@diac24.net>,
	Lorenzo Colitti <lorenzo@google.com>,
	Patrick Rohr <prohr@google.com>
Subject: [PATCH net-next 3/4] net/ipv6: use ipv6_fl_get_saddr in output
Date: Thu, 24 Jul 2025 15:18:24 +0200
Message-ID: <20250724131828.32155-4-equinox@diac24.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724131828.32155-1-equinox@diac24.net>
References: <20250724131828.32155-1-equinox@diac24.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flatten ip6_route_get_saddr() into ip6_dst_lookup_tail (which really
just means handling fib6_prefsrc), and then replace ipv6_dev_get_saddr
with ipv6_fl_get_saddr to pass down the flow information.

Signed-off-by: David Lamparter <equinox@diac24.net>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: Patrick Rohr <prohr@google.com>
---
 net/ipv6/ip6_output.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 0412f8544695..eeda556f275f 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1111,31 +1111,44 @@ static int ip6_dst_lookup_tail(struct net *net, const struct sock *sk,
 	struct neighbour *n;
 	struct rt6_info *rt;
 #endif
-	int err;
+	int err = 0;
 	int flags = 0;
 
 	/* The correct way to handle this would be to do
-	 * ip6_route_get_saddr, and then ip6_route_output; however,
+	 * ipv6_fl_get_saddr, and then ip6_route_output; however,
 	 * the route-specific preferred source forces the
-	 * ip6_route_output call _before_ ip6_route_get_saddr.
+	 * ip6_route_output call _before_ ipv6_fl_get_saddr.
 	 *
 	 * In source specific routing (no src=any default route),
 	 * ip6_route_output will fail given src=any saddr, though, so
 	 * that's why we try it again later.
 	 */
 	if (ipv6_addr_any(&fl6->saddr)) {
+		struct net_device *l3mdev;
+		struct net_device *dev;
 		struct fib6_info *from;
 		struct rt6_info *rt;
+		bool same_vrf;
+		int err = 0;
 
 		*dst = ip6_route_output(net, sk, fl6);
 		rt = (*dst)->error ? NULL : dst_rt6_info(*dst);
 
 		rcu_read_lock();
 		from = rt ? rcu_dereference(rt->from) : NULL;
-		err = ip6_route_get_saddr(net, from, &fl6->daddr,
-					  sk ? READ_ONCE(inet6_sk(sk)->srcprefs) : 0,
-					  fl6->flowi6_l3mdev,
-					  &fl6->saddr);
+
+		l3mdev = dev_get_by_index_rcu(net, fl6->flowi6_l3mdev);
+		if (!from || !from->fib6_prefsrc.plen || l3mdev)
+			dev = from ? fib6_info_nh_dev(from) : NULL;
+		same_vrf = !l3mdev || l3mdev_master_dev_rcu(dev) == l3mdev;
+		if (from && from->fib6_prefsrc.plen && same_vrf)
+			fl6->saddr = from->fib6_prefsrc.addr;
+		else
+			err = ipv6_fl_get_saddr(net, *dst,
+						same_vrf ? dev : l3mdev, sk,
+						sk ? READ_ONCE(inet6_sk(sk)->srcprefs) : 0,
+						fl6);
+
 		rcu_read_unlock();
 
 		if (err)
-- 
2.47.2


