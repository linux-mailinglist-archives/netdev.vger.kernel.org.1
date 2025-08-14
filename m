Return-Path: <netdev+bounces-213861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D970B272BC
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E955E6A4F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8712A2857C2;
	Thu, 14 Aug 2025 23:05:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5059280A5C
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 23:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212732; cv=none; b=r7PMo1wCcc8jGymoWlV/CCD9Eycc+PSFUEYtmw1SbGm9tx9cgVsC14hQsd5mbiY+7RTSxaNE1MzRqn2+jSx7c/oJ4gS+MqjZwRaslr+b3hlDwfLYlx9iYEBtVSuAtgj5UxvVyl1v/h4cnygHFxQyIakAhrZf/MWbz+cArY7VlSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212732; c=relaxed/simple;
	bh=KwTK/suL9huNNzSBcew9y/pncOtjfQmErx2Nfx/hElE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F6IBWVqywr+85B3RhkfUNr1LuO51nKXOrFRN/Uiub6fFU3Hkt5ptKIDy7v6U/gbIWbCyn4cWQBmkcmSpDUtS3+QqFgsO4V0Ioy1M1tOwNA1X7JddMzxS4CoADfEgiPzFSqtwgg7fs8wnAi07DEWVM2Ca1FxWKLUNk22PQrgrH2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-88432ccc211so157168439f.0
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 16:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212730; x=1755817530;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lsw2552WQDQS4l6tKufTwDr+DSYsagSdBDhGcJFbtHY=;
        b=Hc0ZSj3av0O4oAPu5z4RwDMpxJ4xA/mm3oe6sI1gP8lp/1/QI90Xeb/i2RB6fEF5tb
         W0C+cJSHBU70Cx4Eng+IKykxsF1/jovr3GNnG7xH8smRYcnBioDmRqvmbh1FEaN62ur3
         miQYZzEmzIDxyVShOd0hPoM0wA7mNPxvPm9EdaxSO8356WsB9jCTrpJgyIsF8GYnABYI
         AuTrassQLCKBkP9eJ5h90C+mYpzelvIl9LpMM9td9A+TlhDOUhnVC+dIcr52Dix7Dvon
         Sw23nQj2eHgUpWcKY5XGc8KXBktf7aawhvGONRfMblr3gX4vRlnMPyRWt4rsf2RN1kHP
         7ELQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7VeRqPYLfUO3jJKz1fM+kNqHn3Ltvaz2OsOqdMrPi91wVXcM8a4+yW36B+QplzE2I36v67Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFl2ppzR3D0XRrN5t61fixFLWqz+myHedvBi6lAOfwb9zaOe3+
	VXJwNYz7SxneWcXxAbmQucQwJVdU0g/1nGM9CqMlE7i0Of+Yw71bJ8Nz8RhTwRnLDpYLB1qZxif
	TBm6uG4ATbjYY/C/glkDK9dXR1oQ8lAd0KPJ/WXBirUHQsQ15PUfANEw62Ws=
X-Google-Smtp-Source: AGHT+IF/vrp4iK90AdDyqbOiaRz6aUsA58MH0VT5AvbcyfvEj7EEI27YoWZNQdw6kQOT+5WmINPs4UFLSvxq/0P45AL2iQP1nGrz
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a09:b0:3e5:7282:4a95 with SMTP id
 e9e14a558f8ab-3e572825034mr84251525ab.24.1755212730073; Thu, 14 Aug 2025
 16:05:30 -0700 (PDT)
Date: Thu, 14 Aug 2025 16:05:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689e6bba.050a0220.e29e5.0003.GAE@google.com>
Subject: [syzbot] [nfc?] [net?] WARNING in nfc_rfkill_set_block
From: syzbot <syzbot+535bbe83dfc3ae8d4be3@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	krzk@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c80af0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13f39c6a0380a209
dashboard link: https://syzkaller.appspot.com/bug?extid=535bbe83dfc3ae8d4be3
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/46150b6d2447/disk-8f5ae30d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1c604b2b2258/vmlinux-8f5ae30d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9c542f0972de/bzImage-8f5ae30d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+535bbe83dfc3ae8d4be3@syzkaller.appspotmail.com

------------[ cut here ]------------
rtmutex deadlock detected
WARNING: CPU: 1 PID: 9725 at kernel/locking/rtmutex.c:1674 rt_mutex_handle_deadlock+0x28/0xb0 kernel/locking/rtmutex.c:1674
Modules linked in:
CPU: 1 UID: 0 PID: 9725 Comm: syz.8.874 Tainted: G        W           6.17.0-rc1-syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:rt_mutex_handle_deadlock+0x28/0xb0 kernel/locking/rtmutex.c:1674
Code: 90 90 41 57 41 56 41 55 41 54 53 83 ff dd 0f 85 8c 00 00 00 48 89 f7 e8 c6 2c 01 00 90 48 c7 c7 a0 08 0b 8b e8 79 08 8b f6 90 <0f> 0b 90 90 4c 8d 3d 00 00 00 00 65 48 8b 1c 25 08 b0 f5 91 4c 8d
RSP: 0018:ffffc900043a7950 EFLAGS: 00010246
RAX: 89021558f1df5a00 RBX: ffffc900043a79e0 RCX: ffff888025bb3b80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900043a7b00 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1017124863 R12: 1ffff92000874f38
R13: ffffffff8af82119 R14: ffff888036e55098 R15: dffffc0000000000
FS:  00007fec70d5e6c0(0000) GS:ffff8881269c5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fce013b0000 CR3: 000000003ebbc000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1734 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x692/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 device_lock include/linux/device.h:911 [inline]
 nfc_dev_down net/nfc/core.c:143 [inline]
 nfc_rfkill_set_block+0x50/0x2e0 net/nfc/core.c:179
 rfkill_set_block+0x1e5/0x450 net/rfkill/core.c:346
 rfkill_fop_write+0x44e/0x580 net/rfkill/core.c:1301
 vfs_write+0x287/0xb40 fs/read_write.c:684
 ksys_write+0x14b/0x260 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fec72afebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fec70d5e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fec72d25fa0 RCX: 00007fec72afebe9
RDX: 0000000000000008 RSI: 0000200000000080 RDI: 0000000000000003
RBP: 00007fec72b81e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fec72d26038 R14: 00007fec72d25fa0 R15: 00007ffe1f71d718
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

