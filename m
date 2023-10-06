Return-Path: <netdev+bounces-38606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71C07BBA5C
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1381A1C202E8
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ED114017;
	Fri,  6 Oct 2023 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ojCqw3Y6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FB926E05;
	Fri,  6 Oct 2023 14:35:37 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83163CA;
	Fri,  6 Oct 2023 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kKfx47fCkhJedgI0pV3Mmb8FdvLnLdQ41ephI4q9c+E=; b=ojCqw3Y6KzNSAk+wWv0XLorpb7
	T7EuCyGabZsD/4wkNqC515OAS6v3A6E62xnmE92pTHGnmYYRUjFG3klqs5hT16MTPJvWfMy4JqJgd
	T7IRzZpgv84R4NdLJu05YgxAn+aIeMyQIJGLMRNQzzblVu9IPg6jxK+8mHu2A7anuZGk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qolvM-0001gK-SS; Fri, 06 Oct 2023 16:35:28 +0200
Date: Fri, 6 Oct 2023 16:35:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
Message-ID: <19161969-1033-4fd5-9a24-ec21d66c6735@lunn.ch>
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
 <20231006094911.3305152-4-fujita.tomonori@gmail.com>
 <2023100635-product-gills-3d7e@gregkh>
 <20231006.225325.1176505861124451190.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006.225325.1176505861124451190.fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> The Kconfig file would be like the following. AX88796B_RUST_PHY
> depends on AX88796B_PHY so the description of AX88796B_PHY is enough?
> I'll add the name of the module.
> 
> 
> config AX88796B_PHY
> 	tristate "Asix PHYs"
> 	help
> 	  Currently supports the Asix Electronics PHY found in the X-Surf 100
> 	  AX88796B package.

I _think_ you can add

	depends on !AX88796B_RUST_PHY

> config AX88796B_RUST_PHY
> 	bool "Rust reference driver"
> 	depends on RUST && AX88796B_PHY

And then this becomes

    	depends on RUST && !AX88796B_PHY

> 	default n
> 	help
> 	  Uses the Rust version driver for Asix PHYs.

You then express the mutual exclusion in Kconfig, so that only one of
AX88796B_PHY and AX88796B_RUST_PHY is ever enabled.

I've not actually tried this, so it might not work. Ideally you need
to be able disable both, so that you can enable one.

There is good documentation in

Documentation/kbuild/kconfig-language.rst

> >> +ifdef CONFIG_AX88796B_RUST_PHY
> >> +  obj-$(CONFIG_AX88796B_PHY)	+= ax88796b_rust.o
> >> +else
> >> +  obj-$(CONFIG_AX88796B_PHY)	+= ax88796b.o
> >> +endif
> > 
> > This can be expressed in Kconfig, no need to put this here, right?
> 
> Not sure. Is it possible? If we allow both modules to be built, I
> guess it's possible though.

If what i suggested above works, you don't need the ifdef, just list
the two drivers are normal and let Kconfig only enable one at most.
Or go back to your idea of using choice. Maybe something like

choice
	tristate "AX88796B PHY driver"

	config CONFIG_AX88796B_PHY
		bool "C driver"

	config CONFIG_AX88796B_RUST_PHY
	        bool "Rust driver"
		depends on RUST
endchoice

totally untested....

	Andrew

