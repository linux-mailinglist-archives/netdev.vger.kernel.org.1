Return-Path: <netdev+bounces-217394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BB3B38870
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 19:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046C43BD161
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9FA2D0C72;
	Wed, 27 Aug 2025 17:19:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE69747F
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315179; cv=none; b=bRP13Dpo9SOJNOMMQEnNlKHc/aOG6Bu+pJsKBRNDlvEqpAGcWyATRgcaweQfc6k+xAEBu+AwI4j8OvdlC9AUPysgqNbRCFyw9wZjX82ybOuBRUUIVabHNPyBxnJPms+/OArSOpGTW70yw6O7EdDkoQPA9Ycf/ZdjckipnUQsCqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315179; c=relaxed/simple;
	bh=xc5Gs1BKnZMD2Jn2qmEE5N1BLIigyY6nGB+0F7DakPs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=csyfpSUkr7eRQNbfFRxml26kHJ/WIuE/NZhqU9CPH26MbI8KrOn4sh/qyF4hGFLeBagLk9KoRQFgZM5l+2xCYJ2WkuQ1NHdqv1L/COq2FNkV9ukGVDj36k/wAbjgT78eb4qqH8Qz51BFEB2lQ8E13NJS8swxp/oKq6Gmq7hH4uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-886e18b5e13so9124639f.2
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 10:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756315177; x=1756919977;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjiXdLCfctwMNg9bkhL6n+ycMUPOZUiVReHJWB1zxBw=;
        b=CUjvLggvMdx4vbmQ2mlBqIo5ugCT4h+QWNUNIdCzawj0tHqP0QGs71Awi6ZCt4mrPR
         8HUKoKE+5rfxhBIN4K/9NAhBEJpZWPVIV083c+7mjKc5xlLDLPGLusHb57tPaNo2ELE4
         dAy/1tUrgv3Vz8g+6NbIbqx6qm7qCD9UOqjxK8rBBi/1KTgH7/5lsVqfn9N26+X7RH8b
         kgcsrtCHF5aH9CKzlrP3unMWwTVwiRmEjehssODggncxU1zTdK46c31T2RrgqbprduQZ
         GlSStW7InlIOS8734GpX+UmONHt0+nRpbCFbHoutlDS6BOW5XUzNcshJD658gjq1dUG+
         Wjqg==
X-Forwarded-Encrypted: i=1; AJvYcCW8t4ReMtn+8mymcIbn75SaYggLxL77vftw2ZK68c2MyZSLpEfc/Ix2d53q7SSf59oHTACa+O0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKdn5cabbGh2xGOZ0gbxiWzNI1QM9IpqcgSS7OhAkkMCJKpMkc
	jnd29RDZZ4WNTMN2f9r8B0CY3XJbQTE5Ekr3I1V40zNA17PzhrqEUQa0Vj5FzolETQgzXaWdsJ1
	F8kLJcIkQwc4nYnpuCo5YPaHUGfMpdr13joctPbLVzmt7UqQeFf5vORXFUlU=
X-Google-Smtp-Source: AGHT+IEco9XwsvuSdkgVLocpTlpW4+Fen1aDiOmyXkgy8ZvjTrTqKXoicYuvhN5wflACRlNUiPVnS/1w1eA1w1FxJ8vkCZSGXByj
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:3e5:51bb:9cd9 with SMTP id
 e9e14a558f8ab-3e91fc29a4emr287844375ab.8.1756315177086; Wed, 27 Aug 2025
 10:19:37 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:19:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68af3e29.a70a0220.3cafd4.002e.GAE@google.com>
Subject: [syzbot] [hams?] general protection fault in rose_rt_ioctl
From: syzbot <syzbot+2eb8d1719f7cfcfa6840@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ceb951552404 Merge branch 'introduce-refcount_t-for-refere..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1038cfbc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=292f3bc9f654adeb
dashboard link: https://syzkaller.appspot.com/bug?extid=2eb8d1719f7cfcfa6840
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7a0a7a3f8dbc/disk-ceb95155.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ec99703c0bdd/vmlinux-ceb95155.xz
kernel image: https://storage.googleapis.com/syzbot-assets/248da817e5e1/bzImage-ceb95155.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2eb8d1719f7cfcfa6840@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 UID: 0 PID: 21085 Comm: syz.4.4642 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:rose_clear_routes net/rose/rose_route.c:565 [inline]
RIP: 0010:rose_rt_ioctl+0x162/0x1250 net/rose/rose_route.c:760
Code: 3f 31 ff 44 89 fe e8 3d de 52 f7 45 85 ff 74 0a e8 33 db 52 f7 e9 76 02 00 00 48 8b 44 24 28 48 8d 50 10 49 89 d7 49 c1 ef 03 <43> 0f b6 04 2f 84 c0 48 89 54 24 20 0f 85 87 02 00 00 44 0f b6 22
RSP: 0018:ffffc9000bb77ae0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff8880529fd800 RCX: 0000000000000000
RDX: 0000000000000010 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000bb77c10 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff5200176ef4c R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff88804bc15300 R15: 0000000000000002
FS:  00007f4e974376c0(0000) GS:ffff888125d1b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32163fff CR3: 000000006a0fe000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rose_ioctl+0x3ce/0x8b0 net/rose/af_rose.c:1381
 sock_do_ioctl+0xd9/0x300 net/socket.c:1238
 sock_ioctl+0x576/0x790 net/socket.c:1359
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4e9658ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4e97437038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4e967b5fa0 RCX: 00007f4e9658ebe9
RDX: 0000000000000000 RSI: 00000000000089e4 RDI: 0000000000000004
RBP: 00007f4e96611e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4e967b6038 R14: 00007f4e967b5fa0 R15: 00007ffe31b011d8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:rose_clear_routes net/rose/rose_route.c:565 [inline]
RIP: 0010:rose_rt_ioctl+0x162/0x1250 net/rose/rose_route.c:760
Code: 3f 31 ff 44 89 fe e8 3d de 52 f7 45 85 ff 74 0a e8 33 db 52 f7 e9 76 02 00 00 48 8b 44 24 28 48 8d 50 10 49 89 d7 49 c1 ef 03 <43> 0f b6 04 2f 84 c0 48 89 54 24 20 0f 85 87 02 00 00 44 0f b6 22
RSP: 0018:ffffc9000bb77ae0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff8880529fd800 RCX: 0000000000000000
RDX: 0000000000000010 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000bb77c10 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff5200176ef4c R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff88804bc15300 R15: 0000000000000002
FS:  00007f4e974376c0(0000) GS:ffff888125d1b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32163fff CR3: 000000006a0fe000 CR4: 00000000003526f0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	31 ff                	xor    %edi,%edi
   2:	44 89 fe             	mov    %r15d,%esi
   5:	e8 3d de 52 f7       	call   0xf752de47
   a:	45 85 ff             	test   %r15d,%r15d
   d:	74 0a                	je     0x19
   f:	e8 33 db 52 f7       	call   0xf752db47
  14:	e9 76 02 00 00       	jmp    0x28f
  19:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
  1e:	48 8d 50 10          	lea    0x10(%rax),%rdx
  22:	49 89 d7             	mov    %rdx,%r15
  25:	49 c1 ef 03          	shr    $0x3,%r15
* 29:	43 0f b6 04 2f       	movzbl (%r15,%r13,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
  35:	0f 85 87 02 00 00    	jne    0x2c2
  3b:	44 0f b6 22          	movzbl (%rdx),%r12d


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

