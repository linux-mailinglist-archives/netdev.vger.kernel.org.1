Return-Path: <netdev+bounces-52774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD72800324
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 06:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF46B20BD2
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 05:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F54179EC;
	Fri,  1 Dec 2023 05:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMI/eLgg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAE8170C;
	Thu, 30 Nov 2023 21:44:04 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so347589a12.0;
        Thu, 30 Nov 2023 21:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701409444; x=1702014244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8YZhGW1C4Tde9vAx9UFYsoDd9OchIqU9rvzpr81BHE=;
        b=GMI/eLgg9Hvnd3pvCx6jDGAUDy8Uhty6x3huidhXDyKcgx9iXRw5Lk9fk0+5GdFdox
         bVBhBCbeWxUGp+ZfUei7xh52AUu5lBgbdLJ7mX0JlPsC2jfs9ARdjK1nXlsRFB5lw3wq
         aer8XzsMgURYNSwVT+QTnMEPK6+UhiGVJ2JQuGG7G0JpN+tYh+VyEvrRslnvn5QxeADK
         r8weXbhka7fqKuZQJ7N5dBsgYDe2923I0orbjYkKgEq5JJV6YV3PkrDbBpN/i/ejeut2
         DtOgRJo/nzyrniXdvWYvqEDDxSSxDarvimz8dvjvCW3K++q7uoznH7W7gLP4IzRLf4oe
         gPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701409444; x=1702014244;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+8YZhGW1C4Tde9vAx9UFYsoDd9OchIqU9rvzpr81BHE=;
        b=Nbgn/m7rmcK6p6zfl6vJ6sD0qIuv0f9leMuTywExhh6YVk+7JHbkBjUvp935qf7OjF
         WW3kCp5Tz0pmJDG7WNjvTTq7ATyFwR/+KZGS01ssTBAf/ac36fS8gqraFVHzZHVxIPfI
         jdoOqstqzMZti3bRIsN0ep8oowEkzCmwNz1A+heQeerUGmp9JgzcGo6JmIz3lqykalkP
         /NorZFdbaVig3oxPZsAFbBa0AqZc1EPDWEMPT3wgmCHKcNN34XQmJqYe9YmiTC0eqfOk
         J1tDb17VvmBnyEmaPXGZ4BUYlJkQJJT7bSzpyOUY7WoO6PNsDP5wErEihjB0flGVCmnb
         ZAXQ==
X-Gm-Message-State: AOJu0YyKuE2FwHHPeBhSEXe4z5c2f1PKUQdV8c3iAj00nOP+uPBOj+SD
	pEzejNjgn/PTVCMIufVuTnA=
X-Google-Smtp-Source: AGHT+IFOAjiK941jj9f4Dczhqw/iz1tT9cYt2XdYBWqsUKXr7Hi3uJ0AlatwXN+XVavH/yuQGD1aVA==
X-Received: by 2002:a05:6a20:8411:b0:187:ccb6:ddf1 with SMTP id c17-20020a056a20841100b00187ccb6ddf1mr4942708pzd.0.1701409443838;
        Thu, 30 Nov 2023 21:44:03 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id az16-20020a17090b029000b002865781c51dsm539529pjb.18.2023.11.30.21.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 21:44:03 -0800 (PST)
Date: Fri, 01 Dec 2023 14:44:02 +0900 (JST)
Message-Id: <20231201.144402.323448332510672095.fujita.tomonori@gmail.com>
To: gary@garyguo.net
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 wedsonaf@gmail.com, aliceryhl@google.com, boqun.feng@gmail.com
Subject: Re: [PATCH net-next v8 1/4] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20231129195145.69ff5cf6.gary@garyguo.net>
References: <20231123050412.1012252-1-fujita.tomonori@gmail.com>
	<20231123050412.1012252-2-fujita.tomonori@gmail.com>
	<20231129195145.69ff5cf6.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Wed, 29 Nov 2023 19:51:45 +0000
Gary Guo <gary@garyguo.net> wrote:

> On Thu, 23 Nov 2023 14:04:09 +0900
> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
> 
>> +    /// Reads a given C22 PHY register.
>> +    // This function reads a hardware register and updates the stats so takes `&mut self`.
>> +    pub fn read(&mut self, regnum: u16) -> Result<u16> {
>> +        let phydev = self.0.get();
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        // So an FFI call with a valid pointer.
>> +        let ret = unsafe {
>> +            bindings::mdiobus_read((*phydev).mdio.bus, (*phydev).mdio.addr, regnum.into())
>> +        };
>> +        if ret < 0 {
>> +            Err(Error::from_errno(ret))
>> +        } else {
>> +            Ok(ret as u16)
>> +        }
>> +    }
>> +
>> +    /// Writes a given C22 PHY register.
>> +    pub fn write(&mut self, regnum: u16, val: u16) -> Result {
>> +        let phydev = self.0.get();
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        // So an FFI call with a valid pointer.
>> +        to_result(unsafe {
>> +            bindings::mdiobus_write((*phydev).mdio.bus, (*phydev).mdio.addr, regnum.into(), val)
>> +        })
>> +    }
> 
> `read` and `write` are not very distinctive names, especially when
> `read_paged` exists.

IIRC, these names are based on the IEEE spec and clear for PHY developers.

read/write: access a C22 register.
read_paged/write_paged: access a paged register.


>> +impl<T: Driver> Adapter<T> {
>> +    /// # Safety
>> +    ///
>> +    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
>> +    unsafe extern "C" fn soft_reset_callback(
>> +        phydev: *mut bindings::phy_device,
>> +    ) -> core::ffi::c_int {
>> +        from_result(|| {
>> +            // SAFETY: This callback is called only in contexts
>> +            // where we hold `phy_device->lock`, so the accessors on
>> +            // `Device` are okay to call.
>> +            let dev = unsafe { Device::from_raw(phydev) };
>> +            T::soft_reset(dev)?;
> 
> Usually we want type safety by to the callback typed access to the
> device's driver-private data, rather than just give it an arbitrary
> `Device`. Any reason not to similar things here?

Because two Rust PHY drivers that I implemented don't need such.

