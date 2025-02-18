Return-Path: <netdev+bounces-167297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0848A39A49
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43EDD7A45D8
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 11:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C772324112F;
	Tue, 18 Feb 2025 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VBnSLYdE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0190223FC42
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877300; cv=none; b=QDsxFQcrfm/LvBSnOwA8ZDSXu1UBdo6unMdsYrXxaoznGLFnq7lc24PhxMLF1hJSfMmqIqAPwWIIyQzrov+rQFhgFUuLdDGRwAEeVMK8qX+cm6IZbgQpEprxTOcdKgyDBJmDh7EkQELwh6D8H/E+/EfRVswMV/lMHy9WcvnDnno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877300; c=relaxed/simple;
	bh=xCyewt8yClFT75JdJZ0OkuPSWHYtt9k1lIyQcq3u4EI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FW120RIYUmsNLixMEUq4AimK82iw83GR+EDcHOiE6gCJSuI8mv7qfP1SqpxKr8mmQ2AlqX5JmNR3syLoaautWyIqGdQnsAg5mcVq+iu+3qysCSYiZOPSSdBu1K9/41Qpm/DEwO01jJOOkComhdy2V0fAfk1y5GMu3Db5c3vNgz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VBnSLYdE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=goozUNnJLLkrSorBmN4CSjqgYHxzSyfaXsVrvCrQJa4=; b=VBnSLYdEwASJZI+Z1Kv8WaqVUj
	Gu1Tah9MVvryFRKBG2JxPljesgrEr0NiylzHcyGbSkupA97NOevzP68oL884NugEsBs15/E/eSgar
	pNC/xNuhPK3r9JnPzndMZ9oTPjU+4Hn/cv283WqtPJLFn3soXzRVappfV0arMsxtWs+BfkrRpKYni
	tt3eskO9YIk5T8Ikk5aU6pVa7+uzAV9Kzer3jQcSpbdTpHpugb17KVJR/gfw4lZOpqwTqRxOe1Wru
	YMPm06bYKyELzNlxSc9sb84+KaYUvqjmTW+g29Ce/s7mWn1KzQkuW0Mt/V76Qqt9PjRgw7tlBvmZ+
	b0GG4ECg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58960)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tkLYp-0001hN-3B;
	Tue, 18 Feb 2025 11:14:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tkLYl-0007Da-2g;
	Tue, 18 Feb 2025 11:14:39 +0000
Date: Tue, 18 Feb 2025 11:14:39 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Inochi Amaoto <inochiama@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH RFC net-next 0/7] net: stmmac: cleanup transmit clock setting
Message-ID: <Z7RrnyER5ewy0f3T@shell.armlinux.org.uk>
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

A lot of stmmac platform code which sets the transmit clock is very
similar - they decode the speed to the clock rate (125, 25 or 2.5 MHz)
and then set a clock to that rate.

The DWMAC core appears to have a clock input for the transmit section
called clk_tx_i which requires this rate.

This series moves the code which sets this clock into the core stmmac
code.

Patch 1 adds a hook that platforms can use to configure the clock rate.
Patch 2 adds a generic implementation.
Patches 3 through 7 convert the easy-to-convert platforms to use this
new infrastructure.

 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    | 10 +----
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |  5 ++-
 .../net/ethernet/stmicro/stmmac/dwmac-intel-plat.c | 24 ++----------
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c    | 22 ++---------
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   | 26 ++-----------
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 43 ++++++++++++++++++++++
 include/linux/stmmac.h                             |  4 ++
 8 files changed, 65 insertions(+), 71 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

