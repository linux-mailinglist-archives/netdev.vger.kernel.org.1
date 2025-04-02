Return-Path: <netdev+bounces-178850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50289A79344
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55AD13B7562
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15796192D6B;
	Wed,  2 Apr 2025 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKNP9K5O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F669192B75;
	Wed,  2 Apr 2025 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743611367; cv=none; b=ilxYQ9x+EIoOII1tpQrGIwHtwc5n4q9TmslWmQnZO2uwN1KzO+7+SzY5XoPhW4Cn6p5Tkn2MdbA8TkWVS20PqyhdPUeGYieHeXOZ83hvsuqiPQX50OrEd+5f3FZ5uGbpLFeknj8Bl/UOZDbf6wz3bs1nzrWkKZZ9CgNBP2DA7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743611367; c=relaxed/simple;
	bh=hpNglcGCD/ImR4MbnHVfaGtof3Zs/Gn5mxoDcxHVy5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMTLhK2IkGubVE2Cw5iB9YB1a1nZrTfnHXEpIptXds39VsK7YwreRNLqXf7TwzdhfbQBxSHuOPs2c2GIginwaH2SjWK01E1dwgd++Isd5CtWSUhGXdok5iQVucM3kxEfGiAIri1GlftO/pJRZgFNL41u941WBp8OqlmKzvUmD5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKNP9K5O; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c546334bdeso513844785a.2;
        Wed, 02 Apr 2025 09:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743611364; x=1744216164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNud7VaCUDeA+FyZPSt2bHJdSWzIBv4EDqJHrTjrcSI=;
        b=EKNP9K5O2o3ZWV1AtLjwedC37+zomjYHxZqt/6WfqY7fLtfHyZ0RPqMO5zVBUGFOal
         JZBegA5LDj5SLnzbCa42TU7igPjUbalYoVNQAYQbdrdGouussVRaFBi7TPr9DGWCBayi
         i9fQoJwKb4cJh++P5lOOdP6p2og1LHs0ro4KMRfKNxtEtiSkGRcpbuw+4xN4geX/0Sza
         WUO3B95LvvOEK34bhHP1zKJ+WmKSCjkNP8gAUNQ0+hLICTLExIgLRpnCQYj91ooelrpm
         vBoxg3WEEM/6g/y13IiydpQcyMOPJJyGI/FhpzmiL09FfI6pGD7ylgaqSLFMNz/zZxvb
         wv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743611364; x=1744216164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNud7VaCUDeA+FyZPSt2bHJdSWzIBv4EDqJHrTjrcSI=;
        b=kD+VSykTy1piL9jmLa38D2DPe/EAl2lMwPUyO5JhskZ6jXBwmq8GUdHEEO7cbwHs0y
         yjwbeRzyke31q8XLgyUlQVm/N7btlUGlpIt+0qu0RS0wOnO0NWUq4FzqkVsAk84EpQDY
         ri/fJqZeqnJ6QYV74bFad3XghQGMtfME+Ewa4Riw2/UgHzx4SUKhszfwuoAAWBrEv5JD
         tXb+1dkXdocyFrfy1BgGx05YYB5S+zbMkPzN9uMyjZVfDKEIjSlZ34cEyVWr0ipFsy+2
         nOFNX75lAtghdZZAyvto6HLDySPHF8TQqWb/xutVburXiydCKwGjasnisLdGCCuVPk3a
         XSkA==
X-Forwarded-Encrypted: i=1; AJvYcCV9aXEUyv7GLYPuoc+Aa4sP9jF0q/OUnf23Knk+o5pmV0ot1PH+paAIgwYlHykHTpDTIWkmH1yvt27EQs4=@vger.kernel.org, AJvYcCVjy6VaHiWWN1pnIGSxY0ECR0JawoBfdP2xcm/ESFw0AvEig+qZErVIvQDvx7NybzqvfHBR/ePOuUhzhAdBuXc=@vger.kernel.org, AJvYcCWMyPc40PGAtT/FmZCkv4RaY4dwNrdi3b0j/Fmr3wpzFbXihI8GYJWuqIk103lzSNW9G/0ViTp3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk+XMBIgeDjEReFYHwjpIXfFnWFm2aVT63SAMikI3EHAPcz6lQ
	9XEXyNDt+n2DMAjgConlU3zh+jVWb44E7iJ/ptxZxi2ymW9AM3vk
X-Gm-Gg: ASbGnctud2EjVlZ4tN/0IBJrM5Tx8pGgTYYXdCFDGRt5Pp9/0jx+sIDgA9GoNMcVzyB
	ggTSMKMDcVFwNI9/YxU0Mmrgs2lWbZI8v1C64INECsRyLcbEaboSYGijePdvydgU/8551Ya4dET
	N0s5T0f/K9mNWzRfVfY3XOJbWewc72N6//RZJgTAfmTjNfJC1onuddvCCJObjRBQUKbgq6LRGdj
	xyzdZtuULN/idJK9WGaKzzu+3bjS9u3OegLOyt8kzQWT30P0CD/5ZhH3yqj8gZxPyMiX9NE3rE/
	NjE2g2R7W3Aiyn88XoyaIdvmrDI+58u/LnYsWx/HFSZSCh54vOrg4bPvXoDor3HxUjlbtqMG7Fo
	Q+CwEuU1vjNNXbweuzItgmTVKQgy36ZPMB4M=
X-Google-Smtp-Source: AGHT+IEp0HORSr1/7mlmiTWemxCFPiCAqmQppHiDsaiqEfJoplVhG4xWytAzoUDxpOw1aGDKv6oBhg==
X-Received: by 2002:a05:620a:c51:b0:7c5:b90a:54a6 with SMTP id af79cd13be357-7c6865ecef4mr2469143785a.13.1743611364038;
        Wed, 02 Apr 2025 09:29:24 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f7682e57sm805481085a.39.2025.04.02.09.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 09:29:23 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id AA1F41200043;
	Wed,  2 Apr 2025 12:29:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 02 Apr 2025 12:29:22 -0400
X-ME-Sender: <xms:4mXtZ8woKWkRmc6VaQ-rIcgyTGESwQvikWY8xkJYUxOR4tmoFHdDZg>
    <xme:4mXtZwTDM43jX0f8oRqX0xR8iAFLgOgLpE0XaWm7m-XV6ArMWhyuYHKVf5D_DYxvZ
    9Am9SzkPOFdQnQbKQ>
X-ME-Received: <xmr:4mXtZ-X4T9elYX3BYdy0dkbtAx6frPy3TW91RgUMNG6dZINpxoZ-ed1Cobk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeeiudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpedvgeeifeehtddtffehffffvdfgjedtieek
    heefgedtteeluddvheefjefgffejteenucffohhmrghinheprhhushhtqdhfohhrqdhlih
    hnuhigrdgtohhmpdhgihhthhhusgdrtghomhdpudeirdihohhunecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprg
    huthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsgho
    qhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprh
    gtphhtthhopeefgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhujhhithgr
    rdhtohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopegrrdhhihhnuggsoh
    hrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhi
    gidruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhk
    rghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuh
    hmihgthhdrvgguuh
X-ME-Proxy: <xmx:4mXtZ6gjqtRfsx2orknyTbTJ0tqj1-ho7s1qgQvsr4Kdf26SgtDtdQ>
    <xmx:4mXtZ-DinTPeuo_LSa-tRxhcFC-wuMEc-z35r74kGpFsITa8OKc6gg>
    <xmx:4mXtZ7J1dbuACXpbSA72vqOv_A39r_I_YOhLDRkBIt9OVQJXK0PAhw>
    <xmx:4mXtZ1CadqeRsHajfSSAt9OrlDIUWmeb81E5EwE0NDH6XaE5OPa26A>
    <xmx:4mXtZ-xglIbgDySJhM9CoXucF1DHhWWVtaS8LMrLnjXd_wMNcantbHkG>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 12:29:22 -0400 (EDT)
Date: Wed, 2 Apr 2025 09:29:18 -0700
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
Message-ID: <Z-1l3mgsOi4y4N_c@boqun-archlinux>
References: <Z96zstZIiPsP4mSF@Mac.home>
 <871puoelnj.fsf@kernel.org>
 <Z-qgo5gl6Qly-Wur@Mac.home>
 <20250402.231627.270393242231849699.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402.231627.270393242231849699.fujita.tomonori@gmail.com>

On Wed, Apr 02, 2025 at 11:16:27PM +0900, FUJITA Tomonori wrote:
> On Mon, 31 Mar 2025 07:03:15 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> >> My recommendation would be to take all of `rust/kernel/time` under one
> >> entry for now. I suggest the following, folding in the hrtimer entry as
> >> well:
> >> 
> >> DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]
> >> M:	Andreas Hindborg <a.hindborg@kernel.org>
> > 
> > Given you're the one who would handle the patches, I think this make
> > more sense.
> > 
> >> R:	Boqun Feng <boqun.feng@gmail.com>
> >> R:	FUJITA Tomonori <fujita.tomonori@gmail.com>
> > 
> > Tomo, does this look good to you?
> 
> Fine by me.
> 
> So a single entry for all the Rust time stuff, which isn't aligned
> with C's MAINTAINERS entries. It's just for now?
> 

Given Andreas is the one who's going to handle the PRs, and he will put
all the things in one branch. I think it's fine even for long term, and
we got all relevant reviewers covered. If the Rust timekeeping + hrtimer
community expands in the future, we can also add more entries. We don't
necessarily need to copy all maintainer structures from C ;-)

> 
> >> R:	Lyude Paul <lyude@redhat.com>
> >> R:	Frederic Weisbecker <frederic@kernel.org>
> >> R:	Thomas Gleixner <tglx@linutronix.de>
> >> R:	Anna-Maria Behnsen <anna-maria@linutronix.de>
> >> R:	John Stultz <jstultz@google.com>
> > 
> > We should add:
> > 
> > R:      Stephen Boyd <sboyd@kernel.org>
> > 
> > If Stephen is not against it.
> > 
> >> L:	rust-for-linux@vger.kernel.org
> >> S:	Supported
> >> W:	https://rust-for-linux.com
> >> B:	https://github.com/Rust-for-Linux/linux/issues
> >> T:	git https://github.com/Rust-for-Linux/linux.git rust-timekeeping-next
> >> F:	rust/kernel/time.rs
> >> F:	rust/kernel/time/
> >> 
> >> If that is acceptable to everyone, it is very likely that I can pick 2-6
> >> for v6.16.
> >> 
> > 
> > You will need to fix something because patch 2-6 removes `Ktime` ;-)
> 
> I'll take care of it in the next version.
> 

Thanks!

> >> I assume patch 1 will go through the sched/core tree, and then Miguel
> >> can pick 7.
> >> 
> > 
> > Patch 1 & 7 probably should go together, but we can decide it later.
> 
> Since nothing has moved forward for quite a while, maybe it's time to
> drop patch 1.

No, I think we should keep it. Because otherwise we will use a macro
version of read_poll_timeout(), which is strictly worse. I'm happy to
collect patch #1 and the cpu_relax() patch of patch #7, and send an PR
to tip. Could you split them a bit:

* Move the Rust might_sleep() in patch #7 to patch #1 and put it at
  kernel::task, also if we EXPORT_SYMBOL(__might_sleep_precision), we
  don't need the rust_helper for it.

* Have a separate containing the cpu_relax() bit.

* Also you may want to put #[inline] at cpu_relax() and might_resched().

and we can start from there. Sounds good?

Regards,
Boqun

