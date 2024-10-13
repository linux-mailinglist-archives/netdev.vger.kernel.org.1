Return-Path: <netdev+bounces-134892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B1C99B842
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 07:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C9C1F21DA5
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 05:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF39F84D0D;
	Sun, 13 Oct 2024 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJezFpjy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EB62AD18;
	Sun, 13 Oct 2024 05:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728796514; cv=none; b=Gs+FExuUQLcVIbcz99QZ9YLdNhspUrU2/+0Mh6FDOqIf8zXzwtRMXIQVcJgrlVr4rY9T4RlReFWVn8TrjiW2Ddry8m/vKsFbXapvo8mhh3Te4WtCdG/HnPhlDGXHE2G1FmVN0EOrKXeHXmvg8uNIl+Lk90zsdoZ7B8aIbhVD4xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728796514; c=relaxed/simple;
	bh=kxcy2RlMglBoUgg4GE0rq7b9omyBE2JmSWO++esHBOY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EdPQPrM19W3acjaiKcRf5x35QQyN7aLMSGWCXk/3QzIF2iQC8EJBCzivQFJuRdnMkGg0Fz2lBwfOUYUGKn5uMJ2xD433bdoHaakwuBpie6b8K783MpiWS7zRhz4EciHFCve5USSX7QgfX2KiQCrkIgI5mA0OpDeN/2nbQTLcvJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJezFpjy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cdb889222so1844425ad.3;
        Sat, 12 Oct 2024 22:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728796512; x=1729401312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVwr1Cb7sAdt+UT07RBe5ZH+FrBE6ooNRnlIiE0/nA0=;
        b=iJezFpjygvxPXVOGbfU+d0boFzE0MUAXegTPGslWkD3Tvs+1+eNTIECB8IEH++Ys9D
         IknUFgqrgc+UnzT0k2cANWZnArYr8wtP4u0P9zoyKL68DfjBVxkHWPghpBrf6dlO3em/
         OA8TlTEZR348WNRDYMF4HuEGDImuE5iph+Y9avG3HNt5L1SZ33aeRFtdk0LRJOnIoIu+
         p+FgFnsnw60IAVqp77GCRgVCZkq5f4ziZzTtRcSwHj8shC+MUHtmrDvaUZyx++yom72x
         P1IY3T99izbXHEpCjpjYlU2vAvBLd/AIXTws4d0NGn1t4icAJ7eCHEehLzpOALIcx4iY
         WYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728796512; x=1729401312;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YVwr1Cb7sAdt+UT07RBe5ZH+FrBE6ooNRnlIiE0/nA0=;
        b=U8fTG2SJ8wRLJtAckT0YGe808g0M901/S/k9y0XqQ0NkisD6gNimyopzRqTSY5m9le
         VI3fJ1PanVk4q1Qkhf892xrNXXrisMnzx1+0UDUkXtXKiIJHcjZpct+y35PXVPrUfp62
         +wJ6KGLK+YuRN1iFMc0Vjqh8XPgfznVcwRssA+eWy7mt3z+pW95I8KcBJ/IDHeD9P3in
         UOjDvTMZaB2TvhnPSbpNF4UFbQnoZZ397yuZ15OcZNTDp2QxA3ee0E4yjpOtS38ikYiN
         ItBgXejF0K2OiMxcZo1mUQh+tcRtR82/ggTZXr8CrHgIJbzRx/63nyRYxI3G5NDGAOeq
         Xwxg==
X-Forwarded-Encrypted: i=1; AJvYcCUZsAPmAvW9HyqLusL/iIKHmu5sg4BYdV/J0XAJ9QP9TiY/7Tz5730RPRN/K6JQcEwkOqaruCfF@vger.kernel.org, AJvYcCWKMoUnUKHQ8MzDvvsSztSADxuRqqeNYGVTvOjfrPP93GPHsTZQj7hkQWjF7TlJTM4k3d9GsWK0l6T+o5U=@vger.kernel.org, AJvYcCX1YlIUXa6OXxCgtIIcjQNaKcOPJcUEK30GGVrRist7MB3ByclMqYrlfCUmfQJYZW16mWTl52JQyofVVlKNHog=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuGK8JkAXm9C17Yx2rGkdLbYc3ObvgNRhOWtSt2LYkVLDiM5st
	N1X0DP9eEa6KPC6u79RK4TyBVx0X0SGoH+jQRuJzNPt+yYdQPZr7
X-Google-Smtp-Source: AGHT+IF33t1fD42C1/4LU9fR0rKwJp98vkZGnud1eHt9LMLbFeMKtMa4oNFpwv554E2wi59xG0/BHw==
X-Received: by 2002:a17:902:f64b:b0:20b:ab4b:5432 with SMTP id d9443c01a7336-20ca13f8416mr101939175ad.12.1728796512322;
        Sat, 12 Oct 2024 22:15:12 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad34f4sm44928135ad.47.2024.10.12.22.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 22:15:12 -0700 (PDT)
Date: Sun, 13 Oct 2024 14:15:06 +0900 (JST)
Message-Id: <20241013.141506.1304316759533641692.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 linux-kernel@vger.kernel.org, jstultz@google.com, sboyd@kernel.org
Subject: Re: [PATCH net-next v2 0/6] rust: Add IO polling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Zws7nK549LWOccEj@Boquns-Mac-mini.local>
References: <20241013.101505.2305788717444047197.fujita.tomonori@gmail.com>
	<20241013.115033.709062352209779601.fujita.tomonori@gmail.com>
	<Zws7nK549LWOccEj@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 12 Oct 2024 20:16:44 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Sun, Oct 13, 2024 at 11:50:33AM +0900, FUJITA Tomonori wrote:
>> On Sun, 13 Oct 2024 10:15:05 +0900 (JST)
>> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>> 
>> > On Sat, 12 Oct 2024 08:29:06 -0700
>> > Boqun Feng <boqun.feng@gmail.com> wrote:
>> > 
>> >> While, we are at it, I want to suggest that we also add
>> >> rust/kernel/time{.rs, /} into the "F:" entries of TIME subsystem like:
>> >> 
>> >> diff --git a/MAINTAINERS b/MAINTAINERS
>> >> index b77f4495dcf4..09e46a214333 100644
>> >> --- a/MAINTAINERS
>> >> +++ b/MAINTAINERS
>> >> @@ -23376,6 +23376,8 @@ F:      kernel/time/timeconv.c
>> >>  F:     kernel/time/timecounter.c
>> >>  F:     kernel/time/timekeeping*
>> >>  F:     kernel/time/time_test.c
>> >> +F:     rust/kernel/time.rs
>> >> +F:     rust/kernel/time/
>> >>  F:     tools/testing/selftests/timers/
>> >> 
>> >>  TIPC NETWORK LAYER
>> >> 
>> >> This will help future contributers copy the correct people while
>> >> submission. Could you maybe add a patch of this in your series if this
>> >> sounds reasonable to you? Thanks!
>> > 
>> > Agreed that it's better to have Rust time abstractions in
>> > MAINTAINERS. You add it into the time entry but there are two options
>> > in the file; time and timer?
>> > 
>> > TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER
>> > M:      John Stultz <jstultz@google.com>
>> > M:      Thomas Gleixner <tglx@linutronix.de>
>> > R:      Stephen Boyd <sboyd@kernel.org>
>> > 
>> > HIGH-RESOLUTION TIMERS, TIMER WHEEL, CLOCKEVENTS
>> > M:      Anna-Maria Behnsen <anna-maria@linutronix.de>
>> > M:      Frederic Weisbecker <frederic@kernel.org>
>> > M:      Thomas Gleixner <tglx@linutronix.de>
>> > 
>> > The current Rust abstractions which play mainly with ktimer.h. it's 
>> > not time, timer stuff, I think.
>> 
>> Oops, s/ktimer.h/ktime.h/
>> 
>> No entry for ktime.h in MAINTAINERS; used by both time and timer
>> stuff.
>> 
> 
> I think ktime.h belongs to TIMEKEEPING, since ktime_get() is defined in
> kernel/time/timekeeping.c and that's a core function for ktime_t, but

Sounds reasonable.

This patchset adds Delta (also belongs to time, I guess) and fsleep to
rust/kernel/time.rs. I think that fsleep belongs to timer (because
sleep functions in kernel/time/timer.c). It's better to add
rust/kerne/time/timer.rs for fsleep() rather than putting both time
and timer stuff to rust/kernel/time.rs?


> you're not wrong that there is no entry of ktime.h in MAINTAINERS, so if
> you want to wait for or check with Thomas, feel free.
> 
>> > As planned, we'll move *.rs files from rust/kernel in the future,
>> > how we handle time and timer abstractions?
> 
> I don't think core stuffs will be moved from rust/kernel, i.e. anything
> correspond to the concepts defined in kernel/ directory probably stays
> in rust/kernel, so time and timer fall into that category.

Seems that I misunderstood. The plan for the future layout is
documented somewhere?


>> Looks like that we'll add rust/kernel/hrtimer/ soon. I feel that it's
>> better to decide on the layout of time and timer abstractions now
>> rather than later.
> 
> I already suggested we move hrtimer.rs into rust/kernel/time to match
> the hierarchy of the counterpart in C (kernel/time/hrtimer.c):
> 
> 	https://lore.kernel.org/rust-for-linux/ZwqTf-6xaASnIn9l@boqun-archlinux/

Sounds good.

