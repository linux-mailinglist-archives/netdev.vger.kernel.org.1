Return-Path: <netdev+bounces-154968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06778A0086C
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 12:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3264162127
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 11:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D7D1F9EA7;
	Fri,  3 Jan 2025 11:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="omu4oSb2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685671F9A8B
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735902995; cv=none; b=ufODCBbbAWdphPkYTIqUyRCTuPLmHi5N5na7V+IU4Z7k4IKACqFSmL5lDE1aGJTYCX0atul0HKJwjWaKEC0f+LW7c4SqcmdHtPV3yAXkDfknjLYX1AX228uKibxLx4Xt41T3VC08rwSRapKQU7I6hOJPojZMpms0Wt1QWGkHjww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735902995; c=relaxed/simple;
	bh=vAIVECYjFh7YV0hfWsBwfPI2sPBAS2AlLB+1OpFiCkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qs7KuVjhvVaMBm8IvHcoNtUOAaKeWp+aWhEs9k5npf1ugByF+leMKELlbsiSjxmZsJEyBznOeYngaarNvUlIOjV9iIDh6xSHQkwd7mWWlsY2IU3nOWkVarvrlXVlvAgEsZc6QL1bDTPEB+2ymKdhrX2XZPI0qnEWKYsWkO4cewg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=omu4oSb2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KnnKr1tOZVG12cK+LLFuxnU9SlvnnOfbe1CXtqwo2co=; b=omu4oSb2n/Rx3anVtN7y8fsq6W
	ILbT06ESY8/18a0G6Ad4YiG8uXgbgd8tbeEuBBkTzg9YBJD6H/UkK/6vmh9BhGmWeWg5pDxeBoO+r
	EmcLWybCYb+EcQCxZKg0O/KOhAklMJgpzc7kc6eMm2yDrHmsLA6dWTJrQnmjhYFs0J7a3xkTp3v0b
	7ZwaxxwEJFfvNiD6ifORIUJnEUixetrKN8hGBATpO4Kk5ajHUf8lerm1RZMzyQ4y6Qs7v/u485vsS
	2phrRtLXhA8QRs9kPW4ke7a1I5gNa6M+icLSRRmZwdPF8Vh8d4vzqgXUrXJBK+ZglEUaE4H5ua5XA
	qmVOteUw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38220)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTff2-0002zj-35;
	Fri, 03 Jan 2025 11:16:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTfew-0001H9-1H;
	Fri, 03 Jan 2025 11:16:06 +0000
Date: Fri, 3 Jan 2025 11:16:06 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/6] net: pcs: add supported_interfaces bitmap for
 PCS
Message-ID: <Z3fG9oTY9F9fCYHv@shell.armlinux.org.uk>
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

This series adds supported_interfaces for PCS, which gives MAC code a
way to determine the interface modes that the PCS supports without
having to implement functions such as xpcs_get_interfaces(), or
workarounds such as in

https://lore.kernel.org/r/20241213090526.71516-3-maxime.chevallier@bootlin.com

Patch 1 adds the new bitmask to struct phylink_pcs, and code within
phylink to validate that the PCS returned by the MAC driver supports
the interface mode - but only if this bitmask is non-empty.

Patch 2 through 4 fills in the interface modes for XPCS, Mediatek LynxI
and Lynx PCS.

Patch 5 adds support to stmmac to make use of this bitmask when filling
in phylink_config.supported_interfaces, eliminating the call to
xpcs_get_interfaces.

As xpcs_get_interfaces() is now unused outside of pcs-xpcs.c, patch 6
makes this function static and removes it from the header file.

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++++++++--
 drivers/net/pcs/pcs-lynx.c                        | 13 +++++++++++++
 drivers/net/pcs/pcs-mtk-lynxi.c                   |  4 ++++
 drivers/net/pcs/pcs-xpcs.c                        |  5 +++--
 drivers/net/phy/phylink.c                         | 11 +++++++++++
 include/linux/pcs/pcs-xpcs.h                      |  1 -
 include/linux/phylink.h                           |  3 +++
 7 files changed, 43 insertions(+), 5 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

