Return-Path: <netdev+bounces-40962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A197C932C
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 09:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A8B1C2098E
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 07:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29D75398;
	Sat, 14 Oct 2023 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvkvTi0k"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC6E1859;
	Sat, 14 Oct 2023 07:22:13 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114D9BF;
	Sat, 14 Oct 2023 00:22:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bcdfcde944so3031b3a.1;
        Sat, 14 Oct 2023 00:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697268131; x=1697872931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOi00yMEaJtXrhRfufHpSmb0CB2/ovVELYt4hqgAF54=;
        b=gvkvTi0k8C9L+DPD49BW4NyDMz/xH7BNCThcTDXt1L6Oo/GsS5GTV4x19XqKHQUtSP
         cVxszjTiD8hS/tV+AbhHZwvjUym2Z/q8aTi27UCIxBRCrFnBpdQi1zhLGGdc4To+1JW3
         zNMqMKRag/+ubu5s7FYuRyGglJfD4qBbo7kNI4ZRYQCYqhL8nDOT4DVAEZyCTHg1vQvM
         nbeqmAweS/PsTk/1mMaPDMo1jLZg/urqyh1gmNA3J8l/o4kuaQh0T4osZCxRmSggnFB9
         mQ9eUm+RpFesi4ZaVMOGAtYalkGxa0fpS8eaLLWxAxCvONPGPcWmXYejubZPAZJb5dNw
         fFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697268131; x=1697872931;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MOi00yMEaJtXrhRfufHpSmb0CB2/ovVELYt4hqgAF54=;
        b=Rmq1NQzvupgZpjW6HIHLQMxl6fuqsbdXczCZq/aszMfuqbG5+3pyMqfVoIV+Qd3fmZ
         hIz1lAA+6MWf1VkvgQ1J/0zC1Hr2AIUsSwQDCeonDopZ/v3hbPCrDQyKtZLjwHZj5pxx
         LqBHkUPG3C4iQVjMSiatQeXn+qeQfbftVK51JVGW3CDaIeUxCqEAKHcWaPyU+TicpfN2
         +BiqepHNG2trfxFDoeqBltVJH8cGW5cWJQKmXnLCRZlsf2pZ0hwFMVUsrLkmDCQ+hOc2
         2vfZO+SFG7FKSq/NYkNiUh1TVpQtXbKa7ndNB36Px8V9rDUfuGkNoxo9J2Nj9SqWhDO7
         JPwg==
X-Gm-Message-State: AOJu0YyA/7CpxT1p4xOqyr5Uoe06gVsz86grAQtuSExJjxSSA8VSUXfC
	HE2fqi2ycOSQwXbCHQwyVykh6chP58cRUAiH
X-Google-Smtp-Source: AGHT+IEF8nd/3nKIYkQ/FpmuoCeckzuK2tGiIEvVaCKWjc5cIdPRtqd2z5K8yptWHxrFPrJVKlk9cg==
X-Received: by 2002:a05:6a20:1595:b0:163:ab09:195d with SMTP id h21-20020a056a20159500b00163ab09195dmr32894916pzj.0.1697268131077;
        Sat, 14 Oct 2023 00:22:11 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id hg20-20020a17090b301400b002776350b50dsm1135710pjb.29.2023.10.14.00.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 00:22:10 -0700 (PDT)
Date: Sat, 14 Oct 2023 16:22:10 +0900 (JST)
Message-Id: <20231014.162210.522439670437191285.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <85d5c498-efbc-4c1a-8d12-f1eca63c45cf@proton.me>
References: <20231012125349.2702474-1-fujita.tomonori@gmail.com>
	<20231012125349.2702474-2-fujita.tomonori@gmail.com>
	<85d5c498-efbc-4c1a-8d12-f1eca63c45cf@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 13 Oct 2023 21:31:16 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

>> +/// An instance of a PHY device.
>> +///
>> +/// Wraps the kernel's `struct phy_device`.
>> +///
>> +/// # Invariants
>> +///
>> +/// `self.0` is always in a valid state.
>> +#[repr(transparent)]
>> +pub struct Device(Opaque<bindings::phy_device>);
>> +
>> +impl Device {
>> +    /// Creates a new [`Device`] instance from a raw pointer.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// This function can be called only in the callbacks in `phy_driver`. PHYLIB guarantees
> 
> "can be called in" -> "must only be called from"

Fixed.

>> +    /// the exclusive access for the duration of the lifetime `'a`.
> 
> In some other thread you mentioned that no lock is held for
> `resume`/`suspend`, how does this interact with it?

The same quesiton, 4th time? 

PHYLIB is implemented in a way that PHY drivers exlusively access to
phy_device during the callbacks.


>> +    unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
>> +        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
>> +        // `Device` type being transparent makes the cast ok.
>> +        unsafe { &mut *ptr.cast() }
> 
> please refactor to
> 
>      // CAST: ...
>      let ptr = ptr.cast::<Self>();
>      // SAFETY: ...
>      unsafe { &mut *ptr }

I can but please tell the exactly comments for after CAST and SAFETY.

I can't find the description of CAST comment in
Documentation/rust/coding-guidelines.rst. So please add why and how to
avoid repeating the same review comment in the future.


>> +    /// Returns true if auto-negotiation is completed.
>> +    pub fn is_autoneg_completed(&self) -> bool {
>> +        const AUTONEG_COMPLETED: u32 = 1;
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        let phydev = unsafe { *self.0.get() };
>> +        phydev.autoneg_complete() == AUTONEG_COMPLETED
>> +    }
>> +
>> +    /// Sets the speed of the PHY.
>> +    pub fn set_speed(&self, speed: u32) {
> 
> This function modifies state, but is `&self`?

Boqun asked me to drop mut on v3 review and then you ask why on v4?
Trying to find a way to discourage developpers to write Rust
abstractions? :)

I would recommend the Rust reviewers to make sure that such would
not happen. I really appreciate comments but inconsistent reviewing is
painful.


>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        let mut phydev = unsafe { *self.0.get() };
>> +        phydev.speed = speed as i32;
>> +    }
>> +
>> +    /// Sets duplex mode.
>> +    pub fn set_duplex(&self, mode: DuplexMode) {
> 
> This function modifies state, but is `&self`?

Ditto.


>> +        let v = match mode {
>> +            DuplexMode::Full => bindings::DUPLEX_FULL as i32,
>> +            DuplexMode::Half => bindings::DUPLEX_HALF as i32,
>> +            DuplexMode::Unknown => bindings::DUPLEX_UNKNOWN as i32,
>> +        };
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        let mut phydev = unsafe { *self.0.get() };
>> +        phydev.duplex = v;
> 
> Note that this piece of code will actually not do the correct thing. It
> will create a copy of `phydev` on the stack and modify that instead of the
> pointee of `self`. I think the code was fine before this change.

Oops, reverted.


>> +    /// Writes a given C22 PHY register.
>> +    pub fn write(&self, regnum: u16, val: u16) -> Result {
> 
> This should probably be `&mut self`, but not sure.

Please discuss with Boqun what should be.


>> +        let phydev = self.0.get();
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        // So an FFI call with a valid pointer.
>> +        to_result(unsafe {
>> +            bindings::mdiobus_write((*phydev).mdio.bus, (*phydev).mdio.addr, regnum.into(), val)
>> +        })
>> +    }
>> +
>> +    /// Reads a paged register.
>> +    pub fn read_paged(&self, page: u16, regnum: u16) -> Result<u16> {
> 
> Again same question (also for all other functions below that call the C
> side).

Ditto (also for all other functions below that call the C side).


>> +        let phydev = self.0.get();
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        // So an FFI call with a valid pointer.
>> +        let ret = unsafe { bindings::phy_read_paged(phydev, page.into(), regnum.into()) };
>> +        if ret < 0 {
>> +            Err(Error::from_errno(ret))
>> +        } else {
>> +            Ok(ret as u16)
>> +        }
>> +    }
> 
> [...]
> 
>> +}
>> +
>> +/// Defines certain other features this PHY supports (like interrupts).
> 
> Maybe add a link where these flags can be used.

I already put the link to here in trait Driver.


>> +pub mod flags {
>> +    /// PHY is internal.
>> +    pub const IS_INTERNAL: u32 = bindings::PHY_IS_INTERNAL;
>> +    /// PHY needs to be reset after the refclk is enabled.
>> +    pub const RST_AFTER_CLK_EN: u32 = bindings::PHY_RST_AFTER_CLK_EN;
>> +    /// Polling is used to detect PHY status changes.
>> +    pub const POLL_CABLE_TEST: u32 = bindings::PHY_POLL_CABLE_TEST;
>> +    /// Don't suspend.
>> +    pub const ALWAYS_CALL_SUSPEND: u32 = bindings::PHY_ALWAYS_CALL_SUSPEND;
>> +}
> 
> [...]
> 
>> +
>> +/// Corresponds to functions in `struct phy_driver`.
>> +///
>> +/// This is used to register a PHY driver.
>> +#[vtable]
>> +pub trait Driver {
>> +    /// Defines certain other features this PHY supports.
>> +    /// It is a combination of the flags in the [`flags`] module.
>> +    const FLAGS: u32 = 0;
> 
> What would happen if I set this to some value that is not a combination of
> the flag values above? I expect that bits that are not part of the flag
> values above to be ignored.

Your expectation is correct.


>> +    /// The friendly name of this PHY type.
>> +    const NAME: &'static CStr;
>> +
>> +    /// This driver only works for PHYs with IDs which match this field.
> 
> Mention that the default value is 0.

Done.


>> +    const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_custom_mask(0, 0);
> 
> [...]
> 
>> +}
>> +
>> +/// Registration structure for a PHY driver.
>> +///
>> +/// # Invariants
>> +///
>> +/// All elements of the `drivers` slice are valid and currently registered
>> +/// to the kernel via `phy_drivers_register`.
> 
> Since `DriverType` is now safe a wrapper type, this invariant should be
> moved to that type instead.

Understood.


>> +pub struct Registration {
>> +    drivers: &'static [DriverType],
>> +}
>> +
>> +impl Registration {
>> +    /// Registers a PHY driver.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The values of the `drivers` array must be initialized properly.
> 
> With the above change you do not need this (since all instances of
> `DriverType` are always initialized). But I am not sure if it would be

Nice.


> fine to call `phy_driver_register` multiple times with the same driver
> without unregistering it first.

The second call `phy_driver_register` with the same drivers (without
unregistered) returns an error. You don't need to worry.


>> +    /// Get a `mask` as u32.
>> +    pub const fn mask_as_int(&self) -> u32 {
>> +        self.mask.as_int()
>> +    }
>> +
>> +    // macro use only
>> +    #[doc(hidden)]
>> +    pub const fn as_mdio_device_id(&self) -> bindings::mdio_device_id {
> 
> I would name this just `mdio_device_id`.

Either is fine by me. Please tell me why for future reference.

