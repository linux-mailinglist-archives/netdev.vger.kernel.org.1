Return-Path: <netdev+bounces-117270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D987794D597
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550A21F22534
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 17:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD4C7D405;
	Fri,  9 Aug 2024 17:42:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D7F6EB64
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723225344; cv=none; b=oQq/93cTYSYXE3/XUuNxtS2XxYfZklDbwqTL28waWJ16gDqXRyJVdwnkj2rCCrVjSVVQGnXasLlFOw2r1S8EHn8NSMih3oxsRltjiHuqGN7C8lHDtHu69lxCVQCUfaK8tObixactQrHNv5SXghnLOyCXVbGawRdUH2JLy2iVDeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723225344; c=relaxed/simple;
	bh=2EPSHaSW0yT5CPf+czwsFP98vo+s3mtIrzY0EJqp4nY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=l86vDd5W6qQ7sBhF3o27VuxNS+y3vt06rUJPpWG7pytCErpzPrxay2+ikU8TcOPqQgAI7R9NhHUlj9dOeMwnjrlVfiI19RNIo6fS6WQAXLxiV3VHEy9f2b8zfbHPO45rsE1o6A38FhnYYEzAVIjQPPpFLBiQw6zPn215p230K5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f901cd3b5so273992039f.1
        for <netdev@vger.kernel.org>; Fri, 09 Aug 2024 10:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723225342; x=1723830142;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9SikiXrI54ueCXpMjmkzPfTZL2o5GTEvSUXBGW0l+c=;
        b=T/WzAm9GgwImz1fLkTXkaLTSHkt0URXq3r2z2HyTMMN7jK+Ptnv9p25b5C9jS36XUv
         WbeRWbgTPXnRUlAqP/TXmSo+gp6agAO0ksIk2xfWafWFZFoCFiPr+E4C5BqCKoiVko06
         RAQmr0VLdbatOGn+bN4HdeZA/3nGV7ItszwroZZWco6oSq5wx1Xy8aCp5jZd5UaozjJC
         r7oM+zddRFOQ3UOJqC4ZL5lE0ydaGCgAEQYTdqH0oZDWQtww5KD7AzcY9PSZANSZHFxQ
         9dqWoUkNCfqpuPTuNVFNMuaRRRJtFzbvAofaO5XJpPpvYpa59NEU7zmMSS40tN+DnCOR
         Mchw==
X-Forwarded-Encrypted: i=1; AJvYcCVq4HH/STTngK0VeYhIwSrXHN7keZLVF7c310aWU1rX9wXuQ7oeR/Nbkj7x43OtUW6TvOD4E34lWIAHrI65CH8PQeQKtCRN
X-Gm-Message-State: AOJu0Yyufntge8xYJ2mv3YRt3QumY373EN26mIgepo6foTa1yfCXZRrn
	lynPX5RBlEay4A9CdVCSEr1iLRVF/6vedDOFk+B8jlo/LIv2qj+HGHKbgcFJEzRLC+JqFPANThP
	fVOwj4XX+lx2yps7MMazdIDMU52FBpDXzvEPK1hTqrWDeB+qW2FLnSBE=
X-Google-Smtp-Source: AGHT+IG9Oc8XZg6vWyomVTHNWwBsWAUBtRLh7A5wdI4Uy01LkStS9EX8Y34o0MyDKdmQ4OK7nIWE3jiqaRJ3GuUFnwOr/Q4SRsMU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13c3:b0:81f:c103:3e70 with SMTP id
 ca18e2360f4ac-8225ee71692mr8376839f.4.1723225341905; Fri, 09 Aug 2024
 10:42:21 -0700 (PDT)
Date: Fri, 09 Aug 2024 10:42:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f5a6d061f43aabe@google.com>
Subject: [syzbot] [net?] [virt?] BUG: stack guard page was hit in vsock_bpf_recvmsg
From: syzbot <syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eb3ab13d997a net: ti: icssg_prueth: populate netdev of_node
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16bc9dbd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=bdb4bd87b5e22058e2a4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d4f4f5980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17522ec5980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/451ec795f57e/disk-eb3ab13d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e6f090c32577/vmlinux-eb3ab13d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ac63cb5127b1/bzImage-eb3ab13d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com

BUG: TASK stack guard page was hit at ffffc9000358ff58 (stack is ffffc90003590000..ffffc90003598000)
Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5231 Comm: syz-executor149 Not tainted 6.11.0-rc2-syzkaller-00271-geb3ab13d997a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:validate_chain+0x1f/0x5900 kernel/locking/lockdep.c:3824
Code: 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 e0 48 81 ec c0 02 00 00 49 89 ce <89> 54 24 58 48 89 bc 24 80 00 00 00 65 48 8b 04 25 28 00 00 00 48
RSP: 0018:ffffc9000358ff60 EFLAGS: 00010086
RAX: 1ffffffff268c780 RBX: ffffffff93463c00 RCX: 7195f92be3ffb448
RDX: 0000000000000001 RSI: ffff88807cc6c6e0 RDI: ffff88807cc6bc00
RBP: ffffc90003590260 R08: ffffffff9372e8cf R09: 1ffffffff26e5d19
R10: dffffc0000000000 R11: fffffbfff26e5d1a R12: 0000000000000001
R13: ffff88807cc6c6d8 R14: 7195f92be3ffb448 R15: ffff88807cc6c700
FS:  000055556f04f380(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000358ff58 CR3: 0000000023e1e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <#DF>
 </#DF>
 <TASK>
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 reacquire_held_locks+0x3eb/0x690 kernel/locking/lockdep.c:5284
 __lock_release kernel/locking/lockdep.c:5473 [inline]
 lock_release+0x396/0xa30 kernel/locking/lockdep.c:5780
 sock_release_ownership include/net/sock.h:1722 [inline]
 release_sock+0x12f/0x1f0 net/core/sock.c:3564
 vsock_bpf_recvmsg+0x60f/0x1090 net/vmw_vsock/vsock_bpf.c:88
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 vsock_bpf_recvmsg+0xcf5/0x1090
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x22f/0x280 net/socket.c:1068
 ____sys_recvmsg+0x1db/0x470 net/socket.c:2816
 ___sys_recvmsg net/socket.c:2858 [inline]
 __sys_recvmsg+0x2f0/0x3e0 net/socket.c:2888
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f66591e2c79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe616028d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002f
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f66591e2c79
RDX: 0000000000010042 RSI: 00000000200003c0 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:validate_chain+0x1f/0x5900 kernel/locking/lockdep.c:3824
Code: 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 e0 48 81 ec c0 02 00 00 49 89 ce <89> 54 24 58 48 89 bc 24 80 00 00 00 65 48 8b 04 25 28 00 00 00 48
RSP: 0018:ffffc9000358ff60 EFLAGS: 00010086
RAX: 1ffffffff268c780 RBX: ffffffff93463c00 RCX: 7195f92be3ffb448
RDX: 0000000000000001 RSI: ffff88807cc6c6e0 RDI: ffff88807cc6bc00
RBP: ffffc90003590260 R08: ffffffff9372e8cf R09: 1ffffffff26e5d19
R10: dffffc0000000000 R11: fffffbfff26e5d1a R12: 0000000000000001
R13: ffff88807cc6c6d8 R14: 7195f92be3ffb448 R15: ffff88807cc6c700
FS:  000055556f04f380(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000358ff58 CR3: 0000000023e1e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	f3 0f 1e fa          	endbr64
   f:	55                   	push   %rbp
  10:	48 89 e5             	mov    %rsp,%rbp
  13:	41 57                	push   %r15
  15:	41 56                	push   %r14
  17:	41 55                	push   %r13
  19:	41 54                	push   %r12
  1b:	53                   	push   %rbx
  1c:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  20:	48 81 ec c0 02 00 00 	sub    $0x2c0,%rsp
  27:	49 89 ce             	mov    %rcx,%r14
* 2a:	89 54 24 58          	mov    %edx,0x58(%rsp) <-- trapping instruction
  2e:	48 89 bc 24 80 00 00 	mov    %rdi,0x80(%rsp)
  35:	00
  36:	65 48 8b 04 25 28 00 	mov    %gs:0x28,%rax
  3d:	00 00
  3f:	48                   	rex.W


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

