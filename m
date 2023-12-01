Return-Path: <netdev+bounces-53006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EE58010EC
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893611C20931
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314114E1AD;
	Fri,  1 Dec 2023 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aOU8f3tT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B606AF3
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:16:36 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a00c200782dso328162966b.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 09:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701450992; x=1702055792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0G0zLpiMY0NX/D7v3CalbgrRtFBApRABzOVmVae/oU=;
        b=aOU8f3tTnYh4ZlT5c/yK+opbDgQAkckdn7+0JcBNOc+iYpx4QVuZtsY8nTwam8EtP3
         ViegAHePBwhUvsEe1/gq1hTtMP80u5ZEkfnCPcpCc4bonyHe9eTKKVubkRs7UBSDtp/j
         3K26m99O5RW4sijFNzLJvcRMTU59XJtxlXNqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701450992; x=1702055792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0G0zLpiMY0NX/D7v3CalbgrRtFBApRABzOVmVae/oU=;
        b=Lgo2DpA5FuL1HAqCkv5LTEfSH+ew9NJzs+Lpfi7gvikibsNFRLtsPhwfOVBrcG2HXR
         JPi5GL7lfx6Vh2JA3+lPFMfbdlDS20CfzWI3aUB3DNjsICYsfYrkzre2GOBLEM9JjPN8
         02TeClX5XwyYk5FdnGYE1tCxTFoUcPc+dQLj3OmSsCJkQsA/FRBCGJ4glurzNAUOaGeu
         A4TECDASZwuQklbvTv8Gr8VN2GNu+g5rKWpvhK2AkCVHVIjoBKdmV/V7yoaSLdVH8CGb
         WY0dShY8OYer1q9DFfc1YiST4Fksp0rfdUPxI8Atv5EPSjEP3ICiHAzfjEBcU3X5B7M4
         KqHg==
X-Gm-Message-State: AOJu0Yz4lK86D1NUG1oqsoM5c/q0rUA/UIHSt7sr9wl6qC3Iw6M3zRdt
	OlJRiObiIAfUtGgQ9y8WSUgXpSpmg/5ilZFdmHUYrA==
X-Google-Smtp-Source: AGHT+IEIOaC0w5D/lhjh+VU3EkfuBUTxRygJ2AHyrjzPwT9T1Q8Z/QSiLprjuyzNtnB0N6X8zBG1Uw==
X-Received: by 2002:a17:907:9189:b0:a18:e17a:ae0f with SMTP id bp9-20020a170907918900b00a18e17aae0fmr473324ejb.0.1701450991817;
        Fri, 01 Dec 2023 09:16:31 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id h9-20020a1709062dc900b00a19d555755esm1008535eji.117.2023.12.01.09.16.30
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 09:16:31 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40b51e26a7aso80575e9.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 09:16:30 -0800 (PST)
X-Received: by 2002:a05:600c:1c09:b0:40b:3483:8488 with SMTP id
 j9-20020a05600c1c0900b0040b34838488mr158050wms.3.1701450990475; Fri, 01 Dec
 2023 09:16:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201083926.1817394-1-judyhsiao@chromium.org>
 <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com>
 <CAD=FV=Vf18TxUWpGTN9b=iECq=5BmEoopQjsMH2U6bDX2=T3cQ@mail.gmail.com> <CANn89iLzmKOGhMeUUxeM=1b2PP3kieTeYsmpfA0GvJdcQMkgtQ@mail.gmail.com>
In-Reply-To: <CANn89iLzmKOGhMeUUxeM=1b2PP3kieTeYsmpfA0GvJdcQMkgtQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 1 Dec 2023 09:16:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UxS9qxYNdd+kqtW3VRSK=0H9ZPgW=CeSEjfbJXut+PaQ@mail.gmail.com>
Message-ID: <CAD=FV=UxS9qxYNdd+kqtW3VRSK=0H9ZPgW=CeSEjfbJXut+PaQ@mail.gmail.com>
Subject: Re: [PATCH v1] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
To: Eric Dumazet <edumazet@google.com>
Cc: Judy Hsiao <judyhsiao@chromium.org>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, Brian Haley <haleyb.dev@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Joel Granados <joel.granados@gmail.com>, Julian Anastasov <ja@ssi.bg>, Leon Romanovsky <leon@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 1, 2023 at 7:58=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Dec 1, 2023 at 4:16=E2=80=AFPM Doug Anderson <dianders@chromium.o=
rg> wrote:
> >
> > Hi,
> >
> > On Fri, Dec 1, 2023 at 1:10=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > On Fri, Dec 1, 2023 at 9:39=E2=80=AFAM Judy Hsiao <judyhsiao@chromium=
.org> wrote:
> > > >
> > > > We are seeing cases where neigh_cleanup_and_release() is called by
> > > > neigh_forced_gc() many times in a row with preemption turned off.
> > > > When running on a low powered CPU at a low CPU frequency, this has
> > > > been measured to keep preemption off for ~10 ms. That's not great o=
n a
> > > > system with HZ=3D1000 which expects tasks to be able to schedule in
> > > > with ~1ms latency.
> > >
> > > This will not work in general, because this code runs with BH blocked=
.
> > >
> > > jiffies will stay untouched for many more ms on systems with only one=
 CPU.
> > >
> > > I would rather not rely on jiffies here but ktime_get_ns() [1]
> > >
> > > Also if we break the loop based on time, we might be unable to purge
> > > the last elements in gc_list.
> > > We might need to use a second list to make sure to cycle over all
> > > elements eventually.
> > >
> > >
> > > [1]
> > > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > > index df81c1f0a57047e176b7c7e4809d2dae59ba6be5..e2340e6b07735db8cf6e7=
5d23ef09bb4b0db53b4
> > > 100644
> > > --- a/net/core/neighbour.c
> > > +++ b/net/core/neighbour.c
> > > @@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *t=
bl)
> > >  {
> > >         int max_clean =3D atomic_read(&tbl->gc_entries) -
> > >                         READ_ONCE(tbl->gc_thresh2);
> > > +       u64 tmax =3D ktime_get_ns() + NSEC_PER_MSEC;
> >
> > It might be nice to make the above timeout based on jiffies. On a
> > HZ=3D100 system it's probably OK to keep preemption disabled for 10 ms
> > but on a HZ=3D1000 system you'd want 1 ms. ...so maybe you'd want to us=
e
> > jiffies_to_nsecs(1)?
>
> I do not think so. 10ms would be awfully long.
>
> We have nsec based time service, why downgrading to jiffies resolution ??=
?

Well, the whole issue is that we're disabling preemption, right?
Unless I'm mistaken, on a 1000 HZ system then a task's timeslice is
1ms and on a 100 HZ system then a task's timeslice is 10ms. When we
disable preemption then the problem is that we can keep going past the
end of our timeslice. This is bad for whatever task the system is
trying to schedule instead of us since it will be blocked waiting for
us to re-enable preemption.

So essentially the problem here is really tied to jiffies resolution,
right? Specifically, if jiffies is 100 Hz then it's actually
inefficient to timeout every 1 ms--I think it would be better to use
up our whole timeslice.


> > One worry might be that we disabled preemption _right before_ we were
> > supposed to be scheduled out. In that case we'll end up blocking some
> > other task for another full timeslice, but maybe there's not a lot we
> > can do there?
>
> Can you tell us in which scenario this gc_list can be so big, other
> than fuzzers ?

The place we hit this wasn't actually with fuzzers but with normal
usage in our labs. The only case where it was a really big problem was
when neigh_forced_gc() was scheduled on a "little" CPU (in a
big.LITTLE system) and that little CPU happened to be running at the
lowest CPU frequency. Specifically Judy was testing on sc7180-trogdor
and the lowest CPU Frequency of the "little" CPUs was 300 MHz. Since
the littles are less powerful than the bigs, this is roughly the
equivalent processing power of a big core running at 120 MHz.

FWIW, we are apparently no longer seeing the bad latency after
<https://crrev.com/c/4914309>, which does this:

# Increase kernel neighbor table size.
echo 1024 > /proc/sys/net/ipv4/neigh/default/gc_thresh1
echo 4096 > /proc/sys/net/ipv4/neigh/default/gc_thresh2
echo 8192 > /proc/sys/net/ipv4/neigh/default/gc_thresh3
echo 1024 > /proc/sys/net/ipv6/neigh/default/gc_thresh1
echo 4096 > /proc/sys/net/ipv6/neigh/default/gc_thresh2
echo 8192 > /proc/sys/net/ipv6/neigh/default/gc_thresh3

However, I still believe that we should land something like Judy's
patch because, no matter what kernel tunings we have, the kernel
shouldn't be disabling preemption for so long.

I will also note that, while I don't know the code at all, someone on
our networking team commented this: High CPU usage / latency on
neigh_cleanup_and_release is expected naturally because of our
relatively-noisy lab environment: there are often hundreds if not
thousands of devices + virtual devices in a single L2 network.

-Doug

