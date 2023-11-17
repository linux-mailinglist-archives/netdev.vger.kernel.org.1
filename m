Return-Path: <netdev+bounces-48847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3B67EFB4C
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 23:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4318E2813A6
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 22:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3AF46447;
	Fri, 17 Nov 2023 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9/717rv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C66B8;
	Fri, 17 Nov 2023 14:21:50 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b6f4d8ddccso1460389b6e.0;
        Fri, 17 Nov 2023 14:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700259709; x=1700864509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqos8Nv96UO955hySjyMIOmjTN/yTGR5pgy+PKd65F4=;
        b=i9/717rvvCJ18aAX4gZY3r/9fPyzDkGS5T+NnU7mS41D3BZ57yGgQrscWmXFtzkNgr
         2ouZlpJKAZYsFgnghxgeJVTFh2n/3H41eSiM5F4YLtEmXpOTUb95+6JRWjMUy0fU/h9k
         hDf+nlaDZqbiQ/Fxq+TOIqC6g5eb/7tcSAqGQxsGXPZW3Us4wW+rmPgnCu6fm2wNW74V
         ZscySD96E4MiTv3PO4e0Q6MChoeak6Gf29NlY7OdnC0+pJQKJIingRV9gpzz+Q+VF3h0
         +s0unaZeQwwb+xOzupXsyN9HR+4J+CqTYfJJ6J/8DFMnKX8At5JXPGDLvFmfhuXxJti5
         6MqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700259709; x=1700864509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqos8Nv96UO955hySjyMIOmjTN/yTGR5pgy+PKd65F4=;
        b=s4f5quf3tL4tGMmfEyTXE+kVbgomWy4JToCQ2C05dHS4rLIG4prijjFX9Me0VEYqBw
         Ku9Q4dsZy35I3G018Y6udKd8ai1iRJOxKdiGi7YuPduDysyW5laR7syfYnaP8Kvxk0RH
         M2McTKCSKvqMNliscns/qgjCC6bbBhHzKQzz7mBvDH8MjSIPBMCcN4RqiHxB9Id+FrJm
         QnfNea0Sje3lT34X3SbJ+xLE59kw5++W/cnZbgW+ngESmTdDZXpno+REDND9uIkQsIKl
         OYJLnQl+8rJb3iYrjeqM0Nw/v1B9NjjJ7jzCINyswl+IaWt5ylqxGo3DeGIUhnlcw6nv
         uA9Q==
X-Gm-Message-State: AOJu0YxiIlVLtmFGvUCyAysNjU7+FAs9ysL57V6MtiHhhv5viZSTYl33
	Vtt1ee/W67A7kpyE52vgw69xcs/45z8=
X-Google-Smtp-Source: AGHT+IHevnMPsSP5sthYpbN5sxjTG4ZyCVTHLgQvykm2FkZTdvq1Lqi6R8M/q2fujgh5nqOco3c2Aw==
X-Received: by 2002:a05:6358:6f1b:b0:168:e78c:e3a7 with SMTP id r27-20020a0563586f1b00b00168e78ce3a7mr802422rwn.18.1700259709419;
        Fri, 17 Nov 2023 14:21:49 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id n8-20020a0cee68000000b0065afbb39b2dsm949508qvs.47.2023.11.17.14.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 14:21:49 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 8B82E27C0054;
	Fri, 17 Nov 2023 17:21:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 17 Nov 2023 17:21:48 -0500
X-ME-Sender: <xms:fOdXZX66WFxiiAiRdwM2fku5hEXLTnHIRMUiwUVybXj9JQbprBkyIw>
    <xme:fOdXZc63coEYyokNQ6iHorfsSXLPWuJHKK70t1pDqoD1aLACQHVqQK-8bKoHOswa0
    Wlwo_LtaQ6XGU50jA>
X-ME-Received: <xmr:fOdXZeeuQzzhOQrPuADAAxGT2Wu-xI91HqAbjvTgcLN5PmO-vwlbVeW4M_I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegtddgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:fOdXZYJuzEunjqIHAUGsiwjLTNx3cpRP9H81PFqFCpPoOBX5I0nHNg>
    <xmx:fOdXZbKdb8ld3VgqcWkmkNcJZOq9YUP659SpeP9ouRh84d2jzMuXJQ>
    <xmx:fOdXZRytMkmZa2kFiE5rDZB5UWs_WkOLTu1Or4vXqoFS7UqMToze1w>
    <xmx:fOdXZYrRUT-VbhVAOmHy_e4tqh1Da1YoaBgBXZ4CgThcPQij3-5L1u2CS-k>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Nov 2023 17:21:47 -0500 (EST)
Date: Fri, 17 Nov 2023 14:21:38 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 2/5] rust: net::phy add module_phy_driver
 macro
Message-ID: <ZVfncj5R9-8aU7vB@boqun-archlinux>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <20231026001050.1720612-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026001050.1720612-3-fujita.tomonori@gmail.com>

On Thu, Oct 26, 2023 at 09:10:47AM +0900, FUJITA Tomonori wrote:
[...]
> +
> +/// Declares a kernel module for PHYs drivers.
> +///
> +/// This creates a static array of kernel's `struct phy_driver` and registers it.
> +/// This also corresponds to the kernel's `MODULE_DEVICE_TABLE` macro, which embeds the information
> +/// for module loading into the module binary file. Every driver needs an entry in `device_table`.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # mod module_phy_driver_sample {
> +/// use kernel::c_str;
> +/// use kernel::net::phy::{self, DeviceId};
> +/// use kernel::prelude::*;
> +///
> +/// kernel::module_phy_driver! {
> +///     drivers: [PhyAX88772A],
> +///     device_table: [
> +///         DeviceId::new_with_driver::<PhyAX88772A>()
> +///     ],
> +///     name: "rust_asix_phy",
> +///     author: "Rust for Linux Contributors",
> +///     description: "Rust Asix PHYs driver",
> +///     license: "GPL",
> +/// }
> +///
> +/// struct PhyAX88772A;
> +///
> +/// #[vtable]
> +/// impl phy::Driver for PhyAX88772A {
> +///     const NAME: &'static CStr = c_str!("Asix Electronics AX88772A");
> +///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x003b1861);
> +/// }
> +/// # }
> +/// ```

When run the following kunit command:

./tools/testing/kunit/kunit.py run --make_options LLVM=1 --arch x86_64 \
	--kconfig_add CONFIG_RUST=y \
	--kconfig_add CONFIG_RUST_PHYLIB_ABSTRACTIONS=y \
	--kconfig_add CONFIG_PHYLIB=y \
	--kconfig_add CONFIG_NETDEVICES=y \
	--kconfig_add CONFIG_NET=y \
	--kconfig_add CONFIG_AX88796B_RUST_PHY=y \
	--kconfig_add CONFIG_AX88796B_PHY=y

I got the following errors:

	ERROR:root:ld.lld: error: duplicate symbol: __rust_asix_phy_init
	>>> defined at doctests_kernel_generated.5ed8fd29a53cf22f-cgu.0
	>>>            rust/doctests_kernel_generated.o:(__rust_asix_phy_init) in archive vmlinux.a
	>>> defined at ax88796b_rust.37fb93aefca595fa-cgu.0
	>>>            drivers/net/phy/ax88796b_rust.o:(.text+0x160) in archive vmlinux.a

	ld.lld: error: duplicate symbol: __rust_asix_phy_exit
	>>> defined at doctests_kernel_generated.5ed8fd29a53cf22f-cgu.0
	>>>            rust/doctests_kernel_generated.o:(__rust_asix_phy_exit) in archive vmlinux.a
	>>> defined at ax88796b_rust.37fb93aefca595fa-cgu.0
	>>>            drivers/net/phy/ax88796b_rust.o:(.text+0x1E0) in archive vmlinux.a

	ld.lld: error: duplicate symbol: __mod_mdio__phydev_device_table
	>>> defined at doctests_kernel_generated.5ed8fd29a53cf22f-cgu.0
	>>>            rust/doctests_kernel_generated.o:(__mod_mdio__phydev_device_table) in archive vmlinux.a
	>>> defined at ax88796b_rust.37fb93aefca595fa-cgu.0
	>>>            drivers/net/phy/ax88796b_rust.o:(.rodata+0x58) in archive vmlinux.a

Because kunit will use the above doc test to generate test, and since
CONFIG_AX88796B_RUST_PHY is also selected, the `module_phy_driver!` has
been called twice, and causes duplicate symbols.

For "rust_asix_phy_*" symbols, it's easy to fix: just rename the usage
in the example. But for __mod_mdio__phydev_device_table, it's hard-coded
in `module_phy_driver!`, I don't have a quick fix right now. Also, does
it mean `module_phy_driver!` is only supposed to be "called" once for
the entire kernel?

Regards,
Boqun

