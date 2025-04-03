Return-Path: <netdev+bounces-178935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F59A79978
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 02:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659933B507E
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 00:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255B1D529;
	Thu,  3 Apr 2025 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCAPpQXO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA7A927;
	Thu,  3 Apr 2025 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743641508; cv=none; b=kOUOvHmkC4cwEIATorpg+ETTcwAUS3KkStVfDl1bXhWcZ5xWepJdMC6K6O4UDimucR1npLpFjoN+yi0F2zZr6WVYfVVmdXMTCeXlvUbVhOvwO7ntY1x7qTmRm09ojO9x91enWmR/t7C1h8xwb0aASPb2az0u6fgIER56PFKwlIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743641508; c=relaxed/simple;
	bh=iryGazCjZUiwGGmfpxfw4Lc6UsOo0wCjVhD7QeGn3Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pF0gJ2/DNofNKUXz/bLkiLeaPeQ0VNmV/94mUh411uYcSLIM1lwf4VyNbkumrqzq4B1Mw3ejZlBXDhHZItuJ0ewMqqgbYXpkvqyR05G42rnDIyX5R09pCBHVfVem4TY/SAiQ4YpruBK3nyE+7qhI63qFfnhAuCZk8dPkwFOoFBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCAPpQXO; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47663aeff1bso3058011cf.0;
        Wed, 02 Apr 2025 17:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743641505; x=1744246305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zx+eNO28JnJFh8ii5WpyLNGRFtml7E13XoXgMVF7PjI=;
        b=SCAPpQXOyUK4aNZ4BOq3su3hGh3lNceDVgHHkU/Uk2f1sqMfHDIIRImPU/lK0XkXPP
         wNgST/iYU8leMBN6fxQdAksIMdJCfxBXAtxKCdGGPTOZcwGinsQ/u6vmiRxHCJTlgwB1
         wJ4Gdne1lnoP6qnQ31BZDmrY/zu7SFeNjhqqVU8HcqMcNeGQNhrTS8R6FF+PpHkaAoi9
         8tt2hoinyuo1G/7h5IAB+JF4icN128gzlmzUtvNa9h3wD3UDvEA8rei9nAcT5oUYEibt
         SwzlCx8dNKpik2DeemaXx80HOGYIH3dNAsl0rzAF1Qsf0Fyu+T3QyN+3Fndkrdn3Sdpt
         3fSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743641505; x=1744246305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zx+eNO28JnJFh8ii5WpyLNGRFtml7E13XoXgMVF7PjI=;
        b=Rns4arTUjGaRjYJbqrx3k+DqKECBxsuLLGrutB7Jc3R5mpOkLFu9BjsYA0H48yfbYn
         WJBO3Lag3jawGtD3MbCsl7cfD2x7/Nz59N7Td6XotQKaV+d9zk/pZ0llJMdUhvawkQRg
         8fdeuCocD9ruAHOGnunnsEg7k4xz6ynqHk5RDEPsdIKLvIbCA3vhGCNPsruPCZB/5TBV
         MfiHSTIlr7iBQSTAoTCaOlXALBcNvxBFYy9Ep38DyrAHiV985hzOU6eyfoBLn0F+7n0U
         YyWkKn/I0hTJkMM+Pirk7XPxRGstavLioNVxYx2DDNZQzZA5awtrYLJx0bygz7Xoeoa6
         Gd2w==
X-Forwarded-Encrypted: i=1; AJvYcCVYLT8B3u9b3bqA6/XK9qEw66RDmMWHxqtQpRh47cYvgz0RbYiCDE0KDrlAtfjJEcCbGZqqvhSg@vger.kernel.org, AJvYcCWskeBpa74p99gnqi27nMPZ5KbwLBnLKU7hkUSxvreDivUb7YLhFSasa6Sqz7pywOMjoS4T63yYDcH4f9U=@vger.kernel.org, AJvYcCX3tzgva2byb2OQfzFsqbQ8k1fSlVm50RucECSWNiIPkzZCZ7yMTmQ2IHbK2wxftpsEgowd2jmrcq9gnwsjvFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPHmAPIBU8Rwh3cVxd0b/ZbykKcChC5MWT16EolUOvfX6YmsHt
	vT43H8J2+xyCTFrTv3JKpicwRTrnw0Beghq7VsMAc6RgMAH2FxNN
X-Gm-Gg: ASbGncu8WmG3dVgPK5HBwKIUTkSwONgO9sHbdtTHsMPz0xDC26zJaJEgatNplmS7hgK
	VYDOnmvR3AXsxXhj2GljKm3oHM7I/vOKIPP0ikFRHPKTs4y0Xx7ATbi4CLW9R2p7F3IDIP1zveG
	3u6YiStkCAZbkllPIW1snlE4xky0RrDi+F1zu7xdlSzk3hXva5H+cONioRfTVAUWiXu0Uf8rVHq
	HAGH/BOJufCOy8ydcOxdBEfsToWjWP6LFMKlH/d0nakL2TX/vZTlkBx7zVnGDppWrY5vnf3J0I7
	e/qAqPdwV6W68v4yvLqEyfRojS/FLs3ms9wasA69B5qpbkGpUgNN9uCmg7vcmNAmzuAM8BOB0tU
	iJSQenVG/ETJAqq0ptCpKk+lqzm6sJG11Vjk=
X-Google-Smtp-Source: AGHT+IHl6vHyV+61sC/9TgrnujKk9+yg+F0OivRtaPSvyTERsIxjVAR8UgjX7v/h/tMPnV4WQljzGQ==
X-Received: by 2002:ac8:7dc4:0:b0:476:b56d:eb46 with SMTP id d75a77b69052e-47909f6f48bmr60270671cf.15.1743641504991;
        Wed, 02 Apr 2025 17:51:44 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b071c4fsm1313341cf.26.2025.04.02.17.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 17:51:44 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9D233120006A;
	Wed,  2 Apr 2025 20:51:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 02 Apr 2025 20:51:43 -0400
X-ME-Sender: <xms:n9vtZwGIv1W-NRG7O72_olayTo7Fuqz7u6_w2ZOoK9yTZXSMgIpeXA>
    <xme:n9vtZ5Xqnx1bqLa3pRymuSJmnltKSFNVWyfJ-SQaJ6bBZhyPkzb4lmobbhgR8BMB9
    1AyCLUsythLm7Hdnw>
X-ME-Received: <xmr:n9vtZ6IXlbi514jubk24p12hMBlsK4Umm4NzE6YegYRUw6aLZwDZNgh7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedv
    teehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeefgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepfhhujhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthho
    pegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigse
    hlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuh
    igsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpd
    hrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    thhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:n9vtZyEI8hT3qbBqN932Yi0iczrpy4remeEzNZJALBvwbRgsI-o8ow>
    <xmx:n9vtZ2XgCrcG_lnChEzVQ5UFuKqDxVtZbgnIlCHOtlFhNX_8KLafgQ>
    <xmx:n9vtZ1PlPqk6x3AntwbvLcHBXFxm9avAx0icBHtboMO5EgH1tM7gdA>
    <xmx:n9vtZ93H8Wb3K8NuSFA34no8HNF0d-OAH2QQTsD5f3iDndTQXcLTAg>
    <xmx:n9vtZ_Vz7_wc7icCGMnztOxic4PgFsso-8Sf6KCj-lBtoUfT0L3dD1y3>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 20:51:42 -0400 (EDT)
Date: Wed, 2 Apr 2025 17:51:41 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: a.hindborg@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, arnd@arndb.de,
	jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev,
	david.laight.linux@gmail.com
Subject: Re: [PATCH v11 6/8] MAINTAINERS: rust: Add new sections for
 DELAY/SLEEP and TIMEKEEPING API
Message-ID: <Z-3bnUucR5EX8XVu@Mac.home>
References: <Z-qgo5gl6Qly-Wur@Mac.home>
 <20250402.231627.270393242231849699.fujita.tomonori@gmail.com>
 <Z-1l3mgsOi4y4N_c@boqun-archlinux>
 <20250403.080334.1462587538453396496.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403.080334.1462587538453396496.fujita.tomonori@gmail.com>

On Thu, Apr 03, 2025 at 08:03:34AM +0900, FUJITA Tomonori wrote:
> On Wed, 2 Apr 2025 09:29:18 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > On Wed, Apr 02, 2025 at 11:16:27PM +0900, FUJITA Tomonori wrote:
> >> On Mon, 31 Mar 2025 07:03:15 -0700
> >> Boqun Feng <boqun.feng@gmail.com> wrote:
> >> 
> >> >> My recommendation would be to take all of `rust/kernel/time` under one
> >> >> entry for now. I suggest the following, folding in the hrtimer entry as
> >> >> well:
> >> >> 
> >> >> DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]
> >> >> M:	Andreas Hindborg <a.hindborg@kernel.org>
> >> > 
> >> > Given you're the one who would handle the patches, I think this make
> >> > more sense.
> >> > 
> >> >> R:	Boqun Feng <boqun.feng@gmail.com>
> >> >> R:	FUJITA Tomonori <fujita.tomonori@gmail.com>
> >> > 
> >> > Tomo, does this look good to you?
> >> 
> >> Fine by me.
> >> 
> >> So a single entry for all the Rust time stuff, which isn't aligned
> >> with C's MAINTAINERS entries. It's just for now?
> >> 
> > 
> > Given Andreas is the one who's going to handle the PRs, and he will put
> > all the things in one branch. I think it's fine even for long term, and
> > we got all relevant reviewers covered. If the Rust timekeeping + hrtimer
> > community expands in the future, we can also add more entries. We don't
> > necessarily need to copy all maintainer structures from C ;-)
> 
> It seems I was mistaken. I had thought that the ideal goal was for the
> same team to maintain both the C code and the corresponding Rust code.
> 

Yeah, that was the ideal goal, but Frederic said in the hrtimer series:

	https://lore.kernel.org/rust-for-linux/Z8iLIyofy6KGOsq5@localhost.localdomain/

, to me it's clear that hrtimer maintainers want hrtimer Rust patches to
go to rust tree via Andreas, and given timekeeping maintainers are
basically the same group of people, and Thomas explicitly asked to be
added as reviewers:

	https://lore.kernel.org/rust-for-linux/87o6xu15m1.ffs@tglx/

It's a clear signal that timekeeping and hrtimer Rust patches are
preferred to go to rust tree, and Andreas had nicely accepted to handle
timekeeping and sleep/delay patches, so it makes sense to use one entry
if he prefers. Hope this clarifies things.

> 
> >> >> I assume patch 1 will go through the sched/core tree, and then Miguel
> >> >> can pick 7.
> >> >> 
> >> > 
> >> > Patch 1 & 7 probably should go together, but we can decide it later.
> >> 
> >> Since nothing has moved forward for quite a while, maybe it's time to
> >> drop patch 1.
> > 
> > No, I think we should keep it. Because otherwise we will use a macro
> 
> Yeah, I know. the first version of this uses a macro.
> 
> 
> > version of read_poll_timeout(), which is strictly worse. I'm happy to
> > collect patch #1 and the cpu_relax() patch of patch #7, and send an PR
> > to tip. Could you split them a bit:
> > 
> > * Move the Rust might_sleep() in patch #7 to patch #1 and put it at
> >   kernel::task, also if we EXPORT_SYMBOL(__might_sleep_precision), we
> >   don't need the rust_helper for it.
> > 
> > * Have a separate containing the cpu_relax() bit.
> > 
> > * Also you may want to put #[inline] at cpu_relax() and might_resched().
> > 
> > and we can start from there. Sounds good?
> 
> I can do whatever but I don't think these matters. The problem is that

Confused. I said I would do a PR, that means if no objection, the
patches will get merged. Isn't this a way to move forward? Or you're
against that I'm doing a PR?

> we haven't received a response from the scheduler maintainers for a
> long time. We don't even know if the implementation is actually an
> issue.
> 

If there's an issue, I can fix it. After all, printk confirmed that
".*s" format works for this case:

	https://lore.kernel.org/rust-for-linux/ZyyAsjsz05AlkOBd@pathway.suse.cz/

and Peter sort of confirmed he's not against the idea:

	https://lore.kernel.org/rust-for-linux/20250201121613.GC8256@noisy.programming.kicks-ass.net/

I don't see any major issue blocking this. But of course, I'm happy to
resolve if there is one.


Regards,
Boqun

> 
> 

