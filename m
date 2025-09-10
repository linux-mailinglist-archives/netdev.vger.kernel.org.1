Return-Path: <netdev+bounces-221570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E13B50EBD
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 09:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F364E0ACE
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 07:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE093019A3;
	Wed, 10 Sep 2025 07:08:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93C26B779
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 07:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757488127; cv=none; b=tPWJ1Bx4OanZn9EK1vvBppj9sd2qNRev8W/gLrTIFlQzrboXJPHQhbL+xTt9sFwwzCyNShYIYHMQz4TSjg9N5h/PHFmZxRdzPPHspwHlql063Th64HV3zVYS0fIwjD5l/OMEmHmgjCULE6A0KRFWrZ5COsSnIJ5O23zBTSqFCE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757488127; c=relaxed/simple;
	bh=VDXJRMatLsnf9a6GY+1Kzd46i4ImKZ+ZX2nboEeBDuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hcg7CWokvU2pZ3I1+aVlaPM4+XT43uumMOSLK0icCvgLJclJ655NrZsGaDA1hel2qg0u5/XdK3RIWlYMIyUJNLRDA7yF1fJ4EhkBl2T8XAfItE5gXX/uUgv+x/mPhHBBQKNU94c3aYVoED0xzORS4FYjMVtmNkHEMlOV9Ci7l0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uwEwW-0006YP-9Z; Wed, 10 Sep 2025 09:08:36 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uwEwU-000YJv-2i;
	Wed, 10 Sep 2025 09:08:34 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uwEwU-00G9DX-2C;
	Wed, 10 Sep 2025 09:08:34 +0200
Date: Wed, 10 Sep 2025 09:08:34 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: clear EEE runtime state in
 PHY_HALTED/PHY_ERROR
Message-ID: <aMEj8vjJY4h6kYbN@pengutronix.de>
References: <20250909131248.4148301-1-o.rempel@pengutronix.de>
 <5078fdbe-b8ac-430a-ab5d-9fa2d493c7da@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5078fdbe-b8ac-430a-ab5d-9fa2d493c7da@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Sep 09, 2025 at 03:58:32PM +0200, Andrew Lunn wrote:
> On Tue, Sep 09, 2025 at 03:12:48PM +0200, Oleksij Rempel wrote:
> > Clear EEE runtime flags when the PHY transitions to HALTED or ERROR
> > and the state machine drops the link. This avoids stale EEE state being
> > reported via ethtool after the PHY is stopped or hits an error.
> 
> One obvious question, why is EEE special? We have other state in
> phydev which is not valid when the link is down. Are we setting speed
> and duplex to UNKNOWN? lp_advertising, mdix, master_slave_state?
> 
> So while i agree it is nice not to show stale EEE state, maybe we
> should not be showing any stale state and this patch needs extending?

I decided to send the first step patch for the agreed subset (EEE
flags), so it can be merged faster.

As a follow-up I would propose a separate patch which clears additional
link-resolved state when the PHY enters HALTED, for example:

--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1552,6 +1552,16 @@ static enum phy_state_work _phy_state_machine(struct phy_device *phydev)
                }
                break;
        case PHY_HALTED:
+               if (phydev->link) {
+                       if (phydev->autoneg == AUTONEG_ENABLE) {
+                               phydev->speed = SPEED_UNKNOWN;
+                               phydev->duplex = DUPLEX_UNKNOWN;
+                       }
+                       if (phydev->master_slave_state != MASTER_SLAVE_STATE_UNSUPPORTED)
+                               phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
+                       phydev->mdix = ETH_TP_MDI_INVALID;
+                       linkmode_zero(phydev->lp_advertising);
+               }
        case PHY_ERROR:
                if (phydev->link) {
                        phydev->link = 0;

Would this approach be acceptable, or do you see hidden issues with clearing
these extra fields?

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

