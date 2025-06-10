Return-Path: <netdev+bounces-196148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B7EAD3BA2
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2E01886F31
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5467202F93;
	Tue, 10 Jun 2025 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wt9WAt1Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D351EE7D5
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566978; cv=none; b=nFJPHdLZfCe9kzvZ5OBZ01dzz66+Xk3Z661Em4g2OD1IMo+9bOXVoxGTK6FZdz3a6M7wPw9sjJXyabbD0AJ+nXl2VYLF6bBzgU44zD0mkK6P6+BLm20ZhW8tpR7WcQ6u5FCHGj6Q4+qI4bdKiHSnz01pDzBn9CRpXFTUksNdP1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566978; c=relaxed/simple;
	bh=IWRUrEd7brUxEQ1vU5PPByxfISsVCWANzqeHUhsa5EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEAVkyVsWWXfVLDxGHd9xCCC9zNMI4dFsBk8xyEgejS6W0I0LXb1NnYqffaCtdxX+2/uqZYc/STLB3IfeIT1F9m4ukmnPglP4NBd6jQBH112uTAJZjrb30SQSzXel93Ayg8/J9upSzuHpY7oWEtpC7kNIdPr49aU6AnziS3977c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wt9WAt1Y; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a5ae2fdf4eso61205981cf.0
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749566976; x=1750171776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z15tMFb2reZO+eqtRhpVQfHqAPcEFXwc1PjRxRnjSKw=;
        b=wt9WAt1Y6fc8RmPRkhkelTg+oyzRE0B7IXiPjQdjNQJNRfVr8e832ui9i8rc9BkHGQ
         57YR9n06KLMxv7WkhqPeZfu7MRk8eH1TDQ8eRQhsnarB+5FQBlyW2UXaNRQ/lXHDVMZU
         NpuoTjLb0k868r7AE9RVHdiaDrf7t6BgLJOkKD12nUNzmZ4bFZBb1zp1X/WHb71XjhXD
         bxbvjriRlHT1GadeX22pnsQEy3gBAcRBqGLp6Dk2DY+jUjFi2b2HNBWxW8ghvzDibYje
         F+/y/tRlQgO7a17prgMFezKztYruoiQkTHMQQLzFalh0LqNhgD/ttYhgZNg7icZawJwa
         qGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749566976; x=1750171776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z15tMFb2reZO+eqtRhpVQfHqAPcEFXwc1PjRxRnjSKw=;
        b=ATBAqC9yS7VjJ1VKtZjoh0BCkJ1Yn2B4zEgOWMfrOHH7xe1kuC3oLr3QkFnFlS/hhr
         4iAJw7O7IRQy6PiL7Xf2Xukdj3QmiweXuBeq7RXpAkgPk3rQhgNZ7ZFuy0ucTy7fBm5P
         syxXIm4VZd/Nr/Pw8pMVTYrom0UHAc5yHOFvGn5uAk90gMyKp6TL/Ni2Dd7BPYT4SHYB
         tnqw4wIgLvp/0fgrzA2BtiWD6zMvh39OpK0QMhzUdrkavhPUmE92yJJV9ttlRvuJSR49
         KdXpqLTVMkYmIQcXZM2Bknr+LJQCUW6Q9o6boZ6nFthlBat5BxiwdqkIhsBxAr/yzv8f
         WmBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj10os4mjwc3+7Q/OdhW5SyiDye1sKQ5ePB4TxFuLnCXV4ZZX8oW426akb40B52op+RLnOFdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz83uhrZQ5F0wzA1npjWVspsMeIomdzpGBqr1//pqUKDG7EUSTo
	KJ7a2aAWDOvH+NOVrh4CVYW2vRC1GCsusXkU3LR+x/cPow3Mi03TX5cGVdSc7eZpWCfCRNSG04j
	bPNfix2riK5626LrEtvZxEEU0mEVRogeLj+buv199vDMvDPwB3wdI5nGF
X-Gm-Gg: ASbGncsywkcHjhpqe440K60Zu/747+Dk0YXI8BwFKifNtdXJxzNIgQDf8zUDiFQ7g/w
	6nmYAYWEE+czyNciVvL0gl1UE+FKHgSVoMP/Vg4WrVxBeqCe/M89N9bGfDXqpHkulj4ip0Nhf11
	peEaCXRBeQSxF1pn48Xm7yL4tYYyYjMXiEtcOKICi7odo=
X-Google-Smtp-Source: AGHT+IE7AxlYGiV8s47P7BrFuP3emvjItDe1dAR8WPAPSqot9vEQvUGV4Rp4OaweBpSE3WeuZGT2Lp8Eh+bOQUxn9C8=
X-Received: by 2002:a05:622a:1bac:b0:4a6:f098:f7ab with SMTP id
 d75a77b69052e-4a708cc2becmr58479461cf.4.1749566975456; Tue, 10 Jun 2025
 07:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9da42688-bfaa-4364-8797-e9271f3bdaef@hetzner-cloud.de>
 <87zfemtbah.fsf@toke.dk> <CANn89i+7crgdpf-UXDpTNdWfei95+JHyMD_dBD8efTbLBnvZUQ@mail.gmail.com>
 <CANn89iKpZ5aLNpv66B9M4R1d_Pn5ZX=8-XaiyCLgKRy3marUtQ@mail.gmail.com>
 <5f19b555-b0fa-472a-a5f3-6673c0b69c5c@hetzner-cloud.de> <CANn89iJAR3HvWXNqNSR=y9qYm4W5sD40La+UpRraF4NE8yhfrA@mail.gmail.com>
 <3d520952-c343-4ae5-98c0-c9965dc7e320@hetzner-cloud.de>
In-Reply-To: <3d520952-c343-4ae5-98c0-c9965dc7e320@hetzner-cloud.de>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Jun 2025 07:49:24 -0700
X-Gm-Features: AX0GCFuHGqfCvhwHrIwtC1IRpeotqI5rTZBKXFx--OR6eLkehVlSIUCxLpuqrnY
Message-ID: <CANn89iKFm1ER904sUUh5v_e29QvkFAZXe4yOJfeoo9VLx616iA@mail.gmail.com>
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

On Tue, Jun 10, 2025 at 7:41=E2=80=AFAM Marcus Wichelmann
<marcus.wichelmann@hetzner-cloud.de> wrote:
>
> Am 06.06.25 um 11:06 schrieb Eric Dumazet:
> > On Thu, Jun 5, 2025 at 3:17=E2=80=AFPM Marcus Wichelmann
> > <marcus.wichelmann@hetzner-cloud.de> wrote:
> >>
> >> Am 06.06.25 um 00:11 schrieb Eric Dumazet:
> >>> On Thu, Jun 5, 2025 at 9:46=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> >>>>
> >>>> On Thu, Jun 5, 2025 at 9:15=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgen=
sen <toke@redhat.com> wrote:
> >>>>>
> >>>>> Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de> writes:
> >>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> while experimenting with XDP_REDIRECT from a veth-pair to another =
interface, I
> >>>>>> noticed that the veth-pair looses lots of packets when multiple TC=
P streams go
> >>>>>> through it, resulting in stalling TCP connections and noticeable i=
nstabilities.
> >>>>>>
> >>>>>> This doesn't seem to be an issue with just XDP but rather occurs w=
henever the
> >>>>>> NAPI mode of the veth driver is active.
> >>>>>> I managed to reproduce the same behavior just by bringing the veth=
-pair into
> >>>>>> NAPI mode (see commit d3256efd8e8b ("veth: allow enabling NAPI eve=
n without
> >>>>>> XDP")) and running multiple TCP streams through it using a network=
 namespace.
> >>>>>>
> >>>>>> Here is how I reproduced it:
> >>>>>>
> >>>>>>   ip netns add lb
> >>>>>>   ip link add dev to-lb type veth peer name in-lb netns lb
> >>>>>>
> >>>>>>   # Enable NAPI
> >>>>>>   ethtool -K to-lb gro on
> >>>>>>   ethtool -K to-lb tso off
> >>>>>>   ip netns exec lb ethtool -K in-lb gro on
> >>>>>>   ip netns exec lb ethtool -K in-lb tso off
> >>>>>>
> >>>>>>   ip link set dev to-lb up
> >>>>>>   ip -netns lb link set dev in-lb up
> >>>>>>
> >>>>>> Then run a HTTP server inside the "lb" namespace that serves a lar=
ge file:
> >>>>>>
> >>>>>>   fallocate -l 10G testfiles/10GB.bin
> >>>>>>   caddy file-server --root testfiles/
> >>>>>>
> >>>>>> Download this file from within the root namespace multiple times i=
n parallel:
> >>>>>>
> >>>>>>   curl http://[fe80::...%to-lb]/10GB.bin -o /dev/null
> >>>>>>
> >>>>>> In my tests, I ran four parallel curls at the same time and after =
just a few
> >>>>>> seconds, three of them stalled while the other one "won" over the =
full bandwidth
> >>>>>> and completed the download.
> >>>>>>
> >>>>>> This is probably a result of the veth's ptr_ring running full, cau=
sing many
> >>>>>> packet drops on TX, and the TCP congestion control reacting to tha=
t.
> >>>>>>
> >>>>>> In this context, I also took notice of Jesper's patch which descri=
bes a very
> >>>>>> similar issue and should help to resolve this:
> >>>>>>   commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr=
_ring to
> >>>>>>   reduce TX drops")
> >>>>>>
> >>>>>> But when repeating the above test with latest mainline, which incl=
udes this
> >>>>>> patch, and enabling qdisc via
> >>>>>>   tc qdisc add dev in-lb root sfq perturb 10
> >>>>>> the Kernel crashed just after starting the second TCP stream (see =
output below).
> >>>>>>
> >>>>>> So I have two questions:
> >>>>>> - Is my understanding of the described issue correct and is Jesper=
's patch
> >>>>>>   sufficient to solve this?
> >>>>>
> >>>>> Hmm, yeah, this does sound likely.
> >>>>>
> >>>>>> - Is my qdisc configuration to make use of this patch correct and =
the kernel
> >>>>>>   crash is likely a bug?
> >>>>>>
> >>>>>> ------------[ cut here ]------------
> >>>>>> UBSAN: array-index-out-of-bounds in net/sched/sch_sfq.c:203:12
> >>>>>> index 65535 is out of range for type 'sfq_head [128]'
> >>>>>
> >>>>> This (the 'index 65535') kinda screams "integer underflow". So cert=
ainly
> >>>>> looks like a kernel bug, yeah. Don't see any obvious reason why Jes=
per's
> >>>>> patch would trigger this; maybe Eric has an idea?
> >>>>>
> >>>>> Does this happen with other qdiscs as well, or is it specific to sf=
q?
> >>>>
> >>>> This seems like a bug in sfq, we already had recent fixes in it, and
> >>>> other fixes in net/sched vs qdisc_tree_reduce_backlog()
> >>>>
> >>>> It is possible qdisc_pkt_len() could be wrong in this use case (TSO =
off ?)
> >>>
> >>> This seems to be a very old bug, indeed caused by sch->gso_skb
> >>> contribution to sch->q.qlen
> >>>
> >>> diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
> >>> index b912ad99aa15d95b297fb28d0fd0baa9c21ab5cd..77fa02f2bfcd56a368151=
99aa2e7987943ea226f
> >>> 100644
> >>> --- a/net/sched/sch_sfq.c
> >>> +++ b/net/sched/sch_sfq.c
> >>> @@ -310,7 +310,10 @@ static unsigned int sfq_drop(struct Qdisc *sch,
> >>> struct sk_buff **to_free)
> >>>                 /* It is difficult to believe, but ALL THE SLOTS HAVE
> >>> LENGTH 1. */
> >>>                 x =3D q->tail->next;
> >>>                 slot =3D &q->slots[x];
> >>> -               q->tail->next =3D slot->next;
> >>> +               if (slot->next =3D=3D x)
> >>> +                       q->tail =3D NULL; /* no more active slots */
> >>> +               else
> >>> +                       q->tail->next =3D slot->next;
> >>>                 q->ht[slot->hash] =3D SFQ_EMPTY_SLOT;
> >>>                 goto drop;
> >>>         }
> >>>
> >>
> >> Hi,
> >>
> >> thank you for looking into it.
> >> I'll give your patch a try and will also do tests with other qdiscs as=
 well when I'm back
> >> in office.
> >>
> >
> > I have been using this repro :
> >
> > [...]
>
> Hi,
>
> I can confirm that the sfq qdisc is now stable in this setup, thanks to y=
our fix.
>
> I also experimented with other qdiscs and fq_codel works as well.
>
> The sfq/fq_codel qdisc works hand-in-hand now with Jesper's patch to reso=
lve the original
> issue. Multiple TCP connections run very stable, even when NAPI/XDP is ac=
tive on the veth
> device, and I can see that the packets are being requeued instead of bein=
g dropped in the
> veth driver.
>
> Thank you for your help!

Well, thanks to you for providing a very clean report, including repro
instructions !

