Return-Path: <netdev+bounces-250214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07607D25145
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DFF6301A185
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED913347BA9;
	Thu, 15 Jan 2026 14:50:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EB2279907
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768488629; cv=none; b=r8zNKG0Hl1bNLBiUOlTq6YEh2ubzC3K0ifY36O9wZ3hqJyBaA86xAXuaRfSINdtSFItQcrP7v+m6KydbYwzS3eRor4ujtXa8dtd2Tjgc2z3QloocHWPOyYTfipT3GM2yc+AD+EFyHiF15/OobOAeEkPHE5AzCzS5rRtFwGOEVGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768488629; c=relaxed/simple;
	bh=3RMfVYSGpkOLiHJBEL0zVUsNi8tg/hwdMTnY1KweINw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pynpndT8eMDowdlN/srGlkdoqzh4WZ0/zuCHeW5Peeg228DFkBkIsNy4rylHok8LjSFoBdTgHTAtC2PDkQaUBb///nEAj4gSrFuW41SSLv4IPvRx1i7F503QmnkxVMXxpChhXHnj1YVT2BjmLfdQOmIV30y60aaqFmnmC26nI+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7cfcf550dd8so2335608a34.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768488627; x=1769093427;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ze4Dv+UBkNGbitWZ+zMrF7QcGpoJNiTm4Tn/wiF9wyU=;
        b=uErFqRjcxmIyWlbzEZEepnxMveW+2X+lDbR0HmnnE2JZ7zMe9W1Q0+4U1pL+PZ/t3d
         yqdFOx/HyHeweF/ivlFd++S2y12olkAxPLlVrtmsneMY3R1CCuGYq6JVoYqICNbImQ+V
         hC3qaTX315IP+/KWeBqaXIK1yof2JocAvmCl8gSmF32JGuopvAkRxcte0ZnRzhfpldns
         /1VxmE0kSE0rjEybFo/xCT/JcvLjv+wCWPRiEDJ0XjDSmEJVEft4PIFzrfh5cdN3gkdh
         ++WJlbXwMWqTLIl/bpthrII3yNJzq1aIKNNbIRAIdLqYvuR8UrhwmQ11AQHo0Oma/RSp
         2KeA==
X-Forwarded-Encrypted: i=1; AJvYcCUihM5XUNBIIcciNpQptm1jl4lWfMrJgYj44nBwxNyzjZmyefCLNTR4jbu+tzy8hFmcvbp/4jY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxgo06fNf5GLQ0+P18N1uyWWjG4ll3Y6IX+rlrn/HAMazscAch
	W/9XuMj/k+onoeGAPe24NDDnytK+JKPRAGA9jj3PRBhY6dFBur0fSLd2ar9422VceNEx2C4ZN68
	ynGZ3ZYJZQgnvclvSXeX0rudPoBoL58ca8cEz+7QnbFJEcRNHnZjVTVncr+A=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16a7:b0:65d:c8e:840a with SMTP id
 006d021491bc7-66102dc0ed3mr4212474eaf.65.1768488627308; Thu, 15 Jan 2026
 06:50:27 -0800 (PST)
Date: Thu, 15 Jan 2026 06:50:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6968feb3.050a0220.58bed.0021.GAE@google.com>
Subject: [syzbot] [isdn4linux?] KCSAN: data-race in mISDN_ioctl / mISDN_read (4)
From: syzbot <syzbot+c6e7bcea7ffb7ff46acb@syzkaller.appspotmail.com>
To: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    516471569089 Merge tag 'libcrypto-fixes-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12417dc2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b319ff1b6a2797ca
dashboard link: https://syzkaller.appspot.com/bug?extid=c6e7bcea7ffb7ff46acb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/daca6d82d1e1/disk-51647156.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3e0d93470f33/vmlinux-51647156.xz
kernel image: https://storage.googleapis.com/syzbot-assets/27efb1907b03/bzImage-51647156.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6e7bcea7ffb7ff46acb@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in mISDN_ioctl / mISDN_read

write to 0xffff88812d848280 of 4 bytes by task 10864 on cpu 1:
 misdn_add_timer drivers/isdn/mISDN/timerdev.c:175 [inline]
 mISDN_ioctl+0x2fb/0x550 drivers/isdn/mISDN/timerdev.c:233
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xce/0x140 fs/ioctl.c:583
 __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:583
 x64_sys_call+0x14b0/0x3000 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd8/0x2c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88812d848280 of 4 bytes by task 10857 on cpu 0:
 mISDN_read+0x1f2/0x470 drivers/isdn/mISDN/timerdev.c:112
 do_loop_readv_writev fs/read_write.c:847 [inline]
 vfs_readv+0x3fb/0x690 fs/read_write.c:1020
 do_readv+0xe7/0x210 fs/read_write.c:1080
 __do_sys_readv fs/read_write.c:1165 [inline]
 __se_sys_readv fs/read_write.c:1162 [inline]
 __x64_sys_readv+0x45/0x50 fs/read_write.c:1162
 x64_sys_call+0x2831/0x3000 arch/x86/include/generated/asm/syscalls_64.h:20
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd8/0x2c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000000 -> 0x00000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 10857 Comm: syz.0.2523 Tainted: G        W           syzkaller #0 PREEMPT(voluntary) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
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

