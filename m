Return-Path: <netdev+bounces-55142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DA28098A0
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 02:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB701C20859
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 01:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75688136F;
	Fri,  8 Dec 2023 01:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvSlbqJv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A340B1717;
	Thu,  7 Dec 2023 17:28:43 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cdf3e99621so361533b3a.1;
        Thu, 07 Dec 2023 17:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701998923; x=1702603723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNIwAtt1u/hcDJlwPdE5PkrgJUQEuR8HwD2r0CEq5+w=;
        b=FvSlbqJvq+IWShf9FLhA1QtqIVE5GBNOXAZRVKgVFD2lNtZ96QiR1mO/ieg2gmDESM
         hiJiAZ0PdEcRimaFZ9gfHvqcdBBaHD0hZQtkjdNWwxrUiiFVfQblBLxrxO4opgu8GNvb
         wwSXOn6lC7OMVyjoOwfjk+/3v5j2V0IJiGfl2qWSZn/Jp66PS2KcXnEb7G1rmDRWtaGt
         UGLy9wY2YchyJaDb5nrnmaWaccY5Eq34wSCdCjcXLNpzfiFSlXGwwbtYMr1vaQ43d6qK
         hb6DIrX0zhQ4RQl4R2GHjEM3yIOcHGYMsJNydrUR8ubZAvO8vhEDMhJkgMMPuU/eG2jh
         DH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701998923; x=1702603723;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nNIwAtt1u/hcDJlwPdE5PkrgJUQEuR8HwD2r0CEq5+w=;
        b=k/AxhcH93HqGWaIsA/1kveTfn7XbuxpuuTXe7+kiuSEuujHyB0kZ8eGQaE0xgsqamG
         I8PBujuxYIf5jDjJz4laMKdVQpEmzoOmvOjlB+ZtqSSjZGk4AOUuYGgNbhS0pyq8ILVs
         BDKc4JcU8OCrRQdv8TEsr9yML3Ha//WGFEqqFiGcST/akkUJlNDIfeqBkywsMyvcPUjj
         7hYX58B0e4qmWFZ1C5qOAxCu1oF5TXt9od19pMCwirv4n225i11gBt2ql/8ICueSQVXV
         YXkE91N6mWsIry1lRc0uKrryhnbgB4gc5F3nKIPaHEU+SBWg+2ToTu4u6QBuVBCjtS7L
         ybLQ==
X-Gm-Message-State: AOJu0YwW93ysfvsZ/VGgVH0MumfxAL/e+3W8IlLZynqAXNhCDrN/vfR5
	D2+COMuL4Kh8Y5xlHrjsHGFQIqwMf62xIw==
X-Google-Smtp-Source: AGHT+IGGRdltUyaOe7ybLE4oh5Er6A9XklGtVr85IGYof1H4qqglCxejdFdLS6U6n8T22klUSFnZ8w==
X-Received: by 2002:a05:6a20:4308:b0:187:df59:5c43 with SMTP id h8-20020a056a20430800b00187df595c43mr7045161pzk.2.1701998922999;
        Thu, 07 Dec 2023 17:28:42 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902768c00b001d076c2e336sm453886pll.100.2023.12.07.17.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 17:28:42 -0800 (PST)
Date: Fri, 08 Dec 2023 10:28:42 +0900 (JST)
Message-Id: <20231208.102842.1616218749853934366.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, aliceryhl@google.com,
 boqun.feng@gmail.com
Subject: Re: [PATCH net-next v9 1/4] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <9d38d6f9-3b54-4a6f-a19d-3710db171fed@proton.me>
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
	<20231205011420.1246000-2-fujita.tomonori@gmail.com>
	<9d38d6f9-3b54-4a6f-a19d-3710db171fed@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 07 Dec 2023 17:25:22 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 12/5/23 02:14, FUJITA Tomonori wrote:
>> @@ -0,0 +1,754 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +// Copyright (C) 2023 FUJITA Tomonori <fujita.tomonori@gmail.com>
>> +
>> +//! Network PHY device.
>> +//!
>> +//! C headers: [`include/linux/phy.h`](../../../../../../../include/linux/phy.h).
>> +
>> +use crate::{bindings, error::*, prelude::*, str::CStr, types::Opaque};
>> +
>> +use core::marker::PhantomData;
>> +
>> +/// PHY state machine states.
>> +///
>> +/// Corresponds to the kernel's [`enum phy_state`].
>> +///
>> +/// Some of PHY drivers access to the state of PHY's software state machine.
> 
> This sentence reads a bit weird, what are you trying to say?

It's copy of the PHY doc. For me, it means that if my PHY driver
doesn't need access to that state, I don't need to know anything about
this enum.


>> +/// [`enum phy_state`]: ../../../../../../../include/linux/phy.h
>> +#[derive(PartialEq, Eq)]
>> +pub enum DeviceState {
>> +    /// PHY device and driver are not ready for anything.
>> +    Down,
>> +    /// PHY is ready to send and receive packets.
>> +    Ready,
>> +    /// PHY is up, but no polling or interrupts are done.
>> +    Halted,
>> +    /// PHY is up, but is in an error state.
>> +    Error,
>> +    /// PHY and attached device are ready to do work.
>> +    Up,
>> +    /// PHY is currently running.
>> +    Running,
>> +    /// PHY is up, but not currently plugged in.
>> +    NoLink,
>> +    /// PHY is performing a cable test.
>> +    CableTest,
> 
> I took a look at `enum phy_state` and found that you only copied the
> first sentence of each state description, why is that?

I thought that the first sentence is enough but I'll copy the full
description if you prefer.


>> +/// A mode of Ethernet communication.
>> +///
>> +/// PHY drivers get duplex information from hardware and update the current state.
> 
> Are you trying to say that the driver automatically queries the
> hardware? You could express this more clearly.

It's the copy from the PHY doc. I assume that it's clear for driver
developers; your driver gets the information from the hardware and
updates the state via the APIs.


>> +pub enum DuplexMode {
>> +    /// PHY is in full-duplex mode.
>> +    Full,
>> +    /// PHY is in half-duplex mode.
>> +    Half,
>> +    /// PHY is in unknown duplex mode.
>> +    Unknown,
>> +}
>> +
>> +/// An instance of a PHY device.
>> +///
>> +/// Wraps the kernel's [`struct phy_device`].
>> +///
>> +/// A [`Device`] instance is created when a callback in [`Driver`] is executed. A PHY driver
>> +/// executes [`Driver`]'s methods during the callback.
>> +///
>> +/// # Invariants
>> +///
>> +/// Referencing a `phy_device` using this struct asserts that you are in
>> +/// a context where all methods defined on this struct are safe to call.
> 
> I know that Alice suggested this, but I reading it now, it sounds a
> bit weird. When reading this it sounds like a requirement for everyone
> using a `Device`. It would be better to phrase it so that it sounds like
> something that users of `Device` can rely upon.

I guess that every reviewer has their preferences. I don't think that
I can write a comment that makes every reviewer fully happy about.

For me, as Alice said, "at least it is correct". 


> Also, I would prefer for this invariant to be a simple one, for example:
> "The mutex of `self.0` is held".
> The only problem with that are the `resume` and `suspend` methods.
> Andrew mentioned that there is some tribal knowledge on this topic, but
> I don't see this written down anywhere here. I can't really suggest an
> improvement to invariant without knowing the whole picture.
> 
>> +/// [`struct phy_device`]: ../../../../../../../include/linux/phy.h
>> +// During the calls to most functions in [`Driver`], the C side (`PHYLIB`) holds a lock that is
>> +// unique for every instance of [`Device`]. `PHYLIB` uses a different serialization technique for
>> +// [`Driver::resume`] and [`Driver::suspend`]: `PHYLIB` updates `phy_device`'s state with
>> +// the lock held, thus guaranteeing that [`Driver::resume`] has exclusive access to the instance.
>> +// [`Driver::resume`] and [`Driver::suspend`] also are called where only one thread can access
>> +// to the instance.
>> +#[repr(transparent)]
>> +pub struct Device(Opaque<bindings::phy_device>);
>> +
>> +impl Device {
>> +    /// Creates a new [`Device`] instance from a raw pointer.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// For the duration of 'a, the pointer must point at a valid `phy_device`,
>> +    /// and the caller must be in a context where all methods defined on this struct
>> +    /// are safe to call.
>> +    unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
>> +        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::phy_device`.
>> +        let ptr = ptr.cast::<Self>();
>> +        // SAFETY: by the function requirements the pointer is valid and we have unique access for
>> +        // the duration of `'a`.
>> +        unsafe { &mut *ptr }
>> +    }
>> +
>> +    /// Gets the id of the PHY.
>> +    pub fn phy_id(&self) -> u32 {
>> +        let phydev = self.0.get();
>> +        // SAFETY: The struct invariant ensures that we may access
>> +        // this field without additional synchronization.
> 
> At the moment the invariant only states that "all functions on
> `Device` are safe to call". It does not say anything about accessing
> fields. I hope this shows why I think the invariant is problematic.

The previous invariant was:

`self.0` is always in a valid state.

https://lore.kernel.org/netdev/20231026001050.1720612-1-fujita.tomonori@gmail.com/T/

It says accessing fields, right? For me, if so, the current invariant
suggested by Alice also says it.

