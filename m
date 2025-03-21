Return-Path: <netdev+bounces-176836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FF3A6C59A
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 23:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B20E480F0B
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 22:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD3C1F12F3;
	Fri, 21 Mar 2025 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5VzMwiJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A058D1EB9E1;
	Fri, 21 Mar 2025 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742594726; cv=none; b=CWnNe3es2WPEPZluOBvIJoWE1XgbIH1ulObuHlboHr7sLWFH/ElsSMu7vP8FIdNfmFurTeFlmRJWdV+OCiWoSgV9ciWMxnmpOW5WM+u9YHZNymfOCVB3WpvVoupQc+PbbrwTTbIXlWjrPapTJYdusri3FSWYpHgbBnYwpGowXzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742594726; c=relaxed/simple;
	bh=9N9lKIA4T37ajX0PCeM9ksT3ycwji09uQfEuJmjCJLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rx21SwZuDmvqzyv4F3J0tqqz1u6572S2JwnKySLW3VitTCEo9uCYtn/UImGMLLBzrNr1oME6nfp3yMeuiuY6VD6ea7mQp4N7abQFMN9zphT+syBX8EXecJctc/K1IZ/zrmPwBV6K2/VOATFbR5HYvHITupoeoG7cicBIZDSDv4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5VzMwiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971E4C4CEE3;
	Fri, 21 Mar 2025 22:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742594726;
	bh=9N9lKIA4T37ajX0PCeM9ksT3ycwji09uQfEuJmjCJLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c5VzMwiJJAAuof1zp8qtJWpsyDichBCO/8ItWHCQPanliBaA4Sz3+HB0m8WE0QYIa
	 MoKUOpzwrcTtrHfDX7RAYkLMHK8JgwVJKf4kRzJee6/eAllb8wH+H0wj6YPy3LJrgE
	 10gqDYNE7dG3TTGOVwnWY+MiPFOOWW9bdbK4EJBv/5ZrVMZlhS7k+jxcNOFF3TnLY7
	 1drf9huoOFTsr5c2xGywVCzWJAP3ISN1iTT6xCYntE6CXKC+Ctd2h+V07mgQ0Ec+Bp
	 1x4uo7CTf29h0+WCRvcOis1lMqGFVIOEiuu5GqftEUR81gfZ4lCzvjNwOUVn6yQdhJ
	 obo+zHGwq7K3g==
Date: Fri, 21 Mar 2025 23:05:23 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>,
	Fiona Behrens <me@kloenk.dev>, rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, anna-maria@linutronix.de,
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com,
	sboyd@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com,
	david.laight.linux@gmail.com
Subject: Re: [PATCH v11 5/8] rust: time: Add wrapper for fsleep() function
Message-ID: <Z93io9rkpRMiXEKi@pavilion.home>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
 <20250220070611.214262-6-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250220070611.214262-6-fujita.tomonori@gmail.com>

Le Thu, Feb 20, 2025 at 04:06:07PM +0900, FUJITA Tomonori a écrit :
> Add a wrapper for fsleep(), flexible sleep functions in
> include/linux/delay.h which typically deals with hardware delays.
> 
> The kernel supports several sleep functions to handle various lengths
> of delay. This adds fsleep(), automatically chooses the best sleep
> method based on a duration.
> 
> sleep functions including fsleep() belongs to TIMERS, not
> TIMEKEEPING. They are maintained separately. rust/kernel/time.rs is an
> abstraction for TIMEKEEPING. To make Rust abstractions match the C
> side, add rust/kernel/time/delay.rs for this wrapper.
> 
> fsleep() can only be used in a nonatomic context. This requirement is
> not checked by these abstractions, but it is intended that klint [1]
> or a similar tool will be used to check it in the future.
> 
> Link: https://rust-for-linux.com/klint [1]
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Sorry to make a late review. I don't mean to delay that any further
but:

> +/// `delta` must be within `[0, i32::MAX]` microseconds;
> +/// otherwise, it is erroneous behavior. That is, it is considered a bug
> +/// to call this function with an out-of-range value, in which case the function
> +/// will sleep for at least the maximum value in the range and may warn
> +/// in the future.
> +///
> +/// The behavior above differs from the C side [`fsleep()`] for which out-of-range
> +/// values mean "infinite timeout" instead.

And very important: the behaviour also differ in that the C side takes
usecs while this takes nsecs. We should really disambiguate the situation
as that might create confusion or misusage.

Either this should be renamed to fsleep_ns() or fsleep_nsecs(), or this should
take microseconds directly.

Thanks.

> +///
> +/// This function can only be used in a nonatomic context.
> +///
> +/// [`fsleep`]: https://docs.kernel.org/timers/delay_sleep_functions.html#c.fsleep
> +pub fn fsleep(delta: Delta) {
> +    // The maximum value is set to `i32::MAX` microseconds to prevent integer
> +    // overflow inside fsleep, which could lead to unintentional infinite sleep.
> +    const MAX_DELTA: Delta = Delta::from_micros(i32::MAX as i64);
> +
> +    let delta = if (Delta::ZERO..=MAX_DELTA).contains(&delta) {
> +        delta
> +    } else {
> +        // TODO: Add WARN_ONCE() when it's supported.
> +        MAX_DELTA
> +    };
> +
> +    // SAFETY: It is always safe to call `fsleep()` with any duration.
> +    unsafe {
> +        // Convert the duration to microseconds and round up to preserve
> +        // the guarantee; `fsleep()` sleeps for at least the provided duration,
> +        // but that it may sleep for longer under some circumstances.
> +        bindings::fsleep(delta.as_micros_ceil() as c_ulong)
> +    }
> +}
> -- 
> 2.43.0
> 

