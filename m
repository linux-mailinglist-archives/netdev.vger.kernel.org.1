Return-Path: <netdev+bounces-89205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBD18A9AD8
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A4B1F2286D
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4096C136E1F;
	Thu, 18 Apr 2024 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="evrpzN/N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1893313247D;
	Thu, 18 Apr 2024 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445642; cv=none; b=MMrJWLcde3bjIwf5ebXjZCKXDgsU3W7KRMWVufmQlCW900mLl27FcfxvVwa9GkKR1VMn6pfoo1HiSaaBPNYpJLKE9ui6SowGp55e0Nqg8+gsu+iegeP7ksLqfhoGhJ8yM08Soi03aldfXpl9GoOiTo6/2WTz4nQtMEEHsKMJHTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445642; c=relaxed/simple;
	bh=ZQmRZwntijmUzO0RJofTZbGiAQg+OTI6y2iSSjPaG+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2Rk3ZoUGL8qOlAe/lLa+nuQ/TU5n6DJS0GdwmWn12xS2gnKqJFtS8N3DL2HLWReom6arg5SVqYeYllZ2JGYNw7TztD/9Ain817w3Cn890vXOv54DMhjellc2k93t0TJziHAKQtnIwviurkrD5BEp3YUroGkekXfbAz8dTELe/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=evrpzN/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B584C113CC;
	Thu, 18 Apr 2024 13:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713445641;
	bh=ZQmRZwntijmUzO0RJofTZbGiAQg+OTI6y2iSSjPaG+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evrpzN/NyFcR3av0bWND/+cKKKoHBp5A4LjBTEmtcTfSKedCuje/mGlvFv2toJgGZ
	 +LNrLSHCzleFmBRy4A++9odF9EmYKhuFfAbdiiKrA6ksELw3CAnwBE/xUiGYi9x2/4
	 XpKdo2PpIDuyejZpqhEes0mzU+M0c3n1oSTyqJ2o=
Date: Thu, 18 Apr 2024 15:07:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, mcgrof@kernel.org, russ.weight@linux.dev
Subject: Re: [PATCH net-next v1 3/4] rust: net::phy support Firmware API
Message-ID: <2024041800-justice-rectify-3715@gregkh>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
 <20240415104701.4772-4-fujita.tomonori@gmail.com>
 <2024041554-lagged-attest-586d@gregkh>
 <20240418.215108.816248101599824703.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418.215108.816248101599824703.fujita.tomonori@gmail.com>

On Thu, Apr 18, 2024 at 09:51:08PM +0900, FUJITA Tomonori wrote:
> >> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> >> index 421a231421f5..095dc3ccc553 100644
> >> --- a/rust/kernel/net/phy.rs
> >> +++ b/rust/kernel/net/phy.rs
> >> @@ -9,6 +9,51 @@
> >>  use crate::{bindings, error::*, prelude::*, str::CStr, types::Opaque};
> >>  
> >>  use core::marker::PhantomData;
> >> +use core::ptr::{self, NonNull};
> >> +
> >> +/// A pointer to the kernel's `struct firmware`.
> >> +///
> >> +/// # Invariants
> >> +///
> >> +/// The pointer points at a `struct firmware`, and has ownership over the object.
> >> +pub struct Firmware(NonNull<bindings::firmware>);
> >> +
> >> +impl Firmware {
> >> +    /// Loads a firmware.
> >> +    pub fn new(name: &CStr, dev: &Device) -> Result<Firmware> {
> >> +        let phydev = dev.0.get();
> > 
> > That's risky, how do you "know" this device really is a phydev?
> 
> That's guaranteed. The above `Device` is phy::Device.

How are we supposed to know that from reading this diff?  I think you
all need to work on naming things better, as that's going to get _VERY_
confusing very quickly.

thanks,

greg k-h

