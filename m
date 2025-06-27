Return-Path: <netdev+bounces-201713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB43AEABF7
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 02:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED04176CE5
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 00:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741182F1FE6;
	Fri, 27 Jun 2025 00:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hv7Tq2ce"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ECF219E8
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 00:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750985389; cv=none; b=g1pvvZpYQfADVKzvBv+cD9yYO3e0KGjMf+XnKVozXLElc5llkdLsg5VNuQwrZlIIWgtxRL4I8d4J1iralaoLEfWhbkKAgYLicUneajzpktMfUDuDeyUCWF1b2h681uZtrDbIoyF/CzcgNfVrZ6ctt6pPw9U3cX0cW7LNNxFLass=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750985389; c=relaxed/simple;
	bh=t9GzxriHItaYufrE46NVicjlDRSBAeoAcSwvCMiIbH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFYEc53fIetHmkc20ldpmL6m/+W4t8AgKzThz/ANUKnpK8wdDrowTcc1irFZ14b1pcGfpv9DSdNhc8BEc9h3y+zHnfOYs/CYQnVDxcGGsAc8+ZlHgG52PLrAiehjM44vIvHU1SH+ANH7kFCBNUxVkbo6CsTGOlW6FMc2HE7bTLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hv7Tq2ce; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso1823424a91.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 17:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750985387; x=1751590187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUS5s+FmIVOfinc0Mjca8HRs8d3I6dW0KrMZu0JgTXk=;
        b=Hv7Tq2cenGeScn7Mkklb3fBuBej7m8X00CdgvEvZGvmWy7Iv5HHEd79MOSycSUGJLF
         UOVhLVnMX2uh4YNVtZ4My7qlb7DrOvpGsm8R9trP3XxgWovlNhN8gIa62K/tgSzpZSmG
         Nz+TE5saafeM0pXxnEaMDYMf0Wo+r9HgklX5JULSXud9TLA8PoYRWryP3eb0weHuQ/H3
         DIioM9pPOL3do+LjqTEP39K9WaQi03+V9mX4So4rn/3Eqj7K8LzUK+phn0IP0BhsYt35
         A6EjZQb+G2u4JKd5vSwMFG2nLQovnhodbdkJVGF2m4DuZT/hljD8omGiO27B4fQd9n+3
         ggDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750985387; x=1751590187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUS5s+FmIVOfinc0Mjca8HRs8d3I6dW0KrMZu0JgTXk=;
        b=ISdPYsPpxQN/qgX4ZJxKS3vSspQhQ42nLfRzse2bCz9XGxlJJSTbQUUB26ldpWR5gw
         lhs4R5urKAVXo12QDhO+HFZZ8geoTqsT2PWZIMqdlEwW9fRE1kbvoC6POGuQROTokApg
         EWbsmFqJ8Bh+iNmEmtE1/P957Sb+h5FGg90ht6+YTsC6qaxJzs7jt+66CgPL60QiN9mu
         0ulhrj/6NyIqn58HNgl/hJeNLOsT0ISa9QMgxzBIh3NFI1OFm/2qdet3YSaTZu7XPwB1
         LW1/0FMN1rRXivMFBPH7KSv+r61CB/yn2FTYdQkgOwa3K/2tl/r7R68IMr2BqIeRVr+g
         D55A==
X-Forwarded-Encrypted: i=1; AJvYcCXaq5GMfFM+HLYC95EaiFR2ooT2c0UaRzeqv2XaLYMLlG6EvuCNrpDev+BMOJap8426UWLdJS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbzsvFfkn8XhtmcROltTFf4Ii6q4NhzVuntzY89mpnSqvbMnHC
	M055WCHlPBcbQ89TuO+QHv4QZBbRmJTgBX/6gTT/KRtoAJHm630A+wHBAk4GRuCD4nFt5DvG37Z
	LOe09lTXc+J6hyE4uCHY52wZ9hbDuuBzSPpFryamJ
X-Gm-Gg: ASbGncsk4CBNAAnU0ddbL2Irvf4ffGzr77Q7VwMG6KuHXFyBIp8lRtKXbQ4vVOKgQn3
	e3eNJQ6Eelna4kboa0Coox8t8LiGnkIjkgH1vH9wBiCupgFfzd1Uc5kbFbrvvTsX0juanfNJIpq
	hagtk3yrY4Ssd/YEcdH+wC11qbaGIYhzphIw3kq7Q07trLwByO5kQbgY68agIFpd8GLhAUu6eEY
	3FH
X-Google-Smtp-Source: AGHT+IEOSiNmZypnJfKZ76MuBP2z1p5J63JUg/XT6kp8Ckdj5f9demlFC0iYLsVSiFJR1y06q1lAK89qsFChtoixhc4=
X-Received: by 2002:a17:90b:384c:b0:312:959:dc3c with SMTP id
 98e67ed59e1d1-318c8fef406mr1573686a91.10.1750985387097; Thu, 26 Jun 2025
 17:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <6c33dd3e-373a-41b3-b67a-1b89ce1ab1b5@redhat.com>
In-Reply-To: <6c33dd3e-373a-41b3-b67a-1b89ce1ab1b5@redhat.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 26 Jun 2025 17:49:35 -0700
X-Gm-Features: Ac12FXzEPvkH5Um9N4GGbaWRTbQL6jULHxR80kaTO52nyps2QBHIy6nzH97I5bU
Message-ID: <CAAVpQUAT8gs10P9DbwfMNZu2xyzEChgMPMFzO9VKdDJT2oPcrw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 00/15] ipv6: Drop RTNL from mcast.c and anycast.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 6:27=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 6/24/25 10:24 PM, Kuniyuki Iwashima wrote:
> > From: Kuniyuki Iwashima <kuniyu@google.com>
> >
> > This is a prep series for RCU conversion of RTM_NEWNEIGH, which needs
> > RTNL during neigh_table.{pconstructor,pdestructor}() touching IPv6
> > multicast code.
> >
> > Currently, IPv6 multicast code is protected by lock_sock() and
> > inet6_dev->mc_lock, and RTNL is not actually needed.
> >
> > In addition, anycast code is also in the same situation and does not
> > need RTNL at all.
> >
> > This series removes RTNL from net/ipv6/{mcast.c,anycast.c} and finally
> > removes setsockopt_needs_rtnl() from do_ipv6_setsockopt().
>
> I went through the whole series I could not find any obvious bug.
>
> Still this is not trivial matter and I recently missed bugs in similar
> changes, so let me keep the series in PW for a little longer, just in
> case some other pair of eyes would go over it ;)

Thank you Paolo!

>
> BTW @Kuniyuki: do you have a somewhat public todo list that others could
> peek at to join this effort?

I  don't have a public one now, but I can create a public repo on GitHub
and fill the Issues tab as the todo list.  Do you have any ideas ?


>
> Thanks!
>
> Paolo
>

