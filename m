Return-Path: <netdev+bounces-154635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C52289FEF7C
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 14:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E721882D29
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 13:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE9819ADB0;
	Tue, 31 Dec 2024 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIgJTEJl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7194017BA1
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735650390; cv=none; b=InY0exiJyxAixUiXHMvOVxoASJo0nxvu6cWXWr0V2Lsio+l6F3hmrDCbvaPX62tslyfeb+6DOLqXp0G2v480O852uuYJPuVGNekjb4CbagN1Gr1QPOdFXMg0XIY/cVNyKxguCZM9tdngbjM9MB5EYWamWo9PtWmrQuxk2Te9H+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735650390; c=relaxed/simple;
	bh=fGWcxQwBh6c/wpsMVmCwf7mjE7OcgtTrq/a0/YBZrQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOPXq13+bqlaI5QwSRGhTRpiNq2XElpvCse9xr4DutjdbyVZiOE0S0RkOgyn/Csue8NRJstpv60tSjw8nZcJ8TDOFckjRJauR7NQlJJ6dFU6nnM4bawTkPfBSQKIpBEmQgTzCrf6nm+bA34iBx3UyPUllyDdS2tUVQpkIwy/YVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIgJTEJl; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d8fd060e27so71390146d6.1
        for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 05:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735650386; x=1736255186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOpaXmg7dWTjjyaWq/Pn9pvy2VomHtGjZdqv/8e0/9k=;
        b=ZIgJTEJltRh5C5WZkarFPI4Lj/VxdKfMAeuIXuT3UbeVFRGacjX8FnMn17iO3FfK4k
         zS3tWFo2UBadXNHYH5IJCLElVqZYlwbUNJSOrygtXsWVyJ3qqgJ6R7OHiyACpurLYZRL
         2Q65lUgn741A40dYmS5SS6gR95+9G9jfgDR88YM+g24oY22C8oIMRNTVpsb6BrUmPBHz
         D1/YvOabOQArQuhuwRZ/sGGwOolikFNJamrrLtK+1LzUGnNAtEQvMkkqgyhdeMoIKMLa
         Bj7rC+3eoNRG0yswSkjhcz5eq3jHL+k3ioorM6qmf3fktfr1Mje0g5d8I/J1mc2wAcCE
         93mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735650386; x=1736255186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOpaXmg7dWTjjyaWq/Pn9pvy2VomHtGjZdqv/8e0/9k=;
        b=c4YftHbPC0jrDh6ogkM02BORIkvYMiri1DrrL7A55HnWNDXv/FKjQfMJYqBZ3+i5JJ
         X/rO/yruxtl9nnEREy5EXmhGs49/OH6eSAeP3YhGw2Z+Y4+WphAfdeb6acuz4qnc/eZW
         fWnSd4cc7I5DLwIsJpwz46EKW0MboHB5cgnqQC6wqL3Qds/5i2k1PrUXUKgDvZ2apvwY
         kBrv5Wq3zSfYqYsXcSpSNYBpLnToY3Po7AOoFJNNCyiA1ITkNIQDle+/dlhEX1Nlbauc
         c2WOXTjzSoWy8+Pd8fz1DLeHFHXz5c5oT2EDkBIOzQ0x54ZjEkUFfFf95OIvi1wh6phE
         Ow0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/qrpm7UG+6hPUjuoLIobLIF/9jXUQnNtaYcHQT6CoK3zvk/MNwSuV7NrBuL0r1ek9jE/mBzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUmj+xhn0xcL17C+/GAENUB0pA2D/j2JRM6lr0++XK5f9geicG
	csqAbRBUd4SW1xqtBWeaO9JDfUHMIFknvAldDhOta7Bl2eQ0gt7/lulk40im4nHPC0m0Ndx7rFW
	kRp2VF2vkqFIVVLIHKJLja3DuTfnG9SlJFcY+9A==
X-Gm-Gg: ASbGncuIYCmCdk2M74/iJMsNOV3zOunJ5CNo6cruC6HBUuJqdNgcZSH38DruUnNb0Le
	cRQmu6Mu7NLZiFf0ejn87WyE4dix+gAXGxBaS5Uo=
X-Google-Smtp-Source: AGHT+IHP+VZN8+as60wrEvL/Gl3DZeSJtjzaN+84RkjS2ebFM8dvSYL4oGJsgOGWOnJOkQZf4WdDB4C5sYQIyHLkZVU=
X-Received: by 2002:ad4:5b83:0:b0:6d4:1d4a:70e9 with SMTP id
 6a1803df08f44-6dd2332d725mr557454356d6.19.1735650386227; Tue, 31 Dec 2024
 05:06:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241231055207.9208-1-laoar.shao@gmail.com> <CANn89iL2qZwc7YQLFC8FQzrn_doD4o13+Bk-0+63aGEFFo_7xA@mail.gmail.com>
 <CALOAHbDLQhU5c+P_TiOQb9mjpgJkdfK21WemydVja+eyC0DkRA@mail.gmail.com> <CANn89iJGy7ktcmfOHiN58KyDDXdu=Y5H-L8qRgj6faFQjo9rwQ@mail.gmail.com>
In-Reply-To: <CANn89iJGy7ktcmfOHiN58KyDDXdu=Y5H-L8qRgj6faFQjo9rwQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 31 Dec 2024 21:05:50 +0800
Message-ID: <CALOAHbBRN=H-fFaKeZ_2iNAEhwfMUDLjo2thq+w4GCMh50+4TA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: tcp: Define tcp_listendrop() as noinline
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 8:34=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Dec 31, 2024 at 12:49=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > On Tue, Dec 31, 2024 at 5:26=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Tue, Dec 31, 2024 at 6:52=E2=80=AFAM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > The LINUX_MIB_LISTENDROPS counter can be incremented for several re=
asons,
> > > > such as:
> > > > - A full SYN backlog queue
> > > > - SYN flood attacks
> > > > - Memory exhaustion
> > > > - Other resource constraints
> > > >
> > > > Recently, one of our services experienced frequent ListenDrops. Whi=
le
> > > > attempting to trace the root cause, we discovered that tracing the =
function
> > > > tcp_listendrop() was not straightforward because it is currently in=
lined.
> > > > To overcome this, we had to create a livepatch that defined a non-i=
nlined
> > > > version of the function, which we then traced using BPF programs.
> > > >
> > > >   $ grep tcp_listendrop /proc/kallsyms
> > > >   ffffffffc093fba0 t tcp_listendrop_x     [livepatch_tmp]
> > > >
> > > > Through this process, we eventually determined that the ListenDrops=
 were
> > > > caused by SYN attacks.
> > > >
> > > > Since tcp_listendrop() is not part of the critical path, defining i=
t as
> > > > noinline would make it significantly easier to trace and diagnose i=
ssues
> > > > without requiring workarounds such as livepatching. This function c=
an be
> > > > used by kernel modules like smc, so export it with EXPORT_SYMBOL_GP=
L().
> > > >
> > > > After that change, the result is as follows,
> > > >
> > > >   $ grep tcp_listendrop /proc/kallsyms
> > > >   ffffffffb718eaa0 T __pfx_tcp_listendrop
> > > >   ffffffffb718eab0 T tcp_listendrop
> > > >   ffffffffb7e636b8 r __ksymtab_tcp_listendrop
> > > >
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > --
> > >
> > > Are we going to accept one patch at a time to un-inline all TCP
> > > related functions in the kernel ?
> >
> > I don't have an in-depth understanding of the TCP/IP stack, so I can't
> > consolidate all related TCP functions in the error paths into a single
> > patch. I would greatly appreciate it if you could help ensure these
> > functions are marked as non-inlined based on your expertise. If you
> > don't have time to do it directly, could you provide some guidance?
> >
> > The inlining of TCP functions in error paths often complicates tracing
> > efforts. For instance, we recently encountered issues with the inlined
> > tcp_write_err(), although we were fortunate to have an alternative
> > tracepoint available: inet_sk_error_report.
> >
> > Unfortunately, no such alternative exists for tcp_listendrop(), which
> > is why I submitted this patch.
> >
> > >
> > > My understanding is that current tools work fine. You may need to upg=
rade yours.
> > >
> > > # perf probe -a tcp_listendrop
> > > Added new events:
> > >   probe:tcp_listendrop (on tcp_listendrop)
> > >   probe:tcp_listendrop (on tcp_listendrop)
> > >   probe:tcp_listendrop (on tcp_listendrop)
> > >   probe:tcp_listendrop (on tcp_listendrop)
> > >   probe:tcp_listendrop (on tcp_listendrop)
> > >   probe:tcp_listendrop (on tcp_listendrop)
> > >   probe:tcp_listendrop (on tcp_listendrop)
> > >   probe:tcp_listendrop (on tcp_listendrop)
> > >
> > > You can now use it in all perf tools, such as:
> > >
> > > perf record -e probe:tcp_listendrop -aR sleep 1
> >
> > The issue is that we can't extract the struct `sock *sk` from
> > tcp_listendrop() using perf. Please correct me if I=E2=80=99m mistaken.
> >
> > In a containerized environment, it's common to have many pods running
> > on a single host, each assigned a unique IP. Our goal is to filter for
> > a specific local_ip:local_port combination while also capturing the
> > corresponding remote IP. This task is straightforward with bpftrace or
> > other BPF-based tools, but I=E2=80=99m unsure how to accomplish it usin=
g perf.
>
> I suggest you ask tracing experts' opinions, why is perf able to add a
> probe, but not bpftrace ?
>
> Again, accepting thousands of patches just because of tracing tools
> seems not good to me.

Thank you for your guidance on using perf. I now understand how to
achieve similar tracing with bpftrace.

I agree with your point that it=E2=80=99s not ideal to send thousands of
patches solely for the sake of tracing tools. It would indeed be much
better if this could be addressed in a single patch.

--=20
Regards
Yafang

