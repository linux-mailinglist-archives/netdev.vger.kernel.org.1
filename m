Return-Path: <netdev+bounces-178646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9851FA78081
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4E516C0A7
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA2320D50B;
	Tue,  1 Apr 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mtv7kC6x"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C3920B7EA;
	Tue,  1 Apr 2025 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525082; cv=none; b=Q8F2qiYiUci3YG/dnun6pdOHh6t7Osa7zckPWUeIYWF+rR/C73cwjt1uPZnZEi+fZYsTyL3lV8zv+VhM85ME9bBz0NGZjhmCuoO6KJIMkZSnufAPsDkHosM1Vjk6A7qtAeYXiYyA7/CyYITpiQPeijl8/e+ulo1V95F3nxwMVhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525082; c=relaxed/simple;
	bh=KXsNaz4eUmfKifeMxUbmS+yJGRk7Pas5WljQxZ0zVaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/V8KR6Ho9hLdBcnIcA11AC49+Q30rK1TnAP3EUprmxmsXnNEY8kWmEuDO9uS20Y6HoRcYkikF+3BzLl09NfsbFaI9TECK20ibdXx3UxPKdClRzDZf1A3Spy0XhtI7SGEKKnZHcjZrKaj5p3XnAuNf0VGF5aIoZBxM6+4jy1uug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mtv7kC6x; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zTEFQc5dWYUuBsuVKJTFRf6BPFUabOSLuUQv6M/NaUs=; b=mtv7kC6xk2ChNFw+jpUJFuq5fe
	VrjElzIo3L2TH/x+D2KvBRax+IzONx5GZK0evuOqnvr5WlXVtfx9s2LdxuVh7NM/vLzpukOgRVyYr
	5bKNnTfeFOPtUeVBpxNNGTOZTlm08RKnEXaNlptfT+iJdMIn+Kl1XKFGGTOBU0sLRjc9LP/JRQubB
	+Zm1AucNADqY66/GtLsXrMCeC61VEYLnMm1hKfb/Z4aR4Iio4lU6v4N9aSjGY7If5iZI9caec0Ef/
	6EDIqh++B1MgxPkKap+KH8/UwUfO9iU/JimJ8EiiTiaE6nOL0VdgGWggwdfVy6w6aGuTBabeQ66I6
	bof9UvDA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48484)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tzeW0-0006de-0J;
	Tue, 01 Apr 2025 17:31:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tzeVv-0002qU-2E;
	Tue, 01 Apr 2025 17:30:59 +0100
Date: Tue, 1 Apr 2025 17:30:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v5 3/6] net: phy: nxp-c45-tja11xx: simplify
 .match_phy_device OP
Message-ID: <Z-wUwypg9KYVUcBz@shell.armlinux.org.uk>
References: <20250401114611.4063-1-ansuelsmth@gmail.com>
 <20250401114611.4063-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401114611.4063-4-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 01, 2025 at 01:46:04PM +0200, Christian Marangi wrote:
> Simplify .match_phy_device OP by using a generic function and using the
> new phy_id PHY driver info instead of hardcoding the matching PHY ID
> with new variant for macsec and no_macsec PHYs.
> 
> Also make use of PHY_ID_MATCH_MODEL macro and drop PHY_ID_MASK define to
> introduce phy_id and phy_id_mask again in phy_driver struct.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

