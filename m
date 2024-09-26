Return-Path: <netdev+bounces-129907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 575BF986F8F
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 11:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D044F1F2144B
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 09:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DFB1A7058;
	Thu, 26 Sep 2024 09:06:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF89208CA
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341585; cv=none; b=u1ChosQ/BCT6SV/eVO/7YsBfhD4DJzPRcQnzkyn6CtNf6WM317IixUVHzrgcCNdPZoGoCq1bL52hzqT8bcU7HdhGWwumUOFkjiHOuLvqzl4F0urhiTsyImggrBd9pt5WvBsqcxBItSgj7NNiobGlHpxp8XgBlR8EqZ0NlbS/4uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341585; c=relaxed/simple;
	bh=NvCmIZyWCVVYHlXeIW2x20WR7cRHt4Imip64l49ZLLg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KrJTv9exZwHep4+TQaPeBlC5GSj24BbddMB1maFKw0ciMPAWC7UF55iGDa1+TThjawXxSZITnFnu+uBKgNKAD/4mS9mS+h3OTrdlxEeRMhf1QTZeZiof38egj0iWgLOZU2OJvaIb5FHv0kkarz4gUfAniggv5v/WMXmoIkaXZ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f56ac8d88so10061855ab.2
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 02:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727341583; x=1727946383;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XrHRgOCKMkPVf19Q1S4Vh275ihiADqflV40qM57jjkE=;
        b=c3Tqw7X5jO8760g6ZY45F8Nu94B3y2b/P9mKBRTRThOQfRhCLH8KSU05AZHOkeQ+Fq
         ZdDcmz99ukGHc3dEofw1vc4CkLc/mag8FHIdn32By16Kngsps2/mb68djqWiLhrQhAlU
         OES5Othr43zxDg57LByGokhNvkEM2ypKB0p3gal70/lRuUWh8/5twSoEqQ9G8Oeyo/YT
         STZ2IJM39rzKwASWwWdjnlUyLZQ34bNUj1G8aXI4SzSOabrhR7Mvh5DwG1Mt0hgXNPDr
         G5OHyYfOBqp6gO6uXpVvmyx6F/BhjfPI69IbAQKTVZwbnW9G5xVVNHx5ThMuWSuUauC7
         K/XA==
X-Forwarded-Encrypted: i=1; AJvYcCVCXp+bg3OP+Z5YnhreM2g6BKzvTmQSWQyiOG4CVWhskw1Cfz1ojaah1ebwIN+FVaINrkwoXx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqXVPRtcOsdmMrArscWuk1s8qJ/3FwHy8TdIn25PvYc09SKPjV
	tWJYVYOn+0XZeKWF57fSI7NIpaViqdsLZksbqqO7TUBKHh8/zwobWnxlgUQ9ztXZgtSsW6rBx6p
	y1aDK8Tnh5QOxQGdiBZTyv7ATzd8OUqUkn6hhVr7ANKJ4QIhxefIo2cc=
X-Google-Smtp-Source: AGHT+IHbqK4XhAdvFiRz7gzcB5yfGyRpXOPMTu3IUs+14jJbPW4H4Tlqzi/LQ8soHJuj0g/381/GCyBOPAYVZT5PsKe2yrh3pshs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190b:b0:3a0:91e7:67cc with SMTP id
 e9e14a558f8ab-3a26d7747famr65386385ab.13.1727341583396; Thu, 26 Sep 2024
 02:06:23 -0700 (PDT)
Date: Thu, 26 Sep 2024 02:06:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f5240f.050a0220.211276.0065.GAE@google.com>
Subject: [syzbot] [net?] WARNING: refcount bug in nsim_fib_event_nb
From: syzbot <syzbot+ed81dabfbde89a6311b5@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d759ee240d3c Merge tag 'net-6.11-rc7' of git://git.kernel...
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17166f29980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=ed81dabfbde89a6311b5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d0ae115b9910/disk-d759ee24.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5c4b4ce8a5a5/vmlinux-d759ee24.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b98d3ce897eb/bzImage-d759ee24.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ed81dabfbde89a6311b5@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 6557 at lib/refcount.c:25 refcount_warn_saturate+0x13a/0x1d0 lib/refcount.c:25
Modules linked in:
CPU: 0 UID: 0 PID: 6557 Comm: kworker/u8:16 Not tainted 6.11.0-rc6-syzkaller-00178-gd759ee240d3c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: netns cleanup_net
RIP: 0010:refcount_warn_saturate+0x13a/0x1d0 lib/refcount.c:25
Code: a0 3a 60 8c e8 d7 2d a3 fc 90 0f 0b 90 90 eb b9 e8 9b 09 e1 fc c6 05 d2 c4 4f 0b 01 90 48 c7 c7 00 3b 60 8c e8 b7 2d a3 fc 90 <0f> 0b 90 90 eb 99 e8 7b 09 e1 fc c6 05 b3 c4 4f 0b 01 90 48 c7 c7
RSP: 0018:ffffc90014d973a0 EFLAGS: 00010246
RAX: ccfc4fa8067d8700 RBX: ffff888025a89a3c RCX: ffff888035538000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffffffff8155b372 R09: fffffbfff1cfa0e0
R10: dffffc0000000000 R11: fffffbfff1cfa0e0 R12: ffffffffffffffff
R13: ffff88805e847000 R14: ffff888025a89a3c R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff487f626e0 CR3: 000000002b560000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_inc include/linux/refcount.h:241 [inline]
 refcount_inc include/linux/refcount.h:258 [inline]
 fib_info_hold include/net/ip_fib.h:606 [inline]
 nsim_fib4_prepare_event drivers/net/netdevsim/fib.c:930 [inline]
 nsim_fib_event_schedule_work drivers/net/netdevsim/fib.c:1000 [inline]
 nsim_fib_event_nb+0xee9/0x10b0 drivers/net/netdevsim/fib.c:1043
 call_fib_notifier+0x42/0x70 net/core/fib_notifier.c:24
 call_fib_entry_notifier net/ipv4/fib_trie.c:90 [inline]
 fib_leaf_notify net/ipv4/fib_trie.c:2204 [inline]
 fib_table_notify net/ipv4/fib_trie.c:2222 [inline]
 fib_notify+0x445/0x780 net/ipv4/fib_trie.c:2245
 fib_net_dump net/core/fib_notifier.c:71 [inline]
 register_fib_notifier+0x182/0x370 net/core/fib_notifier.c:109
 nsim_fib_create+0x902/0xa70 drivers/net/netdevsim/fib.c:1595
 nsim_dev_reload_create drivers/net/netdevsim/dev.c:1480 [inline]
 nsim_dev_reload_up+0x3d1/0x8e0 drivers/net/netdevsim/dev.c:985
 devlink_reload+0x478/0x870 net/devlink/dev.c:474
 devlink_pernet_pre_exit+0x1f3/0x440 net/devlink/core.c:509
 ops_pre_exit_list net/core/net_namespace.c:163 [inline]
 cleanup_net+0x615/0xcc0 net/core/net_namespace.c:620
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
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

