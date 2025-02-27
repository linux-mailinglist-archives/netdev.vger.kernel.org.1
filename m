Return-Path: <netdev+bounces-170311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D922A48207
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E679519C2BF3
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8C123644A;
	Thu, 27 Feb 2025 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aaqrA2+F"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DD62356CA
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667119; cv=none; b=mofTt5CPqXaBXBguP5IXrHELV+BiNB7fx8XeDECusLF6eqrcJBr0n8915sxhHcy4fj2pimmGJG78I+G/q/G1A+8ZYBmtl0Fi+MRpuGPZdlscVUounIUVg125yu4lk4isiZkNCyPEqDSQhR41hhI+lJBnpBEGYazLgdRh9bHPt9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667119; c=relaxed/simple;
	bh=kreywuJn6St7c3ln+0tGz6pXc44YAcIqkemlj0MKHsI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=b6DjPjvgTMyyX30RFu7HOJjWpQt++PltDWbf3+QWua+27dnvW7D692Gn8aNuA8O4KWHzCgr09v2/j9BMYQBeyGQ/X3bFCwSvgVgPJUbZ2B8PSXOmZNf2CzTA4nzmBiD4kYXRx7WjMM5M08rTLLvuAR5vU0lFd8ARHAb7NrV4s8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aaqrA2+F; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XPPe8F/kupJbrBWpX7qUs66Zlmo1bs9+FraXeKyQyco=; b=aaqrA2+F9wnO1h7yRYzc1K+zoo
	xJ+zo2rKVmWGetuvstVl5xucg/VFXhs1ziaNR/xaaYeihJsZM/JbmeZMDv82jnQUxnmdgUr3FekvW
	CKCdsHzO35xKnRPXaKd+4qB/BNPJZ4iAAN9CKcJ2Aa/p+Dn/aE56bTHk33ElCYxMpzHhKlvhzIpDe
	p4V6YzAjjy1okzORaVKKGwe7DB6yqTmvSCa1d69SWqo4HXaDMDMo9ccqzCg8OQmWP6QgEtsZmg6T7
	TSCPwepsC7gTF9eU8VOgmvDNKBLoXbQkc7Ghf7hlQ/4dC0Ot/GILsUL7lI5HXdp5loxGU3JTnKpWc
	3lHTOtEg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35858 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tnf1x-0007RQ-16;
	Thu, 27 Feb 2025 14:38:29 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tnf1c-0056LO-DN; Thu, 27 Feb 2025 14:38:08 +0000
In-Reply-To: <Z8B4tVd4nLUKXdQ4@shell.armlinux.org.uk>
References: <Z8B4tVd4nLUKXdQ4@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH RFC net-next 5/5] net: stmmac: fix resume when media is in
 low-power mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tnf1c-0056LO-DN@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 27 Feb 2025 14:38:08 +0000

The Synopsys Designwavre GMAC core databook requires all clocks to be
active in order to complete software reset.

This means if the PHY receive clock has been stopped due to the media
being in EEE low-power state, and the PHY being permitted to stop its
clock, then software reset will not complete.

Phylink now provides a way to work around this by calling
phylink_prepare_resume() before attempting to issue a reset. This will
prepare any attached PHY by disabling its permission to stop the clock.
phylink_resume() will restore the receive clock stop setting according
to the configuration passed from the netdev driver.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 23c610f7c779..13796b1c8d7c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7925,6 +7925,8 @@ int stmmac_resume(struct device *dev)
 	}
 
 	rtnl_lock();
+	phylink_prepare_resume(priv->phylink);
+
 	mutex_lock(&priv->lock);
 
 	stmmac_reset_queues_param(priv);
-- 
2.30.2


