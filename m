Return-Path: <netdev+bounces-27653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E05DC77CAD1
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 11:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5501C20CF6
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A743B111A7;
	Tue, 15 Aug 2023 09:53:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D08E11CB5
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 09:53:23 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2918510C
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:53:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E939D2085B;
	Tue, 15 Aug 2023 11:53:20 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Id4rYd5Fg6f6; Tue, 15 Aug 2023 11:53:20 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7646920890;
	Tue, 15 Aug 2023 11:53:16 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 6791D80004A;
	Tue, 15 Aug 2023 11:53:16 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 11:53:16 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 11:53:15 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 59B3D3184316; Tue, 15 Aug 2023 11:53:14 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 06/11] ip6_vti: fix slab-use-after-free in decode_session6
Date: Tue, 15 Aug 2023 11:53:05 +0200
Message-ID: <20230815095310.3310160-7-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815095310.3310160-1-steffen.klassert@secunet.com>
References: <20230815095310.3310160-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Zhengchao Shao <shaozhengchao@huawei.com>

When ipv6_vti device is set to the qdisc of the sfb type, the cb field
of the sent skb may be modified during enqueuing. Then,
slab-use-after-free may occur when ipv6_vti device sends IPv6 packets.

The stack information is as follows:
BUG: KASAN: slab-use-after-free in decode_session6+0x103f/0x1890
Read of size 1 at addr ffff88802e08edc2 by task swapper/0/0
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.0-next-20230707-00001-g84e2cad7f979 #410
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
Call Trace:
<IRQ>
dump_stack_lvl+0xd9/0x150
print_address_description.constprop.0+0x2c/0x3c0
kasan_report+0x11d/0x130
decode_session6+0x103f/0x1890
__xfrm_decode_session+0x54/0xb0
vti6_tnl_xmit+0x3e6/0x1ee0
dev_hard_start_xmit+0x187/0x700
sch_direct_xmit+0x1a3/0xc30
__qdisc_run+0x510/0x17a0
__dev_queue_xmit+0x2215/0x3b10
neigh_connected_output+0x3c2/0x550
ip6_finish_output2+0x55a/0x1550
ip6_finish_output+0x6b9/0x1270
ip6_output+0x1f1/0x540
ndisc_send_skb+0xa63/0x1890
ndisc_send_rs+0x132/0x6f0
addrconf_rs_timer+0x3f1/0x870
call_timer_fn+0x1a0/0x580
expire_timers+0x29b/0x4b0
run_timer_softirq+0x326/0x910
__do_softirq+0x1d4/0x905
irq_exit_rcu+0xb7/0x120
sysvec_apic_timer_interrupt+0x97/0xc0
</IRQ>
Allocated by task 9176:
kasan_save_stack+0x22/0x40
kasan_set_track+0x25/0x30
__kasan_slab_alloc+0x7f/0x90
kmem_cache_alloc_node+0x1cd/0x410
kmalloc_reserve+0x165/0x270
__alloc_skb+0x129/0x330
netlink_sendmsg+0x9b1/0xe30
sock_sendmsg+0xde/0x190
____sys_sendmsg+0x739/0x920
___sys_sendmsg+0x110/0x1b0
__sys_sendmsg+0xf7/0x1c0
do_syscall_64+0x39/0xb0
entry_SYSCALL_64_after_hwframe+0x63/0xcd
Freed by task 9176:
kasan_save_stack+0x22/0x40
kasan_set_track+0x25/0x30
kasan_save_free_info+0x2b/0x40
____kasan_slab_free+0x160/0x1c0
slab_free_freelist_hook+0x11b/0x220
kmem_cache_free+0xf0/0x490
skb_free_head+0x17f/0x1b0
skb_release_data+0x59c/0x850
consume_skb+0xd2/0x170
netlink_unicast+0x54f/0x7f0
netlink_sendmsg+0x926/0xe30
sock_sendmsg+0xde/0x190
____sys_sendmsg+0x739/0x920
___sys_sendmsg+0x110/0x1b0
__sys_sendmsg+0xf7/0x1c0
do_syscall_64+0x39/0xb0
entry_SYSCALL_64_after_hwframe+0x63/0xcd
The buggy address belongs to the object at ffff88802e08ed00
which belongs to the cache skbuff_small_head of size 640
The buggy address is located 194 bytes inside of
freed 640-byte region [ffff88802e08ed00, ffff88802e08ef80)

As commit f855691975bb ("xfrm6: Fix the nexthdr offset in
_decode_session6.") showed, xfrm_decode_session was originally intended
only for the receive path. IP6CB(skb)->nhoff is not set during
transmission. Therefore, set the cb field in the skb to 0 before
sending packets.

Fixes: f855691975bb ("xfrm6: Fix the nexthdr offset in _decode_session6.")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv6/ip6_vti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 10b222865d46..73c85d4e0e9c 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -568,12 +568,12 @@ vti6_tnl_xmit(struct sk_buff *skb, struct net_device *dev)
 		    vti6_addr_conflict(t, ipv6_hdr(skb)))
 			goto tx_err;
 
-		xfrm_decode_session(skb, &fl, AF_INET6);
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET6);
 		break;
 	case htons(ETH_P_IP):
-		xfrm_decode_session(skb, &fl, AF_INET);
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET);
 		break;
 	default:
 		goto tx_err;
-- 
2.34.1


