Return-Path: <netdev+bounces-141640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A3E9BBDE0
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 20:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B23283488
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 19:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940241CB9F4;
	Mon,  4 Nov 2024 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gjfcICvJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE918C93B
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747913; cv=none; b=X+rVJth3hewOYDBQO0LFh/cB7sDch68buajQ8xEJAlz7DGuMrItVzPMoYxoxJma4dYgXKWlLmlMt/XIsuiwAOJYNqPlXAXhnjShB1UYJECsu6VNtwJTPFjFmRmA+0+eldZPDbyjEvBnXzsW5+xxIYB8AjZAv9UW/MnhFbcIsPMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747913; c=relaxed/simple;
	bh=o4c7ros9DYn+xK2HPnkqBz3dofFrgKI/jqYMkYox99k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDJ5csTkSC8NyuLrcZP0LZy8FgNrflL2KbiW4k8Y5yIjqRq/OcIOq9ZGW5aPRVbNVQgjbCDIvrHjpui0tclLAqgWhhScIPjyG2ypKHmoD30OoUMonZc/TAWFIJVX9nHeql81ArqMPVdenWEwKngvgiQyL2LtMPov3xrkELjMpnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gjfcICvJ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7eb0448693eso311954a12.2
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 11:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730747910; x=1731352710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4c7ros9DYn+xK2HPnkqBz3dofFrgKI/jqYMkYox99k=;
        b=gjfcICvJB0Y/4kv8TpLTq8p1M5wkuOpWb1bn9hdtMkHmGl8VepkIVNgZF6Pu1o/dTT
         gA9ednJQ8MnGzgFUoLZKsn/wos5XhU+inNJ0CQRWXIOWOXV20B4mJktFGXSYb4Tlis6n
         kDcvwNs8+nVdGMFTAuV3tDwaTzESVpJa88B+aVlw3Uvt2+3XUU64Ln3VGM6vn3hzuzJz
         ti6IqG4m5o/h2XjdRju1VhOlLCsr9p5frv7yD3vZMaPr875d0kdtgn8q9TvixA0DcgHG
         KgmGZqxWoFC/h3D49tZUTZvIMb+ZMeVc3pqItnrurVTSJuUu56TeFZwoeqLdLrnzhtU7
         3Rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730747910; x=1731352710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4c7ros9DYn+xK2HPnkqBz3dofFrgKI/jqYMkYox99k=;
        b=sKF+NFShaUPOVczwOPL4ZKEnSL7qapr/cj5So4VdgBWM+LMtXqZ9k0tyneIWqACPD6
         WaHv7INhHcdkFSRQFV6OOLruRId9bSIPnfLYRlHiYDjjKVVo+0vWD6qcr2Otyaaud4zo
         L+pMKy2rbOi9JO+0XCCy5R2Bkk0bac+KqVUqbuF1e9oIw+mW7C0/U2MWRmCyuNAPh+6k
         1zUy5M71dhJFo8XqkmBX9srRahsnOzjoLlN+OH27ojJcKndDLWYhRCL2C9Q++5X8U6fM
         pEG1T8F46ayuoX/T5NhPCcCu9dVLUilviu5BnK/GIRoAV4sNYR+wOJiVtodBj24Wff92
         5WmA==
X-Forwarded-Encrypted: i=1; AJvYcCUgL+v6RuH0eXJWFQlIKsVQrYVVHlFgE91ffHaENkPLzXJ1clArwXqGSgmdTwCgHXufEZrsDS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJyi/u8bAyH46iP14GIdMEyiLD/gogdfLZyoHVqwmP+oSbsXF7
	JpTKiWnDqPDii9flVV6sO1a/B6OwX5cRxZHPzEAKQ7T29yoFtQJQXgU/Z1aRfXSs1n1S0vB57Wm
	dnWep4gPs42m7nrtoEXfJujD3ZTbqD5Es+T84Ow==
X-Google-Smtp-Source: AGHT+IHaIPQ+nBMH8dexfN2lNpEIdnQn8/hMcRrxlt8l5wRwbDjd8ZCjdB5A1VVt5iHAa8KssU7wpEsM+wpcZAQTSdo=
X-Received: by 2002:a17:90a:b014:b0:2e2:ebce:c412 with SMTP id
 98e67ed59e1d1-2e8f0f4ce84mr16036218a91.2.1730747910349; Mon, 04 Nov 2024
 11:18:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029182703.2698171-1-csander@purestorage.com>
 <CANn89iLx-4dTB9fFgfrsXQ8oA0Z+TpBWNk4b91PPS1o=oypuBQ@mail.gmail.com>
 <CADUfDZrSUNu7nym9dC1_yFUqhC8tUPYjv-ZKHofU9Q8Uv4Jvhw@mail.gmail.com>
 <CANn89iKQ3g2+nSWaV3BWarpbneRCSoGSXdGP90PF7ScDu4ULEQ@mail.gmail.com>
 <CADUfDZpeudTGP5UZt6QqbrYkA+Twei7gGQa6hJ+iYwuZfyp9gw@mail.gmail.com>
 <CADUfDZqcd_2+409_4GGhbRwW8gYHtZSU1vE1eNuE=jycoNMMJA@mail.gmail.com> <CANn89iJEL7=q_tYXPbwUGF4MoX=W0AOoevMg31Y=nH7WyofaiA@mail.gmail.com>
In-Reply-To: <CANn89iJEL7=q_tYXPbwUGF4MoX=W0AOoevMg31Y=nH7WyofaiA@mail.gmail.com>
From: Caleb Sander <csander@purestorage.com>
Date: Mon, 4 Nov 2024 11:18:18 -0800
Message-ID: <CADUfDZr-xuruCjJwebWk2SUAq9-pCDLDQ1HHpQTOPnK3BAXg=g@mail.gmail.com>
Subject: Re: [PATCH] net: skip RPS if packet is already on target CPU
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 10:58=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Nov 4, 2024 at 7:42=E2=80=AFPM Caleb Sander <csander@purestorage.=
com> wrote:
> >
> > On Wed, Oct 30, 2024 at 1:26=E2=80=AFPM Caleb Sander <csander@purestora=
ge.com> wrote:
> > >
> > > On Wed, Oct 30, 2024 at 5:55=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Tue, Oct 29, 2024 at 9:38=E2=80=AFPM Caleb Sander <csander@pures=
torage.com> wrote:
> > > > >
> > > > > On Tue, Oct 29, 2024 at 12:02=E2=80=AFPM Eric Dumazet <edumazet@g=
oogle.com> wrote:
> > > > > >
> > > > > > On Tue, Oct 29, 2024 at 7:27=E2=80=AFPM Caleb Sander Mateos
> > > > > > <csander@purestorage.com> wrote:
> > > > > > >
> > > > > > > If RPS is enabled, all packets with a CPU flow hint are enque=
ued to the
> > > > > > > target CPU's input_pkt_queue and process_backlog() is schedul=
ed on that
> > > > > > > CPU to dequeue and process the packets. If ARFS has already s=
teered the
> > > > > > > packets to the correct CPU, this additional queuing is unnece=
ssary and
> > > > > > > the spinlocks involved incur significant CPU overhead.
> > > > > > >
> > > > > > > In netif_receive_skb_internal() and netif_receive_skb_list_in=
ternal(),
> > > > > > > check if the CPU flow hint get_rps_cpu() returns is the curre=
nt CPU. If
> > > > > > > so, bypass input_pkt_queue and immediately process the packet=
(s) on the
> > > > > > > current CPU.
> > > > > > >
> > > > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > > >
> > > > > > Current implementation was a conscious choice. This has been di=
scussed
> > > > > > several times.
> > > > > >
> > > > > > By processing packets inline, you are actually increasing laten=
cies of
> > > > > > packets queued to other cpus.
> > > > >
> > > > > Sorry, I wasn't aware of these prior discussions. I take it you a=
re
> > > > > referring to threads like
> > > > > https://lore.kernel.org/netdev/20230322072142.32751-1-xu.xin16@zt=
e.com.cn/T/
> > > > > ? I see what you mean about the latency penalty for packets that =
do
> > > > > require cross-CPU steering.
> > > > >
> > > > > Do you have an alternate suggestion for how to avoid the overhead=
 of
> > > > > acquiring a spinlock for every packet? The atomic instruction in
> > > > > rps_lock_irq_disable() called from process_backlog() is consuming=
 5%
> > > > > of our CPU time. For our use case, we don't really want software =
RPS;
> > > > > we are expecting ARFS to steer all high-bandwidth traffic to the
> > > > > desired CPUs. We would happily turn off software RPS entirely if =
we
> > > > > could, which seems like it would avoid the concerns about higher
> > > > > latency for packets that need to be steering to a different CPU. =
But
> > > > > my understanding is that using ARFS requires RPS to be enabled
> > > > > (rps_sock_flow_entries set globally and rps_flow_cnt set on each
> > > > > queue), which enables these rps_needed static branches. Is that
> > > > > correct? If so, would you be open to adding a sysctl that disable=
s
> > > > > software RPS and relies upon ARFS to do the packet steering?
> > > >
> > > > A sysctl will not avoid the fundamental issue.
> > >
> > > Sorry if my suggestion was unclear. I mean that we would ideally like
> > > to use only hardware ARFS for packet steering, and disable software
> > > RPS.
> > > In our testing, ARFS reliably steers packets to the desired CPUs. (Ou=
r
> > > application has long-lived TCP sockets, each processed on a single
> > > thread affinitized to one of the interrupt CPUs for the Ethernet
> > > device.) In the off chance that ARFS doesn't steer the packet to the
> > > correct CPU, we would rather just process it on the CPU that receives
> > > it instead of going through the RPS queues. If software RPS is never
> > > used, then there wouldn't be any concerns about higher latency for
> > > RPS-steered vs. non-RPS-steered packets, right? The get_rps_cpu()
> > > computation is also not cheap, so it would be nice to skip it too.
> > > Basically, we want to program ARFS but skip these
> > > static_branch_unlikely(&rps_needed) branches. But I'm not aware of a
> > > way to do that currently. (Please let me know if it's already possibl=
e
> > > to do that.)
> >
> > I see now that get_rps_cpu() still needs to be called even if software
> > RPS isn't going to be used, because it's also responsible for calling
> > set_rps_cpu() to program ARFS. So looks like avoiding the calls to
> > get_rps_cpu() entirely is not possible.
>
> Yes, this is the reason. Things would be different if ARFS was done at
> dev_queue_xmit() time.
>
> >
> > > > Why not instead address the past feedback ?
> > > > Can you test the following ?
> > >
> > > Sure, I will test the performance on our setup with this patch. Still=
,
> > > we would prefer to skip the get_rps_cpu() computation and these extra
> > > checks, and just process the packets on the CPUs they arrive on.
> >
> > Hi Eric,
> > I tried out your patch and it seems to work equally well at
> > eliminating the process_backlog() -> _raw_spin_lock_irq() hotspot. The
> > added checks contribute a bit of overhead in
> > netif_receive_skb_list_internal(): it has increased from 0.15% to
> > 0.28% of CPU time. But that's definitely worth it to remove the 5%
> > hotspot acquiring the RPS spinlock.
> >
> > Feel free to add:
> > Tested-by: Caleb Sander Mateos <csander@purestorage.com>
> >
> > Some minor comments on the patch:
> > - Probably should be using either skb_queue_len_lockless() or
> > skb_queue_empty_lockless() to check input_pkt_queue.qlen !=3D 0 because
> > the RPS lock is not held at this point
>
> this_cpu_read() has implicit READ_ONCE() semantic.

Okay. Seems like it would be nicer not to reach into the sk_buff_head
internals, but up to you.

>
> > - Could consolidate the 2 this_cpu_read(softnet_data...) lookups into
> > a single this_cpu_ptr(&softnet_data) call
>
> Double check the generated assembly first :)
>
> this_cpu_read() is faster than going through
> this_cpu_ptr(&softnet_data), at least on x86,
> thanks to %gs: prefix.
>
> No temporary register is needed to compute and hold this_cpu_ptr(&softnet=
_data).

Got it, thanks.

