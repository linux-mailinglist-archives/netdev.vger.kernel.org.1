Return-Path: <netdev+bounces-209351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E0AB0F533
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 16:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050C8AC2C21
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 14:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2842EF2B2;
	Wed, 23 Jul 2025 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g8TAycsk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628D119CC3D;
	Wed, 23 Jul 2025 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280652; cv=none; b=OYmhCcSwqA7gvYPY+2ztQD0gSlTRavGqlMATVDp59K3lEdeiFgm1ZbkGTmWbeSctAwAOpjniPfJWHiHmNRCSGyA0RHVUsAfuAJwgAJgb/8++7XavFkwYHg2gS9gkpf5vpnHyRmlT75JVZvi4lXybZ2pdH/I4OMVt2ijCM3zVPAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280652; c=relaxed/simple;
	bh=L9EA4XYDWWt7nuzahxqx5W5SRZ08rtg516cT2lVGNlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=By+GBP6k1zeq3yWhzIZ6M5vIgvAGWyH4gWUJJ/j+CkhbQL46Fg7YYhljkCshSHw/BlpPSVj2kH23U9KY5qiL2TeGf6HpR+UhB/OH23WJGx5x9fxofJaa9wz9+pgKcm5EiRuXrPv/dtw3euoYnMyPwdcxxl2PoAy6QzBplgDJ7x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=g8TAycsk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wGnkEZQrJ+KCotninbE6PxpnOQMilZmp9uMJbvlcMQ8=; b=g8TAycskRftknN7I5qk+Oh1vKa
	XMC4Bjn7iTfccsiY/vnnITO0PQk7GPx6zLqJLGwhzTxL6ojmsFudhTCkxcPWwZUefUvfMXt+R8PBp
	BUDjLcdZFuXBBGXSRzWF1jCV8F/TP/P6zPwioNQfXHGfuwfUx9PwuBmPesqPQ1gmisFU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ueaNv-002b7y-9m; Wed, 23 Jul 2025 16:23:55 +0200
Date: Wed, 23 Jul 2025 16:23:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
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
Message-ID: <9f00a6cf-c441-4b4c-84ca-5c41e6f0a9d9@lunn.ch>
References: <faea23d5-9d5d-4fbb-9c6a-a7bc38c04866@kernel.org>
 <f5c4bb6d-4ff1-4dc1-9d27-3bb1e26437e3@foss.st.com>
 <e3c99bdb-649a-4652-9f34-19b902ba34c1@lunn.ch>
 <38278e2a-5a1b-4908-907e-7d45a08ea3b7@foss.st.com>
 <5b8608cb-1369-4638-9cda-1cf90412fc0f@lunn.ch>
 <383299bb-883c-43bf-a52a-64d7fda71064@foss.st.com>
 <2563a389-4e7c-4536-b956-476f98e24b37@lunn.ch>
 <aH_yiKJURZ80gFEv@shell.armlinux.org.uk>
 <ae31d10f-45cf-47c8-a717-bb27ba9b7fbe@lunn.ch>
 <aIAFKcJApcl5r7tL@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIAFKcJApcl5r7tL@shell.armlinux.org.uk>

> We can't retrofit such detection into PHY drivers - if we do so, we'll
> break WoL on lots of boards (we'd need to e.g. describe PMEB in DT for
> RTL8211F PHYs. While we can add it, if a newer kernel that expects
> PMEB to be described to allow WoL is run with an older DT, then that
> will be a regression.) Thus, I don't see how we could retrofit PHY
> WoL support detection to MAC drivers.

WoL is a mess. I wounder on how many boards it actually works
correctly? How often is it tested?

I actually think this is similar to pause and EEE. Those were also a
mess, and mostly wrongly implemented. The solution to that was to take
as much as possible out of the driver and put it into the core,
phylink.

We probably want a similar solution. The MAC driver indicates its WoL
capabilities to phylink. The PHY driver indicates its capabilities to
phylink. phylink implements all the business logic, and just tells the
PHY what it should enable, and stay awake. phylink tells the MAC what
is should enable, and that it should stay awake.

Is this going to happen? Given Russell limited availability, i guess
not. It needs somebody else to step up and take this on. Are we going
to break working systems? Probably. But given how broken this is
overall, how much should we actually care? We can just fix up systems
as they are reported broken.

I also think WoL, pause and EEE is a space we should have more tests
for. To fully test WoL and pause you need a link partner, but i
suspect you can do some basic API tests without one. WoL you
definitely need a link partner. So this makes testing a bit more
difficult. But that should not stop the community from writing such
tests and making them available for developers to use.

	Andrew

