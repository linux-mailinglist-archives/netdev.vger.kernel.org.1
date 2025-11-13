Return-Path: <netdev+bounces-238277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A475C56E4A
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6B5234C096
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF66331A70;
	Thu, 13 Nov 2025 10:35:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC7B330327
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030129; cv=none; b=N6CzhDTFRdbGmK+HgPMzVwSqIf2VE/ZKPGONRzUVg0f1yqK1eNZ21/tx7W3L5PXx9bClscyS1b8MqAogBts9axcvAah6M0U5R2oZv7CbQ5b9Mhkhk555oZoAFxvr0QHuZm9gW8O1MOz3MSH0tG0HMPRqQkPyuRoZKsAhcOo/BrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030129; c=relaxed/simple;
	bh=IgQgjGtFBP7AF+NZw7x3LDmSXHsIm8i+o+6jOICboEU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AJIvFgec8Fn3eyIUQFxLQWkLoxo1xyIKLWGKHItlT77lKU0929op64vh2ydiNJqlJ6QcZLimNqI7kuEZH4OgdFSJhSR10jOX0r6EhKpoGWOxBMlgp3SeD4ciZ6JFXXpaE0MDm6MiILSUoOl8gjxp3ZrxCwHIdu6wndBUlwkD/b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-43331ea8ed8so7373505ab.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030127; x=1763634927;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbdEWJA56FdSIhplP5wNxS54najxWArCAOLlDXVaQYE=;
        b=mFOtrKFQR2xLRKWrz4jYAMvHEiIXyQlDTgF+BKVcOwKXPIpKULgzaRQZ40ejUvkGBs
         zodKpVqTWLTsq/o/Vv/ntEHz8CfNHraffG+FdFtQzMsXad9+xTCmeVhs2Nk2ePUFS8Id
         r8A+3SeJm5737X2HjrCR4HceQMjQyAmWnBE46QQOUnVDANhfJpwKtTo48W6GopmeOQrL
         aj0YdAFO/QbwMJQBQpwY1CWk1mB/BIOZoYbwCKzKaKhqxTMqDglpMN1lSqYvpGRmNghe
         ZkksQqnYFGQCqCnkR65hghELjsxuwqaqOHSleY6q7iuNbMc70Dyu2A+cyr4QER5Qcf5a
         D+nA==
X-Forwarded-Encrypted: i=1; AJvYcCVlOXqsaHQAnSxc4XpiVkTT0icy4a2AS6XVQlvG/zGzmvxookYCtjTcp2A7CnVVtJDBHvfoBYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBad7Ol+y74h1OqKFdilVPBFvJieT00wjRHwNd3LOkFhJAPEsB
	zA86Wp7/69nkYMvXHzMzeOIaw8oQ0qUxcFA44u1rOs+jFxMT8EpvB+aHMSOHDP6hwFaA92Tq8jl
	XF0+d5lW05Z6JXFtwrfLXN8Pn2jBfyFiZw/jMmFrcZjfznDsxehqS0c+GxwY=
X-Google-Smtp-Source: AGHT+IHIMygvJ0QGQ9pVbXAgtD7mvDrcbNhKzdQ0GRQ2mpHNwLxpAeEclC0oGseOQWc80tJQtPOdoaXHj15IlmGI2ADMJxFqQqhq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2194:b0:433:7673:1d with SMTP id
 e9e14a558f8ab-43473db48a9mr75823835ab.31.1763030127042; Thu, 13 Nov 2025
 02:35:27 -0800 (PST)
Date: Thu, 13 Nov 2025 02:35:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6915b46f.050a0220.3565dc.0028.GAE@google.com>
Subject: [syzbot] [mptcp?] WARNING: refcount bug in mptcp_schedule_work (2)
From: syzbot <syzbot+355158e7e301548a1424@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    24172e0d7990 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11da1c12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=355158e7e301548a1424
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/38a395e6659a/disk-24172e0d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/23093acc54e6/vmlinux-24172e0d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ef12edc574bd/bzImage-24172e0d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+355158e7e301548a1424@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 16 at lib/refcount.c:25 refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:25
Modules linked in:
CPU: 0 UID: 0 PID: 16 Comm: ktimers/0 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:25
Code: 00 00 e8 79 5a 45 fd 5b 41 5e c3 cc cc cc cc cc e8 6b 5a 45 fd c6 05 3f 24 47 0a 01 90 48 c7 c7 80 2e 3d 8b e8 57 a1 09 fd 90 <0f> 0b 90 90 eb d7 e8 4b 5a 45 fd c6 05 20 24 47 0a 01 90 48 c7 c7
RSP: 0018:ffffc90000157830 EFLAGS: 00010246
RAX: 8853f029dd577500 RBX: 0000000000000002 RCX: ffff88801b2dda00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000100
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000100
R10: dffffc0000000000 R11: ffffed101710487b R12: 1ffff9200002af18
R13: ffff88805cbc5e60 R14: ffff88805cbc5a80 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888126df7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ee13ff8 CR3: 0000000056192000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:-1 [inline]
 __refcount_inc include/linux/refcount.h:366 [inline]
 refcount_inc include/linux/refcount.h:383 [inline]
 sock_hold include/net/sock.h:816 [inline]
 mptcp_schedule_work+0x164/0x1a0 net/mptcp/protocol.c:943
 mptcp_tout_timer+0x21/0xa0 net/mptcp/protocol.c:2316
 call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1798 [inline]
 __run_timers kernel/time/timer.c:2372 [inline]
 __run_timer_base+0x648/0x970 kernel/time/timer.c:2384
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
 handle_softirqs+0x22f/0x710 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 run_ktimerd+0xcf/0x190 kernel/softirq.c:1138
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

