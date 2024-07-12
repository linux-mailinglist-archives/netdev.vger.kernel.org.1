Return-Path: <netdev+bounces-111164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CDC93023C
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 00:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E90283396
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 22:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52917604F;
	Fri, 12 Jul 2024 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="eJMIpkTi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60334D108
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 22:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720824567; cv=none; b=n3rjL6xhtY3xkXBSMBLLUohRSoyX26wPPGTx13rNpi2JzoyvN5+kYaogHH11vcuVEykz4UwKE+d8AKn8rQS1gB/jkwpxLx9kMxlzc8RDIMEHlNANm9+dxXzAe97hHt+6C+pD7jYg4SOqpaDrPdoeR31djjXyB5DTUpQKk4RwT64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720824567; c=relaxed/simple;
	bh=yzrZqcsuq4CzUEEp7agdi5M1qVJCH/6gW70AV7UgS5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svR/jXzvpLnTPfEKOreGyP1StNWK/NtU5XPaj26f2swxMtScckDS+vSl8tEQiSIKHmTY0ON+xZJNy+L1q2X9ip4M+5SLlP3RGhCC+Oi6+Q76Qm3FGf+otUPROMM3v80MKe8zwrqZIc1/M7P9nQ7g+4MoKN76/pfwaNHcEt3VAX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=eJMIpkTi; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so34467371fa.2
        for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 15:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1720824564; x=1721429364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNbG9SPw6ODdqm0X1D1P5bIp1TAPpaaOK+IcIxDrqlA=;
        b=eJMIpkTikkEt1IEhNVOJSF0qjn7LsbHJirBjROi3lfMRkK1+n/TQiVRjyfbOeqDF5a
         49W+lhLYoAVIPxe+H2TPstwePMhbWhLxMw/LIChAC6v2zqHWovkTINrVRCWf+xDhrQG5
         qRPvgst+nc5cjJJpr6GmhLbcV2CECEmAF6Uu7/p6sLtvZVbujq98qoflVwUwbU5EzIwK
         Ra5TmuMBIchekmL4J+74NtPb7KXghbseixjbvPsvx3UygsV7KoIOPdX7myCVMsHnyuOa
         w9uwt/ag2ofLGaCWTfGtOiLR4kjGmaZKVN5VRBPPUNqzT7i/1qAjofL0FscCLG4No8di
         YLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720824564; x=1721429364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNbG9SPw6ODdqm0X1D1P5bIp1TAPpaaOK+IcIxDrqlA=;
        b=tY8deg5ZIuxBDezrGnkFsOsOQYue7+RQUCNGZvSXPDTqM6jw6ZDiIOCjvYP4pOmFzU
         y3nLzbRbaDQCgGEoXfM/aL84UerC2EHrqWgpDICUbU6DkQ5RyzBjWZq4T64WqA9ToFIH
         jJ8mzP5dOlQyAjdQ1kZYeFJGFhPFmUdspCIOx0o2F0rgN2U3ORKoiyWch7ypaQ9l3p30
         YkBBGc1TkvsqAu7USDbC4+YIgChzb3G5RsZqjUKDbN5TLzU/Ar8zz9kqcCxI9DomOLU0
         KH9d+2DP8nP04zP86gdCDSK8GsjIT/BirFF6r4+7qBVswFxVJJIsrwiqChoBBeQ5+8vU
         ftfA==
X-Forwarded-Encrypted: i=1; AJvYcCX2QPXWIxlxEvAyTZWl/j/zw9C/NyI4jSWYhjxZ4rwGZEvhnywnarW8R7MjHICw7twfz/gvZ46yzQ31x9/ivtBNAk/U3PTU
X-Gm-Message-State: AOJu0Yw7JDznoQb5JTVtWKmj2bxMkNBHZ9mreWA7S88FqzBvXYDf8Yxz
	SChXEe2bY/8hlzXeclWJd6Fqnr7V4oTO8GBKjC210FE+NzFZAIR29+BoydYxyNWM+A3/86CdrmL
	XQFAEuMMeB/pKduRpXiq9sthpps6f2wp2S8TM
X-Google-Smtp-Source: AGHT+IFQTYMXfqyYBs8TBsM8FGOvJi8uuLScFLRKAzHQL5X7ONHmwQeJ/BxhMJmn063fY3YFc597TbdshfS7b5JGoXU=
X-Received: by 2002:a05:651c:198c:b0:2ee:46ec:60bc with SMTP id
 38308e7fff4ca-2eeb30fc98amr101773481fa.27.1720824563679; Fri, 12 Jul 2024
 15:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZpFfocvyF3KHaSzF@LQ3V64L9R2> <ZpGrstyKD-PtWyoP@krava>
In-Reply-To: <ZpGrstyKD-PtWyoP@krava>
From: Kyle Huey <me@kylehuey.com>
Date: Fri, 12 Jul 2024 15:49:10 -0700
Message-ID: <CAP045ApgYjQLVgvPeB0jK4LjfBB+XMo89gdVkZH8XJAdD=a6sg@mail.gmail.com>
Subject: Re: [bpf?] [net-next ?] [RESEND] possible bpf overflow/output bug
 introduced in 6.10rc1 ?
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, acme@kernel.org, andrii.nakryiko@gmail.com, 
	elver@google.com, khuey@kylehuey.com, mingo@kernel.org, namhyung@kernel.org, 
	peterz@infradead.org, robert@ocallahan.org, yonghong.song@linux.dev, 
	mkarsten@uwaterloo.ca, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 3:18=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Jul 12, 2024 at 09:53:53AM -0700, Joe Damato wrote:
> > Greetings:
> >
> > (I am reposting this question after 2 days and to a wider audience
> > as I didn't hear back [1]; my apologies it just seemed like a
> > possible bug slipped into 6.10-rc1 and I wanted to bring attention
> > to it before 6.10 is released.)
> >
> > While testing some unrelated networking code with Martin Karsten (cc'd =
on
> > this email) we discovered what appears to be some sort of overflow bug =
in
> > bpf.
> >
> > git bisect suggests that commit f11f10bfa1ca ("perf/bpf: Call BPF handl=
er
> > directly, not through overflow machinery") is the first commit where th=
e
> > (I assume) buggy behavior appears.
>
> heya, nice catch!
>
> I can reproduce.. it seems that after f11f10bfa1ca we allow to run tracep=
oint
> program as perf event overflow program
>
> bpftrace's bpf program returns 1 which means that perf_trace_run_bpf_subm=
it
> will continue to execute perf_tp_event and then:
>
>   perf_tp_event
>     perf_swevent_event
>       __perf_event_overflow
>         bpf_overflow_handler
>
> bpf_overflow_handler then executes event->prog on wrong arguments, which
> results in wrong 'work' data in bpftrace output
>
> I can 'fix' that by checking the event type before running the program li=
ke
> in the change below, but I wonder there's probably better fix
>
> Kyle, any idea?

Thanks for doing the hard work here Jiri. I did see the original email
a couple days ago but the cause was far from obvious to me so I was
waiting until I had more time to dig in.

The issue here is that kernel/trace/bpf_trace.c pokes at event->prog
directly, so the assumption made in my patch series (based on the
suggested patch at
https://lore.kernel.org/lkml/ZXJJa5re536_e7c1@google.com/) that having
a BPF program in event->prog means we also use the BPF overflow
handler is wrong.

I'll think about how to fix it.

- Kyle


> >
> > Running the following on my machine as of the commit mentioned above:
> >
> >   bpftrace -e 'tracepoint:napi:napi_poll { @[args->work] =3D count(); }=
'
> >
> > while simultaneously transferring data to the target machine (in my cas=
e, I
> > scp'd a 100MiB file of zeros in a loop) results in very strange output
> > (snipped):
> >
> >   @[11]: 5
> >   @[18]: 5
> >   @[-30590]: 6
> >   @[10]: 7
> >   @[14]: 9
> >
> > It does not seem that the driver I am using on my test system (mlx5) wo=
uld
> > ever return a negative value from its napi poll function and likewise f=
or
> > the driver Martin is using (mlx4).
> >
> > As such, I don't think it is possible for args->work to ever be a large
> > negative number, but perhaps I am misunderstanding something?
> >
> > I would like to note that commit 14e40a9578b7 ("perf/bpf: Remove #ifdef
> > CONFIG_BPF_SYSCALL from struct perf_event members") does not exhibit th=
is
> > behavior and the output seems reasonable on my test system. Martin conf=
irms
> > the same for both commits on his test system, which uses different hard=
ware
> > than mine.
> >
> > Is this an expected side effect of this change? I would expect it is no=
t
> > and that the output is a bug of some sort. My apologies in that I am no=
t
> > particularly familiar with the bpf code and cannot suggest what the roo=
t
> > cause might be.
> >
> > If it is not a bug:
> >   1. Sorry for the noise :(
>
> your report is great, thanks a lot!
>
> jirka
>
>
> >   2. Can anyone suggest what this output might mean or how the
> >      script run above should be modified? AFAIK this is a fairly
> >      common bpftrace that many folks run for profiling/debugging
> >      purposes.
> >
> > Thanks,
> > Joe
> >
> > [1]: https://lore.kernel.org/bpf/Zo64cpho2cFQiOeE@LQ3V64L9R2/T/#u
>
> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c6a6936183d5..0045dc754ef7 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9580,7 +9580,7 @@ static int bpf_overflow_handler(struct perf_event *=
event,
>                 goto out;
>         rcu_read_lock();
>         prog =3D READ_ONCE(event->prog);
> -       if (prog) {
> +       if (prog && prog->type =3D=3D BPF_PROG_TYPE_PERF_EVENT) {
>                 perf_prepare_sample(data, event, regs);
>                 ret =3D bpf_prog_run(prog, &ctx);
>         }

