Return-Path: <netdev+bounces-191279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4F6ABA884
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 08:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9CE4A2DA9
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 06:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24DA1AAA1C;
	Sat, 17 May 2025 06:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av5RsDQr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC12144304;
	Sat, 17 May 2025 06:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747463275; cv=none; b=cw/HrHdgXhnaQbOpYALp8t2fXkTimjbJ/M7nJBMh/VrVN5Us6PZdgR/jXqbbFttqoJoirYxfM+YtYD82kFpAjJexoWnVPsFDH8KAmIhK/97LKJ9q2OyiOncG+Prprs3Gms+uVPIwUQyj9ODYf6AKnRfAHFULPhMw6a/yBH/kvg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747463275; c=relaxed/simple;
	bh=04hjFnYTy7+AxMGmiHcfEddSamIEENvao6s3xLG1yvI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J85bEFHKrk/IzVh1LJ8TLbNf0Sqqa6UtVcsjUgs3xZ8PgTtq+f82cukxfXesKv/LX2sgyVXto68B2MwPw+hF4GQkWps+GRs6J62muhu3+vThsJBfjsHQINRU6kCWrxs5Y1K1vCNhxDXGKADxnj2mXKew1VveFM24xuR0DRS81tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Av5RsDQr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-309fac646adso3864546a91.1;
        Fri, 16 May 2025 23:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747463273; x=1748068073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krmGtfTdxRGRfzuCphmKxJbjcDcZR+vBZsHvl5bmpNU=;
        b=Av5RsDQrwb0+a8g0uqrE2xNJ+JmGvvUGuV7dx5fp4pmfAj6X7YOfioucAnGecwg62r
         C4WpYv6Qdy7hcf+Zz2nqTYBKEs8KssUwK18+0tdbFosWC7aC/HhvfWXtUuRJxvk39oHr
         M0AL9ekJuYGIKQUAhs+6oiNnpwmruhEaUaCw2/TBgS8hGKo+07L64Pui/rU4tGmICLvR
         iR40AsuNZnvY1LWLd7hhPXlS5QScD6kYNHBopPtnHH4qy0CaQAU/t1cZi5nslRfOCZN8
         SsuXGx7XBq9j9sVvut8gJf0hvQxLitLG08c0mYhO3dMMybi10sqWFibX0jD5GeN8slYM
         a1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747463273; x=1748068073;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=krmGtfTdxRGRfzuCphmKxJbjcDcZR+vBZsHvl5bmpNU=;
        b=fRwZtaqM4mtltiaDyu8DdAtH/EL5WUPSp2T59ZlM2TVyw1wQLdE4OquqAmL6lJoN1/
         0CzG73RaWx0FJU9UP8kN3rnfT6i3XeqIkuCQ6SQxHo0MUZ7LSFA6rO2q0f3DuwLMQoJW
         TLQG/usqopuoOaoie9Uz0+khwVF6H9TWgY9QT8+inVbkZ5MeU6UPIxEyuDnyFDV5jFw4
         z1GP8+2ORtZ3/wc3Acp6vohFY6EzHX+cgqKhkLTwfhnFQZ6HqEVMo+0xNrjhgN/8krmX
         Vk4lhqnJfLDYN9OaB9AZ6C/bN7dhkR0Wn4evT/6jBM8jNQ2Pc2tYygUwINJZf8U4eiRF
         dE3g==
X-Forwarded-Encrypted: i=1; AJvYcCU62fOCf09T9OSAt+hTpH7wJZFp+CEbGFR0l0vcBCvQ8HjBLQUrIIyEQh+WDW7pAAsBWpT50WnNDnFYkn6+@vger.kernel.org, AJvYcCVv653BEqihHmQTWyXSqdv4dDxTvMlNiLFO+e7Bj0Ir1v91k0t+8kgqKTjgoOLoNeXm+YirEhiJWLoB@vger.kernel.org, AJvYcCW3uiw7FMb45s6dVXADv1XvhwnKB/wT+7jkyc+iM78mpgqLFzWr9YyMMHB2jpcsd9ouVKVsXUfiYAGUtgOLnMk=@vger.kernel.org, AJvYcCXpclnoLWRZ+AOKfUyV4jq3Sy4JgdR/iSNTCQG+liywL506D5Yrpt6nlEnbqRlkjKizyeBbZpJ6@vger.kernel.org
X-Gm-Message-State: AOJu0YwNqPd3tR7M9vMhr8QrUACwX1bhRAznXAEKN9SoX8TfbhwsPqih
	+sQYM+8tv9KixUnKehUjtTqF6IEHnLD7BgiIUKSE8b/StlYCHurk0YmN
X-Gm-Gg: ASbGncv1MmmjiFaTy+iaMWcVD4VC3bY0eFkpyvcWDT/buRs33KKROGcbVt0C7E1Vwoh
	DY7VdSO2As/vwhnap7dyM+zXL5Zzk3maJLDFOHaWneDwOUgOB2LOlBtmWpnctEaaJR7mU9ybZn3
	ns0OG3zROgY9G4xcBFoKZg2hEqzmMwQ3GwG4oEzjbULtDcEVTLoyuU6bBOaMbMA5A07Wt0KXuO1
	fzxqdj64AwEvVGnoaq5wAFkFykENv9OyF3y/GCW01hk07itdpFN9yDPcVwM4nYuzGR20gyEGlhP
	zMkofyWkY4jWvBHTye7pFvO7zxWLqr2teIBxQ9neRLtScFHdBIpSMWIluq4H3mcq24IqZTEsj8G
	wxcZX+7OkNP4ZnUUfLAaQJ8dU8Px9RrO0Xg==
X-Google-Smtp-Source: AGHT+IGxNQ/F6deePiyixGUiLONdz1qwFhhEhs2C4GvcTFT7SbLhRfQ1aZIhkwvC3whsyWDVK+otfQ==
X-Received: by 2002:a17:90b:2e85:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-30e7e770523mr4533105a91.14.1747463273197;
        Fri, 16 May 2025 23:27:53 -0700 (PDT)
Received: from localhost (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e9ad67011sm1123052a91.33.2025.05.16.23.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 23:27:52 -0700 (PDT)
Date: Sat, 17 May 2025 15:27:35 +0900 (JST)
Message-Id: <20250517.152735.1375764560545086525.fujita.tomonori@gmail.com>
To: lossin@kernel.org
Cc: ansuelsmth@gmail.com, fujita.tomonori@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 kabel@kernel.org, andrei.botila@oss.nxp.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, aliceryhl@google.com, dakr@kernel.org,
 sd@queasysnail.net, michael@fossekall.de, daniel@makrotopia.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [net-next PATCH v10 7/7] rust: net::phy sync with
 match_phy_device C changes
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <D9XV0Y22JHU5.3T51FVQONVERC@kernel.org>
References: <D9XO2721HEQI.3BGSHJXCHPTL@kernel.org>
	<682755d8.050a0220.3c78c8.a604@mx.google.com>
	<D9XV0Y22JHU5.3T51FVQONVERC@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Thanks for the review!

On Fri, 16 May 2025 22:16:23 +0200
"Benno Lossin" <lossin@kernel.org> wrote:

> On Fri May 16, 2025 at 5:12 PM CEST, Christian Marangi wrote:
>> On Fri, May 16, 2025 at 04:48:53PM +0200, Benno Lossin wrote:
>>> On Fri May 16, 2025 at 2:30 PM CEST, FUJITA Tomonori wrote:
>>> > On Thu, 15 May 2025 13:27:12 +0200
>>> > Christian Marangi <ansuelsmth@gmail.com> wrote:
>>> >> @@ -574,6 +577,23 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
>>> >>  /// This trait is used to create a [`DriverVTable`].
>>> >>  #[vtable]
>>> >>  pub trait Driver {
>>> >> +    /// # Safety
>>> >> +    ///
>>> >> +    /// For the duration of `'a`,
>>> >> +    /// - the pointer must point at a valid `phy_driver`, and the caller
>>> >> +    ///   must be in a context where all methods defined on this struct
>>> >> +    ///   are safe to call.
>>> >> +    unsafe fn from_raw<'a>(ptr: *const bindings::phy_driver) -> &'a Self
>>> >> +    where
>>> >> +        Self: Sized,
>>> >> +    {
>>> >> +        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::phy_driver`.
>>> >> +        let ptr = ptr.cast::<Self>();
>>> >> +        // SAFETY: by the function requirements the pointer is valid and we have unique access for
>>> >> +        // the duration of `'a`.
>>> >> +        unsafe { &*ptr }
>>> >> +    }
>>> >
>>> > We might need to update the comment. phy_driver is const so I think
>>> > that we can access to it any time.
>>> 
>>> Why is any type implementing `Driver` a transparent wrapper around
>>> `bindings::phy_driver`?
>>> 
>>
>> Is this referred to a problem with using from_raw or more of a general
>> question on how the rust wrapper are done for phy code?
> 
> I looked at the `phy.rs` file again and now I'm pretty sure the above
> code is wrong. `Self` can be implemented on any type (even types like
> `Infallible` that do not have any valid bit patterns, since it's an
> empty enum). The abstraction for `bindings::phy_driver` is
> `DriverVTable` not an object of type `Self`, so you should cast to that
> pointer instead.

Yeah.

I don't want to delay this patchset due to Rust side changes so
casting a pointer to bindings::phy_driver to DriverVTable is ok but
the following signature doesn't look useful for Rust phy drivers:

fn match_phy_device(_dev: &mut Device, _drv: &DriverVTable) -> bool

struct DriverVTable is only used to create an array of
bindings::phy_driver for C side, and it doesn't provide any
information to the Rust driver.

In match_phy_device(), for example, a device driver accesses to
PHY_DEVICE_ID, which the Driver trait provides. I think we need to
create an instance of the device driver's own type that implements the
Driver trait and make it accessible.

