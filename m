Return-Path: <netdev+bounces-69822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D85884CB84
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8AFDB24F73
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 13:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9179576C77;
	Wed,  7 Feb 2024 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhWqKk2a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B7F24208
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312350; cv=none; b=cKAN+i00+H+Uq8VW+qM0UfuuAjX0vIWYfX2bw5MzGhvEcQN+T9tvfXCYyBKffQUdEJz7Yy0k1hOW26K3cnvgDs0udcErQKCqWBNgxpuY9gWtjJr/jkZmzHS7YIm8/ttwcW3L/JFCDNZ9DzQ3ysYNfPZp8yVYsyqJsH2gDoj/DjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312350; c=relaxed/simple;
	bh=+QsgyuYNoWCk8wVF5ZqzxLQ6qVXP4ZFpBcNhhlrdIxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fk8bFpdbSXUrnTFQPKyu3234qVHiA01Q+AC+E0i/5mv7Zm+k+bVZsQ2ZuDLqOujJH8dK5I8LSseHVvwGbagixfYnOSjrbCIyENaWS/HkXK8W3LDjtB+TGjRukis6cA3vZVKsY4l7Lv+j+NuMl60Af7o876EaTRxcezPB8FaMBMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhWqKk2a; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so724758a12.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 05:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707312347; x=1707917147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAU5ib0hhNAsZ6zmk0yxJI7uGpf7i1U1zZqXQy+FsqY=;
        b=IhWqKk2a/jolOyyCueBetzKgstNuInbvd3qN0yFDR78bW+nq9jOIBYSKKR3FdHBSbn
         eET4B+0m7zgcTKUibBHiKapBJU0DyANWKHqwPt0SPiovvlC2/uxudCyhvY45Ibycx2+T
         BzBMRNdlCk1qS1Lx4ieymQVpUP5h1gp15pVTMrRmbU3xaj6scSLIhrou/qSXHbgUleOr
         Pc9avHEjkzvfY9LCAd/h1B1+IHCbyzLYPLK/ePRVTSNI0KV2T8Zhpk/uEY0qsl+D8g/j
         TCvVyvMCOgr4vqe+os+6ZE+rjvNh6l0G+br5Fl6V3Nqr8gvVsP8TQDKoMoN4p7Ri5m0c
         nzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707312347; x=1707917147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAU5ib0hhNAsZ6zmk0yxJI7uGpf7i1U1zZqXQy+FsqY=;
        b=X8Nzo1SBHpAIQ99UqU/tCyywPiMTcOMhETHfmN2A+Q1d2sc0bQVlpYky6kplJFse/H
         I+lnQdRjQqhcfSF5h0uR1AQYb4uzglZjFAzi6GVjYIHKDh45ez+1R6gQPKd3zM4rEKQi
         vbiBuakSmYCEq3jBAus3JtmevSdTnYrEfGvhzSWGGDixmukeNh7FxSlvmB788FY/dOGd
         3xwD/GmiASKipsBSOitS/5cJzYrB8M8dUeDC+m2JWHzxpWXQ7RlSjUNEhApdO2RA/qW6
         qbVuULxxt6ZSYKyxA0XGO5Gmx0ISYMeSKw+4Feb0cvzLzJG1t7yi6Btip2nyab7TDGof
         sRXQ==
X-Gm-Message-State: AOJu0YyplYAHdCKPrB/SJRZtX/yYwS9Ienjtw/l+D/9EhzxZtQkRuz9l
	FVop56ne+xF5frS2b/YvGvG8i8qrjy2OAZeolRY3Hhr4ZhaUAq3deN+bFfJ1O59ZBRPbYsSRvgp
	UHwEbShT4jIjVBXHWufpBx+Wp11ZVCBcBlRjYQQ==
X-Google-Smtp-Source: AGHT+IEvyww/g53ibFGCl5+b6SrXhyYKdc38rVpAsNoJeLxrJW156kPnWZObtMgwDrl6raVs3DCsBvb6qTfujKn88lA=
X-Received: by 2002:a05:6402:358c:b0:560:c77f:a11c with SMTP id
 y12-20020a056402358c00b00560c77fa11cmr2436676edc.10.1707312346972; Wed, 07
 Feb 2024 05:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204104601.55760-1-kerneljasonxing@gmail.com>
 <CAL+tcoCZG=SCPZDd3ErxFCW6K8A_RHaYR6vJTQJB_BOkhsg-JQ@mail.gmail.com> <CANn89iKRCxmMH5f_NxDCXHNzRvk+oKT7t9m3r_=hOwP5rSkwTQ@mail.gmail.com>
In-Reply-To: <CANn89iKRCxmMH5f_NxDCXHNzRvk+oKT7t9m3r_=hOwP5rSkwTQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 7 Feb 2024 21:25:10 +0800
Message-ID: <CAL+tcoDtiQJFuoeCUv3KMy5q8wU2jYoGRuaNJQrk5WdwHFnXNQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] add more drop reasons in tcp receive path
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:22=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Feb 7, 2024 at 3:24=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Sun, Feb 4, 2024 at 6:46=E2=80=AFPM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > When I was debugging the reason about why the skb should be dropped i=
n
> > > syn cookie mode, I found out that this NOT_SPECIFIED reason is too
> > > general. Thus I decided to refine it.
> >
> > Hello, any suggestions? Those names in the patchset could be improper,
> > but I've already tried to name them in English :S
> >
>
> Adding &drop_reason parameters all over the places adds more code for
> CONFIG_STACKPROTECTOR=3Dy builds,
> because of added canary checks.

Indeed.

It took me some while to consider whether I should add more reasons
into the fast path.

But for now the NOT_SPECIFIED fake reason does not work if we really
want to know some useful hints.
What do you think? Should I give up this patch series or come up with
other better ideas?

>
> Please make sure not to slow down the TCP fast path, while we work
> hard in the opposite direction.

I tested some times by using netperf, it's not that easy to observe
the obvious differences before/after this patch applied.

>
> Also, sending patch series over weekends increases the chance for them
> being lost, just my personal opinion...

Oh, I see :S

Thanks,
Jason

>
>
> > Thanks,
> > Jason
> >
> > >
> > > Jason Xing (2):
> > >   tcp: add more DROP REASONs in cookie check
> > >   tcp: add more DROP REASONS in child process
> > >
> > >  include/net/dropreason-core.h | 18 ++++++++++++++++++
> > >  include/net/tcp.h             |  8 +++++---
> > >  net/ipv4/syncookies.c         | 18 ++++++++++++++----
> > >  net/ipv4/tcp_input.c          | 19 +++++++++++++++----
> > >  net/ipv4/tcp_ipv4.c           | 13 +++++++------
> > >  net/ipv4/tcp_minisocks.c      |  4 ++--
> > >  net/ipv6/tcp_ipv6.c           |  6 +++---
> > >  7 files changed, 64 insertions(+), 22 deletions(-)
> > >
> > > --
> > > 2.37.3
> > >

