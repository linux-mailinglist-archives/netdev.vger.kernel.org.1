Return-Path: <netdev+bounces-151205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 166989ED728
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 21:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD7828363E
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 20:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9540B209F4B;
	Wed, 11 Dec 2024 20:21:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCAB1FF1DC
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733948466; cv=none; b=UbiaCx6qwi+svkR5fJCrExcH/i1ik+V6LghpnrB5MG01sIo1bm9AfrXOgl/PDZ5n84Gvu4HRIPeYUdJ0nVp6eThvboho76mL8Wo2LhOr77DntpOPoKt/VzqFjsZetRuTmiIcmoXQAB8FHHVyJHTav1XMWNM3CtntwOcixD+NBdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733948466; c=relaxed/simple;
	bh=lvaQCeVkIYCkT9DBotBLM9+svJUwSmoJ7gFgLzlDQbM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XPq8WAbTwt59Z3svdGyfaY5ioJ4va0ZJWMozotWvlfuLL+5rzLRS0sMIDIoV+1wT3BcE7N+Unfu3zBUVCpf/23sR+vbNgkQkiKnVYWtFcRpLB+j71WC9C5zFtoqurs2UZmNOrLY+2OIHPRbSC9o3XQjlAoP0JtqkPtofeiNk86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a819a4e83dso57052105ab.1
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 12:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733948464; x=1734553264;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9cNXg/2uxH15+2KiSceUHIL2/zIf0OiqxHvqWf8o1g=;
        b=bsvZSW2uPI13LtPJ/8wXzDjmPO+eo5eLaDdGK4UGhdL9MRJ27xPm1S7a5LYWJsHqIv
         plzNdAhYOTJ0bnjxLdbX9DZ7FoCnsQzc0KBlBKf6EKGeQB+0vcBLgNA39XTitjX2f5Yh
         CGkHpLOPdi+/I3rPXgj8H6GCnPvGyfN2zWK2K/Ay4UJe+2aMxri8NLjk2N2iH8yuYb8x
         sxYXz5FARukbEejaoSEvAAACohLH4Z2j/bF6UI70qDIIkl2gv+k2sjE+iF/iY4/8MgmG
         D7atGFfA7OPTgpT/i3dTcgoC0p+/63m2L7cRAwmhgEubhhy3bkmOTps4rg6rNTl+7Bzw
         C8Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXGDD3ajGL4h3wtPKk1CFkSbtjTRFN1RYwzjggbFsu6PyphBVqCh3Vw03JHpuLjt/X1/tvIa+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOly2Kuqqq+KZorMHVoQH0vX1EqRu/Bz2jZ40CEA72IvCXWUmv
	MkgeuS1kwqGaH5hbZIpgeBTmU5rBViXllJjbl3xqazCrckFUdczAohi3AeQtbT4mpuVqTpYxVjq
	qs+uoAVRSWYwjwmu7jL3aNivsY7R1+r+OL+PgF6A4znvkmbs3bq8Ov6w=
X-Google-Smtp-Source: AGHT+IEiERMCOx0cSR7XVS+8OAA7JcUsTc0PA4DHiTXS80RK95Sq7oJNR8AoBrDhCfyInt8bhuQxRal/vayv+qwbV/VONRpy9W9q
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a7:b0:3a7:8720:9de5 with SMTP id
 e9e14a558f8ab-3ac470ce619mr11266675ab.1.1733948464164; Wed, 11 Dec 2024
 12:21:04 -0800 (PST)
Date: Wed, 11 Dec 2024 12:21:04 -0800
In-Reply-To: <Z1ntik1F3Fy5Zpvn@slm.duckdns.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6759f430.050a0220.17f54a.0044.GAE@google.com>
Subject: Re: [syzbot] [cgroups?] general protection fault in __cgroup_rstat_lock
From: syzbot <syzbot+31eb4d4e7d9bc1fc1312@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in __cgroup_rstat_lock

RBP: 00007f388c6bb0a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f388bb45fa0 R15: 00007fff5c4c6d18
 </TASK>
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
CPU: 0 UID: 0 PID: 6756 Comm: syz.0.16 Not tainted 6.13.0-rc2-syzkaller-ge0dac4f3fa34 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:cgroup_id include/linux/cgroup.h:326 [inline]
RIP: 0010:do_perf_trace_cgroup_rstat include/trace/events/cgroup.h:207 [inline]
RIP: 0010:perf_trace_cgroup_rstat+0x30f/0x580 include/trace/events/cgroup.h:207
Code: 50 01 00 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 a1 75 70 00 41 bd 88 00 00 00 4c 03 2b 4c 89 e8 48 c1 e8 03 <42> 80 3c 30 00 74 08 4c 89 ef e8 82 75 70 00 4d 8b 6d 00 49 8d 5f
RSP: 0018:ffffc9000158fa80 EFLAGS: 00010006
RAX: 0000000000000011 RBX: ffff88807d6c8150 RCX: ffff888029e69e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880b8637768
RBP: ffffc9000158fb70 R08: ffffffff81a8f8fb R09: 1ffffffff2032cae
R10: dffffc0000000000 R11: fffffbfff2032caf R12: ffff8880b86376e0
R13: 0000000000000088 R14: dffffc0000000000 R15: ffffe8ffffc38000
FS:  00007f388c6bb6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f05ffff CR3: 0000000033fbe000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 trace_cgroup_rstat_locked include/trace/events/cgroup.h:242 [inline]
 __cgroup_rstat_lock+0x3e1/0x590 kernel/cgroup/rstat.c:292
 cgroup_rstat_flush+0x30/0x50 kernel/cgroup/rstat.c:353
 cgroup_rstat_exit+0x27/0x1e0 kernel/cgroup/rstat.c:411
 cgroup_create kernel/cgroup/cgroup.c:5782 [inline]
 cgroup_mkdir+0x4f8/0xd60 kernel/cgroup/cgroup.c:5831
 kernfs_iop_mkdir+0x253/0x3f0 fs/kernfs/dir.c:1246
 vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4311
 do_mkdirat+0x264/0x3a0 fs/namei.c:4334
 __do_sys_mkdir fs/namei.c:4354 [inline]
 __se_sys_mkdir fs/namei.c:4352 [inline]
 __x64_sys_mkdir+0x6c/0x80 fs/namei.c:4352
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f388b97ff19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f388c6bb058 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007f388bb45fa0 RCX: 00007f388b97ff19
RDX: 0000000000000000 RSI: d0939199c36b4d28 RDI: 0000000020000000
RBP: 00007f388c6bb0a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f388bb45fa0 R15: 00007fff5c4c6d18
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:cgroup_id include/linux/cgroup.h:326 [inline]
RIP: 0010:do_perf_trace_cgroup_rstat include/trace/events/cgroup.h:207 [inline]
RIP: 0010:perf_trace_cgroup_rstat+0x30f/0x580 include/trace/events/cgroup.h:207
Code: 50 01 00 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 a1 75 70 00 41 bd 88 00 00 00 4c 03 2b 4c 89 e8 48 c1 e8 03 <42> 80 3c 30 00 74 08 4c 89 ef e8 82 75 70 00 4d 8b 6d 00 49 8d 5f
RSP: 0018:ffffc9000158fa80 EFLAGS: 00010006
RAX: 0000000000000011 RBX: ffff88807d6c8150 RCX: ffff888029e69e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880b8637768
RBP: ffffc9000158fb70 R08: ffffffff81a8f8fb R09: 1ffffffff2032cae
R10: dffffc0000000000 R11: fffffbfff2032caf R12: ffff8880b86376e0
R13: 0000000000000088 R14: dffffc0000000000 R15: ffffe8ffffc38000
FS:  00007f388c6bb6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f05ffff CR3: 0000000033fbe000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	50                   	push   %rax
   1:	01 00                	add    %eax,(%rax)
   3:	00 48 89             	add    %cl,-0x77(%rax)
   6:	d8 48 c1             	fmuls  -0x3f(%rax)
   9:	e8 03 42 80 3c       	call   0x3c804211
   e:	30 00                	xor    %al,(%rax)
  10:	74 08                	je     0x1a
  12:	48 89 df             	mov    %rbx,%rdi
  15:	e8 a1 75 70 00       	call   0x7075bb
  1a:	41 bd 88 00 00 00    	mov    $0x88,%r13d
  20:	4c 03 2b             	add    (%rbx),%r13
  23:	4c 89 e8             	mov    %r13,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ef             	mov    %r13,%rdi
  34:	e8 82 75 70 00       	call   0x7075bb
  39:	4d 8b 6d 00          	mov    0x0(%r13),%r13
  3d:	49                   	rex.WB
  3e:	8d                   	.byte 0x8d
  3f:	5f                   	pop    %rdi


Tested on:

commit:         e0dac4f3 test
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.13-fixes-test
console output: https://syzkaller.appspot.com/x/log.txt?x=1119bb30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
dashboard link: https://syzkaller.appspot.com/bug?extid=31eb4d4e7d9bc1fc1312
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

