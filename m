Return-Path: <netdev+bounces-110988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 636DF92F339
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D811282033
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671637E6;
	Fri, 12 Jul 2024 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxjtLFBl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5351646
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 00:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720745726; cv=none; b=d/KuIsW5CR3Q8eQMAwJbDOYLaD5lD6ELBQPIKbsmc9ibuCun3artlnDKihWxIlLqDgkLgrPOfohL74Wy3Osm0E/YR1iVCv26b2Ai0aal8zVsqiXq1WV68oF/taeqlFriFns2F3kEWje/BJ2i0CFsVSdM8rHKIAzwmUBWFYFyh4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720745726; c=relaxed/simple;
	bh=4V4G4/yBBZGn066c4FnPbm+t9T/ypXWo3h73ATaYsDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSueIyRsHiOxzE5FgWQhLxKBQXbkr9HSLJswHQeN6MVJm9Zf6XvA5PJVkE2E/avDJStDSm/9GEip/FnzZrODOh547EmV8DA/4E2uRIlq1pe4yMNcbFHVkFq+JvfEAWr+Pse9q0l+WQ5Fp+X3lFWqd8IJPsCSdirne3yNY1xd6UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxjtLFBl; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa6c4so1858654a12.2
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 17:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720745723; x=1721350523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xmWwBE/JONgUGJqzc+c0zctV+uAJpWTdSO8ijMSfMw=;
        b=OxjtLFBlT4K9bPNlCnJHmIxyGMGIUW8BcxDm3PpRayrN0IUtTcErO4xeeJAkSAOcKb
         KaQg0QPfnXocP3iUU70KK56qRCKTOddS0okg1JrvmhJxcbWSTWLgVE9ExsMM01UW4tkj
         vvWC+PZslUtIy0PQrb6bSz1m41+5zKvAmOSaehgjxGhFqCX4TsfX7ZOEANfxecMYvH6h
         liuQLlAGz5OMmEnbfTq5RncBSEOdBVeyEw8RxPxZivH1y/YeIB6Av2nOXLBj2UVei0yO
         wIWlnfzehL8NOAFpWqwPxrBPZrs4R0ghGqAbRohaV3H968jYD4WUi4De7pcPotgG4PZP
         WrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720745723; x=1721350523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xmWwBE/JONgUGJqzc+c0zctV+uAJpWTdSO8ijMSfMw=;
        b=PQst1NXYfNxiVfTC9RkisnH5WL4lHID9uYP41d5zb//HBhlf0Al1nYuN45f/83MUNy
         RBxOsZBzuLgS4rFsTKHEqznEwrH7LyeDinkZ3apYgNn8a/5v06PEa3ZLXZQd/SsB9vlx
         ip5s8OhuPz5HjeHt8DQ2y/j44QJ8DXGFO60GdKm27Z6aBF3HXUWHwgOBhedw+d1gK1HQ
         GEz2jyQtXEeKCRjZowLYUiymmeBmpotC8FubYVhRdmrmo5P8PRGzn+E2unf7ubegwB2j
         cb0SQt/r0zSj//KDsNRZshdAugTtsCNi/kX6HQs7P8DLWDRv7NGIlzASzMrdMbIGEBLt
         dYvA==
X-Forwarded-Encrypted: i=1; AJvYcCVYCs+6S9wV1JasN0c4Zp//KMTRYKeE7vep65M4NORBzYExo1JZUL6mG6Y5NjzOQwt6inpqiBmPgQdr2Jcnm93kC6YPU7Dc
X-Gm-Message-State: AOJu0YzaqlMzoWyTD4+lzmU+NieE3KsDAxVgvVbwhAPNBnatTLcryEvf
	j7uhNGrxzCRxO829h6JpFyJSDOUCnWLEWnwQcFyURQcgvljuIIDSMNC4LcLkV0toEynrOwj5cpX
	s2O12ZH+EM08yR8qZ8q6lIN6LVXM=
X-Google-Smtp-Source: AGHT+IHTWcOohigIwnVt9qxaq1jPG8dzficBNJDdSsYD2192aaIZQshVGXHK0Jg0PneMcfE6L9zPE28vucxwY2YC3+c=
X-Received: by 2002:a50:cdd1:0:b0:599:4e93:33c9 with SMTP id
 4fb4d7f45d1cf-5994e933435mr815592a12.12.1720745722763; Thu, 11 Jul 2024
 17:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711071017.64104-1-348067333@qq.com> <CANn89iJS434T_knwiX2mHYsyD5xQzJceeJkRg5F-kaLy8OqD9w@mail.gmail.com>
 <CAL+tcoAzshARTCVjQXAFBOS=O4EYo-t6ACtP+h0ynyFOjarfUQ@mail.gmail.com> <CANn89iK-kaAUBF4MkAZJuRiJOO5LCE-SCRKDLBjz6gGoR5G4cA@mail.gmail.com>
In-Reply-To: <CANn89iK-kaAUBF4MkAZJuRiJOO5LCE-SCRKDLBjz6gGoR5G4cA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 12 Jul 2024 08:54:45 +0800
Message-ID: <CAL+tcoDGY0ynF2pG6VuMGnRZc9wMp0GMwB1LJNM=boY4gXy0_A@mail.gmail.com>
Subject: Re: [PATCH net-next] inet: reduce the execution time of getsockname()
To: Eric Dumazet <edumazet@google.com>
Cc: heze0908 <heze0908@gmail.com>, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	kernelxing@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 8:32=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jul 11, 2024 at 4:58=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Hello Eric,
> >
> > On Fri, Jul 12, 2024 at 1:26=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Thu, Jul 11, 2024 at 12:10=E2=80=AFAM heze0908 <heze0908@gmail.com=
> wrote:
> > > >
> > > > From: Ze He <zanehe@tencent.com>
> > > >
> > > > Recently, we received feedback regarding an increase
> > > > in the time consumption of getsockname() in production.
> > > > Therefore, we conducted tests based on the
> > > > "getsockname" test item in libmicro. The test results
> > > > indicate that compared to the kernel 5.4, the latest
> > > > kernel indeed has an increased time consumption
> > > > in getsockname().
> > > > The test results are as follows:
> > > >
> > > > case_name       kernel 5.4      latest kernel     diff
> > > > ----------      -----------     -------------   --------
> > > > getsockname       0.12278         0.18246       +48.61%
> > > >
> > > > It was discovered that the introduction of lock_sock() in
> > > > commit 9dfc685e0262 ("inet: remove races in inet{6}_getname()")
> > > > to solve the data race problem between __inet_hash_connect()
> > > > and inet_getname() has led to the increased time consumption.
> > > > This patch attempts to propose a lockless solution to replace
> > > > the spinlock solution.
> > > >
> > > > We have to solve the race issue without heavy spin lock:
> > > > one reader is reading some members in struct inet_sock
> > > > while the other writer is trying to modify them. Those
> > > > members are "inet_sport" "inet_saddr" "inet_dport"
> > > > "inet_rcv_saddr". Therefore, in the path of getname, we
> > > > use READ_ONCE to read these data, and correspondingly,
> > > > in the path of tcp connect, we use WRITE_ONCE to write
> > > > these data.
> > > >
> > > > Using this patch, we conducted the getsockname test again,
> > > > and the results are as follows:
> > > >
> > > > case_name       latest kernel   latest kernel(patched)
> > > > ----------      -----------     ---------------------
> > > > getsockname       0.18246             0.14423
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > Signed-off-by: Ze He <zanehe@tencent.com>
> > >
> > > There is no way you can implement a correct getsockname() without
> > > extra synchronization.
> > >
> > > When multiple fields are read, READ_ONCE() will not ensure
> > > consistency, especially for IPv6 addresses
> > > which are too big to fit in a single word.
> > >
> >
> > Thanks for your reply.
> >
> > I was thinking two ways at the beginning, one is using lockless way as
> > this patch does which apparently is a little bit complicated, the
> > other one is reverting commit 9dfc685e0262 ("inet: remove races in
> > inet{6}_getname()") because in the real world I don't think the
> > software programmer could call this two syscalls (connect and
> > getsockname) concurrently. What is the use/meaning of calling those
> > two concurrently? Even if there is data-race in this case, programmers
> > cannot trust the results of getsockname one way or another. The fact
> > is the degradation of performance, which the users complain about
> > after upgrading the kernel from 5.4 to the latest. What do you
> > suggest, Eric?
>
> In the 'real world' we need results that we can trust.
>
> Fact that it was missing in the past is not an excuse, this was a bug
> in the first place.
>
> Feel free to implement an alternate protection, if you really need to.

Umm. Let me think more about how to solve the data consistency
issue... Really hard, I think.

Thanks,
Jason

