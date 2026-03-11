Return-Path: <netdev+bounces-266746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INDGDFe6sWmxEwAAu9opvQ
	(envelope-from <netdev+bounces-266746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:54:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B66268EAE
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9274930CA95B
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B76F3E0249;
	Wed, 11 Mar 2026 18:52:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87ED371892
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773255151; cv=none; b=qSRDkzOGRkeqYFRMDWJVi2+QMlW6bRhUHCxCDHa2HaD1Rq6o3Sx3LmDiQI+s3fNIkVNWx6kb02rK5UDd+4cOKw3raMazRTD60BrqYYC5nRP3N0emSKVLUmkr0VTy856xsefm3bUYp+vBK2qUHbguBtNaT8pLE3mcQugvWlDj6S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773255151; c=relaxed/simple;
	bh=hGg4bDSnS8fumqrNyawZ+Z25dUME2Yjx6OiciJumink=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=T39ZUVY7VRA4AphtIEM/bUYfPjOwytvBclkn2APG8bl6Tj58kAfWIvp+Pkis2AfS8Stb4s7zDoIC9DujG3tNY9mkVdSfjrkQnuag0/0cTE5FxF16X8/lCogkqvrQaTLNDAJ1uDXS7bM6s79QDd1APS2N07y7cefO36jcp3Gk604=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-40f192cf4b6so922453fac.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 11:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773255149; x=1773859949;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ERlpPqdrLwTrDo597p9x5sFxQ164aUiiv1lN8OPvDYE=;
        b=ryTYd61lA/Lax+rtxmBBI7GTikBidTEL6uKneWn+Kg002IIFf1cXonDHil/0ZHFx9S
         /eqZ37FkGMaXnStJaHRfPBuIJ59m8AOMsnAa2aXpLvXB7Eq6p4JyWgnuMefyEoxqgD/y
         xcsopN6QCpIbDKm3LuE7mSnnSPqSj4CzRYDcZS8GQxDodoB5oURvP+ok2iU/nGaGFs36
         rTpeMQTFLSR1193dQlskj16U6PuoACqP+Ol6f0R6SVbPibo+unNQIjH3taOlCLEHOnPq
         ++UEdmvkYj7KTpqY4OnkSGsv85w/W3GFK3Z/MsO2x+lzwJGsvsOtWruJlXMk+UA6vM7D
         c8ag==
X-Forwarded-Encrypted: i=1; AJvYcCVqHyhTtjY5WkaHSAIdWksZxzlSCHDvMGNkd7bxisM19vozaNFrBVTSzAOtQkS+S+QRLcYfYw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzojeqJn2Dl+wqiW0LBvEM+cV4pt3GQadrx3L6iZk2hOntwYtkg
	/VjUk0U4FHOuaex/EJ1KqAsbsqKhg7eU8Ng20Tn3KYWpeHZG1wqBoCoXKolQqRiDVUrF65HXIBy
	0UaSOb7qSxrIt5Vj0wKNTFb6uCfunhpKxwBjp3zQFTb6N3HUfqb1RgCcTHVQ=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4d08:b0:679:96f:3f04 with SMTP id
 006d021491bc7-67bc89fb062mr2118614eaf.53.1773255148731; Wed, 11 Mar 2026
 11:52:28 -0700 (PDT)
Date: Wed, 11 Mar 2026 11:52:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b1b9ec.a00a0220.94e15.001b.GAE@google.com>
Subject: [syzbot] [hams?] KASAN: slab-use-after-free Read in ax25_disconnect
From: syzbot <syzbot+41ebf587f04e2bcfa8e5@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2a019678b1a3a692];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-266746-lists,netdev=lfdr.de,41ebf587f04e2bcfa8e5];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,syzkaller.appspot.com:url,storage.googleapis.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email]
X-Rspamd-Queue-Id: 82B66268EAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    1f318b96cc84 Linux 7.0-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d41806580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a019678b1a3a692
dashboard link: https://syzkaller.appspot.com/bug?extid=41ebf587f04e2bcfa8e5
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9997eccd7489/disk-1f318b96.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/092609f7d984/vmlinux-1f318b96.xz
kernel image: https://storage.googleapis.com/syzbot-assets/822d2e7e40b1/bzImage-1f318b96.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+41ebf587f04e2bcfa8e5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in ax25_disconnect+0x19c/0x3c0 net/ax25/ax25_subr.c:283
Read of size 8 at addr ffff8880600774c0 by task ktimers/1/29

CPU: 1 UID: 0 PID: 29 Comm: ktimers/1 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 ax25_disconnect+0x19c/0x3c0 net/ax25/ax25_subr.c:283
 call_timer_fn+0x192/0x640 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2373 [inline]
 __run_timer_base+0x6a3/0x9f0 kernel/time/timer.c:2385
 run_timer_base kernel/time/timer.c:2394 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2404
 handle_softirqs+0x1de/0x6f0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 run_ktimerd+0x69/0x100 kernel/softirq.c:1138
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 20813:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3a6/0x690 mm/slub.c:5383
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 ax25_create_cb+0x50/0x5a0 net/ax25/af_ax25.c:531
 ax25_send_frame+0x445/0x9f0 net/ax25/ax25_out.c:67
 rose_send_frame net/rose/rose_link.c:106 [inline]
 rose_transmit_restart_request net/rose/rose_link.c:198 [inline]
 rose_transmit_link+0x729/0xac0 net/rose/rose_link.c:284
 rose_write_internal+0x1256/0x1b60 net/rose/rose_subr.c:198
 rose_connect+0x93b/0x1110 net/rose/af_rose.c:881
 __sys_connect_file net/socket.c:2089 [inline]
 __sys_connect+0x315/0x450 net/socket.c:2108
 __do_sys_connect net/socket.c:2114 [inline]
 __se_sys_connect net/socket.c:2111 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2111
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 16:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2692 [inline]
 slab_free mm/slub.c:6168 [inline]
 kfree+0x1c1/0x6c0 mm/slub.c:6486
 call_timer_fn+0x192/0x640 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2373 [inline]
 __run_timer_base+0x6a3/0x9f0 kernel/time/timer.c:2385
 run_timer_base kernel/time/timer.c:2394 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2404
 handle_softirqs+0x1de/0x6f0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 run_ktimerd+0x69/0x100 kernel/softirq.c:1138
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888060077000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1216 bytes inside of
 freed 2048-byte region [ffff888060077000, ffff888060077800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888060070000 pfn:0x60070
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000240(workingset|head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000240 ffff88813fe1d000 ffff88813fe17c88 ffffea0001d8b810
raw: ffff888060070000 0000000800080006 00000000f5000000 0000000000000000
head: 0080000000000240 ffff88813fe1d000 ffff88813fe17c88 ffffea0001d8b810
head: ffff888060070000 0000000800080006 00000000f5000000 0000000000000000
head: 0080000000000003 ffffea0001801c01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5801, tgid 5801 (syz-executor), ts 82913456262, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x28bb/0x2950 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3296 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3485
 new_slab mm/slub.c:3543 [inline]
 refill_objects+0x334/0x3c0 mm/slub.c:7178
 __pcs_replace_empty_main+0x371/0x5c0 mm/slub.c:-1
 alloc_from_pcs mm/slub.c:4720 [inline]
 slab_alloc_node mm/slub.c:4854 [inline]
 __do_kmalloc_node mm/slub.c:5262 [inline]
 __kmalloc_node_track_caller_noprof+0x60b/0x7e0 mm/slub.c:5371
 kmalloc_reserve net/core/skbuff.c:635 [inline]
 pskb_expand_head+0x228/0x1320 net/core/skbuff.c:2315
 netlink_trim+0x1b3/0x2c0 net/netlink/af_netlink.c:1299
 netlink_broadcast_filtered+0xd6/0x1010 net/netlink/af_netlink.c:1512
 nlmsg_multicast_filtered include/net/netlink.h:1165 [inline]
 nlmsg_multicast include/net/netlink.h:1184 [inline]
 nlmsg_notify+0xf0/0x1a0 net/netlink/af_netlink.c:2593
 __dev_notify_flags+0xf2/0x310 net/core/dev.c:9799
 netif_change_flags+0xe8/0x1a0 net/core/dev.c:9832
 do_setlink+0xf82/0x4590 net/core/rtnetlink.c:3158
 rtnl_changelink net/core/rtnetlink.c:3776 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3935 [inline]
 rtnl_newlink+0x15a9/0x1be0 net/core/rtnetlink.c:4072
 rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888060077380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888060077400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888060077480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff888060077500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888060077580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

