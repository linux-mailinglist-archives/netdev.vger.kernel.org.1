Return-Path: <netdev+bounces-239912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE10C6DF39
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ADEBC3837DA
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E10234BA4E;
	Wed, 19 Nov 2025 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HXCIUPUX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB08534B677
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547763; cv=none; b=Cx5x+02u3E3jwpNnIzUr1teYIcvDyB27YeQPwRa1OBgKuZ5P7l7dxDFM4nrmKLdLtdyBsKMopuMt4NiN33p+4YgHBjBbtstVzyrQLPjTYH5/rzxwtrejVmRJwEvpabDyS5ZJMY5BWwl9CviqAWrXfVyXKqWnuiex+FKD2sxddhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547763; c=relaxed/simple;
	bh=z+G3dYmvtIkyix5bK8GTWH4FShNE72L+4J6kiwdJono=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NiMkpFo5lvFTLUnozX3OV8flJkeaC42enDDM3RT4aynju6AHZl/R9kFMZhHZihcHPJviVt9EBJRUwaq54t6QI3SFNilElT4MWCxGPQ+fCVTH2EgN7u1y4V5aFP2vp+y8uTJm6h5nh0gD96SMujE0eVot7KWhZyA+0Jw3k9U+nV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HXCIUPUX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LMZKxwd8PgRgdlMYw+yU7jfS7/uNgOpqzYUC5NJ6D7g=; b=HXCIUPUXfM62CSAW1aJvwbDwB3
	aSoqI0m9DNDhLlwWq6Uwm7uDSuRdNxrSBIcoe3vWvSBHe9xxpwQpq+oDFoXRInYo/DWmxHLyWLmld
	krl2JNELKSeeXVzjxKevQKJ8y8J4iTqYo4ipj6/P8e8zu/zJNa+U8Yjj+47k62uIz958c6uVgQ/DH
	MVpRIaHjeaE5RItgyiCG68e7gGa+IMiWtmDhGA35ZpZLxGMwpVbxRTNj8n2oXbSb2FXBH+PVH5Uk8
	aM553oIH7JGa9rJUGPy8+QBA4c98zKVlcl5lPqj8ZarJiS908x4Vefkp9i6GauOiFAft0SFcCDJSE
	HsQ5Nqqg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38790)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vLfKc-000000004UL-48D8;
	Wed, 19 Nov 2025 10:22:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vLfKa-000000003L2-1t19;
	Wed, 19 Nov 2025 10:22:32 +0000
Date: Wed, 19 Nov 2025 10:22:32 +0000
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
Subject: [PATCH net-next 0/6] net: stmmac: simplify axi_blen handling
Message-ID: <aR2aaDs6rqfu32B-@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

stmmac's axi_blen (burst length) handling is very verbose and
unnecessary.

Firstly, the burst length register bitfield is the same across all
dwmac cores, so we can use common definitions for these bits which
platform glue can use.

We end up with platform glue:
- filling in the axi_blen[] array with the decimal burst lengths, e.g.
  dwmac-intel.c, etc
- decoding a bitmap into burst lengths for this array, e.g.
  dwmac-dwc-qos-eth.c

Other cases read the array from DT, placing it into the axi_blen
array, and converting later to the register bitfield.

This series removes all this complexity, ultimately ending up with
platform glue providing the register value containing the burst
length bitfield directly. Where necessary, platform glue calls
stmmac_axi_blen_to_mask() to convert a decimal array (e.g. from
DT) to the register value.

This also means that stmmac_axi_blen_to_mask() can issue a
diagnostic message at probe time if the burst length is incorrect.

 drivers/net/ethernet/stmicro/stmmac/common.h       | 13 ++++++++
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    | 28 ++--------------
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |  5 ++-
 .../net/ethernet/stmicro/stmmac/dwmac1000_dma.c    | 30 ++---------------
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   | 30 ++---------------
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h   | 11 +------
 drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h    | 13 ++------
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     | 11 ++-----
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 33 ++++---------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 38 ++++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   |  6 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  4 ++-
 include/linux/stmmac.h                             |  2 +-
 13 files changed, 78 insertions(+), 146 deletions(-)

- 
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

