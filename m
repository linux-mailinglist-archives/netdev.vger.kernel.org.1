Return-Path: <netdev+bounces-38607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4617BBA6C
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8297B1C20A11
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C8D1A5A1;
	Fri,  6 Oct 2023 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bB+eX+Fq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF83E19472;
	Fri,  6 Oct 2023 14:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54D2C433C8;
	Fri,  6 Oct 2023 14:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696603065;
	bh=pwf12px5MIlHGrT1L/BmWU0BhsremlrF1Oy0cqYDHtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bB+eX+FqXCyvLq5GdYjlwbMjNyuLpGM2mXyLBlO4aRuYxxILekxXr93J7MMDBEF6A
	 wXHESeM3/i3qfbn9Q6RZnvTbDUzEU5JcHZkVyuMnI67UsTxupaB9M/Ez9tqqrk7MzW
	 pdz158Ea39gC+kxGaL2Ncsk34ZOucJg2KJvSq1bw=
Date: Fri, 6 Oct 2023 16:37:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
Message-ID: <2023100623-scam-gauntlet-f2ea@gregkh>
References: <2023100635-product-gills-3d7e@gregkh>
 <20231006.225325.1176505861124451190.fujita.tomonori@gmail.com>
 <2023100637-episode-espresso-7a5a@gregkh>
 <20231006.233054.318856023136859648.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006.233054.318856023136859648.fujita.tomonori@gmail.com>

On Fri, Oct 06, 2023 at 11:30:54PM +0900, FUJITA Tomonori wrote:
> On Fri, 6 Oct 2023 16:12:24 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Oct 06, 2023 at 10:53:25PM +0900, FUJITA Tomonori wrote:
> >> On Fri, 6 Oct 2023 12:31:59 +0200
> >> Greg KH <gregkh@linuxfoundation.org> wrote:
> >> 
> >> > On Fri, Oct 06, 2023 at 06:49:11PM +0900, FUJITA Tomonori wrote:
> >> >> +config AX88796B_RUST_PHY
> >> >> +	bool "Rust reference driver"
> >> >> +	depends on RUST && AX88796B_PHY
> >> >> +	default n
> >> > 
> >> > Nit, "n" is always the default, there is no need for this line.
> >> 
> >> Understood, I'll remove this line.
> >> 
> >> >> +	help
> >> >> +	  Uses the Rust version driver for Asix PHYs.
> >> > 
> >> > You need more text here please.  Provide a better description of what
> >> > hardware is supported and the name of the module if it is built aas a
> >> > module.
> >> > 
> >> > Also that if you select this one, the C driver will not be built (which
> >> > is not expressed in the Kconfig language, why not?
> >> 
> >> Because the way to load a PHY driver module can't handle multiple
> >> modules with the same phy id (a NIC driver loads a PHY driver module).
> >> There is no machinism to specify which PHY driver module should be
> >> loaded when multiple PHY modules have the same phy id (as far as I know).
> > 
> > Sorry, I know that, I mean I am pretty sure you can express this "one or
> > the other" type of restriction in Kconfig, no need to encode it in the
> > Makefile logic.
> > 
> > Try doing "depens on AX88796B_PHY=n" as the dependency for the rust
> > driver.
> 
> You meant the following?
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

Nope, that's not going to work.

And your string is wrong :(

> The problem is that there are NIC drivers that `select
> AX88796B_PHY`. the Kconfig language doesn't support something like
> `select AX88796B_PHY or AX88796B_RUST_PHY`, I guess.

You're going to have to figure out which you want to have in the system,
so if a NIC driver selects the C version, live with that.

This is just the tip of the iceburg of the mess that is "duplicate
drivers in the kernel tree" that I keep warning people about.

You all are on your own here now, good luck!

greg k-h

