Return-Path: <netdev+bounces-160609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA93A1A7F0
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 17:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D312C3AA8C6
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FA5213236;
	Thu, 23 Jan 2025 16:35:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B90212B0E
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737650130; cv=none; b=oWo9uZ9m+n5R0+traXVqu0kUedg4VcxsEd1nrbuwjsGfjBuRsB6CLJlf68WOoFUxFLSWUA+v04YYyNpYsqQ4wFvgMeNunuaw9JeHabQTZ4xF+61eyGRsv8aVjQwshdjZVFrV6MZ2tpMBGj4mg//qCI0/97m4zhQS9ec3OUhk/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737650130; c=relaxed/simple;
	bh=rQrvzIco6ucpXeDPwRKQB1b/pEwTdilUvVHY5dhA/e8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=U6HM2GXwS41SZuUN3e4ouKBDA/+hK5ftq5h3N2rPgunZu9XdGD9MZPuoyB88XnGxItFBxE89pa0ir+MKPonq92DPq7JeKoXm/kx8qZaBiNH89TWDHaG1jMAz2GJQxY6elPYIKU3R+ktGwIN3NgfMBMS6V93twCLhSxPkTEhg24Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3cf6ceaccdbso7398245ab.1
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 08:35:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737650128; x=1738254928;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bN7Cps97LuNIjFLkDCHAZkPg/aaPybeHLcKwHv41VvM=;
        b=Db1pB0Oa1dnvMZPtwwMSbQt64DuPGKaj6qjGrgPRKmDvlx9TXzvO40DW7XyTemgn1z
         6Y3EdzSpiXKHsDncQ+r9BwFc2Z2EKQknFDmgNzg4Hq+jLDEPj9r+K3XrSkdJFpQHgoMh
         gyZeGwfYMFSPwvHstyWoMVzY4MoDrr7C7fFGLuaf6aP6CXqmbxE897ETWAjmELXsq67Q
         hfHzQ3DgkkcdVVlziG7ujyxt5jIKO+uIjoHQlJTtzNEW8HOcqUN/zyL2sE/+iGJiIoYW
         BdWpWscZZ73wNYS422JTXQ3+uy2+/cp+dq5CSIz+MZA11nOzi67/K4VDW+Jnd8gtV2h6
         I2IA==
X-Forwarded-Encrypted: i=1; AJvYcCXj1kjQwJXMQS4yv7TO/fRxMLLZNVHrJBoDVHNToAm49rpwFhZFugx1oNPeyEa2xiZGFdX6a50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBn3henglV0O1OAREMu1f07BmEPd+vTT0c6aiIcjWCpc8P0IV1
	vikl8O9ujl7cGiiigGaRb3fwe1cZIM4ObQJrDqqPcxRSHKWeXS7z7kb0915oMQHQwtQmn3hrCPo
	MKysESFE+EnK2cO8nEbLtP8vv/j/ZEcPqWyFASScLaPR2wkEx1o0CEdk=
X-Google-Smtp-Source: AGHT+IHQTVUuYTiPnz6bKzhsiaTz0p05lbwf74wSRcZ4HPj3Zf2jkd7pS5Y9o0XVymoCJ/KWmtnojkCr2HXaxToEgKDffMKPmNYw
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1521:b0:3cf:bb11:a3a7 with SMTP id
 e9e14a558f8ab-3cfbb11a5dcmr41765325ab.17.1737650128144; Thu, 23 Jan 2025
 08:35:28 -0800 (PST)
Date: Thu, 23 Jan 2025 08:35:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67926fd0.050a0220.2eae65.000e.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in nsim_get_ringparam
From: syzbot <syzbot+b3bcd80232d00091e061@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7004a2e46d16 Merge tag 'linux_kselftest-nolibc-6.14-rc1' o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=171a1c24580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6a5cefe7199b4e8
dashboard link: https://syzkaller.appspot.com/bug?extid=b3bcd80232d00091e061
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a2a9f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12baf618580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d5b55fed9d79/disk-7004a2e4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70382af6f618/vmlinux-7004a2e4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a7609fc3059d/bzImage-7004a2e4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b3bcd80232d00091e061@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in nsim_get_ringparam+0xa8/0xe0 drivers/net/netdevsim/ethtool.c:77
 nsim_get_ringparam+0xa8/0xe0 drivers/net/netdevsim/ethtool.c:77
 ethtool_set_ringparam+0x268/0x570 net/ethtool/ioctl.c:2072
 __dev_ethtool net/ethtool/ioctl.c:3209 [inline]
 dev_ethtool+0x126d/0x2a40 net/ethtool/ioctl.c:3398
 dev_ioctl+0xb0e/0x1280 net/core/dev_ioctl.c:759
 sock_do_ioctl+0x28c/0x540 net/socket.c:1208
 sock_ioctl+0x721/0xd70 net/socket.c:1313
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0x246/0x440 fs/ioctl.c:892
 __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:892
 x64_sys_call+0x19f0/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable kernel_ringparam created at:
 ethtool_set_ringparam+0x96/0x570 net/ethtool/ioctl.c:2063
 __dev_ethtool net/ethtool/ioctl.c:3209 [inline]
 dev_ethtool+0x126d/0x2a40 net/ethtool/ioctl.c:3398

CPU: 0 UID: 0 PID: 5807 Comm: syz-executor164 Not tainted 6.13.0-syzkaller-04788-g7004a2e46d16 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
=====================================================


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

