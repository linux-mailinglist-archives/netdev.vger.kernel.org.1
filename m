Return-Path: <netdev+bounces-161302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DCCA208F4
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 11:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4740216255B
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 10:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C5A19E7F7;
	Tue, 28 Jan 2025 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="h46/7Sbw"
X-Original-To: netdev@vger.kernel.org
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F981991CA;
	Tue, 28 Jan 2025 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738061396; cv=none; b=CRZUGIfm4krWGWx6ynfppc07XH3mM7agUCDC5m8Cdze0Go6/Grg9AtWONgYxiXRZLI45n9tnTo5ybWSDTrQLEXUI4cWjS+7EH9TNd/rJMl3fXWWipwDfvY1VrDomOGEEouchk1soWkfRqr0WpGkqOVPm/v+ucG5P9vsSKPV7nNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738061396; c=relaxed/simple;
	bh=tQhZVViOKdYJwmJY9BFxJKbUw0FsxPZQFp5vTBlEyIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWSMXP/wJHSPiwrMfLIFcoxW2vqFOFgEgQES1VRncw7a+nk35hBtnaSBCJzq4D76worr72FNJxa2O0NLDcyd1V03K+eG2gup2ttJvVGnI/f6TFwj7A+YFwkAMidcgnVbguhK0nnc0KYq6WqC/TYyyGMtCHaLVcQbgt729fB/FBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=h46/7Sbw; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1738061390; bh=Sk5hqTOZF0xdzUDKdnW0ug8ercxLESQwOxYtUVWbC6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h46/7SbwWDW8a1VN0JXa3K525yqCrz1dBJFFA0Tk+xtL/tbi8KD9ysQC/oO2aFQaV
	 HsNqK8RCTev7lsuql9phKG+vC9LqEptSjfXikyt5K6Vbo60IhKcTw80jwKI/Q0WRGR
	 c7VzRmom8qrDv5uNjSc/Q8eOEROW/T+AV/BEQTQg=
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: gary@garyguo.net, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com,
 sboyd@kernel.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, tgunders@redhat.com
Subject: Re: [PATCH v9 7/8] rust: Add read_poll_timeout functions
Date: Tue, 28 Jan 2025 11:49:48 +0100
Message-ID: <64335523-D12A-4E65-9518-64FC08C26D39@kloenk.dev>
In-Reply-To: <20250128.152957.202492012529466658.fujita.tomonori@gmail.com>
References: <20250127114646.6ad6d65f@eugeo>
 <20250127.153147.1789884009486719687.fujita.tomonori@gmail.com>
 <20250128084937.2927bab9@eugeo>
 <20250128.152957.202492012529466658.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 28 Jan 2025, at 7:29, FUJITA Tomonori wrote:

> On Tue, 28 Jan 2025 08:49:37 +0800
> Gary Guo <gary@garyguo.net> wrote:
>
>> On Mon, 27 Jan 2025 15:31:47 +0900 (JST)
>> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>>
>>> On Mon, 27 Jan 2025 11:46:46 +0800
>>> Gary Guo <gary@garyguo.net> wrote:
>>>
>>>>> +#[track_caller]
>>>>> +pub fn read_poll_timeout<Op, Cond, T: Copy>(
>>>>> +    mut op: Op,
>>>>> +    mut cond: Cond,
>>>>> +    sleep_delta: Delta,
>>>>> +    timeout_delta: Delta,
>>>>> +) -> Result<T>
>>>>> +where
>>>>> +    Op: FnMut() -> Result<T>,
>>>>> +    Cond: FnMut(&T) -> bool,
>>>>> +{
>>>>> +    let start =3D Instant::now();
>>>>> +    let sleep =3D !sleep_delta.is_zero();
>>>>> +    let timeout =3D !timeout_delta.is_zero();
>>>>> +
>>>>> +    if sleep {
>>>>> +        might_sleep(Location::caller());
>>>>> +    }
>>>>> +
>>>>> +    loop {
>>>>> +        let val =3D op()?;
>>>>> +        if cond(&val) {
>>>>> +            // Unlike the C version, we immediately return.
>>>>> +            // We know the condition is met so we don't need to ch=
eck again.
>>>>> +            return Ok(val);
>>>>> +        }
>>>>> +        if timeout && start.elapsed() > timeout_delta {
>>>>
>>>> Re-reading this again I wonder if this is the desired behaviour? May=
be
>>>> a timeout of 0 should mean check-once instead of no timeout. The
>>>> special-casing of 0 makes sense in C but in Rust we should use `None=
`
>>>> to mean it instead?
>>>
>>> It's the behavior of the C version; the comment of this function says=
:
>>>
>>> * @timeout_us: Timeout in us, 0 means never timeout
>>>
>>> You meant that waiting for a condition without a timeout is generally=

>>> a bad idea? If so, can we simply return EINVAL for zero Delta?
>>>
>>
>> No, I think we should still keep the ability to represent indefinite
>> wait (no timeout) but we should use `None` to represent this rather
>> than `Delta::ZERO`.
>>
>> I know that we use 0 to mean indefinite wait in C, I am saying that
>> it's not the most intuitive way to represent in Rust.
>>
>> Intuitively, a timeout of 0 should be closer to a timeout of 1 and thu=
s
>> should mean "return with ETIMEDOUT immedidately" rather than "wait
>> forever".
>>
>> In C since we don't have a very good sum type support, so we
>> special case 0 to be the special value to represent indefinite wait,
>> but I don't think we need to repeat this in Rust.
>
> Understood, thanks. How about the following code?
>
> +#[track_caller]
> +pub fn read_poll_timeout<Op, Cond, T: Copy>(
> +    mut op: Op,
> +    mut cond: Cond,
> +    sleep_delta: Delta,
> +    timeout_delta: Option<Delta>,
> +) -> Result<T>
> +where
> +    Op: FnMut() -> Result<T>,
> +    Cond: FnMut(&T) -> bool,
> +{
> +    let start =3D Instant::now();
> +    let sleep =3D !sleep_delta.is_zero();
> +
> +    if sleep {
> +        might_sleep(Location::caller());
> +    }
> +
> +    loop {
> +        let val =3D op()?;
> +        if cond(&val) {
> +            // Unlike the C version, we immediately return.
> +            // We know the condition is met so we don't need to check =
again.
> +            return Ok(val);
> +        }
> +        if let Some(timeout_delta) =3D timeout_delta {
> +            if start.elapsed() > timeout_delta {
> +                // Unlike the C version, we immediately return.
> +                // We have just called `op()` so we don't need to call=
 it again.
> +                return Err(ETIMEDOUT);
> +            }
> +        }
> +        if sleep {
> +            fsleep(sleep_delta);
> +        }
> +        // fsleep() could be busy-wait loop so we always call cpu_rela=
x().
> +        cpu_relax();
> +    }
> +}

I wonder if it makes sense to then switch `Delta` to wrap a  `NonZeroI64`=
 and forbid deltas with 0 nanoseconds with that and use the niche optimiz=
ation. Not sure if we make other apis horrible by that, but this would pr=
event deltas that encode no time passing.

Thanks,
Fiona

