Return-Path: <netdev+bounces-154021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 220E49FAD57
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 11:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA48160BCF
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 10:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3636194A45;
	Mon, 23 Dec 2024 10:53:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4931D191F6A
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734951219; cv=none; b=ZAKlDp2ZUflA2jUtEqNACw1IBs8amPO2TDc+udcv6e+/3u9/MuLnXtz1mDorHOi6Y+baWrGfGl4n/khJUKglhagNByiySlErJGTROiPiGlGnDcrPJ6VhSnIen/mYgeB0MUGseNh9xA4yairqEnRtoHzvRuPa0xSfCWMkCN7O1G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734951219; c=relaxed/simple;
	bh=byGfmgL8scdKv3oZV+gHl79TAQ9vq3AOLvOMN9yVSsI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bh7ef6xUAee1zyshzRqVRVcOhNj4RAtVe2WApOrc7iK19kmX6sl0C8nRxHOHR54A3OK6NY4i7mceaf761XLMmdxpzkZTqZMkFuCbrgryDz24tR3YOyCnDBPYJNMFsMZssRG0ZsoOmtsY7Ptofibt9FDlKIQV0pRXvu54PxBqLxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-844e344b0b5so383581539f.0
        for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 02:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734951217; x=1735556017;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oC1UB04wXEhMr7oMko5jz84KWfb8+hsvIGPpbBG+RNs=;
        b=Gx27lFlv6P1P+1Hhike2hVkg6aozrz6GapEdvJ1O+Qf2/aQjBtDKUezx2wHHrd1aex
         9vTRMljYVd+HTlsw9cK/2JYTdjRvspqEVpNJXLvqvJBZT0VphyHCs4Z5OPB9MjwpgkoJ
         7OBHwictVEN8KFygknSG64thQhphbcVjArjqO6SWWTZibQ7CDmHPSogpcfpC1brIxhZQ
         niP/84c/ngN33fWEKrkUtDYxgtfxhocTM1Nc9vg9vBZ/MMSS96nnjrYMQblr8XiQzXl1
         E3eiWPxiSXqPm5TYXH2n8ZjLMoBLTsUNQAA94DE6l3nkD3FdQbhL2oV7t724U3ZmBukz
         WDMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuWSXi4gt5A3wNC7RXwwhCs1/Brp4VUG5Q8KgPzqpkocg2TjI61Ykntf/2O4ixK7HdfcNLkeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlHhG10+8XSDokFe/DfCmkSnG8QRDmAukoL7JXWeglwSH99Mpm
	NgZh1OI2VERwqfwkydxZg7yl2gBfkz31kZ/peFu7J67CLBVuaf/Sh1TaCODYupP+Q1ko9xxG8Uz
	HIMv7jbsat5CyutzvJHxVeMDLmVguE7ns0S66G/0Ljz9dGGB9MoaQZR4=
X-Google-Smtp-Source: AGHT+IGIn0HcjXCgfiQSEnWSpZiPtsMmzSkVYi3wt9a66Op+hwBvm7QfpxIRZ9GVpK8hNIbzkiXLHbGJ6nvfi/SJc+eSqJG6WIbO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1caf:b0:3a7:c5ff:e60b with SMTP id
 e9e14a558f8ab-3c2d1f74a78mr107727275ab.6.1734951217470; Mon, 23 Dec 2024
 02:53:37 -0800 (PST)
Date: Mon, 23 Dec 2024 02:53:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67694131.050a0220.2f3838.0035.GAE@google.com>
Subject: [syzbot] [net?] UBSAN: array-index-out-of-bounds in cake_enqueue (2)
From: syzbot <syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com>
To: cake@lists.bufferbloat.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, toke@toke.dk, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    573067a5a685 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17556f30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd7202b56d469648
dashboard link: https://syzkaller.appspot.com/bug?extid=f63600d288bfb7057424
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d3b5c855aa0/disk-573067a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c06fc1ead83/vmlinux-573067a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3390e59b9e4b/Image-573067a5.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in net/sched/sch_cake.c:1862:6
index 65535 is out of range for type 'u16[1025]' (aka 'unsigned short[1025]')
CPU: 1 UID: 0 PID: 8219 Comm: syz.0.325 Not tainted 6.13.0-rc3-syzkaller-g573067a5a685 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0xf8/0x148 lib/ubsan.c:429
 cake_enqueue+0x6000/0x78d4 net/sched/sch_cake.c:1862
 dev_qdisc_enqueue+0x60/0x374 net/core/dev.c:3793
 __dev_xmit_skb net/core/dev.c:3889 [inline]
 __dev_queue_xmit+0xbe4/0x35b4 net/core/dev.c:4400
 dev_queue_xmit include/linux/netdevice.h:3168 [inline]
 packet_xmit+0x6c/0x318 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3146 [inline]
 packet_sendmsg+0x3ca8/0x52fc net/packet/af_packet.c:3178
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg net/socket.c:726 [inline]
 __sys_sendto+0x360/0x4d8 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __arm64_sys_sendto+0xd8/0xf8 net/socket.c:2200
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
---[ end trace ]---
FAULT_INJECTION: forcing a failure.
name fail_usercopy, interval 1, probability 0, space 0, times 0
CPU: 1 UID: 0 PID: 8219 Comm: syz.0.325 Not tainted 6.13.0-rc3-syzkaller-g573067a5a685 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 fail_dump lib/fault-inject.c:53 [inline]
 should_fail_ex+0x3b0/0x50c lib/fault-inject.c:154
 should_fail+0x14/0x24 lib/fault-inject.c:164
 should_fail_usercopy+0x20/0x30 lib/fault-inject-usercopy.c:37
 _inline_copy_to_user include/linux/uaccess.h:193 [inline]
 copy_to_user include/linux/uaccess.h:223 [inline]
 simple_read_from_buffer+0xd4/0x248 fs/libfs.c:1128
 proc_fail_nth_read+0x134/0x1a0 fs/proc/base.c:1482
 vfs_read+0x22c/0x970 fs/read_write.c:563
 ksys_read+0x15c/0x26c fs/read_write.c:708
 __do_sys_read fs/read_write.c:717 [inline]
 __se_sys_read fs/read_write.c:715 [inline]
 __arm64_sys_read+0x7c/0x90 fs/read_write.c:715
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600


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

