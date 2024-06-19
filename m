Return-Path: <netdev+bounces-104990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5656090F65C
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CE32B23292
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1195715A4BD;
	Wed, 19 Jun 2024 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UhZR3aWJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914C158A36
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822769; cv=none; b=RVHLEioPoIxNKlbZ/styt4hzqTpeyj5qKj520YqR/2ZJ/oE2E7+gY6JOZmFyluEX6vyMyBdfLZdkSR6qux5iktWoxBvX9T5W5wpiPML5tEBMKNovz9VlaoDqdzVlOPYPMBfn3GFDV0uvhWA8afcCB+GDZH/4b7nfA3lsJo77NRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822769; c=relaxed/simple;
	bh=UgqhHqlcoo2GUEDYVQSY/0NQPdIbLo3HZeq6E2j6UQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2q5Vih8gdgX5E3xxeRP06UhLfraANW8yf/pNGo65kWDULhNC7teAdoREHmbg5owy3uBILi8DCFIa04N9VDS8nsXuY2kFMXKT00F//xUnnj9F3qaxohUNax/r+fgXzIG0gHLTV1O0ZvZJ7YhaDkHYDbWSZ9ndxHTsu2n4KB72B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UhZR3aWJ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35f23f3da44so94090f8f.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 11:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718822764; x=1719427564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJn78QxgCMJZC/Bt30akmrrLqCYwQcxiOnm8hqmwEKA=;
        b=UhZR3aWJxp0gOrbcEpQNpumjbS8dyeRLGT5X9QdlNQExYb9ibz/xvMUMxFuBBVcdC3
         Mu+7Exm7m1Hli3rwoo3YgBFu1LW7GaGzO/fKczVdiHW+UK38uF0OQ4KPXKh3lURkzqtD
         jUReJmlXvic5in0KsOyBSb5PPHlDL9SNKP8xnDwL8ehPZHX0lerwqoBRuK1Sz7Y+bWb8
         uIP7GGTAPvEYP3YzO8JfAhqTlXYTLgK+IqWSSF6GDTuWkrItvTo0eMoJr5C1A7Yh8L7B
         A8i3NpqjldX+01WaerzRRn558W+K/T+gVA93uZgi6L3bc+WbJ8M+MtcQV4kgRGMv0ohx
         0+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718822764; x=1719427564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJn78QxgCMJZC/Bt30akmrrLqCYwQcxiOnm8hqmwEKA=;
        b=iIk6SyPtMcapWbz0gFXfFpJ5LbFg7kZhfmTJzqPZpczv97qWHWk+JlabYf2zjegPeu
         Adbbhen11861oMnipZoMePCP4QVGoN7ffOP40BOux6LaSHO7jXlxmAWDCjpT1xYmfdH+
         Qdd+nnBoxCnS7FTaSA1A6Nh7+9tDxK79RtdRvDeqeJ41azSVVde7zMQA6yr9UkIUWjmy
         G8PW4RiWUIgPEKhNepBypZlWp29hryXn+JolBqsxYrefGEVmKb2Bn7THAU+p5XRj3Scy
         LCFRWcA5TRZJs6Z0p1OKnczZB8zW2nKL3NPxV2GtxslR6oz6lmjeNCLUpMnzB/ndVnfc
         lDBw==
X-Gm-Message-State: AOJu0Yy37HRR0x44WTz5ORYnhU6hahFX2C/4JlVGG1/yLryHVUIOy/Ac
	YKztl58Df1GB+ixtLXK2kxhAh3dNS/3U2X9jByae2/sQ3AVFI3YrSIAsA5GRSR4=
X-Google-Smtp-Source: AGHT+IGvNKdudrDJsFCz+vta1snIK9cUncMqGFnepCueFTkJUGgeHU0mX5Ge8h1gAZtVNK+LZc9FoA==
X-Received: by 2002:a05:6000:1363:b0:362:dbc2:9486 with SMTP id ffacd0b85a97d-36319c6f86emr2312112f8f.68.1718822764283;
        Wed, 19 Jun 2024 11:46:04 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:991f:deb8:4c5d:d73d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36098c8c596sm7594156f8f.14.2024.06.19.11.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 11:46:03 -0700 (PDT)
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
Subject: [PATCH net-next 2/8] net: stmmac: qcom-ethqos: add support for 2.5G overlocked SGMII mode
Date: Wed, 19 Jun 2024 20:45:43 +0200
Message-ID: <20240619184550.34524-3-brgl@bgdev.pl>
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

Add support for 2.5G speed in Overclocked SGMII mode to the QCom ethqos
driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c   | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 80eb72bc6311..dac91bc72070 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -665,6 +665,14 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
 	return val;
 }
 
+static void qcom_ethqos_speed_mode_2500(struct net_device *ndev, void *data)
+{
+	struct stmmac_priv *priv = netdev_priv(ndev);
+
+	priv->plat->max_speed = 2500;
+	priv->plat->phy_interface = PHY_INTERFACE_MODE_OCSGMII;
+}
+
 static int ethqos_configure(struct qcom_ethqos *ethqos)
 {
 	return ethqos->configure_func(ethqos);
@@ -787,6 +795,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		ethqos->configure_func = ethqos_configure_rgmii;
 		break;
+	case PHY_INTERFACE_MODE_OCSGMII:
+		plat_dat->speed_mode_2500 = qcom_ethqos_speed_mode_2500;
+		fallthrough;
 	case PHY_INTERFACE_MODE_SGMII:
 		ethqos->configure_func = ethqos_configure_sgmii;
 		break;
-- 
2.43.0


