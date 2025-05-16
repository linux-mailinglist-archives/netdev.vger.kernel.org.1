Return-Path: <netdev+bounces-191079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF94AB9F92
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 17:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F80F5079F6
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 15:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33571A5BBA;
	Fri, 16 May 2025 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmHLKXeU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ECD153BED;
	Fri, 16 May 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408218; cv=none; b=jP6Gg0ARxjlG4S8MpiHV3xnB5ZoGxz0Clz1ZU5U7BbHKXf6oLPPxjWrPRqGpb8BDOwZSMqBLAeoSudVLSeQ4WGz8Sa9Dp4GyK+liFso0tC7jZtQ/S7uPiDR0Q1wkbm6fWiEE6ytF9s6rHC616SXVkANZixdCHJ4tBQv8eMhh0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408218; c=relaxed/simple;
	bh=p+6azPytU87DSqkliHBZsHaU/+HxhfRmQABFInFMOEY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHFYvrdagcZI8RDBmFSBmTIVBOoHXD3V44sRtQk2J7GnsSbovbEaYqzQgwV/HBT85LDxN5iTTcxBU9gLTyeCHDtfqbsiGQYi9ce+kG2kGis7AVPCexkevON7GsN0yWYtJzxXQOAMAIhmcV/r2UaMBgg4CemSqx2WFshWIDHg6Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmHLKXeU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so16918325e9.1;
        Fri, 16 May 2025 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747408215; x=1748013015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ORFPBkZMrgLx3vzfx3RRX19YF7r1Ciw69gV5Ee6dfvw=;
        b=MmHLKXeUvZOZGgcxG+Zp7hTDUrr/prbWRKuqgYjkXqp3iS8t37n4s/gE6qNJNq8sGO
         L9kYJXP0E5Fp65CWIVzXdW/2Vjq8LbvCBltBS/A0qe2N9nANuzuMGY3SjJbDRtK4Dwl2
         V68ll/R+PDfx94G2GCSSvtZRWbeVN2x3tgsjoF4wE3qOFGrfETbZoOtOuTGuNwry3dH3
         SxAGjZXA3z7wGAtYmOZ+oNExOkdRIt9T78/Um9MOVI4VfHpmxXRUzXjdC/P+mMLIVfrp
         5QvSMHSXYmMFtBA26OdWRDZU3+4Ld+gtIcMX9IfeBhbosp7IPTMfdN+ayy459P9PTINP
         6ipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747408215; x=1748013015;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORFPBkZMrgLx3vzfx3RRX19YF7r1Ciw69gV5Ee6dfvw=;
        b=wI6mberWwL7oP9y9GoU81An75YcTS43Z6y4YqESRN8jQoqAYRWKfHvE9A5rZhs2I8L
         yY1ScFnyPOW/9m/CeO50oMmHnhzKl3vIr7ZmtnWriLxXL9AVB1+NcjNjIe9HAlf7B5kM
         ajfOyhhy+KTuSIAGkt2fukIhK/UcGsTgDwOT73kV7FGSbECWS9o8Ns4HVkuSLW3z3Nxp
         wWu5PjsFwq+5Z3wxwuBBg3J8JaRkF7STpjwjv13ewDvjLqD6DZFeqtVycYYesYuqWwRb
         eunB2mj/hE62M+QD5cPA8/7m0YzdnSgt6JRa5NzRLibQhAglQ9Bfa70UdWAEvMgsjYVC
         +SWw==
X-Forwarded-Encrypted: i=1; AJvYcCUdnTKF6/p/S0SHrSr5BBXQF2BWZaH9XFQtQkxME+pIqzEOh5kTOZdvWyNnLXGmWFvsw4NqGxq9@vger.kernel.org, AJvYcCVexkj/ZQMFT6o5yp7YLrCWP7peh/OvWipy9MNDgNqLwvqqiHKtyaHnDn6dfuCxt5IiikNAGDYIDLmHhPoR4EA=@vger.kernel.org, AJvYcCWzaI44Kp1o7MZvFj77ggEz++4Sd/W1bEBodjv8ZRXfcifpYw2jGV4tY3QHFDQkJbQ8bIGHPLceFXN3@vger.kernel.org, AJvYcCXup02oJjZDAVOGG+QnE8FDGbVbejfRdTook0lOeY4HsHE/p/BpKVs6I1TzltKyYb3gdD/66lmUAeH6v46c@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6pr/EDRQFCjaHrpzIWNgXTa2r9QKn1oNo7zceRnzLsx61herm
	VpdmlOl6aIH8C84lIRwYWV9HQPgSSa1rVeTVZudw4uJH2/gx9EkPHFem
X-Gm-Gg: ASbGncvcqw/BA7QEwRFt4dLzXpJNDvMFZ0YB7cNBRyBJFmx/ONADKpmD0vA6vlqyLRb
	9McSu9hciavml84OSCboyE0i5k1iqkwjTOLEfvh9taVRNKQ4TE8EdvchqKF+igTZFG2D3udnu5f
	Nt5pYvWcazKDG+UFr4zsOoBniAP7/SbDb35OpNHsMPhLXzE3ZluvQY+vBE937huva97tDXWa48k
	at+gN1EfCa7xCCOFppq2T9LxqiU/GNxB7ret58yCwKU5j/eYgFGgDxC/oMcoUxOV5kIjoqlGyJe
	7NUrIZ6XR+nJ6nD0iYYKwbE3+yBcYOUXHwVU9aBCoGQqjJ5MgPjRPdfRUGFfbVVpA88vYUpgdzy
	WIAcbaW0=
X-Google-Smtp-Source: AGHT+IEteT63fryg0tffdzvOFJE6r86nEEJ/R7AafWNje5uNyi4G+IVEa3WTgJNTxO2NJcLVPLFdMw==
X-Received: by 2002:a05:600c:46c7:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-442fd93d0a1mr39132045e9.3.1747408214312;
        Fri, 16 May 2025 08:10:14 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39e852fsm115801795e9.27.2025.05.16.08.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 08:10:13 -0700 (PDT)
Message-ID: <68275555.050a0220.337522.0bff@mx.google.com>
X-Google-Original-Message-ID: <aCdVUEmo4GvA4wx8@Ansuel-XPS.>
Date: Fri, 16 May 2025 17:10:08 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, florian.fainelli@broadcom.com,
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
References: <20250515112721.19323-1-ansuelsmth@gmail.com>
 <20250515112721.19323-8-ansuelsmth@gmail.com>
 <20250516.213005.1257508224493103119.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516.213005.1257508224493103119.fujita.tomonori@gmail.com>

On Fri, May 16, 2025 at 09:30:05PM +0900, FUJITA Tomonori wrote:
> Hi,
> 
> On Thu, 15 May 2025 13:27:12 +0200
> Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> > Sync match_phy_device callback wrapper in net:phy rust with the C
> > changes where match_phy_device also provide the passed PHY driver.
> > 
> > As explained in the C commit, this is useful for match_phy_device to
> > access the PHY ID defined in the PHY driver permitting more generalized
> > functions.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  rust/kernel/net/phy.rs | 26 +++++++++++++++++++++++---
> >  1 file changed, 23 insertions(+), 3 deletions(-)
> > 
> > diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> > index a59469c785e3..936a137a8a29 100644
> > --- a/rust/kernel/net/phy.rs
> > +++ b/rust/kernel/net/phy.rs
> > @@ -418,15 +418,18 @@ impl<T: Driver> Adapter<T> {
> >  
> >      /// # Safety
> >      ///
> > -    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
> > +    /// `phydev` and `phydrv` must be passed by the corresponding callback in
> > +    //  `phy_driver`.
> >      unsafe extern "C" fn match_phy_device_callback(
> >          phydev: *mut bindings::phy_device,
> > +        phydrv: *const bindings::phy_driver
> >      ) -> crate::ffi::c_int {
> >          // SAFETY: This callback is called only in contexts
> >          // where we hold `phy_device->lock`, so the accessors on
> >          // `Device` are okay to call.
> >          let dev = unsafe { Device::from_raw(phydev) };
> > -        T::match_phy_device(dev) as i32
> > +        let drv = unsafe { T::from_raw(phydrv) };
> > +        T::match_phy_device(dev, drv) as i32
> >      }
> >  
> >      /// # Safety
> > @@ -574,6 +577,23 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
> >  /// This trait is used to create a [`DriverVTable`].
> >  #[vtable]
> >  pub trait Driver {
> > +    /// # Safety
> > +    ///
> > +    /// For the duration of `'a`,
> > +    /// - the pointer must point at a valid `phy_driver`, and the caller
> > +    ///   must be in a context where all methods defined on this struct
> > +    ///   are safe to call.
> > +    unsafe fn from_raw<'a>(ptr: *const bindings::phy_driver) -> &'a Self
> > +    where
> > +        Self: Sized,
> > +    {
> > +        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::phy_driver`.
> > +        let ptr = ptr.cast::<Self>();
> > +        // SAFETY: by the function requirements the pointer is valid and we have unique access for
> > +        // the duration of `'a`.
> > +        unsafe { &*ptr }
> > +    }
> 
> We might need to update the comment. phy_driver is const so I think
> that we can access to it any time.
>

Any hint for a better comment?

> >      /// Defines certain other features this PHY supports.
> >      /// It is a combination of the flags in the [`flags`] module.
> >      const FLAGS: u32 = 0;
> > @@ -602,7 +622,7 @@ fn get_features(_dev: &mut Device) -> Result {
> >  
> >      /// Returns true if this is a suitable driver for the given phydev.
> >      /// If not implemented, matching is based on [`Driver::PHY_DEVICE_ID`].
> > -    fn match_phy_device(_dev: &Device) -> bool {
> > +    fn match_phy_device<T: Driver>(_dev: &mut Device, _drv: &T) -> bool {
> >          false
> >      }
> 
> I think that it could be a bit simpler:
> 
> fn match_phy_device(_dev: &mut Device, _drv: &Self) -> bool
> 
> Or making it a trait method might be more idiomatic?
> 
> fn match_phy_device(&self, _dev: &mut Device) -> bool
> 
> 
> Thanks!

-- 
	Ansuel

