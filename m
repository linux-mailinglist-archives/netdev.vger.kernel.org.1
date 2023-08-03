Return-Path: <netdev+bounces-24127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D832976EE0F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 17:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917ED2821E5
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6323423BFA;
	Thu,  3 Aug 2023 15:27:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BC523BF4
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 15:27:09 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A5635A6
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:27:07 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qRaEE-00066i-K3; Thu, 03 Aug 2023 17:27:06 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: sbrivio@redhat.com,
	"David S. Miller" <davem@davemloft.net>,
	dsahern@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	shuah@kernel.org,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net 1/2] tunnels: fix kasan splat when generating ipv4 pmtu error
Date: Thu,  3 Aug 2023 17:26:49 +0200
Message-ID: <20230803152653.29535-2-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803152653.29535-1-fw@strlen.de>
References: <20230803152653.29535-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If we try to emit an icmp error in response to a nonliner skb, we get

BUG: KASAN: slab-out-of-bounds in ip_compute_csum+0x134/0x220
Read of size 4 at addr ffff88811c50db00 by task iperf3/1691
CPU: 2 PID: 1691 Comm: iperf3 Not tainted 6.5.0-rc3+ #309
[..]
 kasan_report+0x105/0x140
 ip_compute_csum+0x134/0x220
 iptunnel_pmtud_build_icmp+0x554/0x1020
 skb_tunnel_check_pmtu+0x513/0xb80
 vxlan_xmit_one+0x139e/0x2ef0
 vxlan_xmit+0x1867/0x2760
 dev_hard_start_xmit+0x1ee/0x4f0
 br_dev_queue_push_xmit+0x4d1/0x660
 [..]

ip_compute_csum() cannot deal with nonlinear skbs, so avoid it.
After this change, splat is gone and iperf3 is no longer stuck.

Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/ipv4/ip_tunnel_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 92c02c886fe7..586b1b3e35b8 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -224,7 +224,7 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 		.un.frag.__unused	= 0,
 		.un.frag.mtu		= htons(mtu),
 	};
-	icmph->checksum = ip_compute_csum(icmph, len);
+	icmph->checksum = csum_fold(skb_checksum(skb, 0, len, 0));
 	skb_reset_transport_header(skb);
 
 	niph = skb_push(skb, sizeof(*niph));
-- 
2.41.0


