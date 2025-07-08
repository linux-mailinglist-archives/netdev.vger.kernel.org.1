Return-Path: <netdev+bounces-204833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC099AFC37E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC541562841
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 06:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC04B235072;
	Tue,  8 Jul 2025 06:55:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442432248BE;
	Tue,  8 Jul 2025 06:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957756; cv=none; b=bBP3YFo3824G4Uz12AWfbaR8m8aMQOoKACFzF3CgFJgk3joUA9VaHsXSLRkQxOV9FPXGWHrmkt5YOUkhi2aPzxHV/m47PuBy2E+E1VtO/S78mDimFTDjdqT38JScFtx2nHKWrA4CshWspWBLOWZozlooyHueY+7mbEs83FG63S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957756; c=relaxed/simple;
	bh=0LtjXvqsRruXDJtU07Ulf5ytfTnCk8K7EwtmbcFBh/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4MGCD5xQKJ1wwNFo0VgitPh0nk8A9FHq5dOfslKoXcJaVEuKcKDXr94l3iolDm+dtVYXE2XAn/OCJlpPPKkOq/UZwdPtka/KB3+p/3qhTnX5gFm2/iPPCi1r4bSOOTJKpDOZA/GFtFP6bK/unI6PfSDgpfc1iLhB+hdefg3YUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 8 Jul
 2025 14:55:44 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 8 Jul 2025 14:55:44 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<p.zabel@pengutronix.de>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
	<u.kleine-koenig@baylibre.com>, <hkallweit1@gmail.com>
CC: <BMC-SW@aspeedtech.com>
Subject: [net-next v3 4/4] net: ftgmac100: Add optional reset control for RMII mode on Aspeed SoCs
Date: Tue, 8 Jul 2025 14:55:44 +0800
Message-ID: <20250708065544.201896-5-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708065544.201896-1-jacky_chou@aspeedtech.com>
References: <20250708065544.201896-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

On Aspeed SoCs, the internal MAC reset is insufficient to fully reset the
RMII interface; only the SoC-level reset line can properly reset the RMII
logic. This patch adds support for an optional "resets" property in the
device tree, allowing the driver to assert and deassert the SoC reset line
when operating in RMII mode. This ensures the MAC and RMII interface are
correctly reset and initialized.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index a98d5af3f9e3..05b8e3743a79 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/clk.h>
+#include <linux/reset.h>
 #include <linux/dma-mapping.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
@@ -101,6 +102,8 @@ struct ftgmac100 {
 
 	/* AST2500/AST2600 RMII ref clock gate */
 	struct clk *rclk;
+	/* Aspeed reset control */
+	struct reset_control *rst;
 
 	/* Link management */
 	int cur_speed;
@@ -148,6 +151,23 @@ static int ftgmac100_reset_and_config_mac(struct ftgmac100 *priv)
 {
 	u32 maccr = 0;
 
+	/* Aspeed RMII needs SCU reset to clear status */
+	if (priv->is_aspeed && priv->netdev->phydev->interface == PHY_INTERFACE_MODE_RMII) {
+		int err;
+
+		err = reset_control_assert(priv->rst);
+		if (err) {
+			dev_err(priv->dev, "Failed to reset mac (%d)\n", err);
+			return err;
+		}
+		usleep_range(10000, 20000);
+		err = reset_control_deassert(priv->rst);
+		if (err) {
+			dev_err(priv->dev, "Failed to deassert mac reset (%d)\n", err);
+			return err;
+		}
+	}
+
 	switch (priv->cur_speed) {
 	case SPEED_10:
 	case 0: /* no link */
@@ -1968,6 +1988,12 @@ static int ftgmac100_probe(struct platform_device *pdev)
 
 	}
 
+	priv->rst = devm_reset_control_get_optional_exclusive(priv->dev, NULL);
+	if (IS_ERR(priv->rst)) {
+		err = PTR_ERR(priv->rst);
+		goto err_phy_connect;
+	}
+
 	if (priv->is_aspeed) {
 		err = ftgmac100_setup_clk(priv);
 		if (err)
-- 
2.34.1


