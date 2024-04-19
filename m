Return-Path: <netdev+bounces-89730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAA88AB58E
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 21:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07EE51C20F9D
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 19:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073EB13C911;
	Fri, 19 Apr 2024 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KgzeKJG/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D4C13C80A
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713554774; cv=none; b=moKaPGFy8fhCsb4S99cQ35uxEX0P3vgNSIg2lTJvV9m7OgCIWB9sINK5HrTFQOJd3c7nfdCVkkv+gu8jb2AYD4JXF3/yCRhVzbywKX5tnal1niakyaZel06Po6oOqV5g2mLpiAa7+sVdM8TY4hLpmT5gz9Xz0QQbYZ2zoxc9WqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713554774; c=relaxed/simple;
	bh=EdC0cGkPp/KdKeI1Kb/6RwCL6y1AT+p3suMsbxZCaso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXyNOEHqBXTLbJN5brXK/iWD5EsDAAP6exetrFLVqT8Ufwjv/ybPa77XHVAqB1XVC0aRSWjjRVtN+oRUe+O2ohxvCjwfNnigDeQMcjJ2ErCuYW/k/keYtp+7N9rn3yZ5uupUIBhwmwtI/d7+mbBX9vEAaHNTNl2EHmkcsKHlc5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KgzeKJG/; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5176f217b7bso4083021e87.0
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 12:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713554771; x=1714159571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jD0EhyCifuBQLkCgtTMY21veWhe8WpFtZANsrLOqmw=;
        b=KgzeKJG/+ttl3iKp6CTfLXe4CISeZ3XMk77y75QIa825gBnZx6oo9jVu5uvE9F7tut
         MIiUb8VLbClGl/VcyzAO0bZzNmthe3/0fvTN766Kq/Cgg2TTnt2gvBUIKnLiT1SgaMAG
         pmGM7yr7wBS+uXkSYYD8gtjfK5G2sB65AtKEeTRxJ949mxH2UDApL7iSaxW2JU6XufEW
         50Or1Pjg0fl5hwbe9zNJSG+kHotU0efDJ9IQg8fevGkdyUSJvmSHxNfB4CfgyvoYR1AC
         sVtLoAztoKhHZscOhowrCMFFoVKB5+/XvnbzfMt6HEFkuTJG78XX7rPEoSI8btUraBoS
         v8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713554771; x=1714159571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jD0EhyCifuBQLkCgtTMY21veWhe8WpFtZANsrLOqmw=;
        b=u9VBC5OZJn1Q0O5cKlH3iggmI8C4FMkYLeqHgR6t6NAfshk7I2mU0RHsKFZAAEWQLi
         AZ6xAKw0iGWAv40adg+kZ2AsR0uuqHbF/Wjv56PAJUvR4rwEZNSaWXPpixplcUEXPynI
         9fQEmP8Emr9A7WXnlguDAMnr2zDTAa3IVBrId+G4jFzOI+NPnmklqhP1S5FCo3ZEPFA6
         B1Uly8YiNYHajsV69tkFYKQuD+WE+380aj2g9+MvZrUeuX88zhS0B21H2IfCzCh17PRh
         hplVhZOdsbPC6y7zIzBx50KMg2/0yICTuUvWtAbB0AAH+xdDYBIbYlL9WrToMzm7q0N4
         leSw==
X-Forwarded-Encrypted: i=1; AJvYcCVvrDQvD4aPSIUDyZGH73zZl6k5CHlhwT2zOHTTWpiOdpt9fHQny45o19VnHAQV8UYMe72dSZ9OPz7Y0oVXcVbIbkQmXSGV
X-Gm-Message-State: AOJu0YwrnTc9wQrDCH9L5BzRtPb0c6eSs2KWFsvAUURAmQZny+VoaG6D
	z++SQZuF6Ig0kT/AqgtFmcJT+oTydJ3tyeDT5Y4R2rVxzNKDmw2OUfJzoKlfe5nOyW5exWoAkws
	vnPgrOR42TqaSiNQZiW+G0MP2d3VYLHc07a2A
X-Google-Smtp-Source: AGHT+IG7VL6KZ/P5UdQBTbJCd+VjQRvtNpyhd38tP7Or3vQWzXSTZExyuSTBKhBZU9qfTY773qr5ITgLc3HCzj5YcEo=
X-Received: by 2002:a05:6512:3f18:b0:51a:dee1:d41e with SMTP id
 y24-20020a0565123f1800b0051adee1d41emr294169lfa.61.1713554771092; Fri, 19 Apr
 2024 12:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328990014.3930751.10674097155895405137.stgit@firesoul>
 <CAJD7tkbZAj3UQSHbu3kj1NG4QDowXWrohG4XM=7cX_a=QL-Shg@mail.gmail.com>
 <72e4a55e-a246-4e28-9d2e-d4f1ef5637c2@kernel.org> <CAJD7tkbNvo4nDek5HV7rpZRbARE7yc3y=ufVY5WMBkNH6oL4Mw@mail.gmail.com>
 <33295077-e969-427a-badb-3e29698f5cfb@kernel.org>
In-Reply-To: <33295077-e969-427a-badb-3e29698f5cfb@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 19 Apr 2024 12:25:32 -0700
Message-ID: <CAJD7tkbXgd1jHA2OYppdyfPnMR5aBtee0KxSHLBsZ=78eGG73w@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] cgroup/rstat: introduce ratelimited rstat flushing
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	cgroups@vger.kernel.org, longman@redhat.com, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, shakeel.butt@linux.dev, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org, Wei Xu <weixugc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 3:17=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
> On 18/04/2024 23.00, Yosry Ahmed wrote:
> > On Thu, Apr 18, 2024 at 4:00=E2=80=AFAM Jesper Dangaard Brouer<hawk@ker=
nel.org>  wrote:
> >> On 18/04/2024 04.21, Yosry Ahmed wrote:
> >>> On Tue, Apr 16, 2024 at 10:51=E2=80=AFAM Jesper Dangaard Brouer<hawk@=
kernel.org>  wrote:
> >>>> This patch aims to reduce userspace-triggered pressure on the global
> >>>> cgroup_rstat_lock by introducing a mechanism to limit how often read=
ing
> >>>> stat files causes cgroup rstat flushing.
> >>>>
> [...]
>
> > Taking a step back, I think this series is trying to address two
> > issues in one go: interrupt handling latency and lock contention.
>
> Yes, patch 2 and 3 are essentially independent and address two different
> aspects.
>
> > While both are related because reducing flushing reduces irq
> > disablement, I think it would be better if we can fix that issue
> > separately with a more fundamental solution (e.g. using a mutex or
> > dropping the lock at each CPU boundary).
> >
> > After that, we can more clearly evaluate the lock contention problem
> > with data purely about flushing latency, without taking into
> > consideration the irq handling problem.
> >
> > Does this make sense to you?
>
> Yes, make sense.
>
> So, you are suggesting we start with the mutex change? (patch 2)
> (which still needs some adjustments/tuning)

Yes. Let's focus on (what I assume to be) the more important problem,
IRQ serving latency. Once this is fixed, let's consider the tradeoffs
for improving lock contention separately.

Thanks!

>
> This make sense to me, as there are likely many solutions to reducing
> the pressure on the lock.
>
> With the tracepoint patch in-place, I/we can measure the pressure on the
> lock, and I plan to do this across our CF fleet.  Then we can slowly
> work on improving lock contention and evaluate this on our fleets.
>
> --Jesper
> p.s.
> Setting expectations:
>   - Going on vacation today, so will resume work after 29th April.

