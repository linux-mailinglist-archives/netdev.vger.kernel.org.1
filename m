Return-Path: <netdev+bounces-232838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E52C092AE
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 17:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5DF41B271B5
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 15:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF42030274B;
	Sat, 25 Oct 2025 15:30:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DF3302CAA
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761406234; cv=none; b=MXRpQVo/oATPxzMgsujqqRT7YJwlDltClO/r4FPudyF6iTdyHuRHI9VT4/q5cATKcdxtl6mKk6WeETx8VVFulCD60Y80UbpockSiZA8wb6FAbrxoH8L87CksCejVKzamuClvTSrCnsH/NYGXgD3pqOz1+E1oNBMIl85J0mN1jdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761406234; c=relaxed/simple;
	bh=tuqhXV1Da6wCZ0InK2dIqD7W5pd/2Xgd2oEnAJ9E7QA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kGWLyeAtOwKJ91UTgnCDo0qqNa+DBwQh7JaxMOU46XMzPjWYpgq0vHfzT8F2zpDCzUQ6o9cieWd2Xsosw4bh6giHWJkTg0UcV0Dpe7VvZZuTi5LaP5Nw3BU8vN3ua1NZKYEEwaNI1LYIPiH8T8UwohUQoNkdD7rk181e+bCHq9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-886e347d2afso323953939f.3
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 08:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761406232; x=1762011032;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4PtvkKZFEBjpaVtmYMgaiUP0rE5WRgcuVuHYkk41Is=;
        b=OblzVLtrXuVLqcjqUQN7wph4GrZURFYm28Xry7lRY9uET+7u+weP39J2RASgFXnw4F
         XcWenuv+Qsqg3a+HlgulzzLoORvD+UdrAOaLDGymysNdeiHXLpq5A7k58ACWKJwl3FUo
         BzdgdlUl+17vcJmkZZLMDE2P3cJpKRcBBmnP6OKE5lmE0jFMmJp9MjgiikZHi2u0sqtf
         9M3TeakVcJX/n81okDvQPSPjhJvJ4g3EjEG8pMUZEYU6PR+JXpRx9DZl93c//IiV5uoY
         ucoAzLguvOZRrN96wLeFRVYZaYL5LZNfKO42R9robbs92Pk9C6K7GmiL5SSFRJtSnm2l
         /66Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqo2LcJXLwwtZmQGIe89kR57KYFHFee1UfIRaVM1WSbKlvWrd+s0dfoD2bfBFuu03sa8bcf24=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTDYNvYBcoX03YOEckXqYF76rkmxNFxt5t6oi9Np76vrBkxufb
	iWbZzYQH2I+YPJRCQxsTCamDhzAvTkY1iw0dnd/7tLOl30Ia6s6AP7kDkPiVjHq+Sfcw8Xyj6+Y
	sKcCZi6SrkMSs/LazbKiuIoSVdLEY30kSAXHQJY5h6I3HrGfEeZZgGBBo6/k=
X-Google-Smtp-Source: AGHT+IE/mS5AInx/Fn2GfpldYfqwHT1aTDzL70mL7vQ4auUZniXaqCBaITtE4KGxBTh882iPv4MheVT5dy2uy9HDIpuf7K+7ITIw
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4d:0:b0:430:b05a:ecc3 with SMTP id
 e9e14a558f8ab-430c525f52amr239057035ab.9.1761406232302; Sat, 25 Oct 2025
 08:30:32 -0700 (PDT)
Date: Sat, 25 Oct 2025 08:30:32 -0700
In-Reply-To: <68087f2f.050a0220.dd94f.0177.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fced18.050a0220.1e563d.00cd.GAE@google.com>
Subject: Re: [syzbot] [mm?] BUG: soft lockup in sys_bpf
From: syzbot <syzbot+9431dc0c0741cff46a99@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	da.gomez@samsung.com, david@redhat.com, gourry@gourry.net, 
	joshua.hahnjy@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, matthew.brost@intel.com, mcgrof@kernel.org, 
	netdev@vger.kernel.org, petr.pavlu@suse.com, rakie.kim@sk.com, 
	samitolvanen@google.com, syzkaller-bugs@googlegroups.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    566771afc7a8 Merge tag 'v6.18-rc2-smb-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c8ee7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8345ce4ce316ca28
dashboard link: https://syzkaller.appspot.com/bug?extid=9431dc0c0741cff46a99
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157013cd980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130cc7e2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/52417ef1f782/disk-566771af.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/66730a263bf1/vmlinux-566771af.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1fe0762efb1f/bzImage-566771af.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9431dc0c0741cff46a99@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5823
rcu: 	(detected by 1, t=10502 jiffies, g=8989, q=37467 ncpus=2)
task:syz-executor333 state:R  running task     stack:24744 pid:5823  tgid:5823  ppid:5816   task_flags:0x400140 flags:0x00080001
Call Trace:
 <IRQ>
 sched_show_task+0x49d/0x630 kernel/sched/core.c:7901
 rcu_print_detail_task_stall_rnp kernel/rcu/tree_stall.h:292 [inline]
 print_other_cpu_stall+0xf78/0x1340 kernel/rcu/tree_stall.h:681
 check_cpu_stall kernel/rcu/tree_stall.h:857 [inline]
 rcu_pending kernel/rcu/tree.c:3671 [inline]
 rcu_sched_clock_irq+0xa47/0x11b0 kernel/rcu/tree.c:2706
 update_process_times+0x235/0x2d0 kernel/time/timer.c:2473
 tick_sched_handle kernel/time/tick-sched.c:276 [inline]
 tick_nohz_handler+0x39a/0x520 kernel/time/tick-sched.c:297
 __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
 __hrtimer_run_queues+0x506/0xd40 kernel/time/hrtimer.c:1841
 hrtimer_interrupt+0x45d/0xa90 kernel/time/hrtimer.c:1903
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
 __sysvec_apic_timer_interrupt+0x10b/0x410 arch/x86/kernel/apic/apic.c:1058
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1052
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:instrument_atomic_read include/linux/instrumented.h:68 [inline]
RIP: 0010:_test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
RIP: 0010:get_page_from_freelist+0x459/0x2960 mm/page_alloc.c:3824
Code: 8c 0d 00 48 8b 74 24 18 49 b8 00 00 00 00 00 fc ff df 48 8b 03 48 39 d8 0f 84 7e 07 00 00 48 8b 44 24 08 4c 8d a0 38 06 00 00 <4c> 89 e7 be 08 00 00 00 e8 ba 8e 0d 00 48 b9 00 00 00 00 00 fc ff
RSP: 0018:ffffc90004c97158 EFLAGS: 00000206
RAX: ffff88823fff8740 RBX: ffff88823fffc888 RCX: dffffc0000000000
RDX: 0000000000000001 RSI: ffff88813fffdf70 RDI: ffff88813fffdf70
RBP: 0000000000000000 R08: dffffc0000000000 R09: 1ffff11027fff7da
R10: dffffc0000000000 R11: ffffed1027fff7db R12: ffff88823fff8d78
R13: 0000000000000830 R14: ffffc90004c97448 R15: ffffc90004c9745c
 __alloc_pages_slowpath+0x33b/0xe50 mm/page_alloc.c:4714
 __alloc_frozen_pages_noprof+0x319/0x370 mm/page_alloc.c:5196
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3055 [inline]
 allocate_slab+0x96/0x350 mm/slub.c:3228
 new_slab mm/slub.c:3282 [inline]
 ___slab_alloc+0xb12/0x13f0 mm/slub.c:4651
 __slab_alloc+0xc6/0x1f0 mm/slub.c:4770
 __slab_alloc_node mm/slub.c:4846 [inline]
 slab_alloc_node mm/slub.c:5268 [inline]
 kmem_cache_alloc_noprof+0xec/0x6b0 mm/slub.c:5287
 skb_clone+0x212/0x3a0 net/core/skbuff.c:2050
 ____bpf_clone_redirect net/core/filter.c:2465 [inline]
 bpf_clone_redirect+0xad/0x3d0 net/core/filter.c:2450
 bpf_prog_3e1cbbed0c4acd81+0x5f/0x68
 bpf_dispatcher_nop_func include/linux/bpf.h:1350 [inline]
 __bpf_prog_run include/linux/filter.h:721 [inline]
 bpf_prog_run include/linux/filter.h:728 [inline]
 bpf_test_run+0x313/0x7a0 net/bpf/test_run.c:423
 bpf_prog_test_run_skb+0xb4e/0x1550 net/bpf/test_run.c:1091
 bpf_prog_test_run+0x2cd/0x340 kernel/bpf/syscall.c:4688
 __sys_bpf+0x562/0x860 kernel/bpf/syscall.c:6167
 __do_sys_bpf kernel/bpf/syscall.c:6259 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6257 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6257
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0d40505cb9
Code: Unable to access opcode bytes at 0x7f0d40505c8f.
RSP: 002b:00007fff9d9b3ed8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0d40505cb9
RDX: 0000000000000050 RSI: 00002000000000c0 RDI: 000000000000000a
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

