Return-Path: <netdev+bounces-195365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC3FACFED2
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 11:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051801781DE
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 09:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80032868BF;
	Fri,  6 Jun 2025 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a6d527mP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BEE2868AC
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749200814; cv=none; b=kWG0/T2hyO5z9F54IgdaSE8RBlQ0ClAig0Rj11vfCT6AuSrQLWpbPm/J/cs1G9QVCwA1pokIdOindOicq8uP7zXrLDU5v+XIimuf/Rg71/seQO+Uk9/YeimZ8wTOB7e8XPwFue3KsacXXL3d1m9Vh/0T44pOuE7DwOmHinpDWPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749200814; c=relaxed/simple;
	bh=5/GIpoiLEODukIITVP+GzuZ7UBw9dQMUpLlMC4ZVZgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jnk9Tg/dkYl025Ll8nM3h9jRcR+B0QIhicjSf8iy9abFZfPz39GwweT6hg1IqhvhZ8dlsvvCmnyvuamHRdjUKZEVu7eZIkVLHayNi7KLfKd/2koViqJsSDvPtO+fcV9CWOfO5g4fwJyWyzjGxWncrrnk3PWV+2Ed6NSo3ldMGJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a6d527mP; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a5851764e1so34882671cf.2
        for <netdev@vger.kernel.org>; Fri, 06 Jun 2025 02:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749200811; x=1749805611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Juf4jrcJwc7M/PUKZ2NRoIutSSX565sEIodIwjaKUU=;
        b=a6d527mPd2UXAQPj6c4VhymXW98cuRZFGAfDCHRAiQp/Sok+UmsLfWyAS8qfDu0ODO
         X+onWR1KvQ5fb2p+RseoMpn9zHRNLAs5uGYrSAMRt2SmGr5BoNsCM+qCnRchNEROhLxG
         ecxQnrPp1kVf6uMko4QFgBon75dQGGVLuzQWVC1WHtwN7+29AtDz/1//Urf22sIgXjiZ
         d9Ia4L7H/fnvQnssM5tvNsQcV/ef7LQ7GChD41fzZ0301ZuuJsv2tlYF6LQByBvEpKwD
         zziFo4aEwtnGMwjndqgzlGOldivb5cUJwbkSz5Sh3G187Ur/hBkBM1d5HA3MxcPuBAkA
         xMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749200812; x=1749805612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Juf4jrcJwc7M/PUKZ2NRoIutSSX565sEIodIwjaKUU=;
        b=KQFc8NgoiTi8iTwmW5Acnjb++JKSwkHtJ2gahYNCqVf1A7cAvyBklRo8bl9dJx2Rk1
         RuENbVQfag15ILlA3Fg94loFVTSql3sxJoKJM2dJzHUM/awhlgyo1oLjFHdUZSPyhFLI
         qH+FNLXHnJXtqV29F32xdK2svur+gcRZ4qHbzGH7IK+0oKOLxKVoNiHzlUF5VjOUFqjv
         d0kHpOqncZDYm2gNmCaa2xCTV9uvu5gdfirXUauCjJ53zOrRDEJvzi3NdX6mXOR5raZn
         ZHdeMZhBccC5j/56/MTfcX4YBLKllqEyaiD/kC2OnLN67YdEOkig4YeBVS4utv/g9Ict
         sOtA==
X-Forwarded-Encrypted: i=1; AJvYcCUMjctyG79Q+VRVrC7K86P9gNts/Jdl/r+VZAN90ENsaLMfzzPwnciuJW4hG+peWDwWhSU5trg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0KDaKTaJF3rSyHn/63YCzMxgWuQoOnssReX4V2GXxdHXfWWwF
	0PEcTmwwrJIGbql6KHEIbqmqbgjvADTyq3+73dkyrY2gAoMUtW8NjTCEhiALH+5DgqNtvfHQw3V
	w62IVegAyHxkgvsEjrHv8exS66xEVepyglSMgWCq5
X-Gm-Gg: ASbGnctWp8cAdBCh5x24Y3nt7A+duZ1U3xcjTSZ8shFllHy0Nd/6Pf7e8uk1QDfTYOh
	PZrECMDUAqmmLocmsZMg/NFe5sWrTVP2X/mPJLLhlxR/acXQ6akoapdSxgq1mlbJHjPEyVDmRqz
	CVmNx88jxY8zH8gkn9IP+Mdcr/BKGzLMvg0Svpwo/pI4jjx28569Uf2RGmKH+wrsN25XZGJMbWd
	zkr1w==
X-Google-Smtp-Source: AGHT+IHrlc9mecNqwz2N+nw+P4UYGvVjpnyOb92OYDI8uLthwW+8fWcUH8+t4NPziYSbwMH5pv1fl34SjJ41A6Aw6oE=
X-Received: by 2002:a05:622a:4a15:b0:4a4:3b41:916c with SMTP id
 d75a77b69052e-4a5b9a38b4bmr50944651cf.17.1749200811395; Fri, 06 Jun 2025
 02:06:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9da42688-bfaa-4364-8797-e9271f3bdaef@hetzner-cloud.de>
 <87zfemtbah.fsf@toke.dk> <CANn89i+7crgdpf-UXDpTNdWfei95+JHyMD_dBD8efTbLBnvZUQ@mail.gmail.com>
 <CANn89iKpZ5aLNpv66B9M4R1d_Pn5ZX=8-XaiyCLgKRy3marUtQ@mail.gmail.com> <5f19b555-b0fa-472a-a5f3-6673c0b69c5c@hetzner-cloud.de>
In-Reply-To: <5f19b555-b0fa-472a-a5f3-6673c0b69c5c@hetzner-cloud.de>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 6 Jun 2025 02:06:40 -0700
X-Gm-Features: AX0GCFuvatprhbrKC4R-61A0CpjrF1M_FzEpByoJmTe1A2qJ9Yyf7FigygmAcu0
Message-ID: <CANn89iJAR3HvWXNqNSR=y9qYm4W5sD40La+UpRraF4NE8yhfrA@mail.gmail.com>
Subject: Re: [BUG] veth: TX drops with NAPI enabled and crash in combination
 with qdisc
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 3:17=E2=80=AFPM Marcus Wichelmann
<marcus.wichelmann@hetzner-cloud.de> wrote:
>
> Am 06.06.25 um 00:11 schrieb Eric Dumazet:
> > On Thu, Jun 5, 2025 at 9:46=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >>
> >> On Thu, Jun 5, 2025 at 9:15=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
> >>>
> >>> Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de> writes:
> >>>
> >>>> Hi,
> >>>>
> >>>> while experimenting with XDP_REDIRECT from a veth-pair to another in=
terface, I
> >>>> noticed that the veth-pair looses lots of packets when multiple TCP =
streams go
> >>>> through it, resulting in stalling TCP connections and noticeable ins=
tabilities.
> >>>>
> >>>> This doesn't seem to be an issue with just XDP but rather occurs whe=
never the
> >>>> NAPI mode of the veth driver is active.
> >>>> I managed to reproduce the same behavior just by bringing the veth-p=
air into
> >>>> NAPI mode (see commit d3256efd8e8b ("veth: allow enabling NAPI even =
without
> >>>> XDP")) and running multiple TCP streams through it using a network n=
amespace.
> >>>>
> >>>> Here is how I reproduced it:
> >>>>
> >>>>   ip netns add lb
> >>>>   ip link add dev to-lb type veth peer name in-lb netns lb
> >>>>
> >>>>   # Enable NAPI
> >>>>   ethtool -K to-lb gro on
> >>>>   ethtool -K to-lb tso off
> >>>>   ip netns exec lb ethtool -K in-lb gro on
> >>>>   ip netns exec lb ethtool -K in-lb tso off
> >>>>
> >>>>   ip link set dev to-lb up
> >>>>   ip -netns lb link set dev in-lb up
> >>>>
> >>>> Then run a HTTP server inside the "lb" namespace that serves a large=
 file:
> >>>>
> >>>>   fallocate -l 10G testfiles/10GB.bin
> >>>>   caddy file-server --root testfiles/
> >>>>
> >>>> Download this file from within the root namespace multiple times in =
parallel:
> >>>>
> >>>>   curl http://[fe80::...%to-lb]/10GB.bin -o /dev/null
> >>>>
> >>>> In my tests, I ran four parallel curls at the same time and after ju=
st a few
> >>>> seconds, three of them stalled while the other one "won" over the fu=
ll bandwidth
> >>>> and completed the download.
> >>>>
> >>>> This is probably a result of the veth's ptr_ring running full, causi=
ng many
> >>>> packet drops on TX, and the TCP congestion control reacting to that.
> >>>>
> >>>> In this context, I also took notice of Jesper's patch which describe=
s a very
> >>>> similar issue and should help to resolve this:
> >>>>   commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_r=
ing to
> >>>>   reduce TX drops")
> >>>>
> >>>> But when repeating the above test with latest mainline, which includ=
es this
> >>>> patch, and enabling qdisc via
> >>>>   tc qdisc add dev in-lb root sfq perturb 10
> >>>> the Kernel crashed just after starting the second TCP stream (see ou=
tput below).
> >>>>
> >>>> So I have two questions:
> >>>> - Is my understanding of the described issue correct and is Jesper's=
 patch
> >>>>   sufficient to solve this?
> >>>
> >>> Hmm, yeah, this does sound likely.
> >>>
> >>>> - Is my qdisc configuration to make use of this patch correct and th=
e kernel
> >>>>   crash is likely a bug?
> >>>>
> >>>> ------------[ cut here ]------------
> >>>> UBSAN: array-index-out-of-bounds in net/sched/sch_sfq.c:203:12
> >>>> index 65535 is out of range for type 'sfq_head [128]'
> >>>
> >>> This (the 'index 65535') kinda screams "integer underflow". So certai=
nly
> >>> looks like a kernel bug, yeah. Don't see any obvious reason why Jespe=
r's
> >>> patch would trigger this; maybe Eric has an idea?
> >>>
> >>> Does this happen with other qdiscs as well, or is it specific to sfq?
> >>
> >> This seems like a bug in sfq, we already had recent fixes in it, and
> >> other fixes in net/sched vs qdisc_tree_reduce_backlog()
> >>
> >> It is possible qdisc_pkt_len() could be wrong in this use case (TSO of=
f ?)
> >
> > This seems to be a very old bug, indeed caused by sch->gso_skb
> > contribution to sch->q.qlen
> >
> > diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
> > index b912ad99aa15d95b297fb28d0fd0baa9c21ab5cd..77fa02f2bfcd56a36815199=
aa2e7987943ea226f
> > 100644
> > --- a/net/sched/sch_sfq.c
> > +++ b/net/sched/sch_sfq.c
> > @@ -310,7 +310,10 @@ static unsigned int sfq_drop(struct Qdisc *sch,
> > struct sk_buff **to_free)
> >                 /* It is difficult to believe, but ALL THE SLOTS HAVE
> > LENGTH 1. */
> >                 x =3D q->tail->next;
> >                 slot =3D &q->slots[x];
> > -               q->tail->next =3D slot->next;
> > +               if (slot->next =3D=3D x)
> > +                       q->tail =3D NULL; /* no more active slots */
> > +               else
> > +                       q->tail->next =3D slot->next;
> >                 q->ht[slot->hash] =3D SFQ_EMPTY_SLOT;
> >                 goto drop;
> >         }
> >
>
> Hi,
>
> thank you for looking into it.
> I'll give your patch a try and will also do tests with other qdiscs as we=
ll when I'm back
> in office.
>

I have been using this repro :

ip netns add lb

ip link add dev to-lb type veth peer name in-lb netns lb

# force qdisc to requeue gso_skb
ethtool -K to-lb tso off

# Enable NAPI
ip netns exec lb ethtool -K in-lb gro on

ip link set dev to-lb up
ip -netns lb link set dev in-lb up

ip addr add dev to-lb 192.168.20.1/24
ip -netns lb addr add dev in-lb 192.168.20.2/24

tc qdisc replace dev to-lb root sfq limit 100

ip netns exec lb netserver

netperf -H 192.168.20.2 -l 100 &
netperf -H 192.168.20.2 -l 100 &
netperf -H 192.168.20.2 -l 100 &
netperf -H 192.168.20.2 -l 100 &

