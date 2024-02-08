Return-Path: <netdev+bounces-70050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9F984D748
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 01:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1B3286013
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 00:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8AB46AF;
	Thu,  8 Feb 2024 00:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0xdIXDU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFD3DDBE
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353322; cv=none; b=C5yhsn8ZCfZcaEPksYnh2kNDNQyPGXPCOwmAVPLvQVs4TWeeiPIDmrbcGr4AzbIukutTUzty5iRppC3NMu6DwTaNgP7a4/cJ2ZQjOrcqvjxN1c1xUWUNASz5fFp2DSaujwRz8nEGcH3lfErORscjDk9MAMvyM6UsjNA4tUhvRbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353322; c=relaxed/simple;
	bh=1IxU7L4pFB3hb8uCfCZkc7ZfbKjVvBxfOTZHi5X1YWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IScfjys/WNhmaERtyjkCnS/5ZCOeG6fdz+fTbm7tpYVfdoUCasoJw6SVQpenDWrJTM/xaeacurA3FsrFqDmDuoZXkcZsGyqncYhn4Y/wILU6B8V+BpGjKVW7MIMdVcsKLyDsQDONjSnzCvV+I6vALoZNaHsfJy2Gyws4ZqXWUcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0xdIXDU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5610c233b95so4446a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 16:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707353319; x=1707958119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IxU7L4pFB3hb8uCfCZkc7ZfbKjVvBxfOTZHi5X1YWc=;
        b=Q0xdIXDU1Yo8ByTtt9fj4L6BHesNJ5un/pRSUlDm26lKRoNFbF8jB0SfmBiWgDUEna
         Ns0FzspFtkcHiMracAk+lVKDF6aPKHZNrUN6HyqHVPd3yXiNKmvyIqNptnmKU9Ev8YFm
         +nnVcvJcaut2/bsk8/SJQojsFQvjf+Hjqb0F62oVQqkjPsVS1U8rqDA61/V6J/mNw9a3
         r3Gm2mbCygwrSS81m9BvU/Dkc+JTBQcFKPLca+kKtW7WIo+r54YtXiTFRSIH9N4G/us7
         5Ab388d9LAf7oCz111dyQ90MQ8xU415+KG3pveCzXwTC3pmMNp/BYHqiQAKKgM4aCgzm
         8OVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707353319; x=1707958119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IxU7L4pFB3hb8uCfCZkc7ZfbKjVvBxfOTZHi5X1YWc=;
        b=Mf2+arYUhZt99A48uYCUgRQhQzhhRkVU0DwGz4JFDLup7NLYQte1ZN6FU/FeE6CuU3
         68VL2uUj0LrBr1Klur2duQ2QVnpxusaOifuK8G1KPz+VsR9zGdJvoemulkNuxTeY59xc
         +Tud4D0952K6upTqMQLTNW675SZIOHHWELqQigDYr7oIV6qHW/rJr7SYQV9/auR0tBnv
         aQ3UdoM8nxSfoVB6GDYi4UnDu5xvH8zVtNe+NzVECVceCSF//BQY06avWGjHCpEO57vT
         M2DPdyx8NfRIxyvLSHGPfMoPiBiN1KtPr3Rvt2xSksWHnr2TeKaeP2C4+Myf1oOPlN4z
         OjNw==
X-Forwarded-Encrypted: i=1; AJvYcCUcz1zskTHIbJh79/Os00oe5964MkGh7k3FCVH06xpbQCNkbsOj8plea1ZWnt4lqVrV3Eo8x6EY10owJCObN1zzeyagsEUd
X-Gm-Message-State: AOJu0YwCqA0WJpgSJHxbPPSz+TCErFAHu5Or2yLbM7T14mdpda1OFMN2
	oWvGQFul6lsEH8VuGuKCsEpwJeTOXVJugf4z/lLZRej5WFzrqzal0lCgFdCBDG0wU0O4kkLKPAK
	hyx8aPt7HAPhmhkOaXek5dmQbdS/gVe3GOq4=
X-Google-Smtp-Source: AGHT+IH18hDVzvNb5YyAuUYWPNEroV45gLm7FQ9rS9O/AGuz1SRM2Z4BuoU8gaX1WDsJOq7P8i/QqCB+DWqM4iZMxN8=
X-Received: by 2002:aa7:da02:0:b0:560:eabe:e291 with SMTP id
 r2-20020aa7da02000000b00560eabee291mr1527538eds.9.1707353319013; Wed, 07 Feb
 2024 16:48:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204104601.55760-1-kerneljasonxing@gmail.com>
 <CAL+tcoCZG=SCPZDd3ErxFCW6K8A_RHaYR6vJTQJB_BOkhsg-JQ@mail.gmail.com>
 <CANn89iKRCxmMH5f_NxDCXHNzRvk+oKT7t9m3r_=hOwP5rSkwTQ@mail.gmail.com>
 <CAL+tcoDtiQJFuoeCUv3KMy5q8wU2jYoGRuaNJQrk5WdwHFnXNQ@mail.gmail.com> <CANn89iKgX=Ci93U1xpRm3P_3kjPsV_AnL_we6FM6mo8B+kTw9Q@mail.gmail.com>
In-Reply-To: <CANn89iKgX=Ci93U1xpRm3P_3kjPsV_AnL_we6FM6mo8B+kTw9Q@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 8 Feb 2024 08:48:02 +0800
Message-ID: <CAL+tcoA2vGwOgFj_kHYEmaDxXBt0c-bfBiXeqYYhgh6zWO5w9A@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] add more drop reasons in tcp receive path
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 9:37=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Feb 7, 2024 at 2:25=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
>
> > Indeed.
> >
> > It took me some while to consider whether I should add more reasons
> > into the fast path.
> >
> > But for now the NOT_SPECIFIED fake reason does not work if we really
> > want to know some useful hints.
> > What do you think? Should I give up this patch series or come up with
> > other better ideas?
>
> Perhaps find a way to reuse return values from functions to carry a drop_=
reason.

It seems feasible to reuse return values, let me work on it :)

>
> >
> > >
> > > Please make sure not to slow down the TCP fast path, while we work
> > > hard in the opposite direction.
> >
> > I tested some times by using netperf, it's not that easy to observe
> > the obvious differences before/after this patch applied.
>
> Sure, the difference is only noticeable on moderate load, when a cpu
> receives one packet in a while.
>
> icache pressure, something hard to measure with synthetic benchmarks,
> but visible in real workloads in the long term.
>
> At Google, we definitely see an increase of network cpu costs releases
> after releases.

Thanks for your explanations.

Thanks,
Jason

