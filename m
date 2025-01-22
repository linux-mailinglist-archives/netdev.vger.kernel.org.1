Return-Path: <netdev+bounces-160189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11085A18BB3
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 07:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E883F3A3103
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 06:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383EC14A619;
	Wed, 22 Jan 2025 06:07:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8151A8F7F
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 06:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737526043; cv=none; b=Xf9GIoB2S6glizE3RExNOIvDqvxeS9ULQM1A+Qe2NN1Ky7oFVk8lDIUaVSmXXO06VtbvKVxpyTcBO9yFdif7IRO2dTeXi7UG/BMMeQElW4nVCtTkmHUNfTfIbVoxeiMk3jPSrBL4wtLn8Y7JS6LVyPIunyUFykW/WmAaMBN4sAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737526043; c=relaxed/simple;
	bh=yF+WQD4yOcDuNUZF41jVYjxRZB1zby8f2la0pn2VWjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUmfn2fbY29IbDIRWyjRnj3wjoxwglHiyCDg9f56ZPuCWPNTKkhIG7278FsaSnEAlfJaWBQ+bvO9MFl0aH6c9t40b/YTg/Y+3Hqxbs57rSt10qZkZftSnqWQPvuugR2pZuH8iFKPSxbYTvWuPAEVb5qatDcThbfxthspAa3BL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1taTtF-0002tj-GM; Wed, 22 Jan 2025 07:07:01 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1taTtB-001Ef8-0G;
	Wed, 22 Jan 2025 07:06:57 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1taTtA-007cLW-33;
	Wed, 22 Jan 2025 07:06:56 +0100
Date: Wed, 22 Jan 2025 07:06:56 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Thangaraj.S@microchip.com
Cc: andrew+netdev@lunn.ch, rmk+kernel@armlinux.org.uk, davem@davemloft.net,
	Woojung.Huh@microchip.com, pabeni@redhat.com, edumazet@google.com,
	kuba@kernel.org, phil@raspberrypi.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 1/7] net: usb: lan78xx: Convert to PHYlink
 for improved PHY and MAC management
Message-ID: <Z5CLAMsLJtKA43kM@pengutronix.de>
References: <20250108121341.2689130-1-o.rempel@pengutronix.de>
 <20250108121341.2689130-2-o.rempel@pengutronix.de>
 <0397c3a4cac5795fc33dd313ea74a8743a587d28.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0397c3a4cac5795fc33dd313ea74a8743a587d28.camel@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Thangaraj,

On Wed, Jan 22, 2025 at 04:02:42AM +0000, Thangaraj.S@microchip.com wrote:
> Hi Oleksji,
> 
> On Wed, 2025-01-08 at 13:13 +0100, Oleksij Rempel wrote:
> >  /* use ethtool to change the level for any given device */
> > @@ -1554,40 +1558,6 @@ static void lan78xx_set_multicast(struct
> > net_device *netdev)
> >         schedule_work(&pdata->set_multicast);
> >  }
> > 
> > 
> > 
> > -static int lan78xx_link_reset(struct lan78xx_net *dev)
> > +static int lan78xx_phy_int_ack(struct lan78xx_net *dev)
> >  {
> 
> Is there any specific reason why this complete logic on phy interrupt
> handling is removed?

### Before: Old PHY Interrupt Handling

In the old implementation, the driver processed PHY interrupts as follows:

1. When a status URB was received, the driver checked for the `INT_ENP_PHY_INT`
   flag to detect a PHY-related interrupt:
   - Upon detecting the interrupt, it triggered a deferred kevent
     (`lan78xx_defer_kevent`) with the `EVENT_LINK_RESET` event.
   - It also called `generic_handle_irq_safe` to notify the PHY subsystem of
     the interrupt, allowing it to update the PHY state.

2. The deferred kevent was handled by `lan78xx_link_reset`, which:
   - It invoked `phy_read_status` to retrieve the PHY state.
   - Based on the PHY state, it adjusted MAC settings (e.g., flow control,
     USB state) and restarted the RX/TX paths if needed.
   - Enabled/disrupted timers and submitted RX URBs when link changes occurred.

This design required the driver to manually handle both PHY and MAC state
management, leading to complex and redundant logic.

### Now: PHYlink Integration

In the updated code, the handling process is simplified:

1. When a status URB detects a PHY interrupt (`INT_ENP_PHY_INT`), the driver
   still calls `lan78xx_defer_kevent(dev, EVENT_PHY_INT_ACK)`. However:
   - The deferred event now serves only to acknowledge the interrupt by calling
     `lan78xx_phy_int_ack`.
   - This separation is necessary because the URB completion context cannot
     directly perform register writes.

2. The interrupt is forwarded to the PHY subsystem, which updates the PHY state
   as before. No additional logic is performed in this step.

3. Once the PHY state is updated, PHYlink invokes appropriate callbacks to
   handle MAC reconfiguration:
   - `mac_config` for initial setup.
   - `mac_link_up` and `mac_link_down` to manage link transitions, flow
     control, and USB state.

### Why the Old Logic is No Longer Needed

The MAC is now reconfigured only through PHYlink callbacks, eliminating the
need for deferred events to handle complex link reset logic.

With PHYlink coordinating PHY and MAC interactions, the driver no longer needs
custom logic to manage state transitions.

> > +static void lan78xx_mac_config(struct phylink_config *config,
> > unsigned int mode,
> > +                              const struct phylink_link_state
> > *state)
> > +{
> > +       struct net_device *net = to_net_dev(config->dev);
> > +       struct lan78xx_net *dev = netdev_priv(net);
> > +       u32 rgmii_id = 0;
> 
> This variable is not modified anywhere in this function. Remove this
> variable if not needed.

Thank you. I'll update it.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

