Return-Path: <netdev+bounces-38600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3517BBA03
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8617282250
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E7D250EA;
	Fri,  6 Oct 2023 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bdwvwaRl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF491F959;
	Fri,  6 Oct 2023 14:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F786C433C8;
	Fri,  6 Oct 2023 14:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696601547;
	bh=5bSiy7MeUuv/xS7PXgRB7JPFcw8e/OWz7TBIF02ndWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdwvwaRlN6VaH0OXV6I0jY236IRe99X0gEEzRPvxsg7dLWtoJi+4jVeHvB3RLeFby
	 aqUBdx4nXGjQLhhEJ/kt5+OspwKjuyLnoz+UbckP5pgDBj3xnFaFMgVK16oPDbIIF2
	 DQrc8YLnZ05mcjOt0R1PTpSS6wiCnedpql7MaXLs=
Date: Fri, 6 Oct 2023 16:12:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
Message-ID: <2023100637-episode-espresso-7a5a@gregkh>
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

On Fri, Oct 06, 2023 at 10:53:25PM +0900, FUJITA Tomonori wrote:
> On Fri, 6 Oct 2023 12:31:59 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Oct 06, 2023 at 06:49:11PM +0900, FUJITA Tomonori wrote:
> >> +config AX88796B_RUST_PHY
> >> +	bool "Rust reference driver"
> >> +	depends on RUST && AX88796B_PHY
> >> +	default n
> > 
> > Nit, "n" is always the default, there is no need for this line.
> 
> Understood, I'll remove this line.
> 
> >> +	help
> >> +	  Uses the Rust version driver for Asix PHYs.
> > 
> > You need more text here please.  Provide a better description of what
> > hardware is supported and the name of the module if it is built aas a
> > module.
> > 
> > Also that if you select this one, the C driver will not be built (which
> > is not expressed in the Kconfig language, why not?
> 
> Because the way to load a PHY driver module can't handle multiple
> modules with the same phy id (a NIC driver loads a PHY driver module).
> There is no machinism to specify which PHY driver module should be
> loaded when multiple PHY modules have the same phy id (as far as I know).

Sorry, I know that, I mean I am pretty sure you can express this "one or
the other" type of restriction in Kconfig, no need to encode it in the
Makefile logic.

Try doing "depens on AX88796B_PHY=n" as the dependency for the rust
driver.

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
> 
> config AX88796B_RUST_PHY
> 	bool "Rust reference driver"
> 	depends on RUST && AX88796B_PHY
> 	default n
> 	help
> 	  Uses the Rust version driver for Asix PHYs.

"This is the rust version of a driver to support...  It will be
called..."

> 
> >> +
> >>  config BROADCOM_PHY
> >>  	tristate "Broadcom 54XX PHYs"
> >>  	select BCM_NET_PHYLIB
> >> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> >> index c945ed9bd14b..58d7dfb095ab 100644
> >> --- a/drivers/net/phy/Makefile
> >> +++ b/drivers/net/phy/Makefile
> >> @@ -41,7 +41,11 @@ aquantia-objs			+= aquantia_hwmon.o
> >>  endif
> >>  obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia.o
> >>  obj-$(CONFIG_AT803X_PHY)	+= at803x.o
> >> -obj-$(CONFIG_AX88796B_PHY)	+= ax88796b.o
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

see above, this is expressed in the Kconfig language and then no ifdef
is needed here at all.

thanks,

greg k-h

