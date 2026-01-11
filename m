Return-Path: <netdev+bounces-248808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD88D0EF50
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 14:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCE3D3007ED0
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 13:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695C633122E;
	Sun, 11 Jan 2026 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zhbJvdFJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71197262A
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768137292; cv=none; b=IjmTZMwhzu+afOfPFsv4E4F516dxy/j+n75DSwWgtQgN/tdQICFpc8XwTXYRFwBZgh8QWfOB9vujJG8qiqr0h5U+lgthx5ng2QEuwKOKnLVE4EUOZ4V3fhrfzRxwxDCexw8UyIk/cqotk9Kmj7215SOTyzCyqf3Bc20DcvFR40U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768137292; c=relaxed/simple;
	bh=fC99+DIuP5g8bMIPDz73J6SX9zmtXERZraswhsw18N4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B6XJpjKoK2KTfuS4KdxdmXU7WaFYK+USFWVisj+4eEH3IznLktxPImshd2BJp2vOzjx4VvckkqAayviQyGIAVCFYoOBjypd6deylwtGjPLvOyLs/sibmZFIb8aupMRyiX4JOf9xLertedB9Yxdf6QPOqHisHBLuJlf8dW1P9QCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zhbJvdFJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WwF1Gcz9iHiKKMLX60wVzRv0f2xUV+Pl1/UTVZ/rgK4=; b=zhbJvdFJG1xbOIX9EZGXofp/aF
	rxWWssHcKknP9f3JHVPxEbALA4S0VYbFmYEtV+ejzqo/eM67zYwcatMqzJq08FShind19kUKH7Etj
	z+3hQuL8knERabhXbKFS8HAkxa3DPC4fcIqXOQx7knNWXM3r9Ypuy/ufnio4KI2g2rjoR/EfJF5FK
	VKF1e0KaYlTMMhcudwvxKG95jMXiqLP8rD9it/vT1DJBfMXH1Nlnf5xE+eWCOKI8V4cBUoQJLS3LV
	ZNh3lAS2p0dSe1PJK7d7fj4wzuYUkZNsihJc5weoKfYeFg7mZqGO1misD/07jOy/23iPkfQKh80UG
	iI0/bZbg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33506)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vevHC-000000005Te-33S8;
	Sun, 11 Jan 2026 13:14:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vevH7-0000000078S-2Be3;
	Sun, 11 Jan 2026 13:14:33 +0000
Date: Sun, 11 Jan 2026 13:14:33 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/5] net: stmmac: pcs: clean up pcs interrupt
 handling
Message-ID: <aWOiOfDQkMXDwtPp@shell.armlinux.org.uk>
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

Clean up the stmmac PCS interrupt handling:

- Avoid promotion to unsigned long from unsigned int by defining PCS
  register bits/fields using u32 macros.
- Pass struct stmmac_priv into the host_irq_status MAC core method.
- Move the existing PCS interrupt handler (dwmac_pcs_isr) into
  stmmac_pcs.c, change it's arguments, use dev_info() rather than
  pr_info()
- arrange to call phylink_pcs_change() on link state changes.

 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |  7 +--
 .../net/ethernet/stmicro/stmmac/dwmac100_core.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  7 +--
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   | 22 ++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   | 62 ++++++----------------
 8 files changed, 53 insertions(+), 57 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

