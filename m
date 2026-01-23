Return-Path: <netdev+bounces-252806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA2vKS9Vc2kDuwAAu9opvQ
	(envelope-from <netdev+bounces-252806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:02:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3B674BB2
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A56830193A3
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189A5318B8B;
	Fri, 23 Jan 2026 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ddOs+3RH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABD22F25E4
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166124; cv=none; b=WvR0d2U2g+SLnU15jV6aAfunwFS6b+ESlhwWD5K6vqNZjpdFvstPdy8zydsaYR+f1QeFK5og+RJn6g7h7A0McV9LZcdYQQNt947OtMx9q2MX1qjrsURoyVRHiVkWRhUP4LeqMMzu57g7fUpAgzy85N5SmOj006YAeiGH4tL+SII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166124; c=relaxed/simple;
	bh=e96jg7OwE2r0ekrdhwJZnYHYnmL8MGX0dN0vYX28pII=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=qV9sStIgCC9YeweacpAptJNnEaVdoFYLT+UsPuLFBWELqh6vlMFf9f2uD7wtMBs/EjIxfhvCYURVNZKpb8IQyrv6zDiMTP0mMikLjOZCi8rHLMfmnNZxYOgu3OE656T1WKRnuRGbCLYQSrUTQF5hND6+NRTPLcXAQmyG/YBTfi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ddOs+3RH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6H4RkMNQBD86K6h3RpMIs8+fLiyTgqows1prrkVr0U0=; b=ddOs+3RH+3PyumGxMfND58X8BB
	Z2mMzVfAedxmLKZ1SQoTPM+wo3S9at/Opgi091E9GDvVYlFX6Qp7X1RQZTGmLnk4xPSxJtsTwRKhp
	PYEWbouv4ZvF5YuYRkL6lDUVra6KFlYx43BVUA9PDDQW7o/efbXozfely/KpK2jxx1xM9GVfEyVbZ
	LrcmkMp6wWuSP3n9vzISLsCDPSt4N0Ltp/T3milS5DubDI49SlXrAQ6ow43tboyC6PiaWATD4Zzxh
	Pd+zka9cCLRus07QYRAZ+pJZ71m/KkrrG++QnrIL2t61Fv2xVTf+vKIQ6uFHkWWZUm4+5hTFh6PFA
	2Byd6/tA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42710 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vjEv8-000000001qq-1hRV;
	Fri, 23 Jan 2026 11:01:42 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vjEv5-00000005gh7-2F9C;
	Fri, 23 Jan 2026 11:01:39 +0000
In-Reply-To: <aXNUlVZilT-CTgph@shell.armlinux.org.uk>
References: <aXNUlVZilT-CTgph@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 16/21] net: stmmac: rk: introduce flags indicating
 support for RGMII/RMII
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vjEv5-00000005gh7-2F9C@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 23 Jan 2026 11:01:39 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252806-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F3B674BB2
X-Rspamd-Action: no action

Introduce two boolean flags into struct rk_priv_data indicating
whether RGMII and/or RMII is supported for this instance. Use these
to configure the supported_interfaces mask for phylink, validate the
interface mode. Initialise these from equivalent flags in the
rk_gmac_ops or depending on the presence of the ops->set_to_rgmii and
ops->set_to_mii methods. Finally, make ops->set_to_* optional.

This will allow us to get rid of empty set_to_rmii() methods.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 35 +++++++++++++------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 802052beb668..49a075565832 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -52,6 +52,8 @@ struct rk_gmac_ops {
 	struct rk_clock_fields clock;
 
 	bool clock_grf_reg_in_php;
+	bool supports_rgmii;
+	bool supports_rmii;
 	bool php_grf_required;
 	bool regs_valid;
 	u32 regs[];
@@ -85,6 +87,8 @@ struct rk_priv_data {
 	bool clk_enabled;
 	bool clock_input;
 	bool integrated_phy;
+	bool supports_rgmii;
+	bool supports_rmii;
 
 	struct clk_bulk_data *clks;
 	int num_clks;
@@ -1401,6 +1405,9 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 	bsp_priv->clock_grf_reg = ops->clock_grf_reg;
 	bsp_priv->clock = ops->clock;
 
+	bsp_priv->supports_rgmii = ops->supports_rgmii || !!ops->set_to_rgmii;
+	bsp_priv->supports_rmii = ops->supports_rmii || !!ops->set_to_rmii;
+
 	if (ops->init) {
 		ret = ops->init(bsp_priv);
 		if (ret) {
@@ -1419,11 +1426,11 @@ static int rk_gmac_check_ops(struct rk_priv_data *bsp_priv)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
-		if (!bsp_priv->ops->set_to_rgmii)
+		if (!bsp_priv->supports_rgmii)
 			return -EINVAL;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
-		if (!bsp_priv->ops->set_to_rmii)
+		if (!bsp_priv->supports_rmii)
 			return -EINVAL;
 		break;
 	default:
@@ -1469,24 +1476,32 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 	switch (bsp_priv->phy_iface) {
 	case PHY_INTERFACE_MODE_RGMII:
 		dev_info(dev, "init for RGMII\n");
-		bsp_priv->ops->set_to_rgmii(bsp_priv, bsp_priv->tx_delay,
-					    bsp_priv->rx_delay);
+		if (bsp_priv->ops->set_to_rgmii)
+			bsp_priv->ops->set_to_rgmii(bsp_priv,
+						    bsp_priv->tx_delay,
+						    bsp_priv->rx_delay);
 		break;
 	case PHY_INTERFACE_MODE_RGMII_ID:
 		dev_info(dev, "init for RGMII_ID\n");
-		bsp_priv->ops->set_to_rgmii(bsp_priv, 0, 0);
+		if (bsp_priv->ops->set_to_rgmii)
+			bsp_priv->ops->set_to_rgmii(bsp_priv, 0, 0);
 		break;
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 		dev_info(dev, "init for RGMII_RXID\n");
-		bsp_priv->ops->set_to_rgmii(bsp_priv, bsp_priv->tx_delay, 0);
+		if (bsp_priv->ops->set_to_rgmii)
+			bsp_priv->ops->set_to_rgmii(bsp_priv,
+						    bsp_priv->tx_delay, 0);
 		break;
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		dev_info(dev, "init for RGMII_TXID\n");
-		bsp_priv->ops->set_to_rgmii(bsp_priv, 0, bsp_priv->rx_delay);
+		if (bsp_priv->ops->set_to_rgmii)
+			bsp_priv->ops->set_to_rgmii(bsp_priv,
+						    0, bsp_priv->rx_delay);
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		dev_info(dev, "init for RMII\n");
-		bsp_priv->ops->set_to_rmii(bsp_priv);
+		if (bsp_priv->ops->set_to_rmii)
+			bsp_priv->ops->set_to_rmii(bsp_priv);
 		break;
 	default:
 		dev_err(dev, "NO interface defined!\n");
@@ -1522,10 +1537,10 @@ static void rk_get_interfaces(struct stmmac_priv *priv, void *bsp_priv,
 {
 	struct rk_priv_data *rk = bsp_priv;
 
-	if (rk->ops->set_to_rgmii)
+	if (rk->supports_rgmii)
 		phy_interface_set_rgmii(interfaces);
 
-	if (rk->ops->set_to_rmii)
+	if (rk->supports_rmii)
 		__set_bit(PHY_INTERFACE_MODE_RMII, interfaces);
 }
 
-- 
2.47.3


