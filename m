Return-Path: <netdev+bounces-179460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 026FDA7CD7F
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 11:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D097A6597
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 09:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4082E19E7FA;
	Sun,  6 Apr 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYiTGhJI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B1D17A2E5;
	Sun,  6 Apr 2025 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743931915; cv=none; b=liO/+SPiuwlNRuzCPnZTMPKlvG6BtmQxx9jz+JPWYbbGSlIxX5NBJJiPlrrOoxJHP0sPVg+7FqZYeRj3HvlJedQMcJMyPlwd0AbxDyhZi1WFK69dU0CCNDagJVdTSQ8RMj6DDHG8t3fTtHl3RLi84a+ZqMZYTXEGn1zBOZl1fHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743931915; c=relaxed/simple;
	bh=NupIctgv6eyPgDfdu7cJa5QG0aJbIdTwbFdNvq2g5u0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SLkt7zH1ekxsM7cMlseoK0mQZSDxwS75jpdUi17yhJiEEBsyqiRXC1wr75yx3wpXQTRMzgAuw9VU5uU/NaADESPmKQgcnSPLRoycUFMakR5f/jpjfDNa7jQqYXkn762Czp5WKnq2LHdntBXu6cOw4PtckE9kwzLVVYZLt6fWe4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYiTGhJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388BAC4CEE3;
	Sun,  6 Apr 2025 09:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743931914;
	bh=NupIctgv6eyPgDfdu7cJa5QG0aJbIdTwbFdNvq2g5u0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MYiTGhJIT74BxQ+RClM9BfPnKX99vk/MwgKtw6jDV/paog20fiRVTU8BH/tdhMI3j
	 6ar9sqamuYkSkuqoY+XXEPhwjHN5Bnxy1b4XhyzHnjTA9kxfqpFPrNACAJT5F+vHJo
	 DQHScsbvizyq/rrZVW60RXmoJDDPEZkX1BmTPNXzywOpJOXwW82eGy5LyET18j71/Q
	 oeLnNhwqUpRNNJv1WZyR3ajvJOZLqDjeQxj9jIXmgoQJVmon6M1vChX1/KqrSS7r0V
	 Dw1Fk+Uulth7/4rQVz+cTgr+PuIzTcelO5aUzTapftfWFuf0w47eKnqi7/UWjNn1LN
	 voOkCfyoa8hkA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  andrew@lunn.ch,  hkallweit1@gmail.com,
  tmgross@umich.edu,  ojeda@kernel.org,  alex.gaynor@gmail.com,
  gary@garyguo.net,  bjorn3_gh@protonmail.com,  benno.lossin@proton.me,
  a.hindborg@samsung.com,  aliceryhl@google.com,  anna-maria@linutronix.de,
  frederic@kernel.org,  tglx@linutronix.de,  arnd@arndb.de,
  jstultz@google.com,  sboyd@kernel.org,  mingo@redhat.com,
  peterz@infradead.org,  juri.lelli@redhat.com,
  vincent.guittot@linaro.org,  dietmar.eggemann@arm.com,
  rostedt@goodmis.org,  bsegall@google.com,  mgorman@suse.de,
  vschneid@redhat.com,  tgunders@redhat.com,  me@kloenk.dev,
  david.laight.linux@gmail.com
Subject: Re: [PATCH v12 5/5] MAINTAINERS: rust: Add a new section for all of
 the time stuff
In-Reply-To: <Z_Hcg32LhKjqFkVG@boqun-archlinux> (Boqun Feng's message of "Sat,
	5 Apr 2025 18:44:35 -0700")
References: <20250406013445.124688-1-fujita.tomonori@gmail.com>
	<20250406013445.124688-6-fujita.tomonori@gmail.com>
	<Z_Hcg32LhKjqFkVG@boqun-archlinux>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sun, 06 Apr 2025 11:31:42 +0200
Message-ID: <87v7rhtz41.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Boqun Feng <boqun.feng@gmail.com> writes:

> On Sun, Apr 06, 2025 at 10:34:45AM +0900, FUJITA Tomonori wrote:
>> Add a new section for all of the time stuff to MAINTAINERS file, with
>> the existing hrtimer entry fold.
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>
>> ---
>>  MAINTAINERS | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d32ce85c5c66..fafb79c42ac3 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10581,20 +10581,23 @@ F:	kernel/time/timer_list.c
>>  F:	kernel/time/timer_migration.*
>>  F:	tools/testing/selftests/timers/
>>  
>> -HIGH-RESOLUTION TIMERS [RUST]
>> +DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]
>>  M:	Andreas Hindborg <a.hindborg@kernel.org>
>>  R:	Boqun Feng <boqun.feng@gmail.com>
>> +R:	FUJITA Tomonori <fujita.tomonori@gmail.com>
>>  R:	Frederic Weisbecker <frederic@kernel.org>
>>  R:	Lyude Paul <lyude@redhat.com>
>>  R:	Thomas Gleixner <tglx@linutronix.de>
>>  R:	Anna-Maria Behnsen <anna-maria@linutronix.de>
>> +R:	John Stultz <jstultz@google.com>
>> +R:	Stephen Boyd <sboyd@kernel.org>
>>  L:	rust-for-linux@vger.kernel.org
>>  S:	Supported
>>  W:	https://rust-for-linux.com
>>  B:	https://github.com/Rust-for-Linux/linux/issues
>> -T:	git https://github.com/Rust-for-Linux/linux.git hrtimer-next
>> -F:	rust/kernel/time/hrtimer.rs
>> -F:	rust/kernel/time/hrtimer/
>> +T:	git https://github.com/Rust-for-Linux/linux.git rust-timekeeping-next
>
> @Andreas, this branch is currently missing, right?

Yes, I'll ping Miguel to set it up when we are ready to go with this.


Best regards,
Andreas Hindborg




