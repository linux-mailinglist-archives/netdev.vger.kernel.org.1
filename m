Return-Path: <netdev+bounces-72373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4B5857C4B
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 13:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC32D284801
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 12:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE8777F15;
	Fri, 16 Feb 2024 12:06:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF3077A0F
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708085198; cv=none; b=OKntS1hg0YfQnHrH1lwIQj7n9mVhRXiOQZjKu4lPRJ9fdvnaLcD8VEJl0U5sHpAdIIkqemmcJNmyGBqF6W5gc8Es5SU4aiWrOQl2GhdNBAeri6fYRyKU4fZiVQ/qe1vCqZYhwDHqtxams6F9yfBCkpQeUetJTfpxmJX6qPhbobI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708085198; c=relaxed/simple;
	bh=c2tlsQpOj9ZW9j5fhmExsISLdlvh3QddpWXoqi2/M40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qYC8uU0H/49H/OwaIuQwt+DA55MPI7/V1iCQ2jAP1uajyoUV3XNLEb0ib0SotDD0hbslIBLCuP4wXLFc1CtD29/755+Vt2j20gfC74xp7JiXIIOaKIE97NPimMzZkZreI2fGS4SaE+Y6XocN4tIT9x+Cp/zxovgTrWH/dDP+jC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rawzB-0000IU-N0; Fri, 16 Feb 2024 13:06:33 +0100
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com
Subject: [PATCH net] net: ip_tunnel: do not adjust device headroom on xmit
Date: Fri, 16 Feb 2024 13:01:42 +0100
Message-ID: <20240216120144.24037-1-fw@strlen.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzkaller triggered following kasan splat:
BUG: KASAN: use-after-free in __skb_flow_dissect+0x19d1/0x7a50 net/core/flow_dissector.c:1170
Read of size 1 at addr ffff88812fb4000e by task syz-executor183/5191
[..]
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 __skb_flow_dissect+0x19d1/0x7a50 net/core/flow_dissector.c:1170
 skb_flow_dissect_flow_keys include/linux/skbuff.h:1514 [inline]
 ___skb_get_hash net/core/flow_dissector.c:1791 [inline]
 __skb_get_hash+0xc7/0x540 net/core/flow_dissector.c:1856
 skb_get_hash include/linux/skbuff.h:1556 [inline]
 ip_tunnel_xmit+0x1855/0x33c0 net/ipv4/ip_tunnel.c:748
 ipip_tunnel_xmit+0x3cc/0x4e0 net/ipv4/ipip.c:308
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3548 [inline]
 dev_hard_start_xmit+0x13d/0x6d0 net/core/dev.c:3564
 __dev_queue_xmit+0x7c1/0x3d60 net/core/dev.c:4349
 dev_queue_xmit include/linux/netdevice.h:3134 [inline]
 neigh_connected_output+0x42c/0x5d0 net/core/neighbour.c:1592
 ...
 ip_finish_output2+0x833/0x2550 net/ipv4/ip_output.c:235
 ip_finish_output+0x31/0x310 net/ipv4/ip_output.c:323
 ..
 iptunnel_xmit+0x5b4/0x9b0 net/ipv4/ip_tunnel_core.c:82
 ip_tunnel_xmit+0x1dbc/0x33c0 net/ipv4/ip_tunnel.c:831
 ipgre_xmit+0x4a1/0x980 net/ipv4/ip_gre.c:665
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3548 [inline]
 dev_hard_start_xmit+0x13d/0x6d0 net/core/dev.c:3564
 ...

The splat occurs because skb->data points past skb->head allocated
area.  This is because neigh layer does:
  __skb_pull(skb, skb_network_offset(skb));

... but skb_network_offset() returns a negative offset and
__skb_pull() arg is unsigned.  IOW, we skb->data gets "adjusted"
by a huge value.

The negative value is returned because skb->head and skb->data distance is
more than 64k and skb->network_header (u16) has wrapped around.

The bug is in the ip_tunnel infrastructure, which can cause
dev->needed_headroom to increment ad infinitum.

The syzkaller reproducer consists of packets getting routed via a gre
tunnel, and route of gre encapsulated packets pointing at another (ipip)
tunnel.  The ipip encapsulation finds gre0 as next output device.

This results in the following pattern:

1). First packet is to be sent out via gre0.
Route lookup found an output device, ipip0.

2).
ip_tunnel_xmit for gre0 bumps gre0->needed_headroom based on the
future output device, rt.dev->needed_headroom (ipip0).

3).
ip output / start_xmit moves skb on to ipip0. which runs the same
code path again (xmit recursion).

4).
Routing step for the post-gre0-encap packet finds gre0 as output
device to use for ipip0 encapsulated packet.

tunl0->needed_headroom is then incremented based on the (already
bumped) gre0 device headroom.

This repeats for every future packet:

gre0->needed_headroom gets inflated because previous packets'
ipip0 step incremented rt->dev (gre0) headroom, and ipip0 incremented
because gre0 needed_headroom was increased.

For each subsequent packet, gre/ipip0->needed_headroom grows until
post-expand-head reallocations result in a skb->head/data distance of
more than 64k.

Once that happens, skb->network_header (u16) wraps around when
pskb_expand_head tries to make sure that skb_network_offset() is
unchanged after the headroom expansion/reallocation.

After this skb_network_offset(skb) returns a different (and
negative) result post headroom expansion.

The next trip to neigh layer (or anything else that would __skb_pull
the network header) makes skb->data point to a memory location outside
skb->head area.

Remove this optimization.

Alternative would be to cap the needed_headroom update to a reasonable
upperlimit such as 256 to prevent growth.

Lets try the simpler solution first and see if any performance
regressions get reported.

Reported-by: syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com
Closes: https://groups.google.com/g/syzkaller-bugs/c/fL9G6GtWskY/m/VKk_PR5FBAAJ
Fixes: 243aad830e8a ("ip_gre: include route header_len in max_headroom calculation")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/ipv4/ip_tunnel.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index a4513ffb66cb..1dde07031122 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -632,10 +632,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	headroom += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
-	if (headroom > READ_ONCE(dev->needed_headroom))
-		WRITE_ONCE(dev->needed_headroom, headroom);
-
-	if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom))) {
+	if (skb_cow_head(skb, headroom)) {
 		ip_rt_put(rt);
 		goto tx_dropped;
 	}
@@ -818,10 +815,8 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	max_headroom = LL_RESERVED_SPACE(rt->dst.dev) + sizeof(struct iphdr)
 			+ rt->dst.header_len + ip_encap_hlen(&tunnel->encap);
-	if (max_headroom > READ_ONCE(dev->needed_headroom))
-		WRITE_ONCE(dev->needed_headroom, max_headroom);
 
-	if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom))) {
+	if (skb_cow_head(skb, max_headroom)) {
 		ip_rt_put(rt);
 		DEV_STATS_INC(dev, tx_dropped);
 		kfree_skb(skb);
-- 
2.43.0


