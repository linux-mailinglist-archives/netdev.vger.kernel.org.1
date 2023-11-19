Return-Path: <netdev+bounces-49010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621977F0695
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 14:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F4D280D09
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 13:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9D71119A;
	Sun, 19 Nov 2023 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ucd1JQ0n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7C383;
	Sun, 19 Nov 2023 05:51:16 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-280b06206f7so691568a91.1;
        Sun, 19 Nov 2023 05:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700401875; x=1701006675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlD51jZUXgbOPpX3jVFk8qj5QsisvkG2E/NrU3UDTTM=;
        b=Ucd1JQ0nemTTHans2rxP37bRLJn3tWmQ/3nMimLPncPUlzFgp/agbgEIQyZ5OOqWhh
         j1wYJGwE4OeMS5uW69y5cf1sWfuOi7WO+6VdonwmnisCR6QH12wcwU91o13Vjyp1XKKF
         aIT0rfMeLlmZv5DjxCT+kCoOIA5ryPTGPWL7c6rGe5UCREKO/BeD29+W2FBLitjLvg+k
         /wGqMNpEPe+qK1IjFwucW8Aa7/H2ScigLHhc0HWEmX3PzDliBKnfjBJvTwojcEaEGAp5
         PvVNAQYtNQsQ1wlM7NnPXBVAp5yPNKmMUHXGQyZxkVtALgE5q9qbXUiAZHxwxyGUmaVS
         rgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700401875; x=1701006675;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JlD51jZUXgbOPpX3jVFk8qj5QsisvkG2E/NrU3UDTTM=;
        b=lO8l1puf/hC5185BrooMsOZzftqIMA/XYAPcbVKTQAGuWZFbRp+0d2eT+KLPfE3hAp
         /Y98JOs2p78vEaNoRUSU7h0wjHnlAOr5LidLaCF8wZP9gj9O3n2HVA+SfeBUtHG3TLXh
         aWw4b+te0cZMvCLtp8n1odUw9ikRFA52XG83GAErskQeQ1PEEM5cOWm1vmbW70cIbgZW
         JNk/Gax3/Iov8OGr9mMrhrhOEfnT1bVb8JstphYa9Y/EmuAifcXPTVtHX13gyGxlCqsE
         Do4hRCraw4wUPPUc82p+MLKukjuBWiSf1vgfecVe/RWQXVFTsVMfRpyZvhksoN3OlaxT
         Olqw==
X-Gm-Message-State: AOJu0YxNCz366JXdbgVDHL57Ukgkv4coej/4TYp5P5YEKFIEZrUZHFVU
	e5XEsA5Cx4uR4qr/4RMoyyeky1+8ZIXYx6bT
X-Google-Smtp-Source: AGHT+IHjPyyPeFiVzaymmpv5hj8unIxKNQEWaf2EPoY4T6z38ktGI0rZ1YeqEke/NotVUWyXuJpDxA==
X-Received: by 2002:a17:902:ce8d:b0:1cc:2ba2:55f4 with SMTP id f13-20020a170902ce8d00b001cc2ba255f4mr6807499plg.0.1700401875389;
        Sun, 19 Nov 2023 05:51:15 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id cz8-20020a17090ad44800b00280fcbbe774sm4130397pjb.10.2023.11.19.05.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 05:51:15 -0800 (PST)
Date: Sun, 19 Nov 2023 22:51:14 +0900 (JST)
Message-Id: <20231119.225114.390963370394344723.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, andrew@lunn.ch, benno.lossin@proton.me,
 miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20231117093906.2514808-1-aliceryhl@google.com>
References: <20231026001050.1720612-2-fujita.tomonori@gmail.com>
	<20231117093906.2514808-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 17 Nov 2023 09:39:05 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> FUJITA Tomonori <fujita.tomonori@gmail.com> writes:
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
> In this reply, I go through my minor nits:
> 
>> +use crate::{
>> +    prelude::{vtable, Pin},
>> +};
> 
> Normally, if you're importing specific prelude items by name instead of
> using prelude::*, then you would import them using their non-prelude
> path.

Understood. I have no reason to import specific prelude items so I use
`prelude::*` instead.


>> +#[derive(PartialEq)]
>> +pub enum DeviceState {
> 
> If you add PartialEq and you can add Eq, then also add Eq.

Added Eq.


>> +/// An adapter for the registration of a PHY driver.
>> +struct Adapter<T: Driver> {
>> +    _p: PhantomData<T>,
>> +}
> 
> You don't need this struct. The methods can be top-level functions.
> 
> But I know that others have used the same style of defining a useless
> struct, so it's fine with me.

You meant like the following?

unsafe extern "C" fn soft_reset_callback<T: Driver>(
    phydev: *mut bindings::phy_device,
) -> core::ffi::c_int {
    from_result(|| {
        // SAFETY: Preconditions ensure `phydev` is valid.
        let dev = unsafe { Device::from_raw(phydev) };
        T::soft_reset(dev)?;
        Ok(0)
    })
}

pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
    DriverVTable(Opaque::new(bindings::phy_driver {
	soft_reset: if T::HAS_SOFT_RESET {
            Some(soft_reset_callback::<T>)
        } else {
            None
	}
    }
}

I thought that a struct is used to group callbacks. Either is fine by
me though.


>> +    /// Defines certain other features this PHY supports.
>> +    /// It is a combination of the flags in the [`flags`] module.
>> +    const FLAGS: u32 = 0;
> 
> You need an empty line between the two lines if you intend for them to
> be separate lines in rendered documentation.

I don't intend to make them separate lines. If I make thme one line,
it's too long (over 100) so I made them two lines.


>> +#[vtable]
>> +pub trait Driver {
>> +    /// Issues a PHY software reset.
>> +    fn soft_reset(_dev: &mut Device) -> Result {
>> +        Err(code::ENOTSUPP)
>> +    }
>>      [...]
>> +}
> 
> I believe that the guidance for what to put in optional vtable-trait
> methods was changed in:
> 
> https://lore.kernel.org/all/20231026201855.1497680-1-benno.lossin@proton.me/

But VTABLE_DEFAULT_ERROR is defined in that patch, which isn't
merged. I'll update the code once that patch is merged.


>> +// SAFETY: `Registration` does not expose any of its state across threads.
>> +unsafe impl Send for Registration {}
> 
> I would change this to "it's okay to call phy_drivers_unregister from a
> different thread than the one in which phy_drivers_register was called".
> 
>> +// SAFETY: `Registration` does not expose any of its state across threads.
>> +unsafe impl Sync for Registration {}
> 
> Here, you can say "Registration has no &self methods, so immutable
> references to it are useless".

I'll reply to Trevor mail on this issue.


>> +    // macro use only
>> +    #[doc(hidden)]
>> +    pub const fn mdio_device_id(&self) -> bindings::mdio_device_id {
>> +        bindings::mdio_device_id {
>> +            phy_id: self.id,
>> +            phy_id_mask: self.mask.as_int(),
>> +        }
>> +    }
> 
> This is fine, but I probably would just expose it for everyone. It's not
> like it hurts if non-macro code can call this method, even if it doesn't
> have a reason to do so.

IIRC, someone said that drivers should not use bindings directly so
this function that returns bindings::mdio_device_id isn't exported.

Thanks!

