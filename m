Return-Path: <netdev+bounces-161259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08C3A2046D
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 07:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40693A762E
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 06:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA56A1D8A0D;
	Tue, 28 Jan 2025 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC7IJBnw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471E818E750;
	Tue, 28 Jan 2025 06:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738045808; cv=none; b=DVzer2oLRbWy1eA6bEYTiendODioBmbZUZltq5ZlDIB9ywNnDSuS0phf2xweY+v36unD9rISleM2P8GAet6MZWvvmnp6cCqA2CT3gbMEjDcr/aOS6X9kCB6O+hHS5WGX620+ScgJNjK+QxF6NYvc0y/aoLJtUvCC+aePGJBNhP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738045808; c=relaxed/simple;
	bh=ZiYycUPenTQu4s/ptmDsRVsujjUVRWWaGf6te5QZCyE=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hkLZkHbfesh9HWPSeyGfv/4pATSSkInrojSfwTv5UIakuCE7qwGPriPm215YUn9Tw7Qd8wYGL/tH6gbBPZYGDLW8SBK1XPpImMkDk6mignTXzGUUazBLxigldzNrD8XLNrTWWJusLfFfMpkWG41NHR8X8kdZnHhBEc0EmbHyu8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MC7IJBnw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2166651f752so108092295ad.3;
        Mon, 27 Jan 2025 22:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738045806; x=1738650606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHZfd5swwxzWvNdXh7F6Dwgn1IHh2xxwB0ISEUn/VTc=;
        b=MC7IJBnwn6vRU3KK4crxgiq1C/CxlRlG+wl/vFb0O5GrnDX62ESwe1qKfFiF2qYCO7
         myLzB+85GgCb+q9rqyK54uiPB1bOBlB+IoSvJ0bcRG7FSJZaQQ4IMW4JYnTXovdj8dRV
         g418MyOZVBx0N55SI9ZHIeS2p6YNwarJNHExP83grZ5hxgI7p4j0d4SOmO5dLAZD8Srv
         It5ckbxhdeFnsoJC5873ty+ucLCJO1zAyeK+0Oqhf3yBIW2c7C+7uGq4HGnTwFa9o/sv
         lJtO8vaLkDCrqweNW6aXUAYaEl140P9wrldp25kVhGCjrD2jEYGW1mU0JWZf3NZeqiu0
         Zl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738045806; x=1738650606;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UHZfd5swwxzWvNdXh7F6Dwgn1IHh2xxwB0ISEUn/VTc=;
        b=QA0wJlSKNKI7/HpBPSgINJYeCefeU1/UgfJmezysPbsig1ANziD5id4Ki8qhvwqtWX
         2vGLNFXABhMnWoUkGmnivVkVXg7FqbYLFGUqU7KaZ98zas1k6t6dpO+Vd1g++r3RU2JH
         G2FbmLpUSmdbx8UgqWAtjvlht61lfCIfTY+8VYIeHbczRQNJDCw7Q9Fw2Qxtw3Ue+Onn
         ny9jqh2btA1xXGmqBsy39UIdeT5l7Vu//dWC1yGQyyhH9PpLXXM78sjMhc4x3+g/Nfk2
         4Dbvjv8AGhnVz75OINwU3rS3Lv3Lv3JeqGwDN3GPPrTHJcl5hsDO7cjSIjl3sctvZaC3
         UvIA==
X-Forwarded-Encrypted: i=1; AJvYcCV7WgmcTsLbKccMhEDQESDQ/eRBt3/Lv2xdiJg7agc16qzOFMVhlq6kJBFlLeyNNmW/4PTuqQdjaGcjBT+V3pk=@vger.kernel.org, AJvYcCVq9tJ2TPG08FYYgfRyWEisJ5IzP3c+aLZq2x7mFzzRmY4sI3n2ToK2/EoRHAH3N+v+GHv5Syb68ZhwMyg=@vger.kernel.org, AJvYcCW/v7zrNb6tHpEr0bOxkEZ/hfRkfvmur6rUaqz3HafyZBvtZuK7/3wSqKHijJqISQMtY8QhRqvf@vger.kernel.org
X-Gm-Message-State: AOJu0YwRRfVNdBah/gVao+8/ZeMFTz88I0rDRRLY4eNLKUp+58j0hdVU
	vP4xNN5Nah8/FxlkzU/2okB44+cry7ICv3z1FtccSPzCqPz2W1Mq
X-Gm-Gg: ASbGncvZpLTx/lWdbds28mzfYHP2q5kemkbH6rQGOBWKXipZnU6Z0e7fyTM9C6Vsryz
	mz/aGs9ZvQvVPOBKM+kscDilhIzg0jTOpOmI/tupbSq7rPA5Z3v50DAxTs6woqc4sTf07MZ1DYL
	C86y0p9FGKAFBZXcYUMK2lhEETqYmYo7g7trfFwfppFKWIizuEpkua4Oz25DyYpj/4DkiqjddCV
	WqHTN1UwuDglAysE4ggZyanm6lE5AQ0Wygxql83/Jhc7HHGarzp9T7YNihx+irDP9CAyHGrlUIm
	XV8qQuzkiAiS05VCvgy60W4wRGf7jnqE3f8KO4VUkhpdtazKivJ+Mylho7eQcMynEOt8AJMj
X-Google-Smtp-Source: AGHT+IGcBr8uT3Aas6GOlfQ3Hk8TBfVEaGfOVnYag+zqWeM7yZEQAVrTSEjYPulr6uBCaBr5M4fdLA==
X-Received: by 2002:a17:903:32c9:b0:216:46f4:7e3d with SMTP id d9443c01a7336-21c3550f34emr678668395ad.15.1738045806343;
        Mon, 27 Jan 2025 22:30:06 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da41415e9sm74049345ad.116.2025.01.27.22.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 22:30:05 -0800 (PST)
Date: Tue, 28 Jan 2025 15:29:57 +0900 (JST)
Message-Id: <20250128.152957.202492012529466658.fujita.tomonori@gmail.com>
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
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com
Subject: Re: [PATCH v9 7/8] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250128084937.2927bab9@eugeo>
References: <20250127114646.6ad6d65f@eugeo>
	<20250127.153147.1789884009486719687.fujita.tomonori@gmail.com>
	<20250128084937.2927bab9@eugeo>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 08:49:37 +0800
Gary Guo <gary@garyguo.net> wrote:

> On Mon, 27 Jan 2025 15:31:47 +0900 (JST)
> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
> 
>> On Mon, 27 Jan 2025 11:46:46 +0800
>> Gary Guo <gary@garyguo.net> wrote:
>> 
>> >> +#[track_caller]
>> >> +pub fn read_poll_timeout<Op, Cond, T: Copy>(
>> >> +    mut op: Op,
>> >> +    mut cond: Cond,
>> >> +    sleep_delta: Delta,
>> >> +    timeout_delta: Delta,
>> >> +) -> Result<T>
>> >> +where
>> >> +    Op: FnMut() -> Result<T>,
>> >> +    Cond: FnMut(&T) -> bool,
>> >> +{
>> >> +    let start = Instant::now();
>> >> +    let sleep = !sleep_delta.is_zero();
>> >> +    let timeout = !timeout_delta.is_zero();
>> >> +
>> >> +    if sleep {
>> >> +        might_sleep(Location::caller());
>> >> +    }
>> >> +
>> >> +    loop {
>> >> +        let val = op()?;
>> >> +        if cond(&val) {
>> >> +            // Unlike the C version, we immediately return.
>> >> +            // We know the condition is met so we don't need to check again.
>> >> +            return Ok(val);
>> >> +        }
>> >> +        if timeout && start.elapsed() > timeout_delta {  
>> > 
>> > Re-reading this again I wonder if this is the desired behaviour? Maybe
>> > a timeout of 0 should mean check-once instead of no timeout. The
>> > special-casing of 0 makes sense in C but in Rust we should use `None`
>> > to mean it instead?  
>> 
>> It's the behavior of the C version; the comment of this function says:
>> 
>> * @timeout_us: Timeout in us, 0 means never timeout
>> 
>> You meant that waiting for a condition without a timeout is generally
>> a bad idea? If so, can we simply return EINVAL for zero Delta?
>> 
> 
> No, I think we should still keep the ability to represent indefinite
> wait (no timeout) but we should use `None` to represent this rather
> than `Delta::ZERO`.
> 
> I know that we use 0 to mean indefinite wait in C, I am saying that
> it's not the most intuitive way to represent in Rust.
> 
> Intuitively, a timeout of 0 should be closer to a timeout of 1 and thus
> should mean "return with ETIMEDOUT immedidately" rather than "wait
> forever".
> 
> In C since we don't have a very good sum type support, so we
> special case 0 to be the special value to represent indefinite wait,
> but I don't think we need to repeat this in Rust.

Understood, thanks. How about the following code?

+#[track_caller]
+pub fn read_poll_timeout<Op, Cond, T: Copy>(
+    mut op: Op,
+    mut cond: Cond,
+    sleep_delta: Delta,
+    timeout_delta: Option<Delta>,
+) -> Result<T>
+where
+    Op: FnMut() -> Result<T>,
+    Cond: FnMut(&T) -> bool,
+{
+    let start = Instant::now();
+    let sleep = !sleep_delta.is_zero();
+
+    if sleep {
+        might_sleep(Location::caller());
+    }
+
+    loop {
+        let val = op()?;
+        if cond(&val) {
+            // Unlike the C version, we immediately return.
+            // We know the condition is met so we don't need to check again.
+            return Ok(val);
+        }
+        if let Some(timeout_delta) = timeout_delta {
+            if start.elapsed() > timeout_delta {
+                // Unlike the C version, we immediately return.
+                // We have just called `op()` so we don't need to call it again.
+                return Err(ETIMEDOUT);
+            }
+        }
+        if sleep {
+            fsleep(sleep_delta);
+        }
+        // fsleep() could be busy-wait loop so we always call cpu_relax().
+        cpu_relax();
+    }
+}

