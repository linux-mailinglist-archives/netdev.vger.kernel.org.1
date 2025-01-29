Return-Path: <netdev+bounces-161446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1F5A217BA
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 07:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF0C27A0797
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 06:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AC2176FB0;
	Wed, 29 Jan 2025 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T381RpQE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899AA25A641;
	Wed, 29 Jan 2025 06:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738132292; cv=none; b=nSlo+TQ813HVN9G/GR+ThUzw2VREBt+uXSUCJh4fK9UMl1im4sQoEtnNFEOOm4RgJ96aSV5jgjk5K+tUJTZV3fqRYdLeBa3iZldP8pmIwLFqv4GsRqosiH56uwqowNxhM4vMD7maJS2cnkfrYCOWt54Svhb1HRIXPsuCcyLIEX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738132292; c=relaxed/simple;
	bh=tXLV31mhA7vI69BSZdH15qxXUdGvnJcB9Uf7Wz7TSDA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BN8icmp1vQBNr4WZxo48eGzP/AD7QDC/67WGhOzdezGn2vne2tW5K2u2BlyyXrm7jW9k5aIuFGCyOfvXZINT3mWtxzO38IsCH9LEDPD88py7LbSGvBEvVZN6gXNUZYthe8AemDSjvASRwLaTEXtOK8uRi/zA4LNhHx0NfT8Cl2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T381RpQE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216426b0865so107984915ad.0;
        Tue, 28 Jan 2025 22:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738132290; x=1738737090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFM+vjyA32CqCtTyb2DyVGfSEHXUhalkrOEEB2zsPis=;
        b=T381RpQEvknZ94MBvk4O6p4uWPWjZa0gdPEZKxOfa7tAWzlpgYarids7Wjsjm28Kgy
         Q62/dZ/5Up0ILWT77uoZDHObJta0/44g/ZWMynJXYFqzPhEjGCvXzOkrq7YPn9IzKGXY
         XqVMLWoaDTWyp5JLE0oZK0nOK4nUHv0/IQt16gJsNGx8+iwDFBNzvUzxaPnvcLZBNh9G
         Mzp10duuKnmokWJIXGckpLo1z5w296OKT1QqEXqf2sPbyXErhwg2qRed6NWPCe34ZR+O
         ABhFUbJsoY9ch9L/uMXJT2iUg4h5KsobJJwTF7MiTK2hoLRAg3ceH884MZi7PpV9lqhH
         2qIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738132290; x=1738737090;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fFM+vjyA32CqCtTyb2DyVGfSEHXUhalkrOEEB2zsPis=;
        b=nQugkqkddPKJ8CLajmaxW2ivRF+Uyq0PIQo/6LCJ94qWWudrJ3lyug6TnQxmxHAXIr
         emGKyikzX87w5Kia/tfrN0RSeQMsrbppDUg7oyc0tBXAB9wQmZQN31dnXNBNV6z8kCPP
         aKsKO/mlJJNbtgCqCzZgYHvvcjGAO+AEws9jHQpuQDFWh0pFosZPntD2oEkVZ2lF9hB5
         A0AhzKzoebfAqdwsqPMfpes2BNGZt3vjLc3IO4gYK60okg5kKG6HHgEAz4HXNURy6NBO
         n7mYMHw3KX1QgQCkHrACGPnXCmDrCdDMIwBKAEuERHfJ4z7VpfyteyphTnwLfIgit7FW
         mFVg==
X-Forwarded-Encrypted: i=1; AJvYcCUwTmoG/4CEYKyOOWDUwhX3nGPFHNZbAjoz60L5D7jC9NW710S3X9zxJSk0Si0O2NpdYDAhc/BAS5+DAV0=@vger.kernel.org, AJvYcCV7IF/IyUIEwuICSpX6/0wVGmKhw8utHTHpYi6OaLjYCg3d99BPl5fyyKfweZcohYLjNhl7YsqpogvMaqkcDJk=@vger.kernel.org, AJvYcCVhjkFlfv1z6eCqxzM52VKq7PugV7wvDY7TUyAcoGbS4E18ejXH1CkMKCaP6mT15G9en/wezoat@vger.kernel.org
X-Gm-Message-State: AOJu0YxkRULiIG0o+sFqJjVdTrTAGa0vnUUsfEFVyXx99JwQdsUBfukO
	N6gxdMkD/nqG4JnNTbFCufyZrdNPbunlX1kvt0eKQGgG7tZNfxea
X-Gm-Gg: ASbGncs9et2kUPO1GjCG/juPsIK8rfrJxjTtl4awhLrLewGdnp+FgOiwQG2xwqTj8Fo
	yMI5ZmlV+uma97+ej+4WyOxW4UdOuVnETlgMPR93wK31nF6pkaoFivM3NEMV6vPYeeD3Xc+0ka1
	gpdjMMWRXBY/tTCM8e7t0QAiMiv3EJM55qkg8THFI0sQcORvwAiW+hRa2k+Q5FAQ7s2GaA3KZ8Z
	AfXpsjcZzTD0joFmCazn4qyiXw900I0n1q/61S4fsiPMewkOsYRiEIDqM/7kZSk9uG6Kdc06oWy
	zr7hHroZ3+JW7zH9u4G8Y9PIX7H40SWxXQD8mbqEI+1fP9E9TUi6PK1Bmg7vC8D8BMUap3xO
X-Google-Smtp-Source: AGHT+IFMNxgF4sXLJo81rYnFc11rYgJ+L512CIATJLEgYq4qkXbMMUXtQeIv9jp0LLKadbZ/x3Mx0w==
X-Received: by 2002:a05:6a21:3511:b0:1ed:75f4:d289 with SMTP id adf61e73a8af0-1ed7a52b048mr3500557637.19.1738132289650;
        Tue, 28 Jan 2025 22:31:29 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac48e660061sm9472498a12.3.2025.01.28.22.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 22:31:29 -0800 (PST)
Date: Wed, 29 Jan 2025 15:31:20 +0900 (JST)
Message-Id: <20250129.153120.170416639063888853.fujita.tomonori@gmail.com>
To: fujita.tomonori@gmail.com
Cc: gary@garyguo.net, linux-kernel@vger.kernel.org,
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
In-Reply-To: <20250128.152957.202492012529466658.fujita.tomonori@gmail.com>
References: <20250127.153147.1789884009486719687.fujita.tomonori@gmail.com>
	<20250128084937.2927bab9@eugeo>
	<20250128.152957.202492012529466658.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 15:29:57 +0900 (JST)
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> On Tue, 28 Jan 2025 08:49:37 +0800
> Gary Guo <gary@garyguo.net> wrote:
> 
>> On Mon, 27 Jan 2025 15:31:47 +0900 (JST)
>> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>> 
>>> On Mon, 27 Jan 2025 11:46:46 +0800
>>> Gary Guo <gary@garyguo.net> wrote:
>>> 
>>> >> +#[track_caller]
>>> >> +pub fn read_poll_timeout<Op, Cond, T: Copy>(
>>> >> +    mut op: Op,
>>> >> +    mut cond: Cond,
>>> >> +    sleep_delta: Delta,
>>> >> +    timeout_delta: Delta,
>>> >> +) -> Result<T>
>>> >> +where
>>> >> +    Op: FnMut() -> Result<T>,
>>> >> +    Cond: FnMut(&T) -> bool,
>>> >> +{
>>> >> +    let start = Instant::now();
>>> >> +    let sleep = !sleep_delta.is_zero();
>>> >> +    let timeout = !timeout_delta.is_zero();
>>> >> +
>>> >> +    if sleep {
>>> >> +        might_sleep(Location::caller());
>>> >> +    }
>>> >> +
>>> >> +    loop {
>>> >> +        let val = op()?;
>>> >> +        if cond(&val) {
>>> >> +            // Unlike the C version, we immediately return.
>>> >> +            // We know the condition is met so we don't need to check again.
>>> >> +            return Ok(val);
>>> >> +        }
>>> >> +        if timeout && start.elapsed() > timeout_delta {  
>>> > 
>>> > Re-reading this again I wonder if this is the desired behaviour? Maybe
>>> > a timeout of 0 should mean check-once instead of no timeout. The
>>> > special-casing of 0 makes sense in C but in Rust we should use `None`
>>> > to mean it instead?  
>>> 
>>> It's the behavior of the C version; the comment of this function says:
>>> 
>>> * @timeout_us: Timeout in us, 0 means never timeout
>>> 
>>> You meant that waiting for a condition without a timeout is generally
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
>> Intuitively, a timeout of 0 should be closer to a timeout of 1 and thus
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

Oops, `Copy` should be dropped:

+pub fn read_poll_timeout<Op, Cond, T>(


> +    mut op: Op,
> +    mut cond: Cond,
> +    sleep_delta: Delta,
> +    timeout_delta: Option<Delta>,
> +) -> Result<T>
> +where
> +    Op: FnMut() -> Result<T>,
> +    Cond: FnMut(&T) -> bool,
> +{
> +    let start = Instant::now();
> +    let sleep = !sleep_delta.is_zero();
> +
> +    if sleep {
> +        might_sleep(Location::caller());
> +    }
> +
> +    loop {
> +        let val = op()?;
> +        if cond(&val) {
> +            // Unlike the C version, we immediately return.
> +            // We know the condition is met so we don't need to check again.
> +            return Ok(val);
> +        }
> +        if let Some(timeout_delta) = timeout_delta {
> +            if start.elapsed() > timeout_delta {
> +                // Unlike the C version, we immediately return.
> +                // We have just called `op()` so we don't need to call it again.
> +                return Err(ETIMEDOUT);
> +            }
> +        }
> +        if sleep {
> +            fsleep(sleep_delta);
> +        }
> +        // fsleep() could be busy-wait loop so we always call cpu_relax().
> +        cpu_relax();
> +    }
> +}
> 

