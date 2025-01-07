Return-Path: <netdev+bounces-155885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B600A04322
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E043A2327
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540591F2388;
	Tue,  7 Jan 2025 14:49:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86851AD3E0
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261387; cv=none; b=iA38rCDpAkeQVsIwzyUi9oBTFbIhpaLJZ+83GDPZgEqmWco3kLLOPO0wXcX1IZZHrNaZyjNIn0eQusMsECDuCf4jaY9RQkee2qR8UilxzWBZQHUq0nOtVjxYqFPU8eGccivxGEMA4FUlegZAr+eBCb9YVEkEl3ueg/BoI5GFZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261387; c=relaxed/simple;
	bh=T0bcH1ahdbx6um8puSVUMB/m1GpB6QM0PXOxkaEi83g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWUM3Gcn3bZplm045+4bK8s6ROyvW//ub/RvU6gOc/ZFvmmTiRPPmz/pVUiKyC0LWzedAm8lXCerFkk/OKtj4D6Uci59A6CXBvee7e62FbVnN98twh5fNSpC7Ej1UGsh0kWcOkUPW/He7l3+WEaj/85QGybdhg8ocuxhKNN4vyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVAtk-000231-Cs; Tue, 07 Jan 2025 15:49:36 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVAti-007MVG-0P;
	Tue, 07 Jan 2025 15:49:34 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVAti-009asF-2Y;
	Tue, 07 Jan 2025 15:49:34 +0100
Date: Tue, 7 Jan 2025 15:49:34 +0100
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
Message-ID: <Z30-_sLmbTzW0Yg6@pengutronix.de>
References: <E1tBXAF-00341F-EQ@rmk-PC.armlinux.org.uk>
 <20250107144048.1c747bf1@bootlin.com>
 <Z302oI--ENXvPiyW@pengutronix.de>
 <20250107152345.6bbb9853@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107152345.6bbb9853@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Jan 07, 2025 at 03:23:45PM +0100, Herve Codina wrote:
> On Tue, 7 Jan 2025 15:13:52 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > On Tue, Jan 07, 2025 at 02:40:48PM +0100, Herve Codina wrote:
> > > Hi,
> > > 
> > > On Thu, 14 Nov 2024 10:33:27 +0000
> > > "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:
> > >   
> > > > phylib has two eee_enabled members. Some parts of the code are using
> > > > phydev->eee_enabled, other parts are using phydev->eee_cfg.eee_enabled.
> > > > This leads to incorrect behaviour as their state goes out of sync.
> > > > ethtool --show-eee shows incorrect information, and --set-eee sometimes
> > > > doesn't take effect.
> > > > 
> > > > Fix this by only having one eee_enabled member - that in eee_cfg.
> > > > 
> > > > Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > ---
> > > >  drivers/net/phy/phy-c45.c    | 4 +---
> > > >  drivers/net/phy/phy_device.c | 4 ++--
> > > >  include/linux/phy.h          | 2 --
> > > >  3 files changed, 3 insertions(+), 7 deletions(-)
> > > >   
> > > 
> > > I observed a regression with this patch applied.
> > > 
> > > My system is based on a i.MX8MP soc with a TI DP83867 ethernet PHY and was
> > > working with the kernel v6.12 release.  
> > 
> > Which ethernet interface is used on this system? FEC or stmmac?
> 
> It is the FEC (ethernet@30be0000).

FEC driver's EEE support is still broken, i assume it is configuring
wrong timer. But, I can't fix without access to HW with proper PHY.

> > 
> > Is it the correct PHY?
> > https://www.ti.com/product/de-de/DP83867E
> 
> Yes, it is this PHY.

EEE support is not listed in this documentation and there is no errata.
I assume, there is still a register claiming EEE support. Otherwise it
would not be activated.

https://e2e.ti.com/support/interface-group/interface/f/interface-forum/658638/dp83867ir-eee-energy-efficient-ethernet
https://e2e.ti.com/support/interface-group/interface/f/interface-forum/556456/dp83867-mdi-auto-negotiation-with-eee-energy-efficient-ethernet-router?DP83867-MDI-Auto-Negotiation-with-EEE-Energy-Efficient-Ethernet-router
https://e2e.ti.com/support/interface-group/interface/f/interface-forum/716392/dp83867ir-eee-energy-efficient-ethernet-with-dp83867

Since chip vendor recommends to actively disable EEE support, something like
this will be needed.
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -947,6 +947,8 @@ static int dp83867_config_init(struct phy_device *phydev)
                               mask, val);
        }
 
+       phy_disable_eee(phydev);
+
        return 0;
 }

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

