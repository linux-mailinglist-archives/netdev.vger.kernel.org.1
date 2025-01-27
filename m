Return-Path: <netdev+bounces-161066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4EDA1D0EC
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 07:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09ED1886DD5
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 06:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FBA154C08;
	Mon, 27 Jan 2025 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQ87XOTL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFF0A59;
	Mon, 27 Jan 2025 06:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737959519; cv=none; b=Z9U4CVHBWzsJMAkiBXDiiRPdJtjr6XquCAitB7KrDMeR8M0im9KZKh8yTd3uJFSgF1SU4tMAwywUy0co8swTQYWEmO/KK19gTuIQDNP2VX1+aUejrWGzl1Eh8IOucp8ZzPt24o+huqBovKZ0IbF4F8dwOEc6U1Dt5om/gciplw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737959519; c=relaxed/simple;
	bh=fq28+7Cu3/O1HXsG/L8DNlMk50ETj/lwjGNA6ls4GnU=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BbIFK0gX+dkTOr4boDq8tYOlI8yI3JwPX2fo5E563hHS2RiwqeqSyY1nUN3P1/Wo6ktlJszLz7CyCUM3dUfKRDX7OthyRA1pUM9HPAg+s67tJ2EenISFnC6cqwfQoBr/G4TpDYY9tLbRVpvSYK1Q643mRPwPbOStWBNfD4PIZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQ87XOTL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-219f8263ae0so72840645ad.0;
        Sun, 26 Jan 2025 22:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737959517; x=1738564317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfNfYKCvqZaMihwMFiRrtekyPJr0TEi8O4d8CRrU8/c=;
        b=cQ87XOTLMqAL9SCuhz+Vzk4DV4VooRb9A4Tu4XLz6sCbQJ6mO5bb2g8ROWJkNY1CNr
         G4yajBCspsMk48feradSxnEPo+mzD1OKZ84V2lwhy3MukDjDuZvOwxZgaz2khPmVg8vb
         8EVc3rcbHZyXz4kQJQFNOp1UMuHK3oX57gDXPGlPAT/+6Cgu5CsYTEObEbkCF8O0KXvB
         b1/8lWSzWsCjbfVuC55h+DJ+0Za6JueXTGI7aHVxecN6tjrMs02HjNyXUM2DLejTzPcr
         lHgTECyhYiG0aDYASToR4nNUzePn08gA1IRrPp0Euik7aUtrkxxrOlpMMKMI3aVGni4w
         DG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737959517; x=1738564317;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tfNfYKCvqZaMihwMFiRrtekyPJr0TEi8O4d8CRrU8/c=;
        b=TerDVA+qS81MJvaKaFZf6nZiN5t4OidS90h3b24/y5iXa46vqtsZoaPQwrFxnh3ljT
         Myf2RRU3MuAc+B0NvracZfQuH4Lo7dC2bzR1l24b5V4ecJUksfeZVzu6ZR7BX+9Yq3j3
         9t3BtDgUHUbZBxos3tMsWa5+o/Zny1MD+X4y0PzDYHuKNfMeOETuiS8xosnbjPsmEFvP
         HEHnXwY4VcV5khex59oYTsW+VpAkoTYEjAU0QmJPTcUjXRuhL365p4tltvmCxTYO1FX9
         N4qTCR5llShzZYKj4ov6iYJSNoACl02cMfr6Qv9Vk0q9FNbhVoTupHW8/OSads0yBXMm
         eqpw==
X-Forwarded-Encrypted: i=1; AJvYcCU7FvDNt1Q6nHavUVgwc5s3WInwz1LEn5lO4R1qagJnFo0JLnl7M+ue38/LyEWStoTTu3ZRCB9BJe397Xabg3A=@vger.kernel.org, AJvYcCVhRWUk6adnlmYNl4aVLWZsT2GDjP43Jq1GrLGiDHgiKlhjME5EWpR6qSmctlVQUipvCRbtHNFxuuYGHAU=@vger.kernel.org, AJvYcCWdmFXl4Ngx3/GdN32moCvRfyV/TDGjeho8Z8QuZlLqVrsR81x8epnz22qeMdt+wgSnQq6Zvkhk@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzp0TG858o05uvcu1eYj1TiWS81TTiraiaC5fzOuWVT8bU6VEy
	ESn5Z/kgWp4ES+PpEV5QwjCJ/qMS4xLTot9TV35m1eibml0KQ6nsXrtuWQVP
X-Gm-Gg: ASbGncvkRpkuspDNrpqgGqjMO4//INekc9MGFlV6taMZyZpXHTV5eSfA9psqF/6NG28
	K5KgKPoJpAnehII9Xkj/SKE9LSbp0XbNTcyV8Bujfl2V5zugdeCBjxb3/JQRaDmFN+nvh8318Sz
	Jf/E871Kx8WgIDNDt6oqVvQlT24sfH/z2pyykUAf4YYzPLxvcQGtNIxakaqJA9B7FtpoYmh5Did
	+z3tPlXX+lHEDBPf8H6fukyLJV7AevEgb22MDmONf8WI3vJkTvgmAimD4d94lZP2LUP9LZBrSf6
	Yw/ypqifUE/7jZJvYpO7PBUm7+7Rb+oNf3WDxGXOLFj5bB7WHYvzNcbQrdA+Dw==
X-Google-Smtp-Source: AGHT+IG3t88XE1H39FP4TiaMyOZ+wufBvP6/f4L48+GD8EeMzE13UPlvF15gmieonw0XeswKwcTKOA==
X-Received: by 2002:a17:902:c94a:b0:216:2abc:195c with SMTP id d9443c01a7336-21c352dd6ffmr548671125ad.7.1737959517362;
        Sun, 26 Jan 2025 22:31:57 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea3b45sm56276125ad.97.2025.01.26.22.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 22:31:56 -0800 (PST)
Date: Mon, 27 Jan 2025 15:31:47 +0900 (JST)
Message-Id: <20250127.153147.1789884009486719687.fujita.tomonori@gmail.com>
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
In-Reply-To: <20250127114646.6ad6d65f@eugeo>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
	<20250125101854.112261-8-fujita.tomonori@gmail.com>
	<20250127114646.6ad6d65f@eugeo>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 11:46:46 +0800
Gary Guo <gary@garyguo.net> wrote:

>> +#[track_caller]
>> +pub fn read_poll_timeout<Op, Cond, T: Copy>(
>> +    mut op: Op,
>> +    mut cond: Cond,
>> +    sleep_delta: Delta,
>> +    timeout_delta: Delta,
>> +) -> Result<T>
>> +where
>> +    Op: FnMut() -> Result<T>,
>> +    Cond: FnMut(&T) -> bool,
>> +{
>> +    let start = Instant::now();
>> +    let sleep = !sleep_delta.is_zero();
>> +    let timeout = !timeout_delta.is_zero();
>> +
>> +    if sleep {
>> +        might_sleep(Location::caller());
>> +    }
>> +
>> +    loop {
>> +        let val = op()?;
>> +        if cond(&val) {
>> +            // Unlike the C version, we immediately return.
>> +            // We know the condition is met so we don't need to check again.
>> +            return Ok(val);
>> +        }
>> +        if timeout && start.elapsed() > timeout_delta {
> 
> Re-reading this again I wonder if this is the desired behaviour? Maybe
> a timeout of 0 should mean check-once instead of no timeout. The
> special-casing of 0 makes sense in C but in Rust we should use `None`
> to mean it instead?

It's the behavior of the C version; the comment of this function says:

* @timeout_us: Timeout in us, 0 means never timeout

You meant that waiting for a condition without a timeout is generally
a bad idea? If so, can we simply return EINVAL for zero Delta?


