Return-Path: <netdev+bounces-238303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04505C572F3
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F6A634D6AA
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A7533BBD3;
	Thu, 13 Nov 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ynDPsikW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD0C2E229C
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033257; cv=none; b=Q8jzEg7S+sfB546xIxezgkHCrRyMUHxxcasKNw4/YJQWdcL9kX4qHIZL0y6PkXs5BAk1/oD5LtFguix7NyCu9UQUh5ocGmP1r6mbsoki9DCFxH+ezSrKmc4tCx3jZ95w9uc8d7pdPYcHnAU4NIYLYBuJW4b3FBXXw6pJDYqr4rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033257; c=relaxed/simple;
	bh=qNncOAjgxOyohBoYCOo/vUaIG3xfmjIufnT8hDOdmTA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n+Ueoa/hsGrNDxK8tsA/mCA8XzaoczmzYsgwLf6CqbM87xTLE2fJbW5+LTCdPM8QCIqrRzrEKRdX9wZCLWD05fRT4pwSSNDsSivCGrMAp73wd0IKtTHPRdRKF+hZF9VBPr4MjFpFX16ZqMZv4KyfGy5knTdMD6IPnKOvndmzM0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ynDPsikW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rPrfEjDTu1UDmQs9Z93vMLSFKq6LqWylwXDwbR3MlNY=; b=ynDPsikW/bIEmKiwvMXvpjE82W
	ByjNky3DMCOWcHbDhyhiK2r+SBd9YdQDftEB3CJTEI/cdg11tc6/HAZ2Rl06u2eRvFm5bsDTyIE0M
	CEGl+SHM4wvPvskejv9UVLX8/TMnBVUdP2KN6sZNQyBJ8WlcNnY+hXTCzs9E2YIvK14pvUTseckoE
	yLFQwDXsCQKwfHxtlI/j6G3UKTYKu8VCcrVApZLBisZs5HD+6RGvlUHJ0BFOHUrBOU4EAj3shOpYI
	vqZtYClTxQLMObhTKZQXm3L4lUFmPf3oBgR4ts1A3Ae/LeiWFMMLylc/IA4BwCAjy2iOHSJnpCUsa
	i7XLkMNw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45782)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vJVU8-000000005LD-3Xtn;
	Thu, 13 Nov 2025 11:27:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vJVU6-000000004oR-0uRX;
	Thu, 13 Nov 2025 11:27:26 +0000
Date: Thu, 13 Nov 2025 11:27:26 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	netdev@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 0/2] net: phy: disable EEE on TI PHYs
Message-ID: <aRXAnpzsvmHQu7wc@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

Towards the end of October, we discussed EEE on TI PHYs which seems to
cause problems with the stmmac hardware. This problem was never fully
diagnosed, but it was identified that TI PHYs do not support LPI
signalling, but report that EEE is supported, and they implement the
advertisement registers and that functionality.

This series allows PHY drivers to disable EEE support.

v2:
- integrate Oleksij Rempel's review comments, and merge update
  into patch 2 to allow EEE on non-1G variants.

 drivers/net/phy/dp83867.c    |  1 +
 drivers/net/phy/dp83869.c    |  1 +
 drivers/net/phy/phy-core.c   |  2 --
 drivers/net/phy/phy_device.c | 32 +++++++++++++++++++++++++++++---
 include/linux/phy.h          |  1 +
 5 files changed, 32 insertions(+), 5 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

