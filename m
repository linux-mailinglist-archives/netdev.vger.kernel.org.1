Return-Path: <netdev+bounces-224106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECD4B80CDD
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA494A0973
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A89A30C0E0;
	Wed, 17 Sep 2025 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tA7yjSBf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28CB2F4A0B;
	Wed, 17 Sep 2025 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124499; cv=none; b=p2U1rIBCItuz4Ew0vBpmXiysMk2JHy8Yy0GvU3P9TrP78n4byTZePm+Y3kQkU64m71N8h7/fSYQYgejk/nEcZiZqFwmMhViSWxAy/WrUanTPQNrnRAsWnmgALr+29ujGUBWchlX3nij4VZ5HZiXmPN7rpibzJ4N769G+yVGBpsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124499; c=relaxed/simple;
	bh=d6z5bQMduWywzCnsjkrsB8XpI7EB7r39k2dXtzSRP4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWwDJ0rB4e3uoqp4tk5W0iV12ypzApEPkD3mLYiFwA2j8WNVYPt/l1JKHG41kTUI+1NLcWRYAhrYxkcc8OB8kcVGr1CsYCwNjFfTD8sMemCX9Z44fNJKpgWV/Cb8oLaXhAnGtd+1h5FD3XPbrkAKloZQrb0xktU9Lxi9Azz8jt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tA7yjSBf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AJktQMdqIHogk394FiivhFmOdjrHiCFPa1pHkmNNloE=; b=tA7yjSBfh1hpMlPKDhAteZScZ3
	LWtL4OhwJkoeY112/UKM1Lj8dS10jvM+/d6/xo7uOMTYDiqIm1NQXobdmEP65om9Qn9i5wDxhEPd0
	P+IcrmnIkqG20n8KABAmHw35SvqVVXkkU52TAhEpRjB553kSnPam6Gyb9lSssnWmtArp8+a58ynQ2
	BDtXU4CWBHtd28yI7/zUBK8UQClI5b7KUxLuPnp+KI2wVmuPFgZljQtubiVf3vGnXc158jeQGCHYZ
	QbXZ0eaG7ML9xwJ8sYFm6VONwlxAFv8YKbLmt62yyEzyVX9cwqj2YVfya/NnroZvUcrbbMUwW7293
	2hky0hiA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45608)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uyuUV-0000000053e-1IFT;
	Wed, 17 Sep 2025 16:54:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uyuUQ-000000000Jt-3aAP;
	Wed, 17 Sep 2025 16:54:38 +0100
Date: Wed, 17 Sep 2025 16:54:38 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: phy: smsc: fix and improve WoL
 support
Message-ID: <aMrZvvVBwmWGjr4P@shell.armlinux.org.uk>
References: <20250917-wol-smsc-phy-v2-0-105f5eb89b7f@foss.st.com>
 <20250917-wol-smsc-phy-v2-3-105f5eb89b7f@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-wol-smsc-phy-v2-3-105f5eb89b7f@foss.st.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 17, 2025 at 05:36:38PM +0200, Gatien Chevallier wrote:
> @@ -673,6 +726,9 @@ int smsc_phy_probe(struct phy_device *phydev)
>  
>  	phydev->priv = priv;
>  
> +	if (phydev->drv->set_wol)
> +		device_set_wakeup_capable(&phydev->mdio.dev, true);

This suggests that you know that this device is _always_ capable of
waking the system up, irrespective of the properties of e.g. the
interrupt controller. If this is not the case, please consider the
approach I took in the realtek driver.

In that case, you also need to add checks in the get_wol() and
set_wol() methods to refuse WoL configuration, and to report that
WoL is not supported.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

