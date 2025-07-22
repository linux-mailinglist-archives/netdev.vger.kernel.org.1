Return-Path: <netdev+bounces-208807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FC1B0D373
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EBD188A66B
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 07:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2117C2D3EE6;
	Tue, 22 Jul 2025 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qChRxj60"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275232C15B5;
	Tue, 22 Jul 2025 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169596; cv=none; b=frn0aYG8qqmktA3QSXi2A9LQJJyuorwYeuWhI0BNU2DsMWz63CEcyhk1iKy7PjRHSdptgu7/gKdDmqTHsbU0r2aROb7qbn1nVexL16s54AWYCvR5cvJGnFZ8R9qi4ETvGl0bF+noVFmiHnDh3q242b6eEFFQU/fdNVG6FsM8m1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169596; c=relaxed/simple;
	bh=dvySKgvwnT8oBcTa6En/DVNoUV2aJy3BPu8eNsOzWfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHirN1G8cvtWgQ1mZ+picddzYreYQQGnyFIw927tLLL+1AAatYAtseNp/sA+0yDELmwWf3gDnrGqkpMnwEAd284N6tMnxbV2hUIi+GHUVHoW/PmS8NWep+peKqkGy9dE9PM4jBmKMxWZ3ZZtbjA8xOACnZ6yEh6vEBBxpqi8ebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qChRxj60; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U6YMzP+2dWgWiUnFlZiTb7wmZcswaZFKOx7Tx9ijr9I=; b=qChRxj60ECKPufnRYt+Lj+Pjgw
	4TtJYFrn2SbRTyUb9OZTtSuALjGdYgGwFaZsBPTCeKc1UhF8PGXaNXFgQpMNfJehBOL2TsAL/JghM
	ztZwOoy8KrecDxpV68upEIUo/CEEl2t3T3hj/P9Q6T4EzawJgEcd0UDh8/jZ6Sr0C9lVlg3a4H6Gb
	d9LwXuv/9y/bt/y3NF0gTq7tbVSCwErt4++t9G4cxQcUsiMzltqJu/i3KBZewhechX+QwOdB2XPdk
	drEU2x4ZHNlUpT4+y0OW3BJtZth18KWYGfy35nNbllatWoDjzItAg3AMxi8bq0F1wKCK3SjGRVvm6
	v4O4NA0w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50216)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ue7UX-0007zl-2z;
	Tue, 22 Jul 2025 08:32:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ue7UT-0006y6-1K;
	Tue, 22 Jul 2025 08:32:45 +0100
Date: Tue, 22 Jul 2025 08:32:45 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <krzk@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: document st,phy-wol
 property
Message-ID: <aH8-nQtNVuewNuwU@shell.armlinux.org.uk>
References: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
 <20250721-wol-smsc-phy-v1-1-89d262812dba@foss.st.com>
 <faea23d5-9d5d-4fbb-9c6a-a7bc38c04866@kernel.org>
 <f5c4bb6d-4ff1-4dc1-9d27-3bb1e26437e3@foss.st.com>
 <e3c99bdb-649a-4652-9f34-19b902ba34c1@lunn.ch>
 <38278e2a-5a1b-4908-907e-7d45a08ea3b7@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38278e2a-5a1b-4908-907e-7d45a08ea3b7@foss.st.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jul 21, 2025 at 05:56:17PM +0200, Gatien CHEVALLIER wrote:
> Here's an extract from the Microchip datasheet for the LAN8742A PHY:
> 
> "In addition to the main interrupts described in this section, an nPME
> pin is provided exclusively for WoL specific interrupts."

So the pin on the PHY for WoL is called nPME? If this pin isn't wired
to an interrupt controller, then the PHY doesn't support WoL. If it is
wired, then could it be inferred that WoL is supported?

If so, then it seems to me the simple solution here is for the PHY
driver to say "if the nPME pin is connected to an interrupt controller,
then PHY-side WoL is supported, otherwise PHY-side WoL is not
supported".

Then, I wonder if the detection of the WoL capabilities of the PHY
in stmmac_init_phy() could be used to determine whether PHY WoL
should be used or not.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

