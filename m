Return-Path: <netdev+bounces-31064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D911278B346
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 16:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F0C1C2090D
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0602712B8B;
	Mon, 28 Aug 2023 14:38:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F812B88
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 14:38:02 +0000 (UTC)
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBF3103
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 07:38:00 -0700 (PDT)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1bf78ff0745so29955635ad.3
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 07:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693233480; x=1693838280;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Q2RRpxWwzBz2lo/Cnb5AUT+RPAiEBd+r9aUTk3eJRA=;
        b=FCln3tqP7vna3njlUuQklT2Wy4u5BOpQiHiFTQblHP2v9pokkhdksvwSjIdrAPP3fn
         z7wqqfd3m2hJHm5tE0TYnWeYRDe9XznL8m3J15pnkoz1YB8HGlIUW0qE1RqwhwnBGH8x
         jKAcQ1dJIu4Yfq8cslk0bMS+IZUwnYpikVpXX69wuyWPx1lImW6RX8wnySZKFn2lCW4W
         WO4oeUvoGMXy7ES3PDTPeDqB1zAA/xh+bpon32P+NAX7QfhBwK7VNZR8I+i4qfjdahZD
         pOfS8TjQvjHhJQOIanE7WKrl3EZmT8DmjGgi2nTzlxORK+hqTPYuddBSFvhnM1HMlbMh
         JMEQ==
X-Gm-Message-State: AOJu0YwxFdv/BXsDp9VPhR2J6/MyA82+VlanJ8WqbpKsuzFxxMecQZNH
	FMsX5AmLNgfYg3B3t701ujo3hqNZqFajDv+aRx7915qEOQ5w
X-Google-Smtp-Source: AGHT+IEz8jOdsOlfENOMATRHg+k5mBVSUCRkiU1x8WK2q7yWY6kRccLIM8K2oreYZ0QBskXAui+unaKhLGedNf/whOHHczGZNFtE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:f54f:b0:1c0:d7a9:1c42 with SMTP id
 h15-20020a170902f54f00b001c0d7a91c42mr2245730plf.13.1693233480351; Mon, 28
 Aug 2023 07:38:00 -0700 (PDT)
Date: Mon, 28 Aug 2023 07:38:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e43b20603fca42e@google.com>
Subject: [syzbot] [net?] KCSAN: data-race in ipv6_mc_down / mld_ifc_work
From: syzbot <syzbot+abaf5beee2f14acba54f@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    f7757129e3de Merge tag 'v6.5-p3' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e85763a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f12c32a009b80107
dashboard link: https://syzkaller.appspot.com/bug?extid=abaf5beee2f14acba54f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/acf44b1aab94/disk-f7757129.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/460ccff9ae88/vmlinux-f7757129.xz
kernel image: https://storage.googleapis.com/syzbot-assets/11e7bd67dc5b/bzImage-f7757129.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+abaf5beee2f14acba54f@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in ipv6_mc_down / mld_ifc_work

write to 0xffff888178cce832 of 1 bytes by task 29599 on cpu 1:
 mld_ifc_stop_work net/ipv6/mcast.c:1080 [inline]
 ipv6_mc_down+0x10a/0x280 net/ipv6/mcast.c:2728
 addrconf_ifdown+0xe32/0xf10 net/ipv6/addrconf.c:3905
 addrconf_notify+0x310/0x980
 notifier_call_chain kernel/notifier.c:93 [inline]
 raw_notifier_call_chain+0x6b/0x1c0 kernel/notifier.c:461
 call_netdevice_notifiers_info net/core/dev.c:1962 [inline]
 call_netdevice_notifiers_extack net/core/dev.c:2000 [inline]
 call_netdevice_notifiers net/core/dev.c:2014 [inline]
 dev_close_many+0x1f0/0x2f0 net/core/dev.c:1555
 unregister_netdevice_many_notify+0x253/0x1070 net/core/dev.c:10823
 rtnl_delete_link net/core/rtnetlink.c:3214 [inline]
 rtnl_dellink+0x384/0x580 net/core/rtnetlink.c:3266
 rtnetlink_rcv_msg+0x807/0x8c0 net/core/rtnetlink.c:6428
 netlink_rcv_skb+0x126/0x220 net/netlink/af_netlink.c:2549
 rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:6446
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x56f/0x640 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x665/0x770 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg net/socket.c:748 [inline]
 ____sys_sendmsg+0x37c/0x4d0 net/socket.c:2494
 ___sys_sendmsg net/socket.c:2548 [inline]
 __sys_sendmsg+0x1e9/0x270 net/socket.c:2577
 __do_sys_sendmsg net/socket.c:2586 [inline]
 __se_sys_sendmsg net/socket.c:2584 [inline]
 __x64_sys_sendmsg+0x46/0x50 net/socket.c:2584
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

write to 0xffff888178cce832 of 1 bytes by task 3189 on cpu 0:
 mld_ifc_work+0x54c/0x7b0 net/ipv6/mcast.c:2656
 process_one_work+0x434/0x860 kernel/workqueue.c:2600
 worker_thread+0x5f2/0xa10 kernel/workqueue.c:2751
 kthread+0x1d7/0x210 kernel/kthread.c:389
 ret_from_fork+0x2e/0x40 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

value changed: 0x02 -> 0x00

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 3189 Comm: kworker/0:7 Not tainted 6.5.0-rc7-syzkaller-00004-gf7757129e3de #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: mld mld_ifc_work
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

