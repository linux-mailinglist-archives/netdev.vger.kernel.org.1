Return-Path: <netdev+bounces-145002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6E49C9091
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 18:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA26B1F22E80
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 17:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AFB1891AB;
	Thu, 14 Nov 2024 17:13:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DEC18595B
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604402; cv=none; b=rAdrLxcInxtQrY/5kKgphQtXWg6RqHk0ina/aBQRGhjvbuL6FPopStANvDT2upsFTnKfxoMX0UcyPHC1YiDmtcv8E3DBAXVKEdHJPnrkB2ZBhLMBf9g5bqdl6JapOS7aKHODz06CdyVSZ66VrHJh0UO0S82AL2xY676sUNKQeT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604402; c=relaxed/simple;
	bh=HAVfaokq31EDmvBU3UOQJ16kSyH0NWYsRTHGqy5xD28=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kFa3GGVrw7LWW81GtJee973lEPULxoGSgQ0kkRhrrrluJQa2rSGpqV257ubDQEv8/NowlFeHnx1Bro4WC7u3iF6m97shgCMncpQ3H7sUqzVmQPAzDG2h3vUrD9v/PJnRdjXFOb2sAU1o7WsueK9dZFXGBzw7d+d6NHpUEY5/NFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7447028bcso4384895ab.1
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 09:13:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731604400; x=1732209200;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XHCekDVCgD4RwyXBhXgygfh4NVWosPvWXuyoL1Z0q1c=;
        b=vPQdvqw8vOxGpdXxQn08adYR2OYlVAyE2SYumf8raaBvkj+DRuKTkdcIYL5cQ/P9GN
         c9LfjiozWGs99ziNnh64GHt/2sxixV5do1J8DzVc9JWigd7A8fgL86HJIU2RUP/QlZhW
         WPKQ8QYE2hmjhraX9IJ3Cj0icWSQSjz6X0/x7fxM/rF6MY/DQO0IA1pWSZhyt/iWUUzP
         JnIJrfruzhJG78T5+rJKTPznOI0zwHRkTChJa7z9+HDbPROHrqjGkXT1SC+Rrvdt+ZSI
         l+n/AxYVqJco74kExMxxZBbTig0pVJmjnEvsfuPVBFo8lPsLUld6/ruI9yQdOKsrSZMl
         KBoA==
X-Forwarded-Encrypted: i=1; AJvYcCW2qJiHXs4DHR3B6hJ6reZfqBTQLhqGElnLFpFG4IapVUlexnJYU5eErUuxdb0f+HIUdY19dUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu4oHO0ljE63UZ1rzhudP8VjzoizwYWAdkUuqBhsagCVTaAJFN
	yyQH/03T3RpzzeeUK5h7tls0TRIg6XzLWLG7LWPayHG2sdFzIxQqa+jR8eaJMwn6020vfFjuami
	qMrPVDrXaVwPrrtgnyIsfKtTo6ETf8GvYS0eXFVKuiZu3xclEYLTZS2I=
X-Google-Smtp-Source: AGHT+IFlgc4WM9GbXMHDFI1iTJH9qLmAz3mqZJ/8Wna8zSJgrU+ASwghtd7vdaqyhPLNRrBJ1mVRAi8HsVTICGXmEyDWteMX7162
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2181:b0:3a6:f349:71e6 with SMTP id
 e9e14a558f8ab-3a71fec44f3mr30404625ab.22.1731604400222; Thu, 14 Nov 2024
 09:13:20 -0800 (PST)
Date: Thu, 14 Nov 2024 09:13:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67362fb0.050a0220.2a2fcc.0069.GAE@google.com>
Subject: [syzbot] [net?] WARNING in rcu_note_context_switch (3)
From: syzbot <syzbot+094799fb39e31554d5ee@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    de2f378f2b77 Merge tag 'nfsd-6.12-4' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d654e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=34db67f35f954904
dashboard link: https://syzkaller.appspot.com/bug?extid=094799fb39e31554d5ee
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-de2f378f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7f87c581ec66/vmlinux-de2f378f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/93ad0017ba33/Image-de2f378f.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+094799fb39e31554d5ee@syzkaller.appspotmail.com

------------[ cut here ]------------
Voluntary context switch within RCU read-side critical section!
WARNING: CPU: 1 PID: 62 at kernel/rcu/tree_plugin.h:331 rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:331
Modules linked in:
CPU: 1 UID: 0 PID: 62 Comm: kworker/u8:3 Not tainted 6.12.0-rc6-syzkaller-00279-gde2f378f2b77 #0
Hardware name: linux,dummy-virt (DT)
Workqueue: bond0 bond_mii_monitor
pstate: 614000c9 (nZCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:331
lr : rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:331
sp : ffff800082f7ba00
x29: ffff800082f7ba00 x28: 0000000000000003 x27: f3f0000004214900
x26: 0000000000000000 x25: fff000007f8ee800 x24: 0000000000000000
x23: 0000000000000000 x22: f3f0000004214900 x21: 0000000000000000
x20: ffff8000827006c0 x19: fff000007f8ef6c0 x18: fffffffffffdbe58
x17: fff07ffffd1ef000 x16: ffff800080008000 x15: 0000000000000048
x14: fffffffffffdbea0 x13: ffff80008274e5d0 x12: 00000000000012cc
x11: 0000000000000644 x10: ffff800082807c30 x9 : ffff80008274e5d0
x8 : 00000000ffffdfff x7 : ffff8000827fe5d0 x6 : 0000000000000644
x5 : fff000007f8e43c8 x4 : 40000000ffffe644 x3 : fff07ffffd1ef000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f3f0000004214900
Call trace:
 rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:331
 __schedule+0xb8/0x8fc kernel/sched/core.c:6570
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0x34/0x104 kernel/sched/core.c:6782
 synchronize_rcu_expedited+0x17c/0x1f0 kernel/rcu/tree_exp.h:991
 synchronize_net+0x18/0x34 net/core/dev.c:11286
 dev_deactivate_many+0x120/0x278 net/sched/sch_generic.c:1377
 dev_deactivate+0x60/0xac net/sched/sch_generic.c:1403
 linkwatch_do_dev+0x78/0xec net/core/link_watch.c:175
 linkwatch_sync_dev+0x8c/0xc8 net/core/link_watch.c:263
 ethtool_op_get_link+0x18/0x34 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x68/0x154 drivers/net/bonding/bond_main.c:873
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2717 [inline]
 bond_mii_monitor+0x110/0x91c drivers/net/bonding/bond_main.c:2939
 process_one_work+0x15c/0x29c kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x24c/0x354 kernel/workqueue.c:3391
 kthread+0x114/0x118 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
---[ end trace 0000000000000000 ]---


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

