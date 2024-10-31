Return-Path: <netdev+bounces-140688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3819B7A3B
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B8128147D
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 12:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B57419AD94;
	Thu, 31 Oct 2024 12:06:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A00199FB8;
	Thu, 31 Oct 2024 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730376398; cv=none; b=nQX3IwVxiouKcZeb8XWlUMPQQbe4xQRc3Euv6/zT7o8LRF0U63hQWXmBfJm0BBm0WE8l5x0dSBE/PCC3RVXqzXUeoxDLVFDP/cx8kN+3AsYSes79vRbPagZKMPW5SZgomXz/FS9b8mqlmXsJ0o0DX8U+qonIAj6pNM9Fd9BfAzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730376398; c=relaxed/simple;
	bh=5sZBGAZdlZ8njThROCJogtID/PIdkdvJbFc6hdanMog=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hp3ON8TRdRb2e1ui1H6i+lK5ZLQkzQpDhdQNF6CzzNgfrPHQIL1XkD5BND3XgXJjVXKHscpM2x8zjP1aLk2aLYUpwd3MTTOxJvp4Sc/W5KTT+a1Wzh2carNQrJLvFlGJQ++7ywuTl3G00rzUAt/FIiuD0IT7J8PjXDZQ4lQgMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XfN2V3MTFz10Mxm;
	Thu, 31 Oct 2024 20:04:18 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id EBF341800DB;
	Thu, 31 Oct 2024 20:06:30 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200005.china.huawei.com
 (7.202.181.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 31 Oct
 2024 20:06:29 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <edumazet@google.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <dsahern@kernel.org>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH net] net: fix data-races around sk->sk_forward_alloc
Date: Thu, 31 Oct 2024 20:23:44 +0800
Message-ID: <20241031122344.2148586-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200005.china.huawei.com (7.202.181.32)

Syzkaller reported this warning:
[   65.568203][    C0] ------------[ cut here ]------------
[   65.569339][    C0] WARNING: CPU: 0 PID: 16 at net/ipv4/af_inet.c:156 inet_sock_destruct+0x1c5/0x1e0
[   65.575017][    C0] Modules linked in:
[   65.575699][    C0] CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc5 #26
[   65.577086][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   65.577094][    C0] RIP: 0010:inet_sock_destruct+0x1c5/0x1e0
[   65.577100][    C0] Code: 24 12 4c 89 e2 5b 48 c7 c7 98 ec bb 82 41 5c e9 d1 18 17 ff 4c 89 e6 5b 48 c7 c7 d0 ec bb 82 41 5c e9 bf 18 17 ff 0f 0b eb 83 <0f> 0b eb 97 0f 0b eb 87 0f 0b e9 68 ff ff ff 66 66 2e 0f 1f 84 00
[   65.577107][    C0] RSP: 0018:ffffc9000008bd90 EFLAGS: 00010206
[   65.577113][    C0] RAX: 0000000000000300 RBX: ffff88810b172a90 RCX: 0000000000000007
[   65.577117][    C0] RDX: 0000000000000002 RSI: 0000000000000300 RDI: ffff88810b172a00
[   65.577120][    C0] RBP: ffff88810b172a00 R08: ffff888104273c00 R09: 0000000000100007
[   65.577123][    C0] R10: 0000000000020000 R11: 0000000000000006 R12: ffff88810b172a00
[   65.577125][    C0] R13: 0000000000000004 R14: 0000000000000000 R15: ffff888237c31f78
[   65.577131][    C0] FS:  0000000000000000(0000) GS:ffff888237c00000(0000) knlGS:0000000000000000
[   65.592485][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   65.592489][    C0] CR2: 00007ffc63fecac8 CR3: 000000000342e000 CR4: 00000000000006f0
[   65.592491][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   65.592492][    C0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   65.592495][    C0] Call Trace:
[   65.596277][    C0]  <TASK>
[   65.598171][    C0]  ? __warn+0x88/0x130
[   65.598874][    C0]  ? inet_sock_destruct+0x1c5/0x1e0
[   65.598879][    C0]  ? report_bug+0x18e/0x1a0
[   65.598883][    C0]  ? handle_bug+0x53/0x90
[   65.598886][    C0]  ? exc_invalid_op+0x18/0x70
[   65.598888][    C0]  ? asm_exc_invalid_op+0x1a/0x20
[   65.598893][    C0]  ? inet_sock_destruct+0x1c5/0x1e0
[   65.598897][    C0]  __sk_destruct+0x2a/0x200
[   65.604664][    C0]  rcu_do_batch+0x1aa/0x530
[   65.605450][    C0]  ? rcu_do_batch+0x13b/0x530
[   65.605456][    C0]  rcu_core+0x159/0x2f0
[   65.605466][    C0]  handle_softirqs+0xd3/0x2b0
[   65.607689][    C0]  ? __pfx_smpboot_thread_fn+0x10/0x10
[   65.607695][    C0]  run_ksoftirqd+0x25/0x30
[   65.607699][    C0]  smpboot_thread_fn+0xdd/0x1d0
[   65.610152][    C0]  kthread+0xd3/0x100
[   65.610158][    C0]  ? __pfx_kthread+0x10/0x10
[   65.610160][    C0]  ret_from_fork+0x34/0x50
[   65.610170][    C0]  ? __pfx_kthread+0x10/0x10
[   65.610172][    C0]  ret_from_fork_asm+0x1a/0x30
[   65.610181][    C0]  </TASK>
[   65.610182][    C0] ---[ end trace 0000000000000000 ]---

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

In this syzkaller testcase, two threads call tcp_v6_do_rcv() with
skb->truesize=768, the sk_forward_alloc changes like this:
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

Add lock around tcp_v6_do_rcv() in tcp_v6_rcv() will have some the
performance impacts, only add lock when opt_skb clone occurs. In some
scenes, tcp_v6_do_rcv() is embraced by sk->sk_lock, add
TCP_SKB_CB(skb)->sk_lock_capability to avoid re-locking.

Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 include/net/tcp.h   |  3 ++-
 net/ipv6/tcp_ipv6.c | 21 ++++++++++++++++-----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d1948d357dad..110a23dda1eb 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -961,7 +961,8 @@ struct tcp_skb_cb {
 	__u8		txstamp_ack:1,	/* Record TX timestamp for ack? */
 			eor:1,		/* Is skb MSG_EOR marked? */
 			has_rxtstamp:1,	/* SKB has a RX timestamp	*/
-			unused:5;
+			sk_lock_capability:1, /* Avoid re-lock flag */
+			unused:4;
 	__u32		ack_seq;	/* Sequence number ACK'd	*/
 	union {
 		struct {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d71ab4e1efe1..a1166035fbce 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1588,6 +1588,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	struct sk_buff *opt_skb = NULL;
 	enum skb_drop_reason reason;
 	struct tcp_sock *tp;
+	bool sk_lock_flag = false;
 
 	/* Imagine: socket is IPv6. IPv4 packet arrives,
 	   goes to IPv4 receive handler and backlogged.
@@ -1618,8 +1619,13 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	   by tcp. Feel free to propose better solution.
 					       --ANK (980728)
 	 */
-	if (np->rxopt.all)
+	if (np->rxopt.all) {
+		if (TCP_SKB_CB(skb)->sk_lock_capability) {
+			sk_lock_flag = true;
+			bh_lock_sock_nested(sk);
+		}
 		opt_skb = skb_clone_and_charge_r(skb, sk);
+	}
 
 	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
 		struct dst_entry *dst;
@@ -1641,7 +1647,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 		tcp_rcv_established(sk, skb);
 		if (opt_skb)
 			goto ipv6_pktoptions;
-		return 0;
+		goto unlock;
 	}
 
 	if (tcp_checksum_complete(skb))
@@ -1658,7 +1664,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 			}
 			if (opt_skb)
 				__kfree_skb(opt_skb);
-			return 0;
+			goto unlock;
 		}
 	} else
 		sock_rps_save_rxhash(sk, skb);
@@ -1668,7 +1674,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 		goto reset;
 	if (opt_skb)
 		goto ipv6_pktoptions;
-	return 0;
+	goto unlock;
 
 reset:
 	tcp_v6_send_reset(sk, skb, sk_rst_convert_drop_reason(reason));
@@ -1676,7 +1682,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (opt_skb)
 		__kfree_skb(opt_skb);
 	sk_skb_reason_drop(sk, skb, reason);
-	return 0;
+	goto unlock;
 csum_err:
 	reason = SKB_DROP_REASON_TCP_CSUM;
 	trace_tcp_bad_csum(skb);
@@ -1715,6 +1721,9 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 
 	consume_skb(opt_skb);
+unlock:
+	if (sk_lock_flag)
+		bh_unlock_sock(sk);
 	return 0;
 }
 
@@ -1900,7 +1909,9 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	skb->dev = NULL;
 
 	if (sk->sk_state == TCP_LISTEN) {
+		TCP_SKB_CB(skb)->sk_lock_capability = true;
 		ret = tcp_v6_do_rcv(sk, skb);
+		TCP_SKB_CB(skb)->sk_lock_capability = false;
 		goto put_and_return;
 	}
 
-- 
2.34.1


