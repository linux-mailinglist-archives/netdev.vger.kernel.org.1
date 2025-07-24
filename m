Return-Path: <netdev+bounces-209797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877F0B10E30
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 17:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C995A3477
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9944C2E92D9;
	Thu, 24 Jul 2025 15:01:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F122BD5BC
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369283; cv=none; b=LqQSsiCaY9W22CFV65SyonO4LqaViD7c68vLFIbtFxTKgPyNaND750GsqLg4Dh5Pb0tXqWl/Wk5sptCJz15HDgaO1CK6ai5er39pALaTBeOKhRE0aj7Mg+BEjdP6aIElLMMHJR8EQzRC3F8Oq3unHJ5mfGEEbapSwIPOqJ0rAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369283; c=relaxed/simple;
	bh=XNZJarOy0cuMIh5weizto+eAttpR2o6rhey3JT0PyPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzrdkCsIzd1TTLPfn2NqaEiDXZEKsb9qrD/Ry59nEJDmsVQzcaohcnB7I7iEeC6UtQ/7NloAeJuCcp8yn+2F8lL/JJkH9V0M4fkXUu4zpBzY7phedQfJgIaPVgX2lgDZHXCWEKMZ+9Vsgrnl7e02SniHEJbDhQwI8kLLkg14B0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from [2001:67c:370:1998:30cb:b625:4f9:61b4] (helo=alea.q.nox.tf)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <equinox@diac24.net>)
	id 1uexRc-000000030oh-1mFJ;
	Thu, 24 Jul 2025 17:01:19 +0200
Received: from equinox by alea.q.nox.tf with local (Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1uexRE-000000001fI-0QiA;
	Thu, 24 Jul 2025 17:00:52 +0200
From: David Lamparter <equinox@diac24.net>
To: netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: David Lamparter <equinox@diac24.net>,
	Lorenzo Colitti <lorenzo@google.com>,
	Patrick Rohr <prohr@google.com>
Subject: [PATCH net-next v2 1/4] net/ipv6: flatten ip6_route_get_saddr
Date: Thu, 24 Jul 2025 17:00:38 +0200
Message-ID: <20250724150042.6361-2-equinox@diac24.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724150042.6361-1-equinox@diac24.net>
References: <20250724150042.6361-1-equinox@diac24.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inline ip6_route_get_saddr()'s functionality in rt6_fill_node(), to
prepare for replacing the former with a dst based function.

NB: the l3mdev handling introduced by 252442f2ae31 "ipv6: fix source
address selection with route leak" is dropped here - the l3mdev ifindex
was a constant 0 on this call site, so that code was in fact dead.

Signed-off-by: David Lamparter <equinox@diac24.net>
---
 net/ipv6/route.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 3fbe0885c21c..a2362913ebed 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5821,9 +5821,19 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 			if (nla_put_u32(skb, RTA_IIF, iif))
 				goto nla_put_failure;
 	} else if (dest) {
-		struct in6_addr saddr_buf;
-		if (ip6_route_get_saddr(net, rt, dest, 0, 0, &saddr_buf) == 0 &&
-		    nla_put_in6_addr(skb, RTA_PREFSRC, &saddr_buf))
+		struct in6_addr saddr_buf, *saddr = NULL;
+
+		if (rt->fib6_prefsrc.plen) {
+			saddr = &rt->fib6_prefsrc.addr;
+		} else {
+			struct net_device *dev = fib6_info_nh_dev(rt);
+
+			if (ipv6_dev_get_saddr(net, dev, dest, 0,
+					       &saddr_buf) == 0)
+				saddr = &saddr_buf;
+		}
+
+		if (saddr && nla_put_in6_addr(skb, RTA_PREFSRC, saddr))
 			goto nla_put_failure;
 	}
 
-- 
2.47.2


