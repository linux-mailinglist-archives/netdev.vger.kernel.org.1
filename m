Return-Path: <netdev+bounces-56135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FA280DF54
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8AD1C214F8
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4D856474;
	Mon, 11 Dec 2023 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZjfavd7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F03EC3;
	Mon, 11 Dec 2023 15:15:06 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d072f50a44so11254305ad.0;
        Mon, 11 Dec 2023 15:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702336506; x=1702941306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4YNPLcgnZ6UEdckfp2o2FcjwAYgk4SB8h01P4r0OTQ=;
        b=eZjfavd72J/a7kZiK3SqC4awQB198/4wuBmZQeWyCH6bCtpm/RpNBKfeoZlhRWFwyG
         DyeI4wsOLdNRYJC/14GpNZ/8Z/rOKVYbJd9ulwxzqDrhbixBfY+qpgwfaQeL78c9krHe
         DsbPdbEmK7f1gljDMZpXSWKuHdvfjbiVeHftWa1kuIAB8Dtyh3aHsqRds7+T9ZLF6dE9
         JWRDIxwLhr3o0lSdnKtT0/5TIcgzWxGPFwSgwPB4uY5hE9JdDhznjXa25t6fYjnvPQ/l
         ZxCaYifs28rNmU+69Lrbb2URFuB7uikWjBHeFLM+BZitEw6pJckTavocsHoXjFY7QiAh
         kcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702336506; x=1702941306;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w4YNPLcgnZ6UEdckfp2o2FcjwAYgk4SB8h01P4r0OTQ=;
        b=aY75VUgREykxnh2GaD5/xbIuVzMQv7U+Kjar8SK+peqYo+QrHm9oUvpcUpxAwADQQY
         ZNoUa6MuFJ1hehO8HS9GW0LMuNovnEVAvG7VhCuJ2OPhNlMjHsl7sJDn+bfXWCYkQ/jd
         efBCZWpOzcbCH7whTAyi7glcQFEnk5HJTqmh8eR1kLX+ud/wFyUO1vCz/bVIj9ZnCRkA
         qwLEx6Ca9J4eE7GK6nOt4sLpFxpc88LllsHyqpVZolNUkl2xhoNx2A+IXoKhA8XEoMeR
         q6OJnGGr5KI5GIvmr3ampGD+8UwRCl5zbJtco146YlT9A1tS9fCjodofu33Q8mbmyk4w
         1KjQ==
X-Gm-Message-State: AOJu0YyTHULXsEChea29GgFRrP7sOkaidGICLb2VjtrV9/3HY8IWvEkD
	y/Z83foB92BE+frLDXchQc4=
X-Google-Smtp-Source: AGHT+IEMXsF39rlkCdwVJwK1oAPEOm5ph1MOGaMbVVRR6PGbEjTOgLbZBNaVIq5IWTDpTxaU6XHkCg==
X-Received: by 2002:a17:903:2311:b0:1d0:7c59:2a4f with SMTP id d17-20020a170903231100b001d07c592a4fmr10131805plh.0.1702336505923;
        Mon, 11 Dec 2023 15:15:05 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id ix3-20020a170902f80300b001cc29b5a2aesm7254389plb.254.2023.12.11.15.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 15:15:05 -0800 (PST)
Date: Tue, 12 Dec 2023 08:15:05 +0900 (JST)
Message-Id: <20231212.081505.1423250811446494582.fujita.tomonori@gmail.com>
To: alice@ryhl.io
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 wedsonaf@gmail.com, aliceryhl@google.com, boqun.feng@gmail.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ccf2b9af-1c8c-44c4-bb93-51dd9ea1cccf@ryhl.io>
References: <20231210234924.1453917-1-fujita.tomonori@gmail.com>
	<20231210234924.1453917-2-fujita.tomonori@gmail.com>
	<ccf2b9af-1c8c-44c4-bb93-51dd9ea1cccf@ryhl.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 22:46:01 +0100
Alice Ryhl <alice@ryhl.io> wrote:

> On 12/11/23 00:49, FUJITA Tomonori wrote:
>> This patch adds abstractions to implement network PHY drivers; the
>> driver registration and bindings for some of callback functions in
>> struct phy_driver and many genphy_ functions.
>> This feature is enabled with CONFIG_RUST_PHYLIB_ABSTRACTIONS=y.
>> This patch enables unstable const_maybe_uninit_zeroed feature for
>> kernel crate to enable unsafe code to handle a constant value with
>> uninitialized data. With the feature, the abstractions can initialize
>> a phy_driver structure with zero easily; instead of initializing all
>> the members by hand. It's supposed to be stable in the not so distant
>> future.
>> Link: https://github.com/rust-lang/rust/pull/116218
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> Overall looks fine to me. Just a few comments below that confuse me:

Thanks.

>> +    /// Gets the state of PHY state machine states.
>> +    pub fn state(&self) -> DeviceState {
>> +        let phydev = self.0.get();
>> +        // SAFETY: The struct invariant ensures that we may access
>> +        // this field without additional synchronization.
>> +        let state = unsafe { (*phydev).state };
>> + // TODO: this conversion code will be replaced with automatically
>> generated code by bindgen
>> +        // when it becomes possible.
>> +        // better to call WARN_ONCE() when the state is out-of-range.
> 
> Did you mix up two comments here? This doesn't parse in my brain.

I'll remove the second comment because all we have to do here is using
bindgen.


>> +    /// Reads a given C22 PHY register.
>> + // This function reads a hardware register and updates the stats so
>> takes `&mut self`.
>> +    pub fn read(&mut self, regnum: u16) -> Result<u16> {
>> +        let phydev = self.0.get();
>> + // SAFETY: `phydev` is pointing to a valid object by the type
>> invariant of `Self`.
>> +        // So an FFI call with a valid pointer.
> 
> This sentence also doesn't parse in my brain. Perhaps "So it's just an
> FFI call" or similar?

"So it's just an FFI call" looks good. I'll fix all the places that
use the same comment.

