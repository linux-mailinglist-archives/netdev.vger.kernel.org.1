Return-Path: <netdev+bounces-238512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E91ECC5A3F8
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 22:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFD674E9D2D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 21:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8489C2D5921;
	Thu, 13 Nov 2025 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ASSQqE1F"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A294502F
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763070423; cv=none; b=WyttEKbkA1VesSDHPFC4joHNs2VqRAqvt2T/trgTBDUG3iJXZm9UGrSW5+Iyje/+zzH95udxu5tOcSQpV3FnWbkzfFxwScacWAHRWic26H1nzWanPcLNDrYdaIsa48AA/9bzyTsjAJN0MgbIl03GYliX6qNwEb//jblzN7p7rGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763070423; c=relaxed/simple;
	bh=R0PKj13y2eGWfmcDyUH4hf+6rv+9bVv2mYSmRDkEyJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVUg5EeKRbprZXKQZ6Z4mREFhU7qAbcOdY0YPcQyxjk7KXOgSWbP9TXNsH5XW+pS5XB7vtyUe9KLSlBzgLmM4+sb4yp2ZeCZy/pTbgCPYNkCBev7lLE1tedR50iuEpuqyBOV2zJjnPshgL/0chUVPhAyLNlavM+Lq+E5ekF7U0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ASSQqE1F; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vBgdZiZYbDqlhcZubzwVA9BQujHuJ2EGuykdkz8RkGk=; b=ASSQqE1FrRvE3ZGVFQiC9w0/VQ
	B3VhkYK6HveImXRgTYnaDcwQQQdJoHa37sv3+ebOw300pLDTQ+SorpMnmGH5saNKb/kvY/1haJNH8
	Nj7OuS40oiW/cMNWcyIOZ6ABpn2dSGtC2g8Xqc8a7OyqsBQrOPGpMC6vmpQQinebklr1EJKaizQ4G
	DtnfsZrXyVRksBaqMg2RF6rMcUgJcoRbpfvr3KY+zHVyCJdw3Kk12hcwlmK1Z9Ze2kXeOL9VFl5LI
	uE5Cplk1yq9i2UBTAOFDNaETXry+8XoOJGUaOxThnSbARW0U8UnnHLQz2ghr9h9LdMBW/jOjiCFEX
	oOBGx/xw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39364)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vJf9a-00000000628-0OIQ;
	Thu, 13 Nov 2025 21:46:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vJf9W-000000005E9-3ZN4;
	Thu, 13 Nov 2025 21:46:50 +0000
Date: Thu, 13 Nov 2025 21:46:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	netdev@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 0/2] net: phy: disable EEE on TI PHYs
Message-ID: <aRZRypeHRvks6Hqw@shell.armlinux.org.uk>
References: <aRXAnpzsvmHQu7wc@shell.armlinux.org.uk>
 <4ed5da1d-1d2f-49ea-918e-2455573066ee@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ed5da1d-1d2f-49ea-918e-2455573066ee@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 13, 2025 at 09:11:32PM +0100, Heiner Kallweit wrote:
> On 11/13/2025 12:27 PM, Russell King (Oracle) wrote:
> > Hi,
> > 
> > Towards the end of October, we discussed EEE on TI PHYs which seems to
> > cause problems with the stmmac hardware. This problem was never fully
> > diagnosed, but it was identified that TI PHYs do not support LPI
> > signalling, but report that EEE is supported, and they implement the
> > advertisement registers and that functionality.
> > 
> > This series allows PHY drivers to disable EEE support.
> > 
> > v2:
> > - integrate Oleksij Rempel's review comments, and merge update
> >   into patch 2 to allow EEE on non-1G variants.
> > 
> >  drivers/net/phy/dp83867.c    |  1 +
> >  drivers/net/phy/dp83869.c    |  1 +
> >  drivers/net/phy/phy-core.c   |  2 --
> >  drivers/net/phy/phy_device.c | 32 +++++++++++++++++++++++++++++---
> >  include/linux/phy.h          |  1 +
> >  5 files changed, 32 insertions(+), 5 deletions(-)
> > 
> 
> Alternatively the PHY driver could call phy_disable_eee()
> in its config_init. Then we wouldn't have to touch core code.

If that's what you intend, then please update the kerneldoc for
phy_disable_eee() so that it doesn't state that it's for MAC use
(because that implies it's not for PHY drivers.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

