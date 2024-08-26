Return-Path: <netdev+bounces-121871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 082D595F14E
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 14:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8938B1F219A0
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DA916F0EB;
	Mon, 26 Aug 2024 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCbZtSP1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FE616C84B
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675227; cv=none; b=eioBHiiYhaODov8GZsDN1z9UNK+snwGrT/3iDxpZMsO9ySggpvot2nHO3znm1QXsDiitECz3Zg0yRJl7w9CtzdYOkObXpsQ2zcFtiuevZQlC4t/IV8DXITbp+b/1EYXJENvkJdqr8NxbCjPv1x48pShVy0VaOaR4uaAMStR4lwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675227; c=relaxed/simple;
	bh=/VxZ0D1FPJfkOYoIxDwjndqZIMscY+brj0jHZFj+d6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5a4LZV5xYHbiGEvKuM+6oO9azEnp1r4mYkHRs7a1SkD17cH85j5277uYBw2JGtcf6QBuFcEPkZHfQQiHEaZBAROc7pHnOZKy0EIq6jGM35bycm0Jv3x6AXlfC7RSSktUabQFq0OiwHb5poCkWQZW/REd8V1YUqEeo33iYq6MPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aCbZtSP1; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-533488ffaddso5294419e87.1
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 05:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724675223; x=1725280023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7jLUQd7S3UA64hOBIvHzrhgt1WS+FDJRMo6FfDm/BQ=;
        b=aCbZtSP1HzMmgDO6r5Th0Psf67YgcB/eHUeKMWFqvwx/HnwZenoaoste2IRDJBHnk9
         xFE3m/OgzEya1juPvW+cgO1d/yx3cjSP20nFtql0Xmb03A7frI7hVin9rVEmsFYLmk8Q
         Dwj1OCyagGUtQNI7GmItHf7+RoOR8+bhptDRtIMw4Z75Up0Uer+C/HnjQbGvk9eWPw0d
         yms7hP1YeWMbCAQaMKEm1Atyl5BVxNwfdB+RyD3tSfRBqyo/gePEeDRNUIA0CoXa9yXJ
         Mu6nyB2eiSteYIfwZLZOmGGBnZH9/KzH1Ecxe8ARdcDHfeZv3hhnlS6PIo7EVIrW8i0S
         9ZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724675223; x=1725280023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7jLUQd7S3UA64hOBIvHzrhgt1WS+FDJRMo6FfDm/BQ=;
        b=GHSLZi7crGzVmRAW+vE+vC4Zl/cFpGxC+SODcbsj2F3gtDOh2c9Nm4pjhG3ZEaGLQe
         sguWSVAOihfhhZmMTPU/aTqyoayzkPpGKFTVMcQit6D5vo69L+uy12AnCaCUOCMOuuue
         82eKnB+VNjK90vKTCOQEQeYL/RwYjTTISpxf7QiH/uMN6g0ZAJZFX2r1BV58DkOq0Avu
         Of8SbABSfbv0kiyFpGcGsXLPGNzGXbjZlIdyC2TK4WMgVGiZxPkgwzgptLL0Fztt3swC
         xEsoOJkMDplb5+KASGh2ihgAx2DFAjwRoBevw45ewEzyGBriluI9JhCcIP6Ql4gJu4iO
         mRxg==
X-Forwarded-Encrypted: i=1; AJvYcCUqE27HCgRcB9oG1KWyUYOFsFBMJUFzXTv4C0oOk/nxwexkOIfQLMLoIz9mP3rrQa6+rz33Wt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmD62raIR4qfIyWOg98Wuj4FerYgMylaS5HTTVvhxgPjQfFB0v
	7OPpDEBofMRB1RIKfpFjBNmTDw86Lp4vscwPVxHKOO+MOH69tMzgs/GTBGp7QRqN/rIGeEC/Do7
	kgdftAJeIua+vq0IS8b3hhoSfAYCx2YlML/PS
X-Google-Smtp-Source: AGHT+IGWOml7RXIrX8EzqOSXJ5KODBA2jEQjYyF6qK4TXOS/8XqVCA5OwbPu3k6fjSC7RvFnzxdT41smKdJ6h0yPwm0=
X-Received: by 2002:a05:6512:33c8:b0:533:4638:d490 with SMTP id
 2adb3069b0e04-534387bbf16mr7115192e87.38.1724675221993; Mon, 26 Aug 2024
 05:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-4F7g=Fqy0KL0t0SaZburRiENsnzm_CYbb8SzbAk1+8oA@mail.gmail.com>
 <87plpwe6kx.ffs@tglx>
In-Reply-To: <87plpwe6kx.ffs@tglx>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Aug 2024 14:26:50 +0200
Message-ID: <CANn89i+oPYb8y7tka82SB7MOYf9wvCG6e3sLvs=4+X=4j5-ydg@mail.gmail.com>
Subject: Re: BUG: general protection fault in hrtimer_try_to_cancel
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Xingyu Li <xli399@ucr.edu>, anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 9:38=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Sat, Aug 24 2024 at 21:50, Xingyu Li wrote:
>
> Cc=3D: network folks.
>
> > We found a bug in Linux 6.10. It is probably a null pointer dereference=
 bug.
> > The reason is probably that in line 1615 of kernel/time/hrtimer.c,
> > before "seq =3D raw_read_seqcount_begin(&base->seq);", there is no null
> > pointer check for 'base'.
>
> So something in the network code invokes hrtimer_cancel() in a teardown
> operation on a non-initialized hrtimer and hrtimers contrary to the timer
> wheel does not check for initialization. That's trivial to fix, see
> below.
>
> But that does not explain the actual root cause. That NULL pointer
> dereference is just the messenger.
>
> This is gro_cells related:
>
> >  hrtimer_cancel+0x12/0x50 kernel/time/hrtimer.c:1447
> >  napi_disable+0x1b6/0x210 net/core/dev.c:6648
> >  gro_cells_destroy+0x12a/0x3d0 net/core/gro_cells.c:116
>
> gro_cells_init() invokes netif_napi_add() for each per cpu
> cell. netif_napi_add() invokes hrtimer_init().
>
> So how can gro_cells_destroy() have a non-initialized hrtimer?
>
> I defer that question to the network people
>
> Thanks,
>
>         tglx
>
> > The bug report is as follows, but unfortunately there is no generated
> > syzkaller reproducer.
> >
> > bridge0: port 2(bridge_slave_1) entered disabled state
> > bridge_slave_0: left allmulticast mode
> > bridge_slave_0: left promiscuous mode
> > bridge0: port 1(bridge_slave_0) entered disabled state
> > Oops: general protection fault, probably for non-canonical address
> > 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN PTI
> > KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> > CPU: 0 PID: 29 Comm: kworker/u4:2 Not tainted 6.10.0 #13
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > Workqueue: netns cleanup_net
> > RIP: 0010:__seqprop_raw_spinlock_sequence include/linux/seqlock.h:226 [=
inline]
> > RIP: 0010:hrtimer_active kernel/time/hrtimer.c:1615 [inline]
> > RIP: 0010:hrtimer_try_to_cancel+0x7c/0x410 kernel/time/hrtimer.c:1332
> > Code: 2f 12 00 48 8b 5c 24 10 48 8b 44 24 08 42 80 3c 30 00 74 08 48
> > 89 df e8 02 3b 75 00 4c 8b 3b 4d 8d 67 10 4c 89 e3 48 c1 eb 03 <42> 8a
> > 04 33 84 c0 0f 85 f4 00 00 00 41 8b 2c 24 89 ee 83 e6 01 31
> > RSP: 0018:ffffc9000080f7a0 EFLAGS: 00010202
> > RAX: 1ffffd1ffff88a14 RBX: 0000000000000002 RCX: 1ffffd1ffff88a15
> > RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffe8ffffc45070
> > RBP: ffffe8ffffc45070 R08: ffffc9000080f867 R09: 1ffff92000101f0c
> > R10: dffffc0000000000 R11: fffff52000101f0d R12: 0000000000000010
> > R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
> > FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f09772124b0 CR3: 000000001f978000 CR4: 0000000000350ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  hrtimer_cancel+0x12/0x50 kernel/time/hrtimer.c:1447
> >  napi_disable+0x1b6/0x210 net/core/dev.c:6648
> >  gro_cells_destroy+0x12a/0x3d0 net/core/gro_cells.c:116

This looks like something that should not happen, unless something
mangled memory.

I had another syzbot report hinting at some per-cpu var corruption of
some sort :

bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
Oops: general protection fault, probably for non-canonical address
0xf01ffbfd1fdfa34d: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0x80ffffe8fefd1a68-0x80ffffe8fefd=
1a6f]
CPU: 1 UID: 0 PID: 64 Comm: kworker/u32:3 Not tainted
6.11.0-rc1-syzkaller-00046-gc91a7dee0555 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:__skb_unlink include/linux/skbuff.h:2418 [inline]
RIP: 0010:__skb_dequeue include/linux/skbuff.h:2434 [inline]
RIP: 0010:__skb_queue_purge_reason include/linux/skbuff.h:3288 [inline]
RIP: 0010:__skb_queue_purge include/linux/skbuff.h:3294 [inline]
RIP: 0010:gro_cells_destroy net/core/gro_cells.c:118 [inline]
RIP: 0010:gro_cells_destroy+0x1a9/0x4d0 net/core/gro_cells.c:106
Code: e8 03 80 3c 28 00 0f 85 71 02 00 00 48 8d 7a 08 49 8b 47 08 49
c7 07 00 00 00 00 48 89 f9 49 c7 47 08 00 00 00 00 48 c1 e9 03 <80> 3c
29 00 0f 85 2b 02 00 00 48 89 c1 48 89 42 08 48 c1 e9 03 80
RSP: 0018:ffffc90000d17a50 EFLAGS: 00010a06
RAX: ffffffe8fefd1a60 RBX: ffffe8fefd1a6060 RCX: 101ffffd1fdfa34d
RDX: 80ffffe8fefd1a60 RSI: ffffffff89043b68 RDI: 80ffffe8fefd1a68
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000008
R10: 0000000000000008 R11: 0000000000000000 R12: fffff91fdfa34c0e
R13: 0000000000000001 R14: ffffe8fefd1a6070 R15: ffffe8fefd1a6061
FS: 0000000000000000(0000) GS:ffff88806b100000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbf176e2650 CR3: 000000003fb9c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
ip6gre_dev_free+0x19/0x30 net/ipv6/ip6_gre.c:1444
netdev_run_todo+0x760/0x12d0 net/core/dev.c:10753
cleanup_net+0x591/0xbf0 net/core/net_namespace.c:636
process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
process_scheduled_works kernel/workqueue.c:3312 [inline]
worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
kthread+0x2c1/0x3a0 kernel/kthread.c:389
ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
</TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__skb_unlink include/linux/skbuff.h:2418 [inline]
RIP: 0010:__skb_dequeue include/linux/skbuff.h:2434 [inline]
RIP: 0010:__skb_queue_purge_reason include/linux/skbuff.h:3288 [inline]
RIP: 0010:__skb_queue_purge include/linux/skbuff.h:3294 [inline]
RIP: 0010:gro_cells_destroy net/core/gro_cells.c:118 [inline]
RIP: 0010:gro_cells_destroy+0x1a9/0x4d0 net/core/gro_cells.c:106
Code: e8 03 80 3c 28 00 0f 85 71 02 00 00 48 8d 7a 08 49 8b 47 08 49
c7 07 00 00 00 00 48 89 f9 49 c7 47 08 00 00 00 00 48 c1 e9 03 <80> 3c
29 00 0f 85 2b 02 00 00 48 89 c1 48 89 42 08 48 c1 e9 03 80

