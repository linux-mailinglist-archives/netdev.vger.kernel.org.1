Return-Path: <netdev+bounces-249234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C9CD161B0
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 02:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B512F300519A
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 01:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A53217722;
	Tue, 13 Jan 2026 01:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="awS6JcwZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D7912D1F1
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768266343; cv=none; b=NdgOcg6YPcg00Tp7l7v14mqIieGJgLI50aBCmYWoTXFSiT2JYZWnVf0GwmFhkdiIzl2SRWoQ9KBbAFH7/obPVXcZMrsbAw9PSggfecejioC+GfkuauRo+Vi3yCdZ9s9M7QaDasaUD1FZ8mvJdDNpCHlR1N3NEw8lyNhy7xqTk/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768266343; c=relaxed/simple;
	bh=0mLHhe39Kqf6i5jhmNl7qFODAllYf91ZHuBxyeVdlK8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=relIzXm0IkG7Ll0eGOmlcQ1jWRMxqu+VuEa0SCqDSaZSUI8TF64tAyTSWhnl+9RVxQ73RyWIZ8t8Vuv6uYyzPuJp6NZIZVE2/w4s9wLdG+LsoKmaSVALIsKF2S6/04vJTtQo6kZ2LAIh18g6W1k/+t3ra+NQOkm+LSLnx4HZfSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=awS6JcwZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34aa1d06456so8425334a91.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 17:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768266341; x=1768871141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xGycwIRrzEAPpS5Queie7jYImm8qoNK4WBpMPiB/Mys=;
        b=awS6JcwZL6Ph6lLnorAZ1eMaAr0s78lggsdWt/4OUkJ0lmKjmCnXSOKGppc42x3fRs
         cRAQfE4iYbwSx3Lk9yRxKlrn7/uD1iPxFWZFLFJIMHS08xnER0zfNWnO6BHM0/itP+14
         d3OIEkdNk1bSmyMCDhVljdKZdtIOCTHX4f1xDqV+a2eqaGop4/TEQ7jQUm3FShpiSq1S
         SshKFjLX7+CvzmltUHbuWNFmRGtl9yNNi93JfCeIKJ+nbmSnelXF9IM1Mh4Q7j7rFL3x
         8EVr8nHdhetULLKru7OFK6FRJ9n9DcP6cdFYcGijJoztyBLNZ8GiOdCm32DO69Yt1U3d
         T8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768266341; x=1768871141;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xGycwIRrzEAPpS5Queie7jYImm8qoNK4WBpMPiB/Mys=;
        b=K5njrcwZse5hy32NuYAax/xDpxc38ZDUR887MmKo81I25wMH6V69u8++yLh+dIiKLZ
         eocx9Rcy09tgfLRoliVhW5qRbxMIl1Sr1s/A+virh78BL9nc+jEGBolgEi4iM2EM58hC
         TGHIYSZEMDIjbzw8/iqzBZH2SkTkV/IKOXzWrA6M3yB/FfUl3bif4QnZ3EBTY5Q/P0Qt
         s14QNfP3JBwXqjVBDyf2Xtvo5UgTB8yQqVwc9BBRRSahExwpeHpCmpD2EuXkp0yyOCig
         FVAjsXERK4LD91bQgX+QndxXxOm2CD9bzoyjrqzXOz6jmgINa6P1Xxo9NzYq+BCEJrOE
         rhYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWvcpqGo+SbfWF1NSWYRPgfVYBSpy167McXFBmGtKlByyDM4Ts1o3xhb7M8ROBNZcpUN99yho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPFxOS8EvmHDwZP9S5tnyCbZV7J5X+frx0lUjGYuSKQyn8qspZ
	WtO3zvlpfVuNQ9ljPINf5KLGOWn83TjwtoCr1cyEXQAE20dPhLJAMT9C6oieGVKGEdpJbJvyNPF
	ziZ9jaw==
X-Google-Smtp-Source: AGHT+IFk7KWM9DQjxowNpxQImTTGbooQRUzI9GllE4ZeJ33KWlodzL3yL3/DBBv3fyWddh0A+uSJIy/SvX4=
X-Received: from pjbev18.prod.google.com ([2002:a17:90a:ead2:b0:339:e59f:e26])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2741:b0:341:88c9:aefb
 with SMTP id 98e67ed59e1d1-34f68c0241cmr14927232a91.5.1768266341535; Mon, 12
 Jan 2026 17:05:41 -0800 (PST)
Date: Tue, 13 Jan 2026 01:05:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260113010538.2019411-1-kuniyu@google.com>
Subject: [PATCH v1 net] ipv6: Fix use-after-free in inet6_addr_del().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+72e610f4f1a930ca9d8a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported use-after-free of inet6_ifaddr in
inet6_addr_del(). [0]

The cited commit accidentally moved ipv6_del_addr() for
mngtmpaddr before reading its ifp->flags for temporary
addresses in inet6_addr_del().

Let's move ipv6_del_addr() down to fix the UAF.

[0]:
BUG: KASAN: slab-use-after-free in inet6_addr_del.constprop.0+0x67a/0x6b0 net/ipv6/addrconf.c:3117
Read of size 4 at addr ffff88807b89c86c by task syz.3.1618/9593

CPU: 0 UID: 0 PID: 9593 Comm: syz.3.1618 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 inet6_addr_del.constprop.0+0x67a/0x6b0 net/ipv6/addrconf.c:3117
 addrconf_del_ifaddr+0x11e/0x190 net/ipv6/addrconf.c:3181
 inet6_ioctl+0x1e5/0x2b0 net/ipv6/af_inet6.c:582
 sock_do_ioctl+0x118/0x280 net/socket.c:1254
 sock_ioctl+0x227/0x6b0 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f164cf8f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f164de64038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f164d1e5fa0 RCX: 00007f164cf8f749
RDX: 0000200000000000 RSI: 0000000000008936 RDI: 0000000000000003
RBP: 00007f164d013f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f164d1e6038 R14: 00007f164d1e5fa0 R15: 00007ffde15c8288
 </TASK>

Allocated by task 9593:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:397 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:414
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 ipv6_add_addr+0x4e3/0x2010 net/ipv6/addrconf.c:1120
 inet6_addr_add+0x256/0x9b0 net/ipv6/addrconf.c:3050
 addrconf_add_ifaddr+0x1fc/0x450 net/ipv6/addrconf.c:3160
 inet6_ioctl+0x103/0x2b0 net/ipv6/af_inet6.c:580
 sock_do_ioctl+0x118/0x280 net/socket.c:1254
 sock_ioctl+0x227/0x6b0 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6099:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free_freelist_hook mm/slub.c:2569 [inline]
 slab_free_bulk mm/slub.c:6696 [inline]
 kmem_cache_free_bulk mm/slub.c:7383 [inline]
 kmem_cache_free_bulk+0x2bf/0x680 mm/slub.c:7362
 kfree_bulk include/linux/slab.h:830 [inline]
 kvfree_rcu_bulk+0x1b7/0x1e0 mm/slab_common.c:1523
 kvfree_rcu_drain_ready mm/slab_common.c:1728 [inline]
 kfree_rcu_monitor+0x1d0/0x2f0 mm/slab_common.c:1801
 process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
 process_scheduled_works kernel/workqueue.c:3340 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Fixes: 00b5b7aab9e42 ("net/ipv6: delete temporary address if mngtmpaddr is removed or unmanaged")
Reported-by: syzbot+72e610f4f1a930ca9d8a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/696598e9.050a0220.3be5c5.0009.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/addrconf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index b66217d1b2f82..27ab9d7adc649 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3112,12 +3112,12 @@ static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
 			in6_ifa_hold(ifp);
 			read_unlock_bh(&idev->lock);
 
-			ipv6_del_addr(ifp);
-
 			if (!(ifp->flags & IFA_F_TEMPORARY) &&
 			    (ifp->flags & IFA_F_MANAGETEMPADDR))
 				delete_tempaddrs(idev, ifp);
 
+			ipv6_del_addr(ifp);
+
 			addrconf_verify_rtnl(net);
 			if (ipv6_addr_is_multicast(pfx)) {
 				ipv6_mc_config(net->ipv6.mc_autojoin_sk,
-- 
2.52.0.457.g6b5491de43-goog


