Return-Path: <netdev+bounces-68473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E61846FBF
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FAF1C23EB8
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4970B13D4F7;
	Fri,  2 Feb 2024 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SJFuCpw+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FE622067
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875477; cv=none; b=NVeP4JmaDWBVgRMgNTTGa4VJOGjv49A9oiiswXuyBwcFr7/7r8SVL/288Ozy+qcU8xsGcbMPZxWqNNAioW5RF9EGOinDj4Te4EDHVapMKwVSTr7UwB0t27B4J4mEqPX5zJTtdGs/KD0COePTYf+miodJ6LggmTXFYcO1BbjUMWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875477; c=relaxed/simple;
	bh=8fiiJ9Sw5knn0jM9hTmBiWtgDjNlBkkG6B2GRAFShdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rj74MmQdHwZ605WaGZJ5hQRPlgLmDIgUnhNsGkd7jn8p+GEkhtw+M+E3xpAEb2usRGaJP7GOJL+dJ7g+Q4QIASOGt7C0Qj2ICga+hUX6SGllJU4OumDc/3kEK49S2uCNu7mcPv/35AHn2E73fZnuZSJP6V5I6QXoSNOOtCX7UcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=SJFuCpw+; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33b1d7f736bso442594f8f.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 04:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706875472; x=1707480272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9SYDIZYkVX9zsy6Yi69xthrwdbFNulk7QMM+MGkA/FM=;
        b=SJFuCpw+kdRNri7ErGgj9fQYolkjhfI3J0/hIBCCxirpI1s8WMbfE8/9LFbvN4kuW1
         gtm7a9S7Vz411wdAemI8LnVqrPBbiBbxJ8AakdB6N4CwFwrpnbw5GJ15/6vc4HBqAaqN
         nDWBYj5pQPbfOl9TTGqqWQNKbKKxDPShVbqyxgQ2xs4j1UOatawH6DthOHqA6VZ0QVPG
         WbbusqS9TCiTOQBrqqr1fuPfKXntlbazfWggcEGkul1unCE1F0g4ggSesqD7ZmONPe/1
         IkaO+j9pOshw78b/BaOjRHibXF/+OX5CxLzug3D+Lzs7YRi51SgnDvb44GAQe4jYvjEH
         6ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706875472; x=1707480272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SYDIZYkVX9zsy6Yi69xthrwdbFNulk7QMM+MGkA/FM=;
        b=O0kBbX5Km1N7zQzKPgcXQ2HTAZMDMQ8h7ZJnSkbsIJhiurZas7wYL+YAmw6a1JcRf0
         +zl3gNpIDiWaCEvdoFTZX3aE+SYcqJgvK4PaiYm1BEq415rsH+XSjw6P+Kdx6juztbFc
         kiirmMIyv2/5tsLIlGFDXK7aCJaalVxX3rab7XKM3BZNgHdY/XTFqc5cMYMZCfQGxeSK
         3aK1qoJUV/EH4keAfoOzrYydpYAYu9uyn28ghih1KoDm6obFB/GkdwFFhmcMIkBvjija
         jkujuRhhxDHu+ZOYzWXwWDxhYaVXiu3/FxcOr+KK3eZtKspm5KjHjpkg/xnFHk030gFz
         059A==
X-Gm-Message-State: AOJu0YyRd6U2UU9DEfSg8YtRviR4CZ4OIJzTLJE1r66cECz6XUsjkpmR
	MafUxjYGTy1oJEZkujMsa8UYSxj35mAjyS/AIuOCyY4dx4eN9gHjRYrEKrqB36o=
X-Google-Smtp-Source: AGHT+IEAdH+1r8a2IPXN0Y19n+o5SeOSP51nI0j1ke0x/I36zoORiG1NCBoKjp1jGCJyjLr019ojBg==
X-Received: by 2002:adf:e604:0:b0:33b:687:7e12 with SMTP id p4-20020adfe604000000b0033b06877e12mr3741707wrm.57.1706875472008;
        Fri, 02 Feb 2024 04:04:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWJLSWukldTCS4U0yUt37QEgK0gqpCf115pnUms87dwkjNyQqNbtG1UqQaCGsdWB/redK0BOB3di6ct1sgZTCFvCLaqRgNbCkMa4B1eD3TiUpXhn6Q2w2kYANhVOkDsRW/g8pZEqxcl8ftD2QUQq2XRfMuFC8t8Mq0LdcfWZ+anzA+GVT4Hj85Qc26SPJmb1zZbckVP6sFPOiu4VjwvmvoQtH+8v6NhB6o0mX5oTyJxZUT6PGTfvN6ZrAllDek3Wjd9
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id b11-20020a5d45cb000000b0033afd49cac7sm1795725wrs.43.2024.02.02.04.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:04:31 -0800 (PST)
Date: Fri, 2 Feb 2024 13:04:28 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net] netdevsim: avoid potential loop in
 nsim_dev_trap_report_work()
Message-ID: <ZbzaTLeMfo7RdQ1A@nanopsycho>
References: <20240201175324.3752746-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201175324.3752746-1-edumazet@google.com>

Thu, Feb 01, 2024 at 06:53:24PM CET, edumazet@google.com wrote:
>Many syzbot reports include the following trace [1]
>
>If nsim_dev_trap_report_work() can not grab the mutex,
>it should rearm itself at least one jiffie later.
>
>[1]
>Sending NMI from CPU 1 to CPUs 0:
>NMI backtrace for cpu 0
>CPU: 0 PID: 32383 Comm: kworker/0:2 Not tainted 6.8.0-rc2-syzkaller-00031-g861c0981648f #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
>Workqueue: events nsim_dev_trap_report_work
> RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:89 [inline]
> RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
> RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
> RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
> RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
> RIP: 0010:kasan_check_range+0x101/0x190 mm/kasan/generic.c:189
>Code: 07 49 39 d1 75 0a 45 3a 11 b8 01 00 00 00 7c 0b 44 89 c2 e8 21 ed ff ff 83 f0 01 5b 5d 41 5c c3 48 85 d2 74 4f 48 01 ea eb 09 <48> 83 c0 01 48 39 d0 74 41 80 38 00 74 f2 eb b6 41 bc 08 00 00 00
>RSP: 0018:ffffc90012dcf998 EFLAGS: 00000046
>RAX: fffffbfff258af1e RBX: fffffbfff258af1f RCX: ffffffff8168eda3
>RDX: fffffbfff258af1f RSI: 0000000000000004 RDI: ffffffff92c578f0
>RBP: fffffbfff258af1e R08: 0000000000000000 R09: fffffbfff258af1e
>R10: ffffffff92c578f3 R11: ffffffff8acbcbc0 R12: 0000000000000002
>R13: ffff88806db38400 R14: 1ffff920025b9f42 R15: ffffffff92c578e8
>FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 000000c00994e078 CR3: 000000002c250000 CR4: 00000000003506f0
>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>Call Trace:
> <NMI>
> </NMI>
> <TASK>
>  instrument_atomic_read include/linux/instrumented.h:68 [inline]
>  atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
>  queued_spin_is_locked include/asm-generic/qspinlock.h:57 [inline]
>  debug_spin_unlock kernel/locking/spinlock_debug.c:101 [inline]
>  do_raw_spin_unlock+0x53/0x230 kernel/locking/spinlock_debug.c:141
>  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:150 [inline]
>  _raw_spin_unlock_irqrestore+0x22/0x70 kernel/locking/spinlock.c:194
>  debug_object_activate+0x349/0x540 lib/debugobjects.c:726
>  debug_work_activate kernel/workqueue.c:578 [inline]
>  insert_work+0x30/0x230 kernel/workqueue.c:1650
>  __queue_work+0x62e/0x11d0 kernel/workqueue.c:1802
>  __queue_delayed_work+0x1bf/0x270 kernel/workqueue.c:1953
>  queue_delayed_work_on+0x106/0x130 kernel/workqueue.c:1989
>  queue_delayed_work include/linux/workqueue.h:563 [inline]
>  schedule_delayed_work include/linux/workqueue.h:677 [inline]
>  nsim_dev_trap_report_work+0x9c0/0xc80 drivers/net/netdevsim/dev.c:842
>  process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
>  process_scheduled_works kernel/workqueue.c:2706 [inline]
>  worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
>  kthread+0x2c6/0x3a0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> </TASK>

What is actually the reason for this trace? I see that the RIP is on
"start" pointer access in kasan code when instrument_atomic_read()
is called on lock->val during spin_unlock checks. But why?

