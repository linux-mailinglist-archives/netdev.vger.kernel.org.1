Return-Path: <netdev+bounces-237586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AB8C4D781
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9206E1896CB1
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2625357723;
	Tue, 11 Nov 2025 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fxNQR7fQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09803563C1
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 11:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861111; cv=none; b=mqFT4EnXcxizRwVUEnjyovZh7HCoNZneaKaUBt4OZMcBKbsN0i6o9QMxKOhA8oTAE2NzIHVBLX9JArX3bhXEjtfkm9ara1Lk89UIJN7FS24HSj7TqXv+6JlnbXVE7PLMMEwR7V+ejwNeW1EBmiBwCf5anxfo/ou6z8LAxUxXJZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861111; c=relaxed/simple;
	bh=0PNbj1sRb7APtOeX+IpFLpFowm7o3wYxfaEPOAXl8oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vol4Wh2kfLBA5b1qfQv1i1lSkKuRfI6vFhd2QMwhPvukOEDUrAITbyM80GKMs/z/VUzOlRRfTVE5kNLodiWLZ/QNW06YNNayiMCtMxWwZ04KU2+M4kzergDrxLyy1gz6XLCAJr6Cq877J8/PKc+HLf5zkl5H1Qvn8jcugzncMMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fxNQR7fQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zJ1f1Txapb4txAgVITSGOVqpaXWnTkTd8UQzWX4wePc=; b=fxNQR7fQq/a3qZSKd3f+w9VAgp
	PnGRjFxACWoUEgOwyJ2E0I/87peKOVo5tV1tX6rIVVWfheWMsEZl5L1ci21bhrwVCdaQpVnYfmUeu
	duvPa95x0as4bjCRa9d+XDexPrH9axT5M7zdaBGPLq5WC0DJgeuj1nhsyNgFOdA4tWelboVt3QE2G
	Yy4vrnEsiXhR8QGq+9TmliJpYGMGTlIFdj3xPKm5RK+2uKd35VEv8UBPwULWTtAtuaLNhIehhvj/x
	4lV769PVTIH5CHRjC04T5dBCsjh3D4LbTjBcAzmskfVKbaQZfdTdVCrb8vRqZyze8+puz86K/KaCS
	9hpxLCQw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60594)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vImhc-000000002VT-28fI;
	Tue, 11 Nov 2025 11:38:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vImha-000000002uH-14CL;
	Tue, 11 Nov 2025 11:38:22 +0000
Date: Tue, 11 Nov 2025 11:38:22 +0000
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
Subject: [PATCH net-next 0/2] net: phy: disable EEE on TI PHYs
Message-ID: <aRMgLmIU1XqLZq4i@shell.armlinux.org.uk>
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

 drivers/net/phy/dp83822.c    |  3 +++
 drivers/net/phy/dp83867.c    |  1 +
 drivers/net/phy/dp83869.c    |  1 +
 drivers/net/phy/dp83tc811.c  |  1 +
 drivers/net/phy/phy-core.c   |  2 --
 drivers/net/phy/phy_device.c | 34 ++++++++++++++++++++++++++++++----
 include/linux/phy.h          |  1 +
 7 files changed, 37 insertions(+), 6 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

