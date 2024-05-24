Return-Path: <netdev+bounces-97932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FDF8CE34A
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 11:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3001C2122F
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 09:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F54284E07;
	Fri, 24 May 2024 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lu/od2me"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620629422
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542687; cv=none; b=LOkigN4GV6NT4x45okuVd6WSQKYa0vY8HFUd6w7D2tMlbMXt+LP3KBUajhpPHM2/lYtKndMQeQmcyzG3GnPTvVeELMtV5ntyTOOjKCHbdOsPUsrAJoDmWnAjPM3qu0bD35IMgCq2VgNc6hmt0B2x+8VtsBEo7BkHC/LsJzHI3ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542687; c=relaxed/simple;
	bh=RHA0z0dfkvAfluwpOn268HbNDfmbyWnG2bMGSeAS360=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkkAhfXVaZhp2ubiu6nWG3atwLfwrJcQKDoWNfeIk7RTeVyNpZJVT+9AX2GuaZbTCM++zyB/jhi7HPc0Kz7LFhWirdiGnOJQmEPCzMNJjgxo0ULQybnPqpjbQTfRGMk/oFuv+ykb4vnk6pIRqpqlO6QcKiAbqQXmWFOGrlKHqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lu/od2me; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-420107286ecso63935e9.0
        for <netdev@vger.kernel.org>; Fri, 24 May 2024 02:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716542684; x=1717147484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcUH2z2PC+NQ15Eh+gwURIN/8l+aK9P+KajNxI/S8X0=;
        b=Lu/od2me3mMOuIetOg+W9pAdRGnl3hV0VYA5jxPDjpb4Eg/zf6c3nCb4weVhc1bzzM
         P1/SOJQlfxbImNPCi+oLlt2/qJTTSqlxtU0NXJhqzG5IJy0pB+v4KtRKrRUULOm6pWX1
         eA7FWw5e0pyC/KH4vQtwTEPq9tGED4GU5nIFlBlpGK/QJj6lLM02DtJGnOXpMbPgHYhm
         V5ZWLgUd/M0TExtNMGzi4fjmLWjSSFqWohIsjI8CN8iPl7yJtiszEcm/r+uAIqlFv4US
         2jQ72u0JXW5zlti8ktk0fX/mf3UlIeqkUKKf58+baZfzCNKptbU8x13ANYn6oWr+Oc0H
         5jJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716542684; x=1717147484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcUH2z2PC+NQ15Eh+gwURIN/8l+aK9P+KajNxI/S8X0=;
        b=kdQYhkRkhp9mL9qoXB0Tzb5FMpTbejdoyGu31klzjiOfHUOR2+8/58+iU0CvYQ0mcv
         s0LktM2xDpgeW660PsTI37mLY3r+Lb/XHv/szKJ9SAFIgn1gIRkqzywp1oMm7tL7euBx
         QJh0sQyuP1HZjVWf8VwjbARq1IUAxAJmABUBdLNZp7UmkB7cYtWyNjrkHYnOphMkvC4A
         iK2dK3kvsD8gKYG7PsR3gDxbkagPtR5YjhUOiXhVBd+XDTtYnRvg0GmwM7lbUaMd+WWP
         bTF3i3KS5oeGAcjLiz+QTmVnNyNaZhqnDML7Q7AI11/3N3nug6hKEGGZcSHbaH4m3SfG
         wF9w==
X-Forwarded-Encrypted: i=1; AJvYcCV/4sUfMmBxFPc69Fu4yBtdVJ3MjcijmGZk2tHk0ldASqYGj5Ve+1AOtb8WDuFX91axQJNRMfNQVsKACxPgk1q6A2FUNgdI
X-Gm-Message-State: AOJu0YzRxC3u8n46OTBpEnOQTSGRxQJ9KCj8zOdBb7hmbhKpnRjmFDK1
	h5E3Az7G+Qsth0v/tLVELrQEEn9XL3/co8oERi4vtdbxUI4RThDtqPDGAn6FQmfUB4tT/BbtCLL
	mBJtXX4uDa++1xZ5iS1P5UCcpkxdW/jA9R6EK
X-Google-Smtp-Source: AGHT+IEb1uqRam6KWo5Pih4A1nbZRrVjux9QuCNJ7mFJACVcqoQO1jJiwdCEgJX7gId+zPG256xHerHbzJGpi4kLHdc=
X-Received: by 2002:a05:600c:5028:b0:41b:e55c:8dca with SMTP id
 5b1f17b1804b1-42108dd0dffmr1055615e9.7.1716542683868; Fri, 24 May 2024
 02:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524085108.1430317-1-yuehaibing@huawei.com>
In-Reply-To: <20240524085108.1430317-1-yuehaibing@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 May 2024 11:24:30 +0200
Message-ID: <CANn89iL5-w3NzupmR4LgskvW2yw1jgnhdFg1HRg+k+JY38G6+w@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Add xmit_recursion level in sch_direct_xmit()
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, hannes@stressinduktion.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 10:49=E2=80=AFAM Yue Haibing <yuehaibing@huawei.com=
> wrote:
>
> packet from PF_PACKET socket ontop of an IPv6-backed ipvlan device will h=
it
> WARN_ON_ONCE() in sk_mc_loop() through sch_direct_xmit() path while ipvla=
n
> device has qdisc queue.
>
> WARNING: CPU: 2 PID: 0 at net/core/sock.c:775 sk_mc_loop+0x2d/0x70
> Modules linked in: sch_netem ipvlan rfkill cirrus drm_shmem_helper sg drm=
_kms_helper
> CPU: 2 PID: 0 Comm: swapper/2 Kdump: loaded Not tainted 6.9.0+ #279
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> RIP: 0010:sk_mc_loop+0x2d/0x70
> Code: fa 0f 1f 44 00 00 65 0f b7 15 f7 96 a3 4f 31 c0 66 85 d2 75 26 48 8=
5 ff 74 1c
> RSP: 0018:ffffa9584015cd78 EFLAGS: 00010212
> RAX: 0000000000000011 RBX: ffff91e585793e00 RCX: 0000000002c6a001
> RDX: 0000000000000000 RSI: 0000000000000040 RDI: ffff91e589c0f000
> RBP: ffff91e5855bd100 R08: 0000000000000000 R09: 3d00545216f43d00
> R10: ffff91e584fdcc50 R11: 00000060dd8616f4 R12: ffff91e58132d000
> R13: ffff91e584fdcc68 R14: ffff91e5869ce800 R15: ffff91e589c0f000
> FS:  0000000000000000(0000) GS:ffff91e898100000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f788f7c44c0 CR3: 0000000008e1a000 CR4: 00000000000006f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  ? __warn+0x83/0x130
>  ? sk_mc_loop+0x2d/0x70
>  ? report_bug+0x18e/0x1a0
>  ? handle_bug+0x3c/0x70
>  ? exc_invalid_op+0x18/0x70
>  ? asm_exc_invalid_op+0x1a/0x20
>  ? sk_mc_loop+0x2d/0x70
>  ip6_finish_output2+0x31e/0x590
>  ? nf_hook_slow+0x43/0xf0
>  ip6_finish_output+0x1f8/0x320
>  ? __pfx_ip6_finish_output+0x10/0x10
>  ipvlan_xmit_mode_l3+0x22a/0x2a0 [ipvlan]
>  ipvlan_start_xmit+0x17/0x50 [ipvlan]
>  dev_hard_start_xmit+0x8c/0x1d0
>  sch_direct_xmit+0xa2/0x390
>  __qdisc_run+0x66/0xd0
>  net_tx_action+0x1ca/0x270
>  handle_softirqs+0xd6/0x2b0
>  __irq_exit_rcu+0x9b/0xc0
>  sysvec_apic_timer_interrupt+0x75/0x90

Please provide full symbols in stack traces.

>  </IRQ>
>
> Fixes: f60e5990d9c1 ("ipv6: protect skb->sk accesses from recursive deref=
erence inside the stack")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/linux/netdevice.h | 17 +++++++++++++++++
>  net/core/dev.h            | 17 -----------------
>  net/sched/sch_generic.c   |  8 +++++---
>  3 files changed, 22 insertions(+), 20 deletions(-)

This patch seems unrelated to the WARN_ON_ONCE(1) met in sk_mc_loop()

If sk_mc_loop() is called with a socket which is not inet, we are in troubl=
e.

Please fix the root cause instead of trying to shortcut sk_mc_loop() as you=
 did.

