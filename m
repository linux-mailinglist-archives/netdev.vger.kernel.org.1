Return-Path: <netdev+bounces-256229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOh0AlHIgWl1JwMAu9opvQ
	(envelope-from <netdev+bounces-256229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:05:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7FFD7491
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 225A530B8804
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 10:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9021C39C625;
	Tue,  3 Feb 2026 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0e5Gwl4s"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857739C62A
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112886; cv=none; b=D4+z4611q0saZXSbb9jiPq8Nm2JyjPoZdqbl5qhZn+Inzm7fTRMk11VE3GeIxdNvmf08+i4H76MR8yNX4azn5Zn2zbEbkUJQIukVcP9D/RcVKDgAMfPb/KoZ9Uu44pK5F6zqZzHwHIB72sSwFSAY7xGs7RAkZdw48C+ngR+nMFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112886; c=relaxed/simple;
	bh=yZlN2p7EKD2ydi+k5ayj0CG0fetwqDgqRK5UFu9fMSs=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=I7JZ2sI4DW6jbHo+STxGeEMFOrtmtdIyMm0bfDd6somumEsfKi1lH5sQN8emtAdlHJPFvVFM0z5bJOp57fruf7vhgIP5YXNc5jlJa5TevKkatuB5dxsK2hifrd3mum4uS+ZC73RZGKzd7QxDIgD/XTD8NBRoC/nWu45TNRMf3Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0e5Gwl4s; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ls29wbQ7VPdzPLzxKpjgX8/RiU9+lNvgMaytuQRwg6A=; b=0e5Gwl4s2DBJlcfOBkwbY++/wF
	SlJZ8xNNIb8SJ1YVwAdDmjChi2bjVLTt03X9Q2098jhdRqootwDiYOKNSNmNdGEA/anaFDRSPBbNN
	pyqdY2xCNX0W4vucrDiBL406bR/o/geYQ0w/uLxH88I8rJ+HRLTd+hbu564nhLB3Rj5Ej1ROkPh0M
	B5XEVjOw0HecDOGvhK2/c0h1RpbNSNM/3Wb8Y3crl9jFEq8i3Nd1qNTvmCCguGJzaGY9D67nAR7W1
	5D+YHfTPowJRnauDAtS2ewHRjVCLhzeQ7gxTFEBWy+TtCOs7k1mGa0FTjA5kWZSo2yk4RixhuTpu/
	RO+YrQdQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38924 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vnDDf-000000004wh-1G8a;
	Tue, 03 Feb 2026 10:01:15 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vnDDe-00000007Xww-2VUU;
	Tue, 03 Feb 2026 10:01:14 +0000
In-Reply-To: <aYHHWm5UkD1JVa7D@shell.armlinux.org.uk>
References: <aYHHWm5UkD1JVa7D@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/4] net: stmmac: add wrappers for
 serdes_power[up|down]() methods
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vnDDe-00000007Xww-2VUU@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 03 Feb 2026 10:01:14 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256229-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 5C7FFD7491
X-Rspamd-Action: no action

Add wrappers for the serdes_power[up|down]() methods and update all
call sites. This will allow us to add state tracking.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 48 +++++++++++--------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9500b332a152..93d18709bc13 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -882,6 +882,26 @@ static void stmmac_release_ptp(struct stmmac_priv *priv)
 	clk_disable_unprepare(priv->plat->clk_ptp_ref);
 }
 
+static void stmmac_legacy_serdes_power_down(struct stmmac_priv *priv)
+{
+	if (priv->plat->serdes_powerdown)
+		priv->plat->serdes_powerdown(priv->dev, priv->plat->bsp_priv);
+}
+
+static int stmmac_legacy_serdes_power_up(struct stmmac_priv *priv)
+{
+	int ret;
+
+	if (!priv->plat->serdes_powerup)
+		return 0;
+
+	ret = priv->plat->serdes_powerup(priv->dev, priv->plat->bsp_priv);
+	if (ret < 0)
+		netdev_err(priv->dev, "SerDes powerup failed\n");
+
+	return ret;
+}
+
 /**
  *  stmmac_mac_flow_ctrl - Configure flow control in all queues
  *  @priv: driver private structure
@@ -981,9 +1001,8 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 	u32 old_ctrl, ctrl;
 	int ret;
 
-	if ((priv->plat->flags & STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP) &&
-	    priv->plat->serdes_powerup)
-		priv->plat->serdes_powerup(priv->dev, priv->plat->bsp_priv);
+	if (priv->plat->flags & STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP)
+		stmmac_legacy_serdes_power_up(priv);
 
 	old_ctrl = readl(priv->ioaddr + MAC_CTRL_REG);
 	ctrl = old_ctrl & ~priv->hw->link.speed_mask;
@@ -4111,14 +4130,10 @@ static int __stmmac_open(struct net_device *dev,
 
 	stmmac_reset_queues_param(priv);
 
-	if (!(priv->plat->flags & STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP) &&
-	    priv->plat->serdes_powerup) {
-		ret = priv->plat->serdes_powerup(dev, priv->plat->bsp_priv);
-		if (ret < 0) {
-			netdev_err(priv->dev, "%s: Serdes powerup failed\n",
-				   __func__);
+	if (!(priv->plat->flags & STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP)) {
+		ret = stmmac_legacy_serdes_power_up(priv);
+		if (ret < 0)
 			goto init_error;
-		}
 	}
 
 	ret = stmmac_hw_setup(dev);
@@ -4222,8 +4237,7 @@ static void __stmmac_release(struct net_device *dev)
 	free_dma_desc_resources(priv, &priv->dma_conf);
 
 	/* Powerdown Serdes if there is */
-	if (priv->plat->serdes_powerdown)
-		priv->plat->serdes_powerdown(dev, priv->plat->bsp_priv);
+	stmmac_legacy_serdes_power_down(priv);
 
 	stmmac_release_ptp(priv);
 
@@ -8130,8 +8144,7 @@ int stmmac_suspend(struct device *dev)
 	/* Stop TX/RX DMA */
 	stmmac_stop_all_dma(priv);
 
-	if (priv->plat->serdes_powerdown)
-		priv->plat->serdes_powerdown(ndev, priv->plat->bsp_priv);
+	stmmac_legacy_serdes_power_down(priv);
 
 	/* Enable Power down mode by programming the PMT regs */
 	if (priv->wolopts) {
@@ -8233,11 +8246,8 @@ int stmmac_resume(struct device *dev)
 			stmmac_mdio_reset(priv->mii);
 	}
 
-	if (!(priv->plat->flags & STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP) &&
-	    priv->plat->serdes_powerup) {
-		ret = priv->plat->serdes_powerup(ndev,
-						 priv->plat->bsp_priv);
-
+	if (!(priv->plat->flags & STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP)) {
+		ret = stmmac_legacy_serdes_power_up(priv);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.47.3


