Return-Path: <netdev+bounces-81974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DE488BFCA
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618BB1F61B3A
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 10:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AEB803;
	Tue, 26 Mar 2024 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBIkc+ms"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CA01BC46;
	Tue, 26 Mar 2024 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449847; cv=none; b=NOLpyg3Vf9eA4y9JQmRwR8n0yQ4HZ6WZi5d4jkt86IkyFjO9EPcELbBdY5TlyFXszyRauvDf373F6jaPUBAvPSGYCTq942zkmhh5pk7SoSDMZilyEJ3x5k+++nsHNyORjGoLE6WVc07Yg7428VoJrTp3QgcAhtPxE6QZf5r3B6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449847; c=relaxed/simple;
	bh=lJ45NlZabDxsjX9dOFlXO1AW6h/uOIU7IDhWcCE4Q0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cG7m7ABodKHFR2yPOuT5wzdUyNyOz9KmvkQ9Uebos2yb5VW93yVYxVPlDIf0glrc7X5ahF7Q3yAsRjmb4jFJrfnEXzuUalvKhyLrLqxqBxqITcglLQaBoe1iXVCHY0AzoD8Cc7wy0m7pJcO54kfLzkf6BfocCeSteGO4QJ3FY/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBIkc+ms; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56c0d1bddc1so2456773a12.3;
        Tue, 26 Mar 2024 03:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711449844; x=1712054644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2cUxqc+B8ra29N4a9j+sNQgSvED4r8/7W/pYRP3YnE=;
        b=fBIkc+msUL2o6pxKPnX3PE26i4AwelIzEC+X/KXhBh3Ss+88g92ewXOe+B1d72iFic
         G5yuxb1rD/yAOwzNlE3tIVceOJ3cQ5aviZXEMDs/fyYt74IVEOBSO39NuKW8pbVKHTfx
         0Gn48a4L2R+AQQ7qXQem7DAuhee8NEReB9wwrhz8Z1tcqwlybiQjVvGebhkUtCje/uHh
         OXawL18mShpg3/fzXwj+jKiv/X/8qjc+j2nQ95SPKRF6c3wjw8CcLsEZR2pZBMxzOb24
         C9EzTwlVW+A7Vfp1SqM22JPj60DPYCwI4oMZ8PgFRFukz7SgzZAuNmofKSSpaBtauXpH
         Q/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711449844; x=1712054644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2cUxqc+B8ra29N4a9j+sNQgSvED4r8/7W/pYRP3YnE=;
        b=wEJV0a3Qp5exERBIhIhLmm2RlcPNYcW/KQLQiUUqy+GcNADNEa0BwL1OC1AvM8qOaA
         9C8RRzZeJliemQ2rqUsaKWkhoekZ6xqeCgr//YgemotME9WYl3koVIWajEJCFbCgQK1l
         ZZYOFVB9TP7+xgziVcCQoR6BNTJyvQ0uj9gDEiiIIXhdvSqK/ZBGi3Jq0eYgjp1p/ROf
         LMHBxU3yen9YPHtLhSvAQYP0QmIxB57DxYOUXCvBAbIlLOmK9hTz/qwU8jghVwuuK+qN
         8PdAkaSJ5x5XevdpDhIo6pD7j9/Kmj8ATet3QwSivg8rpxqlia8eKYK7Zb0JatFu/+Uf
         nk3w==
X-Forwarded-Encrypted: i=1; AJvYcCVmkoQR/QAO3AOhFpjgSaPfKcdO0jRSkFNDZ8K+KiSqf4Emluj0FDdD4Lta3NeU/akb3BXjc/qxKCF/6Oxdj2CXQUi9zrN3mHZkO+IFsn66owltKmFPlGfUvn4E+0H67Olda0t7lSIfakMz
X-Gm-Message-State: AOJu0YwFHpKUWmg4P/+DVWEQYbETWj4Zd8GXWrx62A8W2iV9aRylCEV1
	9lqtK6hcm9Xdl3EAwJj0zGj1P+XPSNFXdYZylLaoOW5UnlBBi2kOkRjWana1FNTVYYONmr3GcNG
	TvzAbKlYHoZVXrBcolZOMT+NFR5Q=
X-Google-Smtp-Source: AGHT+IF8zrbUYqWP1N6gV1jU/zo2RAX8E7iuLRz0kH4xCNfnWa8+w9eu46Bzl5WAb8moT6dAxTG4YD5OuHpmvaPEAmM=
X-Received: by 2002:a17:906:2dc1:b0:a47:1d58:e528 with SMTP id
 h1-20020a1709062dc100b00a471d58e528mr7151774eji.16.1711449843952; Tue, 26 Mar
 2024 03:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325034347.19522-1-kerneljasonxing@gmail.com>
 <CAL+tcoAb3Q13hXnEhukCUwBL0Q1W9qC7LuWyzXYGcDzEM56LqA@mail.gmail.com> <b84992bf3953da59e597883e018a79233a09a0bb.camel@redhat.com>
In-Reply-To: <b84992bf3953da59e597883e018a79233a09a0bb.camel@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 26 Mar 2024 18:43:26 +0800
Message-ID: <CAL+tcoAW6YxrW7M8io_JHaNm3-VfY_sWZFBg=6XVmYyPAb1Nag@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] trace: use TP_STORE_ADDRS macro
To: Paolo Abeni <pabeni@redhat.com>
Cc: edumazet@google.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	rostedt@goodmis.org, kuba@kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 6:29=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Tue, 2024-03-26 at 12:14 +0800, Jason Xing wrote:
> > On Mon, Mar 25, 2024 at 11:43=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Using the macro for other tracepoints use to be more concise.
> > > No functional change.
> > >
> > > Jason Xing (3):
> > >   trace: move to TP_STORE_ADDRS related macro to net_probe_common.h
> > >   trace: use TP_STORE_ADDRS() macro in inet_sk_error_report()
> > >   trace: use TP_STORE_ADDRS() macro in inet_sock_set_state()
> > >
> > >  include/trace/events/net_probe_common.h | 29 ++++++++++++++++++++
> > >  include/trace/events/sock.h             | 35 ++++-------------------=
--
> >
> > I just noticed that some trace files in include/trace directory (like
> > net_probe_common.h, sock.h, skb.h, net.h, sock.h, udp.h, sctp.h,
> > qdisc.h, neigh.h, napi.h, icmp.h, ...) are not owned by networking
> > folks while some files (like tcp.h) have been maintained by specific
> > maintainers/experts (like Eric) because they belong to one specific
> > area. I wonder if we can get more networking guys involved in net
> > tracing.
> >
> > I'm not sure if 1) we can put those files into the "NETWORKING
> > [GENERAL]" category, or 2) we can create a new category to include
> > them all.
>
> I think all the file you mentioned are not under networking because of
> MAINTAINER file inaccuracy, and we could move there them accordingly.

Yes, they are not under the networking category currently. So how
could we move them? The MAINTAINER file doesn't have all the specific
categories which are suitable for each of the trace files.

> >
> > I know people start using BPF to trace them all instead, but I can see
> > some good advantages of those hooks implemented in the kernel, say:
> > 1) help those machines which are not easy to use BPF tools.
> > 2) insert the tracepoint in the middle of some functions which cannot
> > be replaced by bpf kprobe.
> > 3) if we have enough tracepoints, we can generate a timeline to
> > know/detect which flow/skb spends unexpected time at which point.
> > ...
> > We can do many things in this area, I think :)
> >
> > What do you think about this, Jakub, Paolo, Eric ?
>
> I agree tracepoints are useful, but I think the general agreement is
> that they are the 'old way', we should try to avoid their
> proliferation.

Well, it's a pity that it seems that we are about to abandon this
method but it's not that friendly to the users who are unable to
deploy BPF... Well, I came up with more ideas about how to improve the
trace function in recent days. The motivation of doing this is that I
encountered some issues which could be traced/diagnosed by using trace
effortlessly without writing some bpftrace codes again and again. The
status of trace seems not active but many people are still using it, I
believe.

Thanks,
Jason

>
> Cheers,
>
> Paolo
>

