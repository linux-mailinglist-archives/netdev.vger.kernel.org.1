Return-Path: <netdev+bounces-40977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C9F7C9423
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 12:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BECC0B20B50
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 10:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E53C5687;
	Sat, 14 Oct 2023 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+6mUZ1R"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED11110781;
	Sat, 14 Oct 2023 10:32:35 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CD7A2;
	Sat, 14 Oct 2023 03:32:33 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9d132d92cso8038215ad.0;
        Sat, 14 Oct 2023 03:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697279553; x=1697884353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gua12QOAlIZFinMenqeZqusycUwDbC3bo6QcoBle+sA=;
        b=P+6mUZ1RbgvZi4wziCanx/4Rga8HJ6HOvxjj+ZIKvLj7+HqKxPhfSIdBSPlvNlnQxa
         totudf0yRCpx8zWlfgeZQbU7Nl5s1+BPJPxLBBIq2pmRup3aU1tU/DkYg9InzJEhOvqG
         UZtAmn/tlRdgu0rYxhA0yRALtI2zdtzTpk5/d9YxJnFaKDkcaM8YjxTL+7l0OTMs2AM0
         N13rvTxLxX8EHjNW98oMxo5f4eJ9bng2DeC+2AsTbMR7OJX5sLg8kIJFvTE4d34LCzLN
         hTF0xfa+QwlnMbWe26u85oKnGvo5DZvqcgeU8CNh+/u7sAY5+THiVrf5wC987S9lYKEx
         9WaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697279553; x=1697884353;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gua12QOAlIZFinMenqeZqusycUwDbC3bo6QcoBle+sA=;
        b=SYsOet8hHMyGRM/beZnN7qlIOs9lkJkN+8kFBpzKDtatQ/HFlIYe57RK04L6dXpaR6
         D8V1HW9SegpC1vEWwxHflt6L3jw8nMys3x/UDC4+xaiUT6aIoW+T9X3oqbtnivBvc0o+
         12bNV3A998Rhf81m+o+DQfwaiFGLKPNtBKJuddAoUJMioPxn6QlywnhWRowSfzPByARq
         33w2Ib94WxkEYueen+BlXXQInS0XjrJtOsjvP8IQ0EZKfG3X3buegLQT92RmTS0XzFtq
         E9HD02Im46r8hyzeDIMlEilCK2NT95SNmXjU3o0l+sCZGO/op2DicbCLI+WRWID+Xdvx
         T9ag==
X-Gm-Message-State: AOJu0YwQ3nNsxboYmFDzT87weXsVSrm0marxvAL5aaK2Rgxz4dv/9gWj
	3QbYT4MoBIzN6pbjKMvSgfA=
X-Google-Smtp-Source: AGHT+IGGFwq4gfMb8PWSVkQXxm3Y1hQYyRNs356aNWiXyzY33xUaSOEsoBRGWs7iHdDMfo+FN2+FpQ==
X-Received: by 2002:a17:902:a40e:b0:1c9:bd60:72a6 with SMTP id p14-20020a170902a40e00b001c9bd6072a6mr12997998plq.4.1697279552720;
        Sat, 14 Oct 2023 03:32:32 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902d48f00b001c73d829fb7sm5233299plg.15.2023.10.14.03.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 03:32:32 -0700 (PDT)
Date: Sat, 14 Oct 2023 19:32:31 +0900 (JST)
Message-Id: <20231014.193231.787565106108242584.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <4791a460-09e0-4478-8f38-ae371e37416b@proton.me>
References: <85d5c498-efbc-4c1a-8d12-f1eca63c45cf@proton.me>
	<20231014.162210.522439670437191285.fujita.tomonori@gmail.com>
	<4791a460-09e0-4478-8f38-ae371e37416b@proton.me>
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

On Sat, 14 Oct 2023 08:07:03 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 14.10.23 09:22, FUJITA Tomonori wrote:
>> On Fri, 13 Oct 2023 21:31:16 +0000
>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>> +    /// the exclusive access for the duration of the lifetime `'a`.
>>>
>>> In some other thread you mentioned that no lock is held for
>>> `resume`/`suspend`, how does this interact with it?
>> 
>> The same quesiton, 4th time?
> 
> Yes, it is not clear to me from the code/safety comment alone why
> this is safe. Please improve the comment such that that is the case.
>
>> PHYLIB is implemented in a way that PHY drivers exlusively access to
>> phy_device during the callbacks.
> 
> As I suggested in a previous thread, it would be extremely helpful
> if you add a comment on the `phy` abstractions module that explains
> how `PHYLIB` is implemented. Explain that it takes care of locking
> and other safety related things.

From my understanding, the callers of suspend() try to call suspend()
for a device only once. They lock a device and get the current state
and update the sate, then unlock the device. If the state is a
paticular value, then call suspend(). suspend() and resume() are also
called where only one thread can access a device.


>>>> +    unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
>>>> +        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
>>>> +        // `Device` type being transparent makes the cast ok.
>>>> +        unsafe { &mut *ptr.cast() }
>>>
>>> please refactor to
>>>
>>>       // CAST: ...
>>>       let ptr = ptr.cast::<Self>();
>>>       // SAFETY: ...
>>>       unsafe { &mut *ptr }
>> 
>> I can but please tell the exactly comments for after CAST and SAFETY.
>> 
>> I can't find the description of CAST comment in
>> Documentation/rust/coding-guidelines.rst. So please add why and how to
>> avoid repeating the same review comment in the future.
> 
> I haven't had the time to finish my work on the standardization of
> `SAFETY` (and also `CAST`) comments, but I am working on that.
> 
>         // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::phy_device`.
>         let ptr = ptr.cast::<Self>();
>         // SAFETY: by the function requirements the pointer is valid and we have unique access for
>         // the duration of `'a`.
>         unsafe { &mut *ptr }

Thanks, I'll copy-and-paste it.


>>>> +    /// Returns true if auto-negotiation is completed.
>>>> +    pub fn is_autoneg_completed(&self) -> bool {
>>>> +        const AUTONEG_COMPLETED: u32 = 1;
>>>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>>>> +        let phydev = unsafe { *self.0.get() };
>>>> +        phydev.autoneg_complete() == AUTONEG_COMPLETED
>>>> +    }
>>>> +
>>>> +    /// Sets the speed of the PHY.
>>>> +    pub fn set_speed(&self, speed: u32) {
>>>
>>> This function modifies state, but is `&self`?
>> 
>> Boqun asked me to drop mut on v3 review and then you ask why on v4?
>> Trying to find a way to discourage developpers to write Rust
>> abstractions? :)
>> 
>> I would recommend the Rust reviewers to make sure that such would
>> not happen. I really appreciate comments but inconsistent reviewing is
>> painful.
> 
> I agree with Boqun. Before Boqun's suggestion all functions were
> `&mut self`. Now all functions are `&self`. Both are incorrect. A
> function that takes `&mut self` can modify the state of `Self`,
> but it is weird for it to not modify anything at all. Such a
> function also can only be called by a single thread (per instance
> of `Self`) at a time. Functions with `&self` cannot modify the
> state of `Self`, except of course with interior mutability. If
> they do modify state with interior mutability, then they should
> have a good reason to do that.
> 
> What I want you to do here is think about which functions should
> be `&mut self` and which should be `&self`, since clearly just
> one or the other is wrong here.

https://lore.kernel.org/netdev/20231011.231607.1747074555988728415.fujita.tomonori@gmail.com/T/#mb7d219b2e17d3f3e31a0d05697d91eb8205c5c6e

Hmm, I undertood that he suggested all mut.

Anyway,

phy_id()
state()
get_link()
is_autoneg_enabled()
is_autoneg_completed()

doesn't modify Self.

The rest modifies then need to be &mut self? Note that function like read_*
updates the C data structure.


>>>> +        let phydev = self.0.get();
>>>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>>>> +        // So an FFI call with a valid pointer.
>>>> +        let ret = unsafe { bindings::phy_read_paged(phydev, page.into(), regnum.into()) };
>>>> +        if ret < 0 {
>>>> +            Err(Error::from_errno(ret))
>>>> +        } else {
>>>> +            Ok(ret as u16)
>>>> +        }
>>>> +    }
>>>
>>> [...]
>>>
>>>> +}
>>>> +
>>>> +/// Defines certain other features this PHY supports (like interrupts).
>>>
>>> Maybe add a link where these flags can be used.
>> 
>> I already put the link to here in trait Driver.
> 
> I am asking about a link here, as it is a bit confusing when
> you just stumble over this flag module here. It doesn't hurt
> to link more.

I can't find the code does the similar. What exactly do you expect?
Like this?

/// Defines certain other features this PHY supports (like interrupts) for [`Driver`]'s `FLAGS`.
pub mod flags {

>>>> +    /// Get a `mask` as u32.
>>>> +    pub const fn mask_as_int(&self) -> u32 {
>>>> +        self.mask.as_int()
>>>> +    }
>>>> +
>>>> +    // macro use only
>>>> +    #[doc(hidden)]
>>>> +    pub const fn as_mdio_device_id(&self) -> bindings::mdio_device_id {
>>>
>>> I would name this just `mdio_device_id`.
>> 
>> Either is fine by me. Please tell me why for future reference.
> 
> Functions starting with `as_` or `to_` in Rust generally indicate
> some kind of conversion. `to_` functions generally take just `self`
> by value and `as_` conversions take just `&self`/`&mut self`. See
> `Option::as_ref` or `Option::as_mut`. This function is not really
> a conversion, rather it is a getter.

I think that Trevor suggested that name. Either works for me but I'll
go with your suggestion.

