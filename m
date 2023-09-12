Return-Path: <netdev+bounces-33286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4578479D511
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 17:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD53281D7E
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B675018C16;
	Tue, 12 Sep 2023 15:37:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7C6A31
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 15:37:00 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB00310E9;
	Tue, 12 Sep 2023 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Eo7teDrgP/EvjrScwQnnL0XME0C7SYT1+w8XDCbPoNU=; b=lYEWm7mlNdpj9ZYK7OQBkL5dD3
	Lh28re6kZKNO8vnCya2LotBDsfR7Oq7xuCUQRnv/LBoXW+Eh3kxzbaKMr3fYb15sUfu2oTBTzvVIt
	lr39Eq84PkT4k2d+W6Jl+ZRgtQiXg4C2G2EQ2uDt1IcIxiK4rvCs4Nr1S7WLpwX8iHhM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qg5Rg-006F5t-8X; Tue, 12 Sep 2023 17:36:56 +0200
Date: Tue, 12 Sep 2023 17:36:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Oleksij Rempel <linux@rempel-privat.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 0/7] net: phy: introduce phy numbering
Message-ID: <e1de6afe-346f-42bf-8f7a-8621c2e26749@lunn.ch>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907092407.647139-1-maxime.chevallier@bootlin.com>

> The PHY namespace is for now contained within struct net_device, meaning
> that PHYs that aren't related at all to any net_device wouldn't be
> numbered as of right now. The only case I identified is when a PHY sits
> between 2 DSA switches, but I don't know how relevant this is.

It might be relevant for the CPU port of the switch. The SoC ethernet
with a PHY has its PHY associated to a netdev, and so it can be
managed. However, the CPU port does not have a netdev, so the PHY is a
bit homeless. Phylink gained the ability to manage PHYs which are not
associated to a netdev, so i think it can manage such a PHY. If not,
we assume the PHY is strapped to perform link up and autoneg on power
on, and otherwise leave it alone.

	Andrew

