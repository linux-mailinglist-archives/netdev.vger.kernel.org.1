Return-Path: <netdev+bounces-191080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E821AB9FA2
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 17:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A0418806A5
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 15:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDFF1A3178;
	Fri, 16 May 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m03Pc0I9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E7EA32;
	Fri, 16 May 2025 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408348; cv=none; b=I4QUQRqTPRFduziyKgqQxXRVq0qWmYv9uP3tJDoEU1v5z2cJPUj7N8b6pEABeDoTQu1meK/2mU7PHYoKsVpmXuYq9DGgRNDoLsiKdoX1nAe4rXweNW75ma1e6YBY6NHuWbz67JOplxqyDdX1Dx8Zu4qMZcP7h3ljritpZmHZR8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408348; c=relaxed/simple;
	bh=iC9u+UtHMhHcM+URwVij/yn7NuPdsYomqxWBajHqXe8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OajFcvbjqnxWx8iOGfn2GaKjGLhYdiHrJEsw49LeIbtmViOCXJ5LpA8DCfCH/wDhH90esBIH+VfeEQTyfSl+Elys4uoXigd/QtE9PNv2fKxSV7a0P2vdKA1W3m1jgpzENdYrAY/RtjlmUrTUBqLl/q1MzO/RrqQyQe1U1unAYMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m03Pc0I9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso20754745e9.0;
        Fri, 16 May 2025 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747408345; x=1748013145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zBiYRws7s4bKZ8Cm+jQJAQDlwaYsEKqIVZU0U7DnLVA=;
        b=m03Pc0I94cDcZGE0CfZYxPZ7Xp8JNZAzxQer0iHfvpuH7xy42LkPHhF89xNdbkeqnl
         IYwwsAr2tvpmHGniyRk3D2RH8YmEPqtw1vpiHP0TQnHMWts+KAPstRmwKP1923DgRzh5
         7UV3/9GzfmA9C19PCT3ihnPeAFxKF/WORhduIrRVfnuKKRm9GmmtcGYA+Ng6zLMuLzIs
         oeccq/hTk6V14/VeTX9G/1jmyGNDoUxTtIJjEEbz3ZuG8QV4dD5IWN9M6RJeP3MxgC+V
         wdSehkN92YCQs5BsGo+fW8RHSLwe4hGdnPC10zy5hZ3C37vetybR838NtDkc11PPEAy6
         eXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747408345; x=1748013145;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBiYRws7s4bKZ8Cm+jQJAQDlwaYsEKqIVZU0U7DnLVA=;
        b=rj+c7sgHb/8AWS+wN1rXuOumSlcrchnDByNMZy4EqfAuHP9tmwajLDbf1NOzztGc7L
         LqfC2HcbUg8INVCd1xB2SxOHOdJrQk9IhT7dU3uCTt7qsd+pfgPJ1Sl3kvFA3bnCeA/1
         QTWZVj+ta6lCe3teE9jWwURwkJgGxu+naRCM87L0PS1sttHYT/2tPdnsANozURuzAYTX
         0MoUP0WgApjs7f5FA2ZMTCQnBCBPHRjaL00UZlXycey7OS2kAum7z8Pn2WOvXyJMu2w6
         5OXMWXRiFipJrBMz6D3+RHzx7jVh2rtQLeDZL6y7XuwDHEO996OMBJ37aw4QXwBNuzpG
         HbiA==
X-Forwarded-Encrypted: i=1; AJvYcCVC5iiRvRM4zCABf5hw1b/d+Pwmi8nVcYj2FSvYX9VSKyOpTkNAgbYPKb7o8HGgt93v38umbnxjBB7QCPd9R6Y=@vger.kernel.org, AJvYcCWLq1SNWHMte2AoBZd6VE7HtEL45Vai89dk72BchH3M5Sw32bk6gT0b82CfkzmNKoWD3aZN+tMTq9GE@vger.kernel.org, AJvYcCXXe2Ozo473dN1AzUUwTqxMyGFAA6QKxVEeGeWmrXqQm7Jv7kcn1vfkaU3KFRXNyJxNhNcRalT/q5ySB+UR@vger.kernel.org, AJvYcCXf5UhcQcZJ9V8Zus2UW1WLBTlkFLAQjCao7FlkeCcz1P5jFlVb3LcTeWjjTkxtTJLXiCdqjnbn@vger.kernel.org
X-Gm-Message-State: AOJu0YwmmXV5GXDw61haW4RRHAr76ri8tqYcNSZ727G7nJi6QCEzAERx
	5Qp1Hds0+Uni8lOb5tBcrNoOR2vT4f5nMzlFoaub5dEsSriGXAn9ak1X
X-Gm-Gg: ASbGncsgSWrvF7oR0bMqrBSCPHI+Xh4vzlCiUwflJW2k9PQoPR86ccLuDgzCqXwjvHB
	tqcuX5ty0ZCPOjg9p1Of05kANm5r08FBrtaX49RiLkw+8B8hV3M4K3YBly5OgJYOiOX11tayBch
	uaNHRbV5uynYsuo95AGnY4kks3PI5zU+ic4X+swt2fAYeceXtO8lSTwkilbkJ1sBiSFRIFQgR3e
	cHuzt4r8kC1cJo4+p68SR7vkrlJwAlnWotWMkS8FQMCyU6ZbPQwhhK3CHUSOSGNO2Cb4NYxOjZK
	ENGU+VRKnniwUxI2lTub5zGnj9G6ja9plhO7IWgFvXTPlkoNTLuJyRB2slYf7Aod9V8Lxpvc7MT
	MrtVXBnw=
X-Google-Smtp-Source: AGHT+IFkdjlxOpJKA2fXMJusp69KEVL/qR+EAPGHX7GlpKULJLzZ1YSEN2N3lpQPZgdyFJk6frkT6g==
X-Received: by 2002:a05:6000:2af:b0:39d:724f:a8ae with SMTP id ffacd0b85a97d-3a35c8355admr4295266f8f.33.1747408344625;
        Fri, 16 May 2025 08:12:24 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd583fb7sm37168575e9.32.2025.05.16.08.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 08:12:24 -0700 (PDT)
Message-ID: <682755d8.050a0220.3c78c8.a604@mx.google.com>
X-Google-Original-Message-ID: <aCdV03m-PpI9qHas@Ansuel-XPS.>
Date: Fri, 16 May 2025 17:12:19 +0200
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
References: <20250515112721.19323-1-ansuelsmth@gmail.com>
 <20250515112721.19323-8-ansuelsmth@gmail.com>
 <20250516.213005.1257508224493103119.fujita.tomonori@gmail.com>
 <D9XO2721HEQI.3BGSHJXCHPTL@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9XO2721HEQI.3BGSHJXCHPTL@kernel.org>

On Fri, May 16, 2025 at 04:48:53PM +0200, Benno Lossin wrote:
> On Fri May 16, 2025 at 2:30 PM CEST, FUJITA Tomonori wrote:
> > On Thu, 15 May 2025 13:27:12 +0200
> > Christian Marangi <ansuelsmth@gmail.com> wrote:
> >> @@ -574,6 +577,23 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
> >>  /// This trait is used to create a [`DriverVTable`].
> >>  #[vtable]
> >>  pub trait Driver {
> >> +    /// # Safety
> >> +    ///
> >> +    /// For the duration of `'a`,
> >> +    /// - the pointer must point at a valid `phy_driver`, and the caller
> >> +    ///   must be in a context where all methods defined on this struct
> >> +    ///   are safe to call.
> >> +    unsafe fn from_raw<'a>(ptr: *const bindings::phy_driver) -> &'a Self
> >> +    where
> >> +        Self: Sized,
> >> +    {
> >> +        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::phy_driver`.
> >> +        let ptr = ptr.cast::<Self>();
> >> +        // SAFETY: by the function requirements the pointer is valid and we have unique access for
> >> +        // the duration of `'a`.
> >> +        unsafe { &*ptr }
> >> +    }
> >
> > We might need to update the comment. phy_driver is const so I think
> > that we can access to it any time.
> 
> Why is any type implementing `Driver` a transparent wrapper around
> `bindings::phy_driver`?
> 

Is this referred to a problem with using from_raw or more of a general
question on how the rust wrapper are done for phy code?

> >>      /// Defines certain other features this PHY supports.
> >>      /// It is a combination of the flags in the [`flags`] module.
> >>      const FLAGS: u32 = 0;
> >> @@ -602,7 +622,7 @@ fn get_features(_dev: &mut Device) -> Result {
> >>  
> >>      /// Returns true if this is a suitable driver for the given phydev.
> >>      /// If not implemented, matching is based on [`Driver::PHY_DEVICE_ID`].
> >> -    fn match_phy_device(_dev: &Device) -> bool {
> >> +    fn match_phy_device<T: Driver>(_dev: &mut Device, _drv: &T) -> bool {
> >>          false
> >>      }
> >
> > I think that it could be a bit simpler:
> >
> > fn match_phy_device(_dev: &mut Device, _drv: &Self) -> bool
> >
> > Or making it a trait method might be more idiomatic?
> >
> > fn match_phy_device(&self, _dev: &mut Device) -> bool
> 
> Yeah that would make most sense.
>

I think

fn match_phy_device(_dev: &mut Device, _drv: &Self) -> bool

more resemble the C parallel function so I think this suite the best,
should make it easier to port if ever (am I wrong?)

-- 
	Ansuel

