Return-Path: <netdev+bounces-154633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588369FEF54
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 13:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B97D3A2965
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3551925AC;
	Tue, 31 Dec 2024 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tqy64URi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663E437160
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735648497; cv=none; b=KV0JmMSrfYmkXyZCHglNFTkXR4B1lRkUhMfr4QvERDEAn8KDkkEEfiqDImspO6uqDu032I1z2o5pRw23eU/GyrrwvYrSnYl2tnQ2kRxIPCEadPGxeSBKzclDkUXTRRXUHEGtmeE3VuHOV7nNuvONMe9bKRJpahMzWJhij9ZoVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735648497; c=relaxed/simple;
	bh=VzvPRzs/pmd4KtpbLd/8xNsKs92hW5aSQbJ7B1u0nHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZnnnsl8D8LbshORgEN1pm4AV2ahoJ9pl08WpiYDH1+FTeurZG9F5IxyvOZ4e4qSHyb6LAMFxT4w5wiVJdmRvEZxDlu0PAyN4cSiR3zTTVsXE+/dIxqK3RFj22Szkk1XoCxVP9ZRxgHjfD4TzksS8ReXd8p17ZqpB7WKjRt8hZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tqy64URi; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso20323009a12.0
        for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 04:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735648494; x=1736253294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T70Wup5hm59A/hByWauc0THpCwhNeTzJMpKd/ElNIiY=;
        b=Tqy64URipWQQRVM51P3OjU5Mcr5TyhlYZpCCx1UabsxuNZoppSR7tfBkyvA+1LlHpQ
         t3eGb0vTHP/lRNNd3ITKItSyhtZDkGmrwaNX1N1/XrDiMq9/hqOb4Bs+5NOlrkU5GYPP
         qvw4JCpfZog3YZC25o6yKjTQ9zjPDj8bwaQODE/Yyo96xj9hOVPc1IzJ3rkB7CXzN/Kr
         T3jgWF1yeOZDW4DluowFBofyEF/0a/Gdf/LNzLxSxyedlV10IfIdGiyIT1dZnC9/kpUz
         tlbcYOUb/92ICrdr3RW7g20cV6waGMQewjleWad0LB3zad1Gh6jwJcB3hK0s0ZRIUrYJ
         zG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735648494; x=1736253294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T70Wup5hm59A/hByWauc0THpCwhNeTzJMpKd/ElNIiY=;
        b=eFRaDOYVZFP4BUIQaZkRxtQRssZf1w2O4nTNw53LEV5uv/Ne1PdQB6LDrs7Meii7tZ
         08RsWHj6teY5Mhi06PP1yi9y4GJ7BoCYz37Q2qu1+y/m3qq37Of5S6wHUqzC/mM2IFrr
         Wi6IKzAAfFS/JNn5QWc0/bVAWwOLgHug6o1B5yUvb9qCYh3Tj4kXNPR2SvTy/P1Kul0f
         WpmxUMqFxnxVROGURV/PefC2h8yoaIZ8JQFZ8mUANqtIfRTUfgafmzlMB7yVZjiOitJO
         vk5bbe45kcvGADc5d21S6iol/j+IIrIxlE8LikN9hYjfkXLGhJLkp/uqoNy8DWS13T01
         7BEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIQxe0Up9mEOvZR3xcJEdZ79Sr2syHDSYsKZc7YP7NyjlYOvwjoeOCeC7vOpH/bA5+VNyFNns=@vger.kernel.org
X-Gm-Message-State: AOJu0YykN18kam8UiKOe4KxU+OtfARNuwlEQQSQFRNDooxB3UY3hRr6Z
	URFyij3FwzekqtdvVWk/JZXR9BcDd7HY8YLE1q+iWxmyvAd2RzBdlmnnLgk3Eq5g8IA6RGEoSLO
	VV+AYQ9rsbyAtvgydyK3g/75q/191YiXWh5+W
X-Gm-Gg: ASbGncsX4jL5J1ktWyj8DUJxe2CbiSh5Kf9/Jgk48Cj11boKHfPs3E2ahv+sqSFofsr
	zDniybxiqeQGZrKUjsNbsI2z73uSnxryw3/S/KLc=
X-Google-Smtp-Source: AGHT+IHr4fa5LG2Rs8y59dWZr8Y0O5CyiiyrehNZNTj7LJFYYx5UD/7eRHahNkXr0L/IlZ9idYN2qBs7O2IJtrC0zpM=
X-Received: by 2002:a05:6402:430c:b0:5d2:fa65:c5e2 with SMTP id
 4fb4d7f45d1cf-5d81de1fd2amr37663550a12.22.1735648493550; Tue, 31 Dec 2024
 04:34:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241231055207.9208-1-laoar.shao@gmail.com> <CANn89iL2qZwc7YQLFC8FQzrn_doD4o13+Bk-0+63aGEFFo_7xA@mail.gmail.com>
 <CALOAHbDLQhU5c+P_TiOQb9mjpgJkdfK21WemydVja+eyC0DkRA@mail.gmail.com>
In-Reply-To: <CALOAHbDLQhU5c+P_TiOQb9mjpgJkdfK21WemydVja+eyC0DkRA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 31 Dec 2024 13:34:42 +0100
Message-ID: <CANn89iJGy7ktcmfOHiN58KyDDXdu=Y5H-L8qRgj6faFQjo9rwQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: tcp: Define tcp_listendrop() as noinline
To: Yafang Shao <laoar.shao@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 12:49=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> On Tue, Dec 31, 2024 at 5:26=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Tue, Dec 31, 2024 at 6:52=E2=80=AFAM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > The LINUX_MIB_LISTENDROPS counter can be incremented for several reas=
ons,
> > > such as:
> > > - A full SYN backlog queue
> > > - SYN flood attacks
> > > - Memory exhaustion
> > > - Other resource constraints
> > >
> > > Recently, one of our services experienced frequent ListenDrops. While
> > > attempting to trace the root cause, we discovered that tracing the fu=
nction
> > > tcp_listendrop() was not straightforward because it is currently inli=
ned.
> > > To overcome this, we had to create a livepatch that defined a non-inl=
ined
> > > version of the function, which we then traced using BPF programs.
> > >
> > >   $ grep tcp_listendrop /proc/kallsyms
> > >   ffffffffc093fba0 t tcp_listendrop_x     [livepatch_tmp]
> > >
> > > Through this process, we eventually determined that the ListenDrops w=
ere
> > > caused by SYN attacks.
> > >
> > > Since tcp_listendrop() is not part of the critical path, defining it =
as
> > > noinline would make it significantly easier to trace and diagnose iss=
ues
> > > without requiring workarounds such as livepatching. This function can=
 be
> > > used by kernel modules like smc, so export it with EXPORT_SYMBOL_GPL(=
).
> > >
> > > After that change, the result is as follows,
> > >
> > >   $ grep tcp_listendrop /proc/kallsyms
> > >   ffffffffb718eaa0 T __pfx_tcp_listendrop
> > >   ffffffffb718eab0 T tcp_listendrop
> > >   ffffffffb7e636b8 r __ksymtab_tcp_listendrop
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > --
> >
> > Are we going to accept one patch at a time to un-inline all TCP
> > related functions in the kernel ?
>
> I don't have an in-depth understanding of the TCP/IP stack, so I can't
> consolidate all related TCP functions in the error paths into a single
> patch. I would greatly appreciate it if you could help ensure these
> functions are marked as non-inlined based on your expertise. If you
> don't have time to do it directly, could you provide some guidance?
>
> The inlining of TCP functions in error paths often complicates tracing
> efforts. For instance, we recently encountered issues with the inlined
> tcp_write_err(), although we were fortunate to have an alternative
> tracepoint available: inet_sk_error_report.
>
> Unfortunately, no such alternative exists for tcp_listendrop(), which
> is why I submitted this patch.
>
> >
> > My understanding is that current tools work fine. You may need to upgra=
de yours.
> >
> > # perf probe -a tcp_listendrop
> > Added new events:
> >   probe:tcp_listendrop (on tcp_listendrop)
> >   probe:tcp_listendrop (on tcp_listendrop)
> >   probe:tcp_listendrop (on tcp_listendrop)
> >   probe:tcp_listendrop (on tcp_listendrop)
> >   probe:tcp_listendrop (on tcp_listendrop)
> >   probe:tcp_listendrop (on tcp_listendrop)
> >   probe:tcp_listendrop (on tcp_listendrop)
> >   probe:tcp_listendrop (on tcp_listendrop)
> >
> > You can now use it in all perf tools, such as:
> >
> > perf record -e probe:tcp_listendrop -aR sleep 1
>
> The issue is that we can't extract the struct `sock *sk` from
> tcp_listendrop() using perf. Please correct me if I=E2=80=99m mistaken.
>
> In a containerized environment, it's common to have many pods running
> on a single host, each assigned a unique IP. Our goal is to filter for
> a specific local_ip:local_port combination while also capturing the
> corresponding remote IP. This task is straightforward with bpftrace or
> other BPF-based tools, but I=E2=80=99m unsure how to accomplish it using =
perf.

I suggest you ask tracing experts' opinions, why is perf able to add a
probe, but not bpftrace ?

Again, accepting thousands of patches just because of tracing tools
seems not good to me.

