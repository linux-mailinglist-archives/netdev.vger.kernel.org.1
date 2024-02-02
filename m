Return-Path: <netdev+bounces-68366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF669846B8C
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 10:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A8E28748E
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A69C74281;
	Fri,  2 Feb 2024 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="N2wdGssy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB36BB54
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864914; cv=none; b=VDIU5cAPcu8BjD47GRkFHPbXrPpDmB6vd2+DrPX7GAsb0ppKVdvhwKT3zKCsfmK12C5Ym9rb9kdRNEhWe7S3lmzGaj9WpJ58DxjLK5iQnq/qMjLwSSnbdBhxYahrsJY919b44NGh+wIRXHUhQZhds/YIKJUguQdioSQWhqd4p8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864914; c=relaxed/simple;
	bh=P1mbZXHz86dOdn7DDx5IBlzoZd7NDT/LfSbcmtM3SI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAMxsSdBlDSOBvn1TgaJE+hOQfiANSvqRB5zGb0S0vD5JMQoYCiwQEQ6udH/6lMNoBqTDNsOH11ZeK/FgCZMLVTdyg1pCsFpnC9iIQ0UdC/1CUEerxsl3cfMj+fvcZwfcEWr2E1AuOFXrRexA5RD4cQbt4QlgApBQilQdX/KRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=N2wdGssy; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51124d86022so2983434e87.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 01:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706864909; x=1707469709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XztkFEFPiUNRx3WU8KrhE3Lpt8XViqdpHUA9jgF0DSc=;
        b=N2wdGssyaRJ9l4hFwbldj56wkcxRvvhel+1Y5qpZUCMcvvtoXGd0WbeYvOTNa9Xy4u
         bkw1pi8yn3Jbv8WwdEfRa+jtZgTRxfIXnj1pkebSVC7nJfWI6wTRGAFbDNMFQJvh8+Gz
         g4fbvdgrOqEL1d/hbJxxCBdwXu7UHzHh7KModZJ2l66T/CeXeNux4XEkBqGNhfFKKESt
         yQgKQkVBMcXpHC/Gw4wx+A+WUAacCP0caqG4eK4KnJAxGWNn01Q62VBWq0EKHNbELVfG
         Mfr3R+1PnvCvrFLxjWzCfgwWiMzYx0mmSgLJYC6hQIYd67QoZb2iOlfB60Wy6+H8qgyq
         kUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706864909; x=1707469709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XztkFEFPiUNRx3WU8KrhE3Lpt8XViqdpHUA9jgF0DSc=;
        b=DICk6ISYW1LU3iXGB0lwaMSFG4YFIYf2h4eRHcjMuVvROvffZd3f/ZltnroTmB0g/I
         Q6fp1Y69w6L7Yi4hS8OouOotvGkLAxM3ub20GrOBq+2NbCts8734qb+LK20q5DuabH68
         x7lUZbOkxAAwu9FfRhD5X09UJouvuExjO8kHWmybMZS9p3wmlGQNeDwk9ZieQBAjuINp
         akq8FguQkqLMrSPxLzy8RUA3n3OCkCS/7dnV7NB6djaMIX5E9bZ9siIiH0iKZRxM1ZRk
         VpG3PTy/HblW/cYyMUa1dZKCYB1Rq/5TrvpRWrcawRbAMmws1JstHCHTFCeaCiqfnYpA
         s49A==
X-Gm-Message-State: AOJu0YxNsYI6l8kYQJemmMEosoRM6nE/5R6ja4A9PewHRjvMu4KSM+SA
	tB/+g8HExFf1B4l14jK3K2CsxfzvPmlp/R/rBb+rDx0rG2c2C/0fHeBYjoDZ+eY=
X-Google-Smtp-Source: AGHT+IGGha7Fzv8aiad2e3R2Ibr5/4lGluatetPfTY1CEniMmN3J69QFSQSlP/N2lGRCUD45zITrdw==
X-Received: by 2002:ac2:563c:0:b0:511:36e8:6c25 with SMTP id b28-20020ac2563c000000b0051136e86c25mr580604lff.51.1706864908614;
        Fri, 02 Feb 2024 01:08:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXIeJHL/ObVDdv2JIKdGFcoWQueiCpBJ9rhAxuqp+5AtLRX0l3F/+AVQRsy83uHxZU2/2LbpU5TRSoRU0XTZapaYZCXE0/om2Y4TRA3xwFamO2tJT8MpAB+vXP688LHQBuZDy19prl9OhBg7PSGT4rHZWffdPYlEBzj65zqArxJ8ERwfUuG0ZGL865l/b2lmwRCko8RDWNvPTKTQ5k73XJeojs/6JZKiXuG3od17xiScEtxmWvEAUaHr9k0jR9BLiY/
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c468900b0040fb6295018sm1998537wmo.12.2024.02.02.01.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 01:08:28 -0800 (PST)
Date: Fri, 2 Feb 2024 10:08:25 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net] netdevsim: avoid potential loop in
 nsim_dev_trap_report_work()
Message-ID: <ZbyxCcRTfkvgGgjw@nanopsycho>
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
>
>Fixes: 012ec02ae441 ("netdevsim: convert driver to use unlocked devlink API during init/fini")
>Reported-by: syzbot <syzkaller@googlegroups.com>
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Cc: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks!

