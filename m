Return-Path: <netdev+bounces-191309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A51B4ABAC34
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 22:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B20C189D25D
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 20:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC891FA859;
	Sat, 17 May 2025 20:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDhlNorv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A28E1ADFE4;
	Sat, 17 May 2025 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747512323; cv=none; b=kTbxCAhuPiOgFr62B+rsF8u7CVQaVz331rWGUvC2ZpUUUTXR+Q9P8uTXtHlYg53shY2Xbwc8sj8an2VssQfEXKGYRH7dAvKYWf5lOpJ14tria59LCLaQ7upOXGKVxaJAc7FX812qyswADQ72bvCLVj/RGQNP5A+wb2vMh8W/gfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747512323; c=relaxed/simple;
	bh=AB4XzMpsMikY6okt4vrF3tGm3mBeN0JVfbnQcQG7w+g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T53+8efgJWZwtzu17DU9kNJRFeKRgbPgIXnLl/SQNVJ4uOxDhj177HH4Ht8p6Pg6g3W8BnvJdkEQN52xCtsaCErRr3x7uLlRlMLJzklfcYzioW9iUpL+r5lfGj9KFVkhR067LnKgzuHe8/bCylKi3tX/Y5YLTmMJc+DN7e+op+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDhlNorv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-442fda876a6so16337745e9.0;
        Sat, 17 May 2025 13:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747512318; x=1748117118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UsuugEQ+/2e9S0tJT62PmU1w6u3inyoOycAd5NTvgvM=;
        b=BDhlNorvbdcESMWqko74Qt5n21DTrOrJfEh28irVRDnl/Jrb4NjgwSLxEw2UzEB1dn
         V9lzzhuOLzU4SQ2fcra8C9jFfKJamar4vw5MhOnzcGNPZKb6amH38SSVT/WQ+nw9HKpf
         2i2rq5iAfhZK+p/eqaN4kYorsOFw8/nTXG8oURpfgElmO7KhS0DUDfzaQ2fVl044FLC5
         cwr8lUq5K9UsNL9qwAVf/3HQjDd+LVLCctkTPoqJix37oDzG2TyrTphZH81TNnJowE10
         3hrrVypL99Q390l8xAeCW7XnS30HVXj2Gs7alh4q/iEF2Fmhq7Ul9gvfawmaDIPt59X0
         9EKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747512318; x=1748117118;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsuugEQ+/2e9S0tJT62PmU1w6u3inyoOycAd5NTvgvM=;
        b=kkgYeYbhk7b2c5jj/VZtTVVcQRIBxweqWRt3wACfelVzNLhs5buoHjDO9k0ghqH0DE
         WvgLFR9F3Al4gRQHb/wCBX2SrgWNNfVgH6GXcZEIFoXMJ4pPC3cj5McAMn/hggLuMY9X
         ovS4uYuMEhPqUR19DfeFZL85xqDZvWSprRbt9aWEnPJjZNYPKOxWQqiH1JE++GbmxOcX
         KwCAAeTITgW48ZcoSVHtW/dMeMDA6WRf2OWRf8EcMjt05X7Cr57cUlE54gwl8PGrKtno
         GeJxU98e7RmUK3q+AqSHVYf9i/9Z6Y850jGy0I/dN9LX6PlCSL/EpfZaxFGnJi9Pzv50
         S3fw==
X-Forwarded-Encrypted: i=1; AJvYcCVMd2oexlInM0s0aXKRNwb+6qjE4iV0Rv/LtdZWXMd2ZHuOqLvOMGbp3bPqdmstw11ST1m0XnXSet0p@vger.kernel.org, AJvYcCWu+Ak+NY1u+rHltCf0f8tX+M+vU8bWMXpcdbkB8QYLpMVRq/XzZAAtwOxZ7/iIGz7wAZkYyQJc337zSAYs@vger.kernel.org, AJvYcCXPDc/yc0lNxCec2Q9Xwdu6N0EMrUZE/43hjMfM/SDZ9YFW/Y0EfT9XQiHb2LCssFxCn8aShq4d@vger.kernel.org, AJvYcCXeTYsRRQV+rgciWTYeIQD/vhGu3S35yuQQSGFtOrkZWU4nHRyjdubEWeGhlKM6NTqUpu3UASPVVSh2LAIa4yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVUmeChQvOlZ0IEAyZOJ6URR/48VcTS09bl4zA0hFUsJpnziir
	shccHV2nHcFN0vkhB2hhincipb9dAnqDtm5+SMWoaPnF2AqQA2CIu722
X-Gm-Gg: ASbGncstNcnfAl9iCpyTaAq+SGHi/eX81Jjh4TpxmLVqVQbsXna5fAz7aEHKHwwjmdg
	nFkGWCDP2f2ISzHfS67PNgYJWhyQWwyfXour6aItMYmZiHZL9HCKV+R72uYuL3n4bSa84/+jIDq
	LqMsdWEL4cEeklpjG+QwnX9QCai5oeEFTxaBh7U4UUuoSKB/FFKbXVZQQyV/cC6ij8uWnh93yqD
	+uH7g+zq0LfCRq8NSCl1WbV9RzhdXaZKCPGfI0Xo8SJzZXsytqduwVCSCo5xJ+9A4hFhuLGj5t0
	O3rg8neL1VATYxVQJn8PwyCzr5pQuk3QPI84u5thw7yuR9fycUsy9n/VzGfiKUBUcOsU3hfibgk
	JHCGJEmg=
X-Google-Smtp-Source: AGHT+IFFit0BZ5q0vjpcrs87LwvkQdg3H5wj5FX0pcaNQIIhyEraUeokOCYnWQy73hWpYTheN/mtfA==
X-Received: by 2002:a05:600c:8507:b0:43c:f597:d582 with SMTP id 5b1f17b1804b1-442fd608753mr73837655e9.1.1747512317316;
        Sat, 17 May 2025 13:05:17 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd583f20sm80268055e9.28.2025.05.17.13.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 13:05:16 -0700 (PDT)
Message-ID: <6828ebfc.050a0220.7888.5e66@mx.google.com>
X-Google-Original-Message-ID: <aCjr-Uov-xEQPNkz@Ansuel-XPS.>
Date: Sat, 17 May 2025 22:05:13 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: lossin@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, kabel@kernel.org,
	andrei.botila@oss.nxp.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, dakr@kernel.org,
	sd@queasysnail.net, michael@fossekall.de, daniel@makrotopia.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	rmk+kernel@armlinux.org.uk
Subject: Re: [net-next PATCH v11 1/6] net: phy: pass PHY driver to
 .match_phy_device OP
References: <20250516212354.32313-1-ansuelsmth@gmail.com>
 <20250516212354.32313-2-ansuelsmth@gmail.com>
 <D9YA78RFVQMH.QPUFXMHSVU7V@kernel.org>
 <20250517.222804.482303667530450320.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250517.222804.482303667530450320.fujita.tomonori@gmail.com>

On Sat, May 17, 2025 at 10:28:04PM +0900, FUJITA Tomonori wrote:
> On Sat, 17 May 2025 10:09:53 +0200
> "Benno Lossin" <lossin@kernel.org> wrote:
> 
> > On Fri May 16, 2025 at 11:23 PM CEST, Christian Marangi wrote:
> >> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> >> index a59469c785e3..079a0f884887 100644
> >> --- a/rust/kernel/net/phy.rs
> >> +++ b/rust/kernel/net/phy.rs
> >> @@ -418,15 +418,18 @@ impl<T: Driver> Adapter<T> {
> >>  
> >>      /// # Safety
> >>      ///
> >> -    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
> >> +    /// `phydev` and `phydrv` must be passed by the corresponding callback in
> >> +    //  `phy_driver`.
> >>      unsafe extern "C" fn match_phy_device_callback(
> >>          phydev: *mut bindings::phy_device,
> >> +        phydrv: *const bindings::phy_driver,
> >>      ) -> crate::ffi::c_int {
> >>          // SAFETY: This callback is called only in contexts
> >>          // where we hold `phy_device->lock`, so the accessors on
> >>          // `Device` are okay to call.
> >>          let dev = unsafe { Device::from_raw(phydev) };
> >> -        T::match_phy_device(dev) as i32
> >> +        let drv = unsafe { T::from_raw(phydrv) };
> >> +        T::match_phy_device(dev, drv) as i32
> >>      }
> >>  
> >>      /// # Safety
> >> @@ -574,6 +577,19 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
> >>  /// This trait is used to create a [`DriverVTable`].
> >>  #[vtable]
> >>  pub trait Driver {
> >> +    /// # Safety
> >> +    ///
> >> +    /// For the duration of `'a`, the pointer must point at a valid
> >> +    /// `phy_driver`, and the caller must be in a context where all
> >> +    /// methods defined on this struct are safe to call.
> >> +    unsafe fn from_raw<'a>(ptr: *const bindings::phy_driver) -> &'a DriverVTable {
> >> +        // CAST: `DriverVTable` is a `repr(transparent)` wrapper around `bindings::phy_driver`.
> >> +        let ptr = ptr.cast::<DriverVTable>();
> >> +        // SAFETY: by the function requirements the pointer is const and is
> >> +        // always valid to access for the duration of `'a`.
> >> +        unsafe { &*ptr }
> >> +    }
> > 
> > If we go the way of supplying a `&DriverVTable` in the
> > `match_phy_device` function, then this should be a function in the impl
> > block of `DriverVTable` and not in `Driver`.
> 
> Yeah.
> 
> > See my reply to Fujita on the previous version, I don't think that we
> > need to add the `DriverVTable` to the `match_phy_device` function if we
> > don't provide accessor methods. Currently that isn't needed, so you only
> > need the hunks above this one. (I'd wait for Fujita's reply though).
> 
> Agreed, to make DriverVTable actually useful in match_phy_device(),
> further changes would be needed. I think it's sufficient to simply
> make the Rust code compile, as shown in the patch below.
> 
> I can take care of making sure Rust uses DriverVTable correctly later.
>

Thanks a lot, I'm sending new revision with the below change as
suggested.

> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index a59469c785e3..32ea43ece646 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -421,6 +421,7 @@ impl<T: Driver> Adapter<T> {
>      /// `phydev` must be passed by the corresponding callback in `phy_driver`.
>      unsafe extern "C" fn match_phy_device_callback(
>          phydev: *mut bindings::phy_device,
> +        _phydrv: *const bindings::phy_driver,
>      ) -> crate::ffi::c_int {
>          // SAFETY: This callback is called only in contexts
>          // where we hold `phy_device->lock`, so the accessors on

-- 
	Ansuel

