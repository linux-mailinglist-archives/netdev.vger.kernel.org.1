Return-Path: <netdev+bounces-169336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AE7A43871
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DFD8166E30
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 08:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A040263F28;
	Tue, 25 Feb 2025 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtiaaGUo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B2E263C8C;
	Tue, 25 Feb 2025 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473847; cv=none; b=JTuKFKbRQEnBlOs5Vt5ZpRPOLRRHbBOBLJ5SqGsPIt1HuJAQBoB5mD5JLhVEHzY/gE+7bc9Rg5ukDOpBKulvi5Wr+3jGhcAYEg+6aRtpsnrE/pHcbcAUUNF7owQIguMTuJWsDj3S5Ef3gme35Xo36UwOeIdnVkmFJKKOhip8huE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473847; c=relaxed/simple;
	bh=FyBG6tA5eQjNICDy5BX7avRDr58XxtQW2yTJbNVviTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WzvJYPAEp7sZGdELP2gBYYpRh5RdJcBgZC/6/D73S8SC3y7fUL2QEWfCVoWKjcEmZuPnKglwp4Sop6D9g1voBPClv+nH1ZSTUpnRD7rG0sKQ7mW9wHiMIl6urI4xqnqfxAQ8Tr42ruHGrM/tKBxcLGatofc1ZVeXsJ06gziOjY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtiaaGUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0AEC4CEDD;
	Tue, 25 Feb 2025 08:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740473847;
	bh=FyBG6tA5eQjNICDy5BX7avRDr58XxtQW2yTJbNVviTM=;
	h=From:To:Cc:Subject:Date:From;
	b=GtiaaGUo3aPf+gOojB+AY84ddiie2lVkWZoFai/gBLK50pkUTfB1C7wLtSrVf0VQb
	 Vc6IfMrCuYkCAVlxUw/93qI2dHiAbg4rOgmo2R4JBnBNbw/kjMaGs6HPhfb0M1/LbC
	 0jga9g/c1oJ4cRL0twIEMt10hE/zRFkRj6IWlGi/j26Hm17dnvwPZ5LTRo6o5w7tmP
	 qTT/69TsIEw1yG4Tq5sr4jymJR8OITjfW2hhl4BN9weaR5CUUsJjybsikkSZwMpFMP
	 p+XN8Mdtp64Sz04Ixc35ss2YVYU6O9QzZUt1mQAHhWCqknPFWtxzjhm/xFLTMzvHPR
	 XNbpdLfPjkemw==
From: Arnd Bergmann <arnd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Simon Horman <horms@kernel.org>,
	Peter Seiderer <ps.report@gmx.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pktgen: avoid unused-const-variable warning
Date: Tue, 25 Feb 2025 09:57:14 +0100
Message-Id: <20250225085722.469868-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When extra warnings are enable, there are configurations that build
pktgen without CONFIG_XFRM, which leaves a static const variable unused:

net/core/pktgen.c:213:1: error: unused variable 'F_IPSEC' [-Werror,-Wunused-const-variable]
  213 | PKT_FLAGS
      | ^~~~~~~~~
net/core/pktgen.c:197:2: note: expanded from macro 'PKT_FLAGS'
  197 |         pf(IPSEC)               /* ipsec on for flows */                \
      |         ^~~~~~~~~

This could be marked as __maybe_unused, or by making the one use visible
to the compiler by slightly rearranging the #ifdef blocks. The second
variant looks slightly nicer here, so use that.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/core/pktgen.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 55064713223e..402e01a2ce19 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -158,9 +158,7 @@
 #include <net/udp.h>
 #include <net/ip6_checksum.h>
 #include <net/addrconf.h>
-#ifdef CONFIG_XFRM
 #include <net/xfrm.h>
-#endif
 #include <net/netns/generic.h>
 #include <asm/byteorder.h>
 #include <linux/rcupdate.h>
@@ -2363,13 +2361,13 @@ static inline int f_pick(struct pktgen_dev *pkt_dev)
 }
 
 
-#ifdef CONFIG_XFRM
 /* If there was already an IPSEC SA, we keep it as is, else
  * we go look for it ...
 */
 #define DUMMY_MARK 0
 static void get_ipsec_sa(struct pktgen_dev *pkt_dev, int flow)
 {
+#ifdef CONFIG_XFRM
 	struct xfrm_state *x = pkt_dev->flows[flow].x;
 	struct pktgen_net *pn = net_generic(dev_net(pkt_dev->odev), pg_net_id);
 	if (!x) {
@@ -2395,11 +2393,10 @@ static void get_ipsec_sa(struct pktgen_dev *pkt_dev, int flow)
 		}
 
 	}
-}
 #endif
+}
 static void set_cur_queue_map(struct pktgen_dev *pkt_dev)
 {
-
 	if (pkt_dev->flags & F_QUEUE_MAP_CPU)
 		pkt_dev->cur_queue_map = smp_processor_id();
 
@@ -2574,10 +2571,8 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 				pkt_dev->flows[flow].flags |= F_INIT;
 				pkt_dev->flows[flow].cur_daddr =
 				    pkt_dev->cur_daddr;
-#ifdef CONFIG_XFRM
 				if (pkt_dev->flags & F_IPSEC)
 					get_ipsec_sa(pkt_dev, flow);
-#endif
 				pkt_dev->nflows++;
 			}
 		}
-- 
2.39.5


