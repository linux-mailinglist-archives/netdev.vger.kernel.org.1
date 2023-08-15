Return-Path: <netdev+bounces-27646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8AF77CAC2
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 11:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FACC2813E4
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C77C100DD;
	Tue, 15 Aug 2023 09:53:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF07D6FA9
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 09:53:20 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D332FB5
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:53:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 6DA632074F;
	Tue, 15 Aug 2023 11:53:17 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Mx3FdHYmUsf; Tue, 15 Aug 2023 11:53:16 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 5A97320839;
	Tue, 15 Aug 2023 11:53:15 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 4C5B380004A;
	Tue, 15 Aug 2023 11:53:15 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 11:53:15 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 11:53:14 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 47C763182AEF; Tue, 15 Aug 2023 11:53:14 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 01/11] net: xfrm: Fix xfrm_address_filter OOB read
Date: Tue, 15 Aug 2023 11:53:00 +0200
Message-ID: <20230815095310.3310160-2-steffen.klassert@secunet.com>
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

From: Lin Ma <linma@zju.edu.cn>

We found below OOB crash:

[   44.211730] ==================================================================
[   44.212045] BUG: KASAN: slab-out-of-bounds in memcmp+0x8b/0xb0
[   44.212045] Read of size 8 at addr ffff88800870f320 by task poc.xfrm/97
[   44.212045]
[   44.212045] CPU: 0 PID: 97 Comm: poc.xfrm Not tainted 6.4.0-rc7-00072-gdad9774deaf1-dirty #4
[   44.212045] Call Trace:
[   44.212045]  <TASK>
[   44.212045]  dump_stack_lvl+0x37/0x50
[   44.212045]  print_report+0xcc/0x620
[   44.212045]  ? __virt_addr_valid+0xf3/0x170
[   44.212045]  ? memcmp+0x8b/0xb0
[   44.212045]  kasan_report+0xb2/0xe0
[   44.212045]  ? memcmp+0x8b/0xb0
[   44.212045]  kasan_check_range+0x39/0x1c0
[   44.212045]  memcmp+0x8b/0xb0
[   44.212045]  xfrm_state_walk+0x21c/0x420
[   44.212045]  ? __pfx_dump_one_state+0x10/0x10
[   44.212045]  xfrm_dump_sa+0x1e2/0x290
[   44.212045]  ? __pfx_xfrm_dump_sa+0x10/0x10
[   44.212045]  ? __kernel_text_address+0xd/0x40
[   44.212045]  ? kasan_unpoison+0x27/0x60
[   44.212045]  ? mutex_lock+0x60/0xe0
[   44.212045]  ? __pfx_mutex_lock+0x10/0x10
[   44.212045]  ? kasan_save_stack+0x22/0x50
[   44.212045]  netlink_dump+0x322/0x6c0
[   44.212045]  ? __pfx_netlink_dump+0x10/0x10
[   44.212045]  ? mutex_unlock+0x7f/0xd0
[   44.212045]  ? __pfx_mutex_unlock+0x10/0x10
[   44.212045]  __netlink_dump_start+0x353/0x430
[   44.212045]  xfrm_user_rcv_msg+0x3a4/0x410
[   44.212045]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[   44.212045]  ? __pfx_xfrm_user_rcv_msg+0x10/0x10
[   44.212045]  ? __pfx_xfrm_dump_sa+0x10/0x10
[   44.212045]  ? __pfx_xfrm_dump_sa_done+0x10/0x10
[   44.212045]  ? __stack_depot_save+0x382/0x4e0
[   44.212045]  ? filter_irq_stacks+0x1c/0x70
[   44.212045]  ? kasan_save_stack+0x32/0x50
[   44.212045]  ? kasan_save_stack+0x22/0x50
[   44.212045]  ? kasan_set_track+0x25/0x30
[   44.212045]  ? __kasan_slab_alloc+0x59/0x70
[   44.212045]  ? kmem_cache_alloc_node+0xf7/0x260
[   44.212045]  ? kmalloc_reserve+0xab/0x120
[   44.212045]  ? __alloc_skb+0xcf/0x210
[   44.212045]  ? netlink_sendmsg+0x509/0x700
[   44.212045]  ? sock_sendmsg+0xde/0xe0
[   44.212045]  ? __sys_sendto+0x18d/0x230
[   44.212045]  ? __x64_sys_sendto+0x71/0x90
[   44.212045]  ? do_syscall_64+0x3f/0x90
[   44.212045]  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   44.212045]  ? netlink_sendmsg+0x509/0x700
[   44.212045]  ? sock_sendmsg+0xde/0xe0
[   44.212045]  ? __sys_sendto+0x18d/0x230
[   44.212045]  ? __x64_sys_sendto+0x71/0x90
[   44.212045]  ? do_syscall_64+0x3f/0x90
[   44.212045]  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   44.212045]  ? kasan_save_stack+0x22/0x50
[   44.212045]  ? kasan_set_track+0x25/0x30
[   44.212045]  ? kasan_save_free_info+0x2e/0x50
[   44.212045]  ? __kasan_slab_free+0x10a/0x190
[   44.212045]  ? kmem_cache_free+0x9c/0x340
[   44.212045]  ? netlink_recvmsg+0x23c/0x660
[   44.212045]  ? sock_recvmsg+0xeb/0xf0
[   44.212045]  ? __sys_recvfrom+0x13c/0x1f0
[   44.212045]  ? __x64_sys_recvfrom+0x71/0x90
[   44.212045]  ? do_syscall_64+0x3f/0x90
[   44.212045]  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   44.212045]  ? copyout+0x3e/0x50
[   44.212045]  netlink_rcv_skb+0xd6/0x210
[   44.212045]  ? __pfx_xfrm_user_rcv_msg+0x10/0x10
[   44.212045]  ? __pfx_netlink_rcv_skb+0x10/0x10
[   44.212045]  ? __pfx_sock_has_perm+0x10/0x10
[   44.212045]  ? mutex_lock+0x8d/0xe0
[   44.212045]  ? __pfx_mutex_lock+0x10/0x10
[   44.212045]  xfrm_netlink_rcv+0x44/0x50
[   44.212045]  netlink_unicast+0x36f/0x4c0
[   44.212045]  ? __pfx_netlink_unicast+0x10/0x10
[   44.212045]  ? netlink_recvmsg+0x500/0x660
[   44.212045]  netlink_sendmsg+0x3b7/0x700
[   44.212045]  ? __pfx_netlink_sendmsg+0x10/0x10
[   44.212045]  ? __pfx_netlink_sendmsg+0x10/0x10
[   44.212045]  sock_sendmsg+0xde/0xe0
[   44.212045]  __sys_sendto+0x18d/0x230
[   44.212045]  ? __pfx___sys_sendto+0x10/0x10
[   44.212045]  ? rcu_core+0x44a/0xe10
[   44.212045]  ? __rseq_handle_notify_resume+0x45b/0x740
[   44.212045]  ? _raw_spin_lock_irq+0x81/0xe0
[   44.212045]  ? __pfx___rseq_handle_notify_resume+0x10/0x10
[   44.212045]  ? __pfx_restore_fpregs_from_fpstate+0x10/0x10
[   44.212045]  ? __pfx_blkcg_maybe_throttle_current+0x10/0x10
[   44.212045]  ? __pfx_task_work_run+0x10/0x10
[   44.212045]  __x64_sys_sendto+0x71/0x90
[   44.212045]  do_syscall_64+0x3f/0x90
[   44.212045]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   44.212045] RIP: 0033:0x44b7da
[   44.212045] RSP: 002b:00007ffdc8838548 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[   44.212045] RAX: ffffffffffffffda RBX: 00007ffdc8839978 RCX: 000000000044b7da
[   44.212045] RDX: 0000000000000038 RSI: 00007ffdc8838770 RDI: 0000000000000003
[   44.212045] RBP: 00007ffdc88385b0 R08: 00007ffdc883858c R09: 000000000000000c
[   44.212045] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[   44.212045] R13: 00007ffdc8839968 R14: 00000000004c37d0 R15: 0000000000000001
[   44.212045]  </TASK>
[   44.212045]
[   44.212045] Allocated by task 97:
[   44.212045]  kasan_save_stack+0x22/0x50
[   44.212045]  kasan_set_track+0x25/0x30
[   44.212045]  __kasan_kmalloc+0x7f/0x90
[   44.212045]  __kmalloc_node_track_caller+0x5b/0x140
[   44.212045]  kmemdup+0x21/0x50
[   44.212045]  xfrm_dump_sa+0x17d/0x290
[   44.212045]  netlink_dump+0x322/0x6c0
[   44.212045]  __netlink_dump_start+0x353/0x430
[   44.212045]  xfrm_user_rcv_msg+0x3a4/0x410
[   44.212045]  netlink_rcv_skb+0xd6/0x210
[   44.212045]  xfrm_netlink_rcv+0x44/0x50
[   44.212045]  netlink_unicast+0x36f/0x4c0
[   44.212045]  netlink_sendmsg+0x3b7/0x700
[   44.212045]  sock_sendmsg+0xde/0xe0
[   44.212045]  __sys_sendto+0x18d/0x230
[   44.212045]  __x64_sys_sendto+0x71/0x90
[   44.212045]  do_syscall_64+0x3f/0x90
[   44.212045]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   44.212045]
[   44.212045] The buggy address belongs to the object at ffff88800870f300
[   44.212045]  which belongs to the cache kmalloc-64 of size 64
[   44.212045] The buggy address is located 32 bytes inside of
[   44.212045]  allocated 36-byte region [ffff88800870f300, ffff88800870f324)
[   44.212045]
[   44.212045] The buggy address belongs to the physical page:
[   44.212045] page:00000000e4de16ee refcount:1 mapcount:0 mapping:000000000 ...
[   44.212045] flags: 0x100000000000200(slab|node=0|zone=1)
[   44.212045] page_type: 0xffffffff()
[   44.212045] raw: 0100000000000200 ffff888004c41640 dead000000000122 0000000000000000
[   44.212045] raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
[   44.212045] page dumped because: kasan: bad access detected
[   44.212045]
[   44.212045] Memory state around the buggy address:
[   44.212045]  ffff88800870f200: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[   44.212045]  ffff88800870f280: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
[   44.212045] >ffff88800870f300: 00 00 00 00 04 fc fc fc fc fc fc fc fc fc fc fc
[   44.212045]                                ^
[   44.212045]  ffff88800870f380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   44.212045]  ffff88800870f400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   44.212045] ==================================================================

By investigating the code, we find the root cause of this OOB is the lack
of checks in xfrm_dump_sa(). The buggy code allows a malicious user to pass
arbitrary value of filter->splen/dplen. Hence, with crafted xfrm states,
the attacker can achieve 8 bytes heap OOB read, which causes info leak.

  if (attrs[XFRMA_ADDRESS_FILTER]) {
    filter = kmemdup(nla_data(attrs[XFRMA_ADDRESS_FILTER]),
        sizeof(*filter), GFP_KERNEL);
    if (filter == NULL)
      return -ENOMEM;
    // NO MORE CHECKS HERE !!!
  }

This patch fixes the OOB by adding necessary boundary checks, just like
the code in pfkey_dump() function.

Fixes: d3623099d350 ("ipsec: add support of limited SA dump")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index c34a2a06ca94..7c91deadc36e 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1267,6 +1267,15 @@ static int xfrm_dump_sa(struct sk_buff *skb, struct netlink_callback *cb)
 					 sizeof(*filter), GFP_KERNEL);
 			if (filter == NULL)
 				return -ENOMEM;
+
+			/* see addr_match(), (prefix length >> 5) << 2
+			 * will be used to compare xfrm_address_t
+			 */
+			if (filter->splen > (sizeof(xfrm_address_t) << 3) ||
+			    filter->dplen > (sizeof(xfrm_address_t) << 3)) {
+				kfree(filter);
+				return -EINVAL;
+			}
 		}
 
 		if (attrs[XFRMA_PROTO])
-- 
2.34.1


