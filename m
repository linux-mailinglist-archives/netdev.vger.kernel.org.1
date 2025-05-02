Return-Path: <netdev+bounces-187459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B56EDAA73D7
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 15:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8B51883A42
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 13:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1052522AB;
	Fri,  2 May 2025 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xM9jZ/0t"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573D14286
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746192972; cv=none; b=KqaPxyM/wy/bsXqtWd3L0QHCu8p92JCCtfNPlQKKxYH1E5yvK4aHZHQCXWYgc8fBj4mvWxUzRVtP461i4QbnG/De+OOQJto0S4uleACUeeBJxi7xRiTlvBsRGTb2z+7yl873OxnpQ0JtPEpSKk604fYyfJcIDpKHgjzDASNPb44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746192972; c=relaxed/simple;
	bh=ArRmfS9Itya8aIP0Iwlpi5vkC8TISMdQ7Am2jq15GFE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SIT+mxyGAEre2O6pzIhqQCjr4X5dsz7hfqV8XFoarEdEPLoU3pYf5JeFCrL3UNcJLUdcBbXat6jTU8Bc6uYh5obdhblx3zZBdzgYGR7PJw8rqcLJvTwt2Jsbqba2WWDQq17x3NmFVKuoLgDUfbvWwxZaeirMRL65KiyFoJNypHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xM9jZ/0t; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C6hIHQx+SVfzP6vh9iCcuOhRCEQHbpsMyOqCsnAJi7o=; b=xM9jZ/0tMjdgANqDrlrVVa0QfH
	jnSeYi/DQiIU0qiSoNkhhiBzzFGODNfXQUCGIIuHIRbf+2cdC/xsAcfK2Cw9NlSMNUP5r0eGaGlwE
	qK2hEHw4tiWsWeuwb74vOZzpekP5LPazAz+U0f4hvNc1D5mfPF9tJvCj/iSkzY67Yoh2EDVBJAWxn
	L4LmVnl/Wwy4q2errs8AYksmUTakP2MP/HBorCn7jDsC5S8yKyL8pltFSEYDVwuquU2+QDT2TCaZ7
	0aB4OOhRSDN15wU9rB9GDLYaTjzfxFrer+ZgJLQDlBha99vCh13hgYpuaXVJqljQyySh4vWnH3+C7
	bqEK4NMw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58874)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uAqYW-0001OF-2J;
	Fri, 02 May 2025 14:35:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uAqYS-0000iq-1x;
	Fri, 02 May 2025 14:35:52 +0100
Date: Fri, 2 May 2025 14:35:52 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH net-next v2 0/4] net: stmmac: fix setting RE and TE
 inappropriately
Message-ID: <aBTKOBKnhoz3rrlQ@shell.armlinux.org.uk>
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

This series addresses inappropriate setting of the receive and transmit
enables in the GMAC control register identified back in
https://lore.kernel.org/r/Z8BboX9RxZBSXRr1@shell.armlinux.org.uk

The databook is clear for the receive enable, that this should not be
set until the initialisation of the MAC and DMA has been completed.
The previous RFC patch series ("net: stmmac: fix resume failures due to
RX clock") which moves phylink_resume() solves that, but we are left
with these enables being set when the link is down. This is not correct.

Sadly, when XDP support was added, new calls to netif_carrier_on() and
netif_carrier_off() were added, which are incorrect in drivers that
make use of phylink - by doing so, the driver has no guarantee that
the .mac_link_up() and .mac_link_down() methods will be called in
sequence anymore. This is fixed in patch 1.

We remove manipulation of the RE and TE bits from the start_tx(),
stop_tx(), start_rx() and stop_rx() methods for each core.

Finally, we remove the stmmac_mac_set() call from stmmac_hw_setup().

v2: add phylink_carrier_*() functions and use these instead to avoid
calling phy_stop()/phy_start(), which may bounce the physical link.

 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |  8 ----
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 12 ------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 23 +++++-----
 drivers/net/phy/phylink.c                          | 50 ++++++++++++++++++++++
 include/linux/phylink.h                            |  3 ++
 5 files changed, 65 insertions(+), 31 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

