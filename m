Return-Path: <netdev+bounces-141632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7C39BBD5F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 19:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF6C1F22A40
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565191CB9EB;
	Mon,  4 Nov 2024 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="D1NyTxD+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E091CF8B
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745736; cv=none; b=u7BqijlaVHw8cJuzjdj0XBcUr8jjpYmOL8MbsA8wOz/y/Eb0LzHIv/MulrXg9ebapILn2UrxNU/vY+px6W2bGbOljc9BA8TkB+az1GUPmpDlFVLjukAEHKhiGxkMXKsVVGf6eHBJJAtpB7ypg2vfaACq7xPXYabr6yS+KaRVjZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745736; c=relaxed/simple;
	bh=r6ujx4ECoO9nHmJq2WUNuPD/e2iQp28jRgzZMD9FidY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rg2tvPC9vw/r7WEBiqPcQmszzjf9jwtlAhJDy3hoMsRUiQ/KA9EIbbnYhcwdc0LWtwvH0mKX3LMk9z+ISDAeCXD+dwQH8gWkT5uzPhVG91TxXfmTPSWNC12PvZ9qgpZz2kfwRHEpxLKQpAQtzR21iB5yV0bIr4GcuQfkxHGvz+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=D1NyTxD+; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2b720a0bbso782079a91.1
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 10:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730745733; x=1731350533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6ujx4ECoO9nHmJq2WUNuPD/e2iQp28jRgzZMD9FidY=;
        b=D1NyTxD+l3UCgUjLCAAtN88wD/6qkKlmfnvtBk9YirkNC/B4I8rGo5bMbbahTCtXGH
         3pKpKY7LWDHV39i5zoEiWu/Hz3GNnO5Pq686gC9IRmqpvPe9HEb+odVGHkFmpFwNp2AU
         tdTjJFbw/oiWk5AGARS8AsuLqIP5/mmmLZzPpYEmfGSEOYqRt7oGbfMY6zsqhbEcNdaM
         SapGsGKFRNy6R7OcGncdtmWrsgczD8hMMm1eKEdhU2JgwNAm/0BHD/4X4HQTR1G0I7Dj
         Pyb1rkV7+TXhKX9yyk15G401PBme7OtLkLKhioHPS+zrbXD1RhP1eayeIZB11AmFFqzY
         TW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730745733; x=1731350533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6ujx4ECoO9nHmJq2WUNuPD/e2iQp28jRgzZMD9FidY=;
        b=wIzLKSPYcr0Q7oea+orYpi+9CcnVyvYE1t8SlRewhwYQSoVX02lfCobrcz5oElj461
         JtZcy5IA1IdfCITP4y4lynFD6ZbXJKSJYM4HMrmj1otYQxo+fwmA75mfmu7jGnOE7h3E
         qLoMtmhv8m9AxOTN7g2ikTMG/VxLKuT4iTfF2zQv7x2agYQi7uxZ3xOV4itpLCqz8rXO
         0jDNHi8wSrJXZKWWwu+JDMQ4EnSUlFnUJ3LimwSrjKi1H1JK9oOKwJEQBRpcP4+qTprG
         pAg1eh1yNKpezok3Dy+3SeQz8AKNdnn9JCX03kkF07tXj3Kytc2TYv9pjWgSyCPPzo0V
         wI8w==
X-Forwarded-Encrypted: i=1; AJvYcCWBDLZ0BVmfLjH5EkKdLUS1I0tyYDQpxmj942cEzLXJL3MOY+euHQpp4x8ScQSIU7jcCwUzmos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYvAUp3Jr1U9wmr/IU9Tfl/UbTZ61XApN0npeYf5B5prtdCq/L
	uv3YB2SMkVgIgMD6aGWJVhN/KYkXWp+6ZgBpBLAJjIcgF1WoTdB4FjLa7GRQkPD1zEtpiAPabIq
	Y0V0BDDAaI1sinKJ0Fp0pPnPt4qltWpfAKRKMMw==
X-Google-Smtp-Source: AGHT+IHRyp0fZGEkveVbZD/Ka4YhG44ViKMpXPhdBhrYj8X+Sc3biYODwWZrL603VjG0+1/9CnT9o46uFffC49ziBwI=
X-Received: by 2002:a17:90a:c90b:b0:2e2:e929:e8d2 with SMTP id
 98e67ed59e1d1-2e8f10a42e7mr16137187a91.4.1730745732870; Mon, 04 Nov 2024
 10:42:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029182703.2698171-1-csander@purestorage.com>
 <CANn89iLx-4dTB9fFgfrsXQ8oA0Z+TpBWNk4b91PPS1o=oypuBQ@mail.gmail.com>
 <CADUfDZrSUNu7nym9dC1_yFUqhC8tUPYjv-ZKHofU9Q8Uv4Jvhw@mail.gmail.com>
 <CANn89iKQ3g2+nSWaV3BWarpbneRCSoGSXdGP90PF7ScDu4ULEQ@mail.gmail.com> <CADUfDZpeudTGP5UZt6QqbrYkA+Twei7gGQa6hJ+iYwuZfyp9gw@mail.gmail.com>
In-Reply-To: <CADUfDZpeudTGP5UZt6QqbrYkA+Twei7gGQa6hJ+iYwuZfyp9gw@mail.gmail.com>
From: Caleb Sander <csander@purestorage.com>
Date: Mon, 4 Nov 2024 10:42:01 -0800
Message-ID: <CADUfDZqcd_2+409_4GGhbRwW8gYHtZSU1vE1eNuE=jycoNMMJA@mail.gmail.com>
Subject: Re: [PATCH] net: skip RPS if packet is already on target CPU
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 1:26=E2=80=AFPM Caleb Sander <csander@purestorage.c=
om> wrote:
>
> On Wed, Oct 30, 2024 at 5:55=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Tue, Oct 29, 2024 at 9:38=E2=80=AFPM Caleb Sander <csander@purestora=
ge.com> wrote:
> > >
> > > On Tue, Oct 29, 2024 at 12:02=E2=80=AFPM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > >
> > > > On Tue, Oct 29, 2024 at 7:27=E2=80=AFPM Caleb Sander Mateos
> > > > <csander@purestorage.com> wrote:
> > > > >
> > > > > If RPS is enabled, all packets with a CPU flow hint are enqueued =
to the
> > > > > target CPU's input_pkt_queue and process_backlog() is scheduled o=
n that
> > > > > CPU to dequeue and process the packets. If ARFS has already steer=
ed the
> > > > > packets to the correct CPU, this additional queuing is unnecessar=
y and
> > > > > the spinlocks involved incur significant CPU overhead.
> > > > >
> > > > > In netif_receive_skb_internal() and netif_receive_skb_list_intern=
al(),
> > > > > check if the CPU flow hint get_rps_cpu() returns is the current C=
PU. If
> > > > > so, bypass input_pkt_queue and immediately process the packet(s) =
on the
> > > > > current CPU.
> > > > >
> > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > >
> > > > Current implementation was a conscious choice. This has been discus=
sed
> > > > several times.
> > > >
> > > > By processing packets inline, you are actually increasing latencies=
 of
> > > > packets queued to other cpus.
> > >
> > > Sorry, I wasn't aware of these prior discussions. I take it you are
> > > referring to threads like
> > > https://lore.kernel.org/netdev/20230322072142.32751-1-xu.xin16@zte.co=
m.cn/T/
> > > ? I see what you mean about the latency penalty for packets that do
> > > require cross-CPU steering.
> > >
> > > Do you have an alternate suggestion for how to avoid the overhead of
> > > acquiring a spinlock for every packet? The atomic instruction in
> > > rps_lock_irq_disable() called from process_backlog() is consuming 5%
> > > of our CPU time. For our use case, we don't really want software RPS;
> > > we are expecting ARFS to steer all high-bandwidth traffic to the
> > > desired CPUs. We would happily turn off software RPS entirely if we
> > > could, which seems like it would avoid the concerns about higher
> > > latency for packets that need to be steering to a different CPU. But
> > > my understanding is that using ARFS requires RPS to be enabled
> > > (rps_sock_flow_entries set globally and rps_flow_cnt set on each
> > > queue), which enables these rps_needed static branches. Is that
> > > correct? If so, would you be open to adding a sysctl that disables
> > > software RPS and relies upon ARFS to do the packet steering?
> >
> > A sysctl will not avoid the fundamental issue.
>
> Sorry if my suggestion was unclear. I mean that we would ideally like
> to use only hardware ARFS for packet steering, and disable software
> RPS.
> In our testing, ARFS reliably steers packets to the desired CPUs. (Our
> application has long-lived TCP sockets, each processed on a single
> thread affinitized to one of the interrupt CPUs for the Ethernet
> device.) In the off chance that ARFS doesn't steer the packet to the
> correct CPU, we would rather just process it on the CPU that receives
> it instead of going through the RPS queues. If software RPS is never
> used, then there wouldn't be any concerns about higher latency for
> RPS-steered vs. non-RPS-steered packets, right? The get_rps_cpu()
> computation is also not cheap, so it would be nice to skip it too.
> Basically, we want to program ARFS but skip these
> static_branch_unlikely(&rps_needed) branches. But I'm not aware of a
> way to do that currently. (Please let me know if it's already possible
> to do that.)

I see now that get_rps_cpu() still needs to be called even if software
RPS isn't going to be used, because it's also responsible for calling
set_rps_cpu() to program ARFS. So looks like avoiding the calls to
get_rps_cpu() entirely is not possible.

> > Why not instead address the past feedback ?
> > Can you test the following ?
>
> Sure, I will test the performance on our setup with this patch. Still,
> we would prefer to skip the get_rps_cpu() computation and these extra
> checks, and just process the packets on the CPUs they arrive on.

Hi Eric,
I tried out your patch and it seems to work equally well at
eliminating the process_backlog() -> _raw_spin_lock_irq() hotspot. The
added checks contribute a bit of overhead in
netif_receive_skb_list_internal(): it has increased from 0.15% to
0.28% of CPU time. But that's definitely worth it to remove the 5%
hotspot acquiring the RPS spinlock.

Feel free to add:
Tested-by: Caleb Sander Mateos <csander@purestorage.com>

Some minor comments on the patch:
- Probably should be using either skb_queue_len_lockless() or
skb_queue_empty_lockless() to check input_pkt_queue.qlen !=3D 0 because
the RPS lock is not held at this point
- Could consolidate the 2 this_cpu_read(softnet_data...) lookups into
a single this_cpu_ptr(&softnet_data) call

Thanks,
Caleb

