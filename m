Return-Path: <netdev+bounces-223744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E38CB5A437
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AEE1C00D79
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8AA307499;
	Tue, 16 Sep 2025 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rlphQ/q7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D0BA3D
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059286; cv=none; b=b3WAVTFTfyw6wF4YiIH1qC0RyuMYJKHDGctP7P5B5v65GvRp3BU16rfZ16SgbjofzSvYQj1Nm837gC21mt05Ji9WxyWLJ8Vmqpkis/BSYV8VXstMEFEoaeGBwifJ6jE9GOnr6pdkel8qt6XdfzCRtfMoG5VwugDiWS4gptYjotA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059286; c=relaxed/simple;
	bh=24ic9truOqKPNkvgvQOityIpOTNa76Qj+1V+Ihx2vmM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JlMHrTAjpZB97GvXIxQ1OzPqBdhVuwyJ4r7WEMSjWd559Q6oYKXNOix+CITp5ER/4TZaakYgDsQYwPSBt4yM1+zDWM5x3qNa8jV/354kiXXueXgqsuXP05mcJA80byaHpKedeJ3kfEBNoebltQcVVfPsDGvH3zYXe5z611CNgxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rlphQ/q7; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77260b29516so11154761b3a.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758059284; x=1758664084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B6jtnHJhtnkZHWHIvNLopkRGPNcGq/nouoLsqAcFWdY=;
        b=rlphQ/q7Q4yDJvnFx4KDZUWhVWuAYV4qCLW2WZLhJOQwVeoGoluPV0R9itKsd/ncxj
         mlTrDnuaWNfQBgtvta4/tNBvokNxcucGPfatcCk5eLV/c/8R2gLiDOlHItCdivxjzCpi
         MlVO9LL+sL/h/tnzoJJWPQ//uoMCRwnGASD0MIR3JL3Ic+Y4JNumR1lIPkGTwRwncHMP
         Tmphv+Uk8yvJyk+SEce097zMFFT8z3UznkRT5WFm7ntZpeEQse48N16jm7uInlps+VvF
         rItfFpAm4ynYdRA3uPIwyVJih0ymWvCRC7D5FkctU6cZbUr0KvAxu3jxkyKCIupGRzzQ
         L7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758059284; x=1758664084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6jtnHJhtnkZHWHIvNLopkRGPNcGq/nouoLsqAcFWdY=;
        b=BW1dwF0F5hYqhkAFF4S6PEu95vnnBMdIg0In6jOwaHKYyaabBpaz171hvKKeBph47x
         zui6FxriR7clvozr0oNnxd7N5oXKljUTKZRUbtsfZQ/zsswvIqgUFrqfnmrw+kyC0OUP
         dJMSZ88VdM/97TXffTP5Wdyn9JwhFgpVG558nEGdU9F1qc9YmZkyW83ce5dmOjgsll50
         bCdaC+u+w44QUg0qYgacSgXHijdG8VQ8bnpQsizqnCGNu686YEqe26fsgGBhKLyA83sb
         Pxrxc3tquptc1eQlYUiJtGqpqR6mS7aX4Y69jGg8pboxsbv9wvvxPF+kBrvm6sJD35Er
         LmLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg2AB/fYd4umCyXwX/gn7pHhSo1g8IoU78dnIWs7YbfycNdJfB4mw7N6e/kjLhjMn7+Bcn4ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqUReew1e/dbnx+3U5Zxg/RW5zOH8evZCcr54ZxPQthU1GX1LJ
	uXDKeu7jZuQM2SLVBdyzg9icdFcvSwTx3WuRREsYOr4tUiuU4NsM0elJ2lj2kowLRjjxOSgO555
	taqRWxA==
X-Google-Smtp-Source: AGHT+IHSt8vtzA6/075QPGJXyOf6FLW8l0MAVurBdWcLNKAjAOIweUfDpaIh54lmxnbKnUGqQhOEqixGZQQ=
X-Received: from pfbgp7.prod.google.com ([2002:a05:6a00:3b87:b0:776:1344:ca77])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e97:b0:770:56bf:ab5a
 with SMTP id d2e1a72fcca58-7761216c36fmr20858920b3a.19.1758059284058; Tue, 16
 Sep 2025 14:48:04 -0700 (PDT)
Date: Tue, 16 Sep 2025 21:47:19 +0000
In-Reply-To: <20250916214758.650211-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916214758.650211-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916214758.650211-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 1/7] smc: Fix use-after-free in __pnet_find_base_ndev().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+ea28e9d85be2f327b6c6@syzkaller.appspotmail.com, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Ursula Braun <ubraun@linux.ibm.com>, 
	Hans Wippel <hwippel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

syzbot reported use-after-free of net_device in __pnet_find_base_ndev(),
which was called during connect(). [0]

smc_pnet_find_ism_resource() fetches sk_dst_get(sk)->dev and passes
down to pnet_find_base_ndev(), where RTNL is held.  Then, UAF happened
at __pnet_find_base_ndev() when the dev is first used.

This means dev had already been freed before acquiring RTNL in
pnet_find_base_ndev().

While dev is going away, dst->dev could be swapped with blackhole_netdev,
and the dev's refcnt by dst will be released.

We must hold dev's refcnt before calling smc_pnet_find_ism_resource().

Also, smc_pnet_find_roce_resource() has the same problem.

Let's use __sk_dst_get() and dst_dev_rcu() in the two functions.

[0]:
BUG: KASAN: use-after-free in __pnet_find_base_ndev+0x1b1/0x1c0 net/smc/smc_pnet.c:926
Read of size 1 at addr ffff888036bac33a by task syz.0.3632/18609

CPU: 1 UID: 0 PID: 18609 Comm: syz.0.3632 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __pnet_find_base_ndev+0x1b1/0x1c0 net/smc/smc_pnet.c:926
 pnet_find_base_ndev net/smc/smc_pnet.c:946 [inline]
 smc_pnet_find_ism_by_pnetid net/smc/smc_pnet.c:1103 [inline]
 smc_pnet_find_ism_resource+0xef/0x390 net/smc/smc_pnet.c:1154
 smc_find_ism_device net/smc/af_smc.c:1030 [inline]
 smc_find_proposal_devices net/smc/af_smc.c:1115 [inline]
 __smc_connect+0x372/0x1890 net/smc/af_smc.c:1545
 smc_connect+0x877/0xd90 net/smc/af_smc.c:1715
 __sys_connect_file net/socket.c:2086 [inline]
 __sys_connect+0x313/0x440 net/socket.c:2105
 __do_sys_connect net/socket.c:2111 [inline]
 __se_sys_connect net/socket.c:2108 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2108
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f47cbf8eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f47ccdb1038 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f47cc1d5fa0 RCX: 00007f47cbf8eba9
RDX: 0000000000000010 RSI: 0000200000000280 RDI: 000000000000000b
RBP: 00007f47cc011e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f47cc1d6038 R14: 00007f47cc1d5fa0 R15: 00007ffc512f8aa8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888036bacd00 pfn:0x36bac
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001243d08 ffff8880b863fdc0 0000000000000000
raw: ffff888036bacd00 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x446dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_COMP), pid 16741, tgid 16741 (syz-executor), ts 343313197788, free_ts 380670750466
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 ___kmalloc_large_node+0x5f/0x1b0 mm/slub.c:4317
 __kmalloc_large_node_noprof+0x18/0x90 mm/slub.c:4348
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kvmalloc_node_noprof+0x6d/0x5f0 mm/slub.c:5067
 alloc_netdev_mqs+0xa3/0x11b0 net/core/dev.c:11812
 tun_set_iff+0x532/0xef0 drivers/net/tun.c:2775
 __tun_chr_ioctl+0x788/0x1df0 drivers/net/tun.c:3085
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 18610 tgid 18608 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 free_large_kmalloc+0x13a/0x1f0 mm/slub.c:4820
 device_release+0x99/0x1c0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 netdev_run_todo+0xd2e/0xea0 net/core/dev.c:11513
 rtnl_unlock net/core/rtnetlink.c:157 [inline]
 rtnl_net_unlock include/linux/rtnetlink.h:135 [inline]
 rtnl_dellink+0x537/0x710 net/core/rtnetlink.c:3563
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888036bac200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888036bac280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888036bac300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                        ^
 ffff888036bac380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888036bac400: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Fixes: 0afff91c6f5e ("net/smc: add pnetid support")
Fixes: 1619f770589a ("net/smc: add pnetid support for SMC-D and ISM")
Reported-by: syzbot+ea28e9d85be2f327b6c6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/68c237c7.050a0220.3c6139.0036.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Cc: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Dust Li <dust.li@linux.alibaba.com>
Cc: Sidraya Jayagond <sidraya@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>
Cc: Wen Gu <guwen@linux.alibaba.com>
Cc: Ursula Braun <ubraun@linux.ibm.com>
Cc: Hans Wippel <hwippel@linux.ibm.com>
---
 net/smc/smc_pnet.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index b90337f86e83..7225b5fa17a6 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -1126,37 +1126,38 @@ static void smc_pnet_find_ism_by_pnetid(struct net_device *ndev,
  */
 void smc_pnet_find_roce_resource(struct sock *sk, struct smc_init_info *ini)
 {
-	struct dst_entry *dst = sk_dst_get(sk);
-
-	if (!dst)
-		goto out;
-	if (!dst->dev)
-		goto out_rel;
+	struct net_device *dev;
+	struct dst_entry *dst;
 
-	smc_pnet_find_roce_by_pnetid(dst->dev, ini);
+	rcu_read_lock();
+	dst = __sk_dst_get(sk);
+	dev = dst ? dst_dev_rcu(dst) : NULL;
+	dev_hold(dev);
+	rcu_read_unlock();
 
-out_rel:
-	dst_release(dst);
-out:
-	return;
+	if (dev) {
+		smc_pnet_find_roce_by_pnetid(dev, ini);
+		dev_put(dev);
+	}
 }
 
 void smc_pnet_find_ism_resource(struct sock *sk, struct smc_init_info *ini)
 {
-	struct dst_entry *dst = sk_dst_get(sk);
+	struct net_device *dev;
+	struct dst_entry *dst;
 
 	ini->ism_dev[0] = NULL;
-	if (!dst)
-		goto out;
-	if (!dst->dev)
-		goto out_rel;
 
-	smc_pnet_find_ism_by_pnetid(dst->dev, ini);
+	rcu_read_lock();
+	dst = __sk_dst_get(sk);
+	dev = dst ? dst_dev_rcu(dst) : NULL;
+	dev_hold(dev);
+	rcu_read_unlock();
 
-out_rel:
-	dst_release(dst);
-out:
-	return;
+	if (dev) {
+		smc_pnet_find_ism_by_pnetid(dev, ini);
+		dev_put(dev);
+	}
 }
 
 /* Lookup and apply a pnet table entry to the given ib device.
-- 
2.51.0.384.g4c02a37b29-goog


