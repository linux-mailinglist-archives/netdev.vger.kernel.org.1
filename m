Return-Path: <netdev+bounces-157446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC1EA0A521
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 18:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDD318881BB
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 17:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C5F1B4147;
	Sat, 11 Jan 2025 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rm4NYFZq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4488634
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736617560; cv=none; b=mazhQLemXXZEUB6UGeZX6+4L2BDVbJwKPUCuKJ8JmFqUrqLSJMnn9tSSYofTaWJ4vow7/0iBbFy6DD+VJnRwtE6uSPQSspD+zIAubRm0A8WaGK+EdvPrrH1a6aTC51p04Ly5dTBeaQyV0bRUzAYfLDvSVd+wa7/LnNupCTU5Xr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736617560; c=relaxed/simple;
	bh=7jDrEquFEk1U5NhB9tFmIsXgGjcga24jga01WuEUX04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLcxSd2XOQNXBH7Ei9Jwe1b9X+AMveL3FDLmz5gLlriaURRbCbMAz+TnJT/adjU+Wkry0bjPUQz5yMFZEOjNrpKwIdXYNpItI4lwk58zKK+7LAQtUlnwE1HOyxK0C3rN6PCSMZpQo4df+Y5EwGjiUuRcu9U5biBoNirjnqtsN1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rm4NYFZq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UKlktVgaR96X3jU4aSAT0bD/+kMi0sorgxa2a/M+thQ=; b=rm4NYFZq//sbrOL21JCeM0jMZX
	MQoOjnb1nVNnUPLgbAPtsi3JvO/27XCAZJrub7FL/Yz5yPZjwEIQ1FrFb7jOPaMeqFc6LY/aUIDlz
	IqBVj0x67k/APpex+mRZYCiezq5n7YiSBkZznPZrcwgdZjQ36f8iUF6VC7ljoFuOhsAAG58VzSHNS
	XVwwQ/3XiYxmvpMk8Cc80sBjJ5oRQZ37UjTvUmFyJRSNBYp08x10P+BR8qCxSNSgkhPVFovZumhji
	F28OmeCJaXDPBS90TQmILe0Hy2XMxhvy7IJBXAnz/PsSKdsxQ9Ix/9PWTx2iJT1ESTKMbDNa40tAH
	GmU3b15A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36608)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tWfYT-0004lK-2B;
	Sat, 11 Jan 2025 17:45:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tWfYR-000176-0W;
	Sat, 11 Jan 2025 17:45:47 +0000
Date: Sat, 11 Jan 2025 17:45:47 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 5/9] net: phy: improve phy_disable_eee_mode
Message-ID: <Z4KuS_5vwBmwyilU@shell.armlinux.org.uk>
References: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
 <487d87a1-7268-4ef4-9bde-435e61c7495c@gmail.com>
 <6c4692bc-18e9-4195-82e9-1be83645c8a4@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c4692bc-18e9-4195-82e9-1be83645c8a4@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jan 11, 2025 at 06:38:07PM +0100, Andrew Lunn wrote:
> On Sat, Jan 11, 2025 at 10:07:43AM +0100, Heiner Kallweit wrote:
> > If a mode is to be disabled, remove it from advertising_eee.
> > Disabling EEE modes shall be done before calling phy_start(),
> > warn if that's not the case.
> > 
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > ---
> >  include/linux/phy.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/include/linux/phy.h b/include/linux/phy.h
> > index ad71d3a3b..fce29aaa9 100644
> > --- a/include/linux/phy.h
> > +++ b/include/linux/phy.h
> > @@ -1333,7 +1333,10 @@ static inline bool phy_is_started(struct phy_device *phydev)
> >   */
> >  static inline void phy_disable_eee_mode(struct phy_device *phydev, u32 link_mode)
> >  {
> > +	WARN_ON(phy_is_started(phydev));
> > +
> >  	linkmode_set_bit(link_mode, phydev->eee_disabled_modes);
> > +	linkmode_clear_bit(link_mode, phydev->advertising_eee);
> >  }
> 
> Thinking out loud...
> 
> Maybe we should make this more like phy_remove_link_mode()? That
> function also removes the link mode from phydev->supported at the same
> time.

That's what I would expect, but phydev->supported_eee is also used to
determine which registers are programmed. So, removing linkmodes from
it risks not programming a register to disable an EEE mode.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

