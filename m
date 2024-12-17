Return-Path: <netdev+bounces-152664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899879F51AE
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F77B1632CD
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA72D1F76C3;
	Tue, 17 Dec 2024 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="34ICc5MA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187D1F543C
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455226; cv=none; b=efAfXiYoFu+RwR87YuDCRkbJUdBXac4p5hwTEKcnNlV52wKkunWgq2r82coWr9fIv0Xkga0O1wqAq8gT5cIdSmld9dsNUJ4xW1fceTjkvcvQBtLZFTUzeYUB6/i/RfMDI4cKtC4rv8wY9YK3P3pNcRuNnA3Ii/LkWl97HqPFuDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455226; c=relaxed/simple;
	bh=mw2+xVBE/FIBM9SPUUIqfTD9IIYfh0N8o7MeUFKGv2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMRuYAYyhIkDZ6/VnutjjLvab1OI2/ydxdUBQAliDBYz+/OTQIDS6XCrHZVwhTNTegNcnZBPmYt5hDBTzOYO4st7aJtNw+l9YjJ2IlSdbGvmxayzuN9uFil9AqP6wZd4MqfdPd+TpbBozMmm7xYsQfM8zp+aCAgWdc7Lh5KVyBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=34ICc5MA; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d27243ba8bso895413a12.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 09:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734455222; x=1735060022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6wmWb5tPk2zarAIm4H3/RhKf5SFM9az+Rl0pOks7CM=;
        b=34ICc5MAdQxvg2WyrN7juY5RWgkiEcYekc9LC/NG95Z7wpBCeWEfCza621nYaqH+jX
         Q59YoyXDjm8RwLmuUwb2ZB/txZMdMXmLUo2DPh3nPE88KkxYbeinQ+zkA90wKivlcDS0
         iOdEsQdnOiM1T7UloWW20tXPNGHjSLFJsKgDa+WDJ1IX4TX2HJKVDCVs0WCOA5dveHAZ
         txfnZ53X6cXxTAdvDgTbUEimuwcx1p20WGsG+rN4ao3DaSZROB6KKqIyoO5GL4VWja9A
         Oksld8bHb5f164mxzQTRc+MLP0WunRunAlM1WqkWLOnIV/y1KoGH9HvMWZNEpWfbk+i3
         yOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734455222; x=1735060022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6wmWb5tPk2zarAIm4H3/RhKf5SFM9az+Rl0pOks7CM=;
        b=f64BlbNIue79SA0Tz+bFhGXyQfu7omMe1Cv5PELKwZ5YESsm4N8zgiHQL9XJ+8qefM
         o2z/j5p/5hgHTDUhoiAwtODyObjiPJwo3J1UkQ3Z+RDfSwmFsMfh0cet4FPcVJAUoWuJ
         vJ/ddEHwgpvS8yXrnbYOsLqvJNSfXfONPmrykOSvNPwecwvYpN4qJ1fW+6VGkM728kOq
         Sx0YV5Oc2LBn4cJZvKcWoPaU6DJjAYpoDoHrQ0IvKiiJCXjs1vUdgQhYMmsNhsAVfm1M
         tFAPBDb1rexB29zLVHv0NJPx0p11BqD1dmnqcs7iw4cp6pq5gs0I4+bp2kv0n0dl5s09
         lSVg==
X-Forwarded-Encrypted: i=1; AJvYcCUoW7dMMwh+zUPL9ofL1361boIWZTww9PC3mESWc+/Hbc4evQ6cwIO5x+o0RViCg0EFgIDmGUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyffQueHQrS9nGH9wsOpsx9KvcdeC3nnOC+50Ks7y+rhZ/cOnqQ
	WGe3anTbCZDjdO3FsujuTBgm3vXQXRK8CSenQni2Jn3MOjxM0Ls2f0Edkd8s/W2S9Qf50/eV8MZ
	8nNVwLb8TERZjzbA2Cwbdx7Kos/eLdqCK4ahj
X-Gm-Gg: ASbGncsuuzdVl2JkMhMGdep23J2cF9UvQTNrgrKvFW7uPmSbiKxU/kzMqZLDfc+4p3f
	kCJtUdya5ImMVfRtKsb0spWW5URxqtg19PZZnNFYBZfPhPFIMlZDUTA15HEX9KIMUqtphsVRE
X-Google-Smtp-Source: AGHT+IFulS567VQhTJh/MTvDod8HAGRrfyRfruMU8tkJNdxsP9I7ZxLOZ9MaFMQUg6lrhLT0Teloi0xB9QHKcr5U8ls=
X-Received: by 2002:a05:6402:3885:b0:5d3:ff30:b4cc with SMTP id
 4fb4d7f45d1cf-5d63c3c19e2mr16040657a12.33.1734455221598; Tue, 17 Dec 2024
 09:07:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6761aed9.050a0220.29fcd0.006b.GAE@google.com>
In-Reply-To: <6761aed9.050a0220.29fcd0.006b.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Dec 2024 18:06:50 +0100
Message-ID: <CANn89iLL9EgqDz8sjMke9okhJpxtzZkcPvaEQ3s01F89H5RP3A@mail.gmail.com>
Subject: Re: [syzbot] [net?] general protection fault in put_page (4)
To: syzbot <syzbot+38a095a81f30d82884c1@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 6:03=E2=80=AFPM syzbot
<syzbot+38a095a81f30d82884c1@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    78d4f34e2115 Linux 6.13-rc3
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1644573058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6c532525a32eb=
57d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D38a095a81f30d82=
884c1
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D169b0b44580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13f502df98000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7129ee07f8aa/dis=
k-78d4f34e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c23c0af59a16/vmlinu=
x-78d4f34e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/031aecf04ea7/b=
zImage-78d4f34e.xz
>
> The issue was bisected to:
>
> commit b83fbca1b4c9c45628aa55d582c14825b0e71c2b
> Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Date:   Mon Sep 2 10:45:53 2024 +0000
>
>     mptcp: pm: reduce entries iterations on connect
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D163682df98=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D153682df98=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D113682df98000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+38a095a81f30d82884c1@syzkaller.appspotmail.com
> Fixes: b83fbca1b4c9 ("mptcp: pm: reduce entries iterations on connect")
>
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 1 UID: 0 PID: 5836 Comm: sshd Not tainted 6.13.0-rc3-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/25/2024
> RIP: 0010:_compound_head include/linux/page-flags.h:242 [inline]
> RIP: 0010:put_page+0x23/0x260 include/linux/mm.h:1552
> Code: 90 90 90 90 90 90 90 55 41 57 41 56 53 49 89 fe 48 bd 00 00 00 00 0=
0 fc ff df e8 f8 5e 12 f8 49 8d 5e 08 48 89 d8 48 c1 e8 03 <80> 3c 28 00 74=
 08 48 89 df e8 8f c7 78 f8 48 8b 1b 48 89 de 48 83
> RSP: 0000:ffffc90003916c90 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: 0000000000000008 RCX: ffff888030458000
> RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: dffffc0000000000 R08: ffffffff898ca81d R09: 1ffff110054414ac
> R10: dffffc0000000000 R11: ffffed10054414ad R12: 0000000000000007
> R13: ffff88802a20a542 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f34f496e800(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f9d6ec9ec28 CR3: 000000004d260000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  skb_page_unref include/linux/skbuff_ref.h:43 [inline]
>  __skb_frag_unref include/linux/skbuff_ref.h:56 [inline]
>  skb_release_data+0x483/0x8a0 net/core/skbuff.c:1119
>  skb_release_all net/core/skbuff.c:1190 [inline]
>  __kfree_skb+0x55/0x70 net/core/skbuff.c:1204
>  tcp_clean_rtx_queue net/ipv4/tcp_input.c:3436 [inline]
>  tcp_ack+0x2442/0x6bc0 net/ipv4/tcp_input.c:4032
>  tcp_rcv_state_process+0x8eb/0x44e0 net/ipv4/tcp_input.c:6805
>  tcp_v4_do_rcv+0x77d/0xc70 net/ipv4/tcp_ipv4.c:1939
>  tcp_v4_rcv+0x2dc0/0x37f0 net/ipv4/tcp_ipv4.c:2351
>  ip_protocol_deliver_rcu+0x22e/0x440 net/ipv4/ip_input.c:205
>  ip_local_deliver_finish+0x341/0x5f0 net/ipv4/ip_input.c:233
>  NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
>  NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
>  __netif_receive_skb_one_core net/core/dev.c:5672 [inline]
>  __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5785
>  process_backlog+0x662/0x15b0 net/core/dev.c:6117
>  __napi_poll+0xcb/0x490 net/core/dev.c:6883
>  napi_poll net/core/dev.c:6952 [inline]
>  net_rx_action+0x89b/0x1240 net/core/dev.c:7074
>  handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
>  __do_softirq kernel/softirq.c:595 [inline]
>  invoke_softirq kernel/softirq.c:435 [inline]
>  __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inli=
ne]
>  sysvec_apic_timer_interrupt+0x57/0xc0 arch/x86/kernel/apic/apic.c:1049
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.=
h:702
> RIP: 0033:0x7f34f4519ad5
> Code: 85 d2 74 0d 0f 10 02 48 8d 54 24 20 0f 11 44 24 20 64 8b 04 25 18 0=
0 00 00 85 c0 75 27 41 b8 08 00 00 00 b8 0f 01 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 76 75 48 8b 15 24 73 0d 00 f7 d8 64 89 02 48 83
> RSP: 002b:00007ffec5b32ce0 EFLAGS: 00000246
> RAX: 0000000000000001 RBX: 00000000000668a0 RCX: 00007f34f4519ad5
> RDX: 00007ffec5b32d00 RSI: 0000000000000004 RDI: 0000564f4bc6cae0
> RBP: 0000564f4bc6b5a0 R08: 0000000000000008 R09: 0000000000000000
> R10: 00007ffec5b32de8 R11: 0000000000000246 R12: 0000564f48ea8aa4
> R13: 0000000000000001 R14: 0000564f48ea93e8 R15: 00007ffec5b32d68
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:_compound_head include/linux/page-flags.h:242 [inline]
> RIP: 0010:put_page+0x23/0x260 include/linux/mm.h:1552
> Code: 90 90 90 90 90 90 90 55 41 57 41 56 53 49 89 fe 48 bd 00 00 00 00 0=
0 fc ff df e8 f8 5e 12 f8 49 8d 5e 08 48 89 d8 48 c1 e8 03 <80> 3c 28 00 74=
 08 48 89 df e8 8f c7 78 f8 48 8b 1b 48 89 de 48 83
> RSP: 0000:ffffc90003916c90 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: 0000000000000008 RCX: ffff888030458000
> RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: dffffc0000000000 R08: ffffffff898ca81d R09: 1ffff110054414ac
> R10: dffffc0000000000 R11: ffffed10054414ad R12: 0000000000000007
> R13: ffff88802a20a542 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f34f496e800(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f9d6ec9ec28 CR3: 000000004d260000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:   90                      nop
>    1:   90                      nop
>    2:   90                      nop
>    3:   90                      nop
>    4:   90                      nop
>    5:   90                      nop
>    6:   90                      nop
>    7:   55                      push   %rbp
>    8:   41 57                   push   %r15
>    a:   41 56                   push   %r14
>    c:   53                      push   %rbx
>    d:   49 89 fe                mov    %rdi,%r14
>   10:   48 bd 00 00 00 00 00    movabs $0xdffffc0000000000,%rbp
>   17:   fc ff df
>   1a:   e8 f8 5e 12 f8          call   0xf8125f17
>   1f:   49 8d 5e 08             lea    0x8(%r14),%rbx
>   23:   48 89 d8                mov    %rbx,%rax
>   26:   48 c1 e8 03             shr    $0x3,%rax
> * 2a:   80 3c 28 00             cmpb   $0x0,(%rax,%rbp,1) <-- trapping in=
struction
>   2e:   74 08                   je     0x38
>   30:   48 89 df                mov    %rbx,%rdi
>   33:   e8 8f c7 78 f8          call   0xf878c7c7
>   38:   48 8b 1b                mov    (%rbx),%rbx
>   3b:   48 89 de                mov    %rbx,%rsi
>   3e:   48                      rex.W
>   3f:   83                      .byte 0x83
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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

I spent some time on this bug before releasing it, because I have
other syzbot reports probably
caused by the same issue, hinting at shinfo->nr_frags corruption.

I will hold these reports to avoid flooding the mailing list.

