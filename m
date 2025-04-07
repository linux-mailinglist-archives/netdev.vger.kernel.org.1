Return-Path: <netdev+bounces-179611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B13A7DD6E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5CA188B112
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FD524E01F;
	Mon,  7 Apr 2025 12:12:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D59324E014
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744027947; cv=none; b=l6agZ/3SJRYFVVtUiueIbjbif0vaTVJwAcvYpDFKDTHB+xXj2X2WwVL+BY5obWmykcrO+GAoOBbEN5EjGLHsYt0P/A55fGiqZPT3gT/TonkbFBr/VIzceJrB4cL0BybbsKXeMqF9wCOkXYM9y7l6xgIdTHhPYdlsgaPTYUVdIc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744027947; c=relaxed/simple;
	bh=JM8bcgmFvSjE+4oVjYG+DDsuNpUJvzbvA+QreWwAcI4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Svm4Yet9jooxdEwqgG2GFVljc64a/5t3Lb3qWQAE4x0rlDnfWoeZQkDvW26hauXFxhABHvuywimnqxhT+XG6o9UD9RZfOMkCkL1arz2lzoHIzkS0gajgMjlgsN9qbDYAUG8tQNsFguJt6Z+SMMhsfNhb5Egm5s8d0E4HwVAsx/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-85b402f69d4so429813339f.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 05:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744027945; x=1744632745;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=39rzYLbyRA0XbeEFzfZRxovGuCqjIyzpwm7iw9NJxXY=;
        b=ZdHJ+SHsNSebPLOjtQBIrAqUTftiYqzw0/8qDmqSdmNSyC6rzE2pmYdYMP4Xi72/Mm
         E0eWxPZoAS/Co6irkafc2YW5RD2LmgRDjTLuKfxLKsVI6vvBs4Q00lEcUsKQQ9FafX3w
         eKgpF4IjnYAVaEWpEO79XOANWQ8Uk7aXtCuuweMKovwN2ZfsaZFhGusAuhoUkjXFk8lT
         FKXTxLUvcrjdkGvttGx0EF/B6ekS7/1MR5l7KfPugeZJD9ra8kBs7z7ZgxpO5QKYKnPI
         MZb8LyFCrm+maRsA8TT25cp/VlIfa1Z+jbBDLu7u8b1j3G47sOTDpH/FY/tP/ho20o9y
         Gt9g==
X-Forwarded-Encrypted: i=1; AJvYcCU7iKTqJJgDeHBRgc+FhtguwigcCHj6n2lo/qiTVdE/JDKdmmVA1cEiBvL9Xq1xqoHlA+mlJfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxthQIyHfJZXeUQ3cyZ11w0ghwivf6fsEl5wIjT6n+u5bezI3OL
	0Kr2BswGGXZR9j60llJmjgOhfcMVFkxf0BGR/iH7ijSSf4oglHND5I3W5Qmp9ynOv/G3YA5f0B5
	ziKPTPyO2KBeRtIknS8MBZeTjREq5njGfaWs+NzfWKi/IvRXJTqTOt1c=
X-Google-Smtp-Source: AGHT+IH/sQYargxhNszMsKXjelkLl0r9VSiw1P3K9FFxLfUjVRMCFaViDb2DQ5eE+Js+VQH3uxVlIjAR+ZcuDB4hhWPNd3AJUTV2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1846:b0:3d5:890b:d9df with SMTP id
 e9e14a558f8ab-3d6e3f73e25mr132004245ab.15.1744027945033; Mon, 07 Apr 2025
 05:12:25 -0700 (PDT)
Date: Mon, 07 Apr 2025 05:12:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f3c129.050a0220.107db6.0593.GAE@google.com>
Subject: [syzbot] [kernel?] BUG: soft lockup in cfg80211_wext_siwfreq
From: syzbot <syzbot+b6fabe77c2559522cbd7@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1e7857b28020 x86: don't re-generate cpufeaturemasks.h so e..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1606094c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8721be6a767792
dashboard link: https://syzkaller.appspot.com/bug?extid=b6fabe77c2559522cbd7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8ae0388d997b/disk-1e7857b2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f7f7867e1cb/vmlinux-1e7857b2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dc428f20aac5/bzImage-1e7857b2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6fabe77c2559522cbd7@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 144s! [syz.0.44:6093]
Modules linked in:
irq event stamp: 31919317
hardirqs last  enabled at (31919316): [<ffffffff81844f49>] handle_softirqs+0x1e9/0x9b0 kernel/softirq.c:563
hardirqs last disabled at (31919317): [<ffffffff8c2dab0e>] sysvec_apic_timer_interrupt+0xe/0xc0 arch/x86/kernel/apic/apic.c:1049
softirqs last  enabled at (31919312): [<ffffffff8184596b>] __do_softirq kernel/softirq.c:613 [inline]
softirqs last  enabled at (31919312): [<ffffffff8184596b>] invoke_softirq kernel/softirq.c:453 [inline]
softirqs last  enabled at (31919312): [<ffffffff8184596b>] __irq_exit_rcu+0xfb/0x220 kernel/softirq.c:680
softirqs last disabled at (31919315): [<ffffffff8184596b>] __do_softirq kernel/softirq.c:613 [inline]
softirqs last disabled at (31919315): [<ffffffff8184596b>] invoke_softirq kernel/softirq.c:453 [inline]
softirqs last disabled at (31919315): [<ffffffff8184596b>] __irq_exit_rcu+0xfb/0x220 kernel/softirq.c:680
CPU: 0 UID: 0 PID: 6093 Comm: syz.0.44 Not tainted 6.14.0-syzkaller-g1e7857b28020 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:kasan_check_range+0x1ba/0x2a0 mm/kasan/generic.c:189
Code: fb 48 8d 5d 07 48 85 ed 48 0f 49 dd 48 83 e3 f8 48 29 dd 74 12 41 80 3b 00 0f 85 b3 00 00 00 49 ff c3 48 ff cd 75 ee 5b 41 5c <41> 5e 41 5f 5d c3 cc cc cc cc 40 84 ed 75 61 f7 c5 00 ff 00 00 75
RSP: 0018:ffffc90000007a78 EFLAGS: 00000256
RAX: 1ffff92000000f01 RBX: ffffffff81a77055 RCX: ffffffff81a77055
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffc90000007b00
RBP: 0000000000000000 R08: ffffc90000007b07 R09: 1ffff92000000f60
R10: dffffc0000000000 R11: fffff52000000f61 R12: 0000000000000008
R13: dffffc0000000000 R14: dffffc0000000001 R15: fffff52000000f61
FS:  00007f78f9e696c0(0000) GS:ffff888124faf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff8d15feff0 CR3: 0000000035462000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 __bpf_trace_rcu_utilization+0xd5/0x140 include/trace/events/rcu.h:27
 __do_trace_rcu_utilization include/trace/events/rcu.h:27 [inline]
 trace_rcu_utilization+0x1b4/0x1e0 include/trace/events/rcu.h:27
 rcu_core+0x135/0x17a0 kernel/rcu/tree.c:2796
 handle_softirqs+0x2d6/0x9b0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xfb/0x220 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_irq_work arch/x86/kernel/irq_work.c:17 [inline]
 sysvec_irq_work+0xa3/0xc0 arch/x86/kernel/irq_work.c:17
 </IRQ>
 <TASK>
 asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:738
RIP: 0010:rcu_read_unlock_special+0x8a/0x570 kernel/rcu/tree_plugin.h:694
Code: f1 f1 f1 00 f2 f2 f2 49 89 04 14 66 41 c7 44 14 09 f3 f3 41 c6 44 14 0b f3 65 44 8b 3d af 84 bd 11 41 f7 c7 00 00 f0 00 74 44 <48> c7 44 24 20 0e 36 e0 45 4a c7 04 22 00 00 00 00 66 42 c7 44 22
RSP: 0018:ffffc90004be70a0 EFLAGS: 00000206
RAX: 337b379826375900 RBX: 1ffff9200097ce1c RCX: ffffffff93671020
RDX: dffffc0000000000 RSI: ffffffff8e691f31 RDI: ffffffff8ca184c0
RBP: ffffc90004be7180 R08: ffffffff905f5377 R09: 1ffffffff20bea6e
R10: dffffc0000000000 R11: fffffbfff20bea6f R12: 1ffff9200097ce18
R13: ffff8880262ec060 R14: ffffc90004be70e0 R15: ffffffff8ed40300
 __rcu_read_unlock+0xa1/0x110 kernel/rcu/tree_plugin.h:438
 rcu_read_unlock include/linux/rcupdate.h:873 [inline]
 class_rcu_destructor include/linux/rcupdate.h:1155 [inline]
 unwind_next_frame+0x1aa4/0x23b0 arch/x86/kernel/unwind_orc.c:680
 arch_stack_walk+0x11e/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x11a/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbf/0xd0 mm/kasan/generic.c:548
 __call_rcu_common kernel/rcu/tree.c:3082 [inline]
 call_rcu+0x172/0xad0 kernel/rcu/tree.c:3202
 __dentry_kill+0x497/0x630 fs/dcache.c:679
 dput+0x19f/0x2b0 fs/dcache.c:902
 find_next_child fs/libfs.c:603 [inline]
 simple_recursive_removal+0x2bd/0x8f0 fs/libfs.c:618
 debugfs_remove+0x49/0x70 fs/debugfs/inode.c:805
 ieee80211_sta_debugfs_remove+0x40/0x60 net/mac80211/debugfs_sta.c:1285
 __sta_info_destroy_part2+0x35e/0x450 net/mac80211/sta_info.c:1508
 __sta_info_flush+0x5ee/0x720 net/mac80211/sta_info.c:1640
 sta_info_flush net/mac80211/sta_info.h:927 [inline]
 ieee80211_ibss_disconnect+0x2c7/0x7c0 net/mac80211/ibss.c:686
 ieee80211_ibss_leave+0x4a/0x150 net/mac80211/ibss.c:1831
 rdev_leave_ibss net/wireless/rdev-ops.h:574 [inline]
 cfg80211_leave_ibss+0x1ef/0x430 net/wireless/ibss.c:203
 cfg80211_ibss_wext_siwfreq+0x1ef/0x310 net/wireless/ibss.c:321
 cfg80211_wext_siwfreq+0x220/0x870 net/wireless/wext-compat.c:781
 ioctl_standard_call+0xda/0x190 net/wireless/wext-core.c:1043
 wireless_process_ioctl net/wireless/wext-core.c:-1 [inline]
 wext_ioctl_dispatch+0xe4/0x410 net/wireless/wext-core.c:1014
 wext_handle_ioctl+0x15a/0x260 net/wireless/wext-core.c:1075
 sock_ioctl+0x181/0x900 net/socket.c:1243
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f78f8f8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f78f9e69038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f78f91a5fa0 RCX: 00007f78f8f8d169
RDX: 0000200000000040 RSI: 0000000000008b04 RDI: 000000000000000c
RBP: 00007f78f900e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f78f91a5fa0 R15: 00007ffd5dcefa88
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 1036 Comm: kworker/u8:5 Not tainted 6.14.0-syzkaller-g1e7857b28020 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:csd_lock_wait kernel/smp.c:340 [inline]
RIP: 0010:smp_call_function_many_cond+0x1bac/0x2d40 kernel/smp.c:885
Code: 03 84 c0 75 7e 45 8b 65 00 44 89 e6 83 e6 01 31 ff e8 58 02 0c 00 41 83 e4 01 4c 8b 64 24 68 75 07 e8 08 fe 0b 00 eb 41 f3 90 <48> b8 00 00 00 00 00 fc ff df 0f b6 04 03 84 c0 75 11 41 f7 45 00
RSP: 0018:ffffc90003cb7640 EFLAGS: 00000293
RAX: ffffffff81b780bd RBX: 1ffff110170c823d RCX: ffff888027071e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90003cb7840 R08: ffffffff81b78088 R09: 1ffffffff20bea6e
R10: dffffc0000000000 R11: fffffbfff20bea6f R12: ffff8880b873ad08
R13: ffff8880b86411e8 R14: ffff8880b873ad00 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881250af000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc34b52000 CR3: 000000000eb38000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1052
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2455 [inline]
 text_poke_bp_batch+0x354/0xb30 arch/x86/kernel/alternative.c:2665
 text_poke_flush arch/x86/kernel/alternative.c:2856 [inline]
 text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2863
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_enable_cpuslocked+0x136/0x260 kernel/jump_label.c:210
 static_key_enable+0x1a/0x20 kernel/jump_label.c:223
 toggle_allocation_gate+0xc0/0x250 mm/kfence/core.c:850
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
 worker_thread+0x870/0xd50 kernel/workqueue.c:3400
 kthread+0x7b7/0x940 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

