Return-Path: <netdev+bounces-31371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E12D78D55C
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 13:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88EA31C203B8
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 11:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509DB3D6D;
	Wed, 30 Aug 2023 11:01:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4218D20E2
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 11:01:05 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0481BF
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 04:01:03 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qbIwW-00008O-L5; Wed, 30 Aug 2023 13:01:00 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Stanislav Fomichev <sdf@google.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] net: fib: avoid warn splat in flow dissector
Date: Wed, 30 Aug 2023 13:00:37 +0200
Message-ID: <20230830110043.30497-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

New skbs allocated via nf_send_reset() have skb->dev == NULL.

fib*_rules_early_flow_dissect helpers already have a 'struct net'
argument but its not passed down to the flow dissector core, which
will then WARN as it can't derive a net namespace to use:

 WARNING: CPU: 0 PID: 0 at net/core/flow_dissector.c:1016 __skb_flow_dissect+0xa91/0x1cd0
 [..]
  ip_route_me_harder+0x143/0x330
  nf_send_reset+0x17c/0x2d0 [nf_reject_ipv4]
  nft_reject_inet_eval+0xa9/0xf2 [nft_reject_inet]
  nft_do_chain+0x198/0x5d0 [nf_tables]
  nft_do_chain_inet+0xa4/0x110 [nf_tables]
  nf_hook_slow+0x41/0xc0
  ip_local_deliver+0xce/0x110
  ..

Cc: Stanislav Fomichev <sdf@google.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>
Fixes: 812fa71f0d96 ("netfilter: Dissect flow after packet mangling")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217826
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/ip6_fib.h | 5 ++++-
 include/net/ip_fib.h  | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index c9ff23cf313e..1ba9f4ddf2f6 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -642,7 +642,10 @@ static inline bool fib6_rules_early_flow_dissect(struct net *net,
 	if (!net->ipv6.fib6_rules_require_fldissect)
 		return false;
 
-	skb_flow_dissect_flow_keys(skb, flkeys, flag);
+	memset(flkeys, 0, sizeof(*flkeys));
+	__skb_flow_dissect(net, skb, &flow_keys_dissector,
+			   flkeys, NULL, 0, 0, 0, flag);
+
 	fl6->fl6_sport = flkeys->ports.src;
 	fl6->fl6_dport = flkeys->ports.dst;
 	fl6->flowi6_proto = flkeys->basic.ip_proto;
diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index a378eff827c7..f0c13864180e 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -418,7 +418,10 @@ static inline bool fib4_rules_early_flow_dissect(struct net *net,
 	if (!net->ipv4.fib_rules_require_fldissect)
 		return false;
 
-	skb_flow_dissect_flow_keys(skb, flkeys, flag);
+	memset(flkeys, 0, sizeof(*flkeys));
+	__skb_flow_dissect(net, skb, &flow_keys_dissector,
+			   flkeys, NULL, 0, 0, 0, flag);
+
 	fl4->fl4_sport = flkeys->ports.src;
 	fl4->fl4_dport = flkeys->ports.dst;
 	fl4->flowi4_proto = flkeys->basic.ip_proto;
-- 
2.41.0


