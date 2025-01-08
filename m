Return-Path: <netdev+bounces-156167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6311AA05338
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 07:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF591881D55
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 06:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C49A1A841C;
	Wed,  8 Jan 2025 06:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="I9kl/ZY8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F0A19F421
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736317822; cv=none; b=ZcyRCvLl/mIv1TJFeYGFE5gmuSgICRaDcCwc3N6HI4ZdRozb9JA0dsesfSH+AVnu6qp9SsDsf2FeePKPyenkzWoT+KnEjQwKPRgUPG13/QX479SU2vig5jThRqeEIDKeuXrrQD5yqc6H50e//jLWpKKDxJjjY4kW8DHjOJY11Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736317822; c=relaxed/simple;
	bh=55VsQ0LYNS0ayUK7jgjBLbap6JjiTPG9nDZQWSEwrMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgUTOstW5u4/ZVs5VgO8m7xSzO+BrpkWD7yb0XwljYhzAgKPzrD3TQyBTlqUzjcy7ZJ/VG69LHqVURZmJjnCHuoYx0UysvlQVVAlRF3RWQPlEY5KXgzL6rozIHY1oK0ojHXKAi+emMJ9oqrEwJSmkEJtRpvQisyy94ZDwPajLro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=I9kl/ZY8; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736317820; x=1767853820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EK9I1kZbPFS5gqgyMktmGDK/Go+H1JpeI07lY0npmaw=;
  b=I9kl/ZY8FpRnft1AI6Ac0/p4ZUoJK0TKuUNkcwMHRc3Q7XhsJ8zAo6RF
   Tkc7HbRaNYJWsWkNjQPcELoMFClKSRYeiUoQaeiv7W2qVvRIG5JY6gihu
   Ku5ZS/S+mxXO5eHDirlMFVvkl69m37svTcMoiLCtchiDOoDvjFb9EnsRP
   c=;
X-IronPort-AV: E=Sophos;i="6.12,297,1728950400"; 
   d="scan'208";a="709310352"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 06:30:14 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:39785]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.128:2525] with esmtp (Farcaster)
 id 375064e9-e181-43af-a281-9a4da2ee081b; Wed, 8 Jan 2025 06:30:14 +0000 (UTC)
X-Farcaster-Flow-ID: 375064e9-e181-43af-a281-9a4da2ee081b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 8 Jan 2025 06:30:11 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 8 Jan 2025 06:30:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
	<horms@kernel.org>
CC: Xiao Liang <shaw.leon@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Wojciech
 Drewek" <wojciech.drewek@intel.com>, Marcin Szycik
	<marcin.szycik@linux.intel.com>
Subject: [PATCH v1 net 3/3] pfcp: Destroy device along with udp socket's netns dismantle.
Date: Wed, 8 Jan 2025 15:28:34 +0900
Message-ID: <20250108062834.11117-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

pfcp_newlink() links the device to a list in dev_net(dev) instead
of net, where a udp tunnel socket is created.

Even when net is removed, the device stays alive on dev_net(dev).
Then, removing net triggers the splat below. [0]

In this example, pfcp0 is created in ns2, but the udp socket is
created in ns1.

  ip netns add ns1
  ip netns add ns2
  ip -n ns1 link add netns ns2 name pfcp0 type pfcp
  ip netns del ns1

Let's link the device to the socket's netns instead.

Now, pfcp_net_exit() needs another netdev iteration to remove
all pfcp devices in the netns.

pfcp_dev_list is not used under RCU, so the list API is converted
to the non-RCU variant.

pfcp_net_exit() can be converted to .exit_batch_rtnl() in net-next.

[0]:
ref_tracker: net notrefcnt@00000000128b34dc has 1/1 users at
     sk_alloc (./include/net/net_namespace.h:345 net/core/sock.c:2236)
     inet_create (net/ipv4/af_inet.c:326 net/ipv4/af_inet.c:252)
     __sock_create (net/socket.c:1558)
     udp_sock_create4 (net/ipv4/udp_tunnel_core.c:18)
     pfcp_create_sock (drivers/net/pfcp.c:168)
     pfcp_newlink (drivers/net/pfcp.c:182 drivers/net/pfcp.c:197)
     rtnl_newlink (net/core/rtnetlink.c:3786 net/core/rtnetlink.c:3897 net/core/rtnetlink.c:4012)
     rtnetlink_rcv_msg (net/core/rtnetlink.c:6922)
     netlink_rcv_skb (net/netlink/af_netlink.c:2542)
     netlink_unicast (net/netlink/af_netlink.c:1321 net/netlink/af_netlink.c:1347)
     netlink_sendmsg (net/netlink/af_netlink.c:1891)
     ____sys_sendmsg (net/socket.c:711 net/socket.c:726 net/socket.c:2583)
     ___sys_sendmsg (net/socket.c:2639)
     __sys_sendmsg (net/socket.c:2669)
     do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

WARNING: CPU: 1 PID: 11 at lib/ref_tracker.c:179 ref_tracker_dir_exit (lib/ref_tracker.c:179)
Modules linked in:
CPU: 1 UID: 0 PID: 11 Comm: kworker/u16:0 Not tainted 6.13.0-rc5-00147-g4c1224501e9d #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:ref_tracker_dir_exit (lib/ref_tracker.c:179)
Code: 00 00 00 fc ff df 4d 8b 26 49 bd 00 01 00 00 00 00 ad de 4c 39 f5 0f 85 df 00 00 00 48 8b 74 24 08 48 89 df e8 a5 cc 12 02 90 <0f> 0b 90 48 8d 6b 44 be 04 00 00 00 48 89 ef e8 80 de 67 ff 48 89
RSP: 0018:ff11000007f3fb60 EFLAGS: 00010286
RAX: 00000000000020ef RBX: ff1100000d6481e0 RCX: 1ffffffff0e40d82
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8423ee3c
RBP: ff1100000d648230 R08: 0000000000000001 R09: fffffbfff0e395af
R10: 0000000000000001 R11: 0000000000000000 R12: ff1100000d648230
R13: dead000000000100 R14: ff1100000d648230 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ff1100006ce80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005620e1363990 CR3: 000000000eeb2002 CR4: 0000000000771ef0
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

Fixes: 76c8764ef36a ("pfcp: add PFCP module")
Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/20250104125732.17335-1-shaw.leon@gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/pfcp.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index 69434fd13f96..68d0d9e92a22 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -206,8 +206,8 @@ static int pfcp_newlink(struct net *net, struct net_device *dev,
 		goto exit_del_pfcp_sock;
 	}
 
-	pn = net_generic(dev_net(dev), pfcp_net_id);
-	list_add_rcu(&pfcp->list, &pn->pfcp_dev_list);
+	pn = net_generic(net, pfcp_net_id);
+	list_add(&pfcp->list, &pn->pfcp_dev_list);
 
 	netdev_dbg(dev, "registered new PFCP interface\n");
 
@@ -224,7 +224,7 @@ static void pfcp_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct pfcp_dev *pfcp = netdev_priv(dev);
 
-	list_del_rcu(&pfcp->list);
+	list_del(&pfcp->list);
 	unregister_netdevice_queue(dev, head);
 }
 
@@ -247,11 +247,16 @@ static int __net_init pfcp_net_init(struct net *net)
 static void __net_exit pfcp_net_exit(struct net *net)
 {
 	struct pfcp_net *pn = net_generic(net, pfcp_net_id);
-	struct pfcp_dev *pfcp;
+	struct pfcp_dev *pfcp, *pfcp_next;
+	struct net_device *dev;
 	LIST_HEAD(list);
 
 	rtnl_lock();
-	list_for_each_entry(pfcp, &pn->pfcp_dev_list, list)
+	for_each_netdev(net, dev)
+		if (dev->rtnl_link_ops == &pfcp_link_ops)
+			pfcp_dellink(dev, &list);
+
+	list_for_each_entry_safe(pfcp, pfcp_next, &pn->pfcp_dev_list, list)
 		pfcp_dellink(pfcp->dev, &list);
 
 	unregister_netdevice_many(&list);
-- 
2.39.5 (Apple Git-154)


