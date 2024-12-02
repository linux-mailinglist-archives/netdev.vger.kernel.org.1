Return-Path: <netdev+bounces-147994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE049DFC46
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 09:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498D616326F
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 08:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839C81F9AB9;
	Mon,  2 Dec 2024 08:45:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9313A1F8AFE
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733129128; cv=none; b=VcACqPvIZKngG/qDWlkUQz+267KPN0ah3g4Ty0ynJzVes4+xJP+fd06tcKW0oPXQhqQV9oxP6CYIoGNTMCBfrgkAbyaCKlQrWOZxYhB2SbfBGazvSwIf5snvYULXcLNOguIq3+Tm9tiyYvugvRV3AluXqiywmcpJ2SzH5WHjlSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733129128; c=relaxed/simple;
	bh=CxGY8qpbLiIsJwmMkHUuBBbTxLhDklFM+I265oZGhm0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TpeGSI7kV2YV/RX0mmxePllfp8hv/qJL89umt8z+Tnrm+GQ8lpG7khCm0lvN6D/pFOXSvS1fobVd7ozHekoY3LG0EUMP5huTNx9C9sqbbMhfcoroBS4PyoL6skEHk3edyZ7m1wVj0YF2vcZTxHQjCwtg1Vg9/aw44YfhzQ0hZLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-843e86e0b3fso421875439f.3
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 00:45:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733129125; x=1733733925;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DggI3VJrakSEIqX6oolfq04BqTmJ6a1XKUkbVE4u05o=;
        b=nFOJRgcB8Y44StRGemjr4vg7Z1IX2Z4KBJupJCLp6u+Wm0fdzq5Ba7B/AwIsKQulKi
         MIyzzimInu0s5sC2HLx4O0LSqtmUTH+9S62sxbMUa6P2d4uNYf6BSt97mWYmGHi0+7Wj
         fEpgk68ppi+vYILmnVEryEvNh4Axkn+X/jtwRIqeL+C4aUv/L2yBtsGfW5uvV7eSjlMw
         VwAOPrklMmH41Ab4DHX637o+Fy9F0d8Nwi5ZNOKO/BXJTqVFMNvre6bR2cbyyLW/HXCU
         FgBcPzO3J9gteqiqYZmlFdiD3zZnpM4gOK3AklAe2YYV+KF7NjkVSL5YE10lnCAyi65+
         YpHg==
X-Forwarded-Encrypted: i=1; AJvYcCXKOXNwP17WP/JaS+WDxCLyquhVF1skRAHquL8MdBawvOuspKyardcJeMk0GsEbG9zs+tCbjQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxjxGe+6fPZezq4VB6C1fCG+Dmj2AYUIRIVMXv/evdCX/MxWYB
	3fdCAtBrQGHGTgQwhgX8y84uaEqCnbTodMitm8ztclV3aSrbSQkysA8/LO9Qzg3shZDA40IbEQd
	v/TpXNisKVwf3mD4jGHSXsdlS/qrF6+0MoijBfIG3liapGULRPyCHiY0=
X-Google-Smtp-Source: AGHT+IFI8OPrENAahT+kGtwkrh/Z2SFqE1aFEhuRzlW8jPYn4T2eNojuFpUcC6Jy+Mj6cSorUadjUg9yeYQlkfNnflKRfyhHaUf/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc3:b0:3a7:e800:7d37 with SMTP id
 e9e14a558f8ab-3a7e8008126mr67268915ab.10.1733129125680; Mon, 02 Dec 2024
 00:45:25 -0800 (PST)
Date: Mon, 02 Dec 2024 00:45:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674d73a5.050a0220.ad585.0045.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_conn_put
From: syzbot <syzbot+55d58a05f0b5fd2ea0c7@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a747e02430df ipv6: avoid possible NULL deref in modify_pre..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10f77f78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3891b550f14aea0f
dashboard link: https://syzkaller.appspot.com/bug?extid=55d58a05f0b5fd2ea0c7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/34080a6fadb0/disk-a747e024.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bc6aa3daa047/vmlinux-a747e024.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7defcc489e27/bzImage-a747e024.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+55d58a05f0b5fd2ea0c7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in sco_conn_free net/bluetooth/sco.c:87 [inline]
BUG: KASAN: slab-use-after-free in kref_put include/linux/kref.h:65 [inline]
BUG: KASAN: slab-use-after-free in sco_conn_put+0xad/0x210 net/bluetooth/sco.c:107
Write of size 8 at addr ffff8880226d05a0 by task syz-executor/5862

CPU: 0 UID: 0 PID: 5862 Comm: syz-executor Not tainted 6.12.0-syzkaller-10695-ga747e02430df #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 sco_conn_free net/bluetooth/sco.c:87 [inline]
 kref_put include/linux/kref.h:65 [inline]
 sco_conn_put+0xad/0x210 net/bluetooth/sco.c:107
 hci_disconn_cfm include/net/bluetooth/hci_core.h:2050 [inline]
 hci_conn_hash_flush+0xff/0x240 net/bluetooth/hci_conn.c:2698
 hci_dev_close_sync+0xa42/0x11c0 net/bluetooth/hci_sync.c:5212
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_unregister_dev+0x20b/0x510 net/bluetooth/hci_core.c:2698
 vhci_release+0x80/0xd0 drivers/bluetooth/hci_vhci.c:664
 __fput+0x23c/0xa50 fs/file_table.c:450
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:938
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1096
 x64_sys_call+0x26a8/0x26b0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8252380849
Code: Unable to access opcode bytes at 0x7f825238081f.
RSP: 002b:00007fff0c285e98 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8252380849
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000043
RBP: 00007f82523dd978 R08: 00007fff0c283c37 R09: 000000000001abe9
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 000000000001abe9 R14: 0000000000000000 R15: 00007fff0c286720
 </TASK>

Allocated by task 7965:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4314
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 copy_verifier_state+0x944/0xec0 kernel/bpf/verifier.c:1514
 is_state_visited kernel/bpf/verifier.c:18413 [inline]
 do_check+0x4522/0xfcd0 kernel/bpf/verifier.c:18575
 do_check_common+0x1564/0x2010 kernel/bpf/verifier.c:21848
 do_check_main kernel/bpf/verifier.c:21939 [inline]
 bpf_check+0x19380/0x1f1b0 kernel/bpf/verifier.c:22656
 bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2947
 __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5790
 __do_sys_bpf kernel/bpf/syscall.c:5897 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5895 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5895
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 7965:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kfree+0x196/0x420 mm/slub.c:4746
 free_func_state kernel/bpf/verifier.c:1452 [inline]
 free_verifier_state kernel/bpf/verifier.c:1461 [inline]
 free_states kernel/bpf/verifier.c:21729 [inline]
 do_check_common+0x19b2/0x2010 kernel/bpf/verifier.c:21860
 do_check_main kernel/bpf/verifier.c:21939 [inline]
 bpf_check+0x19380/0x1f1b0 kernel/bpf/verifier.c:22656
 bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2947
 __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5790
 __do_sys_bpf kernel/bpf/syscall.c:5897 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5895 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5895
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880226d0000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1440 bytes inside of
 freed 2048-byte region [ffff8880226d0000, ffff8880226d0800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x226d0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac42000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ac42000 dead000000000100 dead000000000122
head: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea000089b401 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5855, tgid 5855 (syz-executor), ts 65737422958, free_ts 65730381330
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2408
 allocate_slab+0x5a/0x2f0 mm/slub.c:2574
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
 __slab_alloc+0x58/0xa0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 __do_kmalloc_node mm/slub.c:4282 [inline]
 __kmalloc_node_track_caller_noprof+0x2e9/0x4c0 mm/slub.c:4302
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:609
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1323 [inline]
 nlmsg_new include/net/netlink.h:1018 [inline]
 inet6_ifinfo_notify+0x72/0x120 net/ipv6/addrconf.c:6178
 addrconf_notify+0xc6b/0x1020 net/ipv6/addrconf.c:3784
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:85
 __dev_notify_flags+0x207/0x400
 dev_change_flags+0xf0/0x1a0 net/core/dev.c:9020
page last free pid 5848 tgid 5848 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdf9/0x1140 mm/page_alloc.c:2657
 discard_slab mm/slub.c:2673 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3142
 put_cpu_partial+0x17c/0x250 mm/slub.c:3217
 __slab_free+0x2ea/0x3d0 mm/slub.c:4468
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 __kmalloc_cache_noprof+0x1d9/0x390 mm/slub.c:4309
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 ____ip_mc_inc_group+0x5a2/0xe50 net/ipv4/igmp.c:1468
 __ip_mc_inc_group net/ipv4/igmp.c:1503 [inline]
 ip_mc_inc_group net/ipv4/igmp.c:1509 [inline]
 ip_mc_up+0x124/0x300 net/ipv4/igmp.c:1808
 inetdev_event+0xfa4/0x1550 net/ipv4/devinet.c:1638
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:85
 __dev_notify_flags+0x207/0x400
 dev_change_flags+0xf0/0x1a0 net/core/dev.c:9020
 do_setlink+0xc90/0x4210 net/core/rtnetlink.c:3109
 rtnl_changelink net/core/rtnetlink.c:3723 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3875 [inline]
 rtnl_newlink+0x171c/0x24f0 net/core/rtnetlink.c:4007

Memory state around the buggy address:
 ffff8880226d0480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880226d0500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880226d0580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff8880226d0600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880226d0680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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

