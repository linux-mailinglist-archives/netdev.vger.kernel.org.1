Return-Path: <netdev+bounces-162649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1287CA277A9
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4F43A1384
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15DE215779;
	Tue,  4 Feb 2025 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKfbQMDm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2634166F32
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688224; cv=none; b=mXoGocKo+6ylM/xPgXM6zBEbo/P3AMMbVZ+1zc6caX2B9AptDsf6OFL6Lh6HFX3G3CPdOkIsKOajZAJfN1DjIcuU2lKKWcqfjEC/GFJz301bTnmQ5oWB3eX0IaTRxdBzj70K3+E+rMIy5ChKubYgDouXhBXwdWDjKztd3dvzZO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688224; c=relaxed/simple;
	bh=A4D/RB0TYsOirGxTCD1pKsdR4sWLoDUDfgOak3jyYCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIw30cXOCnks4JbRdNcFdOgWXcnkdDxzbMhuFGBQROFMxe1AepxTi5nTjk10gtIrCHLEU9zjrxYGTNe5ysadA1waCTSSzN1XY6KPi0gGYJyoFEvpOR13c6uZ7WZ8653dIoug1H591fzH9eTl5oFBR9eVXep5FVgTKaMtIz2B0sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JKfbQMDm; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dccc90a52eso1248824a12.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 08:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738688221; x=1739293021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4V+8+gsz9nYVXr4B1OGpZ57RFL7WyZcu08m1tGrCThg=;
        b=JKfbQMDmCNuambthfYwiYVPx4zZjaeyUfihDsoVPocvUx1NwMVnDJpHR6tOMlBBW+s
         IQBrCvOCHQunkOzw1aIyJowAWdkZt3VhkS3cTJpH4dqjXHI99k7M/nAlQObzHsinAanB
         DkHW9HbPV1tzqEsXPNh7If8cS3V6fvHnfGqd1wu4WfxhWa+tMGjTmS1dpm0Yqw/auWBc
         Gt72B0P0nY7gu6tHRImOhF0Hug/3kn5hr7a/4zRnFRcEzVZfXwVWEji2twlpqGkjNOa1
         M9EWTozMALcFmGwdGKRlfwEntlhkBaf0zBohrnuf0fpoTHLZ+bQ92Vw1gHlhd8bXaGHQ
         ErLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738688221; x=1739293021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4V+8+gsz9nYVXr4B1OGpZ57RFL7WyZcu08m1tGrCThg=;
        b=NjfsP3s2ul67nemnqyZvaMghmYMeXideR+PoFB5KyPNOUO/3FTkvLN7IU1q1Sazy1T
         zu+S9K5z9N8jDsNPpWXn8+aY0hBIk4elDtVNJIzk2LFUb2RC39A9ccDS17AX9CoIenBh
         ocfnKUW1x7rIeVYUrAZfpBmrgSgokLMn0VqNHbNmadHoCZEXkwnLZeOZfnpHJ6jx1Cqh
         peIXvwW1VjdMYs/ty+H6qnlqchlrv6jnsDaKxdATkU4j/Vi4CAWZxaeqd5Og5W94S2Mz
         dIXNrtXAYoAbVY54y3HXhggry2LJ8skvmTRt5CxCE+WLTqO7mShyWKVOzld80ibAYJCy
         kqhg==
X-Forwarded-Encrypted: i=1; AJvYcCXA+n4T48fyJ4BCXyKotRSMTinwX1pkOXB4+MxunW/oi5dRNI2nONJgdbBmdaWSOvpfD8lRNxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5c00/audRRzkocMYGb5SP4qgP5O6BQmN3+PHT9ZUcS8BpGo0l
	TFLoU0u02vvTFCrVcGxIZo2/bHvryht5kiihm5cABqTqW9rcHlTZuDNssJUgtXVvNp7innU7M2R
	7as47ERKb2cHKZD+BFJaNxUB4RsnRSjVo5g6NNpAvgmQyStaxTg==
X-Gm-Gg: ASbGncsf4/5bBAtukvlH6upJorMvb0cegip8r8E56xteTixfRdV+xoeA5mYlawntrxm
	xShze6dvoz3xFUtyb0n7nChp537SsblJ4F6E50epUTxkbbWZz89VfW1xsu87MDyq9WXAy1J4=
X-Google-Smtp-Source: AGHT+IFRv6qlUYgrsFF/hX8+/mvGSr+mugXMjDX4Nn58NiWcYHrCzkLrgO+my7aMxm4yPEV3WGAbQbyGfgKSXRBjyoY=
X-Received: by 2002:a05:6402:388c:b0:5dc:90e7:d43 with SMTP id
 4fb4d7f45d1cf-5dc90e7101amr15273405a12.26.1738688220633; Tue, 04 Feb 2025
 08:57:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203143046.3029343-1-edumazet@google.com> <20250203143046.3029343-10-edumazet@google.com>
 <20250203153633.46ce0337@kernel.org> <CANn89i+-Jifwyjhif1jPXcoXU7n2n4Hyk13k7XoTRCeeAJV1uA@mail.gmail.com>
 <CANn89iKfq8LhriwPzzkCACfrPtVz=XXdnsqQFz6ZOFgqJX7ZJA@mail.gmail.com>
 <CANn89iJKeRYZh42MKvqLgLFwCSoti0dbSkreaOMSgmfWXzm-GA@mail.gmail.com> <7bdc93b7-3f1a-47ab-bf1f-8ad684e4f569@kernel.org>
In-Reply-To: <7bdc93b7-3f1a-47ab-bf1f-8ad684e4f569@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Feb 2025 17:56:49 +0100
X-Gm-Features: AWEUYZk2wp1NTZmih-FaYbX4PS9wn-F3-AWf-hKMDLZNh_hvwJg0dkaIbXRxL2Y
Message-ID: <CANn89iJJnZrLRfE+dMEtS2bOjS3s=c=-5Xk1c5XZAUWpJ8SbVg@mail.gmail.com>
Subject: Re: [PATCH v2 net 09/16] ipv4: icmp: convert to dev_net_rcu()
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 5:21=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Eric,
>
> On 04/02/2025 11:35, Eric Dumazet wrote:
> > On Tue, Feb 4, 2025 at 5:57=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >>
> >> On Tue, Feb 4, 2025 at 5:14=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> >>>
> >>> On Tue, Feb 4, 2025 at 12:36=E2=80=AFAM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> >>>>
> >>>> On Mon,  3 Feb 2025 14:30:39 +0000 Eric Dumazet wrote:
> >>>>> @@ -611,9 +611,9 @@ void __icmp_send(struct sk_buff *skb_in, int ty=
pe, int code, __be32 info,
> >>>>>               goto out;
> >>>>>
> >>>>>       if (rt->dst.dev)
> >>>>> -             net =3D dev_net(rt->dst.dev);
> >>>>> +             net =3D dev_net_rcu(rt->dst.dev);
> >>>>>       else if (skb_in->dev)
> >>>>> -             net =3D dev_net(skb_in->dev);
> >>>>> +             net =3D dev_net_rcu(skb_in->dev);
> >>>>>       else
> >>>>>               goto out;
> >>>>
> >>>> Hm. Weird. NIPA says this one is not under RCU.
> >>>>
> >>>> [  275.730657][    C1] ./include/net/net_namespace.h:404 suspicious =
rcu_dereference_check() usage!
> >>>> [  275.731033][    C1]
> >>>> [  275.731033][    C1] other info that might help us debug this:
> >>>> [  275.731033][    C1]
> >>>> [  275.731471][    C1]
> >>>> [  275.731471][    C1] rcu_scheduler_active =3D 2, debug_locks =3D 1
> >>>> [  275.731799][    C1] 1 lock held by swapper/1/0:
> >>>> [  275.732000][    C1]  #0: ffffc900001e0ae8 ((&n->timer)){+.-.}-{0:=
0}, at: call_timer_fn+0xe8/0x230
> >>>> [  275.732354][    C1]
> >>>> [  275.732354][    C1] stack backtrace:
> >>>> [  275.732638][    C1] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tain=
ted 6.13.0-virtme #1
> >>>> [  275.732643][    C1] Hardware name: Bochs Bochs, BIOS Bochs 01/01/=
2011
> >>>> [  275.732646][    C1] Call Trace:
> >>>> [  275.732647][    C1]  <IRQ>
> >>>> [  275.732651][    C1]  dump_stack_lvl+0xb0/0xd0
> >>>> [  275.732663][    C1]  lockdep_rcu_suspicious+0x1ea/0x280
> >>>> [  275.732678][    C1]  __icmp_send+0xb0d/0x1580
> >>>> [  275.732695][    C1]  ? tcp_data_queue+0x8/0x22d0
> >>>> [  275.732701][    C1]  ? lockdep_hardirqs_on_prepare+0x12b/0x410
> >>>> [  275.732712][    C1]  ? __pfx___icmp_send+0x10/0x10
> >>>> [  275.732719][    C1]  ? tcp_check_space+0x3ce/0x5f0
> >>>> [  275.732742][    C1]  ? rcu_read_lock_any_held+0x43/0xb0
> >>>> [  275.732750][    C1]  ? validate_chain+0x1fe/0xae0
> >>>> [  275.732771][    C1]  ? __pfx_validate_chain+0x10/0x10
> >>>> [  275.732778][    C1]  ? hlock_class+0x4e/0x130
> >>>> [  275.732784][    C1]  ? mark_lock+0x38/0x3e0
> >>>> [  275.732788][    C1]  ? sock_put+0x1a/0x60
> >>>> [  275.732806][    C1]  ? __lock_acquire+0xb9a/0x1680
> >>>> [  275.732822][    C1]  ipv4_send_dest_unreach+0x3b4/0x800
> >>>> [  275.732829][    C1]  ? neigh_invalidate+0x1c7/0x540
> >>>> [  275.732837][    C1]  ? __pfx_ipv4_send_dest_unreach+0x10/0x10
> >>>> [  275.732850][    C1]  ipv4_link_failure+0x1b/0x190
> >>>> [  275.732856][    C1]  arp_error_report+0x96/0x170
> >>>> [  275.732862][    C1]  neigh_invalidate+0x209/0x540
> >>>> [  275.732873][    C1]  neigh_timer_handler+0x87a/0xdf0
> >>>> [  275.732883][    C1]  ? __pfx_neigh_timer_handler+0x10/0x10
> >>>> [  275.732886][    C1]  call_timer_fn+0x13b/0x230
> >>>> [  275.732891][    C1]  ? call_timer_fn+0xe8/0x230
> >>>> [  275.732894][    C1]  ? call_timer_fn+0xe8/0x230
> >>>> [  275.732899][    C1]  ? __pfx_call_timer_fn+0x10/0x10
> >>>> [  275.732902][    C1]  ? mark_lock+0x38/0x3e0
> >>>> [  275.732920][    C1]  __run_timers+0x545/0x810
> >>>> [  275.732925][    C1]  ? __pfx_neigh_timer_handler+0x10/0x10
> >>>> [  275.732936][    C1]  ? __pfx___run_timers+0x10/0x10
> >>>> [  275.732939][    C1]  ? __lock_release+0x103/0x460
> >>>> [  275.732947][    C1]  ? do_raw_spin_lock+0x131/0x270
> >>>> [  275.732952][    C1]  ? __pfx_do_raw_spin_lock+0x10/0x10
> >>>> [  275.732956][    C1]  ? lock_acquire+0x32/0xc0
> >>>> [  275.732958][    C1]  ? timer_expire_remote+0x96/0xf0
> >>>> [  275.732967][    C1]  timer_expire_remote+0x9e/0xf0
> >>>> [  275.732970][    C1]  tmigr_handle_remote_cpu+0x278/0x440
> >>>> [  275.732977][    C1]  ? __pfx_tmigr_handle_remote_cpu+0x10/0x10
> >>>> [  275.732981][    C1]  ? __pfx___lock_release+0x10/0x10
> >>>> [  275.732985][    C1]  ? __pfx_lock_acquire.part.0+0x10/0x10
> >>>> [  275.733015][    C1]  tmigr_handle_remote_up+0x1a6/0x270
> >>>> [  275.733027][    C1]  ? __pfx_tmigr_handle_remote_up+0x10/0x10
> >>>> [  275.733036][    C1]  __walk_groups.isra.0+0x44/0x160
> >>>> [  275.733051][    C1]  tmigr_handle_remote+0x20b/0x300
> >>>>
> >>>> Decoded:
> >>>> https://netdev-3.bots.linux.dev/vmksft-mptcp-dbg/results/976941/vm-c=
rash-thr0-1
> >>>
> >>> Oops, I thought I ran the tests on the whole series. I missed this on=
e.
> >>
> >> BTW, ICMPv6 has the same potential problem, I will amend both cases.
> >
> > I ran again the tests for v3, got an unrelated crash, FYI.
> >
> > 14237.095216] #PF: supervisor instruction fetch in kernel mode
> > [14237.095570] #PF: error_code(0x0010) - not-present page
> > [14237.095915] PGD 1e58067 P4D 1e58067 PUD ce1c067 PMD 0
> > [14237.096991] Oops: Oops: 0010 [#1] SMP DEBUG_PAGEALLOC NOPTI
> > [14237.097507] CPU: 0 UID: 0 PID: 6371 Comm: python3 Not tainted
> > 6.13.0-virtme #1559
> > [14237.098045] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > [14237.098578] RIP: 0010:0x0
> > [14237.099324] Code: Unable to access opcode bytes at 0xffffffffffffffd=
6.
> > [14237.099752] RSP: 0018:ffffacfd4486bed0 EFLAGS: 00000286
> > [14237.100079] RAX: 0000000000000000 RBX: ffff9af502607200 RCX: 0000000=
000000002
> > [14237.100452] RDX: 00007fffc684a690 RSI: 0000000000005401 RDI: ffff9af=
502607200
> > [14237.100821] RBP: 0000000000005401 R08: 0000000000000001 R09: 0000000=
000000000
> > [14237.101182] R10: 0000000000000001 R11: 0000000000000000 R12: 00007ff=
fc684a690
> > [14237.101542] R13: ffff9af50888ed68 R14: ffff9af502607200 R15: 0000000=
000000000
> > [14237.101956] FS:  00007f76b73f95c0(0000) GS:ffff9af57cc00000(0000)
> > knlGS:0000000000000000
> > [14237.102372] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [14237.102679] CR2: ffffffffffffffd6 CR3: 00000000039ca000 CR4: 0000000=
0000006f0
> > [14237.103160] Call Trace:
> > [14237.103435]  <TASK>
> > [14237.103720]  ? __die_body.cold+0x19/0x26
> > [14237.104340]  ? page_fault_oops+0x134/0x2a0
> > [14237.104553]  ? cp_new_stat+0x157/0x190
> > [14237.104799]  ? exc_page_fault+0x68/0x230
> > [14237.105013]  ? asm_exc_page_fault+0x26/0x30
> > [14237.105259]  full_proxy_unlocked_ioctl+0x63/0x90
> > [14237.105546]  __x64_sys_ioctl+0x97/0xc0
> > [14237.105754]  do_syscall_64+0x72/0x180
> > [14237.105949]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> I think I got this issue as well on MPTCP side, when using GCOV, but
> something else using the debugfs could trigger that as well I guess. It
> is apparently fixed in the Linus tree, see 57b314752ec0 ("debugfs: Fix
> the missing initializations in __debugfs_file_get()")
>
> https://lore.kernel.org/all/20250129191937.GR1977892@ZenIV/

Great, thanks for the info :)

