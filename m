Return-Path: <netdev+bounces-65565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA2F83B088
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 18:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F52F1F24D89
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 17:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09E6129A93;
	Wed, 24 Jan 2024 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u5/EEmG5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1781B12A152
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118759; cv=none; b=qskhYWtzOv71s4yHqQYnJ7viZcgGvfP75DaABmchGidRc9CscAUULCiWc+07N1ZH3B/v3yd8d/Xa7fgBNKRZKUJS7TfSKunF8v1nxXXOzqmXKM1u3Qw8VacbKi+j0pSuB0qKV6E47zuhzaznJ2jIUHU2p+4X4eFCp6i8+h5Lh8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118759; c=relaxed/simple;
	bh=Gopisa6ia6e3M5Hep3D5tEDD+hYStJChcRlWI+zWbXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3PUfADcp4E9FtT08b5gx18rZp+vhRN9WLpn4fqFjOId1wLqoWF+5G/rChCZt02e2ybVQM9pRvn7WTjj4wBcgNOvXF+w4k9lUdoiwXY/IQAWOX34q2EgmxRdmT8OR7rsU3zzM3hLcdFkBkfq/8qwnS/hSietAxVS9OzTT+urhwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u5/EEmG5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mBRdRZbLl2eSZETEZstbkJq+SehwoFaIrZnUllW36ls=; b=u5/EEmG5m0i1gEDlwe8xLb93Vb
	Zp0KaD/aFMBQBPMID0MlltYHw+iDDDycVbPVXgIpGDucG2tQ7ZIyly9rFF8OHZWhGNc/4U7PagPah
	fxQ6UJYlZ2PURc3YhjCgTdvs3NUHSUQQGoBDQrZr+Rh3oz5sMORAXvuCmuyCxIyEOY8s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rShQR-0061AQ-Hr; Wed, 24 Jan 2024 18:52:35 +0100
Date: Wed, 24 Jan 2024 18:52:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Network Development <netdev@vger.kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: Race in PHY subsystem? Attaching to PHY devices before they get
 probed
Message-ID: <c3282db2-b1e5-422a-b62f-c081042da9de@lunn.ch>
References: <bdffa33c-e3eb-4c3b-adf3-99a02bc7d205@gmail.com>
 <a9e79494-b94a-40f7-9c28-22b6220db5c2@lunn.ch>
 <Za6eMg0y2QxogfmD@shell.armlinux.org.uk>
 <65b12597.050a0220.66e91.7b3b@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b12597.050a0220.66e91.7b3b@mx.google.com>

> Well if we start having more and more PHY that require loading a FW then
> this will become a big problem...
> 
> I wasted some good time on this and if the MDIO is slow enough loading
> the FW can take even 100s resulting in probe still having to finish and
> config_init called later.

If its going to take 100s of seconds, i don't think we can have
'ip set link up' stall for that long. It needs to return an error code,
and hopefully a useful error message asking the user to throw the machine
away and get a better one!

> Since the FW has not been loaded config_init returns bad data and fails
> to configure. (and after a while probe is complete)
> 
> I don't know if it would be ok as a solution but I think moving the
> fw_load call in the config_init seems to "handle" this problem but IMHO
> it's still and hack for a fragile implementation.

Just throwing out ideas, but i think we need to split this into two
different use cases:

1) Firmware loading is fast, only 1-2 seconds. We can block operations
on the PHY until it is ready

2) Firmware loading is slow, we return -EBUSY or -EAGAIN, or similar.

Maybe we could add a struct completion to struct phy_device, which has
compete() called on it when probe finishes. phy_attach_direct() does a
wait_for_completion_timeout()?

This is assuming we cannot actually fix phylib to correctly use the
driver model, PHYs are not visible until probe is complete, and the
MAC drivers can handle that.

	Andrew

