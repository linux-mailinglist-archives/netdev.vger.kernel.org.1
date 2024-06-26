Return-Path: <netdev+bounces-106916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 935D7918144
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A0F1F23A26
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AA6181BBF;
	Wed, 26 Jun 2024 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvbvQOQy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76917B4F7
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405878; cv=none; b=GO0DIb2NMf/6cluyr1TZC8tjHX+v9TtH1LuDbCWWb1LNb/j0oU4hgofiRVBTk59C4bDVfckZ1oTlWsa3tAklKDz80+jY79+DHkOqpJREedwo4tZ5+UU1krzgN1L4WTZ6z8FoeWbf2ysr/Ti1fGsDx6OPyedTjufwpvMbLskmp10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405878; c=relaxed/simple;
	bh=HdcjK1lZt0cMvl5swu/P8l9KhkvN8xpRHt3Z9Kg/Xkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rF6fVeHyWAiGBWJCzkp9wcoT69zWeSghHlQzzpd8yCKxxm51BdZr5ZDyA7/xRhqPVDAv0wMvl6vVeA1ZPvf46zU/3GWN2BRnPp1xBb1Zw2AICz5qi0wVhvTUk1VUkpyvm+i06+nHkBGWIKFj6ajDLawHXto5wJ0YAnkrqEkeJeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvbvQOQy; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-37624917c2dso114165ab.0
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 05:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719405876; x=1720010676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOP7YiRR4I9XfZUY9Kbb1cEv3Bz0lKnLk14KHPzKeNw=;
        b=fvbvQOQy04kKUhMF8UMmKehEAgtP1a2J/bqHnQWWJp2KRh263M3lnbw+aaF1lOCAIB
         12kaI1x7E+KkedmVGgo3WRLpSeMjstz8ngGB7vKi0aZ3QIwLOV23XsqqyF4WzMYv05m/
         7VwVLk60s9w5Dmp0fUTZQ3/WkItmWZmdNhIBGMNRXkY0XAHAxSGyRRRVnki+9ZGFwcBO
         /jVgWLq+utmZoylLfiqt49hM9k+wgakXJTo4t8hB6iANIb73wze0e+VausQGi/0PLGhl
         +sQQdwDSpVxDexdJSqGl4NI4MfhtWCRAEPpBrBydaCxay7dAaZqymlDbSoGhtV9RkStw
         U2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719405876; x=1720010676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOP7YiRR4I9XfZUY9Kbb1cEv3Bz0lKnLk14KHPzKeNw=;
        b=k3OqolCK6Kvtxsn2xG6PscYln+Fg44hucZXQKLNhInGpvySAO/rWBsUDC2xvDNCNjo
         28eVlVi0/eJoKwkt8osUyCSPP3m1kCGbcisrwu7wUIM6QlmlLgf2J1wIaE1NkKLDEY1x
         0ReJnmPLRcRrigKhmrRNCd3vzuUQYn1GOFo1X5I7K4ooZsL3KWOeausvCGTkTwfng+AO
         nbZzVhPuTh275uEWFGMHgaA3f6p4y6qzIDltUt49CH+DuUEjvolE1DI9/K8AY4Z4M0cM
         sChKGEgmdb/E/8+BGlSrCN6bJKyyRAXIGMcFNrAM+0DoqG22hiVlQCYk1I9CuVPa+0d/
         Gcdg==
X-Forwarded-Encrypted: i=1; AJvYcCUWluK8Or/TkwHORsZN8VyP9w9PIZWwaCkCgYqX/kevyrPIvH3C9/X1LuuGo9YaVVjsf0IjPYSxqvHLEdJl5Los5YkGpgJd
X-Gm-Message-State: AOJu0YyVW/MF2zr94J99HExmHuTsvMYPFteEEbKqbIH5IBADitZe1fQI
	U+WMgaJ60mo4Qpvo+BEEqkpF5CYn43JXVXZbsxQx7qZbQ8T32RyuPdL04Hfe6if+7rcamwrT3y9
	0u+/YQgAwAFmkSIriE0AXlYZHaP4DkfINHmUW
X-Google-Smtp-Source: AGHT+IFr5ZeWffUSjzqyCMmJ/EZbeNWOTbnHB4n3zMyFmHphog4kGnPbgVBYlR1LmeETe7Cvoqzx8t1frffAP3kXSrA=
X-Received: by 2002:a92:d088:0:b0:375:ee62:5917 with SMTP id
 e9e14a558f8ab-377e600ffc6mr3108635ab.6.1719405875919; Wed, 26 Jun 2024
 05:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000006293f0061bca5cea@google.com>
In-Reply-To: <0000000000006293f0061bca5cea@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Jun 2024 14:44:20 +0200
Message-ID: <CANn89i+25=xcbgFCMWUcuDbNJ8TG2mCF_18Lks3ZZGapQ922LQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] general protection fault in coalesce_fill_reply
To: syzbot <syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com>, 
	Heng Qi <hengqi@linux.alibaba.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 2:43=E2=80=AFPM syzbot
<syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    50b70845fc5c Merge branch 'add-ethernet-driver-for-tehuti=
-..
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1780b3b698000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3De78fc116033e0=
ab7
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De77327e34cdc8c3=
6b7d3
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1599901a980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1429e30198000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2c4a7dba390c/dis=
k-50b70845.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/62ea7d7c8bc6/vmlinu=
x-50b70845.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/573c2ae03545/b=
zImage-50b70845.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com
>
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc0000000193: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000c98-0x0000000000000c9f]
> CPU: 1 PID: 5093 Comm: syz-executor403 Not tainted 6.10.0-rc4-syzkaller-0=
0936-g50b70845fc5c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 06/07/2024
> RIP: 0010:coalesce_fill_reply+0xcc/0x1b70 net/ethtool/coalesce.c:214
> Code: e8 19 2c f9 f7 4c 89 f0 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 f7 e=
8 e3 f1 5e f8 bb 98 0c 00 00 49 03 1e 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00=
 74 08 48 89 df e8 c5 f1 5e f8 48 8b 03 48 89 44 24
> RSP: 0018:ffffc90003526ee0 EFLAGS: 00010206
> RAX: 0000000000000193 RBX: 0000000000000c98 RCX: ffff88802661da00
> RDX: 0000000000000000 RSI: ffff88801b72e740 RDI: ffff88802dac6780
> RBP: ffffc90003527118 R08: ffffffff899bb137 R09: 1ffff11003e8b805
> R10: dffffc0000000000 R11: ffffffff899cf860 R12: ffffffff899cf860
> R13: dffffc0000000000 R14: ffff88801b72e740 R15: ffff88802dac6780
> FS:  000055557bf45380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200f9018 CR3: 0000000066db0000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ethnl_default_dump_one net/ethtool/netlink.c:467 [inline]
>  ethnl_default_dumpit+0x5ac/0xb30 net/ethtool/netlink.c:494
>  genl_dumpit+0x107/0x1a0 net/netlink/genetlink.c:1027
>  netlink_dump+0x647/0xd80 net/netlink/af_netlink.c:2325
>  __netlink_dump_start+0x59f/0x780 net/netlink/af_netlink.c:2440
>  genl_family_rcv_msg_dumpit net/netlink/genetlink.c:1076 [inline]
>  genl_family_rcv_msg net/netlink/genetlink.c:1192 [inline]
>  genl_rcv_msg+0x88c/0xec0 net/netlink/genetlink.c:1210
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
>  ___sys_sendmsg net/socket.c:2639 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f99a46ff219
> Code: 48 83 c4 28 c3 e8 e7 18 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff97ad8a78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fff97ad8c48 RCX: 00007f99a46ff219
> RDX: 0000000000000000 RSI: 0000000020000e80 RDI: 0000000000000003
> RBP: 00007f99a4771610 R08: 0000000000000000 R09: 00007fff97ad8c48
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007fff97ad8c38 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:coalesce_fill_reply+0xcc/0x1b70 net/ethtool/coalesce.c:214
> Code: e8 19 2c f9 f7 4c 89 f0 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 f7 e=
8 e3 f1 5e f8 bb 98 0c 00 00 49 03 1e 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00=
 74 08 48 89 df e8 c5 f1 5e f8 48 8b 03 48 89 44 24
> RSP: 0018:ffffc90003526ee0 EFLAGS: 00010206
> RAX: 0000000000000193 RBX: 0000000000000c98 RCX: ffff88802661da00
> RDX: 0000000000000000 RSI: ffff88801b72e740 RDI: ffff88802dac6780
> RBP: ffffc90003527118 R08: ffffffff899bb137 R09: 1ffff11003e8b805
> R10: dffffc0000000000 R11: ffffffff899cf860 R12: ffffffff899cf860
> R13: dffffc0000000000 R14: ffff88801b72e740 R15: ffff88802dac6780
> FS:  000055557bf45380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055a18cbf60a8 CR3: 0000000066db0000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:   e8 19 2c f9 f7          call   0xf7f92c1e
>    5:   4c 89 f0                mov    %r14,%rax
>    8:   48 c1 e8 03             shr    $0x3,%rax
>    c:   42 80 3c 28 00          cmpb   $0x0,(%rax,%r13,1)
>   11:   74 08                   je     0x1b
>   13:   4c 89 f7                mov    %r14,%rdi
>   16:   e8 e3 f1 5e f8          call   0xf85ef1fe
>   1b:   bb 98 0c 00 00          mov    $0xc98,%ebx
>   20:   49 03 1e                add    (%r14),%rbx
>   23:   48 89 d8                mov    %rbx,%rax
>   26:   48 c1 e8 03             shr    $0x3,%rax
> * 2a:   42 80 3c 28 00          cmpb   $0x0,(%rax,%r13,1) <-- trapping in=
struction
>   2f:   74 08                   je     0x39
>   31:   48 89 df                mov    %rbx,%rdi
>   34:   e8 c5 f1 5e f8          call   0xf85ef1fe
>   39:   48 8b 03                mov    (%rbx),%rax
>   3c:   48                      rex.W
>   3d:   89                      .byte 0x89
>   3e:   44                      rex.R
>   3f:   24                      .byte 0x24
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

Seems to be caused by

commit f750dfe825b904164688adeb147950e0e0c4d262
Author: Heng Qi <hengqi@linux.alibaba.com>
Date:   Fri Jun 21 18:13:51 2024 +0800

    ethtool: provide customized dim profile management

