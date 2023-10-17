Return-Path: <netdev+bounces-41764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06F27CBDDD
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA50E1C20CA0
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946E13D392;
	Tue, 17 Oct 2023 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576673D3A8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:37:33 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5D8F1
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:37:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3213A20844;
	Tue, 17 Oct 2023 10:37:28 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P9RLUuBlqaoT; Tue, 17 Oct 2023 10:37:27 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7EB8120764;
	Tue, 17 Oct 2023 10:37:27 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 72BA280004E;
	Tue, 17 Oct 2023 10:37:27 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 10:37:27 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 17 Oct
 2023 10:37:26 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 72EA93182ADA; Tue, 17 Oct 2023 10:37:26 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 2/7] xfrm: interface: use DEV_STATS_INC()
Date: Tue, 17 Oct 2023 10:37:18 +0200
Message-ID: <20231017083723.1364940-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017083723.1364940-1-steffen.klassert@secunet.com>
References: <20231017083723.1364940-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Eric Dumazet <edumazet@google.com>

syzbot/KCSAN reported data-races in xfrm whenever dev->stats fields
are updated.

It appears all of these updates can happen from multiple cpus.

Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.

BUG: KCSAN: data-race in xfrmi_xmit / xfrmi_xmit

read-write to 0xffff88813726b160 of 8 bytes by task 23986 on cpu 1:
xfrmi_xmit+0x74e/0xb20 net/xfrm/xfrm_interface_core.c:583
__netdev_start_xmit include/linux/netdevice.h:4889 [inline]
netdev_start_xmit include/linux/netdevice.h:4903 [inline]
xmit_one net/core/dev.c:3544 [inline]
dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3560
__dev_queue_xmit+0xeee/0x1de0 net/core/dev.c:4340
dev_queue_xmit include/linux/netdevice.h:3082 [inline]
neigh_connected_output+0x231/0x2a0 net/core/neighbour.c:1581
neigh_output include/net/neighbour.h:542 [inline]
ip_finish_output2+0x74a/0x850 net/ipv4/ip_output.c:230
ip_finish_output+0xf4/0x240 net/ipv4/ip_output.c:318
NF_HOOK_COND include/linux/netfilter.h:293 [inline]
ip_output+0xe5/0x1b0 net/ipv4/ip_output.c:432
dst_output include/net/dst.h:458 [inline]
ip_local_out net/ipv4/ip_output.c:127 [inline]
ip_send_skb+0x72/0xe0 net/ipv4/ip_output.c:1487
udp_send_skb+0x6a4/0x990 net/ipv4/udp.c:963
udp_sendmsg+0x1249/0x12d0 net/ipv4/udp.c:1246
inet_sendmsg+0x63/0x80 net/ipv4/af_inet.c:840
sock_sendmsg_nosec net/socket.c:730 [inline]
sock_sendmsg net/socket.c:753 [inline]
____sys_sendmsg+0x37c/0x4d0 net/socket.c:2540
___sys_sendmsg net/socket.c:2594 [inline]
__sys_sendmmsg+0x269/0x500 net/socket.c:2680
__do_sys_sendmmsg net/socket.c:2709 [inline]
__se_sys_sendmmsg net/socket.c:2706 [inline]
__x64_sys_sendmmsg+0x57/0x60 net/socket.c:2706
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read-write to 0xffff88813726b160 of 8 bytes by task 23987 on cpu 0:
xfrmi_xmit+0x74e/0xb20 net/xfrm/xfrm_interface_core.c:583
__netdev_start_xmit include/linux/netdevice.h:4889 [inline]
netdev_start_xmit include/linux/netdevice.h:4903 [inline]
xmit_one net/core/dev.c:3544 [inline]
dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3560
__dev_queue_xmit+0xeee/0x1de0 net/core/dev.c:4340
dev_queue_xmit include/linux/netdevice.h:3082 [inline]
neigh_connected_output+0x231/0x2a0 net/core/neighbour.c:1581
neigh_output include/net/neighbour.h:542 [inline]
ip_finish_output2+0x74a/0x850 net/ipv4/ip_output.c:230
ip_finish_output+0xf4/0x240 net/ipv4/ip_output.c:318
NF_HOOK_COND include/linux/netfilter.h:293 [inline]
ip_output+0xe5/0x1b0 net/ipv4/ip_output.c:432
dst_output include/net/dst.h:458 [inline]
ip_local_out net/ipv4/ip_output.c:127 [inline]
ip_send_skb+0x72/0xe0 net/ipv4/ip_output.c:1487
udp_send_skb+0x6a4/0x990 net/ipv4/udp.c:963
udp_sendmsg+0x1249/0x12d0 net/ipv4/udp.c:1246
inet_sendmsg+0x63/0x80 net/ipv4/af_inet.c:840
sock_sendmsg_nosec net/socket.c:730 [inline]
sock_sendmsg net/socket.c:753 [inline]
____sys_sendmsg+0x37c/0x4d0 net/socket.c:2540
___sys_sendmsg net/socket.c:2594 [inline]
__sys_sendmmsg+0x269/0x500 net/socket.c:2680
__do_sys_sendmmsg net/socket.c:2709 [inline]
__se_sys_sendmmsg net/socket.c:2706 [inline]
__x64_sys_sendmmsg+0x57/0x60 net/socket.c:2706
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x00000000000010d7 -> 0x00000000000010d8

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 23987 Comm: syz-executor.5 Not tainted 6.5.0-syzkaller-10885-g0468be89b3fa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023

Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_interface_core.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index b86474084690..e21cc71095bb 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -380,8 +380,8 @@ static int xfrmi_rcv_cb(struct sk_buff *skb, int err)
 	skb->dev = dev;
 
 	if (err) {
-		dev->stats.rx_errors++;
-		dev->stats.rx_dropped++;
+		DEV_STATS_INC(dev, rx_errors);
+		DEV_STATS_INC(dev, rx_dropped);
 
 		return 0;
 	}
@@ -426,7 +426,6 @@ static int
 xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 {
 	struct xfrm_if *xi = netdev_priv(dev);
-	struct net_device_stats *stats = &xi->dev->stats;
 	struct dst_entry *dst = skb_dst(skb);
 	unsigned int length = skb->len;
 	struct net_device *tdev;
@@ -473,7 +472,7 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 	tdev = dst->dev;
 
 	if (tdev == dev) {
-		stats->collisions++;
+		DEV_STATS_INC(dev, collisions);
 		net_warn_ratelimited("%s: Local routing loop detected!\n",
 				     dev->name);
 		goto tx_err_dst_release;
@@ -512,13 +511,13 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 	if (net_xmit_eval(err) == 0) {
 		dev_sw_netstats_tx_add(dev, 1, length);
 	} else {
-		stats->tx_errors++;
-		stats->tx_aborted_errors++;
+		DEV_STATS_INC(dev, tx_errors);
+		DEV_STATS_INC(dev, tx_aborted_errors);
 	}
 
 	return 0;
 tx_err_link_failure:
-	stats->tx_carrier_errors++;
+	DEV_STATS_INC(dev, tx_carrier_errors);
 	dst_link_failure(skb);
 tx_err_dst_release:
 	dst_release(dst);
@@ -528,7 +527,6 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct xfrm_if *xi = netdev_priv(dev);
-	struct net_device_stats *stats = &xi->dev->stats;
 	struct dst_entry *dst = skb_dst(skb);
 	struct flowi fl;
 	int ret;
@@ -545,7 +543,7 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 			dst = ip6_route_output(dev_net(dev), NULL, &fl.u.ip6);
 			if (dst->error) {
 				dst_release(dst);
-				stats->tx_carrier_errors++;
+				DEV_STATS_INC(dev, tx_carrier_errors);
 				goto tx_err;
 			}
 			skb_dst_set(skb, dst);
@@ -561,7 +559,7 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 			fl.u.ip4.flowi4_flags |= FLOWI_FLAG_ANYSRC;
 			rt = __ip_route_output_key(dev_net(dev), &fl.u.ip4);
 			if (IS_ERR(rt)) {
-				stats->tx_carrier_errors++;
+				DEV_STATS_INC(dev, tx_carrier_errors);
 				goto tx_err;
 			}
 			skb_dst_set(skb, &rt->dst);
@@ -580,8 +578,8 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 
 tx_err:
-	stats->tx_errors++;
-	stats->tx_dropped++;
+	DEV_STATS_INC(dev, tx_errors);
+	DEV_STATS_INC(dev, tx_dropped);
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
 }
-- 
2.34.1


