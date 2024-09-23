Return-Path: <netdev+bounces-129307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCA397ECAF
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 16:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 902C2B22233
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 14:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AF0197A97;
	Mon, 23 Sep 2024 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WC+O9xxU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF94198A05
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727100078; cv=none; b=jULO+VcN162nRJbtM/TKJ1Z89Q2MWFqNBylSwg2/hsiOtnkaP1Cf7rZwfX/S38638PjYvwqxUeweHssWJVQ1OQovFHCH+l42YlhNvG9H8iV/2eA0I0Zojnw33NZ7UYZeri8Nc+Gsyjhs6VeYWVFRMzIZjBxdblQpO6d88oV6Q/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727100078; c=relaxed/simple;
	bh=padsI1+u/2z+xQhAZgWLYTo75R+tN+YHKNWR168uLMU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ESJkGAJtjWgBssTsbtQ/xEZeC5firrgnLnxSPuX9xYFqgfAwP90qKTUJ0s3HJ62GV1DQys0CQ6qleztW9yrZGd7XJX7yWC4MpMpGNVEYsG9OvgrkQX9ho9mO8oSl8GnBB7nq82IRXzvbh3UVrbNJZmonmBi1EySq4bf36HcVh1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WC+O9xxU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y7px9IibGHhWdcHZiXEt45/kKOgBPnK4DjembK1POGs=; b=WC+O9xxUhbi6tnZQr8Ofz31G6L
	6HGYv3B+6HRrsgWn6Yj8st/vpA+IAtyfV0njSNblMthVivdQZCzpMLiMF6mZqN9lTGsKY0DbO94v+
	XcF0y6XnMKsaNsuVV5hNRt+r+85xAIzcoSG7n/a7o0+QHb3JWxoprqvMjHqkh9R70oqSQMoPvDaCI
	qG7gW3nUeTh84OldeJZAQ/MArmjoK0We1qCgKPCFKddpXk40qOScTIMjblgv0F8mNn071pTKz4Y3D
	yYwQTk6BOS0G93D5KwIwKv8dMp7PuX1ZCVMTADC6LDUuelB5R+et9Vev9dOIuJfs+JTPruiV1rwmJ
	aeBvHwdw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45872 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ssjcb-0004H9-12;
	Mon, 23 Sep 2024 15:01:01 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ssjcZ-005Nrf-QL; Mon, 23 Sep 2024 15:00:59 +0100
In-Reply-To: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 01/10] net: pcs: xpcs: move PCS reset to
 .pcs_pre_config()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ssjcZ-005Nrf-QL@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 23 Sep 2024 15:00:59 +0100

Move the PCS reset to .pcs_pre_config() rather than at creation time,
which means we call the reset function with the interface that we're
actually going to be using to talk to the downstream device.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c   | 39 +++++++++++++++++++++++++++---------
 include/linux/pcs/pcs-xpcs.h |  1 +
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 82463f9d50c8..7c6c40ddf722 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -659,6 +659,30 @@ int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns, int enable)
 }
 EXPORT_SYMBOL_GPL(xpcs_config_eee);
 
+static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
+{
+	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
+	const struct dw_xpcs_compat *compat;
+	int ret;
+
+	if (!xpcs->need_reset)
+		return;
+
+	compat = xpcs_find_compat(xpcs->desc, interface);
+	if (!compat) {
+		dev_err(&xpcs->mdiodev->dev, "unsupported interface %s\n",
+			phy_modes(interface));
+		return;
+	}
+
+	ret = xpcs_soft_reset(xpcs, compat);
+	if (ret)
+		dev_err(&xpcs->mdiodev->dev, "soft reset failed: %pe\n",
+			ERR_PTR(ret));
+
+	xpcs->need_reset = false;
+}
+
 static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 				      unsigned int neg_mode)
 {
@@ -1365,6 +1389,7 @@ static const struct dw_xpcs_desc xpcs_desc_list[] = {
 
 static const struct phylink_pcs_ops xpcs_phylink_ops = {
 	.pcs_validate = xpcs_validate,
+	.pcs_pre_config = xpcs_pre_config,
 	.pcs_config = xpcs_config,
 	.pcs_get_state = xpcs_get_state,
 	.pcs_an_restart = xpcs_an_restart,
@@ -1460,18 +1485,12 @@ static int xpcs_init_id(struct dw_xpcs *xpcs)
 
 static int xpcs_init_iface(struct dw_xpcs *xpcs, phy_interface_t interface)
 {
-	const struct dw_xpcs_compat *compat;
-
-	compat = xpcs_find_compat(xpcs->desc, interface);
-	if (!compat)
-		return -EINVAL;
-
-	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
 		xpcs->pcs.poll = false;
-		return 0;
-	}
+	else
+		xpcs->need_reset = true;
 
-	return xpcs_soft_reset(xpcs, compat);
+	return 0;
 }
 
 static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index b4a4eb6c8866..fd75d0605bb6 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -61,6 +61,7 @@ struct dw_xpcs {
 	struct clk_bulk_data clks[DW_XPCS_NUM_CLKS];
 	struct phylink_pcs pcs;
 	phy_interface_t interface;
+	bool need_reset;
 };
 
 int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface);
-- 
2.30.2


