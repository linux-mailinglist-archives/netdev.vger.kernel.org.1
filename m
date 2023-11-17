Return-Path: <netdev+bounces-48601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F617EEED1
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513FD2812B0
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5621548D;
	Fri, 17 Nov 2023 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1sTyn8Co"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EE9D4E
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:39:06 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a828bdcfbaso28535317b3.2
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700213945; x=1700818745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8uh/1N+tGpZdyYYLem5NQUA0RzoK2GeeFDzKLPiN8o=;
        b=1sTyn8CoYXFBhab9awtossnzDuH8n6i5YokbNR2q1TRbwhFEQnXVUidMzTo4+Iz40U
         WSieg9U9QrXWC59B9NlfGS22S3Drj/3jb8B4/JVGmUqjFkbCSs+8qkJ7i3Mca0qaVUiA
         pMImzlC1UQbE1lJ1GB+RNCO4S2AY1FzBxKnkp/53n7Q678TU/wCsQTM4QpzY0t+VVemo
         7R4LBW8fp7hX80WmwrCZxiPfQaUqK1rpGLNLMAKAUyArj/zLP8dF2adA7QXXVmlHVNMx
         C1YSo9V64vIuMeduYE7FIh2jL8xHr1Bv9pUafppQhBlVuXnS8liO0uRY0uj1jpE59z2m
         piCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700213945; x=1700818745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8uh/1N+tGpZdyYYLem5NQUA0RzoK2GeeFDzKLPiN8o=;
        b=ekw9zRi5xf/GvFjZUTl55eswLRSHBSJKukEZdM8EMAP4aGcXX0ZiGukYYe73Tc6PBb
         DtESywOSbIhEgk9Th30TMvOrtzVXMN+nejXYYS1FGSgDrcNZsqTg84IuJohUOiPJet4V
         gY8B+NG4lmXyCp6oUj6C7ZAyKnSx/j+sX0Qbe4jPb9TUj4nFEedhv9c1Ie5xYUSO0uZZ
         vbWXIeSg0cT8QkDDYO4SFLSZi4Dt7cgGwQhUEH1+VJH5mOg5cPkt7pdpLE9EuDjojGEk
         pUJayTfLMGjNmn0398ZQavcK1u0TZ+IIb0kVPjSE0oufq6u+dcKDuggMplPihzbikN9Y
         VRJA==
X-Gm-Message-State: AOJu0Ywkk8/eOv55XRYyXlMxZz9MalxTQzFeQhAh67CB129uFrJLKrCK
	7ta8cLHfLsjGtAG8xmhf0g2k4pVpH5Dl2Pk=
X-Google-Smtp-Source: AGHT+IHkqIXq7+Zj+gED8zOASIYbuaF5VQEeDHm9lNOkZoLOGVYm0Gmi0uphUL15OmVFDmSbz7r0W+C1B3Fi61Q=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a81:6d02:0:b0:5be:a164:566d with SMTP id
 i2-20020a816d02000000b005bea164566dmr484689ywc.1.1700213945524; Fri, 17 Nov
 2023 01:39:05 -0800 (PST)
Date: Fri, 17 Nov 2023 09:39:03 +0000
In-Reply-To: <20231026001050.1720612-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231026001050.1720612-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231117093903.2514513-1-aliceryhl@google.com>
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY drivers
From: Alice Ryhl <aliceryhl@google.com>
To: fujita.tomonori@gmail.com
Cc: andrew@lunn.ch, benno.lossin@proton.me, miguel.ojeda.sandonis@gmail.com, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"

FUJITA Tomonori <fujita.tomonori@gmail.com> writes:
> This patch adds abstractions to implement network PHY drivers; the
> driver registration and bindings for some of callback functions in
> struct phy_driver and many genphy_ functions.
> 
> This feature is enabled with CONFIG_RUST_PHYLIB_ABSTRACTIONS=y.
> 
> This patch enables unstable const_maybe_uninit_zeroed feature for
> kernel crate to enable unsafe code to handle a constant value with
> uninitialized data. With the feature, the abstractions can initialize
> a phy_driver structure with zero easily; instead of initializing all
> the members by hand. It's supposed to be stable in the not so distant
> future.
> 
> Link: https://github.com/rust-lang/rust/pull/116218
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

I promised Andrew to take a look at these patches at Plumbers. This
email contains the first part of my review.

In this email, I will bring up the question of how the safety comments
should be worded. I know that you've probably discussed this before, but
my opinion was asked for, and this is the main area where I think
there's room for improvement.

> +    /// # Safety
> +    ///
> +    /// This function must only be called from the callbacks in `phy_driver`.
> +    unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {

This kind of safety comment where you say "must only be used by internal
code and nothing else" isn't great. It doesn't really help with checking
the correctness. It's usually better to document what is actually
required here, even if it shouldn't be called by non-internal code. I
recommend something along the lines of:

	# Safety
	
	For the duration of 'a, the pointer must point at a valid `phy_device`,
	and the caller must hold the X mutex.

Then in methods like this: (which are missing justification for why
there's no data race!)
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> +        unsafe { (*phydev).phy_id }
you instead say:

	SAFETY: By the struct invariants, `phydev` points at a valid
	`phy_device`, and we hold the X lock, which gives us access to
	the `phy_id` field.

And you would also update the struct invariant accordingly:

/// # Invariants
///
/// Referencing a `phy_device` using this struct asserts that the X
/// mutex is held.
#[repr(transparent)]
pub struct Device(Opaque<bindings::phy_device>);





> +// During the calls to most functions in [`Driver`], the C side (`PHYLIB`) holds a lock that is
> +// unique for every instance of [`Device`]. `PHYLIB` uses a different serialization technique for
> +// [`Driver::resume`] and [`Driver::suspend`]: `PHYLIB` updates `phy_device`'s state with
> +// the lock held, thus guaranteeing that [`Driver::resume`] has exclusive access to the instance.
> +// [`Driver::resume`] and [`Driver::suspend`] also are called where only one thread can access
> +// to the instance.

I used "X mutex" as an example for the synchronization mechanism in the
above snippets, but it sounds like its more complicated than that? Here
are some possible alternatives I could come up with:

Maybe we don't need synchronization when some operations can't happen?

/// # Invariants
///
/// Referencing a `phy_device` using this struct asserts that the X
/// mutex is held, or that there are no concurrent operations of type Y.
#[repr(transparent)]
pub struct Device(Opaque<bindings::phy_device>);

Maybe we have a separate case for when the device is being initialized
and nobody else has access yet?

/// # Invariants
///
/// Referencing a `phy_device` using this struct asserts that the X
/// mutex is held, or that the reference has exclusive access to the
/// entire `phy_device`.
#[repr(transparent)]
pub struct Device(Opaque<bindings::phy_device>);

Maybe it is easier to just list the fields we need access to?

/// # Invariants
///
/// Referencing a `phy_device` using this struct asserts exclusive
/// access to the following fields: phy_id, state, speed, duplex. And
/// read access to the following fields: link, autoneg_complete,
/// autoneg.
#[repr(transparent)]
pub struct Device(Opaque<bindings::phy_device>);

Perhaps we want to avoid duplication with some existing C documentation?

/// # Invariants
///
/// Referencing a `phy_device` using this struct asserts that the user
/// is inside a Y scope as defined in Documentation/foo/bar.
#[repr(transparent)]
pub struct Device(Opaque<bindings::phy_device>);

But I don't know how these things are actually synchronized. Maybe
it is some sixth option. I would be happy to help draft these safety
comments once the actual synchronization mechanism is clear to me.

Or maybe you prefer to not do it this way, or to punt it for a later
patch series. I prefer to document these things in the above way, but
ultimately it is not up to me.

Alice


