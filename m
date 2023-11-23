Return-Path: <netdev+bounces-50395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1547F58C6
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 08:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138E61C20B58
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 07:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B02C13AD4;
	Thu, 23 Nov 2023 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BD3A1
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 23:00:54 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SbTXC1w3dzvR9b;
	Thu, 23 Nov 2023 15:00:27 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 Nov
 2023 15:00:51 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net,v3] ipv4: igmp: fix refcnt uaf issue when receiving igmp query packet
Date: Thu, 23 Nov 2023 15:13:14 +0800
Message-ID: <20231123071314.3332069-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected

When I perform the following test operations:
1.ip link add br0 type bridge
2.brctl addif br0 eth0
3.ip addr add 239.0.0.1/32 dev eth0
4.ip addr add 239.0.0.1/32 dev br0
5.ip addr add 224.0.0.1/32 dev br0
6.while ((1))
    do
        ifconfig br0 up
        ifconfig br0 down
    done
7.send IGMPv2 query packets to port eth0 continuously. For example,
./mausezahn ethX -c 0 "01 00 5e 00 00 01 00 72 19 88 aa 02 08 00 45 00 00
1c 00 01 00 00 01 02 0e 7f c0 a8 0a b7 e0 00 00 01 11 64 ee 9b 00 00 00 00"

The preceding tests may trigger the refcnt uaf issue of the mc list. The
stack is as follows:
	refcount_t: addition on 0; use-after-free.
	WARNING: CPU: 21 PID: 144 at lib/refcount.c:25 refcount_warn_saturate (lib/refcount.c:25)
	CPU: 21 PID: 144 Comm: ksoftirqd/21 Kdump: loaded Not tainted 6.7.0-rc1-next-20231117-dirty #80
	Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
	RIP: 0010:refcount_warn_saturate (lib/refcount.c:25)
	RSP: 0018:ffffb68f00657910 EFLAGS: 00010286
	RAX: 0000000000000000 RBX: ffff8a00c3bf96c0 RCX: ffff8a07b6160908
	RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff8a07b6160900
	RBP: ffff8a00cba36862 R08: 0000000000000000 R09: 00000000ffff7fff
	R10: ffffb68f006577c0 R11: ffffffffb0fdcdc8 R12: ffff8a00c3bf9680
	R13: ffff8a00c3bf96f0 R14: 0000000000000000 R15: ffff8a00d8766e00
	FS:  0000000000000000(0000) GS:ffff8a07b6140000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: 000055f10b520b28 CR3: 000000039741a000 CR4: 00000000000006f0
	Call Trace:
	<TASK>
	igmp_heard_query (net/ipv4/igmp.c:1068)
	igmp_rcv (net/ipv4/igmp.c:1132)
	ip_protocol_deliver_rcu (net/ipv4/ip_input.c:205)
	ip_local_deliver_finish (net/ipv4/ip_input.c:234)
	__netif_receive_skb_one_core (net/core/dev.c:5529)
	netif_receive_skb_internal (net/core/dev.c:5729)
	netif_receive_skb (net/core/dev.c:5788)
	br_handle_frame_finish (net/bridge/br_input.c:216)
	nf_hook_bridge_pre (net/bridge/br_input.c:294)
	__netif_receive_skb_core (net/core/dev.c:5423)
	__netif_receive_skb_list_core (net/core/dev.c:5606)
	__netif_receive_skb_list (net/core/dev.c:5674)
	netif_receive_skb_list_internal (net/core/dev.c:5764)
	napi_gro_receive (net/core/gro.c:609)
	e1000_clean_rx_irq (drivers/net/ethernet/intel/e1000/e1000_main.c:4467)
	e1000_clean (drivers/net/ethernet/intel/e1000/e1000_main.c:3805)
	__napi_poll (net/core/dev.c:6533)
	net_rx_action (net/core/dev.c:6735)
	__do_softirq (kernel/softirq.c:554)
	run_ksoftirqd (kernel/softirq.c:913)
	smpboot_thread_fn (kernel/smpboot.c:164)
	kthread (kernel/kthread.c:388)
	ret_from_fork (arch/x86/kernel/process.c:153)
	ret_from_fork_asm (arch/x86/entry/entry_64.S:250)
	</TASK>

The root causes are as follows:
Thread A					Thread B
...						netif_receive_skb
br_dev_stop					...
    br_multicast_leave_snoopers			...
        __ip_mc_dec_group			...
            __igmp_group_dropped		igmp_rcv
                igmp_stop_timer			    igmp_heard_query         //ref = 1
                ip_ma_put			        igmp_mod_timer
                    refcount_dec_and_test	            igmp_start_timer //ref = 0
			...                                     refcount_inc //ref increases from 0
When the device receives an IGMPv2 Query message, it starts the timer
immediately, regardless of whether the device is running. If the device is
down and has left the multicast group, it will cause the mc list refcount
uaf issue.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
v3: I add some debug info in net/ipv4/igmp.c, the code is as follows.
    Also I remove strace information started with "?"
    1063	if (changed) {
    1064		mdelay(50);
    1065		printk("%s: indev:%s, im->multiaddr=0x%x, im name:%s\n",
    1066			__func__, in_dev->dev ? in_dev->dev->name : "NULL", im->multiaddr,
    1067			im->interface ? im->interface->dev->name : "NULL");
    1068		igmp_mod_timer(im, max_delay);
    1069	}
v2: use cmd "cat messages |/root/linux-next/scripts/decode_stacktrace.sh
    /root/linux-next/vmlinux" to get precise stack traces and check whether
    the im is destroyed before timer is started.
---
 net/ipv4/igmp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 76c3ea75b8dd..efeeca2b1328 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -216,8 +216,10 @@ static void igmp_start_timer(struct ip_mc_list *im, int max_delay)
 	int tv = get_random_u32_below(max_delay);
 
 	im->tm_running = 1;
-	if (!mod_timer(&im->timer, jiffies+tv+2))
-		refcount_inc(&im->refcnt);
+	if (refcount_inc_not_zero(&im->refcnt)) {
+		if (mod_timer(&im->timer, jiffies + tv + 2))
+			ip_ma_put(im);
+	}
 }
 
 static void igmp_gq_start_timer(struct in_device *in_dev)
-- 
2.34.1


