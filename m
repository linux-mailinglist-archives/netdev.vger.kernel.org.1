Return-Path: <netdev+bounces-109107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB94926F03
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 07:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C5F28592F
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 05:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586491A072A;
	Thu,  4 Jul 2024 05:46:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D327E57C
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 05:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720071962; cv=none; b=SX02cXATDjhruxZ5rVPvHE5on/EG+dRGPqBUm+CJivQpBEW34UeE7uvquY3EUHWt5L/E0AvasGhRNOr7PIIzzReBkQe2qZkVwWn3KUAUGHqtWPrOgK6Uk2zsuww3HE6nppxMQ1vgHPHHEEHibYXPM1VnapybwcL931RgKYM4Xkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720071962; c=relaxed/simple;
	bh=Iek5JlSbh5ePXXrj2niiFW2J59vUqyii5r+8rzFOIvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rk4BYm64DqrVGs16/IbeN6mXI9wwFa6ttyA/KzMYBAcVoqB3tEt+LYjPgY5BhxGye/aTS86Tz3vlLRwXzJCIDGwaFAvzy6vViQtGoN27+iR6ZaKTS/4vQaiej2CuQ32kcbY06Hi3tfyIBEFYAcN03i6qzj1QOw1MP63qG6p5zYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sPFHy-0002bX-Cj; Thu, 04 Jul 2024 07:45:50 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sPFHx-0071D3-RU; Thu, 04 Jul 2024 07:45:49 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sPFHx-00EMPA-2Q;
	Thu, 04 Jul 2024 07:45:49 +0200
Date: Thu, 4 Jul 2024 07:45:49 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yuiko Oshino <yuiko.oshino@microchip.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v2 1/1] net: phy: microchip: lan87xx: reinit PHY
 after cable test
Message-ID: <ZoY3Dc5GsySzzRDS@pengutronix.de>
References: <20240704053123.967930-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240704053123.967930-1-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Jul 04, 2024 at 07:31:23AM +0200, Oleksij Rempel wrote:
> Reinit PHY after cable test, otherwise link can't be established on
> tested port. This issue is reproducible on LAN9372 switches with
> integrated 100BaseT1 PHYs.
> 
> Fixes: 788050256c411 ("net: phy: microchip_t1: add cable test support for lan87xx phy")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

I lost in this version one reviewed by:
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com> 
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

