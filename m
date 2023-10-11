Return-Path: <netdev+bounces-40021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B07DE7C567E
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3FB81C20E0C
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FABF20324;
	Wed, 11 Oct 2023 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ge+eqSnV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EA820325;
	Wed, 11 Oct 2023 14:16:13 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9211BCF;
	Wed, 11 Oct 2023 07:16:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-692af7b641cso1242599b3a.1;
        Wed, 11 Oct 2023 07:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697033768; x=1697638568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7bq7R0jS1gakQ6odYWB7+KjbWCzk7tjw1A7qKItlgU=;
        b=Ge+eqSnVw+9DAA42BbmWOGp/+7njhst0mOaAzfAYDWq4scqxA5JPhGAQbbg1N1QAvx
         RrFWkQWoznUq/RNJ3+xYBPdgNYDv/I/WBo8u8HFbR15g74jnvDQisG0v7qBNCTAgOL/V
         yEp6OzI+H4fRqE9LnqqfsvzSkbJ0OpqRVrhDQwe/n5+5w3/vrAVVwRFU5WF75h5xwsSA
         vCX6rAUp2HyAFvFnaFP1BDLZ8yeUkfq0rnV88xmUEZYuXpq9fVCVXduTdXGd/4U4V2Qm
         n33JqFgk66EU0htqED4/hFuHyvI7gDIQCt/eE2xxYKsuaPoc9tr+aQk6Viohs+Qh4VFj
         2nDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697033768; x=1697638568;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E7bq7R0jS1gakQ6odYWB7+KjbWCzk7tjw1A7qKItlgU=;
        b=Y+OHa4za2mKd2yhgxcvaQVX5k7VdOn3BmkEK60rg4jGzlhpI66Q75b+/AgY93oJjrr
         zVsF2rhmttxt/n8GZ+UXZRQ5xJXKp9gM5hNXXjLiMH5hZ/8O8Ex91ddHyjuvh/ub3AY0
         k+UExcAwAcOqQg/8FJqai46+zmhMyfJ8TYdPb1ayUGIx3xviA15YryGDNhR7dpsOG14P
         NCZPK1DOci5y/wkMeb+6MPqCe31UHSeKkf1vY35KZF5JLjJm4wCZUd76ftVTomwXM7iA
         aRPiswmQbgpNDrhBWlfu3JzXcU9Jasm6egAmnBPehLR8+LzvWXt17R59vX2mgWpIDJAI
         RU3w==
X-Gm-Message-State: AOJu0Yz+sNH3vqope8WhcIzciC0fprdTUOqFHFoOBBhAt5nPGypSfa8B
	x970W9LIM5fsC61CUyt1bA71yfxx2Y6Ihokj
X-Google-Smtp-Source: AGHT+IG8HMOl7n1DunhTAX9+zRfsP6NCJQypLkpmLCbNEc5A2fsS1FK8C0PrczQTLXrEAOxkySuhgw==
X-Received: by 2002:a05:6a20:a123:b0:13f:65ca:52a2 with SMTP id q35-20020a056a20a12300b0013f65ca52a2mr24054272pzk.5.1697033768319;
        Wed, 11 Oct 2023 07:16:08 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id ev7-20020a17090aeac700b00274922d4b38sm12150470pjb.27.2023.10.11.07.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:16:08 -0700 (PDT)
Date: Wed, 11 Oct 2023 23:16:07 +0900 (JST)
Message-Id: <20231011.231607.1747074555988728415.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <1aea7ddb-73b7-8228-161e-e2e4ff5bc98d@proton.me>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
	<20231009013912.4048593-2-fujita.tomonori@gmail.com>
	<1aea7ddb-73b7-8228-161e-e2e4ff5bc98d@proton.me>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 09 Oct 2023 12:19:54 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

I skipped the topics that you've already discussed with Andrew.

> On 09.10.23 03:39, FUJITA Tomonori wrote:
>> This patch adds abstractions to implement network PHY drivers; the
>> driver registration and bindings for some of callback functions in
>> struct phy_driver and many genphy_ functions.
>> 
>> This feature is enabled with CONFIG_RUST_PHYLIB_BINDINGS.
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> ---
>>   init/Kconfig                    |   8 +
>>   rust/Makefile                   |   1 +
>>   rust/bindings/bindings_helper.h |   3 +
>>   rust/kernel/lib.rs              |   3 +
>>   rust/kernel/net.rs              |   6 +
>>   rust/kernel/net/phy.rs          | 733 ++++++++++++++++++++++++++++++++
>>   6 files changed, 754 insertions(+)
>>   create mode 100644 rust/kernel/net.rs
>>   create mode 100644 rust/kernel/net/phy.rs

(snip)

>> +impl Device {
>> +    /// Creates a new [`Device`] instance from a raw pointer.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// For the duration of the lifetime 'a, the pointer must be valid for writing and nobody else
>> +    /// may read or write to the `phy_device` object.
>> +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
>> +        unsafe { &mut *ptr.cast() }
> 
> Missing `SAFETY` comment.

Added:

// SAFETY: The safety requirements guarantee the validity of the dereference, while the
// `Device` type being transparent makes the cast ok.


>> +    /// Gets the id of the PHY.
>> +    pub fn phy_id(&mut self) -> u32 {
>> +        let phydev = self.0.get();
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        unsafe { (*phydev).phy_id }
>> +    }
>> +
>> +    /// Gets the state of the PHY.
>> +    pub fn state(&mut self) -> DeviceState {
>> +        let phydev = self.0.get();
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        let state = unsafe { (*phydev).state };
>> +        // FIXME: enum-cast
>> +        match state {
>> +            bindings::phy_state::PHY_DOWN => DeviceState::Down,
>> +            bindings::phy_state::PHY_READY => DeviceState::Ready,
>> +            bindings::phy_state::PHY_HALTED => DeviceState::Halted,
>> +            bindings::phy_state::PHY_ERROR => DeviceState::Error,
>> +            bindings::phy_state::PHY_UP => DeviceState::Up,
>> +            bindings::phy_state::PHY_RUNNING => DeviceState::Running,
>> +            bindings::phy_state::PHY_NOLINK => DeviceState::NoLink,
>> +            bindings::phy_state::PHY_CABLETEST => DeviceState::CableTest,
>> +        }
>> +    }
>> +
>> +    /// Returns true if the link is up.
>> +    pub fn get_link(&mut self) -> bool {
> 
> I would call this function `is_link_up`.
> 
>> +        const LINK_IS_UP: u32 = 1;
>> +        let phydev = self.0.get();
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        unsafe { (*phydev).link() == LINK_IS_UP }
> 
> Can you move the call to `link` and the `==` operation out
> of the `unsafe` block? They are safe operations. (also do
> that below where possible)

Sure, fixed.


>> +/// Creates the kernel's `phy_driver` instance.
>> +///
>> +/// This is used by [`module_phy_driver`] macro to create a static array of phy_driver`.
> 
> Missing '`'.

Fixed.


>> +/// Registration structure for a PHY driver.
>> +///
>> +/// # Invariants
>> +///
>> +/// The `drivers` points to an array of `struct phy_driver`, which is
>> +/// registered to the kernel via `phy_drivers_register`.
> 
> Since it is a reference you do not need to explicitly state
> that it points to an array of `struct phy_driver`. Instead I would
> suggest the following invariant:
> 
> All elements of the `drivers` slice are valid and currently registered
> to the kernel via `phy_drivers_register`.

Surely, makes sense. 


>> +pub struct Registration {
>> +    drivers: Option<&'static [Opaque<bindings::phy_driver>]>,
> 
> Why is this an `Option`?

Oops, removed; leftover of older version.


>> +}
>> +
>> +impl Registration {
>> +    /// Registers a PHY driver.
>> +    #[must_use]
>> +    pub fn register(
>> +        module: &'static crate::ThisModule,
>> +        drivers: &'static [Opaque<bindings::phy_driver>],
>> +    ) -> Result<Self> {
>> +        if drivers.len() == 0 {
>> +            return Err(code::EINVAL);
>> +        }
>> +        // SAFETY: `drivers` has static lifetime and used only in the C side.
>> +        to_result(unsafe {
>> +            bindings::phy_drivers_register(drivers[0].get(), drivers.len() as i32, module.0)
>> +        })?;
> 
> This `register` function seems to assume that the values of the
> `drivers` array are initialized and otherwise also considered valid.
> So please change that or make this function `unsafe`.

Understood.


>> +        Ok(Registration {
> 
> Please add an `INVARIANT` comment similar to a `SAFETY` comment
> that explains why the invariant is upheld.

Added.


>> +#[macro_export]
>> +macro_rules! module_phy_driver {
>> +    (@replace_expr $_t:tt $sub:expr) => {$sub};
>> +
>> +    (@count_devices $($x:expr),*) => {
>> +        0usize $(+ $crate::module_phy_driver!(@replace_expr $x 1usize))*
>> +    };
>> +
>> +    (@device_table [$($dev:expr),+]) => {
>> +        #[no_mangle]
>> +        static __mod_mdio__phydev_device_table: [
> 
> Shouldn't this have a unique name? If we define two different
> phy drivers with this macro we would have a symbol collision?
> 
>> +            kernel::bindings::mdio_device_id;
> 
> Please use absolute paths in macros:
> `::kernel::bindings::mdio_device_id` (also below).

Updated.


>> +            $crate::module_phy_driver!(@count_devices $($dev),+) + 1
>> +        ] = [
>> +            $(kernel::bindings::mdio_device_id {
>> +                phy_id: $dev.id,
>> +                phy_id_mask: $dev.mask_as_int()
>> +            }),+,
>> +            kernel::bindings::mdio_device_id {
>> +                phy_id: 0,
>> +                phy_id_mask: 0
>> +            }
>> +        ];
>> +    };
>> +
>> +    (drivers: [$($driver:ident),+], device_table: [$($dev:expr),+], $($f:tt)*) => {
>> +        struct Module {
>> +            _reg: kernel::net::phy::Registration,
>> +        }
>> +
>> +        $crate::prelude::module! {
>> +             type: Module,
>> +             $($f)*
>> +        }
>> +
>> +        static mut DRIVERS: [
>> +            kernel::types::Opaque<kernel::bindings::phy_driver>;
>> +            $crate::module_phy_driver!(@count_devices $($driver),+)
>> +        ] = [
>> +            $(kernel::net::phy::create_phy_driver::<$driver>()),+
>> +        ];
>> +
>> +        impl kernel::Module for Module {
>> +            fn init(module: &'static ThisModule) -> Result<Self> {
>> +                // SAFETY: static `DRIVERS` array is used only in the C side.
> 
> In order for this SAFETY comment to be correct, you need to ensure
> that nobody else can access the `DRIVERS` static. You can do that by
> placing both the `static mut DRIVERS` and the `impl ::kernel::Module
> for Module` items inside of a `const _: () = {}`, so like this:
> 
>      const _: () = {
>          static mut DRIVERS: [...] = ...;
>          impl ::kernel::Module for Module { ... }
>      };
> 
> You can also mention this in the SAFETY comment.

Great, that's exactly what to be needed here. Thanks a lot!

