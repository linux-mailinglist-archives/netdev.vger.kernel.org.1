Return-Path: <netdev+bounces-125851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F359B96EF3C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840BD1F2244E
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64371C7B94;
	Fri,  6 Sep 2024 09:29:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0200A1C7B9B
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614970; cv=none; b=XOIPXiw8hrz7X3rPWmHnD6rwPkhiTX08shw2kHu9we22lk1VBY+0oFrq46GH5gloKvuw6AkgBI5ZDgwoEMoVQT9qUdFbkCbOrGLr0qknApPujyvV7KKESiZ2/LzrAR/kgtyaCpaNbvuNz9xMRbgG3lPzOjjyBuqyfcmryL9iDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614970; c=relaxed/simple;
	bh=fJfzHSInhoHoY5Jojv+ycocnJdn72qEwJd9jdDTkLdc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PfzYmWjhxrbvEpsJKjP+1xogudGpaT+LfvLupoA2L5cYYprH5yq9ie1i6xSsUoxvBcM74WdvVsSTA5rr+vNMSr5ckDARFOxTHjbTLbEx2wK8OkMTMOsqvPiYzPFwDnBD6l15U3b8YI1fHK/OE8XJtw4wNk/jObHE+krRbumGzJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a3ad86c74so402498339f.3
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 02:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725614968; x=1726219768;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dm4FFk+1pNfM2Fp0sRJnYHmPPOHH5Ow4vVfTO7nt6hk=;
        b=OE0KRsp7XYvZlrYponctxhJzGEDgV/9tfZOx8rFX8Vu1RNqBQ3rcBlcVx36+p5sIkq
         GMtNoF7ePgV8aSXHh9wp5yG6YRgBlegk8R/OLL/Hl3AvoJJrAI5AOl0oNzYiO/mwK/+T
         Tlu5/UStdRM2Uzokuktvscn4vymiFhTwrOQ46iLpFotK3BXjhXmhcAZdptBayLRxv6QS
         RaUrLMkTL2w4B0rr58180iMVBpiJ9aXZ1FHS/UF5HdjGpFSUBRZzM8nWFYbOHPFCLkF2
         LM/FZLJEQ7iHYYWOpyk/ePshe1OvRRdrBEpKiFdBzkXe8tMc1MIGuUEqg1isrrP2ru3s
         n4Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUF7fwUFLrAu7Jvt6b45EKP5ZiweRtcmYIGLKieY2R8RP2ENxHiXx+xAgsDfFgQAU8I8jPh5X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOY2cWxNmRCFYKKb4yLdlWSRK8ZGxJvD7ScAw7W9nuM40dY7s3
	xpVTv5o43MjcgUpmPvqQhQ6gRXstshxcAreFgZVBz1/9mwDWH1IUHK992JWLWOIF1iMjtmIl2dP
	WHvk710PH6wLGeR2mNUIhLfoJ1EcbKadp4ZhcoIhPk1+996mtgMpY+9c=
X-Google-Smtp-Source: AGHT+IG9y9THT5WUBTsr+ISyqEEXWAzFKgxLS41DECEA18dM+01I4v5xVvUFW4ydKx7jPL7TE6QH2puEnL9yPjnurFNVV1G+3Kxz
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2710:b0:4c2:8e08:f588 with SMTP id
 8926c6da1cb9f-4d084ea65d2mr180601173.2.1725614968058; Fri, 06 Sep 2024
 02:29:28 -0700 (PDT)
Date: Fri, 06 Sep 2024 02:29:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000030c41e0621700b61@google.com>
Subject: [syzbot] [net?] general protection fault in hsr_proxy_announce
From: syzbot <syzbot+02a42d9b1bd395cbcab4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    780801200300 Merge branch 'fbnic-ethtool'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10175d29980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=02a42d9b1bd395cbcab4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/030fc5a1120b/disk-78080120.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b3504af771a/vmlinux-78080120.xz
kernel image: https://storage.googleapis.com/syzbot-assets/076c89aa8522/bzImage-78080120.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+02a42d9b1bd395cbcab4@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 UID: 0 PID: 11116 Comm: syz.4.1509 Not tainted 6.11.0-rc5-syzkaller-00859-g780801200300 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:hsr_proxy_announce+0x2a2/0x4c0 net/hsr/hsr_device.c:437
Code: 8b 64 24 30 4c 8b 6c 24 28 eb 05 e8 38 1e f9 f5 48 8b 5c 24 20 48 83 c3 10 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 4c 8b 74 24 18 74 08 48 89 df e8 fb 68 60 f6 48 8b 1b
RSP: 0018:ffffc90000a18ae0 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000000010 RCX: dffffc0000000000
RDX: 0000000000000100 RSI: 0000000000000003 RDI: ffff888028de6cc0
RBP: ffffc90000a18bb0 R08: ffffffff8b9a6c52 R09: 1ffffffff283cb08
R10: dffffc0000000000 R11: fffffbfff283cb09 R12: 1ffff92000143164
R13: ffffffff8b9a6c21 R14: ffff888028de6cf0 R15: ffff888028de6cf0
FS:  00007f1c709906c0(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1c7098ff98 CR3: 00000000652c4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 call_timer_fn+0x18e/0x650 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2417 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2428
 run_timer_base kernel/time/timer.c:2437 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__text_poke+0xa4a/0xd30 arch/x86/kernel/alternative.c:1960
Code: 7c 24 50 00 75 19 e8 b5 56 5e 00 eb 18 e8 ae 56 5e 00 e8 39 05 85 0a 48 83 7c 24 50 00 74 e7 e8 9c 56 5e 00 fb 48 8b 44 24 78 <42> 80 3c 28 00 74 0d 48 8d bc 24 60 01 00 00 e8 72 a1 c5 00 48 8b
RSP: 0018:ffffc900091f79c0 EFLAGS: 00000287
RAX: 1ffff9200123ef64 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc9000a0bc000 RSI: 0000000000023bf4 RDI: 0000000000023bf5
RBP: ffffc900091f7b90 R08: ffffffff81353564 R09: 1ffffffff283cb08
R10: dffffc0000000000 R11: fffffbfff283cb09 R12: 1ffff9200123ef48
R13: dffffc0000000000 R14: 0000000000000046 R15: ffffffff81b6cc2c
 text_poke arch/x86/kernel/alternative.c:1984 [inline]
 text_poke_bp_batch+0x8cd/0xb30 arch/x86/kernel/alternative.c:2373
 text_poke_flush arch/x86/kernel/alternative.c:2486 [inline]
 text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2493
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_slow_inc_cpuslocked+0x80/0xf0 kernel/jump_label.c:168
 static_key_slow_inc+0x1a/0x30 kernel/jump_label.c:191
 bpf_enable_runtime_stats kernel/bpf/syscall.c:5541 [inline]
 bpf_enable_stats+0xfe/0x140 kernel/bpf/syscall.c:5560
 __sys_bpf+0x75b/0x810 kernel/bpf/syscall.c:5793
 __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5815
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1c6fb7cef9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1c70990038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f1c6fd35f80 RCX: 00007f1c6fb7cef9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000020
RBP: 00007f1c6fbef01e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f1c6fd35f80 R15: 00007ffdbe19d3a8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hsr_proxy_announce+0x2a2/0x4c0 net/hsr/hsr_device.c:437
Code: 8b 64 24 30 4c 8b 6c 24 28 eb 05 e8 38 1e f9 f5 48 8b 5c 24 20 48 83 c3 10 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 4c 8b 74 24 18 74 08 48 89 df e8 fb 68 60 f6 48 8b 1b
RSP: 0018:ffffc90000a18ae0 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000000010 RCX: dffffc0000000000
RDX: 0000000000000100 RSI: 0000000000000003 RDI: ffff888028de6cc0
RBP: ffffc90000a18bb0 R08: ffffffff8b9a6c52 R09: 1ffffffff283cb08
R10: dffffc0000000000 R11: fffffbfff283cb09 R12: 1ffff92000143164
R13: ffffffff8b9a6c21 R14: ffff888028de6cf0 R15: ffff888028de6cf0
FS:  00007f1c709906c0(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1c7098ff98 CR3: 00000000652c4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8b 64 24 30          	mov    0x30(%rsp),%esp
   4:	4c 8b 6c 24 28       	mov    0x28(%rsp),%r13
   9:	eb 05                	jmp    0x10
   b:	e8 38 1e f9 f5       	call   0xf5f91e48
  10:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
  15:	48 83 c3 10          	add    $0x10,%rbx
  19:	48 89 d8             	mov    %rbx,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	4c 8b 74 24 18       	mov    0x18(%rsp),%r14
  33:	74 08                	je     0x3d
  35:	48 89 df             	mov    %rbx,%rdi
  38:	e8 fb 68 60 f6       	call   0xf6606938
  3d:	48 8b 1b             	mov    (%rbx),%rbx


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

