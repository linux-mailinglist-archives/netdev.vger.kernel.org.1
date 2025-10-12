Return-Path: <netdev+bounces-228634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9494BD065E
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 17:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9913BCEEC
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 15:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501E12EB854;
	Sun, 12 Oct 2025 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="xjptzmFT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83072D5933
	for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760284023; cv=none; b=uERgSAjuEK8E6Gc4xbdKXW8YqRYZMkwIzn16L6nPoTylEYE9FW94nOeNohJPDiJUWuRt79dvPr9/mTGgqZMhcszlpGQAdYtqO0XgklV41V5NZo6SBUzZNMdr+mAMa8tCgH7ifG3bGlsSgCAYVbs779hf01W7R2mCim1Of5Zb8W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760284023; c=relaxed/simple;
	bh=vUWaG8gjp+90UimZuidE/FOfQW2L1C5infpgnLgV1oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHNSifRgkCOt+Vjlug48iok0vRtIFRHDan5c5QqM+TA8uHn7jBYe1H6f++YPTsAIR3I6itqi09hIQpVczkihpt71q8ieatyQ43tbvBvoqsArgLoHGJ3U0ExdGi4/lbTbHN/DpKzqd3byLmZ40Vsqot4mQWOzo8ErPDgws1QcYSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=xjptzmFT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eceb38eb1so36720035ad.3
        for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 08:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1760284019; x=1760888819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4GxUB3mXIOijnAo4Jh/QDcKjXyJblUTMk9gLfFdbCM=;
        b=xjptzmFTQbK+0m5s0FRZM19eMwzOC9c15/d/IvGWMDZ4A3AtqTawUPTG4xzbyD85TN
         gEOQ0R8aM5ngO++wXvmjDzLnACs9wFgSYRbnlp+0Lm5ihOmLK4rWqAgvzupZ+ZQjoFBU
         h7MW8dDdmduReciH7upzzrvYcs8yUBRfbvEhZidBDr98l8LW472bje5I3BXR6exIJR9H
         5R8rItli0lkwT8z0HWgdXxqQdgNpSY7eTGut6moc5/Hdak7X90A/nS1EQ/T0aWT3xj25
         Lv7NNSLnEh4eQ8cBidxxVCIkWDEC0IMu9sHHRnp3OQ/bxQF+piqFL7sid1MJHZTfdqdu
         9jXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760284019; x=1760888819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4GxUB3mXIOijnAo4Jh/QDcKjXyJblUTMk9gLfFdbCM=;
        b=DAJwnqdClEW5y1NfMb+EY6btNsshFxsnM3Skjm97xp1Kj/YdHgRTdFWXABZOTszCJI
         oYE0ciFZjYpbZoQ4kDBHN2oEFtwzJGDZLKmH30HekfTlVxhN/tBhPAE6zCLxjI7sdeJo
         s6pz+T8k4DE8CIwXDmhwr0xgx73vZi5RTXrFFhAL2ZdebaYwUazQTHOg56PxfMMT07CG
         +GozDPOrLvNWcC38UHNsFYUDIpvSUXdDlg5bSvAh+YqDjlNmuJML3NBGHowFmPTil8SE
         ZuSABioyXItCMls2yDNc65PDlEMuYBWqZsIIsC0v57C55ExL96VvmN+eRX7yNVN7c8wI
         WgFA==
X-Forwarded-Encrypted: i=1; AJvYcCXWa/7xGSfNOl7JK3uybBFkOVXfdgXoO4UiSxNxxvGFppEpHwQawWX/v+psKZM/7uw9DsPmXsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo6IBfllg72Shgh436LMVUopP0bPtxhBX6HNFWv5uv8IJWJnrD
	BUOMx6w3tU2FD/DQcvSlLnZiNUhuUezagVXkj/wPnUdCstdScZT1cpSo7orqXiI9lsKR2l0dSQo
	wpsesNphUp+AkepdilmJiSI2hHMWg6Orjenkvv2b/
X-Gm-Gg: ASbGnct36WgStyKpM/UKwF4Rkr1NenIv6uSRY9bXCyfd9ZNabweRPkOJryFSCTVmDEv
	SfOXBtwZCmKqIvr7YdtnOik31vLxeyn1RZ7bVGZlF6NU7rLiJLDUuizQLemZHpIPV1GH0O+JsTp
	31aWvManIgR8O1nx0UM8XjkyAlkUI/0Xh2fNXIzziSOqC5FJXxvFTtr0LJA194Dx6gp/ztFXdrH
	0Ool+oJwp+RUa/DzZFFt5Vuv4ocyvNQhmjkfF/8qu8WzXcLcQqsXTYhYfm7JI3g2ji2wXv44Zpp
	8w==
X-Google-Smtp-Source: AGHT+IEsvkIHji5FXS3k4mVFSuiV2wODeo+ujiKNFe0QTizQr/lk/JboIRcTN5Hm3VjE5u/54mBRs8ZXlewlr2/MopQ=
X-Received: by 2002:a17:902:f64a:b0:277:9193:f2da with SMTP id
 d9443c01a7336-29027356c8emr245366775ad.5.1760284019230; Sun, 12 Oct 2025
 08:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <681a1770.050a0220.a19a9.000d.GAE@google.com> <68ea0a24.050a0220.91a22.01ca.GAE@google.com>
 <CANn89iLjjtXV3ZMxfQDb1bbsVJ6a_Chexu4FwqeejxGTwsR_kg@mail.gmail.com>
In-Reply-To: <CANn89iLjjtXV3ZMxfQDb1bbsVJ6a_Chexu4FwqeejxGTwsR_kg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 12 Oct 2025 11:46:48 -0400
X-Gm-Features: AS18NWDhOrXzge47KDe52C44MpGP1jFq2C5UW5hu7ElSnyjdHaEd7xaH1FLGrCk
Message-ID: <CAM0EoMnGLqKU7AnsgS00SEgU0eq71f-kiqNniCNyfiyAfNm8og@mail.gmail.com>
Subject: Re: [syzbot] [net?] [mm?] INFO: rcu detected stall in
 inet_rtm_newaddr (2)
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+51cd74c5dfeafd65e488@syzkaller.appspotmail.com>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, davem@davemloft.net, dsahern@kernel.org, 
	hdanton@sina.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 5:42=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sat, Oct 11, 2025 at 12:41=E2=80=AFAM syzbot
> <syzbot+51cd74c5dfeafd65e488@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    18a7e218cfcd Merge tag 'net-6.18-rc1' of git://git.kern=
el...
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12504dcd980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D61ab7fa743d=
f0ec1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D51cd74c5dfeaf=
d65e488
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7=
976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14d2a5425=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D142149e2580=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/7a01e6dce97e/d=
isk-18a7e218.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/5e1b7e41427f/vmli=
nux-18a7e218.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/69b558601209=
/bzImage-18a7e218.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+51cd74c5dfeafd65e488@syzkaller.appspotmail.com
> >
> > sched: DL replenish lagged too much
> > rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > rcu:    0-...!: (2 GPs behind) idle=3D7754/1/0x4000000000000000 softirq=
=3D15464/15465 fqs=3D1
> > rcu:    (detected by 1, t=3D10502 jiffies, g=3D11321, q=3D371 ncpus=3D2=
)
> > Sending NMI from CPU 1 to CPUs 0:
> > NMI backtrace for cpu 0
> > CPU: 0 UID: 0 PID: 5948 Comm: syz-executor Not tainted syzkaller #0 PRE=
EMPT(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 10/02/2025
> > RIP: 0010:rb_insert_color_cached include/linux/rbtree.h:113 [inline]
> > RIP: 0010:rb_add_cached include/linux/rbtree.h:183 [inline]
> > RIP: 0010:timerqueue_add+0x1a8/0x200 lib/timerqueue.c:40
> > Code: e7 31 f6 e8 6a 0c de f6 42 80 3c 2b 00 74 08 4c 89 f7 e8 7b 0a de=
 f6 4d 89 26 4d 8d 7e 08 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 <74> 08 4c 89 =
ff e8 5e 0a de f6 4d 89 27 4d 85 e4 40 0f 95 c5 eb 07
> > RSP: 0018:ffffc90000007cf0 EFLAGS: 00000046
> > RAX: 1ffff110170c4f83 RBX: 1ffff110170c4f82 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88805de72358
> > RBP: 0000000000000000 R08: ffff88805de72357 R09: 0000000000000000
> > R10: ffff88805de72340 R11: ffffed100bbce46b R12: ffff88805de72340
> > R13: dffffc0000000000 R14: ffff8880b8627c10 R15: ffff8880b8627c18
> > FS:  000055557c657500(0000) GS:ffff888125d0f000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000200000000600 CR3: 000000002ee76000 CR4: 00000000003526f0
> > Call Trace:
> >  <IRQ>
> >  __run_hrtimer kernel/time/hrtimer.c:1794 [inline]
> >  __hrtimer_run_queues+0x656/0xc60 kernel/time/hrtimer.c:1841
> >  hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1903
> >  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
> >  __sysvec_apic_timer_interrupt+0x108/0x410 arch/x86/kernel/apic/apic.c:=
1058
> >  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [in=
line]
> >  sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1052
> >  </IRQ>
> >  <TASK>
> >  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentr=
y.h:702
> > RIP: 0010:pv_vcpu_is_preempted arch/x86/include/asm/paravirt.h:579 [inl=
ine]
> > RIP: 0010:vcpu_is_preempted arch/x86/include/asm/qspinlock.h:63 [inline=
]
> > RIP: 0010:owner_on_cpu include/linux/sched.h:2282 [inline]
> > RIP: 0010:mutex_spin_on_owner+0x189/0x360 kernel/locking/mutex.c:361
> > Code: b6 04 30 84 c0 0f 85 59 01 00 00 48 8b 44 24 08 8b 18 48 8b 44 24=
 48 42 80 3c 30 00 74 0c 48 c7 c7 90 8c fa 8d e8 a7 cd 88 00 <48> 83 3d ff =
27 5e 0c 00 0f 84 b9 01 00 00 48 89 df e8 41 e0 d5 ff
> > RSP: 0018:ffffc900034c7428 EFLAGS: 00000246
> > RAX: 1ffffffff1bf5192 RBX: 0000000000000001 RCX: ffffffff819c6588
> > RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8f4df8a0
> > RBP: 1ffffffff1e9bf14 R08: ffffffff8f4df8a7 R09: 1ffffffff1e9bf14
> > R10: dffffc0000000000 R11: fffffbfff1e9bf15 R12: ffffffff8f4df8a0
> > R13: ffffffff8f4df8f0 R14: dffffc0000000000 R15: ffff8880267a9e40
> >  mutex_optimistic_spin kernel/locking/mutex.c:464 [inline]
> >  __mutex_lock_common kernel/locking/mutex.c:602 [inline]
> >  __mutex_lock+0x311/0x1350 kernel/locking/mutex.c:760
> >  rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
> >  inet_rtm_newaddr+0x3b0/0x18b0 net/ipv4/devinet.c:978
> >  rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6954
> >  netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
> >  netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
> >  netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
> >  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
> >  sock_sendmsg_nosec net/socket.c:727 [inline]
> >  __sock_sendmsg+0x21c/0x270 net/socket.c:742
> >  __sys_sendto+0x3bd/0x520 net/socket.c:2244
> >  __do_sys_sendto net/socket.c:2251 [inline]
> >  __se_sys_sendto net/socket.c:2247 [inline]
> >  __x64_sys_sendto+0xde/0x100 net/socket.c:2247
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7faade790d5c
> > Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48=
 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 =
ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
> > RSP: 002b:00007ffdd2e3b670 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
> > RAX: ffffffffffffffda RBX: 00007faadf514620 RCX: 00007faade790d5c
> > RDX: 0000000000000028 RSI: 00007faadf514670 RDI: 0000000000000003
> > RBP: 0000000000000000 R08: 00007ffdd2e3b6c4 R09: 000000000000000c
> > R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
> > R13: 0000000000000000 R14: 00007faadf514670 R15: 0000000000000000
> >  </TASK>
> > rcu: rcu_preempt kthread timer wakeup didn't happen for 10499 jiffies! =
g11321 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402
> > rcu:    Possible timer handling issue on cpu=3D0 timer-softirq=3D4286
> > rcu: rcu_preempt kthread starved for 10500 jiffies! g11321 f0x0 RCU_GP_=
WAIT_FQS(5) ->state=3D0x402 ->cpu=3D0
> > rcu:    Unless rcu_preempt kthread gets sufficient CPU time, OOM is now=
 expected behavior.
> > rcu: RCU grace-period kthread stack dump:
> > task:rcu_preempt     state:I stack:27224 pid:16    tgid:16    ppid:2   =
   task_flags:0x208040 flags:0x00080000
> > Call Trace:
> >  <TASK>
> >  context_switch kernel/sched/core.c:5325 [inline]
> >  __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
> >  __schedule_loop kernel/sched/core.c:7011 [inline]
> >  schedule+0x165/0x360 kernel/sched/core.c:7026
> >  schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
> >  rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
> >  rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
> >  kthread+0x711/0x8a0 kernel/kthread.c:463
> >  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >  </TASK>
> >
> >
> > ---
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
>
> Yet another taprio report.
>
> If taprio can not be fixed, perhaps we should remove it from the
> kernel, or clearly marked as broken.
> (Then ask syzbot to no longer include it)

Agreed on the challenge with taprio.
We need the stakeholders input: Vinicius - are you still working in
this space? Vladimir you also seem to have interest (or maybe nxp
does) in this?
At a minimum, we should mark it as broken unless the stakeholders want
to actively fix these issues.
Would syzbot still look at it if it was marked broken?

cheers,
jamal

