Return-Path: <netdev+bounces-179025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEC8A7A13B
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 12:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F6518989A7
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 10:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD00524A071;
	Thu,  3 Apr 2025 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nahMCi8D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1811E04AC;
	Thu,  3 Apr 2025 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743676926; cv=none; b=e1Xkw5rY+k7nbK2HbRCay57BGxokmZWwCCEicL8wHL/AQxzbZTLQP9UzkLKDo0X7FO498FbzCSleuWF/ryqi+Ftb0qsY1MYITesLwiqplolO4SflWY4aoKQX4ueHO7w+X+WPIeLjz7poWfdsK2K0hv+zi626NkZSSwvfE7c2+jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743676926; c=relaxed/simple;
	bh=cQ+xu78fnQL2dNMW5nTACbZbpn5DUyuQK9MC0D500po=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UhVfI/1ZTr4QYIFvSC0PaXWj17gBF8654Ix5XO56C0NLwkqPTyM6vKRQXx8EJ4d3rM2jFitavDkpGBUyC8qHssQjE7G6giAzUi3flZg90iNmOJjKHHewZx7ymvTNfNOjeqe9M/O5suwqnjOhlT02Euno8XtyjOxszbnu1O2us7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nahMCi8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991DDC4CEE3;
	Thu,  3 Apr 2025 10:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743676925;
	bh=cQ+xu78fnQL2dNMW5nTACbZbpn5DUyuQK9MC0D500po=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nahMCi8DfymJdPrdn7QdiDD3Q8rDwmGOvJf1NoMlk42yNhXZCmhH8ZeJoSeZVMRGe
	 mlLn7120CdMWVO+pvpRFrjFMysdwrEUOH93be8/cDYcrfqL2wLp0eMqudzz1g7b9Wc
	 tGXtxBwGirpcKDB14QfW1H6Y3MC4HHvJuaXYtv9nMHguhCBJg44ZzkNrFbo3+X+bfo
	 ZOi7GyCd1H9ZDWQiEAmuasS4pR8NpKq8PBjgV7CMcTxaFKBXqj7/rOFb+0yWZRmEsK
	 qRlnBZI82XIyl0QFDyYLaATLWm0SgrvsM8SxHTbmTHTDSV0hxac8K7/3iJEQqnGtup
	 HLlsP/XuITz0w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
Cc: <linux-kernel@vger.kernel.org>,  <daniel.almeida@collabora.com>,
  <boqun.feng@gmail.com>,  <gary@garyguo.net>,  <me@kloenk.dev>,
  <rust-for-linux@vger.kernel.org>,  <netdev@vger.kernel.org>,
  <andrew@lunn.ch>,  <hkallweit1@gmail.com>,  <tmgross@umich.edu>,
  <ojeda@kernel.org>,  <alex.gaynor@gmail.com>,
  <bjorn3_gh@protonmail.com>,  <benno.lossin@proton.me>,
  <a.hindborg@samsung.com>,  <aliceryhl@google.com>,
  <anna-maria@linutronix.de>,  <frederic@kernel.org>,
  <tglx@linutronix.de>,  <arnd@arndb.de>,  <jstultz@google.com>,
  <sboyd@kernel.org>,  <mingo@redhat.com>,  <peterz@infradead.org>,
  <juri.lelli@redhat.com>,  <vincent.guittot@linaro.org>,
  <dietmar.eggemann@arm.com>,  <rostedt@goodmis.org>,
  <bsegall@google.com>,  <mgorman@suse.de>,  <vschneid@redhat.com>,
  <tgunders@redhat.com>,  <david.laight.linux@gmail.com>
Subject: Re: [PATCH v11 4/8] rust: time: Introduce Instant type
In-Reply-To: <20250403.134038.2188356790179825602.fujita.tomonori@gmail.com>
	(FUJITA Tomonori's message of "Thu, 03 Apr 2025 13:40:38 +0900")
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
	<20250220070611.214262-5-fujita.tomonori@gmail.com>
	<87iko1b213.fsf@kernel.org>
	<pk-Wz6K7ID9UBJQ5yv7aHqGztuRNqPlZv0ACr8K6kOMOzdan60fYn3vqlQFrf4NwwY5cXXp0jnYlX1nKpdlaGA==@protonmail.internalid>
	<20250403.134038.2188356790179825602.fujita.tomonori@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 03 Apr 2025 12:41:52 +0200
Message-ID: <87cydtv85r.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:

> On Sat, 22 Mar 2025 14:58:16 +0100
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>
>> FUJITA Tomonori <fujita.tomonori@gmail.com> writes:
>>
>>> Introduce a type representing a specific point in time. We could use
>>> the Ktime type but C's ktime_t is used for both timestamp and
>>> timedelta. To avoid confusion, introduce a new Instant type for
>>> timestamp.
>>>
>>> Rename Ktime to Instant and modify their methods for timestamp.
>>>
>>> Implement the subtraction operator for Instant:
>>>
>>> Delta = Instant A - Instant B
>>>
>>> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
>>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>>> Reviewed-by: Gary Guo <gary@garyguo.net>
>>> Reviewed-by: Fiona Behrens <me@kloenk.dev>
>>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>>
>>
>> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>>
>>
>> As Boqun mentioned, we should make this generic over `ClockId` when the
>> hrtimer patches land.
>
> Seems that I overlooked his mail. Can you give me a pointer?
>
> I assume that you want the Instance type to vary depending on the
> clock source.

Yea, basically it is only okay to subtract instants if they are derived
from the same clock source. Boqun suggested here [1] before hrtimer
patches landed I think.

At any rate, now we have `kernel::time::ClockId`. It is an enum though,
so I am not sure how to go about it in practice. But we would want
`Instant<RealTime> - Instant<BootTime>` to give a compiler error.


Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/all/ZxwFyl0xIje5gv7J@Boquns-Mac-mini.local


