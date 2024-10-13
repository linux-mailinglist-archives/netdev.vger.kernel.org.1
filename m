Return-Path: <netdev+bounces-134886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A462799B81C
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 05:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAD91C214CA
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 03:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB6A7406D;
	Sun, 13 Oct 2024 03:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmtljHxs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7152E231CB3;
	Sun, 13 Oct 2024 03:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728789410; cv=none; b=si+b8By0B0vSvZ8ykFu8qwTM/jFwYPPKjnOPZhjcOh0qoeH2lgHuckCckl10vFQXfKy/megu3yuUcsIjttnzrxL5UUTx70HhExwwmov7G7JSbuDooI+U7DeYkanfRNVCp6588ZgXhaEyr/Jrfx3nkJzGW8y0ARG4asgukphdFCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728789410; c=relaxed/simple;
	bh=wYw45KJ87Tz+41/dwsmk/arKMh0CcaxFGtU+lzmA5h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hn+A3qWkmoo1I0AWG7X/yDSlgPZxQq75Deazx/sAV2sxSuI5ZPr3zO1trMg+dmxCciuHyeP9gABNQPot7P5SYqyb9MwSslZqDNSZyFS1L3FLiUjzdxAvbngIjvdG7Jpu2/CooqiVX+1E/jPQcYUS+4ojVNOjfCv0MWg+y2S+NQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmtljHxs; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7afcf50e2d0so154159885a.3;
        Sat, 12 Oct 2024 20:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728789407; x=1729394207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWX1pHC59HWQu7vk0ZAQ8Do+vw5b/RWukPcaBvgOC4A=;
        b=hmtljHxsA8yxb903buTYGgQNWoNrjq4cVpnI/bynT22g08VBiDtNyNCTgjbsWeXQBk
         oz5M7Z7Jf2UU8aQZKuOtwX72QjFBBar/gzJCcon8/vwYWz/gCdv7hwRznMXdujF4wsHK
         msHGw84eKeJ34ft+lqOBBuGkg+xqe9QyEyzQvMHupYvfxBOLG/mBXCOtO6Nd0fLi5AYn
         jkTlK8II6Nn99PcfwDZ5XDcHAemghaaMeF+6ou78pUT45xrpHtFy4uvB8c5Kgp32zs4T
         v4EX7Qrkz/+lxuNstGenhH0fqAIx/KP/BFBOnMPDPjVZxaCt8fe09RikEA0jrKZMYUSv
         GPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728789407; x=1729394207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWX1pHC59HWQu7vk0ZAQ8Do+vw5b/RWukPcaBvgOC4A=;
        b=YxC79BOk9gAkLhGz/GaAvZcMimG9HWxkX3qnC4r4087+zeMstm+QpYwP3ajHRiERaJ
         ztIUISOnw7yLTg7lKuRyALU3XRVr87RWRtXzAEqG1qLhBPFfTUtE1K/iekCwCHprGY/R
         D7vEdZC7IsrwdKNDtWdQgFyOWZ80r2HUBaq8DWSkegXp1ikwW93xCmxQTI/F20jxnPVR
         99A44F8KPoMPQy9Krzy/TpqTJ/Razc4qwrQ5GSwUIcRyKnkGiYS9Pp8+LvfJsGwbfNbz
         /yRpYPH1Gtbn4n83mFnGLt8VRRHcvVp9wsADZ/8MMsfruMYbfsG24NYP5OdRqxMPo0+T
         TkkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsDG56V96AnCNKtBT12WCzFvSjnAQsbL5Tze/Ws+hsgzZQ/0X5wErmZQf0ApRBnRLhVeWkpCFtKTnORVc=@vger.kernel.org, AJvYcCW+XUGdrsRW8w81RuV4kCbU7RfV9C30K0P4mFhIiyu6w65eSWPh3xtCUfEKSpC7SClrMAQQVXij8ChYPXuKKqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YycpaDi2DO48dK3V6wtueFE1t9rjCQRoYPyF45hTLH5NluUaHnj
	vCdnpG6VEx69Ci0TOKJpsk1Qe4yiwz5OO+KILONm9fbvjFNpFVwU
X-Google-Smtp-Source: AGHT+IH1SxP3Fviq6G/vghaX4YA+TCGWPdtpdOVEhs0VAymzntxHUIrXQ8DafuNBwPf0CZFLjCkJYw==
X-Received: by 2002:a05:620a:7207:b0:7a9:a810:9930 with SMTP id af79cd13be357-7b11a362117mr1170556285a.23.1728789407261;
        Sat, 12 Oct 2024 20:16:47 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460428069bbsm30746971cf.54.2024.10.12.20.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 20:16:46 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id E69801200076;
	Sat, 12 Oct 2024 23:16:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sat, 12 Oct 2024 23:16:45 -0400
X-ME-Sender: <xms:nTsLZ9hH4CM0rQbG7V6z15fsviqItf4Qv34cyyYkLBWADqhujHzeYg>
    <xme:nTsLZyDDIJqu20i8r_Y7sLwrMDH443J3qGq6DK2FFkoZF8aLAAq0CVLGf-ssFskkm
    TnJebNAT5XQKKGOSQ>
X-ME-Received: <xmr:nTsLZ9EsIqglSHZ2xoCdiTEih8Qz04KMI7yBZBPfVGcIky9klfjB6-CswDk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epfhhujhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfh
    horhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgu
    rhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilh
    drtghomhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughupdhrtghpthht
    ohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnh
    horhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgv
    th
X-ME-Proxy: <xmx:nTsLZyRHYB4zpDJrbm9anmEvdPjQVnUhESV0R9_xMXZuI84OOfgBeg>
    <xmx:nTsLZ6xmXHhoHTxsnY1Gy5ULM_Qz1GV8F9jYZpSPTTV4B22W-uz8bg>
    <xmx:nTsLZ47bDJMpY7-ESFkAGikpEqTkS5LQtPKMg8XtykPTD-NZsxcRxA>
    <xmx:nTsLZ_ygQCeU_aoXtKqdbsnvsbJATb2L8VNBmbc9Q1JJLj-_8wQW5Q>
    <xmx:nTsLZyjAJ8AhMzgNi1K5ZfYUTfd1Ap4a4MHZXNzw2VbGInBJ3ekKTqXY>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Oct 2024 23:16:45 -0400 (EDT)
Date: Sat, 12 Oct 2024 20:16:44 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	tglx@linutronix.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
	jstultz@google.com, sboyd@kernel.org
Subject: Re: [PATCH net-next v2 0/6] rust: Add IO polling
Message-ID: <Zws7nK549LWOccEj@Boquns-Mac-mini.local>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <ZwqVwktWNMrxFvGH@boqun-archlinux>
 <20241013.101505.2305788717444047197.fujita.tomonori@gmail.com>
 <20241013.115033.709062352209779601.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013.115033.709062352209779601.fujita.tomonori@gmail.com>

On Sun, Oct 13, 2024 at 11:50:33AM +0900, FUJITA Tomonori wrote:
> On Sun, 13 Oct 2024 10:15:05 +0900 (JST)
> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
> 
> > On Sat, 12 Oct 2024 08:29:06 -0700
> > Boqun Feng <boqun.feng@gmail.com> wrote:
> > 
> >> While, we are at it, I want to suggest that we also add
> >> rust/kernel/time{.rs, /} into the "F:" entries of TIME subsystem like:
> >> 
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index b77f4495dcf4..09e46a214333 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -23376,6 +23376,8 @@ F:      kernel/time/timeconv.c
> >>  F:     kernel/time/timecounter.c
> >>  F:     kernel/time/timekeeping*
> >>  F:     kernel/time/time_test.c
> >> +F:     rust/kernel/time.rs
> >> +F:     rust/kernel/time/
> >>  F:     tools/testing/selftests/timers/
> >> 
> >>  TIPC NETWORK LAYER
> >> 
> >> This will help future contributers copy the correct people while
> >> submission. Could you maybe add a patch of this in your series if this
> >> sounds reasonable to you? Thanks!
> > 
> > Agreed that it's better to have Rust time abstractions in
> > MAINTAINERS. You add it into the time entry but there are two options
> > in the file; time and timer?
> > 
> > TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER
> > M:      John Stultz <jstultz@google.com>
> > M:      Thomas Gleixner <tglx@linutronix.de>
> > R:      Stephen Boyd <sboyd@kernel.org>
> > 
> > HIGH-RESOLUTION TIMERS, TIMER WHEEL, CLOCKEVENTS
> > M:      Anna-Maria Behnsen <anna-maria@linutronix.de>
> > M:      Frederic Weisbecker <frederic@kernel.org>
> > M:      Thomas Gleixner <tglx@linutronix.de>
> > 
> > The current Rust abstractions which play mainly with ktimer.h. it's 
> > not time, timer stuff, I think.
> 
> Oops, s/ktimer.h/ktime.h/
> 
> No entry for ktime.h in MAINTAINERS; used by both time and timer
> stuff.
> 

I think ktime.h belongs to TIMEKEEPING, since ktime_get() is defined in
kernel/time/timekeeping.c and that's a core function for ktime_t, but
you're not wrong that there is no entry of ktime.h in MAINTAINERS, so if
you want to wait for or check with Thomas, feel free.

> > As planned, we'll move *.rs files from rust/kernel in the future,
> > how we handle time and timer abstractions?

I don't think core stuffs will be moved from rust/kernel, i.e. anything
correspond to the concepts defined in kernel/ directory probably stays
in rust/kernel, so time and timer fall into that category.

> 
> Looks like that we'll add rust/kernel/hrtimer/ soon. I feel that it's
> better to decide on the layout of time and timer abstractions now
> rather than later.

I already suggested we move hrtimer.rs into rust/kernel/time to match
the hierarchy of the counterpart in C (kernel/time/hrtimer.c):

	https://lore.kernel.org/rust-for-linux/ZwqTf-6xaASnIn9l@boqun-archlinux/

Regards,
Boqun

