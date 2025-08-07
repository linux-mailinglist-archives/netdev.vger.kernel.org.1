Return-Path: <netdev+bounces-212058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D558EB1D997
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 16:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6EC16BB7B
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 14:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449B025C802;
	Thu,  7 Aug 2025 14:02:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE34238D49
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754575363; cv=none; b=nUFqAQ+wjIa7lOi4i8I9aUzFotrkyTg7+OWI0TUpRcc+oY0lyOHUtFp1SPcwHTWgXXuVwDwOwX4GMPuIG8ZtD5ZtdQVEZgzuBSwxvTwiVEoMYttcoWQ21jWuSJwdQnmT9uKg3xMOShVYVCbzz0ST6BpuXKf6pPq7Zy76xcPVnCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754575363; c=relaxed/simple;
	bh=dUAlM7f0/ek29519zm6XLoUu3GZyva65NIoAYroTzTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaK8xk2saSfY/Ws04VeZujqqfueYNovbLJk7xMocoUAmqaKCdKglalzuy55s02pdrrUN3hIVaV0EpShKsyHLhqv/ewFsCR1dqnxMTPZLJ75k+Y2eZQkPWGl5S6/ivtFglduhbksow1Xc6f4p2cFw9fBHpfBwnZVyO7SSZwPuiqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uk1CS-0003WQ-0k; Thu, 07 Aug 2025 16:02:32 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uk1CR-00CNyt-1P;
	Thu, 07 Aug 2025 16:02:31 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uk1CR-00EK29-10;
	Thu, 07 Aug 2025 16:02:31 +0200
Date: Thu, 7 Aug 2025 16:02:31 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Xu Yang <xu.yang_2@nxp.com>, hkallweit1@gmail.com,
	pabeni@redhat.com, netdev@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND] net: phy: fix NULL pointer dereference in
 phy_polling_mode()
Message-ID: <aJSx9xTrFfFm0dcx@pengutronix.de>
References: <ywr5p6ccsbvoxronpzpbtxjqyjlwp5g6ksazbeyh47vmhta6sb@xxl6dzd2hsgg>
 <aJNSDeyJn5aZG7xs@shell.armlinux.org.uk>
 <unh332ly5fvcrjgur4y3lgn4m4zlzi7vym4hyd7yek44xvfrh5@fmavbivvjfjn>
 <b9140415-2478-4264-a674-c158ca14eb07@lunn.ch>
 <aJOHObGgfzxIDzHW@shell.armlinux.org.uk>
 <2b3fvsi7c47oit4p6drgjqeaxgwyzyopt7czfv3g2a74j2ay5j@qu22cohdcrjs>
 <3mkwdhodm4zl3t6zsavcrrkuawvd3qjxtdvhxwi6gwe42ic7rs@tevlpedpwlag>
 <aJSSNg4aZNfoqqZh@shell.armlinux.org.uk>
 <aJSf0JaBl4cKphFi@pengutronix.de>
 <d137518b-604b-4be3-9eb1-96d49123a251@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d137518b-604b-4be3-9eb1-96d49123a251@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Aug 07, 2025 at 02:58:05PM +0200, Andrew Lunn wrote:
> > Hm, I guess, with this change there will be a subtile regression.
> > In case of an external PHYs the ax88772_init_phy() is using PHYlib to
> > suspend the internal PHY.
> > 
> > May be:
> >   priv->mdio->phy_mask = ~(BIT(priv->phy_addr) | BIT(AX_EMBD_PHY_ADDR));
> 
> I looked at that:

Here we read the primary PHY address from the EEPROM. This offset may
contain either the internal or external PHY address. See commit
d0ffff8fddd5 ("USB: asix: Detect internal PHY and enable/use
accordingly")

I need to admit, asix_read_phy_addr(..., bool internal) was originally
designed to distinguish between internal and external PHYs by setting
internal = false.  But in practice, most vendors seem to follow the
existing driver behavior as reference, and only modify the primary PHY
address in the EEPROM.

> 	ret = asix_read_phy_addr(dev, true);
> 	if (ret < 0)
> 		return ret;
> 

At this point, we store the address of the internal or external PHY:

> 	priv->phy_addr = ret;

If the PHY address matches the address of the internal PHY, then
embd_phy is set to true:

> 	priv->embd_phy = ((priv->phy_addr & 0x1f) == AX_EMBD_PHY_ADDR);
> 
> So priv->phy_addr has to be the address of the internal PHY, so this
> should just work without anything special for the embedded PHY.

For most AX88772-based devices, priv->phy_addr is indeed the internal
PHY. However, on devices with an external PHY - like the "Linux
Automation GmbH USB 10Base-T1L" - both internal and external PHYs are
accessible over the MDIO bus.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

