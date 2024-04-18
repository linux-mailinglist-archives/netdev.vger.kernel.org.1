Return-Path: <netdev+bounces-88953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4604B8A9115
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 04:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776CA1C20CBC
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 02:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964B541C85;
	Thu, 18 Apr 2024 02:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xf6JRe/b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B313BB3D
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 02:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406459; cv=none; b=QZKdhEMu6jkMF8Ucq62+NPSX8Tw9DoNz5ZQmrCDFbo2jE1iUPROhVcynUz2W58Sa52T/x0MCIqTdUhURS3uWE+Ma3/883GVp8bDwGqTCyawY7ewVrGw6htXasuXaPUOCiRPLnh+HfEu01c4ek8n/naWlZ6DETAF2AxxT3yYUIdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406459; c=relaxed/simple;
	bh=xy2v9XI+hu3E9BlWSVNBUmL0WFz0IgfDKWRA7V5lq14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfYI0QLHx7TZdqj2QdWNzJywNgTMcBQI100hGZWU/AHiw+O3c1GG0g0S+hS/EL+sGr63SnWN82DqsyEzzhjWYhQzgLYdbSOQsid5EXmUQbB0b21/4rc+ZADZD3P1vNtW+9UPtpajUdFfpl2CVtYHO7mA1GeOV4dS+fAXtCq93lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xf6JRe/b; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a526a200879so31639066b.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 19:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713406456; x=1714011256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EWy3InHHcdr6Et3oKPqHiA/efKMXLdl9NWj5a3LIKA=;
        b=Xf6JRe/baC1edVV8aM4en7Mzm8ydcn0MB7AwP3LQU6oy8jgPmzDamgns4SNzEhLtYL
         wObW74eejHnRfU0kjoI7K4+HOo77nYZFDfVNQapiD/kMvskbuiGtTWFd8Irk1iRNtWy+
         0AzQ/3klXzvrnr+h26siGOQmNKVTQ0sHasRzCcgMzvVPd+wM749uwPQbDwToXZgrZ3Ve
         N3HHqGg2755agdAn/OU6iWkwxy5Wvh8j+OQkiSjiuuEWc49ZJrld7OfhCc9wNRZj5lB1
         Tb3M0PSReI9r9vHMOajseP7+E7PhEj+ecj5Ojz1EEjLBqyqvNVgmhZ4Nti+LNuENnJYM
         zyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713406456; x=1714011256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EWy3InHHcdr6Et3oKPqHiA/efKMXLdl9NWj5a3LIKA=;
        b=A9xWkTNm2OAlfGOhOQqvLOFruV4eOXdK9JEdd0pg1DlC2nJvntd3TymG5CWJz0T3D1
         6fCZ4bht/qawkIqpF8rXZYi4IoqZUus8NTgbtEoqSxtZTYbwITIcDhMmC38JKMUO0Fhs
         RsXzBuj94WnQOKqH/iKvLm+3/qz969zmKPMNuRe5cuk9a+aQJjSgBcpYjwaFJcIV6rJo
         +UTEOS86VLME1UafPsQOcvI6o5Wwv5cdeP919TKQni6H+3x1F9OkJ0i2bApTDJCzWZGy
         NwVue7r8hhAWZRltwEN3tXhbCAldeo68wU7xBTTnwno5q98JsPLuSvJIjWbJ8jmRBy9P
         B3uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxqn31LpDT1kt9fYB439nDsZuu1tGCm1fyN608n3DBXroMTEGfISKKIhOgAYRCaJsXqUrpHaOwbcSlN3+UiihS5wnUe+Dh
X-Gm-Message-State: AOJu0Ywolfw2E4OD7K7K+M9hYivAT3vMSgFhs9dAGf4nmrCaZVCnUMXa
	a9zj7r7wlIA4rsyqdnbncGMc+ADRr3TPF542lg2Poaa2mRXrEKJiQo8E+AzOB1X+HdAAr19ZLFM
	VzmSjUqjCU0fT2/BVs+dKfjIfueNiuSJzQcIR
X-Google-Smtp-Source: AGHT+IE/Nf4C5eaH5s4T2RRQ0jDt7/fjhylkOElaSpZipRuSnyI2rIKGrPh8cigEE9JO5l6XGaOIHOMiew3CNftZbYw=
X-Received: by 2002:a17:907:6d07:b0:a55:6f39:3364 with SMTP id
 sa7-20020a1709076d0700b00a556f393364mr296261ejc.15.1713406456189; Wed, 17 Apr
 2024 19:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171328983017.3930751.9484082608778623495.stgit@firesoul> <Zh7vuBRbA9rT5OCO@slm.duckdns.org>
In-Reply-To: <Zh7vuBRbA9rT5OCO@slm.duckdns.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Apr 2024 19:13:40 -0700
Message-ID: <CAJD7tkZhjYZQqsnTvUnv9EB1KUNyKijxLbYLOMsEcsRcZw=j3Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] cgroup/rstat: global cgroup_rstat_lock changes
To: Tejun Heo <tj@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	cgroups@vger.kernel.org, longman@redhat.com, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, shakeel.butt@linux.dev, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org, Wei Xu <weixugc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 2:38=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, Apr 16, 2024 at 07:51:19PM +0200, Jesper Dangaard Brouer wrote:
> > This patchset is focused on the global cgroup_rstat_lock.
> >
> >  Patch-1: Adds tracepoints to improve measuring lock behavior.
> >  Patch-2: Converts the global lock into a mutex.
> >  Patch-3: Limits userspace triggered pressure on the lock.
>
> Imma wait for people's inputs on patch 2 and 3. ISTR switching the lock t=
o
> mutex made some tail latencies really bad for some workloads at google?
> Yosry, was that you?

I spent some time going through the history of my previous patchsets
to find context.

There were two separate instances where concerns were raised about
using a mutex.

(a) Converting the global rstat spinlock to a mutex:

Shakeel had concerns about priority inversion with a global sleepable
lock. So I never actually tested replacing the spinlock with a mutex
based on Shakeel's concerns as priority inversions would be difficult
to reproduce with synthetic tests.

Generally speaking, other than priority inversions, I was depending on
Wei's synthetic test to measure performance for userspace reads, and a
script I wrote with parallel reclaimers to measure performance for
in-kernel flushers.

(b) Adding a mutex on top of the global rstat spinlock for userspace
reads (to limit contention from userspace on the in-kernel lock):

Wei reported that this significantly affects userspace read latency
[2]. I then proceeded to add per-memcg thresholds for flushing, which
resulted in the regressions from that mutex going away. However, at
that point the mutex didn't really provide much value, so I removed it
[3].

[1]https://lore.kernel.org/lkml/CALvZod441xBoXzhqLWTZ+xnqDOFkHmvrzspr9NAr+n=
ybqXgS-A@mail.gmail.com/
[2]https://lore.kernel.org/lkml/CAAPL-u9D2b=3DiF5Lf_cRnKxUfkiEe0AMDTu6yhrUA=
zX0b6a6rDg@mail.gmail.com/
[3]https://lore.kernel.org/lkml/CAJD7tkZgP3m-VVPn+fF_YuvXeQYK=3DtZZjJHj=3Dd=
zD=3DCcSSpp2qg@mail.gmail.com/

