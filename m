Return-Path: <netdev+bounces-43012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9687D0FF1
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2C1B21083
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058FB18C21;
	Fri, 20 Oct 2023 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kr6+Huzr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B097C12E65;
	Fri, 20 Oct 2023 12:54:52 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6223A9F;
	Fri, 20 Oct 2023 05:54:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27d8a1aed37so232742a91.1;
        Fri, 20 Oct 2023 05:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697806491; x=1698411291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEXV5g2AMDhD5tUHctgvm/W0AnnHjxLT+J7kRoSHLnw=;
        b=kr6+HuzrCHgzdCBPnCNRTwva9658q7LG0HL1qW7aV2lK68M4noom29s9yGUDv1DE97
         e9B/fu1H62xLFk6wEtveqxGP9m4QMZgqeNwiqGsHMNnIkuwD9sUNau7qwqszDaR/Isnp
         JEeCalsron9MQQaH7oMM6TZUrk/J+dBdIz2YWWpHVqugCG4Yg9BAYIxx6sbyZgg1fBEJ
         b6zsrQcAJa1n7II5auMDxaoc9gwggt9AuwnC0ocxKo4OF8ijBQumV1pVaHDqadBxW7Vp
         NR7ggEo6EpewDk9HZqC+gukpI8hR9M7gd0VcbdbwtS4wiVRKEYdJCa4rOy/S8jy4yKRZ
         Tl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806491; x=1698411291;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XEXV5g2AMDhD5tUHctgvm/W0AnnHjxLT+J7kRoSHLnw=;
        b=PQFlGH01yWH89Osajcnj/J0aOtt78+9OhEaa62vlzpN9H55dQ8G5eAVsnHp30R3M2k
         4gAOZPEcJmaVp2y3ZsmqKeX/nTpth/mcp5TcfH5W/NuQ6wyzP3Iq05FkKOaG+rLrYOgp
         xA4vgzBCbvho8xSwXet8JtTNUUC/cQ6U0Ofptf7Y7PWruj+jYymWSCKXUZ3nyvePBTO9
         vpcllvxdV96bXAXpFckdgDxSY5NtK+SAl8ge0YK9TnKJu+ZWl/dKs2MqsxfuPih/HE35
         sOApWtYWV6pxtiSS+s68PB7atRrg4nGgruSzUCYbGJpwwjJkhKxXO1Fdv8DfsxOG6T+t
         5QeA==
X-Gm-Message-State: AOJu0Yy1IyMVX/XekgPVBbsGd5QrZPrL4bbIlQRBJbw66wQ8gaLa0WPM
	Gmp/5V26/DF7ab3w9hlNYVQ=
X-Google-Smtp-Source: AGHT+IEGQBW9BXSeURIXYuFXu6tb1dTffVCM6IlaMAlR3MbYYh6jXP2O0Q5dBNKw5KrgvkZRP0kjfg==
X-Received: by 2002:a17:90b:38d1:b0:27d:15e3:3aa9 with SMTP id nn17-20020a17090b38d100b0027d15e33aa9mr1812920pjb.3.1697806490639;
        Fri, 20 Oct 2023 05:54:50 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id p20-20020a17090ad31400b0027d15bd9fa2sm3165482pju.35.2023.10.20.05.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 05:54:49 -0700 (PDT)
Date: Fri, 20 Oct 2023 21:54:48 +0900 (JST)
Message-Id: <20231020.215448.1421599168007259810.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20231020.093446.482864708938996774.fujita.tomonori@gmail.com>
References: <20231019.234210.1772681043146865420.fujita.tomonori@gmail.com>
	<64db34c0-a50a-4321-a3d8-b692e26899d9@proton.me>
	<20231020.093446.482864708938996774.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 09:34:46 +0900 (JST)
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> On Thu, 19 Oct 2023 15:20:51 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
> 
>> I would like to remove the mutable static variable and simplify
>> the macro.
> 
> How about adding DriverVTable array to Registration?
> 
> /// Registration structure for a PHY driver.
> ///
> /// # Invariants
> ///
> /// The `drivers` slice are currently registered to the kernel via `phy_drivers_register`.
> pub struct Registration<const N: usize> {
>     drivers: [DriverVTable; N],
> }
> 
> impl<const N: usize> Registration<{ N }> {
>     /// Registers a PHY driver.
>     pub fn register(
>         module: &'static crate::ThisModule,
>         drivers: [DriverVTable; N],
>     ) -> Result<Self> {
>         let mut reg = Registration { drivers };
>         let ptr = reg.drivers.as_mut_ptr().cast::<bindings::phy_driver>();
>         // SAFETY: The type invariants of [`DriverVTable`] ensure that all elements of the `drivers` slice
>         // are initialized properly. So an FFI call with a valid pointer.
>         to_result(unsafe {
>             bindings::phy_drivers_register(ptr, reg.drivers.len().try_into()?, module.0)
>         })?;
>         // INVARIANT: The `drivers` slice is successfully registered to the kernel via `phy_drivers_register`.
>         Ok(reg)
>     }
> }

Scratch this.

This doesn't work. Also simply putting slice of DriverVTable into
Module strcut doesn't work.

We cannot move a slice of DriverVTable. Except for static allocation,
is there a simple way?


