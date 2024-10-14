Return-Path: <netdev+bounces-135340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8A499D8E7
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 23:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025012828A8
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 21:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5291C8FB3;
	Mon, 14 Oct 2024 21:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNNxQJxL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCD714B965;
	Mon, 14 Oct 2024 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940760; cv=none; b=kXcuPeP8aTwCONbbjmdqMqwn4YKAexY2KIhIrFeEstFBEWyLOSSObEMFz5Ay5arfDgLNmByfwLnjMIvDhIAEmkpzTIsxadyjo8UsgE5JsMLMrCQhKU4PXleF206tutTVFuyhs2y5dMv7Dvju+t1dj+MgvhkyLkF36gVOxujoJ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940760; c=relaxed/simple;
	bh=PAFmPTsYSqrYbsWSt40iPYIj+XMcnRXnWh1XxTwJTHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8mFosKhuKMoR0A2+mXL8PXByTVAPY0MPjPsxoMGgHDv60bPEe2QimaXo/jK5b+4bVkBw+61+0p84A4NvI2J4LSTQQrDx0Mbfsg09ZFj10WzgaGY/BE/Vq+FjNtHg9pLIQP25iSVcL2SEgZjg8WDiRSdF+sLSjxDNNiqDKqL5j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNNxQJxL; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbe9914487so32624906d6.1;
        Mon, 14 Oct 2024 14:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728940757; x=1729545557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MiOAdp88mxGwhMyB4rO6W4QU/jKLCZmdITKe/BNgZQ=;
        b=cNNxQJxLoPh5EjtDOWhBiU08DhZ1krxyVkejo7bQXctLA0181Oj1n11bTEGo28QBq9
         h85VYqjd15b7Ni4eUkrDqrdbK9QO6+1MfAiqpr0RzbCRsxGwWC5nuM9W32dME9FuObhg
         FucVHnmJNYan8coNMLfYOCIZS05Sbs6fHhmpRnrEB3bcPXPPMTva9U+nXqEgBL9f1l9N
         yqYIy7tU4e63x69UKS7k1oIiZWbB8Hj/Bexs832S6DkE4oC1tpJMqjChQV4x0xaGw2ap
         eRg0KryU3VPOC1pzTHBYG8XkcdmHQAmhf+AQq0cJkt4N0a6U4/rHeNhkrYvounbIwrGk
         6m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728940757; x=1729545557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MiOAdp88mxGwhMyB4rO6W4QU/jKLCZmdITKe/BNgZQ=;
        b=aWssAe2+saCPpsW1irC1/OlLyYTwjJzbENBUAYheu0j8v8tkQUXRykMyqMc8HQI3e4
         +Dw7n4rHzHfPsbdvThr9v3YTrlNsm43nU5qPCxLLeCpOoWruAC7CaHYUWvLhVL6lILDd
         w8iZ+1EX6duOijFCN/fPNK+cJ9nIZPuxJYANYJH1neDVckxkopYr82N4mwiG48AV5CY9
         rEOpEeXG1lG5Zj/A5XyVot+KJJR5tIXt90gsn5xAupeTiEpEV42q+vcdKn7SUbJOw7Fk
         D+z62AYFPaUH2yTxFMOZ/6xVdeNvTi6OVQ1tn0/w6ANQh/MpvcXMCG7iOJBa2mIeFnpr
         Dq0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZfH3wvGZRNwM21xwQgrSXe89grB+iU8I59Hj+JzNO+zSR7toXUPBKfWtYZc8kXXqVLQqm6sFV85sy+z3xGtc=@vger.kernel.org, AJvYcCVaut/qLB6I20n8A5NchcbZpN7tB+fI9KHeAQ4hTfaMce/zCPfJU/HdKxirA8sPUDactfRxYo3nX872Jhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWDA8d+igvKbRRkU7OYToZpcoujw1RmVpL1S7lgU1j8YRYjZq5
	e+ONv+d92u3X/LTuwgSy6mscHxZGxIkL19y0MrVbTaz1kSmHc9Vx
X-Google-Smtp-Source: AGHT+IGzO2q2s/9dn/cat1gPPyuyoPo+e7nJjOpJTMDlhlAABmQkhJExK4JTITevnji+6N6fPr8Plg==
X-Received: by 2002:a05:6214:54c8:b0:6cb:d4e6:2507 with SMTP id 6a1803df08f44-6cbeffc1e72mr205437426d6.22.1728940757307;
        Mon, 14 Oct 2024 14:19:17 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe863002bsm49615756d6.110.2024.10.14.14.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 14:19:16 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 159A71200069;
	Mon, 14 Oct 2024 17:19:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 14 Oct 2024 17:19:16 -0400
X-ME-Sender: <xms:04oNZ5v42dhsrUUl3yRs2sERmh4OTDH3Q7T1SuEHgN5rIMgSKhnrjQ>
    <xme:04oNZyc4BAsUgxOkCsruCdFvEghmauScldEoeqaTKwqG2miMCQO8-UCoQUCDlpp_c
    VrKj2yhksGRvEIWGQ>
X-ME-Received: <xmr:04oNZ8xKkwj0Q5XPBevFyEXPGZwamzwVbl0O6d_XZ7SOUwtEHxX8rqitujclyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhujhhithgrrdhtohhmohhnohhrihesgh
    hmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthho
    pehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehtmhhgrhhosh
    hssehumhhitghhrdgvughupdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgrghrhiesghgrrhihghhuohdrnhgvth
X-ME-Proxy: <xmx:04oNZwON3RzZUxrTrjLIjnSz8FVL90ZoxRxmkY3GNbkV9d4qkrPn4g>
    <xmx:1IoNZ5-ADSxyVJdj8tR0fIHRgjlmBN4yQN47UKgfQEhdyvBN86TsWA>
    <xmx:1IoNZwU6ydicMPxOl9nWPVtuvp2rgcp7rzkL3v6jQjZsYgPQyGW1Yw>
    <xmx:1IoNZ6fDB12MD_VplaR7LP1gVAd-iHFnz1olszwV9qIA-M6WOjtVVA>
    <xmx:1IoNZ_cku84vArsLoZdIw9otQKX5sj6ZrsVmIqEwSHI8gYiGnig_RhNR>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 17:19:15 -0400 (EDT)
Date: Mon, 14 Oct 2024 14:18:57 -0700
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
Message-ID: <Zw2KwQbAAKZ_5lPL@boqun-archlinux>
References: <20241013.101505.2305788717444047197.fujita.tomonori@gmail.com>
 <20241013.115033.709062352209779601.fujita.tomonori@gmail.com>
 <Zws7nK549LWOccEj@Boquns-Mac-mini.local>
 <20241013.141506.1304316759533641692.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013.141506.1304316759533641692.fujita.tomonori@gmail.com>

On Sun, Oct 13, 2024 at 02:15:06PM +0900, FUJITA Tomonori wrote:
> On Sat, 12 Oct 2024 20:16:44 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > On Sun, Oct 13, 2024 at 11:50:33AM +0900, FUJITA Tomonori wrote:
> >> On Sun, 13 Oct 2024 10:15:05 +0900 (JST)
> >> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
> >> 
> >> > On Sat, 12 Oct 2024 08:29:06 -0700
> >> > Boqun Feng <boqun.feng@gmail.com> wrote:
> >> > 
> >> >> While, we are at it, I want to suggest that we also add
> >> >> rust/kernel/time{.rs, /} into the "F:" entries of TIME subsystem like:
> >> >> 
> >> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> >> index b77f4495dcf4..09e46a214333 100644
> >> >> --- a/MAINTAINERS
> >> >> +++ b/MAINTAINERS
> >> >> @@ -23376,6 +23376,8 @@ F:      kernel/time/timeconv.c
> >> >>  F:     kernel/time/timecounter.c
> >> >>  F:     kernel/time/timekeeping*
> >> >>  F:     kernel/time/time_test.c
> >> >> +F:     rust/kernel/time.rs
> >> >> +F:     rust/kernel/time/
> >> >>  F:     tools/testing/selftests/timers/
> >> >> 
> >> >>  TIPC NETWORK LAYER
> >> >> 
> >> >> This will help future contributers copy the correct people while
> >> >> submission. Could you maybe add a patch of this in your series if this
> >> >> sounds reasonable to you? Thanks!
> >> > 
> >> > Agreed that it's better to have Rust time abstractions in
> >> > MAINTAINERS. You add it into the time entry but there are two options
> >> > in the file; time and timer?
> >> > 
> >> > TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER
> >> > M:      John Stultz <jstultz@google.com>
> >> > M:      Thomas Gleixner <tglx@linutronix.de>
> >> > R:      Stephen Boyd <sboyd@kernel.org>
> >> > 
> >> > HIGH-RESOLUTION TIMERS, TIMER WHEEL, CLOCKEVENTS
> >> > M:      Anna-Maria Behnsen <anna-maria@linutronix.de>
> >> > M:      Frederic Weisbecker <frederic@kernel.org>
> >> > M:      Thomas Gleixner <tglx@linutronix.de>
> >> > 
> >> > The current Rust abstractions which play mainly with ktimer.h. it's 
> >> > not time, timer stuff, I think.
> >> 
> >> Oops, s/ktimer.h/ktime.h/
> >> 
> >> No entry for ktime.h in MAINTAINERS; used by both time and timer
> >> stuff.
> >> 
> > 
> > I think ktime.h belongs to TIMEKEEPING, since ktime_get() is defined in
> > kernel/time/timekeeping.c and that's a core function for ktime_t, but
> 
> Sounds reasonable.
> 
> This patchset adds Delta (also belongs to time, I guess) and fsleep to
> rust/kernel/time.rs. I think that fsleep belongs to timer (because
> sleep functions in kernel/time/timer.c). It's better to add
> rust/kerne/time/timer.rs for fsleep() rather than putting both time
> and timer stuff to rust/kernel/time.rs?
> 

Good point. So how about putting fsleep() into rusk/kernel/time/delay.rs
and add that into the "F:" entry of TIMER subsystem? Since "sleep"s are
a set of particular usage of timers which don't directly interact with a
timer or hrtimer struct, so I feel it's better to have their own
file/mod rather than sharing it with timers. Plus this results in less
potential conflicts with Andreas' hrtimer series.

Regards,
Boqun

[...]

