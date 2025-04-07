Return-Path: <netdev+bounces-179870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBD8A7ECCC
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003DD3BE140
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078072222DA;
	Mon,  7 Apr 2025 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AHM7Awvq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E612217F5D
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052377; cv=none; b=oReVilD9/E8/mLmkikK7Hsj9KHiya/ecpEQ62ijpMh3RKBb3xNgm30s1MMBUYKiV58QYCfywCeea2ll7qLE7sefhuO2LPxhoGwXTbKGFPmNgInUuPSdG9/wovLvLgVJWbyOBTNKXnVAxZ30WnxjwExGo0M/dAWTO6sDp8hTuVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052377; c=relaxed/simple;
	bh=NMWh+oHyraNS6SQsmLRJT2+nDcbZkOoJfrne8Mgsn9M=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=JV1zlKvvdAGhZ8+fH8giatJeO34qwyYiJtB/Gi/KxoAZVfe6J8lEvmCi+Har/ozQojsNp0jY2bCZvEyfKzHD7oyN/lrR2VxWyzYBeRyKTIAmzTfAgzQvWRzGLNbYFihCAXInOxqJ/oU/Gw89Tlt3Q+pj1Fk6RExCArV79CmOxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AHM7Awvq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hBtz6Ng9ArKpM+af3s56+9PEKH0n/HDxcMnPXlkcvuA=; b=AHM7AwvqV0FmHKwQ5UK3nAs+qj
	awi//mBHqMSo2FRcyA9+f26sLvSxkzVniia8baE/vsSBybzSsISUUr9hzzmwEjAq15KpzexLzeCAb
	6O0oTjLaeqqZ74TzSZ4gnMpviTo5tAk2BSWmJ07rYT4czyzUac0tjNn19rVWqr3nx0u1bScna6FCk
	9TkPZAG63aeR94ECET0iIGMKM2nu7ocW4uNECGsgNVtKssr5Igc4aJYMSXhFo1lySkIz3hQx38JQO
	PBdH/+W8sH7B309esxeCfz4c094V4otWXu/o5wX9XZUkEMm9OmAsHZn+/LgwyPXegofBC8VvJUtfd
	uNN6TYmg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47702 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u1rgu-00069a-0n;
	Mon, 07 Apr 2025 19:59:28 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u1rgO-0013gj-5r; Mon, 07 Apr 2025 19:58:56 +0100
In-Reply-To: <Z_QgOTC1hOSkIdur@shell.armlinux.org.uk>
References: <Z_QgOTC1hOSkIdur@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 2/5] net: stmmac: intel: remove eee_usecs_rate and
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
Message-Id: <E1u1rgO-0013gj-5r@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 07 Apr 2025 19:58:56 +0100

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


