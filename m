Return-Path: <netdev+bounces-119386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 703C0955659
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 10:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3D41F21E73
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 08:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4868E13C9C8;
	Sat, 17 Aug 2024 08:15:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC50E13BC35
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723882530; cv=none; b=XHpxO0V0DtBCjiLmLcxj5TXVJAvb3tMYWV3eaRo7BJntbwccEuwkx+1/7+5DXi1lwcX0F/i7dGKyVO4/Z74CxbFDMZuU9EKsAoCmGSygS4SYlqGSf5DHIf8HFb9QHOk6pR6V2GhgP+tCZupgYoHD4P7Uq1Fr0dLMTiV2WeRACy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723882530; c=relaxed/simple;
	bh=e+stYyRMaVv/yiTzYLbeBVeKDcF5yc5e97grWMZtPsY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=S1McCqlQzyCb0yTYMIaITAytT9IA1Yw3hIriReq5q9qeafIVavtIp5WKV0VOhw2+HxI9H/9N32sYqA0TTQtJop7K/05CO82qYKt3BTMVdXxFPYKMMXhpmNUsg+SoT5Lu3vJI1yjisnlPCyM1NTTkzoMFF9HSCf8NW6p/EWJAujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f7fa42463so227056639f.0
        for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 01:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723882528; x=1724487328;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5m/Qn5QvspbDf6FaUgEifp0ZqoRynM1xJ7SNfaqQyQ=;
        b=b1DDC5M9hGTO+N1lTv99a4Y9zcxPY6Nmk7REKq13o2lKHZbv0Ap1F9+QApJV8bvZ8i
         b6jCvPm5B0/dO2ioiJRxcwxBYAA/sKGptSm/N71k3fvL1URd/Lp+vApKI/0ocsjBYVHt
         BH1Dmbj/qiIWU/q08fzQY0SaYUjK19Zt42U1IhCMQq3F/QZ+S8I5v9xSAUjT4Qxwmn4L
         sWaDATgsivlku/m/R8ZwKGXJX8xfjt/UZa6Ti0v3qKCABoqUQ+GGYdaoB9KYhY/zsvK7
         /sXTzffcfcEy68pjjzymEj5lhEr4HvsiTVKKRzyBe6fwOudZc9Lc2so83hyA+RLkh5NI
         ckxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBR8CRh9Pi5Q3cHMCytW2+9hIZTBivNoWPqSP9h588S6hPfTTSXPHee0ADG+1HdtQziYMAnHzm5aZYzK+rHnlqoknqnn1r
X-Gm-Message-State: AOJu0YzVrdxmfQFC/SZmR9E87rCRRTfVtDcgk0i3kW6lPz54OG0P0y4t
	cJ63EXM1CEbdZAZEl6qZeVQCA5vyaDnhzS18qre8K4rs9brLdOobqfUEHfW4eUfskaADx+vaL5b
	DNXImac0CzFWCp79QWehtRSUlTBRSamNkTXaK5uuSp0thMzgKKyXv9so=
X-Google-Smtp-Source: AGHT+IEyECeB0aIQwlML6GEm8q5GVLFKxI0f4cdD+Lps2XXRndx9qjDJxZ5GS703ogEcQvA95E0CzCUYQbQm7AH8EqFDY2ITEnGr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6415:b0:805:e4ad:66d6 with SMTP id
 ca18e2360f4ac-824f341ec01mr23049339f.0.1723882527697; Sat, 17 Aug 2024
 01:15:27 -0700 (PDT)
Date: Sat, 17 Aug 2024 01:15:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2bab3061fdcad9b@google.com>
Subject: [syzbot] [net?] kernel BUG in __sock_sendmsg
From: syzbot <syzbot+58c03971700330ce14d8@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d07b43284ab3 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15bd19cb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f3e2eb337834cdf
dashboard link: https://syzkaller.appspot.com/bug?extid=58c03971700330ce14d8
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120ce5ed980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147a0de5980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-d07b4328.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b4b84226a2bb/vmlinux-d07b4328.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a0895c10c1cc/Image-d07b4328.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+58c03971700330ce14d8@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at net/socket.c:733!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 UID: 0 PID: 3265 Comm: syz-executor510 Not tainted 6.11.0-rc3-syzkaller-00060-gd07b43284ab3 #0
Hardware name: linux,dummy-virt (DT)
pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : sock_sendmsg_nosec net/socket.c:733 [inline]
pc : sock_sendmsg_nosec net/socket.c:728 [inline]
pc : __sock_sendmsg+0x5c/0x60 net/socket.c:745
lr : sock_sendmsg_nosec net/socket.c:730 [inline]
lr : __sock_sendmsg+0x54/0x60 net/socket.c:745
sp : ffff800088ea3b30
x29: ffff800088ea3b30 x28: fbf00000062bc900 x27: 0000000000000000
x26: ffff800088ea3bc0 x25: ffff800088ea3bc0 x24: 0000000000000000
x23: f9f00000048dc000 x22: 0000000000000000 x21: ffff800088ea3d90
x20: f9f00000048dc000 x19: ffff800088ea3d90 x18: 0000000000000001
x17: 0000000000000000 x16: 0000000000000000 x15: 000000002002ffaf
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: ffff8000815849c0 x9 : ffff8000815b49c0
x8 : 0000000000000000 x7 : 000000000000003f x6 : 0000000000000000
x5 : 00000000000007e0 x4 : fff07ffffd239000 x3 : fbf00000062bc900
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00000000fffffdef
Call trace:
 sock_sendmsg_nosec net/socket.c:733 [inline]
 __sock_sendmsg+0x5c/0x60 net/socket.c:745
 ____sys_sendmsg+0x274/0x2ac net/socket.c:2597
 ___sys_sendmsg+0xac/0x100 net/socket.c:2651
 __sys_sendmsg+0x84/0xe0 net/socket.c:2680
 __do_sys_sendmsg net/socket.c:2689 [inline]
 __se_sys_sendmsg net/socket.c:2687 [inline]
 __arm64_sys_sendmsg+0x24/0x30 net/socket.c:2687
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
 el0_svc+0x34/0xec arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
Code: f9404463 d63f0060 3108441f 54fffe81 (d4210000) 
---[ end trace 0000000000000000 ]---


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

