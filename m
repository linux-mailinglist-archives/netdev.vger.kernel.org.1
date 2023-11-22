Return-Path: <netdev+bounces-49912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B047F3CB2
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 05:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1452819C8
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 04:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB59BA25;
	Wed, 22 Nov 2023 04:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DF210C
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 20:17:13 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SZnxp6CYSzvQwN;
	Wed, 22 Nov 2023 12:16:46 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 Nov
 2023 12:17:10 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net,v2] ipv4: igmp: fix refcnt uaf issue when receiving igmp query packet
Date: Wed, 22 Nov 2023 12:29:36 +0800
Message-ID: <20231122042936.1831735-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
	WARNING: CPU: 21 PID: 144 at lib/refcount.c:25 refcount_warn_saturate+0x78/0x110
	CPU: 21 PID: 144 Comm: ksoftirqd/21 Kdump: loaded Not tainted 6.7.0-rc1-next-20231117-dirty #57
	RIP: 0010:refcount_warn_saturate+0x78/0x110
	Call Trace:
	<TASK>
	__warn+0x83/0x130
	refcount_warn_saturate+0x78/0x110
	igmp_start_timer
	igmp_mod_timer
	igmp_heard_query+0x221/0x690
	igmp_rcv+0xea/0x2f0
	ip_protocol_deliver_rcu+0x156/0x160
	ip_local_deliver_finish+0x77/0xa0
	__netif_receive_skb_one_core+0x8b/0xa0
	netif_receive_skb_internal+0x80/0xd0
	netif_receive_skb+0x18/0xc0
	br_handle_frame_finish+0x340/0x5c0 [bridge]
	nf_hook_bridge_pre+0x117/0x130 [bridge]
	__netif_receive_skb_core+0x241/0x1090
	__netif_receive_skb_list_core+0x13f/0x2e0
	__netif_receive_skb_list+0xfc/0x190
	netif_receive_skb_list_internal+0x102/0x1e0
	napi_gro_receive+0xd7/0x220
	e1000_clean_rx_irq+0x1d4/0x4f0 [e1000]
	e1000_clean+0x5e/0xe0 [e1000]
	__napi_poll+0x2c/0x1b0
	net_rx_action+0x2cb/0x3a0
	__do_softirq+0xcd/0x2a7
	run_ksoftirqd+0x22/0x30
	smpboot_thread_fn+0xdb/0x1d0
	kthread+0xe2/0x110
	ret_from_fork+0x34/0x50
	ret_from_fork_asm+0x1a/0x30
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


