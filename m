Return-Path: <netdev+bounces-87877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38688A4D5B
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F58BB20AC6
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93605D47E;
	Mon, 15 Apr 2024 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oKhCu5vc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06955C8E6;
	Mon, 15 Apr 2024 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713179462; cv=none; b=rKl97Ezf72lCwF87UDmJplOhhIoko1canHS3wDNa73BUf6F6Driq9r+sM0UimPrYgPAgBeIUebL/StuVK9LCiTbJ+fEBqbEfghVneYyqqFyQvrJudgBkdvHRCL6+ANA+0UOiYKmcNiTMmS5+vwZye+zBKF/fQQ7Mbav5BuFesdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713179462; c=relaxed/simple;
	bh=Wdx8tH2jh2Lm6GmSbmIxPnRH1Em82bPbtDQpebbbnS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YP+ny3UY6lF2SF/BQ248Tn/oxCady3OkxPCEl98Ajv8gt9YOOvTvcrMxBLXGa2bqq3yAJHn3bamP7OiYPFWL1iDrMrrZN691hNyiRJ6wGjUcAaKScNiPBrM2st5OGwiEB1ItXVNh8lroFYSmuyxH2cTq7rGhM931qhKtXzWKYfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oKhCu5vc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E55DC113CC;
	Mon, 15 Apr 2024 11:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713179462;
	bh=Wdx8tH2jh2Lm6GmSbmIxPnRH1Em82bPbtDQpebbbnS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKhCu5vcwtkWbnkFvKKdHbXs0hOsITh7rD4EEyxmny0pdAWcrBjDeIAJu9b9DmzpR
	 fbkAn5YhtfeYuEPIGRjrb7LNafPCWtlIml41YEkt14jPOtDdf93KBFJUnqN6lTzq8T
	 hhECBDAkTgXAPs801iWmZgsMEqf9nAUxPnO5wyHc=
Date: Mon, 15 Apr 2024 13:10:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>
Subject: Re: [PATCH net-next v1 3/4] rust: net::phy support Firmware API
Message-ID: <2024041554-lagged-attest-586d@gregkh>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
 <20240415104701.4772-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415104701.4772-4-fujita.tomonori@gmail.com>

On Mon, Apr 15, 2024 at 07:47:00PM +0900, FUJITA Tomonori wrote:
> This patch adds support to the following basic Firmware API:
> 
> - request_firmware
> - release_firmware
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> CC: Luis Chamberlain <mcgrof@kernel.org>
> CC: Russ Weight <russ.weight@linux.dev>
> ---
>  drivers/net/phy/Kconfig         |  1 +
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/net/phy.rs          | 45 +++++++++++++++++++++++++++++++++

Please do not bury this in the phy.rs file, put it in drivers/base/ next
to the firmware functions it is calling.

>  3 files changed, 47 insertions(+)
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 7fddc8306d82..3ad04170aa4e 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -64,6 +64,7 @@ config RUST_PHYLIB_ABSTRACTIONS
>          bool "Rust PHYLIB abstractions support"
>          depends on RUST
>          depends on PHYLIB=y
> +        depends on FW_LOADER=y
>          help
>            Adds support needed for PHY drivers written in Rust. It provides
>            a wrapper around the C phylib core.
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 65b98831b975..556f95c55b7b 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -9,6 +9,7 @@
>  #include <kunit/test.h>
>  #include <linux/errname.h>
>  #include <linux/ethtool.h>
> +#include <linux/firmware.h>
>  #include <linux/jiffies.h>
>  #include <linux/mdio.h>
>  #include <linux/phy.h>
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 421a231421f5..095dc3ccc553 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -9,6 +9,51 @@
>  use crate::{bindings, error::*, prelude::*, str::CStr, types::Opaque};
>  
>  use core::marker::PhantomData;
> +use core::ptr::{self, NonNull};
> +
> +/// A pointer to the kernel's `struct firmware`.
> +///
> +/// # Invariants
> +///
> +/// The pointer points at a `struct firmware`, and has ownership over the object.
> +pub struct Firmware(NonNull<bindings::firmware>);
> +
> +impl Firmware {
> +    /// Loads a firmware.
> +    pub fn new(name: &CStr, dev: &Device) -> Result<Firmware> {
> +        let phydev = dev.0.get();

That's risky, how do you "know" this device really is a phydev?  That's
not how the firmware api works, use a real 'struct device' please.


> +        let mut ptr: *mut bindings::firmware = ptr::null_mut();
> +        let p_ptr: *mut *mut bindings::firmware = &mut ptr;

I'm sorry, but I don't understand the two step thing here, you need a
pointer for where the C code can put something, is this really how you
do that in rust?  Shouldn't it point to data somehow down below?

> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Device`.

Again, phydev is not part of the firmware api.

> +        // So it's just an FFI call.
> +        let ret = unsafe {
> +            bindings::request_firmware(
> +                p_ptr as *mut *const bindings::firmware,

Where is this coming from?

> +                name.as_char_ptr().cast(),
> +                &mut (*phydev).mdio.dev,
> +            )
> +        };
> +        let fw = NonNull::new(ptr).ok_or_else(|| Error::from_errno(ret))?;
> +        // INVARIANT: We checked that the firmware was successfully loaded.
> +        Ok(Firmware(fw))
> +    }
> +
> +    /// Accesses the firmware contents.
> +    pub fn data(&self) -> &[u8] {

But firmware is not a u8, it's a structure.  Can't the rust bindings
handle that?  Oh wait, data is a u8, but the bindings should show that,
right?


> +        // SAFETY: The type invariants guarantee that `self.0.as_ptr()` is valid.
> +        // They also guarantee that `self.0.as_ptr().data` pointers to
> +        // a valid memory region of size `self.0.as_ptr().size`.
> +        unsafe { core::slice::from_raw_parts((*self.0.as_ptr()).data, (*self.0.as_ptr()).size) }

If new fails, does accessing this also fail?

And how are you using this?  I guess I'll dig in the next patch...

> +    }
> +}
> +
> +impl Drop for Firmware {
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariants, `self.0.as_ptr()` is valid and
> +        // we have ownership of the object so can free it.
> +        unsafe { bindings::release_firmware(self.0.as_ptr()) }

So drop will never be called if new fails?

Again, please don't put this in the phy driver, put it where it belongs
so we can add the other firmware functions when needed.

thanks,

greg k-h

