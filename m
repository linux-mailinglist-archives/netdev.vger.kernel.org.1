Return-Path: <netdev+bounces-97961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51178CE584
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 14:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B11E2829FF
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 12:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831E586273;
	Fri, 24 May 2024 12:51:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACAE86250
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555089; cv=none; b=jreeZ+FtYMd/EXWxdKityOoclWNMbmA+tX23lZHv8Xi/dEbumCG/bDFeRbyk4rzbn9sDxFMylDqdL/4+stfieKHNZTXi2aG2pwP6ctq1u34nvZc7tQVzH5j1VjH8WTeJY4jws2SarrbxQftLkqwXa6j7IjzwnjU5z7vOUqpWVh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555089; c=relaxed/simple;
	bh=EqnsROPwTP3ntkopFkdrZelWoz/7Hj+16Nwvgg65sKg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fFFCXj4bfa5NClfHPprJyZvG79BhShYb2EtSHhwsOYfa9gczDjpzuOOFmsL8xpEGlZHYogrG6uTEa9HfYlJjLxmSdPr8QzO9fXwgjrEbwQO5w4FVFcDj2VfawwQg/gcLmZJxJpk3HY8HXRfIDVRdK9hMAMuxFl8pxPOYxO0OwjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-372f268d124so26363125ab.1
        for <netdev@vger.kernel.org>; Fri, 24 May 2024 05:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716555087; x=1717159887;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWR8v6vD/ml9vWdL1nuV53C5OuiUbXhFWnnf57JGgQk=;
        b=FMJvrBPDR+9tifDA2vfyOf2uwhifApaLfFgQ3ggtdHVGP53JMIgLwAOVeNxFIP2f00
         VtZ1vylTRRzJTd8Cv4eTRwGE1v/nC9QSLYYY8TutySlARCoNeEzjnoiu3Bv7DVCcFl7Y
         syFAn8zHLEkgh53XehlERl+c/kh/frGufBEnbDDl8Xik1aRgw0/V0UCT2fRY0nhfAx/C
         9a1SE3KICEj2MEUZLWqeNo3isiMtoCnSpmcbv7Qt+ydLSgAgxcp71aPLbV0JGQ6qXDPB
         SAX+VErDxS8SQEoZDWXFpi/CEYSXTn4kGsQmoglfsDuuGomTWP2Yu5JgUaURsgzhBYCn
         gaPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp8P/g93HoVf7nnMxiOSCVu6LkBBebZxSlXgn4pM3gyW2xnNPMU0hfXsuckx++YvTPvsysAra7NMUit4GChBTTA/a6iVlw
X-Gm-Message-State: AOJu0Yzi4t+MOoBw+DvjjWzWzaD7lzGphxJes7zwY2QlaKrO3RjY1MM1
	FnV47nTmBG0pxPiq7refidrxmItLrxs5m3Wc4gycDR4c7LsVGJfPngOuhBDSMcnAvphg9JB3maK
	s7Vnc9tudOzytHi0QDPWxNwrtExPvwcJ9NDAisAmHJF0cPo6HvK0E0a8=
X-Google-Smtp-Source: AGHT+IE1JjcpjaC2BHnwYpKEH7AuYjloe9wjM4YYnL2XHbMZ/dpvGBz6q/CpNKjGQ+cByz1cp/TWPBDwuHY7CRbbM77uGI0dct+4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9b:b0:36f:c675:fe8e with SMTP id
 e9e14a558f8ab-3737b350f33mr2429995ab.4.1716555087179; Fri, 24 May 2024
 05:51:27 -0700 (PDT)
Date: Fri, 24 May 2024 05:51:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035941f061932a077@google.com>
Subject: [syzbot] [net?] KMSAN: kernel-infoleak in __skb_datagram_iter (4)
From: syzbot <syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    101b7a97143a Merge tag 'acpi-6.10-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15633df4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ac2f8c387a23814
dashboard link: https://syzkaller.appspot.com/bug?extid=0c85cae3350b7d486aee
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4f673334a91c/disk-101b7a97.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8e6db59f4091/vmlinux-101b7a97.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7e5782387c9d/bzImage-101b7a97.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:29 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:271 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x366/0x24b0 lib/iov_iter.c:185
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 copy_to_user_iter lib/iov_iter.c:24 [inline]
 iterate_ubuf include/linux/iov_iter.h:29 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 _copy_to_iter+0x366/0x24b0 lib/iov_iter.c:185
 copy_to_iter include/linux/uio.h:196 [inline]
 simple_copy_to_iter net/core/datagram.c:532 [inline]
 __skb_datagram_iter+0x185/0x1000 net/core/datagram.c:420
 skb_copy_datagram_iter+0x5c/0x200 net/core/datagram.c:546
 skb_copy_datagram_msg include/linux/skbuff.h:4070 [inline]
 netlink_recvmsg+0x432/0x1610 net/netlink/af_netlink.c:1962
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x2c4/0x340 net/socket.c:1068
 ____sys_recvmsg+0x18a/0x620 net/socket.c:2803
 ___sys_recvmsg+0x223/0x840 net/socket.c:2845
 __sys_recvmsg net/socket.c:2875 [inline]
 __do_sys_recvmsg net/socket.c:2885 [inline]
 __se_sys_recvmsg net/socket.c:2882 [inline]
 __x64_sys_recvmsg+0x304/0x4a0 net/socket.c:2882
 x64_sys_call+0x38ff/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:48
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 pskb_expand_head+0x30f/0x19d0 net/core/skbuff.c:2271
 netlink_trim+0x2c2/0x330 net/netlink/af_netlink.c:1317
 netlink_broadcast_filtered+0x82/0x23b0 net/netlink/af_netlink.c:1523
 nlmsg_multicast_filtered include/net/netlink.h:1111 [inline]
 nlmsg_multicast include/net/netlink.h:1130 [inline]
 nlmsg_notify+0x15f/0x2f0 net/netlink/af_netlink.c:2602
 rtnl_notify+0xc3/0xf0 net/core/rtnetlink.c:757
 wireless_nlevent_flush net/wireless/wext-core.c:354 [inline]
 wireless_nlevent_process+0xfe/0x250 net/wireless/wext-core.c:414
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3348
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3429
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 wireless_send_event+0x566/0x1020 net/wireless/wext-core.c:580
 ioctl_standard_iw_point+0x12e5/0x13c0
 compat_standard_call+0x179/0x310 net/wireless/wext-core.c:1110
 wext_ioctl_dispatch+0x234/0xa30 net/wireless/wext-core.c:1016
 compat_wext_handle_ioctl+0x1ae/0x2f0 net/wireless/wext-core.c:1139
 compat_sock_ioctl+0x26b/0x1370 net/socket.c:3525
 __do_compat_sys_ioctl fs/ioctl.c:1004 [inline]
 __se_compat_sys_ioctl+0x791/0x1090 fs/ioctl.c:947
 __ia32_compat_sys_ioctl+0x93/0xe0 fs/ioctl.c:947
 ia32_sys_call+0x1481/0x40a0 arch/x86/include/generated/asm/syscalls_32.h:55
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb4/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Local variable iwp created at:
 compat_standard_call+0x48/0x310 net/wireless/wext-core.c:1097
 wext_ioctl_dispatch+0x234/0xa30 net/wireless/wext-core.c:1016

Bytes 60-63 of 64 are uninitialized
Memory access of size 64 starts at ffff88804af03180
Data copied to user address 00007fff5690c968

CPU: 0 PID: 4697 Comm: dhcpcd Tainted: G        W          6.9.0-syzkaller-02339-g101b7a97143a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
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

