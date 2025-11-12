Return-Path: <netdev+bounces-237878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E45C5113D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 09:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 467584EDBFA
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CAF2F39BD;
	Wed, 12 Nov 2025 08:14:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB42DC34B
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762935285; cv=none; b=PiJI7X0szksy/d1CgoPYgj8txsMUepfpFsiYxFsZ+YDT6LIX/GpkA/kqhuiFk73avpObOyQ9WHL6VBmCQBMQIDejeGU8ZMlhg9gmpoL7GVZ+Qm5siJ91iQprpJE4giLfADIFlGFErfKqnPULoApCue0Xwetg3IC56S93hDtwWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762935285; c=relaxed/simple;
	bh=BYbdxvWo47kO9Wloo/yIIBxUnP0QEo6by8CzdjsQFZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmHYnqiwWaSOs1/aRVXw3kXjJ6e0apPKTKzoWFr8WlkAmyfgwops8lB/oh8eRw0uUTqpIuCbyI62Uzc7sZJWsPAVI+D+l4YZdNBqt20kFrbzr/j8/ZIxgErAC2SpEBBhuczLpeIdEKxg43Q6hBAHLJ4oVBYN/cvrT4GOh1j/GSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vJ5zt-0006c8-K2; Wed, 12 Nov 2025 09:14:33 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vJ5zr-0003AD-0Q;
	Wed, 12 Nov 2025 09:14:31 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vJ5zq-00GPh9-3D;
	Wed, 12 Nov 2025 09:14:31 +0100
Date: Wed, 12 Nov 2025 09:14:30 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/2] net: phy: allow drivers to disable EEE
 support via .get_features()
Message-ID: <aRRB5miRuA57NSk5@pengutronix.de>
References: <aRMgLmIU1XqLZq4i@shell.armlinux.org.uk>
 <E1vImhq-0000000DrQc-3bMW@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E1vImhq-0000000DrQc-3bMW@rmk-PC.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Nov 11, 2025 at 11:38:38AM +0000, Russell King (Oracle) wrote:
> Allow PHY drivers to hook the .get_features() method to disable EEE
> support. This is useful for TI PHYs, where we have a statement that
> none of their gigabit products support EEE, yet at least DP83867
> reports EEE capabilties and implements EEE negotiation.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> +/**
> + * phy_get_Features_no_eee - read the PHY features, disabling all EEE

s/phy_get_Features_no_eee/phy_get_features_no_eee


Otherwise looks good.

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you.
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

