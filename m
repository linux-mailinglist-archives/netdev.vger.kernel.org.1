Return-Path: <netdev+bounces-138219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085879ACA13
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678C1B22876
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19EB1AC8B8;
	Wed, 23 Oct 2024 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7RZ81Dj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A821AC882;
	Wed, 23 Oct 2024 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729686842; cv=none; b=QXCWqwWtZiJRQAC//DNmpni3aHD1XpYrxNB7O7K+bzdEsSn9G1Lj04KoS2zS+LlM0QOHzQSLyNLh5h27fFLRhoCH/hh5Yn4i21jSd4o9lU2k+/UnXbLocOGEmNQLuxpLBNh9iOHU7dOM23iDcKJOLL2bTXLbEUaGs1b3ZuSHd18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729686842; c=relaxed/simple;
	bh=6qBPmAgCD2RNJ5ERNzeh2m1p2+HKuBilNgolUWw92fQ=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kJK555oyeJV85qCUsdX46+PiOTLAmkAFO2M6Kkf7aBjfroqaNiF7NHnsp5zxwQCHlH47skf+0tdIMxWucmwdFGBqueABxBFsrHtlB96pAq0rx9yiNKUyCX8WrRcJ3vtdL8b6rUnbGIgu9q/t5+K+WUzzxAyINiLFsu7Fp1EOGDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7RZ81Dj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-208cf673b8dso65493035ad.3;
        Wed, 23 Oct 2024 05:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729686840; x=1730291640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ue+11o5O3jAWZIekjz1MSKEWKTEaJ2momNJN9wnFir8=;
        b=I7RZ81DjwHMplg2XiIzk1b8cjeS/J7OJvxeXBvG0cHl7Qjx9gUrblRD2C4gexBbbKj
         Om0hHfNtHS7M3z0UrQ0e5wzDl/qxjWGyULrUu3ZcCh+IdsYJY7f0fDqY1rQd8xSjhHQO
         GhFSUTY+qxrZuMW3W+zdwCFjkRK7usOCXVseI07TPOgj5ECDJjUhE915PvKm0vayTG1Y
         8SOnjwoWQ52Qi0E3hWAzoDsxWAsS+bhtIa7x0iNDAT8vL2eR5UmkVkLifnRep6/YlQ0K
         3bhHlkRYSQpS9MX1LVADZa9Un1Ihgaxo/AgxT8OYg7rXSff8qUBHCLDSnlhYdPFBIkyP
         7AGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729686840; x=1730291640;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ue+11o5O3jAWZIekjz1MSKEWKTEaJ2momNJN9wnFir8=;
        b=sMi4egnAiyrqXrIplDwWGztlzjLxZKeDlk1W59YflPA71UTaCBN9tmqlWIY9WOyuT8
         YW4nDRN4VwBfIXkw5R3AF5J1EzjsGXuVyxhx08aSdMbbzOEhzBnk0kPcAHD8mZLngUHl
         +PwnDwO++5UwfRkQW6P3Sz9RKOC6Yn4/jtjeP5DfTXDtu+26DnWW7ptwaC8ncw1t4ujz
         0MK4D8JR7tpUiyQnU5ntsuq91aZxw6u6PU4CRS4+bG2riTAw3BWb7ZzAslOSS85PBJ4W
         WzWVHO59U4xM+rCTZ2tnZ8pt2NI7jBkXIfqXnNNgXaq+KCROpKaloCCsrDrVMxghDzlh
         HbzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2kJnbMmwV02fg54Ml6t299u6sea/MhO+FilJ5YecDGS1vTRl1n2iwz2BSLogOqsBnUHdkFY7j@vger.kernel.org, AJvYcCVQzYeVBD9L8Qv/Mdt96DWuw5TtjkUvr4i5GJBcbryjP/WEeMIM6VRfl41je9y7NINT9mmvYJ+fHMCTdSA=@vger.kernel.org, AJvYcCX/becbvJI34l3TFOxS/DeiveR8H1t9EnKkGDmvjGzQjKow95pcQ34N/qz9S18tm9kbvyM7gGFhlUjTVNm3EZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9m8uPLT0eJD6RWUrhZmTmzkyOH1/ShhAN0APiWcIhy9mQzxE
	1Q4zl7AZ+B7nIy3Qux0T95/Ukc83D4838DUHDSD6BgiZmFI6x10h
X-Google-Smtp-Source: AGHT+IH9n/qU6Rv+MXUSEUJm4JVUaOK76SXTgg8tMJecu8olE0KEpAZsSmxYsevEjWL/iDDH23E0yw==
X-Received: by 2002:a17:902:f541:b0:20c:5b80:930f with SMTP id d9443c01a7336-20fa9e29844mr31991765ad.12.1729686840422;
        Wed, 23 Oct 2024 05:34:00 -0700 (PDT)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef0ad34sm56832105ad.68.2024.10.23.05.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 05:34:00 -0700 (PDT)
Date: Wed, 23 Oct 2024 21:33:45 +0900 (JST)
Message-Id: <20241023.213345.2086786446806395897.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/8] rust: time: Add wrapper for fsleep
 function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgjTGmD0=9wJRP+aNtHC2ab7e9tuRwnPZZt8RN3wpmZHBg@mail.gmail.com>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
	<20241016035214.2229-6-fujita.tomonori@gmail.com>
	<CAH5fLgjTGmD0=9wJRP+aNtHC2ab7e9tuRwnPZZt8RN3wpmZHBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 10:29:12 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

>> diff --git a/rust/kernel/time/delay.rs b/rust/kernel/time/delay.rs
>> new file mode 100644
>> index 000000000000..dc7e2b3a0ab2
>> --- /dev/null
>> +++ b/rust/kernel/time/delay.rs
>> @@ -0,0 +1,31 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Delay and sleep primitives.
>> +//!
>> +//! This module contains the kernel APIs related to delay and sleep that
>> +//! have been ported or wrapped for usage by Rust code in the kernel.
>> +//!
>> +//! C header: [`include/linux/delay.h`](srctree/include/linux/delay.h).
>> +
>> +use crate::time;
>> +use core::ffi::c_ulong;
>> +
>> +/// Sleeps for a given duration at least.
>> +///
>> +/// Equivalent to the kernel's [`fsleep`], flexible sleep function,
>> +/// which automatically chooses the best sleep method based on a duration.
>> +///
>> +/// `Delta` must be longer than one microsecond.
> 
> Why is this required? Right now you just round up to one microsecond,
> which seems okay.

Oops, it should have been removed.

>> +/// This function can only be used in a nonatomic context.
>> +pub fn fsleep(delta: time::Delta) {
>> +    // SAFETY: FFI call.
>> +    unsafe {
>> +        // Convert the duration to microseconds and round up to preserve
>> +        // the guarantee; fsleep sleeps for at least the provided duration,
>> +        // but that it may sleep for longer under some circumstances.
>> +        bindings::fsleep(
>> +            ((delta.as_nanos() + time::NSEC_PER_USEC - 1) / time::NSEC_PER_USEC) as c_ulong,
> 
> You probably want this:
> 
> delta.as_nanos().saturating_add(time::NSEC_PER_USEC - 1) / time::NSEC_PER_USEC
> 
> This would avoid a crash if someone passes i64::MAX nanoseconds and
> CONFIG_RUST_OVERFLOW_CHECKS is enabled.

Ah, I'll fix.

Thanks!

