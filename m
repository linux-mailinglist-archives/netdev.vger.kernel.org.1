Return-Path: <netdev+bounces-102299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9EC90243A
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED721F249C3
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8F712FF86;
	Mon, 10 Jun 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kfWY4TsC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195AB80BE5
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030446; cv=none; b=q9SaYhzJiXQrpdyZwwhb8za01a9IYU1ymGlRMRh6QROvNYUx83Nv84hr9om98vfcYnOjEPc9JyWQRCQty8OagQio22Wj2gxft291Ocyeb+9g7L7gIPoFtdt3B2Uqo1pFfIG62HC5WAgqOf4gQ1k8KoSdfGkgWh1Bi2ff1mZ/Am0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030446; c=relaxed/simple;
	bh=8cgXOuc05YqlvcSTRVt5oHwmke6xdfBgQiSijkGOGfg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=I3NzxNRnYBWI2Iyirau7ztB7jAKWh3DyUFyWsNYOAfSnVyG7M/nFR4xnZBylJn3juFoL5JVJFO6i0e+WMvaJhnWNSUg4J7y9V/ozKr3bmqsCvqPr2enK8NzybBydGRcADUFB7CiSUZYl4D+VtXwh932BXU/F1kPRkDz2Vx1fxSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kfWY4TsC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z2ysErSY7/KD9NFUvu+f/pl6Tbexshy7z97dxZsQWrs=; b=kfWY4TsCcc1grEGTbn+Brd+Lrn
	m5o0JB6UbNBZhCHcgxPXyICBmOv1uKggVfJOplpzdr971WSYcvl+5mNLlHrUbG2eePp89y3jv2uYK
	pdtXsgyGInPMZIOpZR06j9Fz3RKcchR9hMadm0Np5igW8Lft5oPCgGog2Mxy2vJgcsH2AKGFsHFId
	3T5vf9RQfy9eOpiNGvUV4iZ8Dd5TPj8C/P8bsCUOCbuLobabkH3Bmg98wugOdciQgoZZwPkgjYMF0
	/wK7Yd1iWTCLRMZNqEzzzLFP2JS03ADPRynhc2q9DA9623vdBUC5YRXEZaC5uXQFw2Z/rIdWuch/8
	BzRn9qAg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46476 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sGgCE-0001eh-2K;
	Mon, 10 Jun 2024 15:40:31 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sGgCH-00Facn-T6; Mon, 10 Jun 2024 15:40:33 +0100
In-Reply-To: <ZmcQTuR5IKRp0pgy@shell.armlinux.org.uk>
References: <ZmcQTuR5IKRp0pgy@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next 1/5] net: stmmac: add select_pcs() platform method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sGgCH-00Facn-T6@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 10 Jun 2024 15:40:33 +0100

Allow platform drivers to provide their logic to select an appropriate
PCS.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 +++++++
 include/linux/stmmac.h                            | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index bbedf2a8c60f..302aa4080de3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -949,6 +949,13 @@ static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
 						 phy_interface_t interface)
 {
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
+	struct phylink_pcs *pcs;
+
+	if (priv->plat->select_pcs) {
+		pcs = priv->plat->select_pcs(priv, interface);
+		if (!IS_ERR(pcs))
+			return pcs;
+	}
 
 	if (priv->hw->xpcs)
 		return &priv->hw->xpcs->pcs;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 8f0f156d50d3..9c54f82901a1 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -13,7 +13,7 @@
 #define __STMMAC_PLATFORM_DATA
 
 #include <linux/platform_device.h>
-#include <linux/phy.h>
+#include <linux/phylink.h>
 
 #define MTL_MAX_RX_QUEUES	8
 #define MTL_MAX_TX_QUEUES	8
@@ -271,6 +271,8 @@ struct plat_stmmacenet_data {
 	void (*dump_debug_regs)(void *priv);
 	int (*pcs_init)(struct stmmac_priv *priv);
 	void (*pcs_exit)(struct stmmac_priv *priv);
+	struct phylink_pcs *(*select_pcs)(struct stmmac_priv *priv,
+					  phy_interface_t interface);
 	void *bsp_priv;
 	struct clk *stmmac_clk;
 	struct clk *pclk;
-- 
2.30.2


