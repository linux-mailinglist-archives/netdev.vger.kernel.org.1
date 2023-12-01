Return-Path: <netdev+bounces-53076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEC1801308
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3AC4B20B2B
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343FA4D585;
	Fri,  1 Dec 2023 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mA3n7Vzi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D1593
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:47:27 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54c54a3b789so1851449a12.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701456446; x=1702061246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55+ZUEjsrc3UB5LYQhm11Jk8d+ZjC/aqtysvU5RZ+wA=;
        b=mA3n7VziJG5cR7UE5bIxOtbg+gJj0g5gDfAASfdF37Te6utn4N6yJWwK3gp4fksY2R
         465+L8281ctp/Yztw1qw7lZRPkyEHk+cU6J1rDalmJvgMWvGHwLZXYbjrIhaT0V5vNgp
         Vz0NV37lq5KMEhXDvtBwXCGvQCoRAbw9Ff9Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701456446; x=1702061246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55+ZUEjsrc3UB5LYQhm11Jk8d+ZjC/aqtysvU5RZ+wA=;
        b=DAtFR+p0bur5TOEfRtGVIBOYq7vAZ7gNYS4wVrFAuMERhANizIUeYd4Qkbipwnm9xn
         aYnd+0ScWoAxRaKdlLomcSK3C8ISdCCdVEwaUxQczrNsHyaHkXSnKJvddB3zTSOIrFAQ
         dnZFAOvC3+QKnWQO3giRxJPocQu+Ol3CnmDYyVdQsYvZWSp9BZCKBV8J1y0KW0Vc/m/y
         ud5SIm2sRWMsEfwy0b+9vGcigV4CrHtCEpfUgD2RfASL/uQmLcOc12Cp23RdGhVRgXL+
         0iqEMVcynW1eCQ5EiEPHAtlSfgLe0acJo7Wdu7j021/Fo2cieWbNus1nJIgf4x/XMffi
         0ddA==
X-Gm-Message-State: AOJu0YyOpBzRtJvCJjSRxgs+okEkp6UPiBDwEedpzj+h8wiz9r3pkvcR
	CpY5JjGlZ/4Z9vWSj6/zbGXgEq7tHClIOSbw6w6MWFgp
X-Google-Smtp-Source: AGHT+IEOdU39MSQnLtHjd2uvsUsxdJIMexjW7rJXmIS0nxxxc2V1fihwKEyyQk/yEbEFzHYVoDYQTg==
X-Received: by 2002:a05:6402:180a:b0:54a:f411:9a2e with SMTP id g10-20020a056402180a00b0054af4119a2emr1913095edy.0.1701456446129;
        Fri, 01 Dec 2023 10:47:26 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id da6-20020a056402176600b0054c52a78f56sm898309edb.56.2023.12.01.10.47.26
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 10:47:26 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso1206a12.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:47:26 -0800 (PST)
X-Received: by 2002:a50:bb48:0:b0:54b:bf08:a95f with SMTP id
 y66-20020a50bb48000000b0054bbf08a95fmr204880ede.6.1701456057266; Fri, 01 Dec
 2023 10:40:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201083926.1817394-1-judyhsiao@chromium.org>
 <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com>
 <CAD=FV=Vf18TxUWpGTN9b=iECq=5BmEoopQjsMH2U6bDX2=T3cQ@mail.gmail.com>
 <CANn89iLzmKOGhMeUUxeM=1b2PP3kieTeYsmpfA0GvJdcQMkgtQ@mail.gmail.com>
 <CAD=FV=UxS9qxYNdd+kqtW3VRSK=0H9ZPgW=CeSEjfbJXut+PaQ@mail.gmail.com> <CANn89iLuY3dg6tpJCosGVOVR2FbT09DGXZpfb+zuW_BnPVf32g@mail.gmail.com>
In-Reply-To: <CANn89iLuY3dg6tpJCosGVOVR2FbT09DGXZpfb+zuW_BnPVf32g@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 1 Dec 2023 10:40:41 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XvczUqrYVzDYy=uQ7-LMcRgpJj3iiehzfJNAq=UvJXbg@mail.gmail.com>
Message-ID: <CAD=FV=XvczUqrYVzDYy=uQ7-LMcRgpJj3iiehzfJNAq=UvJXbg@mail.gmail.com>
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

On Fri, Dec 1, 2023 at 9:35=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> > > > > @@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_tabl=
e *tbl)
> > > > >  {
> > > > >         int max_clean =3D atomic_read(&tbl->gc_entries) -
> > > > >                         READ_ONCE(tbl->gc_thresh2);
> > > > > +       u64 tmax =3D ktime_get_ns() + NSEC_PER_MSEC;
> > > >
> > > > It might be nice to make the above timeout based on jiffies. On a
> > > > HZ=3D100 system it's probably OK to keep preemption disabled for 10=
 ms
> > > > but on a HZ=3D1000 system you'd want 1 ms. ...so maybe you'd want t=
o use
> > > > jiffies_to_nsecs(1)?
> > >
> > > I do not think so. 10ms would be awfully long.
> > >
> > > We have nsec based time service, why downgrading to jiffies resolutio=
n ???
> >
> > Well, the whole issue is that we're disabling preemption, right?
> > Unless I'm mistaken, on a 1000 HZ system then a task's timeslice is
> > 1ms and on a 100 HZ system then a task's timeslice is 10ms. When we
> > disable preemption then the problem is that we can keep going past the
> > end of our timeslice. This is bad for whatever task the system is
> > trying to schedule instead of us since it will be blocked waiting for
> > us to re-enable preemption.
> >
> > So essentially the problem here is really tied to jiffies resolution,
> > right? Specifically, if jiffies is 100 Hz then it's actually
> > inefficient to timeout every 1 ms--I think it would be better to use
> > up our whole timeslice.
>
> It is not because a kernel is built with HZ=3D100 that each thread has
> to consume cpu times in 10ms slices.
>
> Process scheduler does not use jiffies at all, but high resolution time s=
ervice.
>
> Keep in mind this code is run from soft-interrupt, not a dedicated proces=
sus.

Fair enough. I guess my mental model is wrong here. Please disregard
my suggestion about using something based on how long "jiffies" is
then. Using a fixed 1 ms timeout sounds great, then.


> > > Can you tell us in which scenario this gc_list can be so big, other
> > > than fuzzers ?
> >
> > The place we hit this wasn't actually with fuzzers but with normal
> > usage in our labs. The only case where it was a really big problem was
> > when neigh_forced_gc() was scheduled on a "little" CPU (in a
> > big.LITTLE system) and that little CPU happened to be running at the
> > lowest CPU frequency. Specifically Judy was testing on sc7180-trogdor
> > and the lowest CPU Frequency of the "little" CPUs was 300 MHz. Since
> > the littles are less powerful than the bigs, this is roughly the
> > equivalent processing power of a big core running at 120 MHz.
> >
> > FWIW, we are apparently no longer seeing the bad latency after
> > <https://crrev.com/c/4914309>, which does this:
> >
> > # Increase kernel neighbor table size.
> > echo 1024 > /proc/sys/net/ipv4/neigh/default/gc_thresh1
> > echo 4096 > /proc/sys/net/ipv4/neigh/default/gc_thresh2
> > echo 8192 > /proc/sys/net/ipv4/neigh/default/gc_thresh3
> > echo 1024 > /proc/sys/net/ipv6/neigh/default/gc_thresh1
> > echo 4096 > /proc/sys/net/ipv6/neigh/default/gc_thresh2
> > echo 8192 > /proc/sys/net/ipv6/neigh/default/gc_thresh3
> >
> > However, I still believe that we should land something like Judy's
> > patch because, no matter what kernel tunings we have, the kernel
> > shouldn't be disabling preemption for so long.
>
> Sure, and I suggested a refinement, because as I said jiffies can
> stick to a value.
>
> Not sure why a refinement given by a network maintainer is not an option =
?
>
> I must be missing something.

Your refinement was good. I was merely trying to answer the question
you asked about how we got into it as completely as possible. Sorry if
I caused confusion.

