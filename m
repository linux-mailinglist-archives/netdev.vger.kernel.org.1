Return-Path: <netdev+bounces-132179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3211A990BA6
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FCE2835F4
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2431E571F;
	Fri,  4 Oct 2024 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RF+GTfnv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC7B1E47D6;
	Fri,  4 Oct 2024 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066015; cv=none; b=iQMoUYJhy78++yiuOaHH+r/fPXB7sP6DFFyJgQSOmFZqbtRuguKRS4/Tr65+G0KE5p7d/Vg/zjWbB442vFP1iATudJtIHWzYR3FZdgzi0vNOIODrmr+L1haJovzKqmrn4m71cUVM6QDUpeONPqPEqrpRzbp5FvJsAUkTmLK9/8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066015; c=relaxed/simple;
	bh=e7Pt9dk06k5wArD4fbGTpcQ2wpH0fZyNTg2rsIWFrvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNbtklZfEMi4+8QyuvYsXWH4hkqn54gSSVaWJNYGFD4xHLE7qA2M1bKtdg4VEpDYjByvJNwgWaiA7bO3zuP31NeJPwNTc2fmCAG7IKkBX6TezI/jUdOBqYKk7D9uz65rSRoU7IWAcpEzZgZFqSaDoQR5eXLe5HPYWyveKXOz0cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RF+GTfnv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TbsE1H3TrmvZMXxn8umMjBNefx95zTIgFXP2rPdpWQQ=; b=RF+GTfnvGyb3Lbk4EfTd7E0qfO
	j+KuhIH8i2/heOJfkBdmF5VoK57f3jQ+uSje6V/5izea5C1f+dGo7560L0AxfJZLEnOVDHsgyPuIW
	FuQmrGsxxJ50yHbFFZ7TWbZNhqiXFs4+D2wUfVzVfJIllXABj5Wqe1w4ObuScoC8ABZ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swmuQ-00954O-6G; Fri, 04 Oct 2024 20:20:10 +0200
Date: Fri, 4 Oct 2024 20:20:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v2 3/9] net: phy: Allow PHY drivers to report
 isolation support
Message-ID: <cf015eee-0d09-4fc7-b214-f9b0db12016e@lunn.ch>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
 <20241004161601.2932901-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004161601.2932901-4-maxime.chevallier@bootlin.com>

> +static bool phy_can_isolate(struct phy_device *phydev)
> +{
> +	if (phydev->drv && phydev->drv->can_isolate)
> +		return phydev->drv->can_isolate(phydev);
> +
> +	return true;

Reading Russells comment, and the fact that this feature is nearly
unused, so we have no idea how well PHYs actually support this, i
would flip the logic. Default to false. A PHY driver needs to actively
sign up to supporting isolation, with the understanding it has been
tested on at least one board with two or more PHYs.

	Andrew

