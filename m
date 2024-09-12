Return-Path: <netdev+bounces-127933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD25977157
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD061287122
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7214C1C3F0A;
	Thu, 12 Sep 2024 19:13:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788181C3F18
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168409; cv=none; b=fp6jCvUk7guxgIFjG3Vcz1PRLQF291tezH/QJPqZe64wjHb3n/RYeIaUQFfD5a2vciynoOeAZtOOY16J/JyboTkYgafioMvBT5LhS1K/Yg0DXl1EGg6svAFQkcBTQNT0De3AVQWtmoJKxw/lAorJWz1bASWNZJ3wXI10/fq87b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168409; c=relaxed/simple;
	bh=gywwvF34Ufue1kLL6Vg7tvSVlc+gm/z9NVehtbWO96Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o17BKy/6rCA+5Aj9bvHH0d4uQPHt5e1c5xngpBocUm73mOHBRNBVSyHsFpkaxLkE6LV+wwQTtLLvzT50k/vIrmSBVdVT1C0v466zD+zp832Kbvy9Jgr2oR3hK03ryCLwu3sFbTDDLx/eVCj6stGnOMQ50CSarN8K9ParbPYp844=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aa499f938so275115739f.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 12:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726168406; x=1726773206;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r4RO713141R/Eyk0JKxENp+hXLSBWtfv0JqnjVrRjC0=;
        b=nl7kjKYyiVNox5dN7g1iP1lFhZqxPMe5/9ofi6JjfB7qrR+eELet+jkMxit7jCFvHX
         0bWE5UubgxZzUP8LKL6Z6oZf4j2ObqDIxWCTmgt8+FWOAiHNQb0FLbwlG9EH6SK4O+Xa
         nHF9K6NcYP3I43EetCizHkrNpxiLhJ09BfIxtuDzDzjfpqOoRJI83O8wJMtAe5AWH2Q4
         aIZ3k9HOYWeHIxgEFQ3bNVOItnkv1chUo9D4v30EEpR5tAdaBcVGfFWOR7ENkKzSyFEt
         mrr9QPyGfIrMqtCWfHCCyfGQd8hu0KZYocAOuqjXvmik9onzySJff7GgUcZ1r9fqO96r
         1y7A==
X-Forwarded-Encrypted: i=1; AJvYcCWKyX5IF42kSCSbn8ePzsTPtj4PL5ByCqzaffji6LzR6vi+ni2/wAvLl8A1k3R7k8BVuVTtotA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ1GqwOJREoQOp+vZQW2r4865h8Tv36cw3XZRZ81JeQv0eEI/x
	MLRe0XyoPjNfz8F05dhE8qsJsh9l/RbIiSXqpuEsEOvj23U06ME+vjJQkobEiU1m5gzbc0vkeTh
	WYk7xS3O8vkKX72T4Es4VSS5Cij+ZwSr+cqj8Vxz/er6U+q11P/sTboQ=
X-Google-Smtp-Source: AGHT+IHjTiFZMVvlQcgI9c5+n8ISFR0ke8dQO6Uiu7ctQKNdm7TyNOGT95DmJyUwL+v4xN2ns5HJaa06EuSURHXFc8EdVG/4KTln
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2147:b0:398:a9b3:d6b1 with SMTP id
 e9e14a558f8ab-3a08464e152mr33198825ab.12.1726168406602; Thu, 12 Sep 2024
 12:13:26 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:13:26 -0700
In-Reply-To: <000000000000227d2c061c54ff82@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2cef80621f0e6f5@google.com>
Subject: Re: [syzbot] [net?] WARNING: suspicious RCU usage in dev_activate
From: syzbot <syzbot+2120b9a8f96b3fa90bad@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	jhs@mojatatu.com, jiri@resnulli.us, johannes.berg@intel.com, 
	johannes@sipsolutions.net, jv@jvosburgh.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    77f587896757 Merge tag 'arm-fixes-6.11-3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1781149f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=2120b9a8f96b3fa90bad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128160a9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3d43e4fb8f51/disk-77f58789.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3f2facb83939/vmlinux-77f58789.xz
kernel image: https://storage.googleapis.com/syzbot-assets/26e67580882c/bzImage-77f58789.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2120b9a8f96b3fa90bad@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.11.0-rc7-syzkaller-00039-g77f587896757 #0 Not tainted
-----------------------------
net/sched/sch_generic.c:1250 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/u8:4/62:
 #0: ffff888011c52948 ((wq_completion)bond0#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888011c52948 ((wq_completion)bond0#2){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900015d7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900015d7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x174/0x3170 drivers/net/bonding/bond_main.c:2863

stack backtrace:
CPU: 1 UID: 0 PID: 62 Comm: kworker/u8:4 Not tainted 6.11.0-rc7-syzkaller-00039-g77f587896757 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6724
 dev_activate+0xf8/0x1240 net/sched/sch_generic.c:1250
 linkwatch_do_dev+0xfb/0x170 net/core/link_watch.c:173
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:799
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2643 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2865
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

=============================
WARNING: suspicious RCU usage
6.11.0-rc7-syzkaller-00039-g77f587896757 #0 Not tainted
-----------------------------
net/sched/sch_generic.c:1228 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/u8:4/62:
 #0: ffff888011c52948 ((wq_completion)bond0#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888011c52948 ((wq_completion)bond0#2){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900015d7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900015d7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x174/0x3170 drivers/net/bonding/bond_main.c:2863

stack backtrace:
CPU: 1 UID: 0 PID: 62 Comm: kworker/u8:4 Not tainted 6.11.0-rc7-syzkaller-00039-g77f587896757 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6724
 transition_one_qdisc+0x8e/0x1c0 net/sched/sch_generic.c:1228
 netdev_for_each_tx_queue include/linux/netdevice.h:2513 [inline]
 dev_activate+0x838/0x1240 net/sched/sch_generic.c:1258
 linkwatch_do_dev+0xfb/0x170 net/core/link_watch.c:173
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:799
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2643 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2865
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

=============================
WARNING: suspicious RCU usage
6.11.0-rc7-syzkaller-00039-g77f587896757 #0 Not tainted
-----------------------------
include/linux/rtnetlink.h:100 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/u8:4/62:
 #0: ffff888011c52948 ((wq_completion)bond0#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888011c52948 ((wq_completion)bond0#2){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900015d7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900015d7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x174/0x3170 drivers/net/bonding/bond_main.c:2863

stack backtrace:
CPU: 0 UID: 0 PID: 62 Comm: kworker/u8:4 Not tainted 6.11.0-rc7-syzkaller-00039-g77f587896757 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6724
 dev_ingress_queue include/linux/rtnetlink.h:100 [inline]
 dev_activate+0x925/0x1240 net/sched/sch_generic.c:1259
 linkwatch_do_dev+0xfb/0x170 net/core/link_watch.c:173
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:799
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2643 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2865
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1525
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 62, name: kworker/u8:4
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u8:4/62:
 #0: ffff888011c52948 ((wq_completion)bond0#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888011c52948 ((wq_completion)bond0#2){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900015d7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900015d7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x174/0x3170 drivers/net/bonding/bond_main.c:2863
CPU: 0 UID: 0 PID: 62 Comm: kworker/u8:4 Not tainted 6.11.0-rc7-syzkaller-00039-g77f587896757 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8463
 down_read+0x8e/0xa40 kernel/locking/rwsem.c:1525
 wireless_nlevent_flush net/wireless/wext-core.c:351 [inline]
 wext_netdev_notifier_call+0x1f/0x120 net/wireless/wext-core.c:371
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 netdev_state_change+0x11f/0x1a0 net/core/dev.c:1376
 linkwatch_do_dev+0x112/0x170 net/core/link_watch.c:177
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:799
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2643 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2865
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.11.0-rc7-syzkaller-00039-g77f587896757 #0 Tainted: G        W         
-----------------------------
kworker/u8:4/62 is trying to lock:
ffffffff8fc7f690 (net_rwsem){++++}-{3:3}, at: wireless_nlevent_flush net/wireless/wext-core.c:351 [inline]
ffffffff8fc7f690 (net_rwsem){++++}-{3:3}, at: wext_netdev_notifier_call+0x1f/0x120 net/wireless/wext-core.c:371
other info that might help us debug this:
context-{4:4}
3 locks held by kworker/u8:4/62:
 #0: ffff888011c52948 ((wq_completion)bond0#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888011c52948 ((wq_completion)bond0#2){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900015d7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900015d7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x174/0x3170 drivers/net/bonding/bond_main.c:2863
stack backtrace:
CPU: 0 UID: 0 PID: 62 Comm: kworker/u8:4 Tainted: G        W          6.11.0-rc7-syzkaller-00039-g77f587896757 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4750 [inline]
 check_wait_context kernel/locking/lockdep.c:4820 [inline]
 __lock_acquire+0x153b/0x2040 kernel/locking/lockdep.c:5092
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
 wireless_nlevent_flush net/wireless/wext-core.c:351 [inline]
 wext_netdev_notifier_call+0x1f/0x120 net/wireless/wext-core.c:371
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 netdev_state_change+0x11f/0x1a0 net/core/dev.c:1376
 linkwatch_do_dev+0x112/0x170 net/core/link_watch.c:177
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:799
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2643 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2865
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

