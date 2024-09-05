Return-Path: <netdev+bounces-125648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D59396E0BC
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 19:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4441F2509E
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 17:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA47C1A0AF4;
	Thu,  5 Sep 2024 17:03:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204341A0707
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555815; cv=none; b=FdWuG0IwZsrFYCnRwOxV2MtcB55+4ASwo3B5SG4ayNainFWkToN1X/ClBezqIoSUYXfVSlhAEt0NMyeDtZhvJx+udrAgsjjmoH0wa7YIm8Wv0neElej3k3TzlaZ1DaQJnLPCkOHAupbiSqDl/b4ooMstmoKE/Q7cODbo3TGk6Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555815; c=relaxed/simple;
	bh=fsdtgHQu5S+sGmX4XjmiO1zwvwOLPtFBcLTtq8gnQpo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YtBwNUQ15idHbf/XyslvzBFQRzpktibZ1PuIMcNesCnRKhPMfXEn5kqCRLkgYCgEPxT4OGM5+JONRPFMNfPNQaVE9wNybz6/xk2XS8mvSrzBAc6aIt+W7uLgUzFpSDgLYvUgc8w4uj0PbsairIsimAEgyNE5ooLsuAm7qJlGI70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d55a00bd7so28489975ab.1
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 10:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725555813; x=1726160613;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ICQ0YqUAuBCDVOBEFVxSd7r2rupOA9lJI8jrGUESHbY=;
        b=UnhDCm5X+U2uoJIURuzh82/tXpqxe4LvLPdT/Bhc+/2X8mRe5KIZkGImDFriRylqPU
         O+YZTBLMmhwHzhv0HxJp6OBgvEgQwOLFgUWNz5nXzV0MAG12ANEPOo51XEr2cN+MGFcw
         7NnoUYXBv8ocipKN8K/klZ67HmK730XDEJq1K/0xqk0NrTputw0wMtXRA/l4Zvbo18wT
         MK61jlZF6d/xJwhTXZArViAEA0LRKvY3igLifXQBivqKcuFgJkh1Xw9VwbjgIcV3DOKw
         /dIlBCW84c6Zv+nl2D+JeL0/I9UKsIlaXuonHUM6wd88j99n+802EPZRIcxs771Bq0It
         SbLw==
X-Forwarded-Encrypted: i=1; AJvYcCXTYJLXhXGIPnLoxFobxGin3J27la8OPV2Fny85xNgat78fbH1s1r1/ljtL9fPYI7DUU08jzt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4vrc+OX4lY/SLg/b25n/0eYyuvjuDNRC6GLehT2D47sBaxcO2
	Gk0+3flc+eeb+iorZneIRjuiqGZ7SVLW1xnKEiVGw8JeSLtdqrV5SOr7eL4MiNLKZRfeta57TCH
	OYdZhcoGedDrCDQ9VRTOvWd3NA6nQTJleuFx7jeQnMqG0DkW20yiKJLc=
X-Google-Smtp-Source: AGHT+IFYRWYkcvChLrkvOANUiRcQCLrZIdD+dFvMb+kbcd5lkJ6kfExWmqX1DHM/95PiKmt9yMf0EBmeawpU8sKWE8nNizjizfkz
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c2:b0:377:1625:5fca with SMTP id
 e9e14a558f8ab-39f40ee300emr6574465ab.1.1725555813052; Thu, 05 Sep 2024
 10:03:33 -0700 (PDT)
Date: Thu, 05 Sep 2024 10:03:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047043b0621624565@google.com>
Subject: [syzbot] [mptcp?] possible deadlock in sk_clone_lock (3)
From: syzbot <syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martineau@kernel.org, 
	matttbe@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    67784a74e258 Merge tag 'ata-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1631e529980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=f4aacdfef2c6a6529c3e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e6cf2b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171c1f2b980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-67784a74.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e2f2583cf0b1/vmlinux-67784a74.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0fedd864addd/bzImage-67784a74.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.11.0-rc6-syzkaller-00019-g67784a74e258 #0 Not tainted
--------------------------------------------
syz-executor364/5113 is trying to acquire lock:
ffff8880449f1958 (k-slock-AF_INET){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff8880449f1958 (k-slock-AF_INET){+.-.}-{2:2}, at: sk_clone_lock+0x2cd/0xf40 net/core/sock.c:2328

but task is already holding lock:
ffff88803fe3cb58 (k-slock-AF_INET){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff88803fe3cb58 (k-slock-AF_INET){+.-.}-{2:2}, at: sk_clone_lock+0x2cd/0xf40 net/core/sock.c:2328

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(k-slock-AF_INET);
  lock(k-slock-AF_INET);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

7 locks held by syz-executor364/5113:
 #0: ffff8880449f0e18 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1607 [inline]
 #0: ffff8880449f0e18 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg+0x153/0x1b10 net/mptcp/protocol.c:1806
 #1: ffff88803fe39ad8 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1607 [inline]
 #1: ffff88803fe39ad8 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg_fastopen+0x11f/0x530 net/mptcp/protocol.c:1727
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: __ip_queue_xmit+0x5f/0x1b80 net/ipv4/ip_output.c:470
 #3: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #3: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #3: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: ip_finish_output2+0x45f/0x1390 net/ipv4/ip_output.c:228
 #4: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 #4: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: process_backlog+0x33b/0x15b0 net/core/dev.c:6104
 #5: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #5: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #5: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: ip_local_deliver_finish+0x230/0x5f0 net/ipv4/ip_input.c:232
 #6: ffff88803fe3cb58 (k-slock-AF_INET){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #6: ffff88803fe3cb58 (k-slock-AF_INET){+.-.}-{2:2}, at: sk_clone_lock+0x2cd/0xf40 net/core/sock.c:2328

stack backtrace:
CPU: 0 UID: 0 PID: 5113 Comm: syz-executor364 Not tainted 6.11.0-rc6-syzkaller-00019-g67784a74e258 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_deadlock kernel/locking/lockdep.c:3061 [inline]
 validate_chain+0x15d3/0x5900 kernel/locking/lockdep.c:3855
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 sk_clone_lock+0x2cd/0xf40 net/core/sock.c:2328
 mptcp_sk_clone_init+0x32/0x13c0 net/mptcp/protocol.c:3279
 subflow_syn_recv_sock+0x931/0x1920 net/mptcp/subflow.c:874
 tcp_check_req+0xfe4/0x1a20 net/ipv4/tcp_minisocks.c:853
 tcp_v4_rcv+0x1c3e/0x37f0 net/ipv4/tcp_ipv4.c:2267
 ip_protocol_deliver_rcu+0x22e/0x440 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x341/0x5f0 net/ipv4/ip_input.c:233
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 __netif_receive_skb_one_core net/core/dev.c:5661 [inline]
 __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5775
 process_backlog+0x662/0x15b0 net/core/dev.c:6108
 __napi_poll+0xcb/0x490 net/core/dev.c:6772
 napi_poll net/core/dev.c:6841 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6963
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:908 [inline]
 __dev_queue_xmit+0x1763/0x3e90 net/core/dev.c:4450
 dev_queue_xmit include/linux/netdevice.h:3105 [inline]
 neigh_hh_output include/net/neighbour.h:526 [inline]
 neigh_output include/net/neighbour.h:540 [inline]
 ip_finish_output2+0xd41/0x1390 net/ipv4/ip_output.c:235
 ip_local_out net/ipv4/ip_output.c:129 [inline]
 __ip_queue_xmit+0x118c/0x1b80 net/ipv4/ip_output.c:535
 __tcp_transmit_skb+0x2544/0x3b30 net/ipv4/tcp_output.c:1466
 tcp_rcv_synsent_state_process net/ipv4/tcp_input.c:6542 [inline]
 tcp_rcv_state_process+0x2c32/0x4570 net/ipv4/tcp_input.c:6729
 tcp_v4_do_rcv+0x77d/0xc70 net/ipv4/tcp_ipv4.c:1934
 sk_backlog_rcv include/net/sock.h:1111 [inline]
 __release_sock+0x214/0x350 net/core/sock.c:3004
 release_sock+0x61/0x1f0 net/core/sock.c:3558
 mptcp_sendmsg_fastopen+0x1ad/0x530 net/mptcp/protocol.c:1733
 mptcp_sendmsg+0x1884/0x1b10 net/mptcp/protocol.c:1812
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x1a6/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmmsg+0x3b2/0x740 net/socket.c:2737
 __do_sys_sendmmsg net/socket.c:2766 [inline]
 __se_sys_sendmmsg net/socket.c:2763 [inline]
 __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2763
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f04fb13a6b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd651f42d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f04fb13a6b9
RDX: 0000000000000001 RSI: 0000000020000d00 RDI: 0000000000000004
RBP: 00007ffd651f4310 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000020000080 R11: 0000000000000246 R12: 00000000000f4240
R13: 00007f04fb187449 R14: 00007ffd651f42f4 R15: 00007ffd651f4300
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

