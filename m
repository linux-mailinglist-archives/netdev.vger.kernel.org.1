Return-Path: <netdev+bounces-49000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D3A7F057B
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 11:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E995280D34
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 10:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E8C6FD0;
	Sun, 19 Nov 2023 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeRvmOpc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880DFE5;
	Sun, 19 Nov 2023 02:50:36 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28399608b7aso465702a91.0;
        Sun, 19 Nov 2023 02:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700391036; x=1700995836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2d0cgZC/FNXEtQr/CM8vVIUQ0NC+sKetd/MTCqu3dk=;
        b=EeRvmOpcSMS7w4CgpOAby21mCg7zl6RVw5ewdc4tL/qy+7lxlxcjmTDmZYQz2Wwn4C
         Q5DWvTP6OKonsWTzIzsbLmrDa3W1U/+aK5bClsr/R23Joto6Fw46rxPGNAwmMLbg+gSP
         qX0DllR7zM4V+pjbg8hSxqlwI5xPZk3nSDoR/+q+OWsQ6/ZxJi/fwvAYOWtnOBUKs2vw
         1FBv+NU+9JNxybudwEpSriJn/QbJ6XPEmzFcLMnQ4dktDEFHXbuyLkfVDUpPXvoIKfdG
         nWJhcDGGs+81bWSCCEa/nhxwG/b+0nMLutlHZVEyqyIqBj332vyINZEeyT09VIPHcUhU
         eppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700391036; x=1700995836;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G2d0cgZC/FNXEtQr/CM8vVIUQ0NC+sKetd/MTCqu3dk=;
        b=oJAnlMgct2WNwKqh6HILCX+HO/ny04rEUATSu19tPoNK/VD5X94NbrrIJwJMnGS/fb
         STzL+4ss3lvIK8SsKgR8+vN8YuS7r0cU2BTKnXMjU710AM7R3D6qUCTzx8VujRDQJYPm
         7OkMkGiP4Ajpe5iHz7zdcLZgwSZvTEYl+61+nvsN4W7Hn1fxQB2zTgwGR5d/RhK4acMx
         69j1yDH6sqfkIAZ27ywSBgZagHBKZyEbpZkm2bV2c98p/zPRThhFrTW0b0EdmUAqR0qy
         VzeWkntr+erM6AcSqSZp7Keawf33OBuWpfn2wQr2+u50h9kZFjSS+f08qfHfb/pxqQmG
         znlg==
X-Gm-Message-State: AOJu0YyMLJ250c0oni/23BxrKWEjBbCjvMxguvJgaoKYHNkJCEJs+Xpr
	5NMoCX63ty5tsDh6ebX1tV0=
X-Google-Smtp-Source: AGHT+IE007C9iuZgEWSriC/ac1aOVDFCETk7+TJdg9E4jjj64MQ69RI2mLHCI/TLcAOlhR4kz7zn6w==
X-Received: by 2002:a17:90a:fe96:b0:281:2d56:e750 with SMTP id co22-20020a17090afe9600b002812d56e750mr4688229pjb.0.1700391035883;
        Sun, 19 Nov 2023 02:50:35 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090abd8400b00274b035246esm7807499pjr.1.2023.11.19.02.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 02:50:35 -0800 (PST)
Date: Sun, 19 Nov 2023 19:50:35 +0900 (JST)
Message-Id: <20231119.195035.2131772627066676234.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, andrew@lunn.ch, benno.lossin@proton.me,
 miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 2/5] rust: net::phy add module_phy_driver
 macro
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20231117093908.2515105-1-aliceryhl@google.com>
References: <20231026001050.1720612-3-fujita.tomonori@gmail.com>
	<20231117093908.2515105-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 17 Nov 2023 09:39:08 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> FUJITA Tomonori <fujita.tomonori@gmail.com> writes:
>> This macro creates an array of kernel's `struct phy_driver` and
>> registers it. This also corresponds to the kernel's
>> `MODULE_DEVICE_TABLE` macro, which embeds the information for module
>> loading into the module binary file.
>> 
>> A PHY driver should use this macro.
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> A few minor nits:
> 
>> +    (drivers: [$($driver:ident),+], device_table: [$($dev:expr),+], $($f:tt)*) => {
> 
> Here, you can add $(,)? to allow trailing commas when the macro is used.
> Like this:
> 
> (drivers: [$($driver:ident),+ $(,)?], device_table: [$($dev:expr),+ $(,)?], $($f:tt)*) => {

Updated.

> 
>> +            ::kernel::bindings::mdio_device_id {
> 
> Here, I recommend `$crate` instead of `::kernel`.

I copied the code that Benno wrote, IIRC. Either is fine by me. Why
`$crate` is better here?

Also better to replace other `::kernel` in this macro?


>> +/// #[no_mangle]
>> +/// static __mod_mdio__phydev_device_table: [::kernel::bindings::mdio_device_id; 2] = [
>> +///     ::kernel::bindings::mdio_device_id {
>> +///         phy_id: 0x003b1861,
>> +///         phy_id_mask: 0xffffffff,
>> +///     },
>> +///     ::kernel::bindings::mdio_device_id {
>> +///         phy_id: 0,
>> +///         phy_id_mask: 0,
>> +///     },
>> +/// ];
> 
> I'd probably put a safety comment on the `#[no_mangle]` invocation to say that
> "C will not read off the end of this constant since the last element is zero".

Added.

Thanks a lot!

