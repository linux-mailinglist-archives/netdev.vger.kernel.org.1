Return-Path: <netdev+bounces-49509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC8D7F23B3
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC23B1F2662D
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60231429E;
	Tue, 21 Nov 2023 02:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBqFzBDU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AB8E3;
	Mon, 20 Nov 2023 18:13:07 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6bbfb8f7ac4so1418907b3a.0;
        Mon, 20 Nov 2023 18:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700532787; x=1701137587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IsJ+vBOvHozQQUHLnusyAMGlpXVOSmcYb5GpvxkMATU=;
        b=RBqFzBDUd2YjHq2Y5gRTKoHAGsGvi6LX/TfmMTUlSXsACqGxQuBL03gnfi14LisAQF
         XAJm7S7CJt3Oyl+WcVyM9ONELB3IJchHYCVhXCBeb1aG7RHIyr1ryofuhvPDb5H0lXf5
         Fjyj6yHEeWu2324U1xwiH97JqtClKy1cttOd1RgAXl8vgZ/8M9pHxp623wVCMFzhpxti
         OPWKjf38Q/Ju4RSoWMHfKJ9y90nlHOfEjONvlSE57b79fy5X5aJYnmSwWPmbcJEBHxtq
         fQXn8o5CnIoNr5LoJic9cSOhLwhcfeBUgol7d+AScpjV67WtCh+ogkZp6khtHRVRABiO
         Rwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532787; x=1701137587;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IsJ+vBOvHozQQUHLnusyAMGlpXVOSmcYb5GpvxkMATU=;
        b=jOzVZqqAWPKo+E1u/sPTbeY4qm6qmAYHY8DuwXvcxQAUkrCg4RoN+Q54duddkMSvfc
         fGv6qjfjMZkm2fgQJ/BHc7xAMMRjEt3K4e9kaqqAehs0k5xrBbSvANkoBPcSVPyVCdRt
         zienwCcBUKE4TN+/BxODQbKL5EZFRX2kH8R4T6FE4cUa3GoszHq+mFBNpZJ9M38qOVjo
         C+BLrXhWq/9KXNsK+4G0tjE3ht6uHtwjOnNnvlV0j5bsfB3eelClvzh+F/0JPT8wH47J
         yxUE9E/Nyh1pUbCtciSSqDiBncu+JinduyoSJyMDrZ56R7B6uPm4wRld5Yq6ppKAzP4c
         Hp8g==
X-Gm-Message-State: AOJu0Yza+DUuVfQgz8JzyOhODaLEpYe646VDhFRkLikfveLlgeQSQtSx
	/EvcEBSL/cEKP0rwRbjePok=
X-Google-Smtp-Source: AGHT+IFTLVJTUjc0cp3vhCIr4tOgxnJmbofRbzxMkHyltk1zlguaVTne21bl2wJhKS9uNVeh9Ynllg==
X-Received: by 2002:a05:6a20:7f8c:b0:187:df59:5c3c with SMTP id d12-20020a056a207f8c00b00187df595c3cmr12841723pzj.3.1700532787031;
        Mon, 20 Nov 2023 18:13:07 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id q24-20020a17090a2e1800b00274922d4b38sm6196677pjd.27.2023.11.20.18.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:13:06 -0800 (PST)
Date: Tue, 21 Nov 2023 11:13:06 +0900 (JST)
Message-Id: <20231121.111306.119472527722905184.fujita.tomonori@gmail.com>
To: tmgross@umich.edu
Cc: boqun.feng@gmail.com, fujita.tomonori@gmail.com, andrew@lunn.ch,
 gregkh@linuxfoundation.org, aliceryhl@google.com, benno.lossin@proton.me,
 miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CALNs47tt94DBPvz47rssBTZ86jbHwaa7XaNnT3UbdxwY6nLg1g@mail.gmail.com>
References: <e7d0226a-9a38-4ce9-a9b5-7bb80a19bff6@lunn.ch>
	<ZVjePqyic7pvcb24@Boquns-Mac-mini.home>
	<CALNs47tt94DBPvz47rssBTZ86jbHwaa7XaNnT3UbdxwY6nLg1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 19 Nov 2023 05:06:23 -0600
Trevor Gross <tmgross@umich.edu> wrote:

>> +pub struct Registration {
>> +    drivers: Pin<&'static mut [DriverVTable]>,
>> +}
>>
>> [...]
>>
>> +// SAFETY: `Registration` does not expose any of its state across threads.
>> +unsafe impl Send for Registration {}
>>
>> +// SAFETY: `Registration` does not expose any of its state across threads.
>> +unsafe impl Sync for Registration {}
> 
> I don't think the impl here actually makes sense. `Registration` is a
> buffer of references to `DriverVTable`. That type isn't marked Sync so
> by the above rules, its references should not be either.
> 
> Tomo, does this need to be Sync at all? Probably easiest to drop the
> impls if not, otherwise I think it is more correct to move them to
> `DriverVTable`.  You may have had this before, I'm not sure if
> discussion made you change it at some point...

This needs to be Sync:

601 | pub struct Registration {
    |            ^^^^^^^^^^^^
note: required because it appears within the type `Module`
   --> drivers/net/phy/foo_rust.rs:5:1
    |
5   | / kernel::module_phy_driver! {
6   | |     drivers: [Foo],
7   | |     device_table: [
8   | |         DeviceId::new_with_driver::<Foo>()
...   |
13  | |     license: "GPL",
14  | | }
    | |_^
note: required by a bound in `kernel::Module`
   --> /home/ubuntu/git/linux/rust/kernel/lib.rs:69:27
    |
69  | pub trait Module: Sized + Sync {
    |                           ^^^^ required by this bound in `Module`
    = note: this error originates in the macro `kernel::module_phy_driver` (in Nightly builds, run with -Z macro-backtrace for more info)


I'm not sure we discussed but making DriverVTable Sync works.

#[repr(transparent)]
pub struct DriverVTable(Opaque<bindings::phy_driver>);

// SAFETY: DriverVTable has no &self methods, so immutable references to it are useless.
unsafe impl Sync for DriverVTable {}


looks correct?

