Return-Path: <netdev+bounces-139719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D34879B3E6B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104061C21148
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799661E1048;
	Mon, 28 Oct 2024 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDWCKuF3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8829018FDD8;
	Mon, 28 Oct 2024 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158238; cv=none; b=ip4GwRyikYpQhVu/HQywQVIh2uZyiYf3uQaQPB3rYjh2HIOKSFPXVXY4A9tNW2bA1kCXsuXsfq3sELaq/l4c706Ws37MvF6u3nybDscyJvYV7mzHYzoRXex8ibPT/cHgXr+pgLDPlMooDpGQcoxbAnScYhfB+CsPEpX39Xpsnjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158238; c=relaxed/simple;
	bh=Jsu2Q0T6DOFCldJgVCT+xnWtn4srBxJLJpFjAU23yzU=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=a3YTwn7dqWd5DzRJ4SnLf7KvwaLothY5mFOsRh8I7/VWMgZXfQOxAwHQNGDseiwrTSKDEkLnOo4WWbvp6kP1+wCT67DyzmGSq/wKbB6nC6twFRg/PcHJVeNE5ffpXITxMRL/qC5s6RUCinXdnZfIRIprGueHj2CNKd9uJP70Wek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDWCKuF3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-207115e3056so42193415ad.2;
        Mon, 28 Oct 2024 16:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730158236; x=1730763036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xyJaUlEgG3da8Ovm63SP1qrlwjIVojX8esngLKq16Rs=;
        b=LDWCKuF3p8AWzRZrtytnUjml7yXbQbbDT4ryviUvb5t6PWCLJZQczT8zVoRhXo6x+N
         4nn3f0ZnOS4m/shcqWQDxV+LyDU3DcL+CoewkJ1/LEJXjIJkRgtisAMEfaz20LP/ygFM
         YA2w40bxI0YL+BapKW6M8gEkfh30gPrusfe7Y5JarqaIKj/R11SAMo/hVvrdMuTaglu8
         Q7vVOb0phUYqm6RK0ZI+jNFxAOG9SmxwgZNpLL/vP9BQTCmNijU5SGEYl5cKEGs6BNe9
         m+Kt0+heewfsz9PCQ4nXkefQSoT5BLU3TXuItrrs3k0flgphhHRcw1p8ztXvzo+YTGTL
         10xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730158236; x=1730763036;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xyJaUlEgG3da8Ovm63SP1qrlwjIVojX8esngLKq16Rs=;
        b=ALocc2IFvviiCAdYw0o00Rjcr9UNeWtJXqwkqLyudkRaukERvn2eaTBWqq90ZTxlCq
         vxiU/DrEwbd0uOYuRLD0/qFlQGHx2T7WX7zktNr2hqJ+asqSMviA/fVMhT+TqiJoUULg
         jS3rTg4UiTAhii2gEmwp5CAkc7n1bxhMEu8+CrND1RCnphResbJxGmPKErj6mT1TIBs2
         kfVxgKXDXSev15EBw14XPrwNXz+S5I6RiLalg9eVJBwbK5Phz2FjgJJ3dlya8FLM62JE
         McIwyNUa9ryzd4O7NM9zScMN8RSodnRPDuhOGRX46q+qUnSL4foGq9s2pTymnDrCqyJr
         MMlA==
X-Forwarded-Encrypted: i=1; AJvYcCUMowsfjR1p9GRJL7INigQFRKAtfTM2wlZiGjqxEjirmAPyatX2SeAJLgQw7boR5Poa8SQdGHvZM8drBO8=@vger.kernel.org, AJvYcCUl+z8/7C6WeqWwPV8+lKiBNaN6N0bcEBhdmMVA+Gak7vzYRErSdvCKcmsvotCF/9gU0xQ3CtLx@vger.kernel.org, AJvYcCXkHJNVFGrh+IlDg/VRu8Oizvl8zGpLvhTTDBW7rJy9duoCQWNGm37h5q9epb6QFqE3GWdwKXV7p59D3f3aYe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZHQVSE5RYNnUsXh2mi8a2MEqCZ5WZxIik3tSr/Gq/8R3TsCB
	5RXUYnsa9WKk2F3Qj4i1uc8Xs9MLzQ/DTXJdiIz13/CXfth+66K1
X-Google-Smtp-Source: AGHT+IGKkE8Qj5alHRYQT/GtuS+Y+1Ctc8ChfOQBMOx0xiUAHzpYehQViFiP60/V/dAfs056kBniHQ==
X-Received: by 2002:a17:902:d4ca:b0:20c:a387:7dc9 with SMTP id d9443c01a7336-210c69e32dfmr139076345ad.29.1730158235611;
        Mon, 28 Oct 2024 16:30:35 -0700 (PDT)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf87c1esm56083325ad.116.2024.10.28.16.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 16:30:35 -0700 (PDT)
Date: Tue, 29 Oct 2024 08:30:29 +0900 (JST)
Message-Id: <20241029.083029.72679397436968362.fujita.tomonori@gmail.com>
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
In-Reply-To: <Zx8VUety0BTpDGAL@Boquns-Mac-mini.local>
References: <ZxwVuceNORRAI7FV@Boquns-Mac-mini.local>
	<20241028.095030.2023085589483262207.fujita.tomonori@gmail.com>
	<Zx8VUety0BTpDGAL@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 27 Oct 2024 21:38:41 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Mon, Oct 28, 2024 at 09:50:30AM +0900, FUJITA Tomonori wrote:
>> On Fri, 25 Oct 2024 15:03:37 -0700
>> Boqun Feng <boqun.feng@gmail.com> wrote:
>> 
>> >> +/// Sleeps for a given duration at least.
>> >> +///
>> >> +/// Equivalent to the kernel's [`fsleep`], flexible sleep function,
>> >> +/// which automatically chooses the best sleep method based on a duration.
>> >> +///
>> >> +/// The function sleeps infinitely (MAX_JIFFY_OFFSET) if `Delta` is negative
>> >> +/// or exceedes i32::MAX milliseconds.
>> >> +///
>> > 
>> > I know Miguel has made his suggestion:
>> > 
>> > 	https://lore.kernel.org/rust-for-linux/CANiq72kWqSCSkUk1efZyAi+0ScNTtfALn+wiJY_aoQefu2TNvg@mail.gmail.com/
>> > 
>> > , but I think what we should really do here is just panic if `Delta` is
>> > negative or exceedes i32::MAX milliseconds, and document clearly that
>> > this function expects `Delta` to be in a certain range, i.e. it's the
>> > user's responsibility to check. Because:
>> > 
>> > *	You can simply call schedule() with task state set properly to
>> > 	"sleep infinitely".
>> > 
>> > *	Most of the users of fsleep() don't need this "sleep infinitely"
>> > 	functionality. Instead, they want to sleep with a reasonable
>> > 	short time.
>> 
>> I agree with the above reasons but I'm not sure about just panic with
>> a driver's invalid argument.
>> 
> 
> If a driver blindly trusts a user-space input or a value chosen by the
> hardware, I would say it's a bug in the driver. So IMO drivers should
> check the input of fsleep().
> 
>> Can we just return an error instead?
>> 
> 
> That also works for me, but an immediate question is: do we put
> #[must_use] on `fsleep()` to enforce the use of the return value? If
> yes, then the normal users would need to explicitly ignore the return
> value:
> 
> 	let _ = fsleep(1sec);
> 
> The "let _ =" would be a bit annoying for every user that just uses a
> constant duration.

Yeah, but I don't think that we have enough of an excuse here to break
the rule "Do not crash the kernel".

Another possible option is to convert an invalid argument to a safe
value (e.g., the maximum), possibly with WARN_ON_ONCE().

