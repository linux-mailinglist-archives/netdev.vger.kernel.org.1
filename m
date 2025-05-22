Return-Path: <netdev+bounces-192541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5FEAC04BE
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E05F4E0078
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 06:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56734221D8F;
	Thu, 22 May 2025 06:43:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8601B87F2
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 06:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747896225; cv=none; b=nKjuhpCl/ghQpf4hiSPQ6QPM4NncCRRpwwMcvFkQ9+0j4C9j6TvfF30ZuswRF4X74a19r+mrODqCEpOgxCUueym6n65Og6pX5W2TDbqkjbsfjg6EOpS2sR63L9sHiO7pO9yjTAtLMOLrklhMjaELsKITTcBhO+OegTk5toONv4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747896225; c=relaxed/simple;
	bh=dxDP5IQt5rtpMdaHBgCk/Tk6qBhSaHaiq5AmRp9SC68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvFBnr7W/38cq9ZjsWfMGQ7hOhDb7HEaJGRTzpBtYLuZ+VnjV76fXtbVHZfzygWjWYxBo5lmYG/FQ96hWQPCwlwqjG2AdtTs5CzbfYmzC2gJDrHxiJohQ/fA1wPtf/swHGGBayoPyhwXVWzAnN/hwcsDY/XywquGFdgQs6ihH0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uHzeA-0006k1-53; Thu, 22 May 2025 08:43:18 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uHze7-000gpo-02;
	Thu, 22 May 2025 08:43:15 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uHze6-002gka-2f;
	Thu, 22 May 2025 08:43:14 +0200
Date: Thu, 22 May 2025 08:43:14 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v11 01/13] net: pse-pd: Introduce
 attached_phydev to pse control
Message-ID: <aC7Hgu_ieB31Wy_r@pengutronix.de>
References: <20250520-feature_poe_port_prio-v11-0-bbaf447e1b28@bootlin.com>
 <20250520-feature_poe_port_prio-v11-1-bbaf447e1b28@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250520-feature_poe_port_prio-v11-1-bbaf447e1b28@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, May 20, 2025 at 06:11:03PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> In preparation for reporting PSE events via ethtool notifications,
> introduce an attached_phydev field in the pse_control structure.
> This field stores the phy_device associated with the PSE PI,
> ensuring that notifications are sent to the correct network
> interface.
> 
> The attached_phydev pointer is directly tied to the PHY lifecycle. It
> is set when the PHY is registered and cleared when the PHY is removed.
> There is no need to use a refcount, as doing so could interfere with
> the PHY removal process.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de> 

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

