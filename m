Return-Path: <netdev+bounces-154648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDAE9FF394
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 10:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5C41881872
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 09:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AF32EB1D;
	Wed,  1 Jan 2025 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DbMv9V60"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596F125771
	for <netdev@vger.kernel.org>; Wed,  1 Jan 2025 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735722631; cv=none; b=WzbMkRgUG6WKm8ySS2VCQ2LeDmQHlVwV5oeMBNkofaRt3fE9gmA2gIltOq/JRhZQ6jp1g+pNfHwDlkWDJfll1SYkj1sUqwGs5ms/Kj0N5dw1BS/706tasjhNcGicFF7MhIWLUCMTjs6qOX9o2zK+e+PunSiGttao4BC8rRIvs2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735722631; c=relaxed/simple;
	bh=fMuRObfvCVKn/P/QtTdT/LBF66VwEWD0m2zcq0LURBI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m3BcrfykAcFq18CfXTzsvY7sDdrAklBdrWLVdl7RB30vBVU5dh2wxv9HX71jNtkVCNDF0lppU1DhrPiiy2XZMLuiIQAafX8sWfzOWOqtqEvAeeoohiAddVPRdcIr82/BuqtOx1Q7z4xwM8m7MtdHyMdhx+qqFlIUt5i4MZrMRt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DbMv9V60; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1735722482; x=1767258482;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xZnPMoM3xqacq8MeWkdFg4PWxjd+bwIJMW97pL9nEzw=;
  b=DbMv9V606UXynFBcPRwhx+mYz+aF7AOMEKbFeT+jqva/f7hpIyVU2rF4
   0pgYxmAgpFInn8gvuupaqn5K6NXYJ6PzTjdszScdeFRqQRf1oMuQnFG/o
   v2M/uW0j3Ux2+s4RatEKgMnKI0ZZ/Olxwh+iRYloT0lQG7qZwJVoqugvy
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,281,1728950400"; 
   d="scan'208";a="11144040"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 09:08:00 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:64353]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.144:2525] with esmtp (Farcaster)
 id 35111c00-0d3a-4f9f-a81e-7a9de71f3c9e; Wed, 1 Jan 2025 09:10:26 +0000 (UTC)
X-Farcaster-Flow-ID: 35111c00-0d3a-4f9f-a81e-7a9de71f3c9e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 1 Jan 2025 09:10:26 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 1 Jan 2025 09:10:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
	<horms@kernel.org>
CC: Mahesh Bandewar <maheshb@google.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH v1 net] ipvlan: Fix use-after-free in ipvlan_get_iflink().
Date: Wed, 1 Jan 2025 18:10:08 +0900
Message-ID: <20250101091008.27533-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzbot presented a use-after-free report [0] regarding ipvlan and
linkwatch.

ipvlan does not hold a refcnt of the lower device.

When the linkwatch work is triggered for the ipvlan dev, the lower
dev might have already been freed.

Let's hold the lower dev's refcnt in dev->netdev_ops->ndo_init()
and release it in dev->priv_destructor() as done for vlan and macvlan.

[0]:
BUG: KASAN: slab-use-after-free in ipvlan_get_iflink+0x84/0x88 drivers/net/ipvlan/ipvlan_main.c:353
Read of size 4 at addr ffff0000d768c0e0 by task kworker/u8:35/6944

CPU: 0 UID: 0 PID: 6944 Comm: kworker/u8:35 Not tainted 6.13.0-rc2-g9bc5c9515b48 #12 4c3cb9e8b4565456f6a355f312ff91f4f29b3c47
Hardware name: linux,dummy-virt (DT)
Workqueue: events_unbound linkwatch_event
Call trace:
 show_stack+0x38/0x50 arch/arm64/kernel/stacktrace.c:484 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xbc/0x108 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x16c/0x6f0 mm/kasan/report.c:489
 kasan_report+0xc0/0x120 mm/kasan/report.c:602
 __asan_report_load4_noabort+0x20/0x30 mm/kasan/report_generic.c:380
 ipvlan_get_iflink+0x84/0x88 drivers/net/ipvlan/ipvlan_main.c:353
 dev_get_iflink+0x7c/0xd8 net/core/dev.c:674
 default_operstate net/core/link_watch.c:45 [inline]
 rfc2863_policy+0x144/0x360 net/core/link_watch.c:72
 linkwatch_do_dev+0x60/0x228 net/core/link_watch.c:175
 __linkwatch_run_queue+0x2f4/0x5b8 net/core/link_watch.c:239
 linkwatch_event+0x64/0xa8 net/core/link_watch.c:282
 process_one_work+0x700/0x1398 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x8c4/0xe10 kernel/workqueue.c:3391
 kthread+0x2b0/0x360 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862

Allocated by task 9303:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x68 mm/kasan/common.c:68
 kasan_save_alloc_info+0x44/0x58 mm/kasan/generic.c:568
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x84/0xa0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4283 [inline]
 __kmalloc_node_noprof+0x2a0/0x560 mm/slub.c:4289
 __kvmalloc_node_noprof+0x9c/0x230 mm/util.c:650
 alloc_netdev_mqs+0xb4/0x1118 net/core/dev.c:11209
 rtnl_create_link+0x2b8/0xb60 net/core/rtnetlink.c:3595
 rtnl_newlink_create+0x19c/0x868 net/core/rtnetlink.c:3771
 __rtnl_newlink net/core/rtnetlink.c:3896 [inline]
 rtnl_newlink+0x122c/0x15c0 net/core/rtnetlink.c:4011
 rtnetlink_rcv_msg+0x61c/0x918 net/core/rtnetlink.c:6901
 netlink_rcv_skb+0x1dc/0x398 net/netlink/af_netlink.c:2542
 rtnetlink_rcv+0x34/0x50 net/core/rtnetlink.c:6928
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x618/0x838 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x5fc/0x8b0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg net/socket.c:726 [inline]
 __sys_sendto+0x2ec/0x438 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __arm64_sys_sendto+0xe4/0x110 net/socket.c:2200
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x90/0x278 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x13c/0x250 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x54/0x70 arch/arm64/kernel/syscall.c:151
 el0_svc+0x4c/0xa8 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x1a0 arch/arm64/kernel/entry.S:600

Freed by task 10200:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x68 mm/kasan/common.c:68
 kasan_save_free_info+0x58/0x70 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x48/0x68 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kfree+0x140/0x420 mm/slub.c:4746
 kvfree+0x4c/0x68 mm/util.c:693
 netdev_release+0x94/0xc8 net/core/net-sysfs.c:2034
 device_release+0x98/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x2b0/0x438 lib/kobject.c:737
 netdev_run_todo+0xdd8/0xf48 net/core/dev.c:10924
 rtnl_unlock net/core/rtnetlink.c:152 [inline]
 rtnl_net_unlock net/core/rtnetlink.c:209 [inline]
 rtnl_dellink+0x484/0x680 net/core/rtnetlink.c:3526
 rtnetlink_rcv_msg+0x61c/0x918 net/core/rtnetlink.c:6901
 netlink_rcv_skb+0x1dc/0x398 net/netlink/af_netlink.c:2542
 rtnetlink_rcv+0x34/0x50 net/core/rtnetlink.c:6928
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x618/0x838 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x5fc/0x8b0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg net/socket.c:726 [inline]
 ____sys_sendmsg+0x410/0x708 net/socket.c:2583
 ___sys_sendmsg+0x178/0x1d8 net/socket.c:2637
 __sys_sendmsg net/socket.c:2669 [inline]
 __do_sys_sendmsg net/socket.c:2674 [inline]
 __se_sys_sendmsg net/socket.c:2672 [inline]
 __arm64_sys_sendmsg+0x12c/0x1c8 net/socket.c:2672
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x90/0x278 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x13c/0x250 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x54/0x70 arch/arm64/kernel/syscall.c:151
 el0_svc+0x4c/0xa8 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x1a0 arch/arm64/kernel/entry.S:600

The buggy address belongs to the object at ffff0000d768c000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 224 bytes inside of
 freed 4096-byte region [ffff0000d768c000, ffff0000d768d000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x117688
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff0000c77ef981
flags: 0xbfffe0000000040(head|node=0|zone=2|lastcpupid=0x1ffff)
page_type: f5(slab)
raw: 0bfffe0000000040 ffff0000c000f500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000040004 00000001f5000000 ffff0000c77ef981
head: 0bfffe0000000040 ffff0000c000f500 dead000000000100 dead000000000122
head: 0000000000000000 0000000000040004 00000001f5000000 ffff0000c77ef981
head: 0bfffe0000000003 fffffdffc35da201 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000d768bf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000d768c000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000d768c080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff0000d768c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000d768c180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/net/ipvlan/ipvlan.h      |  1 +
 drivers/net/ipvlan/ipvlan_main.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index 025e0c19ec25..3d22e0c7805d 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -70,6 +70,7 @@ struct ipvl_dev {
 	netdev_features_t	sfeatures;
 	u32			msg_enable;
 	spinlock_t		addrs_lock;
+	netdevice_tracker	dev_tracker;
 };
 
 struct ipvl_addr {
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index ee2c3cf4df36..3566b21f49d5 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -160,6 +160,9 @@ static int ipvlan_init(struct net_device *dev)
 	}
 	port = ipvlan_port_get_rtnl(phy_dev);
 	port->count += 1;
+
+	netdev_hold(phy_dev, &ipvlan->dev_tracker, GFP_KERNEL);
+
 	return 0;
 }
 
@@ -669,6 +672,13 @@ void ipvlan_link_delete(struct net_device *dev, struct list_head *head)
 }
 EXPORT_SYMBOL_GPL(ipvlan_link_delete);
 
+static void ipvlan_link_destruct(struct net_device *dev)
+{
+	struct ipvl_dev *ipvlan = netdev_priv(dev);
+
+	netdev_put(ipvlan->phy_dev, &ipvlan->dev_tracker);
+}
+
 void ipvlan_link_setup(struct net_device *dev)
 {
 	ether_setup(dev);
@@ -678,6 +688,7 @@ void ipvlan_link_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_UNICAST_FLT | IFF_NO_QUEUE;
 	dev->netdev_ops = &ipvlan_netdev_ops;
 	dev->needs_free_netdev = true;
+	dev->priv_destructor = ipvlan_link_destruct;
 	dev->header_ops = &ipvlan_header_ops;
 	dev->ethtool_ops = &ipvlan_ethtool_ops;
 }
-- 
2.39.5 (Apple Git-154)


