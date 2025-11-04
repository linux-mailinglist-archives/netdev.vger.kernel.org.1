Return-Path: <netdev+bounces-235504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93987C31A34
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 15:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1A684EE828
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF33732E73A;
	Tue,  4 Nov 2025 14:51:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7420C24EF8C
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267860; cv=none; b=uTNzBlRMsY0Ovoj1ykZIeH8QACN/mFIaWLLpq+4e/z6shN9cMFRYdmlYXqK1p4J4bZeJu5zrKPzv2HjCNoilGyKpSd8p8YO3lhJ9rI5jILrM/sCSRzEt7OQbTXEyUcWP6Ah8h2mis4xjXoKfnynF6lqB388uG3f0g9/Iy3hDA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267860; c=relaxed/simple;
	bh=WErgLFmKhgxO9bfISfDiZ3Vzdx1n2EoL34w4692Tt+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4R+WQQV5AKctKbpZ5ZdFb/c3CnBsRy2NKewzFJhleUoNmHFb6weTjwH/9rjm2Fh1T9jcmOZvpGN/IJue3IJX0XUdx3nyabzYZA2nnRra/2zAVSjr/O/Sn7iyu84m5CUR+7TMqIauwvsUQ92QStmBweDaG4WZzf1nekNjGx3jF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from [2001:67c:1232:144:9c7d:e76f:d255:c66c] (helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <equinox@diac24.net>)
	id 1vGILB-000000009AD-2pir;
	Tue, 04 Nov 2025 15:48:57 +0100
Received: from equinox by alea with local (Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1vGIKk-0000000057Q-0g3C;
	Tue, 04 Nov 2025 09:48:30 -0500
From: David Lamparter <equinox@diac24.net>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: David Lamparter <equinox@diac24.net>,
	Lorenzo Colitti <lorenzo@google.com>,
	Patrick Rohr <prohr@google.com>
Subject: [RESEND PATCH net-next v2 1/4] net/ipv6: flatten ip6_route_get_saddr
Date: Tue,  4 Nov 2025 09:48:19 -0500
Message-ID: <20251104144824.19648-2-equinox@diac24.net>
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
index aee6a10b112a..9508e46b9e56 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5822,9 +5822,19 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
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
2.50.1


