Return-Path: <netdev+bounces-211003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7451B1621C
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 15:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1245167BED
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 13:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C19E2D3EDB;
	Wed, 30 Jul 2025 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v9bYDHmL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689A42900A8
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883990; cv=none; b=E44t6AcRF3YhFl+fwnOYAn6c59bcjM06tS3lUWZYjsNMkMx40QOCXZ1y8NeVsHkphMPbHu6df3FR2pGeOulPr4If9QoJWfuiVa9ncdyEcJumwc+KzoXpYw6rV5fzLo0GXNB1xYztSuEOcUllseujf82UTglOyrDMoEbEl35qjXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883990; c=relaxed/simple;
	bh=lpc41LyyfE34SNHK/Abn1mL4YTNmIEDuGPeAWMGsSh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbiGmurag78pjR+lU9Y1Eix6osm2jokBa8eMePDkLRr3gRTi9a0x67CJBunDGztTW65yn0+Tt/cExJP4BsKSt+rIui0oqqac+37mwEopo1/HgptbP/WasEhg50psZoudn4ee+sWe2CsXGWQI1xF3Ia9wlqS2QulCPaT9oDKgrLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v9bYDHmL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uyUM3WVmB2Jd5l9xZIBC8XFu2Ho8Agcrt4JiTbwfAsI=; b=v9bYDHmL/+x0oZe8sQINJZYGln
	8LGhfNpCVz1r0GZsSg1Qo7NDai8ifi0dyiMcOF908UVpyAK1Rc5wUldirLULUZIQ9RKXdVAXqqUaU
	c1sQz7B1lOi8mMJxoYQteqpjuiHjtjhRw/vylURLnfVUVZGqPfYJTMaf4hpt5k/iyjEs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uh7LA-003Hd5-B0; Wed, 30 Jul 2025 15:59:32 +0200
Date: Wed, 30 Jul 2025 15:59:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Braunwarth <daniel.braunwarth@kuka.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC ???net???] net: phy: realtek: fix wake-on-lan support
Message-ID: <a14075fe-a0fc-4c59-b4d3-1060f6fd2676@lunn.ch>
References: <E1uh2Hm-006lvG-PK@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uh2Hm-006lvG-PK@rmk-PC.armlinux.org.uk>

> 2. detect whether we can support wake-up by having a valid interrupt,
>    and the "wakeup-source" property in DT. If we can, then we mark
>    the MDIO device as wakeup capable, and associate the interrupt
>    with the wakeup source.

We should document "wakeup-source" in ethernet-phy.yaml.

What are the different hardware architectures?

1) A single interrupt line from the PHY to the SoC, which does both
link status and WoL.

2) The PHY has a dedicated WoL output pin, which is connected to an
interrupt.

3) The PHY has a dedicated WoL output pin, which is connected directly
to a PMIC. No software involved, the pin toggling turns the power back
on.

For 1), i don't think 'wakeup-source' tells us anything useful. The
driver just needs to check that interrupts are in use.

For 2) we should recommend that the wakeup interrupt is called
"wakeup", following wakeup-source.txt, and the "wakeup-source"
property is present.

For 3) its more magical, there is no interrupt properties involved, so
we do need the "wakeup-source" to know that the pin is actually
connected to something.

We need to differentiate between drivers newly getting WoL support,
and existing drivers. We can be much more strict with new support.

	Andrew

