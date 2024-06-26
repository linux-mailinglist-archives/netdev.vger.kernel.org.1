Return-Path: <netdev+bounces-106990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24E3918602
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96093282BBF
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4646F18C345;
	Wed, 26 Jun 2024 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PwVvH3rX"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7604318C32C;
	Wed, 26 Jun 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416296; cv=none; b=h14BB+008+TKEkb3xZAVMwpfIlp8WpS8Ci6xXDt1igAf+uWQe3XxxRfJ9momaNAps7zUnyiskZY0tcq946xwxgN7q4zZ+XistqF2GUyBsWY6m+2AOM7x2WeK9qmT97wl9iWwkUh5Y7qgL2lVrzz0WEsMb0JYRglaPLLRLlmiOFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416296; c=relaxed/simple;
	bh=yY7hF00YdnC7rmlszEd8R8EnRWvFQBBBtzonXZEBVyI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=Zbc7T/ri5qDiWEx6SH3QKl1id/vj8cHb63NP+bsssf86JF40gn2f+h3xxNGnGj0f3tG2AnQfKxyymoXGa0YgrcMCRNTJ1YkMEUR0Br8+yVSRB51Y7LDiAlwbCb+cL3E2kxfG00H3u2QYQQpr47C8ce4812TVWO2fABUJsH53IXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PwVvH3rX; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719416284; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=ema/Qtdc7xMoEROyK507XYm1L7SMS56qJb7cuFUr7dk=;
	b=PwVvH3rXRdCo2swVeLGWPWtooOj1bc0tsSSa/h0eG1cQpwrTw5YD72dQpXSlucmhaGTKcgHAbqAdfk09sqw1sm1bnI2q/xeBZ7c5FcU3gJqllos2Jhm482L1CMDnpb/fLfBAZl+pnhafC32I8JL8wBrInxFnW2ax2ZbVYDNXtsc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W9JqbN1_1719416283;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W9JqbN1_1719416283)
          by smtp.aliyun-inc.com;
          Wed, 26 Jun 2024 23:38:03 +0800
Message-ID: <1719416205.6598291-21-hengqi@linux.alibaba.com>
Subject: Re: [syzbot] [net?] general protection fault in coalesce_fill_reply
Date: Wed, 26 Jun 2024 23:36:45 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net,
 kuba@kernel.org,
 linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com,
 syzbot <syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com>
References: <0000000000006293f0061bca5cea@google.com>
 <CANn89i+25=xcbgFCMWUcuDbNJ8TG2mCF_18Lks3ZZGapQ922LQ@mail.gmail.com>
In-Reply-To: <CANn89i+25=xcbgFCMWUcuDbNJ8TG2mCF_18Lks3ZZGapQ922LQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 26 Jun 2024 14:44:20 +0200, Eric Dumazet <edumazet@google.com> wrot=
e:
> On Wed, Jun 26, 2024 at 2:43=E2=80=AFPM syzbot
> <syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    50b70845fc5c Merge branch 'add-ethernet-driver-for-tehu=
ti-..
> > git tree:       net-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1780b3b6980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3De78fc116033=
e0ab7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3De77327e34cdc8=
c36b7d3
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1599901a9=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1429e301980=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/2c4a7dba390c/d=
isk-50b70845.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/62ea7d7c8bc6/vmli=
nux-50b70845.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/573c2ae03545=
/bzImage-50b70845.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com
> >
> > Oops: general protection fault, probably for non-canonical address 0xdf=
fffc0000000193: 0000 [#1] PREEMPT SMP KASAN PTI
> > KASAN: null-ptr-deref in range [0x0000000000000c98-0x0000000000000c9f]
> > CPU: 1 PID: 5093 Comm: syz-executor403 Not tainted 6.10.0-rc4-syzkaller=
-00936-g50b70845fc5c #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 06/07/2024
> > RIP: 0010:coalesce_fill_reply+0xcc/0x1b70 net/ethtool/coalesce.c:214
> > Code: e8 19 2c f9 f7 4c 89 f0 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 f7=
 e8 e3 f1 5e f8 bb 98 0c 00 00 49 03 1e 48 89 d8 48 c1 e8 03 <42> 80 3c 28 =
00 74 08 48 89 df e8 c5 f1 5e f8 48 8b 03 48 89 44 24
> > RSP: 0018:ffffc90003526ee0 EFLAGS: 00010206
> > RAX: 0000000000000193 RBX: 0000000000000c98 RCX: ffff88802661da00
> > RDX: 0000000000000000 RSI: ffff88801b72e740 RDI: ffff88802dac6780
> > RBP: ffffc90003527118 R08: ffffffff899bb137 R09: 1ffff11003e8b805
> > R10: dffffc0000000000 R11: ffffffff899cf860 R12: ffffffff899cf860
> > R13: dffffc0000000000 R14: ffff88801b72e740 R15: ffff88802dac6780
> > FS:  000055557bf45380(0000) GS:ffff8880b9500000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000200f9018 CR3: 0000000066db0000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  ethnl_default_dump_one net/ethtool/netlink.c:467 [inline]
> >  ethnl_default_dumpit+0x5ac/0xb30 net/ethtool/netlink.c:494
> >  genl_dumpit+0x107/0x1a0 net/netlink/genetlink.c:1027
> >  netlink_dump+0x647/0xd80 net/netlink/af_netlink.c:2325
> >  __netlink_dump_start+0x59f/0x780 net/netlink/af_netlink.c:2440
> >  genl_family_rcv_msg_dumpit net/netlink/genetlink.c:1076 [inline]
> >  genl_family_rcv_msg net/netlink/genetlink.c:1192 [inline]
> >  genl_rcv_msg+0x88c/0xec0 net/netlink/genetlink.c:1210
> >  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
> >  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
> >  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
> >  netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
> >  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
> >  sock_sendmsg_nosec net/socket.c:730 [inline]
> >  __sock_sendmsg+0x221/0x270 net/socket.c:745
> >  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
> >  ___sys_sendmsg net/socket.c:2639 [inline]
> >  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f99a46ff219
> > Code: 48 83 c4 28 c3 e8 e7 18 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fff97ad8a78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> > RAX: ffffffffffffffda RBX: 00007fff97ad8c48 RCX: 00007f99a46ff219
> > RDX: 0000000000000000 RSI: 0000000020000e80 RDI: 0000000000000003
> > RBP: 00007f99a4771610 R08: 0000000000000000 R09: 00007fff97ad8c48
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > R13: 00007fff97ad8c38 R14: 0000000000000001 R15: 0000000000000001
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:coalesce_fill_reply+0xcc/0x1b70 net/ethtool/coalesce.c:214
> > Code: e8 19 2c f9 f7 4c 89 f0 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 f7=
 e8 e3 f1 5e f8 bb 98 0c 00 00 49 03 1e 48 89 d8 48 c1 e8 03 <42> 80 3c 28 =
00 74 08 48 89 df e8 c5 f1 5e f8 48 8b 03 48 89 44 24
> > RSP: 0018:ffffc90003526ee0 EFLAGS: 00010206
> > RAX: 0000000000000193 RBX: 0000000000000c98 RCX: ffff88802661da00
> > RDX: 0000000000000000 RSI: ffff88801b72e740 RDI: ffff88802dac6780
> > RBP: ffffc90003527118 R08: ffffffff899bb137 R09: 1ffff11003e8b805
> > R10: dffffc0000000000 R11: ffffffff899cf860 R12: ffffffff899cf860
> > R13: dffffc0000000000 R14: ffff88801b72e740 R15: ffff88802dac6780
> > FS:  000055557bf45380(0000) GS:ffff8880b9400000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000055a18cbf60a8 CR3: 0000000066db0000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > ----------------
> > Code disassembly (best guess):
> >    0:   e8 19 2c f9 f7          call   0xf7f92c1e
> >    5:   4c 89 f0                mov    %r14,%rax
> >    8:   48 c1 e8 03             shr    $0x3,%rax
> >    c:   42 80 3c 28 00          cmpb   $0x0,(%rax,%r13,1)
> >   11:   74 08                   je     0x1b
> >   13:   4c 89 f7                mov    %r14,%rdi
> >   16:   e8 e3 f1 5e f8          call   0xf85ef1fe
> >   1b:   bb 98 0c 00 00          mov    $0xc98,%ebx
> >   20:   49 03 1e                add    (%r14),%rbx
> >   23:   48 89 d8                mov    %rbx,%rax
> >   26:   48 c1 e8 03             shr    $0x3,%rax
> > * 2a:   42 80 3c 28 00          cmpb   $0x0,(%rax,%r13,1) <-- trapping =
instruction
> >   2f:   74 08                   je     0x39
> >   31:   48 89 df                mov    %rbx,%rdi
> >   34:   e8 c5 f1 5e f8          call   0xf85ef1fe
> >   39:   48 8b 03                mov    (%rbx),%rax
> >   3c:   48                      rex.W
> >   3d:   89                      .byte 0x89
> >   3e:   44                      rex.R
> >   3f:   24                      .byte 0x24
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
>=20
> Seems to be caused by
>=20
> commit f750dfe825b904164688adeb147950e0e0c4d262
> Author: Heng Qi <hengqi@linux.alibaba.com>
> Date:   Fri Jun 21 18:13:51 2024 +0800
>=20
>     ethtool: provide customized dim profile management


Hi, Eric

Thanks for your quick check! The fix has been submitted to:

  https://lore.kernel.org/all/20240626153421.102107-1-hengqi@linux.alibaba.=
com/

Thanks a lot!

