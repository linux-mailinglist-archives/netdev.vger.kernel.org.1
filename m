Return-Path: <netdev+bounces-154739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0529FFA43
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 15:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C091621A5
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 14:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177E17462;
	Thu,  2 Jan 2025 14:12:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5247319F40B
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827150; cv=none; b=szOuB9nTRUfk5Bxkh1b6AJEr6+U4YIWZvMgg1u5kAruCveptaT922321c5Id2jRVZWMAfn6Qb4itaqF4/YI8Zn3htIVOPm4yA5rkLH9dNsZByeIaccxB+K4Ae2JepMwEYPtLO0gwsr06tHGbEpxxSJOJNRENXfC5ClvNhJwCVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827150; c=relaxed/simple;
	bh=wPxn59tSgSmcO24LE33kLgcotvUU9ljXLuJfD8vRGuI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ol97EOxDpWoU1uzbXVtSV6gLxgTQtBAnLRTXzlQYYew+B60CdU5yliLyb1BrJZUOlQ4mTqTkugMdB0u79TArjKep/fd8sy9IAlVjgC2bteZD68gIgEhgDfMTc2Qf3XW1IYiEERFlez85kCdzGWoGpNYB0IK0mJsCYswVvDmg0fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a7d60252cbso95659405ab.0
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 06:12:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735827147; x=1736431947;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rkdKVs5gee22maPZSM64t26mDgvSK7e1wMmhQIaq3IA=;
        b=RHoUL4q22lmxM1CWBzdH1ZDTjRkfqJXLStu3MAS6N6LuxHtweTQ7Chidpwyr0x9/ET
         oK+aZr6kW/Bt7EAjrTeEOxoMzAWzKfobDnfCz7zby6zUAGqd8VsQ51FC9kfxX9DJxd1r
         Quddd6wEpSaWGyJ6p1o3ED35LRYCgapiarZ6myOlwQojhs43tj8FmIkWVJJIscneqYjJ
         fJUA22lr0Kv5jKCgphzn0plld2e6wZaZyrAi2zXTXMuWIHCbRsq6BaUFoEtVD8UusZ+L
         LS3jUjvWxvUEr2DnAD+pEGjB4oo6FCGcb9VOfOHBoiLUV/n3Rmq4Ys5DmP2ZFvduT39z
         gNjw==
X-Forwarded-Encrypted: i=1; AJvYcCUvzU6BpEIHh6Ji64pwtUTExxCdfvNVghlwLChMDYW1Py7ICKz9M6y1VWcBW6VCGu4orc7Q7AU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw02UgjEsAK4bvXogGyqhN/xN1JdvWQRtkosMY3UuTwZZmBHNtS
	CLrQVvUZpPO4zKXUpyZNLI0r8HK+nx2a8dIQmfYI1A35ltIQ5JsCiHGgfRGxN+YmBF0TvbxFoiO
	i9RnjKhjRFu0zzVlaU+ul6h//KRzo66a9coVKZiXzk8reUG3McGgpMu4=
X-Google-Smtp-Source: AGHT+IH6JAzal0ozoCrSLYDf9NMBl51hwmTv1n3XUr15Z+IqBxFpe5glpZd3aRK+boKDdvRvLv1Fd05FCBYTdbSjcR2mO1xzAZbj
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180a:b0:3a7:cf61:ded7 with SMTP id
 e9e14a558f8ab-3c3024370d0mr355166845ab.10.1735827147518; Thu, 02 Jan 2025
 06:12:27 -0800 (PST)
Date: Thu, 02 Jan 2025 06:12:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67769ecb.050a0220.3a8527.003f.GAE@google.com>
Subject: [syzbot] [mptcp?] general protection fault in proc_scheduler
From: syzbot <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ccb98ccef0e5 Merge tag 'platform-drivers-x86-v6.13-4' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128f6ac4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86dd15278dbfe19f
dashboard link: https://syzkaller.appspot.com/bug?extid=e364f774c6f57f2c86d1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1245eaf8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d24eb225cff7/disk-ccb98cce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dd81532f8240/vmlinux-ccb98cce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18b08e4bbf40/bzImage-ccb98cce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 1 UID: 0 PID: 5924 Comm: syz-executor Not tainted 6.13.0-rc5-syzkaller-00004-gccb98ccef0e5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:proc_scheduler+0xc6/0x3c0 net/mptcp/ctrl.c:125
Code: 03 42 80 3c 38 00 0f 85 fe 02 00 00 4d 8b a4 24 08 09 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 cc 02 00 00 4d 8b 7c 24 28 48 8d 84 24 c8 00 00
RSP: 0018:ffffc900034774e8 EFLAGS: 00010206

RAX: dffffc0000000000 RBX: 1ffff9200068ee9e RCX: ffffc90003477620
RDX: 0000000000000005 RSI: ffffffff8b08f91e RDI: 0000000000000028
RBP: 0000000000000001 R08: ffffc90003477710 R09: 0000000000000040
R10: 0000000000000040 R11: 00000000726f7475 R12: 0000000000000000
R13: ffffc90003477620 R14: ffffc90003477710 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fee3cd452d8 CR3: 000000007d116000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 proc_sys_call_handler+0x403/0x5d0 fs/proc/proc_sysctl.c:601
 __kernel_write_iter+0x318/0xa80 fs/read_write.c:612
 __kernel_write+0xf6/0x140 fs/read_write.c:632
 do_acct_process+0xcb0/0x14a0 kernel/acct.c:539
 acct_pin_kill+0x2d/0x100 kernel/acct.c:192
 pin_kill+0x194/0x7c0 fs/fs_pin.c:44
 mnt_pin_kill+0x61/0x1e0 fs/fs_pin.c:81
 cleanup_mnt+0x3ac/0x450 fs/namespace.c:1366
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xad8/0x2d70 kernel/exit.c:938
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
 get_signal+0x2576/0x2610 kernel/signal.c:3017
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fee3cb87a6a
Code: Unable to access opcode bytes at 0x7fee3cb87a40.
RSP: 002b:00007fffcccac688 EFLAGS: 00000202 ORIG_RAX: 0000000000000037
RAX: 0000000000000000 RBX: 00007fffcccac710 RCX: 00007fee3cb87a6a
RDX: 0000000000000041 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000003 R08: 00007fffcccac6ac R09: 00007fffcccacac7
R10: 00007fffcccac710 R11: 0000000000000202 R12: 00007fee3cd49500
R13: 00007fffcccac6ac R14: 0000000000000000 R15: 00007fee3cd4b000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:proc_scheduler+0xc6/0x3c0 net/mptcp/ctrl.c:125
Code: 03 42 80 3c 38 00 0f 85 fe 02 00 00 4d 8b a4 24 08 09 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 cc 02 00 00 4d 8b 7c 24 28 48 8d 84 24 c8 00 00
RSP: 0018:ffffc900034774e8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 1ffff9200068ee9e RCX: ffffc90003477620
RDX: 0000000000000005 RSI: ffffffff8b08f91e RDI: 0000000000000028
RBP: 0000000000000001 R08: ffffc90003477710 R09: 0000000000000040
R10: 0000000000000040 R11: 00000000726f7475 R12: 0000000000000000
R13: ffffc90003477620 R14: ffffc90003477710 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fee3cd452d8 CR3: 000000007d116000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
   5:	0f 85 fe 02 00 00    	jne    0x309
   b:	4d 8b a4 24 08 09 00 	mov    0x908(%r12),%r12
  12:	00
  13:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1a:	fc ff df
  1d:	49 8d 7c 24 28       	lea    0x28(%r12),%rdi
  22:	48 89 fa             	mov    %rdi,%rdx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	0f 85 cc 02 00 00    	jne    0x2ff
  33:	4d 8b 7c 24 28       	mov    0x28(%r12),%r15
  38:	48                   	rex.W
  39:	8d                   	.byte 0x8d
  3a:	84 24 c8             	test   %ah,(%rax,%rcx,8)


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

