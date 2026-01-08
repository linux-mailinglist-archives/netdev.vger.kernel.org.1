Return-Path: <netdev+bounces-248031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DD0D026E2
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 12:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60F14302DC9E
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 11:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA1F45C3AD;
	Thu,  8 Jan 2026 10:16:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402E344D685
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867384; cv=none; b=uCRysUUy+ljfXkj6ndBcEDaqBxY4mukTD6YTq3kU2WBfjFHF2EofGLoMaJY4WpnFvQdnzaYEmID6ddPMXzBkmVwT5cI61C1q0WiIjbnJT3bAKqjwf5R3B2yIfNJFxW9Ae0C52qedfnXpybaYHzkvgAp1eutqXpfMJdFU5hiZb2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867384; c=relaxed/simple;
	bh=r46TeTAsvXLyudt9PQ5TJmUtz6XZj6rTn/Rg5C2jtIw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cgWZdPOfpwAP1DlslTWSVPjhit5XLe0WZgkJVHvc2ZDno/gd0mWTj2uOq7wWF9PShqTcTfW1uxdPLuBBzFp7/T2c3faGV+WUo81DU/sCyI5vMtvzLERYKyWwEZ76vm1txTtVsg4T2sWBNzkF2RPTcCmHqI5a/N8XpbLgzNJ56Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4512e9f2f82so5613245b6e.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 02:16:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767867379; x=1768472179;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HfzHvGppm2YPB7GFJv3lvZRdv00vKd6q9SmsqIhkZt4=;
        b=dFi+SV4W0BRTgIPsxIXLTZUUbEEDTmVAABTbUTRWV/nWyEUD5iJyrSnyOsXmNH+TwE
         jXmDXqb0MZKlZq+RwEDBvnVD8GiO3b/eebsFoWX3D0NQAlJzxb6uHKVjRC7p5vagg4th
         uIWFskTYfuoDpQmtkF1FOsGZKEh2SQnAQb1Fzepu7+fTsvXmsiD/ND5ten29GIXJ4/ib
         ZhRqngbBc9vg1mmVKoI3S4TJRpqMXl4+THGhhXap8x6QcHrrqHFL8hQZHadcxrUUDoOf
         0QcSzpGYgfVxUVm1I7pPG8OKyqDV3c4J9klgu4aucDD4gWcJTdXV+MIDt/5jM5z2Fat4
         68XA==
X-Forwarded-Encrypted: i=1; AJvYcCWwcgQhPyQtkkyq39skHQCpB4zyt1gu71mcNeXSSdFe8KiBSjEK7wkFn8V3wlB/ne7eR5vtxNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK2KIo88ieJzBnIFdpK2YgZqzqVPx+ICcKLzhuE3RLmPEvG29Z
	/pVvf7NT6svzpur8oJMa0aQucwrU5FjqOvA53zqGKhvOvdqdQ8hMjRjx/fPOOuE1n9tT2P/9LN9
	lA48kQdU9Xc+rjdVQsWzot2c8tPTKEs7we3GTn7ZEBHNnihqoxRcZWy1EzmE=
X-Google-Smtp-Source: AGHT+IGlG9xMD/Xg43vd6VzYzy/bP8Xcm+nWbQlnZVG1oqAohaZtzbuXMPHk7W4Hw07khUgFjwxb+gmfZ2h9K/mOj5AnkwCpX6vv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:a1a1:b0:65b:29af:b562 with SMTP id
 006d021491bc7-65f5508542emr1552625eaf.77.1767867379436; Thu, 08 Jan 2026
 02:16:19 -0800 (PST)
Date: Thu, 08 Jan 2026 02:16:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695f83f3.050a0220.1c677c.0392.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: kernel-infoleak in __skb_datagram_iter (5)
From: syzbot <syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f0b9d8eb98df Merge tag 'nfsd-6.19-3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f9be9a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3903bdf68407a14
dashboard link: https://syzkaller.appspot.com/bug?extid=bfc7323743ca6dbcc3d3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d9ff9c5037b8/disk-f0b9d8eb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b3c97cb6b38c/vmlinux-f0b9d8eb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d523f5e33ff5/bzImage-f0b9d8eb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:30 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:302 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:330 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_iter+0xef3/0x33f0 lib/iov_iter.c:197
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 copy_to_user_iter lib/iov_iter.c:24 [inline]
 iterate_ubuf include/linux/iov_iter.h:30 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:302 [inline]
 iterate_and_advance include/linux/iov_iter.h:330 [inline]
 _copy_to_iter+0xef3/0x33f0 lib/iov_iter.c:197
 copy_to_iter include/linux/uio.h:220 [inline]
 simple_copy_to_iter net/core/datagram.c:521 [inline]
 __skb_datagram_iter+0x196/0x12c0 net/core/datagram.c:402
 skb_copy_datagram_iter+0x5b/0x1e0 net/core/datagram.c:535
 skb_copy_datagram_msg include/linux/skbuff.h:4217 [inline]
 netlink_recvmsg+0x4bb/0xfe0 net/netlink/af_netlink.c:1951
 sock_recvmsg_nosec net/socket.c:1078 [inline]
 sock_recvmsg+0x2df/0x390 net/socket.c:1100
 ____sys_recvmsg+0x193/0x610 net/socket.c:2812
 ___sys_recvmsg+0x20b/0x850 net/socket.c:2854
 __sys_recvmsg net/socket.c:2887 [inline]
 __do_sys_recvmsg net/socket.c:2893 [inline]
 __se_sys_recvmsg net/socket.c:2890 [inline]
 __x64_sys_recvmsg+0x20e/0x3d0 net/socket.c:2890
 x64_sys_call+0x38b7/0x3e70 arch/x86/include/generated/asm/syscalls_64.h:48
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd3/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 pskb_expand_head+0x310/0x15d0 net/core/skbuff.c:2290
 netlink_trim+0x3a3/0x450 net/netlink/af_netlink.c:1299
 netlink_broadcast_filtered+0x80/0x28f0 net/netlink/af_netlink.c:1512
 nlmsg_multicast_filtered include/net/netlink.h:1165 [inline]
 nlmsg_multicast include/net/netlink.h:1184 [inline]
 nlmsg_notify+0x15b/0x2f0 net/netlink/af_netlink.c:2593
 rtnl_notify+0xba/0x100 net/core/rtnetlink.c:958
 wireless_nlevent_flush net/wireless/wext-core.c:354 [inline]
 wireless_nlevent_process+0xfe/0x290 net/wireless/wext-core.c:414
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xb91/0x1d80 kernel/workqueue.c:3340
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3421
 kthread+0xd5c/0xf00 kernel/kthread.c:463
 ret_from_fork+0x208/0x710 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Uninit was stored to memory at:
 wireless_send_event+0x652/0x1540 net/wireless/wext-core.c:580
 ioctl_standard_iw_point+0x12b0/0x13f0 net/wireless/wext-core.c:896
 compat_standard_call+0x188/0x4c0 net/wireless/wext-core.c:1108
 wireless_process_ioctl net/wireless/wext-core.c:-1 [inline]
 wext_ioctl_dispatch+0x192/0x7a0 net/wireless/wext-core.c:1014
 compat_wext_handle_ioctl+0x1a1/0x300 net/wireless/wext-core.c:1137
 compat_sock_ioctl+0x20c/0xff0 net/socket.c:3530
 __do_compat_sys_ioctl fs/ioctl.c:695 [inline]
 __se_compat_sys_ioctl fs/ioctl.c:638 [inline]
 __ia32_compat_sys_ioctl+0x7f9/0x1270 fs/ioctl.c:638
 ia32_sys_call+0x25d9/0x4340 arch/x86/include/generated/asm/syscalls_32.h:55
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x154/0x320 arch/x86/entry/syscall_32.c:307
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:332
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:370
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Local variable iwp created at:
 compat_standard_call+0x4a/0x4c0 net/wireless/wext-core.c:1095
 wireless_process_ioctl net/wireless/wext-core.c:-1 [inline]
 wext_ioctl_dispatch+0x192/0x7a0 net/wireless/wext-core.c:1014

Bytes 60-63 of 64 are uninitialized
Memory access of size 64 starts at ffff8881183ec000
Data copied to user address 00007ffe7d4a8260

CPU: 1 UID: 101 PID: 5458 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
=====================================================


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

