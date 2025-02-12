Return-Path: <netdev+bounces-165668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F92A32F89
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F44E167108
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F53261391;
	Wed, 12 Feb 2025 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="06z5riO5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBA61DEFDD
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388286; cv=none; b=QsEu0zxIMbPLFdVAu19vMVzb4iJFH6TZZk2kCin3dpMXJ3HcrClF0iF4YbQEd5uWkedix4/sbePxgr5kGnvFjMouyNWT72x0hX5PtwmbgdFRDDwKWha+Oi8zOezvFrk64JACbCoIqRwfSoASOM0vrq77o7L4rEAl3esRDDXsPag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388286; c=relaxed/simple;
	bh=l+cWqnamQoHx+N7Kimd8YxSbO37JRmdE1+IO4t9I5w8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WuNRJN6xyv9Dqm0/YQn2fDOWnS5GIQvoPELHsRvgXErnqkgkwSYrSVb4P0mfklsU8lGlgnnRYGOTaM7x7/Cd5AwdVavP0x4jgTnG/TQo1V0tnj27oJtx85wIX7QtkW5rGIEQRV6nPzeQU7L6rFP4Ih8Bm4wkOxgf48ru+EfQ0AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=06z5riO5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f72fac367so221575ad.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 11:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739388284; x=1739993084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysBI1lKJKiCXV640ptiNSZHDkjEc3qz7bqsceA80Sdg=;
        b=06z5riO58YhK+AZKh4yrOWQZ8CWguvYzgQ3NE7m/KUEI5tkYIgpjJd/U4YWXMZBU9y
         HXRvAJNt8LkPBjBVjugAuVNE1UrjnSuukN9esrH5ixcDVrPf9GMEs7u12hRxMzC2fAkE
         CaD8DU6LfROPhwMzwvaz0O2DvuBKMbvYMJOkHLApANIi5fCOInbWkx3fzNJ1QPouvipC
         wE1eFqGaaCggJewC1kejDuZCTCvDJ/ApzbmSqZWEansP0KJhnuirNHxRAZVLaiO45NkN
         aYJJXV6H+bTAQamgg5ZbpaV4oq1X5da+xFhf0qYrYqzj1zo1QNaKQLXKsCEQbkUy8YnT
         TrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739388284; x=1739993084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysBI1lKJKiCXV640ptiNSZHDkjEc3qz7bqsceA80Sdg=;
        b=YSZEEnGJbmCoeo9XIlOWf6P1lMc05+zpWQEWE7+bIPpC5LZOuN1aXjj3w1vkCbeEXl
         cHMcXtyt3JkMno4uLQAOb4STNFdr1kHr/5+y+584Sko0xqMxQ32zfoeWoXnQ7Wq5dZjD
         7dmKiWvmh9lGtjIOKcari5MNqyw9BEhhhLocWxXQ9CXPXcJYBQdjuzavycmjTAtdwujQ
         2UNlJQiZn1yzjRp/kwRdFbfKP3Ev7lcE1ZabbgNMUTsDif+HE96kbEk6lfzQOjUzHdKu
         dg9ZRQR4Sql/ddoiekBEvYW97cbL50cSFw9VWOvbYgmxbQ2z67IYY0mBmCkm6l0EHv7a
         zY9g==
X-Forwarded-Encrypted: i=1; AJvYcCUzSg8wQDzyzXRuOOTJmq3GwttpOq0DYFDSIN2QSwxLgiY7VLxkez+ugkUO8FBW2cLR1iKthLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe0o0a4z6wsUWNRm/sN9c334HO0i+zoeQgCKZGBr/pp7Ww48BR
	EVyLdyUEsfC2jb9KHy3ucZmS9EMHa0HApDKLJ7VoMAN1DJZUpHj13AKnJa+bsQUl50XNGnM4huS
	+ggIwzaDwy1QLXZtrQvh7keixdCgbVz3xHEwg
X-Gm-Gg: ASbGncudqt/z/gFl0XSmoRa0mG3vp+RAFGu/RcWkix9+ildAtkCDzDsW+ymldtD9Q/R
	SlvG5GpsubDWRU+eEdbOnIZGn08ulvAKYWuXc6fOjiGO2TzapuE8aX0muLk5rgWh3wsiipa57
X-Google-Smtp-Source: AGHT+IG3mH0V0pqhkUrHd7i53pO09w3W4FM+WXo+DDwzObVvZimRDXWUBCK6ZJ6lGbkRD5mGoTECZFIJIWbQCd1Xlv8=
X-Received: by 2002:a17:902:fc86:b0:21f:2306:e453 with SMTP id
 d9443c01a7336-220d37075a4mr78545ad.7.1739388284328; Wed, 12 Feb 2025 11:24:44
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210130953.26831-1-kerneljasonxing@gmail.com>
 <CAHS8izMznEB7TWkc4zxBhFF+8JVmstFoRfqfsRLOOMbcuUoRRA@mail.gmail.com> <CAL+tcoDrxSgGU3G0a=OqpYVD2WAayLKGy=po5p7Tm+eHiodtNw@mail.gmail.com>
In-Reply-To: <CAL+tcoDrxSgGU3G0a=OqpYVD2WAayLKGy=po5p7Tm+eHiodtNw@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 12 Feb 2025 11:24:31 -0800
X-Gm-Features: AWEUYZl2GLgD-49XjfTGwLqGK2I-bG3cTjdo_9LJeB-0uQwwIptMQ0n0Ccuw_hw
Message-ID: <CAHS8izNSG_fC7t3cAaN0s3W2Mo-7J2UW8c-OxPSpdeuvK-mxxw@mail.gmail.com>
Subject: Re: [PATCH net-next v1] page_pool: avoid infinite loop to schedule
 delayed worker
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 7:14=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Wed, Feb 12, 2025 at 10:37=E2=80=AFAM Mina Almasry <almasrymina@google=
.com> wrote:
> >
> > On Mon, Feb 10, 2025 at 5:10=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > If the buggy driver causes the inflight less than 0 [1] and warns
> >
> > How does a buggy driver trigger this?
>
> We're still reproducing and investigating. With a certain version of
> driver + XDP installed, we have a very slight chance to see this
> happening.
>
> >
> > > us in page_pool_inflight(), it means we should not expect the
> > > whole page_pool to get back to work normally.
> > >
> > > We noticed the kworker is waken up repeatedly and infinitely[1]
> > > in production. If the page pool detect the error happening,
> > > probably letting it go is a better way and do not flood the
> > > var log messages. This patch mitigates the adverse effect.
> > >
> > > [1]
> > > [Mon Feb 10 20:36:11 2025] ------------[ cut here ]------------
> > > [Mon Feb 10 20:36:11 2025] Negative(-51446) inflight packet-pages
> > > ...
> > > [Mon Feb 10 20:36:11 2025] Call Trace:
> > > [Mon Feb 10 20:36:11 2025]  page_pool_release_retry+0x23/0x70
> > > [Mon Feb 10 20:36:11 2025]  process_one_work+0x1b1/0x370
> > > [Mon Feb 10 20:36:11 2025]  worker_thread+0x37/0x3a0
> > > [Mon Feb 10 20:36:11 2025]  kthread+0x11a/0x140
> > > [Mon Feb 10 20:36:11 2025]  ? process_one_work+0x370/0x370
> > > [Mon Feb 10 20:36:11 2025]  ? __kthread_cancel_work+0x40/0x40
> > > [Mon Feb 10 20:36:11 2025]  ret_from_fork+0x35/0x40
> > > [Mon Feb 10 20:36:11 2025] ---[ end trace ebffe800f33e7e34 ]---
> > >
> > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > ---
> > >  net/core/page_pool.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > index 1c6fec08bc43..8e9f5801aabb 100644
> > > --- a/net/core/page_pool.c
> > > +++ b/net/core/page_pool.c
> > > @@ -1167,7 +1167,7 @@ void page_pool_destroy(struct page_pool *pool)
> > >         page_pool_disable_direct_recycling(pool);
> > >         page_pool_free_frag(pool);
> > >
> > > -       if (!page_pool_release(pool))
> > > +       if (page_pool_release(pool) <=3D 0)
> > >                 return;
> >
> > Isn't it the condition in page_pool_release_retry() that you want. to
> > modify? That is the one that handles whether the worker keeps spinning
> > no?
>
> Right, do you mean this patch?
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 8e9f5801aabb..7dde3bd5f275 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1112,7 +1112,7 @@ static void page_pool_release_retry(struct
> work_struct *wq)
>         int inflight;
>
>         inflight =3D page_pool_release(pool);
> -       if (!inflight)
> +       if (inflight < 0)
>                 return;
>
> It has the same behaviour as the current patch does. I thought we
> could stop it earlier.
>

Yes I mean this.

> >
> > I also wonder also whether if the check in page_pool_release() itself
> > needs to be:
> >
> > if (inflight < 0)
> >   __page_pool_destroy();
> >
> > otherwise the pool will never be destroyed no?
>
> I'm worried this would have a more severe impact because it's
> uncertain if in this case the page pool can be released? :(
>

Makes sense indeed. We can't be sure if the page_pool has already been
destroyed if inflight < 0. Ignore the earlier suggestion from me,
thanks.

--=20
Thanks,
Mina

