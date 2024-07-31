Return-Path: <netdev+bounces-114686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9B3943773
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8701C21EDD
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 20:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDF916087B;
	Wed, 31 Jul 2024 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WjH26Lyz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD9A482CA;
	Wed, 31 Jul 2024 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722459426; cv=none; b=rnZrFdboSmnAhMfz6p7MHVvvt/KwOqdXzWiqkM5NSww1TA4XjT6khRQCa25+FSWGTIV3vOH7tNKSfcBj5isgu8uvTSLNh4vKPDqMYLY3488E8Gi1eOowyqV2+ggQqTmdwuJ1Q6rHNn47r0AkjUn/DB0RUBqq9pYZ5p0Knz/n07s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722459426; c=relaxed/simple;
	bh=S6cIvGR5mOk2G7VAoRfOCaXFBOwMiNuDrGBl4qDM7wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQQe8XeZMF/l7tu5viHBaDHgqW7jDS0lVf1UenZmazyx9cVuCgQ5Yt93MUVBizaIglUaI3GsDi/244Sb+SfCQ8o3NrHkXzH/9HsxDb1ebvRtjB8o2u4bV9kfkk04bHe/3hH99y4aVbx+VRjOlndqhvDvv80DcT6y9f4/MoWzAFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WjH26Lyz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z2w+dNclAsqk4wZhdlz04USVS7DM8QutvGTc2QRMkiw=; b=WjH26LyzdkyLNZWCd6RZ6aFCa5
	5uVtFij44MxI+Fersgih1A9CSC7it3xJj1wKYMgZFyByhKZUgBfqWAM/MeHchlwq+z2V6aLnNAZQL
	tq09tyt0GHaSku3sY0nkri9o0XLxAZ0vHw9ZBlbqPvWJn5VmUECVtLShBL2vYgLUDVyw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZGNY-003iAy-5R; Wed, 31 Jul 2024 22:57:00 +0200
Date: Wed, 31 Jul 2024 22:57:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alice Ryhl <aliceryhl@google.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me
Subject: Re: [PATCH net-next v2 2/6] rust: net::phy support probe callback
Message-ID: <5055051e-b058-400f-861d-e7438bebb017@lunn.ch>
References: <20240731042136.201327-1-fujita.tomonori@gmail.com>
 <20240731042136.201327-3-fujita.tomonori@gmail.com>
 <5525a61c-01b7-4032-97ee-4997b19979ad@lunn.ch>
 <CAH5fLggyhvEhQL_VWdd38QyFuegPY5mXY_J-jZrh9w8=WPb2Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLggyhvEhQL_VWdd38QyFuegPY5mXY_J-jZrh9w8=WPb2Vg@mail.gmail.com>

> > > +    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
> > > +    unsafe extern "C" fn probe_callback(phydev: *mut bindings::phy_device) -> core::ffi::c_int {
> > > +        from_result(|| {
> > > +            // SAFETY: This callback is called only in contexts
> > > +            // where we can exclusively access to `phy_device`, so the accessors on
> > > +            // `Device` are okay to call.
> >
> > This one is slightly different to other callbacks. probe is called
> > without the mutex. Instead, probe is called before the device is
> > published. So the comment is correct, but given how important Rust
> > people take these SAFETY comments, maybe it should indicate it is
> > different to others?
> 
> Interesting. Given that we don't hold the mutex, does that mean that
> some of the methods on Device are not safe to call in this context? Or
> is there something else that makes it okay to call them despite not
> holding the mutex?

probe is always the first method called on a device driver to match it
to a device. Traditionally, if probe fails, the device is destroyed,
since there is no driver to drive it. probe needs to complete
successfully before the phy_device structure is published so a MAC
driver can reference it. If it is not published, nothing can have
access to it, so you don't need to worry about parallel activities on
it.

And a PHY driver does not need a probe function. Historically, probe
was all about, can this driver drive this hardware. However, since we
have ID registers in the hardware, we already know the driver can
drive the hardware. So probe is now about setting up whatever needs
setting up. For PHY drivers, there is often nothing, no local state
needed, etc. So the probe is optional.

	Andrew

