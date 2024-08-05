Return-Path: <netdev+bounces-115663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2ED94765B
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 09:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6D91C2108C
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 07:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE9714A087;
	Mon,  5 Aug 2024 07:53:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C223149C60
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844414; cv=none; b=vDeqz1i/5OwqOXTnjKbP4bQt3E7x+vOP8CJLJ8i8yhvUfPwa3er/hG0BnjDnaoezGzNA0NC8hVx1NilZqgTRR7FTgWEstk7C4iMmVgMv3SQwFCHGdjfm5ShnbdnVJaqD11fGkbIGMynSSWyaxO5uUwij/Z0NsL7TzdLxzAlZJAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844414; c=relaxed/simple;
	bh=98f71b/+TER00xeT31L5EM3cGgGkGRXnqhXz2MjspKA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iIJPq48OSsdpPPM4yzrXK5L0q358qBg3yzVddyFMNBDkKQAtzJTrBwtG+PqhnFbhpi4e4XLOnpj+y5eaIW9zRVyE6cs+bO7A07RGbeYh0BGgC/H0CAyc4GimvX41u30X/SludO1BkGgPgSYMi8Gsg2tYyuguRiiO+88tceYKXm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3962d4671c7so155860215ab.2
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 00:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844412; x=1723449212;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZ4vjQ0bAntT8g7/oep15XgS1MZFp3uw9eyQ6xfQrWQ=;
        b=mdi1p1+ick2HmxqTu0ulDJdaXzjctRsTyUyKHkzpChD5kGBYwLeVglYDxEtNebEhZJ
         iWjEZNjQVg8lZ3vGZQVhkLfwvlVItOkzf5zjq1g1OG4W5JNfDYrUkpBOriPhPEzzpe9p
         rsBOEvYcuCTLPYprJDW5swc1S7WevhcSSyJRuWcwSYPI8fggewmq7pKq+mQN//yQmGTG
         YDYHQZGmjz0l7+hoi4KvVeU0pw7iupssvhqUD2ayX5Bc7GXZfQdu+FenLa0iv+QMz6H+
         QbPZhTGLCuT2uSdUaMeTCGZIUe57fKQ0+AUE3MdnxCIxgV7c5uf36+y3hR7d4xMf0ZGw
         iuHA==
X-Forwarded-Encrypted: i=1; AJvYcCUt+JeKIZdgeedMJwAPi+h7Q4k0bat2AGXKkee1j/zySzNpgznaGHjjJZu85i/fhvUdDLwrovTXsxli7WLPK95JaWMWsdTs
X-Gm-Message-State: AOJu0YwmUCl0eEsB+4ijL6/9UNI25+QPEI5sZHlh39r0HkgTjSf3tln3
	Mdr3Rbd9S5hrv4TrBXUb13mez1eO41B8m0LCyq3vpdCWrV0/v/pAYeGn5mOvW49DSlK/lVB/qi7
	2fwXjlk3d2Cm6p+ANNzOAUxaX/9+qXFbhWTdf3Zy9sKOOxjvMYGFUm/Y=
X-Google-Smtp-Source: AGHT+IEi9pv1Sbl4r7ktMOicU45sCOcRaKGUVK7MDJijq97Rnv9mgENWnYt2h6AWXf9FaC+NTm184Nb8YepZjNuj7HZk82y9KaWg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e8:b0:397:fa4e:3df0 with SMTP id
 e9e14a558f8ab-39b1fc3e8afmr8718275ab.3.1722844412316; Mon, 05 Aug 2024
 00:53:32 -0700 (PDT)
Date: Mon, 05 Aug 2024 00:53:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000331d30061eeaf927@google.com>
Subject: [syzbot] [kernel?] WARNING in hrtimer_forward (3)
From: syzbot <syzbot+41e4341f493f1155aa3d@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d650ab5e7d9 selftests/bpf: Fix a btf_dump selftest failure
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17e154d3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=41e4341f493f1155aa3d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/630e210de8d9/disk-3d650ab5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3576ca35748a/vmlinux-3d650ab5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5b33f099abfa/bzImage-3d650ab5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+41e4341f493f1155aa3d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 11474 at kernel/time/hrtimer.c:1048 hrtimer_forward+0x210/0x2d0 kernel/time/hrtimer.c:1048
Modules linked in:
CPU: 0 UID: 0 PID: 11474 Comm: syz.2.2194 Not tainted 6.10.0-syzkaller-12666-g3d650ab5e7d9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:hrtimer_forward+0x210/0x2d0 kernel/time/hrtimer.c:1048
Code: 00 49 89 1e 48 8b 04 24 eb 07 e8 bb e7 12 00 31 c0 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 a1 e7 12 00 90 <0f> 0b 90 eb e0 4c 89 f0 31 d2 49 f7 f4 48 89 04 24 49 89 c6 4d 0f
RSP: 0018:ffffc90000007bf8 EFLAGS: 00010246
RAX: ffffffff81809d7f RBX: 0000000000000001 RCX: ffff888026059e00
RDX: 0000000000000101 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 00000042facd7bc5 R08: ffffffff81809c13 R09: 1ffffffff26e4d1f
R10: dffffc0000000000 R11: ffffffff81358260 R12: 00000000061a8000
R13: ffff88807db07080 R14: 000000000044e132 R15: 1ffff1100fb60e0c
FS:  00007fa65d4636c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f478b2356c0 CR3: 000000005beac000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <IRQ>
 hrtimer_forward_now include/linux/hrtimer.h:355 [inline]
 mac80211_hwsim_beacon+0x192/0x1f0 drivers/net/wireless/virtual/mac80211_hwsim.c:2354
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x59b/0xd50 kernel/time/hrtimer.c:1753
 hrtimer_run_softirq+0x19a/0x2c0 kernel/time/hrtimer.c:1770
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5763
Code: 2b 00 74 08 4c 89 f7 e8 fa 43 8b 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc90013aef5c0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff9200275dec4 RCX: 087af4297aab3e00
RDX: dffffc0000000000 RSI: ffffffff8c0ae720 RDI: ffffffff8c606a20
RBP: ffffc90013aef718 R08: ffffffff937268ff R09: 1ffffffff26e4d1f
R10: dffffc0000000000 R11: fffffbfff26e4d20 R12: 1ffff9200275dec0
R13: dffffc0000000000 R14: ffffc90013aef620 R15: 0000000000000246
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 __mutex_unlock_slowpath+0x3c3/0x750 kernel/locking/mutex.c:937
 __static_call_update+0x38f/0x5e0 kernel/static_call_inline.c:209
 tracepoint_update_call kernel/tracepoint.c:317 [inline]
 tracepoint_add_func+0x918/0x9e0 kernel/tracepoint.c:358
 tracepoint_probe_register_prio kernel/tracepoint.c:511 [inline]
 tracepoint_probe_register+0x105/0x160 kernel/tracepoint.c:531
 perf_trace_event_reg kernel/trace/trace_event_perf.c:129 [inline]
 perf_trace_event_init+0x478/0x930 kernel/trace/trace_event_perf.c:202
 perf_trace_init+0x243/0x2e0 kernel/trace/trace_event_perf.c:226
 perf_tp_event_init+0x8d/0x110 kernel/events/core.c:10244
 perf_try_init_event+0x139/0x3f0 kernel/events/core.c:11719
 perf_init_event kernel/events/core.c:11789 [inline]
 perf_event_alloc+0x131a/0x22d0 kernel/events/core.c:12069
 __do_sys_perf_event_open kernel/events/core.c:12576 [inline]
 __se_sys_perf_event_open+0xb43/0x38d0 kernel/events/core.c:12467
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa65c7779f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa65d463048 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007fa65c905f80 RCX: 00007fa65c7779f9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000140
RBP: 00007fa65c7e58ee R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fa65c905f80 R15: 00007ffd6d5028f8
 </TASK>
----------------
Code disassembly (best guess):
   0:	2b 00                	sub    (%rax),%eax
   2:	74 08                	je     0xc
   4:	4c 89 f7             	mov    %r14,%rdi
   7:	e8 fa 43 8b 00       	call   0x8b4406
   c:	f6 44 24 61 02       	testb  $0x2,0x61(%rsp)
  11:	0f 85 85 01 00 00    	jne    0x19c
  17:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  1e:	74 01                	je     0x21
  20:	fb                   	sti
  21:	48 c7 44 24 40 0e 36 	movq   $0x45e0360e,0x40(%rsp)
  28:	e0 45
* 2a:	4b c7 44 25 00 00 00 	movq   $0x0,0x0(%r13,%r12,1) <-- trapping instruction
  31:	00 00
  33:	43 c7 44 25 09 00 00 	movl   $0x0,0x9(%r13,%r12,1)
  3a:	00 00
  3c:	43                   	rex.XB
  3d:	c7                   	.byte 0xc7
  3e:	44                   	rex.R
  3f:	25                   	.byte 0x25


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

