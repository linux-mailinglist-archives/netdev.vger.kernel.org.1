Return-Path: <netdev+bounces-191034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D59CAB9C0D
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 14:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB46C1BC6A41
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 12:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85A823C4F3;
	Fri, 16 May 2025 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT/UWPHm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359BE22A4D8;
	Fri, 16 May 2025 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398626; cv=none; b=G5+Q7FTw2XFajkfD4XfnYvYjlVKFIgu/DyY8ZIXiE6Etnv6f9ilXR2PjFD+AjwOkOGaj5Oy+7laaCedRQ7zi7Y4wDQdl/Ihlbgk3Euy28G1xzJuq7twUlf3HFl0plQ9BqshiSrhnt9+JtJf+ygy8lEvykKkU06HOBPkYvO6bmOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398626; c=relaxed/simple;
	bh=nwYhIG9LJ+6zK7RH0ApN4R1mwVIHfFiOX+00ypaTp+k=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=W5yHtg3wW+5zabmJnRBOvb1NDZq/58s9oPAL6JYbi3Spk/TAzocW1QyfvStCMDR6Yf9IWDxRu31IbiprR8wmf4kcJpG7NTTj0fkMpqyIvqMJMO+HscsCqnycmaML31OZ8BoVEx5j1lfHeeIO/XprdBQ/pqnAOkTvTkPHN9tL2vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bT/UWPHm; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73712952e1cso2033931b3a.1;
        Fri, 16 May 2025 05:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747398624; x=1748003424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLCTf9Ut0kcV85ZGwg++EZk2C0hrJLjzgs04W8Smfc4=;
        b=bT/UWPHms8EkOTGZpdELSGDi5y9hVaJEVG1q8R1l//FzjydZ1hujD8T0KZh8MJxiZT
         vfkxG7g1gC4nvxIDb15tv7HqHrlmuFI3kDgllPBg8sb7tDmBZ1JEFHQrzAMkHyoz0rGx
         /BQOHM//g46JTUJxNBVAbvFrdTtUOY6FANblCbxu8Yz4aR48bpPtUhy1PH193aEQqrLB
         Rs+LEkQ5u/0DHnw0t3Ea2UYJt67nKJMSgyR/n6Ri1+CRB2HXsmOzuja46BZBLDsmN5as
         Wn6dfBB9ZZqMRPwkDCeDSE6mfzvRadrO0bOvZ94Q1KmZpC/pARxBNe/bNLcbwyGuXd2o
         L6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747398624; x=1748003424;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kLCTf9Ut0kcV85ZGwg++EZk2C0hrJLjzgs04W8Smfc4=;
        b=bknvw3OChr1J8KY1N1TuA4OHPCO2e149Gwf7i6T+yLQ56wSlSkXCPEZrNNpjltsALn
         5t5KMuFOZtkXf4+eLSpy6E9YARvXEDuo4I0toOTyMp5W3E1U4nk3sezUL1NbTKwwZUst
         Vr8bphqNcGzUcknlLN8ctfuPXVriQEwGbjjy6L4j1Yal53ccpMgBAXhqN3xPrgRIFByl
         9XzMBY5Ar3atqybu3xR5U+F7LK0X2IlkMVevivn9nKOgxtG8XqLBkjlcIT3COLTv3eMJ
         yOTuQvxbpa/KllNzSNIUkr10BqsGzQq//gW3GEhfdL3Lpw8/m80HCCnYz2yPw0b0uD3b
         v58Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuO1LHK9WcVvfGdZgM1GZvhwkkTAChOmKpa2y5f1V4F4izuHUAMj0vVgVDafRHMdYNsOoJPx5G6AGVAF87@vger.kernel.org, AJvYcCVwg0xGFA2sX19ftHa/ElbHTX5c+bXSo/6fUI8LZZKkcy16dyoQ+Yztr5VsmUwAqh1EZAtuZhTG@vger.kernel.org, AJvYcCW3MY/o24zt1iOKOmhEYgUUH/zosCMYF2e3rXwSycl1jmoZesP5jUwFzhMWbMnp76hDvPg1MDHzRforPThiQxY=@vger.kernel.org, AJvYcCWgYkMPj+EhkvWXACcmT+IlGWlV+mgrgFflck+FWG88Vsa5pwQnc0J+Yl1Yd9y+aJg5V/+Fx903SNCh@vger.kernel.org
X-Gm-Message-State: AOJu0YwKManvoavFP7/tUUtNrRrVVzxC62EjKnZVYyr4//CXBVmU7vxA
	XqlZP3zjs70BLAPAHaOQPeI1IPfyOpa3kTYLRyMlH4iZIuQ856j9m0Ej
X-Gm-Gg: ASbGncvRQqR4HWjwnVAcvSKLr62uPnODNrhBpqjhyehE3KFigVAZHq3lPTjkSbNLNzt
	L/IiHJJN7ZafYjmxLu7g02NJnmQ2yvqwhs1DeJhoZ0LtzQpQY7PA0QKL0oEjzioLz2WNjXGFr9z
	1oevNNIs4v/ig3kNYwBlEArfCX7Lcmabw1KCLLoFzX12qPYGZV/YATjvdSC3zfcbjAgKNN3iqGV
	XVyjBA+r2V+ibHuym2o0PSF9kZnZTXxsGobD7oYP3cFpCrhh4XrrVivu3tk5d4pwFJ4brhhPQsE
	BPjti5GrZdoXDJMmMVQIERq8Aui4hB2zTtK/5CCfYjU58ajBvJOE4H/UOn48nKO6w5ars9A4zAc
	SBdt3o8T6iwBrQNbWW7sT9OsAuBWUCVCFSw==
X-Google-Smtp-Source: AGHT+IG7bFcsFrVgd2uv9RkZrXD7UCHoqQABXr+MZFrh4F6RGHZH/oFmgFlgnjb+Ml/aJOBBoVST2g==
X-Received: by 2002:a05:6a00:2d0a:b0:740:6f69:8d94 with SMTP id d2e1a72fcca58-742acba67c1mr3197974b3a.0.1747398624190;
        Fri, 16 May 2025 05:30:24 -0700 (PDT)
Received: from localhost (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9739a12sm1399496b3a.77.2025.05.16.05.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 05:30:23 -0700 (PDT)
Date: Fri, 16 May 2025 21:30:05 +0900 (JST)
Message-Id: <20250516.213005.1257508224493103119.fujita.tomonori@gmail.com>
To: ansuelsmth@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 kabel@kernel.org, andrei.botila@oss.nxp.com, fujita.tomonori@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
 dakr@kernel.org, sd@queasysnail.net, michael@fossekall.de,
 daniel@makrotopia.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [net-next PATCH v10 7/7] rust: net::phy sync with
 match_phy_device C changes
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250515112721.19323-8-ansuelsmth@gmail.com>
References: <20250515112721.19323-1-ansuelsmth@gmail.com>
	<20250515112721.19323-8-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 15 May 2025 13:27:12 +0200
Christian Marangi <ansuelsmth@gmail.com> wrote:

> Sync match_phy_device callback wrapper in net:phy rust with the C
> changes where match_phy_device also provide the passed PHY driver.
> 
> As explained in the C commit, this is useful for match_phy_device to
> access the PHY ID defined in the PHY driver permitting more generalized
> functions.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  rust/kernel/net/phy.rs | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index a59469c785e3..936a137a8a29 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -418,15 +418,18 @@ impl<T: Driver> Adapter<T> {
>  
>      /// # Safety
>      ///
> -    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
> +    /// `phydev` and `phydrv` must be passed by the corresponding callback in
> +    //  `phy_driver`.
>      unsafe extern "C" fn match_phy_device_callback(
>          phydev: *mut bindings::phy_device,
> +        phydrv: *const bindings::phy_driver
>      ) -> crate::ffi::c_int {
>          // SAFETY: This callback is called only in contexts
>          // where we hold `phy_device->lock`, so the accessors on
>          // `Device` are okay to call.
>          let dev = unsafe { Device::from_raw(phydev) };
> -        T::match_phy_device(dev) as i32
> +        let drv = unsafe { T::from_raw(phydrv) };
> +        T::match_phy_device(dev, drv) as i32
>      }
>  
>      /// # Safety
> @@ -574,6 +577,23 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
>  /// This trait is used to create a [`DriverVTable`].
>  #[vtable]
>  pub trait Driver {
> +    /// # Safety
> +    ///
> +    /// For the duration of `'a`,
> +    /// - the pointer must point at a valid `phy_driver`, and the caller
> +    ///   must be in a context where all methods defined on this struct
> +    ///   are safe to call.
> +    unsafe fn from_raw<'a>(ptr: *const bindings::phy_driver) -> &'a Self
> +    where
> +        Self: Sized,
> +    {
> +        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::phy_driver`.
> +        let ptr = ptr.cast::<Self>();
> +        // SAFETY: by the function requirements the pointer is valid and we have unique access for
> +        // the duration of `'a`.
> +        unsafe { &*ptr }
> +    }

We might need to update the comment. phy_driver is const so I think
that we can access to it any time.

>      /// Defines certain other features this PHY supports.
>      /// It is a combination of the flags in the [`flags`] module.
>      const FLAGS: u32 = 0;
> @@ -602,7 +622,7 @@ fn get_features(_dev: &mut Device) -> Result {
>  
>      /// Returns true if this is a suitable driver for the given phydev.
>      /// If not implemented, matching is based on [`Driver::PHY_DEVICE_ID`].
> -    fn match_phy_device(_dev: &Device) -> bool {
> +    fn match_phy_device<T: Driver>(_dev: &mut Device, _drv: &T) -> bool {
>          false
>      }

I think that it could be a bit simpler:

fn match_phy_device(_dev: &mut Device, _drv: &Self) -> bool

Or making it a trait method might be more idiomatic?

fn match_phy_device(&self, _dev: &mut Device) -> bool


Thanks!

