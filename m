Return-Path: <netdev+bounces-258329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJFMJb+/jGmisgAAu9opvQ
	(envelope-from <netdev+bounces-258329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:43:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F3B126B32
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BB65300A118
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187EE34EF0C;
	Wed, 11 Feb 2026 17:43:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8464A30AAD0
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770831805; cv=none; b=aTjFoBQVJomvTawtrweEjOjmq5tifrq411z76bU6QQhQKCmroVUsxxnUnUjHw2JRs6pwbapQtZtIqP4Y9bEWzAQFTbpQ99dGgFCt9nFWyqykUGLBxacMyAiIOCpVw1h7nJVSDEY4ZmnhyQw2lasyFOYQINePgezg2h38Rp22wfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770831805; c=relaxed/simple;
	bh=enOK+xQAwibNFl755M0gHSeGK7tz6PLm6CdIraviPPI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AsC2Lt3821w9DBy8DF3PvZrFWm2Aq+Msq65F9BC4Gwjby+l1cW/G6zRZxawVrMHjR6WjWwiUWVhiTh/OPfleWPd+gRY9oXWl1HuNMzjY6deGhb7nks3o14p+GZcfs44B4V4Y7AnhKLRfn2Se669X7PWe0PdLROT/Zd6fMsSfjrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6630c8af251so7960367eaf.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770831802; x=1771436602;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HtDN/y6BNod39FzbWiG8faJ4UVLGhrcatNVSKG8AYj8=;
        b=WpocCwoREInaYJhguAOwdgMMGlKWTV/lgSpFEH0QFI+qHd+jZOigU7S0vtSRPGCeWi
         M78T/KL9SobOp22g6JAg7RAmpA3chsg34WDkPwz8oNzk1NcBMGjgikgiNXCtKLtDd9Uh
         TKRVIFvhKwg9v15feU+WmFKLoYX8jTxPWXXpCMpNMU+6jvDYrTtuYzzb2Una7jpr9VB8
         +16hVvcl7c9S/WCb3dCjd1qjb8zEEjVj68oZ93tBph9/M5DIjXyr47jQ4Fk8/CDX3jWX
         VACj8NJa8SUJZ7yrOA3URKrKoRxoW6kqC7Ayyo+8COH4G/ae0Gu/6J0Q7F6Lkd6Q76vv
         MY3w==
X-Forwarded-Encrypted: i=1; AJvYcCUhiH/A079XmOpTn27dlNihN5SsEiyTayVr6Ibm9BUAAjyMz1EAaePHUzZifYjkjXm70IZGw88=@vger.kernel.org
X-Gm-Message-State: AOJu0YywqqOesutwI8XfYQcbDyT5P3SzoJFIwEDU6NX5DxFP3AhlwF7V
	yMASW3isH2NglCop+IfT4M3i4SVwJLzJbqIWsVD+65YgRsu5hb3j7+O9aAmZJP7tToZfswR4EbH
	CilEznnu18SrGVGAvg0uHyEWDJ1Wu4RHetvlGDU50uoyJpB415kb0S4tW4gw=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:217:b0:663:170:3b with SMTP id
 006d021491bc7-66d0c56d269mr9581757eaf.55.1770831802482; Wed, 11 Feb 2026
 09:43:22 -0800 (PST)
Date: Wed, 11 Feb 2026 09:43:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698cbfba.050a0220.2eeac1.009d.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-out-of-bounds Read in fib6_add_rt2node
From: syzbot <syzbot+707d6a5da1ab9e0c6f9d@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4aae00ac5a9d2645];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258329-lists,netdev=lfdr.de,707d6a5da1ab9e0c6f9d];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,storage.googleapis.com:url,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: E9F3B126B32
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    2687c848e578 x86/vmware: Fix hypercall clobbers
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1168ca52580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aae00ac5a9d2645
dashboard link: https://syzkaller.appspot.com/bug?extid=707d6a5da1ab9e0c6f9d
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1355ca5a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1233c65a580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-2687c848.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6edd74830601/vmlinux-2687c848.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3eefe8753597/bzImage-2687c848.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+707d6a5da1ab9e0c6f9d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in fib6_add_rt2node+0x349c/0x3500 net/ipv6/ip6_fib.c:1142
Read of size 1 at addr ffff8880384ba6de by task syz.0.18/5500

CPU: 0 UID: 0 PID: 5500 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 fib6_add_rt2node+0x349c/0x3500 net/ipv6/ip6_fib.c:1142
 fib6_add_rt2node_nh net/ipv6/ip6_fib.c:1363 [inline]
 fib6_add+0x910/0x18c0 net/ipv6/ip6_fib.c:1531
 __ip6_ins_rt net/ipv6/route.c:1351 [inline]
 ip6_route_add+0xde/0x1b0 net/ipv6/route.c:3957
 inet6_rtm_newroute+0x268/0x19e0 net/ipv6/route.c:5660
 rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9316b9aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd8809b678 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f9316e15fa0 RCX: 00007f9316b9aeb9
RDX: 0000000000000000 RSI: 0000200000004380 RDI: 0000000000000003
RBP: 00007f9316c08c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9316e15fac R14: 00007f9316e15fa0 R15: 00007f9316e15fa0
 </TASK>

Allocated by task 5499:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5657 [inline]
 __kmalloc_noprof+0x40c/0x7e0 mm/slub.c:5669
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 fib6_info_alloc+0x30/0xf0 net/ipv6/ip6_fib.c:155
 ip6_route_info_create+0x142/0x860 net/ipv6/route.c:3820
 ip6_route_add+0x49/0x1b0 net/ipv6/route.c:3949
 inet6_rtm_newroute+0x268/0x19e0 net/ipv6/route.c:5660
 rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880384ba600
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 22 bytes to the right of
 allocated 200-byte region [ffff8880384ba600, ffff8880384ba6c8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x384ba
ksm flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801a841b40 ffffea0000c2c780 dead000000000007
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 27805093247, free_ts 22714174709
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x228/0x280 mm/page_alloc.c:1884
 prep_new_page mm/page_alloc.c:1892 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3945
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5240
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab+0x86/0x3a0 mm/slub.c:3248
 new_slab mm/slub.c:3302 [inline]
 ___slab_alloc+0xd82/0x1760 mm/slub.c:4656
 __slab_alloc+0x65/0x100 mm/slub.c:4779
 __slab_alloc_node mm/slub.c:4855 [inline]
 slab_alloc_node mm/slub.c:5251 [inline]
 __do_kmalloc_node mm/slub.c:5656 [inline]
 __kvmalloc_node_noprof+0x673/0x8d0 mm/slub.c:7144
 v4l2_ctrl_new+0x9d5/0x1790 drivers/media/v4l2-core/v4l2-ctrls-core.c:2112
 v4l2_ctrl_new_std+0x24e/0x300 drivers/media/v4l2-core/v4l2-ctrls-core.c:2266
 handler_new_ref+0x153/0x9c0 drivers/media/v4l2-core/v4l2-ctrls-core.c:1853
 v4l2_ctrl_add_handler+0x19f/0x290 drivers/media/v4l2-core/v4l2-ctrls-core.c:2416
 vivid_create_controls+0x2fdc/0x3bd0 drivers/media/test-drivers/vivid/vivid-ctrls.c:2044
 vivid_create_instance drivers/media/test-drivers/vivid/vivid-core.c:1933 [inline]
 vivid_probe+0x4261/0x72b0 drivers/media/test-drivers/vivid/vivid-core.c:2095
 platform_probe+0xf9/0x190 drivers/base/platform.c:1446
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x267/0xaf0 drivers/base/dd.c:661
page last free pid 36 tgid 36 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xbf8/0xd70 mm/page_alloc.c:2973
 vfree+0x25a/0x400 mm/vmalloc.c:3466
 delayed_vfree_work+0x55/0x80 mm/vmalloc.c:3385
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xaec/0x17a0 kernel/workqueue.c:3340
 worker_thread+0xda6/0x1360 kernel/workqueue.c:3421
 kthread+0x726/0x8b0 kernel/kthread.c:463
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Memory state around the buggy address:
 ffff8880384ba580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880384ba600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880384ba680: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
                                                    ^
 ffff8880384ba700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880384ba780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

