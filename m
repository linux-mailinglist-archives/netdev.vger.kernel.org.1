Return-Path: <netdev+bounces-110972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D2492F2DB
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 01:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55AE1C20D7D
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 23:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0607816D9B2;
	Thu, 11 Jul 2024 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+WESBco"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF1C4F1E2
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 23:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720742298; cv=none; b=giBKL1Mfr2hNbrE/VZpw/CMs1NxB5PL4FhbGpRhFulaXl8WmINPy0Fyk//D7tyXEAXYFT6wKC9uiIGS9cGUGSLtf8a4JUp3ktZRaCpLP6pelTj0Gv6e5RA3LuJ+A+L6QMnCOLboEbXhYPUW7vyOkq4tLuqc66AAhykBGkOBXJMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720742298; c=relaxed/simple;
	bh=rLXFZUqOdS2J3W7v7i3fAelVH3ptIDYmksd7I+cyjN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfbSalrjU1LeU5ej6OVVqGw/XNlKHbfEVsIiIpdsnGPVl7NN77pybm9z2TIq5m+qcb5kuThT+WOt9xfD8AoV+uOSi/6ah/As/Vh5Was1/9pNGKt45KpH7b4Q8qkO0Bs8HzzlpyJL2h0TFsgc2iU5CCEr+61zepZ3mx4DoLqOxvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+WESBco; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58b447c5112so1956040a12.3
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 16:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720742295; x=1721347095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYHKYdCAhh+LrMq8h4yj+YgwDtj3X4olRZLKXsgtb/k=;
        b=R+WESBcogIFIEhEEV3jPGApe5TlHe6dlUXUHn4eRcPQ1LWOk1kXj4tfkt3jzJ/Edo+
         5rMzehdmkCRY6Xt7MG+SdGxB8AchJHAGLZOMYI+A0++D0To9wclTYf/GAqalPGDStwDu
         pCtFEG3k03w85m1hPHIZ5eiIjwm+IEfiv6C/gfwnlNlH/JVAazbxHg+lBAbXT+1XIWoY
         4H7C99RfCf3+s4COaM8bkhWn3n/UWBU+9Bz2OyIdZiE9edVZumBT2s7jBspYqZKf2sfw
         Wfh6Y+Y5xmsidp/nmw5zC06AoM+gHqtmDARwQQY/hcjYPWyOuDxN0FY/bkvHwrLQXZV/
         9ptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720742295; x=1721347095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYHKYdCAhh+LrMq8h4yj+YgwDtj3X4olRZLKXsgtb/k=;
        b=fymG4Oj2mYyh0q4dCTSp/oPVTtPXQ8VRv+yC6rcqtNCqf8QCRjbEwWoOaku7i9Uz5s
         50Bh2WCRVaKGyM7Edt5+r2RwBI6BjZJlRRJrqEFULyYW4wE9CkS3n/ihHJkCan5N8XVu
         wqbL1GJ4i/zXBGqgjTuMpHoovyv0n21Uzizdb/rG6+AXLQmDCCHFj4TMfzJvI96PcbW0
         NnaFrHSXnM4Q/6LOtEGbVRfcSQizb8BF0G4REAXU+VF8tCKJFTUEVm2xmTNbVnLIlgKe
         RZywz5s1hDIVjFNVDOtJ55zlHf5tbHW0PkwcgjT/gmKfk8HCqhYgSICQcvDcW9ObCrcL
         IhnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4sLt17D1wW95f8OpWBCBVT/a0yKbVH4936P1fpNqzzIShvHGRVHVuDxE6iDUZ87z5QA7u/Lv+AYOo1VEQDiSHIANQAJUJ
X-Gm-Message-State: AOJu0YyY+S0UqTArX60E+s0mUHF6JZvgJM4UFGE72HKrzEyDgjAjU97p
	lQpLHoEA+rCfilIHyM3sPodSSC9THjeLtBQM4lRmT5GPUnKv3ooK+QI3fboKj3vvdlDnKjzu/El
	VuEHidysaZWyokWmA/mP9AlCVCR8=
X-Google-Smtp-Source: AGHT+IHTnkd+lNXjgFBS3PrO4nt7+MdWhPJWIUVRftIB5OhEULQX5VU6pI0QsNEdPz5P1b1hma5EFFgpigZewJwweYM=
X-Received: by 2002:a05:6402:5187:b0:57d:6326:c658 with SMTP id
 4fb4d7f45d1cf-594b7d840admr8538880a12.0.1720742295451; Thu, 11 Jul 2024
 16:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711071017.64104-1-348067333@qq.com> <CANn89iJS434T_knwiX2mHYsyD5xQzJceeJkRg5F-kaLy8OqD9w@mail.gmail.com>
In-Reply-To: <CANn89iJS434T_knwiX2mHYsyD5xQzJceeJkRg5F-kaLy8OqD9w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 12 Jul 2024 07:57:37 +0800
Message-ID: <CAL+tcoAzshARTCVjQXAFBOS=O4EYo-t6ACtP+h0ynyFOjarfUQ@mail.gmail.com>
Subject: Re: [PATCH net-next] inet: reduce the execution time of getsockname()
To: Eric Dumazet <edumazet@google.com>
Cc: heze0908 <heze0908@gmail.com>, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	kernelxing@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Fri, Jul 12, 2024 at 1:26=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jul 11, 2024 at 12:10=E2=80=AFAM heze0908 <heze0908@gmail.com> wr=
ote:
> >
> > From: Ze He <zanehe@tencent.com>
> >
> > Recently, we received feedback regarding an increase
> > in the time consumption of getsockname() in production.
> > Therefore, we conducted tests based on the
> > "getsockname" test item in libmicro. The test results
> > indicate that compared to the kernel 5.4, the latest
> > kernel indeed has an increased time consumption
> > in getsockname().
> > The test results are as follows:
> >
> > case_name       kernel 5.4      latest kernel     diff
> > ----------      -----------     -------------   --------
> > getsockname       0.12278         0.18246       +48.61%
> >
> > It was discovered that the introduction of lock_sock() in
> > commit 9dfc685e0262 ("inet: remove races in inet{6}_getname()")
> > to solve the data race problem between __inet_hash_connect()
> > and inet_getname() has led to the increased time consumption.
> > This patch attempts to propose a lockless solution to replace
> > the spinlock solution.
> >
> > We have to solve the race issue without heavy spin lock:
> > one reader is reading some members in struct inet_sock
> > while the other writer is trying to modify them. Those
> > members are "inet_sport" "inet_saddr" "inet_dport"
> > "inet_rcv_saddr". Therefore, in the path of getname, we
> > use READ_ONCE to read these data, and correspondingly,
> > in the path of tcp connect, we use WRITE_ONCE to write
> > these data.
> >
> > Using this patch, we conducted the getsockname test again,
> > and the results are as follows:
> >
> > case_name       latest kernel   latest kernel(patched)
> > ----------      -----------     ---------------------
> > getsockname       0.18246             0.14423
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > Signed-off-by: Ze He <zanehe@tencent.com>
>
> There is no way you can implement a correct getsockname() without
> extra synchronization.
>
> When multiple fields are read, READ_ONCE() will not ensure
> consistency, especially for IPv6 addresses
> which are too big to fit in a single word.
>

Thanks for your reply.

I was thinking two ways at the beginning, one is using lockless way as
this patch does which apparently is a little bit complicated, the
other one is reverting commit 9dfc685e0262 ("inet: remove races in
inet{6}_getname()") because in the real world I don't think the
software programmer could call this two syscalls (connect and
getsockname) concurrently. What is the use/meaning of calling those
two concurrently? Even if there is data-race in this case, programmers
cannot trust the results of getsockname one way or another. The fact
is the degradation of performance, which the users complain about
after upgrading the kernel from 5.4 to the latest. What do you
suggest, Eric?

Thanks,
Jason

