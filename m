Return-Path: <netdev+bounces-44059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE277D5F63
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 03:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEDAD1C20CCC
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CC31369;
	Wed, 25 Oct 2023 01:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHK7FWUx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5E41386;
	Wed, 25 Oct 2023 01:10:50 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6095128;
	Tue, 24 Oct 2023 18:10:48 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ca3c63d7f0so3720405ad.1;
        Tue, 24 Oct 2023 18:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698196248; x=1698801048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8VsaG1wKGdFyl+TUgEaSdhXE2Oopz1FxFnSoh/fLtY=;
        b=DHK7FWUxbBSJEKuO80CaPCsLAHaQpRz5ysglhfq4+29sjV6RctIzx7C/0dNBA9asNc
         ZjfGB2Gxb3fjhr6Q+AeB6WAs8jJOYKKXEFrftIR8Z/nZSJFOc+3sG3j+htGwNxZgxKD2
         Tyy1HrRFEkiY7o1cEW5qBlwRzDLAz+x2dRfz1aKNKkPg5QVsX7vb3cdiecMm76yUFRRk
         ZVHoDgIYY6OhQd2fdyzdrzDI9CKHgQcE2/6kr4kLbP8zxpO0KOfUeC2Tqw/SDwkLmG6C
         vv8W1mskb/w/75V770NEfY8UgJBgu/iSMuADIY8PTws1nzI/kzkZ4vRNNBgpvICgPueI
         OABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698196248; x=1698801048;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I8VsaG1wKGdFyl+TUgEaSdhXE2Oopz1FxFnSoh/fLtY=;
        b=xM6Gp27mLoQw8+g8Qy7RgXowco0EHx8QuSZ32sOJHEBnasDN63voS4Ipg/GSAvOtvT
         5qAMEM2dPPjvDkvmgfMCkDaxbD+oVEgFblvBRcgMhEeN2F92t/Q6IwfO7jSyLa7gJaVX
         mwXEXJxS5g3YTnMkj5bdQBuJr8C06s92oEAeVjAranBD2RRTeeLttOcq3anRG0HWtgXe
         TybpMc1bShvHub4A5/tQuDfCtqRXRzyD6ecJ5jquPz0HpZLkqateW9Gd1ZBAXKofh0NU
         bjZWjRGBAubsI37UULZPizOtwixa6GkjHGtf3evRTZ8PNdTiefxu27V/869s6qTFHmRc
         bvNw==
X-Gm-Message-State: AOJu0YzOi+SER8rajBN4TiEpzNWp9iuxmDMomiCumSaAhmmminM4R34M
	R6CRnayBqBS7W2dhJUEBosY=
X-Google-Smtp-Source: AGHT+IFKKaTURKwmieMtxz02OWk4MaUAsC/cpidlOIBJwmFZ8raUk7tnWac/Ki9j83ZlJkM2JnGaXg==
X-Received: by 2002:a17:902:654d:b0:1ca:273d:22f with SMTP id d13-20020a170902654d00b001ca273d022fmr13136929pln.0.1698196247868;
        Tue, 24 Oct 2023 18:10:47 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id jh1-20020a170903328100b001c55e13bf2asm8004560plb.283.2023.10.24.18.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 18:10:47 -0700 (PDT)
Date: Wed, 25 Oct 2023 10:10:46 +0900 (JST)
Message-Id: <20231025.101046.1989690650451477174.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v6 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <1f61dda0-1e5e-4cdb-991b-1107439ecc99@proton.me>
References: <20231024005842.1059620-1-fujita.tomonori@gmail.com>
	<20231024005842.1059620-2-fujita.tomonori@gmail.com>
	<1f61dda0-1e5e-4cdb-991b-1107439ecc99@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 16:23:20 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 24.10.23 02:58, FUJITA Tomonori wrote:
>> This patch adds abstractions to implement network PHY drivers; the
>> driver registration and bindings for some of callback functions in
>> struct phy_driver and many genphy_ functions.
>> 
>> This feature is enabled with CONFIG_RUST_PHYLIB_ABSTRACTIONS=y.
>> 
>> This patch enables unstable const_maybe_uninit_zeroed feature for
>> kernel crate to enable unsafe code to handle a constant value with
>> uninitialized data. With the feature, the abstractions can initialize
>> a phy_driver structure with zero easily; instead of initializing all
>> the members by hand. It's supposed to be stable in the not so distant
>> future.
>> 
>> Link: https://github.com/rust-lang/rust/pull/116218
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> [...]
> 
>> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
>> new file mode 100644
>> index 000000000000..2d821c2475e1
>> --- /dev/null
>> +++ b/rust/kernel/net/phy.rs
>> @@ -0,0 +1,708 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +// Copyright (C) 2023 FUJITA Tomonori <fujita.tomonori@gmail.com>
>> +
>> +//! Network PHY device.
>> +//!
>> +//! C headers: [`include/linux/phy.h`](../../../../include/linux/phy.h).
>> +
>> +use crate::{
>> +    bindings,
>> +    error::*,
>> +    prelude::{vtable, Pin},
>> +    str::CStr,
>> +    types::Opaque,
>> +};
>> +use core::marker::PhantomData;
>> +
>> +/// PHY state machine states.
>> +///
>> +/// Corresponds to the kernel's [`enum phy_state`](https://docs.kernel.org/networking/kapi.html#c.phy_state).
> 
> Please use `rustfmt`, this line is 109 characters long.

Hmm, `make rustfmt` doesn't warn on my env. `make rustfmtcheck` or
`make rustdoc` doesn't.

What's the limit?


> Also it might make sense to use a relative link, since then it also
> works offline (though you have to build the C docs).

/// Corresponds to the kernel's [`enum phy_state`](../../../../../networking/kapi.html#c.phy_state).

101 characters too long?

Then we could write:

/// PHY state machine states.
///
/// Corresponds to the kernel's
/// [`enum phy_state`](../../../../../networking/kapi.html#c.phy_state).
///
/// Some of PHY drivers access to the state of PHY's software state machine.


>> +    /// Gets the current link state. It returns true if the link is up.
>> +    pub fn get_link(&self) -> bool {
>> +        const LINK_IS_UP: u32 = 1;
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        let phydev = unsafe { *self.0.get() };
>> +        phydev.link() == LINK_IS_UP
>> +    }
> 
> Can we please change this name? I think Tomo is waiting for Andrew to
> give his OK. All the other getter functions already follow the Rust
> naming convention, so this one should as well. I think using
> `is_link_up` would be ideal, since `link()` reads a bit weird in code:
> 
>      if dev.link() {
>          // ...
>      }
> 
> vs
> 
>      if dev.is_link_up() {
>          // ...
>      }

I'll go with is_link_up()


>> +    /// Gets the current auto-negotiation configuration. It returns true if auto-negotiation is enabled.
> 
> Move the second sentence into a new line, it should not be part of the
> one-line summary.

Oops, make one-line? 

/// Gets the current auto-negotiation configuration and returns true if auto-negotiation is enabled.

Or

/// Gets the current auto-negotiation configuration.
///
/// It returns true if auto-negotiation is enabled.

>> +    pub fn is_autoneg_enabled(&self) -> bool {
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        let phydev = unsafe { *self.0.get() };
>> +        phydev.autoneg() == bindings::AUTONEG_ENABLE
>> +    }
>> +
>> +    /// Gets the current auto-negotiation state. It returns true if auto-negotiation is completed.
> Same here.
> 
> --
> Cheers,
> Benno
> 
>> +    pub fn is_autoneg_completed(&self) -> bool {
>> +        const AUTONEG_COMPLETED: u32 = 1;
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        let phydev = unsafe { *self.0.get() };
>> +        phydev.autoneg_complete() == AUTONEG_COMPLETED
>> +    }
> [...]
> 
> 

