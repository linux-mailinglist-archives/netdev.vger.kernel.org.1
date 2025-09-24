Return-Path: <netdev+bounces-226072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D44B9BA84
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 21:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3214A16FF3D
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 19:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0050425A322;
	Wed, 24 Sep 2025 19:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="J04eFdJC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03EA524F;
	Wed, 24 Sep 2025 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741521; cv=none; b=QDfnRP6vymOkVziq4XFwPA54yLBxd6qY7YOnpkD5nlyUYgwqF41euJMNMIRhMp10m0kY7+9bnJaUewSa9jZhfS/W0y7Q2lfEnuSfLYdyBGb5rSsvxi9uL7jOOJLapy4LfArOGeg55IiTKPTm+xl6QeIioEwwQtvpi89NW9BlWRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741521; c=relaxed/simple;
	bh=95aat4oQ06Jh8/hBbhtSbL+8nyZNKrKmryhSV0RFoMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCoDWM7dLvpmxJF/Kxn7AdEGQyfP8dRvDvR2VJtFRlSGe0zKVLiGgCyK5WKjcqektAOY+xHkQPdfr3ppJhPh7fzXKXjCzg1a+kt6DpqeLTXwgJWXIMy80JeLMBXSdBTYNdT+urAkykq4gNXdVf/ypdnsdPtFtI2oDXda9CdvDOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=J04eFdJC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ufTdfR029ev5iFJksbw4EUIZ+WDv4x+PeGBh+8RwVcI=; b=J04eFdJCeUQeL5MqK/scbwZnBk
	3X8yOTmxCD5ZtG33ZiKIJ+uJ/prq0IubLeXvjpaeHl6oHvclr5GbZUmGr0MuCl/wZae5fKQSg3YTw
	TVQ9u0HCXMFyEcg9QVhFarUw4KApDhhJhI4WzxtRxgE003ohX2fEpnkD3cy/dqfNf4lud1BdcOPQ5
	1p2VhMC4MR2V6xmKKb6jvxCGNTuE8iQLkoRhIRT2FZw98iKyqcOfwJ4IXrPU6bVGXe01Qa0anmdTi
	NRkZBBSkAc1jRhx32dqmHuvK04sHwtFH9EBMthUiNnuQQM8WkcbwmaekuIaLclK6cpdMeEOVQh//e
	QJVCDIAA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51276)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v1V0c-000000001Ck-3wl8;
	Wed, 24 Sep 2025 20:18:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v1V0Z-000000007On-2hsa;
	Wed, 24 Sep 2025 20:18:31 +0100
Date: Wed, 24 Sep 2025 20:18:31 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v11 2/5] net: phy: introduce
 PHY_INTERFACE_MODE_REVSGMII
Message-ID: <aNREByX9-8VtbH0n@shell.armlinux.org.uk>
References: <20250922131148.1917856-1-mmyangfl@gmail.com>
 <20250922131148.1917856-3-mmyangfl@gmail.com>
 <aNQvW54sk3EzmoJp@shell.armlinux.org.uk>
 <fe6a4073-eed0-499d-89ee-04559967b420@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe6a4073-eed0-499d-89ee-04559967b420@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 24, 2025 at 08:41:06PM +0200, Andrew Lunn wrote:
> In theory, {R}GMII does have inband signalling, but it is pretty much
> never used. REV for GMII could thus indicate what role the device is
> playing in this in-band signalling?

For RGMII, as you say, the in-band signalling is pretty much never used.
The stmmac code as it stands today does have support for using it, but
the code has been broken for longer than six years:

1. the longest historical breakage, it's conditional on the hardware
   reporting that it has a PCS integrated into the design, but a PCS
   won't be integrated into the design for RGMII-only cases.

2. even if (1) was fixed, that would result in the driver manipulating
   the netif carrier state from interrupt context, always beating
   phylink's resolve worker, meaning that mac_link_(down|up) never get
   called. This results in no traffic flow and a non-functional
   interface.

So, maybe we should just ignore the RGMII in-band signalling until
someone pops up with a hard and fast requirement for it.

> For any SERDES based links likes like SGMII, 1000Base-X and above,
> clocking is part of the SERDES, so symmetrical. There clearly is
> inband signalling, mostly, when it is not broken because of
> overclocked SGMII. But we have never needed to specify what role each
> end needs to play.

100base-X is intentionally symmetric, and designed for:

	MAC----PCS---- some kind of link ----PCS----MAC

where "some kind of link" is fibre or copper. There is no reverse mode
possible there, because "reverse" is just the same as "normal".

For SGMII though, it's a different matter. The PHY-like end transmits
the link configuration. The MAC-like end receives the link
configuration and configures itself to it - and never sends a link
configuration back.

So, the formats of the in-band tx_config_reg[15:0] are different
depending on the role each end is in.

In order for a SGMII link with in-band signalling to work, one end
has to assume the MAC-like role and the other a PHY-like role.

PHY_INTERFACE_MODE_SGMII generally means that the MAC is acting in a
MAC-like role. However, stmmac had the intention (but broken) idea
that setting the DT snps,ps-speed property would configure it into a
PHY-like role. It almost does... but instead of setting the "transmit
configuration" (TC) bit, someone typo'd and instead set the "transmit
enable" (TE) bit. So no one has actually had their stmmac-based
device operating in a PHY-like role, even if they _thought_ it was!

> > However, stmmac hardware supports "reverse" mode for more than just
> > SGMII, also RGMII and SMII.
> 
> How does the databook describe reverse SGMII? How does it differ from
> SGMII?

It doesn't describe "reverse SGMII". Instead, it describes:

1. The TC bit in the MAC configuration register, which makes the block
   transmit the speed and duplex from the MAC configuration register
   over RGMII, SGMII or SMII links (only, not 1000base-X.)

2. The SGMIIRAL bit in the PCS control register, which switches where
   the SGMII rate adapter layer takes its speed configuration from -
   either the incoming in-band tx_config_reg[15:0] word, or from the
   MAC configuration register. It is explicitly stated for this bit
   that it is for back-to-back MAC links, and as it's specific to
   SGMII, that means a back-to-back SGMII MAC link.

Set both these bits while the MAC is configured for SGMII mode, and
you have a stmmac MAC which immitates a SGMII PHY as far as the
in-band tx_config_reg[15:0] word is concerned.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

