Return-Path: <netdev+bounces-154735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BE39FF9F5
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 14:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304751883926
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 13:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F5A191489;
	Thu,  2 Jan 2025 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="547sZOfR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADC27462
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735825947; cv=none; b=AzIYxYfKwXMJYpdMAAYFwJGHdAEmrtnpQSJs689LUBCj0YM7xvRVSmpMeWIct8ZVUMkoCBmTGqY/+vONv3b1VECY40MN8gjxF5EEYOxCsY346bSSweMUWScTxfYErtq3dui9laydWa3/iLcmQrKx8YF6nwMeEKDhlwYaJVOTuKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735825947; c=relaxed/simple;
	bh=iLQmKFtdG8j/tfplLqzkX/w7+1DbZL3hsNTnKYDbr88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtK/qYTfZDbfxhWrO7fjgQMrnXmlNaM21hFzcgKlBBz5t0C7g+dK+/Rclbd+SPWEOzmOBEJ2R8vA7Qbg7fvr0TVMaZSRFgegIsskQohLqOzWFqiyoXPU3Ewra0ZVH4+baUjCjRy0+tZBsIQqcJjk7fO2a6TnyKrxt5x9ZNAgVw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=547sZOfR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xb3F6YeBISNklHg5bbeW7AOJnQRGwL4WSITUo3Z2bL0=; b=547sZOfR5NQhI8QS3fBgflstEr
	xPTo8TBc32Y59U+2v4lvM3DfcLJrMMD6zauFsKq3/29mCa6mcCHVgOSd/TfzXTkGdXDybljVVi36/
	pWzUkY8hRzoE4ZHdmcQHcXde0e3nMZcZhNmNGtQMVS/6JF2Ebje4kddTZfV8MmHdtJUU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tTLcY-000khX-Hl; Thu, 02 Jan 2025 14:52:18 +0100
Date: Thu, 2 Jan 2025 14:52:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Francesco Valla <francesco@valla.it>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: phy: don't issue a module request if a driver is
 available
Message-ID: <d5bbf98e-7dff-436e-9759-0d809072202f@lunn.ch>
References: <20250101235122.704012-1-francesco@valla.it>
 <Z3ZzJ3aUN5zrtqcx@shell.armlinux.org.uk>
 <7103704.9J7NaK4W3v@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7103704.9J7NaK4W3v@fedora.fritz.box>

On Thu, Jan 02, 2025 at 02:26:58PM +0100, Francesco Valla wrote:
> On Thursday, 2 January 2025 at 12:06:15 Russell King (Oracle) <linux@armlinux.org.uk> wrote:
> > On Thu, Jan 02, 2025 at 12:51:22AM +0100, Francesco Valla wrote:
> > > Whenever a new PHY device is created, request_module() is called
> > > unconditionally, without checking if a driver for the new PHY is already
> > > available (either built-in or from a previous probe). This conflicts
> > > with async probing of the underlying MDIO bus and always throws a
> > > warning (because if a driver is loaded it _might_ cause a deadlock, if
> > > in turn it calls async_synchronize_full()).
> > 
> > Why aren't any of the phylib maintainers seeing this warning? Where does
> > the warning come from?
> > 
> 
> I'm not sure. For me, it was pretty easy to trigger.

Please include the information how you triggered it into the commit
message.

> This is expected, as request_module() is not meant to be called from an async
> context:
> 
> https://lore.kernel.org/lkml/20130118221227.GG24579@htj.dyndns.org/
> 
> It should be noted that:
>  - the davincio_mdio device is a child of the am65-cpsw-nuss device
>  - the am65-cpsw-nuss driver is NOT marked with neither PROBE_PREFER_ASYNCHRONOUS
>    nor PROBE_FORCE_SYNCHRONOUS and the behavior is being triggered specifying
>    driver_async_probe=am65-cpsw-nuss on the command line.

So the phylib core is currently async probe incompatible. The whole
module loading story is a bit shaky in phylib, so we need to be very
careful with any changes, or you are going to break stuff, in
interesting ways, with it first appearing to work, because the
fallback genphy is used rather than the specific PHY driver, but then
breaking when genphy is not sufficient.

Please think about this as a generic problem with async probe. Is this
really specific to phylib? Should some or all of the solution to the
problem be moved into the driver core? Could we maybe first try an
async probe using the existing drivers, and then fall back to a sync
probe which can load additional drivers?

One other question, how much speadup do you get with async probe of
PHYs? Is it really worth the effort?

	Andrew

