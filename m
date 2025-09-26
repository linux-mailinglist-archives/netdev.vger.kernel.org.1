Return-Path: <netdev+bounces-226801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E8BBA53D9
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE091C008B2
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E9F2848A2;
	Fri, 26 Sep 2025 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oe8EbAlN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3687D1A2C11;
	Fri, 26 Sep 2025 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923229; cv=none; b=sz9jXXFIkKDHK3IaF2Ezhj4SgSk05UyN6bfR2f68NeJutORuZuBccbF3TFmfLUUeSQQBNo+SahcS+WfVcf7TIFNZruQOcbp6LtOVQSI++DXo2d9iKc41ULL3PNMsMRY0h7BaDR1d3qYkFt1T9woF75mPjLgHX69xSYHom8MXnMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923229; c=relaxed/simple;
	bh=xVwUsh4VEPWNSyVNEeCxRkWfKg9d4hdwW9Tq5tRZDcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOvniDzWqN3LFIQyDLqrQKKTJ8H5OUmAVN9snsNVPsHglv2lFtTOuZwlpeHs/r7EdmWnpHh7IlrKDAt/OYSNEqnxVYfIGAXQAlRIgzH5AJvX65vy8kMw1zBF7jA6+p+zv6q81/K79JPX6mo7n0pjgsLAZkny8s3FB1REFesYVQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oe8EbAlN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CDFZDYAxaFN3nhi7/HwU9S5RObSUo/2jEgabQRdF8jk=; b=oe8EbAlN9kRabbnXfuOkmcosZO
	LbkpaYIMROW0hrnfWI3U9LedmDkc9poV5KKIH4ifyGSjWq5y1Ou7f+A/VFn5u1i6b1AnOHwNzIc0D
	Hd33Q59nsNUTGxH3NYdpbJC2ARaHnUzpIGn+tvG699CAnYof/HvGKfTUOdYPyo68tr6E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v2GHA-009bGm-Nm; Fri, 26 Sep 2025 23:46:48 +0200
Date: Fri, 26 Sep 2025 23:46:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josef Raschen <josef@raschen.org>
Cc: Arun Ramadoss <arun.ramadoss@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: microchip_t1: LAN887X: Fix device init issues.
Message-ID: <0737ef75-b9ac-4979-8040-a3f1a83e974e@lunn.ch>
References: <20250925205231.67764-1-josef@raschen.org>
 <3e2ea3a1-6c5e-4427-9b23-2c07da09088d@lunn.ch>
 <6ac94be0-5017-49cd-baa3-cea959fa1e0d@raschen.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac94be0-5017-49cd-baa3-cea959fa1e0d@raschen.org>

On Fri, Sep 26, 2025 at 11:24:56PM +0200, Josef Raschen wrote:
> Hello Andrew,
> 
> Thanks for your feedback.
> 
> On 9/26/25 00:00, Andrew Lunn wrote:
> > On Thu, Sep 25, 2025 at 10:52:22PM +0200, Josef Raschen wrote:
> > > Currently, for a LAN8870 phy, before link up, a call to ethtool to set
> > > master-slave fails with 'operation not supported'. Reason: speed, duplex
> > > and master/slave are not properly initialized.
> > > 
> > > This change sets proper initial states for speed and duplex and publishes
> > > master-slave states. A default link up for speed 1000, full duplex and
> > > slave mode then works without having to call ethtool.
> > 
> > Hi Josef
> > 
> > What you are missing from the commit message is an explanation why the
> > LAN8870 is special, it needs to do something no other PHY does. Is
> > there something broken with this PHY? Some register not following
> > 802.3?
> > 
> >      Andrew
> > 
> > ---
> > pw-bot: cr
> > 
> 
> Special about the LAN8870 might be that it is a dual speed T1 phy.
> As most other T1 pyhs have only one possible configuration the unknown
> speed configuration was not a problem so far. But here, when
> calling link up without manually setting the speed before, it seems to
> pick speed 100 in phy_sanitize_settings(). I assume that this is not the
> desired behavior?

What speeds does the PHY say it supports?

phy_sanitize_settings() should pick the highest speed the PHY supports
as the default. So if it is picking 100, it suggests the PHY is not
reporting it supports 1000? Or phy_sanitize_settings() is broken for
1000Base-T1? Please try understand why it is picking 100.

> The second problem is that ethtool initially does not allow to set
> master-slave at all. You first have to call ethtool without the
> master-slave argument, then again with it. This is fixed by reading
> the master slave configuration from the device which seems to be missing
> in the .config_init and .config_aneg functions. I took this solution from
> net/phy/dp83tg720.c.

How does this work with a regular T4 or T2 PHY? Ideally, A T1 should
be no different. And ideally, we want a solution for all T1 PHYs,
assuming it is not something which is special for this PHY.

	Andrew

