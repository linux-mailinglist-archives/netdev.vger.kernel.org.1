Return-Path: <netdev+bounces-150566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 882FC9EAA9E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789C4188A42A
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A31230990;
	Tue, 10 Dec 2024 08:27:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCDC230981
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819243; cv=none; b=WUYxirc9QDRg7ZtNfzTI5DSkuvq7JyE2X0BZME1eat6/w4N105IRvyk4n6Hws9SGakf6wEC6Yfb1WHMvpESUL/OkWlY4vwb2kmF1wdKUYvTL6WjjHOGs1xFcT0HMdovkJrfahgKpycdTBauVVSE0f9fXGULY4Ao7jFkXLyizgHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819243; c=relaxed/simple;
	bh=RGEqFTsyLAWytI7W+/2L934Qp3FUaqeSB9bSIm03mQI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nSTfhcdJJVlUkfiHLtTXOun8KdfqZ84QC/ExHpVp8PlHvLV4gGwEFGzCna3wRXoVaG0B88mIUjwZA+5Bko7S3Y89f/28woOA57Tergs0jgeolpdlyLMBdtX1xAGhSzeJwiE4O+j0XzeJrzncP5mWG4nNjWUYngZ5YagYVNBmolk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a7de3ab182so116339665ab.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 00:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733819241; x=1734424041;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gEszRSbd8tWerIRnCbggzUfqai9KrhAu9qVrRUgthsE=;
        b=fXYHdJ6YpTwHQfyWgVdG6f2zOOKylktgIJahjLfSRFuG3QiqKftEGsWbMi8H79JbNC
         HZXtyl4qRJZu6FSml2hYME4HJoCEfIKR72mFwaXisc1AykcIkHLayxT4NVxt4nHyzwTy
         Q6dl85FOXJv7mVx2V8iPJu6rfs+do4DSwnTERBNMzqE2Tpcm8sJdMSJn6Ux+sd7eFLH5
         s9CJPOcHM+hlvy8jYVYT38N5PuEbl18lpvQLCqmACeiunssuMU+XSJAr8I3lYZfpNTEg
         YQlcdF72V+bpllSekA6r0rqmAwtaN7mf5FDXsz5kvqPZw8dznN7DXmbnzA9h+ppziBY5
         sBlg==
X-Forwarded-Encrypted: i=1; AJvYcCV7k3riuqYIm/uEnaWBVh6EGdWEDImcN6aD01CRKfr7XU7d3+Ztmn5YSY5EXpKoNPYwAKuZwx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCTXTFCNShB2VjQh3JnYkJqgkoTS/y4x/Dvgy7Fab1UqoARJGp
	DJfdCHZ4mTG7hbre+WvaX5bBXzr9I5RwakoykmOVCD8EjdbQK8yL63Dbw+D47uL8LlckveIlas9
	DACukslXpFzuliFgREYeyNvNqWNCfimS3MGH10Rsd1WQL3mtULTJfQ9g=
X-Google-Smtp-Source: AGHT+IHBX2YwuKKiF3YlIjH872Jb10T1FN7R/2rd1aFm4MD74rYJnO0r7c1yeHL8132Q4SDwuC4tN2wH79oeFO1GSSZ1vhk07TcQ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1568:b0:3a7:e800:7d37 with SMTP id
 e9e14a558f8ab-3a9dbac588cmr37719775ab.10.1733819240944; Tue, 10 Dec 2024
 00:27:20 -0800 (PST)
Date: Tue, 10 Dec 2024 00:27:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6757fb68.050a0220.2477f.005f.GAE@google.com>
Subject: [syzbot] [net?] [afs?] WARNING in rxrpc_send_data
From: syzbot <syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e58b4771af2b Merge branch 'vxlan-support-user-defined-rese..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16b9a8f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=ff11be94dfcd7a5af8da
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14cb93e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a3d4df980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b527c0c7acd8/disk-e58b4771.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/41720c9a36cc/vmlinux-e58b4771.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8888d773b743/bzImage-e58b4771.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5822 at net/rxrpc/sendmsg.c:296 rxrpc_alloc_txqueue net/rxrpc/sendmsg.c:296 [inline]
WARNING: CPU: 0 PID: 5822 at net/rxrpc/sendmsg.c:296 rxrpc_send_data+0x2969/0x2b30 net/rxrpc/sendmsg.c:390
Modules linked in:
CPU: 0 UID: 0 PID: 5822 Comm: syz-executor280 Not tainted 6.13.0-rc1-syzkaller-00332-ge58b4771af2b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:rxrpc_alloc_txqueue net/rxrpc/sendmsg.c:296 [inline]
RIP: 0010:rxrpc_send_data+0x2969/0x2b30 net/rxrpc/sendmsg.c:390
Code: 24 48 48 89 de e8 37 38 ab f6 4c 39 f3 b8 00 fe ff ff 41 bf fc ff ff ff 44 0f 44 f8 45 31 f6 e9 71 fd ff ff e8 38 33 ab f6 90 <0f> 0b 90 48 8b 7c 24 28 e8 4a d3 09 f7 e9 46 fd ff ff 89 d9 80 e1
RSP: 0018:ffffc90003d9f620 EFLAGS: 00010293
RAX: ffffffff8af43ee8 RBX: ffff88814e6b4e80 RCX: ffff88802b741e00
RDX: 0000000000000000 RSI: 00000000000000ff RDI: ffff88807d0ea440
RBP: ffffc90003d9f8d0 R08: ffff88807d0ea43f R09: 0000000000000000
R10: ffff88807d0ea340 R11: ffffed100fa1d488 R12: ffff88814e6b4e48
R13: 1ffff11029cd69cf R14: ffff88807d0ea000 R15: 0000000000000000
FS:  0000555559fc7380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f831d7fb0d0 CR3: 000000007f1c2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rxrpc_do_sendmsg+0x1569/0x1910 net/rxrpc/sendmsg.c:763
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
 ___sys_sendmsg net/socket.c:2637 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f831d783ab9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd37defc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f831d783ab9
RDX: 0000000000008880 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007f831d7cd0fd R08: 0000000000000000 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f831d7d213c
R13: 00007f831d7cd082 R14: 0000000000000001 R15: 0000000000000001
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

