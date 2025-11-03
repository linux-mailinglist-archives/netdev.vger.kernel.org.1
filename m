Return-Path: <netdev+bounces-235040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1269C2B8CC
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 12:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CDAB4F7C9F
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 11:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCED305E0D;
	Mon,  3 Nov 2025 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gNKzdyIA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9B1303C8E
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170590; cv=none; b=jCf14Uhd/g4gxcbP+aj7OJf0H63g3ZH9aev+APnuXNmTsFYCjwj3JRKegdJbZib/3sr3wlA7f/+oaYyRmA29DJedGGzSoFpY2LV4HBcAgJKPj3Blath6DFUBC3NAzEW1UhOsdkO1/QG1NuqaVXf7H6ONFmpllH5kNkEEyjfnJpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170590; c=relaxed/simple;
	bh=tVBS72/wkKu2upsUuTa7Hv8lDJkTrOtJ9STg0clPhAw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OCFo2/tcbSI+Be9jpiNlTrvItQo7E3TuvnC9J2AS2m1QxkuZGW1df68lBYqUiqCNwy5cEYYSY4ZhmMAMHJLcuFn5+uUsPpGKrHVaFvAPBORRXLo1ceDvKMUS6vpA8SzJJyZfnUUSk4HiFvKH3kYN5Qm9TEFrWtdPK8E89vFKgzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gNKzdyIA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GTfMsl5VdszDHeLyngBRKiaPiX+MAqFEJJUPqI8k2GI=; b=gNKzdyIAH2mme3mWN8ZqzZZWor
	vNnDr4RJdn7vga8saNkBBGnBLW5U2X78/HI2+HCcVG0VTWh0SIIHJQfU3qWFyWzeGhBCR8MaQGPVj
	rKBALG4yYpxykQEFWOtBtSuE23KFadOONtu5PDwNTLlfc9mGp98uXHRT8Z5+Qkh77ZOSQ45F/HiiI
	Cd8pEeclcM6R8ItQhkSojdVgfuoLLzJd53hFABseSHuns+iLoZT/wPvIyzn7yv5XD591V77ksOSKf
	XvrUjJ4ph1dKJH5Uh64MpOOLpGPAbVTIwnbczewIdaV2RxdxpA7P77vQiaOJS4Xuj6hoqGEbG1FrX
	XIJxknVw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55964)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vFt46-000000000ep-0SZE;
	Mon, 03 Nov 2025 11:49:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vFt43-000000003mC-1llA;
	Mon, 03 Nov 2025 11:49:35 +0000
Date: Mon, 3 Nov 2025 11:49:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, s32@nxp.com,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH net-next 00/11] net: stmmac: multi-interface stmmac
Message-ID: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
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

This series adds a callback for platform glue to configure the stmmac
core interface mode depending on the PHY interface mode that is being
used. This is currently only called justbefore the dwmac core is reset
since these signals are latched on reset.

Included in this series are changes to s32 to move its PHY_INTF_SEL_x
definitions out of the way of the dwmac core's signals which has more
entitlement to use this name. We convert dwmac-imx as an example.

Including other platform glue would make this series excessively large,
but once this core code is merged, the individual platform glue updates
can be posted one after another as they will be independent of each
other.

It is hoped that this callback can be used in future to reconfigure the
dwmac core when the interface mode changes to support PHYs that change
their interface mode, but we're nowhere near being able to do that yet.

 drivers/net/ethernet/stmicro/stmmac/common.h      |  10 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c   | 134 +++++++---------------
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c   |  10 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  54 +++++++++
 include/linux/stmmac.h                            |   1 +
 6 files changed, 115 insertions(+), 95 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

