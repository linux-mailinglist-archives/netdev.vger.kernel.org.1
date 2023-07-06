Return-Path: <netdev+bounces-15932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1AF74A7BB
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 01:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B1D1C20EE1
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 23:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A284A168C1;
	Thu,  6 Jul 2023 23:30:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E301640A
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 23:30:47 +0000 (UTC)
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA3ADC
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 16:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1688686246; x=1720222246;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=McShaDKep+QCylez7qiK/NcyXimXJT7SOwE5kNsTVjo=;
  b=CQzLN3WqmxwI8p7Chl9+7EQnHIfEJZcDn2cKxKm3mZ/sZLfFbibh2btg
   roWagAV+8xHX4QUL/G430IYrIzwKb7tBMIIpwHj224ajmZIYr+jTaTzsE
   g1aKKolXzqWUF/2Uv8abTFhMSMqYmJ7Bn9mHrATOSU4y0D3RuAET/dmzx
   8=;
X-IronPort-AV: E=Sophos;i="6.01,187,1684800000"; 
   d="scan'208";a="141250000"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 23:30:43 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix) with ESMTPS id 3522E40DB0;
	Thu,  6 Jul 2023 23:30:42 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 23:30:39 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 23:30:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Wang Yufen
	<wangyufen@huawei.com>
Subject: [PATCH v1 net] icmp6: Fix null-ptr-deref of fib6_null_entry->rt6i_idev in icmp6_dev().
Date: Thu, 6 Jul 2023 16:30:24 -0700
Message-ID: <20230706233024.63730-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.32]
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With some IPv6 Ext Hdr (RPL, SRv6, etc.), we can send a packet that
has the link-local address as src and dst IP and will be forwarded to
an external IP in the IPv6 Ext Hdr.

For example, the script below generates a packet whose src IP is the
link-local address and dst is updated to 11::.

  # for f in $(find /proc/sys/net/ -name *seg6_enabled*); do echo 1 > $f; done
  # python3
  >>> from socket import *
  >>> from scapy.all import *
  >>>
  >>> SRC_ADDR = DST_ADDR = "fe80::5054:ff:fe12:3456"
  >>>
  >>> pkt = IPv6(src=SRC_ADDR, dst=DST_ADDR)
  >>> pkt /= IPv6ExtHdrSegmentRouting(type=4, addresses=["11::", "22::"], segleft=1)
  >>>
  >>> sk = socket(AF_INET6, SOCK_RAW, IPPROTO_RAW)
  >>> sk.sendto(bytes(pkt), (DST_ADDR, 0))

For such a packet, we call ip6_route_input() to look up a route for the
next destination in these three functions depending on the header type.

  * ipv6_rthdr_rcv()
  * ipv6_rpl_srh_rcv()
  * ipv6_srh_rcv()

If no route is found, fib6_null_entry is set to skb, and the following
dst_input(skb) calls ip6_pkt_drop().

Finally, in icmp6_dev(), we dereference skb_rt6_info(skb)->rt6i_idev->dev
as the input device is the loopback interface.  Then, we have to check if
skb_rt6_info(skb)->rt6i_idev is NULL or not to avoid NULL pointer deref
for fib6_null_entry.

BUG: kernel NULL pointer dereference, address: 0000000000000000
 PF: supervisor read access in kernel mode
 PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 0 PID: 157 Comm: python3 Not tainted 6.4.0-11996-gb121d614371c #35
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:icmp6_send (net/ipv6/icmp.c:436 net/ipv6/icmp.c:503)
Code: fe ff ff 48 c7 40 30 c0 86 5d 83 e8 c6 44 1c 00 e9 c8 fc ff ff 49 8b 46 58 48 83 e0 fe 0f 84 4a fb ff ff 48 8b 80 d0 00 00 00 <48> 8b 00 44 8b 88 e0 00 00 00 e9 34 fb ff ff 4d 85 ed 0f 85 69 01
RSP: 0018:ffffc90000003c70 EFLAGS: 00000286
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000000000000e0
RDX: 0000000000000021 RSI: 0000000000000000 RDI: ffff888006d72a18
RBP: ffffc90000003d80 R08: 0000000000000000 R09: 0000000000000001
R10: ffffc90000003d98 R11: 0000000000000040 R12: ffff888006d72a10
R13: 0000000000000000 R14: ffff8880057fb800 R15: ffffffff835d86c0
FS:  00007f9dc72ee740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000057b2000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
 <IRQ>
 ip6_pkt_drop (net/ipv6/route.c:4513)
 ipv6_rthdr_rcv (net/ipv6/exthdrs.c:640 net/ipv6/exthdrs.c:686)
 ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:437 (discriminator 5))
 ip6_input_finish (./include/linux/rcupdate.h:781 net/ipv6/ip6_input.c:483)
 __netif_receive_skb_one_core (net/core/dev.c:5455)
 process_backlog (./include/linux/rcupdate.h:781 net/core/dev.c:5895)
 __napi_poll (net/core/dev.c:6460)
 net_rx_action (net/core/dev.c:6529 net/core/dev.c:6660)
 __do_softirq (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/irq.h:142 kernel/softirq.c:554)
 do_softirq (kernel/softirq.c:454 kernel/softirq.c:441)
 </IRQ>
 <TASK>
 __local_bh_enable_ip (kernel/softirq.c:381)
 __dev_queue_xmit (net/core/dev.c:4231)
 ip6_finish_output2 (./include/net/neighbour.h:544 net/ipv6/ip6_output.c:135)
 rawv6_sendmsg (./include/net/dst.h:458 ./include/linux/netfilter.h:303 net/ipv6/raw.c:656 net/ipv6/raw.c:914)
 sock_sendmsg (net/socket.c:725 net/socket.c:748)
 __sys_sendto (net/socket.c:2134)
 __x64_sys_sendto (net/socket.c:2146 net/socket.c:2142 net/socket.c:2142)
 do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
RIP: 0033:0x7f9dc751baea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
RSP: 002b:00007ffe98712c38 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007ffe98712cf8 RCX: 00007f9dc751baea
RDX: 0000000000000060 RSI: 00007f9dc6460b90 RDI: 0000000000000003
RBP: 00007f9dc56e8be0 R08: 00007ffe98712d70 R09: 000000000000001c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: ffffffffc4653600 R14: 0000000000000001 R15: 00007f9dc6af5d1b
 </TASK>
Modules linked in:
CR2: 0000000000000000
 ---[ end trace 0000000000000000 ]---
RIP: 0010:icmp6_send (net/ipv6/icmp.c:436 net/ipv6/icmp.c:503)
Code: fe ff ff 48 c7 40 30 c0 86 5d 83 e8 c6 44 1c 00 e9 c8 fc ff ff 49 8b 46 58 48 83 e0 fe 0f 84 4a fb ff ff 48 8b 80 d0 00 00 00 <48> 8b 00 44 8b 88 e0 00 00 00 e9 34 fb ff ff 4d 85 ed 0f 85 69 01
RSP: 0018:ffffc90000003c70 EFLAGS: 00000286
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000000000000e0
RDX: 0000000000000021 RSI: 0000000000000000 RDI: ffff888006d72a18
RBP: ffffc90000003d80 R08: 0000000000000000 R09: 0000000000000001
R10: ffffc90000003d98 R11: 0000000000000040 R12: ffff888006d72a10
R13: 0000000000000000 R14: ffff8880057fb800 R15: ffffffff835d86c0
FS:  00007f9dc72ee740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000057b2000 CR4: 00000000007506f0
PKRU: 55555554
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: disabled

Fixes: 4832c30d5458 ("net: ipv6: put host and anycast routes on device with address")
Reported-by: Wang Yufen <wangyufen@huawei.com>
Closes: https://lore.kernel.org/netdev/1ddf7fc8-bcb3-ab48-4894-24158e8a9d0f@huawei.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/icmp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 9edf1f45b1ed..bd6479e3c757 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -424,7 +424,10 @@ static struct net_device *icmp6_dev(const struct sk_buff *skb)
 	if (unlikely(dev->ifindex == LOOPBACK_IFINDEX || netif_is_l3_master(skb->dev))) {
 		const struct rt6_info *rt6 = skb_rt6_info(skb);
 
-		if (rt6)
+		/* The destination could be an external IP in Ext Hdr (SRv6, RPL, etc.),
+		 * and fib6_null_entry could be set to skb if no route is found.
+		 */
+		if (rt6 && rt6->rt6i_idev)
 			dev = rt6->rt6i_idev->dev;
 	}
 
-- 
2.30.2


