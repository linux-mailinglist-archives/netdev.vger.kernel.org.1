Return-Path: <netdev+bounces-42836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D997D05D6
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 02:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086651C20E67
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 00:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE7B377;
	Fri, 20 Oct 2023 00:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Edk8FTJv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D974361;
	Fri, 20 Oct 2023 00:34:49 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBF6A3;
	Thu, 19 Oct 2023 17:34:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ba8eb7e581so81665b3a.0;
        Thu, 19 Oct 2023 17:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697762088; x=1698366888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=taa/SLU/9O/XadgncirKySx1+hAvtUl61CUryzFzv6o=;
        b=Edk8FTJvy+/br0qS6sk9k4LZ3TwPcBmFWrqclxyyEko9FEdMF+yCNrGM9F97fb6ATk
         7PDD4Zan0nGiCXyyvv8Ezdlt0v6oWlC2k84cYBQQaKQa5nHFgK/RmJ15YTzxny9SIgPU
         0MMYUfhSHDNhRCe0D6gOw8O2M3jHTA/QYYR2gFGWt5ccBTBBReWwKwneYbj5XsKMCere
         aLKgvyvZoDJkemvtCXk/TeGEeQKSPS9lR33B56VCfA0aVO4SjmA/y4ZbEHdh/D6JF3V9
         8iFJWdqonG/JVA1GUcVZtTp+o2csqCYHXz+V/ArXC8Y6tFHjvVXWNWAnBaXNS89oa0JN
         rQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697762088; x=1698366888;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=taa/SLU/9O/XadgncirKySx1+hAvtUl61CUryzFzv6o=;
        b=dY8ZD7Vv4jUXzmuVNmLSWoh5ubW8zJ0+cGB+vhZbc/uuHcmVDdG4/uW+rhkg59kU8B
         1r8oycnb7SEW8ZcO18HtYo9nqfaNtqp1tNqUGQWoOrXBIJazCX+VHDrtHR5jP5yWI7hE
         A5KlR4N/u+hDRVFmrh0Ho/CicNKy0HRE8qTxYjMrs6a883u2iXZAs3Glli8vdLjDAMuN
         yDSUh+Ha6XmnoDXr6aMJNtbmtpsnNk1hUNaGunNzcVHpS2jpJHc9olA0yP0kLP215qqa
         AJzKPcWmiCkfZ6sdZDUp0RePtkY37dePpEleyoP6Ref+sTslQ02TZZOkHIBPPIowFy1x
         YVIA==
X-Gm-Message-State: AOJu0YzlmfkPDkvKxF0e46UGwPwvrghA07KgGxHf+h2pwZae5qLIIhm5
	8w9XMDFUCyZBdVV0eGqLlsE=
X-Google-Smtp-Source: AGHT+IHXMDBk79JAWPhogHZ6A3hYm9KcIHgmL44OUj5Ojv5u1/VqogMfdDb7nELy8u/54aygTlnqVA==
X-Received: by 2002:a05:6a20:3d20:b0:17a:d292:25d1 with SMTP id y32-20020a056a203d2000b0017ad29225d1mr396062pzi.6.1697762087743;
        Thu, 19 Oct 2023 17:34:47 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id q21-20020a631f55000000b0059b2316be86sm330934pgm.46.2023.10.19.17.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 17:34:47 -0700 (PDT)
Date: Fri, 20 Oct 2023 09:34:46 +0900 (JST)
Message-Id: <20231020.093446.482864708938996774.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <64db34c0-a50a-4321-a3d8-b692e26899d9@proton.me>
References: <0e8d2538-284b-4811-a2e7-99151338c255@proton.me>
	<20231019.234210.1772681043146865420.fujita.tomonori@gmail.com>
	<64db34c0-a50a-4321-a3d8-b692e26899d9@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 15:20:51 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> I would like to remove the mutable static variable and simplify
> the macro.

How about adding DriverVTable array to Registration?

/// Registration structure for a PHY driver.
///
/// # Invariants
///
/// The `drivers` slice are currently registered to the kernel via `phy_drivers_register`.
pub struct Registration<const N: usize> {
    drivers: [DriverVTable; N],
}

impl<const N: usize> Registration<{ N }> {
    /// Registers a PHY driver.
    pub fn register(
        module: &'static crate::ThisModule,
        drivers: [DriverVTable; N],
    ) -> Result<Self> {
        let mut reg = Registration { drivers };
        let ptr = reg.drivers.as_mut_ptr().cast::<bindings::phy_driver>();
        // SAFETY: The type invariants of [`DriverVTable`] ensure that all elements of the `drivers` slice
        // are initialized properly. So an FFI call with a valid pointer.
        to_result(unsafe {
            bindings::phy_drivers_register(ptr, reg.drivers.len().try_into()?, module.0)
        })?;
        // INVARIANT: The `drivers` slice is successfully registered to the kernel via `phy_drivers_register`.
        Ok(reg)
    }
}

Then the macro becomes simpler. No need to add any public
functions. Also I think that this approach supports the manual
registration.


    (drivers: [$($driver:ident),+], device_table: [$($dev:expr),+], $($f:tt)*) => {
        const N: usize = $crate::module_phy_driver!(@count_devices $($driver),+);
        struct Module {
            _reg: ::kernel::net::phy::Registration<N>,
        }

        $crate::prelude::module! {
            type: Module,
            $($f)*
        }

        impl ::kernel::Module for Module {
            fn init(module: &'static ThisModule) -> Result<Self> {
                let drivers = [$(::kernel::net::phy::create_phy_driver::<$driver>()),+];
                let reg = ::kernel::net::phy::Registration::register(module, drivers)?;
                Ok(Module { _reg: reg })
            }
        }

        $crate::module_phy_driver!(@device_table [$($dev),+]);
    }

