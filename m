Return-Path: <netdev+bounces-197130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0D7AD79CA
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41CF1893171
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 18:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F6B2C325B;
	Thu, 12 Jun 2025 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oShTmNPj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E15298CC7
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749752954; cv=none; b=upE9NczmLXTe8QvLIt2mawH51SAn/vxt3503VJSAcFkMHjHG0V15HGeP5SeXYxHOUTglssSXC0qPEJb5M+zZPAUsAn9QOK1C07ylMzgsi6KXkBIQywPmMJdUPYv+ZrvManz4vTJCtjH5l+4uRzI3Gv67bH+DOD6MOzLmchaO8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749752954; c=relaxed/simple;
	bh=eHTuafaULvmIAe8SUoaFrFys5FVTmltrs6snx4C2yEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoKWt8y7dYmGfcbXu7fwlXcH6W9ybkpaYaoJDkxxdU0CkZoT3HELysg4nLKkux8AsLaQyRn9MllTGJIzCGesM3rJxM+YqPDgiAX55Z0qPH/wecNOZgsaYTKrKkECJfxmPkVFouCN10ht3HsH/nk862PmjKAB6CQSflXvR/+2OYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oShTmNPj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jX0HjYsYo0Ch4qF951psrJIyp7cyzT8WoiqYSUYftLk=; b=oShTmNPj9V+1TJXwhYSuvRhpiY
	cUXSCZMC8g8wskBS5K184Jjc16cMgsDzPajEnokLgjFCTGktAJmsN8B5uA5xll61qRUpW1bQ0CKax
	jskooNjMNvaYhbL7J9qUapsoKnImulzBadmP0Dak3/22zsBCQYpFUanymw2Iyl3Ko7ms=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPmfj-00FZyi-BR; Thu, 12 Jun 2025 20:29:07 +0200
Date: Thu, 12 Jun 2025 20:29:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Leon Romanovsky <leon@kernel.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	pabeni@redhat.com, kuba@kernel.org, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [net-next PATCH 0/6] Add support for 25G, 50G, and 100G to fbnic
Message-ID: <52be06d0-ad45-4e8c-9893-628ba8cebccb@lunn.ch>
References: <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
 <20250612094234.GA436744@unreal>
 <daa8bb61-5b6c-49ab-8961-dc17ef2829bf@lunn.ch>
 <20250612173145.GB436744@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612173145.GB436744@unreal>

> > > when the fbnic was proposed for merge, the overall agreement was that
> > > this driver is ok as long as no-core changes will be required for this
> > > driver to work and now, year later, such changes are proposed here.
> > 
> > I would say these are natural extensions to support additional speeds
> > in the 'core'. We always said fbnic would be pushing the edges of the
> > linux core support for SFP, because all other vendors in this space
> > reinvent the wheel and hide it away in firmware. fbnic is different
> > and Linux is actually driving the hardware.

> How exactly they can hide speed declarations in the FW and still support it?
 
You obviously did not spend time to look at the code and understand
what it is doing. This is used to map the EEPROM contents of the SFP
to how the PCS etc should be configured. So far, this has only been
used for speeds up to 10Gbps. This code is mostly used by SoCs, and at
the moment most SoCs inbuilt interfaces top out at 10G. fbnic is
pushing this core code to higher speeds.

You can easily hide speed declarations in firmware and still support
it because we are not talking about the ethtool API here. This is a
lower level. A FW driven device will have its own code for parsing the
SFP EEPROM and configuring the PCS etc, without needing anything from
Linux.

> In addition, it is unclear what the last sentence means. FBNIC has FW like
> any other device.

From what i have seen, it has a small amount of firmware. However,
Linux is actually controlling most of the hardware. The PCS is
controlled by linux, the SFP will be controlled by linux, the GPIOs
and I2C bus for the SFP will be controlled by Linux, all very typical
for SoC class devices, but untypical for data centre class devices. It
is also not the only one, the wangxun txgbe is doing something
similar, but at slower speeds. There is potential here for cross
pollination between these two devices/drivers.

	Andrew

