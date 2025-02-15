Return-Path: <netdev+bounces-166658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A714EA36D1C
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 10:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECD71677BC
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 09:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680561953AD;
	Sat, 15 Feb 2025 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdIEsFke"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D119B19049B;
	Sat, 15 Feb 2025 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739612894; cv=none; b=rq2sJZOtjRPhCYmiYhm3kyKDVI2vjSpbdQ5O25mJvpu1WvFuX86rWFUYpmPQYH4SRWP1isLOEhvkQJXP83956LL6JzOqyBbfRNXvBpVuGW7G+ZWBLQiEsrMpU8pw7A52/RhdUid99Nun2AtUeB4JIsOZv5EsuIRFHltXbwRFfYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739612894; c=relaxed/simple;
	bh=5p1qxbmmokb/RCjmP0J0KXsqx7Q/xH8ph31KI4qY+is=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XpdOcvHUichgGiI661RxjQZx9k1a05VIOBDukhOozhhyiigxxHR1u9Hc4q00rcf8dymtHsdx6jxb++oOPOjfN40Xj8DueDWsYpQcC9HWguLNvBrLlE/fjuC2BBgvLUR89PK8lQwVqAiOpND/ioe2M3XvI24mIXW9NfApTWZn03o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdIEsFke; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220d39a5627so42415695ad.1;
        Sat, 15 Feb 2025 01:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739612891; x=1740217691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVUIuv5v60t9dUYELYCuiXZ/SdEpKJMXESO8sDLvOaw=;
        b=ZdIEsFkehPXmP/+UtvaUfX/y6oywKDbJURPxEDkalpCYNBpIJ16gJaNtu9grQITemU
         GwElHt6iWA5kWqrlX+Zk5bHIApw+Niyb1pzlLCI/sVYLUvOzEZQUhmtfFpimfsqDx8lS
         /qoyCrqTKCqhfDWao6vcZdeiX1hItHJMa38TCs9JOZPuxeFuutDLzXdE8A0bIWXdU9Mm
         b8+l3rsK3y/MyabU0d50tPUNepXjuldLdCnjNnhXUW8DI2gZOjyY17of5Eh0PtSLCIk3
         R1Ynkjffd1ajnASj3rOOt2zNHNzT5Ph85vX5RYLZn97ViRpp0ESQNSvB0SnoXB1h+6/F
         gf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739612891; x=1740217691;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lVUIuv5v60t9dUYELYCuiXZ/SdEpKJMXESO8sDLvOaw=;
        b=NFdpRTYokZh3gFJdLVUhYQPZnBwiE4LGBw4sYL7m+SCAAJ4AAf57UbqV6dVh1JnD2D
         6+m0cNVHlREkIlnyQtGsNqHX7qg9POFXjhwLsTAwFI1cWnLt1jKmJxhFvmaQvhr2GdtA
         wf5cK2xl9jhbUCw5XMx2gOgvQiRdfLU675YbkMU7zZgEYXDU2vpdXjKxveYVZzRxEbTJ
         vyCGjAauzIOYL7Y/UbNMx9knpOn2G9/sbZvkuUgMV37WMI2hiBd3SIbGOEO91GfAuR8p
         2caLqyW3i04kcdqCSdyYYqrSNTrzGh1cFmW8tVMiHbhZpUjrH494KN+GMOqoq+0WUR10
         CjGw==
X-Forwarded-Encrypted: i=1; AJvYcCUwb4CdN3EsfI0iHTENuOXje1JR2S24UJOjL3K6RRWqjB//uKBTCilkm5PdGWS2YCR8TGuYEUSeoPreW/hVaO4=@vger.kernel.org, AJvYcCV54OJruluIKfMFmhdqznZDmWDzG1kTixEKV4wV4ce8iDYnV+UM5z7MM4gYSXmBtoWxMUTYh2Rp@vger.kernel.org, AJvYcCW3uW+QaGCdUprrYh0OeIro+MDHp/kZUaZn6r9NXEZctivFr0KjxrIKdAg2CsZFdq0y+iMN3B1D3adtd/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM843kLskXN29EtJz1lziQOgL1mhheBmG4nS0NIP4eavr08JXd
	mswF9dLTiOf7jraTOGkYNInfJg5LHdC3t+67Jtyd7rpDutOmAdt6
X-Gm-Gg: ASbGncu/AwSw4LOYlCP/V2Ykp6S9VjmM+d2UaAc22I5NaJRcpq5JbGsTvsvyfJvjCGN
	wKBC/nk0MBIXkyCoUIlF9GkXLLw6OlYZCvLhuOFoAIn2L9SOrN0+4FQxCvOeSwH4LMeHVEOUMSN
	WBJn15klIK4LeRoJn5jPLa4ilGVELUyggNxY4o2r8/aslgWcl+iCgx6fsVw8KqpkmuunHFe5o+A
	xIS7ywm9PSunREMlhcTIIVYHyBtb/lGhjlkRHoN47QnZ0edJmSCIp3SbvRdFVjPP/TcbPvx9lAP
	W6yEr6n0rNJX9OdihUR0SdlzTgIFDJtO9V0ObVYeSZnOh9nP7vtpMBxrTmCT1VcS69tmgU43
X-Google-Smtp-Source: AGHT+IFSkyYAhujjKt35ajNYuLEfuQtd1ZG9+o4N2CkiF9wb8sdnKHspORe3GA6ysX8Thph6oTObVw==
X-Received: by 2002:a17:902:ce89:b0:220:e9ac:e746 with SMTP id d9443c01a7336-221040d81f2mr42004535ad.53.1739612890987;
        Sat, 15 Feb 2025 01:48:10 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5364351sm40951775ad.76.2025.02.15.01.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 01:48:10 -0800 (PST)
Date: Sat, 15 Feb 2025 18:48:01 +0900 (JST)
Message-Id: <20250215.184801.161111735013966961.fujita.tomonori@gmail.com>
To: gary@garyguo.net
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev
Subject: Re: [PATCH v10 7/8] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250214113740.156faaf4@eugeo>
References: <20250209162048.3f18eebd.gary@garyguo.net>
	<20250214.130530.335441284525755047.fujita.tomonori@gmail.com>
	<20250214113740.156faaf4@eugeo>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 11:37:40 +0000
Gary Guo <gary@garyguo.net> wrote:

> On Fri, 14 Feb 2025 13:05:30 +0900 (JST)
> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
> 
>> On Sun, 9 Feb 2025 16:20:48 +0000
>> Gary Guo <gary@garyguo.net> wrote:
>> 
>> >> +fn might_sleep(loc: &Location<'_>) {
>> >> +    // SAFETY: FFI call.
>> >> +    unsafe {
>> >> +        crate::bindings::__might_sleep_precision(
>> >> +            loc.file().as_ptr().cast(),
>> >> +            loc.file().len() as i32,
>> >> +            loc.line() as i32,
>> >> +        )
>> >> +    }
>> >> +}  
>> > 
>> > One last Q: why isn't `might_sleep` marked as `track_caller` and then
>> > have `Location::caller` be called internally?
>> >
>> > It would make the API same as the C macro.  
>> 
>> Equivalent to the C side __might_sleep(), not might_sleep(). To avoid
>> confusion, it might be better to change the name of this function.
>> 
>> The reason why __might_sleep() is used instead of might_sleep() is
>> might_sleep() can't always be called. It was discussed in v2:
>> 
>> https://lore.kernel.org/all/ZwPT7HZvG1aYONkQ@boqun-archlinux/
> 
> I don't follow. `__might_sleep` or `might_sleep` wouldn't make a
> difference here, given that this function may actually sleep.

Yeah, it doesn't matter here. If I understand correctly, the
discussion is about whether might_sleep() itself should be unsafe
considering the case where it is called from other functions. I simply
chose uncontroversial __might_sleep().

After reviewing the code again, I realized that I made a mistake;
__might_sleep() should only be executed when CONFIG_DEBUG_ATOMIC_SLEEP
is enabled. I also think that it is confusing that might_sleep() calls
C's __might_sleep().

How about implementing the equivalent to might_sleep()?

/// Annotation for functions that can sleep.
///
/// Equivalent to the C side [`might_sleep()`], this function serves as
/// a debugging aid and a potential scheduling point.
///
/// This function can only be used in a nonatomic context.
#[track_caller]
fn might_sleep() {
    #[cfg(CONFIG_DEBUG_ATOMIC_SLEEP)]
    {
        let loc = core::panic::Location::caller();
	// SAFETY: FFI call.
	unsafe {
	    crate::bindings::__might_sleep_precision(
	        loc.file().as_ptr().cast(),
	        loc.file().len() as i32,
                loc.line() as i32,
	    )
	}
    }
    // SAFETY: FFI call.
    unsafe { crate::bindings::might_resched() }
}


>> > Also -- perhaps this function can be public (though I guess you'd need
>> > to put it in a new module).  
>> 
>> Wouldn't it be better to keep it private until actual users appear?

I'll make the above public if you think that is the better approach.

C's might_sleep() is defined in linux/kernel.h but kernel/kernel.rs
isn't a good choice, I guess. kernel/sched.rs or other options?

