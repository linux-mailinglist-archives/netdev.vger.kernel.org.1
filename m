Return-Path: <netdev+bounces-155870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC16A04227
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0352318897BF
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55D31F238B;
	Tue,  7 Jan 2025 14:14:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D63C1F2379
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259248; cv=none; b=dkQXk58Bp9dY5l/aWISb+8iHTeJ50Y9AxnfHiQ3Qh5SQMQj2Sk1ZFxCCms639krs5nfO9WxeeXTcCV3upbWlbxuu0fb/mzBSX3edGg6VUr5gKc6CDngpnWiZ2e7jkx6O50h13dUnpDZ+PSIoC1O8nq34QMdCsQ8/qAy+F1nw8Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259248; c=relaxed/simple;
	bh=86CCqM+imMIUc/tM4ya5cQxDZvfadXu/sI3vec3Qo10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fzd+VTV2X8feIz//9YrCT5uFGWsJ0eR27ms0HKMPBorxZeIWgJFD+rseLE+hAY8h8K8lLvM08zux7U0FSW+z1f6la0vZUb3WXAN5BIuukUSmFI32gVNd1N9yjbgeSRWGnzQTDVScZ8jaMvEy70N6GNVggyrSMPIqfux4rFVNaqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVALB-0002Jk-Lq; Tue, 07 Jan 2025 15:13:53 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVALA-007MLg-0j;
	Tue, 07 Jan 2025 15:13:53 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVALA-009aUe-2r;
	Tue, 07 Jan 2025 15:13:52 +0100
Date: Tue, 7 Jan 2025 15:13:52 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net] net: phy: fix phylib's dual eee_enabled
Message-ID: <Z302oI--ENXvPiyW@pengutronix.de>
References: <E1tBXAF-00341F-EQ@rmk-PC.armlinux.org.uk>
 <20250107144048.1c747bf1@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107144048.1c747bf1@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Jan 07, 2025 at 02:40:48PM +0100, Herve Codina wrote:
> Hi,
> 
> On Thu, 14 Nov 2024 10:33:27 +0000
> "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:
> 
> > phylib has two eee_enabled members. Some parts of the code are using
> > phydev->eee_enabled, other parts are using phydev->eee_cfg.eee_enabled.
> > This leads to incorrect behaviour as their state goes out of sync.
> > ethtool --show-eee shows incorrect information, and --set-eee sometimes
> > doesn't take effect.
> > 
> > Fix this by only having one eee_enabled member - that in eee_cfg.
> > 
> > Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/net/phy/phy-c45.c    | 4 +---
> >  drivers/net/phy/phy_device.c | 4 ++--
> >  include/linux/phy.h          | 2 --
> >  3 files changed, 3 insertions(+), 7 deletions(-)
> > 
> 
> I observed a regression with this patch applied.
> 
> My system is based on a i.MX8MP soc with a TI DP83867 ethernet PHY and was
> working with the kernel v6.12 release.

Which ethernet interface is used on this system? FEC or stmmac?

Is it the correct PHY?
https://www.ti.com/product/de-de/DP83867E

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

