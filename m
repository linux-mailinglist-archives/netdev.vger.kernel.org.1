Return-Path: <netdev+bounces-198494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 130CBADC6AC
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30E63AE7A8
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7FB29552A;
	Tue, 17 Jun 2025 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4AW5cXS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E5A290BC8
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152882; cv=none; b=Z1t/K49us62XwXtWlF6ds/n22mjJZuT2zCBVBvABPPNcOBMOPEjYqsb7AERoMd+qUAInLRrtMxzyMikODlgg9b4Xz7zWt4hfRbYZe2HQllzr60fVArnB1+4wiBCg8Rd2rDQ2ngV0+Co+xdh7aE9s3ENJOLh7i3V/rYjckJvYtsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152882; c=relaxed/simple;
	bh=4mXybjNql83roRvkXEyu7iXZ4aNdvN0yFRChnAR8npc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m31M9xQ7foXpcKUt8fVFJBTOm/F+f4LMRN9TQxgXfx6IhlE4Buf+FjG346X2CFRCl6rJUEEsYK2QkCK+h9NEkka5i3uHjaBzT4g2jKKU5Wh9NpP/CV4WPJOg5NYAQPFmyyY3VM3C8ZXoveSIp0oOVPBUnhhfq9VW/7bGDrbpWms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y4AW5cXS; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b31befde0a0so135664a12.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 02:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750152879; x=1750757679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7f5U2YQyJ7Sib6/GxtNtbuYrRnQxjNTxtDfhJh7cr4=;
        b=Y4AW5cXSzmvc6qBTeU9V4baHoxDs173VJaX8YBMsepvGZt95fhNHV1r0aL0YjMIEbR
         723Gbe8+wgzrs3Sfc0bE9kn8lOZ4f//Wwc3eSaGpszr3z3yF9WjyKoG58kmP9HrxNa10
         wpR+T672cPfHTwuHK5hsNQy53VRyrR+sThYsrwBhCH0pnjRxVgy279Y9BSKC+SSD11zT
         dzWY+G1R4uvXIcplrvoCM3tJd7T87uyaYaAPowYVu6Rs+2BeJ1uwN3f79c3/N0Gz/d2C
         9HCiQcCktOoIpu4xWfdpf/L6MYcotzOlrTw01v/gCSSVXVtbHNtArFmlv+KLsjya1Jof
         O7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750152879; x=1750757679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7f5U2YQyJ7Sib6/GxtNtbuYrRnQxjNTxtDfhJh7cr4=;
        b=TO85+uzY1kwIkdV9WBqo9w08UeNypTU9g6tkv7x20MCsYzo21jJfuRkaxzTR777aqA
         xGMeJSiJq2Q2nqxXOjzdLlGZ0xpIFNqmlGs55bLbexemBqnnIXF/jHJDhGpcDf8a/ksI
         iod1rr3MJpodHvuM6Gh+Oc0gg+GYafeME3QcHZuGszUo3UNXHIVE9uB5lK8AZBux4uBR
         7zSfHrKzSHIhv0HYv7t9yfYqdxcYe+Oq0dpiNbKEWiOLmE3Wj8VYTtIkpWCj2Yf61lq9
         cTrsArMCQKzFDOGxE/FL1Nxh0Qkr0nF7DETcfnH1XXtDqxL3A68g9ldvw3WpLPxi90ib
         bMyA==
X-Forwarded-Encrypted: i=1; AJvYcCU/mAQIJim5LnJ7qu5woafBHkuCUkdl0sZQjUao7ZFo+Ds27g3NDiBjDRDj80o+j+Lm4x/1TU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIfN33vYIV+aqhqmqlcADn95EDKZ/k0Xzqa5a31UXOnRKsktzf
	n8xRoeM8awOXEjysSNyW8Ii2wRYT94y/VA+JBwRCqb1ho3lc1GuC2GWhTRfuvxI8UjSDKbRa0wL
	8uNydTUAyT1UUAa4Otx0d2R8MhGdEHseoh72l4sTx
X-Gm-Gg: ASbGncsKLaSuwPjvZIX+W5Zzzckvw2fxnY+JzPF9M/M9CACdW9812F6LvNKkS29mLol
	AQTSh2O1mxyIq9c7gOqf949cEEHAD+VAs49+vT94ONYPij5W3YZnftEQUrMPTTivkvysFFzZhlw
	GVhcmY1pMy9qFrT6fF7uDf5n0WkPL8l0VS5nu9ajR0HaXguUG3iMXWJvi6612m04+t2ZHkbEt9y
	wZgjw45/cQ=
X-Google-Smtp-Source: AGHT+IF0V6IpDA0g/g88zQN1Y5jwthq4vJStWs8fyODDsQaoYNjd5ntqaH61CbzS6DeZH1dw+BJNe+YrREENeD63aH0=
X-Received: by 2002:a17:90b:1d81:b0:313:352f:6620 with SMTP id
 98e67ed59e1d1-313f1be63ebmr17632161a91.4.1750152878984; Tue, 17 Jun 2025
 02:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6850d3bd.a70a0220.395abc.01fa.GAE@google.com>
In-Reply-To: <6850d3bd.a70a0220.395abc.01fa.GAE@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 17 Jun 2025 11:34:27 +0200
X-Gm-Features: AX0GCFtmlTXwGd4wbmbNXD1rdGyEhDesrG7ukmKKzoYmJc174K-z66naXEiAI1k
Message-ID: <CANp29Y68ZaQnb0R2fZSLjcCxiOE3uZyW4b7wLEYMAycF0WHNUg@mail.gmail.com>
Subject: Re: [syzbot] [wireless?] WARNING: net/mac80211/tx.c:LINE at
 __ieee80211_beacon_get, CPU: syz.NUM.NUM/NUM
To: syzbot <syzbot+468656785707b0e995df@syzkaller.appspotmail.com>
Cc: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz dup: WARNING in __ieee80211_beacon_get

On Tue, Jun 17, 2025 at 4:32=E2=80=AFAM syzbot
<syzbot+468656785707b0e995df@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    050f8ad7b58d Add linux-next specific files for 20250616
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D125e190c58000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd2efc7740224b=
93a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D468656785707b0e=
995df
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e0775=
7-1~exp1~20250514183223.118), Debian LLD 20.1.6
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/49faa18d2f53/dis=
k-050f8ad7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7c6f9cd7fe5d/vmlinu=
x-050f8ad7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/84a08d6403ee/b=
zImage-050f8ad7.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+468656785707b0e995df@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: net/mac80211/tx.c:5024 at __ieee80211_beacon_update_cntdwn net/m=
ac80211/tx.c:5024 [inline], CPU#1: syz.4.243/6807
> WARNING: net/mac80211/tx.c:5024 at __ieee80211_beacon_get+0x125d/0x1630 n=
et/mac80211/tx.c:5453, CPU#1: syz.4.243/6807
> Modules linked in:
> CPU: 1 UID: 0 PID: 6807 Comm: syz.4.243 Not tainted 6.16.0-rc2-next-20250=
616-syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 05/07/2025
> RIP: 0010:__ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5024 [inline=
]
> RIP: 0010:__ieee80211_beacon_get+0x125d/0x1630 net/mac80211/tx.c:5453
> Code: e7 e8 27 f2 2f f7 45 31 f6 4c 8b bc 24 a0 00 00 00 e9 78 fe ff ff e=
8 92 bf d6 f6 90 0f 0b 90 e9 e0 f7 ff ff e8 84 bf d6 f6 90 <0f> 0b 90 e9 38=
 fb ff ff e8 76 bf d6 f6 48 c7 c7 a0 5c 79 8f 4c 89
> RSP: 0018:ffffc90000a089f8 EFLAGS: 00010246
> RAX: ffffffff8ae9aaac RBX: ffffffff8ae99886 RCX: ffff888025e8da00
> RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffff888025e8da00 R09: 0000000000000003
> R10: 0000000000000007 R11: 0000000000000100 R12: ffff888058976500
> R13: dffffc0000000000 R14: ffff8880589769d0 R15: ffff888032955024
> FS:  00007fbd84f5b6c0(0000) GS:ffff888125d40000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000555570bf35c8 CR3: 000000002eed6000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  ieee80211_beacon_get_tim+0xb4/0x2b0 net/mac80211/tx.c:5580
>  ieee80211_beacon_get include/net/mac80211.h:5638 [inline]
>  mac80211_hwsim_beacon_tx+0x3ce/0x860 drivers/net/wireless/virtual/mac802=
11_hwsim.c:2319
>  __iterate_interfaces+0x2a8/0x590 net/mac80211/util.c:761
>  ieee80211_iterate_active_interfaces_atomic+0xdb/0x180 net/mac80211/util.=
c:797
>  mac80211_hwsim_beacon+0xbb/0x1c0 drivers/net/wireless/virtual/mac80211_h=
wsim.c:2353
>  __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
>  __hrtimer_run_queues+0x529/0xc60 kernel/time/hrtimer.c:1825
>  hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1842
>  handle_softirqs+0x283/0x870 kernel/softirq.c:579
>  __do_softirq kernel/softirq.c:613 [inline]
>  invoke_softirq kernel/softirq.c:453 [inline]
>  __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inli=
ne]
>  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.=
h:702
> RIP: 0010:finish_wait+0x5/0x1f0 kernel/sched/wait.c:358
> Code: 0f 1e fa 44 89 ef e8 7a 68 f5 ff eb 96 0f 1f 84 00 00 00 00 00 90 9=
0 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 <41> 57 41 56 41=
 55 41 54 53 48 83 ec 10 48 89 f3 49 89 fd 48 bd 00
> RSP: 0018:ffffc9001bccf5f0 EFLAGS: 00000246
> RAX: 7fffffffffffffff RBX: dffffc0000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffc9001bccf640 RDI: ffff888028058700
> RBP: ffffc9001bccf6f0 R08: ffffffff8fa14ff7 R09: 1ffffffff1f429fe
> R10: dffffc0000000000 R11: fffffbfff1f429ff R12: ffff888028058700
> R13: ffffc9001bccf640 R14: 1ffff92003799ec4 R15: 7fffffffffffffff
>  unix_wait_for_peer+0x22f/0x2e0 net/unix/af_unix.c:1587
>  unix_dgram_sendmsg+0xb1f/0x1870 net/unix/af_unix.c:2188
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg+0x219/0x270 net/socket.c:727
>  ____sys_sendmsg+0x52d/0x830 net/socket.c:2566
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
>  __sys_sendmmsg+0x227/0x430 net/socket.c:2709
>  __do_sys_sendmmsg net/socket.c:2736 [inline]
>  __se_sys_sendmmsg net/socket.c:2733 [inline]
>  __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2733
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fbd8418e929
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fbd84f5b038 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
> RAX: ffffffffffffffda RBX: 00007fbd843b5fa0 RCX: 00007fbd8418e929
> RDX: 0400000000000041 RSI: 0000200000000000 RDI: 0000000000000005
> RBP: 00007fbd84210b39 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007fbd843b5fa0 R15: 00007ffe98cac8e8
>  </TASK>
> ----------------
> Code disassembly (best guess):
>    0:   0f 1e fa                nop    %edx
>    3:   44 89 ef                mov    %r13d,%edi
>    6:   e8 7a 68 f5 ff          call   0xfff56885
>    b:   eb 96                   jmp    0xffffffa3
>    d:   0f 1f 84 00 00 00 00    nopl   0x0(%rax,%rax,1)
>   14:   00
>   15:   90                      nop
>   16:   90                      nop
>   17:   90                      nop
>   18:   90                      nop
>   19:   90                      nop
>   1a:   90                      nop
>   1b:   90                      nop
>   1c:   90                      nop
>   1d:   90                      nop
>   1e:   90                      nop
>   1f:   90                      nop
>   20:   90                      nop
>   21:   90                      nop
>   22:   90                      nop
>   23:   90                      nop
>   24:   90                      nop
>   25:   f3 0f 1e fa             endbr64
>   29:   55                      push   %rbp
> * 2a:   41 57                   push   %r15 <-- trapping instruction
>   2c:   41 56                   push   %r14
>   2e:   41 55                   push   %r13
>   30:   41 54                   push   %r12
>   32:   53                      push   %rbx
>   33:   48 83 ec 10             sub    $0x10,%rsp
>   37:   48 89 f3                mov    %rsi,%rbx
>   3a:   49 89 fd                mov    %rdi,%r13
>   3d:   48                      rex.W
>   3e:   bd                      .byte 0xbd
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller=
-bugs/6850d3bd.a70a0220.395abc.01fa.GAE%40google.com.

