Return-Path: <netdev+bounces-187599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B598AA8096
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 14:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2A3462EDE
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 12:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4511F1921;
	Sat,  3 May 2025 12:11:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2EB1F1539
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746274291; cv=none; b=HNr+alGKNEhS3z9oz2dNGB9dNaHjo4daJYNJmVp7hSWINYDZ621kiJvgwOlditCnaUuFaKxUYCR7dDEvbPaPtWhBqvwUZl5HxNeDINxBKIxuROh1/4gcSpsptNy1a38abUdrWnQJ/b8MPDkuKHk0XJe9ei82QzgFGNAT5YwhIOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746274291; c=relaxed/simple;
	bh=6fTHyu9bRz7JFDb3svNNwfepCkjZ1lsZANKZ+jhYnjE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BLLrnS/uUNDNMsMxbLWB2eM9DdNOAwCSyrInY3m0pemDdaxxNQrz9LyPOuSZVGyty6UwOTwGEb3Bef4ISzjtZol7jg31IFco2eSJ/SDk6H64hVPrR4+K0WWZmzHGORfSSjKYiO5zaKkj4hO6mNDt+HQU3P1NQX6OKhLNEawsmX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-85b5a7981ccso261026839f.2
        for <netdev@vger.kernel.org>; Sat, 03 May 2025 05:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746274288; x=1746879088;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xpICkILdajduER/YLuCCCNObz/t1lP6UyNT/xJlM5rY=;
        b=kj5uwvF3GR6BFhc9Ffz16s3RrbJTBvrfrYGK1Wo0+zNz/Xj91uL3hbDKUwP2a9x9D0
         ShApLDi4lv4dWmyIiYyt9sbjPllbnrXLEx8R1NykGmbiTBng2jvgEDwNKAHj8g+BMsKa
         fnLbIViNQTacXkw12NA5+VkueObyeYgPXTH0M2+2m0qJ3jjzwh3zjkw7pxg/yl5YuTrn
         GZmMuhchq9CE7cr8j/4h79SIJ7Lj2I/c4dtjLm9qGV/M7i7f3l1QnvlXZadnazekiVUe
         csKy/JK2EliTc1RUW6DF73rSyiuHyiFGcWv6lnKkYr0DOBsv5jdCAQLFYAMm5A1kc2nH
         ZFTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAE53wfF9TxSb/86SoIHHrb6mWPp9U6QztNDiq8FkEz1jFJ6Clw1EYy8qFX31m+UywNH35hK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH4zi8bic5RPV+yim6JKObV8U0f+eKDVDUotXnC6xdxwARJeuQ
	gMvKAbwq9AjCzen5JPRZSA6g4OST44MYKDweMKxCovEn/idsecCc5Cet5c4RZZFd72D9FkQnarW
	NNX3IL3VTlkm9o3ZwB8TQxeqbtjfTJ4r95tXuBIEFa2E3UHpp2zo2o7U=
X-Google-Smtp-Source: AGHT+IEA4eq27hApebar8OS4dbm0j62fWqYJiIuVwPD6OA9pwNTVqN+a0MBkk1tasN0/jYrN24P5m3TQeDg1RHD9QIH/3drZ+27j
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0a:b0:3d3:d994:e92e with SMTP id
 e9e14a558f8ab-3da5b31e5e4mr6002615ab.17.1746274288749; Sat, 03 May 2025
 05:11:28 -0700 (PDT)
Date: Sat, 03 May 2025 05:11:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681607f0.a70a0220.254cdc.001a.GAE@google.com>
Subject: [syzbot] [usb?] [net?] BUG: using smp_processor_id() in preemptible
 code in usbnet_skb_return
From: syzbot <syzbot+efc5e3c9e61a69ecf48f@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    615dca38c2ea Merge 6.15-rc4 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=118108d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9354c815d9df4c56
dashboard link: https://syzkaller.appspot.com/bug?extid=efc5e3c9e61a69ecf48f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5780386f6283/disk-615dca38.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f6f6640257e/vmlinux-615dca38.xz
kernel image: https://storage.googleapis.com/syzbot-assets/23030a651560/bzImage-615dca38.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+efc5e3c9e61a69ecf48f@syzkaller.appspotmail.com

BUG: using smp_processor_id() in preemptible [00000000] code: dhcpcd/2879
caller is usbnet_skb_return+0x74/0x490 drivers/net/usb/usbnet.c:331
CPU: 1 UID: 0 PID: 2879 Comm: dhcpcd Not tainted 6.15.0-rc4-syzkaller-00098-g615dca38c2ea #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 check_preemption_disabled+0xd0/0xe0 lib/smp_processor_id.c:49
 usbnet_skb_return+0x74/0x490 drivers/net/usb/usbnet.c:331
 usbnet_resume_rx+0x4b/0x170 drivers/net/usb/usbnet.c:708
 usbnet_change_mtu+0x1be/0x220 drivers/net/usb/usbnet.c:417
 __dev_set_mtu net/core/dev.c:9443 [inline]
 netif_set_mtu_ext+0x369/0x5c0 net/core/dev.c:9496
 netif_set_mtu+0xb0/0x160 net/core/dev.c:9520
 dev_set_mtu+0xae/0x170 net/core/dev_api.c:247
 dev_ifsioc+0xa31/0x18d0 net/core/dev_ioctl.c:572
 dev_ioctl+0x223/0x10e0 net/core/dev_ioctl.c:821
 sock_do_ioctl+0x19d/0x280 net/socket.c:1204
 sock_ioctl+0x42f/0x6a0 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe33dfabd49
Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
RSP: 002b:00007fff83666778 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe33dedd6c0 RCX: 00007fe33dfabd49
RDX: 00007fff83676968 RSI: 0000000000008922 RDI: 0000000000000005
RBP: 00007fff83686b28 R08: 00007fff83676928 R09: 00007fff836768d8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff83676968 R14: 0000000000000028 R15: 0000000000008922
 </TASK>
BUG: using smp_processor_id() in preemptible [00000000] code: dhcpcd/2879
caller is usbnet_skb_return+0x74/0x490 drivers/net/usb/usbnet.c:331
CPU: 1 UID: 0 PID: 2879 Comm: dhcpcd Not tainted 6.15.0-rc4-syzkaller-00098-g615dca38c2ea #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 check_preemption_disabled+0xd0/0xe0 lib/smp_processor_id.c:49
 usbnet_skb_return+0x74/0x490 drivers/net/usb/usbnet.c:331
 usbnet_resume_rx+0x4b/0x170 drivers/net/usb/usbnet.c:708
 usbnet_change_mtu+0x1be/0x220 drivers/net/usb/usbnet.c:417
 __dev_set_mtu net/core/dev.c:9443 [inline]
 netif_set_mtu_ext+0x369/0x5c0 net/core/dev.c:9496
 netif_set_mtu+0xb0/0x160 net/core/dev.c:9520
 dev_set_mtu+0xae/0x170 net/core/dev_api.c:247
 dev_ifsioc+0xa31/0x18d0 net/core/dev_ioctl.c:572
 dev_ioctl+0x223/0x10e0 net/core/dev_ioctl.c:821
 sock_do_ioctl+0x19d/0x280 net/socket.c:1204
 sock_ioctl+0x42f/0x6a0 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe33dfabd49
Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
RSP: 002b:00007fff83666778 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe33dedd6c0 RCX: 00007fe33dfabd49
RDX: 00007fff83676968 RSI: 0000000000008922 RDI: 0000000000000005
RBP: 00007fff83686b28 R08: 00007fff83676928 R09: 00007fff836768d8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff83676968 R14: 0000000000000028 R15: 0000000000008922
 </TASK>
BUG: using smp_processor_id() in preemptible [00000000] code: dhcpcd/2879
caller is usbnet_skb_return+0x74/0x490 drivers/net/usb/usbnet.c:331
CPU: 1 UID: 0 PID: 2879 Comm: dhcpcd Not tainted 6.15.0-rc4-syzkaller-00098-g615dca38c2ea #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 check_preemption_disabled+0xd0/0xe0 lib/smp_processor_id.c:49
 usbnet_skb_return+0x74/0x490 drivers/net/usb/usbnet.c:331
 usbnet_resume_rx+0x4b/0x170 drivers/net/usb/usbnet.c:708
 usbnet_change_mtu+0x1be/0x220 drivers/net/usb/usbnet.c:417
 __dev_set_mtu net/core/dev.c:9443 [inline]
 netif_set_mtu_ext+0x369/0x5c0 net/core/dev.c:9496
 netif_set_mtu+0xb0/0x160 net/core/dev.c:9520
 dev_set_mtu+0xae/0x170 net/core/dev_api.c:247
 dev_ifsioc+0xa31/0x18d0 net/core/dev_ioctl.c:572
 dev_ioctl+0x223/0x10e0 net/core/dev_ioctl.c:821
 sock_do_ioctl+0x19d/0x280 net/socket.c:1204
 sock_ioctl+0x42f/0x6a0 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe33dfabd49
Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
RSP: 002b:00007fff83666778 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe33dedd6c0 RCX: 00007fe33dfabd49
RDX: 00007fff83676968 RSI: 0000000000008922 RDI: 0000000000000005
RBP: 00007fff83686b28 R08: 00007fff83676928 R09: 00007fff836768d8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff83676968 R14: 0000000000000028 R15: 0000000000008922
 </TASK>
BUG: using smp_processor_id() in preemptible [00000000] code: dhcpcd/2879
caller is usbnet_skb_return+0x74/0x490 drivers/net/usb/usbnet.c:331
CPU: 1 UID: 0 PID: 2879 Comm: dhcpcd Not tainted 6.15.0-rc4-syzkaller-00098-g615dca38c2ea #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 check_preemption_disabled+0xd0/0xe0 lib/smp_processor_id.c:49
 usbnet_skb_return+0x74/0x490 drivers/net/usb/usbnet.c:331
 usbnet_resume_rx+0x4b/0x170 drivers/net/usb/usbnet.c:708
 usbnet_change_mtu+0x1be/0x220 drivers/net/usb/usbnet.c:417
 __dev_set_mtu net/core/dev.c:9443 [inline]
 netif_set_mtu_ext+0x369/0x5c0 net/core/dev.c:9496
 netif_set_mtu+0xb0/0x160 net/core/dev.c:9520
 dev_set_mtu+0xae/0x170 net/core/dev_api.c:247
 dev_ifsioc+0xa31/0x18d0 net/core/dev_ioctl.c:572
 dev_ioctl+0x223/0x10e0 net/core/dev_ioctl.c:821
 sock_do_ioctl+0x19d/0x280 net/socket.c:1204
 sock_ioctl+0x42f/0x6a0 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe33dfabd49
Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
RSP: 002b:00007fff83666778 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe33dedd6c0 RCX: 00007fe33dfabd49
RDX: 00007fff83676968 RSI: 0000000000008922 RDI: 0000000000000005
RBP: 00007fff83686b28 R08: 00007fff83676928 R09: 00007fff836768d8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff83676968 R14: 0000000000000028 R15: 0000000000008922
 </TASK>


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

