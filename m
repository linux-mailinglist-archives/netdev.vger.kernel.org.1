Return-Path: <netdev+bounces-16410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A06B74D1AE
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 11:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E94281020
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8039CDDC6;
	Mon, 10 Jul 2023 09:34:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCD2DDBA
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 09:34:59 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BC71707
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 02:34:57 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QzzMs5w0rzTmPK;
	Mon, 10 Jul 2023 17:33:45 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 10 Jul
 2023 17:34:55 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net 1/3] xfrm: fix slab-use-after-free in decode_session6
Date: Mon, 10 Jul 2023 17:40:51 +0800
Message-ID: <20230710094053.3302181-2-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710094053.3302181-1-shaozhengchao@huawei.com>
References: <20230710094053.3302181-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When the xfrm device is set to the qdisc of the sfb type, the cb field
of the sent skb may be modified during enqueuing. Then,
slab-use-after-free may occur when the xfrm device sends IPv6 packets.

The stack information is as follows:
BUG: KASAN: slab-use-after-free in decode_session6+0x103f/0x1890
Read of size 1 at addr ffff8881111458ef by task swapper/3/0
CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.4.0-next-20230707 #409
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
Call Trace:
<IRQ>
dump_stack_lvl+0xd9/0x150
print_address_description.constprop.0+0x2c/0x3c0
kasan_report+0x11d/0x130
decode_session6+0x103f/0x1890
__xfrm_decode_session+0x54/0xb0
xfrmi_xmit+0x173/0x1ca0
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
<TASK>
asm_sysvec_apic_timer_interrupt+0x1a/0x20
RIP: 0010:intel_idle_hlt+0x23/0x30
Code: 1f 84 00 00 00 00 00 f3 0f 1e fa 41 54 41 89 d4 0f 1f 44 00 00 66 90 0f 1f 44 00 00 0f 00 2d c4 9f ab 00 0f 1f 44 00 00 fb f4 <fa> 44 89 e0 41 5c c3 66 0f 1f 44 00 00 f3 0f 1e fa 41 54 41 89 d4
RSP: 0018:ffffc90000197d78 EFLAGS: 00000246
RAX: 00000000000a83c3 RBX: ffffe8ffffd09c50 RCX: ffffffff8a22d8e5
RDX: 0000000000000001 RSI: ffffffff8d3f8080 RDI: ffffe8ffffd09c50
RBP: ffffffff8d3f8080 R08: 0000000000000001 R09: ffffed1026ba6d9d
R10: ffff888135d36ceb R11: 0000000000000001 R12: 0000000000000001
R13: ffffffff8d3f8100 R14: 0000000000000001 R15: 0000000000000000
cpuidle_enter_state+0xd3/0x6f0
cpuidle_enter+0x4e/0xa0
do_idle+0x2fe/0x3c0
cpu_startup_entry+0x18/0x20
start_secondary+0x200/0x290
secondary_startup_64_no_verify+0x167/0x16b
</TASK>
Allocated by task 939:
kasan_save_stack+0x22/0x40
kasan_set_track+0x25/0x30
__kasan_slab_alloc+0x7f/0x90
kmem_cache_alloc_node+0x1cd/0x410
kmalloc_reserve+0x165/0x270
__alloc_skb+0x129/0x330
inet6_ifa_notify+0x118/0x230
__ipv6_ifa_notify+0x177/0xbe0
addrconf_dad_completed+0x133/0xe00
addrconf_dad_work+0x764/0x1390
process_one_work+0xa32/0x16f0
worker_thread+0x67d/0x10c0
kthread+0x344/0x440
ret_from_fork+0x1f/0x30
The buggy address belongs to the object at ffff888111145800
which belongs to the cache skbuff_small_head of size 640
The buggy address is located 239 bytes inside of
freed 640-byte region [ffff888111145800, ffff888111145a80)

As commit f855691975bb ("xfrm6: Fix the nexthdr offset in
_decode_session6.") showed, xfrm_decode_session was originally intended
only for the receive path. IP6CB(skb)->nhoff is not set during
transmission. Therefore, set the cb field in the skb to 0 before
sending packets.

Fixes: f855691975bb ("xfrm6: Fix the nexthdr offset in _decode_session6.")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/xfrm/xfrm_interface_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index a3319965470a..b86474084690 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -537,8 +537,8 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IPV6):
-		xfrm_decode_session(skb, &fl, AF_INET6);
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET6);
 		if (!dst) {
 			fl.u.ip6.flowi6_oif = dev->ifindex;
 			fl.u.ip6.flowi6_flags |= FLOWI_FLAG_ANYSRC;
@@ -552,8 +552,8 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 		break;
 	case htons(ETH_P_IP):
-		xfrm_decode_session(skb, &fl, AF_INET);
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET);
 		if (!dst) {
 			struct rtable *rt;
 
-- 
2.34.1


