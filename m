Return-Path: <netdev+bounces-96358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C138C5682
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 15:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386F12835ED
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40F613FD8D;
	Tue, 14 May 2024 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bH0xkm4z"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DE612E75;
	Tue, 14 May 2024 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691925; cv=none; b=jsO7VgXKx/aVkyMkgzzlrtBAtsigDGkEJNb2gNtCbRqGurn98fvbbbcXsNh8VEP+YQGq4NERYGD53p5o0Ysz6XIriA9a68PK8Jn+WunU4BA4N1u302bMjCjnsUa571Q1gpB8v2V5cJItExOYrslrstCpKlkyno93Em+qgNii9Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691925; c=relaxed/simple;
	bh=+Z6R1uNsAOJ+8G02CVd/I1z60HSnWhvLdgPhe1ovvuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrsdVR9j1kR1kkmDOWHrZK0VXuLdHa+pQRAWU5CgiHoUXC97eAopp3NYQHhe/ZjwqtAbGCtNe/lcNaNQNFXsScDy3lmLYr2Ir0uMKz9GhYMt2nNQR78CydoWm/p5rTYK7sEuhsxx+4wXhOj2UlgwX72VclchBj5Kmeeq/7bfqOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bH0xkm4z; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dQfWTLYhPweRfGZN+ci+uPjT2T2ohypaGEMZ89n1Fv0=; b=bH0xkm4zsM5ql2lAREgIz9IfKW
	fqPf1Y/9t6zJUfue1FE8netIA9JAJQtssgIN1q+6l8rG3OrJakWMaTHtuMLu/2YLdvEjzMe/ujibJ
	XlJ/VniPCoFsoP1IeaWpxIOSEVo00TWDYuMmPcocYKuG3DxcMe9gVVDPoPIa/nQKnMLzXqSNTK90K
	6gsBDJECghMsXAhf/iRaHaHmiK6Zi30rAZ2xFFKkA34mlud0DXi2A66UFqG2W4HGHfKWBEISXiNn+
	NOJBF5zhBP44bV3b+fn2WGXT1U80nnym83c5jojreePi2zgW6qhKubaJLJnZzTZgKKUW1xiGMdZ0K
	n19023Eg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43384)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s6rq2-0002zA-2U;
	Tue, 14 May 2024 14:05:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s6rq1-00074q-WC; Tue, 14 May 2024 14:05:02 +0100
Date: Tue, 14 May 2024 14:05:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	MD Danish Anwar <danishanwar@ti.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>
Subject: Re: [PATCH 2/2] net: phy: dp83869: Fix RGMII-SGMII and 1000BASE-X
Message-ID: <ZkNhfXYxFTdB+weJ@shell.armlinux.org.uk>
References: <20240514122728.1490156-1-thomas.gessler@brueckmann-gmbh.de>
 <20240514122728.1490156-2-thomas.gessler@brueckmann-gmbh.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514122728.1490156-2-thomas.gessler@brueckmann-gmbh.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 14, 2024 at 02:27:28PM +0200, Thomas Gessler wrote:
> The PHY supports multiple modes of which not all are properly
> implemented by the driver. In the case of the RGMII-to-SGMII and
> 1000BASE-X modes, this was primarily due to the use of non-standard
> registers for auto-negotiation settings and link status. This patch adds
> device-specific get_features(), config_aneg(), aneg_done(), and
> read_status() functions for these modes. They are based on the genphy_*
> versions with the correct registers and fall back to the genphy_*
> versions for other modes.

I'm reading this, and wondering... do you have a use case for this,
or are you adding it because "the PHY supports this" ?

> The RGMII-to-SGMII mode is special, because the chip does not really act
> as a PHY in this mode but rather as a bridge. It requires a connected
> SGMII PHY and gets the negotiated speed and duplex from it through SGMII
> auto-negotiation. To use the DP83869 as a virtual PHY, we assume that
> the connected SGMII PHY supports 10/100/1000M half/full duplex and
> therefore support and always advertise those settings.

I call this configuration a "stacked PHY" system, and you're right that
it's a setup that we have no support for at the moment. We assume that
there is exactly one PHY in each network device.

I think we would need a lot of re-architecting of the phylib <-> netdev
linkage to allow stacked PHY systems to work sensibly.

If you don't have a use case for this, then it would be better not to
add support for it at this stage, otherwise it may restrict what we can
do in the future when coming up with a solution for stacked PHY support.
Alternatively, you may wish to discuss this topic and work on a
solution.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

