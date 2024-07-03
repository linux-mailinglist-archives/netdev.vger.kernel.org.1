Return-Path: <netdev+bounces-109005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2719267F1
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F8CEB25B7E
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A73C18EFE9;
	Wed,  3 Jul 2024 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="11TkfX+q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7557D18A924
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030513; cv=none; b=snsovkhyqP8wWbAPakEIIePtFstpXTGCZCG1SXPPDzoyOBmQWJGpNAOdP9qrQkOAWblZxMOUgVlp/Kx3upl/j+z+c/WIRatp62pMQVodf36p/Og999MXp/2MQcOQCKmYFRK7dA7L8dqF/wkAP1j8U8Z8YREvhMGxFLdkhLCryok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030513; c=relaxed/simple;
	bh=OhayV8asqA4tlrZmqZAr3hetao9MUBRw+6Zcnt3ZjBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTCHTbjot2H3UM8+hDY/XksnIitRQEvh7YqJczKNVsN8CRRgh0zqVo9qfS9YHjTaRy8ftAzQspXydLZDhlD8esqMI3TlzGgI8xzQNOnlxm5t4cPMSiAE8PAlhlz+IDwW0Sl75gTPjjbRnzaJcsCgK9T2yJJkUVZnt4rxDw+lzKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=11TkfX+q; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-425624255f3so6455045e9.0
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 11:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720030510; x=1720635310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASQg5AvNQNadFvEbt3zujicewyUwPXC5PJaL2UVk5WA=;
        b=11TkfX+q9zyJ2bLBWAZuFpQQ7ObApFip11igdtfZYbEG7DKvP9hehES8ylmhh7VAdD
         ksexgBArqLjH3FGWTkT95SOKcdLbDM0gu+66QM9MGLfXxJY7TM4Hma/Ji+cXWS4lrnfs
         ZvkfyicaeGC1oeCPoUehPFRL8cotZgecmYyxnB3ywTN8Vprg9+Bbm8bKm378sNmqNuQ6
         TugoMfsSY7SuXHASDTrJXT86MZRkHqtm32P/BKRBgHnDmnJMTzonTFNwvdiPe7wgS5Uy
         AKTOeJxvfDBQ0YpHgFZfeSsPOE2DmgeQCendut/a/NGJuk+uyes8uztaP+SX1077VtrX
         DkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030510; x=1720635310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASQg5AvNQNadFvEbt3zujicewyUwPXC5PJaL2UVk5WA=;
        b=iujXo+SjKbg7AHjIj1IbrEF/OsZpQBL8bNaFpcIlmVhvi7x4znJYbJasdJPYeIjHgg
         deejLT2yVizZ5B1Jm+v0N3YE4DLdL/bLSbrNd8M+o0GWrcMtQldvBKR0JPcktp9AHwaE
         8AC7pjGo23deNeqX6u+WE6ywa3ed090vR4TzHO74H4kqjnSXWCl6bgiLi7OBpDQl1FwW
         hSZDRDRfhdOh5KRJioDoPqPnO0o4R3fcJUx/oTulOfdQXKrOt2NZye/s9TBqxCC4K+Bw
         NFrlZq3TWm9AzwHGLFkaLWl+iOE9XK6upHFStQUCtN9Ovc6vHL+72yULtwh4oAmnY11s
         lgkw==
X-Gm-Message-State: AOJu0Yw8IABbNUaIAI2T8kFBZ+eyNbWg4EoZNr4oAZATFONZdQk5kDU6
	XOVqzS6eMyVS9JQg7mZnpfluAc77xcvTFauFK84KZJqVNEBYKcvrp00hTuaHX8I=
X-Google-Smtp-Source: AGHT+IHNlfmjna3tXbxnZXAgMVKod6UX7ashoHI1BYbx3wkqgqg5H0QXcmvLJ38mwLeb04u5JC3tOA==
X-Received: by 2002:a05:600c:22d7:b0:421:8234:9bb4 with SMTP id 5b1f17b1804b1-4264093f1bcmr23484975e9.19.1720030509875;
        Wed, 03 Jul 2024 11:15:09 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c37f:195e:538f:bf06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c0f26sm245178845e9.39.2024.07.03.11.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:15:08 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next v3 2/2] net: stmmac: qcom-ethqos: enable SGMII loopback during DMA reset on sa8775p-ride-r3
Date: Wed,  3 Jul 2024 20:14:59 +0200
Message-ID: <20240703181500.28491-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703181500.28491-1-brgl@bgdev.pl>
References: <20240703181500.28491-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

On sa8775p-ride-r3 the RX clocks from the AQR115C PHY are not available at
the time of the DMA reset. We can however extract the RX clock from the
internal SERDES block. Once the link is up, we can revert to the
previous state.

The AQR115C PHY doesn't support in-band signalling so we can count on
getting the link up notification and safely reuse existing callbacks
which are already used by another HW quirk workaround which enables the
functional clock to avoid a DMA reset due to timeout.

Only enable loopback on revision 3 of the board - check the phy_mode to
make sure.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 91fe57a3e59e..e46cbacc627d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -21,6 +21,7 @@
 #define RGMII_IO_MACRO_CONFIG2		0x1C
 #define RGMII_IO_MACRO_DEBUG1		0x20
 #define EMAC_SYSTEM_LOW_POWER_DEBUG	0x28
+#define EMAC_WRAPPER_SGMII_PHY_CNTRL1	0xf4
 
 /* RGMII_IO_MACRO_CONFIG fields */
 #define RGMII_CONFIG_FUNC_CLK_EN		BIT(30)
@@ -79,6 +80,9 @@
 #define ETHQOS_MAC_CTRL_SPEED_MODE		BIT(14)
 #define ETHQOS_MAC_CTRL_PORT_SEL		BIT(15)
 
+/* EMAC_WRAPPER_SGMII_PHY_CNTRL1 bits */
+#define SGMII_PHY_CNTRL1_SGMII_TX_TO_RX_LOOPBACK_EN	BIT(3)
+
 #define SGMII_10M_RX_CLK_DVDR			0x31
 
 struct ethqos_emac_por {
@@ -95,6 +99,7 @@ struct ethqos_emac_driver_data {
 	bool has_integrated_pcs;
 	u32 dma_addr_width;
 	struct dwmac4_addrs dwmac4_addrs;
+	bool needs_sgmii_loopback;
 };
 
 struct qcom_ethqos {
@@ -114,6 +119,7 @@ struct qcom_ethqos {
 	unsigned int num_por;
 	bool rgmii_config_loopback_en;
 	bool has_emac_ge_3;
+	bool needs_sgmii_loopback;
 };
 
 static int rgmii_readl(struct qcom_ethqos *ethqos, unsigned int offset)
@@ -191,8 +197,22 @@ ethqos_update_link_clk(struct qcom_ethqos *ethqos, unsigned int speed)
 	clk_set_rate(ethqos->link_clk, ethqos->link_clk_rate);
 }
 
+static void
+qcom_ethqos_set_sgmii_loopback(struct qcom_ethqos *ethqos, bool enable)
+{
+	if (!ethqos->needs_sgmii_loopback ||
+	    ethqos->phy_mode != PHY_INTERFACE_MODE_2500BASEX)
+		return;
+
+	rgmii_updatel(ethqos,
+		      SGMII_PHY_CNTRL1_SGMII_TX_TO_RX_LOOPBACK_EN,
+		      enable ? SGMII_PHY_CNTRL1_SGMII_TX_TO_RX_LOOPBACK_EN : 0,
+		      EMAC_WRAPPER_SGMII_PHY_CNTRL1);
+}
+
 static void ethqos_set_func_clk_en(struct qcom_ethqos *ethqos)
 {
+	qcom_ethqos_set_sgmii_loopback(ethqos, true);
 	rgmii_updatel(ethqos, RGMII_CONFIG_FUNC_CLK_EN,
 		      RGMII_CONFIG_FUNC_CLK_EN, RGMII_IO_MACRO_CONFIG);
 }
@@ -277,6 +297,7 @@ static const struct ethqos_emac_driver_data emac_v4_0_0_data = {
 	.has_emac_ge_3 = true,
 	.link_clk_name = "phyaux",
 	.has_integrated_pcs = true,
+	.needs_sgmii_loopback = true,
 	.dma_addr_width = 36,
 	.dwmac4_addrs = {
 		.dma_chan = 0x00008100,
@@ -682,6 +703,7 @@ static void ethqos_fix_mac_speed(void *priv, unsigned int speed, unsigned int mo
 {
 	struct qcom_ethqos *ethqos = priv;
 
+	qcom_ethqos_set_sgmii_loopback(ethqos, false);
 	ethqos->speed = speed;
 	ethqos_update_link_clk(ethqos, speed);
 	ethqos_configure(ethqos);
@@ -820,6 +842,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	ethqos->num_por = data->num_por;
 	ethqos->rgmii_config_loopback_en = data->rgmii_config_loopback_en;
 	ethqos->has_emac_ge_3 = data->has_emac_ge_3;
+	ethqos->needs_sgmii_loopback = data->needs_sgmii_loopback;
 
 	ethqos->link_clk = devm_clk_get(dev, data->link_clk_name ?: "rgmii");
 	if (IS_ERR(ethqos->link_clk))
-- 
2.43.0


