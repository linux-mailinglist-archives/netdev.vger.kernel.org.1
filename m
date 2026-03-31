Return-Path: <netdev+bounces-273736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBVyC0QezGnHPgYAu9opvQ
	(envelope-from <netdev+bounces-273736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 21:19:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C17B43707D8
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 21:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50FBE30458FE
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BF73A5E83;
	Tue, 31 Mar 2026 19:19:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDF2331209
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 19:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984767; cv=none; b=oHdsxsEGh6z5M/BcSiF1iIC3gvx8lKqJi2xTF4ewejpko2xgGJByi2Imu2eQ1HIxF7WW0GxZndN/OocQQKBJgXKd9tcLAiZkrKevC0Eyjz8YdExr0W7AC01HbU09c8bVowX0aNmLJfVSsVtJwn+6ItDfoDsZaGoNNsAN511wlCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984767; c=relaxed/simple;
	bh=gaIZJecD7ma60cDpNZKqVnMxQqcmWQuqpTGy/dbBo44=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=X3YVp8cmqj13qKpngatbZ3ZIwDziSSQFnbJbG8hGJWg3K/2VKNHQ9NCakDdVsjjW8zDM/gx6l1wZfOGCEUt2nCLRSUs/UwuI3ze6HK1XKRCPrb3KibIlEv6m0vwGD2UD3/VSBvlG6hhL8hD/u3qB4bqoMpfz1jdmj704+UQ5ioU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7d7510702e6so16794325a34.3
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 12:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774984765; x=1775589565;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LY/R9mURx+pPbug2NJHiluq/tfa+Bf+Yd4kZ80ndOrQ=;
        b=qiIddjHJJB/O8eMBStmQkquklbmwARcSSgG8SGbvfyn6DLATalMUuZ06Bs90lBXIaX
         2wwce5TI3pwStfaJ5f1sUPv3CRgC8jvfG0GDRmkCJlPWItstXKV60GlScdDAEgLNoNw2
         n/nDRVQQwIp5HjxwoM4C4LKtxaJl2duSCe+RcQueOuDEQ/VW9OtJGNwp2QG/92yRyAEW
         YpuUNirOtl+BLeIzlB64yPQM6C9UPU1BtGa2dAEI3d8cK0aB+J5/ii0uebfcCih51BHF
         xMbyFM/5LRzYvaJRRKSU1yy6WbDcHLOv/sgwv5bLNgKVSkC1HtYpxPlC/rhc38r7/f1z
         H8XA==
X-Forwarded-Encrypted: i=1; AJvYcCUdTW9LuKlTnCQLbqInxU6S4F6v/o5WMWMUMKQeevy23nFAzHsSqbclB5G8Bj+SXRgnl4OPvkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0mGd1BS1S68fx9QXc+s5cFfyzpmUgJxvX4NIWW3+ewzyGNwqa
	nWX1nbQXtGFayoZGaRBm6AmGmbNS64tpFBRLmNsUO9B52TbywybEd5H6R1qUDye6hps49rJeQ1z
	g3xoJGw+LhHgHy38MSJ9WclNgupe/JERIguofWPcgf/5AtmRA/YQacAQL0y8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b90:b0:67e:438d:f688 with SMTP id
 006d021491bc7-67fabd020f3mr273884eaf.49.1774984764934; Tue, 31 Mar 2026
 12:19:24 -0700 (PDT)
Date: Tue, 31 Mar 2026 12:19:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cc1e3c.050a0220.183828.0031.GAE@google.com>
Subject: [syzbot] [hams?] KASAN: slab-use-after-free Read in ax25cmp (2)
From: syzbot <syzbot+abd2b69348e2d9b107a1@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=5a3e5e8c17cc174e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-273736-lists,netdev=lfdr.de,abd2b69348e2d9b107a1];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,storage.googleapis.com:url,appspotmail.com:email,googlegroups.com:email,goo.gl:url]
X-Rspamd-Queue-Id: C17B43707D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    7aaa8047eafd Linux 7.0-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f71a48580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a3e5e8c17cc174e
dashboard link: https://syzkaller.appspot.com/bug?extid=abd2b69348e2d9b107a1
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4e96235a659c/disk-7aaa8047.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2dbf138efd1a/vmlinux-7aaa8047.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c0528de45bad/bzImage-7aaa8047.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+abd2b69348e2d9b107a1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in ax25cmp+0x17b/0x1d0 net/ax25/ax25_addr.c:119
Read of size 1 at addr ffff8880589bdc08 by task syz-executor/30916

CPU: 1 UID: 0 PID: 30916 Comm: syz-executor Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x156/0x4c9 mm/kasan/report.c:482
 kasan_report+0xdf/0x1e0 mm/kasan/report.c:595
 ax25cmp+0x17b/0x1d0 net/ax25/ax25_addr.c:119
 ax25_find_cb+0x142/0x410 net/ax25/af_ax25.c:236
 ax25_send_frame+0x157/0xb70 net/ax25/ax25_out.c:55
 rose_send_frame+0xfa/0x2a0 net/rose/rose_link.c:106
 rose_transmit_restart_request+0x1b8/0x250 net/rose/rose_link.c:198
 rose_t0timer_expiry+0x1d/0x150 net/rose/rose_link.c:83
 call_timer_fn+0x19a/0x670 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers+0x757/0xb30 kernel/time/timer.c:2373
 __run_timer_base kernel/time/timer.c:2385 [inline]
 __run_timer_base kernel/time/timer.c:2377 [inline]
 run_timer_base+0x114/0x190 kernel/time/timer.c:2394
 run_timer_softirq+0x1a/0x50 kernel/time/timer.c:2404
 handle_softirqs+0x1eb/0x9e0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xef/0x150 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1056
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:preempt_schedule_irq+0x4b/0x90 kernel/sched/core.c:7238
Code: 00 00 00 fc ff df 48 89 eb 48 c1 eb 03 48 01 d3 f6 c4 02 75 47 bf 01 00 00 00 e8 80 b8 43 f6 e8 3b ce 7e f6 fb bf 01 00 00 00 <e8> e0 96 ff ff 9c 58 fa f6 c4 02 75 1e bf 01 00 00 00 e8 9e 56 43
RSP: 0018:ffffc90002ea7838 EFLAGS: 00000202
RAX: 0000000000051bfd RBX: ffffed101344f000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8de79d93 RDI: 0000000000000001
RBP: ffff88809a278000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 irqentry_exit+0x17b/0x670 kernel/entry/common.c:239
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x5e/0x380 kernel/locking/lockdep.c:5872
Code: 05 bb 36 29 12 83 f8 07 0f 87 f0 00 00 00 48 0f a3 05 86 bc f4 0e 0f 82 c2 02 00 00 8b 35 6e f0 f4 0e 85 f6 0f 85 dd 00 00 00 <48> 8b 44 24 30 65 48 2b 05 5d 36 29 12 0f 85 02 03 00 00 48 83 c4
RSP: 0018:ffffc90002ea7938 EFLAGS: 00000206
RAX: 0000000000000046 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8de53c03 RDI: ffffffff8c1b1a20
RBP: ffffffff8e7e7920 R08: 0000000086db7919 R09: 0000000000000007
R10: 0000000000000200 R11: 0000000000000000 R12: 0000000000000002
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 rcu_read_lock include/linux/rcupdate.h:850 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1193 [inline]
 unwind_next_frame+0xd1/0x1ea0 arch/x86/kernel/unwind_orc.c:495
 arch_stack_walk+0x94/0xf0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4538 [inline]
 slab_alloc_node mm/slub.c:4866 [inline]
 kmem_cache_alloc_noprof+0x241/0x6e0 mm/slub.c:4873
 alloc_filename fs/namei.c:142 [inline]
 do_getname+0x35/0x390 fs/namei.c:182
 getname_flags fs/namei.c:225 [inline]
 class_filename_flags_constructor include/linux/fs.h:2541 [inline]
 user_path_at+0x26/0x60 fs/namei.c:3617
 ksys_umount fs/namespace.c:2062 [inline]
 __do_sys_umount fs/namespace.c:2070 [inline]
 __se_sys_umount fs/namespace.c:2068 [inline]
 __x64_sys_umount+0x10a/0x1a0 fs/namespace.c:2068
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f502359da57
Code: a2 c7 05 9c fc 24 00 00 00 00 00 eb 96 e8 e1 12 00 00 90 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffc8bc59ed8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 00007f5023632048 RCX: 00007f502359da57
RDX: 0000000000000004 RSI: 0000000000000009 RDI: 00007ffc8bc5b020
RBP: 00007ffc8bc5b00c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc8bc5b020
R13: 00007f5023632048 R14: 00000000001c31ca R15: 00007ffc8bc5b060
 </TASK>

Allocated by task 15931:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kmalloc_noprof include/linux/slab.h:950 [inline]
 rose_add_node net/rose/rose_route.c:85 [inline]
 rose_rt_ioctl+0x586/0x2550 net/rose/rose_route.c:748
 rose_ioctl+0x491/0x7d0 net/rose/af_rose.c:1387
 sock_do_ioctl+0x118/0x280 net/socket.c:1254
 sock_ioctl+0x599/0x6b0 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 31660:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2685 [inline]
 slab_free mm/slub.c:6165 [inline]
 kfree+0x1f6/0x6b0 mm/slub.c:6483
 rose_neigh_put include/net/rose.h:166 [inline]
 rose_timer_expiry+0x53f/0x630 net/rose/rose_timer.c:183
 call_timer_fn+0x19a/0x670 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers+0x757/0xb30 kernel/time/timer.c:2373
 __run_timer_base kernel/time/timer.c:2385 [inline]
 __run_timer_base kernel/time/timer.c:2377 [inline]
 run_timer_base+0x114/0x190 kernel/time/timer.c:2394
 run_timer_softirq+0x1a/0x50 kernel/time/timer.c:2404
 handle_softirqs+0x1eb/0x9e0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xef/0x150 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1056
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697

The buggy address belongs to the object at ffff8880589bdc00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 8 bytes inside of
 freed 512-byte region [ffff8880589bdc00, ffff8880589bde00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880589bf400 pfn:0x589bc
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88813fe40c80 ffffea0001f2ac10 ffffea0001e4cd10
raw: ffff8880589bf400 000000080010000d 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88813fe40c80 ffffea0001f2ac10 ffffea0001e4cd10
head: ffff8880589bf400 000000080010000d 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0001626f01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5819, tgid 5819 (syz-executor), ts 63017728292, free_ts 14412109844
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x153/0x170 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x111d/0x3140 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x27c/0x2ba0 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3292 [inline]
 allocate_slab mm/slub.c:3481 [inline]
 new_slab+0xa6/0x6b0 mm/slub.c:3539
 refill_objects+0x26b/0x400 mm/slub.c:7175
 refill_sheaf mm/slub.c:2812 [inline]
 __pcs_replace_empty_main+0x1ab/0x660 mm/slub.c:4615
 alloc_from_pcs mm/slub.c:4717 [inline]
 slab_alloc_node mm/slub.c:4851 [inline]
 __kmalloc_cache_noprof+0x493/0x6f0 mm/slub.c:5375
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 mca_alloc net/ipv6/mcast.c:871 [inline]
 __ipv6_dev_mc_inc+0x2f1/0xbc0 net/ipv6/mcast.c:961
 ipv6_add_dev+0xb78/0x1520 net/ipv6/addrconf.c:471
 addrconf_notify+0x563/0x19c0 net/ipv6/addrconf.c:3654
 notifier_call_chain+0x99/0x420 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x110 net/core/dev.c:2249
 call_netdevice_notifiers_extack net/core/dev.c:2287 [inline]
 call_netdevice_notifiers net/core/dev.c:2301 [inline]
 register_netdevice+0x16e6/0x2210 net/core/dev.c:11474
 veth_newlink+0x44a/0xa00 drivers/net/veth.c:1889
 rtnl_newlink_create net/core/rtnetlink.c:3862 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3979 [inline]
 rtnl_newlink+0x1494/0x2380 net/core/rtnetlink.c:4094
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6980
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0x7e1/0x10d0 mm/page_alloc.c:2978
 __free_pages mm/page_alloc.c:5369 [inline]
 free_contig_range+0xde/0x1d0 mm/page_alloc.c:7374
 debug_vm_pgtable_free_huge_page mm/debug_vm_pgtable.c:980 [inline]
 destroy_args+0xa8/0x7a0 mm/debug_vm_pgtable.c:993
 debug_vm_pgtable+0x1b66/0x34c0 mm/debug_vm_pgtable.c:1368
 do_one_initcall+0x11d/0x760 init/main.c:1382
 do_initcall_level init/main.c:1444 [inline]
 do_initcalls init/main.c:1460 [inline]
 do_basic_setup init/main.c:1479 [inline]
 kernel_init_freeable+0x6e5/0x7a0 init/main.c:1692
 kernel_init+0x1f/0x1e0 init/main.c:1582
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff8880589bdb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880589bdb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880589bdc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff8880589bdc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880589bdd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 fc                	add    %bh,%ah
   4:	ff                   	lcall  (bad)
   5:	df 48 89             	fisttps -0x77(%rax)
   8:	eb 48                	jmp    0x52
   a:	c1 eb 03             	shr    $0x3,%ebx
   d:	48 01 d3             	add    %rdx,%rbx
  10:	f6 c4 02             	test   $0x2,%ah
  13:	75 47                	jne    0x5c
  15:	bf 01 00 00 00       	mov    $0x1,%edi
  1a:	e8 80 b8 43 f6       	call   0xf643b89f
  1f:	e8 3b ce 7e f6       	call   0xf67ece5f
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 e0 96 ff ff       	call   0xffff970f <-- trapping instruction
  2f:	9c                   	pushf
  30:	58                   	pop    %rax
  31:	fa                   	cli
  32:	f6 c4 02             	test   $0x2,%ah
  35:	75 1e                	jne    0x55
  37:	bf 01 00 00 00       	mov    $0x1,%edi
  3c:	e8                   	.byte 0xe8
  3d:	9e                   	sahf
  3e:	56                   	push   %rsi
  3f:	43                   	rex.XB


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

