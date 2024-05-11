Return-Path: <netdev+bounces-95747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA7D8C33E6
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 23:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241EE1F212E7
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 21:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44555224FA;
	Sat, 11 May 2024 21:47:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBF9225AE
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715464053; cv=none; b=QtHyfXztu0LVk4bTdkeRXBU/xFKOjguB4h94ub0TGBUbfiXp3SNvltT6ioqggPYto+6VQFQRmO8gkHcn+s508RLC1g50Q2jdog7aUutojYQSc937CvW4w06xcBAsGMK9HBYVK7dUbxRVztw79FSYENs/p1QkXjrfnLzfZOY3pW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715464053; c=relaxed/simple;
	bh=iHY/FICu79B2UV32GHY4SXtsa2DPPqciV831WTijYjo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EfCPDtqp2S8qxgNhZN+9SX92Paiow8eDKqnCJJs7ozspf5A/6BoyYorrXwwdrSsY8WiVPFBJegcB23Cvgu/r9fAWWWDIJVUjI22cmkJOpoVo/kuZpwgom21RygE3dh9S9/eeAoOI6+S4jRUdenVmzsctBYr1imMmdM2Tyurjo3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7deb999eea4so364314439f.3
        for <netdev@vger.kernel.org>; Sat, 11 May 2024 14:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715464051; x=1716068851;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lX/OlSQmXWwWmSNmAsxqiLeBJGVZs/7FIdqQkxiZXNc=;
        b=bGTwCgnawcv8q+WpvjdC0KaULLLRGWyFzgY5n0a6PIhUys4PlgHm0Nfo0kacrYuk9Z
         VSkGwSyg6HREgoX7pWWhjjM9SBP7R0nvLZYq7LXK/0023V/oRPWPu5LMfWEkXxyxSZBN
         2jlnl/JbYxvUWAFfraEbKzFUAz/ywLX9T70/inCP3LWbf4lUbF4i3r6IfJ91sNHdN63N
         5hHGgVdOrSzaVsIwdJEJKy6Gn5dIBHKRhaGrlWosVByqAni+njLa2/bN1V7i/rN2iRp9
         INFIAOl+omBMZXhvJT1Z6H9FCxgYOmQOFU9/iUV8H++eLCYPNGWmgZXT9+xGlGLeaeaR
         sBNg==
X-Forwarded-Encrypted: i=1; AJvYcCXb3fRxD4DPwqR2FJF3lIf3fGD4CQ3uT7obW3GiOeaDpur9fXNFxF/Pa+UIGyoK5otufcl3kiK3F38hjWV4c21z246Tkjpc
X-Gm-Message-State: AOJu0YzP1PpU8WAcC145R1kVPPtV3FVlQHZKpm7a+jWajpfBNWt2+Jg8
	/DhORLZqwlr4Dun6ku26E1sWMsGYL1lhYqNOEmsbNGW4SCmQA8a+2g7+i3dJdRFEee59FThnGID
	Ecz8CrBuNuLd0MsYv8R6DAPDvkALp6q2qtviWe9edkw6X0JYiN4QK0rk=
X-Google-Smtp-Source: AGHT+IEyr2MkkKyLxyXOc+YEXYbowgrmBfs5RPY6U+6VNVoVl2iR5wT0v1mJpSOk2ghUAttu5B/oGm/+NE73g+AbzzChM0rrVUWq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8305:b0:488:59cc:eb5b with SMTP id
 8926c6da1cb9f-48958afa76fmr419094173.3.1715464050944; Sat, 11 May 2024
 14:47:30 -0700 (PDT)
Date: Sat, 11 May 2024 14:47:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061c0a106183499ec@google.com>
Subject: [syzbot] [wireguard?] WARNING in kthread_unpark (2)
From: syzbot <syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    75fa778d74b7 Add linux-next specific files for 20240510
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13d483c0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccdd3ebd6715749a
dashboard link: https://syzkaller.appspot.com/bug?extid=943d34fa3cf2191e3068
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ad9391835bcf/disk-75fa778d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d827b3da9a26/vmlinux-75fa778d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f32f0182388/bzImage-75fa778d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 11 at kernel/kthread.c:525 __kthread_bind_mask kernel/kthread.c:525 [inline]
WARNING: CPU: 0 PID: 11 at kernel/kthread.c:525 __kthread_bind kernel/kthread.c:538 [inline]
WARNING: CPU: 0 PID: 11 at kernel/kthread.c:525 kthread_unpark+0x16b/0x210 kernel/kthread.c:631
Modules linked in:

CPU: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.9.0-rc7-next-20240510-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: netns cleanup_net

RIP: 0010:__kthread_bind_mask kernel/kthread.c:525 [inline]
RIP: 0010:__kthread_bind kernel/kthread.c:538 [inline]
RIP: 0010:kthread_unpark+0x16b/0x210 kernel/kthread.c:631
Code: 00 fc ff df 41 0f b6 04 06 84 c0 0f 85 93 00 00 00 41 80 4d 03 04 4c 89 e7 48 8b 34 24 e8 bd c5 32 0a eb 09 e8 46 88 33 00 90 <0f> 0b 90 48 89 ef be 08 00 00 00 e8 75 43 99 00 f0 80 65 00 fb 4c
RSP: 0018:ffffc90000107758 EFLAGS: 00010293

RAX: ffffffff8162943a RBX: 0000000000000000 RCX: ffff8880172c3c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88802e430800 R08: ffffffff816293c7 R09: 1ffffffff25f64cd
R10: dffffc0000000000 R11: fffffbfff25f64ce R12: 0000000000000001
R13: ffff8880296eda2c R14: 1ffff110052ddb45 R15: ffff8880296eda00
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd40918ff8 CR3: 000000002e664000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kthread_stop+0x17a/0x630 kernel/kthread.c:707
 destroy_workqueue+0x136/0xc40 kernel/workqueue.c:5810
 wg_destruct+0x1e2/0x2e0 drivers/net/wireguard/device.c:257
 netdev_run_todo+0xe1a/0x1000 net/core/dev.c:10693
 default_device_exit_batch+0xa14/0xa90 net/core/dev.c:11769
 ops_exit_list net/core/net_namespace.c:178 [inline]
 cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

