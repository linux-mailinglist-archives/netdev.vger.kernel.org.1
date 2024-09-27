Return-Path: <netdev+bounces-130145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D15398895D
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 18:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB67E1F2151D
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 16:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B69A1C174E;
	Fri, 27 Sep 2024 16:53:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA8C1E49E
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727456009; cv=none; b=m5CmiIH2qO21tBnrMp6slaB5RmuGCOCa+bFr4cQ3xrNu8FFargwgCE29vK1W0fhplP6XAsVdIsCFuGvzJIpVHdr12hrjgV9P9CTopo/Dk/t7rJ5kqKCEELO/dH2EIdKJHelwzdtcEntJbMQKvpgMCfBhDwr0P/UibSd2IHyqJrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727456009; c=relaxed/simple;
	bh=HbNSFkbC/4y/P9Ba5K39AMbcnzlPTdiRQBsZeQhkrv8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BEo9HVQqMpaa8REv0SP/0+7qjTN4hB8nHMbwwX5isgi2DjjS7oNqwb2NwyhHJQ547f/R7iP4oUCs1yHqkhWl4/exFFahoWn2dLADSV3aDtA9kEZdoscneID+EJQKNiGoLFhTMEdvBBaciWIJNCXdcZNJ7G3riZbi8gNBQ1gYzVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a348ebb940so6922845ab.2
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 09:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727456007; x=1728060807;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgG/ygLGocIzopMcfdOssCN03xQrocYaesipZFj2uiI=;
        b=RMK7P4tQ7POb0hpGNuWmoCI29TxM1xNlR6AocwZBAmWzTfmJMWqLpVSdSwtqQozqYs
         ytAGjiSSCDMfqGAynOeSTldZnFE0xwla0oNE+dwJju/ozN+fZ5gO3rd7oWEfW1WCvpcR
         XP+h+opFnAfx7H3lm3d6d4honYtVl1jaqNVoHo+ZpZWMatMDjEYkBsR2YjUqvZcGrZ4T
         asPWDOY3OWSJA3T5u+DWePll6cUIt/qJ55IdIqgbitQreYYRlX6ty/21arZ8iuVnoQ2J
         E0fdBEuyY2v4r7Ce1M23VxBdd83WKY7w0nkbs7DoqfS+Y2I2GShqe6HBGkF0fsdgqRef
         82eQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/K8VVtm+BIH7XQm3P7JntS+iJMXsyAB9gU+M7SF1jA0LGSwtuVp3V+0TKV10IDG5MDbJlHIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YysmiVW1whRuBwiDIx4uljTW5TPpCn6hHkq2SjtzAo2qG071AOx
	vtV5Rbr7a5QgjZPziF5/MNMn4vb3tTUBx1DlTAH0LwYhGcatpdq9ripEeXtIXBrnfgHrAYtgpVK
	HzPCRaWRkFEjVs5rlk+ApGHJMJIgmQ3bYb1tEjnJVqqdn+q1sNMYt+SQ=
X-Google-Smtp-Source: AGHT+IFLcsTwZkkrPecbB6b2x8xxn5b3sGmUMzGQ4h9C3xp8xEdNTP44IfHSYDBkGxlYjVO1w+LHh/ffAG4Kc/WUsfbl8O1dYX6n
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17ce:b0:3a0:9d2b:2420 with SMTP id
 e9e14a558f8ab-3a3452d1fa0mr30894455ab.25.1727456007561; Fri, 27 Sep 2024
 09:53:27 -0700 (PDT)
Date: Fri, 27 Sep 2024 09:53:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6e307.050a0220.38ace9.002c.GAE@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in crda_timeout_work (8)
From: syzbot <syzbot+d41f74db64598e0b5016@syzkaller.appspotmail.com>
To: bristot@kernel.org, davem@davemloft.net, edumazet@google.com, 
	johannes@sipsolutions.net, juri.lelli@redhat.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, vineeth@bitbyteword.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aa486552a110 Merge tag 'memblock-v6.12-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ae0507980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c71bad3e6ab6955
dashboard link: https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170c659f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a7caa9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c6beec63de3/disk-aa486552.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fa35efb3dd39/vmlinux-aa486552.xz
kernel image: https://storage.googleapis.com/syzbot-assets/537d8ff45d85/bzImage-aa486552.xz

The issue was bisected to:

commit 5f6bd380c7bdbe10f7b4e8ddcceed60ce0714c6d
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon May 27 12:06:55 2024 +0000

    sched/rt: Remove default bandwidth control

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15684507980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17684507980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13684507980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d41f74db64598e0b5016@syzkaller.appspotmail.com
Fixes: 5f6bd380c7bd ("sched/rt: Remove default bandwidth control")

INFO: task kworker/1:1:46 blocked for more than 144 seconds.
      Not tainted 6.11.0-syzkaller-10622-gaa486552a110 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:24304 pid:46    tgid:46    ppid:2      flags:0x00004000
Workqueue: events_power_efficient crda_timeout_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 crda_timeout_work+0x15/0x50 net/wireless/reg.c:540
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/1:0/25:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6701


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

