Return-Path: <netdev+bounces-115043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF56944F28
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 17:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6AA2284132
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8C41A99C4;
	Thu,  1 Aug 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="g4z0XSoj"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE011A71E1
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526028; cv=none; b=O75K3NvxXU4SqNOHUn40ApSTtrChLS/LXDdBDRX2XhRfrXsX8L5DM+ZTKLHfi7velOEg1/exYR6dYOfzrQkCyboOLdbPlYC3OYQrKe6ljfsfv6Tnd1OFdkvnfQkJRTxlVQzXaZU3zLbAj+W4xa5hVLJC+jN31r3nJL8HT8FoYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526028; c=relaxed/simple;
	bh=4h0Y6LtuSzhJHCsb2ZCCiML34iodb18YUPVtFffsGYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SkV7ibYD65W01AkAcBah8aAtJWHdZzkMekZ+BSMJbXQA3HRgjfTiQExMWUmPxbmQCACnoe9q1mP23paTdV1L4x5iNwrkI6ApnbGiicoWWr1d8rG8e4JfNlO+3V4GA8ukEGnHDx5RZXbseNQ6LFMfclAWt7eMWAqs1W4yuyE3vNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=g4z0XSoj; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:22f7:64f5:261f:da0e])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 55BC37D9F3;
	Thu,  1 Aug 2024 16:27:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722526024; bh=4h0Y6LtuSzhJHCsb2ZCCiML34iodb18YUPVtFffsGYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09jakub@cloudflare.com,=0D=0A=09tparkin@kat
	 alix.com|Subject:=20RFC:=20l2tp:=20how=20to=20fix=20nested=20socke
	 t=20lockdep=20splat|Date:=20Thu,=20=201=20Aug=202024=2016:27:04=20
	 +0100|Message-Id:=20<20240801152704.24279-1-jchapman@katalix.com>|
	 MIME-Version:=201.0;
	b=g4z0XSojsr1DEI7u52986JW74bWRgdFOQA+TrLTOka4f3g4U3t6+289CVgfuw+Tfl
	 cioSnNWmj57UYorYr1ew/mS2u3Z7yirSqiJ9r4jn3Td8xNz0skVNIvGdBEr0pg2ypb
	 aldYi5qdkpeLH23I/YKFGf13QHa3mDfuuRJE09R54nk3IDaUXyVmrugddeLAGCILlz
	 2Xs/yGZBDWdyOL2TPi0AP8JnGxYU5e75kkOwaaI41rXDqKvvD5c/X3HByV8j4+EQ76
	 Z0UPqOGnV+Ab5hkCVIqAw32sVaxsZBJ7x6diNVTDUHpd1y7n4l29S19TvJgsDS03Ep
	 h96104q/HMdTA==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	jakub@cloudflare.com,
	tparkin@katalix.com
Subject: RFC: l2tp: how to fix nested socket lockdep splat
Date: Thu,  1 Aug 2024 16:27:04 +0100
Message-Id: <20240801152704.24279-1-jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When l2tp tunnels use a socket provided by userspace, we can hit lockdep splats like the below when data is transmitted through another (unrelated) userspace socket which then gets routed over l2tp.

This issue was previously discussed here: https://lore.kernel.org/netdev/87sfialu2n.fsf@cloudflare.com/

Is it reasonable to disable lockdep tracking of l2tp userspace tunnel sockets? Is there a better solution?

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index e22e2a45c925..ab7be05da7d4 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1736,6 +1736,16 @@ int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
 	}
 
 	sk->sk_allocation = GFP_ATOMIC;
+
+	/* If the tunnel socket is a userspace socket, disable lockdep
+	 * validation on the tunnel socket to avoid lockdep splats caused by
+	 * nested socket calls on the same lockdep socket class. This can
+	 * happen when data from a user socket is routed over l2tp, which uses
+	 * another userspace socket.
+	 */
+	if (tunnel->fd >= 0)
+		lockdep_set_novalidate_class(&sk->sk_lock.slock);
+
 	release_sock(sk);
 
 	sock_hold(sk);


Here is the lockdep splat:

  ============================================
  WARNING: possible recursive locking detected
  6.10.0+ #34 Not tainted
  --------------------------------------------
  iperf3/771 is trying to acquire lock:
  ffff8881027601d8 (slock-AF_INET/1){+.-.}-{2:2}, at: l2tp_xmit_skb+0x243/0x9d0
  
  but task is already holding lock:
  ffff888102650d98 (slock-AF_INET/1){+.-.}-{2:2}, at: tcp_v4_rcv+0x1848/0x1e10
  
  other info that might help us debug this:
   Possible unsafe locking scenario:
  
         CPU0
         ----
    lock(slock-AF_INET/1);
    lock(slock-AF_INET/1);
  
   *** DEADLOCK ***
  
   May be due to missing lock nesting notation
  
  10 locks held by iperf3/771:
   #0: ffff888102650258 (sk_lock-AF_INET){+.+.}-{0:0}, at: tcp_sendmsg+0x1a/0x40
   #1: ffffffff822ac220 (rcu_read_lock){....}-{1:2}, at: __ip_queue_xmit+0x4b/0xbc0
   #2: ffffffff822ac220 (rcu_read_lock){....}-{1:2}, at: ip_finish_output2+0x17a/0x1130
   #3: ffffffff822ac220 (rcu_read_lock){....}-{1:2}, at: process_backlog+0x28b/0x9f0
   #4: ffffffff822ac220 (rcu_read_lock){....}-{1:2}, at: ip_local_deliver_finish+0xf9/0x260
   #5: ffff888102650d98 (slock-AF_INET/1){+.-.}-{2:2}, at: tcp_v4_rcv+0x1848/0x1e10
   #6: ffffffff822ac220 (rcu_read_lock){....}-{1:2}, at: __ip_queue_xmit+0x4b/0xbc0
   #7: ffffffff822ac220 (rcu_read_lock){....}-{1:2}, at: ip_finish_output2+0x17a/0x1130
   #8: ffffffff822ac1e0 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0xcc/0x1450
   #9: ffff888101f33258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock#2){+...}-{2:2}, at: __dev_queue_xmit+0x513/0x1450
  
  stack backtrace:
  CPU: 2 UID: 0 PID: 771 Comm: iperf3 Not tainted 6.10.0+ #34
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
  Call Trace:
   <IRQ>
   dump_stack_lvl+0x69/0xa0
   dump_stack+0xc/0x20
   __lock_acquire+0x135d/0x2600
   ? srso_alias_return_thunk+0x5/0xfbef5
   lock_acquire+0xc4/0x2a0
   ? l2tp_xmit_skb+0x243/0x9d0
   ? __skb_checksum+0xa3/0x540
   _raw_spin_lock_nested+0x35/0x50
   ? l2tp_xmit_skb+0x243/0x9d0
   l2tp_xmit_skb+0x243/0x9d0
   l2tp_eth_dev_xmit+0x3c/0xc0
   dev_hard_start_xmit+0x11e/0x420
   sch_direct_xmit+0xc3/0x640
   __dev_queue_xmit+0x61c/0x1450
   ? ip_finish_output2+0xf4c/0x1130
   ip_finish_output2+0x6b6/0x1130
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __ip_finish_output+0x217/0x380
   ? srso_alias_return_thunk+0x5/0xfbef5
   __ip_finish_output+0x217/0x380
   ip_output+0x99/0x120
   __ip_queue_xmit+0xae4/0xbc0
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? tcp_options_write.constprop.0+0xcb/0x3e0
   ip_queue_xmit+0x34/0x40
   __tcp_transmit_skb+0x1625/0x1890
   __tcp_send_ack+0x1b8/0x340
   tcp_send_ack+0x23/0x30
   __tcp_ack_snd_check+0xa8/0x530
   ? srso_alias_return_thunk+0x5/0xfbef5
   tcp_rcv_established+0x412/0xd70
   tcp_v4_do_rcv+0x299/0x420
   tcp_v4_rcv+0x1991/0x1e10
   ip_protocol_deliver_rcu+0x50/0x220
   ip_local_deliver_finish+0x158/0x260
   ip_local_deliver+0xc8/0xe0
   ip_rcv+0xe5/0x1d0
   ? __pfx_ip_rcv+0x10/0x10
   __netif_receive_skb_one_core+0xce/0xe0
   ? process_backlog+0x28b/0x9f0
   __netif_receive_skb+0x34/0xd0
   ? process_backlog+0x28b/0x9f0
   process_backlog+0x2cb/0x9f0
   __napi_poll.constprop.0+0x61/0x280
   net_rx_action+0x332/0x670
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? find_held_lock+0x2b/0x80
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? srso_alias_return_thunk+0x5/0xfbef5
   handle_softirqs+0xda/0x480
   ? __dev_queue_xmit+0xa2c/0x1450
   do_softirq+0xa1/0xd0
   </IRQ>
   <TASK>
   __local_bh_enable_ip+0xc8/0xe0
   ? __dev_queue_xmit+0xa2c/0x1450
   __dev_queue_xmit+0xa48/0x1450
   ? ip_finish_output2+0xf4c/0x1130
   ip_finish_output2+0x6b6/0x1130
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __ip_finish_output+0x217/0x380
   ? srso_alias_return_thunk+0x5/0xfbef5
   __ip_finish_output+0x217/0x380
   ip_output+0x99/0x120
   __ip_queue_xmit+0xae4/0xbc0
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? tcp_options_write.constprop.0+0xcb/0x3e0
   ip_queue_xmit+0x34/0x40
   __tcp_transmit_skb+0x1625/0x1890
   tcp_write_xmit+0x766/0x2fb0
   ? __entry_text_end+0x102ba9/0x102bad
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __might_fault+0x74/0xc0
   ? srso_alias_return_thunk+0x5/0xfbef5
   __tcp_push_pending_frames+0x56/0x190
   tcp_push+0x117/0x310
   tcp_sendmsg_locked+0x14c1/0x1740
   tcp_sendmsg+0x28/0x40
   inet_sendmsg+0x5d/0x90
   sock_write_iter+0x242/0x2b0
   vfs_write+0x68d/0x800
   ? __pfx_sock_write_iter+0x10/0x10
   ksys_write+0xc8/0xf0
   __x64_sys_write+0x3d/0x50
   x64_sys_call+0xfaf/0x1f50
   do_syscall_64+0x6d/0x140
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7f4d143af992
  Code: c3 8b 07 85 c0 75 24 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> e9 01 cc ff ff 41 54 b8 02 00 00 0
  RSP: 002b:00007ffd65032058 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
  RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f4d143af992
  RDX: 0000000000000025 RSI: 00007f4d143f3bcc RDI: 0000000000000005
  RBP: 00007f4d143f2b28 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4d143f3bcc
  R13: 0000000000000005 R14: 0000000000000000 R15: 00007ffd650323f0
   </TASK>
  

