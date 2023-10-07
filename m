Return-Path: <netdev+bounces-38716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83957BC341
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 02:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5E31C20957
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 00:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ED6184;
	Sat,  7 Oct 2023 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ew8BKZk3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFB8163;
	Sat,  7 Oct 2023 00:20:32 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4487BD;
	Fri,  6 Oct 2023 17:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pc12asmd1hUYs6fygbwA/q1wrrG0xzU9XLDEwVoLCNw=; b=ew8BKZk3FcWu9oK9gYWLy8AGMY
	moEShzGVBJdvjL54/H6ohBifrwiBfPT7PBaSqBrTqEZA8k5xDTIhpVCr0tuWIO5oJ7wQl8IqogOv9
	MruAt89U3OdrNlCslgbIDnDO+sfFTCkDleTH/y6klnYloBSFhWinFeQ7+yAkS1Zp4PGc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qov3R-0009UC-Rd; Sat, 07 Oct 2023 02:20:25 +0200
Date: Sat, 7 Oct 2023 02:20:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
Message-ID: <bafa74fb-0b5b-4215-b702-8dd6799fef55@lunn.ch>
References: <3db1ad51-a2a0-4648-8bc5-7ed089a4e5dd@lunn.ch>
 <20231007.012100.297660999016269225.fujita.tomonori@gmail.com>
 <a8625fd5-6083-4a4d-872a-c755c214b891@lunn.ch>
 <20231007.085400.1040380280563980814.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007.085400.1040380280563980814.fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 07, 2023 at 08:54:00AM +0900, FUJITA Tomonori wrote:
> On Fri, 6 Oct 2023 18:55:23 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> >> How about adding CONFIG_RUST_PHYLIB to the first patch. Not
> >> selectable, it's just a flag for Rust PHYLIB support.
> > 
> > We have to be careful with names. To some extent, CONFIG_PHYLIB means
> > the core of phylib. So it could be that CONFIG_RUST_PHYLIB means the
> > core of phylib written in rust? I doubt that will ever happen, but we
> > are setting a naming scheme here which i expect others will blindly
> > cut/paste. What we actually want is a symbol which represents the Rust
> > binding onto the phylib core. So i think it should have BINDING, or
> > WRAPPER or something like that in the name.
> 
> Good point. Let's save CONFIG_PHYLIB for someday.
> 
> 
> >> diff --git a/init/Kconfig b/init/Kconfig
> >> index 4b4e3df1658d..2b6627aeb98c 100644
> >> --- a/init/Kconfig
> >> +++ b/init/Kconfig
> >> @@ -1889,7 +1889,7 @@ config RUST
> >>  	depends on !GCC_PLUGINS
> >>  	depends on !RANDSTRUCT
> >>  	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
> >> 	depends on PHYLIB=y
> >> +	select RUST_PHYLIB
> > 
> > I know the rust build system is rather limited at the moment, but is
> > this required? Is it possible to build the rust code without the
> > phylib binding? Can your `RUST_PHYLIB` add phylib.rs to a Makefile
> > target only if it is enabled?
> 
> A short-term solution could work, I think.
> 
> config RUST
> 	bool "Rust support"
> 	depends on HAVE_RUST
> 	depends on RUST_IS_AVAILABLE
> 	depends on !MODVERSIONS
> 	depends on !GCC_PLUGINS
> 	depends on !RANDSTRUCT
> 	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
> 	select CONSTRUCTORS
> 	help
> 	  Enables Rust support in the kernel.
> 
> 	  This allows other Rust-related options, like drivers written in Rust,
> 	  to be selected.
> 
> 	  It is also required to be able to load external kernel modules
> 	  written in Rust.
> 
> 	  See Documentation/rust/ for more information.
> 
> 	  If unsure, say N.
> 
> config RUST_PHYLIB_BINDING
> 	bool "PHYLIB bindings support"
> 	depends on RUST
> 	depends on PHYLIB=y
> 	help
>           Adds support needed for PHY drivers written in Rust. It provides
>           a wrapper around the C phlib core.
> 
> 
> Then we can conditionally build build the PHYLIB bindings.
> 
> diff --git a/rust/kernel/net.rs b/rust/kernel/net.rs
> index fbb6d9683012..33fc1531a6c0 100644
> --- a/rust/kernel/net.rs
> +++ b/rust/kernel/net.rs
> @@ -2,4 +2,5 @@
> 
>  //! Networking.
> 
> +#[cfg(CONFIG_RUST_BINDINGS_PHYLIB)]
>  pub mod phy;

This looks reasonable. If you spin a new version with all these
Kconfig changes, i will do some compile testing.

	Andrew

