Return-Path: <netdev+bounces-156166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5C1A05337
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 07:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB6237A2428
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 06:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E9B1A7255;
	Wed,  8 Jan 2025 06:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EaWPyNX3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB24E1A7045
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 06:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736317788; cv=none; b=D4Rhh5WEXMFCgec0F5zpJqw1O+24YKRRqf235qJeH2UodUEo5S+D916hr4Qi+puEd0y1MASf0P8bntqIQQowCOjF0RmmOmytbzEJnaw6zZTgB0uh/FrTIWYy4YKlg6w+7cNveSRnJt3BFCvzV8offlBA+qrtKiBop+9oEJiAFYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736317788; c=relaxed/simple;
	bh=0PU6XYU57UyAzBIkkJ8QSj7WFpTWozu46QlS5RSo6nM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGxQe8NeEzwX6+vOx1G8Uo+bv0HK5sWSA+18uu6zbF6mcVnOP+9CPa359tY1wrq+dexZTSnKSlGVs5rFyxbRA3Fl469DzQ2XO7LRau5WU3+e36Rxe7w7lkGWehhMc2Jn30zjHjRh/MobNPI0bT/Zo0fYTqP/ApMGpzy/j6Ns6o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EaWPyNX3; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736317785; x=1767853785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zPlTAXNcIFA8RwSydqDIpstZRb9IRasqQuwEvP/Pohc=;
  b=EaWPyNX36inQldK2QSQZq4O4goxkF9iCzrwE1rhSWg6Ye52n572vr/KL
   1LGp4hnQ+M7GIrz79oPLHNdx7KIR902U9vNH2dBw7YAA8fDy0MObaWaEr
   vk2NnXncF1xOnsGtCM6AgSsh91LMWLpIzzmv7vgm8LqxQWAwAlGYFajDy
   w=;
X-IronPort-AV: E=Sophos;i="6.12,297,1728950400"; 
   d="scan'208";a="56093579"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 06:29:43 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:52715]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.128:2525] with esmtp (Farcaster)
 id f4f34a11-0d6e-4ff0-9947-7811132ecbe8; Wed, 8 Jan 2025 06:29:44 +0000 (UTC)
X-Farcaster-Flow-ID: f4f34a11-0d6e-4ff0-9947-7811132ecbe8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 8 Jan 2025 06:29:43 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 8 Jan 2025 06:29:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
	<horms@kernel.org>
CC: Xiao Liang <shaw.leon@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Pablo
 Neira Ayuso" <pablo@netfilter.org>, Harald Welte <laforge@gnumonks.org>
Subject: [PATCH v1 net 2/3] gtp: Destroy device along with udp socket's netns dismantle.
Date: Wed, 8 Jan 2025 15:28:33 +0900
Message-ID: <20250108062834.11117-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250108062834.11117-1-kuniyu@amazon.com>
References: <20250108062834.11117-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

gtp_newlink() links the device to a list in dev_net(dev) instead of
src_net, where a udp tunnel socket is created.

Even when src_net is removed, the device stays alive on dev_net(dev).
Then, removing src_net triggers the splat below. [0]

In this example, gtp0 is created in ns2, and the udp socket is created
in ns1.

  ip netns add ns1
  ip netns add ns2
  ip -n ns1 link add netns ns2 name gtp0 type gtp role sgsn
  ip netns del ns1

Let's link the device to the socket's netns instead.

Now, gtp_net_exit_batch_rtnl() needs another netdev iteration to remove
all gtp devices in the netns.

[0]:
ref_tracker: net notrefcnt@000000003d6e7d05 has 1/2 users at
     sk_alloc (./include/net/net_namespace.h:345 net/core/sock.c:2236)
     inet_create (net/ipv4/af_inet.c:326 net/ipv4/af_inet.c:252)
     __sock_create (net/socket.c:1558)
     udp_sock_create4 (net/ipv4/udp_tunnel_core.c:18)
     gtp_create_sock (./include/net/udp_tunnel.h:59 drivers/net/gtp.c:1423)
     gtp_create_sockets (drivers/net/gtp.c:1447)
     gtp_newlink (drivers/net/gtp.c:1507)
     rtnl_newlink (net/core/rtnetlink.c:3786 net/core/rtnetlink.c:3897 net/core/rtnetlink.c:4012)
     rtnetlink_rcv_msg (net/core/rtnetlink.c:6922)
     netlink_rcv_skb (net/netlink/af_netlink.c:2542)
     netlink_unicast (net/netlink/af_netlink.c:1321 net/netlink/af_netlink.c:1347)
     netlink_sendmsg (net/netlink/af_netlink.c:1891)
     ____sys_sendmsg (net/socket.c:711 net/socket.c:726 net/socket.c:2583)
     ___sys_sendmsg (net/socket.c:2639)
     __sys_sendmsg (net/socket.c:2669)
     do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)

WARNING: CPU: 1 PID: 60 at lib/ref_tracker.c:179 ref_tracker_dir_exit (lib/ref_tracker.c:179)
Modules linked in:
CPU: 1 UID: 0 PID: 60 Comm: kworker/u16:2 Not tainted 6.13.0-rc5-00147-g4c1224501e9d #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:ref_tracker_dir_exit (lib/ref_tracker.c:179)
Code: 00 00 00 fc ff df 4d 8b 26 49 bd 00 01 00 00 00 00 ad de 4c 39 f5 0f 85 df 00 00 00 48 8b 74 24 08 48 89 df e8 a5 cc 12 02 90 <0f> 0b 90 48 8d 6b 44 be 04 00 00 00 48 89 ef e8 80 de 67 ff 48 89
RSP: 0018:ff11000009a07b60 EFLAGS: 00010286
RAX: 0000000000002bd3 RBX: ff1100000f4e1aa0 RCX: 1ffffffff0e40ac6
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8423ee3c
RBP: ff1100000f4e1af0 R08: 0000000000000001 R09: fffffbfff0e395ae
R10: 0000000000000001 R11: 0000000000036001 R12: ff1100000f4e1af0
R13: dead000000000100 R14: ff1100000f4e1af0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ff1100006ce80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9b2464bd98 CR3: 0000000005286005 CR4: 0000000000771ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn (kernel/panic.c:748)
 ? ref_tracker_dir_exit (lib/ref_tracker.c:179)
 ? report_bug (lib/bug.c:201 lib/bug.c:219)
 ? handle_bug (arch/x86/kernel/traps.c:285)
 ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1))
 ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
 ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/irqflags.h:42 ./arch/x86/include/asm/irqflags.h:97 ./arch/x86/include/asm/irqflags.h:155 ./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
 ? ref_tracker_dir_exit (lib/ref_tracker.c:179)
 ? __pfx_ref_tracker_dir_exit (lib/ref_tracker.c:158)
 ? kfree (mm/slub.c:4613 mm/slub.c:4761)
 net_free (net/core/net_namespace.c:476 net/core/net_namespace.c:467)
 cleanup_net (net/core/net_namespace.c:664 (discriminator 3))
 process_one_work (kernel/workqueue.c:3229)
 worker_thread (kernel/workqueue.c:3304 kernel/workqueue.c:3391)
 kthread (kernel/kthread.c:389)
 ret_from_fork (arch/x86/kernel/process.c:147)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
 </TASK>

Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/20250104125732.17335-1-shaw.leon@gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Harald Welte <laforge@gnumonks.org>
---
 drivers/net/gtp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 8e456d09d173..97fcd0c9525f 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1524,7 +1524,7 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
 		goto out_encap;
 	}
 
-	gn = net_generic(dev_net(dev), gtp_net_id);
+	gn = net_generic(src_net, gtp_net_id);
 	list_add(&gtp->list, &gn->gtp_dev_list);
 	dev->priv_destructor = gtp_destructor;
 
@@ -2480,6 +2480,11 @@ static void __net_exit gtp_net_exit_batch_rtnl(struct list_head *net_list,
 	list_for_each_entry(net, net_list, exit_list) {
 		struct gtp_net *gn = net_generic(net, gtp_net_id);
 		struct gtp_dev *gtp, *gtp_next;
+		struct net_device *dev;
+
+		for_each_netdev(net, dev)
+			if (dev->rtnl_link_ops == &gtp_link_ops)
+				gtp_dellink(dev, dev_to_kill);
 
 		list_for_each_entry_safe(gtp, gtp_next, &gn->gtp_dev_list, list)
 			gtp_dellink(gtp->dev, dev_to_kill);
-- 
2.39.5 (Apple Git-154)


