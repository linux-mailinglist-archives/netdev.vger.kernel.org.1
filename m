Return-Path: <netdev+bounces-89186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6FD8A9A68
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 14:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304121F210C6
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 12:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21C712EBD8;
	Thu, 18 Apr 2024 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2+3dKX7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96F7D40E;
	Thu, 18 Apr 2024 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444683; cv=none; b=hznv8xOj1y5h/dmHOP7oiYmRwiH8pKikyadsr+iQZ7gQ+YcXkigiDHo0ALfznWRQrT1GOMHW18+JjLaREmxqdV55iDI67koKp+g5887C+0dbfkrjkVTeGtk9vj+8xeUUsv/kdleWj/DpLUWHKs3KXq8njgrZedmv5IYBzhydMfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444683; c=relaxed/simple;
	bh=r7GWD0cnvUzk4BrLd0lA2y+WxClZliaU2V71i+ooL+Y=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=al6uGVlvM7ihJgNQYgVkaHPfuXOznwb2MZ16YBNfgUnkY+16DS+MqKL4QxJq+FszdRszdBXcB/jpckXVCqEhDuDcJ53K5W5oF9ced4f3dBsLgKsLSqfLJRbT/o03/W4y4IfyPg5p0b13gmLesiYwTyJfrQYYwEcLb+8b5gC9A40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2+3dKX7; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2abae23d682so229211a91.3;
        Thu, 18 Apr 2024 05:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713444681; x=1714049481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYQQ6x5PQs+7pRarP8H6SbmAo0a0VwHa5Gdfjk8N7ks=;
        b=J2+3dKX7m2NEMJvUgMsVImlpiwSao4kvgxTv8m5W6RwxCeVJhxg/mEeNdTedDIki+s
         0NJEvEZiQ+0XEWwT+KpDGOvA6qXbT4QseGinhU6qf4jbV6DooGWYGhm6c5JXSWWbOePQ
         GxlGXiWtv9m2Eo3WWOJB52pSUBKWJe5dCUMQ/5tr5ZnPsV2Ogq/bLLeMSwwU+N6f9cNa
         2kKicSn3Pnwifu3Qv5nivo4OofziIuwgO8w67mR6S0t6zBciqLIszgwBcfFxkktcBJJi
         iQVjFW+K/2PjOKvXtVqrPl38qolDG5vGLn3kqJWQgOr+Xe6bEdTUgeBQ2FCrCaVgZ91B
         xCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444681; x=1714049481;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AYQQ6x5PQs+7pRarP8H6SbmAo0a0VwHa5Gdfjk8N7ks=;
        b=NinNDFu26nainypIWpuU89JfiHJLYbJwy2wc6wB4D3C5bMMdxILoiPm0LXixy/TLc6
         DdnEOB5N9SoeyYGthWdj39v7TaS3jRPNXyvVLsy7KTEk6XROCHDU8UfvovgdHYHXDxPr
         6be2ZuioYvgNhowW9mpMeedFPOPXCtrFdmnHAvft4oEe/fhSMOVYF9tGTllzTSSpUGVs
         iFHN6ime72kwk9QZdOXQuACpnRZE4yBFPTo+8V5eiGD3vcBTPUR1lCh7CgKMo9FoIm77
         wYoxJ+eLVXaC8BWtPkCHxu/Kn8+ogDv/qw8NvUU3Ln3uPZrVmSC+PF/952E64PdLqaTK
         MP6A==
X-Forwarded-Encrypted: i=1; AJvYcCWBkTzDseNBpfjNYvCNpapeBVk8EFWXqYp26sYXDepuajpO/KicFHSi9zvxu8wf/wkqLgvvfD0HgTZnMXIHJaCk9KtFtNDzDM+D9aKIhcBjvuyC486T4OLNB4iHKcPOUWFDW3sOL60=
X-Gm-Message-State: AOJu0Yz+ydsxZ/5AeiHPtN/8+Q2Ves1lC2QZ7cE8//0LADWrdiPFXcde
	PnaYyJzOqtGBA7jfCNKKun1IJpH5lPmwTkEA4HY2mIoVDPdf0z5o+whB2ANO
X-Google-Smtp-Source: AGHT+IHbq+6w80vWYaxKCglkniAg6WlEJa2DDh2HnK+6ckiKxndHkvdO4ik0XyWpyg3QMl++6pXjcw==
X-Received: by 2002:a17:90a:c7c8:b0:2ab:be54:85ed with SMTP id gf8-20020a17090ac7c800b002abbe5485edmr2104020pjb.0.1713444681486;
        Thu, 18 Apr 2024 05:51:21 -0700 (PDT)
Received: from localhost (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id v12-20020a17090a778c00b002ab534866dcsm2782641pjk.26.2024.04.18.05.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:51:21 -0700 (PDT)
Date: Thu, 18 Apr 2024 21:51:08 +0900 (JST)
Message-Id: <20240418.215108.816248101599824703.fujita.tomonori@gmail.com>
To: gregkh@linuxfoundation.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu, mcgrof@kernel.org,
 russ.weight@linux.dev
Subject: Re: [PATCH net-next v1 3/4] rust: net::phy support Firmware API
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <2024041554-lagged-attest-586d@gregkh>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
	<20240415104701.4772-4-fujita.tomonori@gmail.com>
	<2024041554-lagged-attest-586d@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 15 Apr 2024 13:10:59 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Apr 15, 2024 at 07:47:00PM +0900, FUJITA Tomonori wrote:
>> This patch adds support to the following basic Firmware API:
>> 
>> - request_firmware
>> - release_firmware
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> CC: Luis Chamberlain <mcgrof@kernel.org>
>> CC: Russ Weight <russ.weight@linux.dev>
>> ---
>>  drivers/net/phy/Kconfig         |  1 +
>>  rust/bindings/bindings_helper.h |  1 +
>>  rust/kernel/net/phy.rs          | 45 +++++++++++++++++++++++++++++++++
> 
> Please do not bury this in the phy.rs file, put it in drivers/base/ next
> to the firmware functions it is calling.

Sure. I had a version of creating rust/kernel/firmware.rs but I wanted
to know if a temporary solution could be accepted.

With the build system for Rust, we can't put it in drivers/base/ yet.


>> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
>> index 421a231421f5..095dc3ccc553 100644
>> --- a/rust/kernel/net/phy.rs
>> +++ b/rust/kernel/net/phy.rs
>> @@ -9,6 +9,51 @@
>>  use crate::{bindings, error::*, prelude::*, str::CStr, types::Opaque};
>>  
>>  use core::marker::PhantomData;
>> +use core::ptr::{self, NonNull};
>> +
>> +/// A pointer to the kernel's `struct firmware`.
>> +///
>> +/// # Invariants
>> +///
>> +/// The pointer points at a `struct firmware`, and has ownership over the object.
>> +pub struct Firmware(NonNull<bindings::firmware>);
>> +
>> +impl Firmware {
>> +    /// Loads a firmware.
>> +    pub fn new(name: &CStr, dev: &Device) -> Result<Firmware> {
>> +        let phydev = dev.0.get();
> 
> That's risky, how do you "know" this device really is a phydev?

That's guaranteed. The above `Device` is phy::Device.

> That's not how the firmware api works, use a real 'struct device' please.

Right, I'll do in v2.

> 
>> +        let mut ptr: *mut bindings::firmware = ptr::null_mut();
>> +        let p_ptr: *mut *mut bindings::firmware = &mut ptr;
> 
> I'm sorry, but I don't understand the two step thing here, you need a
> pointer for where the C code can put something, is this really how you
> do that in rust?  Shouldn't it point to data somehow down below?

Oops, can be simpler:

let mut ptr: *const bindings::firmware = ptr::null_mut();
let ret = unsafe {
        bindings::request_firmware(&mut ptr, name.as_char_ptr().cast(), &mut (*phydev).mdio.dev)
};

>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Device`.
> 
> Again, phydev is not part of the firmware api.
> 
>> +        // So it's just an FFI call.
>> +        let ret = unsafe {
>> +            bindings::request_firmware(
>> +                p_ptr as *mut *const bindings::firmware,
> 
> Where is this coming from?
> 
>> +                name.as_char_ptr().cast(),
>> +                &mut (*phydev).mdio.dev,
>> +            )
>> +        };
>> +        let fw = NonNull::new(ptr).ok_or_else(|| Error::from_errno(ret))?;
>> +        // INVARIANT: We checked that the firmware was successfully loaded.
>> +        Ok(Firmware(fw))
>> +    }
>> +
>> +    /// Accesses the firmware contents.
>> +    pub fn data(&self) -> &[u8] {
> 
> But firmware is not a u8, it's a structure.  Can't the rust bindings
> handle that?  Oh wait, data is a u8, but the bindings should show that,
> right?

In the C side:

struct firmware {
        size_t size;
        const u8 *data;
        /* firmware loader private fields */
        void *priv;
};

data() function allows a driver in Rust to access to the above data
member in Rust.

A driver could define its own structure over &[u8]. 

> 
>> +        // SAFETY: The type invariants guarantee that `self.0.as_ptr()` is valid.
>> +        // They also guarantee that `self.0.as_ptr().data` pointers to
>> +        // a valid memory region of size `self.0.as_ptr().size`.
>> +        unsafe { core::slice::from_raw_parts((*self.0.as_ptr()).data, (*self.0.as_ptr()).size) }
> 
> If new fails, does accessing this also fail?

If a new() fails, a Firmware object isn't created. So data() function
cannot be called.


> And how are you using this?  I guess I'll dig in the next patch...
> 
>> +    }
>> +}
>> +
>> +impl Drop for Firmware {
>> +    fn drop(&mut self) {
>> +        // SAFETY: By the type invariants, `self.0.as_ptr()` is valid and
>> +        // we have ownership of the object so can free it.
>> +        unsafe { bindings::release_firmware(self.0.as_ptr()) }
> 
> So drop will never be called if new fails?

Yes, like data() function.

