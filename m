Return-Path: <netdev+bounces-162380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC3CA26B27
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 05:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD23166827
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 04:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB2A12BF24;
	Tue,  4 Feb 2025 04:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TUjREqkC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5125A624
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 04:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738645051; cv=none; b=jHks26+M6aOfGainAqKI+SnSBuSvd5IzfNUQO6//WNBIYkQ536zCACH/tOaY3L9JnDGOofrHKRrx+mf2qDAdsyVj5zOmncJJsk9WOYNzDt2rhTPCI02Ci5oYXuOpkbNXc7mPshCsk1EwbmeSAAij35k7imfh7PaWT+IEQ+AbCcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738645051; c=relaxed/simple;
	bh=KYCjZAA0+yfQAASMZJBhgr1LqR0sfoz0VHKzuE6DjiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sf1GZXbLjYWpH29JUGXPvRXOiKbQJS4vrxwOs9t4w0GW2T2gp4ZgG3PcrIuK5b20yzZOOWXHgz/gy8nu6IDO80LtQ/94Wg9WQ1+qMzD48qiLEPf0JYceYy28lvRX24NfxXcWXh0a/b1B5mOwkXS5kBF+J/vAIjsmmJff8gyZAkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TUjREqkC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3e9a88793so8217825a12.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 20:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738645048; x=1739249848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTBoYwSGUzubSTLMc77Vpia4roUN6bXDpnFw3nnPTpc=;
        b=TUjREqkCVXXpsvFnxm01Ge5hcYuCX1F7DYe+XLCJezNvbYQURaEwUz2vey4h4QbXHX
         8mC2ahNkrqUUUdxgr5f2CbGyTKo05hnrhVjSX7puI2x9WeMl5YvjJH3YR4MPuxcxiAyG
         cd21zF6SHq0nggeDqnDoKGEmKeojT99HarZ7FXlgmwGY7YsWZsH6dgDcQxUKgPbofWNi
         hddM0K4+cq7Fz+WiwVRiPJZvNBKJnlJVH599UxoUJPHNxTLPl+dVIHDFzjr0WACys/7Q
         d2TcRlRSCpwS5e59zPCffUD09bv5X/80PVivzTGqSBO9ZNbuBESczV+Q6QHap4/FptLB
         bcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738645048; x=1739249848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTBoYwSGUzubSTLMc77Vpia4roUN6bXDpnFw3nnPTpc=;
        b=fJiX124wPeddQ2emFqkaFWAptwsVFGi0Lf8+nW8FDpL3RidbbQxxwZtalVLdllPQwV
         2dS44xqDhdXRdbHzB8ysHpb9ThmO9tDwiJWBCCeBPAEDxZRIRKtnEytA8MfZPNXK+j/Z
         NIfB2f6eoy/+FkRG4xMDLi/nu+87jChJOxat4HkHVTM4gpjNLRJ75HKH0o7iPtuWX2W+
         plJp6d030dXqLBUlKENFm2bp2KlUuGqlpqCCiEXxWTG8SeTCnUvm8LSEgG4dz73ZSf9s
         udBKs31y7fATo5SobjMYOgbuq7GDNvk+l3SPhOOG4VXXbF5D8aMU1VFb7aP/NK71jhMX
         R9BQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5hbgfopjldBS/DmYfPepXW3b+LSJQDB4lX4ODOlhxJnyGWoVdbEG/KQ2J08a9IsEkEtgCfo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX71jKtHN4iVgvnv5cxhWzUbFsVZosItsnDXkg2lWJZcBZgM2A
	TzfWyCDCsj+xIL3cETbnlVUnQ4V37ynrDRYn0WMtTjfMlJw+cKyKMWFgd1lwZipSkFRThhZa3nS
	GEjhJbng0n5shTs86qSBgX7IwPHyH8E/gDhC+
X-Gm-Gg: ASbGncsKEcrCzVj6BYBeTzq9aw5LZxLFjKA9ldcHaNTqbrrXu7p7mYm4MMs7GsvlKNi
	nUWlFCz2sv7P588TC6FK27s67cZs+1JlVGlum2zMiWzTZ7fap2dLz+zlO/9EMeTS1cePxTg==
X-Google-Smtp-Source: AGHT+IH6XiPwUKD+bzaIJi7xqkfwXuBLXff47ke5DUDO1LD1VqeymiYZPQbZYWw/nRCI1SLFaRhGW1aLAEbMMpOFfp4=
X-Received: by 2002:a05:6402:2710:b0:5db:f26d:fff1 with SMTP id
 4fb4d7f45d1cf-5dc5efe74b5mr24847288a12.21.1738645047790; Mon, 03 Feb 2025
 20:57:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203143046.3029343-1-edumazet@google.com> <20250203143046.3029343-10-edumazet@google.com>
 <20250203153633.46ce0337@kernel.org> <CANn89i+-Jifwyjhif1jPXcoXU7n2n4Hyk13k7XoTRCeeAJV1uA@mail.gmail.com>
In-Reply-To: <CANn89i+-Jifwyjhif1jPXcoXU7n2n4Hyk13k7XoTRCeeAJV1uA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Feb 2025 05:57:16 +0100
X-Gm-Features: AWEUYZkLGfGoi05y7E6qK4I7GqdGVDdKFhWxnG6NY_-q97iwnjUoGk6p_nRF16o
Message-ID: <CANn89iKfq8LhriwPzzkCACfrPtVz=XXdnsqQFz6ZOFgqJX7ZJA@mail.gmail.com>
Subject: Re: [PATCH v2 net 09/16] ipv4: icmp: convert to dev_net_rcu()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 5:14=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Feb 4, 2025 at 12:36=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon,  3 Feb 2025 14:30:39 +0000 Eric Dumazet wrote:
> > > @@ -611,9 +611,9 @@ void __icmp_send(struct sk_buff *skb_in, int type=
, int code, __be32 info,
> > >               goto out;
> > >
> > >       if (rt->dst.dev)
> > > -             net =3D dev_net(rt->dst.dev);
> > > +             net =3D dev_net_rcu(rt->dst.dev);
> > >       else if (skb_in->dev)
> > > -             net =3D dev_net(skb_in->dev);
> > > +             net =3D dev_net_rcu(skb_in->dev);
> > >       else
> > >               goto out;
> >
> > Hm. Weird. NIPA says this one is not under RCU.
> >
> > [  275.730657][    C1] ./include/net/net_namespace.h:404 suspicious rcu=
_dereference_check() usage!
> > [  275.731033][    C1]
> > [  275.731033][    C1] other info that might help us debug this:
> > [  275.731033][    C1]
> > [  275.731471][    C1]
> > [  275.731471][    C1] rcu_scheduler_active =3D 2, debug_locks =3D 1
> > [  275.731799][    C1] 1 lock held by swapper/1/0:
> > [  275.732000][    C1]  #0: ffffc900001e0ae8 ((&n->timer)){+.-.}-{0:0},=
 at: call_timer_fn+0xe8/0x230
> > [  275.732354][    C1]
> > [  275.732354][    C1] stack backtrace:
> > [  275.732638][    C1] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted=
 6.13.0-virtme #1
> > [  275.732643][    C1] Hardware name: Bochs Bochs, BIOS Bochs 01/01/201=
1
> > [  275.732646][    C1] Call Trace:
> > [  275.732647][    C1]  <IRQ>
> > [  275.732651][    C1]  dump_stack_lvl+0xb0/0xd0
> > [  275.732663][    C1]  lockdep_rcu_suspicious+0x1ea/0x280
> > [  275.732678][    C1]  __icmp_send+0xb0d/0x1580
> > [  275.732695][    C1]  ? tcp_data_queue+0x8/0x22d0
> > [  275.732701][    C1]  ? lockdep_hardirqs_on_prepare+0x12b/0x410
> > [  275.732712][    C1]  ? __pfx___icmp_send+0x10/0x10
> > [  275.732719][    C1]  ? tcp_check_space+0x3ce/0x5f0
> > [  275.732742][    C1]  ? rcu_read_lock_any_held+0x43/0xb0
> > [  275.732750][    C1]  ? validate_chain+0x1fe/0xae0
> > [  275.732771][    C1]  ? __pfx_validate_chain+0x10/0x10
> > [  275.732778][    C1]  ? hlock_class+0x4e/0x130
> > [  275.732784][    C1]  ? mark_lock+0x38/0x3e0
> > [  275.732788][    C1]  ? sock_put+0x1a/0x60
> > [  275.732806][    C1]  ? __lock_acquire+0xb9a/0x1680
> > [  275.732822][    C1]  ipv4_send_dest_unreach+0x3b4/0x800
> > [  275.732829][    C1]  ? neigh_invalidate+0x1c7/0x540
> > [  275.732837][    C1]  ? __pfx_ipv4_send_dest_unreach+0x10/0x10
> > [  275.732850][    C1]  ipv4_link_failure+0x1b/0x190
> > [  275.732856][    C1]  arp_error_report+0x96/0x170
> > [  275.732862][    C1]  neigh_invalidate+0x209/0x540
> > [  275.732873][    C1]  neigh_timer_handler+0x87a/0xdf0
> > [  275.732883][    C1]  ? __pfx_neigh_timer_handler+0x10/0x10
> > [  275.732886][    C1]  call_timer_fn+0x13b/0x230
> > [  275.732891][    C1]  ? call_timer_fn+0xe8/0x230
> > [  275.732894][    C1]  ? call_timer_fn+0xe8/0x230
> > [  275.732899][    C1]  ? __pfx_call_timer_fn+0x10/0x10
> > [  275.732902][    C1]  ? mark_lock+0x38/0x3e0
> > [  275.732920][    C1]  __run_timers+0x545/0x810
> > [  275.732925][    C1]  ? __pfx_neigh_timer_handler+0x10/0x10
> > [  275.732936][    C1]  ? __pfx___run_timers+0x10/0x10
> > [  275.732939][    C1]  ? __lock_release+0x103/0x460
> > [  275.732947][    C1]  ? do_raw_spin_lock+0x131/0x270
> > [  275.732952][    C1]  ? __pfx_do_raw_spin_lock+0x10/0x10
> > [  275.732956][    C1]  ? lock_acquire+0x32/0xc0
> > [  275.732958][    C1]  ? timer_expire_remote+0x96/0xf0
> > [  275.732967][    C1]  timer_expire_remote+0x9e/0xf0
> > [  275.732970][    C1]  tmigr_handle_remote_cpu+0x278/0x440
> > [  275.732977][    C1]  ? __pfx_tmigr_handle_remote_cpu+0x10/0x10
> > [  275.732981][    C1]  ? __pfx___lock_release+0x10/0x10
> > [  275.732985][    C1]  ? __pfx_lock_acquire.part.0+0x10/0x10
> > [  275.733015][    C1]  tmigr_handle_remote_up+0x1a6/0x270
> > [  275.733027][    C1]  ? __pfx_tmigr_handle_remote_up+0x10/0x10
> > [  275.733036][    C1]  __walk_groups.isra.0+0x44/0x160
> > [  275.733051][    C1]  tmigr_handle_remote+0x20b/0x300
> >
> > Decoded:
> > https://netdev-3.bots.linux.dev/vmksft-mptcp-dbg/results/976941/vm-cras=
h-thr0-1
>
> Oops, I thought I ran the tests on the whole series. I missed this one.

BTW, ICMPv6 has the same potential problem, I will amend both cases.

