Return-Path: <netdev+bounces-143494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F4A9C29D6
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 05:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924D52845DA
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 04:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71FC3D994;
	Sat,  9 Nov 2024 04:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hV6X6ACo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD45A55;
	Sat,  9 Nov 2024 04:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127127; cv=none; b=DK/dhGiKj95FLeS3q7xooHRF0SJEL+TiZESqEyKXqMxiORLbf3YpF3CFt1ttFnlVG/gFxo93nLJ573Tkzr67SHh8u6iPjzb7JxHq7S1UIRfeeAC0kkfhMFAdOwNa1i8QdFNi6CbOhMit41eQple6p7n+vmjcS35yV9hUJpAz1pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127127; c=relaxed/simple;
	bh=KqclHp6ArxX0BZFmIZrwmiFdi8bA+sADZ4vgofgVCdk=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LmLf1h9DdZ60yjPzMcS7eoFuJuw3QB7F9tX9cbjfAQqXp/2JK+DsK2FbSdmi6fAXEQcW463MW2AjkOx8rctyFoOrEFlY7TtKP14UaOpeRkWqWfBagVhq2rD0eRb89tALlQYOv21uvrEnpcpkaRKTrjxvkgnF4tmzGZ2u7+dxyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hV6X6ACo; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e4e481692so2768212b3a.1;
        Fri, 08 Nov 2024 20:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731127126; x=1731731926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DA3hw8R6XL4AOWydyQZHwCswIEuadIAoTh+magCGfx0=;
        b=hV6X6ACoqEnHVbygs6U4cEhsN2J3O7LQsNIWTa7rKrhSbr5whhFCcE5iTfr4rgfpCq
         7A8JJA0jjnSiqgiC+1mGlgPPtDJUv4enLhTp9pKtIH+Pc+CMjRajDIEdKd+NAPmwFyqH
         hoK24LWkyh+YuzkJGAKvcSMK96pQRb6JFzJbKfUTXZv/AZ3hMAKNpa7szgrjz/tBIHww
         RzcE+K2aSS0jhtHpv1d9FBmfIq9vn9jhnEi1Cc8Hxcckt2gmHZuhKEfE8F5YDips7wUa
         ERz8QfQHZlaW5htRl3wlKZ0kMjGvEsKKBdAHyeJXTXhXi3ml0dMH98Zj7QvSwtxf/Kmo
         io9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731127126; x=1731731926;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DA3hw8R6XL4AOWydyQZHwCswIEuadIAoTh+magCGfx0=;
        b=aLv48dHvFgZuPwdcknI/ob+JPQd7I4sh/7MAn/q3xtxKdBLIagL8LNkTbCd3sdsHzF
         9+7ckES5x4ro0nagfoWxUKjQ4fuPSyYq3e6ZieGQ/6WH/VRDaDsV3Q1AqJMXbwCvaL36
         53SDDiDpMvDHNYj5+NSCyDC4xs/CU7Vb6EI3fauBBeeUBbpOqnECAeAdUAkI+3OzdL9v
         5/aDfvsBzkFC/PFab4y/vnletEMCXbLXX6Drff7ZLQLiCnsCzswJQGFlkNzRgi85oXWh
         MPTmRC/G+iZJo22hKz4sUTpEBhadmT/3Za63cTv+9w+Cbh4Pj+PRIGY0zZ88rOy4/1eU
         r1jw==
X-Forwarded-Encrypted: i=1; AJvYcCUUPjzgxx5fxBF0xMR6hMRTgqBZ0ZHCuHnmRL8IsBoJGCRPHQHDTkVeHMbXlQJBzTtbo5xG0BKo@vger.kernel.org, AJvYcCUfqV9pnoayv6vWFaKm3dN10wMIdBiMj9PeQSt7EQyB827m4F9xAvF5roLSise2l3ezKc6I0j/wLbZuOcb3w/0=@vger.kernel.org, AJvYcCVrrI+sKtiNRykkMCNAPxUhNdPH72ESimVZE5UVqtExAHFjtOEYY7lXpOdPA9tXYaYJBAtiyzndEyt/8cc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/oEfpVIlT8cJqLYBYiAOv1JuuCUFd5sbNvTQ5BilExGfvf6wW
	xI0YLx2p+Wr0kAXXQSUmBBRibUcCjs6zyJPhuU7WGnpLG17FP+uFSbsayIZC
X-Google-Smtp-Source: AGHT+IE0Kr9CUmz3El+k3JIITWmsTInqwUzEweCi1wf/HtTKz3DG3dyudW9DQYXt+GAqQh9CmRwTiw==
X-Received: by 2002:a05:6a00:23c4:b0:71d:fb29:9f07 with SMTP id d2e1a72fcca58-724132cd842mr7181605b3a.15.1731127125542;
        Fri, 08 Nov 2024 20:38:45 -0800 (PST)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65aa9csm4340079a12.74.2024.11.08.20.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 20:38:45 -0800 (PST)
Date: Sat, 09 Nov 2024 13:38:39 +0900 (JST)
Message-Id: <20241109.133839.322803434056714560.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, jstultz@google.com,
 sboyd@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de
Subject: Re: [PATCH v5 4/7] rust: time: Add wrapper for fsleep function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Zyux5d33Kt6qFdaH@Boquns-Mac-mini.local>
References: <20241101010121.69221-1-fujita.tomonori@gmail.com>
	<20241101010121.69221-5-fujita.tomonori@gmail.com>
	<Zyux5d33Kt6qFdaH@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 10:13:57 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

>> diff --git a/rust/kernel/time/delay.rs b/rust/kernel/time/delay.rs
>> new file mode 100644
>> index 000000000000..c3c908b72a56
>> --- /dev/null
>> +++ b/rust/kernel/time/delay.rs
>> @@ -0,0 +1,43 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Delay and sleep primitives.
>> +//!
>> +//! This module contains the kernel APIs related to delay and sleep that
>> +//! have been ported or wrapped for usage by Rust code in the kernel.
>> +//!
>> +//! C header: [`include/linux/delay.h`](srctree/include/linux/delay.h).
>> +
>> +use crate::time::Delta;
> 
> Nit: I think it's better to use:
> 
> use super::Delta;
> 
> here to refer a definition in the super mod.

Fixed.

>> +use core::ffi::c_ulong;
>> +
>> +/// Sleeps for a given duration at least.
>> +///
>> +/// Equivalent to the kernel's [`fsleep`], flexible sleep function,
>> +/// which automatically chooses the best sleep method based on a duration.
>> +///
>> +/// `delta` must be 0 or greater and no more than u32::MAX / 2 microseconds.
> 
> Adding backquotes on "u32::MAX / 2" would make it easier to read and
> generates better documentation. For example.
> 
> /// `delta` must be 0 or greater and no more than `u32::MAX / 2` microseconds.
>
>
>> +/// If a value outside the range is given, the function will sleep
>> +/// for u32::MAX / 2 microseconds at least.
> 
> Same here.

Updated both.

> I would also add the converted result in seconds of `u32::MAX / 2`
> microseconds to give doc readers some intuitions, like:
> 
> the function will sleep for `u32::MAX / 2` (= ~2147 seconds or ~36
> minutes) at least.

Yeah, looks good. Added.

>> +///
>> +/// This function can only be used in a nonatomic context.
>> +pub fn fsleep(delta: Delta) {
>> +    // The argument of fsleep is an unsigned long, 32-bit on 32-bit architectures.
>> +    // Considering that fsleep rounds up the duration to the nearest millisecond,
>> +    // set the maximum value to u32::MAX / 2 microseconds.
>> +    const MAX_DURATION: Delta = Delta::from_micros(u32::MAX as i64 >> 1);
>> +
>> +    let duration = if delta > MAX_DURATION || delta.as_nanos() < 0 {
> 
> I think it would be helpful if `Delta` has a `is_negative()` function.

Added.

Thanks a lot!

