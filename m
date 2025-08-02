Return-Path: <netdev+bounces-211441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA52B18A1B
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 03:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6090564440
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 01:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0466F53E;
	Sat,  2 Aug 2025 01:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mhi26C6r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837BE61FCE;
	Sat,  2 Aug 2025 01:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754098991; cv=none; b=GCSWg0q8Agg5rTDkt8LdunBmySF1196bRgRot0F3thCCgiWmY2qaeLI3I3p1ZsIzuTJ78JjZwU/aGTtllVn0Vuddjz5X0Am0K1zmaopYxfohWTYiwLKd9pv198kFP3zCOBWYFbt9WaApevEFPZgpfzgoTp5OmNGkl6QqKniUimc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754098991; c=relaxed/simple;
	bh=ARy/VX6CUs3jjxJVZ3MNm1sHP/MaQEYGr4CUfc45x7M=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GcAp9qxu8fZb8eD/Kmkjrqp8olkN5gBHpRV4RI9rxzwNgRTuB7xxRiYUblVfuRzUg0jPiQ0vCfPSJEfSbpLnWNbrcmJxiNvuZDYRDDOZ4rNwNQ6z3cLuCFcgguHSl0Xhdn2hoUrFLbpc5OafQwhxBReoY8rcnPd7h21iZJu3Xeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mhi26C6r; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23aeac7d77aso24506055ad.3;
        Fri, 01 Aug 2025 18:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754098989; x=1754703789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=weJuLYF1Nsaic0ACg/G0aZsZAS+W9k65EY14a4+MR14=;
        b=Mhi26C6rPySrNLDuHIAFZbt02XHWMvoYJSzz3vwO6WXMz3X6OqHheibF8+ifLiscY9
         u6MaZ4nTcjOg2zre8zzwzt6xk3gL1MiKxEhifzmRRVxi64shDeina1dMfmR6kMZhVtts
         WTMcFA6ITZr/15HgKaLanJAYoCTPuVWAxWf1539iFO8+CdXdIFNZcemA8taxrYwEqEBW
         ajQ2qurKYMYiHXzD2m6+3Md2n6ejxbNPL84swsEhoeoFrC049lcYaLNJUDeScyfKmp4S
         UpxPQI70eOXL5a8UGT5gCHxtD3JJdM2+pHu3HslmME0sPP/yKzT9qLnrHadsDr4QsLHJ
         ypPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754098989; x=1754703789;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=weJuLYF1Nsaic0ACg/G0aZsZAS+W9k65EY14a4+MR14=;
        b=pI/+8EcvF0y/TSUF8yNuXzGm+3KiVghULKzhyxJ4qnODRqBE1LlnMokLZfzUpDTR3Q
         Q6UdjGC+a2GzxgVO5nNI8mzj99mc5y8rZDCwGWdDbu6/MPzIvE8yjSwIryVgmOTJ9QB7
         Wnmmmq/mELGvIabJ7WLjv0PDnfVIaB6dj5zTNJxWUqc7NFa7pQBqzp21u4VT/rZSuijg
         lQLI2xxjDEpDifyHO2V6TJywYAL++lH7vVMTy99vJmhlunkifiTkSwkUHdGflnb1x4kC
         4gNU8TVVOUdGkyxyTGX0IIpzbdRL+Zv5G+rz5bzqHpRpgo2Ntet+8t4q2wEFu3h+T4yE
         2jQw==
X-Forwarded-Encrypted: i=1; AJvYcCVO0nhCZb3RCQhFXZNPI7n2lPrnATla/bZosAaa1TgL0hwz9RSA3JRqNAYYcfCtfb1MEVadzi3WY3ZLzHQ=@vger.kernel.org, AJvYcCWfYAqBhjrFT4tedKKQLSgbC7Aj0PonKU1H0ePSFjVOskX8IQ9SLQK5ByipfzyNDEm66GzQ1RE1s4PNrzFOrK8=@vger.kernel.org, AJvYcCXzvAXHogKnD0nV5ieEmqHCAXCwldqKFrUY2kdl+yxPl/KlUv/Q/GLhmKd8MP5BU89K5LN6BAqz@vger.kernel.org
X-Gm-Message-State: AOJu0YyltCvPIZqqVyU/YzjNALSryykMmhAMRSkkNgciUm98+9GAgHfB
	h0wEePr5E/vzObFaDTF3nxJmO7WaMCwaaFBPIXfcslFcXYQMYv7OtwMk
X-Gm-Gg: ASbGnct7mbX2gMPdFBEI14/wOvhBmyUG4/y5pkL9fYZr7kVwRdSMP0B+GChkB0QSVFF
	AI/WIIw/3sjrpDBKz47R3NiivNJYw80tOMD7AqXMSUkb/8b6OFs55ykWKjNcZzD3FhTJ0yZkn79
	r/r9d4suGAVQH2N2fQ0wcYP/c/sgXD7CXnxcWYaPP32r91Sl0nn69tcJ4Q1x2UZ1qCzKEh5anFs
	/PiWbxe3XGsE2QOr42HZJmdHi9sV1JB/0+q/oImToXIiMpaWGQJW17ExA4WoKtpzjS2lsDElBj4
	xAhr6MkOEIH3Ya/LTi6Dbs8EN3qj/vhwSmXP7CJ4R2Q+2cGX+mvmvTpYMHiT0Bl8nRyGPpjwud0
	YWBuAV892fr+oOM+BhXoD+RqtJzCzIJePBictIV3DQgVKp4zI/bxM2W+muoDFi0tuyuj08JH8zq
	mUEWADu1iZOho=
X-Google-Smtp-Source: AGHT+IGpj7ZTXaNNi8srTiSWbwjEF29bnu8RW8Dm7uu03Hq1nM3LY13P6VnpK8b3t21ni7GPHufQBA==
X-Received: by 2002:a17:903:2c7:b0:223:65dc:4580 with SMTP id d9443c01a7336-2424706db41mr22115975ad.52.1754098988625;
        Fri, 01 Aug 2025 18:43:08 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102b2c24fsm1466731a91.3.2025.08.01.18.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 18:43:08 -0700 (PDT)
Date: Sat, 02 Aug 2025 10:42:49 +0900 (JST)
Message-Id: <20250802.104249.1482605492526656971.fujita.tomonori@gmail.com>
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
In-Reply-To: <DBNPR4KQZXY5.279JBMO315A12@kernel.org>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
	<20250220070611.214262-8-fujita.tomonori@gmail.com>
	<DBNPR4KQZXY5.279JBMO315A12@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 15:13:45 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Thu Feb 20, 2025 at 8:06 AM CET, FUJITA Tomonori wrote:
>> diff --git a/rust/kernel/cpu.rs b/rust/kernel/cpu.rs
>> new file mode 100644
>> index 000000000000..eeeff4be84fa
>> --- /dev/null
>> +++ b/rust/kernel/cpu.rs
>> @@ -0,0 +1,13 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Processor related primitives.
>> +//!
>> +//! C header: [`include/linux/processor.h`](srctree/include/linux/processor.h).
>> +
>> +/// Lower CPU power consumption or yield to a hyperthreaded twin processor.
>> +///
>> +/// It also happens to serve as a compiler barrier.
>> +pub fn cpu_relax() {
>> +    // SAFETY: FFI call.
>> +    unsafe { bindings::cpu_relax() }
>> +}
> 
> Please split this out in a separate patch.

I will.

>> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
>> index f6ecf09cb65f..8858eb13b3df 100644
>> --- a/rust/kernel/error.rs
>> +++ b/rust/kernel/error.rs
>> @@ -64,6 +64,7 @@ macro_rules! declare_err {
>>      declare_err!(EPIPE, "Broken pipe.");
>>      declare_err!(EDOM, "Math argument out of domain of func.");
>>      declare_err!(ERANGE, "Math result not representable.");
>> +    declare_err!(ETIMEDOUT, "Connection timed out.");
>>      declare_err!(ERESTARTSYS, "Restart the system call.");
>>      declare_err!(ERESTARTNOINTR, "System call was interrupted by a signal and will be restarted.");
>>      declare_err!(ERESTARTNOHAND, "Restart if no handler.");
>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>> index d4a73e52e3ee..be63742f517b 100644
>> --- a/rust/kernel/io.rs
>> +++ b/rust/kernel/io.rs
>> @@ -7,6 +7,8 @@
>>  use crate::error::{code::EINVAL, Result};
>>  use crate::{bindings, build_assert};
>>  
>> +pub mod poll;
>> +
>>  /// Raw representation of an MMIO region.
>>  ///
>>  /// By itself, the existence of an instance of this structure does not provide any guarantees that
>> diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
>> new file mode 100644
>> index 000000000000..5977b2082cc6
>> --- /dev/null
>> +++ b/rust/kernel/io/poll.rs
>> @@ -0,0 +1,120 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! IO polling.
>> +//!
>> +//! C header: [`include/linux/iopoll.h`](srctree/include/linux/iopoll.h).
>> +
>> +use crate::{
>> +    cpu::cpu_relax,
>> +    error::{code::*, Result},
>> +    time::{delay::fsleep, Delta, Instant},
>> +};
>> +
>> +/// Polls periodically until a condition is met or a timeout is reached.
>> +///
>> +/// The function repeatedly executes the given operation `op` closure and
>> +/// checks its result using the condition closure `cond`.
> 
> I'd add an empty line here,
>
>> +/// If `cond` returns `true`, the function returns successfully with the result of `op`.
>> +/// Otherwise, it waits for a duration specified by `sleep_delta`
>> +/// before executing `op` again.
> 
> and here.

Sure, I'll add at both places.

>> +/// This process continues until either `cond` returns `true` or the timeout,
>> +/// specified by `timeout_delta`, is reached. If `timeout_delta` is `None`,
>> +/// polling continues indefinitely until `cond` evaluates to `true` or an error occurs.
>> +///
>> +/// # Examples
>> +///
>> +/// ```rust,ignore
> 
> Why ignore? This should be possible to compile test.

https://lore.kernel.org/rust-for-linux/CEF87294-8580-4C84-BEA3-EB72E63ED7DF@collabora.com/

>> +/// fn wait_for_hardware(dev: &mut Device) -> Result<()> {
> 
> I think the parameter here can just be `&Io<SIZE>`.
> 
>> +///     // The `op` closure reads the value of a specific status register.
>> +///     let op = || -> Result<u16> { dev.read_ready_register() };
>> +///
>> +///     // The `cond` closure takes a reference to the value returned by `op`
>> +///     // and checks whether the hardware is ready.
>> +///     let cond = |val: &u16| *val == HW_READY;
>> +///
>> +///     match read_poll_timeout(op, cond, Delta::from_millis(50), Some(Delta::from_secs(3))) {
>> +///         Ok(_) => {
>> +///             // The hardware is ready. The returned value of the `op`` closure isn't used.
>> +///             Ok(())
>> +///         }
>> +///         Err(e) => Err(e),
>> +///     }
>> +/// }
>> +/// ```
>> +///
>> +/// ```rust
>> +/// use kernel::io::poll::read_poll_timeout;
>> +/// use kernel::time::Delta;
>> +/// use kernel::sync::{SpinLock, new_spinlock};
>> +///
>> +/// let lock = KBox::pin_init(new_spinlock!(()), kernel::alloc::flags::GFP_KERNEL)?;
>> +/// let g = lock.lock();
>> +/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), Some(Delta::from_micros(42)));
>> +/// drop(g);
>> +///
>> +/// # Ok::<(), Error>(())
>> +/// ```
>> +#[track_caller]
>> +pub fn read_poll_timeout<Op, Cond, T>(
>> +    mut op: Op,
>> +    mut cond: Cond,
>> +    sleep_delta: Delta,
>> +    timeout_delta: Option<Delta>,
>> +) -> Result<T>
>> +where
>> +    Op: FnMut() -> Result<T>,
>> +    Cond: FnMut(&T) -> bool,
>> +{
>> +    let start = Instant::now();
>> +    let sleep = !sleep_delta.is_zero();
>> +
>> +    if sleep {
>> +        might_sleep();
>> +    }
> 
> I think a conditional might_sleep() is not great.
> 
> I also think we can catch this at compile time, if we add two different variants
> of read_poll_timeout() instead and be explicit about it. We could get Klint to
> catch such issues for us at compile time.

Your point is that functions which cannot be used in atomic context
should be clearly separated into different ones. Then Klint might be
able to detect such usage at compile time, right?

How about dropping the conditional might_sleep() and making
read_poll_timeout return an error with zero sleep_delta?

Drivers which need busy-loop (without even udelay) can
call read_poll_timeout_atomic() with zero delay.



