Return-Path: <netdev+bounces-150594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 845909EAD43
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 10:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D74F188CADC
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C022E78F32;
	Tue, 10 Dec 2024 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kyut4uHw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAC41DC992
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824334; cv=none; b=nEmVl/7MTekVAH98a2+1TzmAobsXMa9sKt8oS33uc9WfLHXecj69ekgiFM6CdX+mb7oo2mRmLWJH+vKEFw7Ao5u/VJuYFFqCE7g/XSiSnv8lnWYZkRUi543F2mvEEsF9J6SVEIToqyJPlZLgfVOBYS/A7XnwywDGmUsey7jx060=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824334; c=relaxed/simple;
	bh=yf0j3cpdeOsPLqDZiZ5tAybjEz2nTg7LrYksg9fowVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbqHyfb4LR/jXQcHd8UfCnTyJm1MNLKzlnjzgOkf/u1rfcJWkpBgxpNflRUcfXxtFZqfWhQNOTZb2ATQYC1wQQ0FaTIKzZrZZ63ZlOPC1nNBRk9j1OUfgaYM/IoLLLztOSgx8biIqHSUsSkWuENUU88V99OgUSLu2T1Ql4RiIWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kyut4uHw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=e5hFWPnaELsaVDYQ7Ba5U5+Y79ITjmEHQS3KB0SWlQ4=; b=kyut4uHwPxOaK20+VRKDZEULl8
	05vCa5yPgrEl/rZo01WybmwTCfWqIAZWgOvWwZFlIY5uppvMVdn3POmzUmsZDYyyBRQWhwPXc+V0i
	zMHrTbrDuDoVFdG0tP88nx+Nrs8FYpL0eOUdHgpLDD8grQlKNMbRkxdmGABmLDkfyxqIHv90lCfHm
	ljHvbqj2+kMntSO8wxJX7aM7l/m7PNMjVrnR8iS1kyDSRANchSASGHCRZqF+T8cy+L5l7XOmKRW0d
	rYn8wKsjI4Qsextdzh71BQdvhknBvvBc4E6kSBYwAgIyzVegpP5MueiQke1Olc/hAWz9MfXJFm8y9
	wAHnwOzQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43046)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tKwuL-00026T-1x;
	Tue, 10 Dec 2024 09:51:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tKwuJ-0002rQ-07;
	Tue, 10 Dec 2024 09:51:55 +0000
Date: Tue, 10 Dec 2024 09:51:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 03/10] net: phy: add configuration of rx clock
 stop mode
Message-ID: <Z1gPOlBcPIZmXAH6@shell.armlinux.org.uk>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKefY-006SMd-Af@rmk-PC.armlinux.org.uk>
 <fdf1b674-8e47-43ab-9608-e25dde9f3f20@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdf1b674-8e47-43ab-9608-e25dde9f3f20@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 10, 2024 at 04:11:09AM +0100, Andrew Lunn wrote:
> > @@ -2073,6 +2073,7 @@ int phy_unregister_fixup_for_id(const char *bus_id);
> >  int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
> >  
> >  int phy_eee_tx_clock_stop_capable(struct phy_device *phydev);
> > +int phy_eee_rx_clock_stop(struct phy_device *phydev, bool clk_stop_enable);
> 
> Hi Russell
> 
> Do you have patches to MAC drivers using phylib, not phylink, using
> these two new calls?
> 
> We see phylib users get EEE wrong. I'm worried phylib users are going
> to try to use these new API methods and make an even bigger mess. If
> we think these should only be used by phylink, maybe they should be
> put into a header in drivers/net/phy to stop MAC drivers using them?

If we want to fix the current phylib-using drivers, then we do need
at minimum phy_eee_rx_clock_stop() to do that - we have drivers that
call phy_init_eee(..., true) which would need to call this.

It's quite rare that drivers allow the PHY to stop the clock. There
may be several reasons for this:

1) the MAC doesn't support EEE on the MII link type(s) that have a
   clock. (e.g. supporting EEE on SGMII but not RGMII.)

2) the documentation for the MAC doesn't comment on this aspect
   (so the safest thing is to always keep the clock running.)

3) the driver developer hasn't understood the feature and the safest
   approach is to pass phy_init_eee() with a value of zero/false
   which leaves the setting unchanged.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

