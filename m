Return-Path: <netdev+bounces-64680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B0C836530
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 15:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA9B284304
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 14:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1BC3D0C9;
	Mon, 22 Jan 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F6NtI5B0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D3F3D387
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932769; cv=none; b=dKeVqGZKPCFmNI01GfD/AWeZTfQp/4bqYa0QLd/rGQOOq3QdUn/C6gwTer06dXqlDqTsFqmvqVJkqZUJx4ZBe1K5CzUd3nErBO6DQ4Pz6mr2/aGAc3wFEgdnSqCBie1cWifdLsrFA7JT5BGrcEgdcsRhrjG0+wBAI5lhrm7nhR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932769; c=relaxed/simple;
	bh=mJOYvA+1SxwM6no7yOiY6qkK4+pt3GAz2CuMCCQKxYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slZiKvLjNz9ZgUCUk8LvP6S5K161iE/8oa/b8iGbcqdnJCB8Bi6VL0SLURV4CG4eaKusljYcvybSQ4Qn5P0SDxdnEVAnxv1xpWQTmJnPNYSCdFl6Ks2+Cmv74Fx5srSiiupDc52cDkYe8u+vSGlRlihLJayEzjs5yZDOkRdsAqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=F6NtI5B0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=qh4Gzy9LM0YFcLHoOf5wlPGyluZXD/iR2O6RQFVsnFI=; b=F6
	NtI5B0XT9V4A6uRY4KLs9yvgu/YXeKFqmtiKa66L/o8TBjVHvMy7dxI7SbClmNGwJqIBd6d4OciZL
	UJKbxEaE/QEPuMlQkxOktJ9QY9U40NRyqvbqBcehueFewVUkPa9GJ74V8X7p8+42QggMP3WUQSBtt
	WyuEPmbTK3vlrCc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rRv2Y-005jIV-U7; Mon, 22 Jan 2024 15:12:42 +0100
Date: Mon, 22 Jan 2024 15:12:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robimarko@gmail.com>,
	Ansuel Smith <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: Race in PHY subsystem? Attaching to PHY devices before they get
 probed
Message-ID: <a9e79494-b94a-40f7-9c28-22b6220db5c2@lunn.ch>
References: <bdffa33c-e3eb-4c3b-adf3-99a02bc7d205@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdffa33c-e3eb-4c3b-adf3-99a02bc7d205@gmail.com>

On Mon, Jan 22, 2024 at 08:09:58AM +0100, Rafał Miłecki wrote:
> Hi!
> 
> I have MT7988 SoC board with following problem:
> [   26.887979] Aquantia AQR113C mdio-bus:08: aqr107_wait_reset_complete failed: -110
> 
> This issue is known to occur when PHY's firmware is not running. After
> some debugging I discovered that .config_init() CB gets called while
> .probe() CB is still being executed.
> 
> It turns out mtk_soc_eth.c calls phylink_of_phy_connect() before my PHY
> gets fully probed and it seems there is nothing in PHY subsystem
> verifying that. Please note this PHY takes quite some time to probe as
> it involves sending firmware to hardware.
> 
> Is that a possible race in PHY subsystem?

Seems like it.

There is a patch "net: phylib: get rid of unnecessary locking" which
removed locks from probe, which might of helped, but the patch also
says:

    The locking in phy_probe() and phy_remove() does very little to prevent
    any races with e.g. phy_attach_direct(),

suggesting it probably did not help.

I think the traditional way problems like this are avoided is that the
device should not be visible to the rest of the system until probe has
completed.

Maybe look at phy_device_register(). I think it is the call to
mdiobus_register_device() which makes it visible. What i don't know is
the call path which calls probe. Is it part of device_add()? Can
mdiobus_register_device() be moved to the end of this function?

Could you add a WARN_ON(1) in the probe function to get the call
stack. With that, we might be able to figure out where the
mdiobus_register_device() needs to move.

Thanks
	Andrew

