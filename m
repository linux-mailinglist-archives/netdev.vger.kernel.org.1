Return-Path: <netdev+bounces-68496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A70847079
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB7B1C21F10
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D3E15A5;
	Fri,  2 Feb 2024 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lf3I3qiL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E170417D2
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877583; cv=none; b=meT+dPSE8Vj8LrZQY+qcsPlnd0S5xOoQAM6iRNeXZ5Er7+A9XkFQIP//Yngt/Tddtf6UwQdB0LJWnFWKnbQwoc76sX+1qe+IglxNEWhlPQAiI5FJZxB0baIa4x6gtWav/vGHfQuuALbMtnIoFIN1hAp5XKFI4R7M0axynAri2r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877583; c=relaxed/simple;
	bh=i5jqPOYanic22PXR35J3EuIHVG6BHWXkBHc473VQK7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vbeqc1UPWRVqlvLJDki3scWlQ7m3umLEf3l1Kw3lnqLx5gqQqw+VtoHsOqgjragO9UM7n4dsFPu8bu9EAcSXslzhD8Lo12zdTVrx183QYr7HLQfGpePra0EodBNLpv4Tssqcz3oOdFsdzNQ/eWb8O4zDZrr6X6gV3qUgrjKFe5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lf3I3qiL; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55fff7a874fso4025a12.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 04:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706877580; x=1707482380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJpo3otJr1kXqukJ3a6IJI199SleP5mo2jGr+qOrGcA=;
        b=lf3I3qiLuYxMjEEegRL6aJ2tHR2T8AgqVkUaIshuzSlzX9rXxPLNMMUq3V1uN6a8Bm
         OcJmrmyWqdIY/SkquNzMhtQae5XzBdbB1zWiykAetOgtBbOUWwmxXWWhmxk0/+V8/Ypp
         e94nYGWgGsHyWDogdXBJ03TBhnzPzTeM4yXfnRkTIxBgpi6r3BhzUMSxhMqRkeuq5kWZ
         IYTlZbsPpYaCsmVNOFzX4+0H5djNAkgZTLSgi6YQMmqtDHFck5rTte5CjSQ6v0xCajWk
         0gxXg/kaX238C9jRId8c1AsJhwD0Teyvad3yLbmMdlM/OY2vNA5Uq3DVepHEPDnNBb5f
         VhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706877580; x=1707482380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJpo3otJr1kXqukJ3a6IJI199SleP5mo2jGr+qOrGcA=;
        b=whzUr8X+c2VcydrAtzAJ9v7EvgpTvnhRpUUgLyu1ir9iFxDWp9nDm/v8CCG0b36+fm
         RvhzhC0YmbC5xJdFMiiTsXBwdonxGt6D43RU14L9xtR4z+AA17G+ZLcoAY+fapdutt19
         JJpKsRj2Bf4e/Pr+4lwPiH93e97SF+S+I9q0KgehsSmLNxf2QkvH2kOLmMU7fnJh7Sos
         sNiLUCtoTSc3kGNESWYtTAFPQepJQA9I9qfTkxWbqk3OagyD/IWRjfgxwpeeqopI95Ro
         aV6dlzKYPFueGSLib0F6difEIcDbiQp0ZdrNqC3H2ayZy8u7hL+Oc4/4P6CbBZ/1ML+6
         s73Q==
X-Gm-Message-State: AOJu0Yx7zNc8WhHN6GggNYRcVCP2cLBjHUjmtlbI/em4H3n+ntZdtIQh
	a5H6rYsJcRxrMpDppDoYm9IxHc/w80f0R5LuRjaU/FLMLDGX6R2eOkly2FiEaHPRR8agFl2tlRy
	KZ3ind4WeJs9IeCHeNydp3hw7ZIyqAJKY+anm
X-Google-Smtp-Source: AGHT+IEzl0cv1Pmy0zrbZJeBMPw2r0CykveuiaVGFwA1lP4aAa/gJ4TUxQf3ApioKw7CknLMfnFA46vajt8qTj6+bwY=
X-Received: by 2002:a50:bac1:0:b0:55f:98d7:877c with SMTP id
 x59-20020a50bac1000000b0055f98d7877cmr116914ede.5.1706877579772; Fri, 02 Feb
 2024 04:39:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201175324.3752746-1-edumazet@google.com> <ZbzaTLeMfo7RdQ1A@nanopsycho>
In-Reply-To: <ZbzaTLeMfo7RdQ1A@nanopsycho>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 2 Feb 2024 13:39:26 +0100
Message-ID: <CANn89i+9ibPhpUvoO6y8Kegs3iWFW2aPy+X3QA3Br6ccpgHPzw@mail.gmail.com>
Subject: Re: [PATCH net] netdevsim: avoid potential loop in nsim_dev_trap_report_work()
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 1:04=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Thu, Feb 01, 2024 at 06:53:24PM CET, edumazet@google.com wrote:
> >Many syzbot reports include the following trace [1]
> >
> >If nsim_dev_trap_report_work() can not grab the mutex,
> >it should rearm itself at least one jiffie later.
> >
> >[1]
> >Sending NMI from CPU 1 to CPUs 0:
> >NMI backtrace for cpu 0
> >CPU: 0 PID: 32383 Comm: kworker/0:2 Not tainted 6.8.0-rc2-syzkaller-0003=
1-g861c0981648f #0
> >Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 11/17/2023
> >Workqueue: events nsim_dev_trap_report_work
> > RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:89 [inline]
> > RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
> > RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
> > RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
> > RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
> > RIP: 0010:kasan_check_range+0x101/0x190 mm/kasan/generic.c:189
> >Code: 07 49 39 d1 75 0a 45 3a 11 b8 01 00 00 00 7c 0b 44 89 c2 e8 21 ed =
ff ff 83 f0 01 5b 5d 41 5c c3 48 85 d2 74 4f 48 01 ea eb 09 <48> 83 c0 01 4=
8 39 d0 74 41 80 38 00 74 f2 eb b6 41 bc 08 00 00 00
> >RSP: 0018:ffffc90012dcf998 EFLAGS: 00000046
> >RAX: fffffbfff258af1e RBX: fffffbfff258af1f RCX: ffffffff8168eda3
> >RDX: fffffbfff258af1f RSI: 0000000000000004 RDI: ffffffff92c578f0
> >RBP: fffffbfff258af1e R08: 0000000000000000 R09: fffffbfff258af1e
> >R10: ffffffff92c578f3 R11: ffffffff8acbcbc0 R12: 0000000000000002
> >R13: ffff88806db38400 R14: 1ffff920025b9f42 R15: ffffffff92c578e8
> >FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:000000000000=
0000
> >CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >CR2: 000000c00994e078 CR3: 000000002c250000 CR4: 00000000003506f0
> >DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >Call Trace:
> > <NMI>
> > </NMI>
> > <TASK>
> >  instrument_atomic_read include/linux/instrumented.h:68 [inline]
> >  atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
> >  queued_spin_is_locked include/asm-generic/qspinlock.h:57 [inline]
> >  debug_spin_unlock kernel/locking/spinlock_debug.c:101 [inline]
> >  do_raw_spin_unlock+0x53/0x230 kernel/locking/spinlock_debug.c:141
> >  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:150 [inl=
ine]
> >  _raw_spin_unlock_irqrestore+0x22/0x70 kernel/locking/spinlock.c:194
> >  debug_object_activate+0x349/0x540 lib/debugobjects.c:726
> >  debug_work_activate kernel/workqueue.c:578 [inline]
> >  insert_work+0x30/0x230 kernel/workqueue.c:1650
> >  __queue_work+0x62e/0x11d0 kernel/workqueue.c:1802
> >  __queue_delayed_work+0x1bf/0x270 kernel/workqueue.c:1953
> >  queue_delayed_work_on+0x106/0x130 kernel/workqueue.c:1989
> >  queue_delayed_work include/linux/workqueue.h:563 [inline]
> >  schedule_delayed_work include/linux/workqueue.h:677 [inline]
> >  nsim_dev_trap_report_work+0x9c0/0xc80 drivers/net/netdevsim/dev.c:842
> >  process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
> >  process_scheduled_works kernel/workqueue.c:2706 [inline]
> >  worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
> >  kthread+0x2c6/0x3a0 kernel/kthread.c:388
> >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> > </TASK>
>
> What is actually the reason for this trace? I see that the RIP is on
> "start" pointer access in kasan code when instrument_atomic_read()
> is called on lock->val during spin_unlock checks. But why?

This is a watchdog triggering because there are tasks stuck in D state.

 NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted
6.8.0-rc2-syzkaller-00031-g861c0981648f #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 11/17/2023
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
nmi_cpu_backtrace+0x277/0x390 lib/nmi_backtrace.c:113
nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
watchdog+0xf87/0x1210 kernel/hung_task.c:379
kthread+0x2c6/0x3a0 kernel/kthread.c:388
ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
</TASK>
Sending NMI from CPU 1 to CPUs 0:

