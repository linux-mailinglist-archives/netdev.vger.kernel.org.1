Return-Path: <netdev+bounces-104958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1205990F4A5
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE2B2848A5
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906D8155386;
	Wed, 19 Jun 2024 17:02:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF79137747
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816547; cv=none; b=szJkHEQzmJoOQF2nWclbAjoCgizEYwzf1Dh1ejsca9UGO91F7XsJdEio7I2SsTic1gC+CEXinWd9CkcIHLI/LyVKjOxckJPLWnEIE8bDJEdiLzn6Rw/bTE2trMsZ8Q0Pa7Zm7WUVljUU6EYBKXOc+ZVRFabOGQ1ZYQKrrFawNpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816547; c=relaxed/simple;
	bh=0vO4GKaP767w0/XD+Si416dist7SXca57A4FWcH2paQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hyTuz5POwgsWsdury9iCNpiwDGRY/dKIkfjOrYb1vmi7HfcuZF3/QUUYmfyx/XkuAPeSRrH3pU5V6WVmuwP58RDsanIZDMFQvl8OY7mIGY5Q7RhZcWDpzTIs6py6rg4GjUViW9U31ESiU+9PTiUSN5gF2TQCLXhgHyrFyHOyTLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-375beb12e67so71904695ab.3
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 10:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718816545; x=1719421345;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UWJmbqOBPchg8T0EuVb6TtoE3L9OrAp1dqQL8qXw334=;
        b=Rg7D7nA6+7VJi75fayTOpbpBFEA0AQPYIl5YnAm7/PQP4m8s0+aqhXSJrOVx3xEuQw
         5NXRKGxXI+7et9zk0Id02KPLwLPqcotKVta8bVYseYhf57rrq+/eeJlxn5Ee4XudCWa/
         vqiDVBjEBVlJAUhn0i5xj3GTRuo5YcIiObLV+3/1vfiQhSQaznlxKxoJXN9LG3oqi9OV
         MtiRrD7Ad0QKxeX9XGI084c418U+OShRQ4t+n8FYU+VqWKZUwLxRZeeoNmshPIlLKvfJ
         zPlBlNFtOvvuZPJ/+jRkXyaKJGh8JHIagu0Z7E4DjYNS60VjAJ5dNvvFbc54moIe//7k
         SxxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzWUTyuZJnGvZy78GsBN16Mg6xNbL4cLAwyaiCML8DFrjL05kC2PuDnx5t0abxUuZBf3q+y83UtMBuxCwdthZppsHbY3AP
X-Gm-Message-State: AOJu0Yy3h0xvOaFMNgrsRVtdP+3kiMu0Vo5Uu9La6PiM5ZVsf8GUD5jl
	h/Jwt9N9on0NH2tWkGA8jrpI6TI5b40qFDSWahSBUvkBVvktzVW7W5PKbe0fHbXljRCyr94kOyL
	nhzSNDZrO7BGvX9FgsgRhU5lPkq9VqBp519hLZrthOyrsjjyHKGNdmPE=
X-Google-Smtp-Source: AGHT+IGG+jy/QZJDvaJsVEmz2br/qj5OV0b0xIwU6nt1cNy4F8SFq2xs0EtRU4+71UWtY+rA/r/2MtFTPmdrehDPLxlizgHgGgZ/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2183:b0:375:da97:f21a with SMTP id
 e9e14a558f8ab-3761d7288a6mr1983605ab.3.1718816544969; Wed, 19 Jun 2024
 10:02:24 -0700 (PDT)
Date: Wed, 19 Jun 2024 10:02:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098e724061b41297e@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 hci_sock_get_cookie (2)
From: syzbot <syzbot+d047bdb99944f4429ce7@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    45403b12c29c ip_tunnel: Move stats allocation to core
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12dd357a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce6b8d38d53fa4e
dashboard link: https://syzkaller.appspot.com/bug?extid=d047bdb99944f4429ce7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/08e0ccb0d0c7/disk-45403b12.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d8c2fb69ea08/vmlinux-45403b12.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f665a6962ffc/bzImage-45403b12.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d047bdb99944f4429ce7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in hci_sock_get_cookie+0x49/0x50 net/bluetooth/hci_sock.c:96
Read of size 4 at addr ffff888055333568 by task syz-executor.2/5954

CPU: 1 PID: 5954 Comm: syz-executor.2 Not tainted 6.10.0-rc2-syzkaller-00724-g45403b12c29c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 hci_sock_get_cookie+0x49/0x50 net/bluetooth/hci_sock.c:96
 mgmt_cmd_status+0x1be/0x4d0 net/bluetooth/mgmt_util.c:149
 cmd_status_rsp net/bluetooth/mgmt.c:1451 [inline]
 cmd_complete_rsp+0xe7/0x150 net/bluetooth/mgmt.c:1466
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x187/0x420 net/bluetooth/mgmt.c:9413
 hci_dev_close_sync+0x587/0xf60 net/bluetooth/hci_sync.c:5058
 hci_dev_do_close net/bluetooth/hci_core.c:556 [inline]
 hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:581
 sock_do_ioctl+0x158/0x460 net/socket.c:1222
 sock_ioctl+0x629/0x8e0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2334e7cea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2335caa0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2334fb3f80 RCX: 00007f2334e7cea9
RDX: 0000000000000000 RSI: 00000000400448ca RDI: 000000000000000d
RBP: 00007f2334eebff4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f2334fb3f80 R15: 00007ffd57013a68
 </TASK>

Allocated by task 5225:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 __kmalloc_noprof+0x1f9/0x400 mm/slub.c:4134
 kmalloc_noprof include/linux/slab.h:664 [inline]
 sk_prot_alloc+0xe0/0x210 net/core/sock.c:2096
 sk_alloc+0x38/0x370 net/core/sock.c:2149
 bt_sock_alloc+0x3c/0x340 net/bluetooth/af_bluetooth.c:148
 hci_sock_create+0xa1/0x190 net/bluetooth/hci_sock.c:2202
 bt_sock_create+0x161/0x230 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x490/0x920 net/socket.c:1571
 sock_create net/socket.c:1622 [inline]
 __sys_socket_create net/socket.c:1659 [inline]
 __sys_socket+0x150/0x3c0 net/socket.c:1706
 __do_sys_socket net/socket.c:1720 [inline]
 __se_sys_socket net/socket.c:1718 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1718
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5962:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2195 [inline]
 slab_free mm/slub.c:4436 [inline]
 kfree+0x149/0x360 mm/slub.c:4557
 sk_prot_free net/core/sock.c:2132 [inline]
 __sk_destruct+0x476/0x5f0 net/core/sock.c:2224
 sock_put include/net/sock.h:1879 [inline]
 mgmt_pending_free net/bluetooth/mgmt_util.c:307 [inline]
 mgmt_pending_remove+0x13e/0x1a0 net/bluetooth/mgmt_util.c:315
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 mgmt_index_removed+0xe6/0x340 net/bluetooth/mgmt.c:9346
 hci_sock_bind+0xcc6/0x1140 net/bluetooth/hci_sock.c:1307
 __sys_bind+0x23d/0x2f0 net/socket.c:1847
 __do_sys_bind net/socket.c:1858 [inline]
 __se_sys_bind net/socket.c:1856 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1856
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888055333000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1384 bytes inside of
 freed 2048-byte region [ffff888055333000, ffff888055333800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x55330
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888015042000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff888015042000 dead000000000100 dead000000000122
head: 0000000000000000 0000000000080008 00000001ffffefff 0000000000000000
head: 00fff00000000003 ffffea000154cc01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 4538, tgid 4538 (klogd), ts 83329536244, free_ts 22893428251
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x2e2d/0x2ee0 mm/page_alloc.c:3402
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4660
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2264
 allocate_slab+0x5a/0x2e0 mm/slub.c:2427
 new_slab mm/slub.c:2480 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3666
 __slab_alloc+0x58/0xa0 mm/slub.c:3756
 __slab_alloc_node mm/slub.c:3809 [inline]
 slab_alloc_node mm/slub.c:3988 [inline]
 kmalloc_trace_noprof+0x1d5/0x2c0 mm/slub.c:4147
 kmalloc_noprof include/linux/slab.h:660 [inline]
 syslog_print+0x121/0x9c0 kernel/printk/printk.c:1553
 do_syslog+0x3bb/0x810 kernel/printk/printk.c:1731
 __do_sys_syslog kernel/printk/printk.c:1823 [inline]
 __se_sys_syslog kernel/printk/printk.c:1821 [inline]
 __x64_sys_syslog+0x7c/0x90 kernel/printk/printk.c:1821
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2565
 free_contig_range+0x9e/0x160 mm/page_alloc.c:6619
 destroy_args+0x8a/0x890 mm/debug_vm_pgtable.c:1038
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1418
 do_one_initcall+0x248/0x880 init/main.c:1267
 do_initcall_level+0x157/0x210 init/main.c:1329
 do_initcalls+0x3f/0x80 init/main.c:1345
 kernel_init_freeable+0x435/0x5d0 init/main.c:1578
 kernel_init+0x1d/0x2b0 init/main.c:1467
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888055333400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888055333480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888055333500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff888055333580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888055333600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

