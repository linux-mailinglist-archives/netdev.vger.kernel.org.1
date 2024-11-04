Return-Path: <netdev+bounces-141638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFC49BBD93
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 19:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE131F22692
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37B01CB9F2;
	Mon,  4 Nov 2024 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1EilAkrG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085318622
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730746719; cv=none; b=B9WjGWy6rGOW7KfaDJW6AkZNfhv8jkTuQTqUp52VK9UHDgFOxoxNzbj9f8FBIiLky6aI4W+Dlkaw5t1CU6oCjSpucfQljlfHTK4nMJC4w96uPTCvwUrZCmttORA9WKALbcL62gaqZJxWcHbIILllvhOsXJPCNfaylhe2CI3tVbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730746719; c=relaxed/simple;
	bh=isJAzGf3k6QvAMsbQKBBMJaq26UrihdubbeoWh4yKU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9J0INIyenx9VDi/lMmxKwfE97QLPL82rBvYgsQ+j4mAxVrqgHOIJl6vptHnI6qXvEkncLwDnaaV9z1nQPwtWMY4L/1aES88Hd+IqmWDGMCZED3U2UQThlwP+Nbl08DsCyyZRQUZPVP9RPzsgzcI+bBmRSK42S3NK/Fs9qCQ/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1EilAkrG; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so2427755a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 10:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730746716; x=1731351516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isJAzGf3k6QvAMsbQKBBMJaq26UrihdubbeoWh4yKU0=;
        b=1EilAkrGxAVqi7NGl36SkxfnaHaixxSbqqBLYBQEOQFqGrjmqtWDRwIIfURhPaAPzh
         e88RXqC5diTGO9P7m/gUPonKpr0da8fwalYBgfaqoSIiRDOKc4ZOHVx8sewuNgf+voCs
         9n57gPhMxVvsRSAUVPapgBLvzz7d+xPjYcoiBX5uNaCcw0uSZQoWjyYh/R1EEifsAISC
         8i3NPBbN98OVRMAZuuB1BsRm5mH42kFflmgQCC+kks9Je0m7aJTVrk8W+LyFt2OIOWdL
         GMLCJD2io1G/eJXvbkIfINRVkYIRXsnR2Ibg6RfgjfiUPZspHlHgF/O8Gg5SVkh4Y8gZ
         mQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730746716; x=1731351516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isJAzGf3k6QvAMsbQKBBMJaq26UrihdubbeoWh4yKU0=;
        b=paiA0UdsKARacLJnj6zE8lC8hgLQvQ2Na09jtGMUFR5jQHkwzDLf62qSAa6eAodwTA
         lQdRQ1k++2AuPyFU9amWeMfcDqUQ8oHpLQWukn8a78dhx4Duz1Jd3My4vJ3BWmj09IOz
         VTOn46kz3dRk43hx6v9rRlks71A6lbqx3JW/Nu9k07M6epGOfDMzUNFeV2HblDmtL/HM
         O6WtuUZIr298M4TJPUNSCX7NeK/6rB7Fd6Zif2q7jYZimDk9FscJ9X7C2a2CosCNx/az
         sLakbNiwZzhrXxD0JT+5k3cbRXJkZ9ILK6dt5563vmC5MOJ/R4ht/lFa3wOHMc4+VrCZ
         9qtg==
X-Forwarded-Encrypted: i=1; AJvYcCVU0hqCQgfqZX/VbbtWSC+2c9AcluUsrNqMK5kA3bQJF+J8R4ug0jUaAMXqa5Q7MalC4Dpzi9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhXSyMg0RkfPc3zB7ISZu1HdfBdCrkCArGw2Mp/0VkRTWkuJ+t
	6EhEPqbsdT+lBp5ydXynvdtPO46UwAeA/SRoHt62cohZqmbmZjWd1VridUAmiwysilz5FwRlZtI
	HGNjpnDBqSvsgEdS3gSLXFkMDGqK7jkmBu/spOOI8Phw6vp8c16O+
X-Google-Smtp-Source: AGHT+IEujtLJL3hcARW/aKUxU8QnzrSHycAUnFbSnslpk0nRWq73KMkhf1GdNQ6s6+j90MoiQCusUWsJSvHjg2C3MR4=
X-Received: by 2002:a05:6402:510e:b0:5ce:dfe7:97c8 with SMTP id
 4fb4d7f45d1cf-5cedfe798ccmr1158352a12.31.1730746715856; Mon, 04 Nov 2024
 10:58:35 -0800 (PST)
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
 <CADUfDZpeudTGP5UZt6QqbrYkA+Twei7gGQa6hJ+iYwuZfyp9gw@mail.gmail.com> <CADUfDZqcd_2+409_4GGhbRwW8gYHtZSU1vE1eNuE=jycoNMMJA@mail.gmail.com>
In-Reply-To: <CADUfDZqcd_2+409_4GGhbRwW8gYHtZSU1vE1eNuE=jycoNMMJA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Nov 2024 19:58:24 +0100
Message-ID: <CANn89iJEL7=q_tYXPbwUGF4MoX=W0AOoevMg31Y=nH7WyofaiA@mail.gmail.com>
Subject: Re: [PATCH] net: skip RPS if packet is already on target CPU
To: Caleb Sander <csander@purestorage.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 7:42=E2=80=AFPM Caleb Sander <csander@purestorage.co=
m> wrote:
>
> On Wed, Oct 30, 2024 at 1:26=E2=80=AFPM Caleb Sander <csander@purestorage=
.com> wrote:
> >
> > On Wed, Oct 30, 2024 at 5:55=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Tue, Oct 29, 2024 at 9:38=E2=80=AFPM Caleb Sander <csander@puresto=
rage.com> wrote:
> > > >
> > > > On Tue, Oct 29, 2024 at 12:02=E2=80=AFPM Eric Dumazet <edumazet@goo=
gle.com> wrote:
> > > > >
> > > > > On Tue, Oct 29, 2024 at 7:27=E2=80=AFPM Caleb Sander Mateos
> > > > > <csander@purestorage.com> wrote:
> > > > > >
> > > > > > If RPS is enabled, all packets with a CPU flow hint are enqueue=
d to the
> > > > > > target CPU's input_pkt_queue and process_backlog() is scheduled=
 on that
> > > > > > CPU to dequeue and process the packets. If ARFS has already ste=
ered the
> > > > > > packets to the correct CPU, this additional queuing is unnecess=
ary and
> > > > > > the spinlocks involved incur significant CPU overhead.
> > > > > >
> > > > > > In netif_receive_skb_internal() and netif_receive_skb_list_inte=
rnal(),
> > > > > > check if the CPU flow hint get_rps_cpu() returns is the current=
 CPU. If
> > > > > > so, bypass input_pkt_queue and immediately process the packet(s=
) on the
> > > > > > current CPU.
> > > > > >
> > > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > >
> > > > > Current implementation was a conscious choice. This has been disc=
ussed
> > > > > several times.
> > > > >
> > > > > By processing packets inline, you are actually increasing latenci=
es of
> > > > > packets queued to other cpus.
> > > >
> > > > Sorry, I wasn't aware of these prior discussions. I take it you are
> > > > referring to threads like
> > > > https://lore.kernel.org/netdev/20230322072142.32751-1-xu.xin16@zte.=
com.cn/T/
> > > > ? I see what you mean about the latency penalty for packets that do
> > > > require cross-CPU steering.
> > > >
> > > > Do you have an alternate suggestion for how to avoid the overhead o=
f
> > > > acquiring a spinlock for every packet? The atomic instruction in
> > > > rps_lock_irq_disable() called from process_backlog() is consuming 5=
%
> > > > of our CPU time. For our use case, we don't really want software RP=
S;
> > > > we are expecting ARFS to steer all high-bandwidth traffic to the
> > > > desired CPUs. We would happily turn off software RPS entirely if we
> > > > could, which seems like it would avoid the concerns about higher
> > > > latency for packets that need to be steering to a different CPU. Bu=
t
> > > > my understanding is that using ARFS requires RPS to be enabled
> > > > (rps_sock_flow_entries set globally and rps_flow_cnt set on each
> > > > queue), which enables these rps_needed static branches. Is that
> > > > correct? If so, would you be open to adding a sysctl that disables
> > > > software RPS and relies upon ARFS to do the packet steering?
> > >
> > > A sysctl will not avoid the fundamental issue.
> >
> > Sorry if my suggestion was unclear. I mean that we would ideally like
> > to use only hardware ARFS for packet steering, and disable software
> > RPS.
> > In our testing, ARFS reliably steers packets to the desired CPUs. (Our
> > application has long-lived TCP sockets, each processed on a single
> > thread affinitized to one of the interrupt CPUs for the Ethernet
> > device.) In the off chance that ARFS doesn't steer the packet to the
> > correct CPU, we would rather just process it on the CPU that receives
> > it instead of going through the RPS queues. If software RPS is never
> > used, then there wouldn't be any concerns about higher latency for
> > RPS-steered vs. non-RPS-steered packets, right? The get_rps_cpu()
> > computation is also not cheap, so it would be nice to skip it too.
> > Basically, we want to program ARFS but skip these
> > static_branch_unlikely(&rps_needed) branches. But I'm not aware of a
> > way to do that currently. (Please let me know if it's already possible
> > to do that.)
>
> I see now that get_rps_cpu() still needs to be called even if software
> RPS isn't going to be used, because it's also responsible for calling
> set_rps_cpu() to program ARFS. So looks like avoiding the calls to
> get_rps_cpu() entirely is not possible.

Yes, this is the reason. Things would be different if ARFS was done at
dev_queue_xmit() time.

>
> > > Why not instead address the past feedback ?
> > > Can you test the following ?
> >
> > Sure, I will test the performance on our setup with this patch. Still,
> > we would prefer to skip the get_rps_cpu() computation and these extra
> > checks, and just process the packets on the CPUs they arrive on.
>
> Hi Eric,
> I tried out your patch and it seems to work equally well at
> eliminating the process_backlog() -> _raw_spin_lock_irq() hotspot. The
> added checks contribute a bit of overhead in
> netif_receive_skb_list_internal(): it has increased from 0.15% to
> 0.28% of CPU time. But that's definitely worth it to remove the 5%
> hotspot acquiring the RPS spinlock.
>
> Feel free to add:
> Tested-by: Caleb Sander Mateos <csander@purestorage.com>
>
> Some minor comments on the patch:
> - Probably should be using either skb_queue_len_lockless() or
> skb_queue_empty_lockless() to check input_pkt_queue.qlen !=3D 0 because
> the RPS lock is not held at this point

this_cpu_read() has implicit READ_ONCE() semantic.

> - Could consolidate the 2 this_cpu_read(softnet_data...) lookups into
> a single this_cpu_ptr(&softnet_data) call

Double check the generated assembly first :)

this_cpu_read() is faster than going through
this_cpu_ptr(&softnet_data), at least on x86,
thanks to %gs: prefix.

No temporary register is needed to compute and hold this_cpu_ptr(&softnet_d=
ata).

