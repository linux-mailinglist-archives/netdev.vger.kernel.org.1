Return-Path: <netdev+bounces-68504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8FB8470B7
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F28B21BCA
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132F915B3;
	Fri,  2 Feb 2024 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UhjwZyti"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B003D8F
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878618; cv=none; b=HYhUCkDmq5ffsrPBrXeLa0Bz7YFzEM3bz2of+sIcDRnz/lclmyq27p4fBaviBm8VXhmSnZQdtKWFHBWVtmZ2nKyeWl9/WZL1V35bFojePBPfNEMEQVmw/HBhnhDYcIfOBxj8bsQLSRyxxPNg44Wzx6GWuLhg8jE3wueDkz3teTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878618; c=relaxed/simple;
	bh=1Mx7l4lQ9ghg1e9l0lqyccL/4eIUzUyRwXPGxNutlfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrjSGODcTEa2KG75EfvLVy+KIW+4K8l0dx8FEXeQEnwhB/AEWCvJNn8i8zkGFxYfGkigHhVa6tIDITfD5BB0qCD51PbU67wNqTGVUs5Rq+0xJVAtf2ipbCJt9rwvg9pvKp+dN/tq8QNENiTDu/b7ffFxYdsnkmMVwQA05guQKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=UhjwZyti; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d066b82658so27369401fa.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 04:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706878614; x=1707483414; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EZsLdr6CrXxJurnHuMAHBlhf0vj0Wo/02mtiuBu9wug=;
        b=UhjwZytiJi+ThtOrg58V/nfPW1QjoyT29vuiF8F/mEG8gug6O3DN2gIPxDzaeE+uSF
         dx168Bc2yJobRxo95yWaOedRIuZEDe5MTrIZrStdx8cm2IvlvYQLpYDayYopKuV90kzl
         uJsdcxbR0PeXn1IoYmsazFKG9juX2Z9jhxtmltdGouEzqPhhEuJk7uqCuRL4KgFiXnrg
         ZJmY8rJDC17O46M0z+Vgt3EaPCYwRuMjwgcUjRpUxdnz4K8Tixd52/9U6zY94VVO8gUY
         9j7D0o5pL8bqNCF6x7ikNCm9O1vBcOJZLyCyUnqQi28+/LzR59/0whRkHW0VdNsAeaxt
         EwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706878614; x=1707483414;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZsLdr6CrXxJurnHuMAHBlhf0vj0Wo/02mtiuBu9wug=;
        b=p1vlStZEpV6+8xJyvTLs6rOoOTUZfhjJv8NxCa5pL0D+dymPWSgKFOzAiHM3N7pn0a
         +BLw7C9DyHhmDuZsukN2fx6o+pLqy8nCr2lQExV/tzaP5oSj8qRGcnYegDBxsg7zc7kM
         puYkv5NY0gAkE9VyV0hKZQWqVo2YezSuORXBZie0aPYjdCFLDogryG6xwi82dWabclpo
         /1J9Qgr1tiD+wTzoqtX35uIsWueJfKU+tRGsoQNtjY1FbdJmjjWeswB7xqKeb4pS8Sz8
         HN+34J+4tck9RsViVP5+XDt3CFESBw/2U8Gw2GYrS5Xo2rYxnLVutXrQorVwDr8vLWE/
         uMDQ==
X-Gm-Message-State: AOJu0Yx5iT0EyID9bVypz7hg0sQTH3kaDlXMlVvELPB+Zpa2QGu7pkxu
	KsjYFExLGY8YNYt45LYKeFaw3q97+QEgIxqtvGeiZGIauK27M6QRoYtydY15/U4=
X-Google-Smtp-Source: AGHT+IHRQB3GsU4tJVx3evl5t7loFC6W1thzm6XkwoXkicExR+P4ryXCQjT70+L9fC38hOonASMWNw==
X-Received: by 2002:a2e:8e24:0:b0:2ce:c0f:4b8 with SMTP id r4-20020a2e8e24000000b002ce0c0f04b8mr1173233ljk.42.1706878613954;
        Fri, 02 Feb 2024 04:56:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWPTfNaGjylcrMcMCSdRQLQThoCVXP/6i9nNaMOmL/kif8cwV1NDg3lWE8FKvQftTrfSBlFBywOxog/3GdddefLwdtxviC42vF+FxNjBC+R+y0uQzOaZU8vTDBHud0/K6BIRacHxVCnnpp7wGUCKNhJUeNfUtXmfePb7745OrmFt1gyF9mi+zWvQ/7lR0/IIO+kZ3iWvQfqLjq+I+h+lFx0MW+xIQ88LLeVJhKlPinMOpmCQFT86e450yRMlrMo2rNy
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id kt17-20020a1709079d1100b00a36f42fa79esm869495ejc.16.2024.02.02.04.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:56:53 -0800 (PST)
Date: Fri, 2 Feb 2024 13:56:50 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net] netdevsim: avoid potential loop in
 nsim_dev_trap_report_work()
Message-ID: <ZbzmkmwRWBjF77Fw@nanopsycho>
References: <20240201175324.3752746-1-edumazet@google.com>
 <ZbzaTLeMfo7RdQ1A@nanopsycho>
 <CANn89i+9ibPhpUvoO6y8Kegs3iWFW2aPy+X3QA3Br6ccpgHPzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+9ibPhpUvoO6y8Kegs3iWFW2aPy+X3QA3Br6ccpgHPzw@mail.gmail.com>

Fri, Feb 02, 2024 at 01:39:26PM CET, edumazet@google.com wrote:
>On Fri, Feb 2, 2024 at 1:04 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Feb 01, 2024 at 06:53:24PM CET, edumazet@google.com wrote:
>> >Many syzbot reports include the following trace [1]
>> >
>> >If nsim_dev_trap_report_work() can not grab the mutex,
>> >it should rearm itself at least one jiffie later.
>> >
>> >[1]
>> >Sending NMI from CPU 1 to CPUs 0:
>> >NMI backtrace for cpu 0
>> >CPU: 0 PID: 32383 Comm: kworker/0:2 Not tainted 6.8.0-rc2-syzkaller-00031-g861c0981648f #0
>> >Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
>> >Workqueue: events nsim_dev_trap_report_work
>> > RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:89 [inline]
>> > RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
>> > RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
>> > RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
>> > RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
>> > RIP: 0010:kasan_check_range+0x101/0x190 mm/kasan/generic.c:189
>> >Code: 07 49 39 d1 75 0a 45 3a 11 b8 01 00 00 00 7c 0b 44 89 c2 e8 21 ed ff ff 83 f0 01 5b 5d 41 5c c3 48 85 d2 74 4f 48 01 ea eb 09 <48> 83 c0 01 48 39 d0 74 41 80 38 00 74 f2 eb b6 41 bc 08 00 00 00
>> >RSP: 0018:ffffc90012dcf998 EFLAGS: 00000046
>> >RAX: fffffbfff258af1e RBX: fffffbfff258af1f RCX: ffffffff8168eda3
>> >RDX: fffffbfff258af1f RSI: 0000000000000004 RDI: ffffffff92c578f0
>> >RBP: fffffbfff258af1e R08: 0000000000000000 R09: fffffbfff258af1e
>> >R10: ffffffff92c578f3 R11: ffffffff8acbcbc0 R12: 0000000000000002
>> >R13: ffff88806db38400 R14: 1ffff920025b9f42 R15: ffffffff92c578e8
>> >FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
>> >CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> >CR2: 000000c00994e078 CR3: 000000002c250000 CR4: 00000000003506f0
>> >DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> >DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> >Call Trace:
>> > <NMI>
>> > </NMI>
>> > <TASK>
>> >  instrument_atomic_read include/linux/instrumented.h:68 [inline]
>> >  atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
>> >  queued_spin_is_locked include/asm-generic/qspinlock.h:57 [inline]
>> >  debug_spin_unlock kernel/locking/spinlock_debug.c:101 [inline]
>> >  do_raw_spin_unlock+0x53/0x230 kernel/locking/spinlock_debug.c:141
>> >  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:150 [inline]
>> >  _raw_spin_unlock_irqrestore+0x22/0x70 kernel/locking/spinlock.c:194
>> >  debug_object_activate+0x349/0x540 lib/debugobjects.c:726
>> >  debug_work_activate kernel/workqueue.c:578 [inline]
>> >  insert_work+0x30/0x230 kernel/workqueue.c:1650
>> >  __queue_work+0x62e/0x11d0 kernel/workqueue.c:1802
>> >  __queue_delayed_work+0x1bf/0x270 kernel/workqueue.c:1953
>> >  queue_delayed_work_on+0x106/0x130 kernel/workqueue.c:1989
>> >  queue_delayed_work include/linux/workqueue.h:563 [inline]
>> >  schedule_delayed_work include/linux/workqueue.h:677 [inline]
>> >  nsim_dev_trap_report_work+0x9c0/0xc80 drivers/net/netdevsim/dev.c:842
>> >  process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
>> >  process_scheduled_works kernel/workqueue.c:2706 [inline]
>> >  worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
>> >  kthread+0x2c6/0x3a0 kernel/kthread.c:388
>> >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>> >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>> > </TASK>
>>
>> What is actually the reason for this trace? I see that the RIP is on
>> "start" pointer access in kasan code when instrument_atomic_read()
>> is called on lock->val during spin_unlock checks. But why?
>
>This is a watchdog triggering because there are tasks stuck in D state.
>
> NMI backtrace for cpu 1
>CPU: 1 PID: 29 Comm: khungtaskd Not tainted
>6.8.0-rc2-syzkaller-00031-g861c0981648f #0
>Hardware name: Google Google Compute Engine/Google Compute Engine,
>BIOS Google 11/17/2023
>Call Trace:
><TASK>
>__dump_stack lib/dump_stack.c:88 [inline]
>dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>nmi_cpu_backtrace+0x277/0x390 lib/nmi_backtrace.c:113
>nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
>trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
>check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
>watchdog+0xf87/0x1210 kernel/hung_task.c:379
>kthread+0x2c6/0x3a0 kernel/kthread.c:388
>ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
></TASK>
>Sending NMI from CPU 1 to CPUs 0:

Ah, got it. Thanks!

