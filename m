Return-Path: <netdev+bounces-130050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 328F8987D55
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 05:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90973B23D5A
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 03:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8009016DC36;
	Fri, 27 Sep 2024 03:52:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0BDD53C
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 03:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727409142; cv=none; b=geoVtgBr3OKxyw4zjCLgVVKVF6vWEDhR8wlSYm3COgUXzl56sxp5UTIib011iK3NdWj98afXbZG6R2wYJmcx6GXyGV2E2PCsO1XPusAm2d3MGhw/g1JM8KZU9wdoCfVEBU5+nHSvmzwX0I0Nn+kE+z0ftQlHV+9ruEfcGK+t2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727409142; c=relaxed/simple;
	bh=tijYP/eR2PHioC3KgAgMi4QXGnwkmGd0Dgeb/FN19k0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hcSv2CPKes8DzHxJkJeMsOlpD3dOc4JHIRAnEl7x2VBZDseKa+5zkW3jW0D7kuqth2qlB7D+ElpGKu2Jm+0+BzzQe9fHXuNSS0dHSU3tpOzm/a+Nvd9cQxSkcXGQCv0jtdWyTG5kUFRWJkuk4pZH/JrBc7Y2wQeeQaCwheJ6Zos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a345a02c23so4388665ab.1
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 20:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727409140; x=1728013940;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3auWreLAZ73QzV0Lv0K1wMlu78NrY1VI+H7gTuEZZNg=;
        b=NP0/YFe94oBBKdBNxFZ2URN7J26FkQiHSS//sr6c/XtHAasL0QnzWdsB7KBTK9D58e
         DFL/13L/h8Tw1rHkgBUbrPWdfBpVm6lTfNGRpZbC15BEineDzKTORXbhKwXreP0Abj5d
         4YloDhqWyfbOb/FGIOH4hQBxgD+rUFOJksMVGNZkUYFEkfDlq0KOW/LPE43teWBUYWKj
         kttFM4AcUJz7kGZcMxN4vPTNKa+2dCdULdN+rkKwra5GX//j6B7Pm4Yq2J6KFfiwXHam
         wJrZ6gwaaW68drw4VWkQVsi6+tO7KZAo38MdZR+JuPIja71R2eEmg0Vikv5Zf0rxHEs+
         tT4w==
X-Forwarded-Encrypted: i=1; AJvYcCXmUGWKmrs6ngQeHFxyDsRAeDbn/r5yLK8d8SMW+2x/iovyQbn2+MgOAelqG38vTtc90vMQmeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp1UrMJCXUMD745PJxyR6UjQCwT8A7aQp0DDHbwLqjeQtSg8Xt
	+qB5J7AAnuoRZdZR76zX6cVplaLLYX6P33Q7TUpK+bCvkZ1LCn2Lv/8rru1tTKl7Ib2+ZmUGOnk
	7GQvmA6oJfeiOawzLnI15qcMkRieLN2VbvJRmio8jZIavnVb6M9mF7pM=
X-Google-Smtp-Source: AGHT+IE/eMe8L5X79DJcyc3g++cEfn8GM0JPpB9NtO+cctnAc2JcrwKhO3x5h2Ylk2bpVDbMqAZ8cGNF4hg6MH0vGn+lnXTetJZ0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4a:0:b0:3a0:915d:a4a7 with SMTP id
 e9e14a558f8ab-3a34514832bmr16835235ab.2.1727409140018; Thu, 26 Sep 2024
 20:52:20 -0700 (PDT)
Date: Thu, 26 Sep 2024 20:52:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f62bf3.050a0220.38ace9.0007.GAE@google.com>
Subject: [syzbot] [bpf?] BUG: MAX_STACK_TRACE_ENTRIES too low! (4)
From: syzbot <syzbot+c6c4861455fdd207f160@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    abf2050f51fd Merge tag 'media/v6.12-1' of git://git.kernel..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=100fc99f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc30a30374b0753
dashboard link: https://syzkaller.appspot.com/bug?extid=c6c4861455fdd207f160
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ee7107980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/367fc75d0a34/disk-abf2050f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8df13e2678de/vmlinux-abf2050f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/138b13f7dbdb/bzImage-abf2050f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6c4861455fdd207f160@syzkaller.appspotmail.com

BUG: MAX_STACK_TRACE_ENTRIES too low!
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.11.0-syzkaller-09959-gabf2050f51fd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 save_trace+0x926/0xb50 kernel/locking/lockdep.c:579
 check_prev_add kernel/locking/lockdep.c:3219 [inline]
 check_prevs_add kernel/locking/lockdep.c:3277 [inline]
 validate_chain+0x2bde/0x5920 kernel/locking/lockdep.c:3901
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 htab_lock_bucket+0x1a4/0x370 kernel/bpf/hashtab.c:167
 htab_map_delete_elem+0x1df/0x6b0 kernel/bpf/hashtab.c:1430
 bpf_prog_bc20a984d57ef3f1+0x67/0x6b
 bpf_dispatcher_nop_func include/linux/bpf.h:1257 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2318 [inline]
 bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2359
 __traceiter_kfree+0x2b/0x50 include/trace/events/kmem.h:94
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x35e/0x440 mm/slub.c:4715
 security_task_free+0xa4/0x1a0 security/security.c:3178
 __put_task_struct+0xf9/0x290 kernel/fork.c:977
 put_task_struct include/linux/sched/task.h:144 [inline]
 delayed_put_task_struct+0x125/0x300 kernel/exit.c:228
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:927
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
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

