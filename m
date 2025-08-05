Return-Path: <netdev+bounces-211700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7677B1B511
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 15:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D17E6210F6
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 13:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E950B274FE8;
	Tue,  5 Aug 2025 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQYqvUHn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5543E25A341;
	Tue,  5 Aug 2025 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401062; cv=none; b=YUmBfzlXjCtATmRxKnUSDaNO8H4i2ToNCbGmtnNdvL2c7U8wY0hmPzkvcN/wyvbZCNiPI8yXf9yVi6uIYVD5eikUIZiRYUXrdAwwDCWxxSWmO6cKRMFZfpLSZFcq0HSpby/H6RoDG4JVhpR9k5BhGXgGooutIcBYIoXszl7/nrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401062; c=relaxed/simple;
	bh=mPSsj2ncxMMlcv0RsZ6mN78BHOw/uNMUAcUoAvbjIOo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NS4GhWLaPE/54GbohF5lWS7Xb7+sNJzPv1XxhxUBpo+EVWGZOmlLo7keGQ/iAPtBXlkD4CmeKkMfnRMrFMWJ4/VQ6YRgfPcP9E3E5eecPNTHZpEe+LuA2V2DbhyM/Ag3FFHGvlNbNpS734L3PpeAHPalT5W8WniJd8O3e66xlBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQYqvUHn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24009eeb2a7so44151785ad.0;
        Tue, 05 Aug 2025 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754401060; x=1755005860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiS8BhJ936jcB2tyM9Y30V/6/vFqlgQAd81Grs50doc=;
        b=dQYqvUHnYCoVqk+MhDVjiC2MjuDVYXBoRGC+fp/b3FqmMJ+utT6C6bV/OrAuAtBTGx
         QUQFTlbSc3JT5FpGjQE2PggM8c1xu4whBCVbJxJy+9HDHOrD7ik6fU+cCiQEicPStzsM
         4XF84RU/oTu3gLvcYZ+yPQw/PsAddX/BoyBET752uYtDgOWC3JjRPFcDrj6yL80L4uBE
         6fyicwavWnnCNZ+iODU5nIWlYnIoB11UV/YHv5WjCSm9MaEsdZq+Z93bSUmmeeg9QqU+
         ed6THOuTlUaXDdYk5gI1vYfPHPsADXw5V4awwQHQTr0EbMN7oRHM6F5AVbmy6D6UZyoh
         engA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754401060; x=1755005860;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LiS8BhJ936jcB2tyM9Y30V/6/vFqlgQAd81Grs50doc=;
        b=Bw59JqcQZWyND2zQpncSM3i1kae6VqjgO/cBmi/XMf1tQeJIpUCayPFxKIHwzTop8v
         2mvoIvbYVs4/6YqxM1uAL6bg8dyXFz9guwtCM5tYcj+PsizaxMLhDNADI6n5v2vyzUh8
         L3FIArF/Yw9ErqMrHXpRxYXun29JKXwGvqyvq7V//PB7iaRNqgFDYyrusj2TXrhis8QS
         Qpmnu3kpZBYebOL/XK84v6XjBS6sSrp3oG4nlPyR7LOlb7TgvHGJxVL1ro2atPYO4N0o
         LDHwPEfvxtSsqOW691mKefzoT6Gk1RCAL8381U+uDolU5WQwvKM8cj0WJppYlVi0tDCN
         lc7A==
X-Forwarded-Encrypted: i=1; AJvYcCUdK9Gh1UcPleoWMGQjEs/MIhZ+dBj1ucWbqYHk0B4FO3GKUF5WqNP089UYdY8wpN77sBO+oe5bAWLkxiQ=@vger.kernel.org, AJvYcCUelTaumoIsFDozRholcy3LgDU25mMg8JXqakRXHn33ajNBRbs7JMWuCj60uatw1tUvLB5egVKM@vger.kernel.org, AJvYcCXtHt1di7UDeohKltaO+TCQJrPyTODRP6162CcKwAFl+D5vrOtf0LoVFIvQcjbVZoaXnWd/MS8hv4snsgoQMjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxzBiweb1ieFZd7N3brfmL19va5ski7FYGWezO351QFHZ8ev0q
	mP3mo6OX28RPO4UOEx5wmRvFI3XBXncrm/edloR8wC/IlXVukDRlmmbS
X-Gm-Gg: ASbGncsn4npUdxETlDYU2JbkyUaG6AnryVkwx892z63FPtYLZ533MNTAisGHbPILwHd
	RU3hKYaldZZrqF0fugV8fzXVIBB/+n3aDtVzOdDdTf7NT281/EytsynNJE21HAIey0UeloZD+yF
	r2DORzrza/mLS3W8PtVKoREE90PgZN9/TkSA0JTQ7LkmDjp66VYAAIswKzBDJuYn9qFKLPM7JIz
	nv5p1wzgNqKXY9gODOk0MaoPDbHJ4iUyw/aRemMTsi/R+mJkB8bXkgxgwOo/hxnM80KsGftuAHK
	Rz/v3UWGpe4W3aVCxIGhgZPS6EIshvQKZI+p0gtteuCldHn4vnjYSpu17wQ1qrSARMCPWewjg93
	/W+AV1B/QwneII/mWZDd02dyGqzSRN1K/VON+9xnCct5GcO16rbNeRTnAQ9yNAJsn4QmYdYlGkY
	t8
X-Google-Smtp-Source: AGHT+IGrXZA4Ihax4H+y51EM2ka6Nzm9Z3DpiVncTVWgN9IOSBjGcWevdKSSHxn3+TReo3p380OpXA==
X-Received: by 2002:a17:903:2f87:b0:23f:cf96:3071 with SMTP id d9443c01a7336-24247033f3dmr211033265ad.49.1754401059445;
        Tue, 05 Aug 2025 06:37:39 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976cb1sm134913705ad.89.2025.08.05.06.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 06:37:38 -0700 (PDT)
Date: Tue, 05 Aug 2025 22:37:21 +0900 (JST)
Message-Id: <20250805.223721.524503114987740782.fujita.tomonori@gmail.com>
To: dakr@kernel.org
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev,
 david.laight.linux@gmail.com
Subject: Re: [PATCH v11 7/8] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <DBRW63AMB4D8.2HXGYM6FZRX3Z@kernel.org>
References: <DBNPR4KQZXY5.279JBMO315A12@kernel.org>
	<20250802.104249.1482605492526656971.fujita.tomonori@gmail.com>
	<DBRW63AMB4D8.2HXGYM6FZRX3Z@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 02 Aug 2025 13:06:04 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Sat Aug 2, 2025 at 3:42 AM CEST, FUJITA Tomonori wrote:
>> On Mon, 28 Jul 2025 15:13:45 +0200
>> "Danilo Krummrich" <dakr@kernel.org> wrote:
>>> On Thu Feb 20, 2025 at 8:06 AM CET, FUJITA Tomonori wrote:
>>>> +/// This process continues until either `cond` returns `true` or the timeout,
>>>> +/// specified by `timeout_delta`, is reached. If `timeout_delta` is `None`,
>>>> +/// polling continues indefinitely until `cond` evaluates to `true` or an error occurs.
>>>> +///
>>>> +/// # Examples
>>>> +///
>>>> +/// ```rust,ignore
>>> 
>>> Why ignore? This should be possible to compile test.
>>
>> https://lore.kernel.org/rust-for-linux/CEF87294-8580-4C84-BEA3-EB72E63ED7DF@collabora.com/
> 
> I disagree with that. 'ignore' should only be used if we can't make it compile.
> 
> In this case we can make it compile, we just can't run it, since there's no real
> HW underneath that we can read registers from.
> 
> An example that isn't compiled will eventually be forgotten to be updated when
> things are changed.

I also prefer the example that can be compiled however I can't think
of a compilable example that is similar to actual use cases (for
example, waiting for some hardware condition). Do you have any ideas?

>>>> +/// fn wait_for_hardware(dev: &mut Device) -> Result<()> {
>>> 
>>> I think the parameter here can just be `&Io<SIZE>`.
>>> 
>>>> +///     // The `op` closure reads the value of a specific status register.
>>>> +///     let op = || -> Result<u16> { dev.read_ready_register() };
>>>> +///
>>>> +///     // The `cond` closure takes a reference to the value returned by `op`
>>>> +///     // and checks whether the hardware is ready.
>>>> +///     let cond = |val: &u16| *val == HW_READY;
>>>> +///
>>>> +///     match read_poll_timeout(op, cond, Delta::from_millis(50), Some(Delta::from_secs(3))) {
>>>> +///         Ok(_) => {
>>>> +///             // The hardware is ready. The returned value of the `op`` closure isn't used.
>>>> +///             Ok(())
>>>> +///         }
>>>> +///         Err(e) => Err(e),
>>>> +///     }
>>>> +/// }
>>>> +/// ```
>>>> +///
>>>> +/// ```rust
>>>> +/// use kernel::io::poll::read_poll_timeout;
>>>> +/// use kernel::time::Delta;
>>>> +/// use kernel::sync::{SpinLock, new_spinlock};
>>>> +///
>>>> +/// let lock = KBox::pin_init(new_spinlock!(()), kernel::alloc::flags::GFP_KERNEL)?;
>>>> +/// let g = lock.lock();
>>>> +/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), Some(Delta::from_micros(42)));
>>>> +/// drop(g);
>>>> +///
>>>> +/// # Ok::<(), Error>(())
>>>> +/// ```
>>>> +#[track_caller]
>>>> +pub fn read_poll_timeout<Op, Cond, T>(
>>>> +    mut op: Op,
>>>> +    mut cond: Cond,
>>>> +    sleep_delta: Delta,
>>>> +    timeout_delta: Option<Delta>,
>>>> +) -> Result<T>
>>>> +where
>>>> +    Op: FnMut() -> Result<T>,
>>>> +    Cond: FnMut(&T) -> bool,
>>>> +{
>>>> +    let start = Instant::now();
>>>> +    let sleep = !sleep_delta.is_zero();
>>>> +
>>>> +    if sleep {
>>>> +        might_sleep();
>>>> +    }
>>> 
>>> I think a conditional might_sleep() is not great.
>>> 
>>> I also think we can catch this at compile time, if we add two different variants
>>> of read_poll_timeout() instead and be explicit about it. We could get Klint to
>>> catch such issues for us at compile time.
>>
>> Your point is that functions which cannot be used in atomic context
>> should be clearly separated into different ones. Then Klint might be
>> able to detect such usage at compile time, right?
>>
>> How about dropping the conditional might_sleep() and making
>> read_poll_timeout return an error with zero sleep_delta?
> 
> Yes, let's always call might_sleep(), the conditional is very error prone. We
> want to see the warning splat whenever someone calls read_poll_timeout() from
> atomic context.
> 
> Yes, with zero sleep_delta it could be called from atomic context technically,
> but if drivers rely on this and wrap this into higher level helpers it's very
> easy to miss a subtle case and end up with non-zero sleep_delta within an atomic
> context for some rare condition that then is hard to debug.
> 
> As for making read_poll_timeout() return a error with zero sleep_delta, I don't
> see a reason to do that. If a driver wraps read_poll_timeout() in its own
> function that sometimes sleeps and sometimes does not, based on some condition,
> but is never called from atomic context, that's fine.

Ok, let's always call might_sleep, even when there's no possibility of
sleeping.

>> Drivers which need busy-loop (without even udelay) can
>> call read_poll_timeout_atomic() with zero delay.
> 
> It's not the zero delay or zero sleep_delta that makes the difference  it's
> really the fact the one can be called from atomic context and one can't be.

That's what I meant.

Since calling read_poll_timeout_atomic() with zero delay can achieve
the same thing as calling read_poll_timeout with zero sleep delta, I
thought the zero sleep delta in read_poll_timeout is unncessary.

But as in the use case you mentioned above, a driver could use the
sleep delta that is not const and calls the function with both
non-zero and zero delta values so let's keep zero sleep delta support.



