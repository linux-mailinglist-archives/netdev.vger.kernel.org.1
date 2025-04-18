Return-Path: <netdev+bounces-184107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736F9A935C9
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 12:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378D53B02EA
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 10:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A946270EB7;
	Fri, 18 Apr 2025 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gIX02F8h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m3280.qiye.163.com (mail-m3280.qiye.163.com [220.197.32.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3051EE7BE;
	Fri, 18 Apr 2025 10:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744970808; cv=none; b=iZ4dO3r34Ew4i4wwaEyfCFZu0DyAD3mE7mndB/GJ9+gOk2/KR6mkMsqS5veWk0HDYFxFsBUAkcfAIExSYZTjchhCKQIKPaYWoNdyT0SI6StUWqLT7LQwqyZZvCMyMQTsvENctV4pcWjgzqx/5n4ucKZVDaaA4SWDmL9tkdqA7Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744970808; c=relaxed/simple;
	bh=3kXZrXSZk96VWDNoRdYhMRuEVP9rA+UBAQ3Jb9rlVqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sFO+faBzGJ+JM7FyvcwW/vikPZNaxfrn/ERmPYtdzHN68SzpmOalGiseCqakZuxfokr1euf2lm23QdsINR1n2gKIJ7dX2ZwMR9uaoEJCc8q1MxJymvcBO7FsHw3pSpz/Chz3y9na6nrG4sHTxUEZrYuZ3rsxUn5bVAr+Z+m5Heg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gIX02F8h; arc=none smtp.client-ip=220.197.32.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 125a9718e;
	Fri, 18 Apr 2025 17:51:18 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	David Wu <david.wu@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org,
	Jonas Karlman <jonas@kwiboo.se>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	netdev@vger.kernel.org,
	Detlev Casanova <detlev.casanova@collabora.com>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH v3 2/3] ethernet: stmmac: dwmac-rk: Add gmac support for rk3562
Date: Fri, 18 Apr 2025 17:51:13 +0800
Message-Id: <20250418095114.271562-2-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250418095114.271562-1-kever.yang@rock-chips.com>
References: <20250418095114.271562-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU1CHlYeTkIaSBpCSx9CTx1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96484f4d0f03afkunm125a9718e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nhw6TBw5AjJILAoqFE8BI01O
	NxxPCVFVSlVKTE9PQk1CQ0NLT0pNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCSEtCNwY+
DKIM-Signature:a=rsa-sha256;
	b=gIX02F8h0RxLT/DTsz8UM4xkQV6oLzvmtElFFMRmrvjBlC9tLDkEx2CRPf2Yi5t8gpoFtiBkMJGT3089Y2RKyumZNGsjZCnEhvMSyrLRv96ytqTE7juPeZYmUozbdxRfgdY+cQ+uidM6M5yYyqitJF+rBJzL2f38eHiF5CE4sSQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=IjfZi31hmUptjdnNvZySV4nqA3Lhny6AX1T2Wc7MbAc=;
	h=date:mime-version:subject:message-id:from;

From: David Wu <david.wu@rock-chips.com>

Add constants and callback functions for the dwmac on RK3562 soc.
As can be seen, the base structure is the same.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v3:
- remove unreadable MACRO;
- use two function for rmii and rgmii speed set;
- don't check grf and php_grf in function call;
- rebase on v6.15-rc1

Changes in v2:
- Collect review tag

 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 190 ++++++++++++++++++
 1 file changed, 190 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 700858ff6f7c..82174054644a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -2,6 +2,7 @@
 /**
  * DOC: dwmac-rk.c - Rockchip RK3288 DWMAC specific glue layer
  *
+ * Copyright (c) 2014 Rockchip Electronics Co., Ltd.
  * Copyright (C) 2014 Chen-Zhi (Roger Chen)
  *
  * Chen-Zhi (Roger Chen)  <roger.chen@rock-chips.com>
@@ -1048,6 +1049,194 @@ static const struct rk_gmac_ops rk3528_ops = {
 	},
 };
 
+/* sys_grf */
+#define RK3562_GRF_SYS_SOC_CON0			0X0400
+#define RK3562_GRF_SYS_SOC_CON1			0X0404
+
+#define RK3562_GMAC0_CLK_RMII_MODE		GRF_BIT(5)
+#define RK3562_GMAC0_CLK_RGMII_MODE		GRF_CLR_BIT(5)
+
+#define RK3562_GMAC0_CLK_RMII_GATE		GRF_BIT(6)
+#define RK3562_GMAC0_CLK_RMII_NOGATE		GRF_CLR_BIT(6)
+
+#define RK3562_GMAC0_CLK_RMII_DIV2		GRF_BIT(7)
+#define RK3562_GMAC0_CLK_RMII_DIV20		GRF_CLR_BIT(7)
+
+#define RK3562_GMAC0_CLK_RGMII_DIV1		\
+				(GRF_CLR_BIT(7) | GRF_CLR_BIT(8))
+#define RK3562_GMAC0_CLK_RGMII_DIV5		\
+				(GRF_BIT(7) | GRF_BIT(8))
+#define RK3562_GMAC0_CLK_RGMII_DIV50		\
+				(GRF_CLR_BIT(7) | GRF_BIT(8))
+
+#define RK3562_GMAC0_CLK_RMII_DIV2		GRF_BIT(7)
+#define RK3562_GMAC0_CLK_RMII_DIV20		GRF_CLR_BIT(7)
+
+#define RK3562_GMAC0_CLK_SELET_CRU		GRF_CLR_BIT(9)
+#define RK3562_GMAC0_CLK_SELET_IO		GRF_BIT(9)
+
+#define RK3562_GMAC1_CLK_RMII_GATE		GRF_BIT(12)
+#define RK3562_GMAC1_CLK_RMII_NOGATE		GRF_CLR_BIT(12)
+
+#define RK3562_GMAC1_CLK_RMII_DIV2		GRF_BIT(13)
+#define RK3562_GMAC1_CLK_RMII_DIV20		GRF_CLR_BIT(13)
+
+#define RK3562_GMAC1_RMII_SPEED100		GRF_BIT(11)
+#define RK3562_GMAC1_RMII_SPEED10		GRF_CLR_BIT(11)
+
+#define RK3562_GMAC1_CLK_SELET_CRU		GRF_CLR_BIT(15)
+#define RK3562_GMAC1_CLK_SELET_IO		GRF_BIT(15)
+
+/* ioc_grf */
+#define RK3562_GRF_IOC_GMAC_IOFUNC0_CON0	0X10400
+#define RK3562_GRF_IOC_GMAC_IOFUNC0_CON1	0X10404
+#define RK3562_GRF_IOC_GMAC_IOFUNC1_CON0	0X00400
+#define RK3562_GRF_IOC_GMAC_IOFUNC1_CON1	0X00404
+
+#define RK3562_GMAC_RXCLK_DLY_ENABLE		GRF_BIT(1)
+#define RK3562_GMAC_RXCLK_DLY_DISABLE		GRF_CLR_BIT(1)
+#define RK3562_GMAC_TXCLK_DLY_ENABLE		GRF_BIT(0)
+#define RK3562_GMAC_TXCLK_DLY_DISABLE		GRF_CLR_BIT(0)
+
+#define RK3562_GMAC_CLK_RX_DL_CFG(val)		HIWORD_UPDATE(val, 0xFF, 8)
+#define RK3562_GMAC_CLK_TX_DL_CFG(val)		HIWORD_UPDATE(val, 0xFF, 0)
+
+#define RK3562_GMAC0_IO_EXTCLK_SELET_CRU	GRF_CLR_BIT(2)
+#define RK3562_GMAC0_IO_EXTCLK_SELET_IO		GRF_BIT(2)
+
+#define RK3562_GMAC1_IO_EXTCLK_SELET_CRU	GRF_CLR_BIT(3)
+#define RK3562_GMAC1_IO_EXTCLK_SELET_IO		GRF_BIT(3)
+
+static void rk3562_set_to_rgmii(struct rk_priv_data *bsp_priv,
+				int tx_delay, int rx_delay)
+{
+	regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON0,
+		     RK3562_GMAC0_CLK_RGMII_MODE);
+
+	regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC0_CON1,
+		     DELAY_ENABLE(RK3562, tx_delay, rx_delay));
+	regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC0_CON0,
+		     RK3562_GMAC_CLK_RX_DL_CFG(rx_delay) |
+		     RK3562_GMAC_CLK_TX_DL_CFG(tx_delay));
+
+	regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC1_CON1,
+		     DELAY_ENABLE(RK3562, tx_delay, rx_delay));
+	regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC1_CON0,
+		     RK3562_GMAC_CLK_RX_DL_CFG(rx_delay) |
+		     RK3562_GMAC_CLK_TX_DL_CFG(tx_delay));
+}
+
+static void rk3562_set_to_rmii(struct rk_priv_data *bsp_priv)
+{
+	if (!bsp_priv->id)
+		regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON0,
+			     RK3562_GMAC0_CLK_RMII_MODE);
+}
+
+static void rk3562_set_gmac_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
+{
+	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int val = 0;
+
+	switch (speed) {
+	case 10:
+		val = RK3562_GMAC0_CLK_RGMII_DIV50;
+		break;
+	case 100:
+		val = RK3562_GMAC0_CLK_RGMII_DIV5;
+		break;
+	case 1000:
+		val = RK3562_GMAC0_CLK_RGMII_DIV1;
+		break;
+	default:
+		goto err;
+	}
+
+	regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON0, val);
+	return;
+err:
+	dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
+}
+
+static void rk3562_set_gmac_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
+{
+	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int val = 0, offset;
+
+	switch (speed) {
+	case 10:
+		if (bsp_priv->id == 1) {
+			val = RK3562_GMAC1_CLK_RMII_DIV20;
+			regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON0,
+				     RK3562_GMAC1_RMII_SPEED10);
+		} else {
+			val = RK3562_GMAC0_CLK_RMII_DIV20;
+		}
+		break;
+	case 100:
+		if (bsp_priv->id == 1) {
+			val = RK3562_GMAC1_CLK_RMII_DIV2;
+			regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON0,
+				     RK3562_GMAC1_RMII_SPEED100);
+		} else {
+			val = RK3562_GMAC0_CLK_RMII_DIV2;
+		}
+		break;
+	default:
+		goto err;
+	}
+
+	offset = (bsp_priv->id == 1) ? RK3562_GRF_SYS_SOC_CON1 :
+				       RK3562_GRF_SYS_SOC_CON0;
+	regmap_write(bsp_priv->grf, offset, val);
+	return;
+err:
+	dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
+}
+
+static void rk3562_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
+				       bool enable)
+{
+	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int value;
+
+	if (IS_ERR(bsp_priv->grf) || IS_ERR(bsp_priv->php_grf)) {
+		dev_err(dev, "Missing rockchip,grf or rockchip,php_grf property\n");
+		return;
+	}
+
+	if (!bsp_priv->id) {
+		value = input ? RK3562_GMAC0_CLK_SELET_IO :
+				RK3562_GMAC0_CLK_SELET_CRU;
+		value |= enable ? RK3562_GMAC0_CLK_RMII_NOGATE :
+				  RK3562_GMAC0_CLK_RMII_GATE;
+		regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON0, value);
+
+		value = input ? RK3562_GMAC0_IO_EXTCLK_SELET_IO :
+				RK3562_GMAC0_IO_EXTCLK_SELET_CRU;
+		regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC0_CON1, value);
+		regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC1_CON1, value);
+	} else {
+		value = input ? RK3562_GMAC1_CLK_SELET_IO :
+				RK3562_GMAC1_CLK_SELET_CRU;
+		value |= enable ? RK3562_GMAC1_CLK_RMII_NOGATE :
+				 RK3562_GMAC1_CLK_RMII_GATE;
+		regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON1, value);
+
+		value = input ? RK3562_GMAC1_IO_EXTCLK_SELET_IO :
+				RK3562_GMAC1_IO_EXTCLK_SELET_CRU;
+		regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC1_CON1, value);
+	}
+}
+
+static const struct rk_gmac_ops rk3562_ops = {
+	.set_to_rgmii = rk3562_set_to_rgmii,
+	.set_to_rmii = rk3562_set_to_rmii,
+	.set_rgmii_speed = rk3562_set_gmac_rgmii_speed,
+	.set_rmii_speed = rk3562_set_gmac_rmii_speed,
+	.set_clock_selection = rk3562_set_clock_selection,
+};
+
 #define RK3568_GRF_GMAC0_CON0		0x0380
 #define RK3568_GRF_GMAC0_CON1		0x0384
 #define RK3568_GRF_GMAC1_CON0		0x0388
@@ -1996,6 +2185,7 @@ static const struct of_device_id rk_gmac_dwmac_match[] = {
 	{ .compatible = "rockchip,rk3368-gmac", .data = &rk3368_ops },
 	{ .compatible = "rockchip,rk3399-gmac", .data = &rk3399_ops },
 	{ .compatible = "rockchip,rk3528-gmac", .data = &rk3528_ops },
+	{ .compatible = "rockchip,rk3562-gmac", .data = &rk3562_ops },
 	{ .compatible = "rockchip,rk3568-gmac", .data = &rk3568_ops },
 	{ .compatible = "rockchip,rk3576-gmac", .data = &rk3576_ops },
 	{ .compatible = "rockchip,rk3588-gmac", .data = &rk3588_ops },
-- 
2.25.1


