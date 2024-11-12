Return-Path: <netdev+bounces-144222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB82B9C61AE
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 20:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626A0283C23
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 19:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF3021503E;
	Tue, 12 Nov 2024 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="juduWgP0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C23220B218;
	Tue, 12 Nov 2024 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440630; cv=none; b=PG1tf3NSI8ILU1iEny6Tm8EnFxVcySNIj5LZCd5IOyRxCGKtBSKOz4IrG5bssdmdlAd5CwxVBj0oeD4VGiYfNx7WlbJY90R4N3MW4YFdCbrdUkdfxElo8MUzPRgXHgSrFT9ErBjF0DkR6LXRnQNjDEOds4TSa0hUt9jX04ZA4C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440630; c=relaxed/simple;
	bh=BeDSDoXPcPdLZNULBBBx2ulxSWrYGcd9EVpAudDaIx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxWKuMvcvrHTC4ISQGsMfq+1QXGAzVmwwwAApqyl1yn7YzNSxwvy64EMkh8oEUbxY6Z64HGsh8EBjXCYZ64LgENEXSMVJPetwdLO5OYp4z8B1k9RXcSN27dmqRgQ5TupztLEmwCE3TbqvfaS6U1Kc4yp1/kpj5uh0PYtPWdAqD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=juduWgP0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YSQXibYKsgFeeFgY2M4dFECJ3n26gpZRHHkGSthk2yo=; b=juduWgP0JfB4DsEUOY0m/jPCvG
	nm3PJVq288H7QLH15qaIlX6RlOqI39tcgVOxIzCP5XYLrEacj7DCx6+Y+ZH/sdkrQhk9pgifd3rpg
	gcp9gItA9FdOPA+kvoBZng8Of/DxuHZQ/LZ7gc4mSjVDDCdKDO1UgF/uFOdiTh/GXFtg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tAwnf-00D4mw-PT; Tue, 12 Nov 2024 20:43:43 +0100
Date: Tue, 12 Nov 2024 20:43:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	imx@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: Initialize ethernet phy in low power mode before ndo_open
Message-ID: <c16c6440-bf79-42a1-a330-68d9bb96f75c@lunn.ch>
References: <4t7npxg4jxxoeemcat3besmrfn6sbgsgoolpxbw5asfxfj7xxl@inac2mylgpzl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4t7npxg4jxxoeemcat3besmrfn6sbgsgoolpxbw5asfxfj7xxl@inac2mylgpzl>

On Tue, Nov 12, 2024 at 01:36:37PM +0100, Sean Nyekjaer wrote:
> Hi,
> 
> I'm using a imx6ull, we have an unused ethernet on our board. We would
> like it to use as little power as possible as it's battery operated.
> During probe I would expect the ethernet driver to probe the phy
> deivce and set it in low power mode (BMCR_PDOWN).
> The bit is correcly set if I up/down the interface, is that prefered
> behavior?
> 
> I can see it's the same stmmac driver for stm32mp1 etc.
> 
> I can also set the phy in low power mode in the bootloader, but then the
> fec driver would reset phy and we end up where we started.

There are conflicting requirements here. Most users want the interface
up as quickly as possible. Autoneg takes a little over 1 second, which
if you force the interface down in probe means open will take up to 1
second longer before the interface is usable.

Few users want minimal power requirements, which is the conflicting
requirement.

Changing the default is going to cause regressions and developers will
complain their board takes longer to boot. So your best bet is to
up/down the unused interface. Or if you don't need it at all, mark it
as disabled in DT.

	Andrew


