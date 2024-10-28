Return-Path: <netdev+bounces-139409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3569B219A
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 01:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167422814CC
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 00:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FB87DA62;
	Mon, 28 Oct 2024 00:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ld2hwYk4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73CC61FEB;
	Mon, 28 Oct 2024 00:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730076646; cv=none; b=pXJcHS5S6MDYUT9kYMrJTzmYXJMYqvFOrTI4tMZfSJQNKQMo9/cPt54YBT4i/bzd74M0COZfeTEt0zC7zKmXQj9vF7Ek2+TOmpuCOPd/dWe9CwGIlpvp/5PNsHUeCnOY0duGYRaMPjp73pLOzTwSNJ0qxYRgAzPQi9ge9vQYy4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730076646; c=relaxed/simple;
	bh=/bDoUYUGszg0+71H1gaR2VKqqEmpzSZZSP7cxjGHLug=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=n4P7Nt1ulPahlxMmWYmRNijVXi8FbLYK2s+sOVBxREkH1rgBl/D86+jeXkqoPzOGX9Gh3px0eg6BwaaQwWMMJ9qRF/fGgRqYGQYxvWhsZJJjgGyyZFRxQKOQlvou7RKb8YfOESOYdRyrHAGB3CauKCt6sgtdJk7QwKMwWA9MAoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ld2hwYk4; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2eba31d3aso2547899a91.2;
        Sun, 27 Oct 2024 17:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730076644; x=1730681444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axMxxB4OuWR/bMGoKBYRMmZEJ+FwsBw1Uv2Ou7ndq2U=;
        b=Ld2hwYk4UuGf+66m9b/G/SC2t4CUNo5Wetzrwj3FMAhYq6G6LOw3Q77oarP8hLrUjV
         LTPUxb7UJvPLKekpzCsyin6CSSfRpcRpv5Hs6L/Il+w6ok4KZAH+H5iUVqMgXM4FeFYp
         JUmNhzLQdx8wQSQG3qq4zdCe63H299u4wmmiK4qrj9yFsG3MKfH+DCIPlZ21McPIQ+80
         HcABUO8k6+eYw+4r8TXZb+hejrWhGQNSbS1F8isdA0LlRpdrCWamIvORu/bGd9M84+dU
         t4yVi0AtoWgSzuIZ/r6sygSwniCMROlAMhI7C5aOSVT5rJU1IDNGFUpd2muq2QGTuiyQ
         Xwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730076644; x=1730681444;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=axMxxB4OuWR/bMGoKBYRMmZEJ+FwsBw1Uv2Ou7ndq2U=;
        b=tDTssjPZlXVjh/AQL2AWK80DIQ0zXBuWF2mPlY7eUX1dITV4YPeppq3/324iWvwjE2
         QhCq0eM8M88Oz4iGfzFP0r8/urTeI84+gKUIkPAkHHKkEFg7Ikl4jZmOstYWoCP5Ybhq
         UC8cmTJ0NxexQoZ69iGuZLnqw47PXOcVN6N6CSk/VtWlHkQ5YD5ENwbgbpAsqr5GoLVD
         K+LJcHyNjQs3s6K3mF6qOK1mtaEQCBHv4LjA6iE9FOmjfK13+3TTkKnufeaMJcvvIwpJ
         ZPDtA4H30wNy8QsDN7cjAdy/wk5zsfHNNxeAJt2FVx1VvDUaQr4GKfRa372h4GNh03az
         4WlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEG0WGWurot2hDS9urpkUZiEZw13GTBCFAX0Hrcf2cW154bCsOYU3Uek3wjkIRxtvcfuXmnIOfCZdldO4=@vger.kernel.org, AJvYcCUVjB5cbQaWYIoYAYRe52KFgXJoiXTIAdCZYnFbiUUiPBV9seTAsw0Ti+5HTGmoq95eUCVcr3rGwisBfOPr+0Y=@vger.kernel.org, AJvYcCWaPVo5Us5OUZ8csUqKtSQuyTcKrbm3AaEjNiblEPIJMIS92eS8ou7FZEJTsxm2eXcK2ia8Zonx@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvJczing1X/tIBNJL85u22eV3x1Ox7bd47PTX6AXeu/kYYC+E
	5fUT7Epm/E5nm1ctRufTIwWfqPqnPRvyuhQWkD6c8WECHPgHrJms
X-Google-Smtp-Source: AGHT+IFF243CRibqpr3soAzARSC9QFNdc09zWj+EerzwVZIKB6BdsE+ca5aHuZ4FIMI8F6oAPL/o+A==
X-Received: by 2002:a17:90b:4c89:b0:2e2:d112:3b5c with SMTP id 98e67ed59e1d1-2e8f11dcf0bmr8594885a91.37.1730076644089;
        Sun, 27 Oct 2024 17:50:44 -0700 (PDT)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e7867fe396sm7116484a91.51.2024.10.27.17.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 17:50:43 -0700 (PDT)
Date: Mon, 28 Oct 2024 09:50:30 +0900 (JST)
Message-Id: <20241028.095030.2023085589483262207.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, jstultz@google.com,
 sboyd@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de
Subject: Re: [PATCH v4 4/7] rust: time: Add wrapper for fsleep function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZxwVuceNORRAI7FV@Boquns-Mac-mini.local>
References: <20241025033118.44452-1-fujita.tomonori@gmail.com>
	<20241025033118.44452-5-fujita.tomonori@gmail.com>
	<ZxwVuceNORRAI7FV@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 15:03:37 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

>> +/// Sleeps for a given duration at least.
>> +///
>> +/// Equivalent to the kernel's [`fsleep`], flexible sleep function,
>> +/// which automatically chooses the best sleep method based on a duration.
>> +///
>> +/// The function sleeps infinitely (MAX_JIFFY_OFFSET) if `Delta` is negative
>> +/// or exceedes i32::MAX milliseconds.
>> +///
> 
> I know Miguel has made his suggestion:
> 
> 	https://lore.kernel.org/rust-for-linux/CANiq72kWqSCSkUk1efZyAi+0ScNTtfALn+wiJY_aoQefu2TNvg@mail.gmail.com/
> 
> , but I think what we should really do here is just panic if `Delta` is
> negative or exceedes i32::MAX milliseconds, and document clearly that
> this function expects `Delta` to be in a certain range, i.e. it's the
> user's responsibility to check. Because:
> 
> *	You can simply call schedule() with task state set properly to
> 	"sleep infinitely".
> 
> *	Most of the users of fsleep() don't need this "sleep infinitely"
> 	functionality. Instead, they want to sleep with a reasonable
> 	short time.

I agree with the above reasons but I'm not sure about just panic with
a driver's invalid argument.

Can we just return an error instead?

>> +/// This function can only be used in a nonatomic context.
>> +pub fn fsleep(delta: time::Delta) {
>> +    // SAFETY: FFI call.
>> +    unsafe {
>> +        // Convert the duration to microseconds and round up to preserve
>> +        // the guarantee; fsleep sleeps for at least the provided duration,
>> +        // but that it may sleep for longer under some circumstances.
>> +        bindings::fsleep(delta.as_micros_ceil() as c_ulong)
> 
> If delta is 0x10000_0000i64 * 1000_000 (=0xf424000000000i64), which
> exceeds i32::MAX milliseconds, the result of `delta.as_micros_ceil() as
> c_ulong` is:
> 
> *	0 on 32bit
> *	0x3e800000000 on 64bit
> 
> , if I got my math right. The first is obviously not "sleeps
> infinitely".
> 
> Continue on 64bit case, in C's fsleep(), 0x3e800000000 will be cast to
> "int" (to call msleep()), which results as 0, still not "sleep
> infinitely"?

You mean "unsigned int" (to call msleep())?

You are correct that we can't say "the function sleeps infinitely
(MAX_JIFFY_OFFSET) if `Delta` is negative or exceeds i32::MAX
milliseconds.". There are some exceptional ranges.

Considering that Rust-for-Linux might eventually support 32-bit
systems, fsleep's arguments must be less than u32::MAX (usecs).
Additionally, Because of DIV_ROUND_UP (to call msleep()), it must be
less than u32::MAX - 1000. To simplify the expression, the maximum
Delta is u32::MAX / 2 (usecs)? I think that it's long enough for
the users of fsleep().

