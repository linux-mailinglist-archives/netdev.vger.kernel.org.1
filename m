Return-Path: <netdev+bounces-205563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A39AFF46E
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 00:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92C63B1B9C
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 22:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18E42417EF;
	Wed,  9 Jul 2025 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wziYeNNe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0FA23C8D3
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 22:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099059; cv=none; b=dsiQcrQM+eSgtLKjSCglZgkCLfPKm0ixLtq/+cd1I2kdxa5z1NrXJ+vLFvTNkfZ0YJ5aO0gGbD6X2LBSpe0/z+C6clmOboqmgdXlSu6xjas0J/asJNXdabuJJCHcLgsjrhP8TVzJM5xZYJyXQgdJpRRk4pgSYLWnEXpW3eLIJ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099059; c=relaxed/simple;
	bh=LjFYF0lt9jEUxpT2nC08KiKqDS8ZoM1AgxsygSkxKWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XxfavwtBsuIHNbtoL6lXbrJDZGexoFCbyD7rRJPbTWBNF1yzpjnlP6qr1axccylpCjjyL4eDsr/N+6a8WN6b7L4wcQ8PXV0glgxxiJOifPP3c0h/TxF6owz1WL1sza7EbHd2UZH0avifGgC9fYtDuXHXf1z+6h/FOTmf3uBZ9NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wziYeNNe; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3138c50d2a0so484907a91.2
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 15:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752099057; x=1752703857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ekJuo2KtcQ9gwWfZtcvEIB5fjv3g7q7AyadBW+eJGQo=;
        b=wziYeNNeFIOO6KVSGT+WxTqrTkdLsLbORrItmJ/8RNPSD1vWemvut/TBCu3q9mdYlg
         haMdtnD6tVpXHyHQNLL7uukF9IdhUHmsalBie0quoDcyeQWc6WSvrZt+hS48MEul7146
         4L4XhvHwSaABqpi0PUF2Vlb04T6lZD+eWMdeCROw8DICfVwbV6wZEHr3gUQxS9RPH4Cx
         R3J50A4IBDcOTwqO0lJMwYr+XKOwnZsvjCWYvm1Q240JXvDBxYCONTXZCljU49vn1b9n
         5ooM4zk4AbMYFbeMYHKw3kWgKYBIrdXe+B9OZM9U6dZj8znLhNFy/rB8+Izs3TPDa1lA
         w74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752099057; x=1752703857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekJuo2KtcQ9gwWfZtcvEIB5fjv3g7q7AyadBW+eJGQo=;
        b=s70CuU9uJk7Vy5jGzNgfmXAvWHWBP0JQ6O90W9+zYx1dAb9/7pStH3U1RiESwhbMfX
         paZA0VzB9aGWoNn5PJcIyNjQZpW+qh1TgtY+ndX/qalIUkpss9dsw8NqhXEbWQq99Afa
         IBwJa0atPl0n2ue/XNhY3w2g5gCKXLuh8e05rkmEdkSfJKw625HEDGrRYYZ+2QZdnaI7
         XxCbqQOIcfP+8v2KlmggFTkhLkveTmQe8UVgqNNOz76GKjLMHnzGHsC/pLlfRI8IcQnk
         MlhhD9/BMabb7pgaQGClewCZxV5FBkrYiGOFD6SyepfTNQsI+/K7lqngKt/El9uTdJMi
         KExw==
X-Forwarded-Encrypted: i=1; AJvYcCVWTfcmkNb38p+dXmJO8StGovAxb5E9MfMzoPabPgEaGjd3jQqCszrvAnJyjQ4AiWxUP+IKYIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYrcjzROFNEhZdda/lDemmR7SYiFoE96ANJqmiDlFH/t5HLX8t
	JXpDxz1N/fAMPUgoh4uEmhEm6qHWEJYwihtQ34B2Nz4jKx6ylKqOTzR6mhLiGu+xyBczWO7qTio
	/FtKY2w==
X-Google-Smtp-Source: AGHT+IECSBQdnk0doL1qbDFuq/dnOTDWqCbUYWmLLcEa469Xs/RJQgQsVMYS8W0FhNeG4wrYG76Jqvbp7ac=
X-Received: from pjwx6.prod.google.com ([2002:a17:90a:c2c6:b0:2e0:915d:d594])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5110:b0:312:51a9:5d44
 with SMTP id 98e67ed59e1d1-31c2fcc3320mr6012901a91.5.1752099057649; Wed, 09
 Jul 2025 15:10:57 -0700 (PDT)
Date: Wed,  9 Jul 2025 22:10:13 +0000
In-Reply-To: <686ee4a0.050a0220.385921.0022.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <686ee4a0.050a0220.385921.0022.GAE@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709221056.707151-1-kuniyu@google.com>
Subject: Re: [syzbot] [net?] WARNING: ./include/net/netdev_lock.h:LINE at
 __linkwatch_sync_dev, CPU: kworker/u8:NUM/NUM
From: Kuniyuki Iwashima <kuniyu@google.com>
To: syzbot+9196eb463ddf99a0be6e@syzkaller.appspotmail.com, 
	Jay Vosburgh <jv@jvosburgh.net>
Cc: cratiu@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, syzkaller-bugs@googlegroups.com, vladimir.oltean@nxp.com
Content-Type: text/plain; charset="UTF-8"

From: syzbot <syzbot+9196eb463ddf99a0be6e@syzkaller.appspotmail.com>
Date: Wed, 09 Jul 2025 14:52:32 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    050f8ad7b58d Add linux-next specific files for 20250616
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13ad8370580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d2efc7740224b93a
> dashboard link: https://syzkaller.appspot.com/bug?extid=9196eb463ddf99a0be6e
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155c190c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109c95d4580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/49faa18d2f53/disk-050f8ad7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7c6f9cd7fe5d/vmlinux-050f8ad7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/84a08d6403ee/bzImage-050f8ad7.xz
> 
> The issue was bisected to:
> 
> commit 04efcee6ef8d0f01eef495db047e7216d6e6e38f
> Author: Stanislav Fomichev <sdf@fomichev.me>
> Date:   Fri Apr 4 16:11:22 2025 +0000
> 
>     net: hold instance lock during NETDEV_CHANGE
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16390dd4580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15390dd4580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11390dd4580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9196eb463ddf99a0be6e@syzkaller.appspotmail.com
> Fixes: 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
> 
> ------------[ cut here ]------------
> RTNL: assertion failed at ./include/net/netdev_lock.h (72)
> WARNING: ./include/net/netdev_lock.h:72 at netdev_ops_assert_locked include/net/netdev_lock.h:72 [inline], CPU#0: kworker/u8:3/49
> WARNING: ./include/net/netdev_lock.h:72 at __linkwatch_sync_dev+0x303/0x350 net/core/link_watch.c:279, CPU#0: kworker/u8:3/49
> Modules linked in:
> CPU: 0 UID: 0 PID: 49 Comm: kworker/u8:3 Not tainted 6.16.0-rc2-next-20250616-syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> Workqueue: bond0 bond_mii_monitor
> RIP: 0010:netdev_ops_assert_locked include/net/netdev_lock.h:72 [inline]
> RIP: 0010:__linkwatch_sync_dev+0x303/0x350 net/core/link_watch.c:279
> Code: 7c fe ff ff e8 5e 7f 66 f8 c6 05 ce 6b 31 06 01 90 48 c7 c7 20 2f 93 8c 48 c7 c6 7a 32 9d 8d ba 48 00 00 00 e8 9e 1d 2a f8 90 <0f> 0b 90 90 e9 4d fe ff ff 44 89 f1 80 e1 07 38 c1 0f 8c 22 fd ff
> RSP: 0018:ffffc90000ba7670 EFLAGS: 00010246
> RAX: a4c1d8d5a4094c00 RBX: ffff888032708000 RCX: ffff8880222a5a00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
> RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
> R10: dffffc0000000000 R11: fffffbfff1bfaa14 R12: 1ffff110064e105d
> R13: dffffc0000000000 R14: ffffffff8c1c95e8 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff888125c40000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000000300 CR3: 000000007997c000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ethtool_op_get_link+0x15/0x70 net/ethtool/ioctl.c:63
>  bond_check_dev_link+0x444/0x6c0 drivers/net/bonding/bond_main.c:863
>  bond_miimon_inspect drivers/net/bonding/bond_main.c:2745 [inline]
>  bond_mii_monitor+0x428/0x2e00 drivers/net/bonding/bond_main.c:2967
>  process_one_work kernel/workqueue.c:3235 [inline]
>  process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3318
>  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3399
>  kthread+0x711/0x8a0 kernel/kthread.c:464
>  ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

Jay, could you test your patch below with the instruction above ?

https://lore.kernel.org/netdev/1912679.1750099002@famine/

Thanks!

