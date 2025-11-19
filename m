Return-Path: <netdev+bounces-239992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 490C3C6EEED
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC0DD4FCB94
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10949359FBE;
	Wed, 19 Nov 2025 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0SrAqVdn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF43587C8
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558677; cv=none; b=OHislq5F/TjPe7SKjNdl3EuFtynhyZyRi/yVkwsLLeM4yrSlT4dYbheeDdQ9i+TWRMs/W4m6B4drJjni2dZR1QHNAntWg+1gVGxlakZu8+d4SZwmPKN0sv2CA4YGn/cKGo1eexYs3lj5e5o7Wu2LItytTN1p020kHv9leptsPu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558677; c=relaxed/simple;
	bh=+xiZM4qTPSQRxIeNBcHhAh/Hjv5Hssw1WB27bUrae3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Njf4faWw5K1GYkJ6pqStstMc2yR01AgJwBSTgvZ5QDSB/Xz162BYo1sSsNnT7DbdeRKRyHI4M9fu0aFWD4YUKHnQAyYZ0GdlAiA48cCAwEmxZYMoX6QzvabZiRfQ/Z7S8WKpKiebQeWi4bqZJytUkcuxKRmpMSVNRgb1qu137R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0SrAqVdn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KlzV6fNSYpqo/evRQgp3nfPkie9yh48RUddK4nisswQ=; b=0SrAqVdnGTbnKKkYCHeAF+BZZQ
	XIMG9rTwaSkfJKOoX7hd0OUoLXrInxmuHf0GqAKn4QJGjWwDtt8QU5PHOpZTFNz0+2b+drjg0qNvO
	4Pc2vrvcpqHQ4OdSkdIU6gM4v/xRkN2DyRtA6XbVdQqteusXiZzZXpmYOPHps7jZiODQ7Wuo1yW/s
	nWchQxMXv50gPXFus1lmz5j9/2ZsB+OAEdTobEcK1b23o+fB4hWSl8+0S6DiiplFFD6hPYYZtL2JH
	CpUXj/anhOC9kAxuv4brsGc3THgiNuUUWbfaG0dv2YXTyCQGrjDwRdmVg0wavtGJ5L8nR8iEY858a
	YHbSeDKA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55904)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vLiAO-000000004pX-0a77;
	Wed, 19 Nov 2025 13:24:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vLiAM-000000003Se-1DFf;
	Wed, 19 Nov 2025 13:24:10 +0000
Date: Wed, 19 Nov 2025 13:24:10 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/9] phy: add hwtstamp_get callback to phy
 drivers
Message-ID: <aR3E-mPm_ZWXov8C@shell.armlinux.org.uk>
References: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
 <20251119124725.3935509-3-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119124725.3935509-3-vadim.fedorenko@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 19, 2025 at 12:47:18PM +0000, Vadim Fedorenko wrote:
> PHY devices had lack of hwtstamp_get callback even though most of them
> are tracking configuration info. Introduce new call back to
> mii_timestamper.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

