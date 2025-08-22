Return-Path: <netdev+bounces-216019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F9FB31900
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93EB0563C28
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 13:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FAE2FC03E;
	Fri, 22 Aug 2025 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VV4H3Z/w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3B12EDD66
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868244; cv=none; b=UanTbvmYP0j+2R0I2PYw2hpoYRklzI+9NwIQbTUd7rYP9PZeo/a9q0PGDczD2DT5OO2QR9yNUysJJE0K1wTMI3cHC4MDkTs4ivWIDQh/qixKbXtgT66QKY//PZ4UtzE6aUgbVJo3uG4Q6529oocbuXnmYuDQIaCFeCQ5F/iGvbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868244; c=relaxed/simple;
	bh=MSyTaEZJmjXFTo13z8H5zsonFqyt6Okx8f0zNJmvbOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n401RlP83AoIHvfYFEnuny9gSsVZVBIJIEEhXulc6d91tA9O6b/OyFdQ3CJmwnTDVF050v6Y3bGdJkP94CpFe9KxZTF01EFf067CPyiSudkJBp4TRKWgmzYqPvRsyZrep4ff950XHvP8FZqTlNMyYK2rfYRv4bRhuJY4PHh7BIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VV4H3Z/w; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b0faa6601cso39539601cf.1
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755868242; x=1756473042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N57JTsqxdhsLazPWHoDT0EjdNXy3KAszydZnqiovi1g=;
        b=VV4H3Z/wXApGNQmIqQa1A3pmwNdJV0cQLhgRjoQOJxp7doDpfOwHvLouJJS1BTRLv2
         NHcrxC2fOy+paBiM0/8XPj0HCqK8LPzsWs/Vgcld/iTyvxnmvvo1OTRtxtIp1OwQjLhC
         Sqr3PncpzgtKKUqRA7NmwAKPYXgoCRv1g17YS40yvwVW1dbSo9h5U1EMiG3aRloKrcsE
         jZSxhA9Gjep9ZVBmskmssrPzIcyoRr3k4ebgnbQo47imzOl5nybc1wIyLBid50KFCRlU
         3YonSpRRF15PQclLa36fdIYgN4Jj/dkDr3UfsFAF5hI+umOF2VIZvAdA6glcd21iGvSr
         3MRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755868242; x=1756473042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N57JTsqxdhsLazPWHoDT0EjdNXy3KAszydZnqiovi1g=;
        b=GI/uhIjbk7ri6+EU0s9EGx6O9GKDI1HW6dUfWp0KmUEF0OV3RtKMy7sce46oT9wZhJ
         vtCVWYnboGWWVC3nSK6tYk71P/mQyglaZtLj1raCEIrARpyBZW52LfViV+zoY8GOZUWO
         ztRmxeFP28CDdiKS0Hempqp7YinVSgSLJ52WLUXsReRjAoB8m2xxelF1zxjO9055mPQq
         /o9bvdRbhhO4M3wZzqLIHR4r2g1oL3WSV8sCG/Cv9nGiLssFyjuqNnGu4z9PKBur0Isg
         WfHpkBT0ecoaPbtk4uW9VS+W/buX7GQHHcGjSH1TEcYwqnArHbe2CHCcR/0a3NyFBsyo
         4GmA==
X-Gm-Message-State: AOJu0Yw2JfLf0uDutrftcRmn5MnRDt/ZkA/M1a00bZYxgsQUpCqAGaIa
	HSRHxli4j/YMC1lri9QHmhxtg5/GiuYWdNF4TuQONv3yAtcFRiFTAzXuS6YxH1ra6D9Hj2fQRMb
	xy3KdUfcpl9VCZ4SJ/Sn9GPSuG1NyebrZcOhoGyKM
X-Gm-Gg: ASbGncsqdt+AvNo1JMQu521epBEoOnmEcII3u2Buu5tsYUOf6D4fromI8QGvVzOJ8S3
	OzMPqKmeckUfwEdmsE5eo16CnVi4uVBEX7zar6PtUPne+IBzHB1PecKHBEOomXdDsup58LQ1BCF
	izPRGeR77RJohHr940Lztsywv2XJmp9NX5GvNJgzq+aZz4lnEeE/9WAfq13dAUzDxGCb1dOMq+S
	ZtFqNB2ju4/xdmvh4ncwLIrdw==
X-Google-Smtp-Source: AGHT+IFFfO9FAwB0bxBIAymSm2iH/ik4U523UowUTRHNYsIQTgXcMa6Murg0Cl9LRBDgp0xji4p4CcpYi6Kc9ZrNx0w=
X-Received: by 2002:a05:622a:17c7:b0:4b2:8ac5:2597 with SMTP id
 d75a77b69052e-4b2aafa126fmr30288821cf.42.1755868240939; Fri, 22 Aug 2025
 06:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKgnLcw6yzq78CIP@bzorp3> <CANn89iLy4znFBLK2bENWMfhPyjTc_gkLRswAf92uV7KY3bTdYg@mail.gmail.com>
 <aKg1Qgtw-QyE8bLx@bzorp3> <CANn89i+GMqF91FkjxfGp3KGJ-dC6-Snu3DoBdGuxZqrq=iOOcQ@mail.gmail.com>
 <aKho5v5VwxdNstYy@bzorp3>
In-Reply-To: <aKho5v5VwxdNstYy@bzorp3>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 Aug 2025 06:10:28 -0700
X-Gm-Features: Ac12FXyy7u6tVu7Pv87kjRB3iHWipFVZ6CUOjrpapoptaAhIe54P4_OqLIKwc8k
Message-ID: <CANn89i+S1hyPbo5io2khLk_UTfoQgEtnjYUUJTzreYufmbii+A@mail.gmail.com>
Subject: Re: [RFC, RESEND] UDP receive path batching improvement
To: Balazs Scheidler <bazsi77@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 5:56=E2=80=AFAM Balazs Scheidler <bazsi77@gmail.com=
> wrote:
>
> On Fri, Aug 22, 2025 at 02:37:28AM -0700, Eric Dumazet wrote:
> > On Fri, Aug 22, 2025 at 2:15=E2=80=AFAM Balazs Scheidler <bazsi77@gmail=
.com> wrote:
> > >
> > > On Fri, Aug 22, 2025 at 01:18:36AM -0700, Eric Dumazet wrote:
> > > > On Fri, Aug 22, 2025 at 1:15=E2=80=AFAM Balazs Scheidler <bazsi77@g=
mail.com> wrote:
> > > > > The condition above uses "sk->sk_rcvbuf >> 2" as a trigger when t=
he update is
> > > > > done to the counter.
> > > > >
> > > > > In our case (syslog receive path via udp), socket buffers are gen=
erally
> > > > > tuned up (in the order of 32MB or even more, I have seen 256MB as=
 well), as
> > > > > the senders can generate spikes in their traffic and a lot of sen=
ders send
> > > > > to the same port. Due to latencies, sometimes these buffers take =
MBs of data
> > > > > before the user-space process even has a chance to consume them.
> > > > >
> > > >
> > > >
> > > > This seems very high usage for a single UDP socket.
> > > >
> > > > Have you tried SO_REUSEPORT to spread incoming packets to more sock=
ets
> > > > (and possibly more threads) ?
> > >
> > > Yes.  I use SO_REUSEPORT (16 sockets), I even use eBPF to distribute =
the
> > > load over multiple sockets evenly, instead of the normal load balanci=
ng
> > > algorithm built into SO_REUSEPORT.
> > >
> >
> > Great. But if you have many receive queues, are you sure this choice do=
es not
> > add false sharing ?
>
> I am not sure how that could trigger false sharing here.  I am using a
> "socket" filter, which generates a random number modulo the number of
> sockets:
>
> ```
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
>
> int number_of_sockets;
>
> SEC("socket")
> int random_choice(struct __sk_buff *skb)
> {
>   if (number_of_sockets =3D=3D 0)
>     return -1;
>
>   return bpf_get_prandom_u32() % number_of_sockets;
> }
> ```

How many receive queues does your NIC have (ethtool -l eth0) ?

This filter causes huge contention on the receive queues and various
socket fields, accessed by different cpus.

You should instead perform a choice based on the napi_id (skb->napi_id)


>
> Last I've checked the code, all it did was putting the incoming packet in=
to
> the right socket buffer, as returned by the filter. What would be the fal=
se
> sharing in this case?
>
> >
> > > Sometimes the processing on the userspace side is heavy enough (think=
 of
> > > parsing, heuristics, data normalization) and the load on the box heav=
y
> > > enough that I still see drops from time to time.
> > >
> > > If a client sends 100k messages in a tight loop for a while, that's g=
oing to
> > > use a lot of buffer space.  What bothers me further is that it could =
be ok
> > > to lose a single packet, but any time we drop one packet, we will con=
tinue
> > > to lose all of them, at least until we fetch 25% of SO_RCVBUF (or if =
the
> > > receive buffer is completely emptied).  This problem, combined with s=
mall
> > > packets (think of 100-150 byte payload) can easily cause excessive dr=
ops. 25%
> > > of the socket buffer is a huge offset.
> >
> > sock_writeable() uses a 50% threshold.
>
> I am not sure why this is relevant here, the write side of sockets can
> easily be flow controlled (e.g. the process waiting until it can send mor=
e
> data). Also my clients are not necessarily client boxes. PaloAlto firewal=
ls
> can generate 70k events-per-second in syslog alone. And that does leave t=
he
> firewall, and my challenge is to read all of that.
>
> >
> > >
> > > I am not sure how many packets warrants a sk_rmem_alloc update, but I=
'd
> > > assume that 1 update every 100 packets should still be OK.
> >
> > Maybe, but some UDP packets have a truesize around 128 KB or even more.
>
> I understand that the truesize incorporates struct sk_buff header and we =
may
> also see non-linear SKBs, which could inflate the number (saying this wit=
hout really
> understanding all the specifics there).
>
> >
> > Perhaps add a new UDP socket option to let the user decide on what
> > they feel is better for them ?
>
> I wanted to avoid a knob for this, but I can easily implement this way. S=
o
> should I create a patch for a setsockopt() that allows setting
> udp_sk->forward_threshold?
>
> >
> > I suspect that the main issue is about having a single drop in the firs=
t place,
> > because of false sharing on sk->sk_drops
> >
> > Perhaps we should move sk_drops on a dedicated cache line,
> > and perhaps have two counters for NUMA servers.
>
> I am looking into sk_drops, I don't know what it does at the moment, it's
> been a while I've last read this codebase :)
>

Can you post

ss -aum src :1000  <replace 1000 with your UDP source port>

We will check the dXXXX output (number of drops), per socket.

