Return-Path: <netdev+bounces-181878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC90A86BCC
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 10:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D105A8A7AB3
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 08:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB3B19CC06;
	Sat, 12 Apr 2025 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="g2fL0SiJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1F8199238
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744445363; cv=none; b=qropi33/Wpk5rmkkf1JGbNSZLe0HEcbxMX5ZoT8dNYLOo7/XjiauwkT51SzCz4rKVjmj5mvbBjRI+jObBH1KDKeoIbdNEDdHhvBrsw3A2fNTERMN813+VU6x21NdW/oF4gwachGWSdNSefDynN0IUQ8YerTzqhf7KArHdKzx2FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744445363; c=relaxed/simple;
	bh=WAFOqUl/TRyBIk15Ch1++vj9j2oY+PsMb9v3GEcnEcI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=s+4W6J3F7rXg2bOMFkwUi7hzDhHUxHcpRW0Wp0QaLwX1sgzYO8FUN3lDoj2WyfRFxBbfhvQPAM2CF7eMrRP5TDMyfI8QSi1/s97N1MbW5wRujyllbbVzq3xU9i8EWI3Wq4r6wAj+Vt3jd/Tymg8AyJYt7SwqSYnchRrO3UgbibQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=g2fL0SiJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9qMIXcNMzblzp9RIwLXwsUxv9/cysEMvIvuAUsNL+zQ=; b=g2fL0SiJm1hmi1VzInrX3ZYfMq
	uuYlNlRB+f7yCCkY3QMlKa9fYEPqgCpzZXCyIYChVXHRcOANErQJbGwbMXP+288je+oc/oT7Ldyyg
	NYdv6TsaGWNeJa+EeSIu6lSswNPbfKbDCZDfpQpd2IAWFFxYm8Y9/A9NWeoNuiXMhxefzYWt5OSLY
	+gZbXpgOkuh3/cKVaiQLbfOmy2uvkFbJ1z6nWwtWeTs1pha+WCQWOky9qPgJS6151JkpFGaXx1DYB
	WTNmrEFxMJ4Ac/YOf57/EkPMFPfaI1ox0ELGIQgl4RVmHPQZy16jvrfGNkjBo4NHxPtY9YqdkbL/D
	7BUmxJmQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42084 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u3VvM-0004M4-1G;
	Sat, 12 Apr 2025 09:09:12 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u3Vul-000E7m-1j; Sat, 12 Apr 2025 09:08:35 +0100
In-Reply-To: <Z_oe0U5E0i3uZbop@shell.armlinux.org.uk>
References: <Z_oe0U5E0i3uZbop@shell.armlinux.org.uk>
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
	Philipp Zabel <p.zabel@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH net-next v2 2/5] net: stmmac: intel: remove eee_usecs_rate and
 hardware write
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u3Vul-000E7m-1j@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 12 Apr 2025 09:08:35 +0100

Remove the write to GMAC_1US_TIC_COUNTER for two reasons:

1. during initialisation or reinitialisation of the DWMAC core, the
   core is reset, which sets this register back to its default value.
   Writing it prior to stmmac_dvr_probe() has no effect.

2. Since commit 8efbdbfa9938 ("net: stmmac: Initialize
   MAC_ONEUS_TIC_COUNTER register"), GMAC4/5 core code will set
   this register based on the rate of plat->stmmac_clk. This clock
   is created by the same code which initialises plat->eee_usecs_rate,
   which is also created to run at this same rate. Since Marek's
   commit, this will set this register appropriately using the
   rate of this clock.

Therefore, dwmac-intel.c writing GMAC_1US_TIC_COUNTER serves no
useful purpose and can be removed.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index c8bb9265bbb4..54db5b778304 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -682,7 +682,6 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	plat->axi->axi_blen[2] = 16;
 
 	plat->ptp_max_adj = plat->clk_ptp_rate;
-	plat->eee_usecs_rate = plat->clk_ptp_rate;
 
 	/* Set system clock */
 	sprintf(clk_name, "%s-%s", "stmmac", pci_name(pdev));
@@ -1313,13 +1312,6 @@ static int intel_eth_pci_probe(struct pci_dev *pdev,
 	memset(&res, 0, sizeof(res));
 	res.addr = pcim_iomap_table(pdev)[0];
 
-	if (plat->eee_usecs_rate > 0) {
-		u32 tx_lpi_usec;
-
-		tx_lpi_usec = (plat->eee_usecs_rate / 1000000) - 1;
-		writel(tx_lpi_usec, res.addr + GMAC_1US_TIC_COUNTER);
-	}
-
 	ret = stmmac_config_multi_msi(pdev, plat, &res);
 	if (ret) {
 		ret = stmmac_config_single_msi(pdev, plat, &res);
-- 
2.30.2


