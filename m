Return-Path: <netdev+bounces-103511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B65908622
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A87628A954
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89311185087;
	Fri, 14 Jun 2024 08:20:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C7518413E
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353220; cv=none; b=l4vZxRLoq1wvXuQt8VJMWxlotUN5im6aNmUasR1lpp3XmrX8lUE+5ZRFcET546zvbdJFj0CZvorpM9mAEAlYQt49VukULNgSON+ZyAyOWUaI5ShZz3VtpPibzZf0iFb77c7rJBqFxNUmjQdx2JMPBOgo1nsR8EBpdSA4yX5X5Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353220; c=relaxed/simple;
	bh=e3ogd1Rf26F8B2OGtCcYnmXW4DRYUwGPUqwfsRijmGw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lBRQ277BtBhn0/WCfZoukf6K+7kQ8nj4XlGoq5h6wo+f6MYjny4K+M7Auh3+MJP6kl0AHVJ8DvLv2uSwa6h/c25M5GFVWsE9FtBaozb94r0K1NG/REcnSI/Dzw4tCxnVr23ZblVGTm8IJSzAIYo/KgtsMij2cR96S0cvlaBKCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3745fb76682so18637775ab.2
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 01:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718353218; x=1718958018;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJYub9ik3zvCE5LR2av2mS0zy2PWlUjn26HCWt4th7Y=;
        b=PyZZSevIQ3fAqH1AVrZwbPReuxRtk/VMjfps/2PFcOeevwNEPepreNnsf4y5uvDP7G
         NmcPVm+Ekwcxb3rUcOrlmRJNfuQ+8jgu53cmdL3+nl0nVAvunzKYg8CYJmlOCP+OPkDq
         MlB+ye/iJL9vfIijkMmk0OPQ/CrmGzt0oe8T/g2kUfhP4viVX2q9WVdvIqQxXBq6UY70
         eLt1DrKWXaAlOiDh3BMUhI/fgJQK2JjTmXAiCZMngDFd/hrnc+YUGSm/3bcQSyf8Y202
         MNeIFM0Pu4p8s8dXyAYfTkIby5BcMZhPuA1qPxbTYoZ6uo/WMia05Jn4C1pCLzklAZEJ
         rJbw==
X-Forwarded-Encrypted: i=1; AJvYcCXOxqVVaxUUqKviwOSSv6A09DTnmpb3i6oQfrTPfetqhgu4pPUYFTQH10BNshbUY41FP3Zst3pscBC1B/YLnr8yhCQHLuT+
X-Gm-Message-State: AOJu0YwpCtE34F5ADGevlyuf47TUQpZOjXHkmeCGFDLCAYWr78d7LoxE
	68hShnpIWHTOTqRnJVzLww20zfebem2EZbuiZVaEZY+JVZRvqMAH+4EMFQmWRp/+rLb1iDxLq3J
	a4F3ToWujTxRnoiQt6L/nGYyi6LZ7YGpJUmWGJMXIXconyxzHAKoQgtA=
X-Google-Smtp-Source: AGHT+IFlHbIwVrRQ09ko8ZYI6I9T8ufKj5i6mBTVJzY7IHh86/F0utu1+qkoHOzzZG6f2rTVNlurhV4WzRJtmHfKVVMP6Y7Q/UI6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1909:b0:375:9e28:49b with SMTP id
 e9e14a558f8ab-375e0e2be9bmr1347055ab.2.1718353218075; Fri, 14 Jun 2024
 01:20:18 -0700 (PDT)
Date: Fri, 14 Jun 2024 01:20:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000298850061ad54973@google.com>
Subject: [syzbot] [netfilter?] net test error: WARNING: suspicious RCU usage
 in _destroy_all_sets
From: syzbot <syzbot+565a9cd16f2d99544b94@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	kadlec@netfilter.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4467c09bc7a6 net: mvpp2: use slab_build_skb for oversized ..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17b14736980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
dashboard link: https://syzkaller.appspot.com/bug?extid=565a9cd16f2d99544b94
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b7d932d926fc/disk-4467c09b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b6972333a06f/vmlinux-4467c09b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b607f1f9f977/bzImage-4467c09b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+565a9cd16f2d99544b94@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.10.0-rc3-syzkaller-00100-g4467c09bc7a6 #0 Not tainted
-----------------------------
net/netfilter/ipset/ip_set_core.c:1200 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/u8:5/748:
 #0: ffff888015ed5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015ed5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90003a3fd00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90003a3fd00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8f5db250 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:594

stack backtrace:
CPU: 0 PID: 748 Comm: kworker/u8:5 Not tainted 6.10.0-rc3-syzkaller-00100-g4467c09bc7a6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
 _destroy_all_sets+0x232/0x5f0 net/netfilter/ipset/ip_set_core.c:1200
 ip_set_net_exit+0x20/0x50 net/netfilter/ipset/ip_set_core.c:2396
 ops_exit_list net/core/net_namespace.c:173 [inline]
 cleanup_net+0x802/0xcc0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

=============================
WARNING: suspicious RCU usage
6.10.0-rc3-syzkaller-00100-g4467c09bc7a6 #0 Not tainted
-----------------------------
net/netfilter/ipset/ip_set_core.c:1211 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/u8:5/748:
 #0: ffff888015ed5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015ed5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90003a3fd00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90003a3fd00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8f5db250 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:594

stack backtrace:
CPU: 1 PID: 748 Comm: kworker/u8:5 Not tainted 6.10.0-rc3-syzkaller-00100-g4467c09bc7a6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
 _destroy_all_sets+0x53f/0x5f0 net/netfilter/ipset/ip_set_core.c:1211
 ip_set_net_exit+0x20/0x50 net/netfilter/ipset/ip_set_core.c:2396
 ops_exit_list net/core/net_namespace.c:173 [inline]
 cleanup_net+0x802/0xcc0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

