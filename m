Return-Path: <netdev+bounces-156563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D7DA06FC2
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9F6167D25
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 08:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451DA214A7D;
	Thu,  9 Jan 2025 08:11:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9C62144DD
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736410283; cv=none; b=j6JQuhIHr2L5fyHM8lUFhikihzScA1OdAjMKy08GkfYT8j0zopV6HR45L5QIzqy09gq5KOKGl3AQuaIfHB6NaJDv9wCxBcqErqpRxjwhHEmTNGR4neqqqbN6hYKSH4IQRCtRTnO21dCvsy3xN4wMND6sRo81aafEh25DvrOT4hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736410283; c=relaxed/simple;
	bh=d9a9xF03542ie2bd44uN9mnqRJel7iJv07cKTH8pqBc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ujRCmkR6gcXe5EMtZvujKXIyTnk68VbAmdXH9qsAhy508u9QcsiTg6wkdTKiXjB4QpE31EH0cRV/ZdUFCu9G7mGfQ63NqJ7RxS1iFcQjEn3RUSFqFhvDD4t/kKL1lZ+z1ac11sFy/2cfFUpKr961wSHxhksiDJJen0UMeyvz8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a9d4ea9e0cso5599105ab.0
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 00:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736410280; x=1737015080;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RK4rXM1FgmqnXM8BFzphg44L66SnjDZ4JF88m96fuv8=;
        b=CMyYkKdzUMurwa2b+GxKS1MNHEWsJRJAb28m0ptjYkgGw6nt0EpPL4mg6+cvTp+h5H
         pvMH3lsh9GgTl6sA+PgVbKf8JVsELEJVZrHa+1D+5riFV6Lcnc1/LH2MNh1eNvwFCcdV
         wDjD49YylGn3uYBFbbDKWYKJ5u+ivwvmTCZDxzKRLejzZcxOhiXkyJUXoRX3P0FZ5CkK
         maeeKz4yCy7azklP7sUan3dtYHtK6EBB5Gq244BZGDySMqIMhv2coH0rDv5+plAnFdnw
         M33250PcOTOx97rBTHYWNKvfBSnK7f90IgO3AjPIuDQ2C12m0Tch6VzWnH43nQRaR9A5
         PnYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV/u1u/Ez3gE5SFRS07zBlpthz2YW8246Trc6VS5LikGUG8YBoDmk6Zh7J0b/Dfhkl0cgDo6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcaUAvJMoyPqTqQQGV99ZgwMn4CtjV2O17TbccuGcP0tR53Oa/
	VcYONLOwrRabPvMvUuzcL9PIUPIa9Dl68k4OjMDPNi0oChfzzR98c1JQDn3UnVb28gPaSEHEZVN
	aFCyHOQ8DB5gVsoVuSgye6iOVOL4OXjin6N7VgAEOcionNExdrOwTyV4=
X-Google-Smtp-Source: AGHT+IG5Tp+DFsS/bds6JxrccKhSq7g0fal8rOnrdF62JsCFwj8O2D9M3az8lkhjN5pdWiwLa0Sly73fMrPWEdvyqRJjCC6RgjzH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:308b:b0:3a7:6c6a:e2a2 with SMTP id
 e9e14a558f8ab-3ce3a9b8f55mr48064295ab.9.1736410280572; Thu, 09 Jan 2025
 00:11:20 -0800 (PST)
Date: Thu, 09 Jan 2025 00:11:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677f84a8.050a0220.25a300.01b3.GAE@google.com>
Subject: [syzbot] [virt?] [net?] general protection fault in vsock_connectible_has_data
From: syzbot <syzbot+3affdbfc986ecd9200fd@syzkaller.appspotmail.com>
To: cong.wang@bytedance.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8ce4f287524c net: libwx: fix firmware mailbox abnormal ret..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13f06edf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c541fa8af5c9cc7
dashboard link: https://syzkaller.appspot.com/bug?extid=3affdbfc986ecd9200fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15695418580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124c56f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e09bf4b8939b/disk-8ce4f287.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7f7846f83db/vmlinux-8ce4f287.xz
kernel image: https://storage.googleapis.com/syzbot-assets/44540dea47ac/bzImage-8ce4f287.xz

The issue was bisected to:

commit 69139d2919dd4aa9a553c8245e7c63e82613e3fc
Author: Cong Wang <cong.wang@bytedance.com>
Date:   Mon Aug 12 02:21:53 2024 +0000

    vsock: fix recursive ->recvmsg calls

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116bc4b0580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=136bc4b0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=156bc4b0580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3affdbfc986ecd9200fd@syzkaller.appspotmail.com
Fixes: 69139d2919dd ("vsock: fix recursive ->recvmsg calls")

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000014: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000000a0-0x00000000000000a7]
CPU: 1 UID: 0 PID: 5828 Comm: syz-executor976 Not tainted 6.13.0-rc5-syzkaller-00142-g8ce4f287524c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:vsock_connectible_has_data+0x85/0x100 net/vmw_vsock/af_vsock.c:882
Code: 80 3c 38 00 74 08 48 89 df e8 e7 e0 5f f6 48 8b 1b 66 83 fd 05 75 3a e8 d9 78 f9 f5 48 81 c3 a0 00 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 bc e0 5f f6 4c 8b 1b 4c 89 f7 41
RSP: 0018:ffffc900015976f8 EFLAGS: 00010206
RAX: 0000000000000014 RBX: 00000000000000a0 RCX: ffff888033e09e00
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000005
RBP: 0000000000000005 R08: ffffffff8ba5fadc R09: 1ffffffff285492b
R10: dffffc0000000000 R11: fffffbfff285492c R12: 0000000000002000
R13: dffffc0000000000 R14: ffff888033e18000 R15: dffffc0000000000
FS:  00005555565ca380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200061c8 CR3: 0000000074f74000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vsock_has_data net/vmw_vsock/vsock_bpf.c:30 [inline]
 vsock_bpf_recvmsg+0x4b5/0x10a0 net/vmw_vsock/vsock_bpf.c:87
 sock_recvmsg_nosec net/socket.c:1033 [inline]
 sock_recvmsg+0x22f/0x280 net/socket.c:1055
 ____sys_recvmsg+0x1c6/0x480 net/socket.c:2803
 ___sys_recvmsg net/socket.c:2845 [inline]
 do_recvmmsg+0x426/0xab0 net/socket.c:2940
 __sys_recvmmsg net/socket.c:3014 [inline]
 __do_sys_recvmmsg net/socket.c:3037 [inline]
 __se_sys_recvmmsg net/socket.c:3030 [inline]
 __x64_sys_recvmmsg+0x199/0x250 net/socket.c:3030
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb38b2465e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd43f6938 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007fffd43f6b08 RCX: 00007fb38b2465e9
RDX: 0000000000000001 RSI: 00000000200061c0 RDI: 0000000000000003
RBP: 00007fb38b2b9610 R08: 0000000000000000 R09: 00007fffd43f6b08
R10: 0000000000002000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffd43f6af8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vsock_connectible_has_data+0x85/0x100 net/vmw_vsock/af_vsock.c:882
Code: 80 3c 38 00 74 08 48 89 df e8 e7 e0 5f f6 48 8b 1b 66 83 fd 05 75 3a e8 d9 78 f9 f5 48 81 c3 a0 00 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 bc e0 5f f6 4c 8b 1b 4c 89 f7 41
RSP: 0018:ffffc900015976f8 EFLAGS: 00010206
RAX: 0000000000000014 RBX: 00000000000000a0 RCX: ffff888033e09e00
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000005
RBP: 0000000000000005 R08: ffffffff8ba5fadc R09: 1ffffffff285492b
R10: dffffc0000000000 R11: fffffbfff285492c R12: 0000000000002000
R13: dffffc0000000000 R14: ffff888033e18000 R15: dffffc0000000000
FS:  00005555565ca380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 0000000074f74000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	80 3c 38 00          	cmpb   $0x0,(%rax,%rdi,1)
   4:	74 08                	je     0xe
   6:	48 89 df             	mov    %rbx,%rdi
   9:	e8 e7 e0 5f f6       	call   0xf65fe0f5
   e:	48 8b 1b             	mov    (%rbx),%rbx
  11:	66 83 fd 05          	cmp    $0x5,%bp
  15:	75 3a                	jne    0x51
  17:	e8 d9 78 f9 f5       	call   0xf5f978f5
  1c:	48 81 c3 a0 00 00 00 	add    $0xa0,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 bc e0 5f f6       	call   0xf65fe0f5
  39:	4c 8b 1b             	mov    (%rbx),%r11
  3c:	4c 89 f7             	mov    %r14,%rdi
  3f:	41                   	rex.B


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

