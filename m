Return-Path: <netdev+bounces-242344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B39C8F7B3
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 17:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6663A4840
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8042C21F7;
	Thu, 27 Nov 2025 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yThXhOUf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8222C0286;
	Thu, 27 Nov 2025 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764260339; cv=none; b=ERnDwanA7vTqaiwZbfPm0k7qEPEh0nbANPNSXuGJuKB8OPzJ5kpBf6D/OxgPlC+8YkcIqtHGOBK3h/wNRurCmzmzUlay3A/mH/eU4xKGUqO/SHrzMGGWIo/KNRT0QpcCHIPIrADe0WvBFBd5i2tvo4vyJ9UlIJJF2SOvS20YFF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764260339; c=relaxed/simple;
	bh=t2uDBz+82j0w9NcSM/JsgG1kyNntMTuHnmJDiLWQMzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6YNbXS/Zn6vkNgHTsnhlOpc+pN/4DdZp5eBM89zfqi+p9s7i0/aaQNjf8WGeJR8qo+PDogDipcOhXMyDzXnvBb4dVeDHjwxuYvkHE7Y6qAjlO8dbK1crail4q2mhvQYz6zSyhbldp921R0DlEerYSe3sqOghaRZaEuDgyMdqNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yThXhOUf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8T5HkI0We3VI+g02Vs8peXV0afuVb0skw3QtQvz86hQ=; b=yThXhOUfxO+KekHEbI6ub96dfG
	NuncKTsQjvJZjv5Os5/zit+DZUBPO9bMUvp546l9XvLzUUQJ1yCr/VjSnwTw93A91RY8NYsZjuMwD
	q8VxGVgSnnstwKjX26UfvQ0ELQEVkz5Rb4WwL4Zc+8aBIUUGOpesG5NPl3eCdCiu/6DuPRXiA+1Kf
	yoWipp+7vAlxLUUrrKWuzmcFF/4CMJ/WlO4qH85t4BxUxWQmXkPb5A5UG/+lYTJcDZhCKVOO+oO42
	KWbId3OwImBatduZHiBJgqEJRxRqhZOKky24jIZMqjImgTOK8mH9HYq+c1PIdrvhCGRiYXiQT7M/Y
	TquobJnw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46534)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vOehZ-000000005UE-1W3B;
	Thu, 27 Nov 2025 16:18:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vOehX-000000002oA-0AlO;
	Thu, 27 Nov 2025 16:18:35 +0000
Date: Thu, 27 Nov 2025 16:18:34 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Rob Herring <robh@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jonathan Corbet <corbet@lwn.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Lukasz Majewski <lukma@denx.de>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Divya.Koppera@microchip.com,
	Kory Maincent <kory.maincent@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v8 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <aSh52mXPMr3ijY-m@shell.armlinux.org.uk>
References: <20251119140318.2035340-1-o.rempel@pengutronix.de>
 <20251125181957.5b61bdb3@kernel.org>
 <aSa8Gkl1AP1U2C9j@pengutronix.de>
 <20251126144225.3a91b8cc@kernel.org>
 <aSgX9ue6uUheX4aB@pengutronix.de>
 <7a5a9201-4c26-42f8-94f2-02763f26e8c1@lunn.ch>
 <c14b1dae-142e-4038-92a9-cfcad492f4e2@bootlin.com>
 <b4ae88a8-3db7-434a-92d8-90734f6d7682@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4ae88a8-3db7-434a-92d8-90734f6d7682@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 27, 2025 at 04:48:42PM +0100, Andrew Lunn wrote:
> Maybe for the last year, when i have seen broken pause, i've been
> reporting the problems but also pushing developers towards
> phylink. phylink also does all the business logic for EEE, and is
> starting to get WoL support.

Not "starting" - it has a full implementation for it, unless I'm
missing something.

What is missing is the upgrade of phylib drivers to a more modern WoL
approach where they actually tell us that they truly are capable of
waking the system - I don't think that's something we has core code
maintainers can really get involved with, but push people to do the
necessary leg work to make it so.

We have far too many phylib drivers that implement the get_wol
without a thought to whether the hardware can actually wake the
system, and that is completely incompatible with having logic to
determine whether a certain WoL configuration should be set on the
PHY or the MAC.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

