Return-Path: <netdev+bounces-237438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A6DC4B533
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 04:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3C6188F957
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 03:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFF360B8A;
	Tue, 11 Nov 2025 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="li5RAEK4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B93D6F;
	Tue, 11 Nov 2025 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831828; cv=none; b=FvsJ9688bkUkiyY4SDmteOjC2BvRvDvDbRu+cpIG9okOYF0Zaq7jsn6u8lDjXBQ97VNyEW4nh3Lcqtvkm4TuD9FNntw45GVT9+4R6rktsmEW+C+ynwGH9YDHetX214bXuaMbW3jiXyJMGU15KJtRDRw14zC/o8Cg4kCpKPLKlJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831828; c=relaxed/simple;
	bh=JlYn9rIy7uyj5CmPIHlFQHH3uFeD9tk9d9asndxWrRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2WVqjuCB/Tdd3aYMHpoKWOoJPCDz+CZsBJGdSbjrhiXVe8hZEd3dhkYh610r6P4qYRPiqOG6EAnvcXIxsu4e9eBOTy0mUhJJsKFmjWX4matDESlzIBRyZopxQoKxudgBBkygiy6/5CGfcLHbEdb1xOBf37E2uTY2vUQLaYXeN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=li5RAEK4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HW5zNTSs91UiAOz4S9gU+9c/0Itm3O1nWh1VBzNeF+0=; b=li5RAEK4Ot2b7NpWpJAT6oimFX
	aMLDZKbm/8g9ln8eSjgxmoAur9H+uT9N21oTHrluWXoNaYbc5MCcw125cH9Db11O5yCNpUgzPhc9T
	aqwWc7sVLADrHYrrSjGGR/hHMZYjxDyaT6LC/JVlZkAYnknLzAMrBztYnwk/b7Jj6Tug=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vIf5H-00DaMn-49; Tue, 11 Nov 2025 04:30:19 +0100
Date: Tue, 11 Nov 2025 04:30:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, aziz.sellami@nxp.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/3] net: enetc: add port MDIO support for
 both i.MX94 and i.MX95
Message-ID: <4ef9d041-2572-4a8d-9eb8-ddc2c05be102@lunn.ch>
References: <20251105043344.677592-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105043344.677592-1-wei.fang@nxp.com>

On Wed, Nov 05, 2025 at 12:33:41PM +0800, Wei Fang wrote:
> >From the hardware perspective, NETC IP has only one external master MDIO
> interface (eMDIO) for managing external PHYs. The EMDIO function and the
> ENETC port MDIO are all virtual ports of the eMDIO.
> 
> The difference is that EMDIO function is a 'global port', it can access
> all the PHYs on the eMDIO, so it provides a means for different software
> modules to share a single set of MDIO signals to access their PHYs.
> 
> But for ENETC port MDIO, each ENETC can access its set of registers to
> initiate accesses on the MDIO and the eMDIO arbitrates between them,
> completing one access before proceeding with the next. It is required
> that each ENETC port MDIO has exclusive access and control of its PHY.
> Therefore, we need to set the external PHY address for ENETCs, so that
> its port MDIO can only access its own PHY. If the PHY address accessed
> by the port MDIO is different from the preset PHY address, the MDIO
> access will be invalid.
> 
> Normally, all ENETCs use the interfaces provided by the EMDIO function
> to access their PHYs, provided that the ENETC and EMDIO are on the same
> OS. If an ENETC is assigned to a guest OS, it will not be able to use
> the interfaces provided by the EMDIO function, so it must uses its port
> MDIO to access and manage its PHY.

I think i'm slowly starting to understand this. But i'm still missing
some parts.

What prevents a guest OS from setting the wrong value in its ENETC
port MDIO and then accessing any PHY on the physical bus?

I assume there is a hypervisor doing this enforcement? But if there is
a hypervisor doing this enforcement, why does the ENETC port MDIO need
programming? The hypervisor will block it from accessing anything it
should not be able to access. A normal MDIO bus scan will find just
the devices it is allowed to access.

I also think the architecture is wrong. Why is the MAC driver messing
around with the ENETC Port MDIO hardware? I assume the ENETC port MDIO
bus driver knows it is a ENETC port MDIO device it is driving? It
should be the one looking at the device tree description of its bus,
checking it has one and only one device described on the bus, and
programming itself with the device the hypervisor will let through.
Not that i think this is actually necessary, let the hypervisor
enforce it...

	Andrew

