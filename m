Return-Path: <netdev+bounces-170164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43F3A478D1
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DE3188E4FC
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAACF1E1E08;
	Thu, 27 Feb 2025 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vcjrEA4X"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0B92153EA
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647817; cv=none; b=DrL5yHl7ipNgIpPlrVLWySdtN3Rm8CB1kEx+zFfatt8/dwC4WhRART+Z2o2aqA7k2D1QmpL7cnm8YWXOWWCMZ8rFmxOG4hVXXOYVLi0eZVNS0hIHLJKZMEgiMBq/BFYwNpMN/OxSBpXdlBPGYDe9NO9tEuyrS37BXyjuVEPjRH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647817; c=relaxed/simple;
	bh=RbhXV0HJc8fW4BgIFHZgkvkB3Ls6+0LNpZQb+ADIjJk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=oJMuPf9c29NmL5snaKxkVB4BXUeWb2m5wgccZowZMivKPMYTgZfb01hKZ9+tHxZmPCUw2O+Uoqu8zXCoudHcVoqCOixV8lVLxI1y3EQHl9jNFLOxuZ1zMjTkQ6EsQJQsOlu8X7iyebK18IsOJ5kQldzkzlg5f7l+M3vrvKTQ7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vcjrEA4X; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+Is/usG/uTbxek38OoQ9V19tnOww4Olpp8b53U8TJtM=; b=vcjrEA4XEg4A07h0C1gTEKrqbI
	jKt8zGOvkremvhnM1/jbvZCu8x63BANbfIKHk81ELFCHmzAzbHxWQE74LpVEgK/3ovWhfb94M5YZQ
	BUC0jtgRa5bU62QW52gxOyDBfsANj0T9x+iiI+frTJ+I1DDGrDEgpY5h/XT5YXESuoCNPZ2EY4gcw
	w5HFyqMqn8lKK9RsI3aTbTBTlB7QW4AmrujK7wcUBjHEsBtfJSzOzx2PNo718A0EERCw/7XVm1MdP
	ic4srHrzdOmnnDBLcA6Qg1tXxLBZWDpaqs5PFPn4usyxkTmm10VQ2QBhZznlkrd8p8yv6Y/QqzNJt
	lOpNVEBA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36302 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tna0e-0006bo-2R;
	Thu, 27 Feb 2025 09:16:48 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tna0K-0052sY-QF; Thu, 27 Feb 2025 09:16:28 +0000
In-Reply-To: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 02/11] net: stmmac: provide generic implementation
 for set_clk_tx_rate method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tna0K-0052sY-QF@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 27 Feb 2025 09:16:28 +0000

Provide a generic implementation for the set_clk_tx_rate method
introduced by the previous patch, which is capable of configuring the
MAC transmit clock for 10M, 100M and 1000M speeds for at least MII,
GMII, RGMII and RMII interface modes.

Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 32 +++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index b32187284607..3a00a988cb36 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -407,6 +407,8 @@ int stmmac_dvr_probe(struct device *device,
 int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt);
 int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size);
 int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled);
+int stmmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
+			   phy_interface_t interface, int speed);
 
 static inline bool stmmac_xdp_is_enabled(struct stmmac_priv *priv)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e66cd6889728..aec230353ac4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -177,6 +177,38 @@ int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled)
 }
 EXPORT_SYMBOL_GPL(stmmac_bus_clks_config);
 
+/**
+ * stmmac_set_clk_tx_rate() - set the clock rate for the MAC transmit clock
+ * @bsp_priv: BSP private data structure (unused)
+ * @clk_tx_i: the transmit clock
+ * @interface: the selected interface mode
+ * @speed: the speed that the MAC will be operating at
+ *
+ * Set the transmit clock rate for the MAC, normally 2.5MHz for 10Mbps,
+ * 25MHz for 100Mbps and 125MHz for 1Gbps. This is suitable for at least
+ * MII, GMII, RGMII and RMII interface modes. Platforms can hook this into
+ * the plat_data->set_clk_tx_rate method directly, call it via their own
+ * implementation, or implement their own method should they have more
+ * complex requirements. It is intended to only be used in this method.
+ *
+ * plat_data->clk_tx_i must be filled in.
+ */
+int stmmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
+			   phy_interface_t interface, int speed)
+{
+	long rate = rgmii_clock(speed);
+
+	/* Silently ignore unsupported speeds as rgmii_clock() only
+	 * supports 10, 100 and 1000Mbps. We do not want to spit
+	 * errors for 2500 and higher speeds here.
+	 */
+	if (rate < 0)
+		return 0;
+
+	return clk_set_rate(clk_tx_i, rate);
+}
+EXPORT_SYMBOL_GPL(stmmac_set_clk_tx_rate);
+
 /**
  * stmmac_verify_args - verify the driver parameters.
  * Description: it checks the driver parameters and set a default in case of
-- 
2.30.2


