Return-Path: <netdev+bounces-160252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F01A1901A
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 11:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C2818851A7
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 10:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF590211488;
	Wed, 22 Jan 2025 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt2/6Dpa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6900E1F7578;
	Wed, 22 Jan 2025 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737542657; cv=none; b=jfFkKf4mP9svm37CUANm6BGa0RXjwtNrYXpaORFaXbtwN8kYKeyjEeJ131EocW4D/XIkpQCtXn8qAB3+BpCUAeeOxWBBKFkj5uelgkFklVyzynW7S5A7FVWYZ8784SmEMY/ZtnMoC9RYuLYvYd463XBbgTziLLCxLzzDi5qM+wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737542657; c=relaxed/simple;
	bh=LHfpwFkMzfAo1uIQDb5wPLmqmWu5ct/ZQUb0VDIwHQc=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=T99t8N32zFd41AvuvFz6jhovrVJjS6K1qpeXjwUnQdxfEufMHcpJlxOszJzvE/vnnqiYj7czhvdcCVNgZMSvcpciXk0v2If1MZ7roMvf0y7Abdl8VbRkrIYVpa8bqhPBDvI7A55F3dpy0TOUGi7yZAbT6vTvRXfEdj8TRod1vew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kt2/6Dpa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166651f752so155297345ad.3;
        Wed, 22 Jan 2025 02:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737542655; x=1738147455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15nUF4TeFgp1VzyEgGEGFlDAEz7IFOo0+dU19nH2WFM=;
        b=kt2/6DpaJYuhXyrjGXHiPo2h7ckJwfQG0uJHkloFlvDqvWdoL7OIF54GmuqgcY4YDh
         esXqAcgP0yr7OTxYL4V14AmJY4Db0EoZZT64xyiNmKUF6FIZlmt8unEn9tGAJH+FX1iH
         F8XoeIrrlk860iTV3aOYnqTLvL6iTnkrXBY5lumd36WTcIseiM0IujKYduH4tqxwpZGt
         E9AxSOszzzCVWrhH9gnP3AOrQLwPss0Resj4C7elcP0Qq4dW1lzrMf/lWxVGR9lCeycM
         D+zhFM6XEUen6IiwSli/FRF/6pfc8DgyhZWHWsViGadBo+/Nazrj7QLt86+lLUqlWfpJ
         J3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737542655; x=1738147455;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=15nUF4TeFgp1VzyEgGEGFlDAEz7IFOo0+dU19nH2WFM=;
        b=habXn8+/2WYyebRM/rSZiEkklZu0MOkKCdBEIwuyUuQGqZFqQafyFirvqtd2nyXpy/
         1y9L5iiM+Lb5/tBvA5GGin58oebouCwFJ5remWOX8yiP5PO0HAuKecm0vzd0kRdALf1F
         0R0Lh/kr+hgA/BBvbqKUUi2E/99kRUF01xtDb/FrmXicFYtRxVPy+QlFdACFPUOe58FJ
         oeMn1U0M6FKoP+V4xJSb5pxlrwuyb31tHwZXw5AYVDPOQoW75SByGU2ixG1I4eJD/SPT
         t+yVGLLtrQxuzLQdCbMsRJ4ng67iaU68ExT9vIXmjUiGbmxtZVA/eZLbMCuC7fwdH105
         CafQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGKC7Mr3jlshBzUjl5wbYXO+8dlkfUj6LNuiO570w7DgMT8a/xeTzOKf/UbmGccqG5Z5KidN5sZ084potIVZY=@vger.kernel.org, AJvYcCV1hV/IFyLMiqnpC2POW2V3EsiUYuxcv1NWq4ZonZlm76q2QoNm/9bL9ReVnv1xfmzF5heuTkIvQVZRLhE=@vger.kernel.org, AJvYcCVcrfN+GleQO4S0rPWe0aSohob2KXgoPg3aF1Hyc495YAYxY7nhrjo+sAGV3pcqDCK25H7hEn1w@vger.kernel.org
X-Gm-Message-State: AOJu0YxNNAZ6iuEg9p5ntw1CXJjU2nYLKSDhbVDzDs0LQZepOMp0q/5+
	3smLbjHMM+8ZYt5BJ+McnBf1Yxb3VCw49ryqjRSgnlRUnvHadCff
X-Gm-Gg: ASbGncu/JN5GZ6H0jAIwVRnFeBlm/0lTL8eMP+3riK4GHEGGo8j//sX78VwBBmaVWgs
	XVVwcg+nHY2SeFckjx5oklpT7hK1MLEA99/OZp9c7tGvAxfHJz0jhFmuQW3rznqq3hmZiHADObt
	uQYMMDLxAoCPyICX8ApN82tKdZoHVLjSElRSwHDwzHSxvKCpgEcg1ZXmW20KMFndfFnDunOZTlI
	Q4i+S97s5TpDRq3PMacsYGVVsur0jNYRhiB+XJwRI55vbmLdfoYX6HL6B4dxh2pkHwgZWOAXdL/
	7bSjQ8NVaiHdX5YpT5jLUPVFa5YZ4gQ6S+dLF+Ym0aWlO4Cs7ec=
X-Google-Smtp-Source: AGHT+IG9HLZlD+8uq/8P1ltV+4DZ3pw21bqNFLyC10/mJt/eYb3f+WFt4QCb5qaQck3VzSCjUzF8nw==
X-Received: by 2002:a05:6a20:729e:b0:1e4:8fdd:8c77 with SMTP id adf61e73a8af0-1eb2144d534mr33093526637.8.1737542655489;
        Wed, 22 Jan 2025 02:44:15 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9c8dc4sm10901408b3a.94.2025.01.22.02.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 02:44:15 -0800 (PST)
Date: Wed, 22 Jan 2025 19:44:05 +0900 (JST)
Message-Id: <20250122.194405.1742941306708932313.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, miguel.ojeda.sandonis@gmail.com,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 4/7] rust: time: Add wrapper for fsleep function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLghgcJV6gLvPxJVvn8mq4ZN0jGF16L5w-7nDo9TGNAA86w@mail.gmail.com>
References: <CANiq72kqu7U6CR30T5q=PvRam919eMTXNOfJHKXKJ0Z60U0=uw@mail.gmail.com>
	<20250122.155702.1385101290715452078.fujita.tomonori@gmail.com>
	<CAH5fLghgcJV6gLvPxJVvn8mq4ZN0jGF16L5w-7nDo9TGNAA86w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 09:23:33 +0100
Alice Ryhl <aliceryhl@google.com> wrote:

>> > I would also say "the C side [`fsleep()`] or similar"; in other words,
>> > both are "kernel's" at this point.
>>
>> Agreed that "the C side" is better and updated the comment. I copied
>> that expression from the existing code; there are many "kernel's" in
>> rust/kernel/. "good first issues" for them?
>>
>> You prefer "[`fsleep()`]" rather than "[`fsleep`]"? I can't find any
>> precedent for the C side functions.
> 
> I think that's a matter of taste. In the Rust ecosystem, fsleep is
> more common, in the kernel ecosystem, fsleep() is more common. I've
> seen both in Rust code at this point.

Understood, I'll go with [`fsleep`].


>> > And perhaps I would simplify and say something like "The behavior
>> > above differs from the C side [`fsleep()`] for which out-of-range
>> > values mean "infinite timeout" instead."
>>
>> Yeah, simpler is better. After applying the above changes, it ended up
>> as follows.
>>
>> /// Sleeps for a given duration at least.
>> ///
>> /// Equivalent to the C side [`fsleep`], flexible sleep function,
>> /// which automatically chooses the best sleep method based on a duration.
>> ///
>> /// `delta` must be within [0, `i32::MAX`] microseconds;
> 
> I'd do `[0, i32::MAX]` instead for better rendering.

Yeah, looks better after redering. I'll update it.


>> /// otherwise, it is erroneous behavior. That is, it is considered a bug
>> /// to call this function with an out-of-range value, in which case the
>> /// function will sleep for at least the maximum value in the range and
>> /// may warn in the future.
>> ///
>> /// The behavior above differs from the C side [`fsleep`] for which out-of-range
>> /// values mean "infinite timeout" instead.
>> ///
>> /// This function can only be used in a nonatomic context.
>> ///
>> /// [`fsleep`]: https://docs.kernel.org/timers/delay_sleep_functions.html#c.fsleep
>> pub fn fsleep(delta: Delta) {
>>
>>
>> >> A range can be used for a custom type?
>> >
>> > I was thinking of doing it through `as_nanos()`, but it may read
>> > worse, so please ignore it if so.
>>
>> Ah, it might work. The following doesn't work. Seems that we need to
>> add another const like MAX_DELTA_NANOS or something. No strong
>> preference but I feel the current is simpler.
>>
>> let delta = match delta.as_nanos() {
>>     0..=MAX_DELTA.as_nanos() as i32 => delta,
>>     _ => MAX_DELTA,
>> };
> 
> Could you do Delta::min(delta, MAX_DELTA).as_nanos() ?

We need Delta type here so you meant:

let delta = std::cmp::min(delta, MAX_DELTA);

?

We also need to convert a negative delta to MAX_DELTA so we could do:

let delta = if delta.is_negative() {
    MAX_DELTA
} else {
    min(delta, MAX_DELTA)
};

looks a bit readable than the original code?

