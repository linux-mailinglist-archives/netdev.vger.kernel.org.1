Return-Path: <netdev+bounces-229791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCA4BE0D39
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 23:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02187350660
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2692FDC59;
	Wed, 15 Oct 2025 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="poZwmUOK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A592FE57F
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760564212; cv=none; b=rg2DzDna3+15gsQjqNHBonVJrzDNEKAk+rvK6NjUO7P8QglWA9dunOMQ19OW2J9X3Fbn29ovslYMNOvyZaJIAva8KUhA2Csiop5Ttu/1X+42aHKWKVScCesvLTqQGS0B0HP8maU9LIRVWNmxLZ6XLrbZnXK6gpXM58XD5tySfDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760564212; c=relaxed/simple;
	bh=AnTYK0r3Jre07PAvtYHBFqs+L6ZvaH8xIrtTplAWf5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cewWc7f81bfwVSXWo0+Uohjy+RpmqlgcNlOdQU90aexZ4pYEvdPdsYpMYbavo00X31Lq9tEiUcsg7+2vXjQYIo2vrhGpQld+b1nTqbbSaorCE5W29gew5e+qJG1Q4AQGOnTAvqyj7+l/c625FjIwcSl3qw5MaG+Sz1CeY/6ILoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=poZwmUOK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso105476b3a.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1760564210; x=1761169010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzSvXM+jlguRu/awbYVDNDd3xNqML1B84uavLhBp4Nk=;
        b=poZwmUOKEa/5777WrObkPsQoOaETpXgRP+B0uDd83HVJKxNzhV79FNsrTu1i57KpuU
         e5p2yYNKXjiFeScOIiU7f8JGaEQqp4l88QCgKf/7m83gmQeJGTxUYXvU4FI95fx36qgu
         TKWiqWWF4PDyUX/ErXQgdVn1r/hCInQz6bxYfCsi8AJ7I6YkqSalgEb8dwdoBt/mKMC4
         bptZOABkHvWeE9snIVWOMAE5ZPOsQ9R46UuWBvId3N6bZMBHkEcDnWNn754kHH/cS2J6
         PkbNf0DgH6MZP54Q5hz9e08Gc+9ggK/L/79OlSUIfGfqP8iasmUA2a/AIZXCU80gbFoc
         4abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760564210; x=1761169010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzSvXM+jlguRu/awbYVDNDd3xNqML1B84uavLhBp4Nk=;
        b=DKlUfqXFEfFdkeIUaoV/YIr+0oFdD6N/r5kCdklKYIerHmh4rMRQIB6bN0KytgvkIK
         Kp1K2svxPEM++P9CfiotgxPHxj+1ItwjNn7Lci30ylYpO5d5wD9uTZlUBThkTdjL4eV5
         RqG4byrHk8ZWnXtyuT7/CWkT5xZcAXE+BLlrzXfzd3dFi/53RkGNrwLYr8I2cA/C4nmC
         MkVET3JAe63feYH/485Sq8DJaqXoyGXFEm6DiZYl958+FEMZWz349zTOEtEBQJu4N8ee
         WFwr0cQBHFL0roTnDm5nXbMp6zXlROtBqoNc3FuDLATfJuUQ6PXh+etC2Eb+ScApbrpU
         /mMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgq5tdB+4ioucHC+T44pyf3XZ+IdkBDCG+6OLjtx0Lt6MAebvIitWD6yLj8aWim2CqJWENtlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUoaDYpr2cayk3iRQiJs8W14xgbYvznASZEI8F7zK2VeIVXilI
	7D145Q39bEt4JjBKQRd5an6CxYC0UEEKyWu4s4gjZr0IHGuqPFPeftmBYo+Vin0wUhS2tP66fUe
	hrvxFUOgNCr94lwhIv8YGZmTAQMF2LEfhzmOqyYcy
X-Gm-Gg: ASbGnct7Bl72nvZjIenyM9PSf8Jh7x41QFCax3hjxQB5P23tYgY8+2y1piZQS8aJKCk
	U3lolJ49eKu/IPSgneSZuMrd0CR4nq2qvWFl0+dSjs1eqitlk+SvfyExqZaBojH5je+Q2IUl+Ke
	p6mabpjU/bk/mmFSTBclPEZllYZN95v0wTHUiETIaTP8zJnOtlFQN9JLLFdFvaNoKU13kM1CGDg
	rnMtDqRX6x/kFX5pXt1AcgJ8VQxWGnONzRqo1lbV/MVVTKWDccrr++oLEww2bblzwL2vOo644J0
	1h4SWpBI8kaijw1EQfDlSgI=
X-Google-Smtp-Source: AGHT+IELxj5a7h+o5Luu19pXGQ4VkpPt+FUNnaQnoS6dyUNaqIr/GBMJMif+q0MFMpmlTEAbqOQIKJxaU3dB+8Ubrj0=
X-Received: by 2002:a05:6a20:9392:b0:32b:6f6c:98d4 with SMTP id
 adf61e73a8af0-32da81541eemr40399081637.20.1760564210403; Wed, 15 Oct 2025
 14:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <681a1770.050a0220.a19a9.000d.GAE@google.com> <68ea0a24.050a0220.91a22.01ca.GAE@google.com>
 <CANn89iLjjtXV3ZMxfQDb1bbsVJ6a_Chexu4FwqeejxGTwsR_kg@mail.gmail.com>
 <CAM0EoMnGLqKU7AnsgS00SEgU0eq71f-kiqNniCNyfiyAfNm8og@mail.gmail.com> <87347mmpwp.fsf@intel.com>
In-Reply-To: <87347mmpwp.fsf@intel.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 15 Oct 2025 17:36:39 -0400
X-Gm-Features: AS18NWDq1L4jsWd86ZGlqYi63dTb-i0V7eW3hYlGtsDWjEV25RTc6xg8okqheEA
Message-ID: <CAM0EoMnWcsgtN++zkOW9zf5QqUg9uNBGTNgf=2JARqarW31wwQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] [mm?] INFO: rcu detected stall in
 inet_rtm_newaddr (2)
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	syzbot <syzbot+51cd74c5dfeafd65e488@syzkaller.appspotmail.com>, davem@davemloft.net, 
	dsahern@kernel.org, hdanton@sina.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 5:51=E2=80=AFPM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>
> > On Sat, Oct 11, 2025 at 5:42=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> >>
> >> On Sat, Oct 11, 2025 at 12:41=E2=80=AFAM syzbot
> >> <syzbot+51cd74c5dfeafd65e488@syzkaller.appspotmail.com> wrote:
> >> >
> >> > syzbot has found a reproducer for the following issue on:
> >> >
> >> > HEAD commit:    18a7e218cfcd Merge tag 'net-6.18-rc1' of git://git.k=
ernel...
> >> > git tree:       net-next
> >> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12504dcd=
980000
> >> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D61ab7fa7=
43df0ec1
> >> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D51cd74c5df=
eafd65e488
> >> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f90=
9b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> >> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14d2a5=
42580000
> >> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D142149e2=
580000
> >> >
> >> > Downloadable assets:
> >> > disk image: https://storage.googleapis.com/syzbot-assets/7a01e6dce97=
e/disk-18a7e218.raw.xz
> >> > vmlinux: https://storage.googleapis.com/syzbot-assets/5e1b7e41427f/v=
mlinux-18a7e218.xz
> >> > kernel image: https://storage.googleapis.com/syzbot-assets/69b558601=
209/bzImage-18a7e218.xz
> >> >
> >> > IMPORTANT: if you fix the issue, please add the following tag to the=
 commit:
> >> > Reported-by: syzbot+51cd74c5dfeafd65e488@syzkaller.appspotmail.com
> >> >
> >> > sched: DL replenish lagged too much
> >> > rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> >> > rcu:    0-...!: (2 GPs behind) idle=3D7754/1/0x4000000000000000 soft=
irq=3D15464/15465 fqs=3D1
> >> > rcu:    (detected by 1, t=3D10502 jiffies, g=3D11321, q=3D371 ncpus=
=3D2)
> >> > Sending NMI from CPU 1 to CPUs 0:
> >> > NMI backtrace for cpu 0
> >> > CPU: 0 UID: 0 PID: 5948 Comm: syz-executor Not tainted syzkaller #0 =
PREEMPT(full)
> >> > Hardware name: Google Google Compute Engine/Google Compute Engine, B=
IOS Google 10/02/2025
> >> > RIP: 0010:rb_insert_color_cached include/linux/rbtree.h:113 [inline]
> >> > RIP: 0010:rb_add_cached include/linux/rbtree.h:183 [inline]
> >> > RIP: 0010:timerqueue_add+0x1a8/0x200 lib/timerqueue.c:40
> >> > Code: e7 31 f6 e8 6a 0c de f6 42 80 3c 2b 00 74 08 4c 89 f7 e8 7b 0a=
 de f6 4d 89 26 4d 8d 7e 08 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 <74> 08 4c =
89 ff e8 5e 0a de f6 4d 89 27 4d 85 e4 40 0f 95 c5 eb 07
> >> > RSP: 0018:ffffc90000007cf0 EFLAGS: 00000046
> >> > RAX: 1ffff110170c4f83 RBX: 1ffff110170c4f82 RCX: 0000000000000000
> >> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88805de72358
> >> > RBP: 0000000000000000 R08: ffff88805de72357 R09: 0000000000000000
> >> > R10: ffff88805de72340 R11: ffffed100bbce46b R12: ffff88805de72340
> >> > R13: dffffc0000000000 R14: ffff8880b8627c10 R15: ffff8880b8627c18
> >> > FS:  000055557c657500(0000) GS:ffff888125d0f000(0000) knlGS:00000000=
00000000
> >> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> > CR2: 0000200000000600 CR3: 000000002ee76000 CR4: 00000000003526f0
> >> > Call Trace:
> >> >  <IRQ>
> >> >  __run_hrtimer kernel/time/hrtimer.c:1794 [inline]
> >> >  __hrtimer_run_queues+0x656/0xc60 kernel/time/hrtimer.c:1841
> >> >  hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1903
> >> >  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline=
]
> >> >  __sysvec_apic_timer_interrupt+0x108/0x410 arch/x86/kernel/apic/apic=
.c:1058
> >> >  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 =
[inline]
> >> >  sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1=
052
> >> >  </IRQ>
> >> >  <TASK>
> >> >  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idte=
ntry.h:702
> >> > RIP: 0010:pv_vcpu_is_preempted arch/x86/include/asm/paravirt.h:579 [=
inline]
> >> > RIP: 0010:vcpu_is_preempted arch/x86/include/asm/qspinlock.h:63 [inl=
ine]
> >> > RIP: 0010:owner_on_cpu include/linux/sched.h:2282 [inline]
> >> > RIP: 0010:mutex_spin_on_owner+0x189/0x360 kernel/locking/mutex.c:361
> >> > Code: b6 04 30 84 c0 0f 85 59 01 00 00 48 8b 44 24 08 8b 18 48 8b 44=
 24 48 42 80 3c 30 00 74 0c 48 c7 c7 90 8c fa 8d e8 a7 cd 88 00 <48> 83 3d =
ff 27 5e 0c 00 0f 84 b9 01 00 00 48 89 df e8 41 e0 d5 ff
> >> > RSP: 0018:ffffc900034c7428 EFLAGS: 00000246
> >> > RAX: 1ffffffff1bf5192 RBX: 0000000000000001 RCX: ffffffff819c6588
> >> > RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8f4df8a0
> >> > RBP: 1ffffffff1e9bf14 R08: ffffffff8f4df8a7 R09: 1ffffffff1e9bf14
> >> > R10: dffffc0000000000 R11: fffffbfff1e9bf15 R12: ffffffff8f4df8a0
> >> > R13: ffffffff8f4df8f0 R14: dffffc0000000000 R15: ffff8880267a9e40
> >> >  mutex_optimistic_spin kernel/locking/mutex.c:464 [inline]
> >> >  __mutex_lock_common kernel/locking/mutex.c:602 [inline]
> >> >  __mutex_lock+0x311/0x1350 kernel/locking/mutex.c:760
> >> >  rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
> >> >  inet_rtm_newaddr+0x3b0/0x18b0 net/ipv4/devinet.c:978
> >> >  rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6954
> >> >  netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
> >> >  netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
> >> >  netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
> >> >  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
> >> >  sock_sendmsg_nosec net/socket.c:727 [inline]
> >> >  __sock_sendmsg+0x21c/0x270 net/socket.c:742
> >> >  __sys_sendto+0x3bd/0x520 net/socket.c:2244
> >> >  __do_sys_sendto net/socket.c:2251 [inline]
> >> >  __se_sys_sendto net/socket.c:2247 [inline]
> >> >  __x64_sys_sendto+0xde/0x100 net/socket.c:2247
> >> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >> >  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
> >> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >> > RIP: 0033:0x7faade790d5c
> >> > Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28=
 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 =
f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
> >> > RSP: 002b:00007ffdd2e3b670 EFLAGS: 00000293 ORIG_RAX: 00000000000000=
2c
> >> > RAX: ffffffffffffffda RBX: 00007faadf514620 RCX: 00007faade790d5c
> >> > RDX: 0000000000000028 RSI: 00007faadf514670 RDI: 0000000000000003
> >> > RBP: 0000000000000000 R08: 00007ffdd2e3b6c4 R09: 000000000000000c
> >> > R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
> >> > R13: 0000000000000000 R14: 00007faadf514670 R15: 0000000000000000
> >> >  </TASK>
> >> > rcu: rcu_preempt kthread timer wakeup didn't happen for 10499 jiffie=
s! g11321 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402
> >> > rcu:    Possible timer handling issue on cpu=3D0 timer-softirq=3D428=
6
> >> > rcu: rcu_preempt kthread starved for 10500 jiffies! g11321 f0x0 RCU_=
GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D0
> >> > rcu:    Unless rcu_preempt kthread gets sufficient CPU time, OOM is =
now expected behavior.
> >> > rcu: RCU grace-period kthread stack dump:
> >> > task:rcu_preempt     state:I stack:27224 pid:16    tgid:16    ppid:2=
      task_flags:0x208040 flags:0x00080000
> >> > Call Trace:
> >> >  <TASK>
> >> >  context_switch kernel/sched/core.c:5325 [inline]
> >> >  __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
> >> >  __schedule_loop kernel/sched/core.c:7011 [inline]
> >> >  schedule+0x165/0x360 kernel/sched/core.c:7026
> >> >  schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
> >> >  rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
> >> >  rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
> >> >  kthread+0x711/0x8a0 kernel/kthread.c:463
> >> >  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
> >> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >> >  </TASK>
> >> >
> >> >
> >> > ---
> >> > If you want syzbot to run the reproducer, reply with:
> >> > #syz test: git://repo/address.git branch-or-commit-hash
> >> > If you attach or paste a git patch, syzbot will apply it before test=
ing.
> >>
> >> Yet another taprio report.
> >>
> >> If taprio can not be fixed, perhaps we should remove it from the
> >> kernel, or clearly marked as broken.
> >> (Then ask syzbot to no longer include it)
> >
> > Agreed on the challenge with taprio.
> > We need the stakeholders input: Vinicius - are you still working in
> > this space? Vladimir you also seem to have interest (or maybe nxp
> > does) in this?
>
> No, I am not working on this space anymore.
>
> I will talk with other Intel folks (and my manager) and see what we can
> do.

I assume your customers are still interested in this working? If yes,
that would be a good pitch to the manager.
In my (extreme) view, another selling point is that there is an
ethical obligation to ensure things continue to work as intended.
Getting patches in is the easy part.

cheers,
jamal

>But if others that find it useful can help even better.
>

