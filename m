Return-Path: <netdev+bounces-203855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3C6AF7A1C
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B6F177A76
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 15:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CD92E7649;
	Thu,  3 Jul 2025 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="eWsA89Dg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000B2D6622
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555171; cv=none; b=LTX7vk2qTfMZ6l+Pv/pOaxDyorrU3eNba4vcRZox4G14rzE1Xkv/NSYDizi+dix1W/2waEcRhONSJKjYrYH25u5cGX33ndzL/P4HBczMYJsUfryFps9wnP90ZC0liY/OX7zHqxydEscx4EDhbW/QqbDnjEv2MzolkvuOS2QWjEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555171; c=relaxed/simple;
	bh=DYvCAhzLM8fdwVq7aCiUxFHRsCqPkI8aNLS/wCBGn0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eea8outcke/nH8a37EMF7bbI+b/kPycoJHWhLjtx8uWKJei51SIxxhAXIrNU3AlW5fm4hmpncOP7KNFzDjmbE9s4xeG3SOGMxwFQkHChA0247CpoGfEAkzc4GYs4KcVKtYKClBOa+gdxuRBy6cgunzw9ZGBxn2Kp0s/EaL6Nxy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=eWsA89Dg; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74b52bf417cso81250b3a.0
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 08:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751555168; x=1752159968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zr5/PSMlHaNo3rCbCbRSTlWCczbh6mWql7osZOxjq28=;
        b=eWsA89Dg+kPt9tt7Sju2dkIp0p5CVbhXBvJ4psc1hkL8M3nIp4wvvWRxDuQCoud4uV
         o1JqXXyS1gPnVrZbiGzjQzmjy+gVRn5zMM42zCMFdSMpYAlOPRbnQo4P6gdC3d2AHiyc
         b4ZEnTL2+xOce2HVSESI2X0n7kH6As66FFuWM9nW0WBwTMD7Xk0AJSqW5KgHl6GzBUFg
         hFVX0DdCYI2/f/Y2h4J+SNZ0gr4nKeMY4dYg8sEVeIklkkJ8sW0ZA8wzBn4fwzM0boJe
         /x6opTSQIM2v/cT/zVbkbU3Q0H5TgiME9ERc8BUP4PRqLHUIoWGi4pfL8hF9tVYCt/8d
         Xj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751555168; x=1752159968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zr5/PSMlHaNo3rCbCbRSTlWCczbh6mWql7osZOxjq28=;
        b=uQEhLas5d29KlPf7eWYTBUlEm7TqM/Rph20od0ws8YYX+k/4vQepc5dJUH45Qc06ZK
         yKD4LOZ0TRA7YncioX5j7Tk0AHGnnc7xjeOHRg8wAiUuu05kwIcEisJl1ot5GK3doJ0m
         Dh+UiHQz1OazNld8iCekLhMk36ZrJcEh+fODeUFB02J0dlx66r5oEcOQErEenPxBBDE0
         BjUk/2nffUjaYC6egR4zrkq32t+MPA/Yqi9yrYvvadEmdSx4vuAE077aWChOmbtsvik8
         OFTshZZ2iK6ZjXbMSzFqoTdI5mo+K1o0e48qR8rs1ZLg77mA+xagPdMcOZVcAKZVT9Gx
         gQTg==
X-Forwarded-Encrypted: i=1; AJvYcCX4TAIpzjP56hdbNFIk2q8Uiv/X0QmrXRP839Hr14zo6u+EDoYLaRnMAusdE1MWYD6x57OlQ80=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx1mbQD3h+CnsJ28Fx7B8MgY7B5slnlgn5xleJ12a8fKFWxm9a
	HstT7cIkQZUMuqJ6Hu8n1Zo56i+v1JN9ILdeWle8OSp9U3gMdW8WYZ4BpHPrXFd862sFf+9tHN1
	zG6jwnD+a7WjlTG/xr3Eic++tF+p+o37xh2oEfnU6
X-Gm-Gg: ASbGncsxm/diB4HWx1Y9oZPw/FICWHvUF7jD6nPHSMKk6FHxBSUuDNgBoHzhkBXqk5m
	OjrvldAjKKEODg7BWAAaDDJYcy1tM/tfYqzEGjV/MncieSIwBS6gAsBFYBekUkhG/zWOlHK3EzG
	1WOoOZAjApTli/pkF67+MSN8ArToVF2GwwKc9PCpj23g==
X-Google-Smtp-Source: AGHT+IE7LWxQoj/NE9eb8qrgB6bmZeglyHBFQW8RyGDs4pupg6OxAxtcd4yot8ghXLbwdJjmPIUO2sQUkC+1dLEudyM=
X-Received: by 2002:a05:6a00:a95:b0:73e:1e24:5a4e with SMTP id
 d2e1a72fcca58-74cb6a2684fmr4721831b3a.24.1751555168577; Thu, 03 Jul 2025
 08:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68663c93.a70a0220.5d25f.0857.GAE@google.com> <68666a48.a00a0220.c7b3.0003.GAE@google.com>
In-Reply-To: <68666a48.a00a0220.c7b3.0003.GAE@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 3 Jul 2025 11:05:57 -0400
X-Gm-Features: Ac12FXz0U46QJZd0mMRlLQj1vbF2-eA_JKElS5gSdKa2WfGkzHIdN1l5OlAIswM
Message-ID: <CAM0EoM=JWBb-Ap8Wutic8-7k7_+5rrt-t65h5Bv-iyiJ+JtOCA@mail.gmail.com>
Subject: Lion, can you take a look at his? WAS(Re: [syzbot] [net?] general
 protection fault in htb_qlen_notify
To: syzbot <syzbot+d8b58d7b0ad89a678a16@syzkaller.appspotmail.com>, 
	Lion <nnamrec@gmail.com>
Cc: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 7:32=E2=80=AFAM syzbot
<syzbot+d8b58d7b0ad89a678a16@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    bd475eeaaf3c Merge branch '200GbE' of git://git.kernel.or=
g..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15cc058258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D36b0e72cad529=
8f8
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd8b58d7b0ad89a6=
78a16
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f604=
9-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1113748c580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10909ebc58000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d59bc82a55e0/dis=
k-bd475eea.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2a83759fceb6/vmlinu=
x-bd475eea.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/07576fd8e432/b=
zImage-bd475eea.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+d8b58d7b0ad89a678a16@syzkaller.appspotmail.com
>
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc0000000035: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x00000000000001a8-0x00000000000001af]
> CPU: 1 UID: 0 PID: 6017 Comm: syz.0.16 Not tainted 6.16.0-rc3-syzkaller-0=
0144-gbd475eeaaf3c #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 05/07/2025
> RIP: 0010:htb_deactivate net/sched/sch_htb.c:613 [inline]
> RIP: 0010:htb_qlen_notify+0x31/0xc0 net/sched/sch_htb.c:1489
> Code: 41 56 41 55 41 54 53 49 89 f6 49 89 ff 49 bc 00 00 00 00 00 fc ff d=
f e8 3d c6 46 f8 49 8d 9e a8 01 00 00 49 89 dd 49 c1 ed 03 <43> 0f b6 44 25=
 00 84 c0 75 4d 8b 2b 31 ff 89 ee e8 5a ca 46 f8 85
> RSP: 0018:ffffc900034f6fb0 EFLAGS: 00010206
> RAX: ffffffff89798833 RBX: 00000000000001a8 RCX: ffff88802714bc00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88807a6ac000
> RBP: dffffc0000000000 R08: ffff88802714bc00 R09: 0000000000000002
> R10: 00000000ffffffff R11: ffffffff89798810 R12: dffffc0000000000
> R13: 0000000000000035 R14: 0000000000000000 R15: ffff88807a6ac000
> FS:  00007fa0c3df16c0(0000) GS:ffff888125d50000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa0c3dd0d58 CR3: 00000000743e8000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  qdisc_tree_reduce_backlog+0x29c/0x480 net/sched/sch_api.c:811
>  fq_change+0x1519/0x1f50 net/sched/sch_fq.c:1147
>  fq_init+0x699/0x960 net/sched/sch_fq.c:1201
>  qdisc_create+0x7ac/0xea0 net/sched/sch_api.c:1324
>  __tc_modify_qdisc net/sched/sch_api.c:1749 [inline]
>  tc_modify_qdisc+0x1426/0x2010 net/sched/sch_api.c:1813
>  rtnetlink_rcv_msg+0x779/0xb70 net/core/rtnetlink.c:6953
>  netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2534
>  netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>  netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
>  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg+0x21c/0x270 net/socket.c:727
>  ____sys_sendmsg+0x505/0x830 net/socket.c:2566
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
>  __sys_sendmsg net/socket.c:2652 [inline]
>  __do_sys_sendmsg net/socket.c:2657 [inline]
>  __se_sys_sendmsg net/socket.c:2655 [inline]
>  __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fa0c2f8e929
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fa0c3df1038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fa0c31b5fa0 RCX: 00007fa0c2f8e929
> RDX: 0000000000044080 RSI: 0000200000000040 RDI: 0000000000000006
> RBP: 00007fa0c3010b39 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007fa0c31b5fa0 R15: 00007ffd14aa8178
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:htb_deactivate net/sched/sch_htb.c:613 [inline]
> RIP: 0010:htb_qlen_notify+0x31/0xc0 net/sched/sch_htb.c:1489
> Code: 41 56 41 55 41 54 53 49 89 f6 49 89 ff 49 bc 00 00 00 00 00 fc ff d=
f e8 3d c6 46 f8 49 8d 9e a8 01 00 00 49 89 dd 49 c1 ed 03 <43> 0f b6 44 25=
 00 84 c0 75 4d 8b 2b 31 ff 89 ee e8 5a ca 46 f8 85
> RSP: 0018:ffffc900034f6fb0 EFLAGS: 00010206
> RAX: ffffffff89798833 RBX: 00000000000001a8 RCX: ffff88802714bc00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88807a6ac000
> RBP: dffffc0000000000 R08: ffff88802714bc00 R09: 0000000000000002
> R10: 00000000ffffffff R11: ffffffff89798810 R12: dffffc0000000000
> R13: 0000000000000035 R14: 0000000000000000 R15: ffff88807a6ac000
> FS:  00007fa0c3df16c0(0000) GS:ffff888125d50000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa0c3dd0d58 CR3: 00000000743e8000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:   41 56                   push   %r14
>    2:   41 55                   push   %r13
>    4:   41 54                   push   %r12
>    6:   53                      push   %rbx
>    7:   49 89 f6                mov    %rsi,%r14
>    a:   49 89 ff                mov    %rdi,%r15
>    d:   49 bc 00 00 00 00 00    movabs $0xdffffc0000000000,%r12
>   14:   fc ff df
>   17:   e8 3d c6 46 f8          call   0xf846c659
>   1c:   49 8d 9e a8 01 00 00    lea    0x1a8(%r14),%rbx
>   23:   49 89 dd                mov    %rbx,%r13
>   26:   49 c1 ed 03             shr    $0x3,%r13
> * 2a:   43 0f b6 44 25 00       movzbl 0x0(%r13,%r12,1),%eax <-- trapping=
 instruction
>   30:   84 c0                   test   %al,%al
>   32:   75 4d                   jne    0x81
>   34:   8b 2b                   mov    (%rbx),%ebp
>   36:   31 ff                   xor    %edi,%edi
>   38:   89 ee                   mov    %ebp,%esi
>   3a:   e8 5a ca 46 f8          call   0xf846ca99
>   3f:   85                      .byte 0x85
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

It is triggered by your patch. On the first try, removing your patch
seems to fix it.
It may have nothing to do with your patch i.e your patch may have
opened it up to trigger an existing bug.
You removed that if n=3D0, len=3D0 check which earlier code was using to
terminate the processing.

cheers,
jamal

