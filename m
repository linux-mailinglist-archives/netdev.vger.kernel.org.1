Return-Path: <netdev+bounces-249124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD26D14A29
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 19:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B740E307B3B3
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 17:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565C637F0F9;
	Mon, 12 Jan 2026 17:53:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A2630F7F9
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240417; cv=none; b=HwLcP8ZsGDcCUMjX+o9rxXvzv4sPhBQ7BS1NebRT7goIabgcYp91trPa+BkknseetbE/bG9mzBbT3YkxbXfwpVbT2ZnTY5v+dGsj1kWSIz2FIXhmEc+N+rl42XGkESoxtcMDRnbiZ1/EATCVT0DuL5KlzUPDtQDRSr463DLE6Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240417; c=relaxed/simple;
	bh=5enVgKErWMl17WE3rjWAou8lbB0jF8yNQ/qfoiEUnus=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pJJDpEUxaE7SQrYgAQwd8SVTp5H3bfQnG6K4OGEIYKKHPFk3PS1+muZNar7gwAmE5MwA34lVMVRaU0GzXFTMnzHFN6za52FDQYGp2Q6YZ9YIQo69cy3vK+/eYYO3y3lwS//f+6h+mRsDt/n2a/yKxuqeYG/w4YAuw14QiVjX644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7cac9cda2d0so3942455a34.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 09:53:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768240414; x=1768845214;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/2CGV40/TN51r4c09sqA+URdPQKj/J4hylR6i+D0F4=;
        b=MJs3xxF2b8T+0thXogTvhOwQYgc6CM+pBRpiwPBrQLDjNInSXafXyhBD6e8e7/b0D+
         6/BJXTHkg4etPyAq2bOm/2NYoXahkITkFkyo5+6GVecQ2V4rz2vFDodB8F8N046STXJW
         QiW0jJzUEiBisMgs4xLHjEqZVPGfAUWuKYorUAU+pvJxpX7Js2Q3jWS0EIooB8lAZ43k
         ecojMtMygPmW1EovpIxZss/+NNPbxmlUiPQEmWSVSHD5A2Dgl+4jpMGLZK3+gFaMBrBr
         ZtQA1PVsfHI8/MQoBjmh9eUlh5r4/Zuip0A3yy4hEJpXrM6MXIGu9ZDirFsFg7OdnGpS
         rr2A==
X-Forwarded-Encrypted: i=1; AJvYcCX7N+ahY4mNxrhVPjMpHAzW08fFR6yzpll6rLlz70EPYUOUKG0uFaZT6mS2h/vzGnz0rQGOcKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/DQlReJ79QqQOJs1rpLSpq5ny4ulfcx7qwHIKMStGoB0vRs+c
	g0ZFyf1nY55JgkpNwJ1yk6rSNDCFuwvTFZhRGNJg3s83OZF9Mce52ieBKmQEm/Q76ayvwajrtvE
	R6sqBgZt2MN5h7f3YuBIQEB2h2GuTyefkq+AvLBPZfFPSr1yfEwQTwho9hDo=
X-Google-Smtp-Source: AGHT+IFnbjtH3fP6MqkFupWcmJ/QINhXxfug/FOL0aROEVR9Pl9Mt0hJhPYx/ngYjRgvibxdfHV1LTWrfk2NPNmc9xgD1O5tqW3J
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:d85a:0:b0:65f:6601:b361 with SMTP id
 006d021491bc7-65f6601cb02mr4726724eaf.12.1768240413986; Mon, 12 Jan 2026
 09:53:33 -0800 (PST)
Date: Mon, 12 Jan 2026 09:53:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6965351d.050a0220.eaf7.00c5.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in qfq_search_class
From: syzbot <syzbot+07f3f38f723c335f106d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9c7ef209cd0f Merge tag 'char-misc-6.19-rc5' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1507199a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1859476832863c41
dashboard link: https://syzkaller.appspot.com/bug?extid=07f3f38f723c335f106d
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-9c7ef209.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46201e726fe4/vmlinux-9c7ef209.xz
kernel image: https://storage.googleapis.com/syzbot-assets/599b32da17bc/bzImage-9c7ef209.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+07f3f38f723c335f106d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in qdisc_class_find include/net/sch_generic.h:658 [inline]
BUG: KASAN: slab-use-after-free in qfq_find_class net/sched/sch_qfq.c:215 [inline]
BUG: KASAN: slab-use-after-free in qfq_search_class+0x16e/0x1a0 net/sched/sch_qfq.c:569
Read of size 4 at addr ffff8880651e5300 by task syz.1.1901/12358

CPU: 0 UID: 0 PID: 12358 Comm: syz.1.1901 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 qdisc_class_find include/net/sch_generic.h:658 [inline]
 qfq_find_class net/sched/sch_qfq.c:215 [inline]
 qfq_search_class+0x16e/0x1a0 net/sched/sch_qfq.c:569
 __tc_ctl_tclass net/sched/sch_api.c:2237 [inline]
 tc_ctl_tclass+0x789/0x16c0 net/sched/sch_api.c:2309
 rtnetlink_rcv_msg+0x3c9/0xe90 net/core/rtnetlink.c:6967
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa5d/0xc30 net/socket.c:2592
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2646
 __sys_sendmsg+0x16d/0x220 net/socket.c:2678
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f60b858f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f60b939a038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f60b87e5fa0 RCX: 00007f60b858f7c9
RDX: 0000000000000000 RSI: 0000200000000000 RDI: 0000000000000007
RBP: 00007f60b8613f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f60b87e6038 R14: 00007f60b87e5fa0 R15: 00007fff412b17a8
 </TASK>

Allocated by task 11350:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 qfq_change_class+0x2ba/0x1da0 net/sched/sch_qfq.c:479
 __tc_ctl_tclass net/sched/sch_api.c:2279 [inline]
 tc_ctl_tclass+0x59d/0x16c0 net/sched/sch_api.c:2309
 rtnetlink_rcv_msg+0x3c9/0xe90 net/core/rtnetlink.c:6967
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa5d/0xc30 net/socket.c:2592
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2646
 __sys_sendmsg+0x16d/0x220 net/socket.c:2678
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 12068:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6670 [inline]
 kfree+0x2f8/0x6e0 mm/slub.c:6878
 qfq_change_class+0x1576/0x1da0 net/sched/sch_qfq.c:533
 __tc_ctl_tclass net/sched/sch_api.c:2279 [inline]
 tc_ctl_tclass+0x59d/0x16c0 net/sched/sch_api.c:2309
 rtnetlink_rcv_msg+0x3c9/0xe90 net/core/rtnetlink.c:6967
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa5d/0xc30 net/socket.c:2592
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2646
 __sys_sendmsg+0x16d/0x220 net/socket.c:2678
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880651e5300
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 0 bytes inside of
 freed 128-byte region [ffff8880651e5300, ffff8880651e5380)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x651e5
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b442a00 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 9272, tgid 9271 (syz.1.993), ts 100051406974, free_ts 100051372730
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1af/0x220 mm/page_alloc.c:1857
 prep_new_page mm/page_alloc.c:1865 [inline]
 get_page_from_freelist+0xd0b/0x31a0 mm/page_alloc.c:3915
 __alloc_frozen_pages_noprof+0x25f/0x2430 mm/page_alloc.c:5210
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab mm/slub.c:3248 [inline]
 new_slab+0x2c3/0x430 mm/slub.c:3302
 ___slab_alloc+0xe18/0x1c90 mm/slub.c:4656
 __slab_alloc.constprop.0+0x63/0x110 mm/slub.c:4779
 __slab_alloc_node mm/slub.c:4855 [inline]
 slab_alloc_node mm/slub.c:5251 [inline]
 __kmalloc_cache_noprof+0x485/0x800 mm/slub.c:5771
 kmalloc_noprof include/linux/slab.h:957 [inline]
 __hw_addr_create net/core/dev_addr_lists.c:60 [inline]
 __hw_addr_add_ex+0x3c9/0x7c0 net/core/dev_addr_lists.c:118
 __hw_addr_add net/core/dev_addr_lists.c:135 [inline]
 dev_addr_init+0x161/0x250 net/core/dev_addr_lists.c:559
 alloc_netdev_mqs+0x363/0x1550 net/core/dev.c:12016
 tun_set_iff drivers/net/tun.c:2778 [inline]
 __tun_chr_ioctl+0x193e/0x4880 drivers/net/tun.c:3088
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 9272 tgid 9271 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0x7df/0x1170 mm/page_alloc.c:2943
 selinux_genfs_get_sid security/selinux/hooks.c:1359 [inline]
 inode_doinit_with_dentry+0xaca/0x12e0 security/selinux/hooks.c:1557
 selinux_d_instantiate+0x26/0x30 security/selinux/hooks.c:6545
 security_d_instantiate+0x142/0x1a0 security/security.c:3601
 d_make_persistent+0x6a/0x190 fs/dcache.c:2790
 __debugfs_create_file+0x26b/0x530 fs/debugfs/inode.c:450
 debugfs_create_file_full+0x41/0x60 fs/debugfs/inode.c:460
 ref_tracker_dir_debugfs+0x19d/0x2f0 lib/ref_tracker.c:441
 ref_tracker_dir_init include/linux/ref_tracker.h:70 [inline]
 alloc_netdev_mqs+0x314/0x1550 net/core/dev.c:12006
 tun_set_iff drivers/net/tun.c:2778 [inline]
 __tun_chr_ioctl+0x193e/0x4880 drivers/net/tun.c:3088
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880651e5200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880651e5280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880651e5300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880651e5380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880651e5400: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
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

