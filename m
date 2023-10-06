Return-Path: <netdev+bounces-38530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D247BB547
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FEB282200
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 10:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC7C11730;
	Fri,  6 Oct 2023 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i122yJp6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4A21C296;
	Fri,  6 Oct 2023 10:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36B4C433C8;
	Fri,  6 Oct 2023 10:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696588322;
	bh=5Z6FbpvSWqYW39gaTXVzZcm8RSENORgYCe3p8oowV8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i122yJp6UhVSV7Hdjj8wpNNXk6il2mfCSwwCJB0RRdNsH09OAWKWYgL3/7c8wy/78
	 AsT5qDEFqxoOireypYBwJHsMKMfetR147tZOrR6o37vhN2Ct/gfv9Z6TuEDAzQf954
	 CJgW55CphcXv24/erWRLzFKPt9o6OJ3mGy7ouNxw=
Date: Fri, 6 Oct 2023 12:31:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
Message-ID: <2023100635-product-gills-3d7e@gregkh>
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
 <20231006094911.3305152-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006094911.3305152-4-fujita.tomonori@gmail.com>

On Fri, Oct 06, 2023 at 06:49:11PM +0900, FUJITA Tomonori wrote:
> +config AX88796B_RUST_PHY
> +	bool "Rust reference driver"
> +	depends on RUST && AX88796B_PHY
> +	default n

Nit, "n" is always the default, there is no need for this line.

> +	help
> +	  Uses the Rust version driver for Asix PHYs.

You need more text here please.  Provide a better description of what
hardware is supported and the name of the module if it is built aas a
module.

Also that if you select this one, the C driver will not be built (which
is not expressed in the Kconfig language, why not?

> +
>  config BROADCOM_PHY
>  	tristate "Broadcom 54XX PHYs"
>  	select BCM_NET_PHYLIB
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index c945ed9bd14b..58d7dfb095ab 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -41,7 +41,11 @@ aquantia-objs			+= aquantia_hwmon.o
>  endif
>  obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia.o
>  obj-$(CONFIG_AT803X_PHY)	+= at803x.o
> -obj-$(CONFIG_AX88796B_PHY)	+= ax88796b.o
> +ifdef CONFIG_AX88796B_RUST_PHY
> +  obj-$(CONFIG_AX88796B_PHY)	+= ax88796b_rust.o
> +else
> +  obj-$(CONFIG_AX88796B_PHY)	+= ax88796b.o
> +endif

This can be expressed in Kconfig, no need to put this here, right?

>  obj-$(CONFIG_BCM54140_PHY)	+= bcm54140.o
>  obj-$(CONFIG_BCM63XX_PHY)	+= bcm63xx.o
>  obj-$(CONFIG_BCM7XXX_PHY)	+= bcm7xxx.o
> diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_rust.rs
> new file mode 100644
> index 000000000000..d11c82a9e847
> --- /dev/null
> +++ b/drivers/net/phy/ax88796b_rust.rs
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0

No copyright line?  Are you sure?

thanks,

greg k-h

