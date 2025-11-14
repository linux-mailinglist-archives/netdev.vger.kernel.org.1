Return-Path: <netdev+bounces-238697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59389C5E036
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7470F3B8FBA
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718C332BF54;
	Fri, 14 Nov 2025 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Zn9Awb85"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671F3328260
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134054; cv=none; b=PFVn6Gpo0Lh6lCtSL2SrBbJ+rUYfjNxcirwT0eEZ8GqpfE7iqdofNFfajwkXL1SdZs6rv7F9+2hYU6GRTaEEefgW6cBgWgfptiCIavx8NE5KMbqO1SoqB8LNL2E1GEmn6Kg/vbYsEC1EDvCTRJ5uYEEik0lww7AArAYdckyybWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134054; c=relaxed/simple;
	bh=mu2YNn50UMDRZXKZjg2XxkHg0xLTlZF3qSBikoeevQo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SVlNbEHJuVNkEpiwsxlp6e8qadEZOJT8Q5MWP0+eaVZVWzcyiGpUe+jKUDZbqQEwCjeP/c9IVrFLkEnmhnKOR5C40tI+Y+Drt8oAqw5jTCsCfcEdu297kDR1vO4vqON8YRWT1IQnqzb98eQPzVbhgFNO5e7YRnsDeSn0RkOuaDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Zn9Awb85; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=x8I9KPnocTwYvke4KmXVCDz7cZG6pMchNENixp9PaBs=; b=Zn9Awb85lPONKsoStmaW7puSJd
	sWvTakfmHty+CMm9yYGn2u9kg/IUnrIviU8J6r5+kbjT2c+0wtalE3+CQn/03msl6F6/VZrPMbHGN
	SIUgk6n5hY7iVXH8HC565xoQMEjiJg6gFliLTIarrIhlSYHmFiGQ0rUDvcG+D9jhTV/iuCzoMyxLg
	26hEe04rdRWNm3bEIBDiqg1tYbPZAsQo3Y9Tamx1CNrxYEHaKhKoVwZgm9ogMPW3psyb12bFKmQd8
	rmH+Xyh4lmrtsZACjXvvFBQRK4WyREdITOuOn74qX++CZCzNG5vHB5w1eAVUvsJMW3pl2a4KDOZUd
	HTD62yYg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35954)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vJvho-0000000075e-1H7F;
	Fri, 14 Nov 2025 15:27:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vJvhk-000000005wa-1i8p;
	Fri, 14 Nov 2025 15:27:16 +0000
Date: Fri, 14 Nov 2025 15:27:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen Wang <unicorn_wang@outlook.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, sophgo@lists.linux.dev
Subject: [PATCH net-next 00/11] net: stmmac: clean up plat_dat
 allocation/initialisation
Message-ID: <aRdKVMPHXlIn457m@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

This series cleans up the plat_dat allocation and initialisation,
moving common themes into the allocator.

This results in a nice saving:

 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  | 43 +---------------
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   | 22 +-------
 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c |  1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 34 ++++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   | 39 +-------------
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 60 ++++------------------
 7 files changed, 53 insertions(+), 148 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

