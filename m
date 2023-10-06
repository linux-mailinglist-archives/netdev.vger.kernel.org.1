Return-Path: <netdev+bounces-38641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B88D77BBD52
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 18:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAFA2821A7
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CF328E23;
	Fri,  6 Oct 2023 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LXsI3yB/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9748C286B4;
	Fri,  6 Oct 2023 16:55:27 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BADC6;
	Fri,  6 Oct 2023 09:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XBLPQTyQ5AVy/jXm8OQ04sHa8uGh6ojfEJTVaQIw4XA=; b=LXsI3yB//hMlSRQsRIAqzB03+G
	MFt6pbgY5saQP8PPN0EZWl71RshO5a4Su/J/vbOykcRaZ5e5+N8pJnQ+B3VIdMi2VgbKqD5Yaf5CZ
	NJzneH7/Ewu3JbmWJfLOWbUpBjdbsmtqeRxXK+sCfANZMBOjzrtf1OiOeMKTlHjlbA1M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qoo6l-0003YD-Tx; Fri, 06 Oct 2023 18:55:23 +0200
Date: Fri, 6 Oct 2023 18:55:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
Message-ID: <a8625fd5-6083-4a4d-872a-c755c214b891@lunn.ch>
References: <19161969-1033-4fd5-9a24-ec21d66c6735@lunn.ch>
 <20231007.002609.681250079112313735.fujita.tomonori@gmail.com>
 <3db1ad51-a2a0-4648-8bc5-7ed089a4e5dd@lunn.ch>
 <20231007.012100.297660999016269225.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007.012100.297660999016269225.fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> How about adding CONFIG_RUST_PHYLIB to the first patch. Not
> selectable, it's just a flag for Rust PHYLIB support.

We have to be careful with names. To some extent, CONFIG_PHYLIB means
the core of phylib. So it could be that CONFIG_RUST_PHYLIB means the
core of phylib written in rust? I doubt that will ever happen, but we
are setting a naming scheme here which i expect others will blindly
cut/paste. What we actually want is a symbol which represents the Rust
binding onto the phylib core. So i think it should have BINDING, or
WRAPPER or something like that in the name.

> diff --git a/init/Kconfig b/init/Kconfig
> index 4b4e3df1658d..2b6627aeb98c 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1889,7 +1889,7 @@ config RUST
>  	depends on !GCC_PLUGINS
>  	depends on !RANDSTRUCT
>  	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
> 	depends on PHYLIB=y
> +	select RUST_PHYLIB

I know the rust build system is rather limited at the moment, but is
this required? Is it possible to build the rust code without the
phylib binding? Can your `RUST_PHYLIB` add phylib.rs to a Makefile
target only if it is enabled?

>  	select CONSTRUCTORS
>  	help
>  	  Enables Rust support in the kernel.
> @@ -1904,6 +1904,10 @@ config RUST
>  
>  	  If unsure, say N.
>  
> +config RUST_PHYLIB
> +	bool

This is where the depends on PHYLIB should be. It is the Rust binding
on phylib which has the dependency on phylib, not the core rust code.


What i think the end state should be, once the Rust build system is
better is that in drivers/net/phy/Kconfig we have:

if PHYLIB

config RUST_PHYLIB_BINDING
    bool
    depends on RUST
    help
      Adds support needed for PHY drivers written in Rust. It provides
      a wrapper around the C phlib core.

and the Makefile when uses this to build the binding as a kernel
module.

	Andrew

