Return-Path: <netdev+bounces-48997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCF67F050C
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 10:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE52C1C203A7
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 09:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6C2538F;
	Sun, 19 Nov 2023 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GN2KbZLv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BCE10F5;
	Sun, 19 Nov 2023 01:44:42 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6bcdfcde944so1006493b3a.1;
        Sun, 19 Nov 2023 01:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700387081; x=1700991881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Os71NIU9g6N4qgyMt2S7CVvxdS/GIju2V1dJNj1orWc=;
        b=GN2KbZLvwmH0R+SxYSVbD4yj/pTNb8EPQ7u2lBXVMExuTw44iEL1u9yuPU+8oAmbaD
         AE99udILFbRy2UtC6O6XUkysn9QHiBJttpgTVOix2GGRhnr2Ex+xfpIHW84HEfWodNEz
         Rut7K/karqTWF0Ji7/0sD2Wu+TdGox68ZcQ6HweKLX8R7IrWP2nLO/b1zQ0n3Z89V6tN
         WTOqLP3BYU/gCq8CzmASbA/+lfDIPGnGbK8Ml5ZVjta9P7YDj/qJiIHb1xoP8XlWmYxy
         BxPbOCqsUiK0yIZYTiO01sk42Wg28bifoMtq+lowvCdFNtIrCNryiIk25ZeQXwJmqszn
         a2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700387081; x=1700991881;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Os71NIU9g6N4qgyMt2S7CVvxdS/GIju2V1dJNj1orWc=;
        b=Tz8GJd/Jw8lcs1eDvveBz08YoWoMl8A+RuHYf5Ki7/wbcyHXjls9ha5B3ReMqzQc9B
         SBi0byX7TqcRLl2bu6zy3MkvxmmSrSGJrN9387QI5kzj+QJkBNI9l8BrvgGWih0KVnCa
         6Ojj57Wuix9WqT/gZiolylxuHY973RGaZ2IOkdaSCdhel5xHSySi6n75MHWjE7LAP1/u
         FoQDeHg65l+jD1Akf2tIC+0TRHzQAeZTvFlb6iDalTLMq0yprwD4oTrfNBzjwEuNo4G4
         wnTKl6t0mU27jQIH96pH7E4MtQEf12lT0nvWakzx0gK3f2QV9NReiucf6HFhrnF5YYc5
         W3Hg==
X-Gm-Message-State: AOJu0YyQzhgMJ3/B5s0EOOSROfqCCIA2ynvZRwDcYS4kv4EqU3HisYpA
	WUZyJLz6u0XmOPE5Mu/awk0=
X-Google-Smtp-Source: AGHT+IFjMlOWOD8sjPTp9rFyY+YQnRI5SgPp9SLq4uZKg3shjGCr8+SjYPWOa5c+NqYcrSWJiDn9YQ==
X-Received: by 2002:a17:903:22c1:b0:1cf:5806:5634 with SMTP id y1-20020a17090322c100b001cf58065634mr2582235plg.1.1700387081354;
        Sun, 19 Nov 2023 01:44:41 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b001bf044dc1a6sm4096532plh.39.2023.11.19.01.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 01:44:41 -0800 (PST)
Date: Sun, 19 Nov 2023 18:44:40 +0900 (JST)
Message-Id: <20231119.184440.1005320869494044991.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 2/5] rust: net::phy add module_phy_driver
 macro
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZVfncj5R9-8aU7vB@boqun-archlinux>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
	<20231026001050.1720612-3-fujita.tomonori@gmail.com>
	<ZVfncj5R9-8aU7vB@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 17 Nov 2023 14:21:38 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> When run the following kunit command:
> 
> ./tools/testing/kunit/kunit.py run --make_options LLVM=1 --arch x86_64 \
> 	--kconfig_add CONFIG_RUST=y \
> 	--kconfig_add CONFIG_RUST_PHYLIB_ABSTRACTIONS=y \
> 	--kconfig_add CONFIG_PHYLIB=y \
> 	--kconfig_add CONFIG_NETDEVICES=y \
> 	--kconfig_add CONFIG_NET=y \
> 	--kconfig_add CONFIG_AX88796B_RUST_PHY=y \
> 	--kconfig_add CONFIG_AX88796B_PHY=y
> 
> I got the following errors:
> 
> 	ERROR:root:ld.lld: error: duplicate symbol: __rust_asix_phy_init
> 	>>> defined at doctests_kernel_generated.5ed8fd29a53cf22f-cgu.0
> 	>>>            rust/doctests_kernel_generated.o:(__rust_asix_phy_init) in archive vmlinux.a
> 	>>> defined at ax88796b_rust.37fb93aefca595fa-cgu.0
> 	>>>            drivers/net/phy/ax88796b_rust.o:(.text+0x160) in archive vmlinux.a
> 
> 	ld.lld: error: duplicate symbol: __rust_asix_phy_exit
> 	>>> defined at doctests_kernel_generated.5ed8fd29a53cf22f-cgu.0
> 	>>>            rust/doctests_kernel_generated.o:(__rust_asix_phy_exit) in archive vmlinux.a
> 	>>> defined at ax88796b_rust.37fb93aefca595fa-cgu.0
> 	>>>            drivers/net/phy/ax88796b_rust.o:(.text+0x1E0) in archive vmlinux.a
> 
> 	ld.lld: error: duplicate symbol: __mod_mdio__phydev_device_table
> 	>>> defined at doctests_kernel_generated.5ed8fd29a53cf22f-cgu.0
> 	>>>            rust/doctests_kernel_generated.o:(__mod_mdio__phydev_device_table) in archive vmlinux.a
> 	>>> defined at ax88796b_rust.37fb93aefca595fa-cgu.0
> 	>>>            drivers/net/phy/ax88796b_rust.o:(.rodata+0x58) in archive vmlinux.a
> 
> Because kunit will use the above doc test to generate test, and since
> CONFIG_AX88796B_RUST_PHY is also selected, the `module_phy_driver!` has
> been called twice, and causes duplicate symbols.
> 
> For "rust_asix_phy_*" symbols, it's easy to fix: just rename the usage
> in the example.

Surely, done.

> But for __mod_mdio__phydev_device_table, it's hard-coded
> in `module_phy_driver!`, I don't have a quick fix right now. Also, does
> it mean `module_phy_driver!` is only supposed to be "called" once for
> the entire kernel?

As I wrote in another mail, I fixed this.

