Return-Path: <netdev+bounces-127836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A5A976CB9
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7165CB21C0D
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 14:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B921A706B;
	Thu, 12 Sep 2024 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dz5hjWYg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEFA1B9826;
	Thu, 12 Sep 2024 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152760; cv=none; b=lHkiB1mD5f3zansvUTFexPv9WZx2UtcLy/Z4FdOp5znaMEe0UjEUy2WZhBOrOIbn9SUU8VZnPY4Gpx6NITxYOUXwo4z+4dBq3K9SJXyi1gG8N0jf20eH6hbH6SlvVEfl3ZGIvvWxaateUGnLmoFqhDjBFbI3Fs7vdcn/oix39+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152760; c=relaxed/simple;
	bh=RLrkZs4ovEv0Httw4hEtSJK4lJfzyoHkdLeIF6nE/1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plnDrJ+AKhxpo0EHJUZzb81LXQvxiUm63MfYQWbWiJYzmmf1d45M0wE4jZMZ16qMdJ+dvsVIqbgOYS0cvg0eqeuPrFDMm307kMivdWP38PJ913AING2+YlAvMXsYUmi6o+ex+6lZJbmw9x7L0ZBFBTapQguxph8VY8xrLuo68nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dz5hjWYg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Kc5fmbqo+fknIZZUwNedqMq8aO/tfTzBtyPA+VCec8E=; b=dz5hjWYg/YABXz5BPfxyrb/XC/
	H7c/DqdvrlLKyCyuix5FRlvvGrsXF3S09CjJEAl5Vl5COlhY7HVhzsFg/rdNkpVTxwW03p7HEePVH
	GoD37ZAxU/mJTuQANKIMqmolVW1avAiObO18JoLRU3JYq5wHBJz2eXN5WZi1Qvoz+qSM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1solB3-007JiN-DA; Thu, 12 Sep 2024 16:52:09 +0200
Date: Thu, 12 Sep 2024 16:52:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, rdunlap@infradead.org,
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 1/5] net: lan743x: Add SFP support check flag
Message-ID: <e5e4659c-a9e2-472b-957b-9eee80741ccf@lunn.ch>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-2-Raju.Lakkaraju@microchip.com>
 <a40de4e3-28a9-4628-960c-894b6c912229@lunn.ch>
 <ZuKKMIz2OuL8UbgS@HYD-DK-UNGSW21.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuKKMIz2OuL8UbgS@HYD-DK-UNGSW21.microchip.com>

On Thu, Sep 12, 2024 at 11:59:04AM +0530, Raju Lakkaraju wrote:
> Hi Andrew,
> 
> Thank you for review the patches.
> 
> The 09/11/2024 19:06, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > > +     if (adapter->is_pci11x1x && !adapter->is_sgmii_en &&
> > > +         adapter->is_sfp_support_en) {
> > > +             netif_err(adapter, drv, adapter->netdev,
> > > +                       "Invalid eeprom cfg: sfp enabled with sgmii disabled");
> > > +             return -EINVAL;
> > 
> > is_sgmii_en actually means PCS? An SFP might need 1000BaseX or SGMII,
> 
> No, not really.
> The PCI11010/PCI1414 chip can support either an RGMII interface or
> an SGMII/1000Base-X/2500Base-X interface.

A generic name for SGMII/1000Base-X/2500Base-X would be PCS, or maybe
SERDES. To me, is_sgmii_en means SGMII is enabled, but in fact it
actually means SGMII/1000Base-X/2500Base-X is enabled. I just think
this is badly named. It would be more understandable if it was
is_pcs_en.

> According to the datasheet,
> the "Strap Register (STRAP)" bit 6 is described as "SGMII_EN_STRAP"
> Therefore, the flag is named "is_sgmii_en".

Just because the datasheet uses a bad name does not mean the driver
has to also use it.

	Andrew

