Return-Path: <netdev+bounces-216698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E4DB34F90
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A477B32B1
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 23:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DB2299A8E;
	Mon, 25 Aug 2025 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkoe2Ct7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6527227EB9
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756163487; cv=none; b=b3QpC7joIBecS3ALtUCj5bpZfL37w5nFjCwfse8173EVZPh8YlQDWtWxRZkZvEkkX4WijU2n6NfXIqs8cscijpo8yczbov5q/+NyIDnZ0USUX9oQZO+ZPWW6RQFDtoT/g0Ashj28JHMZN5fdHXJDoG0/iGwi2+eTnC30m4fapy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756163487; c=relaxed/simple;
	bh=ixz1yuirrXD6mnVtL1bd1gJEqgL/svxLkWYVRvO4lVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyKDVEDp3is7Nhc131MjImyIkvzoIcbROEpyph8Rx2rBe4nLhnEAWvxp9cql59Y3bamjPFWqj0E3njCf/2pplQqvI3Ayrm44OQ5Pk4MXQ+XSiHep//TOhupkzFlvH3qoUqX68SJN2+6OSVKak0rARW4VgdFGUojvF6j0JCoC8QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qkoe2Ct7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24611734e50so44455ad.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 16:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756163485; x=1756768285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dLaiZzeTepl12qWMx9QKw/19qCQYh3LlmcZm1QwIbM=;
        b=qkoe2Ct79RD2BrkaTzQucJfgQi3d0uwq57GE5Z5EfPdVYrlNYDlv1NyIZo9B9GZ6nw
         50VscqRl641w5J4Q32d3URB0ETZXPA/uFQ5OsdvXl8DpQQoQu/890kUxsGh6QSTgHwhK
         c+85YwB0/YcvYRHSCiVY2v9QPiyhXHcH4jOwh8cTOJE5fkmKy8RkgRVGD+oV9jeh/uMr
         Dk0zvUOmhI5vr97ys5XjfGOirFPnWH1McQ8nFuiDHuNx2I76YPdNrlFqZwzPLquP9IeZ
         MhQx4P/Ja340P98yKmFPZA3TkpepQNRgmngU+c9MS79b0/SGyDkcS+7y0l/CgLNXsNkl
         aAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756163485; x=1756768285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dLaiZzeTepl12qWMx9QKw/19qCQYh3LlmcZm1QwIbM=;
        b=DqjfuexMaY5c6m6acaUZr1igOyTt31pKs0OERP1ZuDCVyJFoZJAxtGlmo+s6vjmqbi
         x8VaWaMolIGpu+aHafKMs7VO3fohkXgMzj1DH51SmzqncQK5xqvhkZDNwsFLgKQy7lwv
         U1AMVKdEWl/GtyEoIYOu4rSkJLE1GP2Sr5JirxHLu4QfVg3unfTaBx9SkRW9zw2m8yHD
         W1LakzMCkRKklVbPbnZuUjjX2P9Px+tjfglpXEPYrs7dxA3561dDuKeF+Qzt8REds6tB
         1yGLBxRJQv85soPUGaMGbrZbhG0joFwZ2w2JOxmOg8jJjp0+WDzLrUsxqKxAUOG9wFLe
         uF3A==
X-Forwarded-Encrypted: i=1; AJvYcCX2yxfY/wCALaSVdKYDy3pjc9YT8XUnf1787vQHI7OeVZds/RSVYrNpZABTzSongQZ42UDq2Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywybaSvZO2PD1hORDMU5NP8rMc9IHU7co3T0XASYdPNBs8K3sR
	Nzn15K1tyrXEGtTqyMb8Ba+5zKzla5fP3j8DGwFWvHX3I9HYBjA2/8Lil52eBrNWB3TBxMIcHsv
	XbCvzPlt0lQgqUUfRXGASlzD+l46RH+nT7s0j4FE7
X-Gm-Gg: ASbGncvKuBKLR0OTnw8uoT42It2aJU4GwY40V+6hs7jgj1pzo6sa8VxhCV6U6DCSvlR
	PfFPGS/LwLHuJ1lZe9VEbYqT5XUGEpqN9HNWFQ3Ki+Il82MrpVzy7O/1Rc+2nZPcBkmN0lyU+YQ
	OfbLYBU/11uTn/BC/ZM4NLjsgkeo4WtJSAkEdQdTMo460XDo0x5ECO9E4q/fDRjC38rtWs79IMl
	AEBYaAM0sbuR6wYHJpSQHz1J/CiM5DEW/JznaLmjg==
X-Google-Smtp-Source: AGHT+IGKRWDvD6PmfOHXQDWpFqztgRfUjHVbWDw7YUH4xk346B7xIJu3hGT2hAmt6rmv2thaI7rQd9xPFojMCCbRPgQ=
X-Received: by 2002:a17:903:2444:b0:245:f7a8:bc60 with SMTP id
 d9443c01a7336-2485bd93e9cmr1554075ad.16.1756163484628; Mon, 25 Aug 2025
 16:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824215418.257588-1-skhawaja@google.com> <20250824215418.257588-2-skhawaja@google.com>
 <aKy9z1oephUbAr_E@mini-arch>
In-Reply-To: <aKy9z1oephUbAr_E@mini-arch>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 25 Aug 2025 16:11:12 -0700
X-Gm-Features: Ac12FXzh7LaR57obZrQSkK9P_2qkr-4XDbUUBkl9CRa5pUZtiS7BRW2WaGI1HVo
Message-ID: <CAAywjhRXXjJA1irEUtU4XM0KGtMMKAcyDtZz9WX8OzH42sehjw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/2] Extend napi threaded polling to allow
 kthread based busy polling
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, mkarsten@uwaterloo.ca, Joe Damato <joe@dama.to>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 12:47=E2=80=AFPM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 08/24, Samiullah Khawaja wrote:
> > Add a new state to napi state enum:
> >
> > - NAPI_STATE_THREADED_BUSY_POLL
> >   Threaded busy poll is enabled/running for this napi.
> >
> > Following changes are introduced in the napi scheduling and state logic=
:
> >
> > - When threaded busy poll is enabled through sysfs or netlink it also
> >   enables NAPI_STATE_THREADED so a kthread is created per napi. It also
> >   sets NAPI_STATE_THREADED_BUSY_POLL bit on each napi to indicate that
> >   it is going to busy poll the napi.
> >
> > - When napi is scheduled with NAPI_STATE_SCHED_THREADED and associated
> >   kthread is woken up, the kthread owns the context. If
> >   NAPI_STATE_THREADED_BUSY_POLL and NAPI_STATE_SCHED_THREADED both are
> >   set then it means that kthread can busy poll.
> >
> > - To keep busy polling and to avoid scheduling of the interrupts, the
> >   napi_complete_done returns false when both NAPI_STATE_SCHED_THREADED
> >   and NAPI_STATE_THREADED_BUSY_POLL flags are set. Also
> >   napi_complete_done returns early to avoid the
> >   NAPI_STATE_SCHED_THREADED being unset.
> >
> > - If at any point NAPI_STATE_THREADED_BUSY_POLL is unset, the
> >   napi_complete_done will run and unset the NAPI_STATE_SCHED_THREADED
> >   bit also. This will make the associated kthread go to sleep as per
> >   existing logic.
> >
> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> >
> > ---
> >  Documentation/ABI/testing/sysfs-class-net |  3 +-
> >  Documentation/netlink/specs/netdev.yaml   |  5 +-
> >  Documentation/networking/napi.rst         | 63 +++++++++++++++++++++-
> >  include/linux/netdevice.h                 | 11 +++-
> >  include/uapi/linux/netdev.h               |  1 +
> >  net/core/dev.c                            | 66 +++++++++++++++++++----
> >  net/core/dev.h                            |  3 ++
> >  net/core/net-sysfs.c                      |  2 +-
> >  net/core/netdev-genl-gen.c                |  2 +-
> >  tools/include/uapi/linux/netdev.h         |  1 +
> >  10 files changed, 142 insertions(+), 15 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-net b/Documentation/=
ABI/testing/sysfs-class-net
> > index ebf21beba846..15d7d36a8294 100644
> > --- a/Documentation/ABI/testing/sysfs-class-net
> > +++ b/Documentation/ABI/testing/sysfs-class-net
> > @@ -343,7 +343,7 @@ Date:             Jan 2021
> >  KernelVersion:       5.12
> >  Contact:     netdev@vger.kernel.org
> >  Description:
> > -             Boolean value to control the threaded mode per device. Us=
er could
> > +             Integer value to control the threaded mode per device. Us=
er could
> >               set this value to enable/disable threaded mode for all na=
pi
> >               belonging to this device, without the need to do device u=
p/down.
> >
> > @@ -351,4 +351,5 @@ Description:
> >               =3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >               0  threaded mode disabled for this dev
> >               1  threaded mode enabled for this dev
> > +             2  threaded mode enabled, and busy polling enabled.
>
> I might have asked already but forgot the answer: any reason we keep
> extending sysfs? With a proper ynl control over per-queue settings,
> why do we want an option to enable busy-polling threaded mode for the
> whole device?
That's great. One would enable threaded napi busy poll only for
certain napis and not for the whole device, so this makes perfect
sense. I am open to doing it.

