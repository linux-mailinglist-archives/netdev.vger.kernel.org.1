Return-Path: <netdev+bounces-167624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F01B2A3B198
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 07:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85F83B1AAC
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 06:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD4E1B4153;
	Wed, 19 Feb 2025 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHvSeb2f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9B217BB21;
	Wed, 19 Feb 2025 06:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739946374; cv=none; b=hvD2vcuJDd/pD0EYrJBjlpS8AGdNniAvpBuHedIbr/3iiVOUvC/1xVnzJtEO1IR0JKg+mjyZQhVym/xKYVoQeHACBYTO5sk7EZRHVwD3bnOhUvIPtLqgZz8EpJi87Ze2rVNGz79bMlvIh6YcqWxKMsXCSUteDT3nTqvrJUX0gUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739946374; c=relaxed/simple;
	bh=YLRfZjNmZEwt2J4sS1CuWL+Dyi6Eo3SE1Lf0l46ZiwY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nJ7qeKUtcohGR1zhTKSB6x+ivxLVq3drcZwfPuQZ5VXq7t8W00X8Kmoa2FFxS6vDQYDZsoTfXxC0rPrRMQAeFttc99Y5V0CcZuPKUZjhH9AeSM5EBI6gUaVxfXPQ63tQ9RDWy3uEbo0hTsy/olwRC2ECRVrhJBcVdTW/LAif7ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHvSeb2f; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f44353649aso8921499a91.0;
        Tue, 18 Feb 2025 22:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739946372; x=1740551172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kZElKND3kCKGrS1g7RYXmXU6YgLKTvquyxfdR0pRBg=;
        b=eHvSeb2fT4bXIWF3jfazaay8rfw/7JBEp19VWt1Ap0ba98MYZJUQ/2OtTHq1BSs5JS
         XMQfz5KTb57AfMToe/GOAbFfuYdhabg/hnHdKSQGWoTsembCD14weUcFstxwPzKPBapy
         CV9C4ZbwhdoUzWcnrN3lt4jdNqYRqRQwuX3AF9xt/k0HqXHnOBfwbH6zSb8Mr0IJvZNZ
         +V5jzxgGiY9JMVLcIQF5k19hErd7F6rq2YRN8R8SBJNSd54twQf37eRwsZqvKbsL+H2U
         7UJCDqBeBtwGYANpk1EtrL7B5JFVuwdOKXUI1Mm/Q2ljvpze3p4aHuvfhjfBKl0qBz5D
         eOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739946372; x=1740551172;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3kZElKND3kCKGrS1g7RYXmXU6YgLKTvquyxfdR0pRBg=;
        b=ZEMWFW9mcolkL49S2PflFR99RJuoPdTuShTpn7bqY+VuYZhSwMEDgOxP2Y7eUyolsm
         A4BSGpqkr6D60u9ji6w/7mOxPreJsZrCeIiun83Q3FSoSNAUa8wTiyZMiSfWYfSbATby
         SFXTYUneS4olUsniSA/M0SMGoI9vXIUMiKaaQeOYp1FWQGv9eTpXp4e7J6SHTFdHlCTE
         GcZY3hHK8QjJCQ6xVPU0OznEyPYPD/VZLUtUINhDGd+dYG3MMx07PiN0Yx2hd9P+d0gh
         7Fl3GiBMlNajMYiJ3T9HxjF3Rn3jKKDAhEIxrkRA7Ntry7OPCBNWrHGzzYPQqchHMv+7
         IwNg==
X-Forwarded-Encrypted: i=1; AJvYcCVHOtdtsmEH7RoRAyE/Fa5Ly4wgIbGFAgLFX5jGYapcnWJ0Hiq6d+2f/qGXH0IyjpPQB3NfQjZ0@vger.kernel.org, AJvYcCVlt4EUaiItHco1yW8IRCR3Nd56AQAPqKMyTUHhBIxZptD7TAnCngCWoWYj3R5Aam27hj3qUUwP2sNW72Ax5Rc=@vger.kernel.org, AJvYcCVpVGZQTIyxpEJ3dqzvJvLj50KxqkNonT28EqIPsETIXZ0i/mjjfO9RlHRuA9wKi61DcILuyv7SJCTQqDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFs8dLpDGZ73ennXJqwhOsuOh3dI7ERX9rxqpjgTTP1poUTQBp
	5sxZ0tytzLwLp6HS9lZUGH3GLQ9BqcpLQ7GbHg+vWySwhmRHYCpQ
X-Gm-Gg: ASbGncu9+ojZEQRCFiT4Alu5CXoTuVkdhE1uyVjwAhV3LUOpBWEuDFm4wvxN2dzo+F8
	m9JURbsq6j2FA0XQ8g6t2jInAvO11hU1/fnK2Akc7gVZeZCz0mCwZZBi9hZnFYcE4W6wtf1VnS7
	V+xdaLqApaPtCaDz57i5ksKWb9QDhIw6qxGV+9NH3+DoyZsVu7i/H65RcvwNX0jQDacmnK9HY39
	WVHpX/gptfmeCQ+ZJVHLNwhsqVJFLmtMi2DRR5JutevXZuTivKWRr9PJ2CLpcWBswMsKpWC5aIg
	8Eeq+gBsrDMIvrr9y1c2t4n0bbHP7og4afAHse10i0Va+S4P1k8ns9DzLTQJX84Dq+RO5ZRN
X-Google-Smtp-Source: AGHT+IE7Ce4LdfDebhYA+Q4CG7Lr1YqDWI7NHJxGkePySSwowWVZA/9C6wEyMSCkX4JxZx62eXof3Q==
X-Received: by 2002:aa7:88d5:0:b0:725:e4b9:a600 with SMTP id d2e1a72fcca58-732618e50d1mr25994703b3a.16.1739946372290;
        Tue, 18 Feb 2025 22:26:12 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73274a11a0bsm5866711b3a.123.2025.02.18.22.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 22:26:11 -0800 (PST)
Date: Wed, 19 Feb 2025 15:26:02 +0900 (JST)
Message-Id: <20250219.152602.1131699707200242344.fujita.tomonori@gmail.com>
To: frederic@kernel.org
Cc: fujita.tomonori@gmail.com, anna-maria@linutronix.de,
 tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 tgunders@redhat.com, me@kloenk.dev
Subject: Re: [PATCH v10 6/8] MAINTAINERS: rust: Add TIMEKEEPING and TIMER
 abstractions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Z7M8IDI_caXqBvMp@localhost.localdomain>
References: <20250207132623.168854-7-fujita.tomonori@gmail.com>
	<20250217.091008.1729482605084144345.fujita.tomonori@gmail.com>
	<Z7M8IDI_caXqBvMp@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 14:39:44 +0100
Frederic Weisbecker <frederic@kernel.org> wrote:

>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index c8d9e8187eb0..987a25550853 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -10353,6 +10353,7 @@ F:	kernel/time/sleep_timeout.c
>> >  F:	kernel/time/timer.c
>> >  F:	kernel/time/timer_list.c
>> >  F:	kernel/time/timer_migration.*
>> > +F:	rust/kernel/time/delay.rs
>> >  F:	tools/testing/selftests/timers/
>> >  
>> >  HIGH-SPEED SCC DRIVER FOR AX.25
>> > @@ -23852,6 +23853,7 @@ F:	kernel/time/timeconv.c
>> >  F:	kernel/time/timecounter.c
>> >  F:	kernel/time/timekeeping*
>> >  F:	kernel/time/time_test.c
>> > +F:	rust/kernel/time.rs
>> >  F:	tools/testing/selftests/timers/
>> 
>> TIMERS and TIMEKEEPING maintainers,
>> 
>> You would prefer to add rust files to a separate entry for Rust? Or
>> you prefer a different option?
> 
> It's probably a better idea to keep those rust entries to their own sections.
> This code will be better handled into your more capable hands.

Got it. I'll create new sections for Rust's TIMERS and TIMEKEEPING.

Thanks!

