Return-Path: <netdev+bounces-89450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 451478AA4B1
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 23:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C60D7B217DE
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D415B194C8E;
	Thu, 18 Apr 2024 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFVaEgAw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DB8194C83
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713475420; cv=none; b=BMc0ofNQp5cP02PixP49qQ/B2yLmbvKPwnMUwTDRWywZYyFZkj5p5TE2EF29MTv9DB7YYoQvvahWdlX30TZdhuuXMIdOlvs44SM7ZVQQvGAqj7/3jkdmPv+3dOvPC6iMEabDJRPjhRqVWGKUU0D8i0OJSy8HwabbZUMKF/68pM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713475420; c=relaxed/simple;
	bh=wYalYvd4bYEay973j3KTZyV29Ho5YwrE1KyGZ1KnlgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRFCWK5AVrNlmCYPyZZQGxHgs7NTmCLMXKgBpBOtnRkPuDePFeoZrkCBzyoIe9uvB2vdZZ151DzqnHrP95CelnyOheBOhw74k1QRQ/s2oIulfUcSVXXSOMKuLikfjfS/tSXlSTP3pARiRhTM3oswtQsPvURCvtPhi24YZKxrfL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZFVaEgAw; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a55323f2ef9so159349366b.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 14:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713475417; x=1714080217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYalYvd4bYEay973j3KTZyV29Ho5YwrE1KyGZ1KnlgE=;
        b=ZFVaEgAwWC/2Pvg7Ypnq/zIiQNSHCNnI51To28V5suYVoiQMxVk0bferCnPf5YGPke
         /P568lPj+RMGpsF4FQUtLz6wLUlnSDgKANDNBpZbLRw/QMaXspv0xELHWl8qkw3hFxJW
         GtTZKnjZykuH65OrN7AuVbmDzTrmhwxQpmQFSarL2wqWjrWzg0v/k6L97hFUSXsILSog
         zRoLNMWNXK1PhZKeKDdaKEsSCuHZHUufWb0g57M9qlx9yR0SbQy/bsLiAFYIDrnZk4UT
         6sW/O1jJOxeMqcorRBCa+Pw+aW7YO1jan+tD2MzTxs9oKXG8BCYCOJiZ528UW+tsml5A
         qgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713475417; x=1714080217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYalYvd4bYEay973j3KTZyV29Ho5YwrE1KyGZ1KnlgE=;
        b=Aunk2XR3JuJqJD1n+O05fDDW2/zBADgQbuupegOkXxlATz+Q2UjNaK5941Ye4obDZo
         W26lIYIWQSedWVsf8thaB1kQV35FwfvZR8tsHdXxGRLiF7IQN1cXJOWWJxy1g2JxKhLK
         7gDs7EnHU630uexsLhIJtWeTB3SL11Ydt544SpmDuahI3mU/50J8d1vhgNhrYqI+TWFV
         KIId9qMHox9ENaacg8saxaTwkWOxLg9UfWz/QkOZ03hWOPlnEp3RXESyiuGvHBunAJ9W
         hevWisfWzvrHjAzNM/nRGdrreM0Y7HuG0uYJUoUFEeMxl1Wh/soy1vfrSpsMS2jMkJj2
         TcAA==
X-Forwarded-Encrypted: i=1; AJvYcCU8H2f9HYkpLJ6Qi0mt89UkVKMnNgWjdCNHcPT5ZFme+gghxbFzLXAofSZQAwBJP9YUYn3BvMVj6ht4P+pA+RYkhVJLkVJy
X-Gm-Message-State: AOJu0Yy8kMNtToTFN4TzqQSq1sPmlkIX/oXMiej+Q26bxUNR0dLlSuoQ
	QNncQHOfLG3WrnNG+IWdbIv7983vhb+LRZ4Wy4oOqoIhseZY7MTP+vVRQH9ZXfhw4GxEsrGNk5g
	SGqHsktzc+pg0NP6CJualdIGL0r9CHAe83dz1
X-Google-Smtp-Source: AGHT+IE+jIlHU4WcaqMzFdFWnRNrWh1I/I1LmnfLavnHBCPlaJu7GYVzwrGYnuyYgovrzEFHVjqFlQyyrOWhsCBSVS4=
X-Received: by 2002:a17:906:f1d6:b0:a55:5c04:89a4 with SMTP id
 gx22-20020a170906f1d600b00a555c0489a4mr182160ejb.21.1713475417327; Thu, 18
 Apr 2024 14:23:37 -0700 (PDT)
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
 <ZiGNc6EiuqsTJ2Ry@slm.duckdns.org>
In-Reply-To: <ZiGNc6EiuqsTJ2Ry@slm.duckdns.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 18 Apr 2024 14:22:58 -0700
Message-ID: <CAJD7tkZOV4rQQ0s=bZT=vO-OT4FxBG+R4nypUKcQTRGap4BGHA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] cgroup/rstat: introduce ratelimited rstat flushing
To: Tejun Heo <tj@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	cgroups@vger.kernel.org, longman@redhat.com, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, shakeel.butt@linux.dev, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org, Wei Xu <weixugc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 2:15=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Yosry.
>
> On Thu, Apr 18, 2024 at 02:00:28PM -0700, Yosry Ahmed wrote:
> ...
> > I think this is an artifact of different subsystems sharing the same
> > rstat tree for no specific reason. I think almost all flushing calls
> > really need the stats from one subsystem after all.
> >
> > If we have separate trees, lock contention gets slightly better as
> > different subsystems do not compete. We can also have different
> > subsystems "customize" their trees, for e.g. by setting different
> > time-based or magnitude-based rate-limiting thresholds.
> >
> > I know this is a bigger lift, just thinking out loud :)
>
> I have no objection to separating out rstat trees so that it has
> per-controller tracking. However, the high frequency source of updates ar=
e
> cpu and memory, which tend to fire together, and the only really high
> frequency consumer seems to be memory, so I'm not too sure how much benef=
it
> separating the trees out would bring.

Well, we could split the global lock into multiple ones, which isn't
really a solution, but it would help other controllers not to be
affected by the high frequency of flushing from the memory controller
(which has its own thresholding).

For updates, cpu and memory would use separate percpu locks as well,
which may help slightly.

Outside of this, I think it helps us add controller-specific
optimizations. For example, I tried to generalize the thresholding
code in the memory controller and put it in the rstat code, but I
couldn't really have a single value representing the "pending stats"
from all controllers. It's impossible to compare memory stats (mostly
in pages or bytes) to cpu time stats for instance.

Similarly, with this proposal from Jesper (which I am not saying I am
agreeing with :P), instead of having time-based ratelimiting in both
the rstat code and the memcg code to support different thresholds, we
could have the memory controller set a different threshold for itself.

So perhaps the lock breakdowns are not enough motivation, but if we
start generalizing optimizations in some controllers, we may want to
split the tree for flexibility.

