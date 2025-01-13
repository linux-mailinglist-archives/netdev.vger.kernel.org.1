Return-Path: <netdev+bounces-157746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBB2A0B88A
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97001168825
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F092397BF;
	Mon, 13 Jan 2025 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0L4eHWNZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA96F23DE97;
	Mon, 13 Jan 2025 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736775925; cv=none; b=gfa5bIzhVsz3X5bbHcqE3La+tscjvkNOddsbPtFUcEa6wLPuYZdnff8S2DpLaAICoZLS7khaPQ5a4/N2ELL4RsG8lXBwZxF4ZyOiqu1TekIYx5DDJajDAPX2E48XMtTIsUs3HF5ygWBTJ1Q9qAUf1aWuX/7Aj/rS7f2aYd9OQH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736775925; c=relaxed/simple;
	bh=2UrNOx9gcc9ankhRKxQYPz6zT2FT52cbpni1iXPDDWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdwt9KUmR0xMVYilLWpcxVT4o/rMoSNHYPkaXRIu+3elODoklyx2bHiy0GhypMLDkRnV478JSLBjHcOLwEPybQ0NYDWjA2espF5mu4roeHtkCmIO8AZGUI9kGqi10aHgipu/w5UFabKLek6IYL5vcwIYAFKcvspJJHuR+DT8gdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0L4eHWNZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ZmEz5XFIt5gc9RlqtGLJ84sSlE6hukrBWI7K+I3v9TA=; b=0L
	4eHWNZ13WkFV5c5faj6XFH0UT5HF/i0fk2lXEy0pOENGnsy2K9bOlYzgPW2acfJTxXxeJXb9hKNdS
	V2qXk9u3AROWdpQZadr8CFhI1g/eCLOibx8KtzXnSx40noFQHb/kOfncXzYZKmnNurTLgxIO1hDq/
	VSCVZcF4GrYbLGQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXKkk-0046Ya-LJ; Mon, 13 Jan 2025 14:45:14 +0100
Date: Mon, 13 Jan 2025 14:45:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 7/7] net: usb: lan78xx: Enable EEE support
 with phylink integration
Message-ID: <38ad9a25-a5b9-48ab-b92d-4c9d9f4c7d62@lunn.ch>
References: <Z35z6ZHspfSZK4U7@shell.armlinux.org.uk>
 <Z36KacKBd2WaOxfW@pengutronix.de>
 <Z36WqNGpWWkHTjUE@shell.armlinux.org.uk>
 <Z4ADpj0DlqBRUEK-@pengutronix.de>
 <Z4AG7zvIvQDv3GTn@shell.armlinux.org.uk>
 <Z4AJ4bxLePBbbR2u@pengutronix.de>
 <Z4ARB96M6KDuPvv8@shell.armlinux.org.uk>
 <80925b27-5302-4253-ad6d-221ba8bf45f4@lunn.ch>
 <Z4UKHp0RopBT5gpI@pengutronix.de>
 <Z4UVQRHqk8ND984c@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4UVQRHqk8ND984c@shell.armlinux.org.uk>

On Mon, Jan 13, 2025 at 01:29:37PM +0000, Russell King (Oracle) wrote:
> On Mon, Jan 13, 2025 at 01:42:06PM +0100, Oleksij Rempel wrote:
> > On Thu, Jan 09, 2025 at 08:33:07PM +0100, Andrew Lunn wrote:
> > > > Andrew had a large patch set, which added the phylib core code, and
> > > > fixed up many drivers. This was taken by someone else, and only
> > > > Andrew's core phylib code was merged along with the code for their
> > > > driver, thus breaking a heck of a lot of other drivers.
> > > 
> > > As Russell says, i did convert all existing drivers over the new
> > > internal API, and removed some ugly parts of the old EEE core code.
> > > I'm not too happy we only got part way with my patches. Having this in
> > > between state makes the internal APIs much harder to deal with, and as
> > > Russell says, we broke a few MAC drivers because the rest did not get
> > > merged.
> > > 
> > > Before we think about extensions to the kAPI, we first need to finish
> > > the refactor. Get all MAC drivers over to the newer internal API and
> > > remove phy_init_eee() which really does need to die. My patches have
> > > probably bit rotted a bit, but i doubt they are unusable. So i would
> > > like to see them merged. I would however leave phylink drivers to
> > > Russell. He went a slight different way than i did, and he should get
> > > to decide how phylink should support this.
> > 
> > Hi Andrew,
> > 
> > Ok. If I see it correctly, all patches from the
> > v6.4-rc6-net-next-ethtool-eee-v7 branch, which I was working on, have been
> > merged by now. The missing parts are patches from the
> > v6.3-rc3-net-next-ethtool-eee-v5 branch.
> > 
> > More precisely, the following non-phylink drivers still need to be addressed:
> > drivers/net/ethernet/broadcom/asp2
> > drivers/net/ethernet/broadcom/genet
> > drivers/net/ethernet/samsung/sxgbe
> > drivers/net/usb/lan78xx - this one is in progress
> > 
> > Unfortunately, I won’t be able to accomplish this before the merge window, as I
> > am currently on sick leave. However, I promise to take care of it as soon as
> > possible.
> 
> Does any of this include mvneta?

Hi Russell 

I asked Oleksij to skip MAC drivers using phylink. I'm not sure it
makes sense to merge my phylink changes for EEE and then replace them
with your EEE implementation.

	Andrew

