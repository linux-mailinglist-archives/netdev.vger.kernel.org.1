Return-Path: <netdev+bounces-208656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBC4B0C936
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 19:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210011AA2AA3
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 17:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82072E0414;
	Mon, 21 Jul 2025 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X/7TOYbi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC341E32D3;
	Mon, 21 Jul 2025 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753117652; cv=none; b=aXv7H4YLIR9jiKRM9aS/WVClLiWK97ZNovX9HFYTApt7awMjFjcvG8YhLPY3y7nDnNzPiz8L2S221HBxzRQURh72EbtU6z5k/hwhc/ZgcmVhhZgwODVxn9UQgwvfG7FxDEq6mcQgo2EqWj2dcmbhbSiNnALOtHJEsmNsoVrMBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753117652; c=relaxed/simple;
	bh=he3TT+P6tlhNCxwJTUuZrgo1/Mm06oMGX2ulhjwdQ40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWO3skC7HTNC8o/9ZpXwlY9xSPb841Lvl74Z+Ne5HMmjHcI/3Q8A3n1FiUUOj+kFkNZig7U/Gp44gA1Gjko//hJPWdELIV+HuHGm/r59AKnQdoNZWZ1H+pYIbK6us83SIwrXyeDr2PBugJV8dHWmLcVi5maF9XBMkeAnmOSjuaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X/7TOYbi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ATPRMv6WRS4ltcYjhWI+utSCYQ2pU0+YQZ54Mw2Wv9c=; b=X/7TOYbiNymO23APCZZzJWZm11
	8JWuJ8rAH5b6g52xjDQVrrwKBJyvzOj0yDTbRxXe46pU/cyK/RGilf8hLDFIfFnKS6RJGXlv8VNjW
	wt7HMYS/Vq8zsFgSpNfc+r1HGX0ov6+lSZwPlpzdgiKTlwnu+eMlz53omjI0l+fuHh2Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1udtyp-002Nch-Dr; Mon, 21 Jul 2025 19:07:11 +0200
Date: Mon, 21 Jul 2025 19:07:11 +0200
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
Message-ID: <5b8608cb-1369-4638-9cda-1cf90412fc0f@lunn.ch>
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

> Regarding this property, somewhat similar to "mediatek,mac-wol",
> I need to position a flag at the mac driver level. I thought I'd go
> using the same approach.

Ideally, you don't need such a flag. WoL should be done as low as
possible. If the PHY can do the WoL, the PHY should be used. If not,
fall back to MAC.

Many MAC drivers don't support this, or they get the implementation
wrong. So it could be you need to fix the MAC driver.

MAC get_wol() should ask the PHY what it supports, and then OR in what
the MAC supports.

When set_wol() is called, the MAC driver should ask the PHY driver to
do it. If it return 0, all is good, and the MAC driver can be
suspended when times comes. If the PHY driver returns EOPNOTSUPP, it
means it cannot support all the enabled WoL operations, so the MAC
driver needs to do some of them. The MAC driver then needs to ensure
it is not suspended.

If the PHY driver is missing the interrupt used to wake the system,
the get_wol() call should not return any supported WoL modes. The MAC
will then do WoL. Your "vendor,mac-wol" property is then pointless.

Correctly describe the PHY in DT, list the interrupt it uses for
waking the system.

	Andrew

