Return-Path: <netdev+bounces-246232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EBCCE6F9A
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 15:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 005603007FE0
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37522226D1E;
	Mon, 29 Dec 2025 14:09:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807811B6D08
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767017374; cv=none; b=Io5rPMdiudoTcAA0gEII+OKy3pAVUqSjtPNra5GI1V0lM1pSgqJ+rQVI+qToKhtkt27Wb7oC5opv26i/N0k0375CcYpJ+OP2C29HD9Nu85D5fEj+XwBGGQ9Bb1nP0FP4Kkh13k0b8G72tHGBMnmx2UsfYSwQ9JgffW9YrU6OvJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767017374; c=relaxed/simple;
	bh=JBmddtQ2wW9rHVi/KTtehcF8xeLzKpXc6MJk6zJGoNc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KIBwdKEdUUTnBHawxWnNKzfja+psQ6qe0J27dzutySs/FjmtkCj9LsFLqr32+dRHpO2N6attHSiZoTl2xKNqvQ90Ub3Dcq3al7NF+IFAlps+L2TtxuH08VDJb76jPfP01XuJ7mV+UQspqSIkfodDpyTnMDR5j477nuzmCJRnFrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6574d564a9eso16808394eaf.2
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 06:09:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767017371; x=1767622171;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VOvCZFX94Wy/FQexBTyZeQINiOCGQDsX01AhIlUm7WM=;
        b=hd4v+UjSjU5aaHQEBIWirPWBJ/SdVTBwjGh1I7/nnd1L4IWXfEQwyknqoxpZe/GMDx
         SBIpJQlEVFt6zk7PRRt0lGzmX+rJBLiPsrfikpm7XXhy7ArNZsyfhEYxGApzzbloaV0b
         U7tIXqj3GybfxnVnnFxxmUJj+Ca0ttx9x9Qji/XxnhtPJnLMK/F52A2Y1tSDIz12xm+K
         WiEiyrSnYERXl8DY/UhGEVc5DYxq07PaSFdwGcf/j9JkalYa5zC5hjkNgHGX516c+UMy
         azm4PjOm99MwPWWifuiJzQXUP/WVOyJQyJX0uGK2X02Mf0JW5KfNS3fLPNfYFcPTY+nY
         9oUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1sNynlW+abbfaKNhEajnPEExcwTZ/qEszo2ENKsbZeWZMuFlzn2/iOVcJzY/wsanwYgJ6z+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoQWlJRq/lKpTxowh0I9VaAae/08jI9xkQd7rq8v3nwFeu/fVA
	wH4l/QY9y3/owitmnUi600jBgkmPYWOt0HlCmFEJHOPWTG8ysz/TozKDOaPwb1CnG5AFQw+X/L7
	MqhKBHNOqd86Rtmq4RpM5xVdeWq0YLOazk18SvdfpHuNlRWcodvNUUWWAKvw=
X-Google-Smtp-Source: AGHT+IG8c6vO6aSbBMs19NszwBQCcgEzkEnKa0ihuu0Q+ReS2NWvK5EiAJ8rFROMVI4xZurVy/VnabguV9R5gVKwauEbE45f4OX8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2212:b0:659:9a49:9046 with SMTP id
 006d021491bc7-65d0e94d381mr13611673eaf.17.1767017371516; Mon, 29 Dec 2025
 06:09:31 -0800 (PST)
Date: Mon, 29 Dec 2025 06:09:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69528b9b.050a0220.329c0f.0417.GAE@google.com>
Subject: [syzbot] [net?] WARNING: locking bug in finish_task_switch (2)
From: syzbot <syzbot+fa2e2b8fd1b3f689d484@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ccd1cdca5cd4 Merge tag 'nfsd-6.19-1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1417109a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f2b6fe1fdf1a00b
dashboard link: https://syzkaller.appspot.com/bug?extid=fa2e2b8fd1b3f689d484
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7a2605cdbf37/disk-ccd1cdca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a90296b9771/vmlinux-ccd1cdca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/01272b1902ce/bzImage-ccd1cdca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa2e2b8fd1b3f689d484@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: kernel/locking/lockdep.c:238 at hlock_class kernel/locking/lockdep.c:238 [inline], CPU#0: ktimers/0/16
WARNING: kernel/locking/lockdep.c:238 at check_wait_context kernel/locking/lockdep.c:4879 [inline], CPU#0: ktimers/0/16
WARNING: kernel/locking/lockdep.c:238 at __lock_acquire+0x55a/0x2cf0 kernel/locking/lockdep.c:5187, CPU#0: ktimers/0/16
Modules linked in:
CPU: 0 UID: 0 PID: 16 Comm: ktimers/0 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:hlock_class kernel/locking/lockdep.c:238 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4879 [inline]
RIP: 0010:__lock_acquire+0x561/0x2cf0 kernel/locking/lockdep.c:5187
Code: 83 3d a2 bd 21 17 00 75 27 90 e8 ba 99 dd 02 85 c0 74 1c 83 3d c3 bd 3e 0d 00 75 13 48 8d 3d d6 c1 41 0d 48 c7 c6 ca 31 ee 8c <67> 48 0f b9 3a 90 31 c9 0f b6 81 c4 00 00 00 84 c0 0f 84 77 ff ff
RSP: 0018:ffffc900001571b0 EFLAGS: 00010046
RAX: 0000000000000001 RBX: ffff88801b6de760 RCX: ffff88801b6ddac0
RDX: 0000000000000100 RSI: ffffffff8cee31ca RDI: ffffffff8ede4890
RBP: ffff88801b6de768 R08: 0000000000000000 R09: 0000000000000100
R10: dffffc0000000000 R11: fffffbfff1db688f R12: 0000000000000003
R13: ffff88801b6de768 R14: ffff88801b6ddac0 R15: 0000000000000006
FS:  0000000000000000(0000) GS:ffff888126cef000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f617ff8 CR3: 0000000033f24000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 lock_acquire+0x107/0x340 kernel/locking/lockdep.c:5868
 finish_lock_switch kernel/sched/core.c:4993 [inline]
 finish_task_switch+0x177/0x940 kernel/sched/core.c:5112
 context_switch kernel/sched/core.c:5259 [inline]
 __schedule+0x1467/0x5070 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule_rtlock+0x30/0x70 kernel/sched/core.c:7024
 rtlock_slowlock_locked+0x3819/0x4010 kernel/locking/rtmutex.c:1868
 rtlock_slowlock kernel/locking/rtmutex.c:1895 [inline]
 rtlock_lock kernel/locking/spinlock_rt.c:43 [inline]
 __rt_spin_lock kernel/locking/spinlock_rt.c:49 [inline]
 rt_spin_lock+0x158/0x3e0 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 fq_pie_timer+0x190/0x5b0 net/sched/sch_fq_pie.c:397
 call_timer_fn+0x16e/0x590 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2373 [inline]
 __run_timer_base+0x648/0x970 kernel/time/timer.c:2385
 run_timer_base kernel/time/timer.c:2394 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2404
 handle_softirqs+0x1df/0x650 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 run_ktimerd+0x69/0x100 kernel/softirq.c:1138
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
----------------
Code disassembly (best guess):
   0:	83 3d a2 bd 21 17 00 	cmpl   $0x0,0x1721bda2(%rip)        # 0x1721bda9
   7:	75 27                	jne    0x30
   9:	90                   	nop
   a:	e8 ba 99 dd 02       	call   0x2dd99c9
   f:	85 c0                	test   %eax,%eax
  11:	74 1c                	je     0x2f
  13:	83 3d c3 bd 3e 0d 00 	cmpl   $0x0,0xd3ebdc3(%rip)        # 0xd3ebddd
  1a:	75 13                	jne    0x2f
  1c:	48 8d 3d d6 c1 41 0d 	lea    0xd41c1d6(%rip),%rdi        # 0xd41c1f9
  23:	48 c7 c6 ca 31 ee 8c 	mov    $0xffffffff8cee31ca,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	90                   	nop
  30:	31 c9                	xor    %ecx,%ecx
  32:	0f b6 81 c4 00 00 00 	movzbl 0xc4(%rcx),%eax
  39:	84 c0                	test   %al,%al
  3b:	0f                   	.byte 0xf
  3c:	84 77 ff             	test   %dh,-0x1(%rdi)
  3f:	ff                   	.byte 0xff


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

