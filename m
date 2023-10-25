Return-Path: <netdev+bounces-44048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C16A7D5EED
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 02:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341DE281BE0
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 00:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD487E2;
	Wed, 25 Oct 2023 00:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIweEYBh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893A72909;
	Wed, 25 Oct 2023 00:02:49 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F292DA;
	Tue, 24 Oct 2023 17:02:45 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6bcbfecf314so1080450b3a.1;
        Tue, 24 Oct 2023 17:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698192164; x=1698796964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKXYRj+plrKzQKjbCKs5zOy4joHAux8MW+g+eW9+NN4=;
        b=AIweEYBhm59KjmljHnp39v/iIQByc0wuzgI7CWK3/qj/vuUmbCXCtCu2RjYkecrPqN
         GsLqrfSTFwgJ5ZUtCZWmcEJqQ/VaE6E5ZgodPFBUL78KZJzfzsjrhX9GgOtgG6px7uf4
         qBSBXWdtkxmXoA7SlPh6b5vcX18XRojbOpkSeH9lA/jJdcQ2PJ5Q30W5C+zd9W6G1WI6
         vGG/3phwv8UmH7DCWYy4dyAO64abVdC0/SIcrW5GyPiNhHM05Ftm8ncXE8FQkNsbf2Hu
         hhLfmLUbQK/g3SFbLdisazPKYOwUTRfPKn9cnknlXxC1PoSm7ANJ9cvPTTnU33H7NIG1
         lMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698192164; x=1698796964;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iKXYRj+plrKzQKjbCKs5zOy4joHAux8MW+g+eW9+NN4=;
        b=ZeG1QxAyxHnsF+COGzekvzfDadjbjn5ntGKCEfjsQxCCBJbPszy7alRpL0QwMX9F4z
         A986gp065P0C7DIy0fBrrTQlgSiCzy3buGqJY1zdNgPrctQKE4jeXtxVuh4FswfLAq+v
         KbI9lYPXPjrKrH7TlTaVn8yr9GYPizVgKlREaYRChN6E3RI2tmC84HPMEOGgt/kk/9eW
         J1DQXXJdyNu1VK5ZVCXainFtys+xbBX7+eHXV7w6SFQX91fq1rljonNLtvEdXAo9u1rQ
         /jUoSGMLhUTZzd7i4pPRiMDmu7FgH+Iai0jxLyxeMWiyrnPPNoM0ZAQy9FDMs9HN9gO8
         ykmA==
X-Gm-Message-State: AOJu0Yzgj9f62Nt6CiEpBuVYiTkdxfz7/YfBjFHAfK5Ezf6gmFzlqpKm
	8JRumuzNktZX0HN2QUxOzTw=
X-Google-Smtp-Source: AGHT+IH2tJH7hm3pPDGwPhv6OkIAT0W1oxeOJ7re+s6wKYXod0O27hcGW/YGNyJbOXy5ReLoRI0rpQ==
X-Received: by 2002:a05:6a20:c188:b0:15a:2c0b:6c81 with SMTP id bg8-20020a056a20c18800b0015a2c0b6c81mr16992215pzb.3.1698192164370;
        Tue, 24 Oct 2023 17:02:44 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b006be1dc1537csm8170308pfj.59.2023.10.24.17.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 17:02:44 -0700 (PDT)
Date: Wed, 25 Oct 2023 09:02:43 +0900 (JST)
Message-Id: <20231025.090243.1437967503809186729.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v6 2/5] rust: net::phy add module_phy_driver
 macro
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ca5873fb-3139-4198-8ff8-c3abc6c40347@proton.me>
References: <20231024005842.1059620-1-fujita.tomonori@gmail.com>
	<20231024005842.1059620-3-fujita.tomonori@gmail.com>
	<ca5873fb-3139-4198-8ff8-c3abc6c40347@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 16:28:02 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 24.10.23 02:58, FUJITA Tomonori wrote:
>> This macro creates an array of kernel's `struct phy_driver` and
>> registers it. This also corresponds to the kernel's
>> `MODULE_DEVICE_TABLE` macro, which embeds the information for module
>> loading into the module binary file.
>> 
>> A PHY driver should use this macro.
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> ---
>>   rust/kernel/net/phy.rs | 129 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 129 insertions(+)
>> 
>> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
>> index 2d821c2475e1..f346b2b4d3cb 100644
>> --- a/rust/kernel/net/phy.rs
>> +++ b/rust/kernel/net/phy.rs
>> @@ -706,3 +706,132 @@ const fn as_int(&self) -> u32 {
>>           }
>>       }
>>   }
>> +
>> +/// Declares a kernel module for PHYs drivers.
>> +///
>> +/// This creates a static array of kernel's `struct phy_driver` and registers it.
>> +/// This also corresponds to the kernel's `MODULE_DEVICE_TABLE` macro, which embeds the information
>> +/// for module loading into the module binary file. Every driver needs an entry in `device_table`.
>> +///
>> +/// # Examples
>> +///
>> +/// ```ignore
> 
> Is this example ignored, because it does not compile?

The old version can't be compiled but the current version can so I'll
drop ignore.


> I think Wedson was wrapping his example with `module!` inside
> of a module, so maybe try that?

I'm not sure what you mean.


>> +/// use kernel::c_str;
>> +/// use kernel::net::phy::{self, DeviceId};
>> +/// use kernel::prelude::*;
>> +///
>> +/// kernel::module_phy_driver! {
>> +///     drivers: [PhyAX88772A],
>> +///     device_table: [
>> +///         DeviceId::new_with_driver::<PhyAX88772A>(),
>> +///     ],
>> +///     name: "rust_asix_phy",
>> +///     author: "Rust for Linux Contributors",
>> +///     description: "Rust Asix PHYs driver",
>> +///     license: "GPL",
>> +/// }
>> +///
>> +/// struct PhyAX88772A;
>> +///
>> +/// impl phy::Driver for PhyAX88772A {
>> +///     const NAME: &'static CStr = c_str!("Asix Electronics AX88772A");
>> +///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x003b1861);
>> +/// }
>> +/// ```
>> +///
>> +/// This expands to the following code:
>> +///
>> +/// ```ignore
>> +/// use kernel::c_str;
>> +/// use kernel::net::phy::{self, DeviceId};
>> +/// use kernel::prelude::*;
>> +///
>> +/// struct Module {
>> +///     _reg: ::kernel::net::phy::Registration,
>> +/// }
>> +///
>> +/// module! {
>> +///     type: Module,
>> +///     name: "rust_asix_phy",
>> +///     author: "Rust for Linux Contributors",
>> +///     description: "Rust Asix PHYs driver",
>> +///     license: "GPL",
>> +/// }
>> +///
>> +/// const _: () = {
>> +///     static mut DRIVERS: [::kernel::net::phy::DriverVTable; 1] = [
>> +///         ::kernel::net::phy::create_phy_driver::<PhyAX88772A>::(),
>> +///     ];
>> +///
>> +///     impl ::kernel::Module for Module {
>> +///        fn init(module: &'static ThisModule) -> Result<Self> {
>> +///            let mut reg = unsafe { ::kernel::net::phy::Registration::register(module, Pin::static_mut(&mut DRIVERS)) }?;
> 
> Can you please format this as well?

Done.


>> +///            Ok(Module { _reg: reg })
>> +///        }
>> +///     }
>> +/// }
>> +///
>> +/// static __mod_mdio__phydev_device_table: [::kernel::bindings::mdio_device_id; 2] = [
>> +///     ::kernel::bindings::mdio_device_id {
>> +///         phy_id: 0x003b1861,
>> +///         phy_id_mask: 0xffffffff,
>> +///     },
>> +///     ::kernel::bindings::mdio_device_id {
>> +///         phy_id: 0,
>> +///         phy_id_mask: 0,
>> +///     }
>> +/// ];
>> +/// ```
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
>> +            ::kernel::bindings::mdio_device_id;
>> +            $crate::module_phy_driver!(@count_devices $($dev),+) + 1
>> +        ] = [
>> +            $($dev.mdio_device_id()),+,
>> +            ::kernel::bindings::mdio_device_id {
>> +                phy_id: 0,
>> +                phy_id_mask: 0
>> +            }
>> +        ];
>> +    };
>> +
>> +    (drivers: [$($driver:ident),+], device_table: [$($dev:expr),+], $($f:tt)*) => {
>> +        struct Module {
>> +            _reg: ::kernel::net::phy::Registration,
>> +        }
>> +
>> +        $crate::prelude::module! {
>> +            type: Module,
>> +            $($f)*
>> +        }
>> +
>> +        const _: () = {
>> +            static mut DRIVERS: [
>> +                ::kernel::net::phy::DriverVTable;
>> +                $crate::module_phy_driver!(@count_devices $($driver),+)
>> +            ] = [
>> +                $(::kernel::net::phy::create_phy_driver::<$driver>()),+
>> +            ];
>> +
>> +            impl ::kernel::Module for Module {
>> +                fn init(module: &'static ThisModule) -> Result<Self> {
>> +                    // SAFETY: The anonymous constant guarantees that nobody else can access the `DRIVERS` static.
>> +                    // The array is used only in the C side.
>> +                    let mut reg = unsafe { ::kernel::net::phy::Registration::register(module, core::pin::Pin::static_mut(&mut DRIVERS)) }?;
> 
> Can you put the safe operations outside of the `unsafe` block?

fn init(module: &'static ThisModule) -> Result<Self> {
    // SAFETY: The anonymous constant guarantees that nobody else can access
    // the `DRIVERS` static. The array is used only in the C side.
    let mut reg = ::kernel::net::phy::Registration::register(
        module,
        core::pin::Pin::static_mut(unsafe { &mut DRIVERS }),
    )?;
    Ok(Module { _reg: reg })
}

> Since `rustfmt` does not work well within `macro_rules`, you
> have to manually format this code. One trick I use to do this
> is to replace all meta variables with normal variables and
> just put it in `rustfmt` and then revert the replacement in
> the output.

Understood, done.

