Return-Path: <netdev+bounces-208610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B2BB0C525
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF733A2EDF
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDF52D8791;
	Mon, 21 Jul 2025 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rDowa1V+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE401E521E;
	Mon, 21 Jul 2025 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104402; cv=none; b=LBZYPxZRG+vRb+FmHHaf4mdmDhrwSGmipfLMaGqHbh6a8QPYdyTNP0BnN7thvycjRV/fLXvbWTrXM+CVkzD78AX51JyfhVz2N5W+lTpOpviiIl8dF2dS4p4F+IgQHNO/i/EIOtLGYNWk8PeQ3JiYPDtfk6bKRMGqFPnPWMffQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104402; c=relaxed/simple;
	bh=sRSbq2dWBq5biO2NCQAchFm6eHRQIvC4ME8xN9f6d+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKPGZBFePEv9gZ558nHAb8gWGljF+S/HAUsIYNSwe0nK+WWuV6/WPyKMI42uXgLfMcOOwyh/CSIzrOPD2PSgjiufRyI+h3lWqMg1qGx4jhNa8oFZPniean15JHosXIQEwz5bmOh156ohQmXcy26Xw2njgIm2gTy2FSUrBTqstlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rDowa1V+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=f0zjOMTbsL9IYskcxTnBbpsTUpI1b+AoqR8XdDVpdrI=; b=rDowa1V+pr1UhzVlanIV+mlqe+
	yi+x6a81Qp2xjGtBieTAdZdnaK3PLVHeziPlVeTDFY+AU7vBY2Li5ixGzFtTemQcIS20U/QvC5Ihr
	xxAkLgUGpSzVY0r0gOueIKO7mDIUSP3kdU1h3GzEwPfuofWTL4jRmOskhSRsAo9WqMVk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1udqXE-002MJh-72; Mon, 21 Jul 2025 15:26:28 +0200
Date: Mon, 21 Jul 2025 15:26:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: phy: smsc: fix and improve WoL support
Message-ID: <cca8e9e6-a063-4e00-87af-f59ea926cce3@lunn.ch>
References: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
 <20250721-wol-smsc-phy-v1-3-89d262812dba@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-wol-smsc-phy-v1-3-89d262812dba@foss.st.com>

> +static int smsc_phy_suspend(struct phy_device *phydev)
> +{
> +	if (!phydev->wol_enabled)
> +		return genphy_suspend(phydev);
> +
> +	return 0;
> +}

Suspend/resume is somewhat complex, and i don't know all the
details. But this looks odd. Why does the phylib core call suspend
when phydev->wol_enabled is true? That at least needs an explanation
in the commit message.

> +static int smsc_phy_resume(struct phy_device *phydev)
> +{
> +	int rc;
> +
> +	if (!phydev->wol_enabled)
> +		return genphy_resume(phydev);
> +
> +	rc = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (!(rc & MII_LAN874X_PHY_WOL_STATUS_MASK))
> +		return 0;
> +
> +	dev_info(&phydev->mdio.dev, "Woke up from LAN event.\n");

Please don't spam the log. It is clear the system woke up, there are
messages in the log...

	Andrew

