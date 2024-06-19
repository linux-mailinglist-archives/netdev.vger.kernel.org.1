Return-Path: <netdev+bounces-104995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B8490F66C
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811DA1F24F1B
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A1215B993;
	Wed, 19 Jun 2024 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ajzwoK9I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B5515B142
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822773; cv=none; b=WVw1nYfQou2VljoTFxoZYz5Gw6ECi5c1/bSCtyFFfiFAdNKsUqI3Uy/IIwyZ/gaNc1r0W1z3VrvGoQxrrY0eEcNpwIqcxt5Ma4RQNsUPIn/sND10jfM+ChUiCqy2uKfyJBJ7fAk3A7oDYxGRx1JKMLSvDpdOkak9+az6DbR7PWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822773; c=relaxed/simple;
	bh=+e447U9ZNkT7AYGVOo7aDCOA3wONE7KRmNgjVrgpyuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKPYzqJShEC3+naWSmAx3MPNXw++axLNZP7LZXedoU6KE0A3vd1VYwgyCOjp/fX/P8O8qEiJbYWIepnXMAw/fr7RAK8IUjLT8qJaTwe2fKd8WU3NNom2/NKHeviGdyN18QjJLgjQSxekMKfNRD3VBuPGG6dAGb9ScdYD/DgmBUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ajzwoK9I; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35f2c9e23d3so828253f8f.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718822770; x=1719427570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpAzXcNNxYpTdvfi+BDU0xCxyu40usRKC5CFcQJxaNM=;
        b=ajzwoK9I6PthWpsuT2C98OMmoBEmve18tfYsICwcvOATXeIVHRXcHlxIlPY9D33Q4f
         OzwEDX8OeCfiDFAob9on1whMJjwRkB8DP88cREwmo5PlhDYm2KLszzfKCboq30m53eyY
         7FK0tC4ohRSmxshdLdFQFsOy4rdco6uR/Y75siyPThQIP8VDojZaFj0dk/Np9fxKsLDR
         jbGdnDFVzbEtyzMlCzkbICbR6JHEbjIx1teyyY757UXNAR8KPgfrmGUJ9uu348dNo8Wv
         zYE/UzimN5Y/uabEH2nha2a7ixGyKVBVYX/vwwa6VXiEnLGWaof9FOFyXQo5Nl1EkJzF
         C9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718822770; x=1719427570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpAzXcNNxYpTdvfi+BDU0xCxyu40usRKC5CFcQJxaNM=;
        b=nmLlJxkVVW9syts1L1TkKxEAxVy8el3IqOpoEm2FG1bnBZbhEDjgURxITzLwgo5Wlj
         nTaZIl9Pe2Pdraz2kS8RUXi5kWvj7ylc4Zs5dK3OPwof4xOKsat/FqvXznFRcLgELMrm
         gkvoPThlmlRYce17JFGY4qpfZZ5L4b3o9ixHk4nQ2+0Rg6x8a3GwQQlCMRrk2vyrfHXn
         rM8QUDYjZ3Avv3puK6CWzym9VrNW2MEtsa/rMgHaxTFErpyqg5/oEbq3e3L877RcsUN0
         Vr1OE0ccePRoTdV+9cWlokMZG6EpDL7aTXyur2UTEyM7C1DkhgeRhH8+DQsL/V/FNqUg
         +zEw==
X-Gm-Message-State: AOJu0YxBttPeVTTRWdznA8FVQ5/lwZpl7flZn7QN0WjzD7CXPEs6Fn6t
	KrENYxxuQiG0m4XO8UaKfsecCd6CHQJKAbKD9G9vvH8HbLY6a8+2MxuTrk0gX40=
X-Google-Smtp-Source: AGHT+IHjF8mEpNI/gxyJaJmiFPRUJrocPqa3dz8xJy9EQvsllKfjPZWiH68BZOjcdaFrDoZZqxW6IA==
X-Received: by 2002:adf:e390:0:b0:363:10cb:45aa with SMTP id ffacd0b85a97d-36310cb4a2bmr3050189f8f.24.1718822770504;
        Wed, 19 Jun 2024 11:46:10 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:991f:deb8:4c5d:d73d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36098c8c596sm7594156f8f.14.2024.06.19.11.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 11:46:10 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Vinod Koul <vkoul@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next 8/8] net: stmmac: qcom-ethqos: add a DMA-reset quirk for sa8775p-ride-r3
Date: Wed, 19 Jun 2024 20:45:49 +0200
Message-ID: <20240619184550.34524-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619184550.34524-1-brgl@bgdev.pl>
References: <20240619184550.34524-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

On sa8775p-ride the RX clocks from the AQR115C PHY are not available at
the time of the DMA reset so we need to loop TX clocks to RX and then
disable loopback after link-up. Use the provided callbacks to do it for
this board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index dac91bc72070..ec43449d0252 100644
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
@@ -678,6 +682,29 @@ static int ethqos_configure(struct qcom_ethqos *ethqos)
 	return ethqos->configure_func(ethqos);
 }
 
+static void qcom_ethqos_set_serdes_loopback(struct qcom_ethqos *ethqos,
+					    bool enable)
+{
+	rgmii_updatel(ethqos,
+		      SGMII_PHY_CNTRL1_SGMII_TX_TO_RX_LOOPBACK_EN,
+		      enable ? SGMII_PHY_CNTRL1_SGMII_TX_TO_RX_LOOPBACK_EN : 0,
+		      EMAC_WRAPPER_SGMII_PHY_CNTRL1);
+}
+
+static void qcom_ethqos_open(struct net_device *pdev, void *priv)
+{
+	struct qcom_ethqos *ethqos = priv;
+
+	qcom_ethqos_set_serdes_loopback(ethqos, true);
+}
+
+static void qcom_ethqos_link_up(struct net_device *ndev, void *priv)
+{
+	struct qcom_ethqos *ethqos = priv;
+
+	qcom_ethqos_set_serdes_loopback(ethqos, false);
+}
+
 static void ethqos_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
 {
 	struct qcom_ethqos *ethqos = priv;
@@ -861,6 +888,12 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (data->dma_addr_width)
 		plat_dat->host_dma_width = data->dma_addr_width;
 
+	if (of_device_is_compatible(np, "qcom,sa8775p-ethqos") &&
+	    ethqos->phy_mode == PHY_INTERFACE_MODE_OCSGMII) {
+		plat_dat->open = qcom_ethqos_open;
+		plat_dat->link_up = qcom_ethqos_link_up;
+	}
+
 	if (ethqos->serdes_phy) {
 		plat_dat->serdes_powerup = qcom_ethqos_serdes_powerup;
 		plat_dat->serdes_powerdown  = qcom_ethqos_serdes_powerdown;
-- 
2.43.0


