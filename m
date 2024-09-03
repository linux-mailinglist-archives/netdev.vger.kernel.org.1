Return-Path: <netdev+bounces-124388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5429692AC
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 06:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419781C20FAD
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 04:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5D51CDFAC;
	Tue,  3 Sep 2024 04:03:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066061A3026
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 04:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725336204; cv=none; b=D+fk3jr/UUIWCUwqEy6duY6ZBeaXAExS2LGwUfxZWq+EWs41lA2RRiP0pVtJl+0Pj1ha2KTytwrwNgM/adLHNlySM8Ewx10upGjz3XqinRiKIT4uQvNkUSbz0vfxbXAjalo5pHmJAFI7aeHXXE3WLgai5X8fNr0C5g21AC2x0iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725336204; c=relaxed/simple;
	bh=3DVyBQQSxw+DaF0Tvku13o9jnSR2iRYfV6GGKEvuAhY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o2kyjrf79VEaBlbI/9qwu5DxxxLm5hRHn9V0v37UYifc9lmRjUFtsT/c0UF+1jqAA6HbVUlyn5aY1H+ci6fRe+MsxgtVOeoxumrOLPhpqzFqva1jcqvPtMehhacqmy2zXmVweaVB1bQ3i76yccQ0+CnyKSNt/TJqG/jCmLmqK1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f510b3f81so20976285ab.0
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 21:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725336202; x=1725941002;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PRu/ehkcfoxHuabFtsJ4qkhHQn3xPQjo9rYWKQxBFPg=;
        b=Zr4inDd95RqU8modJy6eLe4qaTBD6t/vndhT+64qm3B3RTzB3Db96/Qa9oUzFJABaR
         mDCbeSup2A7SEx02yLFEHwnVZGEaW0oB7ej0aXUjsWratMgsgAVkvt+2G6Rw4uog3YM/
         1RFK+HnSjsksVz591ibdvxAWyMx5pBUJy9xo+sCiqn+DQNPHvW49cMza2XfoVMsZ/spy
         tKJBwzB4sn93ESRtI6rMxXof9Tn+ksK2me6jlxnfd8YwPaVIODQ9JCey1kk5kgywM+8E
         8ZyWJt8yLeMVT7cS4QY2+k0KYC1m2DDLOFmhRKcwqF1EXcT1psYlPUEBLgGEiMfAQsm8
         s6mw==
X-Forwarded-Encrypted: i=1; AJvYcCWiiPW7hq6nT0JTwxE8oRvPOVHJ8jJ/Wrf6YIf3GM3Qq0v/Zv2EF1JiESBPBvmhPEL6+HF6ThM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtvEVJSyJHr2h92xZ/d++TTIbUlVqvP6iBuOHfOpYZ/QOl0vgB
	2JoEAAF43qo1WCfyXqzAMzd0/3cXxBq8+P29zGbc4/GNu44/gYuWhU/N2UFQbKkGC4zxj/WOris
	j5BQzDk+P4jJcirJa0iGtM8Qyp7GFcuyhH7keLPD77HW2OvMo++qFZIE=
X-Google-Smtp-Source: AGHT+IFmd2CzI3jFIENT6kfyko0tux6vbzdEg6trD/WMvcO8cAfFSkHxcnH4zllEdGlSPNnJzcCy1OiNV5jI1oviTjo2nmjHC08V
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152d:b0:376:3fad:bb7c with SMTP id
 e9e14a558f8ab-39f38add4b3mr9096585ab.1.1725336202191; Mon, 02 Sep 2024
 21:03:22 -0700 (PDT)
Date: Mon, 02 Sep 2024 21:03:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073383906212f236a@google.com>
Subject: [syzbot] [usb?] WARNING in rtl8150_open/usb_submit_urb
From: syzbot <syzbot+d7e968426f644b567e31@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, petkan@nucleusys.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc88bb116179 usb: roles: add lockdep class key to struct u..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=17b89e97980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f470942baada45b1
dashboard link: https://syzkaller.appspot.com/bug?extid=d7e968426f644b567e31
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bb5463980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150ca88f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5b06342088f5/disk-fc88bb11.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e881a8c2cb53/vmlinux-fc88bb11.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4bf14d7b61d4/bzImage-fc88bb11.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7e968426f644b567e31@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 1 PID: 2586 at drivers/usb/core/urb.c:503 usb_submit_urb+0xe4b/0x1730 drivers/usb/core/urb.c:503
Modules linked in:
CPU: 1 UID: 0 PID: 2586 Comm: dhcpcd Not tainted 6.11.0-rc4-syzkaller-00069-gfc88bb116179 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:usb_submit_urb+0xe4b/0x1730 drivers/usb/core/urb.c:503
Code: 84 3c 02 00 00 e8 05 e4 fc fc 4c 89 ef e8 fd 25 d7 fe 45 89 e0 89 e9 4c 89 f2 48 89 c6 48 c7 c7 20 5d a0 87 e8 46 e6 c2 fc 90 <0f> 0b 90 90 e9 e9 f8 ff ff e8 d7 e3 fc fc 49 81 c4 c0 05 00 00 e9
RSP: 0018:ffffc9000441f740 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888112487a00 RCX: ffffffff811a99a9
RDX: ffff88810df6ba80 RSI: ffffffff811a99b6 RDI: 0000000000000001
RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
R13: ffff8881023bf0a8 R14: ffff888112452a20 R15: ffff888112487a7c
FS:  00007fc04eea5740(0000) GS:ffff8881f6300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0a1de9f870 CR3: 000000010dbd0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rtl8150_open+0x300/0xe30 drivers/net/usb/rtl8150.c:733
 __dev_open+0x2d4/0x4e0 net/core/dev.c:1474
 __dev_change_flags+0x561/0x720 net/core/dev.c:8838
 dev_change_flags+0x8f/0x160 net/core/dev.c:8910
 devinet_ioctl+0x127a/0x1f10 net/ipv4/devinet.c:1177
 inet_ioctl+0x3aa/0x3f0 net/ipv4/af_inet.c:1003
 sock_do_ioctl+0x116/0x280 net/socket.c:1222
 sock_ioctl+0x22e/0x6c0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc04ef73d49
Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
RSP: 002b:00007ffdc6648808 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc04eea56c0 RCX: 00007fc04ef73d49
RDX: 00007ffdc66589f8 RSI: 0000000000008914 RDI: 0000000000000005
RBP: 00007ffdc6668bb8 R08: 00007ffdc66589b8 R09: 00007ffdc6658968
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdc66589f8 R14: 0000000000000028 R15: 0000000000008914
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

