Return-Path: <netdev+bounces-238915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27DAC610D4
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 07:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE073B168C
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 06:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F96B239E88;
	Sun, 16 Nov 2025 06:34:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD7423185E
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763274876; cv=none; b=I8C2In6zHPrlyb3gbdX/2OG2YAc3chE8TBqNZb+XQPE4c+jkwjQNWXTWNYbRHDvWCVmDtj0QrdBoRkDBAaOS4TvwrGdDzilJUda5TAthAv/UgyNE6Tghm6xquJn8FcHH8e+Hj7D3Sbj5Y0ZyrlZ9FvRBsOxRaQ3FLWN2ef6nRk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763274876; c=relaxed/simple;
	bh=Z9+yRofKyKVVwgowyYx1GdVMhoJKG3EFBRaN3clK2WY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WBaB/rCRBKKicHZefau72EgG6bW4Qjgeow9lQSAdPggt/axJjlOj56GwcGbjZ9GiC07/JXGKZvcLXvdzh7EYUUXWS0HvR0BC02r8S93Fv1DBxcGLi4EU/pOpDoTXV2tAULItB46N3NZX35kLL7m7t4OyZOdNBHgi58qeZHG3k+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-9489bfaef15so287613239f.1
        for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 22:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763274873; x=1763879673;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gjx3r24VJTugT4CDrLB1f5RU5Y7i7+w64Jn8nAtEVdw=;
        b=c7PO0ARvsBtUE2lJKd0niTPhCzyqwAXZ8GK7Akg97xJPtxVhha8/gGGu+xXc9GvbTZ
         62M3CzLBm8d4Wp1R21E+sHD4pWXFrUgh7BcLxnWfThYLpWxrjVslCFKi8NR+84cbpzN4
         C3AYlkXzXJ2T7r/vHO8PyuQecWkf8K3ZP+X8O9G+shx4kOt8LweJQwfos5OuBo+k+uty
         ji1KJtnmZrfr9Ac6nHVqxHcxbcDlk1uEvNbNmTa1NondTSvZXx8RB7We/IbSDFSI5g3o
         JWx8eF9+FxG0ZIkVrmSw0+mwCk5C/Di/fUKJGFhDa385OmYbZgXR43hSvcEgJ8iAEXuk
         cBKw==
X-Forwarded-Encrypted: i=1; AJvYcCVpqcun89glM04/p0buJ240GY80XyQKFrCbMnaXAai9uk06t1ujh/cQv7HcUToGSfNU+GJ8Rdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Jc8PzF5S0BzK0dR3CSAC5qyx0OzXZ53scnqSsH/C3JXgvlT2
	wiJtpo7DGcVt4HzOMvUfApv2maiElp3H3YlA0Avy+PW8jDvYqIwyLAPXBHzH1tzCN7hGLmf3qnZ
	QVPvJn6ml9SAvUZT7XyX+lFBErV6GSFzYvu48L9AIX5/Fh2J1xYVmkv7uRUI=
X-Google-Smtp-Source: AGHT+IHxvbOGOlMSlBIAf9dN9mLAxdh3W4hTpM5tiuvzG74mx1TVGbdQKm9krrLSvltN+3qu7Jj+f9t3KwVJ5OgxDCmtCwFulCes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:cd1c:0:b0:5b7:1e68:4d95 with SMTP id
 8926c6da1cb9f-5b7c9c4a0a5mr3784468173.2.1763274873218; Sat, 15 Nov 2025
 22:34:33 -0800 (PST)
Date: Sat, 15 Nov 2025 22:34:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69197079.a70a0220.3124cb.0070.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mgmt_pending_remove
From: syzbot <syzbot+9aa47cd4633a3cf92a80@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4001bda0cc91 Merge branch 'selftests-vsock-refactor-and-im..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17f2897c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4dda49799a90cd0f
dashboard link: https://syzkaller.appspot.com/bug?extid=9aa47cd4633a3cf92a80
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a21c12580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1a9e5dda198/disk-4001bda0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e0d7f0aa5468/vmlinux-4001bda0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9cef7d2ebe50/bzImage-4001bda0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9aa47cd4633a3cf92a80@syzkaller.appspotmail.com

RAX: ffffffffffffffda RBX: 00007f5543fe5fa0 RCX: 00007f5543d8f6c9
RDX: 0000000000000007 RSI: 0000200000000000 RDI: 0000000000000005
RBP: 00007f5544b69090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f5543fe6038 R14: 00007f5543fe5fa0 R15: 00007ffe72e0a568
 </TASK>
Bluetooth: hci0: no memory for command
==================================================================
BUG: KASAN: slab-use-after-free in mgmt_pending_remove+0x3b/0x210 net/bluetooth/mgmt_util.c:316
Read of size 8 at addr ffff888077164818 by task syz.0.17/5989

CPU: 0 UID: 0 PID: 5989 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 mgmt_pending_remove+0x3b/0x210 net/bluetooth/mgmt_util.c:316
 set_link_security+0x5c2/0x710 net/bluetooth/mgmt.c:1918
 hci_mgmt_cmd+0x9c9/0xef0 net/bluetooth/hci_sock.c:1719
 hci_sock_sendmsg+0x6ca/0xef0 net/bluetooth/hci_sock.c:1839
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 sock_write_iter+0x279/0x360 net/socket.c:1195
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5543d8f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5544b69038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f5543fe5fa0 RCX: 00007f5543d8f6c9
RDX: 0000000000000007 RSI: 0000200000000000 RDI: 0000000000000005
RBP: 00007f5544b69090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f5543fe6038 R14: 00007f5543fe5fa0 R15: 00007ffe72e0a568
 </TASK>

Allocated by task 5989:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __kmalloc_cache_noprof+0x3d5/0x6f0 mm/slub.c:5763
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 mgmt_pending_new+0x65/0x1e0 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x35/0x140 net/bluetooth/mgmt_util.c:296
 set_link_security+0x557/0x710 net/bluetooth/mgmt.c:1910
 hci_mgmt_cmd+0x9c9/0xef0 net/bluetooth/hci_sock.c:1719
 hci_sock_sendmsg+0x6ca/0xef0 net/bluetooth/hci_sock.c:1839
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 sock_write_iter+0x279/0x360 net/socket.c:1195
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5991:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2539 [inline]
 slab_free mm/slub.c:6630 [inline]
 kfree+0x19a/0x6d0 mm/slub.c:6837
 mgmt_pending_free net/bluetooth/mgmt_util.c:311 [inline]
 mgmt_pending_foreach+0x30d/0x380 net/bluetooth/mgmt_util.c:257
 mgmt_index_removed+0x112/0x2f0 net/bluetooth/mgmt.c:9477
 hci_sock_bind+0xbe9/0x1000 net/bluetooth/hci_sock.c:1314
 __sys_bind_socket net/socket.c:1874 [inline]
 __sys_bind+0x2c6/0x3e0 net/socket.c:1905
 __do_sys_bind net/socket.c:1910 [inline]
 __se_sys_bind net/socket.c:1908 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1908
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888077164800
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff888077164800, ffff888077164860)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x77164
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801a026280 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1098, tgid 1098 (kworker/u8:6), ts 87994876358, free_ts 87976357652
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3055 [inline]
 allocate_slab+0x96/0x350 mm/slub.c:3228
 new_slab mm/slub.c:3282 [inline]
 ___slab_alloc+0xe94/0x18a0 mm/slub.c:4651
 __slab_alloc+0x65/0x100 mm/slub.c:4770
 __slab_alloc_node mm/slub.c:4846 [inline]
 slab_alloc_node mm/slub.c:5268 [inline]
 __kmalloc_cache_noprof+0x411/0x6f0 mm/slub.c:5758
 kmalloc_noprof include/linux/slab.h:957 [inline]
 dst_cow_metrics_generic+0x56/0x1c0 net/core/dst.c:193
 dst_metrics_write_ptr include/net/dst.h:136 [inline]
 dst_metric_set include/net/dst.h:197 [inline]
 icmp6_dst_alloc+0x264/0x420 net/ipv6/route.c:3335
 ndisc_send_skb+0x3f1/0x1510 net/ipv6/ndisc.c:491
 ndisc_send_ns+0xcb/0x150 net/ipv6/ndisc.c:670
 addrconf_dad_work+0xaae/0x14b0 net/ipv6/addrconf.c:4282
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
page last free pid 1113 tgid 1113 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2906
 __slab_free+0x2e7/0x390 mm/slub.c:5962
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:352
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4970 [inline]
 slab_alloc_node mm/slub.c:5280 [inline]
 kmem_cache_alloc_node_noprof+0x433/0x710 mm/slub.c:5332
 __alloc_skb+0x112/0x2d0 net/core/skbuff.c:664
 alloc_skb include/linux/skbuff.h:1383 [inline]
 nlmsg_new include/net/netlink.h:1055 [inline]
 nl80211_send_ibss_bssid+0x8d/0x430 net/wireless/nl80211.c:19952
 __cfg80211_ibss_joined+0x34a/0x440 net/wireless/ibss.c:50
 cfg80211_process_wdev_events+0x38a/0x4f0 net/wireless/util.c:1143
 cfg80211_process_rdev_events+0xa1/0x110 net/wireless/util.c:1170
 cfg80211_event_work+0x31/0x70 net/wireless/core.c:334
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158

Memory state around the buggy address:
 ffff888077164700: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff888077164780: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
>ffff888077164800: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff888077164880: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff888077164900: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
==================================================================


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

