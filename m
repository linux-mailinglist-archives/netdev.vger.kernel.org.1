Return-Path: <netdev+bounces-153955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C36D59FA476
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 08:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68BBF188917F
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 07:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5463E1547DE;
	Sun, 22 Dec 2024 07:05:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDA319BBA
	for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734851124; cv=none; b=TRQu0pBQB5Bf00YTEPYGyJB70ES9O6mOcFUMT76WyGJzY9jSX1SabVhWxnh9vxGMfocB0BOjJ9Kqs4mEvKwUa3zEiE+9LfjgJfSUfZIoBVgiZLKXVPdtJukAO4sknshbrkILelt5mFaBH3S+7tMaWo7fntWwA6ZXDo+8GiVcA44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734851124; c=relaxed/simple;
	bh=PNegf3bFlJXcVlmlllcmWn2Muyqx6WbO8ikALr0GQFU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YM0MlK6v2k5XoNHsHaaHH1XHOZdJLwFWvl+K3tC7He7WezKKXmxgRMBFv4ljQUh1ap60c/cMy3YVOmycz8FnGOJqXUIdTMXCTU0QW55wCk4bO5p4gbugSf8pOkPGG6KgOjo5bAajTM5yuEFmoOs/lhRi97fWT1Ty4nMv7bEnZvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ac98b49e4dso29096015ab.1
        for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 23:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734851122; x=1735455922;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XmoCRLkY6I+jgLgj0zkUOOAsUGcwh8Ol0VulYvPl6FI=;
        b=k+FgOv9OoiwqKMF1HBwb/y+T/C9klmu+cz28hFTX5GC41sqn8UTofAwfp1oYJ9vejK
         Sl9+/srzYLMVzc3ptjSTF32cS9Vvqq4vvVY2nez9tNwqCS0mDzDbshRnonZ4eU8vHJKr
         s4pS2z1IVJr5f/fWRw8DgYoeH8ooECumM+negfwtotpSo67oriN1gV4M/VO7x3Dywa8/
         xjPJYiD4Lv7XsB68EVE+VHQFw95oT5AcJhtuwLfojV0dziZH22YEfty/o2bOpIeVHzcj
         Ebn12HFAIbHFTTSB/wA1ROt2+PQyI/RXxtqN+w8n2NPQ0QohTQvZbgAYY0/gEn8tidS0
         A9mg==
X-Forwarded-Encrypted: i=1; AJvYcCVAJwxrSu8YMK0qaWGYQXSW6ubPpbYQfMAljA+D6FgRRbpwxvvrQg5qvn3BvGq6lIfi2vd0zAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQzt0/QctCq73Ujeavm35vqqX6M2uGZf/os671sMRzeyJ2pqNb
	03C6bjaAUtDLU0kU6z+rP2/1SF3gyM3ziCYCV4YQN+WNJf1kuAzdWh4OlFRM6vPliNRSxf2qTGa
	8QYLdP7rEUqk3W5LKyQP7IIockXmdyrF02Mpt8B5rIG+31cCEMlEJk64=
X-Google-Smtp-Source: AGHT+IGzHgDt9/GFaGV3DI+15BlSA/J1KYG9eMziHH5AON43o13av5whl3lFrlAhFebxJDAwNPd6Pj+uqQzQiC1R7b0hf45HIFs1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24c:0:b0:3a7:fe8c:b004 with SMTP id
 e9e14a558f8ab-3c2d2782c53mr60071215ab.11.1734851121855; Sat, 21 Dec 2024
 23:05:21 -0800 (PST)
Date: Sat, 21 Dec 2024 23:05:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6767ba31.050a0220.25abdd.0138.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in sco_conn_put
From: syzbot <syzbot+b1f28526bea4dce0f04f@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d3c9510dc900 net: page_pool: rename page_pool_is_last_ref()
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17efd730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87a291e9e8ffbb16
dashboard link: https://syzkaller.appspot.com/bug?extid=b1f28526bea4dce0f04f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4e4dd3da989d/disk-d3c9510d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd16db384609/vmlinux-d3c9510d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7903aba8a210/bzImage-d3c9510d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b1f28526bea4dce0f04f@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8522 at kernel/workqueue.c:2257 __queue_work+0xcd3/0xf50 kernel/workqueue.c:2256
Modules linked in:
CPU: 1 UID: 0 PID: 8522 Comm: syz.1.688 Not tainted 6.13.0-rc2-syzkaller-00457-gd3c9510dc900 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:__queue_work+0xcd3/0xf50 kernel/workqueue.c:2256
Code: ff e8 71 e8 37 00 90 0f 0b 90 e9 b2 fe ff ff e8 63 e8 37 00 eb 13 e8 5c e8 37 00 eb 0c e8 55 e8 37 00 eb 05 e8 4e e8 37 00 90 <0f> 0b 90 48 83 c4 60 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc
RSP: 0018:ffffc9000485f888 EFLAGS: 00010087
RAX: ffffffff816775e4 RBX: ffff88802abf1e00 RCX: 0000000000080000
RDX: ffffc90005282000 RSI: 00000000000002f5 RDI: 00000000000002f6
RBP: 0000000000000000 R08: ffffffff81676a44 R09: 0000000000000000
R10: ffffc9000485f960 R11: fffff5200090bf2d R12: ffff88805a00d800
R13: ffff88805a00d9c0 R14: dffffc0000000000 R15: 0000000000000008
FS:  00007fbe34d8a6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c352926 CR3: 0000000028684000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 queue_delayed_work_on+0x1ca/0x390 kernel/workqueue.c:2552
 sco_conn_free net/bluetooth/sco.c:91 [inline]
 kref_put include/linux/kref.h:65 [inline]
 sco_conn_put+0x145/0x210 net/bluetooth/sco.c:107
 sco_chan_del+0xa3/0x180 net/bluetooth/sco.c:236
 sco_sock_close net/bluetooth/sco.c:526 [inline]
 sco_sock_release+0xb3/0x320 net/bluetooth/sco.c:1300
 __sock_release net/socket.c:640 [inline]
 sock_close+0xbc/0x240 net/socket.c:1419
 __fput+0x23c/0xa50 fs/file_table.c:450
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 get_signal+0x15f7/0x1750 kernel/signal.c:2790
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xce/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbe33f85d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbe34d8a038 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: fffffffffffffffc RBX: 00007fbe34175fa0 RCX: 00007fbe33f85d29
RDX: 0000000000000008 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007fbe34001a20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbe34175fa0 R15: 00007ffe3e4f91f8
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

