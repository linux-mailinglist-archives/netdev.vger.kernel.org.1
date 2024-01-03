Return-Path: <netdev+bounces-61085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6E0822687
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 02:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB441F22EC9
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 01:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F15EC5;
	Wed,  3 Jan 2024 01:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="j3b212kF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2D046AC
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 01:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J5p8t7dzeX6bwGsHaSsGJVGk+E4NhTeOsnb9VPSZ9gg=; b=j3b212kF98g9IfDT8dNL2874eu
	RByYazuNV1UQu5v0o2cmuaa9wmIiXSKH2GpLkGA4Xgw0O5fPht+2RX7rqepvpV5odkvo2MnemUhml
	4jH1/AUnzeeie3f5u6fwow75H+sbADlcTKF8QhU4ptruWcPzP+TiU4VlMM2Xw4zlKXm8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rKq2A-004DaA-G3; Wed, 03 Jan 2024 02:27:02 +0100
Date: Wed, 3 Jan 2024 02:27:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Asmaa Mnebhi <asmaa@nvidia.com>, davem@davemloft.net,
	netdev@vger.kernel.org, davthompson@nvidia.com
Subject: Re: [PATCH v1 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Message-ID: <99a49ad0-911b-4320-9222-198a12a1280e@lunn.ch>
References: <20231226141903.12040-1-asmaa@nvidia.com>
 <ZZRZvRKz6X61eUaH@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZRZvRKz6X61eUaH@shell.armlinux.org.uk>

On Tue, Jan 02, 2024 at 06:45:17PM +0000, Russell King (Oracle) wrote:
> On Tue, Dec 26, 2023 at 09:19:03AM -0500, Asmaa Mnebhi wrote:
> > +	/* KSZ9031's autonegotiation takes normally 4-5 seconds to complete.
> > +	 * Occasionally it fails to complete autonegotiation. The workaround is
> > +	 * to restart it.
> > +	 */
> > +        if (phydev->autoneg == AUTONEG_ENABLE) {
> > +		while (timeout) {
> > +			if (phy_aneg_done(phydev))
> > +				break;
> > +			mdelay(1000);
> > +			timeout--;
> > +		};
> 
> Extra needless ;
> 
> Also.. ouch! This means we end up holding phydev->lock for up to ten
> seconds, which prevents anything else happening with phylib during
> that time. Not sure I can see a good way around that though. Andrew?

Is there any status registers which indicate energy detection? No
point doing retries if there is no sign of a link partner.

I would also suggest moving the timeout into a driver private data
structure, and rely on phylib polling the PHY once per second and
restart autoneg from that. That will avoid holding the lock for a long
time.

	Andrew

