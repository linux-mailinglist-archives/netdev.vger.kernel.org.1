Return-Path: <netdev+bounces-135203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B49099CC07
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5E91F238FC
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EC91EF1D;
	Mon, 14 Oct 2024 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MyKXdDHR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AEA18638
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914224; cv=none; b=ODJkQAd5CM7uf4FnjNmhaokDhUWccTnQK0HqLX9hX3uK6Kw7alzgerz0u8FheSNtxPUkAtq7ALkkJbTPN7DTb7Zjo2G5ThKRXvZUhTix6c4lYb41bSobcRSHyD6g15tpr9ODnVGtMSiA8WEjOnvpJDzoI1DUic5JkPO7iv66AFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914224; c=relaxed/simple;
	bh=oUtrNdjetUZuu9oYSMvw2pCbVgBEYq6T20DynLKcauM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhTufhpu1N9JLaBEo2I2TRx/69wKDDoCevEIaSmP60iZepUfKRVmRd4FjZOq/yAK91Ecy9pZT+JMOysKtlHZl5G5TEXGtExTXg8q9gJkxzlRC8gGUNsG2idcWqJyxkvLqvg2NHy/CGsikp0UX1NvNzrzt3aoIWLQtQyarauYwLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MyKXdDHR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5f7F2sZOmWBNrr5nbX40fQQmpS/m37/SRkvrI5UaOuE=; b=MyKXdDHRnDTXLZyARWAofQg1h4
	u9m4TGgChbUO7PF7QaeiVhW9xVvR5I7ZsphyL4pVMpHZuOrtCryPsZ3f7e6xk2UZG3Y3sLCOuRY/G
	8oWkCXMz12qwsMUYIo5aQWRd0rHM5CvduHdcAt/5dXtnj4X/PfaT3QgtjploLBBx4B1jcTzp8d3fm
	4HXT2OAYcxNsQnJos/3jzdhw9RQpaxAUYEZ5fpprheadP716wYo92YH5DZlUYH6iZ/0Ng+gXFXpvK
	XnVjsJEmVqvq0DLnn3byhvZxQCimG8PB8qZH6VrTfVIn20Lck/k4Fkm0CXSILxMY5H/0RT6KFcYnU
	wLAzyQ+g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45554)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t0LZ0-000278-3C;
	Mon, 14 Oct 2024 14:56:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t0LYy-0003Kl-2g;
	Mon, 14 Oct 2024 14:56:44 +0100
Date: Mon, 14 Oct 2024 14:56:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Gerhard Engleder <gerhard@engleder-embedded.com>, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next] net: phy: micrel: Improve loopback support
 if autoneg is enabled
Message-ID: <Zw0jHKKt6z4O3D5U@shell.armlinux.org.uk>
References: <20241013202430.93851-1-gerhard@engleder-embedded.com>
 <63352ee3-f056-4e28-bc10-b6e971e2c775@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63352ee3-f056-4e28-bc10-b6e971e2c775@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Oct 14, 2024 at 03:18:29PM +0200, Andrew Lunn wrote:
> Russell's reading of 802.3 is that 1G requires autoneg. Hence the
> change. Loopback is however special. Either the PHY needs to do
> autoneg with itself, which is pretty unlikely, or it needs to ignore
> autoneg and loopback packets independent of the autoneg status.
> 
> What does 802.3 say about loopback? At least the bit in BMCR must be
> defined. Is there more? Any mention of how it should work in
> combination with autoneg?

Loopback is not defined to a great degree in 802.3, its only suggesting
that as much of the PHY data path should be exercised as possible.
However, it does state in clause 22 that the duplex bit should not
affect loopback.

It doesn't make any reference to speed or autoneg.

Given that PHYs that support multiple speeds need to have different
data paths through them, and the requirement for loopback to use as
much of the data path as possible, it does seem sensible that some
PHYs may not be able to negotiate with themselves in loopback mode,
(e.g. at 1G speeds, one PHY needs to be master the other slave, how
does a single PHY become both master and slave at the same time...)
then maybe forced speed is necessary when entering loopback.

So probably yes, when entering loopback, we probably ought to force
the PHY speed, but that gets difficult for a PHY that is down and
as autoneg enabled (what speed do we force?)

We do have the forced-settings in phy->autoneg, phy->speed and
phy->duplex even after the referred to commit, so we could use
that to switch the PHY back to a forced mode. However, I suepct
we're into PHY specific waters here - whether the PHY supports
1G without AN even in loopback mode is probably implementation
specific.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

