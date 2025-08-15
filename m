Return-Path: <netdev+bounces-214018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D574B27BA4
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 10:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06186188D52D
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 08:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD302550A4;
	Fri, 15 Aug 2025 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="VcQOEHbu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002CD23A9AE
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247534; cv=none; b=X3dn/OWfm9ltnyNX+REU2ELeuAYhN48UzRJD1uwlxsj73i+Or2nCGGIhawEaqo3EKQ0q3sFJDlIFL4GL6j123rz4PrLHDQJ9TL0uZz0ko8Z4sYHor36DBcdrdQh2btPbEX46KI1zZZDNCQ2+EdTlDf1QgbaJQet09DellzH0fWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247534; c=relaxed/simple;
	bh=6A2Dq0amHqC9N/hfufJ+u5OIDXQr1Cru95oYvYCsqWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdbYrFqydjYWhG7FAvY1Acwfcpy0+Kj0DcmUXKxTBgr5JxFQJp1mTlei7fZzuKPF+MPIUujpDtdRoKGO0oWALyEqKpxsHXntA8Kg9mKNSeqo39EOMAR6Mnqg9cWP4VLibIVEr1dz6wBmDzfHNd8WJPgy0xRdJjpU+V0i+vMdQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=VcQOEHbu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-244580536efso12891475ad.1
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 01:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1755247532; x=1755852332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Co4cFF+FKkR54CtGgOYFxRvGwd8LqfcB4BNywSWQw/4=;
        b=VcQOEHbuW5MeUiBfz8IIZbY7IyWu4wOkEIwn54ySxxBIjzF9g0vraJmaYl5AdAeznY
         udnYJppMIz4rFftAx0BLszc+f13dYCpDHer8fTXn1xn/YEHUxgPB8uGhMoTsPEPs4Hzq
         0zpsYhRn0jvDLsIDgYU4ou30CNnLsO90TciDDTULVdjh0o3qYwactpcy4XuHpDVeupeV
         RNcT2w6gxY+qZxAGOuNbGJMpVXpCH0SQEPOum6O/uQp9JfKIJuzTN2OjBNHFzFdWkPCA
         pCqGKo2VC5fkBLPr05XQok7Q8Hp8eq93p8i0Dv28iDU7GXlytTA8V6Na+TkNInNCtHpA
         eJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755247532; x=1755852332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Co4cFF+FKkR54CtGgOYFxRvGwd8LqfcB4BNywSWQw/4=;
        b=Y5xFiG2MRSCVDCl7eo/U94JevlAHJkFR0cl9wzgmz4I9pzW0r4P7FdF1xmOrZVQr5U
         mGZ1D+E9XxNOeRKZywYq85sB1zQNj3tVI3r5fuNFsVIfH2l3DfhYayp0nqXFsupwYvm9
         YTpDaqRNwwnpBFRU0wUSUDclPrrz2MduvXiWoih9csTQcRF389OBXAy4BQL8Zor+E4Yk
         had4rz+eRV7igTPhVlPE1ADSGUrS9AGY5rYIHgXxhtlJ/9a7Pvb7tMxyCK320XsMyyB4
         3dljHFK1m687bTL7qrat1ixavJXPPNuAu3f+IYjbre+HtS2EVKbAceBYBPkMgIOKBKIC
         Fw2g==
X-Forwarded-Encrypted: i=1; AJvYcCUAPXTHCgDERnoIWmsbAXTvyqJdT5yljgTVXWRfM4OAP1ytRC6oX9MopQAnIgde0h9AwUrvl2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YznQU/mZQYWF61A9edZ2oIzWVzZjp1ILeJQA2lp5VJhNsRGJbF6
	Bhl8FczQeFu2i05b9o84XFy7822FbkdzMUmPh9XrDClIZ44i8LPeiCUccrxppmQjerW1tBOTX3v
	GYpkSFi1848kvrGYEFShrGzdRZUjX9tCf9PbVHEEJ
X-Gm-Gg: ASbGncu4beB1WP4Xg3H34B1k+nba435DFE+zM5Uk2mx2f5Kc5x3hKyYrTRs9zEG9EOV
	D0Rc981hbWy3AZvbX8Nn2Dd+aaL4UPNHxZzkBPnBRELOTLtI9p2wWlE+1lTbnVZ8h4fCNuD9Jza
	eVOnl1rSSz/kL1xP6YH7wrCNKrjjFzx8x06+9+ar2n/v3oz3jc/61yNKG1maRBwwqbQSwTnKD9s
	P0iZhbO8+kE0/r16g==
X-Google-Smtp-Source: AGHT+IEDd8LPtnC0aomuJDrr/vQ901c9sDGH8px9y2LJbdfA0ZR8UlOSmvzBB+QpayfTHNuzrAFUZNkIev9eGhAWc5w=
X-Received: by 2002:a17:903:1249:b0:240:2eae:aecb with SMTP id
 d9443c01a7336-2446d8ef28cmr17168905ad.43.1755247532257; Fri, 15 Aug 2025
 01:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813174617.257553-1-victor@mojatatu.com>
In-Reply-To: <20250813174617.257553-1-victor@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 15 Aug 2025 04:45:20 -0400
X-Gm-Features: Ac12FXwAaJtCTNeAoCX0XMJyy2Gt8tsZ6o21OMcrWLcB5MMxPbh8hfsP5QkxTfs
Message-ID: <CAM0EoMmry8eGK6f7J8LCot==gftE4PUTQZ8gMD2ZwV8HqOC-qA@mail.gmail.com>
Subject: Re: [RFC PATCH net] net/sched: sch_dualpi2: Run prob update timer in
 softirq to avoid deadlock
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, 
	chia-yu.chang@nokia-bell-labs.com, koen.de_schepper@nokia-bell-labs.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:46=E2=80=AFPM Victor Nogueira <victor@mojatatu.co=
m> wrote:
>
> When a user creates a dualpi2 qdisc it automatically sets a timer. This
> timer will run constantly and update the qdisc's probability field.
> The issue is that the timer acquires the qdisc root lock and runs in
> hardirq. The qdisc root lock is also acquired in dev.c whenever a packet
> arrives for this qdisc. Since the dualpi2 timer callback runs in hardirq,
> it may interrupt the packet processing running in softirq. If that happen=
s
> and it runs on the same CPU, it will acquire the same lock and cause a
> deadlock. The following splat shows up when running a kernel compiled wit=
h
> lock debugging:
>
> [  +0.000224] WARNING: inconsistent lock state
> [  +0.000224] 6.16.0+ #10 Not tainted
> [  +0.000169] --------------------------------
> [  +0.000029] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> [  +0.000000] ping/156 [HC0[0]:SC0[2]:HE1:SE0] takes:
> [  +0.000000] ffff897841242110 (&sch->root_lock_key){?.-.}-{3:3}, at: __d=
ev_queue_xmit+0x86d/0x1140
> [  +0.000000] {IN-HARDIRQ-W} state was registered at:
> [  +0.000000]   lock_acquire.part.0+0xb6/0x220
> [  +0.000000]   _raw_spin_lock+0x31/0x80
> [  +0.000000]   dualpi2_timer+0x6f/0x270
> [  +0.000000]   __hrtimer_run_queues+0x1c5/0x360
> [  +0.000000]   hrtimer_interrupt+0x115/0x260
> [  +0.000000]   __sysvec_apic_timer_interrupt+0x6d/0x1a0
> [  +0.000000]   sysvec_apic_timer_interrupt+0x6e/0x80
> [  +0.000000]   asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  +0.000000]   pv_native_safe_halt+0xf/0x20
> [  +0.000000]   default_idle+0x9/0x10
> [  +0.000000]   default_idle_call+0x7e/0x1e0
> [  +0.000000]   do_idle+0x1e8/0x250
> [  +0.000000]   cpu_startup_entry+0x29/0x30
> [  +0.000000]   rest_init+0x151/0x160
> [  +0.000000]   start_kernel+0x6f3/0x700
> [  +0.000000]   x86_64_start_reservations+0x24/0x30
> [  +0.000000]   x86_64_start_kernel+0xc8/0xd0
> [  +0.000000]   common_startup_64+0x13e/0x148
> [  +0.000000] irq event stamp: 6884
> [  +0.000000] hardirqs last  enabled at (6883): [<ffffffffa75700b3>] neig=
h_resolve_output+0x223/0x270
> [  +0.000000] hardirqs last disabled at (6882): [<ffffffffa7570078>] neig=
h_resolve_output+0x1e8/0x270
> [  +0.000000] softirqs last  enabled at (6880): [<ffffffffa757006b>] neig=
h_resolve_output+0x1db/0x270
> [  +0.000000] softirqs last disabled at (6884): [<ffffffffa755b533>] __de=
v_queue_xmit+0x73/0x1140
> [  +0.000000]
>               other info that might help us debug this:
> [  +0.000000]  Possible unsafe locking scenario:
>
> [  +0.000000]        CPU0
> [  +0.000000]        ----
> [  +0.000000]   lock(&sch->root_lock_key);
> [  +0.000000]   <Interrupt>
> [  +0.000000]     lock(&sch->root_lock_key);
> [  +0.000000]
>                *** DEADLOCK ***
>
> [  +0.000000] 4 locks held by ping/156:
> [  +0.000000]  #0: ffff897842332e08 (sk_lock-AF_INET){+.+.}-{0:0}, at: ra=
w_sendmsg+0x41e/0xf40
> [  +0.000000]  #1: ffffffffa816f880 (rcu_read_lock){....}-{1:3}, at: ip_o=
utput+0x2c/0x190
> [  +0.000000]  #2: ffffffffa816f880 (rcu_read_lock){....}-{1:3}, at: ip_f=
inish_output2+0xad/0x950
> [  +0.000000]  #3: ffffffffa816f840 (rcu_read_lock_bh){....}-{1:3}, at: _=
_dev_queue_xmit+0x73/0x1140
>
> I am able to reproduce it consistently when running the following:
>
> tc qdisc add dev lo handle 1: root dualpi2
> ping -f 127.0.0.1
>
> To fix it, make the timer run in softirq.
>
> Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdi=
sc")
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
>  net/sched/sch_dualpi2.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> index 845375ebd4ea..4b975feb52b1 100644
> --- a/net/sched/sch_dualpi2.c
> +++ b/net/sched/sch_dualpi2.c
> @@ -927,7 +927,8 @@ static int dualpi2_init(struct Qdisc *sch, struct nla=
ttr *opt,
>
>         q->sch =3D sch;
>         dualpi2_reset_default(sch);
> -       hrtimer_setup(&q->pi2_timer, dualpi2_timer, CLOCK_MONOTONIC, HRTI=
MER_MODE_ABS_PINNED);
> +       hrtimer_setup(&q->pi2_timer, dualpi2_timer, CLOCK_MONOTONIC,
> +                     HRTIMER_MODE_ABS_PINNED_SOFT);
>
>         if (opt && nla_len(opt)) {
>                 err =3D dualpi2_change(sch, opt, extack);
> @@ -937,7 +938,7 @@ static int dualpi2_init(struct Qdisc *sch, struct nla=
ttr *opt,
>         }
>
>         hrtimer_start(&q->pi2_timer, next_pi2_timeout(q),
> -                     HRTIMER_MODE_ABS_PINNED);
> +                     HRTIMER_MODE_ABS_PINNED_SOFT);
>         return 0;
>  }
>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> --
> 2.34.1
>

