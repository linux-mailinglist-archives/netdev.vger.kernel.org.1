Return-Path: <netdev+bounces-142615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 321379BFC7A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B749C1F23D8E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0AFD53F;
	Thu,  7 Nov 2024 02:17:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982CB38FAD;
	Thu,  7 Nov 2024 02:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945835; cv=none; b=nZ1aMoyFGMhEDakepWdPkRklZwxsB5ia6VSkiCceeDePhYWdjoLsqQ4QJts3pRuXwSdRsjpF+iHpPMnijAs/ZbUmh+QcZaRXUcFHtbaAi7lGU18ZnrSfy5siUc/Ae1hRnaeVi77aM0hurHX2ApFt1joXtdDtK8VUiokI3XoXWQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945835; c=relaxed/simple;
	bh=GrUUUrld2dOYlsaP0IYgGyBkPj2uqFFy1lOlGJihN1E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kc/9FEievIyLyBDUmqRFC1q3OrSGM0lCX+f9QXhVQNbGDsUJnQum1mwA3bezqU7zzPjNfRgP5d10nYqi7mVk8hHJj+RBLY6lTL4D0PXwXwu29GVbcqohRm8pq/1cGsmygKJDshaZMH9VPczZAVKZ7Drng07qSA3e/N7d8/1NWws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XkQdq1z29z1SDfc;
	Thu,  7 Nov 2024 10:15:27 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id B71DE140136;
	Thu,  7 Nov 2024 10:17:09 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200005.china.huawei.com
 (7.202.181.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 7 Nov
 2024 10:17:08 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <dsahern@kernel.org>,
	<kuniyu@amazon.com>, <luoxuanqiang@kylinos.cn>, <kernelxing@tencent.com>,
	<wangliang74@huawei.com>, <kirjanov@gmail.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: fix data-races around sk->sk_forward_alloc
Date: Thu, 7 Nov 2024 10:34:05 +0800
Message-ID: <20241107023405.889239-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200005.china.huawei.com (7.202.181.32)

Syzkaller reported this warning:
 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 16 at net/ipv4/af_inet.c:156 inet_sock_destruct+0x1c5/0x1e0
 Modules linked in:
 CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc5 #26
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
 RIP: 0010:inet_sock_destruct+0x1c5/0x1e0
 Code: 24 12 4c 89 e2 5b 48 c7 c7 98 ec bb 82 41 5c e9 d1 18 17 ff 4c 89 e6 5b 48 c7 c7 d0 ec bb 82 41 5c e9 bf 18 17 ff 0f 0b eb 83 <0f> 0b eb 97 0f 0b eb 87 0f 0b e9 68 ff ff ff 66 66 2e 0f 1f 84 00
 RSP: 0018:ffffc9000008bd90 EFLAGS: 00010206
 RAX: 0000000000000300 RBX: ffff88810b172a90 RCX: 0000000000000007
 RDX: 0000000000000002 RSI: 0000000000000300 RDI: ffff88810b172a00
 RBP: ffff88810b172a00 R08: ffff888104273c00 R09: 0000000000100007
 R10: 0000000000020000 R11: 0000000000000006 R12: ffff88810b172a00
 R13: 0000000000000004 R14: 0000000000000000 R15: ffff888237c31f78
 FS:  0000000000000000(0000) GS:ffff888237c00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007ffc63fecac8 CR3: 000000000342e000 CR4: 00000000000006f0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ? __warn+0x88/0x130
  ? inet_sock_destruct+0x1c5/0x1e0
  ? report_bug+0x18e/0x1a0
  ? handle_bug+0x53/0x90
  ? exc_invalid_op+0x18/0x70
  ? asm_exc_invalid_op+0x1a/0x20
  ? inet_sock_destruct+0x1c5/0x1e0
  __sk_destruct+0x2a/0x200
  rcu_do_batch+0x1aa/0x530
  ? rcu_do_batch+0x13b/0x530
  rcu_core+0x159/0x2f0
  handle_softirqs+0xd3/0x2b0
  ? __pfx_smpboot_thread_fn+0x10/0x10
  run_ksoftirqd+0x25/0x30
  smpboot_thread_fn+0xdd/0x1d0
  kthread+0xd3/0x100
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x34/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 ---[ end trace 0000000000000000 ]---

Its possible that two threads call tcp_v6_do_rcv()/sk_forward_alloc_add()
concurrently when sk->sk_state == TCP_LISTEN with sk->sk_lock unlocked,
which triggers a data-race around sk->sk_forward_alloc:
tcp_v6_rcv
    tcp_v6_do_rcv
        skb_clone_and_charge_r
            sk_rmem_schedule
                __sk_mem_schedule
                    sk_forward_alloc_add()
            skb_set_owner_r
                sk_mem_charge
                    sk_forward_alloc_add()
        __kfree_skb
            skb_release_all
                skb_release_head_state
                    sock_rfree
                        sk_mem_uncharge
                            sk_forward_alloc_add()
                            sk_mem_reclaim
                                // set local var reclaimable
                                __sk_mem_reclaim
                                    sk_forward_alloc_add()

In this syzkaller testcase, two threads call
tcp_v6_do_rcv() with skb->truesize=768, the sk_forward_alloc changes like
this:
 (cpu 1)             | (cpu 2)             | sk_forward_alloc
 ...                 | ...                 | 0
 __sk_mem_schedule() |                     | +4096 = 4096
                     | __sk_mem_schedule() | +4096 = 8192
 sk_mem_charge()     |                     | -768  = 7424
                     | sk_mem_charge()     | -768  = 6656
 ...                 |    ...              |
 sk_mem_uncharge()   |                     | +768  = 7424
 reclaimable=7424    |                     |
                     | sk_mem_uncharge()   | +768  = 8192
                     | reclaimable=8192    |
 __sk_mem_reclaim()  |                     | -4096 = 4096
                     | __sk_mem_reclaim()  | -8192 = -4096 != 0

The skb_clone_and_charge_r() should not be called in tcp_v6_do_rcv() when
sk->sk_state is TCP_LISTEN, it happens later in tcp_v6_syn_recv_sock().
Fix the same issue in dccp_v6_do_rcv().

Suggested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/dccp/ipv6.c     | 2 +-
 net/ipv6/tcp_ipv6.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index da5dba120bc9..d6649246188d 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -618,7 +618,7 @@ static int dccp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	   by tcp. Feel free to propose better solution.
 					       --ANK (980728)
 	 */
-	if (np->rxopt.all)
+	if (np->rxopt.all && sk->sk_state != DCCP_LISTEN)
 		opt_skb = skb_clone_and_charge_r(skb, sk);
 
 	if (sk->sk_state == DCCP_OPEN) { /* Fast path */
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d71ab4e1efe1..c9de5ef8f267 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1618,7 +1618,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	   by tcp. Feel free to propose better solution.
 					       --ANK (980728)
 	 */
-	if (np->rxopt.all)
+	if (np->rxopt.all && sk->sk_state != TCP_LISTEN)
 		opt_skb = skb_clone_and_charge_r(skb, sk);
 
 	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
@@ -1656,8 +1656,6 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 				if (reason)
 					goto reset;
 			}
-			if (opt_skb)
-				__kfree_skb(opt_skb);
 			return 0;
 		}
 	} else
-- 
2.34.1


