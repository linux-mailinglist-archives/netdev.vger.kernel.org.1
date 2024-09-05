Return-Path: <netdev+bounces-125666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD7B96E346
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E210A1F26B60
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 19:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A1B18D624;
	Thu,  5 Sep 2024 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FDwjU0+i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B57B188939
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564880; cv=none; b=sKJsvWMUbqro4M1uVtds+w33FCc6De6ezuas4bquq3Ih/JKFaswLSuVNdEPZSGYf8bM1NGZsVsgHp89v3DiEPCAjDRaa90UMmQ3sCdx0g1RHbOrpHsXti6KT0+4BU31IWe54LqJZfFIolD+cLX4yf6I6X49/GNXxaoIbRlBZYbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564880; c=relaxed/simple;
	bh=M59Ei2LX712q1hVnCSjss6Gv1FCtle3U3nZ38GxiHb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O26Fr6T05YyT6gQGRi/9klNvf7yN6gvDwamN5g0s2BZ2P7PgO8r19Ggj8LPOc5DtvyuR2+7tCPti3baOUn+E7k+h4dgaTMPzFPQ2yYOAb0ZJ5aUgJSZFiIWm7b/ySFb1QoNgndHQ7/la97joBywky6OHK0v7YoMQFD5X+YxuZww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FDwjU0+i; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725564878; x=1757100878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=azFQfrw04WQwkfjNIL3f0eIyYh8rWRuR8ms93nT83/U=;
  b=FDwjU0+idPon32zXY4a042nO4Azb9DUb2goyNr7AQKRLkQjCBBiaMvjf
   z6jCn5RxDSI+MhiiYlZNMKkKXRF5J1eV8NIw0EyI+rgO8BCuWEGu+KHLh
   u5AZ4b3JZPC+0XRPnf5tDn2B8qeSWtjtxA5RmZeBnYXiJhFAlOLn1DIgC
   w=;
X-IronPort-AV: E=Sophos;i="6.10,205,1719878400"; 
   d="scan'208";a="122697329"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 19:34:36 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:32269]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.240:2525] with esmtp (Farcaster)
 id 94e66b04-fe72-4dd2-a414-62451af2c8cd; Thu, 5 Sep 2024 19:34:36 +0000 (UTC)
X-Farcaster-Flow-ID: 94e66b04-fe72-4dd2-a414-62451af2c8cd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 5 Sep 2024 19:34:36 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 5 Sep 2024 19:34:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>
Subject: [PATCH v1 net-next 4/4] af_unix: Don't return OOB skb in manage_oob().
Date: Thu, 5 Sep 2024 12:32:40 -0700
Message-ID: <20240905193240.17565-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240905193240.17565-1-kuniyu@amazon.com>
References: <20240905193240.17565-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzbot reported use-after-free in unix_stream_recv_urg(). [0]

The scenario is

  1. send(MSG_OOB)
  2. recv(MSG_OOB)
     -> The consumed OOB remains in recv queue
  3. send(MSG_OOB)
  4. recv()
     -> manage_oob() returns the next skb of the consumed OOB
     -> This is also OOB, but unix_sk(sk)->oob_skb is not cleared
  5. recv(MSG_OOB)
     -> unix_sk(sk)->oob_skb is used but already freed

The recent commit 8594d9b85c07 ("af_unix: Don't call skb_get() for OOB
skb.") uncovered the issue.

If the OOB skb is consumed and the next skb is peeked in manage_oob(),
we still need to check if the skb is OOB.

Let's do so by falling back to the following checks in manage_oob()
and add the test case in selftest.

Note that we need to add a similar check for SIOCATMARK.

[0]:
BUG: KASAN: slab-use-after-free in unix_stream_read_actor+0xa6/0xb0 net/unix/af_unix.c:2959
Read of size 4 at addr ffff8880326abcc4 by task syz-executor178/5235

CPU: 0 UID: 0 PID: 5235 Comm: syz-executor178 Not tainted 6.11.0-rc5-syzkaller-00742-gfbdaffe41adc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 unix_stream_read_actor+0xa6/0xb0 net/unix/af_unix.c:2959
 unix_stream_recv_urg+0x1df/0x320 net/unix/af_unix.c:2640
 unix_stream_read_generic+0x2456/0x2520 net/unix/af_unix.c:2778
 unix_stream_recvmsg+0x22b/0x2c0 net/unix/af_unix.c:2996
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x22f/0x280 net/socket.c:1068
 ____sys_recvmsg+0x1db/0x470 net/socket.c:2816
 ___sys_recvmsg net/socket.c:2858 [inline]
 __sys_recvmsg+0x2f0/0x3e0 net/socket.c:2888
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5360d6b4e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff29b3a458 EFLAGS: 00000246 ORIG_RAX: 000000000000002f
RAX: ffffffffffffffda RBX: 00007fff29b3a638 RCX: 00007f5360d6b4e9
RDX: 0000000000002001 RSI: 0000000020000640 RDI: 0000000000000003
RBP: 00007f5360dde610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff29b3a628 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 5235:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4080
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:667
 alloc_skb include/linux/skbuff.h:1320 [inline]
 alloc_skb_with_frags+0xc3/0x770 net/core/skbuff.c:6528
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2815
 sock_alloc_send_skb include/net/sock.h:1778 [inline]
 queue_oob+0x108/0x680 net/unix/af_unix.c:2198
 unix_stream_sendmsg+0xd24/0xf80 net/unix/af_unix.c:2351
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5235:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4548
 unix_stream_read_generic+0x1ef6/0x2520 net/unix/af_unix.c:2917
 unix_stream_recvmsg+0x22b/0x2c0 net/unix/af_unix.c:2996
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x22f/0x280 net/socket.c:1068
 __sys_recvfrom+0x256/0x3e0 net/socket.c:2255
 __do_sys_recvfrom net/socket.c:2273 [inline]
 __se_sys_recvfrom net/socket.c:2269 [inline]
 __x64_sys_recvfrom+0xde/0x100 net/socket.c:2269
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880326abc80
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 68 bytes inside of
 freed 240-byte region [ffff8880326abc80, ffff8880326abd70)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x326ab
ksm flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff88801eaee780 ffffea0000b7dc80 dead000000000003
raw: 0000000000000000 00000000800c000c 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 4686, tgid 4686 (udevadm), ts 32357469485, free_ts 28829011109
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3439
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4695
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2321
 allocate_slab+0x5a/0x2f0 mm/slub.c:2484
 new_slab mm/slub.c:2537 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
 __slab_alloc+0x58/0xa0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 kmem_cache_alloc_node_noprof+0x1fe/0x320 mm/slub.c:4080
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:667
 alloc_skb include/linux/skbuff.h:1320 [inline]
 alloc_uevent_skb+0x74/0x230 lib/kobject_uevent.c:289
 uevent_net_broadcast_untagged lib/kobject_uevent.c:326 [inline]
 kobject_uevent_net_broadcast+0x2fd/0x580 lib/kobject_uevent.c:410
 kobject_uevent_env+0x57d/0x8e0 lib/kobject_uevent.c:608
 kobject_synth_uevent+0x4ef/0xae0 lib/kobject_uevent.c:207
 uevent_store+0x4b/0x70 drivers/base/bus.c:633
 kernfs_fop_write_iter+0x3a1/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
 kasan_depopulate_vmalloc_pte+0x74/0x90 mm/kasan/shadow.c:408
 apply_to_pte_range mm/memory.c:2797 [inline]
 apply_to_pmd_range mm/memory.c:2841 [inline]
 apply_to_pud_range mm/memory.c:2877 [inline]
 apply_to_p4d_range mm/memory.c:2913 [inline]
 __apply_to_page_range+0x8a8/0xe50 mm/memory.c:2947
 kasan_release_vmalloc+0x9a/0xb0 mm/kasan/shadow.c:525
 purge_vmap_node+0x3e3/0x770 mm/vmalloc.c:2208
 __purge_vmap_area_lazy+0x708/0xae0 mm/vmalloc.c:2290
 _vm_unmap_aliases+0x79d/0x840 mm/vmalloc.c:2885
 change_page_attr_set_clr+0x2fe/0xdb0 arch/x86/mm/pat/set_memory.c:1881
 change_page_attr_set arch/x86/mm/pat/set_memory.c:1922 [inline]
 set_memory_nx+0xf2/0x130 arch/x86/mm/pat/set_memory.c:2110
 free_init_pages arch/x86/mm/init.c:924 [inline]
 free_kernel_image_pages arch/x86/mm/init.c:943 [inline]
 free_initmem+0x79/0x110 arch/x86/mm/init.c:970
 kernel_init+0x31/0x2b0 init/main.c:1476
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff8880326abb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880326abc00: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
>ffff8880326abc80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff8880326abd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff8880326abd80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb

Fixes: 93c99f21db36 ("af_unix: Don't stop recv(MSG_DONTWAIT) if consumed OOB skb is at the head.")
Reported-by: syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8811381d455e3e9ec788
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c                            |  9 ++++++--
 tools/testing/selftests/net/af_unix/msg_oob.c | 23 +++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 159d78fc3d14..001ccc55ef0f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2673,7 +2673,8 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 			__skb_unlink(read_skb, &sk->sk_receive_queue);
 		}
 
-		goto unlock;
+		if (!skb)
+			goto unlock;
 	}
 
 	if (skb != u->oob_skb)
@@ -3175,9 +3176,13 @@ static int unix_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			skb = skb_peek(&sk->sk_receive_queue);
 			if (skb) {
 				struct sk_buff *oob_skb = READ_ONCE(u->oob_skb);
+				struct sk_buff *next_skb;
+
+				next_skb = skb_peek_next(skb, &sk->sk_receive_queue);
 
 				if (skb == oob_skb ||
-				    (!oob_skb && !unix_skb_len(skb)))
+				    (!unix_skb_len(skb) &&
+				     (!oob_skb || next_skb == oob_skb)))
 					answ = 1;
 			}
 
diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index 535eb2c3d7d1..3ed3882a93b8 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -525,6 +525,29 @@ TEST_F(msg_oob, ex_oob_drop_2)
 	}
 }
 
+TEST_F(msg_oob, ex_oob_oob)
+{
+	sendpair("x", 1, MSG_OOB);
+	epollpair(true);
+	siocatmarkpair(true);
+
+	recvpair("x", 1, 1, MSG_OOB);
+	epollpair(false);
+	siocatmarkpair(true);
+
+	sendpair("y", 1, MSG_OOB);
+	epollpair(true);
+	siocatmarkpair(true);
+
+	recvpair("", -EAGAIN, 1, 0);
+	epollpair(false);
+	siocatmarkpair(false);
+
+	recvpair("", -EINVAL, 1, MSG_OOB);
+	epollpair(false);
+	siocatmarkpair(false);
+}
+
 TEST_F(msg_oob, ex_oob_ahead_break)
 {
 	sendpair("hello", 5, MSG_OOB);
-- 
2.30.2


