Return-Path: <netdev+bounces-191311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2EDABAC38
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 22:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F6D189DD28
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 20:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9543920B808;
	Sat, 17 May 2025 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvRyOC1K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5174B1E79;
	Sat, 17 May 2025 20:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747512552; cv=none; b=gedwZLx1omIcGsPmZIh1sjcEDkLMiBRL1HdqkNUSGLWjSTOQ6tQDFsBHJv0yYOwYjSRsxXUcFpOzkXNZvzu7c77cOUuSwF/ixr9a9hrSFoKRaECGCVcwGCxPf33yGWju8EPpJ+i1yFEwseGaaKXz1C7Ubi19cR20WrFxhnn10Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747512552; c=relaxed/simple;
	bh=TMqG9CjB2LnWUVbL+i3E25ztftUibPgC8VJkqvvljbM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrZ21P8pfOkOg3js30IQ2FJQj8cpM3SvWZnrvXHdDeGoOgp0FANiE4FciyvvAJU0DXyAzVa9kJCFqFjWiBgA/bX4jnBV3HmxRIrqWWP+AwgoVqy4R1mSRmJGekENwzqeCdxfUmGh3u8T13zaYFXnHqPhcGIlMuI91MbdIlTNF0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvRyOC1K; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-441d1ed82faso23167635e9.0;
        Sat, 17 May 2025 13:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747512549; x=1748117349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V5LWVbk/o28tnUQOIgYBSt/dGSgM6hXGxumrTysarjs=;
        b=TvRyOC1K4oz89ToAKOlX+xsmEa3zmmv2teLodpXsr2ezKT70es8SqSMvPPFdFc59bb
         OoRZvcWxCGeNsgpE18ki3AguNcHL3c3+5nuRjIC2juu0pUCcSUBJaDPHtcu/3WxP6Zc0
         E38cNZha+qO3urPepFDHSutJH30RJWIzoNL0vjHx9B3F0Ximvokl31t3fBSHYOBexdaH
         8GSPAkSx4YwC/9aR2AWo6aOkeH9d3NoiW55B9Vrj9y4qJat2l9u1Uvl9Y5iXUpsujCvO
         OWm77PhfcY+YS1cnH8m+E72Bmj1Aucgx01h9tx2puJLLat+XJBYEHjTJPMqPlA/u+BrU
         iwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747512549; x=1748117349;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5LWVbk/o28tnUQOIgYBSt/dGSgM6hXGxumrTysarjs=;
        b=RXjsL4mf3Jk2benKTHPD2Ag5zuQ7q32yP/X9n7gGadp9I9DAyRo7qcL96h/UijTXT6
         qgu7jAjz12iH2YKZz2i67mRk7UvVPznq8Eq2rlNLtV/tfaZkDjaL9Z+28KxT++PKqQ0x
         pI7p3D/5v8odFZmdHpoGSvxFcGpWyfkraJ/08le4hD9qOMPMtwsvcEGGWwT4kOyOYmvI
         NcYAyGJc8GehSIlMZl72ShGx3Ug3QtOhQlq5xErDL4VJX8fgPeA9eFriaZGunEFz4jMB
         eXlUkEYD9HJ3wibxlP9P1bos3RiLjL6PnW86+/TR0SImooobqr4dQGmbPvTLVsSsRLIL
         G6iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPAJGqS3KQY7icnGd+M6msbX2gPyzn7ahDx2zKJihL5KZuV9RqbmGM9pb8v/KxcQz6WFdEXIB4N6M/@vger.kernel.org, AJvYcCVscBzCpg0IXDKRz0y1T6r8pLArKI9eSvc7HMlwoxuwVAWeUkgw0WRe6OM/gT9rjC67CHUhQruV@vger.kernel.org, AJvYcCW0JbFRAgW+Mg8HErYbS5n3RVa798vGq1o4mBGGDfKyWwDQzn0RlkX2h/m9jIreYuLqBhAuUV2lxti6vgdxUQk=@vger.kernel.org, AJvYcCWmIsWWeRWZZaNW5Rhjdl7tzXfA652XbMNmVjARTPqRaeUUB4K7VTvvuRUfRhVn9/1VS/2g+c9zhL7WSw5K@vger.kernel.org
X-Gm-Message-State: AOJu0YzbArhmfIDRYdnxtCLTKCxhlMj02p0GGN4SJoVg8tVbe9C9UEze
	hsyPTdnDTSYXE5BqQbTn+RqKCxwCU+4jRXq6T9feW5Xy2sgXogHdKiAj
X-Gm-Gg: ASbGnct2bm/xjXZi+j6K+7NKvm+aJ0Opwfb1UhvT1NIhwmVBzp2b8awjqCX4PBrWLMb
	ueFrG/6y7K+mY37dxZslhSAfaixUH2pE7/TRrYYGFYnnhXJFFUTgaqkIcWuPqJligFue0CKiIuQ
	gmHpTughUCWExFLY3gJWjcVRrlbQ/NWrrmALH6zzrJq/vViuq5g4B7Luc6geOxK3MU7FTL0DAdY
	qmln3K3XGhx6TT6QeC56SjxFTeOPazWLA3K3DySFmpb77ODK6FAF8EKJmaollvvFk0YGwwJGgsb
	X9JGlR5YgCPqhXWhmv3yG/1ClgSGv16U3wH/0aXLPxsNPmHwkk4lR8C+upywgRenupI1fZvGWyf
	jbFJK8L4=
X-Google-Smtp-Source: AGHT+IEd/mtwzYiUebZmpkaKej43SV14REit3B587TyDZ3nT5ts/cVhLyEG/wCx0ZfTpwliFkM3n0Q==
X-Received: by 2002:a05:600c:c8c:b0:442:f4a3:b5ec with SMTP id 5b1f17b1804b1-442fefd5f8dmr76328875e9.4.1747512548739;
        Sat, 17 May 2025 13:09:08 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3951a97sm160719005e9.23.2025.05.17.13.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 13:09:08 -0700 (PDT)
Message-ID: <6828ece4.050a0220.49f8b.ca57@mx.google.com>
X-Google-Original-Message-ID: <aCjs4ZiamXYmHXKg@Ansuel-XPS.>
Date: Sat, 17 May 2025 22:09:05 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, kabel@kernel.org,
	andrei.botila@oss.nxp.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, dakr@kernel.org,
	sd@queasysnail.net, michael@fossekall.de, daniel@makrotopia.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [net-next PATCH v10 7/7] rust: net::phy sync with
 match_phy_device C changes
References: <D9XV0Y22JHU5.3T51FVQONVERC@kernel.org>
 <20250517.152735.1375764560545086525.fujita.tomonori@gmail.com>
 <D9YA4FS5EX4S.217A1IK0WW4WR@kernel.org>
 <20250517.221313.1252217275580085717.fujita.tomonori@gmail.com>
 <D9YO3781UI2X.1CI7FG1EATN8G@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9YO3781UI2X.1CI7FG1EATN8G@kernel.org>

On Sat, May 17, 2025 at 09:02:51PM +0200, Benno Lossin wrote:
> On Sat May 17, 2025 at 3:13 PM CEST, FUJITA Tomonori wrote:
> > On Sat, 17 May 2025 10:06:13 +0200
> > "Benno Lossin" <lossin@kernel.org> wrote:
> >>>> I looked at the `phy.rs` file again and now I'm pretty sure the above
> >>>> code is wrong. `Self` can be implemented on any type (even types like
> >>>> `Infallible` that do not have any valid bit patterns, since it's an
> >>>> empty enum). The abstraction for `bindings::phy_driver` is
> >>>> `DriverVTable` not an object of type `Self`, so you should cast to that
> >>>> pointer instead.
> >>>
> >>> Yeah.
> >>>
> >>> I don't want to delay this patchset due to Rust side changes so
> >>> casting a pointer to bindings::phy_driver to DriverVTable is ok but
> >>> the following signature doesn't look useful for Rust phy drivers:
> >>>
> >>> fn match_phy_device(_dev: &mut Device, _drv: &DriverVTable) -> bool
> >>>
> >>> struct DriverVTable is only used to create an array of
> >>> bindings::phy_driver for C side, and it doesn't provide any
> >>> information to the Rust driver.
> >> 
> >> Yeah, but we could add accessor functions that provide that information.
> >
> > Yes. I thought that implementation was one of the options as well but
> > realized it makes sense because inside match_phy_device() callback, a
> > driver might call a helper function that takes a pointer to
> > bindings::phy_driver (please see below for details).
> >
> >
> >> Although that doesn't really make sense at the moment, see below.
> >>
> >>> In match_phy_device(), for example, a device driver accesses to
> >>> PHY_DEVICE_ID, which the Driver trait provides. I think we need to
> >>> create an instance of the device driver's own type that implements the
> >>> Driver trait and make it accessible.
> >> 
> >> I think that's wrong, nothing stops me from implementing `Driver` for an
> >> empty enum and that can't be instantiated. The reason that one wants to
> >> have this in C is because the same `match` function is used for
> >> different drivers (or maybe devices? I'm not too familiar with the
> >> terminology). In Rust, you must implement the match function for a
> >> single PHY_DEVICE_ID only, so maybe we don't need to change the
> >> signature at all?
> >
> > I'm not sure I understand the last sentence. The Rust PHY abstraction
> > allows one module to support multiple drivers. So we can could the
> > similar trick that the second patch in this patchset does.
> >
> > fn match_device_id(dev: &mut phy::Device, drv: &phy::DriverVTable) -> bool {
> >     // do comparison workking for three drivers
> > }
> 
> I wouldn't do it like this in Rust, instead this would be a "rustier"
> function signature:
> 
>     fn match_device_id<T: Driver>(dev: &mut phy::Device) -> bool {
>         // do the comparison with T::PHY_DEVICE_ID
>         dev.id() == T::PHY_DEVICE_ID
>     }
> 
> And then in the impls for Phy{A,B,C,D} do this:
> 
>     impl Driver for PhyA {
>         fn match_phy_device(dev: &mut phy::Device) -> bool {
>             match_device_id::<Self>(dev)
>         }
>     }
> 

My 2 cent about the discussion and I'm totally detached from how it
works on Rust kernel code but shouldn't we try to keep parallel API and
args between C and Rust?

I know maybe some thing doesn't make sense from C to Rust but doesn't
deviates from C code introduce more confusion when something need to be
ported from C to Rust?

Again no idea if this apply so I'm just curious about this.

> >
> > #[vtable]
> > impl Driver for PhyA {
> >     ...
> >     fn match_phy_device(dev: &mut phy::Device, drv: &phy::DriverVTable) -> bool {
> >         match_device_id(dev, drv)
> >     }
> > }
> >
> > #[vtable]
> > impl Driver for PhyB {
> >     ...
> >     fn match_phy_device(dev: &mut phy::Device, drv: &phy::DriverVTable) -> bool {
> >         match_device_id(dev, drv)
> >     }
> > }
> >
> > #[vtable]
> > impl Driver for PhyC {
> >     ...
> >     fn match_phy_device(dev: &mut phy::Device, drv: &phy::DriverVTable) -> bool {
> >         match_device_id(dev, drv)
> >     }
> > }
> >
> >
> > The other use case, as mentioned above, is when using the generic helper
> > function inside match_phy_device() callback. For example, the 4th
> > patch in this patchset adds genphy_match_phy_device():
> >
> > int genphy_match_phy_device(struct phy_device *phydev,
> >                            const struct phy_driver *phydrv)
> >
> > We could add a wrapper for this function as phy::Device's method like
> >
> > impl Device {
> >     ...
> >     pub fn genphy_match_phy_device(&self, drv: &phy::DriverVTable) -> i32 
> 
> Not sure why this returns an `i32`, but we probably could have such a
> function as well (though I wouldn't use the vtable for that).
>

Mhh looking at some comments, maybe the module needs some extra love here
and there.

> 
> > Then a driver could do something like 5th patch in the patchset:
> >
> > #[vtable]
> > impl Driver for PhyD {
> >     ...
> >     fn match_phy_device(dev: &mut phy::Device, drv: &phy::DriverVTable) -> bool {
> >        let val = dev.genphy_match_phy_device(drv);
> >        ...
> >     }
> > }
> 

-- 
	Ansuel

