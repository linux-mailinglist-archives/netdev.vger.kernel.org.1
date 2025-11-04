Return-Path: <netdev+bounces-235505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 966D2C31A31
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 15:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4CE3BBE7F
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B00328606;
	Tue,  4 Nov 2025 14:51:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26824EF8C
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267864; cv=none; b=DqgYWP2kRRTwOvg4eK0+l2XyiAHi0SPz5VsszdgQVj0yJ33pkeS8AGlBBrIJOlTxu4/sZjbb+vAAMkxIDUFs7VgOyCBw+RY0m1ZlzodUl716i7g64Q1lyomaXYPM9mJPAGLj/wzA9E/nXBsAhBzU6yiTjHeg3v65+7KPwfQrNQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267864; c=relaxed/simple;
	bh=M0ShxTYF9pyk3xt5e+Ui1p4Cj7hOyPAuU1/9ghwVx6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHYh1+rFG7VziUNJtZhWAJJCVlMb6or1fWYGisAjzq9kII0HJZfYA1AyjSkK7lUkgXr46EuigZmd8A/JBPrj0Up4MqXMGglDKrXHIK1RRXFJ0uuG8GcunWskrHLY/rRPHhNsofnfbBNxfqxKnlu9GapKoA+vH8f94g+BcVepJJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from [2001:67c:1232:144:9c7d:e76f:d255:c66c] (helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <equinox@diac24.net>)
	id 1vGILB-000000009AH-2qAI;
	Tue, 04 Nov 2025 15:48:58 +0100
Received: from equinox by alea with local (Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1vGIKn-0000000057a-1SkV;
	Tue, 04 Nov 2025 09:48:33 -0500
From: David Lamparter <equinox@diac24.net>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: David Lamparter <equinox@diac24.net>,
	Lorenzo Colitti <lorenzo@google.com>,
	Patrick Rohr <prohr@google.com>
Subject: [RESEND PATCH net-next v2 3/4] net/ipv6: use ipv6_fl_get_saddr in output
Date: Tue,  4 Nov 2025 09:48:21 -0500
Message-ID: <20251104144824.19648-4-equinox@diac24.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251104144824.19648-1-equinox@diac24.net>
References: <20251104144824.19648-1-equinox@diac24.net>
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
---
 net/ipv6/ip6_output.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f904739e99b9..28406ed5ddfb 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1126,27 +1126,40 @@ static int ip6_dst_lookup_tail(struct net *net, const struct sock *sk,
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
+		if (from && from->fib6_prefsrc.plen && same_vrf) {
+			fl6->saddr = from->fib6_prefsrc.addr;
+			err = 0;
+		} else
+			err = ipv6_fl_get_saddr(net, *dst,
+						same_vrf ? dev : l3mdev, sk,
+						sk ? READ_ONCE(inet6_sk(sk)->srcprefs) : 0,
+						fl6);
+
 		rcu_read_unlock();
 
 		if (err)
-- 
2.50.1


