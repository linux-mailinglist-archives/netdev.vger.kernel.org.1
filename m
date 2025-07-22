Return-Path: <netdev+bounces-208959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7526CB0DB1E
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3129163451
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAA82E9EAF;
	Tue, 22 Jul 2025 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1+uOPwRX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957C42D3EFB;
	Tue, 22 Jul 2025 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191635; cv=none; b=s95XoxpqFNloyPCcr+oKmr885Q8RDYJTr6c1eRmNQbdCYRmtXAagNy+jOYmK5fvyTRFzjUV3oz47nXKFuf4KBV8N3hbS9e5eZgVMaWqZhT76+f3N7Ft0fGNuykRuLggPX+EDpxX9Lb3hQ0YKLs3PD71gOfuhw0nH/sgjpH4DHus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191635; c=relaxed/simple;
	bh=MXO9EWlF1pSPtYi/UYwYFw2pS/bbhVXy0OKvJ0qTjks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQtfqt+1HJ7NGXCb922T1SKStCKKfGzGm9ZUg9qmnKs1+s/i/AzxE1L+EZYsvdyzuujN70Ke0EQm8dZbtPWum6+flbKfsl7F4GZy/ucOqhIOzX6anBWUrx9b+hnBRa8WeHW8Z6tQyk7Qwzp7V9jsywPkJeMgPl5SrsFiLs/YgfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1+uOPwRX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J8qiQBG36WBSmQUwYyp0uzxMsuI5XvwcDQhc2TTCUsM=; b=1+uOPwRXEBL1bsymdavVsthvYW
	PIxAm0lVjGxP5QIRq9kR9moqG69iPLRejLM6DR8ey+R6MoRoChI7PhS95xy5RDt21pHF5hI0Lnbpm
	/MRewzSUzB7pzCLs42MWPvp1XDtZuWHHwPs+XSCnNM5XnUzm6Rc+gzje3gyTJ3ixqr7k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ueDE8-002TAs-HI; Tue, 22 Jul 2025 15:40:16 +0200
Date: Tue, 22 Jul 2025 15:40:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
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
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: document st,phy-wol
 property
Message-ID: <2563a389-4e7c-4536-b956-476f98e24b37@lunn.ch>
References: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
 <20250721-wol-smsc-phy-v1-1-89d262812dba@foss.st.com>
 <faea23d5-9d5d-4fbb-9c6a-a7bc38c04866@kernel.org>
 <f5c4bb6d-4ff1-4dc1-9d27-3bb1e26437e3@foss.st.com>
 <e3c99bdb-649a-4652-9f34-19b902ba34c1@lunn.ch>
 <38278e2a-5a1b-4908-907e-7d45a08ea3b7@foss.st.com>
 <5b8608cb-1369-4638-9cda-1cf90412fc0f@lunn.ch>
 <383299bb-883c-43bf-a52a-64d7fda71064@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <383299bb-883c-43bf-a52a-64d7fda71064@foss.st.com>

I know Russell has also replied about issues with stmmac. Please
consider that when reading what i say... It might be not applicable.

> Seems like a fair and logical approach. It seems reasonable that the
> MAC driver relies on the get_wol() API to know what's supported.
> 
> The tricky thing for the PHY used in this patchset is to get this
> information:
> 
> Extract from the documentation of the LAN8742A PHY:
> "The WoL detection can be configured to assert the nINT interrupt pin
> or nPME pin"

https://www.kernel.org/doc/Documentation/devicetree/bindings/power/wakeup-source.txt

It is a bit messy, but in the device tree, you could have:

    interrupts = <&sirq 0 IRQ_TYPE_LEVEL_LOW>
                 <&pmic 42 IRQ_TYPE_LEVEL_LOW>;
    interrupt-names = "nINT", "wake";
    wakeup-source

You could also have:

    interrupts = <&sirq 0 IRQ_TYPE_LEVEL_LOW>;
    interrupt-names = "wake";
    wakeup-source

In the first example, since there are two interrupts listed, it must
be using the nPME. For the second, since there is only one, it must be
using nINT.

Where this does not work so well is when you have a board which does
not have nINT wired, but does have nPME. The phylib core will see
there is an interrupt and request it, and disable polling. And then
nothing will work. We might be able to delay solving that until such a
board actually exists?

	Andrew

